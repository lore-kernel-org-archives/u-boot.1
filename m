Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E398EE4987
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BB986DBD;
	Fri, 18 Aug 2023 19:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NTNPvAXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5AC86EB9; Fri, 18 Aug 2023 19:49:37 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368F08082A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58c656824c1so12047817b3.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380974; x=1692985774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=itWFXWQYxIccvypjTz60DBtKFGbNquQiH0WYBU6aUjU=;
 b=NTNPvAXzlOUUYHaFa06jxZdY6O17FWV0kvHBWQMg10nYHHxX8lO8nJEBEr7x6JVZEF
 n2ZhmmU629X4k5CXrpAfhR2gxs8lD8x/msghuL2VJ6NWrC/QwJLVFaG/PuUUFBtA8LNN
 lAzmpKV2ZLsgAj4YNh4K70iL/B25LK47pcYJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380974; x=1692985774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itWFXWQYxIccvypjTz60DBtKFGbNquQiH0WYBU6aUjU=;
 b=bK+c67JRuUL/miKjLSULP32FDyto3vFOTLGL2a6dlkRxsHDbz9tJiEKnEsbStA46jL
 I4XahM/AHVXGu+M/S7YkoQdZzKvelkut/Wc+y5GQlxfoRe718igBeKDUCE6cAyC3MXck
 FHECr8jfR/TiI1YqM280rXGTgnL9peE9ZyPSKj6BCS9dQHl42LfA+9tT0hqq3c9xxy48
 HrQ+s7N1BcfSDswjuKjE9h/Nwn6FH+cOcwaJub0BDU72XrH6L+4x5JBMwFn4okCK1vPA
 UO3/qpeBDpqVyjPRkAC3lhlaiIItTVbwrdTfeDnKN7RpCxmdySiDHS6O1pD+GmUmoLTB
 i2Ew==
X-Gm-Message-State: AOJu0YwsZUggGp8QglC6Wl5I+fgy+8ZbDeP6nzHkm+ZRfKyxcDkw5wW+
 TIN20bw5LvXQB983yztsRVGKHA==
X-Google-Smtp-Source: AGHT+IFnSHHKlhMJ5DKTzExhq9nYNw5/LdhOwmEHZfOEMEnACk8m9G/g+QrFDa+ZewTu+NMCIK9ylg==
X-Received: by 2002:a0d:ffc5:0:b0:57a:40aa:3fe4 with SMTP id
 p188-20020a0dffc5000000b0057a40aa3fe4mr3010663ywf.22.1692380973907; 
 Fri, 18 Aug 2023 10:49:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 q62-20020a815c41000000b0057736c436f1sm618097ywb.141.2023.08.18.10.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:33 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH] arm: Use builtins for ffs/fls
Message-ID: <20230818174931.GC1515023@bill-the-cat>
References: <20230731212734.7256-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GE4EKprh8VkLEpNr"
Content-Disposition: inline
In-Reply-To: <20230731212734.7256-1-sean.anderson@seco.com>
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


--GE4EKprh8VkLEpNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:27:33PM -0400, Sean Anderson wrote:

> Since ARMv5, the clz instruction allows for efficient implementation of
> ffs/fls with builtins. Until ARMv7 (with Thumb-2), this instruction is
> only available in ARM mode. LTO makes it difficult to force specific
> functions to be in ARM mode, as it is effectively a form of very
> aggressive inlining. To work around this, fls/ffs are implemented in
> assembly for ARMv5 and ARMv6 when compiling U-Boot in Thumb mode.
> Overall, this saves around 75 bytes per call.
>=20
> This code is synced with v5.15 of the Linux kernel.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--GE4EKprh8VkLEpNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfryYACgkQFHw5/5Y0
tywdVgv9FAmQoSVee1UfhUKfXsHlTgu1zhVyezNQL5+Nr+K4tfjv5A0HhcxymsWf
ju7MtsHtaPcIuusB+0Cmi+P44lSSaXx03/0S1EwzRj5nrZujwzvhiF9G5UAaS4ru
ELJYgencKZZN0BMmv8/I53X3QQ9zOqQW93bVrDnm53o4S3YTagylf/Jjg3XEOPMa
4gk52++ZBGiZ5CoBg61p1RxRFBIWL5pMZImqNaZvseVLQXeYMrLGOJ48nsOaH/Gy
D5yonV8QK6BWVPuU8k0/QQEQeoLhXkSkdj+c5x5bW3qad8PvZU4UxRoaxAnumDDL
QMlVWrRa2HwR3vuvhQ/GpbuE+o+TfowOPjyLqfBEZzKVYRi99m9UYlWE2MRD0/RC
HKzLHzZm55aWTdCz/N5ylxupY478k3Sg7CHSSZWjIaOYDJB8jNuPIrNCb7VUk1YJ
psA3GdinxoAZsYNt9QwJqXNmP/H8M5f8/Z/I0KUmlre71/awriofkbII385wSeQG
Ka6I9JPQ
=BFQR
-----END PGP SIGNATURE-----

--GE4EKprh8VkLEpNr--
