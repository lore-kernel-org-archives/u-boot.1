Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B55FC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDE987C83;
	Thu, 22 Feb 2024 14:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cdFlgP70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FDB88099; Thu, 22 Feb 2024 14:16:26 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2255D87C7F
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc6d24737d7so7114303276.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708607783; x=1709212583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j1cYw9wPbM4Agj9UEZT7gToB3eWDaCNrfzzaGUWTJ4k=;
 b=cdFlgP70bsdOHejRjjntB8jJ/hrSxEEyAxh/ys7S+hUgBImkgJoC0Cdxg/wCjhfzzF
 dpHzllYqFPBm04K+qw80MZSB96Qw1Co4bpZay/wfOGU8GT3X3wiXgf3rPl8htoOgmOZj
 fLnf2wco7PfWDwaBDWCm7uwe8kaseOUncmiVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708607783; x=1709212583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1cYw9wPbM4Agj9UEZT7gToB3eWDaCNrfzzaGUWTJ4k=;
 b=o7t6Cq0Sl4L50BhAAD7AAvKxNd7cY3qEmqC3xaSyTK2rRET789R0zA+D1ZhHPtpK31
 h1G+STTACX3d5nf3cHdXjv8fGnCH4xOaV3BE4cppHjjJ0c9y6Ekh0C5PzYhk6yRAVObv
 w8DAP0Uw37b3uGkeYBxDq8hRpUEMyqrb5ljL9Th7ueRgcPPtk2ExpVufFM5cDjyHkoOe
 t2gWPo3xAvCpD2ytylaznbAXQo5sUJCNGR+f1f7M36P4CaW/lfOBC5677ObGsojvAsLX
 BtLVXtS8RgdycFYwVD5iCPnkZ2XPF/kXMlOiDnkRBQbBYSYuTGyzuD4KvLUyOV0VyHkA
 znpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb6PNeyzqsP5u6SwrzOFsuKTS9kF9dP/YcneifkiwrC6GynxLnzjoelWCHQYpcF3zNkR08z7NT70JXILsvGKibXeMyyw==
X-Gm-Message-State: AOJu0YxqAqJUU8rd2kjUISHZjOO+GE/6cPS+n3/8i8SlFDz3GaqKbhgA
 4+mLF6INpP4U+0nQcBm6TT4H21gIz10nzln1HvZ+IhDInFHuTLAEdApOsmOpR9E=
X-Google-Smtp-Source: AGHT+IGEK8+IKS/D9JhCPIWXBQv9ty4dIbYpbL42dJ+LOlqxn94eJqOCKmolld93mjWB55grV9CZwQ==
X-Received: by 2002:a5b:f06:0:b0:dc6:8534:bb06 with SMTP id
 x6-20020a5b0f06000000b00dc68534bb06mr2296970ybr.17.1708607782814; 
 Thu, 22 Feb 2024 05:16:22 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r9-20020a5b06c9000000b00dc6c58ae000sm2730422ybq.16.2024.02.22.05.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:16:22 -0800 (PST)
Date: Thu, 22 Feb 2024 08:16:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: Enable CONFIG_64BIT for static analysis
Message-ID: <20240222131619.GV3040305@bill-the-cat>
References: <d156b6f6-429e-4c6c-b863-f8554480d74a@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wMCaUtDnQzjmx4SH"
Content-Disposition: inline
In-Reply-To: <d156b6f6-429e-4c6c-b863-f8554480d74a@moroto.mountain>
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


--wMCaUtDnQzjmx4SH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:47:58AM +0300, Dan Carpenter wrote:

> In the Makefile there is a line that says this:
>=20
>     # the checker needs the correct machine size
>     CHECKFLAGS +=3D $(if $(CONFIG_64BIT),-m64,-m32)
>=20
> So set CONFIG_64BIT so that we don't pass -m32 to the static checker.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  arch/arm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fde85dc0d537..4c7be7cf9c33 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,11 +1,15 @@
>  menu "ARM architecture"
>  	depends on ARM
> =20
> +config 64BIT
> +	bool
> +
>  config SYS_ARCH
>  	default "arm"
> =20
>  config ARM64
>  	bool
> +	select 64BIT
>  	select PHYS_64BIT
>  	select SYS_CACHE_SHIFT_6
>  	imply SPL_SEPARATE_BSS

That we have 'config 64BIT' in arch/{mips,riscv}/Kconfig as well is a
leftover of thinking this is like the Linux Kernel where there's no
top-level arch/Kconfig file, can you please move the two existing config
64BIT entries to arch/Kconfig and then select it for ARM64? Thanks.

--=20
Tom

--wMCaUtDnQzjmx4SH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXXSRwACgkQFHw5/5Y0
tyy3xwv8CkIayKyZIlQgDr0OyJT6+1+yef958D+o9JY4TSoGrcbloaxGVje7vw2Q
SCeBQkTknefNMxgaGj74/UPzao+wfXPCspdS+qhwTcb3deqeGdoByUPZV1W57dDY
KssnojIun34bLB2igMLyFIwEPyLdxgL0QUm2WV0N6JAgoBD9P+KGKMY5M4celbGT
VlGNvOFpUxoIypWMmTQFElNTGcotRVcABi8Ui20NE1J7LLV5frQlM8S0j/lDXZRS
wgOAVxVF8OZh6W0a+zXjo4fjPFJlcZ5kMGeEA7Pm9Fr4APVv/DAN6gcdIv5Rp/an
ajv58+tPD2eXUMdumSRHE5GfuPFENPOzxEIVm5FxwXkj/qitA0CIiJNESc4VKOtx
Mf/G+cBUlGVxS35X4zteijhhdJ/9O1pg/Vt2h78QMETl0w6KP0YD6cbY1DDfkhVx
tEcYloYSiN6iYegmFUjQsxgpOjIm9JIctMygwLKorW6AAyY4g+xSqb4l9ROYmkO8
WzE4H5Fe
=OmU6
-----END PGP SIGNATURE-----

--wMCaUtDnQzjmx4SH--
