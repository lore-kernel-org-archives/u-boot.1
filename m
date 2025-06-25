Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1245C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 16:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1039582D88;
	Wed, 25 Jun 2025 18:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MPG6fvj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FAD82DF2; Wed, 25 Jun 2025 18:37:56 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E49582D83
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 18:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea83f382c3so95321fac.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750869466; x=1751474266; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ph42e4PXhAOctsjuXgHFfJS5+3fWNsVeTH5ybBB4/Kg=;
 b=MPG6fvj1q3kPanMhHa1ZLpQQGv2GIWQhv/pUTC6DjrbTSSYP0dHLqry/u2fp2j36Y9
 nD3Vy9z7w1qGbOWSIbsSXzQWvTCdLpTbeTZUI0cmb9Knx8PdQRUBaJWO1cpQy1/jbKIr
 c3cHl++J994hjwm2V2XBo9n9j+brbe6rbrrbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750869466; x=1751474266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph42e4PXhAOctsjuXgHFfJS5+3fWNsVeTH5ybBB4/Kg=;
 b=YD+HNy+Rv4szh2J0iSQID/Ft4/4lf6A9Iq3GQTkOW4a0fl4HuBlrc2/F6tjJEF+UnR
 +NLPt0d8LyHtetgnAYT3xBAvwqUwHzWI+Vs0QK3Js4OVY5MMCAF9aavGuFBSMKz+4EiM
 QGMk2U9fHivnoOdttHl7LlU8KDxyM72X9d8FU0hSXgGIKE6sSyFpR2a+4SUrDSKTNPLE
 NfKzH0qDvGzWIjolAKUMWG3h8gDpO4U3gB2/dDYjcax7dHc/2nmgTSldZ5N1ORjhCWxS
 ZZ88pJ4E3+j7h5VXdfHJGMh8TsxnKl/FUYfUJTTPnG3sUqCnxR5aQVg4lVE46Tj2hea7
 IfpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE8yFoJ+8BUR9vUbg2toQ3L+iCcKP0A4EwQltmkMb7ix90vbNFGPnbUL2/FmdZ1Xs52n6FGgE=@lists.denx.de
X-Gm-Message-State: AOJu0YxZzZbf0bWtUm2WpcgzahmLgnQ+VRgeltC8JQBu5e6UB52eX1Sz
 oMgO0gRTZwzYQtFJIAhETMoruWfo7fIQC0ZcsIK2iZ2QyV0jDScmr3HRYy0Yk5he+vs=
X-Gm-Gg: ASbGncssOkgTZqPnwa3Q9tyCpIs1PUulcOa9aCw4eo6zKx+RD4dP4HVJ01pIzJu3Aou
 MXybtvIivqso/Dfb/ghZrOWwqQlv00jUFX2My/uL82nGaksmKMSMl2NAvmgOuAB91RRe8gj//xX
 J5qeZ/g8upaP+kLDKF0g52B9OYIZxHIZm65W8JMmZa1k4gJvaekfUQsVKbm2PpFvYc5EAcjvUMg
 ws4/sD7CFc06QAIAHUGGbU4qsvNIV+jXyA2gfQGH1pz36AFrniaYiwAcXRMtv/MBEd3aLCx5Ho5
 4p7nQqjK5pQb3lR5W3o3ba9E2m767VZytyY7db4jUF6NhixdkyjIpw4Rya8ERSJ11XY0uGgGGv1
 qTHaREijaSKcXSMPpKVVSwA9KBzFbpgWG2w==
X-Google-Smtp-Source: AGHT+IG9JuEGs5PL+LTr5oWT/miaQKaWn9dhAcH+bHJwtIYQ5S77dpYA2Fon45tDXoJLXlIniB+t3Q==
X-Received: by 2002:a05:6870:459b:b0:2e9:95cc:b855 with SMTP id
 586e51a60fabf-2efce3a8cd1mr324420fac.34.1750869465829; 
 Wed, 25 Jun 2025 09:37:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eead8cc129sm2575542fac.41.2025.06.25.09.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 09:37:45 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:37:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625163742.GR4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
 <20250625141424.GN4003484@bill-the-cat>
 <20250625-stylishly-expiring-c37b5a0a52fb@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iFDUBenCSCNu6H46"
Content-Disposition: inline
In-Reply-To: <20250625-stylishly-expiring-c37b5a0a52fb@spud>
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


--iFDUBenCSCNu6H46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 05:28:56PM +0100, Conor Dooley wrote:
> On Wed, Jun 25, 2025 at 08:14:24AM -0600, Tom Rini wrote:
> > On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski wrote:
> > > Hi Tom,
> > >=20
> > > > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski wrote:
> > > >=20
> > > > > The commit e8a9521e649f
> > > > > ("vf500/vf610: synchronise device trees with linux")
> > > > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > > > It turned out that in Linux's upstream iomuxc node description the
> > > > > fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP=
's
> > > > > Vybrid SoC was not working properly.
> > > > >=20
> > > > > As by default the mux mask was set to 0, the vf610 based boards
> > > > > (like BK4) were bricked, due to misconfiguration of gpio at early
> > > > > boot stage.
> > > > >=20
> > > > > The fix for all vf610 based boards is to introduce
> > > > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property provided and
> > > > > include it in boards' specific U-Boot adjustment files (like
> > > > > vf610-bk4r1-u-boot.dtsi).
> > > > >=20
> > > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > > ---
> > > > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > > > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > > > >  2 files changed, 11 insertions(+)
> > > > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi =20
> > > >=20
> > > > It looks like this is still missing upstream, so what's the status =
on
> > > > that?=20
> > >=20
> > > It looks like in Linux the mux_mask is hardcoded (for Vybrid vf610):
> > > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/fre=
escale/pinctrl-vf610.c#L321
> > >=20
> > > In u-boot other SoCs use it as well, but with different values:
> > > - arch/arm/dts/imxrt1050.dtsi -> 0x7
> > > - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
> > >=20
> > > In the imx8ulp case above - it is already set in *-u-boot.dtsi specif=
ic
> > > file, so I've followed this approach.
> >=20
> > Someone should unify upstream to one approach or another I would think.
> > Or find a good explanation as to why it's not unified, and then we
> > should follow.
>=20
> If these values are per-SoC, which they appear to be given these
> look like 3 different devices, I don't see a reason for these to be
> accepted "upstream".

OK, yes. But it should either be "hard code a thing" or "get the
property" not maybe-one-maybe-the-other? That was what I was trying to
make as my point.

--=20
Tom

--iFDUBenCSCNu6H46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcJdMACgkQFHw5/5Y0
tyziNAv+J/4wG7XSuVTbY9Fdg/mdDG1NBtVxZ74XR1ZPqAAjq6PV9eCLEHLk473F
nIu2w2oLWD10hUAWrWKCuR6djky6gpG+ZkIExt7NWrUMp0YzGpdGhVjwaIocwvxz
sy7CpWGX/C/ZgnzclC1O8ydaYPluXjE4qHInIBEExfhTsOy6uLV4FPOfUuUXDGr8
Se8ycmglU6t5i76JG7ByQlcqGLSr8gN4y+PdFfc+/WIj/7sFg5JnnAyGN5UkR8d8
uHhh3BPiUHILsB/7sss3VH46A8PJ/6Sh/Nz6QNx5HqqFQ9uoOsJNAHcLeSIwCNha
Kig4rdX2g9iTVO3wbVFExHbAJ3go3EPKM/dDFq0xQ+h8JBshtAvdCj/KB2c9Lt2/
sA7+2mN6cbJSSEo1rk7GbrYU9Og1vcN+xmq838uKZGNWrmIlITWgPnbhUA50nRtB
ytFZQLh8bHWM0fXr5K4oOjXJpPtzmiLh++MkSwz3o4M/yxDEQ1ppBsgaD+na0aHu
ps0AkwBZ
=d7+O
-----END PGP SIGNATURE-----

--iFDUBenCSCNu6H46--
