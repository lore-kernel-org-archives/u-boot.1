Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E73C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63ACC84A0F;
	Wed,  8 Jul 2026 20:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rm7BS9ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E60B84A12; Wed,  8 Jul 2026 20:09:13 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288598496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso126156a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783534150; x=1784138950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rXleReN1u8c3IEoOmX2YBOR4P9+Pr0KusIk6cbLSUqQ=;
 b=Rm7BS9ZHc5UoXuiIQyPlHNAnfsxbIjg2S1HXBXCXbh7bA2+ZPy+HHn1zEitoLpOUzZ
 O9nSLwJmlIFZS5T+Khfeq9FAsPWmRPvBmKV9uKu4zJNSqLiSiRchIxsnu5qsS+Hfinag
 w7jV9AGLtV2vWJaNIf5/kCYpL5GD4uhQHDoJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534150; x=1784138950;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rXleReN1u8c3IEoOmX2YBOR4P9+Pr0KusIk6cbLSUqQ=;
 b=s78Fm1XXJyskOtZxn7oFWU9juqU4Bbs1av2znC21emJs8v6wxJvoeZQJN9m/CPBc83
 MnEaTBzmcqL9TOt7VehYk6OQVCnJWuaj433YrBKeZfnGodJeV8H1Y8+o6sDxC28YL9cg
 hYJMww/w4dyJGAzLq//sOWqs+A6+RGlA1hWWVFoHj6tmHMVO5gbBmLHz8M0KiXrYHQEG
 NtvdYgUt8ZkbmJSIbbSWpa/N++fNXTGJsRfQQW0vtkt57t40FtoWZm6Kmf9Jjtwr+HiM
 qmuNgFLNvx8cWdYnsD0Y+x7VWxtQzvcjiRVPhbagvHcVIRC4pisHx89U6qMFCazropHb
 GsQQ==
X-Gm-Message-State: AOJu0YwDJ+2cxqG0VXmzN5H6GB669WvVt9J6fNJrPnL3V3sK8tel+Mri
 Fy4kaqB3N0IQRvdCDpr4kQvO8P5SeaVuGB+RT0WBQdq3q8Ydtjxwd8rveoOFVpbo3Pg=
X-Gm-Gg: AfdE7cmz/I4Co8NqWs82wD3fzPdaKbRET3djQRo1WPTmriuIQeG1A8lufU3r9ufisIe
 Z885EGcoYvj3dPfzxVxOkIcMD9ujrGpigE7luWgVft7LanjQgyvCuyHx17snMGgMNFpzgl8HCQy
 n3NMpMhbFTYGi+gz/0eyvvgaZ7wwyVZRwEPThSfgA+ug1qP4m1Y16Zmwuq+qIZqbY9NKMqQBCBW
 RCzwlNjLN15zE14Th8pEiItvGJjiLNTnHQfRkuXte69yzbdblAgedUhbts2hvYf2x33JPjVnvaK
 k5ndx9Xg0iE789nQ8WOr2biLx0qssRnz0d2bB+MYFsV92FAGzCd8L5VjVb4zLHcINlZh4GFVDA1
 ucm8FbtLxbVGCmK1NmUCejIr9f0IHCDkR2YLa24HBOoAIt3/JhJw6wQvvUeIiAld64+NoYeyVQA
 qVtCjSDffOXWFJKu0Eon9XhpnU6pdsD1fyd/5atnLx0lNAUs40dXnhX2gBRmnwC3VXt8fB6KXeA
 cio8B5MOp5SlLxl8po5jjSLQux/Jo2R7RmaCQ==
X-Received: by 2002:a05:6830:4128:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-7ebced785dcmr2364619a34.4.1783534149700; 
 Wed, 08 Jul 2026 11:09:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb262f50sm2288768a34.15.2026.07.08.11.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:09:09 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:09:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/3] doc: CONTRIBUTE: tell people reviewing *is*
 contributing
Message-ID: <20260708180906.GC749385@bill-the-cat>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-2-8b3bd4d265ef@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K3jqv3rl2CgPuTE9"
Content-Disposition: inline
In-Reply-To: <20260708-other-contrib-v1-2-8b3bd4d265ef@cherry.de>
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


--K3jqv3rl2CgPuTE9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:21:14PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> We are "a bit" struggling with reviewing things and it's most of the
> time maintainers or long time contributors reviewing patches on the
> mailing list.
>=20
> Hint that reviewing is also contributing to the project and that even if
> you don't feel you're an expert, your review is still welcome and can
> help us catch bugs before they are merged.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--K3jqv3rl2CgPuTE9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6SQgAKCRAr4qD1Cr/k
CiuOAPkBMUTaSkr4c/i1HJMoXB21BGOTgWBXnXg4WbX9OXn2jwEAtol0b8DcrUTi
Xg+Q54Uk7Pcd6XuX3YIhh+HOSUBxsww=
=4ckq
-----END PGP SIGNATURE-----

--K3jqv3rl2CgPuTE9--
