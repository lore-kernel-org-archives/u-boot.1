Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 07:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929B786EF6;
	Mon,  6 Nov 2023 08:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qo0d2xGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF6286F68; Mon,  6 Nov 2023 08:49:16 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C1686E82
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 08:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 02AABB80D88;
 Mon,  6 Nov 2023 07:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086C7C433C7;
 Mon,  6 Nov 2023 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699256949;
 bh=+fSPCXz02vgWzJ7+w8IEw4Ilonz4pdBYmflPChdXM9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qo0d2xGJCv3Eda+5rP/7t7s6sxEf0uT81L9mKQh9hZUVUwGEsf65+ktFBt49rnBOA
 CFhPjHMEjKca4JZrkU+7k0tnGz8ZpWqJznQ0ULX88wSVjIis8B1fySNmPxCEUtf1wC
 fW4ExP4mCjAd1rFfx/dJX05xkyYQtj/73cJfP/Ezdx7fg7FpQPlCK/Sta1cpRWgZFr
 P/MAax6v/Gg0LwZynI1RWv4U/esOdPvavqDtm/04C8PLtVaC3XUI5UmpqT5zEa4VMV
 sysOe4i4af6/xOC4ltt45GOvebpM+F3TSYcJtbIRvair1KhY/7KIXlTBpGwkhZLQHx
 naK0LpNT8NSTQ==
Received: by pali.im (Postfix)
 id 1457A802; Mon,  6 Nov 2023 08:49:06 +0100 (CET)
Date: Mon, 6 Nov 2023 08:49:05 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 00/25] spl: Use common function for loading/parsing
 images
Message-ID: <20231106074905.pgrdj6zhsgy66a2e@pali>
References: <20231106022603.3405551-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
User-Agent: NeoMutt/20180716
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

What you are doing is the worst thing in the world. You have been
ignoring all my changes which I have been sending for one year, then you
wrote me that I'm not competent to do any kind of programming, later you
wrote that you would ignore all my requests and stop responding to any
questions, then you have removed all my code from u-boot and showed me
as the worst person in the world.

But seems that this is not enough for you. You have to continue
attacking on me, and making everything even worse.

WHAT YOU WANT FROM ME NOW???? WHY YOU ARE CONTACTING ME??? IS NOT IT
ENOUGH WHAT YOU HAVE TO ME?? Or you do think that I forgot what you have
been doing with me last years? Speak up!

On Sunday 05 November 2023 21:25:38 Sean Anderson wrote:
> This series adds support for loading all image types (Legacy (with and without
> LZMA), FIT (with and without LOAD_FIT_FULL), and i.MX) to the MMC, SPI, NOR,
> NET, FAT, EXT, NVMe, and semihosting load methods. It does this by introducing a
> helper function which handles the minutiae of invoking the proper parsing
> function, and reading the rest of the image.
> 
> Hopefully, this will make it easier for load methods to support all image types
> that U-Boot supports, without having undocumented unsupported image types. I
> applied this to several loaders which were invoking spl_load_simple_fit and/or
> spl_parse_image_header, but I did not use it with others (e.g. DFU/RAM) which
> had complications in the mix.
> 
> This series is organized roughly into two parts. Patches up to "spl: Add generic
> spl_load function" are all setup or size-reduction oriented. Later patches
> generally convert various load functions to spl_load.
> 
> bloat-o-meter results (for CONFIG_SPL only) at [1]. Size growth has been the
> bigegst challenge to preparing this series. I have used every trick I can think
> of to reduce bloat. Some SAMA boards no longer fit, but I have a plan to fix
> them [2].
> 
> This is bar far the largest and most-difficult revision of this series to-date.
> There are probably still things which can reduce the size, but I have been
> working on this series for the better part of two months and I think it is a
> good idea to get some feedback. Because of the SAMA bloat, this series will not
> pass CI, so I expect to do a v7 before this is ready to apply. Feel free,
> however, to apply patches in the first half (especially the fixes).
> 
> This version of the series is better-tested than ever before, thanks to some new
> unit tests. However, things like the i.MX ROMAPI are untested. NAND should also
> be tested more-widely, for reasons listed in the commit message. I encourage you
> try this series out on your favorite board.
> 
> This series depends on [3]. (Almost passing) CI at [4].
> 
> [1] https://gist.github.com/Forty-Bot/5bfe88676dd3c2aec6ebc23abb08e06f
>     This includes some changes to am335x_evm_spiboot and am65x_evm_r5_usbdfu
>     which have since been undone.
> [2] https://lore.kernel.org/u-boot/20231105022742.632175-1-seanga2@gmail.com/
> [3] https://lore.kernel.org/u-boot/20231104203753.1579217-1-seanga2@gmail.com/
> [4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18447
> 
> Changes in v6:
> - Fix uninitialized return value when we can't get a blk_desc
> - Don't close fd before spl_load_simple_fit
> - Remove NULL assignments in spl_load_info
> - Remove dev from spl_load_info
> - Take advantage of bl_len's power-of-twoness
> - Refactor spl_load_info->read to use units of bytes
> - Remove filename from spl_load_info
> - Only support bl_len when we have to
> - Remove spl_nand_legacy_read
> - Split off LZMA decompression into its own function
> - Support testing LEGACY_LZMA filesystem images
> - Use pseudo-LTO for spl_load
> - Align reads to bl_len
> - Add SYS_MMCSD_RAW_MODE to help determine whether SPL_MMC loads
>   anything directly.
> - Convert nand to spl_load
> - Fix LZMA support
> - Fix load address
> - Fix invalid return from spl_blk_load_image
> - Fix soft reset after loading from SPI
> - Explicitly initialize load_info members to reduce text size
> - Rebase on u-boot/next
> - Add option to disable DMA alignment for FAT
> 
> Changes in v5:
> - Make SHOW_ERRORS depend on LIBCOMMON
> - Load the header in spl_load as well
> - Don't bother trying to DMA-align the buffer, since we can't really fix
>   it.
> - Convert NVMe to spl_load
> 
> Changes in v4:
> - Fix format specifiers in debug prints
> - Reword/fix some of the doc comments for spl_load
> - Rebase on u-boot/master
> 
> Changes in v3:
> - Fix using ffs instead of fls
> - Fix using not initializing bl_len when info->filename was NULL
> - Fix failing on success
> 
> Changes in v2:
> - Use reverse-xmas-tree style for locals in spl_simple_read. This is not
>   complete, since overhead depends on bl_mask.
> - Convert semihosting as well
> - Consolidate spi_load_image_os into spl_spi_load_image
> 
> Sean Anderson (25):
>   spl: blk_fs: Fix uninitialized return value when we can't get a
>     blk_desc
>   arm: Disable SPL_FS_FAT when it isn't used
>   spl: Make SHOW_ERRORS depend on LIBCOMMON
>   spl: semihosting: Don't close fd before spl_load_simple_fit
>   spl: Remove NULL assignments in spl_load_info
>   spl: Remove dev from spl_load_info
>   spl: Take advantage of bl_len's power-of-twoness
>   spl: Refactor spl_load_info->read to use units of bytes
>   spl: Remove filename from spl_load_info
>   spl: Only support bl_len when we have to
>   spl: nand: Remove spl_nand_legacy_read
>   spl: legacy: Split off LZMA decompression into its own function
>   test: spl: Support testing LEGACY_LZMA filesystem images
>   spl: Add generic spl_load function
>   spl: Convert ext to use spl_load
>   spl: Convert fat to spl_load
>   spl: Convert mmc to spl_load
>   spl: Convert nand to spl_load
>   spl: Convert net to spl_load
>   spl: Convert nor to spl_load
>   spl: Convert NVMe to spl_load
>   spl: Convert semihosting to spl_load
>   spl: Convert spi to spl_load
>   spl: spi: Consolidate spi_load_image_os into spl_spi_load_image
>   spl: fat: Add option to disable DMA alignment
> 
>  arch/arm/mach-imx/spl_imx_romapi.c        |  24 ++--
>  arch/arm/mach-sunxi/spl_spi_sunxi.c       |   5 +-
>  common/spl/Kconfig                        |  37 +++++-
>  common/spl/spl.c                          |  13 +-
>  common/spl/spl_blk_fs.c                   |  73 +++--------
>  common/spl/spl_ext.c                      |  36 +++---
>  common/spl/spl_fat.c                      |  62 ++++------
>  common/spl/spl_fit.c                      |  74 ++++-------
>  common/spl/spl_imx_container.c            |  55 ++++-----
>  common/spl/spl_legacy.c                   | 110 ++++-------------
>  common/spl/spl_mmc.c                      | 101 ++-------------
>  common/spl/spl_nand.c                     | 104 ++++------------
>  common/spl/spl_net.c                      |  29 +----
>  common/spl/spl_nor.c                      |  42 ++-----
>  common/spl/spl_ram.c                      |   2 +-
>  common/spl/spl_semihosting.c              |  65 ++--------
>  common/spl/spl_spi.c                      | 130 ++++---------------
>  common/spl/spl_ymodem.c                   |   4 +-
>  configs/am335x_evm_spiboot_defconfig      |   2 +-
>  configs/am65x_evm_r5_usbdfu_defconfig     |   1 -
>  configs/xilinx_zynqmp_mini_qspi_defconfig |   3 +
>  configs/zynq_cse_nand_defconfig           |   3 +
>  configs/zynq_cse_nor_defconfig            |   3 +
>  configs/zynq_cse_qspi_defconfig           |   3 +
>  drivers/usb/gadget/f_sdp.c                |  10 +-
>  include/spl.h                             |  60 +++++++--
>  include/spl_load.h                        | 144 ++++++++++++++++++++++
>  include/test/spl.h                        |   4 +
>  test/image/Kconfig                        |   1 +
>  test/image/spl_load.c                     |  13 +-
>  test/image/spl_load_fs.c                  |  32 +++--
>  test/image/spl_load_nand.c                |   2 +
>  test/image/spl_load_net.c                 |   2 +
>  test/image/spl_load_nor.c                 |   2 +
>  test/image/spl_load_os.c                  |  16 ++-
>  test/image/spl_load_spi.c                 |   1 +
>  36 files changed, 536 insertions(+), 732 deletions(-)
>  create mode 100644 include/spl_load.h
> 
> -- 
> 2.37.1
> 
