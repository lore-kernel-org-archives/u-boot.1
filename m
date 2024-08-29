Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD7C8303E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E51B88CEB;
	Thu, 29 Aug 2024 19:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EzTexxwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F4788CA1; Thu, 29 Aug 2024 19:30:19 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2427587BF4
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bd6f2c9d52so4984896d6.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724952616; x=1725557416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q3AyL5rmGgh+9t6fqoE5RbjS6fHOIW1q9ksRGq6CW2I=;
 b=EzTexxwZ+82Xtk2TOUuo3If5xUi0uwH6d8nje8aFnRLHyqp2fR0CmeF57Xgb67I+WU
 DXscQljD0DMFMsAoLtIYm//pjzT4oHUyxqwVzhguYNj2Ef02EgJiHKAFt2UyFiKpsnuQ
 Q8Hl34/dw8cupQu1xoZQho7ybqpMfwdVST0V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724952616; x=1725557416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3AyL5rmGgh+9t6fqoE5RbjS6fHOIW1q9ksRGq6CW2I=;
 b=R9kAvPS+RlUE4EQfuLSyPDS6eS+Vriryhv7W2kQZQ64MwLSYJBT1uGtTAppL+eLzXg
 g26HkIkafmRPmH8t4NoU3gDC2XL82LSGjsgBVXHQgARDihzdjBTR3O+fNk3aBB6wxDAx
 /HMhgfRBphQR8cJ9zG0cl2Q4t9/W2HN3BdxNnSArkPHnuOwo8asi+TsBRcKFbdpnfi4B
 ouoHfy2nzFjoLAGLQq+7NFlGFIxjMt9yVHtTc9eXHMSZ6aXMeYMl4Rf7fc1aryL7etxM
 2EIYUpnw+tY/AJv9Ez9qMXHoX8xWcVL6bhq7IME/KezyJqHp3HujI79Tdi+TPjUIglOu
 D6dQ==
X-Gm-Message-State: AOJu0YyZLD1bttjn7gDWu2jS+Blem0pa3LRggyMqZbBj+pICvOcHUsax
 ARJbR3HauV70d+V04WpZ/GDJkb/rFlDERxD7ayJrPeaEXJigFwHMrVfBI48R0SY=
X-Google-Smtp-Source: AGHT+IHjaygnkiNtUAeV5cOasQ0Qj1zXpPqYcPhFZpSai6GTjswN/mhpE3V4TQE5mXhGn/WnDD9uAA==
X-Received: by 2002:a05:6214:3f88:b0:6c1:7521:cc8f with SMTP id
 6a1803df08f44-6c33e682eaamr36060806d6.35.1724952615544; 
 Thu, 29 Aug 2024 10:30:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca65b3sm7019186d6.119.2024.08.29.10.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:30:15 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:30:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 17/19] lib: Allow crc8 in TPL and VPL
Message-ID: <20240829173011.GL2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1seivzbGpikQqI+E"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-18-sjg@chromium.org>
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


--1seivzbGpikQqI+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:58:00AM -0600, Simon Glass wrote:
> Provide options to enable the CRC8 feature in TPL and VPL builds.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  lib/Kconfig | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 72a5f3cb04f..b2d5e8d04a7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -698,6 +698,24 @@ config SPL_CRC8
>  	  checksum with feedback to produce an 8-bit result. The code is small
>  	  and it does not require a lookup table (unlike CRC32).
> =20
> +config TPL_CRC8
> +	bool "Support CRC8 in TPL"
> +	depends on SPL

Should be TPL not SPL here I assume.

--=20
Tom

--1seivzbGpikQqI+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQsCMACgkQFHw5/5Y0
tyyszQwAomu5ZbBWCcD96Js+SW6VTrZTvXXWn/m1OahUeKph7X6K7PNKN05y4Rw9
pMbdE2T5VwlCzZciGkhmBnYmRuYC2S7fzMBJZe3rYwVoa+5MNmpNAQ7JJo+id3JL
ZtRk/Yc+GL4hTZ0rbpoROTlZvxa7vJE+U0VUO6FdY8DpqRTcYRnJl2jSHmLNucj6
xapWCoF40DSC9agbtQt4845Z5frteuH3ti8XyfsVdYsT0m/hrahtLydiUuov+L5c
AAxmAAaoWFtMafCDypbpQ0yucF8h97xGhdYVRBvV1EEefDvisPtqhd/4YRtSubQz
aEgnAeJ+DeHjgBYJ40CLhS01k1HAu90n7e3tpF0GIK/3czs2nkpQpJt6L/s+gXF5
1jzcT8SciITiyBiiFywW9GKH3AlLq+hcWG3isx+6WxtlXKqt0T5wLpsF2sRtFmLU
2Vhk7UP6U8pftDUOoFvNaU+8slanwkJh7gr9Vy6WxDhoWWHA9W2RwEFr4yzqlaN4
rSCgv9w7
=uzq0
-----END PGP SIGNATURE-----

--1seivzbGpikQqI+E--
