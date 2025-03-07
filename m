Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94929C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 16:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1078681420;
	Fri,  7 Mar 2025 17:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qrh4R3ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D218142D; Fri,  7 Mar 2025 17:20:49 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4510480F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 17:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so1751980276.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741364446; x=1741969246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E+2NdPc68lQICH8MhxIU6YB/2FWST7f3lMLUNOnNLp8=;
 b=Qrh4R3ZHVl1xtmFPambRNEAjqYL4Oa//4MqiClXDA+tsjdlWfF1uHEm5mvcX/nb5M1
 b5K/Cjk7BuofSh1CpOdAFUIL3xaXxZFtxr7c0CtCjrBwbD+3pkSe5aDBeHCrjzpDnuPF
 04/3d8uBGTqx/kl4HyU5Gs0/PHnuommnNLplU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741364446; x=1741969246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+2NdPc68lQICH8MhxIU6YB/2FWST7f3lMLUNOnNLp8=;
 b=d/lyRQBfXYyuB74U56u6lgZ6c1OK9w66fZLKYLfksrva8Xl5zQ8iS5z+dLqTbblkTm
 G+FxRJoBTCDSAU9CF2lKiyl2dHfx1n4QKY5ro8qJvhWpKgk514ag2efTpq0/XZ6hjhGq
 jw+wH7foFFQnnhDXmkyy5zUjxCgIK3OhDHV5Bfr97d3gvSGFKhfiCpt9L/ZJ9pQwsPZ/
 PGB7YkGsTYI704vcbzRLnnOTwI1LCws7IT9bCwlT0mS+h+0lxvbY9dcOnISPcemrvGnI
 mRRMuQrYOoNvWiKaZTVn+UBk2lwnuLTd1C3bJOCh7LLiSE1icoQLMO/S9vjm3ETmguWI
 cDRg==
X-Gm-Message-State: AOJu0Yz+dOQ2aNAC4dBGXq7Z8JolkrBacPrM4Lut8RJJ9xK8DxzZ4sN0
 unoB2i3zTD7dMKtuuYqMzuzUQmN7Z+LIo2IWKqOMx86jxzTHYhwV8Tw1CDX7QM8=
X-Gm-Gg: ASbGncuXXKvJ8aZwJjGhSyrqfSLQC9YyaLiQmVA76biQps8b1xz7xhdSQhprPswrX9L
 RJFHey8p1G9+3x1tyLI9rX2rxSYnFmatciU+Mbqwz+3FKIVBFGKV3ioS65UxBWMl4PQSi0pyyZ6
 BOtfZNLoqJa5oNaZxh/CZn/2Gpl4hSXC6MfP9qjToRrzSs/rAY+2euhJDtIhjl+yPfMwWDZR7TG
 0dotq7ctAQ5TtekQzadKqsiXMzdEJx013sfBOSTjm/RlGGQAKUZmqsy67NTCUsuEyL8cDP9fmeV
 jrim5Ys/V5vgbULBJ2/Bff8c6y9AJxMbwSk7NZE7/8p4tw==
X-Google-Smtp-Source: AGHT+IGsbFhC3VR3HjWilV4tcYFQeI/6zhguEdnPw0EXYCPGTkQesPruG2WYQuKi69833tL52EXuwg==
X-Received: by 2002:a05:6902:2410:b0:e60:85ed:8ce8 with SMTP id
 3f1490d57ef6-e636f816c9fmr139570276.21.1741364446094; 
 Fri, 07 Mar 2025 08:20:46 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b735951sm892732276.7.2025.03.07.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 08:20:45 -0800 (PST)
Date: Fri, 7 Mar 2025 10:20:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH 02/10] cmd: Kconfig: enable CMD_BOOTI for ARCH_K3
Message-ID: <20250307162042.GS2640854@bill-the-cat>
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-3-anshuld@ti.com>
 <20250307155055.GP2640854@bill-the-cat>
 <D8A60PFV4FQL.5AHV0A4WLX0T@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RkdanoOPmJAoLVnS"
Content-Disposition: inline
In-Reply-To: <D8A60PFV4FQL.5AHV0A4WLX0T@ti.com>
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


--RkdanoOPmJAoLVnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 09:43:19PM +0530, Anshul Dalal wrote:
> On Fri Mar 7, 2025 at 9:20 PM IST, Tom Rini wrote:
> > On Fri, Mar 07, 2025 at 01:25:30PM +0530, Anshul Dalal wrote:
> >
> > > This allows us to load the kernel image to memory on 32-bit R5 SPL.
> > >=20
> > > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > > ---
> > >  cmd/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index a04fcaa0e08..66145a001b8 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -357,7 +357,7 @@ config CMD_BOOTZ
> > > =20
> > >  config CMD_BOOTI
> > >  	bool "booti"
> > > -	depends on ARM64 || RISCV || SANDBOX
> > > +	depends on ARM64 || RISCV || SANDBOX || ARCH_K3
> >
> > How are you using "booti" on the R5 part of K3? This shouldn't be
> > useful...
>=20
> This is necessary to allow us to call booti_setup [the code path
> responsible for parsing uncompressed kernel image] from
> spl_parse_image_header at common/spl/spl.c:338 when loading the Image.

OK, so please update arch/arm/lib/Makefile with something like:
ifdef CONFIG_ARCH_K3
obj-$(CONFIG_SPL_OS_BOOT) +=3D booti.o
endif

Thanks.

--=20
Tom

--RkdanoOPmJAoLVnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLHNMACgkQFHw5/5Y0
tyzZbQv9FSB/9Tyesrirmv1IYYW8HhQL5ODPrvF8u/sTvfXzFz5VSnJlr29i4Ywh
6tQIdnJq+UkmXlO+ltjLlEpmTxOtFoM8ly6fvNHX09j7itcKZOdi1zTGixpojtTu
KUb5y4BjOO8QPwJtdrY9lNRD2Mx3karjN2TmmID4VhOTFWzl6Mt+I1BiuRhAyLJp
9UplM3fVDdDBSHiHu17K4sM0q3fGiRIuMQ56/jRIDizxKeHGhvX/5DV28icIWrXf
R/PaO/fboyAfR25dU9vZSNjP+G3s0WJGeZabO3X7IwkiIO3gU1CYWm/WE1YCbtya
aVILmdCfJiPVvk8F2RT4bJip2qxMV8iXK6egTkvudcQ+scuQyFdLQkKU6kN3lnwl
koNP6hOshY/k3FxvI15yDGALhtUxFKDONtjXoYvZSHzBwdmLmrV5yTr2Mz6jkX90
qsdCPzERS8jHOHu7mHOI55Kq6G/OkEnt0O/7W7z95epo7Uha8UuKPtsh4Ap0mSGn
sGkE3aDt
=sal4
-----END PGP SIGNATURE-----

--RkdanoOPmJAoLVnS--
