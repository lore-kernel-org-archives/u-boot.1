Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2631CCD54BF
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2452E86B53;
	Mon, 25 Sep 2023 21:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o2dQ8MEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B8186BD4; Mon, 25 Sep 2023 21:46:17 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7810F86A88
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59f7cc71e2eso33069027b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695671174; x=1696275974; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YwLpC0W5KFW4VSSduqjOCcL0VPrRUWrmZPy83U2aTcQ=;
 b=o2dQ8MEZz0ce3it/pQ6v1JQeTbJsWDF8z6wwRjlAovPIH8qSSoVjrsF+IbeJE7NJb2
 3m0eTpEjl+SCp9uhoqCzhw7fQujwI9f2MQPPjMDJgpsEFvmxXgKVjAyLAedIdHrHS4mK
 hCEVDCKtpMce4z1hCU01W2qy0CIYM/yu4iDI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671174; x=1696275974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwLpC0W5KFW4VSSduqjOCcL0VPrRUWrmZPy83U2aTcQ=;
 b=Fx+Yc/tAiZ3pcAbbHyYcXAfTR7TthLKu5mfeE3fNFNaugtE7nJ7ehQghuztnRWay/V
 vsOZ3TqjDJ3JTBeRDC+lSredjZC2JubdGn7myrUfwC2/3sqqsH3mdEN47a+lRXdg2tUU
 jLy2KIbGvoq1HQgSZXf4wTUNZgWSQlb0lMVhzXj4AFn/rGtV0YOH/TtUwxRh/NP7LQaf
 376EW4U84wK5xIPVZaNhg80pQhvD9JqJ+1mw/Bfj4vos5W7eA/nBjVVUlos7XJZAbC/G
 NhBXQo9xf2oaoO7ZMxo1Lc3dIOK4saQgQWWLpnOIv+QmjJ0xKp3GNB16y79qF7zv3ym+
 v/Nw==
X-Gm-Message-State: AOJu0YxwsJjuVmtnGLcBUQMKvLjkxDSpvtQYK6Wg+xyIPYi/3wMpZHMV
 asttUwnRglgxP/u43AyTjEHXvA==
X-Google-Smtp-Source: AGHT+IH5m7ATmezJCdWb1J7xhHpn2Gt9EVsT6K/gmX6YquXP0XPvUWQejXMWgRNZJA+3Pqt7HwazLQ==
X-Received: by 2002:a05:690c:2c8d:b0:59f:b0d9:5df2 with SMTP id
 ep13-20020a05690c2c8d00b0059fb0d95df2mr2210516ywb.0.1695671174202; 
 Mon, 25 Sep 2023 12:46:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a81a211000000b0058c8b1ddcc1sm2550099ywg.15.2023.09.25.12.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:46:13 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:46:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 08/38] spl: Create proper symbols for enabling the
 malloc() pool
Message-ID: <20230925194611.GN305624@bill-the-cat>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gx38HXrKf5hV++Ky"
Content-Disposition: inline
In-Reply-To: <20230924192536.1812799-9-sjg@chromium.org>
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


--gx38HXrKf5hV++Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 01:24:53PM -0600, Simon Glass wrote:

> For U-Boot proper we have CONFIG_SYS_MALLOC_F which indicates that a
> malloc() pool is available before relocation.
>=20
> For SPL we only have CONFIG_SPL_SYS_MALLOC_F_LEN which indicates the
> size of the pool.
>=20
> In various places we use CONFIG_SPL_SYS_MALLOC_F_LEN =3D=3D 0 to indicate
> that there is no pool.
>=20
> This differing approach is confusing. Add a new CONFIG_SPL_SYS_MALLOC_F
> symbol for SPL (and similarly for TPL and VPL). Tidy up the Kconfig
> help for clarity.
>=20
> For now these symbols are not used. That is cleaned up in the following
> patches.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This introduces:

WARNING: unmet direct dependencies detected for SPL_SYS_MALLOC_F
  Depends on [n]: ARM [=3Dy] && ARCH_SNAPDRAGON [=3Dn] || ARM [=3Dy] && ARC=
H_SOCFPGA [=3Dn] || SPL_FRAMEWORK [=3Dn] && SYS_MALLOC_F [=3Dy] && SPL [=3D=
y]
  Selected by [y]:
  - SPL_DM_SERIAL [=3Dy] && SERIAL [=3Dy] && DM_SERIAL [=3Dy] && SPL_DM [=
=3Dy]

WARNING: unmet direct dependencies detected for SPL_SYS_MALLOC_F
  Depends on [n]: ARM [=3Dy] && ARCH_SNAPDRAGON [=3Dn] || ARM [=3Dy] && ARC=
H_SOCFPGA [=3Dn] || SPL_FRAMEWORK [=3Dn] && SYS_MALLOC_F [=3Dy] && SPL [=3D=
y]
  Selected by [y]:
  - SPL_DM_SERIAL [=3Dy] && SERIAL [=3Dy] && DM_SERIAL [=3Dy] && SPL_DM [=
=3Dy]

On mx28evk and imx28_xea_sb.

--=20
Tom

--gx38HXrKf5hV++Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUR44AACgkQFHw5/5Y0
tyylZQv/YT+ekfprZucPebixH7ND7+KprRQ60NNUVZJO254eH5QJU1RgZMLyCY82
OWuOvrqhj3yoD2gXNUmkAQiNhjgUxr2/gtDkUNHhXSFUWfm0rcsWZbkHpiP4MQIH
jmN5d2sCFVUbiFj2KgyV3XuCzEelZk71A7AN80HAIqBt6E8cDh48/uqjtMf/wuMl
7obOCvuLR61xlDOT2bNRROupTZagnZ6WdRIvoDHTWONstR8d+ci6xgZ4vgnLjk+q
99jhSANeXkSFBaHsBD7B2Yt4rhSv9j79160pcwU9VaN/cBSYe5XDeHp6HypR1auR
LlKqY76AL/15BQ1yBpgb2Yfx2Czo8mrYMR+FJ/bMpE/6tuVsavKSm1Z6BCIuUYEA
fqjjhUReAc637tHuowslDoJYjdS+9tx89+8iWfHlmevob1cCnMV0EUhVlQBOH6Cq
ax/uMFyRgcJssmMd83oi9yDs+fqUrkYupy0CgJfuBaeE7g1J1PIBzD/DT1kke62E
0Pic40/S
=k3a1
-----END PGP SIGNATURE-----

--gx38HXrKf5hV++Ky--
