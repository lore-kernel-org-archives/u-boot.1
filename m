Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA464C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C28A806FE;
	Wed,  5 Feb 2025 03:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="QZsAZlZ1";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fa9Ywf5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25558803B5; Tue,  4 Feb 2025 16:50:31 +0100 (CET)
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com
 [IPv6:2607:f8b0:4864:20::d49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F7080040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 16:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3QjeiZwgMBn0upn.sjojlpotvmlp.dpnv-cppumjtut.efoy.ef@calendar-server.bounces.google.com
Received: by mail-io1-xd49.google.com with SMTP id
 ca18e2360f4ac-84cdb5795b0so353014839f.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 07:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738684227; x=1739289027; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BMZdIr/vFs0rjXRmreMw37pikldDkz5/z6NAVrAyjXA=;
 b=QZsAZlZ1zNUbYNvAg/hHdoY5mIJvkpOSrmHTFaslSQ85tda6gx8D2vqKaNGkZrcmjj
 x2FH64grqD/XPYsWv5pnlWYUtYPgHEdJ7V7k554tVjuBuEKhJtoD0ZptPU7ipw448TRC
 Lx9UPNIjXa1Te+I//QiQKR6wRJ3j+PGM7GHmcKOWeu3piDwpvCJh+/Y8ZCqOSNHjKn9t
 A5zunnfGnwjKyOj7ur1JsDwjQ6WL82t2eUX8wAXGaihPusJcu+zpDt8j3t169yj56mPa
 DMQ20qOoo3yOSt/T1TGOOYgnbSh3taPWOGO6l9UsqlHu18URAKVZXeI8MJa0+eeZbfXt
 wo1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738684227; x=1739289027; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BMZdIr/vFs0rjXRmreMw37pikldDkz5/z6NAVrAyjXA=;
 b=Fa9Ywf5iJN4ITLnRfs6BWSHsGEHTi2atCRTcgu6riFLFEh1044F7ls6B4VoxtLyHnO
 bTNo4WOEyd0EJCW01Fxu8VOk4HT69K330+gim+VlBTeXLPe8jTy2eACNhsyl/AKrEPdv
 Lx7AGWuVexvVPcxTlmDu5lU2D96SABegr0I9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684227; x=1739289027;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMZdIr/vFs0rjXRmreMw37pikldDkz5/z6NAVrAyjXA=;
 b=vwPvuVDQEBuItt4Od0xp9eroWZnJNmE+weCBmKfKFbVhK3ObWc1aOVwB50cp9XVeJB
 3seOkXAPVAs1vfw23yKZAp5CFRK+22KMHiK9qXmhA/Y55UTFwr/bqtRDiNXZEJk4qp0Z
 Vn5Xo9jYJdFwiUghbBdSu7npd5GQjTfjPQMpUHkLd/YMXffnWNTxiE+Yp9mnutw3hbR/
 KkrDSVZkeN+9piIu3+ujcZRUj6zW6ILQzI8Jtb5ReafKW9sa7VhYdH795q7W9Zo5Pfxg
 cyg4NXYSdPsfHQwyCF7RUApHFIZZEaGOvthZqjoGKPghdQcZTMMlEhZ3lHtiVovOuU3Y
 lUOg==
X-Gm-Message-State: AOJu0Yw0mv5OThAPu+2H+vhS4zWcw4w5p6n7u53VnuUpS50Ixj6TAcdW
 DSH9qmtoKyW90fFaKVOfT8HFbr05bAl2QEpyYRyHt9P2aI+gIHYZt2IgtaiUi5uuHCaY09VCPqd
 S/k+V3tv2KN3gNJRulKASNfg+qpyQDsnatuPejFFBwAgnWj7KFKfI
X-Google-Smtp-Source: AGHT+IGtWMOhmZjjM8S0P7aS2nTEGmbfE3NjyB89DiR9qNJogUBwqE5ayoZdiEtBOnvHQ0uvQp+4AY923p8th4OvVKsG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6405:b0:841:a73b:a978 with SMTP id
 ca18e2360f4ac-85427d784abmr2371460439f.7.1738684226323; Tue, 04 Feb 2025
 07:50:26 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-663c79bf-850c-4964-b130-894485f23c4b@google.com>
Date: Tue, 04 Feb 2025 15:50:26 +0000
Subject: Updated invitation: U-Boot community meeting @ Every 2 weeks from 9am
 to 10am on Tuesday (CST) (u-boot@lists.denx.de)
From: Tom Rini <tom.rini@konsulko.com>
To: u-boot@lists.denx.de, pbiel7@gmail.com, sjg@chromium.org, 
 malysagreg@gmail.com
Content-Type: multipart/mixed; boundary="000000000000afeefd062d52f7ce"
X-Mailman-Approved-At: Wed, 05 Feb 2025 03:09:25 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Tom Rini <tom.rini@konsulko.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--000000000000afeefd062d52f7ce
Content-Type: multipart/alternative; boundary="000000000000afeefa062d52f7cc"

--000000000000afeefa062d52f7cc
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KVS1Cb290IGNv
bW11bml0eSBtZWV0aW5nDQpFdmVyeSAyIHdlZWtzIGZyb20gOWFtIHRvIDEwYW0gb24gVHVlc2Rh
eQ0KQ2VudHJhbCBTdGFuZGFyZCBUaW1lIC0gQmFow61hIGRlIEJhbmRlcmFzDQoNCkpvaW4gd2l0
aCBHb29nbGUgTWVldA0KaHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vYnRqLXdnY2ctZXV3P2hzPTIy
NA0KDQoNCgkNCkpvaW4gYnkgcGhvbmUNCihVUykgKzEgMjI0LTU4NS03ODY0DQpQSU46IDEwNzc5
OTQwMw0KDQpNb3JlIHBob25lIG51bWJlcnMNCmh0dHBzOi8vdGVsLm1lZXQvYnRqLXdnY2ctZXV3
P3Bpbj0xMzA3NTI4NTUyMzIyJmhzPTANCg0KDQpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNCg0K
R3Vlc3RzDQp1LWJvb3RAbGlzdHMuZGVueC5kZQ0KcGJpZWw3QGdtYWlsLmNvbQ0Kc2pnQGNocm9t
aXVtLm9yZw0KbWFseXNhZ3JlZ0BnbWFpbC5jb20NClZpZXcgYWxsIGd1ZXN0IGluZm8gIA0KaHR0
cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1O
MjgwTjJ0bGNYRTNhRFZ0YmpsaWNuTmtjbTgyWW5BMWJEQWdkUzFpYjI5MFFHeHBjM1J6TG1SbGJu
Z3VaR1UmdG9rPU9UQWpPRGxpWlRkaU9ERXpNVE0yWW1Wak1EWmhPRE5rWlRSa1lUVTVOelExWmpC
aFltUXhNV014WWpnek5qQTJNV0ZsTURaak1XTTNaR0pqWkRFNFpHWTBNVUJuY205MWNDNWpZV3hs
Ym1SaGNpNW5iMjluYkdVdVkyOXRObVUxTTJJNVpXSTNOMk01TW1Rd1pEUXhPVGN6WXpnNE56Wm1N
all4TURaa1pUbGtaakJtWWcmY3R6PUFtZXJpY2ElMkZCYWhpYV9CYW5kZXJhcyZobD1lbiZlcz0w
DQoNClJlcGx5IGZvciB1LWJvb3RAbGlzdHMuZGVueC5kZSBhbmQgdmlldyBtb3JlIGRldGFpbHMg
IA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVX
JmVpZD1OMjgwTjJ0bGNYRTNhRFZ0YmpsaWNuTmtjbTgyWW5BMWJEQWdkUzFpYjI5MFFHeHBjM1J6
TG1SbGJuZ3VaR1UmdG9rPU9UQWpPRGxpWlRkaU9ERXpNVE0yWW1Wak1EWmhPRE5rWlRSa1lUVTVO
elExWmpCaFltUXhNV014WWpnek5qQTJNV0ZsTURaak1XTTNaR0pqWkRFNFpHWTBNVUJuY205MWND
NWpZV3hsYm1SaGNpNW5iMjluYkdVdVkyOXRObVUxTTJJNVpXSTNOMk01TW1Rd1pEUXhPVGN6WXpn
NE56Wm1Nall4TURaa1pUbGtaakJtWWcmY3R6PUFtZXJpY2ElMkZCYWhpYV9CYW5kZXJhcyZobD1l
biZlcz0wDQpZb3VyIGF0dGVuZGFuY2UgaXMgb3B0aW9uYWwuDQoNCn5+Ly9+fg0KSW52aXRhdGlv
biBmcm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVu
ZGFyLw0KDQpZb3UgYXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBh
dHRlbmRlZSBvbiB0aGUgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxk
IGFsbG93IGFueSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6
ZXIsIGJlIGFkZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mg
b2YgIA0KdGhlaXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0K
DQpMZWFybiBtb3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8z
NzEzNSNmb3J3YXJkaW5nDQo=
--000000000000afeefa062d52f7cc
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/Bahia_Banderas
X-LIC-LOCATION:America/Bahia_Banderas
BEGIN:STANDARD
TZOFFSETFROM:-0600
TZOFFSETTO:-0600
TZNAME:CST
DTSTART:19700101T000000
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=America/Bahia_Banderas:20250128T090000
DTEND;TZID=America/Bahia_Banderas:20250128T100000
RRULE:FREQ=WEEKLY;WKST=SU;INTERVAL=2;BYDAY=TU
DTSTAMP:20250204T155026Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:7o47keqq7h5mn9brsdro6bp5l0@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=sjg@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:1488333282
CLASS:PUBLIC
CREATED:20250114T162827Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20250204T155024Z
LOCATION:
SEQUENCE:1
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--000000000000afeefa062d52f7cc--

--000000000000afeefd062d52f7ce
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTAxMjhUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTAxMjhUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNTAyMDRUMTU1MDI2Wg0K
T1JHQU5JWkVSO0NOPVUtQm9vdDptYWlsdG86ODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1
ZjBhYmQxMWMxYjgzNjA2MWFlDQogMDZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5nb29n
bGUuY29tDQpVSUQ6N280N2tlcXE3aDVtbjlicnNkcm82YnA1bDBAZ29vZ2xlLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj11LWJvb3RAbGlzdHMuZGVueC5kZTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86dS1ib290QGxpc3RzLmRlbnguZGUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049cGJpZWw3QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWlsLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1zamdAY2hyb21pdW0ub3JnO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpzamdAY2hyb21pdW0ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPW1hbHlzYWdyZWdAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYWx5c2FncmVn
QGdtYWlsLmNvbQ0KWC1HT09HTEUtQ09ORkVSRU5DRTpodHRwczovL21lZXQuZ29vZ2xlLmNvbS9i
dGotd2djZy1ldXcNClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDoxNDg4MzMzMjgyDQpDTEFT
UzpQVUJMSUMNCkNSRUFURUQ6MjAyNTAxMTRUMTYyODI3Wg0KREVTQ1JJUFRJT046VS1Cb290IGNv
bW11bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46fjp+On46fjp+DQog
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6LVxuSm9p
biB3aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1l
dXdcbk9yIGRpYWw6IChVUykgKzEgMjI0LTU4NS03ODY0IFBJTjogDQogMTA3Nzk5NDAzI1xuTW9y
ZSBwaG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1dz9waW49MTMwNzUy
ODU1DQogMjMyMiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDogaHR0cHM6Ly9zdXBw
b3J0Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5QbGVhc2UgZG8gbm90
IGVkaXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46DQogfjp+On46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+OjotDQpM
QVNULU1PRElGSUVEOjIwMjUwMjA0VDE1NTAyNFoNCkxPQ0FUSU9OOg0KU0VRVUVOQ0U6MQ0KU1RB
VFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClRSQU5TUDpP
UEFRVUUNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000afeefd062d52f7ce--
