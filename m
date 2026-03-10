Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFEFEB106C
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F6A840B5;
	Tue, 10 Mar 2026 16:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BFYkbsY4";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cHW16Ncc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B34F840D7; Tue, 10 Mar 2026 16:12:30 +0100 (CET)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com
 [IPv6:2a00:1450:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172F9840B5
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-b94336067ebso315735566b.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773155545; x=1773760345; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TklWqQ88Nf7zqkDPG5uhbzJOomjANyosTHUJuzylPlI=;
 b=BFYkbsY4+QViRIIVt7Qq/10C5yddVJpjm+wqEbgwPuJ7AhLvgmJfsnsSHS8Nx7OOtw
 I1QSGUweMhY/Yx8zNP9d+F2Atm7d7bxwu43NKfOEiEAijh+YkAXz9s/9gG9M6qzM+tG1
 KuI2EjuBQxLg7/8u7erwUehqZhPTC671Tf0pFwNYRZ1cwVMgOlNzJhz1JlMFX0rsPZgv
 BlFaFZq7ECSzGm1vlfwzPfxRFDABz3bz3jkuvho3mhkasXIl91kt66e1831bYUNv1MZn
 ZqAbXNeslbz57HwVn7ygdEvVpI65xS76ckGhNRkNovVwUAP203hZxU1gunIveVRj75Bk
 iatQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773155545; x=1773760345; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TklWqQ88Nf7zqkDPG5uhbzJOomjANyosTHUJuzylPlI=;
 b=cHW16NccoaOgtRfPMldpJy92SaJXwDovC0BgJqII5dmkpTC9o0QQ1sVaURi8zeX6nS
 3OMJx/Yf+6u8A2UCMRtR6BXfvy6/kOQq36zhvtZ3qq3lbkB49YEKoPDeZaUI3P4ztC30
 WZXKPmafZlBw4oeJUULyfz5no1XBuduprw8M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155545; x=1773760345;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TklWqQ88Nf7zqkDPG5uhbzJOomjANyosTHUJuzylPlI=;
 b=uciWiqXLK//ycNSAaBhZD2XCQo/TuhFvIhwBPqkSscGYHkZ5HbWqS0rFBWW9g/UbPp
 kJaT0HUgjrmviRcgYy5h51NOQrWti3GB5yF+76WMl+rq6vtoRbd0Qph8dPQGwOflP1tE
 zH08xsx5YgW8XR6q8EagtyENx3V3Qup95CyosguaC1qhXhcQA7fOeTLiDvqRzX374mRt
 Qau63XHYFbFEFQiGfuaFA2ebnRRXCfl5l3cxkA8S0xCOOndZlxCON00dHllTaIzzl3JM
 PFqn6QNOXiQrRtcANJMznuMF/wqA6VBxPJe69DgESPDs2nLPczNE6SLPborPxP3cHDCC
 DQjQ==
X-Gm-Message-State: AOJu0YzAF3rMW5iNfX1bbbVzr4H93cAoIQgdoNtkSA7Mu+4Lq3KFWBof
 xDWRDsPz0DAajeveTNn7s9npKp9M7xu1ZOAcX8mCx6M+Q1d7XQV0qSijsSmCiDsCy/n78aVaRTv
 tJMmYyaYS7OAuq4hGDZirYJM7L2ZqpCtnO/BxvUQlZctpI/OMR7T7
MIME-Version: 1.0
X-Received: by 2002:a17:907:6d24:b0:b97:27a2:51b with SMTP id
 a640c23a62f3a-b9727a20548mr2026366b.55.1773155545500; Tue, 10 Mar 2026
 08:12:25 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-49881dc8-9a1c-4532-82e2-dc88f157cc19@google.com>
Date: Tue, 10 Mar 2026 15:12:25 +0000
Subject: Synced invitation: U-Boot community meeting @ Tue 24 Feb 2026 8am -
 9am (MST) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000006be147064cacf236"
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

--0000000000006be147064cacf236
Content-Type: multipart/alternative; boundary="0000000000006be146064cacf234"

--0000000000006be146064cacf234
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClR1ZXNkYXkgMjQgRmViIDIwMjYg4ouFIDhhbSDi
gJMgOWFtDQpNb3VudGFpbiBUaW1lIC0gRGVudmVyDQoNCkpvaW4gd2l0aCBHb29nbGUgTWVldA0K
aHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vaWN2LW52bXYtZGJmP2hzPTIyNA0KDQoNCgkNCkpvaW4g
YnkgcGhvbmUNCihVUykgKzEgNDc1LTI5OS04MzYyDQpQSU46IDQzOTA1MjA0OQ0KDQpNb3JlIHBo
b25lIG51bWJlcnMNCmh0dHBzOi8vdGVsLm1lZXQvaWN2LW52bXYtZGJmP3Bpbj01NDkzMTcxOTAw
NTU2JmhzPTANCg0KDQpBdHRhY2htZW50cw0KTm90ZXMgYnkgR2VtaW5pICANCmh0dHBzOi8vZG9j
cy5nb29nbGUuY29tL2RvY3VtZW50L2QvMWg4TXNSWDhmTDVoLUEtTEdHR3ltLVJhMTdpZXYyMm0x
eGZwQUZ6RklVMXcvZWRpdD91c3A9bWVldF90bmZtX2NhbGVuZGFyDQoNClUtQm9vdCBjb21tdW5p
dHkgbWVldGluZw0KDQpHdWVzdHMNCnBiaWVsN0BnbWFpbC5jb20NClNpbW9uIEdsYXNzDQptYWx5
c2FncmVnQGdtYWlsLmNvbQ0Ka29yZy5zdW1pdEBnbWFpbC5jb20NCnUtYm9vdEBsaXN0cy5kZW54
LmRlDQoNCg0Kfn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENhbGVuZGFyOiBodHRwczov
L2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2aW5nIHRoaXMg
ZW1haWwgYmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBldmVudC4NCg0KRm9yd2Fy
ZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cgYW55IHJlY2lwaWVudCB0byBzZW5kIGEg
cmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciwgYmUgYWRkZWQgdG8gdGhlIGd1ZXN0IGxpc3Qs
IGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0aGVpciBvd24gaW52aXRhdGlvbiBzdGF0
dXMsIG9yIG1vZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJuIG1vcmUgaHR0cHM6Ly9zdXBwb3J0Lmdv
b2dsZS5jb20vY2FsZW5kYXIvYW5zd2VyLzM3MTM1I2ZvcndhcmRpbmcNCg==
--0000000000006be146064cacf234
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
DTSTART;TZID=America/Bahia_Banderas:20260224T090000
DTEND;TZID=America/Bahia_Banderas:20260224T100000
DTSTAMP:20260310T151225Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:0v3c45uhvntcro4s5fp73bhl58_R20260210T150000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Simon Glass;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=korg.sumit@gmail.com;X-NUM-GUESTS=0:mailto:korg.sumit@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
X-GOOGLE-CONFERENCE:https://meet.google.com/icv-nvmv-dbf
X-MICROSOFT-CDO-OWNERAPPTID:-832031873
RECURRENCE-ID;TZID=America/Bahia_Banderas:20260224T090000
CLASS:PUBLIC
CREATED:20250114T162827Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/icv-nvmv-dbf\nOr dial: (US) +1 475-299-8362 PIN: 
 439052049#\nMore phone numbers: https://tel.meet/icv-nvmv-dbf?pin=549317190
 0556&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20260310T151204Z
LOCATION:https://meet.google.com/icv-nvmv-dbf
SEQUENCE:5
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
ATTACH;FILENAME=Notes by Gemini;FMTTYPE=application/vnd.google-apps.documen
 t:https://docs.google.com/document/d/1h8MsRX8fL5h-A-LGGGym-Ra17iev22m1xfpAF
 zFIU1w/edit?usp=meet_tnfm_calendar
END:VEVENT
END:VCALENDAR

--0000000000006be146064cacf234--

--0000000000006be147064cacf236
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMjRUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMjRUMTAwMDAwDQpEVFNUQU1QOjIwMjYwMzEw
VDE1MTIyNVoNCk9SR0FOSVpFUjtDTj1VLUJvb3Q6bWFpbHRvOjg5YmU3YjgxMzEzNmJlYzA2YTgz
ZGU0ZGE1OTc0NWYwYWJkMTFjMWI4MzYwNjFhZQ0KIDA2YzFjN2RiY2QxOGRmNDFAZ3JvdXAuY2Fs
ZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjB2M2M0NXVodm50Y3JvNHM1ZnA3M2JobDU4X1IyMDI2MDIx
MFQxNTAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1wYmllbDdA
Z21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYmllbDdAZ21haWwuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPVNpbW9uIEdsYXNzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpz
amdAY2hyb21pdW0ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1hbHlzYWdyZWdA
Z21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYWx5c2FncmVnQGdtYWlsLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1rb3JnLnN1bWl0QGdtYWlsLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86a29yZy5zdW1pdEBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049dS1ib290QGxpc3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9vdEBs
aXN0cy5kZW54LmRlDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8vbWVldC5nb29nbGUuY29t
L2ljdi1udm12LWRiZg0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi04MzIwMzE4NzMNClJF
Q1VSUkVOQ0UtSUQ7VFpJRD1BbWVyaWNhL0JhaGlhX0JhbmRlcmFzOjIwMjYwMjI0VDA5MDAwMA0K
Q0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMjUwMTE0VDE2MjgyN1oNCkRFU0NSSVBUSU9OOlUtQm9v
dCBjb21tdW5pdHkgbWVldGluZ1xuXG4tOjp+On46On46fjp+On46fjp+On46fjp+On46fjp+On46
fg0KIDp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46Oi1c
bkpvaW4gd2l0aCBHb29nbGUgTWVldA0KIDogaHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vaWN2LW52
bXYtZGJmXG5PciBkaWFsOiAoVVMpICsxIDQ3NS0yOTktODM2MiBQSU46IA0KIDQzOTA1MjA0OSNc
bk1vcmUgcGhvbmUgbnVtYmVyczogaHR0cHM6Ly90ZWwubWVldC9pY3YtbnZtdi1kYmY/cGluPTU0
OTMxNzE5MA0KIDA1NTYmaHM9N1xuXG5MZWFybiBtb3JlIGFib3V0IE1lZXQgYXQ6IGh0dHBzOi8v
c3VwcG9ydC5nb29nbGUuY29tL2EvdXNlcnMvYQ0KIG5zd2VyLzkyODI3MjBcblxuUGxlYXNlIGRv
IG5vdCBlZGl0IHRoaXMgc2VjdGlvbi5cbi06On46fjo6fjp+On46fjp+On46fjp+Og0KIH46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6
LQ0KTEFTVC1NT0RJRklFRDoyMDI2MDMxMFQxNTEyMDRaDQpMT0NBVElPTjpodHRwczovL21lZXQu
Z29vZ2xlLmNvbS9pY3YtbnZtdi1kYmYNClNFUVVFTkNFOjUNClNUQVRVUzpDT05GSVJNRUQNClNV
TU1BUlk6VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklM
RU5BTUU9Tm90ZXMgYnkgR2VtaW5pO0ZNVFRZUEU9YXBwbGljYXRpb24vdm5kLmdvb2dsZS1hcHBz
LmRvY3VtZW4NCiB0Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMWg4TXNSWDhm
TDVoLUEtTEdHR3ltLVJhMTdpZXYyMm0xeGZwQUYNCiB6RklVMXcvZWRpdD91c3A9bWVldF90bmZt
X2NhbGVuZGFyDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--0000000000006be147064cacf236--
