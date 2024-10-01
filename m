Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA38CE837A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F4F891B1;
	Tue,  1 Oct 2024 15:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eqCt8xNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B17A88E6C; Tue,  1 Oct 2024 14:07:30 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2223889062
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso3060219f8f.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727784445; x=1728389245;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4w2ywr1AId3fLxxpMWOlpioSd09kxKS99WL3sBpdeUA=;
 b=eqCt8xNyVsqzIMdNOF8xyuLoskgFy89dUN9psD+fC1vx0pgbtHrVwblbHSeufupSWb
 BY93+q5hNRE6GUrYlU6u8i0cAb07mTMKwC/LQfNZaVbl89CunBrmTyihukmMEsfGc/wI
 l79ezJZkE7qhu4g7e7hCWvXt+YiIAZshRUFVG2B9GJGI2nx57rLbCctb/e8AiVFIxTMa
 HDT7LQWDuF5U9ujCrIggtMLbgFj8Q+FkQAKsKKGQ/ZrnDH7nD0LMR6M4wY0ETxk9cq2k
 thJ86iSvepstHPVpKs1uZG/of/eaS21n6erFqsnulPIK1PV/VfBELmHbQPDYfGFaxSBz
 ASJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727784445; x=1728389245;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4w2ywr1AId3fLxxpMWOlpioSd09kxKS99WL3sBpdeUA=;
 b=c6OUWOSKtDuIKUrNTwilgYJzimurobkioUtEQfoKjSgGpv0KCuSeq/fKO7n0Y5FeoB
 IrBEGBDXt84xKrfaZlski5BlWMZULLukoAmDa6uve8SI5JmY/87XeGo6KlunQsraY81M
 u4QT1v1s/3e6JjC8Sphqr82Nx2DcsLjaLnC+9n9Jt1b+9KZhcpNEeMcIrvtPwuP4X7kd
 9JCZxmHwrV/ctTDQ3DJNt24ZBYhSTmT9scTZn3V4lx6SSg85Va1N/Yfs4N9ua7lcUwpI
 TfGo4xbRjCGqA0X/JGQuCY2nb+2VHm7lZ3RhrSlltnxFnBoFAExN74WPKmywY9snTTxs
 WSxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7hgqH8+vZ7ad2/A2riwXnnVxfpTyj2g902rWGP3q+S2rozNlzlpMCs+pmDN3NyYxv49+TK8U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3qez2It+HdHgcOzMSoG+CJ6ajvH5TUKP8z804o5q37alldepb
 UcZ9u3EmxgCgr2Tiud3HkOOaBxjnepdjOtrpv2VtBiod/yNiTCyD5OcUOtrg450=
X-Google-Smtp-Source: AGHT+IE/mt22azbQZrO4MFWdq3hWcHhe7Y9RpEkjhSxDn7oj7d8CBUIlrj/NM3ldDU+XP6/D5fKlsg==
X-Received: by 2002:adf:f846:0:b0:37c:d526:9bb0 with SMTP id
 ffacd0b85a97d-37cd5aa5d5emr9765144f8f.35.1727784445407; 
 Tue, 01 Oct 2024 05:07:25 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d35bsm11659657f8f.21.2024.10.01.05.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:07:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Bin Meng <bmeng@tinylab.org>, Bryan Brattlof
 <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, =?utf-8?B?Q3M=?=
 =?utf-8?B?w7Nrw6Fz?= Bence
 <csokas.bence@prolan.hu>, Dragan Simic <dsimic@manjaro.org>, Eddie James
 <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, Jesse Taube
 <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Johan
 Jonker <jbx6244@gmail.com>, Julien Masson <jmasson@baylibre.com>, Kever
 Yang <kever.yang@rock-chips.com>, "Leon M. Busch-George"
 <leon@georgemail.eu>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek
 Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, Nam Cao
 <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Stefan Roese <sr@denx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
In-Reply-To: <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
Date: Tue, 01 Oct 2024 14:07:21 +0200
Message-ID: <87cykkc9hi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

Hi Simon,

On mar., oct. 01, 2024 at 05:18, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>>
>> This series attempts to migrate all sunxi boards to use standard boot,
>> along with a text environment.
>>
>> Changes in v2:
>> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
>> - Put the FEL bootmeth before all other global bootmeths
>> - Convert the other DISTRO_DEFAULTS in the Kconfig too
>> - Keep BOOTCMD_SUNXI_COMPAT
>> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
>>
>> Simon Glass (8):
>>   blk: Make functions available unconditionally
>>   bootstd: Avoid calling unavailable block functions
>>   bootstd: Avoid depending on BLK
>>   sunxi: Add a bootmeth for FEL
>>   sunxi: Move to bootstd
>>   sunxi: Drop old distro boot variables
>>   env: Provide a work-around for unquoting fdtfile
>>   sunxi: Move to text environment
>>
>>  Makefile                                      |   1 +
>>  arch/arm/Kconfig                              |  10 +-
>>  board/sunxi/sunxi.env                         | 152 +++++++++++
>>  boot/Kconfig                                  |  16 +-
>>  boot/Makefile                                 |   1 +
>>  boot/bootdev-uclass.c                         |   3 +
>>  boot/bootmeth_fel.c                           |  81 ++++++
>>  .../gardena-smart-gateway-mt7688_defconfig    |   1 +
>>  doc/usage/environment.rst                     |  12 +
>>  include/blk.h                                 |   9 +-
>>  include/configs/sunxi-common.h                | 238 ------------------
>>  11 files changed, 278 insertions(+), 246 deletions(-)
>>  create mode 100644 board/sunxi/sunxi.env
>>  create mode 100644 boot/bootmeth_fel.c
>>
>> --
>> 2.34.1
>>
>
> I'm just checking on this series. Are there any comments, or can it be applied?

Quentin mentioned a typo in patch 3/8, see:
https://lore.kernel.org/all/1f963aa8-948a-4657-9f1b-a3bc38df4714@cherry.de/

Can you make sure it gets removed when being applied ?

>
> Regards,
> Simon
