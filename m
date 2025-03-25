Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B0CC3600E
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A64081E47;
	Tue, 25 Mar 2025 15:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WVEaQfvD";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W9uW3Fck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D506F812BC; Tue, 25 Mar 2025 15:51:23 +0100 (CET)
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com
 [IPv6:2a00:1450:4864:20::14a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E486B80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-lf1-x14a.google.com with SMTP id
 2adb3069b0e04-54989998f1bso2604969e87.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1742914280; x=1743519080; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HaIHOXSqKE131RW3DTUkP3SJVI6Kv+/vWKugWYk22Jg=;
 b=WVEaQfvDiI2W4lHXX3Nbs0DoJ4tufeQIzu+F0WAw7ZQF1+ng0zFwmjuPfRBcYfQLUu
 7KtSQRFjeJ6B6s47iVTfOiKWVO/uOUwbDfXBEWuS8gzc7nb1eBJNqs9LKZcs8Ev7L0gl
 MufQe+jTtWEO4a6PeWVoJ64axtWu3sEn/hImHzxSwudKO/gADkzGEq8XpvwXuqzRDbg5
 igYcB1hAtT+yAAPKWN4iu/0WxhjpKCUO96XgpWwV/Ffgbc4buF5cvtHdJynRCi5+MzX7
 o6sNYdrkSb1sxlUWtSaTiVqvk6SKmTo1BRA4NcNXQ9QttTmXAhjLpcsBgOb84d8ng081
 2hSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742914280; x=1743519080; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HaIHOXSqKE131RW3DTUkP3SJVI6Kv+/vWKugWYk22Jg=;
 b=W9uW3FckAGxRkengi8e01C6uDneIWBUz9VrceQ2HZTCu7Z6MTvExq1tKRBuxHC2Axa
 pI+VHdw3b7QPXGzndIuisUHfN39f8qXnVnRt3N5q5T/sI1MgKYhCwu5JB7TsYT6I82fH
 GihspfVBxPrLb3NZaonK2TFqPxcIcHaQ6hC1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914280; x=1743519080;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HaIHOXSqKE131RW3DTUkP3SJVI6Kv+/vWKugWYk22Jg=;
 b=BgKBFBM74c2S7jFj8LCKbKl9Sf5PGBp6UWNxt5eeWf7KkykTgUYFZrhGQCJ2HSjGj4
 +xw9PVwnyls+2KICRcHk9thr4xU3ZiBByd1T2eNOhCUhccGypcWc2oA2ZKRDgViLDqaG
 7WzeHZTwgZWtGAeI93MmhxXnYJUgLrs6JsCLYUH2B+yAuQetUr2zQTzMworKycOv0OSX
 kFUJ6w5kgc9x+3ZjNqdylxaqGjbnWX7CpJYudI0c0E3co2aDJRbKKdxI07fdfHxaee1G
 Rv7ZRchETa4/pdzHFteCK56W7iAMIJXmBTejmcj0516euBMLfRjxrk8BJ0T9IPYntMvt
 Jl3A==
X-Gm-Message-State: AOJu0YwFdc9qHD/jB/t1RgnPP2z41BAbi2/xvq6a5WnpFQYJElkyGmxB
 MkvOnAEdK/BuN+4Q/7ekF+l4z64EeOz5QGC9+mfxhlAxJedlVJN43HeEtBGn8tw/baFc0pX0C6P
 V7EkGebVGGhilPhjtVAmXS9OiV3k6AZSMssT7T5YmrtiMrv10kD7J
X-Google-Smtp-Source: AGHT+IH+B4iZu2wmoZLGrAjW8p3HlbZNOBGrNyKcS5D4X0MAmEFcFSzJOKrIzpD5wJPwcf9x6ivxyUdcRtSoLAwqvV0P
MIME-Version: 1.0
X-Received: by 2002:a05:6512:3d21:b0:542:28b4:23ad with SMTP id
 2adb3069b0e04-54ad6489f85mr5845323e87.16.1742914280203; Tue, 25 Mar 2025
 07:51:20 -0700 (PDT)
Message-ID: <calendar-85efffed-5b5a-4131-bea5-60b773cb7f89@google.com>
Date: Tue, 25 Mar 2025 14:51:20 +0000
Subject: Updated invitation: U-Boot community meeting @ Tue Apr 1, 2025 9am -
 10am (CST) (u-boot@lists.denx.de)
From: Tom Rini <tom.rini@konsulko.com>
To: u-boot@lists.denx.de, pbiel7@gmail.com, sjg@chromium.org, 
 malysagreg@gmail.com
Content-Type: multipart/mixed; boundary="0000000000008bd18306312bdab2"
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
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

--0000000000008bd18306312bdab2
Content-Type: multipart/alternative; boundary="0000000000008bd18006312bdab0"

--0000000000008bd18006312bdab0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KVS1Cb290IGNv
bW11bml0eSBtZWV0aW5nDQpUdWVzZGF5IEFwciAxLCAyMDI1IOKLhSA5YW0g4oCTIDEwYW0NCkNl
bnRyYWwgU3RhbmRhcmQgVGltZSAtIEJhaMOtYSBkZSBCYW5kZXJhcw0KDQpKb2luIHdpdGggR29v
Z2xlIE1lZXQNCmh0dHBzOi8vbWVldC5nb29nbGUuY29tL2J0ai13Z2NnLWV1dz9ocz0yMjQNCg0K
DQoJDQpKb2luIGJ5IHBob25lDQooVVMpICsxIDIyNC01ODUtNzg2NA0KUElOOiAxMDc3OTk0MDMN
Cg0KTW9yZSBwaG9uZSBudW1iZXJzDQpodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1dz9waW49
MTMwNzUyODU1MjMyMiZocz0wDQoNCg0KVS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQoNCkd1ZXN0
cw0KcGJpZWw3QGdtYWlsLmNvbQ0Kc2pnQGNocm9taXVtLm9yZw0KbWFseXNhZ3JlZ0BnbWFpbC5j
b20NCnUtYm9vdEBsaXN0cy5kZW54LmRlDQpWaWV3IGFsbCBndWVzdCBpbmZvICANCmh0dHBzOi8v
Y2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TjI4ME4y
dGxjWEUzYURWdGJqbGljbk5rY204MlluQTFiREJmTWpBeU5UQXpNalZVTVRVd01EQXdXaUIxTFdK
dmIzUkFiR2x6ZEhNdVpHVnVlQzVrWlEmdG9rPU9UQWpPRGxpWlRkaU9ERXpNVE0yWW1Wak1EWmhP
RE5rWlRSa1lUVTVOelExWmpCaFltUXhNV014WWpnek5qQTJNV0ZsTURaak1XTTNaR0pqWkRFNFpH
WTBNVUJuY205MWNDNWpZV3hsYm1SaGNpNW5iMjluYkdVdVkyOXRZMlV5TVRaa05qWTFZakZoTWpo
aE5XSXhNV016WTJNMFpEUmxOalJpWlRCak56VTFZamc0TkEmY3R6PUFtZXJpY2ElMkZCYWhpYV9C
YW5kZXJhcyZobD1lbiZlcz0wDQoNClJlcGx5IGZvciB1LWJvb3RAbGlzdHMuZGVueC5kZSBhbmQg
dmlldyBtb3JlIGRldGFpbHMgIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFy
L2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1OMjgwTjJ0bGNYRTNhRFZ0YmpsaWNuTmtjbTgyWW5BMWJE
QmZNakF5TlRBek1qVlVNVFV3TURBd1dpQjFMV0p2YjNSQWJHbHpkSE11WkdWdWVDNWtaUSZ0b2s9
T1RBak9EbGlaVGRpT0RFek1UTTJZbVZqTURaaE9ETmtaVFJrWVRVNU56UTFaakJoWW1ReE1XTXhZ
amd6TmpBMk1XRmxNRFpqTVdNM1pHSmpaREU0WkdZME1VQm5jbTkxY0M1allXeGxibVJoY2k1bmIy
OW5iR1V1WTI5dFkyVXlNVFprTmpZMVlqRmhNamhoTldJeE1XTXpZMk0wWkRSbE5qUmlaVEJqTnpV
MVlqZzROQSZjdHo9QW1lcmljYSUyRkJhaGlhX0JhbmRlcmFzJmhsPWVuJmVzPTANCllvdXIgYXR0
ZW5kYW5jZSBpcyBvcHRpb25hbC4NCg0Kfn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENh
bGVuZGFyOiBodHRwczovL2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUg
cmVjZWl2aW5nIHRoaXMgZW1haWwgYmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBl
dmVudC4NCg0KRm9yd2FyZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cgYW55IHJlY2lw
aWVudCB0byBzZW5kIGEgcmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciwgYmUgYWRkZWQgdG8g
dGhlIGd1ZXN0IGxpc3QsIGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0aGVpciBvd24g
aW52aXRhdGlvbiBzdGF0dXMsIG9yIG1vZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJuIG1vcmUgaHR0
cHM6Ly9zdXBwb3J0Lmdvb2dsZS5jb20vY2FsZW5kYXIvYW5zd2VyLzM3MTM1I2ZvcndhcmRpbmcN
Cg==
--0000000000008bd18006312bdab0
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
DTSTART;TZID=America/Bahia_Banderas:20250401T090000
DTEND;TZID=America/Bahia_Banderas:20250401T100000
DTSTAMP:20250325T145120Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:7o47keqq7h5mn9brsdro6bp5l0@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=sjg@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:-368396634
RECURRENCE-ID;TZID=America/Bahia_Banderas:20250325T090000
CLASS:PUBLIC
CREATED:20250114T162827Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20250325T145118Z
LOCATION:
SEQUENCE:2
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--0000000000008bd18006312bdab0--

--0000000000008bd18306312bdab2
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTA0MDFUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTA0MDFUMTAwMDAwDQpEVFNUQU1QOjIwMjUwMzI1
VDE0NTEyMFoNCk9SR0FOSVpFUjtDTj1VLUJvb3Q6bWFpbHRvOjg5YmU3YjgxMzEzNmJlYzA2YTgz
ZGU0ZGE1OTc0NWYwYWJkMTFjMWI4MzYwNjFhZQ0KIDA2YzFjN2RiY2QxOGRmNDFAZ3JvdXAuY2Fs
ZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjdvNDdrZXFxN2g1bW45YnJzZHJvNmJwNWwwQGdvb2dsZS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJpZWw3QGdtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1zamdAY2hyb21pdW0ub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzamdAY2hyb21pdW0u
b3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1hbHlzYWdyZWdAZ21haWwuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzptYWx5c2FncmVnQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj11LWJvb3RAbGlzdHMuZGVueC5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
dS1ib290QGxpc3RzLmRlbnguZGUNClgtR09PR0xFLUNPTkZFUkVOQ0U6aHR0cHM6Ly9tZWV0Lmdv
b2dsZS5jb20vYnRqLXdnY2ctZXV3DQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTM2ODM5
NjYzNA0KUkVDVVJSRU5DRS1JRDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTAzMjVU
MDkwMDAwDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAyNTAxMTRUMTYyODI3Wg0KREVTQ1JJUFRJ
T046VS1Cb290IGNvbW11bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46
fjp+On46fjp+DQogOn46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
On46fjo6LVxuSm9pbiB3aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNv
bS9idGotd2djZy1ldXdcbk9yIGRpYWw6IChVUykgKzEgMjI0LTU4NS03ODY0IFBJTjogDQogMTA3
Nzk5NDAzI1xuTW9yZSBwaG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1
dz9waW49MTMwNzUyODU1DQogMjMyMiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDog
aHR0cHM6Ly9zdXBwb3J0Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5Q
bGVhc2UgZG8gbm90IGVkaXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46
DQogfjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjo6fjp+OjotDQpMQVNULU1PRElGSUVEOjIwMjUwMzI1VDE0NTExOFoNCkxPQ0FUSU9OOg0KU0VR
VUVOQ0U6Mg0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpVLUJvb3QgY29tbXVuaXR5IG1lZXRp
bmcNClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--0000000000008bd18306312bdab2--
