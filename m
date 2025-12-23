Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB5E6B26D
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 02:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6180A8414E;
	Tue, 23 Dec 2025 03:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="c0bwxK/K";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEBC8To3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E710C8412C; Tue, 23 Dec 2025 03:05:11 +0100 (CET)
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com
 [IPv6:2a00:1450:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD47483FD4
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-64d264e09c7so2019670a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766455507; x=1767060307; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TnOreo/IXBWQCmmDtTTNPudm4j1SarvljLG2Ue8FATw=;
 b=c0bwxK/Ke3bYWDONCp5uI86oK0+GWMZOB8UP3Aeg/glnrBOVBpDZm9V6WMQqdkcYk8
 7gOE1u25AQSSWwfXjm1F/NYoWP8DPikXBUV2EsKvlJBuGVkuX/RYWQJhG+DruXXaYhnJ
 iXOR2G83IcA92K6/Gou9kmdiM+x/03S60x6c/yQjSx3UiT9qlhzR+T7VMuCT1EGSQfQp
 1ZuUvDD4S3NXDIpmiQ8M4Au4DE8TsKI2yjdnIzaARlBPI/JmkjFmJ0O/vbCRwZGgpwhH
 9U5IYYiCRTfu27YbA6y5kdNPRU8DINDJApnYjqJAwtR0cFZH6QzVkK0+jqt6pkrXzK2Q
 +Wdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766455507; x=1767060307; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TnOreo/IXBWQCmmDtTTNPudm4j1SarvljLG2Ue8FATw=;
 b=ZEBC8To3plHe5QngDNNQc3nTsCbXq/Y0uPI/V42J0Mc+fUHOJUvzIrphsn66H5/IKf
 r/WJ1V5cDer7xOdknmqxdhiTxZMhmfVp8mdhsPJn+hwe4eutwdoBkk8AzBeZjTJ/EOxz
 AQM9IYinV+0o/qvHPydEOxbhe9KzqT+zB/TIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455507; x=1767060307;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TnOreo/IXBWQCmmDtTTNPudm4j1SarvljLG2Ue8FATw=;
 b=ZwXoNeBjqADxgZOinSgis+Rk/ipg5haBBPU3W6hB2pDg4Uf2pB9revczCL90loHpMn
 Q68Kw+eHh1etdsEa/R8RiGYTdCNw5Sn65CSv0KS4PFH1DOhydfZJN5BP1u0xfVHrSrT8
 c7QLd5u1YZQ9bdNBKEuVftT9Ur+AeSp2U+6aoR+VxFjPAK81sNpOeEZLDpmAqnoc/tje
 jQQWXfCGGbExGhWZ6pspfJoLhbDixWGY3TMaOAdXb1khMFF89g+SXLLULraFoYR+kgds
 IuOBBjE8UCH6/RJ3qLXc6RO7t5r3/e32fkm3FgWUKSa/4ZUr6CkWjOQ/xyqdLSPeswWU
 9uhw==
X-Gm-Message-State: AOJu0Yziv6RinT+zsVvvWdhwz5w5hw9sFqQBr87fGv70H+E6zn2ZoSxr
 KJCYwtW9rhIBd/jeEQxZ1W1BETDDUxM9F30eeOPvnYL1eqL8if/f9G9cMWf+rmBJ8Egruiv/gpN
 eIUANw4dYTgwXxro748jjIRmf5wAarDdfPwAQnAxUUEE6m3Dl8ycx
X-Google-Smtp-Source: AGHT+IEdPweNMa2tJ5f7HhnEN/79FM8Zn4KrilSsX+1gN5K7KPT8I+OVfpBnI5yjDlOMgoJfN6by2HJrdtcHQOZVLSWZ
MIME-Version: 1.0
X-Received: by 2002:a05:6402:3586:b0:64d:88c:c2ca with SMTP id
 4fb4d7f45d1cf-64d088ccb1emr7904145a12.28.1766455507182; Mon, 22 Dec 2025
 18:05:07 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-5d29fa97-311b-4e96-85a6-53ccded21fa5@google.com>
Date: Tue, 23 Dec 2025 02:05:07 +0000
Subject: Synced invitation: U-Boot community meeting @ Tue 9 Dec 2025 8am -
 9am (MST) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000000471e2064694f97d"
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
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--0000000000000471e2064694f97d
Content-Type: multipart/alternative; boundary="0000000000000471df064694f97b"

--0000000000000471df064694f97b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClR1ZXNkYXkgOSBEZWMgMjAyNSDii4UgOGFtIOKA
kyA5YW0NCk1vdW50YWluIFRpbWUgLSBEZW52ZXINCg0KSm9pbiB3aXRoIEdvb2dsZSBNZWV0DQpo
dHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXc/aHM9MjI0DQoNCg0KCQ0KSm9pbiBi
eSBwaG9uZQ0KKFVTKSArMSAyMjQtNTg1LTc4NjQNClBJTjogMTA3Nzk5NDAzDQoNCk1vcmUgcGhv
bmUgbnVtYmVycw0KaHR0cHM6Ly90ZWwubWVldC9idGotd2djZy1ldXc/cGluPTEzMDc1Mjg1NTIz
MjImaHM9MA0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyBieSBHZW1pbmkgIA0KaHR0cHM6Ly9kb2Nz
Lmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xdjlxMkpKT2t2RHhVTXZLZmhiOUppa3FndjNjamRVR1ZR
aHFnX2pDQ0s2TS9lZGl0P3VzcD1tZWV0X3RuZm1fY2FsZW5kYXINCg0KVS1Cb290IGNvbW11bml0
eSBtZWV0aW5nDQoNCkd1ZXN0cw0KcGJpZWw3QGdtYWlsLmNvbQ0KU2ltb24gR2xhc3MNCm1hbHlz
YWdyZWdAZ21haWwuY29tDQp1LWJvb3RAbGlzdHMuZGVueC5kZQ0KDQoNCn5+Ly9+fg0KSW52aXRh
dGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2Nh
bGVuZGFyLw0KDQpZb3UgYXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBh
biBhdHRlbmRlZSBvbiB0aGUgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNv
dWxkIGFsbG93IGFueSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdh
bml6ZXIsIGJlIGFkZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxl
c3Mgb2YgIA0KdGhlaXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQ
Lg0KDQpMZWFybiBtb3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dl
ci8zNzEzNSNmb3J3YXJkaW5nDQo=
--0000000000000471df064694f97b
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
DTSTART;TZID=America/Bahia_Banderas:20251209T090000
DTEND;TZID=America/Bahia_Banderas:20251209T100000
DTSTAMP:20251223T020507Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:dcl58vad6a0tj03etdt5av1n6j@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Simon Glass;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:961365784
RECURRENCE-ID;TZID=America/Bahia_Banderas:20251209T090000
CLASS:PUBLIC
CREATED:20250114T162827Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20251223T020443Z
LOCATION:https://meet.google.com/btj-wgcg-euw
SEQUENCE:4
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
ATTACH;FILENAME=Notes by Gemini;FMTTYPE=application/vnd.google-apps.documen
 t:https://docs.google.com/document/d/1v9q2JJOkvDxUMvKfhb9Jikqgv3cjdUGVQhqg_
 jCCK6M/edit?usp=meet_tnfm_calendar
END:VEVENT
END:VCALENDAR

--0000000000000471df064694f97b--

--0000000000000471e2064694f97d
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEyMDlUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEyMDlUMTAwMDAwDQpEVFNUQU1QOjIwMjUxMjIz
VDAyMDUwN1oNCk9SR0FOSVpFUjtDTj1VLUJvb3Q6bWFpbHRvOjg5YmU3YjgxMzEzNmJlYzA2YTgz
ZGU0ZGE1OTc0NWYwYWJkMTFjMWI4MzYwNjFhZQ0KIDA2YzFjN2RiY2QxOGRmNDFAZ3JvdXAuY2Fs
ZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOmRjbDU4dmFkNmEwdGowM2V0ZHQ1YXYxbjZqQGdvb2dsZS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJpZWw3QGdtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1TaW1vbiBHbGFzcztYLU5VTS1HVUVTVFM9MDptYWlsdG86c2pnQGNocm9taXVtLm9yZw0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYWx5c2FncmVnQGdtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86bWFseXNhZ3JlZ0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049dS1ib290QGxpc3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9v
dEBsaXN0cy5kZW54LmRlDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8vbWVldC5nb29nbGUu
Y29tL2J0ai13Z2NnLWV1dw0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOjk2MTM2NTc4NA0K
UkVDVVJSRU5DRS1JRDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEyMDlUMDkwMDAw
DQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAyNTAxMTRUMTYyODI3Wg0KREVTQ1JJUFRJT046VS1C
b290IGNvbW11bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46fjp+On46
fjp+DQogOn46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6
LVxuSm9pbiB3aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGot
d2djZy1ldXdcbk9yIGRpYWw6IChVUykgKzEgMjI0LTU4NS03ODY0IFBJTjogDQogMTA3Nzk5NDAz
I1xuTW9yZSBwaG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1dz9waW49
MTMwNzUyODU1DQogMjMyMiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDogaHR0cHM6
Ly9zdXBwb3J0Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5QbGVhc2Ug
ZG8gbm90IGVkaXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46DQogfjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+
OjotDQpMQVNULU1PRElGSUVEOjIwMjUxMjIzVDAyMDQ0M1oNCkxPQ0FUSU9OOmh0dHBzOi8vbWVl
dC5nb29nbGUuY29tL2J0ai13Z2NnLWV1dw0KU0VRVUVOQ0U6NA0KU1RBVFVTOkNPTkZJUk1FRA0K
U1VNTUFSWTpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtG
SUxFTkFNRT1Ob3RlcyBieSBHZW1pbmk7Rk1UVFlQRT1hcHBsaWNhdGlvbi92bmQuZ29vZ2xlLWFw
cHMuZG9jdW1lbg0KIHQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xdjlxMkpK
T2t2RHhVTXZLZmhiOUppa3FndjNjamRVR1ZRaHFnXw0KIGpDQ0s2TS9lZGl0P3VzcD1tZWV0X3Ru
Zm1fY2FsZW5kYXINCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--0000000000000471e2064694f97d--
