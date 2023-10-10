Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F4CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D42869D8;
	Tue, 10 Oct 2023 14:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sw8SKh9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462A3869D8; Tue, 10 Oct 2023 14:57:48 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C5E886591
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59bebd5bdadso68809907b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942664; x=1697547464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XnFR3zs9n6k4SpT7Lg38df/2mRMFAU1PleufXkjG5p4=;
 b=sw8SKh9uq08zgMOc39xKp4f/6kWQiCDv62yoTBJ9w+HrOVtm+xyiomVFODpF0Anppl
 rudF9OtgRGziLciSQGAbMM2xs0HtFmWzsmRgv64OHmA8KanD0y6ndgHGGjPoJagZTc8b
 NYC/JTlXKuHwraBTNjBzKrwrIS7rtrl7v6VGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942664; x=1697547464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnFR3zs9n6k4SpT7Lg38df/2mRMFAU1PleufXkjG5p4=;
 b=pGiOPgo4dFLiFCdCjCyprVqy6/pQLuXWbsJ7DIVE4T5rnLkD3Viv6ZqRog6K5ENTPX
 w6y186V2fhe6Dd54AwwRF+//C9mrgwKqxIo0X8M3r4AqzN/acueR5Aip4/XrP9wYcAhu
 VoeNpew1tGIoXns7WP4/lroXWR4asILAaHRG66PFtzyOvE98+1nvDJrssd4ZNmN7PKHL
 hnQLaJK2qmuNiwBdb4XU3mJn7S9Mk/mAGdOUlmjSPwn9BhHeTckWzkB/1B2hFnfVIRer
 dCT8EpX7MOoIos+SiSn3WTanCVpOPUX3uNz6yocbIe3BriQfLYPnreyC6VEWUXxYLFxx
 Vvfw==
X-Gm-Message-State: AOJu0YwkRGVrkKgN9R3FKx0mPlSowH7jeUortPHvA/JrxpLCSNG9O/Qr
 J3pKbZm54XvqcN6z2f9MfFjwbA==
X-Google-Smtp-Source: AGHT+IEtRx/D2yYY1ceODjhuup5U2jY+4RTYGksjM+TdwkwtEhXFLnIVZpU5t5IPsDQg3EczNksIeA==
X-Received: by 2002:a81:83c6:0:b0:5a7:b96e:9693 with SMTP id
 t189-20020a8183c6000000b005a7b96e9693mr2538394ywf.31.1696942664150; 
 Tue, 10 Oct 2023 05:57:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 j131-20020a816e89000000b005956b451fb8sm4359361ywc.100.2023.10.10.05.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: sleep: Add a test for the time command
Message-ID: <20231010125741.GS2227687@bill-the-cat>
References: <cf9865c45df7acb15759dc88698b63cd1b8b7f32.1695790713.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MLf0gD1V/y3SsVy2"
Content-Disposition: inline
In-Reply-To: <cf9865c45df7acb15759dc88698b63cd1b8b7f32.1695790713.git.love.kumar@amd.com>
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


--MLf0gD1V/y3SsVy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:33:55AM +0530, Love Kumar wrote:

> Execute "time <sleep cmd>", and validate that it gives the approximately
> the correct amount of command execution time.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--MLf0gD1V/y3SsVy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSkUACgkQFHw5/5Y0
tyyHWgwAi6KdbkjBSnLzPMWSnV7lgcHJyDs9ig4xo8B0rPvVZTWeOIk9wPPMglRV
AbQcLoccTIB9SsXXtzhmLQdICWHDKbar0EE2+Li6cgKQaqjgpCAi9a7BNF3MVZfE
t2cuhXyi8Srg0bdgFZjBGaqGq/DYjohxmXsvPgHkszFflowniWETanswG2uZ7nT4
ujAe5rjHNl3cnITgNzgwmj7MoswkyVVUs3tJSmXA2ioUOWGLB09cVhYpx4IQ1Tmn
rHe76SeUucGwlhYhFIrJFiWPIjpmWsEH6ydx7j6j2JiIBcn7chDqyyhFeTHv4M2X
vyOpQqVRciOT8/G4cjkcMGdip2Y0GRtKVh7NL1WwOBwNcGY5e6MkCb0IfE8Zue0V
VUW5hHIzRUnwkh7FNnsdXGWZNjkAE21MElhr7qaOPgs4NTiNSfH1H27X/i01r8R9
n8p28JmimRYKeMmgxO+41CmdrSJ/Oxmj7SVAQea8xN5gcOWWWGBMElnbVVQzwy87
tS7F/raj
=8Wvz
-----END PGP SIGNATURE-----

--MLf0gD1V/y3SsVy2--
