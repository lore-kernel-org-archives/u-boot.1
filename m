Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5423CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 16:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BBD86689;
	Thu, 12 Oct 2023 18:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aBr96cUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3774865A5; Thu, 12 Oct 2023 18:40:46 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E05F86B7A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 18:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7b3d33663so15844767b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697128809; x=1697733609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XqzCwrEse8HbM/o+P6/7in/PxZoohmvLXO8yPin1WRg=;
 b=aBr96cUxWSliACz3Vgkz/XteFCY3ieOWsWcq5qQ4ATVrAAAwOXO6LVPtJNZX4m84eR
 xKb/anQAdUmkK8QfQjnR9Fpsrbv1exsMNVUcb/hYdoBBbAwifgUpTrx+c3cUzYeB+XgW
 gckdWX8clyrN7j1ZrurnFpSlTn6iEwBxM2eL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697128809; x=1697733609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqzCwrEse8HbM/o+P6/7in/PxZoohmvLXO8yPin1WRg=;
 b=QLxD0yeUO1PnkBix+Pl1RzGAcmT0Qyr2ugPHrJc5WAZoiaIwLW1WgtrP5jxMNaSjZk
 Ud09+90nLLnt8kSRDb7Z5bzBozn461OzzuH+ydaEcb721SELWPldKj2HdgznfHUS3rk1
 cEjPpj3lmic3If0HzjI+CD/yaY9I4yH6ntIA8ZqucWVJ1grHzEC75FB/D5AR8Qp/Xc/q
 LyWVKmlgLrkAe+/JPRRIcTOzP7HCQcE8Laa17A80pStQf6QbQi9vs7gCdpkdcpDFKP4I
 zeNv32b4mhbfoK8L0jrpqNJgjcI1FSPg2enYALNm6BXrH9jFvBHrRmdum+NHGOp0/Ivb
 15uA==
X-Gm-Message-State: AOJu0YxFbnnOtovGxRwBwyKfQEqq/yF4wb9IPxxhe6P+0C8e80fSuMnf
 6c41jVJWiwS1bu8AugYi/6vtrA==
X-Google-Smtp-Source: AGHT+IG8d+lburT5fcOVnNCFbZLTl2ekoxBDuZ34z840E63iFNamKLXVBfumlC2maoAiqxyf/JYCQg==
X-Received: by 2002:a05:690c:f92:b0:5a7:e6fb:39b with SMTP id
 df18-20020a05690c0f9200b005a7e6fb039bmr5907968ywb.1.1697128809643; 
 Thu, 12 Oct 2023 09:40:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 w83-20020a0dd456000000b005a1cc37aff1sm72742ywd.20.2023.10.12.09.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 09:40:09 -0700 (PDT)
Date: Thu, 12 Oct 2023 12:40:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH 07/26] arm: imx: Check header before calling
 spl_load_imx_container
Message-ID: <20231012164007.GP3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-8-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yK1t2CK3l7/szin1"
Content-Disposition: inline
In-Reply-To: <20231012015626.3487451-8-seanga2@gmail.com>
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


--yK1t2CK3l7/szin1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 09:56:07PM -0400, Sean Anderson wrote:
> Make sure we have an IMX header before calling spl_load_imx_container,
> since if we don't it will fail with -ENOENT. This allows us to fall back =
to
> legacy/raw images if they are also enabled.
>=20
> To avoid too much bloat, Legacy/Raw images are disabled for the four
> configs which only boot from raw MMC.
>=20
> Future work could include merging imx_container.h with imx8image.h, since
> they appear to define mostly the same structures.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

So, since you mention bloat, this sounds like it's making functional
changes here, but that's not intentional, yes?  Or to ask another way,
is deneb disabling features here, to save space now that it can, or
because they're growing "a bunch" and this reduces the growth?

--=20
Tom

--yK1t2CK3l7/szin1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoIWMACgkQFHw5/5Y0
tywd2gwAthj6mja9JzTSPCBQTJrfK2jq0ZRA57KroxE3Ulhpp0uHAxkAw0Vtq3BD
iZzWR6h77bsNZ6dXoiTAkpK/pXopRHgDlf8xrXIsKFpLDh4EVhgIi2kFnEtSMv/o
80nZZ2Gad3JWKkxoye3I8wBrh974/vM/CAmhQjgKQpAhQPZJc2QSfOSHgJm5m8kf
eVcz6SZxGsoZIQkGavPWnuDMSzT/XcZ9b2G3gZkbSPobsqCqF8Bxdns78KXPCRry
8Yn0ls+dUWOOigE6Oo32b0c67z2ZlHY8e+9p9UMweZ8bQNgxRmkWguHgZmQG4YNI
QOwtQFVAlUAFTjQ/PLYZMKUL95qD+qAKn/JkIra0mUfYXHgsGq3J6ocA0RATncQ2
J8aWG2lq3/wE155rVCbkbjf6ZE8QEss+79mVh1IFwKM+zz0i1YCuDO++bh73bkCj
OrVvCjy1Jh7jk6X7035ZU9rMpri54adIgoL9u7rqn6xM+iJNxybATyvUE3mxGxge
FPOt8g0j
=VlEU
-----END PGP SIGNATURE-----

--yK1t2CK3l7/szin1--
