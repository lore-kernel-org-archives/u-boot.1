Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9658AD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1850983B8B;
	Fri, 28 Nov 2025 23:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jNEKCvMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF5083BAD; Fri, 28 Nov 2025 23:38:22 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663D583B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 23:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-453316a8418so70606b6e.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764369499; x=1764974299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=18tQK8y+QW2wjUZAw0LFB9UZ2qR3OSaDBe9CoRUimlY=;
 b=jNEKCvMeMvT1V3QZcC5uzBTYKbIyMI8Y8/kt32SoKzcMWSTE6Mr0iZATPB83gRw0Xd
 ABz++V5TXCCyqMHUXRvuzZvfDpDB4OC/BxNZDKNBAl3vNf4Ex744IdFGoDEsUUGkwDTH
 TT1couzt2GZtaa7cUXLCuw5HjFWKNiCtXNvAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369499; x=1764974299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18tQK8y+QW2wjUZAw0LFB9UZ2qR3OSaDBe9CoRUimlY=;
 b=JX8S4E24AqvxOqqQavNTUncKBc5N8HB9RZkcpwbaqQvr5iQmuMIv2HgHDW0xNviu2X
 WDs2Z8M+wviAyi/Ar/CcrVNObNvH37J/eOxEW5GROEHU6mdlSrXqGVyz04nkrMqraT7b
 sx0aAhwDc9NLpWxrgYgfowGR4cQRaScO8FeAc9+qWr/SmlztOvErf6oJY0u9/oAhDgvm
 iWOANpcG4dQXPAzsQaCnqK5TtFBcDXTPvZ3oNWuTFfXkxsqNo1cFYBFLP4qwrG0FB5J3
 Shm6nmUGEvBuhbt1/r+eTsfr9bX4MWHan3w0dk94YFQ0HiZL15kcSL10zO3kOhb9PwtL
 EmYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN2+qlWy2KFJouiKltjzTa14/qMQ565jZTRZdwA+RyemSlf02PX1/IWk9FNwKbPP8MH4R9/C0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqfvbBN0vfWZTec0JmWI3EbOSqEMY1DdprNymz/LdGK99RVgzK
 2/w/LTdZpGUoYfO4FfgR7kjmeCo+rHrw47TaT9ZKrqhIKtbNKe+BJ5Zic6GjYA51UWc=
X-Gm-Gg: ASbGncus03zXX3lVaRMfNPMaqCj1aEC+u+3+CfSFReWLUDf3W0a5Fuvi66uhjHJT9mz
 PDB1+cYMf8haP7/OfQkkwsPLYLkjlIF8WuHGOtyuB6/uyKzn1bsD7xuacmrip8Zc/exnFqS8SX2
 VyTJae9g/y9Zpld1ehQso2cWbhXCHssDrwkhAk9hOspHKgERrz/+ku/gctsk9yLjrHJsU8qhbO2
 c9VebaZVjYl2qQjIiGdGbh76ryJayuYzzNrj1/M7r1f2bLEvTgLueZs63M3myr3oX9HUzrqeMxM
 L0kkR0IPxzAU9Qs6HKxrx111LbnuCKApyEqD2sxUZSEiin4VVDj5/jeOE4vtXzBrW94Fx1CarHY
 6PIpvsU9/CPygOwLiLRgpVtoL+S1N4UzzueqkZkr9j8jMKoioWZba2bLqVP2mQrNs299bZ7lJcN
 V29zE2BIvqO6UL8hOhQ0ynhGE9PEV7hR4mcjItOg/QoqFg6F4NSA==
X-Google-Smtp-Source: AGHT+IFDSgdYRVjgXOCtPO1/KN+o7qLt5rvm9fSbsWupvf9NhJw/KP4HJcgDbLeKVT/VhmV/OJFgkQ==
X-Received: by 2002:a05:6808:1310:b0:450:7169:80e5 with SMTP id
 5614622812f47-45112aa801cmr11131853b6e.27.1764369499023; 
 Fri, 28 Nov 2025 14:38:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4531708f1e5sm1721640b6e.10.2025.11.28.14.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:38:18 -0800 (PST)
Date: Fri, 28 Nov 2025 16:38:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>, Xu Zhang <423756212@qq.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: Fix transfer list passing with KVM
Message-ID: <20251128223815.GA289289@bill-the-cat>
References: <20251111075906.38701-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KpjQ0gwwEhAD/XcZ"
Content-Disposition: inline
In-Reply-To: <20251111075906.38701-1-ilias.apalodimas@linaro.org>
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


--KpjQ0gwwEhAD/XcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 09:59:06AM +0200, Ilias Apalodimas wrote:

> When loading U-Boot in a low memory address, the adpr instruction
> to preserve saved_args[] end up within the memory space of QEMUs
> mapped pflashes. As a result the following store pair instructions
> lead to a crash since instructions that modify more than one registers
> can't trap into KVM.
>=20
> This problem can be solved with loading U-Boot with -kernel
> and defining a different text base address. But when running with
> -bios we always start from 0x0. So let's postpone the calculation
> of saved_args[] post relocation, where we will have an address that
> doesn't collide with the QEMU flashes.
>=20
> Acked-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - Move comments to the appropriate place
> - Add missing ifdefs when calculating the bloblist placement
>=20
>  arch/arm/cpu/armv8/start.S | 9 ++++-----
>  arch/arm/lib/crt0_64.S     | 7 +++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)

This, funny enough, breaks our qemu_arm64 + tfa + handoff test with a
failure to boot.

--=20
Tom

--KpjQ0gwwEhAD/XcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSokVAAKCRAr4qD1Cr/k
Co8eAP93FZmrzurxgzgWPNEeP4e25+2CdiQS0oYQgaMhZL1TxAD/Wd2642G9Jx1X
jj0MsbY6kNKCjiwJ/NUB6aYPL3d5jA8=
=y1Ei
-----END PGP SIGNATURE-----

--KpjQ0gwwEhAD/XcZ--
