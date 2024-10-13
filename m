Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1BCF2591
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 15:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5436288EF9;
	Sun, 13 Oct 2024 17:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oeOgul+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56C188F16; Sun, 13 Oct 2024 17:30:13 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8494088EF2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 17:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbce16d151so17805126d6.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728833409; x=1729438209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8L+Z+p/axt/lLJan29cfrUy/6D0NytF0l9+6QJ9exU4=;
 b=oeOgul+6EEMpkUJv7rvqDPEOWDdzjIE8ZsO5/X5EqYx/WEhW6e/X0jnSvdpHvBXdqc
 8r++/wtGMekYJM6d/zxHeA9BDJ3ZycNEz5cBtnRglYgVaAhKvsrQwVaDbSqVIrQGOdsj
 WgbonmpdjKgpGqhtXjtbnB0xdbdrj88GL0z4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728833409; x=1729438209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L+Z+p/axt/lLJan29cfrUy/6D0NytF0l9+6QJ9exU4=;
 b=SGFHF1Vl6ggLzSsMBwWRB9WhrnoyWvcZCW3bd2nYH5TyF/H0hPHbqeCM0KDHEWRzOI
 nGdD7XxKOHxAgtiCP5b/ieHJ3nkRY80vqO6BViu3ORy8xXdJ86ti4fNDJe6vo2Ne7rGZ
 MYzu1MmuZ4qUBCH2R03f8eibIjUZd8xiBWDn0p2Iwl46GAQXDopBCVvZBhsTVICP61x9
 E4cyhlqb2hxmHoXLf4jfZby9jDzpUVyQDx2AKJ3wHxRZ2DKSuA1DjHaJDG8y8sV9ErcL
 zOvtJKkEr1lEnSWNXcOTz4RKT8+mdUo52MnUtFRazR4lrQDKzZQPufSIYAYggXwXH5SR
 BJwQ==
X-Gm-Message-State: AOJu0YwW3T0Lycrfs2GL0o95FjGSLkY8jHbK4hwaaZ3kk4c5FZmYqRAm
 A1VisfNcHz0VMRdjv6JCoE58f7nxAMKv7Jncmi9DFsedEnxErayIlZ8ijWgoS5c=
X-Google-Smtp-Source: AGHT+IG7WEU8hO7fCQ4XHkGa6kfNPYNC8Y8pZ0Nzrw+xg53F1IGBifVdRv4K3OaPS2wbmmimmpmEfg==
X-Received: by 2002:a05:6214:468d:b0:6cb:f9cd:b400 with SMTP id
 6a1803df08f44-6cbf9cdb498mr89769096d6.9.1728833409163; 
 Sun, 13 Oct 2024 08:30:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe86093fasm36186086d6.82.2024.10.13.08.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 08:30:08 -0700 (PDT)
Date: Sun, 13 Oct 2024 09:30:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 04/15] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
Message-ID: <20241013153005.GK14210@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-5-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c7XGxqv2eZhtTBEo"
Content-Disposition: inline
In-Reply-To: <20241013105522.391414-5-sughosh.ganu@linaro.org>
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


--c7XGxqv2eZhtTBEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 04:25:11PM +0530, Sughosh Ganu wrote:
> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by the LMB module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>=20
>  lib/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1dd4f27159..61452f7ac9 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -75,6 +75,23 @@ config LIB_UUID
>  	bool
>  	select SHA1
> =20
> +config MEM_MAP_UPDATE_NOTIFY
> +	bool "Get notified of any changes to the LMB memory map"
> +	default y if EFI_LOADER
> +	help
> +	  Enable this option to get notification on any changes to the
> +	  memory that is allocated or freed by the LMB module. This will
> +	  allow different modules that allocate memory or maintain a memory
> +	  map to have a synchronous view of available and allocated memory.
> +
> +config SPL_MEM_MAP_UPDATE_NOTIFY
> +	bool "Get notified of any changes to the LMB memory map in SPL"
> +	help
> +	  Enable this option to get notification on any changes to the
> +	  memory that is allocated or freed by the LMB module. This will
> +	  allow different modules that allocate memory or maintain a memory
> +	  map to have a synchronous view of available and allocated memory.
> +
>  config RANDOM_UUID
>  	bool "GPT Random UUID generation"
>  	select LIB_UUID

Both of these symbols need to be select'd by the other parts of the code
which require them, not prompted. Please do leave the help text for the
entry, just remove the text after "bool" and select from the other code
which requires this. Thanks.

--=20
Tom

--c7XGxqv2eZhtTBEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcL53YACgkQFHw5/5Y0
tyxDSAv+K6WmTkOVRcfBK8Vneli5OJ3Q++QscaZ67P/Vn2c1ln1xZEtOpxXobmyI
x4s3+fYRPU2bpCl6K6QBulWG7rRbaaFPTtvCDTYxpGP1zogbLPQGLmGWJeLi3v4/
hi+7OEL7du/8zI14vXUHyi+ULiUiD1QR4AX9yZRz3Tfq5HqoJFH7Mz0047Vs1qc5
CQ089n3Bp9qSZDM0TovJqZp0p80wp/7ljwy5LMqH8ibiU7jkeodgiU/aQYcg2hG+
HnvsK2kQXFintVCxEfb8N+jmrsZNlQOSfge9h9gdPd7OPhCssS0EFyrt53FyM6Wk
mhi5Gc54dGwS1vzZzebBcM/bSzH50zjhHJbCKt+EyuDoTqVhl8bLL9VwZ+6L0Cw3
iAoObKek4h5rD8m96xP2o3EqkPcFU22Iooo78hrcRnR05CPDRQQG+N3q2X+1fqJ0
+J3EzUU/8KDK2yyV4NyncIcJXlrqZ0wZIsA98Vc5bTDD5J1CoHhzx12HroCzwt9s
yhH8wbk1
=rc8D
-----END PGP SIGNATURE-----

--c7XGxqv2eZhtTBEo--
