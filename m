Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FF2C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F52682CBC;
	Fri, 20 Jun 2025 19:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kwwhT4o/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3282482CF4; Fri, 20 Jun 2025 19:20:05 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28E280E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 19:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73a8d0e3822so812171a34.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750440001; x=1751044801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sgfEV05Mu+3ID0vPOSZ/gxYPY/9Wky5ZTEuIysoLPfM=;
 b=kwwhT4o/GAVg2s2WIlwE5kvIzKKtviQL2gtM1HrDSunmY9S5tNhFQsEDVvxEeZr9Md
 qSpVA8dr2GbFg9+FiGNq8JooWCY0QdToww/301T3I1529APSVYF0RCG0BdohQmYNCG7t
 5CTX4f7ba8rb1wlrTSd2DDYKeaPuvqIPKnoVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440001; x=1751044801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgfEV05Mu+3ID0vPOSZ/gxYPY/9Wky5ZTEuIysoLPfM=;
 b=M4KYC726DhQ7/4dR4i8BGjwLmFHE2YQEAef2iwUeoSyEpXrz3n/ZBX3jxyDI5E+FCp
 /Mni0TXjLShdb5eFQH1fN7QVNZO6x2R85Dbl/RLbNpEgVFmaLORiC7e2WOYCoNIP6me7
 50h64fqO3qxKro+Ns2zzlPmfDzRVu5E6OOUjSW/RZJ0XfECEfCssYq5VRRCvIIDo8ReE
 aKzD3iT/ZvdyeediZkbMKx2Cpavaoqe2Uk4RB4oZ+Tm3NZ/mtJ5db88CplljJsIqNP4W
 /ApnVDj1EMOnMadRRecpPf5KeCHQdCt8T6M9mI4gNiLKVi+6Tg4iL3dnnc2rNqHKem7v
 8+CA==
X-Gm-Message-State: AOJu0YykGraGVZWbjjT4JkL1I3dte4Tr2gofH3lof/1pOLwOig+5xWty
 2lno2lv2oRHYp/aig9yPEDqj9mSJfVd1WF9OZluSuE+NPuAntKg9eN2WQwVD2j8QB40=
X-Gm-Gg: ASbGncuHd9qSqjjt50X+5ne2+8eiWy9A+fpUL4Pp8eG29/lW9eS9Gkgm0yd4B7oFBaC
 FBf0V3Cva5HY9bXzVhhvY9qTUPx8HdWMqd+OR5apX/IMUix7vTRZ9u6gQYDCowsguHf6oL4hr6t
 bsNnZn/FIV2A8SM+Ct7SFkfHEE7LZizh1wimHBZMsG3oPAii2MCyHe89d5oeB9Oajn2+nZLeOhA
 //MuDCsTYB7zG0D3+NRo9GFTaOF8uUcaKuN6ElBSMOrHeqqiobJp5YcBRBcXDC1uAr96Buls1vm
 oHcIhFW0rLRfTyJH5Ds2TtlvpL2DV6KOlvE3Yg2g0iI+SZI8qmjVn6OLM+f75lOWzUEcKLLe74h
 ZgUQAw/QiOC4WzjYSPhHbwNE=
X-Google-Smtp-Source: AGHT+IHMf4US7y8J/wnroPrk7NPlGZOD5E/cCzPEgtcdQdzdszCDYQNB0Mvb5aoot1AcdK5egHfu3Q==
X-Received: by 2002:a05:6830:8089:b0:73a:9158:fb7e with SMTP id
 46e09a7af769-73a91d85d30mr2425355a34.25.1750440001364; 
 Fri, 20 Jun 2025 10:20:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90c921a7sm382811a34.34.2025.06.20.10.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 10:20:00 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:19:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 1/3] mbedtls: Introduce subset of compiler-rt from LLVM
Message-ID: <20250620171957.GL216500@bill-the-cat>
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ir5hoRUJmJWfxnHM"
Content-Disposition: inline
In-Reply-To: <20250620151021.2711542-1-raymond.mao@linaro.org>
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


--Ir5hoRUJmJWfxnHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 08:10:08AM -0700, Raymond Mao wrote:
> Introduce the implementation of udivti3 and udivmodti4 from LLVM
> compiler-rt builtins for building MbedTLS bignum module via Clang.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++++
>  lib/mbedtls/port/compiler-rt/README.txt       |  11 +
>  .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
>  .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
>  .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
>  .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
>  .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
>  .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
>  8 files changed, 1111 insertions(+)
>  create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
>  create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_endiann=
ess.h
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
>=20
> diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/port/=
compiler-rt/LICENSE.TXT
> new file mode 100644
> index 00000000000..5a79a1b9d5c
> --- /dev/null
> +++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> @@ -0,0 +1,311 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +The LLVM Project is under the Apache License v2.0 with LLVM Exceptions:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +                                 Apache License
> +                           Version 2.0, January 2004
> +                        http://www.apache.org/licenses/

I don't know that this is compatible for us. Looking at
https://www.apache.org/licenses/GPL-compatibility.html it talks about
how you can use it with GPLv3 (which we are *NOT*) but not GPLv2.

--=20
Tom

--Ir5hoRUJmJWfxnHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVmDoACgkQFHw5/5Y0
tyyz3gwArJpt3jcXmkx66EUlXzYCI7+5zI4FOPLb3atTnPARAGAVWmtF0QF/6IQ5
1WcsGF8G+yq9t8Tal03fyyP7VIVq9rbs5Yhs3Czla4vytD3E0MIVDjZAUFvy8seW
lT15E/JdsiMdqSIpkbzS0vT0BCBZWSYUkqVs60ev2ZRk4rALf8vNEe3yt+vNSfG4
vc9RwEGu9VHMdEhC8CUTYpuGFaDusiAwlSVX+YHFXCBBl313BTINwUazHpeoORMe
u7hNStWI6Lwvu+YtTS16flNzH6G35UkAyl6BPmccm+5b6mpWUQGiqid/eD7NOSac
VJm687jo9WYtcwu2JjocfyUhN2K2qZqZyVPf66C2L7FdamzYkgIiZ5lJ7gOD7WQl
hrdjjsA3r5xiKX/SKfdjwJZBZ0wRMjz9X5Q1NaDhDUYjxaO8xGTi4m9hiq4vr6Fi
W8Op8q0M/aJZlvnbWiMItxgLPCDDdunKaB243Dd1+NmMQjuhY5kERhqPwfZu/v3d
r/FKV0zK
=6FNZ
-----END PGP SIGNATURE-----

--Ir5hoRUJmJWfxnHM--
