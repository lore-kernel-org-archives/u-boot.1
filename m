Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11383EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E3486DBD;
	Fri, 18 Aug 2023 19:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nrTzp5DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41E58082A; Fri, 18 Aug 2023 19:53:45 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339DA86EFF
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d73c595b558so1133615276.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692381221; x=1692986021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=njN3Youmm2sczYd+1DgBVXx39BNLWhT90wYZjnTtoy4=;
 b=nrTzp5DRMdz0OAp2eZxKDWBr5FvDV3qP3A8O1y3B9Vfst3KCAU8tmFu3P3O5mufAvI
 YEy0qbU4NCdeAETvlKSDtW80sq38JzS3KxNxwkp7ObACvK41NSkLfFB2WTgOTCpuK7QO
 V9iIaD3mq2nAFzcCCvuW81a4yFww3q2v1giGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381221; x=1692986021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njN3Youmm2sczYd+1DgBVXx39BNLWhT90wYZjnTtoy4=;
 b=OvEBaB/mLx4dGR4nAqAeKC3mqGYyaxoaHsb9XHw8sWqCe2/kycQlY05wWe63iXiq7E
 cu9oBb0QXNzqQdFRPbByPfktbedXuLcvkEb8bjGjBdFeG3lUrsVfwP5aPGVIUFmR5Ac6
 1q3FI4L8KEBKEm3bg07T34HCVOqc95RuPiKxNS4xebYqXDzWzEErQtM8ANk2f2D2TG/l
 gtH9S3hMl0t4j3onQTKToqxvao1qzHCE+CQ/mgACUVa7i/iS9ErRC6/8uX7HkocbpBUo
 oxe/va+Hp1qaH7IqhZr6/eHIJFuamSImZ6pvZ5DZL8YVXfR4NStjUZ4sTsR5xcOSTLyD
 Yt+w==
X-Gm-Message-State: AOJu0YzVmNTWIaUQfwN8Hwd1d6NMewk1cCwyDAmRVpsq6gdhZETFA6+o
 plw5B6XNv0JIAlRc5m1PdK2gug==
X-Google-Smtp-Source: AGHT+IGfovjR18+SYadS/BPFjcZfLPwF2o5iOJSHp4H2QNXUCYoVn/H2dJyFQq65y1X4bSu49+KZpg==
X-Received: by 2002:a81:4893:0:b0:577:2fda:f181 with SMTP id
 v141-20020a814893000000b005772fdaf181mr2955994ywa.44.1692381220925; 
 Fri, 18 Aug 2023 10:53:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a0de642000000b00586b5b6347csm628806ywe.109.2023.08.18.10.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:53:40 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:53:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Elena Popa <elena.popa@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ji Luo <ji.luo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: Re: [EXT] Re: [RFC] spl_fit.c: SPL Falcon Mode return to U-Boot
Message-ID: <20230818175338.GM1515023@bill-the-cat>
References: <VI1PR0402MB3630FE83008686093D25C582900DA@VI1PR0402MB3630.eurprd04.prod.outlook.com>
 <20230810221150.GA3630934@bill-the-cat>
 <VI1PR0402MB363013B1B87BB43633C38501901BA@VI1PR0402MB3630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OWxi3Q0B4MukCVnO"
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB363013B1B87BB43633C38501901BA@VI1PR0402MB3630.eurprd04.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--OWxi3Q0B4MukCVnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 05:00:05PM +0000, Elena Popa wrote:
>=20
>=20
> > > When Falcon Mode is enabled, spl_start_uboot() function must be defin=
ed.
> > If this function returns 0 then SPL should start the kernel, if it retu=
rns 1 then
> > U-Boot must be started.
> > >
> > > When spl_start_uboot() returns 1, then U-Boot must be loaded, and as =
far
> > as I can tell spl_image->os should be set to IH_OS_U_BOOT before:
> > >
> > > 	if (os_takes_devicetree(spl_image->os)) {
> > > 		ret =3D spl_fit_append_fdt(spl_image, info, sector, &ctx);
> > >
> > > in common/spl/spl_fit.c/ int spl_load_simple_fit(...)
> > >
> > > this is not the case currently, and the loading fails. If set manually
> > spl_image->os =3D IH_OS_U_BOOT, it works fine.
> > >
> > > The only place I could see where it could be set is a few lines above=
 in:
> > >
> > > if (!spl_fit_image_get_os(ctx.fit, node, &spl_image->os))
> > > 	debug("Image OS is %s\n", genimg_get_os_name(spl_image->os));
> > > else if (!IS_ENABLED(CONFIG_SPL_OS_BOOT))
> > > 	spl_image->os =3D IH_OS_U_BOOT;
> > >
> > > but the second "if" does not execute, obviously (since we are in falc=
on,
> > CONFIG_SPL_OS_BOOT is enabled). I see a few options, but I am not sure =
how
> > best to fix this:
> > >
> > > 1) add something like:
> > > else if (!IS_ENABLED(CONFIG_SPL_OS_BOOT) || spl_start_uboot())
> > > 	spl_image->os =3D IH_OS_U_BOOT;
> > > but this would mean calling spl_start_uboot() twice, requiring it to =
return
> > the same value. It works in my case.
> > >
> > > 2) set spl_image->os to IH_OS_U_BOOT when the spl_start_uboot() is ca=
lled
> > the first time, in:
> > > common/spl/spl_mmc.c/spl_mmc_do_fs_boot(..)    - in several places:
> > > #ifdef CONFIG_SPL_FS_FAT
> > > 	if (!spl_start_uboot()) {
> > > 		err =3D spl_load_image_fat_os(spl_image, bootdev,
> > > mmc_get_blk_desc(mmc), ...
> > >
> > > #ifdef CONFIG_SPL_FS_EXT4
> > > 	if (!spl_start_uboot()) {
> > > 		err =3D spl_load_image_ext_os(spl_image, bootdev,
> > > mmc_get_blk_desc(mmc),
> > >
> > > ...
> > >
> > > Any insight on how to proceed? I've implemented spl_start_uboot() to
> > decide on whether to boot the kernel or the U-Boot based on key presses=
 on
> > the console.
> >=20
> > Are you talking about the case where we tried to load (or verify) the k=
ernel
> > image and that failed, and so should fall back to U-Boot? Or the case w=
here
> > we're going to U-Boot instead of trying the kernel. For the second case=
 there,
> > we should be doing the same thing we do in the case of not-falcon mode.=
 In
> > the first case however, we might well have a bug or two there and aren't
> > falling back to reporting the error and then loading U-Boot just like w=
e hadn't
> > tried to load the kernel before.
>=20
> I was referring to the second case: we are in Falcon Mode, but
> spl_start_uboot() returns 1, so we should load U-Boot instead of the
> Kernel. However, I found a solution that works with the current
> implementation: adding the "os" property into the u-boot node from
> U-Boot FIT image. Then, spl_fit_image_get_os(...) sets spl_image->os
> correctly.

Ah, OK.  I think this may be partly that the fall-back case wasn't
tested as much with FIT images as it was with legacy ones at the time,
so it might well be that the code needs a bit of fixing.

--=20
Tom

--OWxi3Q0B4MukCVnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfsCIACgkQFHw5/5Y0
tyxztwv/RYIMyl4YtbUEbP/O8Yjuz33zoCD9D1MqFoWjg3xfnyzYX7q49JRIMo+d
GlRxE1CsSfcgb46syp5AIZc83YnejUtGAlEQUm4ioBwd7+h0erT/IkDrRnc6Zn9y
y5jowuxCTzO0qzmcLljhm9p8rnDt/dTM0mWZP/3ymGjoSQZ1ONYPhD9r4G1iUZo4
BM0XBnxymolTXCe8jmqSG58VeKjDpLVUb67RO5F9uUJP5bE5H4LxOL8n1ZMetqgC
1HFu3hh+vfPheTtp5qDh/WEsgmmoildx/VGBoE2uY2pYoDJJJNUuAfJ7LnHH26Cq
ttk5kbg3Gs9gbMRfe0+VMftFd1r1tfQJPdXpLQQfmmCs/6qegeeL3yYExyhCalIk
9xJ/UzXOqufHnw4gwUugHgK6EnSm2EoUcmHm/iGjWdHiXReRfwKMZEsBrlaR5uww
IdQk12UQebsOOE5ys3+blpmwcl8dg53JWKv4YwawD7vafJQvRHyCizgXHoY5ZHcQ
JGv0hJOc
=YUKB
-----END PGP SIGNATURE-----

--OWxi3Q0B4MukCVnO--
