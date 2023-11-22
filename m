Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D9C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D261887631;
	Wed, 22 Nov 2023 21:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C7fhyIK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E091803AE; Wed, 22 Nov 2023 21:50:52 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DE587631
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5cc69df1b9aso1880237b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686245; x=1701291045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oRrBiKyS7uGdNeDURTdvP+Pl1D0QV5l4JBG/57b5/kc=;
 b=C7fhyIK0aeID5UXmdIjYuSIZ6UvdgLltg3VpJSgxqbJSkLSK5czP04VQS1XUXwRUBV
 iy8VGsHNdfWTB/PjCyCbNwqv8s3G4q3WT8ugfKPJ4w4BsH9B1Wvxd+CQjWgfn4KCYZj6
 qEPPuBdMxoT3BMm/jOq3asJQShqT77j9+If3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686245; x=1701291045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRrBiKyS7uGdNeDURTdvP+Pl1D0QV5l4JBG/57b5/kc=;
 b=WKUhAIzPL/bhO42wlPFMk/5nFBfLRb1FsG5C1DaTiDBQr/OTHKgoO0uuRiLdVe2/hm
 b2hUeeQoTonZmthjXIAAvaIrUk5yIbYzvMEBu2sgn7Q/Ky8HHmHgytZbJ5O7i4TscIm5
 O+s2I64CjTZLVtKcx4PhWApUOTd0kAeBGozEcxN/RykD8zsnVeywT3+ZTmvbfhDWJpdC
 lqwhf8HG30I9LuSs754dUmW9guAkTYtaCAJZTOwZBAmw5kHLgfU+9MrqLC6HFkqmEhd9
 4ImILFZIBN40qCP+Is71y2JQGGWi95ABTwVyBwOHTcvFYqYWQZVVcSgCTirgHB80DMZd
 eARQ==
X-Gm-Message-State: AOJu0YxunTw3QPHF/GqPEUeMhz/zBckVPhTX1K1zGuWggfDNAcro5Rz1
 TWgUWbgP21VZUz7pNQeedOD26A==
X-Google-Smtp-Source: AGHT+IG0JDmdKYLODcCdCVErcCHiXsKaWFb7G4Y68QuA43qDW3jugRIhftyi3SmuyeiLVmOrEphkAA==
X-Received: by 2002:a0d:d8d6:0:b0:59f:761a:fe70 with SMTP id
 a205-20020a0dd8d6000000b0059f761afe70mr3561473ywe.19.1700686244899; 
 Wed, 22 Nov 2023 12:50:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 i145-20020a0ddf97000000b005cb6eaf9ed4sm91958ywe.18.2023.11.22.12.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:44 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mach-k3: Move K3 common schema.yaml out of board
 directory
Message-ID: <20231122205042.GR2513409@bill-the-cat>
References: <20231101183329.65091-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sFrX0ngdq6qnZnSs"
Content-Disposition: inline
In-Reply-To: <20231101183329.65091-1-afd@ti.com>
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


--sFrX0ngdq6qnZnSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 01:33:29PM -0500, Andrew Davis wrote:

> This file is common for all K3, move it out of board/ directory and
> into mach-k3. As we need to change the path in k3-binman.dtsi let's
> take this opportunity to switch to absolute paths which makes adding
> non-TI boards (like Toradex Verdin) not need to override these paths.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 66 -------------------
>  arch/arm/dts/k3-binman.dtsi                   | 28 ++++----
>  .../common =3D> arch/arm/mach-k3}/schema.yaml   |  0
>  3 files changed, 14 insertions(+), 80 deletions(-)
>  rename {board/ti/common =3D> arch/arm/mach-k3}/schema.yaml (100%)

Please rebase this on top of -next if this is still needed after Neha's
series has now been merged there, thanks.

--=20
Tom

--sFrX0ngdq6qnZnSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaaIACgkQFHw5/5Y0
tyx7tQv/aI9XRqLVEX9AO1r+R8ypJVwcAgWKMOHGUigpeftMM7rAaGR+nOS+iU4l
7GiZ6kWmzhq+X0kdkkGgOtOwYv3dyK5osMQk0Wl9agNIQtPUds3UhapgjpbRr4Gt
GBlA6Lm7LK+jIsQ/bbUTwCdJdQiAKuQUdG9sjFX0riDBhQsofcEKNdWG5e6NTai/
mKHmQoksoXytD5cNc85+5ZQACu5jBa9EMQMu6Kw4zn/HrlVlNrFDzuaWc3JmK07C
Q9xtdYwZItyO6pOaeXVWKxrTCxKCwvOtOpt1y0zkqOujXJYVqyQ5u8nKdYsIxDc9
0nmKuIf9baX9a1AniiTyegs1gIuuRJejUHbfC5kjWCAaiuF1CqxbvLIZEUh8rfsg
Y8KYOmJZ0umTnWj5NPGFi+igPNA/CwQwfoPIbjv23PTtkxJq6zNlo1Xj3YUrcbB/
jULf8UJ9Y4wZGv9u62QyNSi6SKXyYXsClFGE8SvcMTgPwM2W2JqWs6+XVyn3sngZ
Ho4RJ9Fi
=9Qmj
-----END PGP SIGNATURE-----

--sFrX0ngdq6qnZnSs--
