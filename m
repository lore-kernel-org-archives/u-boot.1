Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632F3E6B26B
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 02:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795CD83E83;
	Tue, 23 Dec 2025 03:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Tdj8kUDb";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OVJPJ2Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCF883FD4; Tue, 23 Dec 2025 03:04:51 +0100 (CET)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com
 [IPv6:2a00:1450:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9A083E83
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-b80716085a0so186374266b.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766455488; x=1767060288; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oRLLh27C9weHv4zAl0x3OeiJReV+rgjAVytUcGEgZoI=;
 b=Tdj8kUDbrGdXCdGZ6Ejd9keaQirPKYPB15SFAb5y/fop85JLKf/ZvIS5V/8fjJBBDE
 FQRNiT8vB+aPvCdKT7U4oFfVgPZhpcSckHK06i1pgrEfk37yQtzfohvV1GAYwGGwc9HJ
 S985eTyKtgY9GpfYnbjhJ9cSATlSw1m4ZLCcEhmQpbI3nXHjtlGNzzjf4+gADFt8jJXw
 IUxaQa8O60HfrdadJrk4koXb6OuUsfppdnmeS4T2eNX3sv1lGWCrsREaYb6LVtKl+4Xz
 EiVnfW5HXhjcC1osyl+nGjlGLB7y5xWZRxRz2DeDsE0hVW5p36PGKy6tv5oXoqI7DNnZ
 jY0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766455488; x=1767060288; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oRLLh27C9weHv4zAl0x3OeiJReV+rgjAVytUcGEgZoI=;
 b=OVJPJ2Udes0NC6SfP3HZyS0FSNg3irrw8gpq63ssbOZJV+LGK8DIfZNjDjL6kkSYAA
 6KHNuCNsNLHvFzJ7go8i8vJ6R2YGkiMZs+1f+A3WY9NG5OUc1CNCRP4OMl3jrVWRUVZr
 YX7NFiv77ZgW7Vv/ePb34v97XX9plln3RUdbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455488; x=1767060288;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRLLh27C9weHv4zAl0x3OeiJReV+rgjAVytUcGEgZoI=;
 b=gi8fR7U5P/sOMzqvMhTey0r0MKOhJNd/fKcxquvvtfYMi9BEbh3H0JzwueMN5/9FXm
 UZd88p5LLBlquBX7+1YiqrtVMlFdbaRCszr97YDCLf8ysmkWafecorTWfJxlXbwjVzuB
 tgqlBkADVUB8BUmqohR2afEYt0xJ1tpMLRUO07DaTVa1xXBjQDqURnTdirvUTvbU4/lq
 qL/qELtAnEVZnGFTcqXqNrWGgSZugnm/gpA0+ARRtOhsh9OrXqHYhVcsPX2s/B3M65Ml
 ulv8Gvu+NSq/T8mlBjltKPWYc81tZUNnbo6+uMdpIJOxO6us+hr6ykAa6Ke7TQ4I1QNq
 PgBg==
X-Gm-Message-State: AOJu0YwIrUyg702nsGq4e8+IIYro3YdcOlq1PhuskNBD2koODJ6fOwGA
 cCFqLDdLoVUkZFlB0QzyeHbOjT22KFk+DPk74fMqVqBoAp4MRCsc2vzooo1mXbRJF0G6ANQ6yh7
 s5dd3k8w8h/9OvcvOJmNrlDnMiVJXBRZb2qpI3Wl+tMWmLeMW22QK
X-Google-Smtp-Source: AGHT+IHnmIaPGXFqJEOQyBugT+0j89vNlA1rZkstoZ1wv3R4BRrKNaYPhojuFRSwjvBjHoZ67yUuANpQTB0F0dngS7dy
MIME-Version: 1.0
X-Received: by 2002:a17:907:2d25:b0:b73:39c3:b4f with SMTP id
 a640c23a62f3a-b80371d6c4cmr1469434266b.50.1766455488142; Mon, 22 Dec 2025
 18:04:48 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-7decca5d-c11a-4819-bbc9-2943036d9c94@google.com>
Date: Tue, 23 Dec 2025 02:04:48 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 8am
 to 9am on Tuesday (MST) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000e1ee03064694f7dd"
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

--000000000000e1ee03064694f7dd
Content-Type: multipart/alternative; boundary="000000000000e1ee03064694f7db"

--000000000000e1ee03064694f7db
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 8am to 9am on Tuesday
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

--000000000000e1ee03064694f7db
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
DTSTART;TZID=America/Bahia_Banderas:20251223T090000
DTEND;TZID=America/Bahia_Banderas:20251223T100000
RRULE:FREQ=WEEKLY;WKST=SU;INTERVAL=2;BYDAY=TU
DTSTAMP:20251223T020448Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:dcl58vad6a0tj03etdt5av1n6j_R20251223T150000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=DELETED;RSVP=TRUE;
 CN=Simon Glass;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:-1550311364
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

--000000000000e1ee03064694f7db--

--000000000000e1ee03064694f7dd
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEyMjNUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTEyMjNUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNTEyMjNUMDIwNDQ4Wg0K
T1JHQU5JWkVSO0NOPVUtQm9vdDptYWlsdG86ODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1
ZjBhYmQxMWMxYjgzNjA2MWFlDQogMDZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5nb29n
bGUuY29tDQpVSUQ6ZGNsNTh2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfUjIwMjUxMjIzVDE1MDAwMEBn
b29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXUtYm9vdEBsaXN0cy5kZW54
LmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp1LWJvb3RAbGlzdHMuZGVueC5kZQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1wYmllbDdAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpwYmllbDdAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ERUxFVEVEO1JTVlA9VFJVRTsNCiBDTj1TaW1vbiBHbGFzcztY
LU5VTS1HVUVTVFM9MDptYWlsdG86c2pnQGNocm9taXVtLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1tYWx5c2FncmVnQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFs
eXNhZ3JlZ0BnbWFpbC5jb20NClgtR09PR0xFLUNPTkZFUkVOQ0U6aHR0cHM6Ly9tZWV0Lmdvb2ds
ZS5jb20vYnRqLXdnY2ctZXV3DQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTE1NTAzMTEz
NjQNCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDI1MDExNFQxNjI4MjdaDQpERVNDUklQVElPTjpV
LUJvb3QgY29tbXVuaXR5IG1lZXRpbmdcblxuLTo6fjp+Ojp+On46fjp+On46fjp+On46fjp+On46
fjp+On4NCiA6fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+
OjotXG5Kb2luIHdpdGggR29vZ2xlIE1lZXQNCiA6IGh0dHBzOi8vbWVldC5nb29nbGUuY29tL2J0
ai13Z2NnLWV1d1xuT3IgZGlhbDogKFVTKSArMSAyMjQtNTg1LTc4NjQgUElOOiANCiAxMDc3OTk0
MDMjXG5Nb3JlIHBob25lIG51bWJlcnM6IGh0dHBzOi8vdGVsLm1lZXQvYnRqLXdnY2ctZXV3P3Bp
bj0xMzA3NTI4NTUNCiAyMzIyJmhzPTdcblxuTGVhcm4gbW9yZSBhYm91dCBNZWV0IGF0OiBodHRw
czovL3N1cHBvcnQuZ29vZ2xlLmNvbS9hL3VzZXJzL2ENCiBuc3dlci85MjgyNzIwXG5cblBsZWFz
ZSBkbyBub3QgZWRpdCB0aGlzIHNlY3Rpb24uXG4tOjp+On46On46fjp+On46fjp+On46fjoNCiB+
On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+
On46Oi0NCkxBU1QtTU9ESUZJRUQ6MjAyNTEyMjNUMDIwNDQzWg0KTE9DQVRJT046aHR0cHM6Ly9t
ZWV0Lmdvb2dsZS5jb20vYnRqLXdnY2ctZXV3DQpTRVFVRU5DRTo0DQpTVEFUVVM6Q09ORklSTUVE
DQpTVU1NQVJZOlUtQm9vdCBjb21tdW5pdHkgbWVldGluZw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZF
VkVOVA0KRU5EOlZDQUxFTkRBUg0K
--000000000000e1ee03064694f7dd--
