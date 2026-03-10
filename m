Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4C8EB106C
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC21684088;
	Tue, 10 Mar 2026 16:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Y67h2O9w";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KlY7PhrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C5E840B6; Tue, 10 Mar 2026 16:12:28 +0100 (CET)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com
 [IPv6:2a00:1450:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27D78405F
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-660fa747a8aso6465493a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773155545; x=1773760345; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IZu601fLwfguz1xqoYJjCB+4J8DrA5czacl8JOYs0XE=;
 b=Y67h2O9wAmEOBK7JqxEX8kCMw2w12ftHkME6EXeZOdxjBFgk5yeF1Y0qdqaQiepA8X
 6qiwkMEwKFFYFKVEGJ+RrRe63FrOhqMPQnDmpJN9pHLj8g8WLvNtzrOyvRrBxUKVxNie
 lTzQp1/DRAyxObWXgj/AkddFArrE2Z36gKVXE8lQyAIkjZPhnx5tIrUa2qpLMv3Bwuqt
 39OTfOXyB8a0RvQIMG4hzxLmwHuRgwynaeAKQS7bsLDLRPNfYryB03FPF9KsrIjGRxa7
 1qyovqCmT0G/HDANPZDhJTFMbi+qrKOvNzUgmqnyRC/qEaYfxceu3fQ+reKksaJSgQRA
 Hzcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773155545; x=1773760345; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IZu601fLwfguz1xqoYJjCB+4J8DrA5czacl8JOYs0XE=;
 b=KlY7PhrH09u7PGOZYfYofxvrfG56rwLwgQarFwZ8Dquh7OodF1FBA59Fof+JDC1d1E
 SGW6oSZ+i1HngOx6bGNKBwsTlLBUYY+w3K65thJjOCGr2OZLthVTGgDzItEoI6bnq37P
 wmiAstGMNL+D9do1oUjTJBrqGj6cgyoLo1EzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155545; x=1773760345;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IZu601fLwfguz1xqoYJjCB+4J8DrA5czacl8JOYs0XE=;
 b=ffUxBaAvkEC4g4F+cvpGVhPelUPRxFFNgwKCsKoOc6/OmaYNUVwh5AgotznywbD2aU
 Xwz6CHy0xrd3FoY8PjO53l8LmlaLtlDlIoQmDr4utyc8+fUWQO1EJGvBkDZTsFipGrL0
 YnoE2iwmEeb78kvlUhpNV1J6YkDU+yKhvPnKYsJMrkUl7CITw5v96I5y5kwSzpBQM3yE
 QKpDUInbHFgf/gvE140Dj3kLeMeBeeg7WaEgrtYLIm9z4VN/82zsf1sDh4xwsG6NgqDl
 Oq/fE4/KIpiZBp/4EFyqe8rv1z6Jnwqn2bQ+dwGtbEz9VDWionQXQo2OXizKYlWC+LRM
 bBGg==
X-Gm-Message-State: AOJu0YywmhN5enIqRtmZoAEEKe0seFrwrqTuhM4W2OaCyKok/nnYYi84
 8Xwxb/KeSsux+KkioX1LUM+jpUB/beLAbzIBRsckYZEizmZsA4r/7VsQh60ANcnNf41gfxeQ6UK
 oE9QZM0NF6V18lBEv7XgnWMF76yJAvL2B0jrdTkm6/XLhZPow4RjG
MIME-Version: 1.0
X-Received: by 2002:a05:6402:430d:b0:659:4853:5382 with SMTP id
 4fb4d7f45d1cf-6619d531314mr8214403a12.32.1773155545406; Tue, 10 Mar 2026
 08:12:25 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-f40ac413-839e-45cc-965a-fb2df471c2eb@google.com>
Date: Tue, 10 Mar 2026 15:12:25 +0000
Subject: Synced invitation: U-Boot community meeting @ Tue 10 Feb 2026 8am -
 9am (MST) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000006a6ff1064cacf23d"
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

--0000000000006a6ff1064cacf23d
Content-Type: multipart/alternative; boundary="0000000000006a6fef064cacf23b"

--0000000000006a6fef064cacf23b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClR1ZXNkYXkgMTAgRmViIDIwMjYg4ouFIDhhbSDi
gJMgOWFtDQpNb3VudGFpbiBUaW1lIC0gRGVudmVyDQoNCkpvaW4gd2l0aCBHb29nbGUgTWVldA0K
aHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vaWN2LW52bXYtZGJmP2hzPTIyNA0KDQoNCgkNCkpvaW4g
YnkgcGhvbmUNCihVUykgKzEgNDc1LTI5OS04MzYyDQpQSU46IDQzOTA1MjA0OQ0KDQpNb3JlIHBo
b25lIG51bWJlcnMNCmh0dHBzOi8vdGVsLm1lZXQvaWN2LW52bXYtZGJmP3Bpbj01NDkzMTcxOTAw
NTU2JmhzPTANCg0KDQpBdHRhY2htZW50cw0KTm90ZXMgYnkgR2VtaW5pICANCmh0dHBzOi8vZG9j
cy5nb29nbGUuY29tL2RvY3VtZW50L2QvMUxlczl3MDFnbGduX216eVQ3d05TakpBbjZua1I2eHhr
ekxSMlh1aGp1R1kvZWRpdD91c3A9bWVldF90bmZtX2NhbGVuZGFyDQoNClUtQm9vdCBjb21tdW5p
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
--0000000000006a6fef064cacf23b
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
DTSTART;TZID=America/Bahia_Banderas:20260210T090000
DTEND;TZID=America/Bahia_Banderas:20260210T100000
DTSTAMP:20260310T151225Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:0v3c45uhvntcro4s5fp73bhl58_R20260210T150000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=DELETED;RSVP=TRUE;
 CN=Simon Glass;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=korg.sumit@gmail.com;X-NUM-GUESTS=0:mailto:korg.sumit@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
X-GOOGLE-CONFERENCE:https://meet.google.com/icv-nvmv-dbf
X-MICROSOFT-CDO-OWNERAPPTID:-1781567907
RECURRENCE-ID;TZID=America/Bahia_Banderas:20260210T090000
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
 t:https://docs.google.com/document/d/1Les9w01glgn_mzyT7wNSjJAn6nkR6xxkzLR2X
 uhjuGY/edit?usp=meet_tnfm_calendar
END:VEVENT
END:VCALENDAR

--0000000000006a6fef064cacf23b--

--0000000000006a6ff1064cacf23d
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMTBUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMTBUMTAwMDAwDQpEVFNUQU1QOjIwMjYwMzEw
VDE1MTIyNVoNCk9SR0FOSVpFUjtDTj1VLUJvb3Q6bWFpbHRvOjg5YmU3YjgxMzEzNmJlYzA2YTgz
ZGU0ZGE1OTc0NWYwYWJkMTFjMWI4MzYwNjFhZQ0KIDA2YzFjN2RiY2QxOGRmNDFAZ3JvdXAuY2Fs
ZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjB2M2M0NXVodm50Y3JvNHM1ZnA3M2JobDU4X1IyMDI2MDIx
MFQxNTAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1wYmllbDdA
Z21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYmllbDdAZ21haWwuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUxFVEVE
O1JTVlA9VFJVRTsNCiBDTj1TaW1vbiBHbGFzcztYLU5VTS1HVUVTVFM9MDptYWlsdG86c2pnQGNo
cm9taXVtLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYWx5c2FncmVnQGdtYWls
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFseXNhZ3JlZ0BnbWFpbC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049a29yZy5zdW1pdEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOmtvcmcuc3VtaXRAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PXUtYm9vdEBsaXN0cy5kZW54LmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp1LWJvb3RAbGlzdHMu
ZGVueC5kZQ0KWC1HT09HTEUtQ09ORkVSRU5DRTpodHRwczovL21lZXQuZ29vZ2xlLmNvbS9pY3Yt
bnZtdi1kYmYNClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotMTc4MTU2NzkwNw0KUkVDVVJS
RU5DRS1JRDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMTBUMDkwMDAwDQpDTEFT
UzpQVUJMSUMNCkNSRUFURUQ6MjAyNTAxMTRUMTYyODI3Wg0KREVTQ1JJUFRJT046VS1Cb290IGNv
bW11bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46fjp+On46fjp+DQog
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6LVxuSm9p
biB3aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS9pY3YtbnZtdi1k
YmZcbk9yIGRpYWw6IChVUykgKzEgNDc1LTI5OS04MzYyIFBJTjogDQogNDM5MDUyMDQ5I1xuTW9y
ZSBwaG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2ljdi1udm12LWRiZj9waW49NTQ5MzE3
MTkwDQogMDU1NiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDogaHR0cHM6Ly9zdXBw
b3J0Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5QbGVhc2UgZG8gbm90
IGVkaXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46DQogfjp+On46fjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+OjotDQpM
QVNULU1PRElGSUVEOjIwMjYwMzEwVDE1MTIwNFoNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5nb29n
bGUuY29tL2ljdi1udm12LWRiZg0KU0VRVUVOQ0U6NQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFS
WTpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtGSUxFTkFN
RT1Ob3RlcyBieSBHZW1pbmk7Rk1UVFlQRT1hcHBsaWNhdGlvbi92bmQuZ29vZ2xlLWFwcHMuZG9j
dW1lbg0KIHQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xTGVzOXcwMWdsZ25f
bXp5VDd3TlNqSkFuNm5rUjZ4eGt6TFIyWA0KIHVoanVHWS9lZGl0P3VzcD1tZWV0X3RuZm1fY2Fs
ZW5kYXINCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--0000000000006a6ff1064cacf23d--
