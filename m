Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB43C0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 00:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D61780F96;
	Mon, 27 Jan 2025 01:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uLwOcI4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5653C80F98; Mon, 27 Jan 2025 01:00:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B958280F85
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 01:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso32233466d6.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737936011; x=1738540811; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cpx8XBFbxigmyro/qfbnmSPvsTlbi1NxGll/VQ8e0dk=;
 b=uLwOcI4Bc1ID2URd9Xpc6xR5WrDzr9NTKWr5DcB0K9pJIVHvpHxObxqUCKFlq7H3YX
 nQcwKaWC7s7oFGb4Dh8myf99/588OJ89oiTOPfihYyXd3dSgyTaXj/7jJAS8vGqgy7Qb
 rsIrygmJyZ8ej/p+gQFR/aTSgbsKr+s+b6iUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737936011; x=1738540811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpx8XBFbxigmyro/qfbnmSPvsTlbi1NxGll/VQ8e0dk=;
 b=YteNa2ju59akGXUhvw1WRAGeJCQ7Ca5tFLyEQ7GUWCVm07q5/kMg3kk4nB8OkexVnq
 HpPRIX/UyqpCkMcJM+ebJ9RlNXzeaRtkTYWI69VwMVKylqz5POmIOUrdrmktOLyoMgUP
 oqi2OiYw7Z39Wct8GTXK7Av+PptKOuldZYDCa7EfiUQHg1/p4wdq9vwxiNh35GXSJRyo
 xfMarrXoSbuYmmz04B8NvhqAA7QoyJswm7AUaNfrhhNznwgdSOvfhaU7BMqgUDwzTGWv
 LUYPJImtxzJPd47Chr7WpgziHJ2IFK7pT8iS6f48BclVvG89tnuc666p6xqDjUryJ784
 1ayA==
X-Gm-Message-State: AOJu0Yz/G25yX8AboTJIEHOttHMg688IhVzJpKXFJ04Qjx8aYvvokH6J
 JyUikB0n/PZMbP9UOylZiWD7p06L93LrON6sDngGQ24+DpCskWnX96IdnsF32SB6ip2s97EICHV
 eKL5nxQ==
X-Gm-Gg: ASbGncviDsKw/I+9Rh2U//cS2hDmay9u1ZVDo72/f7VW/q43mJnGRovDPp8XmhCNuqG
 uSwdKAH3jSmELZVurZLcLPnrY9wE45V4QoRHbTXncjqMzU3KRgQkWjPhugqcr0UzF2QRiFaFMaR
 OOF/gFyJ7B1nH3qJvQaQlz7wwGqE4T+Nt6GQroJi4NHlXeBcTuuQUBIMzar2SqD5G9i6Ht2hren
 rLbqJ16Ozkl3KsNiF6/Hyba7PF+iRZ2XYl1aoFTE9ZbnpqFhzQQTE9OEZ9jptjFYswDkHj3S3nN
 s6ne
X-Google-Smtp-Source: AGHT+IEme9BwXtrS1isLMhad9RCDTSmou8WAdlVmTxRsaz8eYTpxR1Ihz4INI6H/QzeVjOyyND/CJA==
X-Received: by 2002:a05:6214:5002:b0:6d4:1c9d:4f47 with SMTP id
 6a1803df08f44-6e1b2141a31mr654998486d6.13.1737936011603; 
 Sun, 26 Jan 2025 16:00:11 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205ac4aabsm29384246d6.121.2025.01.26.16.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 16:00:10 -0800 (PST)
Date: Sun, 26 Jan 2025 18:00:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] Squashed 'dts/upstream/' changes from
 9b6ba2666d63..8531b4b4988c
Message-ID: <20250127000007.GB1233568@bill-the-cat>
References: <20250121203147.4133618-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zGz4rOrqldkk0xpy"
Content-Disposition: inline
In-Reply-To: <20250121203147.4133618-1-trini@konsulko.com>
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


--zGz4rOrqldkk0xpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 02:31:37PM -0600, Tom Rini wrote:

> 8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
> [snip]
> git-subtree-dir: dts/upstream
> git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
> ---
> This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
> and so match v6.13 release. Changes and changelog omitted due to size,
> and everyone who is listed as a maintainer of a platform with
> OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
> being marked as spam, hopefully.

This is now in master.

--=20
Tom

--zGz4rOrqldkk0xpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeWzIQACgkQFHw5/5Y0
tyy6cwv/eqlAAS6+VNNQuUyTpbWOLRXB3rk6mQ8CuslZrQ/7XUrg26HmX5rtq66m
FcnObmtU7LjAYoNJx8gK2NKoGV3PJz7g8Up+zgnNFiC/4+m0G1H2bZBa2CCbGPXV
oQsDR5KkSn9u8MkKMAo6pLesdcEQ6eIIrWRFuwl/noXQ3pw/MA/KeIUvfr3GrdAa
/janhj+3ZOQf3oApLhR/XJFnmsvMXPoaMvLmRuAnjXkwrWb+4dQ0vFB/V+cAxAdi
RYSQTzbk/RafV6Vde+6XA8ZPtlulrJ6kfpxM4Ey56zXj+v/Xa9UNZtgXB+Pljrzj
w2EigIDoETPvIHr/l+6X11n0PnOkZZW5XVYRqlLrbq6nZ0Dy4XZ//JSTdqoUGgYQ
Zz5DSAd8qEqWrq6uMykSgR6I8yv/xSBbZDR6r0xNj5OdhWKnzhN0iGuRMLtC/ckt
Fd9P6d6iJD92dU2oDRYHZ9hDesxKiMEli5DSraX/R0ikO8e24k6FdzSH88+f5wJO
99fJ6Pck
=23MR
-----END PGP SIGNATURE-----

--zGz4rOrqldkk0xpy--
