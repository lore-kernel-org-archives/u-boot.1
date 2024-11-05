Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9994D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D9B88FCC;
	Tue,  5 Nov 2024 16:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwTqhKfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258618919D; Tue,  5 Nov 2024 15:18:20 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA0889070
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 15:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539f72c913aso8918756e87.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730816297; x=1731421097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B8/1rrncbtaVYrVuI47vQflZIOSS+jJo/pj4Vokq6FQ=;
 b=TwTqhKfTVwGOXEFk7uzxLFLGHpOE56KnC8wlkbdp5cNjHtn2jG368QdFj8iT1FaDk+
 6pHycBQ4i6+1l9eddKlNPxWn/Ci78NLsYS8TRY29Ob0+NjTgT63VwcTbox2Qrk0g39Hq
 fOGPlllLCmpHcbG2eGtx7yFSma6x2ShCtNS3S9boFodYsMFtQabGwVFRrHlyl9E0aNvK
 cVGk2sH9kBIgbj4T7J2j28V4s/K8jA1Jx4Zz4xLsCZYb18CgMiiA6mL56tfn8R8u7eWg
 j0JH9oezR2PqKjZlmp0GCfmD0jRfsHel+BAEcWO3qKievD+CKaPb7Wfw9TcEoHs6McLY
 RGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816297; x=1731421097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B8/1rrncbtaVYrVuI47vQflZIOSS+jJo/pj4Vokq6FQ=;
 b=RkLr74W1li28N59GK8urmXkUSBQDvW3f7qFllYc8LPutrCEb8ZrHKi08KwcwSl6O+P
 zjjhtWbakAydzAMfV87Rnpu7sCxnz5aVMRQC/hrLEMW95vaWrlXDe2cIOLjSG6N3+Eix
 4CDYc6zlKJ+Y6iNEehdzVnEZr7aoPZeq9uk7HO2d+IYAjBpmoZcOMFNIPOvAechp3hxu
 URSZhEbp2efIYI8lexurNNvnTSuF79YI3BhSnl/OvcvEiYdkjTTOl0RxTGkzMpj7czyk
 E5acj3EGUTjGjuI/rJrIkSzIkUJ/otUphVWiEqtJT8kb6GuE1WDAkh3taVmOa850kQKp
 J0mg==
X-Gm-Message-State: AOJu0YwVLBKcuI6nC0DYDY23STHNTPc46CHFiiGtwQ/u5tS3Q35Zy1+s
 YUOfymVv36U4fDW2RBl2tBToOxfehJ+K6BFToNq9zpabBaZPBhJfAdXEsJISgJAP/QIwMnLPksR
 +43rA8Q8TYfp2AgwJs27vJGvyHYg=
X-Google-Smtp-Source: AGHT+IFR3u9G4Brkza8zFIJwpSli83HjLaKrHBaFzotHgeScNAaI8f3AHjEqMhw1IaIjf88FSBaYgdNaduLYrONp9gQ=
X-Received: by 2002:a2e:bc1d:0:b0:2fa:d317:b777 with SMTP id
 38308e7fff4ca-2fcbdf6882emr182698661fa.2.1730816296976; Tue, 05 Nov 2024
 06:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Nov 2024 14:18:05 +0000
Message-ID: <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jens Scharsig <esw@bus-elektronik.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 05 Nov 2024 16:54:11 +0100
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

On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
>
> There has been an LED framework in U-Boot which uses driver model for
> about 9 years now. Recent work is underway to improve it and provide
> more features. It is probably a good time to drop the old code, which
> is only used by 5 boards:

I don't believe, from what I can tell, they are feature comparable, at
the very least I have not been able to get the Pinephone working with
this so as it stands I still don't think this patch set is ready yet.

>    ./tools/qconfig.py -f LED_STATUS
>    5 matches
>    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
>    socfpga_vining_fpga
>
> This series attempts that.
>
> The new /options node provides a way to provide U-Boot settings, and
> LEDs are implemented there. For now I have brought into the options
> schema from upstream. We can update it once the LED additions land
> there.
>
> Changes in v3:
> - Update commit message
> - Combine removal and enable patches
> - Combine removal and enable patches
> - Combine removal and enable patches
>
> Changes in v2:
> - Combine code-removal and defconfig changes
> - Add a patch to enable LED and LED_BOOT for these boards
> - Enable LED on the 5 affected platforms
> - Reorder patches for bisectability
> - Add dt-schema bindings for LED
>
> Simon Glass (25):
>   eb_cpu5282: Drop status-LED code and enable LED
>   vining_fpga: Drop status-LED code and use LED
>   mx23_olinuxino: Drop status-LED code and use LED
>   pinephone: Drop status-LED code and use LED
>   led: Drop LED_STATUS_BOARD_SPECIFIC
>   arm: Drop old LED support
>   common: doc: Drop old LED support
>   st: stm32f429: Drop old LED code
>   led: Make the LED config common
>   led: Drop LED_STATUS from Kconfig
>   led: Drop the legacy LED command
>   misc: Drop gpio_led driver
>   pca9551_led: Delete driver
>   misc: status_led: Delete driver
>   m68k: Drop unused status_led.h header file
>   powerpc: Drop status-LED code
>   igep00x0: Drop unused status_led.h header file
>   sunxi: Drop status-LED code
>   common: Drop status-LED code in board_r
>   image: Drop unused status_led.h header file
>   ide: Drop unused status_led.h header file
>   mpc83xx: Drop status-LED code
>   net: Drop status-LED code
>   led: Drop status_led header file
>   doc: Add devicetree bindings for options
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
>  common/board_r.c                             |  27 --
>  configs/eb_cpu5282_defconfig                 |   8 +-
>  configs/eb_cpu5282_internal_defconfig        |   8 +-
>  configs/mx23_olinuxino_defconfig             |  10 +-
>  configs/pinephone_defconfig                  |   7 +-
>  configs/socfpga_vining_fpga_defconfig        |  13 +-
>  doc/README.LED                               |  77 -----
>  doc/device-tree-bindings/options.yaml        |  79 +++++
>  doc/device-tree-bindings/options/u-boot.yaml | 136 ++++++++
>  drivers/led/Kconfig                          | 342 +------------------
>  drivers/misc/Kconfig                         |  13 -
>  drivers/misc/Makefile                        |   3 -
>  drivers/misc/gpio_led.c                      | 106 ------
>  drivers/misc/pca9551_led.c                   | 170 ---------
>  drivers/misc/status_led.c                    | 124 -------
>  drivers/timer/mpc83xx_timer.c                |   5 -
>  include/configs/eb_cpu5282.h                 |   6 -
>  include/status_led.h                         | 115 -------
>  net/bootp.c                                  |   7 -
>  net/net.c                                    |  33 --
>  35 files changed, 236 insertions(+), 1360 deletions(-)
>  delete mode 100644 board/st/stm32f429-discovery/led.c
>  delete mode 100644 cmd/legacy_led.c
>  delete mode 100644 doc/README.LED
>  create mode 100644 doc/device-tree-bindings/options.yaml
>  create mode 100644 doc/device-tree-bindings/options/u-boot.yaml
>  delete mode 100644 drivers/misc/gpio_led.c
>  delete mode 100644 drivers/misc/pca9551_led.c
>  delete mode 100644 drivers/misc/status_led.c
>  delete mode 100644 include/status_led.h
>
> --
> 2.43.0
>
