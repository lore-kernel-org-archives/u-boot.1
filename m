Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA13ECCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 21:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FE88382E;
	Sat, 18 Oct 2025 23:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XMzm2HxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEB1836CE; Sat, 18 Oct 2025 20:04:39 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A74583631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 20:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id ED7DB25F43;
 Sat, 18 Oct 2025 20:04:36 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LS_1rFhGBIz; Sat, 18 Oct 2025 20:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760810675; bh=kOejMRQifnvmvgqVx0/ao6eBKA8c0FhLrdr65USuryU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XMzm2HxNLT+0l571a+d/uTHuvT5SavTH2P+W+pM6ckV5eJdGjPxoeGO7RSR13QcxQ
 j9tO/IEq3sfAgL4aKs22czs2VfDwQtVsDwDA/7n53U1PIwrhH0Ns8eblvyUgz/XwYP
 ujlbXKNrbZOkd10nUdX1antq5LrUHZ7tQpJGW7972lFe6K6dP5YxI/n2ulPWnGPYh/
 FYNjoYa3vGOWS0SlWKMaJ8ZRLxbACvVu3N1G9m0W/agXPK5Rp62zhYTzBzNyTgaazM
 Yt+4P9W5+gSGSeK5PiKOv321F1mZW+oryuwR+oxqAxEWfEV51gjXM8XQGCESDYsQuO
 x95HTzTUfp5lA==
MIME-Version: 1.0
Date: Sat, 18 Oct 2025 18:04:35 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Henrik Grimler <henrik@grimler.se>
Cc: u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Svyatoslav Ryhel <clamor95@gmail.com>, Ion
 Agorria <ion@agorria.com>
Subject: Re: [PATCH] board: samsung: add support for Samsung Exynos mobile
 device boards
In-Reply-To: <20251017201936.GA13076@l14.localdomain>
References: <20251017-board-exynos-mobile-v1-1-55f47dd52fc7@disroot.org>
 <20251017201936.GA13076@l14.localdomain>
Message-ID: <b6408b1d32a4986622145c1517ec3ae3@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 23:27:21 +0200
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

On 2025-10-17 20:19, Henrik Grimler wrote:
> Hi Kaustabh,
> 
> Nice work on all of the linked patches!
> 
> On Fri, Oct 17, 2025 at 10:07:35PM +0530, Kaustabh Chakraborty wrote:
>> Add support for a generic platform which intends to support multiple
>> boards powerid by Samsung Exynos SoCs. This patch also includes 
>> initial
>> support for three boards:
>> * Samsung Galaxy A2 Core
>> * Samsung Galaxy J6
>> * Samsung Galaxy J7 Prime
> 
> I think it would be easier to review this if you split the patch in two
> parts: first adding docs and common parts, and then the specific parts
> for exynos7870 and these devices.
> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> This patch has the following dependencies:
>> (NOTE: `x` indicates applied)
>> 
>> armv8-broken-cntfrq		- 
>> https://patch.msgid.link/20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org
>> clk-exynos7870			- 
>> https://patch.msgid.link/20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org
>> gpio-s5p-bank-fix		- 
>> https://patch.msgid.link/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org
>> i2c-hs-exynos7			- 
>> https://patch.msgid.link/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
>> mmc-dw-exynos7870		- 
>> https://patch.msgid.link/20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org
>> phy-usb-exynos7870		- 
>> https://patch.msgid.link/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org
>> pinctrl-exynos7870		- 
>> https://patch.msgid.link/20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org
>> power-pmic-regulator-s2mpu05	- 
>> https://patch.msgid.link/20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org
>> serial-s5p-exynos8895		- 
>> https://patch.msgid.link/20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org
>> soc-pmu-exynos7			- 
>> https://patch.msgid.link/20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org
>> usb-dwc3-exynos7870		- 
>> https://patch.msgid.link/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org
>> ---
>>  arch/arm/mach-exynos/Kconfig                       |  11 +-
>>  board/samsung/exynos-mobile/Kconfig                |  18 +
>>  board/samsung/exynos-mobile/MAINTAINERS            |   6 +
>>  board/samsung/exynos-mobile/Makefile               |   5 +
>>  .../samsung/exynos-mobile/debug-exynos7870.config  |   7 +
>>  board/samsung/exynos-mobile/exynos-mobile.c        | 372 
>> +++++++++++++++++++++
>>  board/samsung/exynos-mobile/exynos-mobile.env      |  18 +
>>  configs/exynos-mobile_defconfig                    |  71 ++++
>>  doc/board/samsung/exynos-mobile.rst                | 112 +++++++
>>  doc/board/samsung/index.rst                        |   1 +
>>  include/configs/exynos-mobile.h                    |  14 +
>>  11 files changed, 634 insertions(+), 1 deletion(-)
> 
> [ skipping to docs for now ]
> 
>> diff --git a/doc/board/samsung/exynos-mobile.rst 
>> b/doc/board/samsung/exynos-mobile.rst
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..6390c66ffc38a41f01cb51c7406397cfc5a3d223
>> --- /dev/null
>> +++ b/doc/board/samsung/exynos-mobile.rst
>> @@ -0,0 +1,112 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +.. sectionauthor:: Kaustabh Chakraborty <kauschluss@disroot.org>
>> +
>> +Samsung Exynos Generic Boards (for mobile devices)
>> +==================================================
>> +
>> +Overview
>> +--------
>> +This document describes how to build and run U-Boot for Samsung 
>> Exynos generic
>> +boards. Boards are expected to boot with a primary bootloader, such 
>> as S-BOOT or
>> +S-LK, which hands off control to U-Boot, disguised as an Android boot 
>> image.
> 
> In my opinion exynos-mobile is a bit too generic. From the docs here
> it seems plan is to support devices that support android boot images
> with dt in Samsung's qcdt format. The oldest Exynos mobile device do
> not even support boot images though, and dt images has only been
> around since something like 2015. If I am not mistaken the newest
> devices also does not use dt images.

Well no, any Exynos would be supported by this variant, the only
factor is that U-Boot is used as a *secondary* boot loader. QCDT is
specific to the packaging of the u-boot binary (that too, is
located under a 7870-specific section), and if there are any other
packing methods, they can be documented here as well.

That being said, I've found 'exynos-mobile' to be most appropriate
(This is for mobile devices like phones and tablets, where we have
a proprietary primary boot loader). But if you have suggestions for
better names, let me know. :)

> 
>> +U-Boot is packed with multiple FDTs since it targets multiple boards. 
>> The
>> +appropriate FDT is selected during boot. Additionally, a DTB is also 
>> required
>> +for embedding in the Android boot image. The previous bootloader can 
>> apply
>> +useful overlays on it. Both DTBs are consulted for figuring out the 
>> memory
>> +layout.
> 
>> +Installation
>> +------------
>> +Building
>> +^^^^^^^^
>> +To buiid U-Boot, run the following commands
> 
> Typo, buiid -> build
> 
>> +.. prompt:: bash $
>> +
>> +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output 
>> exynos-mobile_defconfig
>> +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
> 
> I think CROSS_COMPILE=aarch64-linux-gnu- can be dropped from the 
> example, or are only
> aarch64 devices supported?

Plans were for aarch64. But if its possible to add armv7 support, then
that would be great! Is multiple arch-es for the same board possible?

> 
>> +If succcessful, the U-Boot binary will be present in 
>> ``.output/u-boot.bin``.
> 
> Typo, succcessful -> successful.
> 
>> +
>> +Preparation
>> +^^^^^^^^^^^
>> +The U-Boot binary is not flashable as-is, it needs to be encapsulated 
>> in an
>> +Android boot image. Since it supports multiple boards, and devices 
>> have
>> +different requirements (thanks to the lack of standards), this step 
>> varies
> 
> I think `(thanks to the lack of standards)` is a bit opinionated, and
> does not really add anything here, could you please remove it?

I agree. Will remove it.

> 
>> +depending on your target.
>> +
>> +Exynos 7870 Boards
>> +""""""""""""""""""
>> +Create the following devicetree (named ``stub.dts``)
>> +
>> +.. code-block:: devicetree
>> +
>> +	/dts-v1/;
>> +
>> +	/ {
>> +		compatible = "samsung,exynos7870";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +
>> +		model_info-chip = <7870>;
>> +		model_info-hw_rev = <0>;
>> +		model_info-hw_rev_end = <255>;
>> +
>> +		chosen {
>> +		};
>> +
>> +		memory@80000000 {
>> +			device_type = "memory";
>> +			reg = <0x0 0x80000000 0x0>;
>> +		};
>> +
>> +		memory@100000000 {
>> +			device_type = "memory";
>> +			reg = <0x1 0x00000000 0x0>;
>> +		};
>> +	};
>> +
>> +The chosen node and memory ranges are populated by S-BOOT.
>> +
>> +Compile it to a devicetree blob, then use ``dtbTool-exynos`` in order 
>> to pack it
>> +in the QCDT format [1]_, using the following commands:
>> +
>> +.. prompt:: bash $
>> +
>> +	dtc -I dts -O dtb -o stub.dtb stub.dts
>> +	dtbTool-exynos -o stub.dt.img stub.dtb
>> +
>> +Finally, use mkbootimg by osm0sis [2]_ to generate the boot image:
>> +
>> +.. prompt:: bash $
>> +
>> +	mkbootimg -o u-boot.img \
>> +		--kernel	.output/u-boot.bin \
>> +		--dt		stub.dt.img
>> +
>> +Offsets are not provided to ``mkbootimg`` as S-BOOT ignores them.
>> +
>> +Flashing
>> +^^^^^^^^
>> +If flashing for the first time, it must be done via Samsung's 
>> Download (Odin)
>> +mode. Heimdall can be used for flashing, like so:
> 
> Maybe it would be useful to link to Heimdall in references as well.
> 
> Best regards,
> Henrik Grimler
> 
>> +.. prompt:: bash $
>> +
>> +	heimdall flash --BOOT u-boot.img
>> +
>> +However, if U-Boot is already installed, you may also use its 
>> fastboot interface
>> +for flashing. Boot into the boot menu by holding the volume down key. 
>> Enable
>> +fastboot mode from there, connect the device to your host, then run:
>> +
>> +.. prompt:: bash $
>> +
>> +	fastboot flash boot u-boot.img
>> +
>> +To flash an OS image in internal storage, fastboot is a reliable 
>> option.
>> +
>> +References
>> +----------
>> +.. [1] https://wiki.postmarketos.org/wiki/QCDT
>> +.. [2] https://github.com/osm0sis/mkbootimg
>> diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
>> index 
>> 1b92c9518a57df102c2b64ff934b460548ce3d53..1fbe88130c049e1a33d22ae9230fb60ddccea131 
>> 100644
>> --- a/doc/board/samsung/index.rst
>> +++ b/doc/board/samsung/index.rst
>> @@ -8,4 +8,5 @@ Samsung
>> 
>>     axy17lte
>>     e850-96
>> +   exynos-mobile
>>     n1
>> diff --git a/include/configs/exynos-mobile.h 
>> b/include/configs/exynos-mobile.h
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..862db5779ef4c9ff7f53bef78d7cee5107b7226e
>> --- /dev/null
>> +++ b/include/configs/exynos-mobile.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Samsung Exynos Generic Board Configuration (for mobile devices)
>> + *
>> + * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
>> + */
>> +
>> +#ifndef __CONFIG_EXYNOS_MOBILE_H
>> +#define __CONFIG_EXYNOS_MOBILE_H
>> +
>> +#define CPU_RELEASE_ADDR	secondary_boot_addr
>> +#define CFG_SYS_BAUDRATE_TABLE	{9600, 115200}
>> +
>> +#endif /* __CONFIG_EXYNOS_MOBILE_H */
>> 
>> ---
>> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
>> change-id: 20251017-board-exynos-mobile-7c7d43832693
>> 
>> Best regards,
>> --
>> Kaustabh Chakraborty <kauschluss@disroot.org>
>> 
