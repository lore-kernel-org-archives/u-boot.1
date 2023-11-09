Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D7CC04E83
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A50587013;
	Thu,  9 Nov 2023 10:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gOe9k5hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D44F86F92; Thu,  9 Nov 2023 10:01:16 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20187870DF
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507be298d2aso770117e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699520472; x=1700125272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=19bAlzEOGmkTO9f449NTKThWI2XC3WYZZXzSPIxiW4Q=;
 b=gOe9k5hQMsWlixJ/mxBV0i+vWZsW6Kw+0INWeyFpwLz7pqItBoZvOh+TASQUkwG9sG
 gaeGaDFZWuLtM9WGv5XDxN3wfgb2tFsqLZLtnVmBa3Un7QyY8s5eAIDaF5CNevUIZuJs
 2uWa9I+kbuIwvglNOSmUO9q1EqSqeFSoJpO7d5e934OTs6SP/QwXJjDvdMXk6Dn08AOA
 tJZKHXvELB9bfuqmEie2vYt/BNJvoYi1YVeWxz9WFvjmq5c1FQ1LhYSAx/Ww87CpFFMz
 3E+5ehf+H7rrpQNq0gh6/0UgnWwALa7ZGJuBkOyWoFsMdi2hi/7RsZvTs+WU86GpIEA0
 q3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699520472; x=1700125272;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19bAlzEOGmkTO9f449NTKThWI2XC3WYZZXzSPIxiW4Q=;
 b=FNqVloukNm8B5CQ0o37I7IMKRDgCz5YVBD2gk0zDwxruIec78hq33Kl+VI3/scDFDZ
 kEKi7SsI2XpsDWA4pGcxNeV3Vs7caVNxSFPp5JdRXdUZFmOzMUYB8hSbdJhm1bdG2L+x
 TtT0DYiXcX9QCNF0JqzJcsYTHEa1AAx9HoKR0Ch7zl6ZVHva++ETP3f6IdhbrkgtNJK1
 izDPx585ui9p5cbv+c2q9FT0kysFXKylitOaXKNwWksHPchwfe9ryuaYg2MUWeQyj2mI
 2ZNzFaTci+WL8w7Fl2b8Y/S/W5XmWd777pAfE4glSdmNMEk3hOAil6UzF77qsadFahmP
 txVg==
X-Gm-Message-State: AOJu0YzAXK2zse95L/8exvZXmrLAuQ8zW2vqj8cXZkRAeQ/pJpWH9br0
 ZcTUK2EKM14Lj4FMvSXG8Os=
X-Google-Smtp-Source: AGHT+IGYA4dOZgikUF7+xZ/mZWMMx7hUqz4zwNqrliTWhRPRwf10l//ANcVeTXoQ+a7iqrmGyE97qA==
X-Received: by 2002:a19:6547:0:b0:503:654:cf27 with SMTP id
 c7-20020a196547000000b005030654cf27mr757766lfj.28.1699520471993; 
 Thu, 09 Nov 2023 01:01:11 -0800 (PST)
Received: from [127.0.0.1] ([46.211.227.108]) by smtp.gmail.com with ESMTPSA id
 k15-20020ac24f0f000000b004ff96c09b47sm998783lfr.260.2023.11.09.01.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 01:01:11 -0800 (PST)
Date: Thu, 09 Nov 2023 11:01:09 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Implement fastboot multiresponce
User-Agent: K-9 Mail for Android
In-Reply-To: <87cywj9v45.fsf@baylibre.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <87cywj9v45.fsf@baylibre.com>
Message-ID: <94E7D060-9388-4888-B7FF-EE911A179B2C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



9 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80=2E 10=
:41:30 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom> =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>Hi Svyatoslav, Ion,
>
>Thank you for these series=2E
>
>On mar=2E, nov=2E 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail=2Ec=
om> wrote:
>
>> Currently u-boot fastboot can only send one message back to host,
>> so if there is a need to print more than one line messages must be
>> kept sending until all the required data is obtained=2E This behavior
>> can be adjusted using multiresponce ability (getting multiple lines
>> of response) proposed in this patch set=2E
>>
>> Implementation of multiresponce leads to ability to dump content of
>> console buffer which, with use of "oem run", allows to entirely avoid
>> need in UART=2E
>

Hello Mattijs!
Thank you for your suggestions and so rapid responce!

>I'm happy to fastboot getvar all implemented since it's standardly
>supported on Android phones=2E
>
>fastboot oem console seems like a nice debug tool as well when no
>console is available=2E
>
>I do have some concerns with the series, mainly because the introduction
>of the "MORE" byte response=2E
>"MORE" is not part of the fastboot specification [1]=2E
>
>However, that specification documents "TEXT", which, per my
>understanding, should allow to send multiple responses as well=2E
>
>Could we implement this using "TEXT" instead ?

I see no issues with replacing MORE with TEXT whatsoever=2E

These patches were mainly developed and used for our internal development =
needs but since they served extremely well, I have decided to push them ups=
tream so other developers could benefit as well=2E

If you have no other suggestions then swap more > text, please send your r=
eviewed-by to patch and I will reload v2 with swap included=2E

Best regards,
Svyatoslav R=2E

>[1] https://android=2Egooglesource=2Ecom/platform/system/core/+/master/fa=
stboot/#transport-and-framing
>
>>
>> Ion Agorria (5):
>>   fastboot: multiresponse support
>>   fastboot: implement "getvar all"
>>   commonn: console: introduce overflow and isempty calls
>>   lib: membuff: fix readline not returning line in case of overflow
>>   fastboot: add oem console command support
>>
>>  boot/bootmeth_extlinux=2Ec          |  2 +-
>>  common/console=2Ec                  | 17 +++++--
>>  doc/android/fastboot-protocol=2Erst |  3 ++
>>  doc/android/fastboot=2Erst          |  1 +
>>  drivers/fastboot/Kconfig          |  7 +++
>>  drivers/fastboot/fb_command=2Ec     | 52 +++++++++++++++++++++
>>  drivers/fastboot/fb_getvar=2Ec      | 75 +++++++++++++++++++++++++----=
--
>>  drivers/usb/gadget/f_fastboot=2Ec   | 29 ++++++++++++
>>  include/console=2Eh                 | 14 ++++++
>>  include/fastboot-internal=2Eh       |  7 +++
>>  include/fastboot=2Eh                |  9 ++++
>>  include/membuff=2Eh                 |  5 ++-
>>  lib/membuff=2Ec                     |  4 +-
>>  net/fastboot_udp=2Ec                | 25 ++++++++---
>>  test/ut=2Ec                         |  9 ++--
>>  15 files changed, 226 insertions(+), 33 deletions(-)
>>
>> --=20
>> 2=2E40=2E1
