Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BFFC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 20:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C73D80C8F;
	Tue, 18 Feb 2025 21:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ydx3ztjO";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kF+pNqok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1002780C98; Tue, 18 Feb 2025 21:57:46 +0100 (CET)
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B89C80BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 21:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-oo1-xc49.google.com with SMTP id
 006d021491bc7-5fcf0ef267cso367660eaf.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 12:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739912262; x=1740517062; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KPywN4iiu0Ll9dXnQ1rZz437Ke3VdIO/YCgWEyGwAHk=;
 b=Ydx3ztjO0BGMnnCKJGl0B9WKV9G0LjGFpMkUsTFCTDU2JTQwaJq8/ARe78VxyOFl7W
 XsNLryQ9Pp0yGb9Czg+2kUaNQetd5EInbtsiUNeVRjMQ+epMhl16XnKaYaeZU6BzFQDL
 FhKD4Nj7TfV8rxXY6HVPWdNMpVCg9zs+LRLcli7dS/D5qnSyoAGhH+nQW61PHdawr+0q
 ATQdMEYoWGFcdC2CnQaWGCdaDHDeYb2hJgL/A2i4FenHAfM8vDRhaKpTBJZdW2FlEs+R
 g+kYQ8mCrQDzPZ1nxCZlzHZJznuO8iFlmhyJY9LDo1PX/NoXaE0PD5QpfYrFf5nwaNk5
 b7Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739912262; x=1740517062; darn=lists.denx.de;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KPywN4iiu0Ll9dXnQ1rZz437Ke3VdIO/YCgWEyGwAHk=;
 b=kF+pNqoki9erNgU3oMkbjBic/J8XuuM2WMTz8H41mCA53V+H4K5AFPWNqREGsFvWp8
 6d1cgFSVaA6DrEJeG08R7IZQamUSiRTvaAdhdAmvnVumtkSUMOWnGnUs0uX9uA/jXHt8
 J2aM97HbcsPiol7qoLis/Q7SD0v3kZeeoQ3uKidL2J+S/W3sx3f5BGdvHp1Os32lgvIv
 2cRoUz9uT+YuIgjak9kUa2ntAanLYsv5F3QuTUTvQ/++rEVzL921LqpYoncQvBWU3AVy
 IMSS+47tNGiq3bjx2AZxxEse63Njnh23XV1fgBbZ1yu5o91F6otimNkY1RhwtuESwU3o
 qtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739912262; x=1740517062;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPywN4iiu0Ll9dXnQ1rZz437Ke3VdIO/YCgWEyGwAHk=;
 b=ouA1ZoMPehYXuZ5WzTs1Uq9KfIdtl76Yd2Yv4kNIeokM6F8DxDNjKM2yUbviO+/Veq
 rR9oCmUl722y5Z6QvezlRUIGSTVxGD9YUxYKMRA246bUUOGljb4+JX0aCjSw+BLJvVCd
 3gt6a6r69MGdtuzHZEBWaPjOrjjr+GSpUHJMlMG/5N0LryjvuqT/xyp93XfVAM51KL0K
 f/49YBZ8xJO0PfnJGAzg0qI6uEpNrahc4w1N5IPsEYF3lJNfXGphhWENTEPjxMP8hAip
 Y4M7z326E3jLRBme92wRjFhsaAvJuZgU3TyXKTcWx5PhAmA+xPjdbtR4eQiOiMX3o3Sa
 lJvQ==
X-Gm-Message-State: AOJu0Ywq6L/Wa0CaAUA4f8i+ciNzmVuuSYlAfXb/TO1yBGx+O8qV2jEO
 Bc35KO06kLn3fWN3GjZR2NhWg727LO7eYKiy21UILP47O7Dlo96HpOEZF6BeO2e9YyBySuT4wfV
 bVvX/ybjreKFE/E4RQC3JhLHdea++gfE=
X-Google-Smtp-Source: AGHT+IH4V9oXmw/BiKNmXZgc+KM5C0x1k5zrPL/a9V56Gu1X9lm26sPm08HDjbb3hUE9f/UuxlYhMzUsZ6Qvwl2lcwAZ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:2181:b0:29e:4c37:b471 with SMTP id
 586e51a60fabf-2bc99cf6d5fmr9828977fac.30.1739912261995; Tue, 18 Feb 2025
 12:57:41 -0800 (PST)
Message-ID: <calendar-d7a979c8-05b0-425f-bd66-e04e5e4fa7d1@google.com>
Date: Tue, 18 Feb 2025 20:57:41 +0000
Subject: Invitation: U-Boot community meeting @ Every 2 weeks from 10am to
 11am on Tuesday (EST) (u-boot@lists.denx.de)
From: Jesse T <mr.bossman075@gmail.com>
To: u-boot@lists.denx.de, malysagreg@gmail.com, sjg@chromium.org, 
 pbiel7@gmail.com
Content-Type: multipart/mixed; boundary="000000000000511c50062e70e4fe"
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
Reply-To: Jesse T <mr.bossman075@gmail.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--000000000000511c50062e70e4fe
Content-Type: multipart/alternative; boundary="000000000000511c4e062e70e4fc"

--000000000000511c4e062e70e4fc
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

U-Boot community meeting
Every 2 weeks from 10am to 11am on Tuesday
Eastern Time - New York

Join with Google Meet
https://meet.google.com/btj-wgcg-euw?hs=224


	
Join by phone
(US) +1 224-585-7864
PIN: 107799403

More phone numbers
https://tel.meet/btj-wgcg-euw?pin=1307528552322&hs=0


U-Boot community meeting

Organizer
Jesse T
mr.bossman075@gmail.com

Guests
Jesse T - organizer
malysagreg@gmail.com
u-boot@lists.denx.de
sjg@chromium.org
pbiel7@gmail.com
View all guest info  
https://calendar.google.com/calendar/event?action=VIEW&eid=MDFtcXVvZWRqa21nYmZxOG00cW42bzY4dGMgdS1ib290QGxpc3RzLmRlbnguZGU&tok=MjMjbXIuYm9zc21hbjA3NUBnbWFpbC5jb204OTE4NjZkYWM2YzgyMTRlZDc5OTVjYmE2NzQ1MWVjNjhiODM0ZTk4&ctz=America%2FNew_York&hl=en&es=0

Reply for u-boot@lists.denx.de and view more details  
https://calendar.google.com/calendar/event?action=VIEW&eid=MDFtcXVvZWRqa21nYmZxOG00cW42bzY4dGMgdS1ib290QGxpc3RzLmRlbnguZGU&tok=MjMjbXIuYm9zc21hbjA3NUBnbWFpbC5jb204OTE4NjZkYWM2YzgyMTRlZDc5OTVjYmE2NzQ1MWVjNjhiODM0ZTk4&ctz=America%2FNew_York&hl=en&es=0
Your attendance is optional.

~~//~~
Invitation from Google Calendar: https://calendar.google.com/calendar/

You are receiving this email because you are an attendee on the event.

Forwarding this invitation could allow any recipient to send a response to  
the organizer, be added to the guest list, invite others regardless of  
their own invitation status, or modify your RSVP.

Learn more https://support.google.com/calendar/answer/37135#forwarding

--000000000000511c4e062e70e4fc
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
DTSTAMP:20250218T205741Z
ORGANIZER;CN=Jesse T:mailto:mr.bossman075@gmail.com
UID:01mquoedjkmgbfq8m4qn6o68tc@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=sjg@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=Jesse T;X-NUM-GUESTS=0:mailto:mr.bossman075@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:-126214536
CREATED:20250218T205738Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20250218T205738Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:This is an event reminder
TRIGGER:-P0DT0H30M0S
END:VALARM
END:VEVENT
END:VCALENDAR

--000000000000511c4e062e70e4fc--

--000000000000511c50062e70e4fe
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
WTtXS1NUPVNVO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNTAyMThUMjA1NzQxWg0K
T1JHQU5JWkVSO0NOPUplc3NlIFQ6bWFpbHRvOm1yLmJvc3NtYW4wNzVAZ21haWwuY29tDQpVSUQ6
MDFtcXVvZWRqa21nYmZxOG00cW42bzY4dGNAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1tYWx5c2FncmVnQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFs
eXNhZ3JlZ0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049dS1ib290QGxp
c3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9vdEBsaXN0cy5kZW54LmRlDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXNqZ0BjaHJvbWl1bS5vcmc7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnNqZ0BjaHJvbWl1bS5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
cGJpZWw3QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWlsLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
QUNDRVBURUQ7UlNWUD1UUlVFDQogO0NOPUplc3NlIFQ7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1y
LmJvc3NtYW4wNzVAZ21haWwuY29tDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8vbWVldC5n
b29nbGUuY29tL2J0ai13Z2NnLWV1dw0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi0xMjYy
MTQ1MzYNCkNSRUFURUQ6MjAyNTAyMThUMjA1NzM4Wg0KREVTQ1JJUFRJT046VS1Cb290IGNvbW11
bml0eSBtZWV0aW5nXG5cbi06On46fjo6fjp+On46fjp+On46fjp+On46fjp+On46fjp+DQogOn46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6LVxuSm9pbiB3
aXRoIEdvb2dsZSBNZWV0DQogOiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS9idGotd2djZy1ldXdc
bk9yIGRpYWw6IChVUykgKzEgMjI0LTU4NS03ODY0IFBJTjogDQogMTA3Nzk5NDAzI1xuTW9yZSBw
aG9uZSBudW1iZXJzOiBodHRwczovL3RlbC5tZWV0L2J0ai13Z2NnLWV1dz9waW49MTMwNzUyODU1
DQogMjMyMiZocz03XG5cbkxlYXJuIG1vcmUgYWJvdXQgTWVldCBhdDogaHR0cHM6Ly9zdXBwb3J0
Lmdvb2dsZS5jb20vYS91c2Vycy9hDQogbnN3ZXIvOTI4MjcyMFxuXG5QbGVhc2UgZG8gbm90IGVk
aXQgdGhpcyBzZWN0aW9uLlxuLTo6fjp+Ojp+On46fjp+On46fjp+On46DQogfjp+On46fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+OjotDQpMQVNU
LU1PRElGSUVEOjIwMjUwMjE4VDIwNTczOFoNCkxPQ0FUSU9OOg0KU0VRVUVOQ0U6MA0KU1RBVFVT
OkNPTkZJUk1FRA0KU1VNTUFSWTpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmcNClRSQU5TUDpPUEFR
VUUNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkRJU1BMQVkNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4g
ZXZlbnQgcmVtaW5kZXINClRSSUdHRVI6LVAwRFQwSDMwTTBTDQpFTkQ6VkFMQVJNDQpFTkQ6VkVW
RU5UDQpFTkQ6VkNBTEVOREFSDQo=
--000000000000511c50062e70e4fe--
