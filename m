Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB56EE6B26D
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 02:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C489484042;
	Tue, 23 Dec 2025 03:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ls5dtL3Z";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ORfQx14H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E8883E83; Tue, 23 Dec 2025 03:04:51 +0100 (CET)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com
 [IPv6:2a00:1450:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFD483E70
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-64b7907dd42so5213808a12.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766455488; x=1767060288; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wf+en0yz3uAEKt2WD4loHrr4o4LUlFsp/TicRDz4Ibo=;
 b=ls5dtL3Zz87wgThJ/4K27Ei2JQTEF2EOL3STIAmFE3lpVHdQK5BRhAxg3f0hICasUH
 S3tN4n9+QXqEns0A02MzK3li/o3JBeDbd/G0UPD01neEnGJufez1QfaHNmE0e9O3OmIB
 efWEqjh2J8P83Sg658G3tpU2Ib3Zv5UwM4/IyagPDDfdKY1vxbzgTcR9OKSXVR0iNn8r
 6GBvFhJQ59s3ZVPa3i9z7NF7RxzB8j9Kq/3wgv7wBcjUn15mPAHm0xZw8BqJhcygW6FC
 OwVip8z3L12AtSu9iGtth6HJbXPhjZdfCm7L6HFsNN03Hsps2QXYTsckAryksgs2wMIO
 jZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766455488; x=1767060288; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wf+en0yz3uAEKt2WD4loHrr4o4LUlFsp/TicRDz4Ibo=;
 b=ORfQx14Hk6CM7z3cFzX5B0zNniDXy7mVze/fRh2S+wQ4Os7d+KWqEB++1RoMrfb0Md
 oG04e9fYRubU/uUmhm3sOGM6wDkzLyLNs8YLol6wjMHlpdU9yBXknWuY1Q5MQXkh07jW
 L2MbR65uxwAzbKpgECDF4kJCE7YEqDshAC9JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455488; x=1767060288;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wf+en0yz3uAEKt2WD4loHrr4o4LUlFsp/TicRDz4Ibo=;
 b=dXVTBF7gWB/Haw1KveyRVJpaHz0TU/5WYqmWFkG/QfiAT2adfV8ZpC099bwAU+OBdL
 G8QFcpttzuZfiLIb7jaf73nQWvye1v8QTSZAVdW7QCz0yM9imxqPSW+o1fuzEDygxsa2
 UNdT9csGU/QsiSEtFU2M/wRhNRo4g9SF6YeStMdGUsRVIKMYbAbG+V7+3xuKwycknsjL
 UVsMQ4kNZQTCGBSBFkyAbNfC0sH45v2EEospgfoUsnDL2AFisPQ6qET28w/VX0QIOCN3
 lG15fdDMpZgbgiMSjs+ZJ0MJijFFLhZwul/qk5KMv95m3+M9oVmBUgVxZba1H+OPoQbt
 KsDg==
X-Gm-Message-State: AOJu0Yydy8XdXXl2KxqTBfw/DP4ZbeS7BtKq08T6KKm2D9ZfSaxFBu5A
 iHkjQpBrTFJMru98tw4of+fRcDfhThaplbyfYcMLuXxx1oVvHoVP+YRNG2nKYbEa/7t8GSJ2usu
 DEru1tIkvSgfWPf1vOAdllNNA7SwVqCZZVi8/or9RxOEL2hYgBoCp
X-Google-Smtp-Source: AGHT+IEnP5TgcNppCktNTiXoMCFso/uYcRnjG4gzXWnvGnEcKKZGvC9uxRddAiS+o3TpKnqAFZi8aLaUvqi0GZnNBAry
MIME-Version: 1.0
X-Received: by 2002:a05:6402:5245:b0:640:e75a:f95d with SMTP id
 4fb4d7f45d1cf-64b8ea4d9c2mr14311969a12.15.1766455488038; Mon, 22 Dec 2025
 18:04:48 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-23d8fa16-4aa7-4396-8dd1-55e040cc49e0@google.com>
Date: Tue, 23 Dec 2025 02:04:48 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 9am
 to 10am on Tuesday (MDT) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000e053c2064694f791"
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

--000000000000e053c2064694f791
Content-Type: multipart/alternative; boundary="000000000000e053c1064694f78f"

--000000000000e053c1064694f78f
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 9am to 10am on Tuesday
Mountain Time - Denver

Join with Google Meet
https://meet.google.com/btj-wgcg-euw?hs=224


	
Join by phone
(US) +1 224-585-7864
PIN: 107799403

More phone numbers
https://tel.meet/btj-wgcg-euw?pin=1307528552322&hs=0


U-Boot community meeting

Guests
u-boot@lists.denx.de
pbiel7@gmail.com
Simon Glass
malysagreg@gmail.com


~~//~~
Invitation from Google Calendar: https://calendar.google.com/calendar/

You are receiving this email because you are an attendee on the event.

Forwarding this invitation could allow any recipient to send a response to  
the organizer, be added to the guest list, invite others regardless of  
their own invitation status, or modify your RSVP.

Learn more https://support.google.com/calendar/answer/37135#forwarding

--000000000000e053c1064694f78f
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
DTSTART;TZID=America/Bahia_Banderas:20251028T090000
DTEND;TZID=America/Bahia_Banderas:20251028T100000
RRULE:FREQ=WEEKLY;WKST=SU;UNTIL=20251223T055959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20251223T020448Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:dcl58vad6a0tj03etdt5av1n6j@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Simon Glass;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:-2001415355
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
END:VEVENT
END:VCALENDAR

--000000000000e053c1064694f78f--

--000000000000e053c2064694f791
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEwMjhUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEwMjhUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO1VOVElMPTIwMjUxMjIzVDA1NTk1OVo7SU5URVJWQUw9MjtCWURBWT1UVQ0KRFRT
VEFNUDoyMDI1MTIyM1QwMjA0NDhaDQpPUkdBTklaRVI7Q049VS1Cb290Om1haWx0bzo4OWJlN2I4
MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUNCiAwNmMxYzdkYmNkMThk
ZjQxQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20NClVJRDpkY2w1OHZhZDZhMHRqMDNldGR0NWF2
MW42akBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXUtYm9vdEBsaXN0
cy5kZW54LmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp1LWJvb3RAbGlzdHMuZGVueC5kZQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1wYmllbDdAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpwYmllbDdAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVNp
bW9uIEdsYXNzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzamdAY2hyb21pdW0ub3JnDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPW1hbHlzYWdyZWdAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzptYWx5c2FncmVnQGdtYWlsLmNvbQ0KWC1HT09HTEUtQ09ORkVSRU5DRTpodHRwczov
L21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXcNClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJ
RDotMjAwMTQxNTM1NQ0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMjUwMTE0VDE2MjgyN1oNCkRF
U0NSSVBUSU9OOlUtQm9vdCBjb21tdW5pdHkgbWVldGluZ1xuXG4tOjp+On46On46fjp+On46fjp+
On46fjp+On46fjp+On46fg0KIDp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+Ojp+On46Oi1cbkpvaW4gd2l0aCBHb29nbGUgTWVldA0KIDogaHR0cHM6Ly9tZWV0Lmdv
b2dsZS5jb20vYnRqLXdnY2ctZXV3XG5PciBkaWFsOiAoVVMpICsxIDIyNC01ODUtNzg2NCBQSU46
IA0KIDEwNzc5OTQwMyNcbk1vcmUgcGhvbmUgbnVtYmVyczogaHR0cHM6Ly90ZWwubWVldC9idGot
d2djZy1ldXc/cGluPTEzMDc1Mjg1NQ0KIDIzMjImaHM9N1xuXG5MZWFybiBtb3JlIGFib3V0IE1l
ZXQgYXQ6IGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2EvdXNlcnMvYQ0KIG5zd2VyLzkyODI3
MjBcblxuUGxlYXNlIGRvIG5vdCBlZGl0IHRoaXMgc2VjdGlvbi5cbi06On46fjo6fjp+On46fjp+
On46fjp+Og0KIH46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+
On46fjp+On46On46fjo6LQ0KTEFTVC1NT0RJRklFRDoyMDI1MTIyM1QwMjA0NDNaDQpMT0NBVElP
TjpodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXcNClNFUVVFTkNFOjQNClNUQVRV
UzpDT05GSVJNRUQNClNVTU1BUlk6VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUUkFOU1A6T1BB
UVVFDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--000000000000e053c2064694f791--
