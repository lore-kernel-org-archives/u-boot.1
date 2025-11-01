Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED5CCCFA02
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 21:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2534983642;
	Sat,  1 Nov 2025 22:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="pJ64mVDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3AA83677; Sat,  1 Nov 2025 22:15:31 +0100 (CET)
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BEBE8331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 22:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 0689440D56; Sat,  1 Nov 2025 22:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
 t=1762031728; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eDt9g7xa59rLg+ZaBANtUv7APn/b/aR3+oMYUaxlPbY=;
 b=pJ64mVDwGR/DAfUKJTdFtEqeAk+vlEy8iltMigDbQZKENx4juTgfci3hucZ4Scnxv6ImRF
 FI9FwlvMRWwizEBlhgIIVYbst5IOUH9E/b4bLWHAWheYqlidkTdmDEbeQjt6p8fdIbFSUL
 NsGL75pg7DWyZV4V1VtjLU3QyUhttilclDsI4oQu/nK/AV/62AzmigxECrgrio3VA5CbTG
 XODp+WlKYbfGgW1NjjJZudl4udRM1Os6toidybOdYyc54vX1HyP9q2XqM4P1GGitXMcBIv
 +iBQoXrmiWgDbdI8h5LgD52PrHncPJgOZNapRxSWJyIT/mkxhhDfD+Jk/axHXQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251101203429.1603832-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="utf-8"
References: <20251101203429.1603832-1-jonas@kwiboo.se>
Date: Sat, 01 Nov 2025 22:15:25 +0100
Cc: "Tom Rini" <trini@konsulko.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Ye Li" <ye.li@nxp.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Dang Huynh" <danct12@riseup.net>,
 u-boot@lists.denx.de
To: "Jonas Karlman" <jonas@kwiboo.se>
MIME-Version: 1.0
Message-ID: <54983c5b-4625-2000-5dc5-e47fbcac5517@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] Revert =?utf-8?q?=22power=3A?=
 =?utf-8?q?_regulator=3A?= Add vin-supply for GPIO and Fixed 
 =?utf-8?q?regulators=22?=
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
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

Hello Jonas and Dang,

On Saturday, November 01, 2025 21:34 CET, Jonas Karlman <jonas@kwiboo.s=
e> wrote:
> Rockchip boards may depend on a working MMC regulator in SPL to
> successfully load FIT payload from MMC. Typically, these boards only
> include the vmmc-supply regulator and not its vin-supply in SPL contr=
ol
> FDT.
>=20
> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO a=
nd
> Fixed regulators") breaks loading FIT from MMC in SPL on some of thes=
e
> boards due to now requiring the vin-supply to be included in the SPL
> control FDT.
>=20
> The commit also strangely enables any found vin-supply in
> regulator=5Fcommon=5Fof=5Fto=5Fplat() and not when a regulator is ena=
bled or as
> part of regulator=5Fautoset().
>=20
> Revert the commit to fix FIT loading in SPL on broken boards.
>=20
> If a board needs to have its vin-supply enabled, two options come to
> mind:
>=20
> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi f=
or
>   any board.
>=20
> - Implement full support for reference counting of regulators and the=
n
>   update the regulator-uclass to enable any found vin-supply when a
>   regulator is enabled.
>=20
> This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.

Thank you, Jonas, for preparing this patch so quickly!  Of course,
huge thanks to Dang for spotting the issue and bisecting it.

I totally agree with the description of how the reverted commit
f98d812e5353 ("power: regulator: Add vin-supply for GPIO and Fixed
regulators", 2025-09-11) strangely performed the enabling of "vin-
supply" regulators in a suboptimal way.  As already described by
Jonas, a proper implementation of such regulator enabling would
require a much more complex approach.

Thus, please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Reported-by: Dang Huynh <danct12@riseup.net>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/power/regulator/regulator=5Fcommon.c | 10 ----------
>  drivers/power/regulator/regulator=5Fcommon.h |  1 -
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/drivers/power/regulator/regulator=5Fcommon.c b/drivers/p=
ower/regulator/regulator=5Fcommon.c
> index 3ed713ce5019..685d8735fa5c 100644
> --- a/drivers/power/regulator/regulator=5Fcommon.c
> +++ b/drivers/power/regulator/regulator=5Fcommon.c
> @@ -44,16 +44,6 @@ int regulator=5Fcommon=5Fof=5Fto=5Fplat(struct ude=
vice *dev,
>  			dev=5Fread=5Fu32=5Fdefault(dev, "u-boot,off-on-delay-us", 0);
>  	}
> =20
> -	ret =3D device=5Fget=5Fsupply=5Fregulator(dev, "vin-supply", &plat-=
>vin=5Fsupply);
> -	if (ret) {
> -		debug("Regulator vin regulator not defined: %d\n", ret);
> -		if (ret !=3D -ENOENT)
> -			return ret;
> -	}
> -
> -	if (plat->vin=5Fsupply)
> -		regulator=5Fset=5Fenable=5Fif=5Fallowed(plat->vin=5Fsupply, true);
> -
>  	return 0;
>  }
> =20
> diff --git a/drivers/power/regulator/regulator=5Fcommon.h b/drivers/p=
ower/regulator/regulator=5Fcommon.h
> index 799c968d0b66..d4962899d830 100644
> --- a/drivers/power/regulator/regulator=5Fcommon.h
> +++ b/drivers/power/regulator/regulator=5Fcommon.h
> @@ -14,7 +14,6 @@ struct regulator=5Fcommon=5Fplat {
>  	unsigned int startup=5Fdelay=5Fus;
>  	unsigned int off=5Fon=5Fdelay=5Fus;
>  	unsigned int enable=5Fcount;
> -	struct udevice *vin=5Fsupply;
>  };
> =20
>  int regulator=5Fcommon=5Fof=5Fto=5Fplat(struct udevice *dev,
> --=20
> 2.51.0
>

