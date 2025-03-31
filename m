Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F27C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD54581E6C;
	Mon, 31 Mar 2025 19:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tvBR2euo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9296881EC0; Mon, 31 Mar 2025 19:42:43 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0BF81DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5fcd61e9bcdso2102500eaf.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743442960; x=1744047760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mGK9k1+mh20mMmK1sABuEEG8N+k0pZH9+ckUapfaNvA=;
 b=tvBR2euo1tBBAVIzsIqTqgwiYs4AerfdWPs3+gk52f66xz6mwgicBPYyjyyY9Y+bff
 cAChdRUZiE5faJpYruuEfSOdh104WwM6PzMdMnHJoSneffbnD+vwVoe1+YEzY/0/1y+3
 LFaK2YVgUxWBO6FFplHiSb6JylXo+b1f2ySfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743442960; x=1744047760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGK9k1+mh20mMmK1sABuEEG8N+k0pZH9+ckUapfaNvA=;
 b=PL8epRsjtJXZMdudu+QEfiEModubjRkLQftmsfQmhn2dOOpEhAqzNULBn16I1oB75H
 cvZ46bWR1uX9FONfgFfNgsLKZwXpKkn68Vy/g1ikQHIR7PFO0vwgXT0B/CPdLDmEbSYR
 vEtaxfZn1FObhik90ZFkOklv9F/9mMF0fQYJU+ss+Zgq1lyp/iFNTyWzTdYs6wstFOHy
 XQWNfBr/lLJGZw9g9brRV0Jj56UNWty7QMBzgoXFnsl5OxZX/rtn+v5x7ht8nMo4qDSS
 xnAjEIhiIhCM9/VHE8AGh6RGLIWfELdOUSFelms8K2HA/G0lYWXBhordrxoK3l4nyye4
 QldA==
X-Gm-Message-State: AOJu0YxeAR9lYA4Qgt6gGO2iSgd3VaQrfRuEfXtkJGE4GQudko1SWYoW
 3NeFqxxWNdPAuoML8iZUIiUWEukjVKqpppRcQFXl458oNssYiuQ823saSfQh014=
X-Gm-Gg: ASbGnctebmbfbiPcFTl6fn4T2zxxJIKlZNwR+oeOE2oqYCHe6LPFTYrxLrCP2wzFbDr
 8W8teej2Whh9CAyhSoNVUDkASycFRoaRoub4spFCAuDXuc4gVQ/DuAoJyDQRvvwXQ5uEMMd5iOR
 m2p6L35gQWFPXXnHjCJgxMg+nHJHhYBNny6Z53oshrXCdbMMPfYMHOG4F2iJDxFOjirS4BFJimO
 /voVBfSSyEc4GpKST2uK/xHmcAKMkI/qBRHVwAWcXxumo56x8itw3tLDfzc0cZuQ2JApOLJqZ34
 oKtylMBiLMjJ88Xx8k+tzIVffCuY78n/GXlM0lv/xPireAZsJS8skonyucJbCyYyR5zoTUSnkkM
 iMD1tQMuQZoiFe75E
X-Google-Smtp-Source: AGHT+IFu+LEbWDO7r5ljzAQccqZKTnPjawp4rdrxh/y4R+UXstJJu75Xy8vXdHFt8RuVh+COC5Vvvw==
X-Received: by 2002:a05:6820:98d:b0:602:85a5:90ad with SMTP id
 006d021491bc7-60290e77e41mr5609452eaf.2.1743442960017; 
 Mon, 31 Mar 2025 10:42:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60284501daasm1533819eaf.12.2025.03.31.10.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:42:39 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:42:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 01/17] fs: boot: Update fs_read_alloc() to use abuf
Message-ID: <20250331174237.GJ93000@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ueHWgIIa3Yu+/ukp"
Content-Disposition: inline
In-Reply-To: <20250319143820.2385092-2-sjg@chromium.org>
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


--ueHWgIIa3Yu+/ukp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:37:55PM +0100, Simon Glass wrote:

> Using an abuf for this function simplifies returning the size and also
> makes it easier to free memory afterwards. Update the API and callers.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootmeth-uclass.c | 19 ++++++++++---------
>  fs/fs.c                | 25 +++++++++++--------------
>  include/fs.h           |  8 +++++---
>  3 files changed, 26 insertions(+), 26 deletions(-)

So we grow platforms by ~200 bytes:
            sama7g54_curiosity_nandflash: all +204 text +204
               u-boot: add: 6/0, grow: 2/0 bytes: 204/0 (204)
                 function                                   old     new   d=
elta
                 abuf_realloc                                 -      76    =
 +76
                 abuf_uninit_move                             -      42    =
 +42
                 memdup                                       -      28    =
 +28
                 abuf_uninit                                  -      24    =
 +24
                 fs_read_alloc                               96     106    =
 +10
                 fs_load_alloc                              114     124    =
 +10
                 abuf_init                                    -      10    =
 +10
                 abuf_addr                                    -       4    =
  +4

To move away from standard buffer usage and unwinding to move to
something homegrown instead. I am not a fan of growing using abuf here.
When it was introduced in:

commit 67bc59df05331eaac56cd0a00219d1386130aee2
Author: Simon Glass <sjg@chromium.org>
Date:   Sat Sep 25 07:03:07 2021 -0600

    Add support for an owned buffer

It sounded like something for some special cases. Not something to be
used everywhere to be different.

--=20
Tom

--ueHWgIIa3Yu+/ukp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq1A0ACgkQFHw5/5Y0
tyxTUgv8D9v4wvCFFBKljzBdOrN4BSCnvUfOcgv5z8ZYJzGX0QoPvZp0XnUpE/Y8
v+KHVE3i1TS6lHnDWtC3lFD2TqpH9Jczy4vle9yAcLAfwpJDWjLV9lR35U3Hs9rM
8ZeNVca4FxX14wgUl43XU7CBXwyWFxFoZn9mxSjG3vrI2yeW1u0tMaFgR8+zgpnR
x8l/QMEKkRCu2NIzjNi05Z4EoFQ0Dg2Eu6GdegRvFK6qZD15ww1bSl+XX+NNj5I2
WnHnUUGCjJhfogOE8GJPdnGQdwACnnttpiEBte9jFDMErWVu+CWQzTgL6NI4TP4C
g3NUiCfS/eHdaJZgpllkmjlClOBwomeQCaQDim6jHrQVWIQnSBuBlPtqrj8xVkSi
ON9qj+H//wp2xuPuS6/ks85m25xrrIvdwZXQ7dvA1wc+JfVtUvlIJCf93adIUFrJ
8yS56phdXhxNzDDJYVFFSNYLJ0acl3O5S9iCQjEnGlHDAuGzSHVrqzMVWUesDi7S
NJ18kFDQ
=z+FJ
-----END PGP SIGNATURE-----

--ueHWgIIa3Yu+/ukp--
