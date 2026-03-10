Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6FAEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695E483FED;
	Tue, 10 Mar 2026 16:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BG+PZT6D";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZ0uu/iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE5B8405F; Tue, 10 Mar 2026 16:12:12 +0100 (CET)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com
 [IPv6:2a00:1450:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0EA83F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x64a.google.com with SMTP id
 a640c23a62f3a-b96d8d60303so235796766b.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773155529; x=1773760329; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zuidmBGJw2U55KqohoSoe5kPv7mzLluxAAJWW1s+aQ0=;
 b=BG+PZT6D1CHu/s3d6NLBY/6MJTcjgUy1GD2oM9xvdCpAiG512aImBY/IZhUAx5R96i
 6jVVvqZAvGSCjEX74mozhqKTIJIsPgOAzpxxiJCB7g6CNUoVz88ANwlkNMMyjVHV7gBE
 zhVuK+qxg2tbr+T7FQ1DwXCDcikMHrVL6mavSWFG2HtuJLCyZNXIwY4Fvc6b9ALcqHbr
 jtrsKTrt/8imW2yOcQGdIl4HH4KIBu51ewjAwk9F9gmQE4JW5vt95P/1dc89p3H/qCWv
 8HPK+pxxo4BFX06FIpn/hToej2om49x7vlcYa5ffxZLVHVMtqTR8Jp0/Bq9JYxgjYcjD
 CXqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773155529; x=1773760329; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zuidmBGJw2U55KqohoSoe5kPv7mzLluxAAJWW1s+aQ0=;
 b=HZ0uu/iGQ5AbWmvZp0HruVSp5J39drQMzkhHQo/1ehi3M6qpZ1AHOj/Tp8WfiICN5q
 X0PGyuApG7OEJxzcX1xcgoFdT+ttOY/ylvdb9JKUin2yOLuY1jMZCWS58DQijUvJ6F9o
 WcugFrPiJBYlfzUouEk2onm7E5mITC4g7oX5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155529; x=1773760329;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zuidmBGJw2U55KqohoSoe5kPv7mzLluxAAJWW1s+aQ0=;
 b=frgGMP+duFcwyZuC1vjHnlHJ/cV49btkAq1ShmlWupdalLlCEp/1kgFvzfO7jsZfHc
 b3oQ7yl5R/+/ckxdLk6gpY6LhA5RddZ7te9ui5t758vJpVaUlprAxnMhFbTCToNkgd23
 6NCenC/GyKC+tEYjI5tVpRukqqvcs54yXAyesBfAWlE7HGdxWBEElH7F/lrOl5BxXHzq
 HmFd00V0RE679hAQt5LmrS3Y7fikLmUyU0mhjMRgJFfN/TewYj5gzyfK5TPakbVKHR3o
 XJEC0tprmmw6nVZ2nTSotuinj9d0m86+TYdK8/BGCmZm62EEnVn/HNvvUT5KGhl1EI0q
 Zq+w==
X-Gm-Message-State: AOJu0YyKmZmGpcWZzxoWPYVs0oMELJoCz6DpWzyxhESr/KAaZl+bFbrq
 ss+qH3NvaA450rqmH2bVEOJNYjR4HDUCWckpDXh3Jg7JPE0E5eteTMr7EO6yk1K6oM92PlETQl5
 r038P/NLUpfkPmwzeyfCtcsxnz/6ekBZaV00aYa6zHwlysF8sjS5c
MIME-Version: 1.0
X-Received: by 2002:a17:907:3c96:b0:b93:6b15:72f6 with SMTP id
 a640c23a62f3a-b942e01b83emr990884066b.40.1773155529474; Tue, 10 Mar 2026
 08:12:09 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-e636ecc0-5bb4-4530-90ab-8db63da878f9@google.com>
Date: Tue, 10 Mar 2026 15:12:09 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 8am
 to 9am on Tuesday from Tue 10 Feb to Mon 9 Mar (MST)
 (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000007754f9064cacf171"
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

--0000000000007754f9064cacf171
Content-Type: multipart/alternative; boundary="0000000000007754f8064cacf16f"

--0000000000007754f8064cacf16f
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 8am to 9am on Tuesday from Tuesday 10 Feb to Monday 9 Mar
Mountain Time - Denver

Join with Google Meet
https://meet.google.com/icv-nvmv-dbf?hs=224


	
Join by phone
(US) +1 475-299-8362
PIN: 439052049

More phone numbers
https://tel.meet/icv-nvmv-dbf?pin=5493171900556&hs=0


U-Boot community meeting

Guests
pbiel7@gmail.com
Simon Glass
malysagreg@gmail.com
korg.sumit@gmail.com
u-boot@lists.denx.de


~~//~~
Invitation from Google Calendar: https://calendar.google.com/calendar/

You are receiving this email because you are an attendee on the event.

Forwarding this invitation could allow any recipient to send a response to  
the organizer, be added to the guest list, invite others regardless of  
their own invitation status, or modify your RSVP.

Learn more https://support.google.com/calendar/answer/37135#forwarding

--0000000000007754f8064cacf16f
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
RRULE:FREQ=WEEKLY;WKST=SU;UNTIL=20260310T055959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20260310T151209Z
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
X-MICROSOFT-CDO-OWNERAPPTID:-1386129860
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
END:VEVENT
END:VCALENDAR

--0000000000007754f8064cacf16f--

--0000000000007754f9064cacf171
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
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAyMTBUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO1VOVElMPTIwMjYwMzEwVDA1NTk1OVo7SU5URVJWQUw9MjtCWURBWT1UVQ0KRFRT
VEFNUDoyMDI2MDMxMFQxNTEyMDlaDQpPUkdBTklaRVI7Q049VS1Cb290Om1haWx0bzo4OWJlN2I4
MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUNCiAwNmMxYzdkYmNkMThk
ZjQxQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20NClVJRDowdjNjNDV1aHZudGNybzRzNWZwNzNi
aGw1OF9SMjAyNjAyMTBUMTUwMDAwQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049cGJpZWw3QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1TaW1vbiBHbGFzcztYLU5VTS1HVUVT
VFM9MDptYWlsdG86c2pnQGNocm9taXVtLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1tYWx5c2FncmVnQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFseXNhZ3JlZ0Bn
bWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a29yZy5zdW1pdEBnbWFpbC5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvcmcuc3VtaXRAZ21haWwuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXUtYm9vdEBsaXN0cy5kZW54LmRlO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzp1LWJvb3RAbGlzdHMuZGVueC5kZQ0KWC1HT09HTEUtQ09ORkVSRU5DRTpodHRwczovL21l
ZXQuZ29vZ2xlLmNvbS9pY3YtbnZtdi1kYmYNClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDot
MTM4NjEyOTg2MA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMjUwMTE0VDE2MjgyN1oNCkRFU0NS
SVBUSU9OOlUtQm9vdCBjb21tdW5pdHkgbWVldGluZ1xuXG4tOjp+On46On46fjp+On46fjp+On46
fjp+On46fjp+On46fg0KIDp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+Ojp+On46Oi1cbkpvaW4gd2l0aCBHb29nbGUgTWVldA0KIDogaHR0cHM6Ly9tZWV0Lmdvb2ds
ZS5jb20vaWN2LW52bXYtZGJmXG5PciBkaWFsOiAoVVMpICsxIDQ3NS0yOTktODM2MiBQSU46IA0K
IDQzOTA1MjA0OSNcbk1vcmUgcGhvbmUgbnVtYmVyczogaHR0cHM6Ly90ZWwubWVldC9pY3YtbnZt
di1kYmY/cGluPTU0OTMxNzE5MA0KIDA1NTYmaHM9N1xuXG5MZWFybiBtb3JlIGFib3V0IE1lZXQg
YXQ6IGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2EvdXNlcnMvYQ0KIG5zd2VyLzkyODI3MjBc
blxuUGxlYXNlIGRvIG5vdCBlZGl0IHRoaXMgc2VjdGlvbi5cbi06On46fjo6fjp+On46fjp+On46
fjp+Og0KIH46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+On46On46fjo6LQ0KTEFTVC1NT0RJRklFRDoyMDI2MDMxMFQxNTEyMDRaDQpMT0NBVElPTjpo
dHRwczovL21lZXQuZ29vZ2xlLmNvbS9pY3YtbnZtdi1kYmYNClNFUVVFTkNFOjUNClNUQVRVUzpD
T05GSVJNRUQNClNVTU1BUlk6VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUUkFOU1A6T1BBUVVF
DQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--0000000000007754f9064cacf171--
