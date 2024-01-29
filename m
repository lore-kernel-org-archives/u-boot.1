Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D5C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037CE87DCD;
	Mon, 29 Jan 2024 18:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hdJz+VQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6064387DB2; Mon, 29 Jan 2024 18:55:29 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5335887DB0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-603edb4c126so664267b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550926; x=1707155726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2LTFHRKH5Vvv/L9Yq9H6F1aieNsjZRi+IOv7kYKJX4U=;
 b=hdJz+VQjWAV1Wz6ZDM49T8e54rM1AKKK6w4669jta3Ktm2fBCIgF5EOOAd4+htCldJ
 lkZBPMo1M6v1USVjsYqHbNBpkLeZtONcOuhKlc/l0NuogipfOk7I/BfPwNN/79O1IzX2
 hVgJ0tNKiIymLaJlAxT45c+2RQ3/TmDbk9eA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550926; x=1707155726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LTFHRKH5Vvv/L9Yq9H6F1aieNsjZRi+IOv7kYKJX4U=;
 b=Ysy09sHuCbrNG6hHDItgBLfwNo1CmgvGIGu0F4jWZ2jZ8zjYeREtZeZQ8KHlRJmNeU
 rDfZs+JkdhI9X+O29KgbjKAGvhEieHQvZiU80sDFePSotenX5yLv7tV6mnmb8rmHy6YS
 xSFWC090sQ66FEXL7gT7AXTwVpD9dax/uGaYTkY3791QjV9Va4cT7TrHNVortPGyIzPZ
 wrK/57kTzJ0EVJ/BL7UCMxxm+piE15JHxXVyHo4K8jGz4x7xbLtJ7wpoCCdJFD5Tv5c0
 4c1XTmYfs8w4V0UqxLA30R1FWy4FYpWLkT52JGbrWkt6w7+5XeHabbbJQYDlxBSxNQDs
 6j5Q==
X-Gm-Message-State: AOJu0Ywx2XEhBxh2E9wGcc/yBZh/5ciy3SjGkuLe6ZAz/CzR6Ai6xzrO
 OlqXSCr4vxyYRL5kj1CNMU6mQU6xZg6D+A/NfoZqqVaXpK7w5vhpDnlLVtTRosE=
X-Google-Smtp-Source: AGHT+IFgBnkBnZrXiNa5TO3SZ3MJw9L+xatR/gfCTfbhKtA7QdRhO1zZ/NjWnlyVbTQZspAyVF9bZQ==
X-Received: by 2002:a81:de05:0:b0:5d7:1941:2c18 with SMTP id
 k5-20020a81de05000000b005d719412c18mr3941743ywj.69.1706550926093; 
 Mon, 29 Jan 2024 09:55:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t16-20020a818310000000b005ff9b0ab578sm2611159ywf.117.2024.01.29.09.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:25 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: gpio: Add gpio pins generic test
Message-ID: <20240129175523.GH1152441@bill-the-cat>
References: <b68d58b3a80a9b2a7082f5d1be4ebe07934cc6c5.1705639865.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xlrI6p/jtao36bLd"
Content-Disposition: inline
In-Reply-To: <b68d58b3a80a9b2a7082f5d1be4ebe07934cc6c5.1705639865.git.love.kumar@amd.com>
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


--xlrI6p/jtao36bLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:08:34AM +0530, Love Kumar wrote:

> Add gpio pins generic test for the set of gpio pin list to test various
> gpio related functionality, such as the input, set, clear, and toggle,
> it also tests the input and output functionality for shorted gpio pins.
> This test depends on boardenv* configuration to define gpio pins names.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--xlrI6p/jtao36bLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35osACgkQFHw5/5Y0
tyxQHwv9HhMjJguMNEhYBNMFxJOzdVXHxoWjFIOmKYrREcPjR4sQnrQRxJMTBuoj
w487/1/DCC0W7sBj/ZDIyf6JacP03QmP4/pi9EuKxusqn2IC/WQbEe0oqBZ8Au/X
gpP1Bn45CLcINVAff4XvgIW2vqLdFKKuKtOKF4JAGpdgZagJzEPxe6uSqZrRqtFQ
iffWDtD3EePilK/jVXFbKkILsoPF356jiMIE4voD22ELbM3jlAds22ohqUoFJK4t
jJR3Px1yfiewtUiHHPFj6UOxChP3nG3uotOUCtu09TWNi3suNKRG+Q1zuPUfqLEz
zI/GPWpSTwtaMEHXtvyLu/GJAvibsjxo5/6PIj5NzDxs9l2m8KRo9/QVY9LB2WeE
aU5Zl7v7sjv1k6FR26FGoSiAAMKExiHNPZtmaRg6kv8v4x1DJZcfOh0wwW773bi2
KDGoE8bZ42NkpNj7I/mqpMnzEXrwaQIGYEoe3celiyoPsirPkzkyV/+WhYbFL7qG
BoDsTwjM
=IE/s
-----END PGP SIGNATURE-----

--xlrI6p/jtao36bLd--
