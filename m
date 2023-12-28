Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A3C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA96876FC;
	Thu, 28 Dec 2023 14:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JqDqK1nN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179C0876FC; Thu, 28 Dec 2023 14:56:52 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9E3878FA
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5e730eb1770so47799197b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703771806; x=1704376606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SCXGNWJDYhC0OrELLxlqHRaVUue2ySOrdLjliTLJ3MM=;
 b=JqDqK1nNAN2R1uXakrbQ6ZdcT24Eqqy450NL6oVYVa5/Npc18mTou7dw/yYx1rzYEf
 gljREv4UdIzKM3vAcfzZpIJooXORTfj5+rEpy1Ff6M19fWaECdiUk0cogTuhFuBQPtT+
 gdD0fWSXAkMIz+fzw73GRBa5CaRPUT22cr5YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703771806; x=1704376606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCXGNWJDYhC0OrELLxlqHRaVUue2ySOrdLjliTLJ3MM=;
 b=FgQX05kRfr2x1oqzyvo3vvMwo0R1UDZoT+hnPDDEuJrSFlHFFJmn+07DL6dhoAt9ks
 EBbHpMHryKcp5yrIIZlEYl+fCPQgPBB8XYBapJDwMdPprKEo4mgWaOOcrBEdi7Tl9C71
 hTFnad0KX6CHIZt3CLeJbuwQ5jA7OceChpTMp4ZSDtLLS92R2IdyHtCGcwy5+jA5cjU4
 umG5Zd9mpVmR7zviyJmC0sleJYNb/FMNiEoKTHrbEcaaSk2g6dW8Os7WUeXsPZ4g15t2
 A0phl2al4GQ9gVswRXg5mh+CMm+VvuO7WYkJrZTfLRqb4wJmZwblbDJsSZUTlfm+KJoK
 x4DQ==
X-Gm-Message-State: AOJu0Yy0Bl8Y3ph//UJ1Lt/j+IgnGrSNgwwxDS8gOSdVYX8oxDQQLsiR
 Ho6TXCiVZhNJtUvx/k4t09vKOpzd9sAFwg==
X-Google-Smtp-Source: AGHT+IF6p0EENKO41vaq8f2Wp7L6Q7Fupb1/WEJ4rW0pStH/pUPdKh/oZipe1f5GxEJjXKUw/tNKgw==
X-Received: by 2002:a0d:dac5:0:b0:5e7:4d46:d8a4 with SMTP id
 c188-20020a0ddac5000000b005e74d46d8a4mr6231945ywe.33.1703771806058; 
 Thu, 28 Dec 2023 05:56:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 m125-20020a0dfc83000000b005ca4e49bb54sm7456976ywf.142.2023.12.28.05.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 05:56:45 -0800 (PST)
Date: Thu, 28 Dec 2023 08:56:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231228135642.GA2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
 <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJelmuIqDcSN1FFP"
Content-Disposition: inline
In-Reply-To: <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
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


--tJelmuIqDcSN1FFP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> Hi Sumit,
>=20
> On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Although there were still some variations in board DTS files based on
> > meson-gxbb SoC but I think those were minor differences from upstream
> > and shouldn't impact boot on these devices.
> >
> > So switch to upstream DT via mirroring amlogic/ directory from
> > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > building DTB from there including *-u-boot.dtsi files from
> > arch/$(ARCH)/dts/ directory.
> >
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v3:
> > --------------
> > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
> >
> > Changes in v2:
> > --------------
> > - Picked up review tag
> >
> >  arch/arm/mach-meson/Kconfig           | 1 +
> >  configs/nanopi-k2_defconfig           | 2 +-
> >  configs/odroid-c2_defconfig           | 2 +-
> >  configs/p200_defconfig                | 2 +-
> >  configs/p201_defconfig                | 2 +-
> >  configs/videostrong-kii-pro_defconfig | 2 +-
> >  configs/wetek-hub_defconfig           | 2 +-
> >  configs/wetek-play2_defconfig         | 2 +-
> >  dts/arch/arm64/amlogic                | 1 +
> >  9 files changed, 9 insertions(+), 7 deletions(-)
> >  create mode 120000 dts/arch/arm64/amlogic
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> > index d6c89058061..8ddb59161a0 100644
> > --- a/arch/arm/mach-meson/Kconfig
> > +++ b/arch/arm/mach-meson/Kconfig
> > @@ -25,6 +25,7 @@ choice
> >  config MESON_GXBB
> >         bool "GXBB"
> >         select MESON_GX
> > +       imply OF_UPSTREAM
> >         help
> >           Select this if your SoC is an S905
> >
> > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> > index 41dbf7981f8..2e1c756bf7a 100644
> > --- a/configs/nanopi-k2_defconfig
> > +++ b/configs/nanopi-k2_defconfig
> > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> >  CONFIG_ENV_SIZE=3D0x2000
> >  CONFIG_DM_GPIO=3Dy
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> >  CONFIG_DM_RESET=3Dy
> >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
>=20
> So now I am wondering if we can (later) have the SoC be implied when
> using OF_UPSTREAM so we can do:
>=20
> CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
>=20
> and it will add the 'amlogic/' automatically?
>=20
> Perhaps that might be a way to bridge the gap in terms of file layout?

That's going to start to look real ugly real quick I suspect and I'm not
sure what it really gets us? It seems to me that the convention of
"vendor/board" has already been well enough adapted outside of the
kernel, with the odd sticking point being getting everyone used to
whatever will be happening for 32bit boards long term. So I think hiding
the vendor part of the string here will be more, not less, confusing
long term.

--=20
Tom

--tJelmuIqDcSN1FFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNfpoACgkQFHw5/5Y0
tyyIkgv/d42Ukvj978nS7qzNezpTCrt7M/t9ow6N8gade2zN0eDszLtVCLv75bJ6
+C1JhVgLE/UTvzXEtHGi1KNqdH+yfhxFftll6PeQx2TPPvKgbpw6+7LkCmYWma8N
uUBccX3O1xNlKe77HYWmW4yAVyQy3UGgCF0HZxW2Vn7iVomcSKG1UWN6aSkI9tYw
ewnmdAvfa2z1VXGEHWMUl8MbfbJZPBVbZShTmv5uQO2dwP7jAukxDOplWl4m24Eq
BDuAdSqIewWTI3lePr6Pu1+VI7mCdaG24Fw93HnhhFUClmHK+RYS5nt/2IMzmN/T
f2QrU/a9NA+mBihhCHDLRqAZHGp33dNt0w/6E5oYfJoyG9mzX/ghrqXVYttd/1Em
rj81jcPnw4FM8NBjKQPX7AUUxNNqrfCSWtpR2+XVXnSsGH1+LtktBd214BOPCKv7
zE3veLcVGtgul49zsMiaAe4kx3TYyYxc/HmgW/cvc55++C4TIkd/Rtv5IDieEpRO
aDZdO0Tn
=6plK
-----END PGP SIGNATURE-----

--tJelmuIqDcSN1FFP--
