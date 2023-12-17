Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CBDC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 18:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECD387D2E;
	Sun, 17 Dec 2023 19:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bjwOaWLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35B387D30; Sun, 17 Dec 2023 19:41:11 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E83887D2D
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 19:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db537948ea0so1755501276.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702838468; x=1703443268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bZGvT99CkDSjri475GsOdIVFKmx4LFr6ciV6opnON3I=;
 b=bjwOaWLG53XsesQIirHvU40VqmB9YgLCjP6pwFqRe23yDLpJUMoZ3QLHcY1gEXGZUB
 kFjfwuqvbfESG/vKt9wnQHDfqQRvp64qn0zvYUK5rmwWLHEih1xr2yzDcqtcsuGZYWgD
 pbHNffMUZQIrRkEZX3DSHTZJnvtnqle+EE1Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702838468; x=1703443268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZGvT99CkDSjri475GsOdIVFKmx4LFr6ciV6opnON3I=;
 b=dndnoRWw8MGfvDOjEZtijtZeFkoYG8qqRL9cyzdsrQZtRyJOwVtir74+D68iqeCZwW
 xPNVxg65GMU/b31xuDJ1zLc6Mcv10shrjiZySLF7T1xayeNEXYwPFlYzPTUJTII/dLAx
 qWHiDWA9hE13BbVtLS1/3sELMdQJwT9WY+gcspsKhD1pw5pehQr7kmUl8/g4XRit+4CZ
 uSsJndWrsTcO8DsEmXZ+bA3sK+suGV39hM3zOkV0ELb9d+68uJxlFjDsB98+u+VX2qgH
 xIw1ZFxUw2OLfdmx0iqxeV2uxLDnrvcvOK3CONrJXQ1ZePkAv0gTtrCuRZZqzW8QMoIH
 Jt9A==
X-Gm-Message-State: AOJu0YxnT2zeOkCz9R8tuLhJ4ILEqkAgEzaZH3eOuWiWEJ0Z6wfog9fp
 91kNxbiQb70inxCMEJfawT98lQ==
X-Google-Smtp-Source: AGHT+IH8BeK7vNqk11YSjGVXuXsN+ii9M9qU7YS68I1tVY56yZZA0EXqJMroCZwpLxPtWwHJ6eg8+g==
X-Received: by 2002:a81:8245:0:b0:5d7:1940:b399 with SMTP id
 s66-20020a818245000000b005d71940b399mr13136616ywf.101.1702838468364; 
 Sun, 17 Dec 2023 10:41:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c7d6-a760-1f4b-e321.res6.spectrum.com.
 [2603:6081:7b00:6400:c7d6:a760:1f4b:e321])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a81a509000000b00597e912e67esm8108885ywg.131.2023.12.17.10.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 10:41:07 -0800 (PST)
Date: Sun, 17 Dec 2023 13:41:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] arm: Add OVERLAY command to BSS section on ARM64
Message-ID: <20231217184106.GD2513409@bill-the-cat>
References: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q25Ojcksc0htILd7"
Content-Disposition: inline
In-Reply-To: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
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


--q25Ojcksc0htILd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 01:33:39AM +0100, Marek Vasut wrote:
> Avoid allocating and loading the BSS section.
>=20
> $ aarch64-linux-gnu-objdump -Sh u-boot
>=20
> Before:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8=
  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8=
  2**6
>                    ALLOC
>   12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8=
  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>=20
> After:
>   10 .bss_start    00000000  00000000000bf990  00000000000bf990  001021e0=
  2**0
>                    CONTENTS
>   11 .bss          000068e8  00000000000bf990  00000000000bf990  001021e0=
  2**4
>                    CONTENTS
>   12 .bss_end      00000000  00000000000c6278  00000000000c6278  00108ac8=
  2**0
>                    CONTENTS
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> V2: Replicate arch/arm/cpu/u-boot.lds BSS part verbatim
> ---
>  arch/arm/cpu/armv8/u-boot.lds | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

The point I was trying to make before was that I wasn't 100% confident
that we need the linker scripts to match in that most of the relevant
code is in foo_64.S and not foo.S. But from a very quick grep it does
look similar enough that perhaps it was ported over directly enough that
we should be doing this with the linker scripts here too. Hopefully
throwing this in to -next soon enough will get any problems to fall out
quickly if we're wrong.

--=20
Tom

--q25Ojcksc0htILd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV/QMIACgkQFHw5/5Y0
tyz3DAv/fab8TIjeuZHFjHgdrEIPYjnnqdWOimndyd4HGiadJIeJJ8yxt1s1iHNI
Yi6zgkNAXsPZs/gxzlie2bKaGm1VtdeTLbRYEpa6oBoaKUgR1PxeBfvx+ZnmXHFW
AuklVRmwk965KlEfCLXGga+VmhHo1RkU6QHfiGEsAIXHCKY1Ll/NEPlJBMrRR5EO
4QqmBtyhiZXeF1ur/x4aoBWz6pn7IUb30q8qhk1w8cH0/wnjQ532VpzHKtfoycfO
luolk33I0XG5NnjVQ1X0X4h7A3R6OnS4oevicK3jOMOX5AU5mFs3B1tsXH4ZIaq8
fTKNHP7/FCob4e334Q6f84kwZ+xaL8VDIjX1mo+dHm3SrVKHxyw1PWu2oWe5GDDn
xu2LrZ3rxxBiZUJa7bojtcowTs4j+2oashL45jNT5ssYYAFbLnTE/P9HeB9f5a8S
bb0hYCQ44n6NWlMBlkbxIZSmeov69SPOcEQ9KDwnQ0beHm0YGTochbkC0K/aDBEg
vYYBm+aJ
=FAWN
-----END PGP SIGNATURE-----

--q25Ojcksc0htILd7--
