Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60FCC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 20:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF1586FB2;
	Thu, 18 Jan 2024 21:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YDLFxUvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788B586FB2; Thu, 18 Jan 2024 21:22:50 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D596485E44
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 21:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6818f3cf00aso596576d6.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705609366; x=1706214166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZtdmJJW5dS/182JmizL0lUeyj5dvkYucguZSKvEoys=;
 b=YDLFxUvnOy+4A2SHLxaTE1lzwU4+mTmDKtgPnlQWHGbRMISdnti3+Eavcpg9pFuUzX
 Egy0uy6+rCnNkk/ne2Kq2goYKavYctrgGsXTJBKtYRCyCMRMcUU7R9gZ4jJEkfktOEvH
 vrgWttzkkc7i2+NLfVi8pJ/jCklb3Y1iYXbUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705609366; x=1706214166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZtdmJJW5dS/182JmizL0lUeyj5dvkYucguZSKvEoys=;
 b=l1rfd5U1mRM/PCx5VHvSYzYzg+LSmAZLK3GrVKy815z3RkGiQLqAFF47kv6o3V8EW6
 YblDNZeL8UlvV6wndTgCPj5QZiAPCrQ0A6oU5RoWgA6Rivjbw5TCFsbvKJQzhcLHOFiY
 uOZjR+m39I98941FS/sa9HDcreSMXm0ZvwSCa7ujOVrADq5/vmZmMcYyrtKs10EhN9y1
 qzi3GeN48rA48uet9ST5cttVvGmHGrbUTnySCI0G7YKP/ZytuFnDYfVwUFABYdwBrtY7
 knguNKqAe5vjqwDkpGquW24Mdl760fbZx4OIvCnU7yv1lG7HwrZk4vsDo/wKdh6O5Y5j
 yBTQ==
X-Gm-Message-State: AOJu0YyCERNHzNbts/DTVf/Erk5wkR73B37ZbBb6Y484fVHmeguMQUMx
 lVH+eymEnS52akeQ1Jg4DD2S0A6bztb/YuLNxa6X69QhBi/NG3k4gcKtdVUU4yw=
X-Google-Smtp-Source: AGHT+IHiI6iVFJ4sw57x5qCBL+W3/oeTXDM2fYylbB5yWQ5UcKgg4pUo/FWJ0qbTQlzdHo8RNLO1VQ==
X-Received: by 2002:a05:6214:29ea:b0:681:7867:fbba with SMTP id
 jv10-20020a05621429ea00b006817867fbbamr1203829qvb.110.1705609366625; 
 Thu, 18 Jan 2024 12:22:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w5-20020a0cf705000000b006818033cceasm1446785qvn.38.2024.01.18.12.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 12:22:46 -0800 (PST)
Date: Thu, 18 Jan 2024 15:22:43 -0500
From: Tom Rini <trini@konsulko.com>
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v3 07/11] lib: vsprintf: enable '%pbl' format specifier
Message-ID: <20240118202243.GF12635@bill-the-cat>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
 <20240110091037.392520-8-lukas.funke-oss@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uhUGGtpWPKgIa47c"
Content-Disposition: inline
In-Reply-To: <20240110091037.392520-8-lukas.funke-oss@weidmueller.com>
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


--uhUGGtpWPKgIa47c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:10:33AM +0100, lukas.funke-oss@weidmueller.com w=
rote:

> From: Lukas Funke <lukas.funke@weidmueller.com>
>=20
> The commit enables vsprintf() to handle the '%pbl' format specifier
> in order to print bitmaps and its derivatives such as cpumask and
> nodemask [1]. This can be used to derive kernel boot parameters from
> bitmaks such as 'isolcpu' or 'nohz_full' [2].
>=20
> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
> [2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.=
html
>=20
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>

This breaks building ARC platforms, and possibly others.  Note that
tools/buildman/buildman is happy to fetch toolchains for you, and in
this case it's also just the current kernel.org cross-toolchain. Please
see https://docs.u-boot.org/en/latest/develop/ci_testing.html about how
to trigger a CI run prior to sending v4, thanks.

--=20
Tom

--uhUGGtpWPKgIa47c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpiJAACgkQFHw5/5Y0
tyxOdQv6A5SpkBlO4CZZBXk0FhPT5MP+zj61JDVeT06kMpg/snFU/DogKW1TJu8j
vqMyL7RgHka09LCZVyCAoM5ajOINf85Ryb+hxk16B8S790808CaEN447YC2EXwuF
VMYuYYwKfWepj9bXBUvN+RI+QpVjcV03TtPTKeWc2/4ch0+OD+fGerTJHdXnqxIe
TlN0ZRePlqT5hJZWhxp3Ba0186WhhJisI7uQFreCvg/lmxIeJaLIdFjh0/2qYPym
0AyqlL8dhk0vX3L760FwtVzP2Kko/psb9GMXdqPsudj8rDOH9zZhP76BSMAgdTu0
CQDT9K0L3QbAo4+DW9E7vMp1Mwm4jzuyJ6BoBtAwkuX36Recdjd0yYq8b7ijjHWi
8kP+C5F8JWI6KWSRQyKrkiUu3wC/8sip9QV8Kf+IEAStuhFHXDsTxMleq6vDyR8x
xh3z/cSSdhovQKTENc4ZB0PTvPdnuwr2Wk39WuZt4Gpzgr/hPOD+H1hbkLxUIWR+
Ccki+LY/
=Av/b
-----END PGP SIGNATURE-----

--uhUGGtpWPKgIa47c--
