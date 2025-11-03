Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ECDCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DCC836D1;
	Mon,  3 Nov 2025 19:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q5iBHgDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DC683700; Mon,  3 Nov 2025 19:31:41 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095E48331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-44fa105ce72so1312015b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762194698; x=1762799498; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hZl2KLYBzWBdUSTCzKtNTJzxkbevxcZuwAHwBkBaOLA=;
 b=q5iBHgDc3KZM5e/g8WCvd7KQgoJsDMa06TRy+dfuNtJa3G+V82FXZ+afhNYolVyEFw
 OapMs01Yui8/Zhi7WFzVHTo7P/PAXqne55XIQuJUUgKWxz34rhuCZd+KSW9csedzX7yK
 gYkZZnnfaEQ6iN4U03sgOW6kXd8UpWh8JGYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762194698; x=1762799498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZl2KLYBzWBdUSTCzKtNTJzxkbevxcZuwAHwBkBaOLA=;
 b=wwXa8G90FKapIh03l1VWEShf6dBOTQvc910X3jHUgGqavEWMGeaHKSZgiRbC9zEyPa
 P1bIf7dT4HfN46wjyR7Yyddh57hhvEV62iAL8LHi8sQrz0CGfwfBqf02dytYNW4lQI5Y
 +eV3OWl5PyIFpbSgMgwhsfJ33aIKZsrPGqGDqdzj28e8AaKJl2sqfNno/JmEEawxOj2h
 HAqfkIzJvypySuMlPpRRpxnPnpfcTv+sK0oAcDn3c/ryPec6tlJbjYy4zEx1nlS0bJJ7
 ZbB3j2BA8qIX8dnYxmXwYiWmTwbJxINcD39caw5GdsyTL/Py+6CtG9T26BwNdmFEQwoq
 vhlw==
X-Gm-Message-State: AOJu0YwHN+62zqyQefVpcGHQGLLhhCRvSEij3u575uLd6FmijaHP8rtF
 XwJ4q7PwvxU1ZjxGzGtt56JYqROioa1IpTVMlcwuIQ6YEdA81C/yjjqsHKFln3Zx2ug=
X-Gm-Gg: ASbGncvnWay7N+Rldy1QwCoDW/wi7TerC/gnF9WAvMY4b+okqDrcBw8vo11dsEb/vUw
 Pm1UQP5VYv2jzGPev4zU6+jnAM/hlANxCJdjBJLEXLb/dquMyjw1MbYxGRPqBcbRF4mnFr1xrtR
 bwHf2uBi8KTE54Zc65Q9TYF/4UeNW3SrT0QG87nlk+cCsvV18jTG+7sgFfhMQtJcLu0pvBGm06p
 TCPm6iZuGGg+VgOrebAYGg0QJ8tdJ3ayBwsRNMNzrBNaVdZMUX78uW3gmjgnXgokmLecwmVwYgy
 x7waOwdgj/ybl6uusTweYImzcXnbWD19GF4Bzpy/bWM5AvOPLXBeWukrlB3CbYiKK0neEdyEosQ
 KbErMTyW/uUF2zXNxo9KtTgVbN8Fkb2y/ck4ryXAqCu87Y5BsXCNjyrdF3tlzQxJ0rpRXTWrKWI
 z57Xs5mN7rJDT8qYzye+kztugZnouIzzs+34vFdRqVj04eUy8UiA==
X-Google-Smtp-Source: AGHT+IFvhrCCUPJr5eEcnnjkGf/MTWTgmhXLsac9YuiF48ao/l+C6v/UBR60TvtSWu6LAUS4hZjhQA==
X-Received: by 2002:a05:6808:1718:b0:44d:b860:83fb with SMTP id
 5614622812f47-44f95dfb199mr5059338b6e.9.1762194697655; 
 Mon, 03 Nov 2025 10:31:37 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd8864d39sm246142b6e.12.2025.11.03.10.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:31:36 -0800 (PST)
Date: Mon, 3 Nov 2025 12:31:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/2] Fix AArch32 compilation with Clang
Message-ID: <20251103183134.GQ6688@bill-the-cat>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n2VLPb8WtA5YPdAg"
Content-Disposition: inline
In-Reply-To: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
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


--n2VLPb8WtA5YPdAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 10:39:57AM +0100, Dmitrii Sharshakov wrote:

> I faced some minor compatibility issues when choosing Clang as the cross-=
compiler for my target.
>=20
> Please review these two fixes, aiming at enabling Clang-based builds (sti=
ll using GNU binutils)
> for 32-bit ARM targets.
>=20
> Tested to fix build with (also run-tested on qemu arm and arm64 with clan=
g):
>=20
> make ARCH=3Darm HOSTCC=3Dclang CROSS_COMPILE=3Darm-none-eabi- CC=3Dclang =
imx6ulz_smm_m2b_defconfig
> make ARCH=3Darm HOSTCC=3Dclang CROSS_COMPILE=3Darm-none-eabi- CC=3Dclang =
-j20

Thanks for digging these changes out. I'll take them soon'ish for
v2026.01 and then ideally be able to re-enable LLVM based build tests in
my setup.

--=20
Tom

--n2VLPb8WtA5YPdAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQj0/gAKCRAr4qD1Cr/k
CvFzAQC6j6rx42HRms3rtO/PtD+KajARtEJOQ9sVp3PhHCX55QD+Lt7LESeAUDui
ZtHAFu4uX3kd6ienlUOqRafqEVY2awM=
=w83e
-----END PGP SIGNATURE-----

--n2VLPb8WtA5YPdAg--
