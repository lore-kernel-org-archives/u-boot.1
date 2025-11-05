Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E726ACCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 14:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279F183A32;
	Wed,  5 Nov 2025 15:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oNcYvaKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEAF583A3D; Wed,  5 Nov 2025 15:42:12 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7356783A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 15:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c531445439so1987790a34.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762353729; x=1762958529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rNvvf3UwuvviojtYRAtgdSikWQ3TReCQdsvpm11f/BE=;
 b=oNcYvaKglH/UnxjfgTRl1cIsd7bKh/VwAjzsAeZ3P1RExokf+dVZZnNMvsORRUgJVp
 bVODt3ycRrNpdmsyiptbKA8suoBwrthZYG9g309X/cSeorEW5AT8pALSGnp1hSKigJeF
 Ru75p5KlsSO0pckWcK46zHKMEh8L//YBDB9II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762353729; x=1762958529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNvvf3UwuvviojtYRAtgdSikWQ3TReCQdsvpm11f/BE=;
 b=JDF6Xm9Ady1ArSsbx7Jmc+PwjjpeehwKE8/h5DyxQ0u+Y1nN1rQUqnHgOnnzEtNSJd
 RJi7Y/+vIYjDrGv6+Sj2yqOZqoqiZa16Cf3i3C+GapsOnAIuDBkvj8lpTIM0QuybtTAe
 +QCMkj7U//ILshSmpgwXamtF1ApKXSrEsPpg3Cq4qioKpO/QlFwTN9KlWkCNk0W1JSxB
 8gM/ck5mI+zJZhCSqKXQWxcZIbIUi4KownL7vwS8uer1atICf1PyKzxo1QhGkJrt0Rtu
 4WaS7Vb/HAww53J7TbNNIzVq7W8YJA/iLbC0Pcf1wwUsI5bwdc8FwlCbwC2yoeucWu03
 Deqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPW34SAtKBjFdfz6kawBabVsEMf0iMMQkuzl6/Tim8+oomglL+7/YTR6WqBjLxwclLNY+IG7k=@lists.denx.de
X-Gm-Message-State: AOJu0YzYNztGI3VjAlaZGzJkwvilgOwbdAlT+BiggyHN60kxVwUKNdV2
 oylbQbFmaezPitSlq/fWSkMIhmDC48qHLWtQ4mkMndqlCJtYc7yv6weIJ3iQYMt359Q=
X-Gm-Gg: ASbGnctPyRf+bxgZZ/0F30HxYppAyu1sR2t3CfeHvPKuyy/8OA5umSfoOt0O0L6/oMY
 gb4AVPA1+gmWD8CPrtXVNTIe+HxfDpDLvvnYo8hNmIqbH6aGBrJ4MEBbOe3u8tbkbBfNKtMHOms
 D+1HvySOm4QsqKh8DnWc/byzrdKsbqhgGu7OqVD+uHB479HyFaWXl/v5WNx9etPO5VeiANaK2V/
 PVyGHvxAjx611uyn81YWJj+2Lj4s7WZYr0bWAJ+FGpIw/nCtICQWHjIkwcNIOUNHJpZEi60qFH0
 L7WPQi8d0bdLT+D89gPETp45f8H+bcZL9KPkExKRFHyT2Ak8amfxjLxPrRYI1Z5aLPjqt7zyf+8
 oKr0NVdPxT1eewqtGca4P5hUkF5mkWq1B20iXDI0l667TZbJQ3f5bEEEWLRCXmH29aqWmhSke14
 OM9GtTXSqx5kmGP5o/uJwe6IkDnDE+Xfr5593y5dQ=
X-Google-Smtp-Source: AGHT+IEU1xw37l5ZPrV+05p+Unk9sFXdgfthDQU3+hTMmvxxoGZd1ayRgwoKJgn+aTKbBwxNhIHbzQ==
X-Received: by 2002:a05:6808:148b:b0:44d:bc4c:22bd with SMTP id
 5614622812f47-44fed208281mr1333433b6e.24.1762353729101; 
 Wed, 05 Nov 2025 06:42:09 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd88829c4sm1599233b6e.17.2025.11.05.06.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 06:42:07 -0800 (PST)
Date: Wed, 5 Nov 2025 08:42:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: ilias.apalodimas@linaro.org, bb@ti.com, u-boot@lists.denx.de,
 u-kumar1@ti.com, gehariprasath@ti.com, ziyao@disroot.org
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
Message-ID: <20251105144205.GM6688@bill-the-cat>
References: <20251105102316.1713954-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GFDRpKTZlTIPWjWc"
Content-Disposition: inline
In-Reply-To: <20251105102316.1713954-1-n-francis@ti.com>
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


--GFDRpKTZlTIPWjWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 03:53:16PM +0530, Neha Malcom Francis wrote:

> Add support for fetching config fragments and defconfigs out-of-tree using
> CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  scripts/kconfig/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Isn't this what scripts/kconfig/merge_config.sh is for? No, you can't
just do "make foo_defconfig bar.config" directly, but your tooling that
knows about outside fragments can merge foo_defconfig with
/somewhere/bar.config directly.

--=20
Tom

--GFDRpKTZlTIPWjWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQtiOgAKCRAr4qD1Cr/k
CjchAQCDZOLtchuvJcch2bdk2UFDbE1kmr7/xFtDtxRC0MyNlgD+ImWKzj3gPWFj
qRiCVj9BVf3vk02QWTOYbmMv+LDQaA8=
=NdRJ
-----END PGP SIGNATURE-----

--GFDRpKTZlTIPWjWc--
