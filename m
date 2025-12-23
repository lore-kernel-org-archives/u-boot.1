Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F1E6B26B
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 02:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EA78412C;
	Tue, 23 Dec 2025 03:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PbkmQTYK";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QOtT/7bP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A4D8412C; Tue, 23 Dec 2025 03:05:10 +0100 (CET)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com
 [IPv6:2a00:1450:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A981783E70
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x64a.google.com with SMTP id
 a640c23a62f3a-b801b94fedcso492288466b.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766455507; x=1767060307; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5amMNs5Qi4fgEiaHLa1YeHyGGTXEbHj/JkgGc/Xy7M0=;
 b=PbkmQTYKLBtlF+zKczoVJtwTP2pOsWCe3GnIA55XKXiGVpJbjwJw893jGDceF8x94Z
 Yat7jAyR71fAJFMzqYuC3osMsDLIIEms4dTeKWrUaIkcX2xkZ0h3v+3ahT/SIQM2A7ih
 jsZl1tJnvZfAY4H8+jLw4yaETnee1qqmhrfoCblPSxm6AV5X2hGD0eeLJkcY4CHesmLk
 yOeo8CilBHX/FOzrsdmbWWQy15kAUStIl/65Nr6nA9/Ik1qPftT5az/T4swW8FuMHJGv
 i68/HYkm8WeV9lx8u7GeaM61D9CpeVcuUlS+wHARBqDBlO4F38zp7JlGI9XgB+DtANkh
 tMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766455507; x=1767060307; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5amMNs5Qi4fgEiaHLa1YeHyGGTXEbHj/JkgGc/Xy7M0=;
 b=QOtT/7bPk6NEIO7cRjw1z2IjL6gUHLeshRDJzi/gSeDYe51+kwI9MHpqPnyZrl2EWG
 vXUmKQdsHBjbXhTZPCu0Q7tsi03WMdQVYrZHaIbhBbrbUcN1HeJZkFAkfX3PHUX7pMxh
 HwzJCVJsrV3SIZ8eUTcK6VWWbqS1qpjKvX14U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455507; x=1767060307;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5amMNs5Qi4fgEiaHLa1YeHyGGTXEbHj/JkgGc/Xy7M0=;
 b=OsSoB90io6FKzeZxqf96Tk1UaeJ9bhSNaUoOJbmI+XM5bmra1sQiNqmewYKMb2fOSe
 foTy6bUv7ETgwT8xyx/5xoY6h3IMNvAp55pzw1Weiql6QjC3zSap4PNZlKd95lf/kscc
 ZMb4l/1NllSSHoYdd74JdTmwvRlHD52KvvzuOGQ1eEYlYTl9nAweMy9DH2LQoAimBtLk
 LgaSBT1/YKZ153ygCI0CdK3pl12AhO/cQsyabnxt4kuhkBELWEPLijnYwRyVOArAadOp
 dVNCzMRMo1+mAbvUjzkoXePXUX5bXqdX9wgFHPFdNf6CrUyY7MO/wCEJVzolTjrIN51R
 ibZA==
X-Gm-Message-State: AOJu0Yyb+lpZqZ0qCC0opGroiYLKKMQ+efnhjNit0Fw259JiAcAF99Om
 vKhMFprivj3D+X0gPn0tJz03q2cYVo93BZYX7o9h4OzheFQS5m36+Gwr2nUKjVIf9GOsH3GaLBQ
 xeggKo7u4JfkcEe0/gVgYvwuQdZ97ui9WB6x2uEsbe49P+LUqd58u
X-Google-Smtp-Source: AGHT+IGpMR13XT9J0ysGbQTlRsdJWwiMKl1f88j0kqIOdK7GomI4bouFHSuD5gb3bbDC9g1XvJtZOA9lEYo1t2UHkhst
MIME-Version: 1.0
X-Received: by 2002:a17:907:c24:b0:b73:76c5:8f7c with SMTP id
 a640c23a62f3a-b80371f7236mr1285783766b.43.1766455507063; Mon, 22 Dec 2025
 18:05:07 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-d0d6a92a-8c31-4be5-b894-7338ee5a5bfb@google.com>
Date: Tue, 23 Dec 2025 02:05:07 +0000
Subject: Synced invitation: U-Boot community meeting @ Tue 25 Nov 2025 8am -
 9am (MST) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="00000000000002a376064694f9f8"
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

--00000000000002a376064694f9f8
Content-Type: multipart/alternative; boundary="00000000000002a375064694f9f6"

--00000000000002a375064694f9f6
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClR1ZXNkYXkgMjUgTm92IDIwMjUg4ouFIDhhbSDi
gJMgOWFtDQpNb3VudGFpbiBUaW1lIC0gRGVudmVyDQoNCkpvaW4gd2l0aCBHb29nbGUgTWVldA0K
aHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vYnRqLXdnY2ctZXV3P2hzPTIyNA0KDQoNCgkNCkpvaW4g
YnkgcGhvbmUNCihVUykgKzEgMjI0LTU4NS03ODY0DQpQSU46IDEwNzc5OTQwMw0KDQpNb3JlIHBo
b25lIG51bWJlcnMNCmh0dHBzOi8vdGVsLm1lZXQvYnRqLXdnY2ctZXV3P3Bpbj0xMzA3NTI4NTUy
MzIyJmhzPTANCg0KDQpBdHRhY2htZW50cw0KTm90ZXMgYnkgR2VtaW5pICANCmh0dHBzOi8vZG9j
cy5nb29nbGUuY29tL2RvY3VtZW50L2QvMVBFVmM4VTJ3QmlKUVNveXp2dENmTWhacDhUY21hQXRL
cmpYTHB5UTFXWWsvZWRpdD91c3A9bWVldF90bmZtX2NhbGVuZGFyDQoNClUtQm9vdCBjb21tdW5p
dHkgbWVldGluZw0KDQpHdWVzdHMNCnBiaWVsN0BnbWFpbC5jb20NClNpbW9uIEdsYXNzDQptYWx5
c2FncmVnQGdtYWlsLmNvbQ0KdS1ib290QGxpc3RzLmRlbnguZGUNCg0KDQp+fi8vfn4NCkludml0
YXRpb24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9j
YWxlbmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUg
YW4gYXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBj
b3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3Jn
YW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRs
ZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNW
UC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3
ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000002a375064694f9f6
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
DTSTART;TZID=America/Bahia_Banderas:20251125T090000
DTEND;TZID=America/Bahia_Banderas:20251125T100000
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
X-MICROSOFT-CDO-OWNERAPPTID:1507436888
RECURRENCE-ID;TZID=America/Bahia_Banderas:20251125T090000
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
 t:https://docs.google.com/document/d/1PEVc8U2wBiJQSoyzvtCfMhZp8TcmaAtKrjXLp
 yQ1WYk/edit?usp=meet_tnfm_calendar
END:VEVENT
END:VCALENDAR

--00000000000002a375064694f9f6--

--00000000000002a376064694f9f8
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTExMjVUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTExMjVUMTAwMDAwDQpEVFNUQU1QOjIwMjUxMjIz
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
Y29tL2J0ai13Z2NnLWV1dw0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOjE1MDc0MzY4ODgN
ClJFQ1VSUkVOQ0UtSUQ7VFpJRD1BbWVyaWNhL0JhaGlhX0JhbmRlcmFzOjIwMjUxMTI1VDA5MDAw
MA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMjUwMTE0VDE2MjgyN1oNCkRFU0NSSVBUSU9OOlUt
Qm9vdCBjb21tdW5pdHkgbWVldGluZ1xuXG4tOjp+On46On46fjp+On46fjp+On46fjp+On46fjp+
On46fg0KIDp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46
Oi1cbkpvaW4gd2l0aCBHb29nbGUgTWVldA0KIDogaHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vYnRq
LXdnY2ctZXV3XG5PciBkaWFsOiAoVVMpICsxIDIyNC01ODUtNzg2NCBQSU46IA0KIDEwNzc5OTQw
MyNcbk1vcmUgcGhvbmUgbnVtYmVyczogaHR0cHM6Ly90ZWwubWVldC9idGotd2djZy1ldXc/cGlu
PTEzMDc1Mjg1NQ0KIDIzMjImaHM9N1xuXG5MZWFybiBtb3JlIGFib3V0IE1lZXQgYXQ6IGh0dHBz
Oi8vc3VwcG9ydC5nb29nbGUuY29tL2EvdXNlcnMvYQ0KIG5zd2VyLzkyODI3MjBcblxuUGxlYXNl
IGRvIG5vdCBlZGl0IHRoaXMgc2VjdGlvbi5cbi06On46fjo6fjp+On46fjp+On46fjp+Og0KIH46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46
fjo6LQ0KTEFTVC1NT0RJRklFRDoyMDI1MTIyM1QwMjA0NDNaDQpMT0NBVElPTjpodHRwczovL21l
ZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXcNClNFUVVFTkNFOjQNClNUQVRVUzpDT05GSVJNRUQN
ClNVTU1BUlk6VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7
RklMRU5BTUU9Tm90ZXMgYnkgR2VtaW5pO0ZNVFRZUEU9YXBwbGljYXRpb24vdm5kLmdvb2dsZS1h
cHBzLmRvY3VtZW4NCiB0Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMVBFVmM4
VTJ3QmlKUVNveXp2dENmTWhacDhUY21hQXRLcmpYTHANCiB5UTFXWWsvZWRpdD91c3A9bWVldF90
bmZtX2NhbGVuZGFyDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--00000000000002a376064694f9f8--
