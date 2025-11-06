Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCBBCCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 22:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7534983C0C;
	Thu,  6 Nov 2025 23:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uct8stK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2196E83C0E; Thu,  6 Nov 2025 23:14:01 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F379783BA1
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 23:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4500b2ec59eso62346b6e.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762467238; x=1763072038; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s7kHm1H8Z3QUtI1dTrlqicehFdZqCcvXWAb5xXglo2A=;
 b=uct8stK8sRcX3qPb0INto5uAdcmI8Ey2B2zu/ZXqKv+dHDGk0NML8B7OgRFaq27ex1
 npKYqUnwch4YRT5BeAFcbT4UKWiOTjAPNudAvaVU+3+yfGatlvfWgC/UfZ2jEX1/ApzN
 Zn2B6EgVKUL2LOBqOxQ8MsudUxotpiTJmxdrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762467238; x=1763072038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7kHm1H8Z3QUtI1dTrlqicehFdZqCcvXWAb5xXglo2A=;
 b=PGvo1hinjpao0EB14klJWaZykAlAcd+dM8/ruaSmFqCfyTrRk8CE3UewCj18Su6yiz
 OPvi/8nYP8RNPt3hBDEDo/ATMHKQJWTqgGSU8iTiq1/SrldAywgl8ZB8TL98c/4sP2CT
 IxWyl5P9YGdRLcLMoyTXk7raTxKnC92g91J/uOpWRxm5qUa/aVfi1azFbVu6V6pVe5VU
 xkGNp+OTuHSwATmEjsTHjUAzSdDTj31qklJfBvfSmi2pVTcFuxLrLnNdG+G47T2/Ztjq
 riy5YwHzr/OHuyfLDiNDTlnAq+NALKaPFhGX3LfHYIxljot2P6QTHRJXoCEGqjXNZRV5
 4IUg==
X-Gm-Message-State: AOJu0YzyywNDNjvBCrjYCPwCMjt4wvededdTbhii02H2rSDC/wrVsScO
 67FS6LLq3J3IX+T+ouT6MH5giSJN8gZ1aO0jVVCZW98xVZSbTulgkE0lVBxiwbMYfdD0x9DPlbH
 G3X3Vlvy+kA==
X-Gm-Gg: ASbGncvVetnFw80JJgbIa24vRJj/OPNrGNvcIoSYtVV2IzTKXrmCikKSloAF5qSx60+
 xb4gYUkZxJJsKoMmMCA2U4QaYFDgSLPhYHrz8d6B3YMbnqOTtIcg9z6AT7Ib8M1XhyumcoqRq5+
 Jl1G6YkWhhyr+50rZC41EH+veAVHMqlDgShcXElzkOTi8f9fiFDaaUCVln/h6xFlMSvuDSlKvbR
 5BPCcyxKw35nsDpQ8O0Zi/76NXLClF6MBF5uGQFJ9c9IsiUH3P919P5cERQyat7HENQuB1x8/VX
 wL3N4FUGLCgI9pEtHHeWev0/oHtJxJ8CvLBjN/5UYgc69wSpoLzwlCrt/fcVL7M8U1CbFNIk0bd
 wkVQs1EgQyRnciZQjFrRJAMKoH7qY6euNykgtBhODrHYdaqpDg3CJqHXflug8psGp2nuFJoLLi/
 KCQKiSdlbih+TcSnr3ZRJrSDVjipJsXRpyfFHs9TU=
X-Google-Smtp-Source: AGHT+IG646Z0njm8y5QbxIqxNm0j7DY2H20WpXcW4m3l7bA3Lh+Kap4bGFrUaDbMV3dqvuJGheiVVw==
X-Received: by 2002:a05:6808:4f66:b0:44f:e6fe:c919 with SMTP id
 5614622812f47-44fffd46242mr2497897b6e.17.1762467237701; 
 Thu, 06 Nov 2025 14:13:57 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002592016sm1304657b6e.7.2025.11.06.14.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 14:13:57 -0800 (PST)
Date: Thu, 6 Nov 2025 16:13:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/2] Fix AArch32 compilation with Clang
Message-ID: <20251106221355.GZ6688@bill-the-cat>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
 <176246626861.3129497.14948596131312532180.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/8qfOrNquYtY2rpY"
Content-Disposition: inline
In-Reply-To: <176246626861.3129497.14948596131312532180.b4-ty@konsulko.com>
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


--/8qfOrNquYtY2rpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 03:57:48PM -0600, Tom Rini wrote:

> On Sat, 01 Nov 2025 10:39:57 +0100, Dmitrii Sharshakov wrote:
>=20
> > I faced some minor compatibility issues when choosing Clang as the cros=
s-compiler for my target.
> >=20
> > Please review these two fixes, aiming at enabling Clang-based builds (s=
till using GNU binutils)
> > for 32-bit ARM targets.
> >=20
> > Tested to fix build with (also run-tested on qemu arm and arm64 with cl=
ang):
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!
>=20
> [1/2] arch: arm: build: only set -mgeneral-regs-only for AArch64
>       commit: e8e3b38def93b5e5d53569961237ce215454e141
> [2/2] build: fix building u-boot.lds with Clang as a cross-compiler
>       commit: f7d177395d73f7747373dfd0ef7329834788106e

So, I can replicate your success if I do:
$ export PATH=3D${PATH}:/opt/gcc-14.2.0-nolibc/aarch64-linux/bin
$ make O=3D/tmp/rpi4 CROSS_COMPILE=3Daarch64-linux- CC=3Dclang-18 HOSTCC=3D=
clang-18 rpi_4_config all

But if I instead use CROSS_COMPILE=3D/opt/gcc-.../bin/aarch64-linux-
instead we get /usr/bin/as being used and fail. Any ideas where perhaps
CROSS_COMPILE isn't being trimmed correctly and passed to clang maybe?
Thanks!

--=20
Tom

--/8qfOrNquYtY2rpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ0dmwAKCRAr4qD1Cr/k
Cts0AP48PlflxgH/g+iTDTwZDVofmhuaey0sO/VkfSG6ahU+5wEAm3yGEWBMUB3F
hkOxWgQdW1QR5nZYMqHJ1YTvV2j2ewo=
=Tk2c
-----END PGP SIGNATURE-----

--/8qfOrNquYtY2rpY--
