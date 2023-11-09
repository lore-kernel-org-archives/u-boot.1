Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5187AC0018C
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 11:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200E287232;
	Thu,  9 Nov 2023 12:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J1yJRHKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25126871DA; Thu,  9 Nov 2023 12:00:06 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0929487232
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 12:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso849509e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699527600; x=1700132400;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BhsoIw/52DksR2uINZu6ebKioTHrSakoA5flskMmWxY=;
 b=J1yJRHKHx8/sgC1l6M0JYl16m4tMyzp+cbsthTCk0rlc51wqLGpYjjIG2ln3cE415L
 uat9hXj2eKOdZG1min9m9j9q1Al1AZgNff7laphQRUuWrpLQlLLMtHGubRRumn26m8Pe
 wPn/3YVTBEeEWTY7HWpd/AkM1Rx5LGnuVlwWx3Weacfc7CSna35eKjoRppf0X9ZIhtqq
 h+uGwG1zz7XRfkTpj2D6yTchycbC3oy9Hvn+K1hmJWW7w8WV5LMdMsXoKi1feM6H6ZdT
 uGPj12WEpJ0et6cRzsa+e4iGx0oqA8SLeICvftDoctQogOqJG2odgeg9flhRYqtdkusZ
 U7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699527600; x=1700132400;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhsoIw/52DksR2uINZu6ebKioTHrSakoA5flskMmWxY=;
 b=P+c9vrBHIu0uX5cd1czCZMrLuhNnBZBGf72UtIZy/eXPpSW6USjHDq3cxPTUNoG4kg
 9wRtj3SE+m/bfeVcR6tXPFf6WjS3kvspYoA4aC48BqDEaktGxQ0IXGPf5UVo5p4U2gs0
 nnNokl98Omy1xgGB5sN06GjuyFDXTsvtmzJu1syCgMEc1Y2B691QoCeVK6qxs9LGhBD+
 pEP2mb/20CPBYkwMX3LHu7SmnBoA+KFoEhk8/LHWc42FY5D3pdZkNZyDjQoK4pAVXO5T
 o70Cr/xRfcpAbTh4/NVNohLwdp70SSt9uC4FrJL/LhLrzUpIYhXFR8RTbljeDhaoBpUX
 oozQ==
X-Gm-Message-State: AOJu0Yz3yopFGUQCbowM2HYrtWmvigQFPL9aNDHRiRpraDM0l1EJGt9Y
 YOED0mnXXmA6LINSYEIrBqFOcA==
X-Google-Smtp-Source: AGHT+IH9laUxXwePSndaJzm9y6RKSAjVGpxy5MM2N6DQzPzc4l1S4dFihvaszcXOU5OYnr5h3sha6Q==
X-Received: by 2002:a19:f007:0:b0:509:8a7e:4d0d with SMTP id
 p7-20020a19f007000000b005098a7e4d0dmr1133774lfc.0.1699527599804; 
 Thu, 09 Nov 2023 02:59:59 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 i15-20020a05600c354f00b004067e905f44sm1755978wmq.9.2023.11.09.02.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 02:59:59 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, Sean
 Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, Dmitrii
 Merkurev <dimorinny@google.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Implement fastboot multiresponce
In-Reply-To: <94E7D060-9388-4888-B7FF-EE911A179B2C@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <87cywj9v45.fsf@baylibre.com>
 <94E7D060-9388-4888-B7FF-EE911A179B2C@gmail.com>
Date: Thu, 09 Nov 2023 11:59:58 +0100
Message-ID: <87y1f78a4x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Svyatoslav,

On jeu., nov. 09, 2023 at 11:01, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:

> 9 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. 10:=
41:30 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre.com> =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>>Hi Svyatoslav, Ion,
>>
>>Thank you for these series.
>>
>>On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>>
>>> Currently u-boot fastboot can only send one message back to host,
>>> so if there is a need to print more than one line messages must be
>>> kept sending until all the required data is obtained. This behavior
>>> can be adjusted using multiresponce ability (getting multiple lines
>>> of response) proposed in this patch set.
>>>
>>> Implementation of multiresponce leads to ability to dump content of
>>> console buffer which, with use of "oem run", allows to entirely avoid
>>> need in UART.
>>
>
> Hello Mattijs!
> Thank you for your suggestions and so rapid responce!
>
>>I'm happy to fastboot getvar all implemented since it's standardly
>>supported on Android phones.
>>
>>fastboot oem console seems like a nice debug tool as well when no
>>console is available.
>>
>>I do have some concerns with the series, mainly because the introduction
>>of the "MORE" byte response.
>>"MORE" is not part of the fastboot specification [1].
>>
>>However, that specification documents "TEXT", which, per my
>>understanding, should allow to send multiple responses as well.
>>
>>Could we implement this using "TEXT" instead ?
>
> I see no issues with replacing MORE with TEXT whatsoever.
>
> These patches were mainly developed and used for our internal development=
 needs but since they served extremely well, I have decided to push them up=
stream so other developers could benefit as well.

Thank you for taking the time to upstream.

>
> If you have no other suggestions then swap more > text, please send your =
reviewed-by to patch and I will reload v2 with swap included.

I will do a more thorough review in the coming days, I wanted to get
feedback on MORE->TEXT first.

>
> Best regards,
> Svyatoslav R.
>
>>[1] https://android.googlesource.com/platform/system/core/+/master/fastbo=
ot/#transport-and-framing
>>
>>>
>>> Ion Agorria (5):
>>>   fastboot: multiresponse support
>>>   fastboot: implement "getvar all"
>>>   commonn: console: introduce overflow and isempty calls
>>>   lib: membuff: fix readline not returning line in case of overflow
>>>   fastboot: add oem console command support
>>>
>>>  boot/bootmeth_extlinux.c          |  2 +-
>>>  common/console.c                  | 17 +++++--
>>>  doc/android/fastboot-protocol.rst |  3 ++
>>>  doc/android/fastboot.rst          |  1 +
>>>  drivers/fastboot/Kconfig          |  7 +++
>>>  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
>>>  drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++------
>>>  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
>>>  include/console.h                 | 14 ++++++
>>>  include/fastboot-internal.h       |  7 +++
>>>  include/fastboot.h                |  9 ++++
>>>  include/membuff.h                 |  5 ++-
>>>  lib/membuff.c                     |  4 +-
>>>  net/fastboot_udp.c                | 25 ++++++++---
>>>  test/ut.c                         |  9 ++--
>>>  15 files changed, 226 insertions(+), 33 deletions(-)
>>>
>>> --=20
>>> 2.40.1
