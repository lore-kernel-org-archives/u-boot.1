Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B2C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 10:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD05E87985;
	Tue, 16 Jan 2024 11:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F3nTXt1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C6E879A0; Tue, 16 Jan 2024 11:10:03 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE10587978
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 11:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so9816265f8f.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705399800; x=1706004600;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfXik451vY2/MGleVHDMoSYjlBU6uKIngQT9kWCmqi4=;
 b=F3nTXt1C7vo/q7mEamplSlhJ2qgIb5K6TZigV9ldCeLInzegeq0u2+tZtof0alQIkr
 r1G9s9X+mZ9BtaidTkwrs4wvu81XUJrl/dRtXeUJVit85vBw77yTR3QmkIRrbzbLPr9X
 N5xjpP5bz+252SwGvsWZ9VzXgubNNn9lyDo3ec0NtTDHiSex79xxdpBydmW0AqId7Z+0
 xrVY3eu3WAFhUhA6qudCxH6wc4i5Y6uD3iWd5zweUhz2GvsBVRUVh+fNCxqsBrrBcLpb
 08jNHJmCGnd3YGZhzx3RuYz1+TX+BVnvxRqizzzyx4+Yt74jdxU0NAftd7D9toE1Fcp6
 r+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705399800; x=1706004600;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfXik451vY2/MGleVHDMoSYjlBU6uKIngQT9kWCmqi4=;
 b=BI6bnG7gmndfKM3U+QYWPbl6khLic/ZVCRGgqJVdREYFD4nRqelBInmTaFUWLkzseW
 47DLX3eD5Q2rAvkWw2lF9zX3RfxF+46iqgaeTkP0pYvJKcplid2V5Qe8wwE0waQoLu0F
 VoFEak74vMkfV7mdJgiInoFhtEYDxBBQQbE//PqkGktcSRyzYv7xNFyFcOCbbHnFRlT5
 LyhFUOrcFP+j9kdWDOQPTJ4t5EJyyAhOBvqlM7jBWKtz7d5CSKKGD+XJTau3L1TXdI0C
 GQmj0BASUuA5YITM71UUVQhewHrhZLvimC0N58sz4ONfL9l6k+RR6u/RpufTCTzzQs3k
 /gxQ==
X-Gm-Message-State: AOJu0YzdiprwQwOgUWwDgOyvCAgwvHzGGvt4p2wYlKkIjbKL1RPWoEce
 JIGKPUs13MLrQkEqE81Lm4E/15cA5xv20A==
X-Google-Smtp-Source: AGHT+IEQ86H7tj/DwR/DUX2dF4imqUBlhpk+nIeLoPf5FCiwdIC8dzXdsO8NmoGEpasxJgQuegDGPA==
X-Received: by 2002:a5d:598a:0:b0:337:aa5c:60f9 with SMTP id
 n10-20020a5d598a000000b00337aa5c60f9mr993337wri.97.1705399800118; 
 Tue, 16 Jan 2024 02:10:00 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 j21-20020a5d6e55000000b0033672cfca96sm14198057wrz.89.2024.01.16.02.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:09:59 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Prusov
 <ivprusov@salutedevices.com>, Jan Kiszka <jan.kiszka@siemens.com>, Judith
 Mendez <jm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut
 <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nikhil M Jain
 <n-jain1@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Praneeth
 Bajjuri <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/7] Add DFU and usb boot for TI am62x SK and beagleplay
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 11:09:58 +0100
Message-ID: <87sf2x4mix.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sjoerd,

Thank you for the series.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> This series adds DFU support for TI AM62 SK board and new since this
> version also for beagleplay.
>
> Since the last revision, apart from beagleplay support the main changes
> are:
> * Documentation was added on how to use this functionality on both boards
> * the R5 configuration is now done via a config fragment rather
>   then a full configuraiton
> * A new patch was added for dwc3 to work in device mode even if dr_mode is
>   configured as otg. Avoiding the need for an explicit switch to
>   periphal in the u-boot dts

I've tested on Beagle Play that I could load/recover the board via
snagboot:

U-Boot SPL 2023.04 (Sep 27 2023 - 11:19:48 +0200)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
SPL initial stack usage: 13392 bytes
Trying to boot from DFU
##########################################DOWNLOAD ... OK
Ctrl+C to exit ...
##########################################DOWNLOAD ... OK
Ctrl+C to exit ...
Loading Environment from nowhere... OK
init_env from device 10 not supported!
Starting ATF on ARM64 core...

NOTICE:  BL3'.9(release):d7a7135d32a8
NOTICE:  BL31: Built : 10:53:52, Jan 16 2024

U-Boot SPL 2024.01-14350-g416e52ada83a (Jan 16 2024 - 10:54:58 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
SPL initial stack usage: 1888 bytes
Trying to boot from DFU


U-Boot 2024.01-14350-g416e52ada83a (Jan 16 2024 - 10:54:58 +0100)

SoC:   AM62X SR1.0 GP
Model: BeagleBoard.org BeaglePlay
DRAM:  2 GiB
Core:  104 devices, 29 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   No ethernet found.

Press SPACE to abort autoboot in 2 seconds


I've also tested (from the DFU'd U-Boot) that I could scan for usb keys:
=> usb start
[..]
1 USB Device(s) found

So for the series:
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on beagle play

>
> I will also submit the dts changes to linux so that those can be dropped
> again in the near future (hopefully)
>
> Changes in v4:
> - Add config dependency on SYSCON
> - Move defines and constants outside out of function scope
> - Don't force usb0 into peripheral mode
> - Move R5 dfu config to a config fragment rather then a full defconfig
> - Don't enable XHCI for the R5 SPL, unneeded
>
> Change in v3:
> - Add dfu via environment rather then config headers
> - Enable usb nodes in all boot phases
> - Run savedefconfig to adjust to more recent u-boot
>
> Changes in v2:
> - Switch dwc3 glue to a seperate driver rather then in dwc-generic
> - Minimize config changes to just DFU configuration
> - Only enable usb port 0 DFU in SPL
> - Create a seperate defconfig for R5
>
> Sjoerd Simons (7):
>   usb: dwc3: Add dwc3 glue driver for am62
>   usb: dwc3: Switch to device mode on gadget start
>   board: ti: am62x: am62x: include env for DFU
>   arm: dts: k3-am625-sk: Enable usb port in u-boot
>   configs: am62x_evm_*: Enable USB and DFU support
>   beagleplay: Add DFU support
>   doc: board: Add document for DFU boot on am62x SoCs
>
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |   8 ++
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi         |   8 ++
>  board/beagle/beagleplay/beagleplay.env       |   1 +
>  board/ti/am62x/am62x.env                     |   1 +
>  configs/am62x_beagleplay_a53_defconfig       |  30 +++++
>  configs/am62x_evm_a53_defconfig              |  30 +++++
>  configs/am62x_r5_usbdfu.config               |  28 +++++
>  doc/board/beagle/am62x_beagleplay.rst        |  12 ++
>  doc/board/ti/am62x_sk.rst                    |  37 ++++++
>  drivers/usb/dwc3/Kconfig                     |  14 +++
>  drivers/usb/dwc3/Makefile                    |   1 +
>  drivers/usb/dwc3/core.c                      |  10 +-
>  drivers/usb/dwc3/core.h                      |   1 +
>  drivers/usb/dwc3/dwc3-am62.c                 | 125 +++++++++++++++++++
>  drivers/usb/dwc3/gadget.c                    |   6 +
>  15 files changed, 307 insertions(+), 5 deletions(-)
>  create mode 100644 configs/am62x_r5_usbdfu.config
>  create mode 100644 drivers/usb/dwc3/dwc3-am62.c
>
> -- 
> 2.43.0
