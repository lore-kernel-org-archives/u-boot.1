Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49636CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BD4849E4;
	Sun, 21 Jun 2026 21:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="FcwAQZJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FEF284869; Sun, 21 Jun 2026 19:37:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B1D84119
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 19:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 12223272C9;
 Sun, 21 Jun 2026 19:37:34 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YneC9Wc0gwfF; Sun, 21 Jun 2026 19:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1782063453; bh=hTo11ckIdLbsGlW6NcROlz6jdjBbeGaxojU+ZH37DuM=;
 h=Date:To:Cc:Subject:From:References:In-Reply-To;
 b=FcwAQZJJkHf1a/U7CwLHHbhGOAXRocAVk6v76MiH/fXye5VEdjacFmY3cPWH4LhBh
 dF3oqjYuK7dqXsffHrbqMQ2sS4mRz2hd+8Wm5OgA/tf633NDvpWzBBurlHnsk6Aqz1
 yVJdR9m2HWdApFOmnlmPo4iuTdZyudNlM2zfxSBzL3acE62wQ37dV/1PjTtcZa4von
 7EIDIvHwus5KsASFfU0SSxiVC407a3h+Ky9c6BYjnvfdQK5upOt8KmQ7L0wyTiYroS
 P8InE4QRz5H605Pah1+tM50egQs9MbZpA32s7EonkGvUMiFSDCKOAadBz9vvXKTVD2
 ubCzX7Qib3Wgw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 23:07:24 +0530
Message-Id: <DJEWROG7MD9R.MXZLB9VZ1KGA@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Peng Fan"
 <peng.fan@nxp.com>, <u-boot@lists.denx.de>
Cc: "Minkyu Kang" <mk7.kang@samsung.com>, "Tom Rini" <trini@konsulko.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Anand Moon"
 <linux.amoon@gmail.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Lukas Timmermann" <uboot@timmermann.space>, "Henrik Grimler"
 <henrik@grimler.se>
Subject: Re: [PATCH v3 0/4] HS400 and HS400ES support for Exynos DW-MMC drivers
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
In-Reply-To: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

On 2026-06-13 13:13 +05:30, Kaustabh Chakraborty wrote:
> Since upstream dts version v7.0+, Exynos 7870 devices have an explicit
> `bus-width =3D <8>` property. This results in the U-Boot driver trying to
> initialize the HS400 mode, which appears to fail. The HS400 support
> added in the DW-MMC Exynos driver appears to have an incomplete init
> sequence.
>
> This patch series adds the missing pieces to enable HS400 support, and
> additionally adds support for HS400ES too.
>
> The last patch in the series also enables HS400ES support in the
> exynos-mobile defconfig.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Just a bump; failure to pull this series would render upstream stable
U-Boot v2026.07 on the Samsung Galaxy J7 Prime (samsung-on7xelte) unable
to load any operating system due to lack of a storage device.

As of yet I do not see the series in master, next, nor in the MMC Custodian=
 tree.
