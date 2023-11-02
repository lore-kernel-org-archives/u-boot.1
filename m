Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D452C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CCC87663;
	Thu,  2 Nov 2023 23:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iFuULjKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B9387663; Thu,  2 Nov 2023 23:06:28 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1171E87049
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66fbcaf03c6so8964836d6.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698962783; x=1699567583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hThONaLzHkH/kvn6e66xq+qWJcJKm47gQNutuLlbdLs=;
 b=iFuULjKUXKdZKYAritR6mdHuNftYML7chWvfBaTjTfZ3cIWGRfwUg9Rorr/C6fv9Ix
 Oo9wVcRvzgzAHtEThkJ57YIB/lPQVb5nVzUUy04w5bUHGXW2iBa+pmkYc1Jb2+xIT/XT
 Lth9InRAoG79Z6q+SZx3dKEox7ktIB8vo2QT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698962783; x=1699567583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hThONaLzHkH/kvn6e66xq+qWJcJKm47gQNutuLlbdLs=;
 b=FJvy7CMuWTYj4LSpbEVTBqU1MBl/4IsUDQ9vgbE2ZgQ1aMrwIjMCPK0rXfA4OOvizK
 hMQ8ONrn6m0E4GdD5POjiBKcNSyoPIYFhVlFJU085txc0+t42M4eBiUkzybYbyYrVcFD
 OnFymYlkDljcqL8RngXLkE51BgWJu/64mZEVApgYf1gXWoMpGfkVzL3Efnn7pW3LiWdI
 VML1EXLQZRWGcpuEnuj8PDcdYwYbqzsnD/geNY2/Yt7U/EMWaG7cuFAA8lDljwNED4Zr
 TMg9a+0j7IeH066ExyM+7Mpity5jYXyOSrTwUnKrpmlKl3e0GGXN67tl2O7Juv7zRzK+
 PPVw==
X-Gm-Message-State: AOJu0YyUCshy6bO0s4U9HVtPPVxaJS5X6RBNBMRFwFvT0ov8jHmhzN5i
 CbgYPKKoKJkX6VWDZklpH/tKwQ==
X-Google-Smtp-Source: AGHT+IFlcLpAg/buEaTSyw0WuMshhLmzAot3n6qqifTXB0vzAdCgvYihyPPJjk0rNObrTMkfDYAjSA==
X-Received: by 2002:a05:6214:b6f:b0:672:ab2:d9ec with SMTP id
 ey15-20020a0562140b6f00b006720ab2d9ecmr14515193qvb.28.1698962782794; 
 Thu, 02 Nov 2023 15:06:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 du10-20020a05621409aa00b0065b2be40d58sm129871qvb.25.2023.11.02.15.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:06:20 -0700 (PDT)
Date: Thu, 2 Nov 2023 18:06:18 -0400
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, dphadke@linux.microsoft.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v3 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
Message-ID: <20231102220618.GA2106979@bill-the-cat>
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-5-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJ5ydPNtPt1UPFmq"
Content-Disposition: inline
In-Reply-To: <20230912213504.65513-5-seanedmond@linux.microsoft.com>
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


--oJ5ydPNtPt1UPFmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 02:35:03PM -0700, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> There is a preference to use the "ofnode" API for FDT fixups
> moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> fixup the kernel FDT with the ofnode API, it's required to set the
> OFNODE_MULTI_TREE option.
>=20
> To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> the default value for OFNODE_MULTI_TREE to ensure it's always set if
> !OF_LIVE.  This will cause a 1007 byte increase in the code size.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  drivers/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This leads to failure to build such as:
Building current source for 1 boards (1 thread, 12 jobs per thread)
       arm:  +   integratorap_cm946es
+(integratorap_cm946es) arm-linux-gnueabi-ld.bfd: common/board_r.o: in func=
tion `initr_dm':
+(integratorap_cm946es) common/board_r.c:231:(.text.initr_dm+0x4): undefine=
d reference to `oftree_reset'
+(integratorap_cm946es) make[1]: *** [Makefile:1765: u-boot] Error 1
+(integratorap_cm946es) make: *** [Makefile:177: sub-make] Error 2
=20
--=20
Tom

--oJ5ydPNtPt1UPFmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVEHVYACgkQFHw5/5Y0
tywSaAv+M0Pa3pDlET9vxDS3/RyPioSwq5TUl6S3QmpUx3FHE28tCG4vuPiXBRnS
nB/d1ZqSZ8Q+iYjXRU5mLyGQM0XyGGcybsTNH7T6jDvjtVLblK6Ctd+UEu60Lxgp
OhhUWaK99V25d9/X+7AolYvw6Db9zja9eEDSiyDnI5ajklBot6doxkmNV0mKJb8q
oIV0uKee3mcAO/2FS//tvnJSzOBWSTQYyU1Wr3ZYAMswElaCaI4WZMdYsLFp7mTI
TRv2n/WfUXmI+pBHPdUqY7O5bnM8IlNnnfwRtyThARo/b7SkT0Wdy2fPxo6rVodH
LPIuWUBm4W2C50z5TEX5P2TeTWuRjgLQRqchYvHXQqMMO+4X/THJy4xakrdsJ54u
eIqrS3Cf5+uYGpkT6z3/2s40YEY9HabqnMjs/DnTUdxaMgNBNxfOUnY7hehaafuu
me8hCiYQqy/oCQLPG0TwGAZvGrIB06faAtcEWWYI2Q6xVndrIckF4RS9NjualMoH
ZKd9ew8A
=NSnU
-----END PGP SIGNATURE-----

--oJ5ydPNtPt1UPFmq--
