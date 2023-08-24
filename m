Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79A8C71153
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61424846DF;
	Thu, 24 Aug 2023 16:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NuVahROB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C377865AD; Thu, 24 Aug 2023 16:26:38 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D919280844
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d77b9d574f8so1822588276.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692887194; x=1693491994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VQNqOy7JjyOkISrUVePktn0WZBS/R2iVFJKU+tgkSS8=;
 b=NuVahROB2F7yeeya31tdHgSdnJVnpB08GcXqg+uCIkFw0QeCHn7G7Aug1+YhZcFtui
 WStz8NfzeGdBFsi/yXof0qGLEdAX559it8umiFN6c6xH6Ta+c3rgFwa0ngx2z8TQ59BS
 fpyHqSkEpx4n8uEHGmyYF1VVQZmQOeg/rFB7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692887194; x=1693491994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQNqOy7JjyOkISrUVePktn0WZBS/R2iVFJKU+tgkSS8=;
 b=EpWJ0I1PSkXa7fE4Ui8EhsuTqfPMr+daxwmHA+DvMiNchClYaLmkvQn5anpWFqTCnS
 VQlmP/B2ZziTNC86E1yPEkoDga/1zVrAczkr3WJU236y2Wp9mmnNCwNxN85ATRXNG2zX
 LkNqUbXfBEKtnWOxdPXprrTNYpLHgPpgapooj9iTkLzJgG2DsvbVuYh5w+7VaClX/bhJ
 rOsjDTObMgQ/dOZjIhH1HEacuxunllSctFbH2k9PF59hGel9qBnIEtRrksgWSxxeYO3o
 1GEfjd7wyrPy6pbH3/6Et4/jWYjTFnCdH3G/6x9D+gvmXWJWRTZKroKGuwaDDXkRC6Y8
 d1Nw==
X-Gm-Message-State: AOJu0Yw5LWTf/AmV8yshzFZZygphq6hgCe8yz2pWkIzkOBwiIaKD0KBF
 j4KIFWvZ/46bPCA1sPbBpbR+UA==
X-Google-Smtp-Source: AGHT+IGucAaS4q40D+7eK/uFAwm8f7GxIDul35Dacuu5+CXlVx6dLQlq7jPNdx4GnMb2RTVhsx/fXA==
X-Received: by 2002:a25:6412:0:b0:d77:a0a5:e1a3 with SMTP id
 y18-20020a256412000000b00d77a0a5e1a3mr6321207ybb.33.1692887194604; 
 Thu, 24 Aug 2023 07:26:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a5b0d47000000b00d0bad22d652sm3178284ybr.36.2023.08.24.07.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:26:34 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:26:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/6] buildman: Keep all permitted output files
Message-ID: <20230824142632.GN3953269@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CGSRPvpfxH8wW1fU"
Content-Disposition: inline
In-Reply-To: <20230824030304.1555547-3-sjg@chromium.org>
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


--CGSRPvpfxH8wW1fU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:02:55PM -0600, Simon Glass wrote:

> Now that we have a list of permitted output extensions, use it to ensure
> that the -k option preserves all of these.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
>  tools/buildman/builderthread.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthre=
ad.py
> index 25f460c207db..d8374e68eb7f 100644
> --- a/tools/buildman/builderthread.py
> +++ b/tools/buildman/builderthread.py
> @@ -23,6 +23,9 @@ from u_boot_pylib import command
>  RETURN_CODE_RETRY =3D -1
>  BASE_ELF_FILENAMES =3D ['u-boot', 'spl/u-boot-spl', 'tpl/u-boot-tpl']
> =20
> +# Extensions allowed for images (keep in sync with binman/image.py, READ=
ME.md)
> +ALLOWED_EXTS =3D ['.bin', '.rom', '.itb', '.img']
> +
>  def mkdir(dirname, parents=3DFalse):
>      """Make a directory if it doesn't already exist.
> =20
> @@ -636,10 +639,10 @@ class BuilderThread(threading.Thread):
> =20
>              # Now write the actual build output
>              if keep_outputs:
> -                copy_files(
> -                    result.out_dir, build_dir, '',
> -                    ['u-boot*', '*.bin', '*.map', '*.img', 'MLO', 'SPL',
> -                     'include/autoconf.mk', 'spl/u-boot-spl*'])
> +                to_copy =3D ['u-boot*', '*.map', 'MLO', 'SPL',
> +                           'include/autoconf.mk', 'spl/u-boot-spl*']
> +                to_copy +=3D [f'*{ext}' for ext in ALLOWED_EXTS]
> +                copy_files(result.out_dir, build_dir, '', to_copy)
> =20
>      def _send_result(self, result):
>          """Send a result to the builder for processing

The alternative here is to just add to the list "*.stm32" and
"*_unsigned", and move along.  We already have other special cases here,
of "MLO" and I guess "SPL" too.  And of course there's many other things
being caught with "u-boot*" such as ".imx".

--=20
Tom

--CGSRPvpfxH8wW1fU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnaJgACgkQFHw5/5Y0
tyzUrwwArgHiBUizgfrPP11YFr02l5d5lZtIzIa9CilWhYF2svGkE3DZH7DsVhdh
vBs+64fZ7MUwqHR9P5rAvYWE5AoX8s0AZlCSWWkxiDMifbmE/GHS91DvV5WXgppE
54gbplE9pufcmiYLmUwuvh4XK6PGebT2iIrievCdoYSxtA8UIIFHYDOhq3yyT+D5
JBr7B+Yg9SeMTO6lyYX/YHFa5qbUxD/CmbNFxo0i8Xet6MYcuTUEogqDtjuTqbnB
UjVrjlUIQKtGMAl00Tl6/lU2XsLhDq3Nyk1g/f0y9e0wf6WOkK+sJP1WmXWRTMFj
EUyOcTRuY+Lr+vBtX29A5wg7XBiPIu4UNG1eIXbQb0pa0W++0Tkp/I+FU/mHFQaN
2y+SXXCstm+9bYULx0xGuXN3nyziyY4eyIfs66IZNAOPojRWTVUUrg9U04Fu4uhn
uVTwGQGhNkHOq9Zkgg1MYEz0Yri78KR2MFp4lPCsRBjKdb8tC4q9SrrJW/uGe4IY
vL30KXQF
=cO8w
-----END PGP SIGNATURE-----

--CGSRPvpfxH8wW1fU--
