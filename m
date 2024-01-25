Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E05C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6338783B;
	Thu, 25 Jan 2024 17:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a1eOnIQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6336B87B8C; Thu, 25 Jan 2024 17:14:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0883687B58
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-60032f9e510so27247007b3.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199262; x=1706804062; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u0SqUiK35ke15qZJLOB7RQJM03JxtYknqnnDhq4ojaA=;
 b=a1eOnIQUhBkBLMRdjCEOthJpysDB5Mg9U+Jh3fWgztgs0/jXixAlJWWvhAVwf7ZF6q
 lllAXuDFiex8NS5X/YFk9Awb/VSryYbzxqCnd/we/v5rqMpmuKtEHa6JgnjQSzDIFH4/
 UxiLhQ8eJA5TOQ8E/cqjY41AN92VrytcSyhrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199262; x=1706804062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0SqUiK35ke15qZJLOB7RQJM03JxtYknqnnDhq4ojaA=;
 b=DjwRxtjpqk6F9KI9MlC+/V7eA5pDxRh53lYzFvq4GHQoUvOL39N9kqXaDF4+/NRbsm
 bHkQywnDTkO6c7MKVryV+KMCvzLOyXrQWUO2Rk0zd24pDNXDfO1bvRRMvr9JKXHkThh6
 v9r1BYTUl2X6nH+jXPfRxVrV5bjAloPT/XkfsFSPOAQEmFzF4Qof54eZABFGCMCjH06R
 EnrjQHxf+HfBik5PqODOaAjPtKIyqgRzjeAOjjueWleQxz04/uBIqQd8Zh2pbx6bi8IV
 DhBgDN8Xg6fRl1NrF4GmYkyStt5TCffHD2izImd4iE/ZbnRYOrCfxGvkWh61u2bA2hsA
 3AYA==
X-Gm-Message-State: AOJu0Yyb/zdJt5rwUxt19QP9Y3hSly8XDTYfyoZl5UcCcwp8pyWVmij/
 bgdP8/RwxE0jiPDXh5cZ0VKlgN6d9hzoypZoqeEjXs3+qU4cJ1OI7glNjL3RVDE=
X-Google-Smtp-Source: AGHT+IHgaUlrALMF29MBbUS28zs3ylQAfT063AwlBe7ZxnMuldf2HodpbP1/TckElGin/FDST7rS6Q==
X-Received: by 2002:a81:6d15:0:b0:5ff:8fae:aa47 with SMTP id
 i21-20020a816d15000000b005ff8faeaa47mr34912ywc.55.1706199261853; 
 Thu, 25 Jan 2024 08:14:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n6-20020a0de406000000b005ff8179bbfesm739573ywe.104.2024.01.25.08.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:21 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Yurii Monakov <monakov.y@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Harald Seiler <hws@denx.de>, Dave Jones <dave.jones@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: increase default for SYS_MAXARGS
Message-ID: <20240125161419.GO3652023@bill-the-cat>
References: <20240115134656.50917-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7sgZep8pwqcHFtjf"
Content-Disposition: inline
In-Reply-To: <20240115134656.50917-1-heinrich.schuchardt@canonical.com>
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


--7sgZep8pwqcHFtjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 02:46:56PM +0100, Heinrich Schuchardt wrote:

> The value of CONFIG SYS_MAXARGS limits the usability of the 'for' command.
> The current default of 16 is too low for some use case. Cf.
> https://bugs.launchpad.net/snap-core18/+bug/1910094
>=20
> Increase the default to 64.
>=20
> Reported-by: Dave Jones <dave.jones@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7sgZep8pwqcHFtjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiNsACgkQFHw5/5Y0
tyxZAQwAjC08eR+x2BGvjprfBeZ6P2WQF6a9/w3+YfobPyVi0ZN3PhkAcpdui2+P
Wcx8QUTufjHwPR10qKIBnX0In8sma4mZV8UsnHOofcyrNbeTpZ6BpvG16LgRhq6A
TtHb9+0LuJUwMe02O/xl6TYDMik69nXr4klqjdSH3Up6eO/FjxsiXjBQhiVSNOUx
pct/wuANKyHOjPJkYq55stH2lHXegxq3DGlXgfR0M0iMqXm3vnJCAbBB7omlExq8
HtcuRo4RoU1nbTjphQUlefp0PohSrcxJfKyQN2dyKDGjnd05tdh9gNkHVMY/9gqk
8jT6kZfd/7yw4ETowrr7IPTsdUMGiiUcl6SFc6CDhlrzE493yOPA58gOOFg4qqwA
VDttvNj18DMQ4LW/pbdMD02xosiTJTG9OK6+5c+/UsF7+kUzM7cHiRydGD/cBqbC
c/Bp47aNyWNsGCjDbJsK7YzVr3hoShAXg7J3/t68OXaNWYFLVBiP8C9YTq9KVvdW
JZr84aN4
=svMF
-----END PGP SIGNATURE-----

--7sgZep8pwqcHFtjf--
