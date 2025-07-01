Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD10C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D80382FAB;
	Tue,  1 Jul 2025 17:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RugiVwMf";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMOUGDDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B76482FC7; Tue,  1 Jul 2025 17:02:13 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F77A82F71
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 17:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-234f1acc707so26299025ad.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751382128; x=1751986928; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22MV4M7Upo8OvpIKWU1FSVdjcbMRX09ZueXyVie5rD4=;
 b=RugiVwMfS0A4xulSwlO0JJJSgGCviuTmZpiQrVK2klgUbjjO1MaEkE7xWndPjvcpMT
 UJnaZwipQvE5ozFTyMR07+O/2yk/c3kMcK+IAwe54eItpCHS02BSeRlaPBwmuAsnE6PF
 Ak05b+qz18agHXotY37ogBk/a4S8FzR/xVHfcvYtiYdypFZKXFy3ZxQ/YFaF3hTGSeoZ
 Y7mlIGCtmJ30+DDMsI+200vx+x1yQc92TXmpE5SPtWFNYLlnJdQ/SRSBvpz3qCVuyyKm
 aay4bwoKS/BnwVkTqcCagvFAqWstRqJypbz/B07Ot19bTULjLjuDyI3NUzr2zRYCaZIh
 L7vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751382128; x=1751986928; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22MV4M7Upo8OvpIKWU1FSVdjcbMRX09ZueXyVie5rD4=;
 b=dMOUGDDRZsf24T19SCOvZNo2fvaRsyvAv1QGM0poanmYyqsomU59buSzC6PvHEBmEN
 vYyLQoZQchyf8P726J/vXFGw48f2VNnnwGFkK79heax31ZQfy7sm2S9smWzZOe0iOgxE
 e5781TdOXKFD62Q9XUk8Y9syg/tPDJmyEiwUNGOaawW4xAbU3ZAjK6YmGUemZ+3h3af/
 zb7Cyd1KqRP/jblOblITmJrlCrcg1TeaHljfKq9QliLwJKyB7FmJcKpgCvI6T6Yy6hqT
 28qTZTDol0u+iiPr9e3xR0ErMWbhaknCYYBSNgj9uaEqofbr4xpaz0pDOA4GxI+wrcod
 deDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751382128; x=1751986928;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22MV4M7Upo8OvpIKWU1FSVdjcbMRX09ZueXyVie5rD4=;
 b=U4htv6i6w9yEbZ27ijAPFitgXTyIKR7R3/9fBK8/iNJ9TS2ry3dyQPQKXdpLYHU8MA
 pyuUvLpaY1z4br0txcy1Pbktz+BswIKdv5IaHP6v/04tfVm9zAGM9jSJcD/PKhv81xgp
 9s3FM++l6WFIYCKWBxTImG5RKv1H3lLZTm/pSvBPyS96R5/vMiwW5DI9OrQDrHU6bc0q
 Ok4cLJ0w/jg4SmvfiawpInfUS4QwQ6Xe2fNrs4brvrSdoA/vmuXG6lTTugfQQqgDupdL
 InNTmegk3Ss7Cb2LBJJkOsmWIKTQDeLWnCbK5cSRGgwgpzX3KWSwBJlwZaOru/QsE1lK
 /8yQ==
X-Gm-Message-State: AOJu0Yx1lfwSVGlDuB+X6At9B7/epDRs7wRkMXToz3Y15FzZfqTWXuJl
 ywz1XJSD7+jpR00keKkkSSc/btN0MIjkUCD90+l1Kgm9KIvsepq9Qd903LCRixVP1xuqMpBiZ1S
 XZqgfBaWDi8nKqTx2V23fd4IfAMRL9X/7GkU=
X-Google-Smtp-Source: AGHT+IF8VhKNoZw3OgnrFE6GfKNN7/r0yqLtkrgX7hZJIQJGP0j2jyPb+qBPKnShF4aZGXY2cfV3CJoGlv7+K8PRByRV
MIME-Version: 1.0
X-Received: by 2002:a05:6122:2090:b0:52a:79fd:34bd with SMTP id
 71dfb90a1353d-5330bebe036mr12522419e0c.4.1751382117550; Tue, 01 Jul 2025
 08:01:57 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-c86b70ad-cf54-42c4-ad42-f8e42e152e68@google.com>
Date: Tue, 01 Jul 2025 15:01:57 +0000
Subject: Canceled event: U-Boot community meeting @ Every 2 weeks from 10am to
 11am on Tuesday (EST) (u-boot@lists.denx.de)
From: Jesse T <mr.bossman075@gmail.com>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000fb9c890638df6c6c"
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

--000000000000fb9c890638df6c6c
Content-Type: multipart/alternative; boundary="000000000000fb9c870638df6c6a"

--000000000000fb9c870638df6c6a
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This event has been canceled.

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


~~//~~
Invitation from Google Calendar: https://calendar.google.com/calendar/

You are receiving this email because you are an attendee on the event.

Forwarding this invitation could allow any recipient to send a response to  
the organizer, be added to the guest list, invite others regardless of  
their own invitation status, or modify your RSVP.

Learn more https://support.google.com/calendar/answer/37135#forwarding

--000000000000fb9c870638df6c6a
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
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
DTSTAMP:20250701T150157Z
ORGANIZER;CN=Jesse T:mailto:mr.bossman075@gmail.com
UID:01mquoedjkmgbfq8m4qn6o68tc@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ma
 lysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=u-
 boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=sj
 g@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=pb
 iel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;CN=Jesse 
 T;X-NUM-GUESTS=0:mailto:mr.bossman075@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
CREATED:20250218T205738Z
DESCRIPTION:U-Boot community meeting\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~
 :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nJoin with Google Meet
 : https://meet.google.com/btj-wgcg-euw\nOr dial: (US) +1 224-585-7864 PIN: 
 107799403#\nMore phone numbers: https://tel.meet/btj-wgcg-euw?pin=130752855
 2322&hs=7\n\nLearn more about Meet at: https://support.google.com/a/users/a
 nswer/9282720\n\nPlease do not edit this section.\n-::~:~::~:~:~:~:~:~:~:~:
 ~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
LAST-MODIFIED:20250701T150155Z
LOCATION:
SEQUENCE:1
STATUS:CANCELLED
SUMMARY:U-Boot community meeting
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--000000000000fb9c870638df6c6a--

--000000000000fb9c890638df6c6c
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWVElNRVpPTkUNClRaSUQ6QW1lcmljYS9CYWhpYV9CYW5kZXJhcw0KWC1MSUMtTE9D
QVRJT046QW1lcmljYS9CYWhpYV9CYW5kZXJhcw0KQkVHSU46U1RBTkRBUkQNClRaT0ZGU0VURlJP
TTotMDYwMA0KVFpPRkZTRVRUTzotMDYwMA0KVFpOQU1FOkNTVA0KRFRTVEFSVDoxOTcwMDEwMVQw
MDAwMDANCkVORDpTVEFOREFSRA0KRU5EOlZUSU1FWk9ORQ0KQkVHSU46VkVWRU5UDQpEVFNUQVJU
O1RaSUQ9QW1lcmljYS9CYWhpYV9CYW5kZXJhczoyMDI1MDEyOFQwOTAwMDANCkRURU5EO1RaSUQ9
QW1lcmljYS9CYWhpYV9CYW5kZXJhczoyMDI1MDEyOFQxMDAwMDANClJSVUxFOkZSRVE9V0VFS0xZ
O1dLU1Q9U1U7SU5URVJWQUw9MjtCWURBWT1UVQ0KRFRTVEFNUDoyMDI1MDcwMVQxNTAxNTdaDQpP
UkdBTklaRVI7Q049SmVzc2UgVDptYWlsdG86bXIuYm9zc21hbjA3NUBnbWFpbC5jb20NClVJRDow
MW1xdW9lZGprbWdiZnE4bTRxbjZvNjh0Y0Bnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049bWEN
CiBseXNhZ3JlZ0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1hbHlzYWdyZWdAZ21h
aWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047Q049dS0NCiBib290QGxpc3RzLmRlbnguZGU7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOnUtYm9vdEBsaXN0cy5kZW54LmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049c2oNCiBn
QGNocm9taXVtLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86c2pnQGNocm9taXVtLm9yZw0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO0NOPXBiDQogaWVsN0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBi
aWVsN0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO0NOPUplc3NlIA0KIFQ7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOm1yLmJvc3NtYW4wNzVAZ21haWwuY29tDQpYLUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8v
bWVldC5nb29nbGUuY29tL2J0ai13Z2NnLWV1dw0KQ1JFQVRFRDoyMDI1MDIxOFQyMDU3MzhaDQpE
RVNDUklQVElPTjpVLUJvb3QgY29tbXVuaXR5IG1lZXRpbmdcblxuLTo6fjp+Ojp+On46fjp+On46
fjp+On46fjp+On46fjp+On4NCiA6fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+On46fjo6fjp+OjotXG5Kb2luIHdpdGggR29vZ2xlIE1lZXQNCiA6IGh0dHBzOi8vbWVldC5n
b29nbGUuY29tL2J0ai13Z2NnLWV1d1xuT3IgZGlhbDogKFVTKSArMSAyMjQtNTg1LTc4NjQgUElO
OiANCiAxMDc3OTk0MDMjXG5Nb3JlIHBob25lIG51bWJlcnM6IGh0dHBzOi8vdGVsLm1lZXQvYnRq
LXdnY2ctZXV3P3Bpbj0xMzA3NTI4NTUNCiAyMzIyJmhzPTdcblxuTGVhcm4gbW9yZSBhYm91dCBN
ZWV0IGF0OiBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9hL3VzZXJzL2ENCiBuc3dlci85Mjgy
NzIwXG5cblBsZWFzZSBkbyBub3QgZWRpdCB0aGlzIHNlY3Rpb24uXG4tOjp+On46On46fjp+On46
fjp+On46fjoNCiB+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46
fjp+On46fjp+Ojp+On46Oi0NCkxBU1QtTU9ESUZJRUQ6MjAyNTA3MDFUMTUwMTU1Wg0KTE9DQVRJ
T046DQpTRVFVRU5DRToxDQpTVEFUVVM6Q0FOQ0VMTEVEDQpTVU1NQVJZOlUtQm9vdCBjb21tdW5p
dHkgbWVldGluZw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--000000000000fb9c890638df6c6c--
