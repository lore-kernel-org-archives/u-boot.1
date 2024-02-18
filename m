Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0963C4829E
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 09:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A4987C58;
	Sun, 18 Feb 2024 10:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YQmmEeG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE1887CA3; Sun, 18 Feb 2024 10:15:12 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C81087C52
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 10:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1708247701;
 bh=/k1XCrNffBi3TsJregGFAk5dArVtYpi698C6LK4BUSE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=YQmmEeG80moNEPEP5ggY7n17Zqm9s2mbjbTUDck7OXPYRxIca9dySBjrLRKPI71qG
 vkEZ1pwgQCOyhPP9JoPPib8CCIG3m0ctzUM2hp8e682cBFBBjwM8LCY/F6WjQ6sv0G
 eklptEq0geciYSS74EYOOjvB4/FcoTPYgEwKgrocUktADD6ntZCpiQw7FFtTx9fhnw
 p23PVr5oFpFBiYW45FiIK29eA+M2Mfuh2qi4w/ZHqOwOmcTzsihsMnO6OHqYiLAOAk
 VDK8G1/OSuS/m/7CP5+ze19mT1ihLpy91sBtO4SfzkadIV2OH0QgMVpPnnHRGby4YX
 VKtrr4fU7oDAA==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB25437811D4;
 Sun, 18 Feb 2024 09:15:00 +0000 (UTC)
Message-ID: <9cf74a90ca8ef90d23a480fa896f3facb14dea01.camel@collabora.com>
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,  Jagan Teki
 <jagan@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 u-boot@lists.denx.de
Date: Sun, 18 Feb 2024 09:14:44 +0000
In-Reply-To: <20240217183610.2621132-5-jonas@kwiboo.se>
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
MIME-Version: 1.0
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

Hi Jonas,

On Sat, 2024-02-17 at 18:35 +0000, Jonas Karlman wrote:
> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
> into its own board target and update related defconfigs to use the new
> TARGET_ROCKPI4_RK3399 option.
>=20
> Also move the call to gpt_capsule_update_setup() from the weak function
> rk_board_late_init() into the main board_late_init() function.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> =C2=A0arch/arm/mach-rockchip/board.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++---
> =C2=A0arch/arm/mach-rockchip/rk3399/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++
> =C2=A0board/radxa/rockpi4-rk3399/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++++
> =C2=A0board/radxa/rockpi4-rk3399/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 29 +++++++++++++++++
> =C2=A0.../rockpi4-rk3399}/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0.../rockpi4-rk3399/rockpi4-rk3399.c}=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++------
> =C2=A0board/rockchip/evb_rk3399/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 29 -----------------
> =C2=A0configs/rock-4c-plus-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0configs/rock-4se-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0configs/rock-pi-4-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0configs/rock-pi-4c-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/configs/rk3399_common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ----------
> =C2=A0include/configs/rockpi4-rk3399.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 +++++++++++++++++++
> =C2=A013 files changed, 95 insertions(+), 65 deletions(-)
> =C2=A0create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
> =C2=A0create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
> =C2=A0rename board/{rockchip/evb_rk3399 =3D> radxa/rockpi4-rk3399}/Makefi=
le (79%)
> =C2=A0rename board/{rockchip/evb_rk3399/evb-rk3399.c =3D> radxa/rockpi4-
> rk3399/rockpi4-rk3399.c} (79%)
> =C2=A0create mode 100644 include/configs/rockpi4-rk3399.h
>=20
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/boar=
d.c
> index 4f666aee706f..dea5805c4665 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -34,7 +34,7 @@
> =C2=A0#include <asm/arch-rockchip/periph.h>
> =C2=A0#include <power/regulator.h>
> =C2=A0
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> IS_ENABLED(CONFIG_EFI_PARTITION)
> =C2=A0
> =C2=A0#define DFU_ALT_BUF_LEN			SZ_1K
> =C2=A0
> @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
> =C2=A0
> =C2=A0__weak int rk_board_late_init(void)
> =C2=A0{
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> defined(CONFIG_EFI_PARTITION)
> -	gpt_capsule_update_setup();
> -#endif
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -196,6 +192,10 @@ int board_late_init(void)
> =C2=A0{
> =C2=A0	setup_boot_mode();
> =C2=A0
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> IS_ENABLED(CONFIG_EFI_PARTITION)
> +	gpt_capsule_update_setup();
> +#endif
> +
> =C2=A0	return rk_board_late_init();
> =C2=A0}
> =C2=A0
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-
> rockchip/rk3399/Kconfig
> index d01063ac98b6..bf3600aee2ad 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
> =C2=A0	=C2=A0=C2=A0 * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode onl=
y),
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 1x USB 3.0 type C OTG
> =C2=A0
> +config TARGET_ROCKPI4_RK3399
> +	bool "Radxa ROCK Pi 4 board"
> +	help
> +	=C2=A0 Support for ROCK Pi 4 board family by Radxa.
> +
> =C2=A0config TARGET_ROCKPRO64_RK3399
> =C2=A0	bool "Pine64 Rockpro64 board"
> =C2=A0	help
> @@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
> =C2=A0source "board/pine64/pinebook-pro-rk3399/Kconfig"
> =C2=A0source "board/pine64/pinephone-pro-rk3399/Kconfig"
> =C2=A0source "board/pine64/rockpro64_rk3399/Kconfig"
> +source "board/radxa/rockpi4-rk3399/Kconfig"
> =C2=A0source "board/rockchip/evb_rk3399/Kconfig"
> =C2=A0source "board/theobroma-systems/puma_rk3399/Kconfig"
> =C2=A0source "board/vamrs/rock960_rk3399/Kconfig"
> diff --git a/board/radxa/rockpi4-rk3399/Kconfig b/board/radxa/rockpi4-
> rk3399/Kconfig
> new file mode 100644
> index 000000000000..d82663506b12
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_ROCKPI4_RK3399
> +
> +config SYS_BOARD
> +	default "rockpi4-rk3399"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rockpi4-rk3399"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +
> +endif
> diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS b/board/radxa/rockpi4=
-
> rk3399/MAINTAINERS
> new file mode 100644
> index 000000000000..12d4f35af881
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
> @@ -0,0 +1,29 @@
> +ROCK-PI-4
> +M:	Jagan Teki <jagan@amarulasolutions.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/radxa/rockpi4-rk3399/
> +F:	configs/rock-pi-4-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
> +F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-rock-pi-4a.dts
> +F:	arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> +F:	configs/rock-pi-4c-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-pi-4c.dts
> +F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +
> +ROCK-4C+
> +M:	FUKAUMI Naoki <naoki@radxa.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/rock-4c-plus-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-4c-plus.dts
> +F:	arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +
> +ROCK-4SE
> +M:	Christopher Obbard <chris.obbard@collabora.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/rock-4se-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-4se.dts
> +F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> diff --git a/board/rockchip/evb_rk3399/Makefile b/board/radxa/rockpi4-
> rk3399/Makefile
> similarity index 79%
> rename from board/rockchip/evb_rk3399/Makefile
> rename to board/radxa/rockpi4-rk3399/Makefile
> index aaa51c212e52..3d0225332275 100644
> --- a/board/rockchip/evb_rk3399/Makefile
> +++ b/board/radxa/rockpi4-rk3399/Makefile
> @@ -4,4 +4,4 @@
> =C2=A0# SPDX-License-Identifier:=C2=A0=C2=A0=C2=A0=C2=A0 GPL-2.0+
> =C2=A0#
> =C2=A0
> -obj-y	+=3D evb-rk3399.o
> +obj-y	+=3D rockpi4-rk3399.o
> diff --git a/board/rockchip/evb_rk3399/evb-rk3399.c b/board/radxa/rockpi4=
-
> rk3399/rockpi4-rk3399.c
> similarity index 79%
> rename from board/rockchip/evb_rk3399/evb-rk3399.c
> rename to board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> index ebdd74a7b97f..a533128b92fc 100644
> --- a/board/rockchip/evb_rk3399/evb-rk3399.c
> +++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> @@ -3,13 +3,8 @@
> =C2=A0 * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> =C2=A0 */
> =C2=A0
> -#include <common.h>
> =C2=A0#include <dm.h>
> =C2=A0#include <efi_loader.h>
> -#include <init.h>
> -#include <log.h>
> -#include <asm/arch-rockchip/periph.h>
> -#include <linux/kernel.h>
> =C2=A0
> =C2=A0#define ROCKPI4_UPDATABLE_IMAGES	2
> =C2=A0
> @@ -24,17 +19,15 @@ struct efi_capsule_update_info update_info =3D {
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifndef CONFIG_SPL_BUILD
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> IS_ENABLED(CONFIG_EFI_PARTITION)
> =C2=A0static bool board_is_rockpi_4b(void)
> =C2=A0{
> -	return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
> -		of_machine_is_compatible("radxa,rockpi4b");
> +	return of_machine_is_compatible("radxa,rockpi4b");
> =C2=A0}
> =C2=A0
> =C2=A0static bool board_is_rockpi_4c(void)
> =C2=A0{
> -	return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
> -		of_machine_is_compatible("radxa,rockpi4c");
> +	return of_machine_is_compatible("radxa,rockpi4c");
> =C2=A0}
> =C2=A0
> =C2=A0void rockchip_capsule_update_board_setup(void)
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS
> b/board/rockchip/evb_rk3399/MAINTAINERS
> index fa1f320f5a00..c1196e800e5e 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -95,35 +95,6 @@ F:	configs/orangepi-rk3399_defconfig
> =C2=A0F:	arch/arm/dts/rk3399-orangepi.dts
> =C2=A0F:	arch/arm/dts/rk3399-orangepi-u-boot.dtsi
> =C2=A0
> -ROCK-4C+
> -M:	FUKAUMI Naoki <naoki@radxa.com>
> -R:	Jonas Karlman <jonas@kwiboo.se>
> -S:	Maintained
> -F:	configs/rock-4c-plus-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-4c-plus.dts
> -F:	arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> -
> -ROCK-4SE
> -M:	Christopher Obbard <chris.obbard@collabora.com>
> -R:	Jonas Karlman <jonas@kwiboo.se>
> -S:	Maintained
> -F:	configs/rock-4se-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-4se.dts
> -F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> -
> -ROCK-PI-4
> -M:	Jagan Teki <jagan@amarulasolutions.com>
> -R:	Jonas Karlman <jonas@kwiboo.se>
> -S:	Maintained
> -F:	configs/rock-pi-4-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
> -F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> -F:	arch/arm/dts/rk3399-rock-pi-4a.dts
> -F:	arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> -F:	configs/rock-pi-4c-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-pi-4c.dts
> -F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> -
> =C2=A0ROCK-PI-N10
> =C2=A0M:	Jagan Teki <jagan@amarulasolutions.com>
> =C2=A0S:	Maintained
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus=
-
> rk3399_defconfig
> index 94a9803ac6b5..8d4bfe902e8f 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-4c-plus"
> =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> -CONFIG_TARGET_EVB_RK3399=3Dy
> +CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_SPL_STACK=3D0x400000
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-
> rk3399_defconfig
> index e27e4a221267..9acdf52a82f2 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-4se"
> =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> -CONFIG_TARGET_EVB_RK3399=3Dy
> +CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_SPL_STACK=3D0x400000
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-
> rk3399_defconfig
> index eb6727f22ae2..dcc9fd3084e3 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-pi-4a"
> =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> -CONFIG_TARGET_EVB_RK3399=3Dy
> +CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_SPL_STACK=3D0x400000
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-
> rk3399_defconfig
> index 247518c42b13..da2e7349f677 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-pi-4c"
> =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> -CONFIG_TARGET_EVB_RK3399=3Dy
> +CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_SPL_STACK=3D0x400000
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> diff --git a/include/configs/rk3399_common.h
> b/include/configs/rk3399_common.h
> index 96ba19c659bd..4e75771055b8 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -13,22 +13,6 @@
> =C2=A0#define CFG_SYS_SDRAM_BASE		0
> =C2=A0#define SDRAM_MAX_SIZE			0xf8000000
> =C2=A0
> -#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
> -	EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
> -		 0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
> -
> -#define ROCKPI_4B_UBOOT_IMAGE_GUID \
> -	EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
> -		 0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
> -
> -#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
> -	EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
> -		 0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
> -
> -#define ROCKPI_4C_UBOOT_IMAGE_GUID \
> -	EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
> -		 0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
> -
> =C2=A0#ifndef CONFIG_SPL_BUILD
> =C2=A0
> =C2=A0#define ENV_MEM_LAYOUT_SETTINGS \
> diff --git a/include/configs/rockpi4-rk3399.h b/include/configs/rockpi4-
> rk3399.h
> new file mode 100644
> index 000000000000..1936e06ab3c2
> --- /dev/null
> +++ b/include/configs/rockpi4-rk3399.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __ROCKPI4_RK3399_H
> +#define __ROCKPI4_RK3399_H
> +
> +#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
> +	EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
> +		 0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
> +
> +#define ROCKPI_4B_UBOOT_IMAGE_GUID \
> +	EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
> +		 0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
> +
> +#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
> +	EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
> +		 0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
> +
> +#define ROCKPI_4C_UBOOT_IMAGE_GUID \
> +	EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
> +		 0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdin=3Dserial,usbkbd\0" \
> +		"stdout=3Dserial,vidconsole\0" \
> +		"stderr=3Dserial,vidconsole\0"
> +
> +#include <configs/rk3399_common.h>
> +
> +#endif
