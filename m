Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D058C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 03:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B12877B3;
	Tue, 12 Dec 2023 04:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="MVzRNHQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E163877B6; Tue, 12 Dec 2023 01:54:16 +0100 (CET)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7C886FD5
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 01:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Tue, 12 Dec 2023 11:53:50 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1702342450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=l3iswTqPjGp6NqoONxxKB+TTObpsez70BihFVr0BV/s=;
 b=MVzRNHQsjvDHMftnCBHMau/LsA32MVqkylJb+0yyFKbEnbdo5WE7XChZYnennpKyifxSYh
 v3REypJnQS3Q2Ph5kfulBxAEFBxwbTNHBz1zbmNLyBwvTvgjw+My19EXfHZZtCfFrKv52F
 /AIWDHLVB4e/s74plhWhS/8RUMi1iD8pcnk6L5VqpXRfSL/iOJe/CxcdqG2uwbpVYGmzEY
 nNVkSnkq9fBQhlmFIpBQUF2bmEKHSC7gNR0PAZN3JceGCv+tLWatves0NIRheCcpMwJCEr
 E8jUEkegyPxCl4AAx2D6G1FNadALmUNJMyZf+Oy0zgXz3vNnqIBGB4wo0uiyWQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: linux-sunxi@lists.linux.de, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: T113 sunxi SPI NAND thoughts, feedback wanted
Message-ID: <ZXevHkZvw-aTbsYV@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 12 Dec 2023 04:27:20 +0100
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

Greetings sunxi and U-Boot friends!

Over the past five months I've managed to slog through getting a
complete SPI NAND U-Boot and Linux setup running on my Mango Pi MQ.

My tree is here, but I will be slowly trying to upstream my work over
the next few months: https://github.com/Jookia/u-boot/commits/jookia_t113/

It is based on master at the moment with the following patches:
- SUNIV SPI NAND support in SPL
  (https://lore.kernel.org/u-boot/8034158c-03ab-7488-6afa-a67f04264705@gmail.com)
- UART1 and UART2 support for the Mango Pi MQ
- SPI NAND device tree addition for my device
- A new boot option: BOOT_DEVICE_SPINAND
- SPL SPI booting on the T113 (superseeded by someone else)
- SPI controller support for the T113 (superseeded by someone else)
- MTD Kconfig requirement for UBI
- spinand_ helper functions to support UBI in the SPL
- UBI SPINAND support
- UBI SPL FIT support
- musb gadget suport (superseeded by someone else)

This patch seems to be independently written for the T113 SPI support
but looks the same as what I've done:
https://lore.kernel.org/u-boot/20231111133432.755363-1-bigunclemax@gmail.com/

The same with this USB fix:
https://lore.kernel.org/u-boot/20230615190701.327852-1-CFSworks@gmail.com/

I plan to add feedback and review to both these patches. Though USB is a
separate subject, I would be interested to know what speeds people are
getting over USB gadget on the T113. DFU seems to cap out at 70KiB/s,
much lower than SSH in Linux.

Anyway, talking in IRC and reading patches on the mailing list, it seems
there's a little lack of direction for SPI NAND support in U-Boot.
Particularly around how to integrate it alongside existing NAND support
and handling bad blocks.

I'd like to first talk about the boot device situation. It works like
this:

- BOOT_DEVICE_SPI means SPI NOR memory
- BOOT_DEVICE_NAND means parallel NAND memory
- BOOT_DEVICE_ONENAND means OneNAND memory
- drivers/mtd/spi uses drivers/spi/spi-mem
- drivers/mtd/nand/spi uses drivers/spi/spi-mem
- drivers/spi/spi-mem uses drivers/spi/spi-sunxi
- common/spl/spl_spi uses drivers/spi/spi-mem and BOOT_DEVICE_SPI
- common/spl/spl_nand uses mtd/nand/raw and BOOT_DEVICE_NAND
- common/spl/spl_onenand uses drivers/mtd/onenand and BOOT_DEVICE_ONENAND
- common/spl/spl_ubi uses drivers/mtd/nand/raw or drivers/mtd/onenand
  and either BOOT_DEVICE_NAND or BOOT_DEVICE_ONENAND
- drivers/nand/raw has a sunxi NAND and sunxi NAND SPL driver
- arch/arm/mach-sunxi/spl_spi_sunxi implements its own SPI loader

A quick grep shows the following custom SPL_LOAD_IMAGE_METHODs in arch:

arch/arm/mach-sunxi/spl_spi_sunxi.c:SPL_LOAD_IMAGE_METHOD("sunxi SPI", 0, BOOT_DEVICE_SPI, spl_spi_load_image);
arch/x86/cpu/apollolake/spl.c:SPL_LOAD_IMAGE_METHOD("Mapped SPI", 2, BOOT_DEVICE_SPI_MMAP, rom_load_image);
arch/x86/cpu/apollolake/spl.c:SPL_LOAD_IMAGE_METHOD("Fast SPI", 1, BOOT_DEVICE_FAST_SPI,

Looking closer at the NAND APIs SPL uses, it calls the following
functions and defines:

nand_init();
nand_deselect();
int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst);
int nand_spl_read_block(int block, int offset, int len, void *dst);
int onenand_spl_read_block(int block, int offset, int len, void *dst);
int onenand_spl_load_image(uint32_t offs, uint32_t size, void *dst);
BOOT_DEVICE_NAND
BOOT_DEVICE_ONENAND
CONFIG_SYS_ONENAND_PAGE_SIZE
CONFIG_SYS_NAND_U_BOOT_OFFS
CONFIG_SYS_NAND_BLOCK_SIZE
CONFIG_SYS_NAND_PAGE_SIZE
CONFIG_SPL_SPI_SUNXI_NAND_ASSUMED_PAGESIZE (used by SUNIV NAND patch)

In the SUNIV NAND patch there was a question of whether to add a
device-specific BOOT_DEVICE. I think the answer to that heavily depends
on whether the current OneNAND/NAND separation makes sense. The APIs are
basically the same, just with different implementations. The only thing
the BOOT_DEVICE_ does here is indicate that there is a distinct boot
ROM option and that we have booted from it. This disambiguates which
NAND we would be using on sunxi: Parallel or SPI.

In my patches I went ahead and added a new SPI NAND API:

spinand_init();
spinand_deselect();
spinand_spl_read_block(int block, int offset, int len, void *dst);
BOOT_DEVICE_SPINAND
CONFIG_SPL_SPINAND_PAGE_SIZE
CONFIG_SPL_SPINAND_BLOCK_SIZE
(I removed the SUNIV NAND config)

I implemented this in the custom sunxi loader code and made UBI use it.
It might be better off as its own thing in drivers/mtd/nand/spi. Then
perhaps arch/arm/mach-sunxi/spl_spi_sunxi could be refactored and moved
to drivers/mtd/spi/, or removed entirely.

I also want to note that with NAND there's also the question of what to
do with bad blocks: The flash I use has 128KiB block sizes. The SPL is
32KiB and U-Boot is 444KiB, needing 4 blocks.

The boot ROM will try multiple pages. To quote
https://linux-sunxi.org/Bootable_SPI_flash:

"Some SoCs can also boot from SPI NAND flash. Here the BROM tries to
read a valid first stage bootloader starting from page number 0, 32, 64,
96, 128, 160, 192 and 224. It only reads the first 1024 bytes from every
page. Since it simply sends the standard SPI NAND flash commands, it is
a good idea to use a flash with ECC turned on by default and is
performed by the flash itself, since errors cannot otherwise be
corrected."

In other words, it looks at 64KiB offsets from 0KiB to 448KiB. The ROM
will put the offset in the upper byte like it does with MMC.

For my solution I put the SPL at 0KiB, 128KiB, 256KiB and 384KiB. 
I then created a 128MiB UBI partition with a 4MiB U-Boot partition and
dumped the image there. UBI scans each erase block, so that's around
65536 blocks for my UBI partition. I think?

This works surprisingly well and doesn't seem to have a noticeable
impact on boot despite U-Boot being shoved to the end of the NAND in my
setup. I managed to set up fast mapping later but the naive approach
here seems to work without any trouble.

A smarter flash system could try to find a continous set of good blocks,
flash U-Boot there and then flash an SPL pointing to it. But if you're
using NAND you're probably going to be running UBI anyway for Linux, and
the code for this is already here and works. Creating custom software
for this that runs on the target for flashing seems like a pain.

I'd like some feedback or discussion about what is the best soltuion
here to go for. Maybe I'm missing something obvious?

I'd also be interested in which patches from my tree would be a good
start for contributing. I haven't sent any patches to U-Boot before and
starting with a large refactoring probably isn't a good idea when I have
some smaller patches. I might toss these up on the lists soon:

- UART1 and UART2 support for the Mango Pi MQ
- MTD Kconfig requirement for UBI
- UBI SPL FIT support

Thanks for your time,
John.
