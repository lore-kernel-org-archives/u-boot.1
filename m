Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0713C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E683386478;
	Wed, 23 Aug 2023 19:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nDq4jAbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D9A86473; Wed, 23 Aug 2023 19:34:09 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B32864B4
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58fba83feb0so46501327b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692812046; x=1693416846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C5NKCuU8eQfDLnZvgEeyOdEYOWRITwlE99NQbY1NCbU=;
 b=nDq4jAbnvxnw+J0PzoVTAIZCguHxO01vc18/0eNHhImHA59OTYnlpZ/3+HWye5BQFD
 jeAnzFzeBWyuClnsTNiY9xG99mgjKdhBtbeIJjXcP0OWEp66UrF2sRxgOLN616bkvrAm
 kU9opu76bo2RFu5m7EgCRDinofWbaIskKwOpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692812046; x=1693416846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5NKCuU8eQfDLnZvgEeyOdEYOWRITwlE99NQbY1NCbU=;
 b=PxZXezLIgH2D+xrxMyd6E6VFukWMAWMTnOChVduZgWok0rLD6TCwqRTc0ZaGNDTnZH
 DgK2Xe5UenoGYHIyOPWW6MIxSrBgaFXnOLCefdA+QE+UroCdvglNce+h7IAlVWhfF9P+
 ojo/t9PwdOJNz9E2uBg19LZWuIymc6PC/7lTPFl5hQ6kFIHkjdgKb7Bz2KTGmlIo61uu
 jaKWyTR9UHPtIFNnl3ARA6M327KKGeT75lWYQuVwzjcfiY39UTo6NpFoiXjOVF3n/kOH
 GhFatdkybUpR1TFGQO1vi4es6WSeieeJ2Rou7cRgxfnqX4z6PsRDz9E+AwlR4Ustzofn
 slHg==
X-Gm-Message-State: AOJu0YxtEPHuEjaYabLz4eyxzPCsI4MB4R6qFf72KNOVjbtCA7MkUDmO
 xq/89dJtsdBOKzXH6DvSF1BkPA==
X-Google-Smtp-Source: AGHT+IErtbcwoKl/7Nmeaq9Rmut/SI2ikUBy4JyxJ0/cjFROSgBDk/0n8pBUj4ZN6i2KPc70Q4ijjw==
X-Received: by 2002:a81:778a:0:b0:592:8cd:6e10 with SMTP id
 s132-20020a81778a000000b0059208cd6e10mr9490818ywc.49.1692812045937; 
 Wed, 23 Aug 2023 10:34:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a81830d000000b005869e1d8c41sm3440583ywf.29.2023.08.23.10.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:34:05 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:34:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 3/5] thermal: imx_tmu: Select LOG
Message-ID: <20230823173403.GR3953269@bill-the-cat>
References: <20230823172637.303101-1-festevam@gmail.com>
 <20230823172637.303101-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lq1AOGkssPdEu/ML"
Content-Disposition: inline
In-Reply-To: <20230823172637.303101-3-festevam@gmail.com>
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


--lq1AOGkssPdEu/ML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:26:35PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> Without LOG being selected, the dev_info() information
> from the imx_tmu driver cannot be printed.
>=20
> Select the LOG option, so that no dev_info() messages are lost.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 681b621760..0a1d11e216 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -29,6 +29,7 @@ config IMX_SCU_THERMAL
>  config IMX_TMU
>          bool "Thermal Management Unit driver for NXP i.MX8M and iMX93"
>          depends on ARCH_IMX8M || IMX93
> +        select LOG
>          help
>            Support for Temperature sensors on NXP i.MX8M and iMX93.
>            It supports one critical trip point and one passive trip point.

This is now going to bring in a ton of other messages.  Perhaps the
problem is that there are critical messages in this driver which should
not be dev_info ?

--=20
Tom

--lq1AOGkssPdEu/ML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmQwgACgkQFHw5/5Y0
tywBuwwAkHHwFqM1i060YHVZg4RzHuQfXxzcUTBNBP4YMlyd6ZFHt3XjzLF2G8YZ
tlBu4F3JIYxDlOuJjywLAyubDAI7dkKGWSWu2ErrKRX2j6drCRafjy9xJdpxc28a
G26gHlHAHJh+hbOd23fs/5ZCWfpNkoTmVmOCFEzZO8fX1QHJr2+nZttmFl9P9lxM
JA3Rqsa5RYQHr9KPWJtnMx3cR5Dew99K4uUyihQAS7VqDihh8Mmsxd4ehbXN7gL+
NU4UrlUYJB2slyAOkcS8BI6DnPZmmF0Oa+85bzf6e0uQQVyBy+FhEYO/TLoy87Pd
/Y08Q7OwhVTNvUUOxEwZp0pfys1AGM5NaCNR8TsDEMDBxSFBTOhl7pmqhoy4Ntpx
XyCMSgr3nGpkK37Clqpr6b5Gf/81Okj3zGo/0X4BijACzB6ecNtcPlixVSFLQrNO
fbPDoFrxRcHiWQkzrdNUMiBeMM6r2Pqiid9mvWvJCKOt2Kf40BWuPSivCBuUmLyj
baiWqaEw
=2oZy
-----END PGP SIGNATURE-----

--lq1AOGkssPdEu/ML--
