Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C8EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 05:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3464687494;
	Mon,  4 Dec 2023 06:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFOg6HD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F76876B0; Mon,  4 Dec 2023 06:57:57 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C11787158
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 06:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ce3935ffedso1421433b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 21:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701669474; x=1702274274; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=la4TZ50Y8dYK/8KmCragSc/UeZ0f0P/CMIBUUKYVbDo=;
 b=GFOg6HD/+kX7136kuqIXk7VJDNMOfLOXwkm7TVovTdPG1HK97CUkDNQrrWO5bmcT52
 EcuB9OulYzB9QPCWbL9e9FZLRVsNpdgD2XNr0i0LBQq+kGJ4wvQSHgsMwAvZc1GjGaWY
 CsiGkIGkwbWvl6516tQZc99OnAMs6r8qrQWNsqYO3IqXh+e7F0KmwMEPDtr9PUJS0KnU
 WVUDLCL/+La4AZQRT39ae0wzFjp/Wv4Ey1VuikUH7z5KI7DcqLtxsP+k8gbx5yEx095N
 d/nrjNNM3ck2FKn7CnoobVJAIUt23E43MKbCRaF7VC9fvpqa6PkunWy37oRwj2bN9qnz
 lOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701669474; x=1702274274;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=la4TZ50Y8dYK/8KmCragSc/UeZ0f0P/CMIBUUKYVbDo=;
 b=E8EafdDx/++0bFrJAEKundnfoDvLzSSIw6blCQuTBMEhYCOCnqqORFMFI+08F2aPSI
 fwJXuTyXUytCS3gP/RuVtquAgSwpMdR+uBIE0YuL3H7N07B1j3PpyeBGhjfohOgH1KEg
 SUhW0L5e/8rfzK+fqgNQY67EIXscsYsYc9UT2cYL24YhEKGrmRpUq+/RP6yUgnYvKI2p
 w7kavPx6ab2aI1YNdVPxDm89CArQt7DJ2s5rkxBSyed4jp+FZJNLqwmG8ycSA2apEGIF
 iMlQfDtCWzXeTkqKLhbqY1wfcJWL0It+6o8X8WepxiVmIIyndKGbz4GfWwJooNpSX0Dj
 lskQ==
X-Gm-Message-State: AOJu0Yx3GpY4B9xGbQYXzXp+FM4vv0t4/jtElogDTZUgiSR3jcwnALpP
 NJVNNRosa/UH0JCceWMqF1I=
X-Google-Smtp-Source: AGHT+IE5VO1u6UjhihOBsbQ+yGD/yO0OaRHv8KazOb063lA4ep/9z/vP1E+uWzmzwB9Vxd2tXzyWGQ==
X-Received: by 2002:a05:6a20:54a3:b0:18b:8158:86ea with SMTP id
 i35-20020a056a2054a300b0018b815886eamr4347705pzk.10.1701669473600; 
 Sun, 03 Dec 2023 21:57:53 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 fz9-20020a17090b024900b002836c720713sm3047969pjb.24.2023.12.03.21.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:57:53 -0800 (PST)
Message-ID: <1f373e2d-c71a-412f-819a-27b82fc254f4@gmail.com>
Date: Sun, 3 Dec 2023 21:57:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stephen Graf <stephen.graf@gmail.com>
Subject: Re: [PATCH v2 0/3] sunxi: add OrangePi Zero 3 board support
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Mikhail Kalashnikov
 <iuncuim@gmail.com>, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231204005954.13201-1-andre.przywara@arm.com>
Content-Language: en-CA
In-Reply-To: <20231204005954.13201-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

I have tested a newly built u-boot with the patches you provided and it works well.
It is the same configuration as what I have been testing with for the last few weeks.

I loaded the U-boot to SPI flash and tested with the SD card removed from the system
and put in a USB card reader. The output for that test is below.

For completeness you might want to mention that another difference between the zero2
and zero3 is the emac phy going from Realtek to Motorcomm.

Thank you for fixing my patch attempt. It is the first one I have ever done.
Thank you also for your patience with my fumbling attempts. I have learned a lot
from you in the last two weeks.

U-Boot SPL 2024.01-rc3-00043-g5c4e9d0c74-dirty (Dec 03 2023 - 18:21:41 -0800)
DRAM: 1024 MiB
Trying to boot from sunxi SPI
NOTICE:  BL31: v2.10.0  (debug):v2.10.0
NOTICE:  BL31: Built : 18:07:18, Nov 23 2023
NOTICE:  BL31: Detected Allwinner H616 SoC (1823)
NOTICE:  BL31: Found U-Boot DTB at 0x4a0b2828, model: OrangePi Zero3
INFO:    ARM GICv2 driver initialized
INFO:    Configuring SPC Controller
INFO:    PMIC: Probing AXP305 on RSB
ERROR:   RSB: set run-time address: 0x10003
INFO:    Could not init RSB: -65539
INFO:    BL31: Platform setup done
INFO:    BL31: Initializing runtime services
INFO:    BL31: cortex_a53: CPU workaround for erratum 855873 was applied
INFO:    BL31: cortex_a53: CPU workaround for erratum 1530924 was applied
INFO:    PSCI: Suspend is unavailable
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x4a000000
INFO:    SPSR = 0x3c9
INFO:    Changed devicetree.


U-Boot 2024.01-rc3-00043-g5c4e9d0c74-dirty (Dec 03 2023 - 18:21:41 -0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from SPIFlash... SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
OK
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... Device NOT ready
    Request Sense returned 02 3A 00
Device NOT ready
    Request Sense returned 02 3A 00
Device NOT ready
    Request Sense returned 02 3A 00
2 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
Hit any key to stop autoboot:  0
Card did not respond to voltage select! : -110

Device 0: Vendor: Generic- Rev: 1.00 Prod: SD/MMC
             Type: Removable Hard Disk
             Capacity: 15193.5 MB = 14.8 GB (31116288 x 512)
... is now current device
Scanning usb 0:1...
Found U-Boot script /boot/boot.scr
1052 bytes read in 1 ms (1 MiB/s)
## Executing script at 4fc00000
Card did not respond to voltage select! : -110
** Bad device specification mmc 0 **
19472 bytes read in 3 ms (6.2 MiB/s)
No FDT memory address configured. Please configure
the FDT address via "fdt addr <address>" command.
Aborting!
7088139 bytes read in 324 ms (20.9 MiB/s)
22491144 bytes read in 1025 ms (20.9 MiB/s)
Moving Image from 0x40080000 to 0x40200000, end=41800000
## Loading init Ramdisk from Legacy Image at 4ff00000 ...
    Image Name:   uInitrd
    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
    Data Size:    7088075 Bytes = 6.8 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 4fa00000
    Booting using the fdt blob at 0x4fa00000
Working FDT set to 4fa00000
    Loading Ramdisk to 4993d000, end 49fff7cb ... OK
    Loading Device Tree to 0000000049935000, end 000000004993cc0f ... OK
Working FDT set to 49935000

Starting kernel ...


Welcome to Debian GNU/Linux 12 (bookworm)!



On 2023-12-03 4:59 p.m., Andre Przywara wrote:
> A small update for the OrangePi Zero 3 support series. This fixes
> USB support, and upgrades the DRAM clock to 792, for better stability
> (as the other DRAM parameters were tailored to that frequency). I added
> the tags on the way.
> Please test!
> 
> =================
> The OrangePi Zero 3 is a small development board featuring the Allwinner
> H618 SoC. Compared to its predecessor OrangePi Zero 2, the new board uses
> LPDDR4 DRAM instead of DDR3 DRAM, and an X-Powers AXP313 PMIC instead of
> the AXP305.
> U-Boot gained support for both LPDDR4 DRAM and the new PMIC just
> recently, so add a user for those features by adding a defconfig for the
> new board.
> To make this work, patch 1/3 introduces support for zBIT SPI NOR flash
> chip, and patch 2/3 removes the default AXP305 PMIC selection when
> compiling for H616 SoCs.
> Patch 3/3 then adds the defconfig. The DT was already synced from the
> Linux kernel repo a few weeks ago.
> 
> Cheers,
> Andre
> 
> Changelog v1 .. v2:
> - add tags
> - set DRAM clock to 792 MHz (from the default 720 MHz)
> - fix USB support by supplying USB VBUS enable GPIO
> 
> Andre Przywara (3):
>    mtd: spi-nor: Add support for zBIT ZB25VQ128
>    sunxi: H616: remove default AXP305 selection
>    sunxi: H616: Add OrangePi Zero 3 board support
> 
>   arch/arm/dts/Makefile            |  1 +
>   board/sunxi/MAINTAINERS          |  5 +++++
>   configs/orangepi_zero2_defconfig |  1 +
>   configs/orangepi_zero3_defconfig | 32 ++++++++++++++++++++++++++++++++
>   configs/x96_mate_defconfig       |  1 +
>   drivers/mtd/spi/Kconfig          |  5 +++++
>   drivers/mtd/spi/spi-nor-ids.c    |  5 +++++
>   drivers/power/Kconfig            |  1 -
>   8 files changed, 50 insertions(+), 1 deletion(-)
>   create mode 100644 configs/orangepi_zero3_defconfig
> 
