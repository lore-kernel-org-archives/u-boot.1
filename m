Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77E4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857E887CF4;
	Tue, 31 Oct 2023 18:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RRLzm1bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2C787CEB; Tue, 31 Oct 2023 18:46:10 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB40387CE5
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77a453eb01cso43155785a.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774362; x=1699379162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=owMRWyMFmIx04FT00+MOYAccnUl4lD5qlmtAXeL+Owc=;
 b=RRLzm1bzYtqeypMoX/TWWCD3Ax/Y5Q5cTEWt+PZZ8k93k4Kst0RzNgDmqjmGc63WvH
 xs8enAx+hr6kxU1oGMuaOGt1Hk5HpQLZgTAtGHUumlWSYe1ywYSezXqZUWYoO1z19Erg
 ilFyQeQ6Dq/VE5tsGZ/vAIWJ0kyfL1z/9Dg7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774362; x=1699379162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owMRWyMFmIx04FT00+MOYAccnUl4lD5qlmtAXeL+Owc=;
 b=ffypZYOZHGeMLfCMtBbS4tvMAou4ONySSh84PewihR5AS8eXVqPtQncSVLBFhz7u5O
 mRD0DShZM6wJ+uQ0HQD7eJZTTmLUJBsSlfovdkQHlw+Z2MxMR8W+fipbgWhna3nXFbiF
 PPt1CMq9jQJXPh0rIq7Aoh0qmZJdHIXH/r7a7DAZHvhRx8ODvEwcMmJrhrqU7g02lcWt
 MavR6cR5PO/yNU9WXqn7abt6qAOjlDcU3tTWrAm26BXtGg5rdDqh2hRlsH1ZpQyfLCJ1
 QYffWZLAUlhaMlpDUGFxwjT5jIZFWU8vqgUpYnKbMPnjznUPWnqYGYE89zwXj5KC765+
 vWgQ==
X-Gm-Message-State: AOJu0YzQtjUDw5aFfwT410+WotSxZrjFYaYP1pw8Pc2ph5Tuc2ya1Agb
 g+B8jCLJsLpYcK8FEQOHbtgYQvxmy3rE65oaOY1+AQ==
X-Google-Smtp-Source: AGHT+IGzs6N7sWa6aRSg2Xt0LGZ6p4uBs0k+yyLh+exmcj/NTOaRkpkL4iiBeK9wbbxuuW3wyKwShg==
X-Received: by 2002:a05:620a:471f:b0:779:e517:f425 with SMTP id
 bs31-20020a05620a471f00b00779e517f425mr15098238qkb.20.1698774362101; 
 Tue, 31 Oct 2023 10:46:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05620a134500b0076f1d8b1c2dsm701087qkl.12.2023.10.31.10.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:01 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:45:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>
Subject: Re: [RESEND PATCH 1/1] clk: ti: k3-pll: Add calibration support for
 non fractional mode
Message-ID: <20231031174559.GS496310@bill-the-cat>
References: <20231023133546.32283-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h7NBjHR0o4ohlqXo"
Content-Disposition: inline
In-Reply-To: <20231023133546.32283-1-vishalm@ti.com>
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


--h7NBjHR0o4ohlqXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:35:46AM -0500, Vishal Mahaveer wrote:

> PLL calibration needs to be enabled when operating in non fractional
> mode. Add the sequence to do a fast calibration when using PLL
> in this mode.
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--h7NBjHR0o4ohlqXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPVcACgkQFHw5/5Y0
tyzLRgv+Ju4NAfZABC7iBo91NtVIhqkCD8XUbXOgpPF+JTCKYONbwcvBSkVHzuKm
MR0HrpxjzB9atKOyE2SZFy7LyAsrSzFvMw3pYtk/NwhAQT0Px4TTlajfB2kf9Mov
tb+zY3oft4zs5cSSkfV5gxQhubH9Xq1Jbw1H3yBq/cKv6HZcvZWyqVw9KgvHmD5O
BqefMZ53hpm8Jo5Bn33G/d7lRx4v2JAedPBG6NNqOBl72WChOs9yXOKx76quYUkt
aTQUCLRPb5zZu9HMXDgjLCFUfRtskCzx4elbsFw5hPA0MINJYZHLb8xV9L8x53aO
yqhqCYD86UyLTdkR1CzMK0nG52iAWHkZxUIKXwLVfK8tMqhrvoA0wDTtvMQsbOTL
invgJtmr8tGjgcXLh5msHMTqS4X0zHjvICWWrvrd3R4ecOO9vWZ3TSViv/9K447T
RDhXogTq8iQK1RwgINHEH2hZfl2EpjY4jsD8I+IJKgYxwFkLOfmbc+oiBhWMLE8p
kRhK+fwa
=RIV1
-----END PGP SIGNATURE-----

--h7NBjHR0o4ohlqXo--
