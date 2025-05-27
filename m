Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E465C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F526836C8;
	Tue, 27 May 2025 15:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="1PVSksRU";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T/56r/nR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420D1830B6; Tue, 27 May 2025 15:08:52 +0200 (CEST)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com
 [IPv6:2a00:1450:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50D83086
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x64a.google.com with SMTP id
 a640c23a62f3a-ad5697c4537so277638266b.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1748351329; x=1748956129; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDS0Gi1AWoNnm0+CBA/6/qk1kvUoCzU7RyOHwJkY8qo=;
 b=1PVSksRUz+d4Y0xYnBWCcym+okSJwZ2xSyWHGe0MaI0HyqBLMoo5nsRsER+dhHnxsR
 6TazHP4IUKMF7tyvXYCdsB8J2xcAm2C20ixHyugAtiW5UwX2BeHCGOQOHzgWA7sRauvU
 27zM8NC8KrNWXB8cVPHLYSFwLi6rFBjH/VTRmZzWgdwvUuZ0HSFIoBn1U+0qSbY4nLaf
 4sW/Ue5HRZMvLnwEiHlkiMBGhcBBeLFdwkSFhP99Yjr7WKvYwIQ0822iQCohwfUCc/jj
 2FgNUPFTUDbwD1c/2dPG7g2w3WX+2Upc7xE/OiBiGItHG6azhlPdS2cNNQSY1BEBKnUn
 jFMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748351329; x=1748956129;
 darn=lists.denx.de; 
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDS0Gi1AWoNnm0+CBA/6/qk1kvUoCzU7RyOHwJkY8qo=;
 b=T/56r/nR3taLWKbVmi7h82OqyILxepQrZcb07CGsrMLUfaFQm0Ah0KUxgj3QO3z4i2
 zCG+QHSn380lySIPvzJ7nUWxmE32Uy3rWOQV0Juc/QNow3yFQ/A+NQsfyS6VHnnYQIp2
 +d9Tgl9j/PJ3kc+x2Bi1s8Fdq8WU/70S/y8RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351329; x=1748956129;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDS0Gi1AWoNnm0+CBA/6/qk1kvUoCzU7RyOHwJkY8qo=;
 b=MNe/kXs/ylNF4fWJT4DmD23og8jY8QANF3mbVg2WkwuBIgkbPeDkAOIfYAPuef3AVR
 t2SXYaxfHrMylbQrq5vfPuqAQcJBR0hOlQ58SWjLkgXUeo7tz6Gm94C9m0XC1s7EXO1M
 q3VdKGEe3GBSRbluhwBC3U/6Er42yMsxGjgVn5xkJJVySW9P/YFQ+3WxIuWYxlNK/q39
 X10de+Moa4AEit++AapsO9oaYz+17iw///q0lQsaRHV5Qj4Cd6uucQlDg26xerBE2KFL
 q2VoTk/pJLoOzp0NXZ+5h4oZXyVQGye7sPHYmyXkzID4f+n5Zs2cKIcjPHZf1ezUODOm
 ENGw==
X-Gm-Message-State: AOJu0YzrFYwxUjgKvhXDr9QHYArl0SlW7KnQHf14bRVyaLKX+3XsbW8a
 xYjfCeoqp+Bp4cC90cqNHDNrkJd2oDbyltKgs8y0GqCzS6Nk0+PT7PP6MlUUdi5Du9hCkdxBlUE
 XLS/CRCLzgD7eVR8YsglwxtGacoo+1hXue0f/t+8DUv7OZYegKIuraIRx
X-Google-Smtp-Source: AGHT+IHgM2b4oEj99pry09nvMkGfjP2CVtKKPU6w5tZnKBu97MqYjT44kLlvE09Ai1sjjx3lbeBy1mFqac30auDzLy+Y
MIME-Version: 1.0
X-Received: by 2002:a17:907:3f10:b0:ad5:4998:9f1a with SMTP id
 a640c23a62f3a-ad89886a389mr58993966b.5.1748351328766; Tue, 27 May 2025
 06:08:48 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-441f2e5f-528b-4388-aaa9-3fd7f96d06f3@google.com>
Date: Tue, 27 May 2025 13:08:48 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 4pm
 to 5pm on Tuesday (CET) (u-boot@lists.denx.de)
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000e4ea1906361dc3d7"
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
Reply-To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--000000000000e4ea1906361dc3d7
Content-Type: multipart/alternative; boundary="000000000000e4ea1806361dc3d5"

--000000000000e4ea1806361dc3d5
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 4pm to 5pm on Tuesday
Central European Time - Rome

Join with Google Meet
https://meet.google.com/btj-wgcg-euw?hs=224


	
Join by phone
(US) +1 224-585-7864
PIN: 107799403

More phone numbers
https://tel.meet/btj-wgcg-euw?pin=1307528552322&hs=0


U-Boot community meeting

Organizer
cyrevolt@googlemail.com
cyrevolt@googlemail.com

Guests
cyrevolt@googlemail.com - organizer
malysagreg@gmail.com
u-boot@lists.denx.de
korg.sumit@gmail.com
Michael Nazzareno Trimarchi
sjg@chromium.org
pbiel7@gmail.com
pbrobinson@gmail.com


~~//~~
Invitation from Google Calendar: https://calendar.google.com/calendar/

You are receiving this email because you are an attendee on the event.

Forwarding this invitation could allow any recipient to send a response to  
the organizer, be added to the guest list, invite others regardless of  
their own invitation status, or modify your RSVP.

Learn more https://support.google.com/calendar/answer/37135#forwarding

--000000000000e4ea1806361dc3d5
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
RRULE:FREQ=WEEKLY;WKST=SU;UNTIL=20250603T055959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20250527T130848Z
ORGANIZER;CN=cyrevolt@googlemail.com:mailto:cyrevolt@googlemail.com
UID:213jcf92k24qi5hl3hbgvkqkee@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=cyrevolt@googlemail.com;X-NUM-GUESTS=0:mailto:cyrevolt@googlemail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=korg.sumit@gmail.com;X-NUM-GUESTS=0:mailto:korg.sumit@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Michael Nazzareno Trimarchi;X-NUM-GUESTS=0:mailto:michael@amarulaso
 lutions.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=sjg@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbrobinson@gmail.com;X-NUM-GUESTS=0:mailto:pbrobinson@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:-249330427
CREATED:20250403T010015Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20250527T130845Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
BEGIN:VALARM
ACTION:EMAIL
DESCRIPTION:This is an event reminder
SUMMARY:Alarm notification
ATTENDEE:mailto:u-boot@lists.denx.de
TRIGGER:-P0DT0H10M0S
END:VALARM
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:This is an event reminder
TRIGGER:-P0DT0H30M0S
END:VALARM
END:VEVENT
END:VCALENDAR

--000000000000e4ea1806361dc3d5--

--000000000000e4ea1906361dc3d7
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
WTtXS1NUPVNVO1VOVElMPTIwMjUwNjAzVDA1NTk1OVo7SU5URVJWQUw9MjtCWURBWT1UVQ0KRFRT
VEFNUDoyMDI1MDUyN1QxMzA4NDhaDQpPUkdBTklaRVI7Q049Y3lyZXZvbHRAZ29vZ2xlbWFpbC5j
b206bWFpbHRvOmN5cmV2b2x0QGdvb2dsZW1haWwuY29tDQpVSUQ6MjEzamNmOTJrMjRxaTVobDNo
Ymd2a3FrZWVAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYWx5c2Fn
cmVnQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFseXNhZ3JlZ0BnbWFpbC5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtDTj1jeXJldm9sdEBnb29nbGVtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86Y3lyZXZvbHRAZ29vZ2xlbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049dS1ib290QGxpc3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUt
Ym9vdEBsaXN0cy5kZW54LmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvcmcuc3Vt
aXRAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzprb3JnLnN1bWl0QGdtYWlsLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NaWNoYWVsIE5henphcmVubyBUcmltYXJjaGk7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1pY2hhZWxAYW1hcnVsYXNvDQogbHV0aW9ucy5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c2pnQGNocm9taXVtLm9yZztYLU5VTS1HVUVTVFM9
MDptYWlsdG86c2pnQGNocm9taXVtLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7UlNWUD1UUlVFDQogO0NOPXBiaWVs
N0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBiaWVsN0BnbWFpbC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJyb2JpbnNvbkBnbWFpbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnBicm9iaW5zb25AZ21haWwuY29tDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBz
Oi8vbWVldC5nb29nbGUuY29tL2J0ai13Z2NnLWV1dw0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQ
VElEOi0yNDkzMzA0MjcNCkNSRUFURUQ6MjAyNTA0MDNUMDEwMDE1Wg0KREVTQ1JJUFRJT046VS1C
b290IGNvbW11bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46fjp+On46
fjp+DQogOn46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6
LVxuSm9pbiB3aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGot
d2djZy1ldXdcbk9yIGRpYWw6IChVUykgKzEgMjI0LTU4NS03ODY0IFBJTjogDQogMTA3Nzk5NDAz
I1xuTW9yZSBwaG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1dz9waW49
MTMwNzUyODU1DQogMjMyMiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDogaHR0cHM6
Ly9zdXBwb3J0Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5QbGVhc2Ug
ZG8gbm90IGVkaXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46DQogfjp+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+
OjotDQpMQVNULU1PRElGSUVEOjIwMjUwNTI3VDEzMDg0NVoNCkxPQ0FUSU9OOg0KU0VRVUVOQ0U6
MA0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClRS
QU5TUDpPUEFRVUUNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkVNQUlMDQpERVNDUklQVElPTjpUaGlz
IGlzIGFuIGV2ZW50IHJlbWluZGVyDQpTVU1NQVJZOkFsYXJtIG5vdGlmaWNhdGlvbg0KQVRURU5E
RUU6bWFpbHRvOnUtYm9vdEBsaXN0cy5kZW54LmRlDQpUUklHR0VSOi1QMERUMEgxME0wUw0KRU5E
OlZBTEFSTQ0KQkVHSU46VkFMQVJNDQpBQ1RJT046RElTUExBWQ0KREVTQ1JJUFRJT046VGhpcyBp
cyBhbiBldmVudCByZW1pbmRlcg0KVFJJR0dFUjotUDBEVDBIMzBNMFMNCkVORDpWQUxBUk0NCkVO
RDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000e4ea1906361dc3d7--
