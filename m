Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6307BCD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9780586B6D;
	Tue, 10 Oct 2023 14:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R0uQRjMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF33869D8; Tue, 10 Oct 2023 14:57:33 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37710864E7
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59f82ad1e09so70309947b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942650; x=1697547450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vd98yXxk2VSOLUlCJZXlSFoFu8631d0SuAqZFlgpqDU=;
 b=R0uQRjMtLLZdROk1MvSwZJehncA8qargo9pQ2/Hj6f13tkPWOSb9gcCvxeqD3O38sW
 eBqfOjnQuN8qE+BAbgSf7d5BfvSsT8xy4n+rZvR/yOcdcvcEnb32z2ytJvKRl8NLnUkV
 i3h7QMNYzIONcL4Lt/Xg1vnnw+h+kePvgR4lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942650; x=1697547450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vd98yXxk2VSOLUlCJZXlSFoFu8631d0SuAqZFlgpqDU=;
 b=PIEWkRQqlkjgXfjWSf/1/y8HXEMT4+rVGzo1kaoFzT9yv1VayIdjpktVppazo1/ux1
 ity3szKR3TnmyMoirMkvZAj/2uQwkmmmiQWoHkm8izbmnZvSZI/v/Zc578yVUDN0KIFt
 u1qhXtdmOFDxeOzDEK2nSGAVfyRuQ5+3HUXX6ea19H4W2irw6hKMHG/uaixKkFsLgvFm
 9zUXrJqazT7wAjKy6Y6uUZ+cuim/GSVMcY4AjKfr48CyMhhQsIqk5NURmgZOWPwOzoBG
 /EIeltT0D0m16PLrwIFdoqYwUhFszGpEMSCcAtP+D1JohmYYIiiyIrJRes0ZrZLoNo9V
 I3QA==
X-Gm-Message-State: AOJu0YwxBUCqi2GzmgYlhnBJUwJTqoUfzqCObtxs5Tb/hm/P+ConymFL
 y+n07GfKpoQmKPYP0yb+zRSb8A==
X-Google-Smtp-Source: AGHT+IHHFr1XvXgHHUBvCSm342THHwfkqSMddNWJixTGiqApfiATSgGDfM8OjXR+trZMpaYWSTE8sA==
X-Received: by 2002:a81:a0ce:0:b0:5a7:b10c:4772 with SMTP id
 x197-20020a81a0ce000000b005a7b10c4772mr3494617ywg.19.1696942649983; 
 Tue, 10 Oct 2023 05:57:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 f187-20020a0dc3c4000000b0055a07e36659sm4346125ywd.145.2023.10.10.05.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:29 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Chanho Park <chanho61.park@samsung.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <20231010125727.GQ2227687@bill-the-cat>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mUMbqvr1Tpi8Ihgb"
Content-Disposition: inline
In-Reply-To: <20230927214415.2224768-1-jonas@kwiboo.se>
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


--mUMbqvr1Tpi8Ihgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 09:44:13PM +0000, Jonas Karlman wrote:

> spl_board_prepare_for_boot() is not called before jumping/invoking atf,
> optee, opensbi or linux images.
>=20
> Jump to image at the end of board_init_r() to fix this.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--mUMbqvr1Tpi8Ihgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSjcACgkQFHw5/5Y0
tyz1Cgv8DRtZgW2TsjNPbU3zJMFo+DpCK8iXHyV8JkOYA2AweMxc+PGpCFmA3J+7
bTYtZ57yoXhdn+qUiwAhceMZsdiwAmZEYma4Dl63dgpINnu2y4hYkkSrhAfE7z5q
NjDxdDGbjz8sdB4dtO7bigoAXa17Zu1gwIyycu6T7YJnECW3dpILNO0PyIh1Og2Z
EvF5yEeSBRE00SI2Kx5CeUCRpt/wArc7GA0bW4LS61GQR+tj40myCIU5V9F/31SK
TwfFwuF0+d6fHu6UZPOLOi6ef90KrA6rk+b+UN30eLzFFcgkCTr8aNOuHqD2UmPj
LWPNvP3Wvz4u+A/V/PI0VdyoNYrpL4N7N6BnTgBSPPwV2nBgrLEZWpV0XP/hO4R0
T2iHurv3PYF3smmJ+ljvf6Xz2zTHn8748xx5YVpiinAMkjtq2pf4QLJG1hZ9SIlz
FxrlgrK93fOCd9FJGwY0Ox5mOZR4wLNvfoSEQP31PI8aXKKwGFg6SbDIb0nT4oSp
eggMmmxx
=IxZ8
-----END PGP SIGNATURE-----

--mUMbqvr1Tpi8Ihgb--
