Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A05C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 15:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F7C87076;
	Sun, 10 Dec 2023 16:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qfNGzVeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841C987687; Sun, 10 Dec 2023 16:16:14 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E5587045
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 16:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d7b1a8ec90so26629357b3.2
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 07:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702221371; x=1702826171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5kHNNvjNvcBrbHpV3qDNGkGiFwZ34rgTYdJ6WTLOoCc=;
 b=qfNGzVeUpYyr9EOKt/DvcVzGryBsODJGSxBUp5GSw3bpN/sEpOALuUJOMNp4bfrVQA
 GZFw87wLeIDog+eJT7/W2Mo8PsTp/06uxvZL8JncL06nOiNim4kRJzxYdqK7VxyoG41k
 sZJ7EKL3dqesSze8EZSB96kOWnt65smkjl5dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702221371; x=1702826171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kHNNvjNvcBrbHpV3qDNGkGiFwZ34rgTYdJ6WTLOoCc=;
 b=HLVz1vLWyMxgT7oOiyhGyqn2KrhxTocAU7DW6Hyjgz4IOmIsXaZlUjL6d4AKP69vzO
 +enSr+yJuQ41LdNHv1zRxWx6WaWpDu3DO9b8TMPT1KPuZ2PBHagQ35KB2EhJBWhCLvfD
 RQk1YFDmaiFj5Y29RywA7KqJ75Y9W+NP8XTvXDP0o/0qQxVt8faBIYgMRuyFjw/8tFid
 ZUWqTKjSPuxzCuwKeC69Mqdex2+5gHECpLXRlQp69Gs2abKUZr2SYumY4Piz9h/yDSH6
 KZU396zdXWEel1r25UYBySNk3seQWxFdqG3rG1e43CADbQxMMocXeKuYGCRaiRjigFkl
 +UIw==
X-Gm-Message-State: AOJu0YxAUaYEjzPxD738WWKHl0mFaM461FEmUcmCkNv3iFxHJHuejiBq
 LdIt5RG7HWI7VIFNqdMby80FWrA8UgREATna2DkSkw==
X-Google-Smtp-Source: AGHT+IE9iYHhxeWJCMIlPXzqAT9Q+9A/5WWPDcHpsAhBdZb3ewTeO7qTDLAp07aKEJbVcoryVK7nxw==
X-Received: by 2002:a81:b347:0:b0:5df:4993:4371 with SMTP id
 r68-20020a81b347000000b005df49934371mr586166ywh.39.1702221370881; 
 Sun, 10 Dec 2023 07:16:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a0dc702000000b005cf1ce8b96dsm2273898ywd.5.2023.12.10.07.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 07:16:10 -0800 (PST)
Date: Sun, 10 Dec 2023 10:16:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: bdinfo: Handle systems without getopt
Message-ID: <20231210151608.GP2513409@bill-the-cat>
References: <20231210150213.124370-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YM0539YLND1UQME7"
Content-Disposition: inline
In-Reply-To: <20231210150213.124370-1-marek.vasut+renesas@mailbox.org>
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


--YM0539YLND1UQME7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 04:01:56PM +0100, Marek Vasut wrote:

> Systems without getopt support fall back to plain full bdinfo print,
> handle such a case, which occurs e.g. with sandbox_flattree_defconfig .
>=20
> Fixes: 8827a3871452 ("test: bdinfo: Test bdinfo -h")
> Fixes: 2696f3ab8101 ("test: bdinfo: Test bdinfo -m")
> Fixes: 3ff2d796a6f2 ("test: bdinfo: Test bdinfo -e")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--YM0539YLND1UQME7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV11jUACgkQFHw5/5Y0
tyxePAv8CyYr1QORrXXnWZ5kGhJQzLdqp6FKmFaYOqF6FTEr2OjWP0Z9Jm882xFH
H+wHYDCnj48bP8Axz1YjxY7W84xPw1trfebdLrZdBIA5Bsnm230ppgWUENODhrPf
EmMviwGfYYFvyHHHtyt0Smk/e0vGm+yX9D0RzoHz4sxqKZ6PTXrxa4BSkOTPM0Dc
TW0wdRvQU40RS8gg404Dz5REn8hSZy2TiwgW5PLsNDSuAXoeYj2pjBrOD/HiJOND
I3ezQ5mSSPxo7jPEMkGJ49qJUENRAcBw8swC3FZbShTlnLC7gguW8K8EKWTH9UQO
YJ5r/LMfR4VlRt8I+e4CKnG7KSofML0ooVjHVupmEPKiNZqcpqVmsu57kpZGlNW+
t4s5D3rss1OjEWLh0C0kvabsUMloz7M4pQLoTk7XC7SzFTxPdxY+/qiEF6sJWE+J
zBj49v3NSffaahUazbQyTlsUMYcYuHegb0GWEZQdiUt8xYQK5aA3RcDI0pQJTjIg
YEKqEr3O
=yk/n
-----END PGP SIGNATURE-----

--YM0539YLND1UQME7--
