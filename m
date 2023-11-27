Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E65C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70156875B9;
	Mon, 27 Nov 2023 19:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M+kM0KKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179ED875DB; Mon, 27 Nov 2023 19:27:26 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADC4875A1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-daf4f0e3a0fso4343297276.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109642; x=1701714442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iVYg4yzqhmsgfXZbNsWy93i224oESwunLLuTdOrKiCc=;
 b=M+kM0KKYMVCOy4t7BXDGZYlOnyGCr8JSOsNd2F43DDCkYP+qBo4u6I20PeM8ahE5x5
 XAP1MqQ+w9EhxzLpLA9D9YrX2XGyhv6DU+KITk+WssGIzRUNHcULrv97Dm4GkBQ8QzWv
 UNGboqHT+54vLm6VtsPQ3dBjS02/kzf7XsiCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109642; x=1701714442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVYg4yzqhmsgfXZbNsWy93i224oESwunLLuTdOrKiCc=;
 b=hqPlTYUOJgcyyqOT2lrp6HGjPiyWmfijEa11uHrXFHkh0BkZnNJuazQQf33PKWnojn
 V4z94gyYZRICEi+j5XLTLQV1TV1hgEoCPCM2aDJi/ogilw/0eet+Aafi7PTIPG/TprvN
 SPVifn+M7U4VGxF3Xl5g3OUYAEWup2i+5hB8WuesbrJkKzm2tG4kZj7QVGTNayGGix4t
 TI25BftVXeuN1pYKhmF3cM0G76UOid/ZW2/yxwuWC9yNj5QFfqLLueG0547RulaStZDv
 rDIuj/tXsoOWlPSUdPADJsxaX9YoUdYJDQAkKZz3DIHx27Mgxh3hbV8jDvXQCtLwHaXG
 0bkw==
X-Gm-Message-State: AOJu0YzA8FvC8oczHz1HJg3ObdXt8izX+jsWAMMeJ8xKemIFm4nx7//q
 oruEUrRzrYFnOiZIZB4qlr9QHQ==
X-Google-Smtp-Source: AGHT+IGBQTSUFtLRj71QkkimcpcWEdnV1wELK31GtUgigSIdAlyfi034vLw/wB/4S3FH5B5ZXHtosg==
X-Received: by 2002:a25:d30e:0:b0:d9a:fd15:82a3 with SMTP id
 e14-20020a25d30e000000b00d9afd1582a3mr12469910ybf.24.1701109642547; 
 Mon, 27 Nov 2023 10:27:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 79-20020a250d52000000b00d7ba4c5e31fsm3219706ybn.39.2023.11.27.10.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:27:22 -0800 (PST)
Date: Mon, 27 Nov 2023 13:27:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 04/43] net/lwip: implement dns cmd
Message-ID: <20231127182720.GQ2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-5-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LvOtlo4KfNBbeTK3"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-5-maxim.uvarov@linaro.org>
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


--LvOtlo4KfNBbeTK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:47PM +0600, Maxim Uvarov wrote:

> U-Boot recently got support for an alternative network stack using LWIP.
> Replace dns command with the LWIP variant while keeping the output and
> error messages identical.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
[snip]
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 3fd5d34564..5d8d5527c6 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -62,3 +62,5 @@ obj-$(CONFIG_NET) +=3D lwip-external/src/netif/ethernet=
=2Eo
> =20
>  obj-$(CONFIG_NET) +=3D port/if.o
>  obj-$(CONFIG_NET) +=3D port/sys-arch.o
> +
> +obj-y +=3D apps/dns/lwip-dns.o

Shouldn't this depend on CONFIG symbol? There's CONFIG_CMD_DNS today.
And I'll assume this is maybe an issue with other parts of the series,
so please check and confirm those as well.

> diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
> new file mode 100644
> index 0000000000..3ee6e24ef4
> --- /dev/null
> +++ b/net/lwip/apps/dns/lwip-dns.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>

Here and elsewhere, no common.h usage, please include what you need from
it directly.

--=20
Tom

--LvOtlo4KfNBbeTK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk34gACgkQFHw5/5Y0
tyyCuwwAibt91orzPLqfUyGyWRP0IFMvgCEgnN/mqdZeK7fmc4ggMq6QXPIAVvpq
/NXOt7+L7Y5mtcFsf8dhpPqePeE9dg4QRfIf9ncrhoftx5/FAPtcZa/i8kbQe9YM
qgByNlOtHz/GZYHiS3M6Fa4GYSvFHfMfFHgkbksWg7S1l+My/Mwr4O0wNEtAyFLr
XcXZ1VU3oK3liHaX1WwUXJj0VSbyKNCLNypZHQQ1fIkxjUI4wvYc5YMGRbGVT3Jj
H5LVhbLDKBFuE/fJ3KHZqv6v6y95kmvLRhDiscPCi38rbW2mt8MqV1ph+vwYhzIK
Ao9FCbiDPj9bol1RvBjzF6qWGFnLz3uOyzsXEBFCoA3NxTwI1clQMUAguTffY/lX
jNmZxxMQiGohM2bNKofn6wJwmbR3f41oyY4GFwtiZ5107sFm7HkY+r6h699OyupC
XlIAq/Y4DECZwA8ly7TULBn5EciN7FWriA/BgGPbtNT/Bezhtwkm1sLn10kt8Ssd
NbESDDzB
=3Zuq
-----END PGP SIGNATURE-----

--LvOtlo4KfNBbeTK3--
