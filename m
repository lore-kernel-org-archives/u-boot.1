Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9602C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 14:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E42A86496;
	Mon, 28 Aug 2023 16:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEHDi/0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDF88648C; Mon, 28 Aug 2023 16:57:38 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2997086498
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 16:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59209b12c50so41551787b3.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693234655; x=1693839455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gBW+KWYqvGb9Ke5naNiJc/Y6rBiHWi+DYOzAW3EkNCU=;
 b=QEHDi/0PbkEvx8oOiMVOHF/VYujCN+dCn8I/AuS1SWPH337rSrgIt69f/NYzqAa4pd
 qNKyGxuZy5pfcbZUcpu5lNn14rXhETiOc2x8yV177LbB9xmKRQKGHfW5kEnykfqSYlOl
 Gzr5iYwa/x3AqcE2J6OgZ5yb9RWP6jDRYwpWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693234655; x=1693839455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBW+KWYqvGb9Ke5naNiJc/Y6rBiHWi+DYOzAW3EkNCU=;
 b=iGvc8ysNEgnXnnHqKsmtEyHU+mTNLwGkTvru644n7Jq9B3cFvnMCawpZVYDYnDDzQX
 88Fia8jFRYRGcepUZNl4CYJfGdiCWY9AjYQS9Rzg8nNj/x8pbFPtpfjYXW6EAzlu8ZXt
 HJicyOk7CtFWJbrpOEbu3/uSkaRIPMOWyHR0LmlKEa1CnM1+SKkbgxietjwAhDQbJ2ih
 +FACtFKdLueSbvgFYFoud2omGVVYdZlVQa7ckwjO8UN42uMUwkXOVo9ZXa334Cvgguaw
 6LOE7h8SX8FcVhLVuY4D4Sb22UE6E6LYLwCboMZaD7CWdTMqifcD3CUHjzp3qUVlVhe6
 ltGQ==
X-Gm-Message-State: AOJu0Yw6FrjoGM28IdOIaL8ZMdhqKbVFVVqPx+JUx/Emkp/FHZFb4xgo
 +TnF3VKKnxXMAv2HrJqx1b7nrw==
X-Google-Smtp-Source: AGHT+IFTQAb/ra2jgetKt+ivlRkA2L5yg1X0UTPFGeB23xSuwJ+T+HCQwthIbwtOAeKTItHiaY7TDw==
X-Received: by 2002:a05:690c:887:b0:595:352f:2284 with SMTP id
 cd7-20020a05690c088700b00595352f2284mr3258943ywb.20.1693234654805; 
 Mon, 28 Aug 2023 07:57:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 i70-20020a816d49000000b0058038e6609csm2184614ywc.74.2023.08.28.07.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 07:57:34 -0700 (PDT)
Date: Mon, 28 Aug 2023 10:57:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Subject: Re: [PATCH 17/19] Make DISTRO_DEFAULTS as deprecated
Message-ID: <20230828145732.GZ3953269@bill-the-cat>
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-18-sjg@chromium.org>
 <87pm37qlff.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CjQoq8F9px+nyPgm"
Content-Disposition: inline
In-Reply-To: <87pm37qlff.fsf@bloch.sibelius.xs4all.nl>
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


--CjQoq8F9px+nyPgm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 04:41:08PM +0200, Mark Kettenis wrote:
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 24 Aug 2023 13:59:08 -0600
> >=20
> > Encourage people to move to distro boot. Add a short migration guide.
>=20
> Doesn't this commit message say the exact opposite of what the patch does?

Given the unintentionally vague wording everything has, yes and no.
The prompted question needs to be reworded, not just prepended with
"deprecated". And yes, the commit message expanded upon too. As the rest
of the patch explains and documents, platforms should use Standard Boot
in order to boot arbitrary off the shelf stock distributions easily.

--=20
Tom

--CjQoq8F9px+nyPgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTstdEACgkQFHw5/5Y0
tyzfnQv/Uf++sn3wiAmFy0XCXDh3mxfQzZrAZwxcHoDUvMVFGz406XmJx9MGlNg9
7v67DJKFubqPFxXRR/In3RlijluSWU9w8E/1ZJ3XGQLVdrIUFrye6f0Mtn++ZLv/
O+z+IBo83/9AKTBlYB/gO3GKVMPa3H55WAYyBDYnccByD5dPr2c1VX4jbrSu8955
vHOacZj/I3wFpRnqJAHmg9PrS5CpaGZJ5Yp9ImZMKHSGJR4hifhtdYkmrHbEpxV6
UY30L7mIzFhQ2r8m3kceBQ8hwl0+3IHDeX3kORSxnSNjgdrRGMXYv/+Hq4e1o8Pu
UOhRNny4qkXrEjVKRJJTB/Am8FAWLLkUVgrVbFpPO4j5Ttr8HCjCDjqCnqh6g9j3
ueDRx6PrCzzUurcX8b6qxG1dWXmLqhksp+BQQouuTkxOGnPIJCQ+OUtjZuv6bmB8
qsccwSwj5UME6deRHN6tze9xdobTdJNWUUoU42xQkk3wcNpGx1tlR5evgxvhs7Yn
zLlKu5cz
=0JX8
-----END PGP SIGNATURE-----

--CjQoq8F9px+nyPgm--
