Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C216C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CEE88607;
	Mon, 10 Jun 2024 19:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="itCMfcT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBF488607; Mon, 10 Jun 2024 19:31:08 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4128858D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b9706c84e5so2668239eaf.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718040665; x=1718645465; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sI+F4I0u5n6N5Ms1G2p/zWIhY71GBF/s60JqAW7tqSU=;
 b=itCMfcT9VcX0/XwJJg2tc9H8S29W/xETdcHYU15/6+xlnexQtS3cln27YSgiSQVqld
 BmsUiAs+qbfL4tDERxOkvOMOqBjYlJL3UGtyaCzM2kTvgz/rbSb5SSCEawcVMX2xdL2O
 OTT085iQ0IBwWh090Bt5NAJqqJkSGd6fpJ8fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718040665; x=1718645465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sI+F4I0u5n6N5Ms1G2p/zWIhY71GBF/s60JqAW7tqSU=;
 b=dqh/SL6UBEzzUV3yxW2ULy8gen+5A8berGKwVecOnKEwxqap+9fvfdoQNpi4WhjOuy
 ILQwDVQuPDSmwy5xsSTh8Nl3rr39HhMsMJtczol/pk/7uR44U0D2VH1a4UvWC3OkOR67
 Eb4FT3XdnXalLHSdZo1bW7eyXgV+MGr2/QCHCzsUBGPwQAiWHm3rtfWR/jg1fZdNrQgV
 1RJ9CHSHGY5VgmU4W+Y/OAHyrUirn5+iy0Th/6i7Lx/phvUix758ruOzZKmYbbwqh0c/
 1lzuTq2PMAfxWd+/WgTPkC1XjanXchG3y8tBsUfgKEZONeC1tp+jGNKZLlCiocl5H8Ht
 DyIw==
X-Gm-Message-State: AOJu0YzRmRqfVPWHCQBcRCoXpuGiIFzn/6K8qsUxz6iw5R5T6rRarLgT
 Hiro53fYKv1o8PTO7bPeuRQ9QAYG2WrtQUNEgYu4Fx46CviKtcTKCEzBFeeAdP4=
X-Google-Smtp-Source: AGHT+IE6VMieYU0DFNLAf3AL4zVw88uAKw2I67+bNhCzI5AbR87ud9ivMWNN5gGDZEojHoxtXOuATg==
X-Received: by 2002:a05:6820:1ca7:b0:5ba:f20c:3629 with SMTP id
 006d021491bc7-5baf20c3769mr4341717eaf.4.1718040665169; 
 Mon, 10 Jun 2024 10:31:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bae06f9a3fsm801074eaf.1.2024.06.10.10.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 10:31:04 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:31:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 08/31] lmb: replcace the lmb_init_and_reserve()
 function
Message-ID: <20240610173102.GW68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-9-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XvX33tbdsxjov8Dg"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-9-sughosh.ganu@linaro.org>
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


--XvX33tbdsxjov8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:17AM +0530, Sughosh Ganu wrote:
> With the changes to make the Logical Memory Block(LMB) allocations
> persistent and with the common memory regions being reserved during
> board init, the lmb_init_and_reserve() API can be removed and replaced
> with a lmb_add_memory() API, which adds all the available memory to
> the LMB pool.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  arch/arm/mach-apple/board.c          |  2 +-
>  arch/arm/mach-snapdragon/board.c     |  2 +-
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  2 +-
>  cmd/bdinfo.c                         |  2 +-
>  cmd/load.c                           |  2 +-
>  fs/fs.c                              |  2 +-
>  include/lmb.h                        | 12 +++++++++++-
>  lib/lmb.c                            | 15 +++++++++++----
>  net/tftp.c                           |  2 +-
>  net/wget.c                           |  2 +-
>  test/cmd/bdinfo.c                    | 10 +---------
>  11 files changed, 31 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index c877c7b94c..2e72d03edd 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -776,7 +776,7 @@ int board_late_init(void)
>  {
>  	u32 status =3D 0;
> =20
> -	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> +	lmb_add_memory(gd->bd);
> =20
>  	/* somewhat based on the Linux Kernel boot requirements:
>  	 * align by 2M and maximal FDT size 2M

We already reserved gd->bd as part of the initr_lmb call. So I think
this commit needs rethinking, or am I missing something?

--=20
Tom

--XvX33tbdsxjov8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnOFYACgkQFHw5/5Y0
tyzTIwv+PxXjjO16C299Pa3fMSyMjqXeWmcNc7PQK5jTNKMErFPvKt/0MBNq2nMM
Kg9JhP+GLkifDX6TG3qp0GXXR9XaOEsrB1Tsidikmf3Rfq159GedwKCJieRofvBE
Jst9vIXH9m9+UP0eR7fEiFzpGqXqfI3+J/EQz9wX2bF8lzz5eiYXKg/UL2pmUQS9
or5JB8jwqUsBSdZYZEiLxwQNDpXGzahQMAAymYlhx7CyheVuGh4M45tssMCxJN77
K3UH3DoHX0s2YKDvPI16JF7e65WcN9JME+U8+Hihavmlh6xm9TYIq0r84ZCrE2DZ
/9rS/GIu/oIWWE8fyaGNnz7xDzpB3S0amu1jAwF0+I/txjbiwr7LPJguHv017nE5
Sgy2/SR5GbvS3GrqqBmKCFnrQe+geJ2u8fvBFxwuksPq+ZUdIUr73ptVHkEOwYoc
N1WDjxCHt5VPJVZtsIyIorzjuw2IWaZ+o8xu+jZfn0/pnYCvMKcJdk4bejFYO9nt
Bwd4YVcT
=Oq8+
-----END PGP SIGNATURE-----

--XvX33tbdsxjov8Dg--
