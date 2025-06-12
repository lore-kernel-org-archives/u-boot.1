Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35066C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 18:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A79F82B97;
	Thu, 12 Jun 2025 20:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9J03VQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF0B82BD9; Thu, 12 Jun 2025 20:14:38 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAD682B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 20:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-408d7e2ad03so814825b6e.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749752075; x=1750356875; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lch/RGzornpRKRDL1vMJJ9IClso0onGcKPcYik4ykVo=;
 b=M9J03VQ2fmH2ki9C4RWty/gOhDYjimsS7V6B4YQRZnaI4QbPJoc7vaiByWGqq1SWcU
 8HqiFPI4HhIxIB+GM0lyqv2TmZkgIT/ETZu4xcEb//jmDZCuQzjf6wvZQdAXrW7DyY/7
 P0lQ9Tq3iWMOUdBxCanFm5D+HP9BRl7P2eDBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749752075; x=1750356875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lch/RGzornpRKRDL1vMJJ9IClso0onGcKPcYik4ykVo=;
 b=KyDGrrGRFlpa7r6cCc2ynQFQbCNC8F/fbT2owey+28vH+iJA3UO/6TDSwaleKEvfSS
 ZI6M71AWQowawN6Pm0zl1/Ndc9wyr4EuUWm2USLFTjMydB3JG3uLuo/BXVo82+9PLjFL
 PKQiigh6/jVfMfL3Y16TndZnm4yYBGcanCaznL+eWOdbUCMp1mT5c/HTbZT3+XKC0Amy
 ulFi6XTbURIWngV8TjPZNzaI1Kn2giH5Q6KjDV+Z3Y3n/J6a6fpICw3vmrb6f7+Gv8H3
 4J8D2KtDdF+aSfxfFxouPEXmrfAaQAGubCL9YBGY9wgJ4Ym3S29h+rjAx6xYQn33hTB2
 gudA==
X-Gm-Message-State: AOJu0Yzl9udXVlSSn1Rta8TXrHcvBevoUHTtof8npfjEF2KBRRPWvj8u
 SxMFUBXPUqRS3W79KNTcnFYOxdMpe/lP3k4U7g/JZvr7Leu8llEVNlBt9qRxo5lq86w=
X-Gm-Gg: ASbGnctI8zxJEpewLc+mdhRQdJLaHR56QofVbfuC706bsAQP86o6HB1eakNRaSo4QS6
 twv2vBlFFDuDoVvfM8qb9M9/xMzpRXf66zIi68zv/dxSdZNNZn0+W1q9YvZyL+9+du0Vr6+kWmv
 1J1pjUOC2tk3SdfUts+F2QVKRZAXcdIxpfvZr7bQ8CXOrrVnreS5pjxmGyibaPtXVuXkrJWQtQA
 3a54w7tu6mPLNp8KotyrC/RgDnLeFy1CDD4PhLw75E6w48GLpVFBJRe0i7NPMe6MhFXVp+/9fzP
 rP6SJHtXgfWRML+YIbh+eg2C3f9dCrwbOmI7eGoUI0CoFV+dTBgWsYuyJam8oqgDoHlsrOl7paz
 cazoIqkAy8ixrnxZD09wHzAg=
X-Google-Smtp-Source: AGHT+IGjUbLlSm7WN8EOnWaDS/ef3tugpSs7L/gvAmnd2ovEF69tWMZjAAQZYmNTpoQAcLQ6hroSoQ==
X-Received: by 2002:a05:6808:228a:b0:405:6b13:ca55 with SMTP id
 5614622812f47-40a71e6ee79mr295863b6e.37.1749752075032; 
 Thu, 12 Jun 2025 11:14:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a6822f829sm392159b6e.15.2025.06.12.11.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 11:14:34 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:14:32 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH, v2] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Message-ID: <20250612181432.GU1382132@bill-the-cat>
References: <SY7P282MB567599431AB1E77FD46913549F74A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DD8eYFaTcZp+nTY9"
Content-Disposition: inline
In-Reply-To: <SY7P282MB567599431AB1E77FD46913549F74A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
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


--DD8eYFaTcZp+nTY9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 09:08:50AM +0000, =E7=89=9B =E5=BF=97=E5=AE=8F wrot=
e:

> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_OS_E=
LF),
> explicitly pass SMP hart ID (via a0/argc) and DTB address (via a1/argv)
> to comply with modern SMP-enabled kernels' boot protocol requirements.
> See https://www.kernel.org/doc/html/latest/arch/riscv/boot.html#register-=
state
>=20
> Signed-off-by: Zone.N <zone.niuzh@hotmail.com>
> ---
> boot/bootm_os.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index a3c7cb5332e..d95477f1344 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -402,6 +402,17 @@ static int do_bootm_elf(int flag, struct bootm_info =
*bmi)
> if (flag !=3D BOOTM_STATE_OS_GO)
> return 0;
> +/*
> + * Required per RISC-V boot protocol:
> + * a0(argc) =3D hartid of the current core
> + * a1(argv) =3D address of the devicetree in memory
> + * https://www.kernel.org/doc/html/latest/arch/riscv/boot.html#register-=
state
> + */
> +#if defined(CONFIG_RISCV)
> + bmi->argc =3D gd->arch.boot_hart;
> + bmi->argv =3D (char **)bmi->images->ft_addr;
> +#endif
> +
> bootelf(bmi->images->ep, flags, bmi->argc, bmi->argv);
> return 1;

Something entirely ate the spacing, please repost, thanks.

--=20
Tom

--DD8eYFaTcZp+nTY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLGQUACgkQFHw5/5Y0
tywfzwwAnntXV7Gi12lxwMTWQHCz2D9a5BoFI6/xyxjBBERNfCPRjO12hkcGORnn
q1U4U8kNNSN/zckbcKN8uLCMvZ6+dkLPGZQGrRkdlHypJFDYi6iNa/xyGNq8e0Y1
1IUdImMG7h1Dvmr4vmedTUFDG7OfaUJ4+4iqGJzl9zOFuzna8NKLywDRBdI3W5re
XapUDeSTSgyZxeH4jKNz99elyJreV0Ze98CrtyDEp+SGz2XWWpevoH1TgojTrJT1
almCMBoMNBFqg8GqfUVRB0PlEiJwqp7A+PpZz3XSofnViOhkGdacBD7eb7yBwyqE
1TwcXzpREuVXFcwQk2eA3iyfOdoMu4acoiojQqaQJvLthh5/HkxlyG6zQ4F7TFdu
Brfxs63tTSA/6TLhIHr9ELRstnzLDPjjjQOs/Gz3l6N8SB8W+oMBARWtPTB68QqB
X513vzWh14b+QHl1+awH4hHkLspMialB0B3Li2bFUvXq6asL9dQAH/YKxnJ0Sx+Y
ziQinsCr
=Bn5s
-----END PGP SIGNATURE-----

--DD8eYFaTcZp+nTY9--
