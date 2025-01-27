Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C54C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFC88175D;
	Mon, 27 Jan 2025 22:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JNSsDceT";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SsZnL7PQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A72C812C8; Mon, 27 Jan 2025 22:16:08 +0100 (CET)
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com
 [IPv6:2607:f8b0:4864:20::d49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF73D8129B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-io1-xd49.google.com with SMTP id
 ca18e2360f4ac-84cdb5795b0so330797839f.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738012562; x=1738617362; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vqgTszRz9ImM0PMxBFGxVIvyoVyfuzX0lHcrlL9f4Z0=;
 b=JNSsDceTOE8AFIuwzmX+NXDIfTBINzc6Tc3rhOzcE+AyNyDpL6F1AKRXrr5KsPUfLz
 6qfNawkIKT9SyFer6aBGFxbUHKmt7U4bocjyPnfAzI2WQuIdISFC6a4yZ2cI1+YFiTo2
 OcGqsPKUUwzeN2WDVbbFZnFv9W7L39g9QLJ2fkOozgEA2z+R/xXwNPRGG2WYThNpMwdC
 mg8F9oPubvL03Te1O9va5h2AcDV+l0vCdG+4ruKYdTqaAoKt+8Q+Yfvfmm5MhYKcE+dK
 6Zkg8QKbvDMK/ncWbws6TPU04Byuuus7B1sul4i0bmD2Mddh3deAL4XayLsiSeirLmTx
 qaVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738012563; x=1738617363; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vqgTszRz9ImM0PMxBFGxVIvyoVyfuzX0lHcrlL9f4Z0=;
 b=SsZnL7PQ6bGfIuVspJj1iPp5vXL1zFxRXBDAgxMjK7aAuTKTXSlEddnHhuo9UyGKDO
 7F8sQD/Xq32xWrOJRqS0bxqjOJF6IkEZ1UzWtuhj61luFVeWJPyD6APBQDQ1pL903CeI
 mekJLS/peI5Kn1lO3LOU2CJVt3Z49nSrKXerw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738012563; x=1738617363;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqgTszRz9ImM0PMxBFGxVIvyoVyfuzX0lHcrlL9f4Z0=;
 b=u9IpRX6HH9d7wczWE7yGbhj6udSSJGfOErnx7A4LPTs3TH3BZ6g40ny5d4X/MwkIev
 +x+OUg1zCQ1ZTb5DDxs1FVj9cWSiYiJGJMjsis6i/IMMJG9u45K9ogBmkzf1qwc0nmqi
 SfgaK/NGRHke4KEYeUaF8fY1syDaI1MsiRtqjWaprsVQy5/c4NGL+5rYL+LrodWWgRbZ
 n3rY0xdqBHx/dRB4Cfu3/AACR78OM5Qa0TcK3ZsuRNsZgP2FRo/S+6kNow/j/tVnxRfH
 vr74kpR+nn9miPTRQL1rPmiTf3A4vgX/jQNjYK5MZkl5sc2OkOM63n6ckmMzY8VwYc+Q
 cScQ==
X-Gm-Message-State: AOJu0YwR1UtbxBFjEvuBxa7vmz2OVIJSR2ZEj9lvuBo8kenDOa/wXlhJ
 ipXoz2Reb5smIFuL2zhawnzHfv5pio1FVapDnO9nla/Ld528uRxSZfQiFzBEMKYeOJ5uwDK6C3v
 Ckb31GgQu5y9ahdM5PZr4wraw8lGPJNoWzCjHEHH52LsT3XHgtA==
X-Google-Smtp-Source: AGHT+IFvn8ws0WtxiB6si4TIp+cFSs7MxhvWtrGkUDbiqu2O9t+LN0Mdq92TRDiK8Zveabq00i2mzbL4tQ4Neh3XjZYq
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a0e:b0:843:e667:f198 with SMTP id
 ca18e2360f4ac-851b616d44amr3283575439f.2.1738012562724; Mon, 27 Jan 2025
 13:16:02 -0800 (PST)
Message-ID: <calendar-926beecc-acd7-48be-8677-baa3d3be0394@google.com>
Date: Mon, 27 Jan 2025 21:16:02 +0000
Subject: Invitation: U-Boot community meeting @ Tue Jan 28, 2025 9am - 10am
 (CST) (u-boot@lists.denx.de)
From: Tom Rini <tom.rini@konsulko.com>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000006ac681062cb6956d"
X-Mailman-Approved-At: Mon, 27 Jan 2025 22:16:47 +0100
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

--0000000000006ac681062cb6956d
Content-Type: multipart/alternative; boundary="0000000000006ac67f062cb6956b"

--0000000000006ac67f062cb6956b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUdWVzZGF5IEphbiAyOCwgMjAyNSDii4UgOWFtIOKA
kyAxMGFtDQpDZW50cmFsIFN0YW5kYXJkIFRpbWUgLSBCYWjDrWEgZGUgQmFuZGVyYXMNCg0KSm9p
biB3aXRoIEdvb2dsZSBNZWV0DQpodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXc/
aHM9MjI0DQoNCg0KCQ0KSm9pbiBieSBwaG9uZQ0KKFVTKSArMSAyMjQtNTg1LTc4NjQNClBJTjog
MTA3Nzk5NDAzDQoNCk1vcmUgcGhvbmUgbnVtYmVycw0KaHR0cHM6Ly90ZWwubWVldC9idGotd2dj
Zy1ldXc/cGluPTEzMDc1Mjg1NTIzMjImaHM9MA0KDQoNClUtQm9vdCBjb21tdW5pdHkgbWVldGlu
Zw0KDQpHdWVzdHMNCnUtYm9vdEBsaXN0cy5kZW54LmRlDQpWaWV3IGFsbCBndWVzdCBpbmZvICAN
Cmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZl
aWQ9TjI4ME4ydGxjWEUzYURWdGJqbGljbk5rY204MlluQTFiREFnZFMxaWIyOTBRR3hwYzNSekxt
Umxibmd1WkdVJnRvaz1PVEFqT0RsaVpUZGlPREV6TVRNMlltVmpNRFpoT0ROa1pUUmtZVFU1TnpR
MVpqQmhZbVF4TVdNeFlqZ3pOakEyTVdGbE1EWmpNV00zWkdKalpERTRaR1kwTVVCbmNtOTFjQzVq
WVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0Tm1VMU0ySTVaV0kzTjJNNU1tUXdaRFF4T1Rjell6ZzRO
elptTWpZeE1EWmtaVGxrWmpCbVlnJmN0ej1BbWVyaWNhJTJGQmFoaWFfQmFuZGVyYXMmaGw9ZW4m
ZXM9MA0KDQpSZXBseSBmb3IgdS1ib290QGxpc3RzLmRlbnguZGUgYW5kIHZpZXcgbW9yZSBkZXRh
aWxzICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249
VklFVyZlaWQ9TjI4ME4ydGxjWEUzYURWdGJqbGljbk5rY204MlluQTFiREFnZFMxaWIyOTBRR3hw
YzNSekxtUmxibmd1WkdVJnRvaz1PVEFqT0RsaVpUZGlPREV6TVRNMlltVmpNRFpoT0ROa1pUUmtZ
VFU1TnpRMVpqQmhZbVF4TVdNeFlqZ3pOakEyTVdGbE1EWmpNV00zWkdKalpERTRaR1kwTVVCbmNt
OTFjQzVqWVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0Tm1VMU0ySTVaV0kzTjJNNU1tUXdaRFF4T1Rj
ell6ZzROelptTWpZeE1EWmtaVGxrWmpCbVlnJmN0ej1BbWVyaWNhJTJGQmFoaWFfQmFuZGVyYXMm
aGw9ZW4mZXM9MA0KWW91ciBhdHRlbmRhbmNlIGlzIG9wdGlvbmFsLg0KDQp+fi8vfn4NCkludml0
YXRpb24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9j
YWxlbmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUg
YW4gYXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBj
b3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3Jn
YW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRs
ZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNW
UC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3
ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--0000000000006ac67f062cb6956b
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
DTSTAMP:20250127T211602Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:7o47keqq7h5mn9brsdro6bp5l0@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
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
LAST-MODIFIED:20250127T211601Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--0000000000006ac67f062cb6956b--

--0000000000006ac681062cb6956d
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
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTAxMjhUMTAwMDAwDQpEVFNUQU1QOjIwMjUwMTI3
VDIxMTYwMloNCk9SR0FOSVpFUjtDTj1VLUJvb3Q6bWFpbHRvOjg5YmU3YjgxMzEzNmJlYzA2YTgz
ZGU0ZGE1OTc0NWYwYWJkMTFjMWI4MzYwNjFhZQ0KIDA2YzFjN2RiY2QxOGRmNDFAZ3JvdXAuY2Fs
ZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjdvNDdrZXFxN2g1bW45YnJzZHJvNmJwNWwwQGdvb2dsZS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049dS1ib290QGxpc3RzLmRlbnguZGU7WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9vdEBsaXN0cy5kZW54LmRlDQpYLUdPT0dMRS1DT05GRVJF
TkNFOmh0dHBzOi8vbWVldC5nb29nbGUuY29tL2J0ai13Z2NnLWV1dw0KWC1NSUNST1NPRlQtQ0RP
LU9XTkVSQVBQVElEOjE0ODgzMzMyODINCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDI1MDExNFQx
NjI4MjdaDQpERVNDUklQVElPTjpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmdcblxuLTo6fjp+Ojp+
On46fjp+On46fjp+On46fjp+On46fjp+On4NCiA6fjp+On46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+On46fjp+On46fjo6fjp+OjotXG5Kb2luIHdpdGggR29vZ2xlIE1lZXQNCiA6IGh0dHBz
Oi8vbWVldC5nb29nbGUuY29tL2J0ai13Z2NnLWV1d1xuT3IgZGlhbDogKFVTKSArMSAyMjQtNTg1
LTc4NjQgUElOOiANCiAxMDc3OTk0MDMjXG5Nb3JlIHBob25lIG51bWJlcnM6IGh0dHBzOi8vdGVs
Lm1lZXQvYnRqLXdnY2ctZXV3P3Bpbj0xMzA3NTI4NTUNCiAyMzIyJmhzPTdcblxuTGVhcm4gbW9y
ZSBhYm91dCBNZWV0IGF0OiBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9hL3VzZXJzL2ENCiBu
c3dlci85MjgyNzIwXG5cblBsZWFzZSBkbyBub3QgZWRpdCB0aGlzIHNlY3Rpb24uXG4tOjp+On46
On46fjp+On46fjp+On46fjoNCiB+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+On46fjp+On46fjp+Ojp+On46Oi0NCkxBU1QtTU9ESUZJRUQ6MjAyNTAxMjdUMjExNjAx
Wg0KTE9DQVRJT046DQpTRVFVRU5DRTowDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlUtQm9v
dCBjb21tdW5pdHkgbWVldGluZw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxF
TkRBUg0K
--0000000000006ac681062cb6956d--
