Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31200C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543CF86978;
	Mon, 14 Aug 2023 17:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rVUW2zEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5F486978; Mon, 14 Aug 2023 17:04:30 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51CF86967
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-584034c706dso49380237b3.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025467; x=1692630267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sNF//gNazr2ju55d384NeSWKL9s9NyMPG9RiPFU+M/4=;
 b=rVUW2zEEWy3IXiFFdWrmzGCHLVPHsmCm+zdGUVsGPK+3z/J5K3AgTzM2PbfWXXsn6d
 JEGtI15M9xkUpiTxRFf7U13S1w5HQ4etIuFgsp55uanW8Cre8XjuLRTitkyDcZmvoG6q
 iEQsMc/Y/GdkSJ+dPUw9O3n+U2U+yVljyIRYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025467; x=1692630267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNF//gNazr2ju55d384NeSWKL9s9NyMPG9RiPFU+M/4=;
 b=AnWtun9INUnLH3znt6rbFgXR+YMKpa6apP3L7xPOMEn+YRvlzRAOofVIX2E+dIUlGA
 TL5qqY+VCynR3vbWyYIcCcFm6UnA9xuqC6MDmyW260jhB/9+wurgpWla3zY9WM45tRbB
 I83ZbdwGCg6BkVGe/hv+mbb2RLuYDHb1WjStwusqFlyoID6i4eWdDLXJG3uz+xUDpn9Y
 0TYENkxMfvhGwjEaHISYqBUzpS9lCGEiWr0JrkdEzVo4PPRUWsSvVS9XkCCX5laYiCGs
 kb4HcLxIrNWYv6PzNqEOW5c41oXhghf3vt4kDhyp1oYbBiniT+4/u2+DogWnJXyBP7Qh
 NLyA==
X-Gm-Message-State: AOJu0Yxfw3x8s06rCePSTrUY+GHRzyJxHZ85DiKv1rCOnFzNwgaLRQUC
 PvAX/vY43VuftOK4eSeyr3CNzw==
X-Google-Smtp-Source: AGHT+IE4ZRvFiOwDW/BVJD4ZNFquwAYOEQRSzxewLMzgg94b23JzwWxXQSTM/+oTKedeSNz+NHHTWQ==
X-Received: by 2002:a0d:ca55:0:b0:589:a4c6:a4ed with SMTP id
 m82-20020a0dca55000000b00589a4c6a4edmr10295246ywd.3.1692025467639; 
 Mon, 14 Aug 2023 08:04:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 n186-20020a8172c3000000b0058605521e6esm2822378ywc.125.2023.08.14.08.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:27 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [RFC PATCH 1/4] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
Message-ID: <20230814150425.GW3630934@bill-the-cat>
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-2-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z1qt0p38z9BTPrXp"
Content-Disposition: inline
In-Reply-To: <20230814090309.1548310-2-sughosh.ganu@linaro.org>
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


--z1qt0p38z9BTPrXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 02:33:06PM +0530, Sughosh Ganu wrote:

> At the time of building a device-tree file, all the *u-boot.dtsi files
> are looked for, in a particular order, and the first file found is
> included. Then, the list of files specified in the
> CONFIG_DEVICE_TREE_INCLUDES symbol are included.
>=20
> Combine these files that are to be included into a variable, and then
> include all these files in one go.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  scripts/Makefile.lib | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index f5ab7af0f4..f41b16781d 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -179,10 +179,13 @@ ifdef DEVICE_TREE_DEBUG
>  u_boot_dtsi_options_debug =3D $(warning $(u_boot_dtsi_options_raw))
>  endif
> =20
> -# We use the first match
> -u_boot_dtsi =3D $(strip $(u_boot_dtsi_options_debug) \
> +# We use the first match to be included
> +include_files =3D $(strip $(u_boot_dtsi_options_debug) \
>  	$(notdir $(firstword $(u_boot_dtsi_options))))
> =20
> +# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
> +include_files +=3D $(CONFIG_DEVICE_TREE_INCLUDES)

This is what I wanted, logic-wise, but I think include_files is too
vague.

--=20
Tom

--z1qt0p38z9BTPrXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQnkACgkQFHw5/5Y0
tyzRbgv+IO3o3PoMhV4z7CizuQEfscJuWdWewjK/LrIyvykopmwTbUX7RUxqRrxf
sj0Z4HHsxqxbxRZAPTx1vjGaSuYSKxVA3biSzqGrSaOMY+Z3cwW4MzekxLq8idCl
IvnvcD8zWBXWJnglNDXthQa8tvxoIv9hq2jhG0O0IZk7LvX3rWoNWEMkF/yAGylb
sbgbTOSzd2vZSG3xi5bADei+sqrkJzaJ/FB1BvKPHU6FGdxRtUbgmeJMvRCF+/Jk
8JU/gODQFnxItxyQI+1FgAFQw00tq9wqvLZffcmKE2Iw8JxbqLpjwTbFVVAntHy5
gpYlWoex3nsEZospLJnSO5QNQOS8CTPP5lzskydgnTpNSluybvV72/tJLPeJN6nt
ND2Zu1keJi82SAzYBhFGopxwDoeDjsW5oKsMrga8H/jPwEIv80I3NplQWiw96NsQ
IZ0jvno7C6brgngbuX+6gZ735OCBoXqMve0GMaLFgEeeGnhGgLDw/nG/gI4JU57U
IWvnikGi
=10p6
-----END PGP SIGNATURE-----

--z1qt0p38z9BTPrXp--
