Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEE5C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 15:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614F687DD3;
	Tue, 30 Jan 2024 16:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U8AFVnOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EBA87DD3; Tue, 30 Jan 2024 16:58:33 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C506C87DC7
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 16:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc221f01302so3998450276.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706630309; x=1707235109; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FA5Z0MgVG+UGYBgUe+SXhzpwtDD54Chlv8ICOMTraU4=;
 b=U8AFVnObjIcuYvxXS7BLx9S5gCY34p400L3Lk4rTkMc/dQoruwiLeXaymgjEexnqUu
 5tbb8HbaZ5HDuFjRE9fx/4kLRGOnBhdJjulLMjWOnStndSpmu0MBO3geyJskSPQ21RY9
 g+Vo/oPRkcAMS2Q2npV0LUc39SZeoaQOAPYFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706630309; x=1707235109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA5Z0MgVG+UGYBgUe+SXhzpwtDD54Chlv8ICOMTraU4=;
 b=RdJ1BPpUim+TdjYKMyKGprHeHLQf4hB/0xZ1lEYXvRTkXYcTdzXZhQtPhbXKI18cui
 8QE+3O9tldgqwtMK1l2VAn7Tmx9k3wx4qMUrPvgxhQ/FdzjPS8tXQ3LcA4oeJYqWmKCL
 C1tvuFi1kfK0jQv1RqAZrazHTtdHsDO1swIWVgWpD6F6xgYrgU1EyrHtNOz4pVjb/r1L
 O+t4dtNqveDZzn/fxF72lvv2DgSHwUrBfRXos1DH6NV7e9k1eOrFLtljIqKjnMwaqx5m
 zhH8FzcyrBG9a0+oSOBNmu/p1D83+GNYxMPgb1kiLAHbTydI8z/Y2lONqWc0zAGxxVaL
 QIsQ==
X-Gm-Message-State: AOJu0Yw1FeB0UsQkF2dNRjY0ETn/SDIP8wBi/mkDPG1mOgE/K+4E5MYy
 MnkkqQgMnfqZPN+kawjM6pLO9KxIGQBlg5OA+PzCT30BJJ6Pkz0lDGq7UcNfxu8=
X-Google-Smtp-Source: AGHT+IGLGRLNaFaICMhBplPBSik+rmikabMOAwSD8xa6W5bGTfXynQ8UGHtL/7cCrvc0KHTtBWShfQ==
X-Received: by 2002:a25:e806:0:b0:dbd:1dfd:8b8 with SMTP id
 k6-20020a25e806000000b00dbd1dfd08b8mr256698ybd.24.1706630309518; 
 Tue, 30 Jan 2024 07:58:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 o68-20020a254147000000b00dc254858399sm3054474yba.2.2024.01.30.07.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 07:58:29 -0800 (PST)
Date: Tue, 30 Jan 2024 10:58:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [GIT PULL] Clock changes for v2024.04
Message-ID: <20240130155826.GS1152441@bill-the-cat>
References: <5d0147ae-e2f4-df22-d696-543aaaa01bb6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XBI6KB+UW5eOZxkb"
Content-Disposition: inline
In-Reply-To: <5d0147ae-e2f4-df22-d696-543aaaa01bb6@gmail.com>
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


--XBI6KB+UW5eOZxkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:43:23PM -0500, Sean Anderson wrote:

> The following changes since commit 6faba41927bdc8973b59678649ef83c564cc42=
1e:
>=20
>   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.0=
4-rc2
>=20
> for you to fetch changes up to a8dc4965f09d28a59c156437673ddb66860c847e:
>=20
>   clk: clk-gpio: add actual gated clock (2024-01-29 22:35:34 -0500)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--XBI6KB+UW5eOZxkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW5HJ8ACgkQFHw5/5Y0
tyxTEwv/XJXoB8xaf6cVQFs8B++mXkpgKRni0W65HAfFXaueiOm+KLzothq4eOHo
SN60Fz8IbYmPpbmQ/5UfNzx2drk4i3erQOiZBy8pRLZLS2d0iE316gygzvsoPd35
0bU1pZGVKjW8osJ2rXwXEZW0prrUBLkqZj8JcucoViSi5bI4r+MsuQdFAy7L9BlA
co5A+WRGhTT+9bd/w4SLY20AvX/Qv+1AQVpILlxXIoXjoLv/d7Ok897rh3pdXzsF
2tsS2D70C0w22sfNtFM5Rf0IJalqknxZ9pEc/FWaIfuiEUKPDmGtrjyE9+eZ8vWT
RYkkaWMrh2uFsJYINlhaX+dekOAE5hAeXBSGibu1AUKWuHjvO93Kpb3zbmmeZ7c8
oI+CHX4OGYdSfbn3xjIXHN80wDRWkT9ZrTP0ka2o/B7HtEQc5Koa6K9PFXx8ojU+
q3bgT5RO/gu3bt3wpC1dMRdp4uS+8ypewEynjyUT9VgfHOzRP2PTDy1JVptZmIMs
JVELYOeX
=1nnv
-----END PGP SIGNATURE-----

--XBI6KB+UW5eOZxkb--
