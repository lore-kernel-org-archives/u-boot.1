Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542E3CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF7D86ECD;
	Thu, 12 Oct 2023 23:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QeVjLrX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3A386E4F; Thu, 12 Oct 2023 23:24:29 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90A486E87
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d23f1e3b8so725903a91.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697145614; x=1697750414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mau74sZd7L5zjHnarHd5rjUg+Cr6SttXFtKXUtUczV0=;
 b=QeVjLrX4ga1NZ9xsvuOba8eFI9lRgT2gnoHz5ZOmLLRQy8B8LZYofv6pq/sbNpUds3
 HV+b4WXF0pkjtCiEYvOCUe0w/blIWkvNt+zjUEHAzeRWuxHv2dj5FgaK83ZpUWKxqJd3
 I2qDHFRqHXbqK4M2lj5h2PR8IZVnNMFpwmDZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697145614; x=1697750414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mau74sZd7L5zjHnarHd5rjUg+Cr6SttXFtKXUtUczV0=;
 b=phUYxTLPc7q56JUdbLS4nfOQzqdGwTQ0dcyA4gMgQJt2GuignPy23d6kTrMIdP9dfi
 L2V/sc45oBf2QvJJ9BfvAJ0coJm+uodSePYw76/53Kr4SEXEBIUOMji/deD+n41jbLTg
 OUuppsy7y5GESTusPVO0uuLlf0LyOIOhKQZFxZWIeUOy+dAufOOLqunP7ZnJBEn4v/Xr
 6JLhckr8wGWgZyZTVhI2+syrvOgE7hMmx+8QZZ/FTTNyof4+oRC4dHFrnFq6K6JyCOV1
 +GRd7OfndwJv9mi+06e//SwdKZgP+wyJDMmtz0pjdclF9l4IJ6q7nzGW2ymNpdbmCGQr
 o10Q==
X-Gm-Message-State: AOJu0Yyx4ep0wJcUU0PEO3xoHFQVq4mjqSlFKVRx5N9KIeuVT/OORI6t
 6BfLiSckBQDhC57oWkXkdN8zNrIcPoZLwgP9eoO4jg==
X-Google-Smtp-Source: AGHT+IHhNIsgrOmUmwL4nk75POAmkVgQ2o/+N3pP8JqWSCcS8AGWR7kqA5/1ZPU0bl/QVB7n9imTYg==
X-Received: by 2002:a05:690c:f92:b0:5a8:874:bb3a with SMTP id
 df18-20020a05690c0f9200b005a80874bb3amr2371127ywb.31.1697144667016; 
 Thu, 12 Oct 2023 14:04:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a81a18e000000b0059beb468cb4sm222914ywg.1.2023.10.12.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:26 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 5/7] arm: dts: k3-am68: Sync from Linux tag v6.6-rc1
Message-ID: <20231012210424.GE3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-5-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mvWg4HxzYcmGYQde"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-5-5d31f765dd2c@ti.com>
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


--mvWg4HxzYcmGYQde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:15:59AM +0530, Manorit Chawdhry wrote:

> The following commit syncs the device tree from Linux tag
> v6.6-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
>=20
> - Include k3-am68-sk-base-board.dts file
>=20
>     Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>     include k3-am68-sk-base-board.dts for Linux fixes to propagate
>     to U-boot.
>=20
> - Fixing the mcu_timer0
>=20
>     Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi
>=20
> - Fixing secure proxy nodes
>=20
>     Linux DT now have these nodes defined so remove them and rename to
>     use the Linux DT ones.
>=20
> - Remove cpsw node
>=20
>     The compatible is now fixed and the node is not required in
>     -u-boot specifically
>=20
> - Remove aliases and chosen node
>=20
>     Use these from Linux and don't override when not required.
>=20
> - Remove /delete-property/ from sdhci nodes
>=20
>     We have the necessary clock and dev data so remove these.
>=20
> - Remove dummy_clocks and fs_loader0
>=20
>     These weren't being used anywhere so remove it.
>=20
> - Remove mcu_ringacc override
>=20
> All these have been put in a single commit to not break the
> bisectability.
>=20
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mvWg4HxzYcmGYQde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX1gACgkQFHw5/5Y0
tyzVHQv9Fb+kWkh7QefkowyhRSs2uttIvUXQbKNx+znVye82Z50aMv8bAXm/rr5Z
itFfpxt+qIatNZdiH2lQIJF144FQ+p52JjueRxoVB5lJrp4zpmrScO2nyo9z8a3R
H1rKPWU2rLnK4ipjn7P//oNTzWc6SvrDz4n/OzDeizbnS8GYDAfHHuxFPcz5g8ZI
uDKnNufNs3qUgjti8Gowsvovee42jBRmITiKPMMY/T++OV1ffFERwbbMpdEl9tBo
dIUGGrr1HFOPKrXNSk4rcwxQEIajSFfvaTNcSp9QpZ8j1zGhTqelKxexxhGiZ4dW
gU3rp42bWyrq9PZf9kwjoBO+Z1onPqzi6EXye3prysccHddeNNKLjN3Bn9XVNemD
NSr9UKcwwv+/MxDVi3QJGj1nd25OG5ELqyvaQPDhkr3WkZkY/GaEHziQNnWqvaEu
gmSv+xDEr4SJqMcsYvx23zH2QTh95oTLMv/a9/AISEna3mo74B7Mu7TK+QSSyszU
EUdEoFxn
=bA18
-----END PGP SIGNATURE-----

--mvWg4HxzYcmGYQde--
