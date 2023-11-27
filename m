Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D3FC0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC1F8776F;
	Mon, 27 Nov 2023 14:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9iWOa3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E94C8778F; Mon, 27 Nov 2023 14:12:33 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1F7875C3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cd3c4457a0so39486217b3.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701090750; x=1701695550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k8cHlEV9I9W6k8OmH+cofzn4YBhxwv58nsmqIQoF8O0=;
 b=p9iWOa3ZPVI2ij48ZQwWtjIww5mC/t3FgxryblVYIjbQmZh9PU6sbzD/utC5U80+YE
 qU7wCeLCPzKSWYYutYaJQvuOStU8eXSS32nHTxwhrmMxdakCe1Fm3uQDx4j7H9+tEsDj
 MQG9WszkHWX9KDPG8e+UpVPUQOYckGO64B0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090750; x=1701695550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8cHlEV9I9W6k8OmH+cofzn4YBhxwv58nsmqIQoF8O0=;
 b=VRjc/S+7UUAhJSzh02gdWT+d2PnEYzYenilkxIs8cOGGzhC6dzd0vXvNpIbDkFSqjO
 eL3pzG8CwzyMTJapi2wfolGVcD/Me0SXYTbgDe+5/OL4Mf9bz+X6CV5/nuyQ4JRV4i0Y
 oRk+kLFvj/GkAxtz9C9ztnTur5/pgbasV7zviWQEKYvH/q0k9xqjZJJondYHmbVd9N1k
 wfjw+aSYXJjTnvdaszsRsCi+mi2l4n/Apc/u5hy24wGzlx1ik/JR8QsCZObP0WjCuIGi
 w3mMPFeBzpXNtR1n+FKFAbu2pRqfK2T3lXaypbGK3mHGTekHnw4uCoX2n9gKHkN+fuSP
 2L/Q==
X-Gm-Message-State: AOJu0YyHUFhsSc6IRs0ZA6C9kelWS7ei27paRyBdOaXVYVo6Cdupim5+
 aGHKLkp5lG2yr8E7apjGwQlnBw==
X-Google-Smtp-Source: AGHT+IEXAQq4xCZO8DfFCMAlfIexFSRJ+iAVLOhjUcC8IwQQRk1y24b2c2MNSV/S8tiR2WacoRIUxg==
X-Received: by 2002:a0d:d756:0:b0:5ca:b053:8eab with SMTP id
 z83-20020a0dd756000000b005cab0538eabmr6825032ywd.24.1701090750351; 
 Mon, 27 Nov 2023 05:12:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 em14-20020a05690c2b0e00b005cda3901d4dsm2965531ywb.77.2023.11.27.05.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:12:29 -0800 (PST)
Date: Mon, 27 Nov 2023 08:12:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 24/43] lwip: omap3: rename mem_init
Message-ID: <20231127131227.GE2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-25-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U/rMAvWxYjM0htJa"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-25-maxim.uvarov@linaro.org>
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


--U/rMAvWxYjM0htJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:07PM +0600, Maxim Uvarov wrote:

> Rename mem_init to solve following compilation error.
> +arm-linux-gnueabi-ld.bfd: net/lwip/lwip-external/src/core/mem.o: in
>   function `mem_init':
> +net/lwip/lwip-external/src/core/mem.c:162: multiple definition
>   of `mem_init';
>   arch/arm/mach-omap2/omap3/sdrc.o:arch/arm/mach-omap2/omap3/
>   sdrc.c:240: first defined here
> +make[1]: *** [Makefile:1764: u-boot] Error 1
> +/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-
>   gnueabi/13.1.0/../../
> ../../arm-linux-gnueabi/bin/ld: net/lwip/lwip-external/src/core/
>   mem.o (symbol from
>   plugin): in function `mem_init':
> +(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
>   omap3/emif4.o
>   (symbol from plugin):(.text+0x0): first defined here
> +collect2: error: ld returned 1 exit status
> +(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
>   omap3/sdrc.o
>   (symbol from plugin):(.text+0x0): first defined here
> +Image 'simple-bin' is missing external blobs and is non-functional:
>    tee-os
> +/binman/simple-bin/fit/images/op-tee/tee-os (tee-os):
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--U/rMAvWxYjM0htJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVklbsACgkQFHw5/5Y0
tywwqAv/e8/e3v0ZI3cDAYIkv3oGbpxgU4W38LPKEKnSUOhgYpVz99W103GHgXMe
g3U9ud4VS5Mf8bDpNSx1O3SPpzj1MuMr8HsqvDGeRpMaKwN5zLywSC9VTFzSxSo6
LieUVhJWw1b3DJdTai1i0WPFc2AKptjlWmQPfpIwqpftYCY0r96YJEuAN3a1kPhJ
2b+gC6QSuL/qqiFzOPDUi4Mr5WiP19gXKM/JqhUvRhyctqGxttKqlbeHvDbn2ZoU
nSJUkygEakg+hJ5SPleUdgpwCpjCXMTpiPqfEIZgR1igkCOnNvN5HQ5vv2/Z8UIj
Q6l9PIhDjeqwdadOmkB/fxUNH7AkvUTiUPlwGC8jZy2Luy9sWZ1u2OgW8ogwfGYR
xG+vY6HAFNGMV+T09bBaRkiItbAne5lqhs1dCrsfjAvMLor+SMiXSBksKnPUsXQy
Ji4+5Z4t9fZEdM744igywhHqCEoX+N3mgAzGrj3VhHHZ5UI7H8CwTyf6oV9Z6kXp
pYWw/3uW
=b6Mv
-----END PGP SIGNATURE-----

--U/rMAvWxYjM0htJa--
