Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28766CD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04448494B;
	Sat, 13 Jun 2026 15:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="giAjovvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F68847B0; Sat, 13 Jun 2026 14:03:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBD283FEC
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 14:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1080C26FD5;
 Sat, 13 Jun 2026 14:03:34 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUV37oxT0_Po; Sat, 13 Jun 2026 14:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781352213; bh=Y3BqN93hyzbUe0zEOUhELFQiOGE7sXi3ACEbVAhKDMM=;
 h=Date:To:Cc:Subject:From:References:In-Reply-To;
 b=giAjovvG8L87/pnsFIQ9ugz5pz2n4+KTvyicErBzBlLkDXdwkuFgs9ZjzqSEdvK4V
 WVm2d4ajQbeAW0cUTVeLp7ghFmMKLF2KfXxaxmqKbk3EreIdIX19t6tQr21lmUQChW
 yu3cXkptYYmY03SYyuBnU+CAXQI9e6looTCKB5LmaipFJtxVsolmd6gpCoSHKVFD4D
 FkKAtdft0XPD/UwKae/Rj/sho7HeECf9lgRc++cYtiZT6nR/xDf0JpHw9P1xgsle2l
 ktmLPBGVKOt9nWpVPpb70HNx9OHKmipOzYrAZvjOj7hiZsH3rVUl0k+EB0rq9fuRfZ
 eQXiaOVFbph8A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 17:33:17 +0530
Message-Id: <DJ7WNI7STFIV.96BLECLBH8Z1@disroot.org>
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
Subject: Re: [PATCH v3 09/10] arch: arm: exynos: add j7xelte binman config
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
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
> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
> upstream DTS tree. It was accepted into next so it should appear here
> eventually.

The description seems lacking. A concise documentation for this build
process would be nice, and the same must also be mentioned in
`doc/board/samsung/exynos-mobile.rst`.

>
> Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080.=
b4-ty@kernel.org/
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 26 +++++++++++++++++++++++=
+++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/e=
xynos7870-j7xelte-u-boot.dtsi
> new file mode 100644
> index 00000000000..0cd4c12a2e4
> --- /dev/null
> +++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	binman {
> +		filename =3D "u-boot-samsung-j7xelte.img";
> +
> +		android-boot {
> +			/* S-BOOT ignores offsets, so they are not provided here */
> +			kernel {
> +				u-boot-nodtb { };
> +			};
> +
> +			vendor-dt {
> +				dtbh {
> +					dtb-0 {
> +						model_info-chip =3D <7870>;
> +						model_info-hw_rev =3D <0>;
> +						model_info-hw_rev_end =3D <255>;
> +
> +						u-boot-dtb { };
> +					};
> +				};
> +			};
> +		};
> +	};
> +};

