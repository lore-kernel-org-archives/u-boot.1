Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286CEB1058
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FA283FDE;
	Tue, 10 Mar 2026 15:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOFZEdgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5EF83FE9; Tue, 10 Mar 2026 15:22:38 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E8983F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-467161c4ba7so994907b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773152555; x=1773757355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dp8CnHwi93FpuhnuSjlwJAutB48bAg7/i2pNXAnQxfk=;
 b=QOFZEdgz8gMbZ6RwvL3DfuJBo/G6AS91SZvW61NCxTsZtk4roLYp+I8CEfvrDoy2e0
 fKQA5ukDcNBnl5GNxn6wpcWluJLafNr6sndMWBmt3/4qcfT6Ab7EKiTu97SY1WxblFaN
 lufD2YVERicUbppLDkw6lvBGG0zM53VF9IUB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773152555; x=1773757355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dp8CnHwi93FpuhnuSjlwJAutB48bAg7/i2pNXAnQxfk=;
 b=bceF+yeqZg8rpJUiM0X6TSJFBxxyOe0lCTqgDxIR6u+tWwpFW6y1htT8fp6iMnvJ7J
 Hl24TUmLckz61TqL+vg2bRIJ3p73aI0shDVtQ+FLXWDFIciRIshM3OSwx8y+O2vwfAzS
 frwHlttLT04SaO2lwNCAtkh/Ngip8DF1/nMhBfd9KL3EjSZ8yLFz+FBry1PW4Pe0zSZV
 PZnzfegna1uAlGOgDheHrqQMTbZlRzfsiuW+u6VCIRI9s190yPgwvmkwsXNFCFxgZMCv
 imOwDQIEycdoYZzSjwYcofc2DmKEUyLg8+HiRWhANCW25I/+EXdG484fCAgmty0CfFp1
 B+eQ==
X-Gm-Message-State: AOJu0YxdXpBGRh5O9aEAQ0hUOqqXgUChJyi1f1LYZlFyVwItFbWcGdoP
 lcMy6F0KGIPSoUPUUKrGEJdqMhSWFkxtB9N6/YSN+09mzfzBsfBlhOK41UsCRLX7Bbo=
X-Gm-Gg: ATEYQzxyaOCpb2gPXmuMa1nyDfDENtQ6jrzLXYHOcDUtce9jErY9wYe0H7mPR5Rxeiq
 l8WeSNSGQzSOcesFo/4rw2NXzfx3z5Foxlg+L5JjP16ToCRgy+SPjxjsJbHwxvaOXXd7Y20ZAMH
 tK74Ge8zwrZJOWA2JwRAKJ4R6KGHIM84LN6/XVOxYRu8AthYEmUf5DtqqFeh7mphjGQun9THft5
 jiPfPETfMNf+KIhQR7S9ZxvnkvDY0mvJiqMlkWlTVoT+5JWfT2vF8prOrEGzSVeF27tOlNMwOs7
 6KTDAgAY5LxWoyDuGkrecVMJKdRUrL1n0iNv6CL1jV2bxJm8jpDTCea6i9ka2P1mi0uax5m4cx6
 Lzz1ocVDvSPjAJ7C4AKvRi8/KyGngoc6oH/PVQiwl5zhi1xUMerbaKebyLoAodfefp7MIWpkXSB
 PrPjtTEGl506C+QHRynzjYkfZ4843D2Pf3iT7hYYq13Juf4SVXio5lM5zqTWcPAQwyQEmqrOUli
 p6sLw02dJYmASa5IEL9yR97EHZhrQ8WtpgB4VahyTQpLw==
X-Received: by 2002:a05:6808:1807:b0:45f:1840:11f2 with SMTP id
 5614622812f47-4671bf57dfemr1942799b6e.22.1773152554929; 
 Tue, 10 Mar 2026 07:22:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d754386b7fsm2811683a34.2.2026.03.10.07.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:22:34 -0700 (PDT)
Date: Tue, 10 Mar 2026 08:22:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Suhaas Joshi <s-joshi@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
Message-ID: <20260310142232.GH1388590@bill-the-cat>
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
 <a881f055-4fc1-43fe-bc35-7ab1bc47d29b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VA1D4Y1iVDgqKOB+"
Content-Disposition: inline
In-Reply-To: <a881f055-4fc1-43fe-bc35-7ab1bc47d29b@ti.com>
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


--VA1D4Y1iVDgqKOB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 08:49:52AM -0500, Andrew Davis wrote:
> On 3/10/26 4:06 AM, Anshul Dalal wrote:
> > The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> > devices, this patch replaces them with a Kconfig option allowing for
> > easier modifications.
> >=20
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> >   arch/arm/dts/k3-binman.dtsi   |  4 ++--
> >   arch/arm/mach-k3/Kconfig      | 15 +++++++++++++++
> >   arch/arm/mach-k3/common_fdt.c |  5 +++--
> >   3 files changed, 20 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> > index 0fd93f9536a..ad127663d03 100644
> > --- a/arch/arm/dts/k3-binman.dtsi
> > +++ b/arch/arm/dts/k3-binman.dtsi
> > @@ -477,7 +477,7 @@
> >   						FWPERM_SECURE_PRIV_RWCD |
> >   						FWPERM_SECURE_USER_RWCD)>;
> >   		start_address =3D <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> > -		end_address =3D <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
> > +		end_address =3D <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERV=
ED_SIZE - 1)>;
> >   	};
> >   	firewall_armv8_optee_fg: template-8 {
> >   		control =3D <(FWCTRL_EN | FWCTRL_LOCK |
> > @@ -486,7 +486,7 @@
> >   						FWPERM_SECURE_PRIV_RWCD |
> >   						FWPERM_SECURE_USER_RWCD)>;
> >   		start_address =3D <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> > -		end_address =3D <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
> > +		end_address =3D <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RE=
SERVED_SIZE - 1)>;
> >   	};
> >   	ti_falcon_template: template-9 {
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > index 1b8c0b1eb96..ba1130a7996 100644
> > --- a/arch/arm/mach-k3/Kconfig
> > +++ b/arch/arm/mach-k3/Kconfig
> > @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
> >   	  The load address for the ATF image. This value is used to build the
> >   	  FIT image header that places ATF in memory where it will run.
> > +config K3_ATF_RESERVED_SIZE
> > +	hex "Reserved DDR size for ATF"
> > +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 ||=
 SOC_K3_J722S)
> > +	default 0x20000
> > +	help
> > +	  The runtime DDR size reserved for ATF. This value is used to fixup =
the
> > +	  kernel device-tree's reserved-memory node for ATF.
>=20
> This does more than just fixing up the DT. It also sets the size of the f=
irewall
> in the boot certificate, which is much more important. If this is set sma=
ller
> than the real size of ATF then some of it might remain un-firewalled.
>=20
> Same below for OPTEE. Otherwise, LGTM,
>=20
> Acked-by: Andrew Davis <afd@ti.com>

To be clear, I'll expect a v2 that at least updates the help text and
also updates anything relevant under doc/board/ as well. Thanks!

--=20
Tom

--VA1D4Y1iVDgqKOB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabApJAAKCRAr4qD1Cr/k
Cg40AP9zyerMiTzUiUhaXijSiKQSX4y0RgnmUT1I1emHtVPbDgD/dUdXarMO2Fyy
8FD6coLtee70Jua/5kuk1sbTdBM4sw8=
=qMir
-----END PGP SIGNATURE-----

--VA1D4Y1iVDgqKOB+--
