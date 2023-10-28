Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853D3C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 14:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FE78778C;
	Sat, 28 Oct 2023 16:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JzBVC65L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7427787617; Sat, 28 Oct 2023 16:24:03 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F209087881
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 16:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d87554434so21817716d6.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698503038; x=1699107838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WQ3SYa5LIz5H0nLIgmqKHLRWV8As0HnKLWlf2KwFmrs=;
 b=JzBVC65LoYwtGdtKmChDbVqCuNrkSv5+9gGlq5rcLmppHiLOI8ULaODz07osoEvkH+
 4wdFLKQ8EE+0AgBD/cdfHBmPIXsp1+AfjrhCdmV5tLvtPQJ5VJ066p9zPz2UBv/IWWhj
 JRfAReR3x9kkMCNtYmwrd+I8UtIL4FR8UJQOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698503038; x=1699107838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQ3SYa5LIz5H0nLIgmqKHLRWV8As0HnKLWlf2KwFmrs=;
 b=rUWTDZf/Tb1mlHw7VRLTXm2mGTYXCN0YGACqxk32XahUkPYbLrgzOKVs0oEyDmCSzG
 qRFKg2dZ6FikqJyFtsyQYUYrJuxt/ZFB3bQUD7ukA4DVcma7AwPTZfQ9G4Fz0KLbiR+z
 W2BOMCY2e825rFibafvNn7dP6QrTpD9RS7ySMJTp2/X/80CMdfsp6Yc1tnw0CRBO2d9J
 m2uvPsnxGwJ/Mu3v1zr8xG+VEBVWdum+oedkNBh4bWM1IQG50Tu8UvRcmP1c0oXfCJYv
 8sFMEMrDtlVB+2CJLdxXMIJ2f+9gv9hjou8sLf1XgJ+MQqvecReQtHPNPNZPpJEBzdU1
 b+RA==
X-Gm-Message-State: AOJu0YxVv1mcogP/3Pl8bKq2RukRDwVmSgUFAckpC7MrpIyC3PNfMC3q
 HaxtHaRC40ePo5iEM1wVZnOGnQ==
X-Google-Smtp-Source: AGHT+IF/2ND0+nlAgTvmWaRL1iVX1X4scFYH6qnqUeBUXJ8ZpV7dk+RDENcDPzPGyHQSWNZXntVQ7A==
X-Received: by 2002:a05:6214:d6f:b0:65a:fc2a:c2ab with SMTP id
 15-20020a0562140d6f00b0065afc2ac2abmr5962327qvs.49.1698503038697; 
 Sat, 28 Oct 2023 07:23:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 s3-20020ad44b23000000b0063c71b62239sm1666489qvw.42.2023.10.28.07.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 07:23:57 -0700 (PDT)
Date: Sat, 28 Oct 2023 10:23:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Martin =?iso-8859-1?Q?F=E4cknitz?= <faecknitz@hotsplots.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mpc85xx: relocate code in non-SPL build
Message-ID: <20231028142356.GQ496310@bill-the-cat>
References: <20231019230655.24974-1-faecknitz@hotsplots.de>
 <20231028132653.GH496310@bill-the-cat>
 <200e9d8c-5658-0fc0-36dd-cf36c3065ad0@hotsplots.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MG32ZOqPIK3onVKp"
Content-Disposition: inline
In-Reply-To: <200e9d8c-5658-0fc0-36dd-cf36c3065ad0@hotsplots.de>
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


--MG32ZOqPIK3onVKp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 04:21:18PM +0200, Martin F=E4cknitz wrote:
> Works now. I used T1042D4RDB_SDCARD_defconfig.
>=20
> relocate_code in arch/powerpc/cpu/mpc85xx/start.o before patch (non-SPL b=
uild):
>=20
> 00000dc0 <relocate_code>:
>  dc0:   7c 61 1b 78     mr      r1,r3
>  dc4:   7c 89 23 78     mr      r9,r4
>  dc8:   7c aa 2b 78     mr      r10,r5
>  dcc:   48 00 00 05     bl      dd0 <relocate_code+0x10>
>  dd0:   7d 88 02 a6     mflr    r12
>  dd4:   80 0c 01 fc     lwz     r0,508(r12)
>  dd8:   7d 80 62 14     add     r12,r0,r12
>=20
> 00000ddc <in_ram>:
>  ...
>=20
> After Patch:
> 00000dc0 <relocate_code>:
>   dc0:       7c 61 1b 78     mr      r1,r3
>   dc4:       7c 89 23 78     mr      r9,r4
>   dc8:       7c aa 2b 78     mr      r10,r5
>   dcc:       48 00 00 05     bl      dd0 <relocate_code+0x10>
>   dd0:       7d 88 02 a6     mflr    r12
>   dd4:       80 0c 02 c8     lwz     r0,712(r12)
>   dd8:       7d 80 62 14     add     r12,r0,r12
>   ...
>   ea0:       7c 08 03 a6     mtlr    r0
>   ea4:       4e 80 00 20     blr
>=20
> 00000ea8 <in_ram>:
>  ...
>=20
> In SPL build, relocate_code is same in both builds (because of
> CONFIG_SPL_SKIP_RELOCATE).

Thanks for confirming!

>=20
>=20
> On 28.10.2023 15:26, Tom Rini wrote:
> > On Fri, Oct 20, 2023 at 01:06:55AM +0200, Martin F=E4cknitz wrote:
> >=20
> >> When building a non-SPL image, relocation is needed. This patch restor=
es
> >> the old behaviour before commit b35316fb67: CONFIG_SPL_SKIP_RELOCATE w=
as
> >> only defined if CONFIG_SPL_BUILD was defined.
> >>
> >> Fixes: b35316fb67cb ("Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig=
")
> >> Signed-off-by: Martin F=E4cknitz <faecknitz@hotsplots.de>
> >=20
> > This is now applied to u-boot/master, thanks!  But also, can you please
> > confirm that top of tree now works for you, and which defconfig that is?
> > As part of my testing I check for size changes before/after and this
> > doesn't change any platform, which would lead to how I had missed the
> > problem during the conversion.
> >=20
>=20

--=20
Tom

--MG32ZOqPIK3onVKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9GXkACgkQFHw5/5Y0
tyzGlwwAh+wa6LbOfuhAJn5rEweMbO2bDwbzGV4gGWDkS55npOzDVE0BK7E6ShNZ
+RGPq3ptWsjUlrpyCDqpRxrOuzEtgo+FYjmVtKp4FJsyZcVsluwq8no9Y5jyWrxp
Vf5Tk4KQ+Q3Fkug0SN5H/YWSRTBMMZxRXVRo9ygAtk9QhnD/FU11kM5Wi+oYSsZ/
uzlGMm0D9nAt5XA7Eqf7TAotUExLig/r5Q8ismk8GPbMC42nmR64Mbu2r5FTrcM0
e/frTwvpsTsonePoRWfkjXS6OhJWNwrY2ZSElDXyldyS2Et8dA9ongC5CwVdry/P
zI9WvFu1N2W3OmU4vxBWxYbd81L0r+8lmY7Cx8YDePboaxfQyvlnqscXt6jQ7oPw
+bfyMNfVaWyDaANiZpZPtT8WsBYVVVxGCmjyhqiY0SxwO5cuDOe1YQNJgZ2vefWE
QE9tY+kvt1O7QTvrfOLaxTOSXsEiiQTd9Zmx7hX1OFPn5/x9XY7/tlyiz5UaPhEp
xfxhXWkh
=C68u
-----END PGP SIGNATURE-----

--MG32ZOqPIK3onVKp--
