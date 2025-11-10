Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66F6CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 14:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D7283A03;
	Mon, 10 Nov 2025 15:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SYYYOknr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC5C83A24; Mon, 10 Nov 2025 15:53:56 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC4C8391B
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 15:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74526ca79beso2216736a34.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762786433; x=1763391233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TUzOumX3LOSwTXMqz514bN/U+qStBL1zCTZ3138Ety0=;
 b=SYYYOknrvbRj1weP2xo2mgeeCO0cfv6xBYeH1l7rLrHc/HfsfQh+AWTjSPMvkpTT68
 dJhb32F6zLSyrGS7aAk5vC/yD5XuajDov1L4FEisNcBJf70BbOLZoUNvWsWXHs8r2TZy
 8Y6H97WnfXGcTs/E52No5LlzEhPM8MQjd1HjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786433; x=1763391233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUzOumX3LOSwTXMqz514bN/U+qStBL1zCTZ3138Ety0=;
 b=YXg+RMNmAtZ+HycPCg4ue6LvZ8SQd4r++9ZgYqAp0u2buVakGWgPPd2GyJ3HSm4FJQ
 vfV9BDIb5NZUmB6Fe4nDYaOeQC7qFkau2ZZTRWOhJloRvhV98FrPb19M2b+zlz0Iu/52
 Gxy5ZXq/GRBbl/feI9P3CLMfk/DqN2hbFItNJscqqlialM/e8S2Zm7AQH3QFsGHE4+Cz
 TiuJO4tXaS8rQhKMvqurjPtdoN0nPLGKmM2UY4BUr68hPIfS5RBRzRUnRM8YmczqdIC4
 d4IL6H7iG0qZ4Z4GYwAg5XjvOap/VoaGH93ZfxtGzFrUMl26iph7ClupJjP3KjLsJPIw
 1vZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfs7qWpCJG5LN6cbsotdvtnia6kwM8fdmv9hXp4278r8/uhPekCvxpSmeBp9f6q9XiaZw/VH0=@lists.denx.de
X-Gm-Message-State: AOJu0YxJwq11wMmg7mSWMr4jdww7WtPZwnHnvnhZOuE5Mv0+WYviIiqU
 8/UObZe/I6K4UtTELnRDuZAqbCF/5R5NZwrIW/eao2p82+utTCIgsTqEqhim0kezKRM=
X-Gm-Gg: ASbGncuH/fvq7EphL1MiVLdkFZrechqDtD3MwPeuku4nx7znr3cA61FdTk3JzoN8Z9f
 5JnxwG7nuWobID1MGi9Wn9anohiggZmEHNKb4LTPz8jdfQmIbiEFrw/Tu/ermf1OdhXQGboQZ+U
 9E/260acD9yEjEYLgr/CFULhC2Row3sxRCry8zy628hDC+pLL2lW7djiHW+kUhHmXz+AqgARgYe
 LWye6U23rCkONMouNQynrwFLk9JR7tKqVge6FDz1CO3uB/RgfdMUzBKgPuZ1brxRFUD9o+RBIaA
 ub7XKLG7QnPs4peKue8EoTjkA4NW32Q8wz5H2uz8TynJMRsVeT1OKSIsqwHlzV2H/MQp5fI/QWr
 wtKcEXFgMGgjIb2i5cMv6XuWok72z3r/pCtipuB8sXGAkp94rDJD3jSdtuU9c8Jk7RWUA705xFN
 f6mKYPlDi8Q6ztuoyzy+ZbPG/d7qAXJGmQPG+iRQI=
X-Google-Smtp-Source: AGHT+IEHv7I7LctjxtjN+sVWlmZ086ULkC8puuEdV+CRYrUq+CDRs+6YnyCFGbQZ6ss8OsAQvbHjYw==
X-Received: by 2002:a05:6808:6a94:b0:43f:a37c:59f2 with SMTP id
 5614622812f47-4502a1f51bfmr4318781b6e.27.1762786433076; 
 Mon, 10 Nov 2025 06:53:53 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656d1fef709sm4343383eaf.0.2025.11.10.06.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:53:52 -0800 (PST)
Date: Mon, 10 Nov 2025 08:53:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de,
 John Ripple <john.ripple@keysight.com>, Peng Fan <peng.fan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>
Subject: Re: [PATCH] arm: imx: Add command to get offset of first image in
 AHAB OS container
Message-ID: <20251110145350.GK6688@bill-the-cat>
References: <20251110124100.4193259-1-lukma@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kUJ6QV8/sKrINMsy"
Content-Disposition: inline
In-Reply-To: <20251110124100.4193259-1-lukma@nabladev.com>
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


--kUJ6QV8/sKrINMsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 01:41:00PM +0100, Lukasz Majewski wrote:

> With current mainline it is possible to check with AHAB if system OS image
> can be trusted (with 'auth_cntr' command).
> However, after the validation one needs to use the image (fitImage in this
> case) itself. Such operation requires getting the offset in the image
> eligible for AHAB validation to start execution of the fitImage.
>=20
> Command in this patch allows it, so with:
> auth_cntr_offset ${addr} auth_cntr_os_offset;
> setexpr addr ${kernel_addr_r} + ${auth_cntr_os_offset};
>=20
> it is possible to boot the fitImage after AHAB IP block vaidation.
>=20
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>  arch/arm/mach-imx/imx8/ahab.c | 50 +++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Can we please split the commands here out and put it under
cmd/imx/imxh-ahab.c or something? Thanks.

--=20
Tom

--kUJ6QV8/sKrINMsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRH8egAKCRAr4qD1Cr/k
Cv31AQCq1+HSZTgOfveyOaeIl1vX28M5hzYkWRqIAjZfSg4IkwD+Np0ScAFIYptj
evU+H8nQTzBYlbtDS92XcANyjmo/bgM=
=TW5u
-----END PGP SIGNATURE-----

--kUJ6QV8/sKrINMsy--
