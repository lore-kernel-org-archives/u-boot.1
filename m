Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A9E6FE3D
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 18:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB51788BAE;
	Fri,  6 Sep 2024 20:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZc4V5MO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B2488D10; Fri,  6 Sep 2024 20:18:56 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62ED7889F8
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 20:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf7ad1ec3aso12550936d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725646732; x=1726251532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zW7HVwZtx/8hT6Sn+IRQG4YkSBBvrW+fIHWfKuuRnUk=;
 b=IZc4V5MOA7bOowT/n2PGFCbfJ1gbCu6R9DhhLbJosF5yWQKxSJtN+1wwKiucuMdQ7m
 kvzcU5OEdrjshM5hVO3yJ+sRaZcEtjBxa+1NcMsj/vXnx8eGdSpN17GCITRfDmfqIaMU
 bHYIVfwh3sy0dhngLyHijJotYzHK/zHj0FRtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725646732; x=1726251532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW7HVwZtx/8hT6Sn+IRQG4YkSBBvrW+fIHWfKuuRnUk=;
 b=p6LiFT12+hCbUbAxIrPWjR44zu2rRlQOsh4A4SyGnDl0GS0Hhp6ehgQ8ERqX0Yqlps
 SEsKakD1eJbdsGw/J/AL3qDA6z2CH6ITY0IRg3ZsxArvqsXK0ARhjh3XTXs7//ERxFU2
 ZyhJZz+1brGDls7RFKv+HLuTwCXHAGqHI05y7fqs+nPgH0K4WaXbrsEmu2qwQjOOzU9B
 dBmslsgn0K+Ul9au76fUHtIiPx6BcMGLxwtc2HT9n06EGX2AxZqYz3f7gVPdB73WuJA/
 V9vKMJGdX+krFKQVpgTeY/rOLq9D9w5RFgEkrMYciA39n/STLjfGBrwQtTuPA43PRAjb
 gO8A==
X-Gm-Message-State: AOJu0YyzEikGGkUTqX2slk1xeAX7z5FjN445wkSODrNdLRmjf1aGO9tX
 n0W+M1YBSaOSjOxYWMmiwSB+B+tM/vFwv/k4+xZ3BwJbbzaV+uTskWtL82iTA14=
X-Google-Smtp-Source: AGHT+IEE/9VmDMavGxvelmGo5ZRuGLj2NBcB06yvFg4mLdjyaBA0TKJVUyJLKVqF4hR8C+sdAJge4Q==
X-Received: by 2002:a05:6214:3f90:b0:6c5:2747:f458 with SMTP id
 6a1803df08f44-6c5323fa96cmr1133296d6.14.1725646732237; 
 Fri, 06 Sep 2024 11:18:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c520419b03sm18382146d6.104.2024.09.06.11.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:18:51 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:18:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com,
 venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
Subject: Re: [PATCH v2 1/2] kbuild: cherry-pick kbuild fdtoverlay changes
 from linux
Message-ID: <20240906181847.GF3879073@bill-the-cat>
References: <20240906070808.1045991-1-prasad.kummari@amd.com>
 <20240906070808.1045991-2-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NRnXKE1Uo6MGFqDa"
Content-Disposition: inline
In-Reply-To: <20240906070808.1045991-2-prasad.kummari@amd.com>
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


--NRnXKE1Uo6MGFqDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 12:38:07PM +0530, Prasad Kummari wrote:

> Linux commits:
> 15d16d6dadf6 kbuild: Add generic rule to apply fdtoverlay
> 44f87191d105 kbuild: parameterize the .o part of suffix-search
>=20
> The Linux commit 15d16d6dadf6 adds a generic rule in Makefile.lib
> to automatically apply fdtoverlay, so that each platform doesn't
> need to include a complex rule. This also automatically appends
> DTC_FLAGS_foo_base +=3D -@ to all base files
>=20
> The platform's Makefile only needs to have this now:
>=20
> foo-dtbs :=3D foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
> dtb-y :=3D foo.dtb
>=20
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>

Thanks for rephrasing.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NRnXKE1Uo6MGFqDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbR4QACgkQFHw5/5Y0
tyzvQgwAr6O2iCxZ+reoe9elYrgtxq/xDtpF3Oa0EZRk7Vw7QECIsK6UbqNPCAEZ
bh/undBsvyC17QfhTsEUzItoJJTwAIG7Tny0TRArfFnkEDOMsH6ALQunVLfYIbG/
Vkq92Goypv438XGKcMYpa6BXaWcgYsGUI17CovBow3dqQkb5xBQawFO+m0Rxsifx
JxG+BeDOZQDguQiki5J0xBWPFjLvXIR+2msOXdw/fdt5H/BS8mTdaTOn2KfIf/YX
24WI37UYUJroU+nQFTLuD+CM/Fxb1uYZRJkaZErHo8Z3XEkfx7vh7x3Ku9XlwIzL
WQTYDTEJ+I2R2nsDosGP/v9Fe3WkE0LXH2FnGVaCsdBFoWrOdOmLtCTd8ok2yMMJ
66Jlbl1xuIkGDQ08IX9uFB7mZ74GGQOXHPeQXz6hVvWVfVW4UiSVPPubtBvmeSgz
RyZTYPyzgrg1/F7g0PRkZ+wdntUAFFXwOht14SP88sijB72/rgbRhHjvU5AyN+3m
CjC45YqR
=H6OA
-----END PGP SIGNATURE-----

--NRnXKE1Uo6MGFqDa--
