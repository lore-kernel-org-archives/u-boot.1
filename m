Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B754C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB8F88981;
	Thu, 15 Aug 2024 16:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0iLqAQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEE988785; Thu, 15 Aug 2024 16:14:36 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C936688A74
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2681941eae0so598498fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723731263; x=1724336063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EvvNnX3jZjqxFpSqYpbq9Kh7jrVKQeCxJpZ5lD1/idw=;
 b=L0iLqAQOlL2Kg0bEuLQIxnOERc/wv58rPknfBeeNdDgq2yR/VeESO3KWcLbZgLkoMn
 f1Wx4vJEySx7OFRfmUE+JZMHzeGSp+csCZcZys5wmQ4MRy42BThLMmaMJd0q2Ht13jKW
 IdSe0R3WLZRbWJjGfC/YiO7k9b0w5d1I3dOYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723731263; x=1724336063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvvNnX3jZjqxFpSqYpbq9Kh7jrVKQeCxJpZ5lD1/idw=;
 b=w2AFadDLLyrTnYn5ipg1ZV27TUdc6IrCIRnY7ralExu+IFqLtg6yHZpL2g+yA3QUXB
 r6OArk4zgfLXms62H9p5q03BAod6sUFHQhkmooceDhQOcNOW5+4fIPuTzJCY6mFzUtgS
 k/3ajIt2tHkWgCj0bVRTOyz44gotri+az6tWQQWIHr5l5d5B1rRvVKhuAiHFcEQ4SrDX
 EZEU1f+V9Ap60FVTVc8nzxLXMzuVbmh9N8KqlwLsxiybb5Rsf6YhoTEXyNfvi4Hl/UKV
 MB4FmehmBgO9s/zQQ5BK16k6cAlDN5AQvEEQdrQa0umUctBmf0llmAb+/MUbsBUMXliX
 vCIg==
X-Gm-Message-State: AOJu0YxbczlvDeVXVHi2iFKloaaKVUGjPNHC3SHwFFK8dbxhCxFDJ38V
 qctxILyRrdqs90EDKUTrXHtrztD7Mfved5Eo5Iprs38m51PUanend1ZlNwIjqHLGEYrugVehrc3
 /P9A=
X-Google-Smtp-Source: AGHT+IFroXx6gFFBIHs61OIPWGFMoGS8ugnouoF8PPhw8/6M59B5NrBTQutB6208ojf+2B6kZ0x2tQ==
X-Received: by 2002:a05:6870:678e:b0:261:1f7d:cf71 with SMTP id
 586e51a60fabf-26fe5be0515mr7062281fac.34.1723731262857; 
 Thu, 15 Aug 2024 07:14:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270049fbfb2sm374743fac.55.2024.08.15.07.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:14:22 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:14:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] driver: pwm: pwm-imx: fix probing on imx6
Message-ID: <20240815141420.GR1626301@bill-the-cat>
References: <20240814121027.3477977-1-hs@denx.de>
 <20240814141736.GN1626301@bill-the-cat>
 <d1dbe0e1-ecf5-2ee4-5a64-3e50183d1583@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="58A9beWLbad1fMQB"
Content-Disposition: inline
In-Reply-To: <d1dbe0e1-ecf5-2ee4-5a64-3e50183d1583@denx.de>
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


--58A9beWLbad1fMQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 01:17:02PM +0200, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 14.08.24 16:17, Tom Rini wrote:
> > On Wed, Aug 14, 2024 at 02:10:27PM +0200, Heiko Schocher wrote:
> >=20
> > > U-Boot 2024.07 drops on aristainetos2 board the following
> > > warning:
> > >=20
> > > 	Failed to enable per_clk
> > >=20
> > > and bootlogo is not seen on LVDS display.
> > >=20
> > > This patch uses old behaviour for systems without clock framework
> > > if CONFIG_CLK is not enabled.
> > >=20
> > > Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg cl=
ock using dm")
> > > Fixes: 4eea76574062 ("pwm: imx: Remove unused references to CONFIG_IM=
X6_PWM_PER_CLK")
> > >=20
> > > Signed-off-by: Heiko Schocher <hs@denx.de>
> >=20
> > I really do not like this and would like to see the clock migration also
> > enabled / completed on these platforms. Then we can also go and rip out
> > the non-DM_PWM code here.
>=20
> Yes, valid argument, I also thought about this. Anyone working on
> this part?
>=20
> Until this work is not done, this patch is in my eyes a bugfix...
>=20
> Just enabled CONFIG_CLK and CONFIG_CLK_IMX6Q on the aristainetos2
> board and get [1] (as I also have there CONFIG_VIDEO_IPUV3=3Dy)
>=20
> Uff... yes, there are such functions in drivers/video/imx/ipu_common.c
>=20
> :-(
>=20
> and even worser "struct clk" is defined in
>=20
> drivers/video/imx/ipu.h#L22
> and
> include/clk.h#L63
>=20
> completly different ... so this is not a fast job... I fear...

Yeah, that looks like lots of legacy code that needs to be updated. Is
someone going to update it? If not, perhaps we should be removing it,
and boards, instead of adding work-arounds for lack of migration.

--=20
Tom

--58A9beWLbad1fMQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+DTgACgkQFHw5/5Y0
tywRrAv9GleNGudr9HJELoybi5qcEW/Ucr3Q6yoVmK3QsmMACKwGYn+SADqx2Dw/
+/epGfmDDr9vTlb9L8zYT7bUiG48t/R+sRVoFW94mm6bWYago5LPSHrxonpIOOdO
cUezk9cCuLDAZiGhCRlaT3tcZAmnEtESgX0IlTpV5UB0OQSiMqAeT2Dbs3mqKaq1
7+oqUFtfiR7pkEESPPfVwZIJV07x502tTWY5jKpoJ+gCRR8sdKYsAZoPUGCBriNZ
a6sO3ds0QFbpH1jXs26YpdLPGAQFR7bYnvb6SHwvaKcQEZkyZd38t6MTsjWEuIhn
ilCl6sVYWBaLSikKtaklvYWPmOi5bBe+KXKjJC+kpi477RB0W9o39iPJpo4ST9R3
rcRPoFdJSladTk8InRG4H9WRgoSff543h3Pz2CM8nU2gOeaMMYoRl3hOR47ZTNHs
hkco5c5yG3DCOsUAbrwHG+sZGEZn6q7Hksi+Y1aTl3tkXMCfzp9Oafj5gCqyoOGF
/bYEOqYO
=FTym
-----END PGP SIGNATURE-----

--58A9beWLbad1fMQB--
