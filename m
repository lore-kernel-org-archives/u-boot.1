Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6FFD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 20:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E5483D92;
	Mon,  1 Dec 2025 21:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZYLndrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C40A83D92; Mon,  1 Dec 2025 21:45:18 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7671D83D8B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 21:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45085a4ab72so2269437b6e.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 12:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764621915; x=1765226715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nWyRGlEkZWC26tt01iJOry2aUjjY92NXEQ3kv4Xhbv4=;
 b=uZYLndrtDn7+5XHrRcmipXV3+jDtVMbGQtYYIoHa7CLgFRS8YeDPdUbJ/HzvUNVfjL
 KXKfd+UwAPhGzKvQMCHI54o3ntZzDbfmlNGmzKe8x+ipPqfYkQ4/Fj/VEfkQTVuCJHM6
 G6+sGnLKoqeS1Iq1B727pkZmrAO2MyvqpZuGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621915; x=1765226715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWyRGlEkZWC26tt01iJOry2aUjjY92NXEQ3kv4Xhbv4=;
 b=BcjOuqH86fnbZWsGvtAVD36C4YHV+JlORt9F6q9gqk1p6RPxOcxj3NYPsXkbFHHchZ
 MTBM5vLF8dkfuxevfJ11lsEH6z6F1hXpH8nAZhZdXgnil/X8hJa8BYaFPOMFmLodHsN0
 1HWp7v7mkv2PywOmYlNLV99w9UZci1L8WOpffXHt+Y8H21MZyiQnaHEZFoqGirRJCRdC
 yMtG0GnnRacCf/c5/8IHDFSN/sDh2r9NCQQ2HyiLalrQQdEWjLv/GhmYy59PDwxk33ze
 3b/IEk68WUJ2/uQFf5ze/9TcOsY+86TFHH0wV/oN71iy8aAmvwhwVXK3CHS6XhsTM1um
 CK0Q==
X-Gm-Message-State: AOJu0YyttKhJJ5yXa/+QpbKjsUkENwdGW+5tkv/tCeuiKHkDawbt9pyU
 mhgWDrBNrGKsV49tZbhEBNW8pwnqh0fLISrN+7bNaniYs8G9OCyKfi1/RrBtXdrhjdUSP/V3gMT
 8aff/kiU=
X-Gm-Gg: ASbGncvF1Ew+auCAAhZCQ6+h1N8otXUJT/Hk7xoD3cpWBV+OewD8G1p8KrGirQA23eq
 PIMWM+xnaOwom4poRz8wdefi+EmZ4FCZ+/GaA85v6xI7CuXMV0MXuy38pJx29GQznJTLUJbM3Wt
 9HKMauKJajmNZ5UztcMcHoHx15IeCmvwYXYO0pZ7LXqeAkVHMvNy0yDpRQ8iy8jMf3lRmAXI94A
 t46B83FaN7XVwwokqBNk/NvCGJc5nq28MUvaUeEphs5vh5YMwoOIHrkp1VkdSDYE9iE6xjKhUKh
 jaV8ECnVxbLDajoU97p+zwACbasvGtw5c/1bb+0EO/OH9JLN41hwIhNVdE2w8pXWCiztKiv5S8n
 sID9S6vv3eLbDN7qOzO/RX2pilxuTYk/POWusOMAR5hrRhRuBZv2sZsA48yrLDxfbzRJ4aMG4zd
 LhBohcJZE76EhOda1Vnhf0lZqdSDtUeEXOGANnmt440jr8RNx3sw==
X-Google-Smtp-Source: AGHT+IHIOIljkA+psN0kjXERZGdAGCmUAh6ZF3kkslyyfUyYhvtP2GN9F5eaQbTTXouBYidoiJ67xA==
X-Received: by 2002:a05:6808:1a27:b0:437:dade:463f with SMTP id
 5614622812f47-4514e7a233amr13146097b6e.34.1764621915197; 
 Mon, 01 Dec 2025 12:45:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933cedba1sm2918787eaf.14.2025.12.01.12.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 12:45:14 -0800 (PST)
Date: Mon, 1 Dec 2025 14:45:12 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot/image-fit.c: Restore building tools on macOS
Message-ID: <20251201204512.GZ303283@bill-the-cat>
References: <20251201174038.2246180-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="szJJrjjHWrsPrGJI"
Content-Disposition: inline
In-Reply-To: <20251201174038.2246180-1-trini@konsulko.com>
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


--szJJrjjHWrsPrGJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 11:40:38AM -0600, Tom Rini wrote:

> The ordering of headers in this file doesn't follow our rules exactly
> because this file ends up being included when building host tools and so
> has to be correct for host include paths and ordering as well. We need
> to have <malloc.h> higher in the file or macOS will fail to build due to
> declaration problems.
>=20
> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned addres=
s")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>  boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index cccaa48f6839..3f66bec49041 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -23,6 +23,7 @@
>  #include <log.h>
>  #include <mapmem.h>
>  #include <asm/io.h>
> +#include <malloc.h>
>  #include <memalign.h>
>  #include <asm/global_data.h>
>  #ifdef CONFIG_DM_HASH
> @@ -35,7 +36,6 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include <bootm.h>
>  #include <image.h>
>  #include <bootstage.h>
> -#include <malloc.h>
>  #include <upl.h>
>  #include <u-boot/crc.h>

Well, this blows up *everywhere* and so is wrong. I'll figure out
something or another for a v2.

--=20
Tom

--szJJrjjHWrsPrGJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3+VAAKCRAr4qD1Cr/k
Cv0+AP9UFfURTG0JzgI5wnUzxgjYbuRlBbFahwqHZacAL26eiQD9GhwcXEvuVDQA
dQfxI3XgyxmINIuU1fDEmQUE8LYgqQQ=
=eyzu
-----END PGP SIGNATURE-----

--szJJrjjHWrsPrGJI--
