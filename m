Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE980CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 21:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE9E83677;
	Sat,  1 Nov 2025 22:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="IS1srxT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60072836D1; Sat,  1 Nov 2025 22:23:45 +0100 (CET)
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3BA83642
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 22:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 75F0240C2A; Sat,  1 Nov 2025 22:23:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
 t=1762032222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=F8v4n4JDp0dBBfLVM8zymVBw5+NmqZ5h9HnKiY/c20Y=;
 b=IS1srxT9oiKyo79lYgX8eiaKBhkHSaPY+/HJeGeZ603hgvVM2EWM8PxZG4f+06zFBF62th
 ktE+L/MfCtcVxTftnSJfV2tj81I/1c9qhwKFWcDIZIS+YF4XVTwTACoRpYVceA/Msqj49W
 xxG0OzQXJ9eeVufkdSLO0Hho7IKX2dgwfI7DhSvZzbnGWGUiKWK+vtiwbHdu17Y1T7Ju98
 B4yp+Xo22jQuwnBrIaCZtmuZo6URD7zADkkWNqpHuzYokgvOvx0cwiWzjOsAWaRsqTVUQz
 mUkbpuQ9uQc+gvq6zVmXIiIRYYo+cxvYt5TJy7IGfp5dtVhn7kF9VmFnkFOhUA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <878qgpqwpi.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset="utf-8"
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <878qgpqwpi.fsf@bloch.sibelius.xs4all.nl>
Date: Sat, 01 Nov 2025 22:23:41 +0100
Cc: "Jonas Karlman" <jonas@kwiboo.se>, trini@konsulko.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, ye.li@nxp.com, festevam@gmail.com,
 danct12@riseup.net, u-boot@lists.denx.de
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Message-ID: <cec3cc0b-0326-4b0b-6832-f5db556c4cf2@manjaro.org>
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

Hello Mark,

On Saturday, November 01, 2025 22:17 CET, Mark Kettenis <mark.kettenis@=
xs4all.nl> wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > Rockchip boards may depend on a working MMC regulator in SPL to
> > successfully load FIT payload from MMC. Typically, these boards onl=
y
> > include the vmmc-supply regulator and not its vin-supply in SPL con=
trol
> > FDT.
> >=20
> > The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO=
 and
> > Fixed regulators") breaks loading FIT from MMC in SPL on some of th=
ese
> > boards due to now requiring the vin-supply to be included in the SP=
L
> > control FDT.
>=20
> I ran into this issue a few days ago.  Unfortunately that means U-Boo=
t
> 2025.10 is broken on several Rockchip boards :(.

Sadly, that's true. :(

> > The commit also strangely enables any found vin-supply in
> > regulator=5Fcommon=5Fof=5Fto=5Fplat() and not when a regulator is e=
nabled or as
> > part of regulator=5Fautoset().
> >=20
> > Revert the commit to fix FIT loading in SPL on broken boards.
> >=20
> > If a board needs to have its vin-supply enabled, two options come t=
o
> > mind:
> >=20
> > - Add regulator-always-on prop to the regulator in the -u-boot.dtsi=
 for
> >   any board.
> >=20
> > - Implement full support for reference counting of regulators and t=
hen
> >   update the regulator-uclass to enable any found vin-supply when a
> >   regulator is enabled.
>=20
> I fixed the issue with the diff below instead.  But I don't claim to
> fully understand how this all is supposed to work...

Unfortunately, that's just a quick workaround, not a proper fix.
Basically, the regulator=5Fcommon=5Fof=5Fto=5Fplat() function is a wron=
g
place for such enabling of additional regulators.

> diff --git a/drivers/power/regulator/regulator=5Fcommon.c b/drivers/p=
ower/regulator/regulator=5Fcommon.c
> index c80f10c3aa3..f43879a4353 100644
> --- a/drivers/power/regulator/regulator=5Fcommon.c
> +++ b/drivers/power/regulator/regulator=5Fcommon.c
> @@ -48,7 +48,7 @@ int regulator=5Fcommon=5Fof=5Fto=5Fplat(struct udev=
ice *dev,
>  	ret =3D device=5Fget=5Fsupply=5Fregulator(dev, "vin-supply", &plat-=
>vin=5Fsupply);
>  	if (ret) {
>  		debug("Regulator vin regulator not defined: %d\n", ret);
> -		if (ret !=3D -ENOENT)
> +		if (ret !=3D -ENOENT && ret !=3D -ENODEV)
>  			return ret;
>  	}

