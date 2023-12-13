Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ED0C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1DB878F5;
	Thu, 14 Dec 2023 00:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="StKzzpUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9781E878F5; Thu, 14 Dec 2023 00:06:05 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E22987916
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e3338663b2so6248347b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508762; x=1703113562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mLPoruMnYwASJpte0TI/f8uvn+DnpP4pTgV9lq87ryI=;
 b=StKzzpUFr+SJECD20BQSjbADwE5ZLPgaBTitfv9lS7NUTUW+xU/MmZZQlaQEiHqFYe
 MUCGot3hgffS6u5vG01PZCGqXam3V6xe8f9bTibCrNfa5Fxct9wRnEnA4hAbHiph/4vX
 SpPi8EysRmQwrrJN8v3QLdB83DffrKkVcCJ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508762; x=1703113562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLPoruMnYwASJpte0TI/f8uvn+DnpP4pTgV9lq87ryI=;
 b=uE9jyFlQAdpOj/jyU1qIzsLNt57x86+gekj8MzmjH2BF3KROks4lJ5mJN61VijAJkK
 9HAz7mbc5kw81hJnKS2DZveSHHQck/FIRTKqCltq1VSqbCmnDxZc3yEhsXfEhiuHy2kl
 SUccvAPDHRfV5MdfTBqQNE/xJXa0zC1MLaL0IhPUps1ESS3b3ZeR87Wv3jHJmnDL1Etr
 mV8PMqaYmqt51Fm3Nz+lTkKO11OVajo5M4uqHl1REjS4RLJkMBzkLjN2PK4A4u4U22hG
 K/CK0uO6vO13/4tiEx7nNdMV4MqTmONVnFW2WnmTnASJV/XLr+Z+MFfagdDbjqaz93/C
 s2Cg==
X-Gm-Message-State: AOJu0Yx6H8HGRdDKiScJy4iZW48APmEoUK7UtqUZ1eTowc+Zm5El7NeP
 5DwwHMa/ixH1ONe+w8fKacejcw==
X-Google-Smtp-Source: AGHT+IGC8ih+Z0cOq6+tTHQzYd5BAxZdcqnP7h3Q2gWpj4Z2dcJvUrM0QtMZm4Fc3W0kPkpTgjscvA==
X-Received: by 2002:a0d:d407:0:b0:5e3:792e:5dd2 with SMTP id
 w7-20020a0dd407000000b005e3792e5dd2mr173954ywd.74.1702508762234; 
 Wed, 13 Dec 2023 15:06:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a81c206000000b005ce93212c47sm4965692ywc.134.2023.12.13.15.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:06:01 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, kettenis@openbsd.org
Subject: Re: [PATCH] MAINTAINERS: Fix ARCH_APPLE file paths
Message-ID: <20231213230559.GP2513409@bill-the-cat>
References: <20231122162115.508690-1-moritzf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="crFOoy7K6l9Sm71w"
Content-Disposition: inline
In-Reply-To: <20231122162115.508690-1-moritzf@google.com>
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


--crFOoy7K6l9Sm71w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 04:21:14PM +0000, Moritz Fischer wrote:

> Fixes a filepath in MAINTAINERS file that wasn't updated when
> renaming the files to match the new SoC name.
>=20
> Fixes: a4bd5e4120d6 ('arm: apple: Change SoC name from "m1" into "apple"')
> Signed-off-by: Moritz Fischer <moritzf@google.com>

Applied to u-boot/master, thanks!

--=20
Tom

--crFOoy7K6l9Sm71w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6ONcACgkQFHw5/5Y0
tyywBAv7BERtzb7DGpUPjnoKN5VjWLhyjR9s3KgBKJVCiUYxjyREN/zLYp0aewe+
WnHyBBvoLEROu3bBeQEAiCwgzd8xBuuVxwP0QOsqzCK+zOBYAL7Oxhx5dIt5+Km1
WnZO47dLJEWaM1rNrz+HBQeVQPoSjkdyVtYxP+Qq6jsGaRCIU2GbQ54OfZy4h3Ms
Zi3q6CqFn79VnmXDzCDmxIItDaeQF/UcACFsBZRG/hv5kYBwIRR7004aSdDOD5Dx
8ue6pMfS66zTI9SOIwTx/F8SbjL84oamSWJQLmKdfsf4cV9RLuq7H+1L2n46RN7e
rn7redPieEy4bwbV1o/KbmJ8/4wVV/iJmfLMqjvodlSW55HJbKfhTXA1pWKieL3E
rTTs6gmhWFY/XT5BuLMcIrqEr8odKczskk1wo82PJoZ9ccNV9cPcW/S9GnPyBoru
VQ1OdDBVoadAWZhP+Zb872u//rNkwzrud+uu2ZWnajZ/xSoYeb1+i/4caiLg4rWw
nyodQh30
=Tixn
-----END PGP SIGNATURE-----

--crFOoy7K6l9Sm71w--
