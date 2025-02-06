Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E575C02198
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 15:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBAA80B98;
	Thu,  6 Feb 2025 16:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y520wz/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5CB80BA0; Thu,  6 Feb 2025 16:58:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD7980840
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so201735466b.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738857504; x=1739462304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PLH8wQzmLUY5ggGN6XpgKvcl8EIPE6bg5fxQApcFZ34=;
 b=Y520wz/MSHUd0LnH/i+Wal8Q/s4XnitQ1qMy+8tYIXhdrpxlXhebjFi0RpJXAk2QfO
 663JeRocaIckdI5+5Fm1U8N8/5ocoeCD3MP751WtgLLVUVC45KmBxV6iarEry6nPUEO7
 joVHOwqS3tbmiQ4Mout8zDbOc7tLIVSTBe650=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738857504; x=1739462304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PLH8wQzmLUY5ggGN6XpgKvcl8EIPE6bg5fxQApcFZ34=;
 b=JkMAJ7G+X7CHfHgqjaOy3UE4VIDeozirzrzJ14YoKaicIhHlHja0gVcDtFVDi4fYhO
 kr0sZiXGR0OBuVk+lJeJqA/r4SHatjBPaP3vC3Y8krp9z8O6UuQu+FZmGynHQahwuelI
 wvMSbEGekWGXsBISZ+gA1rUhA90ibZytXhSHmFccF1Rr7VSNbLGC5TWEZViQvo2JemRY
 ZExGsbOz4Sa7SphH6va5ijA6XqOXkJJreMi13jsP9r4GB2sJDfqWp2viZAY6aOpRHC9U
 YpnIorEnHIku3RytCffj7LafZl06jQR4DJzq1ZMvXED3HJxRSSX2BzsLpzD6q/wQBXA2
 wGiA==
X-Gm-Message-State: AOJu0Yy97EhrsxgoTJsubV3hIyptvyVoQigt+TZcI3BJT28reesIgDGo
 D6mIVs3fYevO1BDp3aOYqYt8Sdh2iQaJp524R7nvedUZ3f0dZQgavdRXqiMTH2ZILLVkDVYASlB
 5mWXfotFavV+5uhSPGfrSPN3P8CaihnzJGlAA
X-Gm-Gg: ASbGncv5l53cT5Iecepm3eTh997G0tqUT7xmbtqHQ8Sisk6Ej03IblIdPC1CSchCTig
 SxECyRojNEIfb4xV59P4b56dG5v/h2LHXZ5RCwQc4W0+3KKj/s7ehC2vUz1AoRK/JGt4k6YOJMw
 ==
X-Google-Smtp-Source: AGHT+IGbgQ6xQcZSmwJsegxd3PHe0ICADrm5BgbzViFP1KLskg6+U5kY/YBBOEKSRcL4kk/KNGwXtds8dXGVUnmrHjk=
X-Received: by 2002:a17:907:7d90:b0:aaf:74d6:6467 with SMTP id
 a640c23a62f3a-ab75e347a2dmr823384866b.42.1738857503602; Thu, 06 Feb 2025
 07:58:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
 <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
In-Reply-To: <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 08:58:12 -0700
X-Gm-Features: AWEUYZkuh1dOh5gpoicIuH3CyhwjxypvUen-N2whw_0_BOodn3HKweXBFTGiYk8
Message-ID: <CAFLszTjh8qd0ycyqafHUaBuBS0Lhgtp0763FUER6PO_QAw4JdQ@mail.gmail.com>
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
 Peter Robinson <pbrobinson@gmail.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
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

Hi Oleksii,

On Thu, 6 Feb 2025 at 05:46, Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:
>
> Hi Simon.
>
> Please see below.
>
> -- Oleski
>
> On 06/02/2025 14:31, Simon Glass wrote:
> > Hi Oleksii,
> >
> > On Wed, 5 Feb 2025 at 03:15, Oleksii Moisieiev
> > <Oleksii_Moisieiev@epam.com> wrote:
> >> This patch series provides generic support for Raspberry PI 5 in
> >> U-Boot with additional hardware drivers.
> >> The following features were implemented:
> >> 1) add generic board config for Raspberry PI5 including device-tree
> >> files;
> >> 2) add support for RP1 chip with additional hardware;
> >> 3) add support for rp1-clock driver with dt-bindings update;
> >> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> >> 5) add clock/reset/gpio drivers;
> >> 6) add ethernet support in u-boot.
> >>
> >> This patch-series introducing the basic set of supported drivers in
> >> U-Boot which allows using such features as tftp and\or NFS.
> >> I've posted this patch series as RFC because of the following commit:
> >> e51ca0d221 (HACK: drivers: mfd: set bar configuration for RP1 driver, 2024-05-21)
> > Where is that commit?
>
> This commit is part of the patch series. Here is direct link:
>
> https://lore.kernel.org/u-boot/cover.1738749764.git.oleksii_moisieiev@epam.com/T/#m21cf23989fb08cb655e25b1a2d082632b6f865c9
>
> >> It includes HACK for rp1 driver in u-boot. This HACK is setting bar
> >> address in the correct order because RP1 driver in Linux Kernel rely on
> >> the pci BAR configuration which initializes BARs based on BAR size.
> >> This results the Linux set BARs in the same order on each boot.
> >> U-boot does initialization without any sorting so the configuration
> >> may be different from the Linux kernel.
> >> BAR address configuration is set to match the Linux Kernel order
> >> to avoid fails on address translation.
> >>
> >> This should be changed after upstreaming RP1 driver to the Linux kernel
> >> mainline.
> >>
> >> Probably somebody from Raspberry will post an advise about how this
> >> can be properly done.
> > +1
> >
> >> U-Boot support for Raspberry PI 5 was added in terms of the following
> >> project: https://github.com/xen-troops/meta-xt-prod-devel-rpi5
> >> This is xen-based dom0less system on the Raspberry PI 5 with Zephyr as
> >> Control Domain and Linux is Driver Domain.
> >>
> >> It is Yocto-based so it will be easy to build it on your side. Please
> >> visit link for the details.
> > I tried to apply this but I get a lot of conflicts. Can you please
> > advise what tree it is based on?
>
> Yocto build using the following repo:
>
> https://github.com/xen-troops/u-boot/tree/rpi5-2024.04-xt
>
> It is based on the 7-8 month old master. I didn't do any rebase on the
> top because
>
> it's unclear if these changes will go to upstream.
>
> So I've posted RFC before making significant changes.

If these add more support for rpi5 your patches would definitely be welcome.

I tried out your tree, but did not see USB for the two sticks I put in:

$ ub-int rpi5
Building U-Boot in sourcedir for rpi_arm64
Bootstrapping U-Boot from dir /tmp/b/rpi_arm64
Writing U-Boot using method rpi5
cat: /sys/class/block/sdf1/size: No such file or directory
cat: /sys/class/block/sdf1/size: No such file or directory
cat: /sys/class/block/sdf1/size: No such file or directory
cat: /sys/class/block/sdf1/size: No such file or directory

  4.28 RPi: BOOTSYS release VERSION:6fe0b091 DATE: 2024/06/05 TIME: 16:41:49
  4.32 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1717602109
serial 648a6bdf boardrev b04170 stc 4532726
  4.42 AON_RESET: 00000003 PM_RSTS 00001000
  4.50 RP1_BOOT chip ID: 0x20001927
  4.52 PM_RSTS: 0x00001000
  4.53 part 00000000 reset_info 00000000
  4.56 PMIC reset-event 00000000 rtc 00000004 alarm 00000000 enabled 0
  4.63 uSD voltage 3.3V
  4.82 Initialising SDRAM 'Micron' 16Gb x1 total-size: 16 Gbit 4267
  4.85 DDR 4267 0 0 16 152
  5.26 OTP boardrev b04170 bootrom a a
  5.27 Customer key hash
0000000000000000000000000000000000000000000000000000000000000000
  5.34 VC-JTAG unlocked
  5.57 RP1_BOOT chip ID: 0x20001927

  6.62 RP1_BOOT chip ID: 0x20001927
  6.63 RP1_BOOT: fw size 25992
  6.18 PCI2 init
  6.18 PCI2 reset
  6.63 PCIe scan 00001de4:00000001
  6.63 RP1_CHIP_INFO 20001927

  6.66 RPi: BOOTLOADER release VERSION:6fe0b091 DATE: 2024/06/05 TIME: 16:41:49
  6.73 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1717602109
serial 648a6bdf boardrev b04170 stc 6873270
  6.83 AON_RESET: 00000003 PM_RSTS 00001000
  6.87 PCIEx1: PWR 0 DET_WAKE 0
  6.90 M.2 PCIe HAT not detected.
  6.14 usb_pd_init status 1
  6.18 XHCI-STOP
  6.18 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  6.22 USBSTS 1
  6.25 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  6.30 xHC0 ports 3 slots 64 intrs 4
  6.42 XHCI-STOP
  6.42 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  6.46 USBSTS 1
  6.49 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  6.54 xHC1 ports 3 slots 64 intrs 4
  6.62 Boot mode: SD (01) order f4
  7.00 USB3[3] 00021203 connected enabled
  7.00 USB3 root HUB port 3 init
  7.05 DEV [01:00] 3.32 000000:03 class 0 VID 0781 PID 5581
  7.09 MSD device [01:00] 3.32 000000:03 conf 0 iface 0 ep 81#1024 02#1024
  7.16 MSD [01:00] 3.32 000000:03 register MSD
  7.52 USB2[2] 000206e1 connected
  7.02 USB2[2] 00200e03 connected enabled
  7.03 USB2 root HUB port 2 init
  7.09 DEV [01:00] 2.16 000000:02 class 0 VID 090c PID 1000
  7.11 MSD device [01:00] 2.16 000000:02 conf 0 iface 0 ep 82#512 01#512
  7.19 MSD [01:00] 2.16 000000:02 register MSD
  7.76 SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual:
390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
  7.87 SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual:
390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
  7.21 OCR c0ff8000 [40]
CID: 0027504853443332476075149214017b
CSD: 400e00325b590000e6e97f800a400000
  7.29 SD: bus-width: 4 spec: 2 SCR: 0x02858083 0x00000000
  7.37 SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual:
50000000 HZ div: 4 (2) status: 0x1fff0000 delay: 2
  7.46 MBR: 0x00000800, 1048576 type: 0x0c
  7.48 MBR: 0x00100800,17020996 type: 0x83
  7.52 MBR: 0x00000000,       0 type: 0x00
  7.56 MBR: 0x00000000,       0 type: 0x00
  7.60 Trying partition: 0
  7.63 type: 32 lba: 2048 'mkfs.fat' ' system-boot' clusters 1032412 (1)
  7.69 rsc 32 fat-sectors 8066 root dir cluster 2 sectors 0 entries 0
  7.75 FAT32 clusters 1032412
  7.81 [sdcard] autoboot.txt not found
  7.82 Select partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 0
  7.89 Trying partition: 0
  7.92 type: 32 lba: 2048 'mkfs.fat' ' system-boot' clusters 1032408 (1)
  7.98 rsc 32 fat-sectors 8066 root dir cluster 2 sectors 0 entries 0
  7.04 FAT32 clusters 1032408
  7.11 Read config.txt bytes     1680 hnd 0x2fc7d
  7.14 [sdcard] pieeprom.upd not found
  7.16 usb_max_current_enable default 0 max-current 900
  7.28 Read bcm2712-rpi-5-b.dtb bytes    80206 hnd 0x352
  7.30 dt-match: compatible: raspberrypi,5-model-b match: brcm,bcm2712
  7.37 dt-match: compatible: brcm,bcm2712 match: brcm,bcm2712
  7.43 Selecting USB low current limit

NOTICE:  BL31: v2.6(release):v2.6-239-g2a9ede0bd
NOTICE:  BL31: Built : 14:26:57, Jun 22 2023


U-Boot 2024.04-00714-gb81bc374c35 (Feb 06 2025 - 08:56:18 -0700)

DRAM:  1020 MiB (effective 2 GiB)
RPI 5 Model B (0xb04170)
Core:  54 devices, 15 uclasses, devicetree: board
MMC:   mmc@fff000: 0, mmc@1100000: 1
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
mbox: Header response code invalid
bcm2835: Could not query MAC address
PCIe BRCM: link up, 5.0 Gbps x4 (!SSC)
Net:   eth0: ethernet@100000

starting USB...
Bus usb@480000: USB DWC2
scanning bus usb@480000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
U-Boot> dm tree
 Class     Index  Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 clk           0  [   ]   fixed_clock           |-- clk-27M
 clk           1  [   ]   fixed_clock           |-- clk-108M
 simple_bus    0  [ + ]   simple_bus            |-- soc
 serial        0  [ + ]   serial_pl01x          |   |-- serial@7d001000
 rng           0  [   ]   iproc_rng200-rng      |   |-- rng@7d208000
 simple_bus    1  [   ]   simple_bus            |   |-- avs-monitor@7d542000
 simple_bus    2  [   ]   simple_bus            |   |-- firmware
 reset         0  [   ]   raspberrypi-reset     |   |   `-- reset
 simple_bus    3  [   ]   simple_bus            |   `-- nvmem
 simple_bus    4  [ + ]   simple_bus            |-- axi
 reset         1  [ + ]   brcmstb-reset-rescal  |   |-- reset-controller@119500
 pci           0  [ + ]   pcie_brcm             |   |-- pcie@120000
 simple_bus    5  [ + ]   simple_bus            |   |   |-- rp1
 clk           2  [ + ]   rp1-clk               |   |   |   |-- clocks@18000
 gpio          0  [ + ]   rp1-gpio              |   |   |   |-- gpio@d0000
 ethernet      0  [ + ]   eth_macb              |   |   |   `-- ethernet@100000
 bootdev       0  [   ]   eth_bootdev           |   |   |       `--
ethernet@100000.bootdev
 pci           1  [ + ]   pci_bridge_drv        |   |   `-- pci_0:0.0
 pci_generi    0  [ + ]   rp1                   |   |       `-- rp1
 simple_bus    6  [   ]   simple_bus            |   |-- syscon@400018
 usb           0  [ + ]   dwc2_usb              |   |-- usb@480000
 usb_hub       0  [ + ]   usb_hub               |   |   `-- usb_hub
 mmc           0  [ + ]   sdhci-bcmstb          |   |-- mmc@fff000
 blk           0  [ + ]   mmc_blk               |   |   |-- mmc@fff000.blk
 partition     0  [ + ]   blk_partition         |   |   |   |-- mmc@fff000.blk:1
 partition     1  [ + ]   blk_partition         |   |   |   `-- mmc@fff000.blk:2
 bootdev       1  [   ]   mmc_bootdev           |   |   `-- mmc@fff000.bootdev
 mmc           1  [ + ]   sdhci-bcmstb          |   |-- mmc@1100000
 blk           1  [   ]   mmc_blk               |   |   |-- mmc@1100000.blk
 bootdev       2  [   ]   mmc_bootdev           |   |   `-- mmc@1100000.bootdev
 reset         2  [ + ]   brcmstb-reset         |   `-- reset-controller@1504318
 simple_bus    7  [ + ]   simple_bus            |-- clocks
 clk           3  [   ]   fixed_clock           |   |-- clk-osc
 clk           4  [ + ]   fixed_clock           |   |-- clk-usb
 clk           5  [   ]   fixed_clock           |   |-- clk_vpu
 clk           6  [ + ]   fixed_clock           |   |-- clk_uart
 clk           7  [   ]   fixed_clock           |   |-- clk_emmc2
 clk           8  [   ]   fixed_clock           |   |-- clk_xosc
 clk           9  [ + ]   fixed_clock           |   |-- macb_pclk
 clk          10  [ + ]   fixed_clock           |   |-- macb_hclk
 clk          11  [   ]   fixed_clock           |   |-- sdio_src
 clk          12  [   ]   fixed_clock           |   `-- sdhci_core
 clk          13  [   ]   fixed_clock           |-- clk-osc
 clk          14  [   ]   fixed_clock           |-- clk-usb
 clk          15  [   ]   fixed_clock           |-- clk_vpu
 clk          16  [   ]   fixed_clock           |-- clk_uart
 clk          17  [   ]   fixed_clock           |-- clk_emmc2
 clk          18  [   ]   fixed_clock           |-- clk_xosc
 clk          19  [   ]   fixed_clock           |-- macb_pclk
 clk          20  [   ]   fixed_clock           |-- macb_hclk
 clk          21  [   ]   fixed_clock           |-- sdio_src
 clk          22  [   ]   fixed_clock           |-- sdhci_core
 bootstd       0  [   ]   bootstd_drv           `-- bootstd
 bootmeth      0  [   ]   bootmeth_extlinux         |-- extlinux
 bootmeth      1  [   ]   bootmeth_script           |-- script
 bootmeth      2  [   ]   bootmeth_efi_mgr          |-- efi_mgr
 bootmeth      3  [   ]   bootmeth_efi              |-- efi
 bootmeth      4  [   ]   bootmeth_pxe              `-- pxe
U-Boot>

Regards,
Simon
