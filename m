Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB9C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A7C87D47;
	Fri, 19 Jan 2024 17:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DYzlqEQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3EC87D44; Fri, 19 Jan 2024 17:09:15 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB0687D42
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc250cff65aso779562276.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680552; x=1706285352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+fcS6OAKg0aVxG19grbVKC6aIyGsPEAJHAiA4bZgMM=;
 b=DYzlqEQIPszt8DyPp7Msw4AdnmqO78I9UTtRdxbOqUh8DGmrb38QQ2Q9ln/umavRrY
 snJ6RER6uSiA13d9FCE8AqA8xhh7VygH5jNzbsKjh0C7Brpsa3dKU63QrA8pQ2tYeM/s
 0MktL51pMWq7DqWgS73WRoI8iPv8B2Tta2lCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680552; x=1706285352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+fcS6OAKg0aVxG19grbVKC6aIyGsPEAJHAiA4bZgMM=;
 b=KNCqKUrpzQpMw9jFcLPeBGidd3Jy9CePCqjKzIX4CaW/o1a5oOP2RfYBoaW+/kBOfK
 g3Pj0Y1adVk5u47eR100kAWkxioQ8LEqWXIgoBsDK3n6gVHcxqQ/reHIZ4YAbNpGOtoF
 cJ1xQ0cIgAT57RnNaQwnnBacWs6glZi29WtwY7fuPMsMdZYxPYDqaAcqZHX6rl8ADFSH
 GoDz/yVCujQjBPlgmrAje0WTGZvl3H0xc9q08JKEQiPC7eGHrHUMwNmj4uNn11dxM4tv
 vXu7VyO1VhF6+H1iHqV2Nkv8t1Cb+2os0rNCQBY8m+tjcYUZOwwVTUOVdi9gO+322VAd
 xBEA==
X-Gm-Message-State: AOJu0Yx/3PfaVqMZTu/47P0XmS/pBzA1lJmjMzB8VzvyVcufAH3FjAI1
 YV1ri86kBvvzkcAVJc2e5rSuAG36hvM7yQCugMAwbHWv1lCy1cH+LgmWgjbbAHo=
X-Google-Smtp-Source: AGHT+IHm6N8t2Q6wm8cZyGg8XelbJX1tPmollkt+NI6Kf9veZr2T7OfDEIP/5lO5rCmfGuXZwOyisg==
X-Received: by 2002:a05:6902:2484:b0:dc2:403f:e3dc with SMTP id
 ds4-20020a056902248400b00dc2403fe3dcmr136546ybb.1.1705680551351; 
 Fri, 19 Jan 2024 08:09:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 g138-20020a815290000000b005ff8d24601fsm1195112ywb.124.2024.01.19.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:10 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 1/2] smbios: shorten sysinfo_str declarations and use
Message-ID: <20240119160909.GW12635@bill-the-cat>
References: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F9aiaq9oKNgA0ZVN"
Content-Disposition: inline
In-Reply-To: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
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


--F9aiaq9oKNgA0ZVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 04:39:35PM +0200, Ilias Apalodimas wrote:

> sysinfo_str is a bit too long and makes indentation weird. Shorten it
> to si_str.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--F9aiaq9oKNgA0ZVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnqUACgkQFHw5/5Y0
tyzhIAwAlcGSBCOIADaO8PWL+0HUJpf2ZoARXd4tLD5KUXv69/gK2k+8Xg4Yk6p5
NzTpzl3QNur0acreNMs1d/5WOUNZUPtB8MCpzb87c8zVEcfrBABB9lMWkBr668FT
FghxevMoqmllvSvnq9ve7CuzYdNrtWAiKl+7FCRA9M22v6OF0lHkJ7UPFkQrxQJh
iOuv0enJ8c/zD3TIZIP4lUAWwpaE/EfgJoycsxihDBjpz79AZG+EfWNXhGkFqP0E
6J2seiWUh3U0bovNNNl1MMgyfI3gg4wEx5XyD5J+MS25+iaozEdPNrgmO99BWFaK
SVxb7097sz5d0WGRqKvAc1KHzpraw3N8SAEjAGaXQrrAeaL4AxE4rG/pWCyYoXzA
8aXIEw404643YvbgjlkmUmXItI4ZSsEkdU/nJKTcc6Bkh35S6Tou5NlN12Vs5x7s
JON9BSPKmHOY3IwYyY91AnmDYS0mk7bqYcVJpNqK0jdlZYI4kivTlXM4ADRsTdDy
scL177O+
=z34k
-----END PGP SIGNATURE-----

--F9aiaq9oKNgA0ZVN--
