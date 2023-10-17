Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBC0CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98F786BB4;
	Tue, 17 Oct 2023 16:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4Zf4JTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65960803AC; Tue, 17 Oct 2023 16:04:00 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3051A86EDB
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a877e0f0d8so19073037b3.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551437; x=1698156237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cDAzxP6wxYwhDZPKzie08bgKLa1YBVL4J4qhvcLsjzE=;
 b=R4Zf4JTDOLOATR/ks4o7btKBpB29hSDeaj6uezo84OTQttr6eEe8EHXHPdgvDm9w3l
 UyQb7rvBB643oogXoLsCsH3tDVyVDAe5qhDF3bHQIdL3lsNccrUl6Xgv01T+nsY5bdTN
 aqVV5usvEzk36xMYNo3oBSDN492vCNYsvQb/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551437; x=1698156237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDAzxP6wxYwhDZPKzie08bgKLa1YBVL4J4qhvcLsjzE=;
 b=Kq6mHqz93Pxp+fEolFjlGTRJBukUfc1qOzW99ZEXiKKNrcFLBLf0IUkUQtbDvUvOI+
 OEiVtDNfZPB4F7b4oviaQIffVZe24/E1sqH+jbM1K7iqXCk+bOaYe/qU0eQoEqRR8OGk
 Y2/90jRi+6LbPmmHMzwq9sx1YDTJxuTJ4EHIgyDFtxITpd4ET+0NKSIZqLxWb0oXZP3E
 AnhuE4O8uSHpdorw3MjzJM5gyUI6U7Sfn3IOVNCEYW1XpKrPxQQZyMcxUE2lbzvQ7COX
 f15fZKsGlOxf0MBUR/fN9j8rt12OHpFrBQu/bD+BEaExtgN2OaS7R+ngq58JY2LzEx60
 YDWg==
X-Gm-Message-State: AOJu0YziXgb0xq4c/kGYKQiiM0KQwe6pz5b/YPzOzRPwOVZfxI6+Lc54
 UU79ddZjX83g9hFn8EuaVYfqQg==
X-Google-Smtp-Source: AGHT+IGwBcJePgcQJ13cHzhEhX2ARnIX20iduG3Coeg+j3iztj7Zl9A464AE8tMzA64uTLvE0IIGBQ==
X-Received: by 2002:a81:a156:0:b0:5a8:1767:1fef with SMTP id
 y83-20020a81a156000000b005a817671fefmr1329503ywg.9.1697551436742; 
 Tue, 17 Oct 2023 07:03:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u140-20020a0deb92000000b0059bc980b1eesm632259ywe.6.2023.10.17.07.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:03:56 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:03:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH v3 16/32] net: Depend on CONFIG_CMDLINE
Message-ID: <20231017140354.GX3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7uXdo1P2hlTkbw0U"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-17-sjg@chromium.org>
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


--7uXdo1P2hlTkbw0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:07PM -0600, Simon Glass wrote:

> At present it isn't possible to use networking without the command line
> enabled. Add this as a condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>=20
> (no changes since v1)
>=20
>  cmd/Kconfig | 1 +
>  net/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 148414f011df..c6ea5c860e33 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1694,6 +1694,7 @@ if NET
> =20
>  menuconfig CMD_NET
>  	bool "Network commands"
> +	depends on CMDLINE
>  	default y
>  	imply NETDEVICES
> =20
> diff --git a/net/Kconfig b/net/Kconfig
> index 4215889127c9..25d494e1db46 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -4,6 +4,7 @@
> =20
>  menuconfig NET
>  	bool "Networking support"
> +	depends on CMDLINE
>  	default y
> =20
>  if NET

Please unwind this in the other direction.  What in network is depending
on cmdline in a non-trivial way?

--=20
Tom

--7uXdo1P2hlTkbw0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulEoACgkQFHw5/5Y0
tyxGBgwAqtwHaCo0P3kKG/mu3lY+ejaB3Dh5+1nKNzyadhqlI59nWEZjFHW0WM4Y
TPOB3aymEkILhQ7AjTXajB4jHXIlPhOEdh8qIWYvCyD9StFiJEF7UMZItnZnLsTP
1lCSR7GCfPFdydOEtIf7s02CyP91t+gQfu+pxnxyZAM7M2ry+p+gpYsulfbtMYQY
9nJZ27uQpkrqPy55bJwpjoncxPfODeLd8PbMxGdFgvgA8FdDH6ibq58PJ0qF45Zh
ekh1ghSYh7Nqv7s7I0c7aCEwK6A10joB/6NhiLaL+ozLlKGs4KhlOl8tlunVjJJM
hm/Tgp3VTew5jZIhhT0TsI16yhTSlC21Z2tj8wcBjrEOPOUksGf9dibWtTaQGE1f
GYUfBFdNsmzln2atmll5N4hdy+V4dukPVQdGQeC+0Hms3yIvnxUbbnFhADYmP3Oi
VsMPIeweF00ppvNgFUr8YrQRmsptPg1TMhWKUY8UyDd/pKx9eD53p/CO6A9nux4l
RZzwNcGg
=vEo1
-----END PGP SIGNATURE-----

--7uXdo1P2hlTkbw0U--
