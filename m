Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BC9E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0DC800DF;
	Wed,  8 Jan 2025 19:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+YSGvmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238FC8036B; Wed,  8 Jan 2025 19:33:52 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DCB8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467a1d43821so9658031cf.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736361228; x=1736966028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H372X2VYyi2qW1bgYUmE422r6bSDG3oqQVy95j9K8Cg=;
 b=j+YSGvmtFEO0g/TQ08CzTVQDyLYmfeEsKq5bHKUXKwD7MeG8TdmTWliiynEThrZvLQ
 SZQeSD2z0rBJucl09iyKUliLxPzdEia030atyBR3iaR+Miux/och+wmssrgI8sHuT4vR
 YHrsKr3wVmgnbSrXr3YdJXWVytqC+OU4x7+4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736361228; x=1736966028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H372X2VYyi2qW1bgYUmE422r6bSDG3oqQVy95j9K8Cg=;
 b=funX1L96WLbRbgurjpz4KcfDsiN5cWOzp8hadYLTPtcSMjbqZUJZyOJ7i2FUhWuCyf
 aABIXgb28sHB9W5HplDXE9Plw5WSlVaJTfALlrlGdyMXFAdUaRSbcVdsE58EuIbmCQfB
 CzKqH6pSk9g0JKA4+1FBf+trMKg7rw9Vy2hXkqu6ecpPBX23NjkRW9BJ4bFD/8fyTs1c
 Tz3mAia7aZJ7ARfqrSrdeZHuw8jkCh6JCIoJPA/+Zin29kmRCPsxgmDTE6s4K17DeVYV
 xzQuogo4CPmcb/JEQP7crqjNZnwmgXQ6U01pVzMyw6Yz1SnN9KErlSzADPrZNQuHioIa
 gHSA==
X-Gm-Message-State: AOJu0Yz+jOEqqjAxJL17+hWhqlYvxjlvXWjGjUHgBWfCWfAwq8wakd5F
 pdxI/zpNwoAK64tf/86Mj8yucDoYKo5vqfQuF+X//r+m+E57NS4V9/ZUASPeApY=
X-Gm-Gg: ASbGncum+fJWkxLvCTEq9Q8sKRoWNVyiUWJa/fmaQrK0BTrpT5kFCHkLRWTSR7MANed
 4/uYV+v54xHMMdKl7ZZ+ozr6OgBjHIyvUHHONCf+WI6kf0G6p8lnpIc2o0ci1cDduWqwNt5m18I
 AMzOtNYm3gg8Lso78XfhIN8pCUqBFTny76uGsdaWLxsercsoaMQN+uX4QNHQZLrWQniiR6VgL6r
 ovN/rBvV5K2cu3Z1Idh0taWVaL//7MEZThZF6mYUxuNKMOjZwzelx0=
X-Google-Smtp-Source: AGHT+IES66o4wG1ixqGVCnOKuN2rOmDOIKf+NV+miAlW1lxHiYzjPL2Vpzg80PxewuVerUjMxfoIHQ==
X-Received: by 2002:a05:6214:20ce:b0:6d8:98a0:23b6 with SMTP id
 6a1803df08f44-6dfa3a44c3amr5879996d6.4.1736361228392; 
 Wed, 08 Jan 2025 10:33:48 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1813900bsm193141706d6.67.2025.01.08.10.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:33:47 -0800 (PST)
Date: Wed, 8 Jan 2025 12:33:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 12/33] ofnode: Use 4K for a default tree-size
Message-ID: <20250108183345.GO3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8vAVNTJbJbNEWUJ+"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-13-sjg@chromium.org>
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


--8vAVNTJbJbNEWUJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:32:08AM -0700, Simon Glass wrote:

> At some point it would be nice to have the ofnode API automatically
> expand the tree as required, to accommodate new nodes. For now, expand
> the default size so that UPL can be supported.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/core/ofnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why not have oftree_new take a size parameter?

--=20
Tom

--8vAVNTJbJbNEWUJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+xQkACgkQFHw5/5Y0
tywNfgv9GFi1fEF2uvewf7ZksLS9p54qUoWOYJSDV+wpwMIhQRCocYS8dXS/pzoa
yxmHEi7L1+g7tZub17tSppxqFqHvDWH4QReK9lVcq1kNvH+ri36JdMx0RsdOtF2i
6XzHcSa8sujz3Z+ZcolicZK8sUVIpcY16J5TdzTyOEHr/TvuVFsmUvAP/jMlnC6n
EFFHW19n8mjrxxGtQT8DpF/GQaaFXSMseDC4PfvGsTKDrKMEXbL8/HoOJY+9mTGN
Q+kj3TODJxsVvb111eAUJZVNyjyI3+1i67EUamPe/kn7vWO22lALjLN8o0JvX+M7
gBeQmEIV2rnP+3y37SUAHNH3mFcybSAi1A1dh6cUuGCq9PqdG/RHocxABODuqWh4
6tOrFudaEd0g2Yuy2IihgWsQCfhvWcs2LkZb4szTt8BSdDLYkhfXZTgXdlDMhDsx
xjdkLk+a/d6Fr7eYy6VTG7jSYhdmg/0ge9LlgJRy9SIBOG/yCp5Kj4jZVBtG0tgk
17l3Emyw
=fRJl
-----END PGP SIGNATURE-----

--8vAVNTJbJbNEWUJ+--
