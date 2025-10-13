Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C7CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB8C836EE;
	Mon, 13 Oct 2025 16:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lYZIopoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD9C838A5; Mon, 13 Oct 2025 16:23:39 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C73C836D2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ae21804971so1502436a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760365416; x=1760970216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=By3gKQECTKCRFSCXjCAplFdkaEFZNN8QWIkzYkct8EM=;
 b=lYZIopoHHQhCHez30C2mZh2QtbKAye433n17rMoN2cEFK9s1wrphAPhbzBy/tBgtvy
 7YHWsHpssBifSngZ7EgJ0BgbcvEoQ9AgPjh93EmHYTGC49Lb2nPrKFux3FEJgcew7oXZ
 5zW0v6XbaFXhhLndA97Gc8mCaJIhiDu4X3W/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760365416; x=1760970216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=By3gKQECTKCRFSCXjCAplFdkaEFZNN8QWIkzYkct8EM=;
 b=cWsjD+TYu0nLk+jzgT2AhLW8NjWyed9kWXLXf/6joAO/VTMXn5gqOAcLNxR8AfJAN8
 PEt5KEvhHsBkgFjKse/PDGlJiU4qkxGvS6UmL1ItXCF4jnwQLBF3v0rgiqd5IOIjhK7O
 EZtZchF5CFVGt+BRmEgpmyI1IOkRF3i/2/R1ylJ5uytvAeWX+MDJB7/wM6A720kjyfI/
 ozwBmKWkXTEbr6WXsPkOajaKeG0IzNOoi8PwUq+IOEJRSPO695iqhE1DrHJGOOjJ58In
 Axbr/Vrxfm3wRjnmHYKbYZXXKNv7DYhzc0fgdrPN7syEylQ3YfreMsiCm/+MHaazZPP1
 n1tw==
X-Gm-Message-State: AOJu0YxIPupIIvSsTfI34WrmYgxYv0L7lubPPN8Wu1IamXwtM7wc6M7b
 MnXn3PzN3EEV4gfsVa4qKb8a5xdx9wkr1l0xR4IO4ae8JjiUYhI5y1kEqFk8OWHykRM=
X-Gm-Gg: ASbGncvnH40pB1Thl5lYHJJpk/t38n2m4gaEMBuvPh6YaScTvGgtYJ6WCVFrZywHQA8
 Dquhsdf0Q27txO1V4Jx8p52x+J+rOPkGKyCpOOu6E2EiOE1Sq8Xou4qmrCoXxCdDN6DbWLNDTD3
 oStXdqA4Ao4T4+bExKcfFuuaKxu4IdZ5d2v3IDQfDRODunXStmSxvMe/ItwMe7Vn0+2SP6rLwVZ
 6OfgjhAKRTdTV0Kmt1W93EZM6kugT9fiIkix2Rm3HK879JRoPdE5vmzvNSqA2TPWTxnGbuSHegK
 Zs+boVFJCfD2FY0jD+qef4wdQbMx1E0sxOOOd2vC+APus/CvD/GO30ZYYVyAKnzNA3T+t6G18zP
 EMJY7zr0OS0KGYGGY44tixI7VS/X1hr6hsFwGEvpqXNfm25FmwKRY+vEjbbSk8HDr0+Y4rt5tMj
 IBRHHJzxPqNaVMebs=
X-Google-Smtp-Source: AGHT+IF5JRX9j0EouFz0BwevPnc2DR6cFHV5h8WW2KjL4utqONSx2hgoXOqbfjdwMGQis2y5YORR0Q==
X-Received: by 2002:a05:6808:120a:b0:43f:7dee:469c with SMTP id
 5614622812f47-4417b2ee481mr8959996b6e.11.1760365416001; 
 Mon, 13 Oct 2025 07:23:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181e759dsm2555336eaf.12.2025.10.13.07.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:23:35 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:23:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v5 4/4] boot: Move preparing bootdev into a function
Message-ID: <20251013142332.GE6113@bill-the-cat>
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2kTXxe6qCJHDKB4Z"
Content-Disposition: inline
In-Reply-To: <20251012064412.2892979-5-sjg@chromium.org>
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


--2kTXxe6qCJHDKB4Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 12:43:56AM -0600, Simon Glass wrote:

> We will want to use this same logic in another place within iter_inc(),
> so split it out into its own function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2kTXxe6qCJHDKB4Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0LZAAKCRAr4qD1Cr/k
Chb8AQC6SKCZt2zgpW9twLf+Lhgs4QDZQQY6GnYi8UvDrboSgQEAqU7pYgDRX6S/
4zlIF0dNYzpOQ3+53KuhUqHIqLptGQs=
=emSp
-----END PGP SIGNATURE-----

--2kTXxe6qCJHDKB4Z--
