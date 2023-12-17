Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1744AC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 18:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263ED87D42;
	Sun, 17 Dec 2023 19:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cMWR7kpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C680487D3A; Sun, 17 Dec 2023 19:41:16 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BAD87D34
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 19:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5df49931b4eso17158037b3.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702838473; x=1703443273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nou3vAKJn3YoQS92MhifJbQERe/ApRpEl5l75nJUR4M=;
 b=cMWR7kpu6VSNUNh7oxr0gKfOQKTU4X408E+DN/AGVZTuFMHO/vuRTlZ0L5TbUMvlvN
 FMTTwlnvgUqCEOJFr7D0vJbfonvb1Scneo+s8860SoMIlTBD7sPsoFlAMTEN8qUk4UbI
 PcEK6jelNCWaLXsgZuavrpQnrcrt8u1oRoHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702838473; x=1703443273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nou3vAKJn3YoQS92MhifJbQERe/ApRpEl5l75nJUR4M=;
 b=EOmLhMy6U6CtLbywfNi5v1xabF+KG8BeuF2Z8uMrpZwHbSN4UNzDZP6SnRgTa5Rbld
 SpvO8z1OKYi+El09WHBnvIc17/ZX6yK+3XBKLXedntVg25D9CAUeBxkHUxX8TO5j61SZ
 zl9OB5gtaUZdFxkViwh3UX6Gis7/EICIfY6lM+Le0LbGR8J0I+9fBDnLAXjVCZSZgyVc
 Qqa77CtmHwIGZ79yLjEAZdrKDjxcEMSL8gC/HtvdUt1uSrVVLL8OTM3JHHP+k8WeizO8
 q9xra+94B5Rqvo40ctEQkulZR8yIkw4IoYiJBekAiu/9yIStfDF6IL3NTE67eEMTasQE
 bkow==
X-Gm-Message-State: AOJu0YzifjH9wPA2Rwa5RVqcei/0Wb7UWvpVKdvvj4B1tfZgx7wAAoOk
 eq8Gux1CcD19bD5b2l29LYb9Bg==
X-Google-Smtp-Source: AGHT+IFpY4Oic6Q4Ceeb1+m02XjBt0FJQz143Fi9BVTERKRusW7BZzRS0PuKzF2MHq7ZtfWlt8+fxw==
X-Received: by 2002:a81:df06:0:b0:5d4:b7a:ebfc with SMTP id
 c6-20020a81df06000000b005d40b7aebfcmr12328826ywn.22.1702838473131; 
 Sun, 17 Dec 2023 10:41:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c7d6-a760-1f4b-e321.res6.spectrum.com.
 [2603:6081:7b00:6400:c7d6:a760:1f4b:e321])
 by smtp.gmail.com with ESMTPSA id
 p135-20020a25d88d000000b00dbccd3a2d02sm3756208ybg.55.2023.12.17.10.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 10:41:12 -0800 (PST)
Date: Sun, 17 Dec 2023 13:41:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 10/10] Makefile: Use the fdtgrep -u flag
Message-ID: <20231217184110.GE2513409@bill-the-cat>
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+MoG8WGCPtFOgo0E"
Content-Disposition: inline
In-Reply-To: <20231217163627.2339802-11-sjg@chromium.org>
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


--+MoG8WGCPtFOgo0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 09:36:23AM -0700, Simon Glass wrote:
> Use this flag so that the bootph binding is obeyed correctly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12

First of all, yay, this will I believe unblock upstreaming of these
properties.

> ---
>=20
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 8dc6ec82cd56..21b1f7daa72c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -631,7 +631,7 @@ fdtgrep_props :=3D -b bootph-all -b bootph-pre-ram $(=
migrate_spl)
>  endif
>  endif
>  quiet_cmd_fdtgrep =3D FDTGREP $@
> -      cmd_fdtgrep =3D $(objtree)/tools/fdtgrep $(fdtgrep_props) -RT $< \
> +      cmd_fdtgrep =3D $(objtree)/tools/fdtgrep $(fdtgrep_props) -u -RT $=
< \
>  		-n /chosen -n /config -O dtb | \
>  	$(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
>  		-P bootph-all -P bootph-pre-ram -P bootph-pre-sram \

Maybe we need to expand / add some comment here? In practice right now
I don't think we have an issue in that say "keep-power-in-suspend" is
already not being included in these special subset trees, but we want to
I think at least make it clear for future users what unexpected things
might happen.

--=20
Tom

--+MoG8WGCPtFOgo0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV/QMYACgkQFHw5/5Y0
tyyBPQv8DB6D4JLeyz6VISKMM3bGS1oVJ90mqIdfnJkBMToVgpmLJYXacFfMt2JT
lcgIyQ36DNqyopu7pnYkEknz1yt9sKrHZRrXFpSK4YzxFgNFf/heyEmGHiqob/+P
p6Rfeui1yPS4sVNUMCITNThRR1WAbDmkSgTjAYAr2d3Itt5EBsd/w01lTv6KeFd3
Ibnt+zyGsVdQst9GUmOK7LzAr94V2VPYXl5Qlez9nHfwv+XFWADaAGMQ7odkqTrx
Iq5gvS5wjnaFbO5YcufwIJ66Cp8zweS51do+kGwBMmIMwOJxmVsFPOFNFBteRdJE
fXhSEowj3vm0nbJTLP06bx3+d35jto5VYXMQfTyHb37lZA0Zb7flkZ9BjcXqfwkj
bjyi+cIO3OJ1NMWee3K1hSrZT/9I4wwwkB2J8FF+4IS+H68dGnuZZIf5yEQs6QTu
F2xZDu9MZSb8hXF/MszBAzdGVevX0jpGmUoBkyDlt5HaAkZIZZfOBAannjFWxzK8
1wJiAfMd
=6bxA
-----END PGP SIGNATURE-----

--+MoG8WGCPtFOgo0E--
