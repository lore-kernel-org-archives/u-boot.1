Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D618C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C326484C39;
	Wed,  1 Jul 2026 19:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xu8u8XsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E3C849FB; Wed,  1 Jul 2026 19:55:11 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9035B84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9d7464b71so336533a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782928506; x=1783533306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k1jXsHjz77YgV8d+66n24rcOuWE52gxmBjmrenkPsSw=;
 b=Xu8u8XsJnNStpoOSRzsXANJMYEB5438J28uZy1EGLvRqDEDNiL31/v+ptmibK3/zVt
 rSzJjYJQc/b6O//WFl1Y0TGLdXxA9rOJ3O9tHaUCik6g+UO9sbzgqC//1FtnLqosfa7J
 LTGt1k/nIPlUd4+Ia7/zfVYAAYx1a7yKsvh4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928506; x=1783533306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1jXsHjz77YgV8d+66n24rcOuWE52gxmBjmrenkPsSw=;
 b=l/l0B34o4sgtxwpisTxfJI+K0OkfRF4ARAx+EEn73iC/Zs6pVoxmKbfVrb2fWEcdnu
 KHbYrHL4/9dUjAzksvH0z6UO09opNyEvVzS32RqzYOaPsL6nOmuIHa6qoFlD2TGm9MJT
 OZc7Ya+vPi8ThDs4zRHN45T1/uunSu57VKlG/B0OhwYxDyW1ts2VYkUJ52SESjviUvCw
 +EXGE2bFW7hSk7U+wEs1rGH4wFYcREjOuajslff85Pbt67S5itZ9QHNEbV+SGsxbjZE7
 SZca47esZCpV558wjAMCbT7QWzuGnUzFAYqQjImljRCr69CTrbMWukBXEuQmOtzipKPm
 4+cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sP/fV9GUVRROXThgEyEh4oHKliAiqvh3NFHkyKaY57RF+BmK6M9XQDKVYvQRTg07cYmif2/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzSdjCICYcSc+j1AMfnTapeOdOR1np+ljjjPUBTYkowFMg8K8gO
 9QT786YpvOuoVPkPpdxPNZPq5P8d4wPz8+exD8tiWAYixAeqSI1GkWNz44lSVDt+hO4=
X-Gm-Gg: AfdE7ckGPVDMAHkJbxSW0ydD3Lfo1CVgOaO+WZwMfO7CxRt8okDZgiqg9mBcawngFxP
 GKm/AL2CnE4si22Wa5uyCofERmWDaMyqLvqH9DuuWvOGXr41HiQALc8fE2SrQI0ow8Wg2t5t6a6
 xZXxT5gHuOmPbq3D6GO1TV5Q1jFBNIY6gqecK02mSG3uto8+Sk28NvHvsE5dkBGnesfKSnMhblf
 ZT1H1pU2LdHkLywVCdDDCRCWDlcfFqn1rm1CKRnkcfcJg8QAWaGUY0CIsnkXXaukplz/mQMgulA
 qyeMGJsbfw1FDuroqIyj6vQsRJLnFD5+9a1/I1sxMVz60GR9YRSojWmPsv1W6nBeOwNUdE1/T+T
 F73Hlc/0QPdyaBDF03nLLwHEJ6KiFyPoo/H0asiF8wDv6cAA6E00WlWlZnjZ1V78WQPe90oQ0wR
 R4FhnU2m6Uxb4PHIMRUWzAMGXNkEcqLNFT+vZHj5PBvOZGvbSOL3fbWMkO2COlU1NzwJ+Kca5ts
 Xn5MXQ8t/hZnpCBx21WU3Cere7TL2VzJsl5aQ==
X-Received: by 2002:a05:6830:917:b0:7eb:3af8:8c06 with SMTP id
 46e09a7af769-7eb48b0aa75mr1665781a34.12.1782928506219; 
 Wed, 01 Jul 2026 10:55:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542cadeasm605475a34.7.2026.07.01.10.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:55:05 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:55:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 11/16] LoongArch: Generic CPU type
Message-ID: <20260701175503.GR749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-12-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2vMB/fiOnvqB8AB/"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-12-me@ziyao.cc>
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


--2vMB/fiOnvqB8AB/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:18:03AM +0000, Yao Zi wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Provide a generic CPU type with some common routines
> that expected to be implemented at CPU level.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> (No changes from v1)
>=20
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
>  arch/loongarch/cpu/generic/Makefile |  7 +++++++
>  arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
>  arch/loongarch/cpu/generic/dram.c   | 21 +++++++++++++++++++++
>  5 files changed, 64 insertions(+)
>  create mode 100644 arch/loongarch/cpu/generic/Kconfig
>  create mode 100644 arch/loongarch/cpu/generic/Makefile
>  create mode 100644 arch/loongarch/cpu/generic/cpu.c
>  create mode 100644 arch/loongarch/cpu/generic/dram.c
>=20
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 109d37d8e2c7..5254afb2cd05 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -12,6 +12,7 @@ endchoice
>  # board-specific options below
> =20
>  # platform-specific options below
> +source "arch/loongarch/cpu/generic/Kconfig"
> =20
>  # architecture-specific options below
>  choice
> diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/gene=
ric/Kconfig
> new file mode 100644
> index 000000000000..ac7556d6d4d0
> --- /dev/null
> +++ b/arch/loongarch/cpu/generic/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
> +#
> +
> +config GENERIC_LOONGARCH
> +	bool
> +	select SYS_CACHE_SHIFT_6
> +	imply CPU
> +	imply CPU_LOONGARCH
> +	imply LOONGARCH_TIMER
> +	imply CMD_CPU

Which of these "imply" values can ever really be turned off? CMD_CPU?
Yes, others, I don't know.

--=20
Tom

--2vMB/fiOnvqB8AB/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVUdgAKCRAr4qD1Cr/k
Cu+NAQCQbvW8258gPbsrPIyG5DkuusaAsZt4u9yzBHqHx7D8mgEAmC0r1h5GNI2V
xvTNzbMLZgnsTm1hlM5k/6BdO2K5rg0=
=/iW9
-----END PGP SIGNATURE-----

--2vMB/fiOnvqB8AB/--
