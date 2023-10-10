Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AEDCD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECFC86B87;
	Tue, 10 Oct 2023 14:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PG/Vsfzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2D5864E7; Tue, 10 Oct 2023 14:57:45 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900BB869D8
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9a518d66a1so939944276.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942656; x=1697547456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j44wxk4R3XggWEx/l7vXT51uO5x133CBI41L5Fqrwqs=;
 b=PG/VsfzrhCvw9Y5UeK8eLko6YDUk+qcNadUygTdCllc9U4Uzjqq9635Uyj/q1sY5rj
 BVBeOU0r5j1VyXHR3v7P90aOAdWo1l6NyXa8Z7A91fy768a1zNZnEN6gcI5JETw5U8/c
 KMim/2XKOXZbZAtf+7wr3Wj/PTzGVgTJH3zLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942656; x=1697547456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j44wxk4R3XggWEx/l7vXT51uO5x133CBI41L5Fqrwqs=;
 b=SOA7jCqhHOU8EoADILbRD2OrEtx77G34gR4shvTZ4saCz9DVOM+xlIUNL+nZ+ymr6H
 SdShGtT1epH+c+GSnTzOERIyLsL3LIZOvZvM81tlQbSnfu/upZ+xa1jEafAriLgwT4sq
 K9dl7sfKJ+glZyPfo+R3KwCCk5wFMO3jVMCqjfJGkkVxD3xLED2lXjAREvZ2sIYuTgat
 6VRabQtQcEj6ry1NjCcMrpKZ6PI6L9Dk+TbIzhHVpbWdgpP4s3oTZzXboKyqXntnmVlg
 TP4gntCu99JulPEM3eVSPFktQjKsPRPmg030qo362M9aUN5MyfKHTAo31Pd/Ew+qlPBf
 YonQ==
X-Gm-Message-State: AOJu0YyWYgMG2bLKN+m9YMAAC4OzWQLtRXnGTGgFvDBl9fETtY8fKw3e
 5D4R4U6em1oSzqEMYeYgo+K9ww==
X-Google-Smtp-Source: AGHT+IE94Tyd9Kbw1fv3+DPzSFNS09VdA6fk0Xl84fiaCyvKQP62GVjJ6qgyKsvxBfchhb94m5quNg==
X-Received: by 2002:a25:8387:0:b0:d9a:47a7:f7c1 with SMTP id
 t7-20020a258387000000b00d9a47a7f7c1mr2597636ybk.42.1696942655835; 
 Tue, 10 Oct 2023 05:57:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 x142-20020a25ce94000000b00d89679f6d22sm537306ybe.64.2023.10.10.05.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:34 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] test: Fix SPL tests not being run
Message-ID: <20231010125732.GR2227687@bill-the-cat>
References: <20230929160654.3475279-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WfxaRBODws1FSzJ9"
Content-Disposition: inline
In-Reply-To: <20230929160654.3475279-1-sean.anderson@seco.com>
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


--WfxaRBODws1FSzJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 12:06:54PM -0400, Sean Anderson wrote:

> SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
> tree. Don't skip them even if they don't use the devicetree.
>=20
> Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used=
")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--WfxaRBODws1FSzJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSjwACgkQFHw5/5Y0
tyz48wwAlTDQl5PF9tcjeUm/ys1r9ELlTtG+p++f+Ucve6JDSZ88MG2clY5wKxc4
9FL8uqaNp/WQ3l67xSqBUcWS1843q1jkgBJIeYn+hud2SOI2lVDiYq0x5Z057QH8
NOU4ZsEo5LhxJau+y9GeiESaWUrth9yNOb4eilYzUJ58SJWpANo4hK1qh63fcSHL
8o9xHwmJrg5P4BsFMof0epzEMuWV8QakUCVYawJnVBJb2o47yfG87afQygQU1MV4
4Kdosz+Y8ps06x3ZqoWH896gqD/kdHQj2PIF6mAQ47M2Zjk9dGI+Pir6Mti9oYn4
yO8Cj5Ve1xhCHNUgMJAkq5bGL1DoyMKI3P5lrWwAYdyCNc8ahnn561AaWRM6h1dX
3VhhSaCzartl5zlGZg9YJ8Whk4Sd8ViUgmfchylCxloY0zD7F2mXZQnaj/CUos4N
mewZK2HfogtIuIAcP9joGRp2luy4SkOR4uLSfMEyVuuv2Ma6WPF474f1IWd1En76
ypA3CwbC
=RxNe
-----END PGP SIGNATURE-----

--WfxaRBODws1FSzJ9--
