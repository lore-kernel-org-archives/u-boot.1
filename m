Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35338C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 22:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F2788A0E;
	Fri,  9 Aug 2024 00:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="leFMz6II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00BF588A6B; Fri,  9 Aug 2024 00:33:49 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DCD88669
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 00:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-25e3bc751daso964140fac.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723156425; x=1723761225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OB/TXOkALzgRqKxQSiy3W/feLSv9iBufawYHYRaVGbo=;
 b=leFMz6IIrbRipHTXuWKD9n8GnJhzOi1dXK+nAgR8qr/yVQYPuq7JDGvcWv1QkFoC6d
 r4Ew6QTqSGTSmv4hX7CmEk4MrKrxqT9gKzdoyHIsm1ZHMLFjz1wnJewSmdKb8AT+X4sK
 aKkzWB2Ov7U6wzUFKgUi4fzMGWzPomc3fcjpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723156425; x=1723761225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OB/TXOkALzgRqKxQSiy3W/feLSv9iBufawYHYRaVGbo=;
 b=ICVV43QMusZ6zEId4jwkxFXf9jcBg8d5D5swFvbYakSOot46Wh47ytbt87e4ESM4MP
 tx2veNcFrtqhEb64ur7jyKVfxzFp0+awwwytR5hpk9O0v4B9LsbcHE/daUxV1FXHwoNM
 K+RR8rFo88fmvmq0YZOfeB+rNI+JXErQkDk9VT4INsJlzcduw1UcmNKMhOeTbeIEBeM2
 rgud3xlfotoOh2WqqSSwziRBe4perz/mEMk+VIzzcSUt3hztYx7D5cHPMdq2aXHseRAR
 IIuK4tHMbFb/CBbvoGGEamw1wUbTqHEeaO6/U4muqOjaT3fxv1zlrSEfosD+XnIk134z
 R2FA==
X-Gm-Message-State: AOJu0YzFDDql0Olf/71z0BA57U6ZSBGlU1WKh3X71aCDdirl9FisD2V0
 pqm6DmOTpMqFLvVQUBIZYtHAnobboNys/QRwFoQ+0RlV3CZ55B7oVTWt8J61ONY=
X-Google-Smtp-Source: AGHT+IFpuX3ko7yXaVV+5ZH9W6Z/SqMGEQgj9IQjmYh2tBwWG193uC0izNI5WJ3FXiRaQYC03uPe9A==
X-Received: by 2002:a05:6870:e0d3:b0:260:eb3a:1b2 with SMTP id
 586e51a60fabf-2692b618d14mr3440517fac.7.1723156425342; 
 Thu, 08 Aug 2024 15:33:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f2269sm4897478fac.14.2024.08.08.15.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 15:33:42 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:33:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
Subject: Re: [PULL] Pull request for u-boot-nand-20240808
Message-ID: <20240808223340.GS1626301@bill-the-cat>
References: <CAOf5uwk7LP3T79P7qP0DsTKR7WOjq68y7y6QCvC9P=UPgU6-0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B9L1zB+LLH4T9NJc"
Content-Disposition: inline
In-Reply-To: <CAOf5uwk7LP3T79P7qP0DsTKR7WOjq68y7y6QCvC9P=UPgU6-0w@mail.gmail.com>
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


--B9L1zB+LLH4T9NJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:49:48AM +0200, Michael Nazzareno Trimarchi wrote:

> Hi Tom
>=20
> The following changes since commit b7d5ce05b1b52136af09cf34541c6a91079a4b=
86:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06
> 09:36:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de:u-boot/custodians/u-boot-nand-flash.git/
> u-boot-nand-20240808
>=20
> for you to fetch changes up to 855f9b6241407d19f01d4245456be428b5d88f52:
>=20
>   spinand: bind UBI block (2024-08-08 09:28:09 +0200)

Applied to u-boot/master, thanks!

--=20
Tom

--B9L1zB+LLH4T9NJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma1R8EACgkQFHw5/5Y0
tywb0QwAihf+uCOQi7uD9YHXeh6kh1/xbjBXfoaXjRDwQJWkxsFd3P7G/C0zgeJ3
ehnr610Wyzek9bDvszy7XgMnEYOyWR8LOf4DNw3Q2Tny6S6kPaLaJWSR8Fw8fPAK
d75MvZH16Bi5EJ45jMOGLafky9LVX+Uvr2wSU16wN4P3bp4OURrfDBgeV+GHPM9s
g0oaE9t5bRewlCoI7D9y3YV2lbqLThm+uMQVyp66AgAdkYGIju+DJiMY/zg87nTx
U0bZ+8kyyThuVa+Fb6UH1rDUSaDJ4jsevMAnHsutfNsdRWGVMa+J3zng3OnQaRAP
ayBl7z6siA4nDh0Iga6T5ZRGn/b3VcH1DwFZdGMQsYkraJI4g2ukmzgdENfg06Jf
UD3QolKFpejX3KdXIfqSL2Qtt2grv5IpTbsN9xBCT+xNao93pyH3Hs5ok9PbSw9H
s1s54NVMKe5FVCNxTOI0/qOdnajioV9KOTfWpbNLoes2BKjS77zPZkEhT91W3dcY
IVVCkP3i
=0gSr
-----END PGP SIGNATURE-----

--B9L1zB+LLH4T9NJc--
