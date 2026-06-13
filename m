Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744A0CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875A68493F;
	Sat, 13 Jun 2026 15:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Tf+RqA0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2163B84841; Sat, 13 Jun 2026 13:59:47 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4E983FEC
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 13:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C49222719E;
 Sat, 13 Jun 2026 13:59:44 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGUBjqRAcJDu; Sat, 13 Jun 2026 13:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781351984; bh=nsd2lLA5Wy7uFVbTQyENbLTeS/j+C6j2hXQZZoY2F40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Tf+RqA0Bjb63s8hPMJXscBAnPIiphGIpMSrB5yKcBbBomSW4b7Q/muIh/bMY/k1sS
 zxkoYne4lEw06bhtLp8ZyQwdRC66yiThjJx3oqopP29ve0SlU4p/fl5UILYsbMQyJ7
 SnBTGlYas+DMRzMnv+QjnoJ8XcBk+oXyYwklkya9KLAgqMfbvGIZgrrJkUml0drghf
 MJierLfvTuNm8D+QNp/xIEmwwMD9/IYUuS95W8RcjHfHYU/cmC7PUUrFvMzLHSyFkl
 NSdffxtw4KmtSumQOM2G25SCCmxiOEUQblT7wef+x6RSkxE66ldHTZmU3P1UNmTHYz
 UP7y9rnJIU4ew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 17:29:27 +0530
Message-Id: <DJ7WKKCFLI4S.QSJ8NELF2QU@disroot.org>
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: <me@samcday.com>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Bryan Brattlof" <bb@ti.com>, "Yannic Moog"
 <y.moog@phytec.de>, "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>, "Yegor
 Yefremov" <yegorslists@googlemail.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Rasmus Villemoes"
 <ravi@prevas.dk>, "Javier Tia" <floss@jetm.me>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Kaustabh Chakraborty" <kauschluss@disroot.org>,
 "Henrik Grimler" <henrik@grimler.se>, "yan wang" <yan.wang@softathome.com>,
 "Marek Vasut" <marex@nabladev.com>, "Denis Mukhin" <dmukhin@ford.com>
Subject: Re: [PATCH v3 10/10] configs: exynos-mobile: pull in binman
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-10-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-10-710298a38fcc@samcday.com>
X-Mailman-Approved-At: Sat, 13 Jun 2026 15:22:52 +0200
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

On 2026-06-10 11:27 +10:00, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
>
> All Exynos7 mobile devices need abootimg+DTBH wrapping to be bootable
> from the fused S-BOOT bootloader. So we enable binman everywhere.
> Ideally we'll have full coverage of these devices with binman configs in
> the overlay DTSIs but, for now, we ensure there's a placeholder node.
> That way no existing devices will regress their cleanly buildable state.

> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/dts/exynos-mobile.dtsi | 5 +++++
>  arch/arm/mach-exynos/Kconfig    | 1 +
>  configs/exynos-mobile_defconfig | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/exynos-mobile.dtsi b/arch/arm/dts/exynos-mobile=
.dtsi
> new file mode 100644
> index 00000000000..9982e996993
> --- /dev/null
> +++ b/arch/arm/dts/exynos-mobile.dtsi
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0

No copyright notice?

> +/ {
> +	binman {
> +	};
> +};
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index b084b7284aa..d4ae182030d 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -255,6 +255,7 @@ endif
>  config TARGET_EXYNOS_MOBILE
>  	bool "Samsung Exynos Generic Boards (for mobile devices)"
>  	select ARM64
> +	select BINMAN
>  	select BOARD_EARLY_INIT_F
>  	select CLK_EXYNOS
>  	select LINUX_KERNEL_IMAGE_HEADER
> diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defc=
onfig
> index 45ab998bb45..fcaff3d1608 100644
> --- a/configs/exynos-mobile_defconfig
> +++ b/configs/exynos-mobile_defconfig
> @@ -32,6 +32,7 @@ CONFIG_EFI_PARTITION=3Dy
>  CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_OF_UPSTREAM_BUILD_VENDOR=3Dy
>  CONFIG_OF_BOARD=3Dy
> +CONFIG_DEVICE_TREE_INCLUDES=3D"exynos-mobile.dtsi"

What about, instead of this you add an empty binman node to the other
existing devices? I have tested it with on7xelte and j6lte and it works
as intended.

After this is pulled in, I will submit a patch for binman changes for
those devices, so there's no need of a new .dtsi file.

Alternatively, this series can carry said changes for those devices in a
future revision if you want. Up to you.

>  CONFIG_BLKMAP=3Dy
>  CONFIG_BUTTON_REMAP_PHONE_KEYS=3Dy
>  CONFIG_CLK_EXYNOS7870=3Dy

