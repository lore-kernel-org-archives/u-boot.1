Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D5CCD8C8F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 15:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3494483EE4;
	Thu, 13 Nov 2025 16:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UW4tbI2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A5783F8A; Thu, 13 Nov 2025 16:49:08 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B849B83E76
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 16:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-656b7f02b56so432992eaf.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763048944; x=1763653744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RfJ3xbPnhq1wS8mJGGfF7LKsofCUfU3SgTIwEg5k1CQ=;
 b=UW4tbI2zaEzhgmfu6zhm7ckVjITlS1hr7ecuKLJEbVc4japX4bw/2qtIdIe6R0e+Jd
 3i3mX2ehp7IuGJVvg/qpB9KJF4PzDxFq52g6mezl007VmCbjCEQg1IRbOxmMWqfxzNsZ
 SyvjfRU2B7BxQqLFydbf83PHrTEQfeeSrYtHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763048944; x=1763653744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfJ3xbPnhq1wS8mJGGfF7LKsofCUfU3SgTIwEg5k1CQ=;
 b=ZvKRhPIBaj+0t7uQ44VACvJq8Uw9OoirH36SjUAQE9hgC/sXqjSq2VSeUr3Wi8AT5H
 BlOoiztkwKrkfbxS/E9GOesjEUTYxvNsisI5MeV8WBPJX4n/hRxtpg4NSzTyCmsuIWYS
 QrAcIPVldDZ2RihtzCoNXdm8xjUn4jLu9p7QVhbHlJZx8qCcvlkciU1jzVj6zfaW5H75
 +u2SRm9r/X7Ol8ISvUfCEFH2XZt/DAeBGlI2LV78q5xmF1u4amMGkfpIy790T5nnuM1+
 Zrw/ldiFys12o2BJdZu3LzYvZs0y/zYvoGoiWqzIH+KYYdc1hd24UGLZ/iBzgR5yP/XM
 kQJg==
X-Gm-Message-State: AOJu0YzzTtoWTuc64oqHX3MZrfp2wK+jZpnf2WaDmgR/wN5EYCXr1fuR
 k+rIltuynxByf8ysiu08CFo+ECdxLL6qCSyVyd3SEwkk9Uf4jktFjyTo5xIZPaU+RSA=
X-Gm-Gg: ASbGncsdy+YrYEg3pfm38f5zPhKD/UikNVJG24rnIRfL3OgzArR+Dbdo2QQAGIRebII
 n+MDnamVKvedkf3Ahy1U5PFVg15xXExGQ8WgxAIG5pBi1yJp0l/CtZCgaalJ9LkXX4Z2837THiD
 Utst70dRwRfAPwGqjg94rOwQi/WZ9d/oLyrytGmJKhNLueeC9ns+MpS/KrTxiIJUtp+Tgq+vhDq
 CNSIdXCXQFJkwIDsq94YZyI8eV8vxYrSotfUQ2THnz95I/9lbGSqZ9pvxbHkHJTp099yEa6zssj
 2LQYNUwBZLoLr4O+x8ZhntC7XND8ktKIFiTtT9NSBPL8avVHZXwB7WXfTS0ZTDiTtokOCJbtzXN
 zO/ZuTSeBnQwv1s7KU3+QpM9WhDQopqE2ElHg2lPY1gaq3c6ipUztrxEEFjKQSXKleER4fzIcJ0
 AjMLZ4XKU/vAlkmyY5t4qAwYlfCXHU1jrTkspEQV8=
X-Google-Smtp-Source: AGHT+IGzV9Cl1QXLabN+UEQIEQWjNTgj8qaKN7IRm9qB9U01WzZJ4ZLw6rxpbYxGRZLIv/BJclxT1Q==
X-Received: by 2002:a05:6808:3186:b0:44d:c2fb:c0c with SMTP id
 5614622812f47-45095e5c57bmr21182b6e.31.1763048944376; 
 Thu, 13 Nov 2025 07:49:04 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6fc12asm1122377b6e.24.2025.11.13.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:49:03 -0800 (PST)
Date: Thu, 13 Nov 2025 09:49:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
Message-ID: <20251113154900.GJ6688@bill-the-cat>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ii8Laf30D8xO5q8D"
Content-Disposition: inline
In-Reply-To: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
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


--Ii8Laf30D8xO5q8D
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 03:29:51PM +0100, Marek Vasut wrote:

> In case the 'fdt_high' environment variable is set to ~0 and DT is
> at non-8-byte aligned offset, warn users about the dangers of the
> fdt_high usage. This will hopefully lead to removal of most of the
> fdt_high ~0 usage over time.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Jo=E3o Paulo Gon=E7alves" <joao.goncalves@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  boot/image-fdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 3f0ac54f76f..e88525a3846 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of=
_size)
>  			/* All ones means use fdt in place */
>  			of_start =3D fdt_blob;
>  			addr =3D map_to_sysmem(fdt_blob);
> +			if (addr & 7) {
> +				printf("WARNING: The 'fdt_high' environment variable is set to ~0 an=
d DT is at non-8-byte aligned address.\nWARNING: This system will likely fa=
il to boot. Unset 'fdt_high' environment variable and submit fix upstream.\=
n");
> +			}
> +
>  			err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
>  					    of_len, LMB_NONE);
>  			if (err) {

I think we need to yell about it sooner. Today (and for quite some
years) if you pass a 4 byte and not 8 byte aligned DT to Linux, it fails
to boot or breaks in loud and odd ways. This has in turn lead to much
time spent and some of our older threads with the libfdt folks years
ago. So I think we need something earlier in code where we're seeing
that fdt_high is set to ~0 and that's where we say "Stop doing this, it
will be removed soon". Historically it was either used to work-around
problems that don't exist anymore, or as a misguided boot time
optimization (this is different from disabling initrd relocation, which
can be noticeable).

--=20
Tom

--Ii8Laf30D8xO5q8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRX96QAKCRAr4qD1Cr/k
Cn6EAP0Z81v5ASwJwLhPquVw+/TBUr5vcY9AEgHDwQKeMY/T5gEAzCIpVv9vt6bZ
0WNSja91OKrDDouSePT01pmvYbbQ+Ak=
=0wGx
-----END PGP SIGNATURE-----

--Ii8Laf30D8xO5q8D--
