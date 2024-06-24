Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEBEC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 18:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA0D883CD;
	Mon, 24 Jun 2024 20:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QD9wvUW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A2F88387; Mon, 24 Jun 2024 20:29:37 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5F588119
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 20:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f95be3d4c4so2009993a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719253774; x=1719858574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XEpJNSiKhnbKf18HLcqTDABeu83BeFMVHlmBqld9hfA=;
 b=QD9wvUW9kwLHpwDeaJlLOUxpjHwwjhwVpIlxs0H83AujqtX9NjjwwoFSPQLHQIaHTI
 tCH/paqZjTdmQVwNIzY3WM/GWXexfkc6NaZ8ftvSPoL2YH4B/1MqzdMwd0AT/4bNVNKH
 VZkIwUR7KdwgJzufavYl0UdGaPMzFwiylxBmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719253774; x=1719858574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEpJNSiKhnbKf18HLcqTDABeu83BeFMVHlmBqld9hfA=;
 b=VVhiTrm+2mq5+jP6eqHd+nwBOvTNl2NNhDLq+O7f+8NUsrEuiYEUvd6dOozBOV4rLP
 dQxEqjph+fCyMNAx/fnMO6LNWdg3+spe59cTpNaQfvdi+US9BZmiwWkGiaQqdiK+M1ZA
 MKSD1OfdKcamnNOjVhPRqU4wKI0Qztnmjb9s2SEvV/JTUyFs2xr+4LgJO1aul0se8+WD
 UuqYMURotQa8CkJUTmWNjqKEQCnsGFoYqBtkez46tPvX2Zeslye6e8WvKIkKISDb4Q72
 NyLYzhUnIWwhqIlEWLFqhSTtg73f9UngHi/SOOT3eVQIlL5Kt3R5RCerCR16g+oqwO3F
 1K/g==
X-Gm-Message-State: AOJu0YzCbwWRkm2hV4u7WpbNdT7pvOVXZhTFH16jQfNIPtrFqrEip3BG
 h/+WUtqsRNjV7NHNHdUQIzYhmEKXy9jEvLrlBwjxE8Nf+AYcqtDPcYx9PwtlOkeo/nLLof86Hgx
 k4gI=
X-Google-Smtp-Source: AGHT+IFrpbi8fM0tlsck9jjTRCyzUSfeDUiRSydDITyCuxg0UDTzG1a6sV+pFV0hTidXMjG1eP+lyg==
X-Received: by 2002:a9d:7348:0:b0:6fa:18e8:4446 with SMTP id
 46e09a7af769-700b11882afmr6136689a34.8.1719253773711; 
 Mon, 24 Jun 2024 11:29:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c5f591esm1282690a34.27.2024.06.24.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:29:33 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:29:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240624182931.GI38804@bill-the-cat>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/v+5Uh0lKWtWNJj3"
Content-Disposition: inline
In-Reply-To: <20240623203033.1566505-14-sjg@chromium.org>
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


--/v+5Uh0lKWtWNJj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:

> Some configuration is now in variables with a CFG_ prefix. Add these to
> the .cfg file so that we can see everything in one place. Sort the
> options so they are easier to find and compare.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add new patch to update u-boot.cfg with CFG_... options
>=20
>  scripts/Makefile.autoconf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> index b42f9b525fe..65ff11ea508 100644
> --- a/scripts/Makefile.autoconf
> +++ b/scripts/Makefile.autoconf
> @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
>  quiet_cmd_u_boot_cfg =3D CFG     $@
>        cmd_u_boot_cfg =3D \
>  	$(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> -		grep 'define CONFIG_' $@.tmp | \
> +		egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
>  			sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/d=
efine CONFIG_VAL(/d;' > $@; \
>  		rm $@.tmp;						\
>  	} || {								\

I don't like this because whereas "CONFIG_" is enforced to be set only
by Kconfig and so always all reliably set and found via a single header,
CFG_ stuff is not.

--=20
Tom

--/v+5Uh0lKWtWNJj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5uwcACgkQFHw5/5Y0
tyxdwgwAguq/JoEK4r/ZBjv7uXDoeMC9snuezThtiW7n7qHl0Wrgc+60kGanzA5/
znl2HSEGFYAyLr3lONJDk2fAnUkIXM0GujsLQE0w8/bgjC/dW4T6bSE5hy+ehJf0
K5UwB2dgk8Bp6bfgqJPVOAAY4rTfvteW9Uzz5SRh6u711klA1sRvYSTHLsMYup48
xtS9Gq12w1VG76e2qyBEJV0B4NhmzY7vqRulK2KLRt3nBka3/F2+dXLTfPtZwS+P
pX3cv5fltGXXiugjPwhLyx7apFO3tzNUpxAEJJIbYte4Ar8XLB92Hx3eEzughjjg
SkauynVyaA3kVGtTCzsR+l27ylC7z2KoXzC3PVTtGLNLibLnQlKz39WcWjywnYGU
pPzYWKav0vUR/SRfVeHags+Gc5DJzSrPT8NyvUxFrDp/qbGN5hN2s23n5o86dSNw
fvmd7xN7ZnDOx+PfV0QOIPgzHj904BIArgiPc1H8BGt9nAom/53TDs/XGBoaDW76
W+0GTRce
=SxAG
-----END PGP SIGNATURE-----

--/v+5Uh0lKWtWNJj3--
