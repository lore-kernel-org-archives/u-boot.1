Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B8BF433D0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 23:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA24F8419C;
	Thu, 16 Apr 2026 01:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PbMdjm2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F371841C8; Thu, 16 Apr 2026 01:55:04 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A47B83C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d9b21d1461so116202a34.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776297298; x=1776902098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g1FOadwrtQ2XNXPCUh4QCPUEAYAeulLjDahhrv+jSGE=;
 b=PbMdjm2k7QAzDgFIk5ZOzIvSsRAGcIRFl/KTHVteyaBgWSQ6punREGqBe77hu8KHjI
 8vMnfmiawrwWF2vte611OpG4zmu9FeitfDYycdY3WLbdCNQQ7FDtPjNpFuTJ334tDwep
 BjEuh4dTIucTOHebd+PU9qVU6schqcn9YvHEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776297298; x=1776902098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1FOadwrtQ2XNXPCUh4QCPUEAYAeulLjDahhrv+jSGE=;
 b=KX3o74HuzBfUZxlkLiIQkzFpG06njaRjcy8Vg8K+wGWhBsNRPi7DVTZjzToCGfB/No
 ZIEnftosvV4Vi/FcuUJDeOQxZvMWlesheQNZhLMh3iLk+HWKIy0BM/I6zXPWhpYAVB49
 9NDnXmF63M3X6zcnC4Sbz8/9SfnPNWrG4929NYE63ZvQ/d4YnBiKqwCeIg/NFaUPIA5g
 tAAN3SQTOYvOPEcB3qkYTbN1D2BX22TiwxnvDWDpnURkb7iCuCjJ9PSRKcNpynN4VWAQ
 zsHjM5LS0EfWslgHx+zOty6E1rBNHMOYZYk3OEfR5zJ/2xzULWY87znN0ykE5YRwnryT
 BDAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KeeRKf0F9U09WykPA41IFH3GN42U4BgfYCGMfsg2aZZn0Asr22AZhXNXMohf2/HyxoPDQ+LI=@lists.denx.de
X-Gm-Message-State: AOJu0YzojTXXI5NslSs/bk/ynVcETPCmIWaGgDczqgxii7GvNyiYnQpQ
 2BTUcW1P1k9oe2mMwT1UzhsEqBbmHiY5XwhtKv48u6wY5tJT1Fsg3wjhAJ9DoLUHm3A=
X-Gm-Gg: AeBDietkYFXC0mh/jPq1bMa1RAKDkn9zGMYG01k0UjkJbZUwbCcemDv98XmsKUKt4oD
 vKTFQJgIRuqCmiVgcIwEo3YqUPMGxZLLz1b/604opeu5fRA7m4DFQmAFDlEN/NwHx6ROJ3Fqbue
 5ggCK7nUEMdXLEdHQ6QoBE2sJa64NgBw02n84FZwg5fP2QvJjJRCtbwgFhZf3PGJTnPNJ0x74G+
 P1hxUdxlbBSptn0+tbbeGbp1iPY6SugGaMN9iF6mXS/BKPcgQlzCMoACRGVbfByGcUPYc9zMJNS
 SiTnIi+mZLWRX+TXEzYdUzcbB2mX2PfuycCR159SMZ2UEl4n9EGikjFIaYqx664zOrUV1W+5AwM
 Z3gYwNblQAclO9nZrniGDutVqzOSz/MRBpssPeR77EFudiRxNHARy1n+0f1RV/jLAGFFlcz/xgm
 5sibwGqOPsVy/uZbtoVmPjNGXRz8wG7gV0W5jw5y4hIDJr9MOSexVrAoGxCWXCWf1tJ1OYlldEl
 CzkD+kYVakcRC+/Re8+ZLDFI4BPXdSE6H70jlKQVPUnGulFU1usP3g7qeOdYA==
X-Received: by 2002:a9d:5501:0:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7dc803a001dmr758989a34.5.1776297298108; 
 Wed, 15 Apr 2026 16:54:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc76bd18a2sm2221492a34.27.2026.04.15.16.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:54:57 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:54:55 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH] lib/Kconfig: Fix SUPPORTS_FW_LOADER option
Message-ID: <20260415235455.GQ41863@bill-the-cat>
References: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p2xhmgMIxRv3tUR1"
Content-Disposition: inline
In-Reply-To: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
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


--p2xhmgMIxRv3tUR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 04:37:27PM -0500, David Lechner wrote:

> Change the SUPPORTS_FW_LOADER option to be enabled by default.
>=20
> This is a dependency-only option intended to be used like:
>     depends on SUPPORTS_FW_LOADER
>=20
> Instead of having to always remember to do both:
>     depends on CMDLINE
>     depends on ENV_SUPPORT
>=20
> In order to actually work though, the option has to be enabled.
>=20
> Reported-by: Weijie Gao <weijie.gao@mediatek.com>
> Closes: https://lore.kernel.org/u-boot/20260410015311.4066075-1-weijie.ga=
o@mediatek.com/
> Fixes: 4ed440e6be80 ("fw_loader: Introduce SUPPORTS_FW_LOADER symbol")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--p2xhmgMIxRv3tUR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeAlSwAKCRAr4qD1Cr/k
CgkwAP0T6Y2ZINyWmofg1/Josa8UO0BrYh7tnmcW/cVR2uApfwD+Pg1V8zc7JcQY
ndpv/lUo1eCuKv/VSIhJb52Gy7PmHgE=
=TI8L
-----END PGP SIGNATURE-----

--p2xhmgMIxRv3tUR1--
