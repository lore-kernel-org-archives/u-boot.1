Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7050EEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A508784073;
	Tue, 10 Mar 2026 16:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xCQoAscU";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C3GyGKrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EC083F53; Tue, 10 Mar 2026 16:12:12 +0100 (CET)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com
 [IPv6:2a00:1450:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4605484027
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-660a2f72cccso7603386a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773155530; x=1773760330; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lqy8fEEQB7cWto38pI23qlGpz3WEkho3uNkvtYh5ngk=;
 b=xCQoAscUq156vN0UaTm8lJ2zXOcBzxuqG1bViwN6bc+1TXd4/WU7gRWgkB6QmvnL2H
 +gZ7KwKorwlhzRzigtY8v+pptAcQ2bzq8XJY2ZhVK4tcq+QyWnspyW0rVAnM6nA9dJY+
 DZfUFGGORX5djzbkCSokshdpjQelqQk1bStTg/gCaR4AKBFhR9IMhYj/JVNy1GPVaa2f
 OV+jOuKcTpvLhE5oygXpOTxEbvsU1CJgCxCOqUbWTirLbGCn2Ig6pdvnO2QxW+xfCfes
 ZA3Psn22eSHQbxtwyB3FwFDipxxPP2ahIZgW3G7OEFR3pt3E/TO6pldVSLqBLWZ5B5AE
 cCJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773155530; x=1773760330; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lqy8fEEQB7cWto38pI23qlGpz3WEkho3uNkvtYh5ngk=;
 b=C3GyGKrvR0GHbOb19qdHP+xO8ulpbauzMUnaUz/RFX7Am0gt6FixlUmZ3PS7iDYzPC
 p5F/rynF1jrowlgdNA1KnEwfGyFWqBnsnA935bH71BCpStkgqm41rJgxRF77Ui6RBNWe
 zY0QoqSaZbbVi8KEqdVhm+/2l8spwsBlDCB00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155530; x=1773760330;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lqy8fEEQB7cWto38pI23qlGpz3WEkho3uNkvtYh5ngk=;
 b=R0JYa9QdUsxrOkO8J6+gDKYxiojhqFUlWPmij+BqS3/IXtc4d8FhyYQ8I6WbdqR5qD
 ZDIu9qn0BKYnyEBA1R2w640V8h/VkiMYnZDrNyHNgtiEXrQlMdr6p4zCLxtHShxXltGi
 KepIwKP4vzChGlIqs+Wt3UExdjhRNuVBhJvjUHu+AEkEI45pfmz4aLnUItBP2ewEb0/e
 gZyS98J19aPr9moQNX6sW67qZgzIApDN4lV8ytFk5+XjRbiaGcgLeM/7mSeZyrK+ykTC
 6i2IUCyIbNY2/d8JTYwcL/0VSq3e8+2e/qIa+pvjN/0sISMYVre+M7Zlnic/qIi8vg37
 Qi3Q==
X-Gm-Message-State: AOJu0YxGDiN8gyH4nrdkJNPsppYTO/YD5YsbPRrkmz3u0nANbqJO+N9E
 8m1a6KjMr1gWWQoZDkISOFa4eI8uxyg+3tJLAftXwSmsXSC+b3Wrr9zGldI3Ogpo+r/RuEJxgHt
 ioBDLkjgwoaK0ku+9jlvpkcZ4d86krirz59OQvyh7g0ENP9vxnDdX
MIME-Version: 1.0
X-Received: by 2002:a05:6402:2787:b0:662:e31e:a49 with SMTP id
 4fb4d7f45d1cf-662e31e0efamr1181866a12.21.1773155529641; Tue, 10 Mar 2026
 08:12:09 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-7263320f-b043-4885-9f3b-cbc64eddf40f@google.com>
Date: Tue, 10 Mar 2026 15:12:09 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 9am
 to 10am on Tuesday (MDT) (u-boot@lists.denx.de)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="00000000000079e2f7064cacf172"
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

--00000000000079e2f7064cacf172
Content-Type: multipart/alternative; boundary="00000000000079e2f6064cacf170"

--00000000000079e2f6064cacf170
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 9am to 10am on Tuesday
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

--00000000000079e2f6064cacf170
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
DTSTART;TZID=America/Bahia_Banderas:20260310T090000
DTEND;TZID=America/Bahia_Banderas:20260310T100000
RRULE:FREQ=WEEKLY;WKST=SU;INTERVAL=2;BYDAY=TU
DTSTAMP:20260310T151209Z
ORGANIZER;CN=U-Boot:mailto:89be7b813136bec06a83de4da59745f0abd11c1b836061ae
 06c1c7dbcd18df41@group.calendar.google.com
UID:0v3c45uhvntcro4s5fp73bhl58_R20260310T150000@google.com
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
X-MICROSOFT-CDO-OWNERAPPTID:-992614451
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

--00000000000079e2f6064cacf170--

--00000000000079e2f7064cacf172
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAzMTBUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNjAzMTBUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNjAzMTBUMTUxMjA5Wg0K
T1JHQU5JWkVSO0NOPVUtQm9vdDptYWlsdG86ODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1
ZjBhYmQxMWMxYjgzNjA2MWFlDQogMDZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5nb29n
bGUuY29tDQpVSUQ6MHYzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfUjIwMjYwMzEwVDE1MDAwMEBn
b29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBiaWVsN0BnbWFpbC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBiaWVsN0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPURFTEVURUQ7UlNWUD1UUlVF
Ow0KIENOPVNpbW9uIEdsYXNzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzamdAY2hyb21pdW0ub3Jn
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1hbHlzYWdyZWdAZ21haWwuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzptYWx5c2FncmVnQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1rb3JnLnN1bWl0QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29y
Zy5zdW1pdEBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049dS1ib290QGxp
c3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9vdEBsaXN0cy5kZW54LmRlDQpY
LUdPT0dMRS1DT05GRVJFTkNFOmh0dHBzOi8vbWVldC5nb29nbGUuY29tL2ljdi1udm12LWRiZg0K
WC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi05OTI2MTQ0NTENCkNMQVNTOlBVQkxJQw0KQ1JF
QVRFRDoyMDI1MDExNFQxNjI4MjdaDQpERVNDUklQVElPTjpVLUJvb3QgY29tbXVuaXR5IG1lZXRp
bmdcblxuLTo6fjp+Ojp+On46fjp+On46fjp+On46fjp+On46fjp+On4NCiA6fjp+On46fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjo6fjp+OjotXG5Kb2luIHdpdGggR29vZ2xl
IE1lZXQNCiA6IGh0dHBzOi8vbWVldC5nb29nbGUuY29tL2ljdi1udm12LWRiZlxuT3IgZGlhbDog
KFVTKSArMSA0NzUtMjk5LTgzNjIgUElOOiANCiA0MzkwNTIwNDkjXG5Nb3JlIHBob25lIG51bWJl
cnM6IGh0dHBzOi8vdGVsLm1lZXQvaWN2LW52bXYtZGJmP3Bpbj01NDkzMTcxOTANCiAwNTU2Jmhz
PTdcblxuTGVhcm4gbW9yZSBhYm91dCBNZWV0IGF0OiBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNv
bS9hL3VzZXJzL2ENCiBuc3dlci85MjgyNzIwXG5cblBsZWFzZSBkbyBub3QgZWRpdCB0aGlzIHNl
Y3Rpb24uXG4tOjp+On46On46fjp+On46fjp+On46fjoNCiB+On46fjp+On46fjp+On46fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46Oi0NCkxBU1QtTU9ESUZJRUQ6
MjAyNjAzMTBUMTUxMjA0Wg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vaWN2LW52
bXYtZGJmDQpTRVFVRU5DRTo1DQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlUtQm9vdCBjb21t
dW5pdHkgbWVldGluZw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--00000000000079e2f7064cacf172--
