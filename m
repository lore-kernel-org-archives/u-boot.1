Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38970CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 04:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44343807B1;
	Mon, 20 Oct 2025 06:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="GPrLYeho";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="FsNBmCdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860EC8386B; Sun, 19 Oct 2025 11:40:02 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A3E836D1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 11:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dang.huynh@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1760866789; bh=eE3awtydXhPZ3GlNHSIkkJD
 Wc4/HJJe7tSexGd3EweM=; b=GPrLYehoJzL+pLsAOYkZInnNPRCxCD8d9vIGU7OFX2HgHxiPAI
 hr88hRMe2fZhp+aIp2sy0OwJANb+sqTAgdR67OE/MvLL4q93ypv3I6220ikPNFWKwmDv3voXBJQ
 BsU01kfG/9iL1CDhf8OyA3rfDvjPp8PfQJ2YZfW8Eu/e1GMNCHrRAyuUmSG5AgkfiByO/Pfx3kE
 5rrT3imemliSddwP5jzEMJrzaNHdKt92xdg4X3kodfFnhhxnImRaWQ4UOxB/+HktygW3O3AjKUi
 a5pZ0gwPhuhMLo2gkNo2a8fJYWH2sTNtG6HNbZ4nfK/WMlawMGi4MyjVVr3ay5wFsjQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1760866789; bh=eE3awtydXhPZ3GlNHSIkkJD
 Wc4/HJJe7tSexGd3EweM=; b=FsNBmCdIjrhn7/y03FuZh9q9MMpXLbbhX3YSzcCLcEIKwb7Iwg
 ++Z3a7UFoCOpP23QNAauagHIgJxOpJh6sjCA==;
From: Dang Huynh <dang.huynh@mainlining.org>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 0/4] rockchip: Add support for RAM boot from maskrom
 mode
Date: Sun, 19 Oct 2025 09:39:46 +0000
Message-ID: <3064939.mvXUDI8C0e@melttower>
In-Reply-To: <20250802220738.3018910-1-jonas@kwiboo.se>
References: <20250802220738.3018910-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Mon, 20 Oct 2025 06:31:54 +0200
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

Tested on my PineTab 2 using rkusbboot.

Tested-by: Dang Huynh <dang.huynh@mainlining.org> (RK3566 - PineTab 2)

On Saturday, August 2, 2025 10:07:21=E2=80=AFPM Coordinated Universal Time =
Jonas=20
Karlman wrote:
> The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
> cannot be found in nand/spi/mmc storage.
>=20
> In maskrom mode the USB OTG port can accept one of two custom commands.
>=20
> Initially a 0x471 command to load TPL into SRAM. After TPL has been
> executed and it has returned back-to-BROM, a 0x472 command to load SPL
> into start of DRAM.
>=20
> This series adds two binman images that can be used to RAM boot from
> maskrom mode:
> - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
> - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
>   payload with i.e. U-Boot proper, TF-A and FDT.
>=20
> The config fragment rockchip-ramboot.config can be used to enable
> building of these two binman images, e.g.:
>=20
>   make generic-rk3588_defconfig rockchip-ramboot.config
>=20
> These binman images can be used with the proprietary rkbin boot_merger
> tool to create a special loader image that can be used with tools such
> as rkdeveloptool or rockusb tools to RAM boot from maskrom, e.g.:
>=20
>   Create loader image:
>     $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
>=20
>   Boot from maskrom:
>     $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
>    or
>     $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin
>=20
> Another option that does not require use of proprietary tools is using
> open source tools such as rkflashtool or rkusbboot that can load the
> binman images directly without any need to first create a special loader
> image to RAM boot from maskrom, e.g.:
>=20
>   $ rkflashtool l < u-boot-rockchip-usb471.bin
>   $ rkflashtool L < u-boot-rockchip-usb472.bin
>  or
>   $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
>=20
> I am setting up a new personal lab for rockchip boards that primarily
> will use this RAM boot method for testing new U-Boot and Linux builds.
>=20
> More detailed instructions on how RAM boot can be used will be added
> under doc/board/rockchip/ in a follow-up series, after this series has
> been accepted and my new lab is fully up and running.
>=20
> Changes in v3:
> - Use read_brom_bootsource_id() to support RAM boot on RK3576
> - Add a rockchip-ramboot.config fragment to explicitly enable instead of
>   imply the new Kconfig option on a few select SoCs
> - Update commit message to highlight that the binman images can be used
>   directly without use of the proprietary rkbin boot_merger tool
> - Include a special patch, not intended to be merged, to demonstrate use
>   of RAM boot with rk loader images
>=20
> Changes in v2:
> - Rebase on top of "rockchip: binman: Use a template for FIT and other
>   improvements" series
> - Add patch to fix booting into Linux on RK3588 board with 16+ GiB DRAM
>=20
> This series depends on the "rockchip: Add support for ROCK 5B+" [1] and
> "board: rockchip: Add Radxa ROCK 4D" [2] series for a clean apply.
> See [3] for a branch including both depends.
>=20
> [1] https://patchwork.ozlabs.org/cover/2118033/
> [2] https://patchwork.ozlabs.org/cover/2118088/
> [3]
> https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboo=
t-> v3
>=20
> Jonas Karlman (4):
>   rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
>   rockchip: Add support for RAM boot from maskrom mode
>   rockchip: sdram: Add fallback that fixup DRAM gaps on RK3588
>   HACK: rockchip: Add miniall.ini files to simplify test of RAM boot
>=20
>  RK3308MINIALL.ini                       | 22 +++++++++++++++++
>  RK3328MINIALL.ini                       | 20 +++++++++++++++
>  RK3399MINIALL.ini                       | 20 +++++++++++++++
>  RK3528MINIALL.ini                       | 25 +++++++++++++++++++
>  RK3566MINIALL.ini                       | 25 +++++++++++++++++++
>  RK3568MINIALL.ini                       | 25 +++++++++++++++++++
>  RK3576MINIALL.ini                       | 27 ++++++++++++++++++++
>  RK3588MINIALL.ini                       | 25 +++++++++++++++++++
>  arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
>  arch/arm/mach-rockchip/Kconfig          | 14 ++++++++---
>  arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3588/rk3588.c  | 27 ++++++++++++++++++++
>  arch/arm/mach-rockchip/sdram.c          |  7 +++++-
>  arch/arm/mach-rockchip/spl-boot-order.c | 14 ++++++++---
>  board/rockchip/rockchip-ramboot.config  |  1 +
>  boot/Kconfig                            |  3 +++
>  18 files changed, 281 insertions(+), 16 deletions(-)
>  create mode 100644 RK3308MINIALL.ini
>  create mode 100644 RK3328MINIALL.ini
>  create mode 100644 RK3399MINIALL.ini
>  create mode 100644 RK3528MINIALL.ini
>  create mode 100644 RK3566MINIALL.ini
>  create mode 100644 RK3568MINIALL.ini
>  create mode 100644 RK3576MINIALL.ini
>  create mode 100644 RK3588MINIALL.ini
>  create mode 100644 board/rockchip/rockchip-ramboot.config




