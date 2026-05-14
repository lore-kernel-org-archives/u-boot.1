Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9261CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 21:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231EE8407D;
	Thu, 14 May 2026 23:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KLEc+cgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B1584609; Thu, 14 May 2026 23:52:46 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE6083FB0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 23:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso4865070a34.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778795562; x=1779400362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FAg2chfRK5AxDXyskugTg6/o29fHE/pzWbx2TwCk0JY=;
 b=KLEc+cgY2HVbHK9GfYcB/G10LdExS4YYVgQ3QW1qXWBtSYZ2BGmx/tgTvojiNjaI7D
 P5vF0GL4UYWYlCFdfBo4m67agYXef7qb9RzW1OjHuDmbhLJcu5SKzkuBwc9kf20RYYAn
 8kk9HTLjWQHVPwQEgijtKGlDVQoFUCAJrQB7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778795562; x=1779400362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAg2chfRK5AxDXyskugTg6/o29fHE/pzWbx2TwCk0JY=;
 b=KIsxMyzR/cHwvCT/JPLGaErrG/1gX8SNSo5PmRcSCg0sHEB7YUQLxeK+Ubo+MpS5vU
 ZZG0WLPRkiJeRwi5C+7kpuyBdB0y7E+nco8Kk8fkcoH3kTYy2pvHXZn7n/Ki6yyAvqr2
 4mZbchBHL71ur0boGassVLN1jnSI5H7FRKObJ8lTTtpq1UbTs+GYpGBz6zniBLHp6JDN
 0B7QoPbckdTmmcF8+/+sz+1IABShn4EiF9XaRi3AVSlg7QE3QCryJdvMdU9/10Nx/3lg
 f7ebVstIYlMY9BIoeqm87ZVVbTYssYShEoZBaBk8N6QJaB/Fzm82anOnE/inFDqsBlry
 Rn+w==
X-Gm-Message-State: AOJu0YwVMpswdTp0D03jcrFYByF5VIOFg05Iv7zkd1wpRZ3Rh6sro3TY
 hmxn9Tvq9MEqXyWuMguVEfCUZ4ldJ2dNiguET8nj0Rcvv6McMC7a/CpBTiirQdoXoD0=
X-Gm-Gg: Acq92OGfXxejUqoPwBmRpC0m0hteCGi1pCriAZCIAfUXiDbHWB1AwRuTDdI8SpJqUGV
 TAYtE+rH4xjzBbg6+ev/+lxaHTGRnY2S8bslbSe5JM9iUD2R3D01K5SODRgEW9PGoJo6fzIdkeu
 HSyFevMZCjNjSr9wSEcG2OP4TJnZXoqbEEjwNDziRGEcQZ3rEGzItzjHe3AicMwQJIzIDradhBp
 /2+i+Vh4zoaW5JimiOj55Op+ROlO2wgwMxkCO5A7HSNsiOVKwK+N3aCTHC0rkxZJvKCgaMUWFWS
 AZmhGZu+/b7OnXpdEfiRTnYqrqR2JQElXiYnVaCjftcpYm4zhYG7W3stAEdmJNeCplYWVfdTlPg
 u9zsj3BNFZpvOsF0k5FNPxz2aG2VSaIjhaN13YNB+ziugFYzw7aAYYXk50ItFNKbjS7yBRhqD9j
 SORJYtv1UCxewxKhCCNA7m28lPscnWbDG6N2iBsXhyFbOd/mds9h6gozow74plY37NjrEl3FL1x
 qQMCZ4cSaTuCBgadisEIezaG3+wO3QMrJYjSgCc5ewyQqmT+es=
X-Received: by 2002:a05:6830:498c:b0:7dc:c620:aa12 with SMTP id
 46e09a7af769-7e4f2bb65f2mr679371a34.20.1778795562372; 
 Thu, 14 May 2026 14:52:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55843cbaesm177743a34.3.2026.05.14.14.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 14:52:41 -0700 (PDT)
Date: Thu, 14 May 2026 15:52:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 00/10] test: Convert remaining mk_fs() callers and tidy
 fs_helper
Message-ID: <20260514215239.GA4104621@bill-the-cat>
References: <20260506155639.1191640-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S8EWd8MQgDBvA1bo"
Content-Disposition: inline
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
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


--S8EWd8MQgDBvA1bo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 09:56:14AM -0600, Simon Glass wrote:

> Convert the three test fixtures that still use the procedural
> fs_helper.mk_fs() / setup_image() entry points to use FsHelper and
> DiskHelper as context managers, matching test_efi_bootmgr()
>=20
> With those gone, drop setup_image() and inline the module-level mk_fs()
> into FsHelper.mk_fs()
>=20
> A handful of small cleanups follow:
>=20
> - extend mkfs -d to all ext variants and pass it unconditionally
> - move /sbin PATH fix and pre-existing-image cleanup into __init__()
> - drop a dead size-rounding step and the try/except wrapper
> - use Python's file.truncate() instead of shell
> - let callers override fsh.fs_img if they wish
>=20
> This paves the way to move generated test images out of the source tree.
>=20
>=20
> Simon Glass (10):
>   test: Convert test_eficonfig to FsHelper
>   test: Convert test_efi_secboot fixtures to FsHelper
>   test: Convert test_efi_capsule fixture to FsHelper
>   test: Drop unused setup_image() helper
>   test: Inline mk_fs() into FsHelper.mk_fs()
>   test: Factor mkfs args into _get_fs_args() helper
>   test: Pass mkfs -d unconditionally for ext filesystems
>   test: Tidy up the mk_fs() logic a little
>   test: Use Python truncate() for image file
>   test: Set the default fs_img in the constructor
>=20
>  test/py/tests/fs_helper.py                 | 196 ++++------
>  test/py/tests/test_efi_capsule/conftest.py | 156 ++++----
>  test/py/tests/test_efi_secboot/conftest.py | 402 ++++++++++-----------
>  test/py/tests/test_eficonfig.py            |  46 ++-
>  4 files changed, 375 insertions(+), 425 deletions(-)
>=20

For the series:
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--S8EWd8MQgDBvA1bo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagZEIwAKCRAr4qD1Cr/k
CoBdAQCkVtEP39cEuMdqNrTl3za2zrHQk5IifCP86+Sqo4iCNwD9FcC7fFdbavEg
uZH0tbw5dLDCaUi/pfZXqkhqGJ4mQQE=
=y8Zh
-----END PGP SIGNATURE-----

--S8EWd8MQgDBvA1bo--
