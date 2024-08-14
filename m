Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03984C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BDC8899D;
	Wed, 14 Aug 2024 16:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tH3wWf24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC4D8899D; Wed, 14 Aug 2024 16:17:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A03F987C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-709340bd54dso446868a34.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723645058; x=1724249858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CTNYcLxhjHyxSo9Yuq10fy8JiZ3hdHp5aLtP+p2iduE=;
 b=tH3wWf24HTRdCaOQthgIfpyAlCFAfPMhg+HYO2Ry/DXFc00dcZ3PtWyY+tekGDXoKd
 7iuub4YWebtFRLuF6LPAEOvwUy0V9h9COrkOeOJdayawwoCoHRsnZLA1VeZXCgVOMYOC
 c4Cchs2Oj56EcWqcBdbxOJonwr3TuqYh8APXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723645058; x=1724249858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTNYcLxhjHyxSo9Yuq10fy8JiZ3hdHp5aLtP+p2iduE=;
 b=Dp1875juX1VRXlFXsFfCllcyn6VjtsGQr56x+Im3jqy1QQKxokVT6ng5GdgESTyKfU
 KFt2k+owzbxmBDolomc4dAF4Tr1fQjSnxPrF5pur0Imph4QcLv/oj9qIUKYwgD47n08k
 1pv7ZjjmqBdSGg9cY+ikxQT/E7SGBFIMrA93KYZySbE4snOZm2kTqk/MgDx8LDLE7rFD
 oC9jMOz/dL0/4ciatSc6yY+iF6jP7TEGRCMU3GlXMu1bAzSkZufV4RmTl6Ui5Nvb6ErO
 ATS0dU4pfRLLPkV93jjhn522E2AHymhGtaRyMzN/5MUdWlmtdM3qosxHHObvMKjglfHx
 1PNg==
X-Gm-Message-State: AOJu0YxgYAUT9EXC1tPEMsS7DceIJKtnZV8Ic8TNb6CuvJSjAs1C8Fdf
 2bIpLPxr8v7Z4jJTqc2yHZpDorLcwdDRk4UUBnF+4pr4/wwrbKxh6DtNRokh0qw=
X-Google-Smtp-Source: AGHT+IEpQGHyZDRhz5SyqsOIzjT0KklkkkdaFq62DyDodYMz1/GnXo3i3YVDHIRK2ZoXS3lqTZxI1A==
X-Received: by 2002:a05:6830:4991:b0:703:66eb:ef8 with SMTP id
 46e09a7af769-70c956775bfmr3326683a34.5.1723645058365; 
 Wed, 14 Aug 2024 07:17:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e73a7basm2075305eaf.41.2024.08.14.07.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 07:17:37 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:17:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v3] driver: pwm: pwm-imx: fix probing on imx6
Message-ID: <20240814141736.GN1626301@bill-the-cat>
References: <20240814121027.3477977-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cDG5qJU2tkif8Rzc"
Content-Disposition: inline
In-Reply-To: <20240814121027.3477977-1-hs@denx.de>
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


--cDG5qJU2tkif8Rzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 02:10:27PM +0200, Heiko Schocher wrote:

> U-Boot 2024.07 drops on aristainetos2 board the following
> warning:
>=20
> 	Failed to enable per_clk
>=20
> and bootlogo is not seen on LVDS display.
>=20
> This patch uses old behaviour for systems without clock framework
> if CONFIG_CLK is not enabled.
>=20
> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock =
using dm")
> Fixes: 4eea76574062 ("pwm: imx: Remove unused references to CONFIG_IMX6_P=
WM_PER_CLK")
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

I really do not like this and would like to see the clock migration also
enabled / completed on these platforms. Then we can also go and rip out
the non-DM_PWM code here.

--=20
Tom

--cDG5qJU2tkif8Rzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma8vIAACgkQFHw5/5Y0
tyz+JAv/XX+sEts69VY/miihQjfQfmPhFyOnAwntjr5jLFAZMCx7pYJNPR7d0Jm+
Z9FCQlT1rMmSWupzWzcPlA9fWPe1U9qp2VUj+fN/AVDAGjpMX5zFGwcUtM9048l+
3bZYX1vrqCvRVzs/Ha9pdrtFeJapLK1Rm1Sqrjrt9ovziFuBNbiReUqDPpwaja2j
CaUK3OtfuZTn1/ZbPVpcv8Giowqtj652kqSMZ246QSzgf3SnV/3WaooTnD2vIWq7
/lK8nED4bqVR8v/Gkig4oqL2X+ztRvB7qFHUss3bUM5BHgP9YjEjYf30WT/YJiZy
JZBjrAdslu/dwuCyVmsurW6e4DylVb+nlGLkibMH591XNwOF7eP7g2xMN4AXx9q0
XnRA7KfWe3NlSeZue0to65ipcbWkecutfa6SXgCWk7Cbjh2X9hIb52Zrbx/ZaMSk
jmAdJzySkU5+tLaIEuEs/EjtCAEyjpbJgi10WKehMVmc9+T6+hkHkRsexHWidNQX
0+NttJr7
=fMLw
-----END PGP SIGNATURE-----

--cDG5qJU2tkif8Rzc--
