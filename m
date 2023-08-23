Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44932C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE6F864CD;
	Wed, 23 Aug 2023 22:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PAmQznkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174688640E; Wed, 23 Aug 2023 22:29:26 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FAF8644F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-58fc4d319d2so47027777b3.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692822563; x=1693427363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BwjM/9nrtdf0S1sUnnYPUj/5xHW0ieeCfyMyU4ouvV4=;
 b=PAmQznkt+U0WNrmuJHUGwjWLbiFPYCQecqANMnmxjHKBPMZmzTi3s6t9cLsrZ5u5qV
 X71J3xtbpiObUaQi8d4aWKcLSVN7+pf8EY2qiuUlW4YWa8lppItDs4hhGHqqyxew4JKe
 NjdtX8yAof29OdUIcMpaJB82Jo0FZbtxMJlU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822563; x=1693427363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwjM/9nrtdf0S1sUnnYPUj/5xHW0ieeCfyMyU4ouvV4=;
 b=Xnxc3wRPN2O9WlIBB21dTcNAAqXY7KsEgx8dnvSWT2Pm2y7L7YgX+LAvQnyF0dJBaw
 2askUK5WTPCI9s8EsIQVYHO594l2wuecvzDYAnDl1yCilcJX6RvmtA5hQni1mQ0RlVMy
 ug4dp3Y/PWXkZEJ5KM286onq9ogM8Vu8znUK91JUiFVu1HF1T+z/Ow/3rsSrCpVxvZXe
 Nq6WAK6TClMpiiOvoQ3O6Zgj68Wql99JC15jMlSmqmHX311gOqXAk7dBv6eyI+IqhBRZ
 O/syWFdyk7YuyPd3GxRiHM2hzOGdUcvS47d/BUJzXNTV7aQ9FIWHB7jdbURrppeE7uSG
 9TVw==
X-Gm-Message-State: AOJu0YyKmn9QuhlIWyNIXzJqPN/lmhUSpUgRcs3UWvopaIqU5AAPbQsY
 8nbAle7vN/5zXdPIscNo8ZXxxg==
X-Google-Smtp-Source: AGHT+IFGUpQJSq+tUdro3SYx+c0em6GxJgd6jajKaN8EhIhV3AnBnYO1w375MBGTMJhf6R1CwUgcAA==
X-Received: by 2002:a81:8405:0:b0:592:24d7:6673 with SMTP id
 u5-20020a818405000000b0059224d76673mr8996627ywf.15.1692822562779; 
 Wed, 23 Aug 2023 13:29:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 h185-20020a0dc5c2000000b0058427045833sm3582184ywd.133.2023.08.23.13.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:29:22 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:29:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230823202920.GE3953269@bill-the-cat>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c3usI+QCd/0KpGtv"
Content-Disposition: inline
In-Reply-To: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
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


--c3usI+QCd/0KpGtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:57:28PM +0200, Heinrich Schuchardt wrote:

> This is a stub describing how TPL, VPL, and SPL load the next boot stages
> on a detail level for users.
>=20
> For sure we will need a few patches on top to catch the whole complexity.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
[snip]
> +Image load methods
> +------------------
> +
> +The image boot methods available for a board must be defined in two plac=
es:
> +
> +The board code implements a function board_boot_order() enumerating up to
> +six boot methods and the sequence in which they are tried. If there is o=
nly one
> +boot method function, spl_boot_device() may be implemented instead.
> +
> +The configuration controls which of these boot methods are actually avai=
lable.

Maybe some words about how some of these methods are SoC / SoC family
specific while others are more high level and so more generally
available.

--=20
Tom

--c3usI+QCd/0KpGtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmbCAACgkQFHw5/5Y0
tyytxwv/RHCqoQZVgg6r6NzAJSBv94iR1o4caHsQG3WonIGvJu1rEWXG/MSiZ6l8
tP2Tw08ZPLRCJsy8qFJ/zo+X0Js817MAxXnyj38Lm2svez4MtlYZ84bRJ/puAs1r
ZCVq3HjGqU6izTNpMKEqqAxDKCv0szLZDip3lBQR8XvW1Qfx7sRyX1CIHTWBSEgk
4g6N1blNpcMHgbAWELC4nGpSmk6jq4eZrUTlUNlw37+2/ouZEm/YwWD4+mtPJIbc
VIyYfQ4KSiEXEcjYhS+z72MzmQqzN+cb+MPTTiNYb1to5y25nkH4sjtS3GmbRJXE
uekCLoIeVH2uFWlmZ8v5w279zF5pW4hzX2KmJHYzTPazTOx7OhvjtJCa5aIAy42l
TbSNn+5lnoRxRJO41Me5L38j7p3txL7w/D/p7tecOy5fJ7gbAFPaGyvL6nsRxEKq
T+RqyGFMVq2V3gn+QRGHbhZVaXH2oiVAwdf0M54GvdlM09kfSI1aUSj0yca947gK
1rmY3ijK
=guSN
-----END PGP SIGNATURE-----

--c3usI+QCd/0KpGtv--
