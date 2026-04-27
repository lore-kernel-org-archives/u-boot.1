Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627E6FF886D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 20:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26EB84150;
	Mon, 27 Apr 2026 22:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="BE/0hmbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C6284178; Mon, 27 Apr 2026 22:23:34 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F165F83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 22:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Message-ID: <91b9a06ae21a64c0fec04f053798f302689a0067.camel@grimler.se>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1777321411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P27kDT7NMiOTMfAdflZ66/CgoBIIz6MEMfTeIS8et0E=;
 b=BE/0hmboZKncrNc1LxtuhwLoJNfdQom4w4m24D81Wb1tQyGnvNcbQzinIlZ6pNed7UJbMk
 E4QX1fZLdaPnO3MbkCRxiyp8OxpaIvgMxp1AqIhPdgv/Q0TgzgNJ1RklSsEYgtngrKEe81
 SVACC6o4hMxrOKRYPePk1nwabixXU1w=
Subject: Re: [PATCH 0/4] HS400 and HS400ES support for Exynos DW-MMC drivers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Peng Fan
 <peng.fan@nxp.com>, 	u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko	 <semen.protsenko@linaro.org>, Lukas Timmermann
 <uboot@timmermann.space>
Date: Mon, 27 Apr 2026 22:23:28 +0200
In-Reply-To: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
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

Hi Kaustabh,

On Mon, 2026-04-27 at 11:22 +0530, Kaustabh Chakraborty wrote:
> Since upstream dts version v7.0+, Exynos 7870 devices have an
> explicit
> `bus-width =3D <8>` property. This results in the U-Boot driver trying
> to
> initialize the HS400 mode, which appears to fail. The HS400 support
> added in the DW-MMC Exynos driver appears to have an incomplete init
> sequence.
>=20
> This patch series adds the missing pieces to enable HS400 support,
> and
> additionally adds support for HS400ES too.

Seems like exynos5422-odroid-xu4 can support hs400 as well based on
Hardkernel's device trees [1]. I will try to test on that device during
the week to get some more test coverage for this series.

[1]
https://github.com/hardkernel/linux/blob/odroidxu4-6.1.y/arch/arm/boot/dts/=
exynos5422-odroidxu3-common.dtsi#L491

Best regards,
Henrik Grimler

> The last patch in the series also enables HS400ES support in the
> exynos-mobile defconfig.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc: exynos_dw_mmc: add proper init sequen=
ce for HS400 support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc: dw_mmc: setup set_enhanced_strobe ops=
 in driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc: exynos_dw_mmc: add support for HS400E=
S
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configs: exynos-mobile: enable support for=
 HS400ES in MMC
> driver
>=20
> =C2=A0arch/arm/mach-exynos/include/mach/dwmmc.h |=C2=A0 5 ++
> =C2=A0configs/exynos-mobile_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/mmc/dw_mmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 +++++++
> =C2=A0drivers/mmc/exynos_dw_mmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 88
> ++++++++++++++++++++++++++++++-
> =C2=A0include/dwmmc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++
> =C2=A05 files changed, 121 insertions(+), 2 deletions(-)
> ---
> base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
> change-id: 20260427-dwmmc-exynos-hs400-es-b77009a808ce
>=20
> Best regards,
> --=C2=A0=20
> Kaustabh Chakraborty <kauschluss@disroot.org>
