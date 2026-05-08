Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B6CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE7184B56;
	Fri,  8 May 2026 13:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y0DNHBEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1403684BDC; Fri,  8 May 2026 13:08:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB54984AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBmZ84xfRz9sjG;
 Fri,  8 May 2026 13:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778238496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbhrVYhSMawHJJfOp3khmsnetnM23zXsNZzHxmbxkxA=;
 b=Y0DNHBEnoUl9X995KwnCGngGqjANCCiEXdAAhWm5GftKL/9eV336FXn8MNlRoxYMCcS/l1
 oDyH+9KhVSYExPoZRLNoyKx8Jh3iQo7HNpgO4Fw6UJ0SZ1OofifzBvCW+3gSRIu3iGe9M/
 H5KeJns0Eo7W3kdmQe/s0nVhh34UuZgXdszH+wAdnhyp4/JMt2LAQ4s6AtnoV0lnXWaBmi
 6N4cNnHVY8Lw8LCQcPm1WIj9mTkEQFy1Go7gx2BR+ns/8ymgrm4GUJgZg3t3hom4xi6qn2
 sglxFX60v0Td6oNygpPxUIisDmvjIoXENizFJxz3Hx+xtEZfZJJ7TQZ2xxXzbg==
Message-ID: <a63855c7-f2b3-4b99-a5d5-6a2cd25a2a30@mailbox.org>
Date: Fri, 8 May 2026 13:08:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1773151972.git.vjardin@free.fr>
 <cover.1776762022.git.vjardin@free.fr>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <cover.1776762022.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c488856c0017af9a63b
X-MBO-RS-META: bbxhanzkaa1x6oqgchk4yqpmpm5n6jxe
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

On 4/21/26 11:04, Vincent Jardin wrote:
> This v2 addresses Stefan Roese's review feedback on v1:
>    https://lists.denx.de/pipermail/u-boot/2026-March/613625.html
> 
> Changes since v1:
>   - Patch 1 (cpuinfo/SAR): added Reviewed-by Stefan
>   - Patch 2 (board support):
>       * dropped board_init() bi_boot_params assignment
>         (ARM64 uses FDT, ATAGS are !ARM64-only)
>       * dropped empty board_early_init_f()
>       * removed unused includes / DECLARE_GLOBAL_DATA_PTR
>       * added note on U-Boot vs Linux comphy DT bindings
>       * MAINTAINERS: armada-8040-nbx* wildcard covers the u-boot dtsi;
>         removed duplicate NBX BOARD entry from
>         board/Marvell/mvebu_armada-8k/MAINTAINERS
>       * added Reviewed-by Stefan
>   - Patch 3 (emmcboot): moved from cmd/mvebu/ to board/freebox/nbx10g/,
>       renamed Kconfig CMD_MVEBU_EMMCBOOT -> CMD_NBX_EMMCBOOT and
>       MVEBU_MMC_PART_* -> NBX_MMC_PART_*, replaced all `return -1`
>       with `return -EINVAL`, commit message now explains legacy format
>   - Patch 4 (fbxserial): moved from cmd/mvebu/ to board/freebox/nbx10g/,
>       replaced all `return -1` with proper errno codes
>       (-EINVAL for data validation, -ENODEV for missing MMC,
>        -EIO for MMC I/O failures)
>   - Patch 5 (U-Boot dtsi): added Reviewed-by Stefan

Thanks. Next time, please include this revision history into the
patches. This makes the review a bit easier. Please see here:

https://docs.u-boot.org/en/stable/develop/sending_patches.html#sending-updated-patch-versions

Thanks,
Stefan

> Build tested on Nodebox 10G (ATF v2.14 + U-Boot 2026.04 + Linux 6.19),
> all functionality verified on hardware.
> 
> Vincent Jardin (5):
>    arm: mach-mvebu: armada8k: cpuinfo and SAR
>    board: freebox: add Nodebox 10G board support
>    board: freebox: nbx10g: add emmcboot for dual-bank eMMC boot
>    board: freebox: nbx10g: add device serial and MAC address
>      initialization
>    arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE
> 
>   arch/arm/dts/Makefile                    |   1 +
>   arch/arm/dts/armada-8040-nbx-u-boot.dtsi |  15 +
>   arch/arm/dts/armada-8040-nbx.dts         | 259 ++++++++++++++++
>   arch/arm/mach-mvebu/Kconfig              |   9 +
>   arch/arm/mach-mvebu/armada8k/Makefile    |   2 +-
>   arch/arm/mach-mvebu/armada8k/cpu.c       |  12 +
>   arch/arm/mach-mvebu/armada8k/soc_info.c  | 194 ++++++++++++
>   arch/arm/mach-mvebu/armada8k/soc_info.h  |  14 +
>   board/freebox/nbx10g/Kconfig             |  94 ++++++
>   board/freebox/nbx10g/MAINTAINERS         |   6 +
>   board/freebox/nbx10g/Makefile            |   5 +
>   board/freebox/nbx10g/board.c             |  53 ++++
>   board/freebox/nbx10g/nbx_emmcboot.c      | 357 +++++++++++++++++++++++
>   board/freebox/nbx10g/nbx_fbxserial.c     | 286 ++++++++++++++++++
>   board/freebox/nbx10g/nbx_fbxserial.h     | 156 ++++++++++
>   board/freebox/nbx10g/nbx_imagetag.h      |  78 +++++
>   board/freebox/nbx10g/nbx_nrboot.h        |  34 +++
>   configs/mvebu_nbx_88f8040_defconfig      |  75 +++++
>   include/configs/nbx10g.h                 |  29 ++
>   19 files changed, 1678 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi
>   create mode 100644 arch/arm/dts/armada-8040-nbx.dts
>   create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.c
>   create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.h
>   create mode 100644 board/freebox/nbx10g/Kconfig
>   create mode 100644 board/freebox/nbx10g/MAINTAINERS
>   create mode 100644 board/freebox/nbx10g/Makefile
>   create mode 100644 board/freebox/nbx10g/board.c
>   create mode 100644 board/freebox/nbx10g/nbx_emmcboot.c
>   create mode 100644 board/freebox/nbx10g/nbx_fbxserial.c
>   create mode 100644 board/freebox/nbx10g/nbx_fbxserial.h
>   create mode 100644 board/freebox/nbx10g/nbx_imagetag.h
>   create mode 100644 board/freebox/nbx10g/nbx_nrboot.h
>   create mode 100644 configs/mvebu_nbx_88f8040_defconfig
>   create mode 100644 include/configs/nbx10g.h
> 

