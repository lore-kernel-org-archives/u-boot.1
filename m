Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F9AEF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 15:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B4B8366F;
	Sun,  8 Feb 2026 16:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="omTcdS8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512F583AA7; Sun,  8 Feb 2026 16:04:00 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA688341A
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 16:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfccba483eso1192486a34.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770563036; x=1771167836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RsFUl0cgxrO+4GWJOtKlL4HY2dZylWI9PI7RokT1Gs0=;
 b=omTcdS8SdiUf9e/x3E3bIUQbDtFROS6ZvmMcL/jZt7IrWQ7Pfl4yKj7lNxPjeHZSzE
 yFf7GrexRGHiY5mBkPA8gm4weSZyJXoTAq5YeFkyXNx5VHX30xvW7uYgN4NdrKrleUEA
 Csh6rQoNBSEd5yzgyxoKwZ4cMWNyg89otPZdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770563036; x=1771167836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsFUl0cgxrO+4GWJOtKlL4HY2dZylWI9PI7RokT1Gs0=;
 b=j5WVEpycdY1F1WgcFZGuyKfBVye9OZagwHCZlEcrBQfROufWxSXbw09rHyOuYaBgIw
 kHGWftEOOtM1uvNRwVzhb9oRAD13JtrsV3CsQQxdsuT8cDrOawQv0qVvm997q9h3ZOdg
 mX0C+JoliWrqfiNtkzT5uIXJXndihL6cVYikiA1J78scIzOGAeDRtO5TxQuq/Rt41C9T
 zNiOmzF5Gb4EwvclYOVKHH9HCZQWvpS0YGzVHmCwyDgWCwGm6i888cO4GpOn/XweUESF
 YLDKw08vJN8ffT4grxzeJTW9QJum4tM5pTKcSYlbIXoVhYS7CJSGEdpV9/Y6oKkkWnUJ
 eDUQ==
X-Gm-Message-State: AOJu0YwK2D59BN+QkQrqX/hW04eu3nvTr1zEiEYG8TSgt0KLXYO7odqc
 +/mAzgX2ezWeG4jwwyfVFxLatS6Pselmw6QYzK92p5UAHvPH0oj7OmB1Yr3UxgFEivI=
X-Gm-Gg: AZuq6aLRgNv1WBbv392lrx+GomfwFN3vtkTKdDgUX1MMF9WFwao/atPk/SrdtASscz4
 R6UtTe8yYnMq62+wHP+6ZilDOz9EVQolnBh/cNx+Y4wnZ2SmTXd62aIdieA9bWWvI5Qz/bK3qek
 Au/GR5PUy3XS8RMMYMWxnsPY/OsG84oql0e2eIZgjwYX5SftqJxSmqonq2lSxrY+2tYt+vPmU4U
 ElLnQlUfYIiK9J4qw/VF1eS2UFT61douzl3ybMWcUIngnmQlFmgxZEFNUZp1ofKufHxENeFMtyP
 Bdlr9xnhzxHN0MV+I4CTFXfGaK1syerr0pnrPM3daH+Xx5Sz6+85ziEB4l+nRt1DUYGbFH/Glck
 kBg7Gw75mb2kJqQecc6dvvzNZ9J6BtJu8SZ8XtKQ0Q5pK9uW102g1+fsGLiff/z+NvYOQbtf8UM
 9acSXUU4NlamzR2jCO2hDcokbSRmj3Df3ZCpSNgK86JzPrT2ycXIAUSFhltP7a9yfQbwfwjbfDf
 Y1WFZ5C1Q8IQL9F7MLJ8tJTpAKkrI4ntAslLGU=
X-Received: by 2002:a05:6830:67fa:b0:7ca:c803:f539 with SMTP id
 46e09a7af769-7d4643d3de3mr5457976a34.5.1770563035934; 
 Sun, 08 Feb 2026 07:03:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464710c95sm5670587a34.12.2026.02.08.07.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 07:03:55 -0800 (PST)
Date: Sun, 8 Feb 2026 09:03:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] cmd: mmc: Drop trailing space in Name: before newline
Message-ID: <20260208150353.GC2603314@bill-the-cat>
References: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zNc6IAEyvs4FoamL"
Content-Disposition: inline
In-Reply-To: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
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


--zNc6IAEyvs4FoamL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2026 at 03:51:03PM +0100, Marek Vasut wrote:

> The Name: line of 'mmc info' command prints a trailing space before
> newline. This is not useful and shows up as trailing space e.g. when
> the output is checked into documentation. Remove the trailing space.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zNc6IAEyvs4FoamL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYil1QAKCRAr4qD1Cr/k
CoNnAQCZS2yeNfNdTsD0e2rbyC421kNniR68h8WDkZFXYD662gD+PerCAXfdYe4Z
MFJ+nHP6HYmTXj2fdM/vEqKPtcUInAg=
=quFW
-----END PGP SIGNATURE-----

--zNc6IAEyvs4FoamL--
