Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271B4D132CC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8290488A0A;
	Mon,  4 Nov 2024 14:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e8tfH6US";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D836388D3A; Mon,  4 Nov 2024 14:56:38 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EE688936
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-460ad0440ddso26851231cf.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728596; x=1731333396; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sofPgIJ9dLEnEGFQyFFj4s/rvp91oKvPTEoBnSBhGRc=;
 b=e8tfH6US9UQe9Arwd3NZAVAKVWx+9CG6qc5BLaneTZo90hxtL0kYv4nAtKfMO8zAKO
 LAAxlgx1s1AN0ZTO2zdpqwpIm8JCF0bAnkIIDvslOXIhgpwZM6++ZlzCI0Qv312U13bs
 uziqXGrM1oui5DQiXfAk2TQ/F4WcCxl/KHTvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728596; x=1731333396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sofPgIJ9dLEnEGFQyFFj4s/rvp91oKvPTEoBnSBhGRc=;
 b=rt6+RlNtPKNpHsiGcYrLAx6tyFPoQYsVC21uoDGgPuw2UpQioyiW4gu4QVq76M9/Qr
 aT9vJndweiyieUZba9F1zeWiElm6yXyxyFuJjlYU7DTCVbekHaTVCno/0fp7+Z2yr0kC
 XjjmmEFQ8qUu9zR/KzLNcq6uSatbQam8/oCUFgBEnK9OwOfOFMEQYi+ULTsu/JTEKF/3
 DyiPE7q+hrMx/kXa9r5KaOfHJIrGuZpylrXKD3q1jzb4rp4bbkURRhKl+jeeb7LxQ01+
 KfA+e5sn+eZHJ3G3vCE4MhSg2aPD1aDYPSCou9dthT1Y9ZXUalgSSaPuAtbQOTJgmifX
 J0Tg==
X-Gm-Message-State: AOJu0YyEzN7DqZP/IrGGjS4k00hHbF7sZSM+6Cw8S5RH2JtqIQBHquzR
 DLSeRGe5+7L+VwpfrHRFLd7MOUnwwrii/jlw8weSxmKtWuEFNDJVsMowdjuCnlvbDFNQnNhXXxP
 mwPE=
X-Google-Smtp-Source: AGHT+IEs9IBhp4xJzGkxCVAPYY0VAz9hBW1Z6hdREMNx2hLecWHHnHhgDH/CwbVxxGrbJXACgcYcZQ==
X-Received: by 2002:ac8:7d14:0:b0:460:aa51:8411 with SMTP id
 d75a77b69052e-4613bffb691mr510261501cf.24.1730728595706; 
 Mon, 04 Nov 2024 05:56:35 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad411faesm46779031cf.21.2024.11.04.05.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:34 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 5/9] docker: Drop grub for arm64
Message-ID: <20241104135632.GK3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aHohQfeAh75g96KN"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-6-sjg@chromium.org>
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


--aHohQfeAh75g96KN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:49AM -0700, Simon Glass wrote:

> This doesn't build on arm64 at present, so drop it for now. We only
> expect to run sandbox tests, so perhaps it isn't needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/docker/Dockerfile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

What is the build failure? Depending on what other prospects for arm64
build hardware come through I'm hoping to look harder at more build
options, not just sandbox (but of course, QEMU shouldn't matter what the
host is).

--=20
Tom

--aHohQfeAh75g96KN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0pAACgkQFHw5/5Y0
tyyzbAv/ei+HSbQNjNqNTTTR4iz5fg5DxKPXflfd/Znqa+QMohnAy1RAOBLflJ3L
7HzFcMm8odiP9fWyVL8iDgd9oVUITBeFHgrOiE7IrQP2sASKgkh9EzXpRNfhESvG
CzHAn31qyNdxtOKDZM40toCS7bUehA2QqaV8/GQdW49A9hvsqVT3VRgkXwku31j1
n7ELlBanfPwKOcyWZgrhxjQaWAFhN581Df5l9tgo7SVF5JbTkynQYD2pe6s1as01
lx6IBxcwIRGYvJC0wKGrg/kr8tpJ/W3e7KTZqLTch9rtvk5/3C5e8nTd6XA4gpS0
jrdg5kjxhuAB3flYsEAZ5xpHXUl0RVtdEXLnuQu/y5mHb6j9Lq6S1JCtDw3tAiGp
9D4cpLNdERIaj84zpqjblGH2VZScmQSqybwPqCQaYSa0ivSwjiexfPPMIx2qPj4v
E4K1Db6WQ4DJVrmpqTb5+YeXsPzyn9NGqpT1asTUAr8Z3661mXYO+u/2+OJnqyrb
EgaYS3pO
=j/Ro
-----END PGP SIGNATURE-----

--aHohQfeAh75g96KN--
