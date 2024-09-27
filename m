Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D14CDD1BD
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 15:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FA18909F;
	Fri, 27 Sep 2024 17:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHBT7OYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0287D890BB; Fri, 27 Sep 2024 17:52:45 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FB88908D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 17:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c876ed9c93so2296062a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727452362; x=1728057162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jQHkoitMZ1K3yK7TaFnL8lhpjXgQlNuz9AkVOhaX1iA=;
 b=aHBT7OYP65bPMSKz06Mv2uX55zC0AgsjQdeeyUvRquyDBMYgXA67NWnXuBh5iTTl61
 mXw2LHElLAASUc8np7Db0C+i8bpGgImyXVOwDZO1jMLQYglzgmxhuCB71RFLwo/Ql6AI
 MQaCUDvqHfECYKwoeL4F2jm1nzRRtZc2aiBqJH4LKlbqAiaBQn3ty3UQrJXo5gBW1qsb
 rvmG8PO2mCbMTP4YcMFRs0WqjCMsmxPYBsioqa6GFT912wZduxVGzs9F6Q4xcVKV12ii
 jXszcFYFS+fT0GbRoW6vTBnAkvOEDhEyiIZN3a6an0mXhe5bM7tRNdR4LKj4XgYfh/TB
 UpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727452362; x=1728057162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jQHkoitMZ1K3yK7TaFnL8lhpjXgQlNuz9AkVOhaX1iA=;
 b=KzOo2HIhf+Fyn1ApH0Qcrr+L5getruA1zruQQDVM4wRu+SMkEROE41rlv2E7GgKZZr
 lJ5EeidCDXxcWeLOBug3U7A8ErP34sKtpvAdoHDmGhGxrDfgk2On1l+etxAYkp7nspK2
 OENZKdGIHJHAEh8ATnuYiE84YN4abFPoPKYOb9/S1D05o9faZUgpGLd8ZFjEYPn1C2ix
 XDv84dmNJP/nREg+UfjerYbOG8Yj7rgaEo56Ih79wd3qvkbJOvsHprQI3AKyKxTSjMeI
 uhAcOZC+kQlcwHxMLVI94+fxIrDYMTxnLrZYLVezTrbGCj4cBqqs6IX91v9U8jI/Do8y
 HKRg==
X-Gm-Message-State: AOJu0YxZISLgaWpiA3gO4YAc4SUkLwkSfzfG8ldfZNNEyvDkZu0nYlkh
 N16OVTYOeAXnn2s3P7EvE+e7+Kf1HcKO8FZ51QueQJNtAmz1ggAL6EEH2YFVJB3lzvhpEemvIph
 yutK7bVS9/6bm0uMPNell38GOpI8=
X-Google-Smtp-Source: AGHT+IFUBN0bph+nnroOI8lnF4XESyHDeocMH0nd87cKhRmwWagSml0T4lVdTsMgoTmT83L7rTS/zFXR8AuCnIF6Lkw=
X-Received: by 2002:a05:6402:5207:b0:5c5:cf45:cca3 with SMTP id
 4fb4d7f45d1cf-5c8824ef73bmr2766179a12.7.1727452362209; Fri, 27 Sep 2024
 08:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240926223009.1270197-1-sjg@chromium.org>
In-Reply-To: <20240926223009.1270197-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 27 Sep 2024 16:50:15 +0100
Message-ID: <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
Subject: Re: [PATCH 00/27] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

> There has been an LED framework in U-Boot which uses driver model for
> about 9 years now. Recent work is underway to improve it and provide
> more features. It is probably a good time to drop the old code, which
> is only used by 5 boards:
>
>    ./tools/qconfig.py -f LED_STATUS
>    5 matches
>    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
>    socfpga_vining_fpga

Why aren't these boards being migrated to what ever the new frame work
is rather than dropping quite useful functionality on these devices?

> This series attempts that.
>
>
> Simon Glass (27):
>   led: Drop LED_STATUS_BOARD_SPECIFIC
>   arm: Drop old LED support
>   common: doc: Drop old LED support
>   st: stm32f429: Drop old LED code
>   led: Make the LED config common
>   eb_cpu5282: Drop STATUS_LED
>   mx23_olinuxino: Drop STATUS_LED
>   pinephone: Drop STATUS_LED
>   socfpga_vining_fpga: Drop STATUS_LED
>   led: Drop LED_STATUS from Kconfig
>   led: Drop the legacy LED command
>   misc: Drop gpio_led driver
>   pca9551_led: Delete driver
>   misc: status_led: Delete driver
>   m68k: Drop unused status_led.h header file
>   powerpc: Drop status-LED code
>   eb_cpu5282: Drop status-LED code
>   igep00x0: Drop unused status_led.h header file
>   mx23_olinuxino: Drop status-LED code
>   vining_fpga: Drop status-LED code
>   sunxi: Drop status-LED code
>   common: Drop status-LED code in board_r
>   image: Drop unused status_led.h header file
>   ide: Drop unused status_led.h header file
>   mpc83xx: Drop status-LED code
>   net: Drop status-LED code
>   led: Drop status_led header file
>
>  arch/arm/lib/crt0.S                          |   4 -
>  arch/m68k/lib/bootm.c                        |   3 -
>  arch/powerpc/lib/interrupts.c                |   6 -
>  board/BuS/eb_cpu5282/eb_cpu5282.c            |  20 --
>  board/isee/igep00x0/igep00x0.c               |   1 -
>  board/olimex/mx23_olinuxino/mx23_olinuxino.c |   7 -
>  board/softing/vining_fpga/socfpga.c          |   4 -
>  board/st/stm32f429-discovery/Makefile        |   1 -
>  board/st/stm32f429-discovery/led.c           |  39 ---
>  board/sunxi/board.c                          |   6 -
>  boot/image.c                                 |   4 -
>  cmd/Makefile                                 |   1 -
>  cmd/ide.c                                    |   4 -
>  cmd/legacy_led.c                             | 185 ----------
>  common/board_f.c                             |  22 --
>  common/board_r.c                             |  16 -
>  configs/eb_cpu5282_defconfig                 |   6 -
>  configs/eb_cpu5282_internal_defconfig        |   6 -
>  configs/mx23_olinuxino_defconfig             |   8 -
>  configs/pinephone_defconfig                  |   5 -
>  configs/socfpga_vining_fpga_defconfig        |  11 -
>  doc/README.LED                               |  77 -----
>  drivers/led/Kconfig                          | 342 +------------------
>  drivers/misc/Kconfig                         |  13 -
>  drivers/misc/Makefile                        |   3 -
>  drivers/misc/gpio_led.c                      | 106 ------
>  drivers/misc/pca9551_led.c                   | 170 ---------
>  drivers/misc/status_led.c                    | 124 -------
>  drivers/timer/mpc83xx_timer.c                |   5 -
>  include/configs/eb_cpu5282.h                 |   6 -
>  include/status_led.h                         | 102 ------
>  net/bootp.c                                  |   7 -
>  net/net.c                                    |  33 --
>  33 files changed, 11 insertions(+), 1336 deletions(-)
>  delete mode 100644 board/st/stm32f429-discovery/led.c
>  delete mode 100644 cmd/legacy_led.c
>  delete mode 100644 doc/README.LED
>  delete mode 100644 drivers/misc/gpio_led.c
>  delete mode 100644 drivers/misc/pca9551_led.c
>  delete mode 100644 drivers/misc/status_led.c
>  delete mode 100644 include/status_led.h
>
> --
> 2.43.0
>
