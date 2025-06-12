Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2830C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB0382B70;
	Thu, 12 Jun 2025 16:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kes1uNTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967AB82BD9; Thu, 12 Jun 2025 16:38:26 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A51C828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6fabe9446a0so10797586d6.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749739103; x=1750343903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S31d8eRX1fPsiTBg5aKhY8Aom3tQv1JzZI5wDmd4S6w=;
 b=kes1uNTNzsjmhy8dpCyJt8IO3a/uAPPA8ZI/ttwk3PZrXDLMKYaV3zn/oPcm2JDqgo
 pEsybiMeh51si7cQzpyW0HmaSCs4ll3EW2OBDZsu5HZX0TvfxDBepBYAtYplAIlKg4ll
 loOtXgESHkNVd0PsCNAnpjYJQRCgbNoPHDy2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749739103; x=1750343903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S31d8eRX1fPsiTBg5aKhY8Aom3tQv1JzZI5wDmd4S6w=;
 b=O+xmI2x0ui0kEiGea6kzhzQMNASiFgKwt8tMHXAU52ngVX35hK0kHJeRaN7gsCe4Og
 Kiqd4Bl5Qd2OgSID+3qtH6bnidyox0TE0YZ3DmJam2ki5nXbWQLhS4r0lfmf7CHOfDm8
 1YIXFkKQoXTpmOYBOZXQ/Fa1SAXqqgXQoN7sJJXWalXRQlbD3S3CiQAMScZXKvcOkR/4
 SlzN9esWNrg7FO1j84E+/WCbwmm/KLA9uqqIvH+rYw9LGetzUleYRL7DMq8ft7zYuLnf
 8JqtpYGT1zD8Wkomr0IrhiDa4IqD0HD2j40Jn9v9DtDjHSFxbYebK1U2HnapmAWzMYlj
 yXBw==
X-Gm-Message-State: AOJu0YwHZpBWivvTyq2/8dFKMXxGOZOTtDGliueywgifLJj3TDrg5dtI
 F20tkGMSGH17FBvEUTrvdazDjFAmUacUzc+outi4f/CL0fE+lzxCIfmfJkwl7IMBQzF25xqIqC0
 kHn3at00=
X-Gm-Gg: ASbGnctNOsaM2ruOltpXu3K7XBlj8XeyCDuit2Dp73SEYXEmJwpnqZrj381QBwncq2V
 Pb31K+5xwUiNL6mTDTsR1wboEZzS8JOvMModBRytOLXUJwiimWoK5+whI0wlNl64bPGyMCuy03T
 QY0OAE3AE9ImURGWA9tx1EPDzK/ORSUmEieRoCYHk6VIibMvjmz+6ZZFFGJTpy1PfFM/maLqDY0
 po44e2joOkjtJpAaiLQgCBjWD2PmFpqhJPl2L8/lYBXA4NN8xWyTSPdixaI3L3OV1vo/FbVISEE
 bMtq4Vw5rI90fELY7+nT9gHairfZVV4Z1IObvxtvYGsoRE6uYFdJVa/wW39NbwoEfp2p6NJnajj
 utnrDGaqu5WlVdREkDPFJGKk=
X-Google-Smtp-Source: AGHT+IH1ApESBSa4PGfpJU5VzSDMvtSE3qHq5bELJ0uUyQiEt6El8wKzM+w/qsBu/mP2+q/xcq0m7g==
X-Received: by 2002:a05:6808:3849:b0:408:e711:9aa with SMTP id
 5614622812f47-40a5d16771bmr5577845b6e.37.1749739091971; 
 Thu, 12 Jun 2025 07:38:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a6830ef25sm317351b6e.39.2025.06.12.07.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:38:11 -0700 (PDT)
Date: Thu, 12 Jun 2025 08:38:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Keerthy <j-keerthy@ti.com>,
 Bryan Brattlof <bb@ti.com>, Michael Walle <mwalle@kernel.org>,
 Thomas =?iso-8859-1?Q?Sch=E4fer?= <thomas.schaefer@kontron.com>
Subject: Re: [PATCH] mach-k3: j722s: enable caches for the SPL stage
Message-ID: <20250612143808.GM1382132@bill-the-cat>
References: <20250612115015.266601-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jv1moMU/SYeVJwyo"
Content-Disposition: inline
In-Reply-To: <20250612115015.266601-1-heiko.thiery@gmail.com>
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


--jv1moMU/SYeVJwyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 01:50:15PM +0200, Heiko Thiery wrote:

> This is same as done in 27cd65ca1bf1 ("mach-k3: am62ax: enable caches for=
 the SPL stage").
>=20
> This is resulting in ~2x speedup in the A53 SPL stage.
>=20
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  arch/arm/mach-k3/j722s/j722s_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s=
/j722s_init.c
> index af211377e7c..591aa1d60d5 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -162,6 +162,8 @@ static void k3_mem_init(void)
>  		if (ret)
>  			panic("DRAM init failed: %d\n", ret);
>  	}
> +
> +	spl_enable_cache();
>  }
> =20
>  static __maybe_unused void enable_mcu_esm_reset(void)

A bit less a comment for you and more a comment for all the TI folks,
can't we re-architect this a bit to be common? I think I even made that
point on another patch doing this same thing for another K3 part.

--=20
Tom

--jv1moMU/SYeVJwyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhK5lAACgkQFHw5/5Y0
tyxEOgv+KaPdMM7Y04sbwOymjpp1e8JP0qOnTC3nInzGAnp/5kb6UMCJ+S8G1TtC
AnQjZ4e1NKza9oOchKTp9B8mcJwCUoP6VjAGF/IT4BHGa+/xGw4Tg8sK2e6kEK8Z
WKdYkwwPTZ5xrbK3eTVW688pFCToSgTU1jtSb48rI69ccV6rpNhsSzK+JA7rQEcc
pFU54zVdMFB0kZsjV9u9JuyPwp99yZA+qnhoL9AAhJgRRK/uclgzsAg98bq/mQEk
f2EPAmTZ9/EvjqpppFOBEJOyGunwfLRO/TwlOi6RZaFI5m79Yo+eAKaltfCKnulY
mwPTo8j+u1fDple7xAdLczZn8uL/plq3l8/FK6G/z8YtkMvgoayqDSq79ydeDx9I
ZTIopIMRrPdr5UKp1RZ8fS/sT2hYYgoo5eXn/8synqtKsc7gO+KPgZrcgL5MpfcB
1MiZhvEKZnxezPNEL/kbrQYAGdRDuING+c9oofs8ZxDW5id/sZkmOU+59ov7OTbx
dTKydMtU
=TD0T
-----END PGP SIGNATURE-----

--jv1moMU/SYeVJwyo--
