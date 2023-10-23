Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5525FC25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCF2878B3;
	Mon, 23 Oct 2023 19:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XIMbHGtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E53787915; Mon, 23 Oct 2023 19:03:07 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D85878B3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7af45084eso33723207b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080581; x=1698685381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7O0EuxUswQpYZ54AKc+C6V4i/slLdCi3BtswtgZABO0=;
 b=XIMbHGtm4xIm2Z+e0/UfkSgnmWV6ktJW2yePY99UVubbPjeOv1aIL3Nkoa7OgnyAg2
 RUPIwDYwSN1UZR8/hI5opHcdzzlC2cRveB3Q2xH4a9kZ7vgVrgyJtrFUV6+zypLg6/0C
 bUk8JvVrWnSRRmNvIm1hzm3Qxk+i6Rz+QcnCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080581; x=1698685381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0EuxUswQpYZ54AKc+C6V4i/slLdCi3BtswtgZABO0=;
 b=Z9ZA3X3xfpd+iZ55AEXf9/2zvHfQ8CDjYRx4dXUSEXTLyDiQeGP2jQj3o6bkYVzCjL
 gMHe1XegWM5W3cnjWrhK1Wlgs3uiOprdX+GSNBIj3201lAZkqY5GTmZZcy59H4CIX5+v
 2tgu7WPbRVTFFcNiGshS9atJRDNwUxabxB7rSCoiU3vEFbKhXeL942+cJMAOdnLah7Td
 To/Z8vs8GFEIpy9j/tYSfdwl78vRqFdNH6NN3O+P9ebiT2absGcwOfkKxHuab5Ksb5k2
 Oeco0UhpOoK0Jhtvim8gaDMFVh9hyexjP0XuEcR/ep7MVZblOognGTNr9bnOJmZrv/Sg
 97/g==
X-Gm-Message-State: AOJu0YzxJXxJyfV2/oD5HBufekqD1yZGBus2WzlV/+LFT8dq0NWsivJg
 scLdhU9MeRVGQu6CJPuhoznuApRVFqKXemGVqqMucw==
X-Google-Smtp-Source: AGHT+IHd/cVSZUaHEpDSfxkybG+VXsr8OmSMmCy6kkwjD8W8cLhtOr5hXPSQEL5+2iJg4bHYzXgJkA==
X-Received: by 2002:a81:4f0c:0:b0:5a8:181e:8d6c with SMTP id
 d12-20020a814f0c000000b005a8181e8d6cmr8558363ywb.10.1698080580978; 
 Mon, 23 Oct 2023 10:03:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 z63-20020a0dd742000000b0059be6a5fcffsm3322475ywd.44.2023.10.23.10.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 10:03:00 -0700 (PDT)
Date: Mon, 23 Oct 2023 13:02:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] sandbox: eliminate unused functions from binaries
Message-ID: <20231023170258.GT496310@bill-the-cat>
References: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AHarrugZKn6p5nAQ"
Content-Disposition: inline
In-Reply-To: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
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


--AHarrugZKn6p5nAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 01:37:27AM +0200, Heinrich Schuchardt wrote:
> The sandbox should closely mimic other architectures.
>=20
> Place each function or data in a separate section and let the linker
> eliminate unused ones. This will reduce the binary size.
>=20
> In the linker script mark that u_boot_sandbox_getopt are to be kept.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	mark _u_boot_sandbox_getopt secitons a KEEP()
> ---
>  arch/sandbox/config.mk      | 4 +++-
>  arch/sandbox/cpu/u-boot.lds | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> index 2d184c5f65..c02f0229c2 100644
> --- a/arch/sandbox/config.mk
> +++ b/arch/sandbox/config.mk
> @@ -2,7 +2,7 @@
>  # Copyright (c) 2011 The Chromium OS Authors.
> =20
>  PLATFORM_CPPFLAGS +=3D -D__SANDBOX__ -U_FORTIFY_SOURCE
> -PLATFORM_CPPFLAGS +=3D -fPIC
> +PLATFORM_CPPFLAGS +=3D -fPIC -ffunction-sections -fdata-sections
>  PLATFORM_LIBS +=3D -lrt
>  SDL_CONFIG ?=3D sdl2-config
> =20
> @@ -26,6 +26,7 @@ cmd_u-boot__ =3D $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot=
-init) \
>  	$(KBUILD_LDFLAGS:%=3D-Wl,%) \
>  	$(SANITIZERS) \
>  	$(LTO_FINAL_LDFLAGS) \
> +	-Wl,--gc-section \
>  	-Wl,--whole-archive \
>  		$(u-boot-main) \
>  		$(u-boot-keep-syms-lto) \
> @@ -37,6 +38,7 @@ cmd_u-boot-spl =3D (cd $(obj) && $(CC) -o $(SPL_BIN) -W=
l,-T u-boot-spl.lds \
>  	$(SANITIZERS) \
>  	$(LTO_FINAL_LDFLAGS) \
>  	$(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
> +	-Wl,--gc-section \
>  	-Wl,--whole-archive \
>  		$(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
>  		$(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \

There's already a call to --gc-sections for u-boot-spl on sandbox (in
the last line of the link command).  We should probably move the main
u-boot call there too, for consistency.

--=20
Tom

--AHarrugZKn6p5nAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2p0IACgkQFHw5/5Y0
tywR/gv9ESKeBERI4qg6iAG0vsy96dW1d8bpfjSpiMEYOLrSwHwV4fefJX7yvHgx
aI0laizMmDyIEhomPb5XonP1UuM4JCvdnTA36z0MXbLDtJVqBOua2HuZhfcJ1GyN
kP+slatYeSkkpt/qaXa5BFLEPit+fOfdtfaXvwLNdhz9TC3dekN7k3VnIMidYG8W
nPbT82sCMVxG+u1Y0AHce/xMJpsWZimsCwbCN86ZY/ln9xYW9a/i1pdfGbEWE0yO
yVtn2przBnxGK9Z1DdSdFpVBMcA9NHeWBVEQXYa6JEMDIh21L/ljniHK1HW8koDz
G436LXk+gXSyjA/Z6Vieho00Lpt2TJ2NInIj827h6ULJVij+ElZh2Kgp+4bVAbaT
AAiyDwe5ecycghiCWuvkU4LdT8Uk8iQpCoBBBiYVybCKS2va6JSFC3SXXJtO4D+Q
fEt5yJ1UJ3QAGqUFyTJvLJrIlVpreGl4AmSfq56TtPaaoW78kz5Vm2hgRaoJSGrT
T/KZPpKG
=yLvF
-----END PGP SIGNATURE-----

--AHarrugZKn6p5nAQ--
