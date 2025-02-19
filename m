Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA6BC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 19:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09DC1801BE;
	Wed, 19 Feb 2025 20:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FLcmbAXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822AC801CF; Wed, 19 Feb 2025 20:37:47 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA7D800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 20:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so221980a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739993864; x=1740598664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/6KANU477ajl97UXTdLnDw1ol98sD0T83p+24bXaqmU=;
 b=FLcmbAXxkCPJgMmDRLVFrJIprBWY628+TVO6QmAEF5xbDz0Pw8hcdWNERf+FdfoLrw
 OR5qrOEVU93Hqqkvf+8O9+Sp5SUVXYlWjMMdtAvrwd7twSUooq18eZJyBN7VWgqpl1+V
 VOg3ROrKxfJE2m3WP6ODh3CUnJk3mKMjYS8YYfDrfJfH9wIfi/ee3ydlLAC89IEC3B74
 7yeMsNPFbTZidD6sFMoBuxQaQ0+YQEdA9zcFDSTP17Nve7QBm9LXY4XGfHrVGPrhi4xw
 3Kfi9ffEQESO3MAcWSVjzXc7fnBWysq1e4xCQeBSudYoQl23L8fztCKX735f3vaZWzRk
 u6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993864; x=1740598664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/6KANU477ajl97UXTdLnDw1ol98sD0T83p+24bXaqmU=;
 b=shxUyOAKmH3Ofbgft14EGT2hbFBzJfUwYaU0m0V2n06P68fs9tAGWQ2f0HmR4By7qV
 WcyL1zrmT1Dn6U3NWCAQ1do0QxZESi32jFHJrzDQ3vzc+uSFEcOvXdpOHglADLZYOKpK
 TUYPDzIHQePs4DpIW5Cuj4PETL8JpiVLvaOZoqrZyufIdVuZXo4JadARNOWaxDtd8lkk
 3m+59sfLyofMwhzsuZHh1d1puCOdBkgJZhTuN2DRrxQgvkWmQjl+InvIpU1XCZwOdaXb
 unkNaBBQ3GfGFT99ROu5oitQUWZ55bjbYokqL8+2m89TgLiP3JULeYITdC5i+fNR3GXC
 Bwww==
X-Gm-Message-State: AOJu0YzQNGze7+QlkhFsHWc5PvhKnJZRX2pJ8y5TKB3ogj7cwwBe7619
 lJgyvW1L6yru5e6PRgcqgq8RU9jDrvOfAQIv03qlA+1DQZPffQiec4ibBi36x1/KAKmsmK/ls1f
 uHs0c0W/DH8UvfU+X6UNhk1n/ZV8=
X-Gm-Gg: ASbGncvpmypuceZjJDHTTBzBeFP2rjKypWK9UV42f+9qHuBGDKxRtsfmcI72ZKZ9cYK
 Lkcj94W+bbyZBubz2Tb43KSjuZndfGcrJn+p8DKh0lfZavw/5X1RPMvDEiTvYH+Y1QngPgnW5I7
 WZx5vZSDDREqb+MbPn4uDdo15Xm3LSnw==
X-Google-Smtp-Source: AGHT+IESPx8PdtNfdDeq0qtUIgN/F2YvOLkC2z2WdQC67bpUEPLmh7BFR+HzamfANKjwe3UKezyp1usVeQyCpo4wqgw=
X-Received: by 2002:a05:6402:a001:b0:5e0:4408:6bcf with SMTP id
 4fb4d7f45d1cf-5e04408718bmr13986576a12.10.1739993863896; Wed, 19 Feb 2025
 11:37:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 19 Feb 2025 19:37:31 +0000
X-Gm-Features: AWEUYZlGV0QX0yttFdCBP8-d5CeoqXL1IeUXFKZ85XHTuKGEph9WGh2eYXVMgxY
Message-ID: <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>,
 Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Oleksii,

I've started to look at this.

On Wed, 5 Feb 2025 at 10:15, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
wrote:

> This patch series provides generic support for Raspberry PI 5 in
> U-Boot with additional hardware drivers.
> The following features were implemented:
> 1) add generic board config for Raspberry PI5 including device-tree
> files;
>

We already have basic support for the RPi5 since Jan last year, you can see
the patches [1]. This serious should build on that rather than add new
duplicated bits. It supports basic serial and mSD support.


> 2) add support for RP1 chip with additional hardware;
> 3) add support for rp1-clock driver with dt-bindings update;
> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> 5) add clock/reset/gpio drivers;
> 6) add ethernet support in u-boot.
>

I'll review and test the rest in the context of the existing support.

[1] https://lists.denx.de/pipermail/u-boot/2024-January/543011.html


> This patch-series introducing the basic set of supported drivers in
> U-Boot which allows using such features as tftp and\or NFS.
> I've posted this patch series as RFC because of the following commit:
> e51ca0d221 (HACK: drivers: mfd: set bar configuration for RP1 driver,
> 2024-05-21)
>
> It includes HACK for rp1 driver in u-boot. This HACK is setting bar
> address in the correct order because RP1 driver in Linux Kernel rely on
> the pci BAR configuration which initializes BARs based on BAR size.
> This results the Linux set BARs in the same order on each boot.
> U-boot does initialization without any sorting so the configuration
> may be different from the Linux kernel.
> BAR address configuration is set to match the Linux Kernel order
> to avoid fails on address translation.
>
> This should be changed after upstreaming RP1 driver to the Linux kernel
> mainline.
>
> Probably somebody from Raspberry will post an advise about how this
> can be properly done.
> U-Boot support for Raspberry PI 5 was added in terms of the following
> project: https://github.com/xen-troops/meta-xt-prod-devel-rpi5
> This is xen-based dom0less system on the Raspberry PI 5 with Zephyr as
> Control Domain and Linux is Driver Domain.
>
> It is Yocto-based so it will be easy to build it on your side. Please
> visit link for the details.
>
>
>
> Oleksii Moisieiev (17):
>   include: dt-bindings: clk: introduce bindings for rp1 clock
>   include: dt-bindings: mfd: introduce bindings for RP1 driver
>   arch: arm: mach-bcm283x: add pcie memory region to BCM2712 memmap
>   arch: arm: mach-bcm283x: add BCM2712 board support
>   drivers: net: macb: do not include arch/clk.h when clocks enabled
>   drivers: core: of_addr: fix of_get_dma_range translation
>   board: raspberrypi: rpi: save board_type to the global_data
>   drivers: pci: add BCM2712 support for pcie_brcmstb driver
>   drivers: mfd: introduce RP1 chip driver for RPI5
>   drivers: gpio: add support of RP1 GPIO for Raspberry PI 5
>   drivers: reset: introduce reset drivers for brcmstb
>   drivers: clk: introduce clock driver for RP1
>   drivers: net: macb: introduce ePCI connection support for macb
>   configs: add support for the Raspberrypi 5 board to default config
>   HACK: drivers: mfd: set bar configuration for RP1 driver
>   drivers: pci: pcie_brcmstb: use bus_base to config PCI device
>   drivers: pci: pcie_brcmstb: set correct reset state on pcie_remove
>
> Volodymyr Babchuk (3):
>   drivers: pci: take into account that ofnode_read_pci_vendev can fail
>   board: raspberrypi: rpi: request RP1 in late_init
>   bcm2712: enable linux kernel image header
>
>  arch/arm/mach-bcm283x/Kconfig        |   8 +
>  arch/arm/mach-bcm283x/init.c         |  10 +-
>  board/raspberrypi/rpi/rpi.c          |  28 ++
>  configs/rpi_arm64_defconfig          |  19 ++
>  drivers/clk/Kconfig                  |   7 +
>  drivers/clk/Makefile                 |   1 +
>  drivers/clk/clk-rp1.c                | 280 ++++++++++++++++++++
>  drivers/core/of_addr.c               |   8 +-
>  drivers/gpio/Kconfig                 |   7 +
>  drivers/gpio/Makefile                |   1 +
>  drivers/gpio/rp1_gpio.c              | 374 +++++++++++++++++++++++++++
>  drivers/mfd/Kconfig                  |  10 +
>  drivers/mfd/Makefile                 |   1 +
>  drivers/mfd/rp1.c                    | 134 ++++++++++
>  drivers/net/Kconfig                  |   1 +
>  drivers/net/macb.c                   | 156 ++++++++---
>  drivers/net/macb.h                   |  16 ++
>  drivers/pci/pci-uclass.c             |   9 +-
>  drivers/pci/pcie_brcmstb.c           | 328 +++++++++++++++++++++--
>  drivers/reset/Kconfig                |  14 +
>  drivers/reset/Makefile               |   2 +
>  drivers/reset/reset-brcmstb-rescal.c | 103 ++++++++
>  drivers/reset/reset-brcmstb.c        |  97 +++++++
>  include/broadcom/bcm_board_types.h   |  25 ++
>  include/dt-bindings/clk/rp1.h        |  56 ++++
>  include/dt-bindings/mfd/rp1.h        | 239 +++++++++++++++++
>  include/pci_ids.h                    |   3 +
>  27 files changed, 1882 insertions(+), 55 deletions(-)
>  create mode 100644 drivers/clk/clk-rp1.c
>  create mode 100644 drivers/gpio/rp1_gpio.c
>  create mode 100644 drivers/mfd/rp1.c
>  create mode 100644 drivers/reset/reset-brcmstb-rescal.c
>  create mode 100644 drivers/reset/reset-brcmstb.c
>  create mode 100644 include/broadcom/bcm_board_types.h
>  create mode 100644 include/dt-bindings/clk/rp1.h
>  create mode 100644 include/dt-bindings/mfd/rp1.h
>
> --
> 2.34.1
>
