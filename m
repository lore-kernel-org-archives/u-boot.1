Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E3C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ACD87638;
	Wed, 22 Nov 2023 21:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DwTy9lv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7458287627; Wed, 22 Nov 2023 21:49:07 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1C587613
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9fe0a598d8so202799276.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686142; x=1701290942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jvLQN9G2hJyQN8yt8bP/w7xo8DhOJTa1Ya7OAGcTc1I=;
 b=DwTy9lv1r8oUnbqyFX+sn8vgPPzpbLbMptB3czbSgJK4FPlCLh1WwqaoRY9P6bj41W
 V0wqlmCL3pX9JDXwetrnNt8B/gawf+uANj4qjrghdAUPkNgWnbeYp9VGwG65hDBM7b8/
 7caHYva5Q8GYURojRPgn0ULhvREvJtNzWNll4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686142; x=1701290942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvLQN9G2hJyQN8yt8bP/w7xo8DhOJTa1Ya7OAGcTc1I=;
 b=ikI+S8o8W+BPjCsvxnvPN/Phq1vFwXNbwGFPxQoNIbOs+Q9ffRBWMAuy+Bky4mAmCB
 yaKd8VZZE31/El6Gz9D6vN0HkFC85Zcd2yhqwK2fTPd8TuGkJL3ED+WUaflW6Hkbj7JH
 vlJnmn0zCvBdbcRjQpnrA3JUB/s8vRbf8HUwobT5ySBjprhUn2G6iT5745Nk9oBSFbNk
 OKkGaTyrI6NBlS5SFNrxrzbG9TShvZMWYdroSEnev8kw/ZkxFMP9WdN1ei7XoQLqPFz8
 51nCdAuSJSyvXct67fsSaxGdt8VaV6/sTkxzLiUEa1EJWf4Gbqk7EFmEzfNjPxT/Oh6f
 dhiQ==
X-Gm-Message-State: AOJu0YyVbbJQKjyRwFCRYnJS/SRZXRsBjaO2VblFV8+2VG+A8EOotyNG
 oc3FeC0k71gkL8vYck4e4SxZR1UbrqsoSN4Xv/DSNw==
X-Google-Smtp-Source: AGHT+IG8xkXqY9SqSbQipMlGaWGCwgVxsLRI/y77rJrNoYrmXhEuctcXnM5fdJB0sYqBlKesB3bU9g==
X-Received: by 2002:a25:ad16:0:b0:db4:222c:84da with SMTP id
 y22-20020a25ad16000000b00db4222c84damr1210585ybi.23.1700686142211; 
 Wed, 22 Nov 2023 12:49:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 123-20020a251381000000b00da0abddeb02sm1574465ybt.34.2023.11.22.12.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:01 -0800 (PST)
Date: Wed, 22 Nov 2023 15:48:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mach-k3: Let the compiler size the mem_map lists
Message-ID: <20231122204859.GX2513409@bill-the-cat>
References: <20231106165205.22066-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="26MHRKrsKgJP0ZwC"
Content-Disposition: inline
In-Reply-To: <20231106165205.22066-1-afd@ti.com>
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


--26MHRKrsKgJP0ZwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 10:52:05AM -0600, Andrew Davis wrote:

> NR_MMU_REGIONS is a copy/paste from another platform that extends
> this list later. We do not do that, so let the list be the size
> of the initializer list.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/arm64-mmu.c | 34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)

Please redo this on top of current next as the other series that have
gone in make this no longer apply, thanks.

--=20
Tom

--26MHRKrsKgJP0ZwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaTsACgkQFHw5/5Y0
tyziZQwAikjlv9k+S3DTno3+TJCGt7Tv0s4cTA1Tmq8m2+P9UWgWD10+ys0ksxcU
331dz1zSU/3bNdSPe1scIShs3k+ODCvssqJBPK0QfP3pVAbN6E8eF1Fi615VaQC2
3Z53EUSrMezprBezALc8VM14nvgHb6WgApsZfXNwCWemI8yznjO2CTDJGiqP5XQH
GkuRFaPak8lLiN4po4ionV4QuTa8X/MxI4j6n5NBELTgd8TZr/iV9qjzV7x5Sk5Z
cSTjxKBgSyJw6DXenPtR5+FSb4FNmpHDiXdoM4g/m7P58Rs2ABBJpxF9NC5hDyp6
HcAO7jJIo0AV7dZ2trgeUiumqmXmdBr16B1nvmJLaov+GTiBmJZjjK71HgGFI06a
mG055C9BOoMOzBk0K+TERtM8UDwUfa1i0zl7Fu7aV9/qqgcUTfTUeDn0cdoTRe/w
Nnxnft6Gk4UObAAotY5QPTGCCWtOf+hy011VfYAMcPmeBAYrwF399xSwTrFLiK2l
FsAK4iRb
=UkID
-----END PGP SIGNATURE-----

--26MHRKrsKgJP0ZwC--
