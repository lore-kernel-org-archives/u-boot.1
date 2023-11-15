Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C07C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19858748B;
	Wed, 15 Nov 2023 23:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KgcQv/Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD3087489; Wed, 15 Nov 2023 23:37:53 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2748748B
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cc44736f2so1191001cf.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087870; x=1700692670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3eHo9VmVIsrM2PemohLVK7YP35N9N3mjQvWWm9HDg0c=;
 b=KgcQv/FzkzTjyh6m5Hlc5z8VvWezb8ItpEaUM2jD5TnA0OeRgH/KSk2fWwJXUWhHcn
 is73yvJ54oftX9LvUHsVa+mwo3heWUFOvV2TLknLCvs9zWRuMsqwyh9IXi8ISZ7cK7yo
 4xA6rfFlVQ17e+mOsBwCAT4CTGbx/P41rDu+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087870; x=1700692670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eHo9VmVIsrM2PemohLVK7YP35N9N3mjQvWWm9HDg0c=;
 b=Omo5dEGIMYzSPMD8AyaKwOB8LL94ZI+nc2QYljKQO1OPe+gElhYxOmP9ZeR7CaSijG
 Muv90LMS98dRtNemHMdKiPKI2XcgObjUhCzjit7gQCtgMZDxQlhDSDW75XMDyvT4IlJJ
 l0Fa2QY3PebaM9JhGaQQ0wU5zJqBzn/c8VOs2sa51QkD6WYTny2GzojtHvG0imB/vFPB
 7RUguAOmFgn512oTX65eQZNSgzOOleX0pdYPUBqjvHbumm+o+sFtHUN1H2NjYsIISaaS
 FfRjCK2mVi5QOjL+HObhI0IBtHY1tpbn1wr5Ne97i9kbPZKAdXoEeEXE96a7WIOzFheR
 +inQ==
X-Gm-Message-State: AOJu0YxDrUgk8YtL2B+VgmboETxEzhD7E3CgeYED382hdrPA4JvelDLk
 EInwgw8VZxnutyu5TXYzmcJNCw==
X-Google-Smtp-Source: AGHT+IEseAWzxlJ+9W7O+N9TK38WGh8GHO4Mx0fmoIgjWPut8CIEqo6KRjdsQua1DqSqfh145lx6eA==
X-Received: by 2002:ac8:5ccc:0:b0:41c:e02a:eba0 with SMTP id
 s12-20020ac85ccc000000b0041ce02aeba0mr8947791qta.17.1700087870070; 
 Wed, 15 Nov 2023 14:37:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 r5-20020ac85205000000b0041519614354sm3877127qtn.7.2023.11.15.14.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:49 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 23/29] bootm: Reduce arguments to boot_get_loadables()
Message-ID: <20231115223747.GC6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XddEE6wMaTV6NgZ3"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-24-sjg@chromium.org>
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


--XddEE6wMaTV6NgZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:08PM -0700, Simon Glass wrote:

> This function only uses two arguments. The 'arch' always has a constant
> value, so drop it. This simplifies the function call.
>=20
> Tidy up the function comment while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XddEE6wMaTV6NgZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSDsACgkQFHw5/5Y0
tyxeHgv/QtxyFWaf2MX8LkmNwY7tKDjKEBoPRk5L1frk6euuJ6wY8XyD1LZtw87K
hjFu1nOsKc/gs5/JPFWrNXhclkbyRo0uJusWqzRadUQ7Ieii7St8iy3+Sp7OnOKb
W5iOPNHeP0g1qwyZnXU9N+2DooTLnIsid+4jdY5J5ocCwdHR8mj/YNeGkwcGJ614
6XZkpDxLvRPtswn6oG4Ps1XdBagleHS/W3pvpPgzq6zoKDr+KgDNA3WXPFrDHWUj
Zp6MxOoOkdGBx/T8RxJ9PTWmEd+nAsGm6GFrGXsx2aoQyI+SZPFjeiRsxjT6o6Kt
nnqPvUfd/TbiiHpxsQbXNq8IXgIjAkXE9lRj9WMqoxho+liZ2GJzAsObazSchagW
6kV0dcYuTR6BeHLmqRbOEx/ngkfoDZv9Y1CbI+0EaRbagudiBHWn6P3MgJdQzcNm
ueyj8WaI5zOo6xaRQ5V08GiJmr/5cZ7tLK8DRoXtkSmEo8kSHTBrmMX1u0YhP3bS
vfxSF2Pe
=eZTQ
-----END PGP SIGNATURE-----

--XddEE6wMaTV6NgZ3--
