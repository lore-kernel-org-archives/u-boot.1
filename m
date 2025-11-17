Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616BCCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 15:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36A883BA1;
	Mon, 17 Nov 2025 16:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cYTg8XSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E9F83BAD; Mon, 17 Nov 2025 16:38:41 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C178399B
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45033024e45so1800685b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763393918; x=1763998718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EPvWPmOqRQfbDdKbLw9aAaCUxel4O/eNvBS4K+cHwCk=;
 b=cYTg8XSEvKXo0f9DbRLWyfQYGfI+pX7v7uR4H7wWx2V6YPaA1sdfj9pU3fP6Si9KnK
 iecTYAfpZqW2wisPcWtok0FIiUTYdgce7V5UEmpDmv1FSXIrNKaWxO+1aJflk21LqE/0
 JTZfV5A0t6Zf6nweyQFWvvCZ4OtCQf43BTPQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763393918; x=1763998718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPvWPmOqRQfbDdKbLw9aAaCUxel4O/eNvBS4K+cHwCk=;
 b=gIQMMPNueze3LLyJC32wgytk6CETP+uH8OBe+C8yHNuAezUr3mbrav4pwm/EIXpExB
 vq651C2pzKMUo24jhsc9fDbmrVIhLojxHdSg03a2PBpyA3rFb1iF6gvumghi0qYYTHlC
 OSDrcbwjDev7aQRsG29nWn7C1P+7BJzIigIAlJ5BMvvux29Q/pUxs6VfUbT+p8K26mVD
 DPW0PCdDWjJ1tzCr21KfZLjPjfcfcNrwpjJ/AF6KjFFaVv3OCPk7M/LAvSPO3k6ijYdA
 om+b8zUXn5oZRuIKPxATSGDzIzfF9BpnS1JR+/fsEyWO7pLJ7qxNNhLOQunj45EWznGm
 0ppA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7AOKGMc3++YRT+LMvlEUQ9zCBHROHrwBIVByoq3N2kNfU86Sr2cQ3KoegCtBnJm667NhNbow=@lists.denx.de
X-Gm-Message-State: AOJu0YzN4hq8/KHOmvhaEYbqpEKntJGjGlqoCth5FAhzL9+TAPSQHOCK
 Bxpn3fUPmYkcLE91hPz9Pmmo941vn89acWRfjZC2ROyNeNa52i1N0eh6Q1/DLVmaR9w=
X-Gm-Gg: ASbGnctiS4IJf6RRIFrCtxM3/cupgexhpdzh76IdgVCmOdqLtTFTFusCDE4YQuxC49b
 NE0rIWvAIEEhuygeEZFFwuprlfLen9BvuMFzEjx4PpKh/av5loaE1BnPkhRRf1TeTTioaNcpYb3
 r80IJfDwvmgUDNLI6kpQ9WiGIcoqaV5WZUsGSAxWyO8q/rpKelYSfyxCsaeQ7uMQAvtc909FCV+
 ePAjfTwd3A/aEYhIPcB3s0+ItPYk8SJSd1E3R5SZGov7zw8P7/ubEgZSO8fYLMPGgz8NxkMM82N
 RLk4kcKyjA1Fo7vaP2xNghxByfABmdql/YxcbUkhFgf6bvcNEVZW0QOpbcwRJMM9AJGcX5Qrt1Y
 bik03oTRMHKMObomnnUfhyj5o+ejwKzFTcssXwIDYkb1z7zuDdtWd3kFBJqNwF4Vm/OIRGeGu20
 bbHVyf87fjP4FBCMf26unnQ7zNqfV+ZjnoCCuBKR4ueBc0KLj61A==
X-Google-Smtp-Source: AGHT+IGnh9jUJ+crhLjonPSXqwnfMfRWQTH8iz2Z5kg8RpJsxq8EBEAF6EwBW1YKRgIDSAag5vscUQ==
X-Received: by 2002:a05:6808:67c3:b0:43f:7dee:4693 with SMTP id
 5614622812f47-450973eb5cbmr5754644b6e.14.1763393918367; 
 Mon, 17 Nov 2025 07:38:38 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724dd81c5sm4513235eaf.14.2025.11.17.07.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:38:37 -0800 (PST)
Date: Mon, 17 Nov 2025 09:38:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
Message-ID: <20251117153834.GJ2125796@bill-the-cat>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
 <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
 <DB9PR06MB85123A4CF4B3A698386F9EE9CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
 <CALeDE9PswgDAG=1Ouy5W02FKZRFskqc3tx967SVms+MTL8Z1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wDUD5ul4lNy9vO2I"
Content-Disposition: inline
In-Reply-To: <CALeDE9PswgDAG=1Ouy5W02FKZRFskqc3tx967SVms+MTL8Z1Ng@mail.gmail.com>
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


--wDUD5ul4lNy9vO2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 03:18:08PM +0000, Peter Robinson wrote:
> On Tue, 11 Nov 2025 at 10:14, Wolfgang Wallner
> <wolfgang.wallner@br-automation.com> wrote:
> >
> > Hi Peter,
> >
> > > > This adds support for using an OpenSSL engine for signing a FIT ima=
ge.
> > > > To use it, one should set the fit,sign-engine property at the FIT n=
ode
> > > > level with the engine to use. This will in turn call mkimage with t=
he -N
> > > > option.
> > >
> > > Just to be aware this should likely be a OpenSSL provider, engines in
> > > OpenSSL are deprecated and due to be removed in 4.0. A lot of distros
> > > are already dropping support for engines. There's a patch [1] adding
> > > support for Providers support to U-Boot, I suspect we shouldn't be
> > > adding more deps on the Engine support. OpenSSL 4 is due in March.
> >
> > I'm aware that the engine API is deprecated in OpenSSL, and that the pr=
ovider
> > API is the way to go forward.
> >
> > But the PKI provider of my employer currently only provides a PKCS#11 l=
ibrary
> > with an engine API, and I'm not aware of any plans yet if/when they will
> > be supporting the provider API.
> >
> > So for the transition period it would be nice to keep the engine API ar=
ound as
> > such use cases still depend on it.
>=20
> my comment wasn't so much about removing engine support but rather
> having parity with the newer version so that when users upgrade they
> don't end up being stuck with broken functionality.

Yes and I think an unfortunate part of the problem here is that it seems
like the hardware signing vendors haven't committed to a strategy yet as
it's multiple reports of "my vendor has no plans yet". So we'll need to
have plans to support both for some time is all.

--=20
Tom

--wDUD5ul4lNy9vO2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRtBdwAKCRAr4qD1Cr/k
CgH4AQCV4PUnmDFHv/JDPu1hEifS+lw5pdxiGKNelnmp2zeMRAEA07tz4qlqO1gz
F7YuxiIFvJNHl1CnkTARpmgJHDur7gI=
=9x8M
-----END PGP SIGNATURE-----

--wDUD5ul4lNy9vO2I--
