Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D9C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4A38796F;
	Thu,  4 Jan 2024 16:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mE3zvpRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2B58793E; Thu,  4 Jan 2024 16:00:29 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF808796C
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so5693635e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704380404; x=1704985204;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wCcc1qfOC6Oq7NDPblvkF0cBDkVbyKGh5dosyM3yvqM=;
 b=mE3zvpRYkz1O8CaNi6c4BOfRfE/V9hReFDj/mxyV2l8dQPOJiSSQMr3Y3vda0+RjVw
 t8drYb3o4aAkkPujYKAMXFl52t2kOW1q6onKebffvMkft5GRq1/u64AWfgJbRJSOwY+m
 MIoXW+k8aq0rBe45a7fMDXhYO8gc80LjzOngxgAA7HRD4WPyIxGPWsZ+wCl01gpIZ6yF
 SgY2pxGvUs9oDsXR3WTNBnu91WCMlM6viPtEVhUQZ3XUvpQOv1w1ZjnQwfrc28QXs8CF
 4M9/XRVUnIfjwBGDw2VNZOuV1PiZOru6/TDhfR/jt6rImuyeTCSCwUFzafeH27XVlvBH
 9mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704380404; x=1704985204;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCcc1qfOC6Oq7NDPblvkF0cBDkVbyKGh5dosyM3yvqM=;
 b=K2Q0kh2Z58emtlEYCpgdL0e/fpowBvaJc74GYmnCs3G3JE6hfeIA3+kHUe5YDpRwXE
 LoxUTTHypuA8ckf78rjHaS7snpBNuaFrCTpHCZTWclAQBAp/hIAch3ak2GlK/g7amUzS
 BvWH+4CZgrZS3uz1XsOqybFwGYnMi15/0A+XZO/lMGfVJgx+IACJeWMRMbtvA9DDTStm
 v3/x7CZ6K2YdOfrQ+w1T5wrVJkwugWLpme77PReF/Gz+36i6FE/bq9R1EwLvvwQWPj9U
 c8npjTsuzgcMKY3kAYIjF7k1zQR1UTpBdLehrcol5yx5mLxJwTDCMQRUOcFeiHfbYapu
 fVRw==
X-Gm-Message-State: AOJu0Yw8AzgCUBWfWBapBLbkBQzsCSnYIisEkdVl04XiFvJTR8itCeoj
 puxq2yenwO5HZbwv+/yaD5DJhP6XQeyWKg==
X-Google-Smtp-Source: AGHT+IH201NUxMc3mC6v+Iuoeyi/Nq4P1KXS2cikWPNNesKNrtjT7TG1OluOwyIrvus8v5zCnJ65Jg==
X-Received: by 2002:a05:600c:34d6:b0:40d:5821:516b with SMTP id
 d22-20020a05600c34d600b0040d5821516bmr413574wmq.54.1704380404222; 
 Thu, 04 Jan 2024 07:00:04 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm32973015wrn.81.2024.01.04.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:00:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 0/6] Implement fastboot multiresponce
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
Date: Thu, 04 Jan 2024 16:00:02 +0100
Message-ID: <87wmspm9e5.fsf@baylibre.com>
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

Hello Svyatoslav,

On jeu., d=C3=A9c. 28, 2023 at 20:01, Svyatoslav Ryhel <clamor95@gmail.com>=
 wrote:

> Currently u-boot fastboot can only send one message back to host,
> so if there is a need to print more than one line messages must be
> kept sending until all the required data is obtained. This behavior
> can be adjusted using multiresponce ability (getting multiple lines
> of response) proposed in this patch set.
>
> Implementation of multiresponce leads to ability to dump content of
> console buffer which, with use of "oem run", allows to entirely avoid
> need in UART.
>
> ---
> Changes in v6:
>  - remove prev console changes
>  - add console_record_isempty helper
>  - set record flag on init
>
> Changes in v5:
>  - restored membuff_readline behavior changed in v4
>
> Changes in v4:
>  - adjust membuff_readline behavior with overflow
>
> Changes in v3:
>  - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled
>
> Changes in v2:
>  - changed variables to static
>  - fixed multiresponce for udp
>  - documented use of "MORE"
>  - converted #if to if (...)
> ---
>
> Ion Agorria (6):
>   fastboot: multiresponse support
>   fastboot: implement "getvar all"
>   common: console: introduce console_record_isempty helper
>   common: console: record console from the beginning
>   lib: membuff: fix readline not returning line in case of overflow
>   fastboot: add oem console command support

I went on to apply the series, however CI detected a regression in the
unit tests:

https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/764396

This can be reproduced with:
$ ./test/py/test.py --bd sandbox --build -k ut_hush_hush_test_simple_dollar

I've narrowed this down to:
 [PATCH v6 5/6] lib: membuff: fix readline not returning line in case of ov=
erflow

Could you please have a look?

Thank you!

>
>  boot/bootmeth_extlinux.c          |  2 +-
>  common/console.c                  | 10 +++-
>  doc/android/fastboot-protocol.rst |  3 ++
>  doc/android/fastboot.rst          |  1 +
>  drivers/fastboot/Kconfig          |  7 +++
>  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
>  drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
>  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
>  include/console.h                 | 13 ++++++
>  include/fastboot-internal.h       |  7 +++
>  include/fastboot.h                | 19 ++++++++
>  include/membuff.h                 |  5 +-
>  lib/membuff.c                     |  4 +-
>  net/fastboot_udp.c                | 29 +++++++++---
>  14 files changed, 233 insertions(+), 25 deletions(-)
>
> --=20
> 2.40.1
