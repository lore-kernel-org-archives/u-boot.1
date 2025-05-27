Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5863EC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF72B837E1;
	Tue, 27 May 2025 15:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hzNE5UEo";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gLAhqsO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3730B83086; Tue, 27 May 2025 15:09:03 +0200 (CEST)
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com
 [IPv6:2a00:1450:4864:20::249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D6E83086
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x249.google.com with SMTP id
 38308e7fff4ca-327fa3cec44so17492301fa.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1748351340; x=1748956140; darn=lists.denx.de;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1A9H6Zg2PGBAAKyOPxVoYLP0AsiNPq944Y7PPGNrM4=;
 b=hzNE5UEod9PQXQS3lq8P+tfIJgIAC/zNlR1pDTAeQLEDKQr1gJOFnDNx0ZPR2iJcL/
 m7ji3z/x3eHBYNNzU/fQUKe3ADiP4ML9+++NxJ0nvB71AceD4v6JE2NaBNt3AHQoZBoI
 9Kzjpz1K5UedUgxaB/MLIqi1OdZS7vD9INiClP+F6t29GgjD14d2KoEkdJOPUH6WLWTU
 QmvaqQKW0PZu5Ac6O4o4PCfuOzZCbjrnK+39uFGIL7TozCJdb6Zsss6DZAJUffCFlxjm
 KJS1sTt5i4VYAzqjXRtPqstUA/0Da56+DW6DKEuXKYIOqCH79R8xjCnlp3L6DrPf/206
 wDeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748351340; x=1748956140;
 darn=lists.denx.de; 
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1A9H6Zg2PGBAAKyOPxVoYLP0AsiNPq944Y7PPGNrM4=;
 b=gLAhqsO/+8vYEhuNlnJRlJrcQ+/yUWXKuKLYPBHHjRPpyxSAcWTX6/kyPp308Ppbe1
 EO4SBuEJtn7zGum6JxUz40M6Gi9Kw6lu2p8MT0OgfQAi7hPSP049D9wLHbLJL7p5i2dT
 u9aVQLY4sLkoKKwqGqXu7aIfotXwR8q9Mh5fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351340; x=1748956140;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1A9H6Zg2PGBAAKyOPxVoYLP0AsiNPq944Y7PPGNrM4=;
 b=buV+53BwKb1v2UELe5RprSQUOGvUtEzgVoOhQmS8SKktatmZY22KmFTlH3npj4dH0Z
 nv0ri2kJ68hnn8gGfLQQkvnaIRE6PCVAcibt4yTiNGQKepbTZhDDgX+6bAnvIqBknNNd
 CVSrWsT89UuxXhZ3itFqJYTWIT5XXpV32w4WdIzP6V94jOZ9Fjv6yK0D60cblCbaDlmV
 srLJdCrm9q04xHIpAu2SOtqZrSHSmiiFIl6r5u92mIr3xHGUQJG1ekTSGzuEe6JfwRtk
 iqTwLP05QMyfYnNd+LQXZW4sMftGv0qW4U1U3NI/x37fifI6f2F6QkDStMwf1kTF24Db
 LEmg==
X-Gm-Message-State: AOJu0YzuhhrBB0Fq0Qo5AKJJQcFE/dUgDCapezsTiB0RprxRXs9h9J66
 bT8QKOpEa44Kj5Ps3w9yGQ5HdPRvCaKPfrrlhhgBPi3bGzrVSW8m/TyWSKQN8ZxtIIkAsjXIA3v
 TeCmJY8TKpIvsCWjb1uH+e/hWLEpHwFjmlx6t+h/AdDJWDMNFzsz1OHxn
X-Google-Smtp-Source: AGHT+IG2STypUlJNLst1jalQsKe0URnyZ3HH9CVnZsn+mTkZ9M9Es2UcTomUcqggdFytPg3ZU7tROVvM8hM0ZbLGW8Vd
MIME-Version: 1.0
X-Received: by 2002:a05:6402:13c9:b0:602:4405:777b with SMTP id
 4fb4d7f45d1cf-602da2fef89mr10136935a12.24.1748351328947; Tue, 27 May 2025
 06:08:48 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-62291889-a916-419e-9490-08e0e29f1dd4@google.com>
Date: Tue, 27 May 2025 13:08:48 +0000
Subject: Synced invitation: U-Boot community meeting @ Every 2 weeks from 5pm
 to 6pm on Tuesday (CEST) (u-boot@lists.denx.de)
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000e7a9ec06361dc313"
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

--000000000000e7a9ec06361dc313
Content-Type: multipart/alternative; boundary="000000000000e7a9ea06361dc311"

--000000000000e7a9ea06361dc311
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This email keeps the event up to date in your calendar.

U-Boot community meeting
Every 2 weeks from 5pm to 6pm on Tuesday
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

--000000000000e7a9ea06361dc311
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
DTSTART;TZID=America/Bahia_Banderas:20250603T090000
DTEND;TZID=America/Bahia_Banderas:20250603T100000
RRULE:FREQ=WEEKLY;WKST=SU;INTERVAL=2;BYDAY=TU
DTSTAMP:20250527T130848Z
ORGANIZER;CN=cyrevolt@googlemail.com:mailto:cyrevolt@googlemail.com
UID:213jcf92k24qi5hl3hbgvkqkee_R20250603T150000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=malysagreg@gmail.com;X-NUM-GUESTS=0:mailto:malysagreg@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=cyrevolt@googlemail.com;X-NUM-GUESTS=0:mailto:cyrevolt@googlemail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=u-boot@lists.denx.de;X-NUM-GUESTS=0:mailto:u-boot@lists.denx.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=korg.sumit@gmail.com;X-NUM-GUESTS=0:mailto:korg.sumit@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=Michael Nazzareno Trimarchi;X-NUM-GUESTS=0:mailto:michael@amarulasoluti
 ons.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=sjg@chromium.org;X-NUM-GUESTS=0:mailto:sjg@chromium.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=pbiel7@gmail.com;X-NUM-GUESTS=0:mailto:pbiel7@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=pbrobinson@gmail.com;X-NUM-GUESTS=0:mailto:pbrobinson@gmail.com
X-GOOGLE-CONFERENCE:https://meet.google.com/btj-wgcg-euw
X-MICROSOFT-CDO-OWNERAPPTID:203864597
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

--000000000000e7a9ea06361dc311--

--000000000000e7a9ec06361dc313
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNClgtTElDLUxP
Q0FUSU9OOkFtZXJpY2EvQmFoaWFfQmFuZGVyYXMNCkJFR0lOOlNUQU5EQVJEDQpUWk9GRlNFVEZS
T006LTA2MDANClRaT0ZGU0VUVE86LTA2MDANClRaTkFNRTpDU1QNCkRUU1RBUlQ6MTk3MDAxMDFU
MDAwMDAwDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTA2MDNUMDkwMDAwDQpEVEVORDtUWklE
PUFtZXJpY2EvQmFoaWFfQmFuZGVyYXM6MjAyNTA2MDNUMTAwMDAwDQpSUlVMRTpGUkVRPVdFRUtM
WTtXS1NUPVNVO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNTA1MjdUMTMwODQ4Wg0K
T1JHQU5JWkVSO0NOPWN5cmV2b2x0QGdvb2dsZW1haWwuY29tOm1haWx0bzpjeXJldm9sdEBnb29n
bGVtYWlsLmNvbQ0KVUlEOjIxM2pjZjkyazI0cWk1aGwzaGJndmtxa2VlX1IyMDI1MDYwM1QxNTAw
MDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYWx5c2FncmVnQGdt
YWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFseXNhZ3JlZ0BnbWFpbC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQ
VEVEO1JTVlA9VFJVRQ0KIDtDTj1jeXJldm9sdEBnb29nbGVtYWlsLmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86Y3lyZXZvbHRAZ29vZ2xlbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049dS1ib290QGxpc3RzLmRlbnguZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnUtYm9vdEBs
aXN0cy5kZW54LmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvcmcuc3VtaXRAZ21h
aWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzprb3JnLnN1bWl0QGdtYWlsLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBU
RUQ7UlNWUD1UUlVFDQogO0NOPU1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86bWljaGFlbEBhbWFydWxhc29sdXRpDQogb25zLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1zamdAY2hyb21pdW0ub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpz
amdAY2hyb21pdW0ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049cGJpZWw3QGdtYWlsLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJpZWw3QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1wYnJvYmluc29uQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
cGJyb2JpbnNvbkBnbWFpbC5jb20NClgtR09PR0xFLUNPTkZFUkVOQ0U6aHR0cHM6Ly9tZWV0Lmdv
b2dsZS5jb20vYnRqLXdnY2ctZXV3DQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6MjAzODY0
NTk3DQpDUkVBVEVEOjIwMjUwNDAzVDAxMDAxNVoNCkRFU0NSSVBUSU9OOlUtQm9vdCBjb21tdW5p
dHkgbWVldGluZ1xuXG4tOjp+On46On46fjp+On46fjp+On46fjp+On46fjp+On46fg0KIDp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+Ojp+On46Oi1cbkpvaW4gd2l0
aCBHb29nbGUgTWVldA0KIDogaHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vYnRqLXdnY2ctZXV3XG5P
ciBkaWFsOiAoVVMpICsxIDIyNC01ODUtNzg2NCBQSU46IA0KIDEwNzc5OTQwMyNcbk1vcmUgcGhv
bmUgbnVtYmVyczogaHR0cHM6Ly90ZWwubWVldC9idGotd2djZy1ldXc/cGluPTEzMDc1Mjg1NQ0K
IDIzMjImaHM9N1xuXG5MZWFybiBtb3JlIGFib3V0IE1lZXQgYXQ6IGh0dHBzOi8vc3VwcG9ydC5n
b29nbGUuY29tL2EvdXNlcnMvYQ0KIG5zd2VyLzkyODI3MjBcblxuUGxlYXNlIGRvIG5vdCBlZGl0
IHRoaXMgc2VjdGlvbi5cbi06On46fjo6fjp+On46fjp+On46fjp+Og0KIH46fjp+On46fjp+On46
fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46fjp+On46On46fjo6LQ0KTEFTVC1N
T0RJRklFRDoyMDI1MDUyN1QxMzA4NDVaDQpMT0NBVElPTjoNClNFUVVFTkNFOjANClNUQVRVUzpD
T05GSVJNRUQNClNVTU1BUlk6VS1Cb290IGNvbW11bml0eSBtZWV0aW5nDQpUUkFOU1A6T1BBUVVF
DQpCRUdJTjpWQUxBUk0NCkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJT046VGhpcyBpcyBhbiBldmVu
dCByZW1pbmRlcg0KU1VNTUFSWTpBbGFybSBub3RpZmljYXRpb24NCkFUVEVOREVFOm1haWx0bzp1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KVFJJR0dFUjotUDBEVDBIMTBNMFMNCkVORDpWQUxBUk0NCkJF
R0lOOlZBTEFSTQ0KQUNUSU9OOkRJU1BMQVkNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4gZXZlbnQg
cmVtaW5kZXINClRSSUdHRVI6LVAwRFQwSDMwTTBTDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpF
TkQ6VkNBTEVOREFSDQo=
--000000000000e7a9ec06361dc313--
