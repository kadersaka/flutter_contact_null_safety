import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Contact extends Equatable {
  Contact(
      {this.givenName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.familyName,
      this.company,
      this.jobTitle,
      this.emails,
      this.phones,
      this.postalAddresses,
      this.socialProfiles,
      this.urls,
      this.dates,
      this.avatar,
      this.note});

  String identifier,
      displayName,
      givenName,
      middleName,
      prefix,
      suffix,
      familyName,
      company,
      jobTitle,
      note;
  Iterable<Item> emails = [];
  Iterable<Item> phones = [];
  Iterable<Item> socialProfiles = [];
  Iterable<Item> dates = [];
  Iterable<Item> urls = [];
  Iterable<PostalAddress> postalAddresses = [];
  Uint8List avatar;

  bool get hasAvatar => avatar?.isNotEmpty == true;

  String initials() {
    return ((this.givenName?.isNotEmpty == true ? this.givenName[0] : "") +
            (this.familyName?.isNotEmpty == true ? this.familyName[0] : ""))
        .toUpperCase();
  }

  Contact.fromMap(Map m) {
    identifier = m["identifier"];
    displayName = m["displayName"];
    givenName = m["givenName"];
    middleName = m["middleName"];
    familyName = m["familyName"];
    prefix = m["prefix"];
    suffix = m["suffix"];
    company = m["company"];
    jobTitle = m["jobTitle"];
    emails = (m["emails"] as Iterable)?.map((m) => Item.fromMap(m));
    phones = (m["phones"] as Iterable)?.map((m) => Item.fromMap(m));
    socialProfiles =
        (m["socialProfiles"] as Iterable)?.map((m) => Item.fromMap(m));
    urls = (m["urls"] as Iterable)?.map((m) => Item.fromMap(m));
    dates = (m["dates"] as Iterable)?.map((m) => Item.fromMap(m));
    postalAddresses = (m["postalAddresses"] as Iterable)
        ?.map((m) => PostalAddress.fromMap(m));
    avatar = m["avatar"];
    note = m["note"];
  }

  Map toMap() {
    return _contactToMap(this);
  }

  /// The [+] operator fills in this contact's empty fields with the fields from [other]
  operator +(Contact other) => Contact(
      givenName: this.givenName ?? other.givenName,
      middleName: this.middleName ?? other.middleName,
      prefix: this.prefix ?? other.prefix,
      suffix: this.suffix ?? other.suffix,
      familyName: this.familyName ?? other.familyName,
      company: this.company ?? other.company,
      jobTitle: this.jobTitle ?? other.jobTitle,
      note: this.note ?? other.note,
      emails: this.emails == null
          ? other.emails
          : this.emails.toSet().union(other.emails?.toSet() ?? Set()).toList(),
      socialProfiles: this.socialProfiles == null
          ? other.socialProfiles
          : this
              .socialProfiles
              .toSet()
              .union(other.socialProfiles?.toSet() ?? Set())
              .toList(),
      dates: this.dates == null
          ? other.dates
          : this.dates.toSet().union(other.dates?.toSet() ?? Set()).toList(),
      urls: this.urls == null
          ? other.urls
          : this.urls.toSet().union(other.urls?.toSet() ?? Set()).toList(),
      phones: this.phones == null
          ? other.phones
          : this.phones.toSet().union(other.phones?.toSet() ?? Set()).toList(),
      postalAddresses: this.postalAddresses == null
          ? other.postalAddresses
          : this
              .postalAddresses
              .toSet()
              .union(other.postalAddresses?.toSet() ?? Set())
              .toList(),
      avatar: this.avatar ?? other.avatar);

//  /// Returns true if all items in this contact are identical.
//  @override
//  bool operator ==(Object other) {
//    return other is Contact &&
//        this.company == other.company &&
//        this.displayName == other.displayName &&
//        this.givenName == other.givenName &&
//        this.familyName == other.familyName &&
//        this.identifier == other.identifier &&
//        this.jobTitle == other.jobTitle &&
//        this.middleName == other.middleName &&
//        this.note == other.note &&
//        this.prefix == other.prefix &&
//        this.suffix == other.suffix &&
//        DeepCollectionEquality.unordered().equals(this.phones, other.phones) &&
//        DeepCollectionEquality.unordered().equals(this.socialProfiles, other.socialProfiles) &&
//        DeepCollectionEquality.unordered().equals(this.urls, other.urls) &&
//        DeepCollectionEquality.unordered().equals(this.dates, other.dates) &&
//        DeepCollectionEquality.unordered().equals(this.emails, other.emails) &&
//        DeepCollectionEquality.unordered().equals(this.postalAddresses, other.postalAddresses);
//  }

  @override
  List get props => [
        this.company,
        this.displayName,
        this.familyName,
        this.givenName,
        this.identifier,
        this.jobTitle,
        this.middleName,
        this.note,
        this.prefix,
        this.suffix,
        this.phones,
        this.socialProfiles,
        this.urls,
        this.dates,
        this.emails,
        this.postalAddresses
      ];
}

// ignore: must_be_immutable
class PostalAddress extends Equatable {
  PostalAddress(
      {this.label,
      this.street,
      this.city,
      this.postcode,
      this.region,
      this.country});

  String label, street, city, postcode, region, country;

  PostalAddress.fromMap(Map m) {
    label = m["label"];
    street = m["street"];
    city = m["city"];
    postcode = m["postcode"];
    region = m["region"];
    country = m["country"];
  }

  @override
  List get props => [
        this.label,
        this.street,
        this.city,
        this.country,
        this.region,
        this.postcode,
      ];
}

/// Item class used for contact fields which only have a [label] and
/// a [value], such as emails and phone numbers
// ignore: must_be_immutable
class Item extends Equatable {
  Item({this.label, this.value});

  String label, value;

  Item.fromMap(Map m) {
    label = m["label"];
    value = m["value"];
  }

  @override
  List get props => [label, value];
}

Map _itemToMap(Item i) => {"label": i.label, "value": i.value};

Map _contactToMap(Contact contact) {
  var emails = [];
  for (Item email in contact.emails ?? []) {
    emails.add(_itemToMap(email));
  }
  var phones = [];
  for (Item phone in contact.phones ?? []) {
    phones.add(_itemToMap(phone));
  }
  var socialProfiles = [];
  for (Item profile in contact.socialProfiles ?? []) {
    socialProfiles.add(_itemToMap(profile));
  }

  var urls = [];
  for (Item profile in contact.urls ?? []) {
    urls.add(_itemToMap(profile));
  }

  var dates = [];
  for (Item date in contact.dates ?? []) {
    dates.add(_itemToMap(date));
  }

  var postalAddresses = [];
  for (PostalAddress address in contact.postalAddresses ?? []) {
    postalAddresses.add(_addressToMap(address));
  }

  return {
    "identifier": contact.identifier,
    "displayName": contact.displayName,
    "givenName": contact.givenName,
    "middleName": contact.middleName,
    "familyName": contact.familyName,
    "prefix": contact.prefix,
    "suffix": contact.suffix,
    "company": contact.company,
    "jobTitle": contact.jobTitle,
    "emails": emails,
    "phones": phones,
    "dates": dates,
    "socialProfiles": socialProfiles,
    "urls": urls,
    "postalAddresses": postalAddresses,
    "avatar": contact.avatar,
    "note": contact.note
  };
}

Map _addressToMap(PostalAddress address) => {
      "label": address.label,
      "street": address.street,
      "city": address.city,
      "postcode": address.postcode,
      "region": address.region,
      "country": address.country
    };