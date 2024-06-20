Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D25C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA39288535;
	Thu, 20 Jun 2024 16:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Efyug4ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356698853E; Thu, 20 Jun 2024 16:32:39 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22920884DC
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f98178ceb3so547350a34.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718893956; x=1719498756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XA1iBv0JNEsW/wcyDiLJGbEDpha99UgH12eMJ2IbSRc=;
 b=Efyug4ngtddHPlNQli4DjkCxbpTjozOOa9ljEd2NhB7bspuS0lzU8vnzTDJwTGjRUv
 9Z+G4uL6guCsL6+idgvcHzHD4G18O93X4MupAk0wbTFp57/BRKYJEi4Oba1VKXUwj0QG
 grfX3P8Y7T6mEO77uUZTmecc7Q4tdWWjnbFds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718893956; x=1719498756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA1iBv0JNEsW/wcyDiLJGbEDpha99UgH12eMJ2IbSRc=;
 b=hm+gpy0f5LhMzbODhV722SwKX+Yd1+E9AfMNQsPMe72h+z/ERxxNW8GifYhUkXiNqc
 gUC1JiA1FiibFWGzx1f1+8rgNumbWIzh8yWuBVu2KBF60sL/JcjJVdIyXoTc3dO9r8dF
 lfJefLqqwA3mcjMEqo4TOQNjwcWtisU7Zphw5zXawbHg36b9DX3jZxJZ7OAt3v4n+/oe
 HYS8tAqlE0kx/Sygy898UtaaJ/zWWJEamx3dPMS6ylDySYFURfFLsmVIiKpMr0ZUc3Mb
 6eKeXwaOfbMM3UZtVG8ZRR8xaj7KoqLXI1drKRsA3L0NGFgS7pRh5B9XZ1brzoWiD+sm
 rYFA==
X-Gm-Message-State: AOJu0Yzn4lj5jQZ2Jgb6j/Q3OdC7xMAVWOSPI/zkn//e/N1FIh8uUN1R
 P+ZWzV0AQPcjYU9IcnD5ZjXBg+wT2ankU19CYBIv+poKFHyzW+cWscX/Dz/dgr0=
X-Google-Smtp-Source: AGHT+IHz/wsEU8MTi8zJUZsLXKU/2t7aQw7n1kKcgcZSrZcnF8SgGn5T6rSMIMbnm+uttNaAXcOp/w==
X-Received: by 2002:a05:6870:d38c:b0:259:89af:7af8 with SMTP id
 586e51a60fabf-25c948ec9bamr6046563fac.10.1718893955810; 
 Thu, 20 Jun 2024 07:32:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a9c542esm4261838fac.19.2024.06.20.07.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:32:35 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:32:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
Message-ID: <20240620143232.GM68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DITt/bp779aGaD4w"
Content-Disposition: inline
In-Reply-To: <20240620131937.1130446-4-sjg@chromium.org>
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


--DITt/bp779aGaD4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:

> The Python virtualenv tool sets up a few things in the envronment,
> putting its path first in the PATH environment variable and setting up
> a sys.prefix different from the sys.base_prefix value.
>=20
> At present buildman puts the toolchain path first in PATH so that it can
> be found easily during the build. For sandbox this causes problems since
> /usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
> PATH variable. As a result, the venv is partially disabled.
>=20
> The result is that sandbox builds within a venv ignore the venv, e.g.
> when looking for packages.
>=20
> Correct this by detecting the venv and adding the toolchain path after
> the venv path.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Why are we using PATH at all in this case? Shouldn't we just be setting
CROSS_COMPILE=3D/full/path/to/the/prefix ?

--=20
Tom

--DITt/bp779aGaD4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0PYAACgkQFHw5/5Y0
tyx1Kgv/bxElesILxUhIPnO6lQUQVb/nwLgA+9u3viBFGFCtQsLqZ/C9nDZ9P5yi
Pn60eCRfE7pf6smFx1ALv9GCjXGbmP7jzqei5DDBLDgL+NgAOJlbF4/aGTsS/ZKk
NC2MIzLkfgZtoMsXjcmrsfXsPho2Jy3WvapwqmYuKn4DjWAJXbBCONZjF93zhdcM
YyZt7k2mCRZQ02kHdpKbgd8fay3/nU6yms/Q/rAtqILK+4q94b/l1LvfNEnFQTVF
2AESNysD/BpYLvo3Iqiu2Ms+LGF37AoofXv6eKwZf+B3shIFC4MytRIoT9+FxMzj
EvfJxaG7jhq4iBlNtcGA0THHto2uRJlBiLbLaWdYgRjDhg1ZFU+DUa6dTAOOe0Ut
aqP7qu7FfEv/5zoDonFfF8ZawAjLHAi7rrFMZg41a2LJ9j/FQgFAXrvSBSfHL/F0
jxViX/xN8g7vyQ+eLoreMJjt809Xtqy37BLu7QgkQkHIpkID9a1IopFGuJudyxEY
332HxnV/
=65i5
-----END PGP SIGNATURE-----

--DITt/bp779aGaD4w--
