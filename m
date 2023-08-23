Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08634C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673B586478;
	Wed, 23 Aug 2023 19:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IbItCUr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C159C86473; Wed, 23 Aug 2023 19:37:20 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 911DE86478
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5921a962adfso37036377b3.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692812232; x=1693417032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hv0oCgRR5ZoOEBEeItzcq9GUAWVZTPLCFzjlxCAUQds=;
 b=IbItCUr+SgmRKI34CkwNgXM2kcDoUI5ls5OAnkYmov6j0+ivT83gG094Z+nG0iLb6X
 q6liJCA1RZQdb9QeFL5f/aTfRVskMECaeXaWBTZe3SdCxbTCTLPfT0MZ0G4AfV+9lwna
 5Qe68/QSZEBsXToe2U3DeGK+yKkVzOlDLwEJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692812232; x=1693417032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hv0oCgRR5ZoOEBEeItzcq9GUAWVZTPLCFzjlxCAUQds=;
 b=jFohjP8pT8MOqzcrnVPdM2SaXR+1111vKH70VbwfsVo7YtaK/kIvHJEkBbf6g6MF9l
 Am8eAK8hUBrYnz4OFIzijl3lIlCp5uPrYflU08BK9vjHj8irr2NZHG3C9pOSwS42AL5O
 j56qtgqc8ydXHcZDOfEnvEB4gQW8azo6+bDM6LD/OeNx3BBMh/hwvbEbmHBBgwSRsHEF
 2z5UxELKWrGaBy1MYA5LuTFef5y3vaaspC4CoGwvDY9MmiVvQOIQKHzWKTPhUNcmvT9z
 324gHN0p2hG7HffPgGdDTZG5Ww/C+mH1xV4bNPM0IlFx6IcaDwyx7Hv98uDP+fIrme4h
 e1tg==
X-Gm-Message-State: AOJu0YyWrPziFQuX9rBTZ6vNt7WTlLbrGTDayKigkP1WZwJno9GM/N8t
 shYnlj5kkpJZfCgYcublABAZ0IGX16luFvRgVkSAQg==
X-Google-Smtp-Source: AGHT+IHcdzSx1gluXBxjknyAI2E6rtecXcaL+JbVgW00eld28NiB5BTdIbUlt7l728Lvlq3oVW3GNg==
X-Received: by 2002:a0d:cf44:0:b0:56f:ff55:2b7d with SMTP id
 r65-20020a0dcf44000000b0056fff552b7dmr13045475ywd.17.1692812232484; 
 Wed, 23 Aug 2023 10:37:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a0dd90b000000b005927a79333esm13280ywe.28.2023.08.23.10.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:37:12 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:37:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 4/5] thermal: imx_tmu: Fix th temperature unit
Message-ID: <20230823173710.GS3953269@bill-the-cat>
References: <20230823172637.303101-1-festevam@gmail.com>
 <20230823172637.303101-4-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vN89tLZCQ3CqOBX9"
Content-Disposition: inline
In-Reply-To: <20230823172637.303101-4-festevam@gmail.com>
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


--vN89tLZCQ3CqOBX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:26:36PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> The temperature unit is millidegree Celsius, so divide by 1000 to correct=
ly
> print the temperature values in Celsius.
>=20
> While at it, also change a typo: "has beyond" to "is beyond".
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/thermal/imx_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
> index d9a04eaf79..f79b583811 100644
> --- a/drivers/thermal/imx_tmu.c
> +++ b/drivers/thermal/imx_tmu.c
> @@ -238,8 +238,8 @@ int imx_tmu_get_temp(struct udevice *dev, int *temp)
>  		return ret;
> =20
>  	while (cpu_tmp >=3D pdata->alert) {
> -		dev_info(dev, "CPU Temperature (%dC) has beyond alert (%dC), close to =
critical (%dC) waiting...\n",
> -			 cpu_tmp, pdata->alert, pdata->critical);
> +		dev_info(dev, "CPU Temperature (%dC) is beyond alert (%dC), close to c=
ritical (%dC) waiting...\n",
> +			 cpu_tmp / 1000, pdata->alert / 1000, pdata->critical / 1000);
>  		mdelay(pdata->polling_delay);
>  		ret =3D read_temperature(dev, &cpu_tmp);
>  		if (ret)

To follow-up on the patch about select'ing LOG, this shouldn't be
dev_info, it should be higher, at least warning if not critical.  And
given the default LOGLEVEL of 4, it will be included and printed.

--=20
Tom

--vN89tLZCQ3CqOBX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmQ8YACgkQFHw5/5Y0
tyyvtwv/eQMhjsKIsA+vIQmZNn+z5chZ7sSJ0L+FYHioG47e/Qe7vp4asCaqgB+H
gEYs3798uceDJpp2W6barfYPaTelT/5UB0rwDScauexmFCXysc7QSBFxIIEzS6Pj
vc840rYDxyV33OPkULpbt0415uS8EN8Pet5LfKwjLq0knDrr8KcByT+JWTIShk+a
AGaYJUmPlIChTFv0PG6o2901uOxpNZC7LIF9Q9bTuHcK5No3DCqzMRwUCvuIKBeq
02bYXL3daPzJ539Zw3E34nDq+UCM31fPCkQKzkV+a7UYWgtYJF3IvWevOPw2NCDg
eqXct9lhmhc4YO7/yrSA0l5wPj4pXCyo4Hf+wP2L68xvPbhYqubDzgS9yS9ZESH0
5AuMs0mpjWn4iHT9+YF6jIad8NU9UXHxo0Xy37CfDNUO3lqAMBBfsz2d97OL8A+X
aguKz8lG/h+StT+Ozg9nxMwbI2H2qVvoDgGlrwosDisRtQl5DmCec+U8to6aKHOW
zD565PlD
=CguK
-----END PGP SIGNATURE-----

--vN89tLZCQ3CqOBX9--
