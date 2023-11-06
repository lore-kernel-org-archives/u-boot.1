Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B3C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223DF8709A;
	Mon,  6 Nov 2023 17:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hOvYQNBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E8187069; Mon,  6 Nov 2023 17:32:49 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8C886FE8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b6a837a2e1so132874b6e.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288366; x=1699893166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YguKor1i6UVMka0+VvWtvQvDxwq9qZTZuyL65948g30=;
 b=hOvYQNBDpf8cVIKudOZFGOcVYmCCtxgTqTKfByA+0nNk2u3NQNd68P2oBzy13o0z4Z
 h/6te9Kd26kODLLYBCoqqhameTxY1nGMk7Twi3+mJd3b7I4vo/0EPQ4ZFhY5HOhRsESH
 LLQDqOf+9SL1ITi6NoJF5Rbp0L2CSn1DX1DKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288366; x=1699893166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YguKor1i6UVMka0+VvWtvQvDxwq9qZTZuyL65948g30=;
 b=NWYv36kApbFvZmXQKHrk9uBmyC12/giR+Un2vSU/XtQs9wCv8K74iqInnT1Pjva4I5
 LIckRRyO+i/4FeNQVW4coFBH8BJCIpHjr/XJC3Zk9uLIWyGiOd3vv3ULn67k0I7DHDHo
 nr3FcUHs03vBvIbA6YwKbQXGFgCgJvKCslQXUEnMSwt6dBI9KpsjOAfCaO6OY6YSVC7k
 pz2WAqVAzlW3PlQz0gL/NNcTkIhUZRxq3C+hKjlo3ooS2FYG9hAqThvI+GR5tSmazH3l
 5mBfnYwoodMPPQ7gdyzJ3M7kF/7bgSutNR8mlr7C9PRFs4FgBmsepYnXk8t6PWBHRUln
 oZqg==
X-Gm-Message-State: AOJu0YwtU/v4zUk9T7Ob7GudivcnEQ7vhHpQDy3I4DuHC+//YXgMmx7O
 zIqju0k5pUaPYJvdj3be3334tQ==
X-Google-Smtp-Source: AGHT+IGYjX0yt+sRj0pSLmfiqnXMnLIQ25BNFyHisPDC8+OZc5ddsWY66ETQIk6JB5CszClFoLk9ew==
X-Received: by 2002:a05:6808:de4:b0:3b2:f16e:3f6d with SMTP id
 g36-20020a0568080de400b003b2f16e3f6dmr30620852oic.21.1699288366125; 
 Mon, 06 Nov 2023 08:32:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 mn20-20020a0562145ed400b0064f4258184csm3570746qvb.53.2023.11.06.08.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:45 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [PATCH v2] bmips: Add Inteno XG6846 board
Message-ID: <20231106163243.GA61955@bill-the-cat>
References: <20230926092339.2228321-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2BRaPioAoiUKW+Je"
Content-Disposition: inline
In-Reply-To: <20230926092339.2228321-1-linus.walleij@linaro.org>
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


--2BRaPioAoiUKW+Je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:23:39AM +0200, Linus Walleij wrote:

> This adds support for the Inteno XG6846 board based on the
> Broadcom MIPS 6328 SoC.
>=20
> The default boot will read a uImage from flash and boot it.
>=20
> Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--2BRaPioAoiUKW+Je
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFSsACgkQFHw5/5Y0
tyxrMgwAq06xZ94f4bDotsJJ3Sj9A9k4G3maNG2XXHyiXRki6aBfzz+ZKke9AAWI
mUoaGUlr3LuZESmoAWHJrkRf1l7V/rRpX16TCMBAH/6Ts3xMb7MFcvJhaZoXJBnp
wdzKjr3bQU09oC1wvriQfrVuzJrdnCY3HrLE91EFA2nPNqtxiQjyDfKL4d3sZhHd
ngWc0hRoGIEQECF11SdWYG5mVNER7i+sI80f22TaSBBqR0kSwcwUaIviER1ze6SP
9sD0Dqhc83q+yU5X0iQ0ZNQqHeedP8zyWUCa916gapsDFDeCF5F0gI/QKfIDmH5A
dHXo5If/DwFOXXmPpIA4vks1ZpVI7fxhNSExY9mEoqILto/hIcom+axZG66Pwv0d
vqE2ZF/TRXqxjis2D0pK5UqMWcjSPZB4GvIpIL/O9+WMlAI5VfD4LvtXmpuTeZuX
aNVpnjA1OkToTpgsW08pFIkaiBLIt+v2EdbTidTXKeqCLMoAnKrleNBDmQ6/rBzI
I4YaSh2q
=3gQg
-----END PGP SIGNATURE-----

--2BRaPioAoiUKW+Je--
