Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EFE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AEC8036B;
	Thu,  9 Jan 2025 13:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yv6DVwA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE72801FD; Thu,  9 Jan 2025 13:30:32 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B05C8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so2064395ab.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425827; x=1737030627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDkYx12ePZoNyHjx2afcci7uXowRIrdNtgR9loJXIbw=;
 b=Yv6DVwA5RYpfQ0jz5oge8NoPi++mIYRkkKJC52A/LbqCWMB2NWvJUUmb7T1LOzSK1b
 31GlsAVrzv2crW8G1z5ZFmOlP6sCNIzJ1N6G25RbOaq408HMskiMKwrM+axc4VwbD+Wp
 cpxT02er1pU8w45es/7VvrjZcL4+UN1O96omw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425827; x=1737030627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDkYx12ePZoNyHjx2afcci7uXowRIrdNtgR9loJXIbw=;
 b=KNNbRjL4mwj28oucNrH6OG25OG8UGH5rf4CXOviSii846vim7Gv1b5McZ+k4419JdF
 Y/OcxgX53TRzKqrDa92zaLrfIASC+KyNctPfBZvGSMkDlTxFRX01ujqo+XRT2lF67RhP
 /GQyfNDPheyl93C0M2jzCTqgBLMNNlPThhv90G45PYMpVeNk2bxWmN8Porz7da5MIjjN
 wXjcFN1LygkfIQ1Ya7kF2i5xqg5eZz/0fMVdPIblvP8x91eHGrPF/BuLQDOYcwfEmNza
 xIb4OjwSrNBXwwv1lmBP3MukLjK9RVEAWKZVSwrLTVAETm6ITq4MX8AauPx+BAzb4tJq
 wFhg==
X-Gm-Message-State: AOJu0YyGKpzRCQk3glrAgHnqDBX/4rjDUGONaxz9cnYxUiaq88tRCrtG
 yytuTR2isz44DVs2c5hE2rVjxq0hqeaS3OqXzcyrgrptqdav2RISby6mzj2xFXgZh4Zno+K6GdU
 =
X-Gm-Gg: ASbGnct2xEm7hZ4SROTKwUombW10+/nDLj7gtPFa/8s5dLHWehC361eiu+kmVEOVNJL
 exIzFPxAGx6g6fIE7S4PHbNUnLmG26R77FoAXShNUTIBBqKOcba7TZ2hPYgz60EikFyHSkaKGQ/
 9FYO7LQk2lV77LI2DNoFovHSzztWGmCswV3121cgiuOnHJ/t9T/+rH/uY3cIP53XLKITD+CoyRq
 +DHoyBTquQYRdwK9lF4JOlXwx7zj9SHrNcOLkkC+mkPW5mVICQomijHDuFxWsOSoTmef6q99HnR
 6ZxO0EicAt5BdyTbaQ==
X-Google-Smtp-Source: AGHT+IFqjFzXg+gsELxdoBn/eZMeqCMHvWXB5SVTC0Yan6NZ5oc8AiWONhRKegVt9hn2ir/SSTZeRw==
X-Received: by 2002:a05:6e02:1fcb:b0:3ab:a274:d68 with SMTP id
 e9e14a558f8ab-3ce3a9b59b3mr50371965ab.8.1736425827067; 
 Thu, 09 Jan 2025 04:30:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 00/15] vbe: Series part F
Date: Thu,  9 Jan 2025 05:29:55 -0700
Message-Id: <20250109123010.4005298-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot. It mostly focuses on introducing a relocating
SPL-loader so that VBE can run in the limited amount of SRAM available
on many devices.

Another minor new feature is support in VBE for specifying the image
phase when loading from a FIT. This allows a single FIT to include
images for several boot phases, thus simplifying image-creation.

One lingering niggle in this series is that it has a different code path
for sandbox, since it does not support the relocating jump. It should be
possible to resolve this with additional work, but I have not attempted
this so far.

Again, only MMC is supported so far.

Looking ahead, series G will have some more plumbing and H some rk3399
pieces. That should be enough to complete these feature.

Here is a run in my lab, with the VBE ABrec bootmeth. You can see that
VPL runs before memory is set up. SPL sets up memory and can be upgraded
in the field reliably.

$ ub-int vbe
Building U-Boot in sourcedir for rk3399-generic
Bootstrapping U-Boot from dir /tmp/b/rk3399-generic
Writing U-Boot using method rockchip

U-Boot TPL 2025.01-rc3-00345-gdfbdbf1eb56c-dirty (Jan 08 2025 - 10:47:58)
Trying to boot from vbe_abrec
load: Firefly-RK3399 Board
   Using 'config-3' configuration
   Trying 'image-vpl' firmware subimage
   Using 'config-3' configuration
   Trying 'fdt-3' fdt subimage

U-Boot VPL 2025.01-rc3-00345-gdfbdbf1eb56c-dirty (Jan 08 2025 - 10:47:58)
Trying to boot from vbe_abrec
load: Firefly-RK3399 Board
Starting with empty state
VBE: Firmware pick A at 800000
   Using 'config-3' configuration
   Trying 'spl' firmware subimage
   Using 'config-3' configuration
   Trying 'fdt-3' fdt subimage
Channel 0: DDR3, 800MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
Channel 1: DDR3, 800MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
256B stride

U-Boot SPL 2025.01-rc3-00345-gdfbdbf1eb56c-dirty (Jan 08 2025 - 10:47:58 -0700)
Trying to boot from vbe_abrec
load: Firefly-RK3399 Board
VBE: Firmware pick A at 900000
load_simple_fit: Skip load 'atf-5': image size is 0!
Relocating bloblist ff8eff00 to 100000: done
ns16550_serial serial@ff1a0000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

U-Boot 2025.01-rc3-00345-gdfbdbf1eb56c-dirty (Jan 08 2025 - 10:47:58 -0700)

SoC: Rockchip rk3399
Reset cause: POR
Model: Firefly-RK3399 Board
DRAM:  4 GiB (effective 3.9 GiB)
Core:  314 devices, 33 uclasses, devicetree: separate
MMC:   mmc@fe310000: 3, mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from SPIFlash... Invalid bus 0 (err=-19)
*** Warning - spi_flash_probe_bus_cs() failed, using default environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Firefly-RK3399 Board
Net:   PMIC:  RK808
eth0: ethernet@fe300000

starting USB...
Bus usb@fe380000: USB EHCI 1.00
Bus usb@fe3a0000: USB OHCI 1.0
Bus usb@fe3c0000: USB EHCI 1.00
Bus usb@fe3e0000: USB OHCI 1.0
Bus usb@fe900000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
scanning bus usb@fe380000 for devices... 1 USB Device(s) found
scanning bus usb@fe3a0000 for devices... 1 USB Device(s) found
scanning bus usb@fe3c0000 for devices... 2 USB Device(s) found
scanning bus usb@fe3e0000 for devices... 1 USB Device(s) found
scanning bus usb@fe900000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0



Simon Glass (15):
  vbe: Split out some VBE code into a common file
  vbe: Split out reading a FIT into a common file
  vbe: Allocate space for the FIT header
  vbe: Allow VBE to load FITs on any architecture
  vbe: Tidy up error checking with blk_read()
  vbe: Handle loading from an unaligned offset
  vbe: Allow loading loadables if there is no firmware
  vbe: Support loading an FDT from the FIT
  spl: Add fields for VBE
  spl: Add a type for the jumper function
  spl: Add support for a relocating jump to the next phase
  spl: Plumb in the relocating loader
  vbe: Support loading an FDT with the relocating loader
  vbe: Support loading SPL images
  vbe: Update simple-fw to support using the SPL loader

 boot/Makefile          |   2 +-
 boot/vbe_common.c      | 362 +++++++++++++++++++++++++++++++++++++++++
 boot/vbe_common.h      | 173 ++++++++++++++++++++
 boot/vbe_simple.c      |  99 +++--------
 boot/vbe_simple.h      |  15 +-
 boot/vbe_simple_fw.c   | 207 +++++++++--------------
 common/spl/Kconfig     |   8 +
 common/spl/Kconfig.tpl |   8 +
 common/spl/Kconfig.vpl |   8 +
 common/spl/Makefile    |   1 +
 common/spl/spl.c       |  15 +-
 common/spl/spl_reloc.c | 183 +++++++++++++++++++++
 include/spl.h          |  90 +++++++++-
 13 files changed, 948 insertions(+), 223 deletions(-)
 create mode 100644 boot/vbe_common.c
 create mode 100644 boot/vbe_common.h
 create mode 100644 common/spl/spl_reloc.c

-- 
2.34.1

