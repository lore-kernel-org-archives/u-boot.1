Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F21C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EEA84AE9;
	Wed,  1 Jul 2026 19:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xe/o0RNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8E783FEE; Wed,  1 Jul 2026 19:59:33 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813A684AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43fc82b52afso524314fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782928769; x=1783533569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AGTg7arGLJncU3x9uWKw6CNP+kCSDyUmpQewaRkz9g0=;
 b=Xe/o0RNZyKaGlWTLQ3aQI4Y59MPSXygaPqieaXaOEmnE7hxnPz4qjttOxA54Kb424D
 x1i1jTbijf4VN9mNfzRxxCaNpKaCVXdMeX1dME1arlGVPCj/ciqiwXjN0LUx0/vb948T
 KQfIC6+GTPAskR1gTerS3E1gb6FB7MhcGRLHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928769; x=1783533569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGTg7arGLJncU3x9uWKw6CNP+kCSDyUmpQewaRkz9g0=;
 b=HLd6IRXTuc3xRVFElpP1rD6iKx6jT73ZnCHEOzqqFDCNKYVnJBo07hNgdJTSeWbcLX
 GMxSBvsw93/LEDvgZbR+fsnotky/nwoWCYIS0MSDuQ7meRVC1SZJD5e0z+v/eZvAE65a
 jf0UM8aIDdD9gmB5l3nmz6UNPs+VGl/4Hg3W64Is8jGwFUSAi75KLOIM4smF7Hs2adXz
 ZCMJ1gSyr92GQ5ldmQjjYt9tYeWKk+urRkfNfD0V76Cze0Om6vkfacZq9EU3j5NfA9jW
 xTY0wiSFCZRr5AMyJyQzYSQESslb3d1bGXg0Ax8Vft3sxmLN7gDzsgA9L8jiXNbd/if7
 153g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8epdt7lrasUwqo74IMyZmGuoCvlnFXSgjWpJgD/lEPk2VhEceDAR8zM5nJnex8+P5NBswcQk=@lists.denx.de
X-Gm-Message-State: AOJu0YxXVqeboSrOoZbx7iqJgnrEfCzs3VwuJwuj/L5gMt3vZ/Nu9Mke
 Mw9e49hW7GyI2/gqhP95ljUcjTZCnkDZ45z52yKWhrabIhoFYISbjG+uEbRBCdUKEF9GAOLSakk
 xQETrVJI6TQ==
X-Gm-Gg: AfdE7cm6WCwZM3UE2Nr3FOP/cV4LYjye62BEjUImX8z2ZiWyUMYFSV7AhB+0xBfodJO
 7W4pbtbNPo6qNzAoXq0wNq9XP5RBes+EbgwYmlmtJRn5tFgtSF5U/7t5jnNBvKbBU7hziAGd7Op
 mxeOz8d2stj61waKW+bevQxd/mt+PxEwk6pIvaC13Ov9Ed6qaA/Evfctfa07skMnziYwhZH+Ck+
 taNCVEEAztDZYld6JQ4c6F2Y87U59Rf53EospWYh+9mVCxPZ8vg/HBhODzSFA3iqKrjRi9FMX7x
 Dv705td33tgVlcJ9zWWRztXNzqYYJ36wBo1AaimiJvixtFzLqMa4dWtB6JsGl6DF5PFe5jwG7v2
 xdYYC2s9fCgc88wFt+siYPx5Sb50F1Rql1qM7N19+GiCsedmzlypmd1a+qSdMbpcgIZWeARJVAq
 jiH5QQv+2ewCWWHaHfQeMr4R6WWIK7rt81C0ASdbsjKRIyhdo9KiPmacOiIxRhIN/jHzLU0/yzz
 r8C+wILAsTw0Vjj0NSxNZHnIsCvUw6dz1ak6NaFXPmxMWDb
X-Received: by 2002:a05:6870:ac2a:b0:448:558c:d834 with SMTP id
 586e51a60fabf-44cabc26dcdmr1543476fac.35.1782928769233; 
 Wed, 01 Jul 2026 10:59:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbed29e7asm401407fac.13.2026.07.01.10.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:59:28 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:59:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/16] LoongArch initial support
Message-ID: <20260701175926.GS749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bV1TlDrcmV9Z0h43"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
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


--bV1TlDrcmV9Z0h43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:17:52AM +0000, Yao Zi wrote:

> Hi all,
>=20
> After talking to Jiaxun privately, I decided to take over the series.
>=20
> So far this series has implemented general support for initializing CPU,
> exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> machine support and UEFI standard compliant EFI booting support.
>=20
> LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
> intended for MCUs and education purpose). This is a little-endian only
> architecture. Only LA64 is implemented in this series since the hardware
> is more widely available, and I'll work on 32bit support later.
>=20
> This series had passed checkpatch with exceptions on some false alarms
> and headers imported elsewhere. I've tested virtio devices, direct
> kernel booting, efistub kernel booting and grub. For loongarch64 CI, I
> would continue to work on Jiaxun's another series[1] soon.
>=20
> Toolchain can be found at [2] or using upstream one, to build
>=20
> 	make qemu-loongarch64_defconfig
> 	make
>=20
> To run in QEMU:
>=20
> 	qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin

So on this note, we need to also have changes for:
- buildman to fetch the toolchain, which is easy since it's part of the
  normal kernel.org ones.
- tools/docker/Dockerfile to fetch the toolchain, for CI
- Changes to .gitlab-ci.yml and .azure-pipelines.yml to build loongarch
- Changes to those files to also fire off QEMU for loonarch
- Changes to https://source.denx.de/u-boot/u-boot-test-hooks to support
  the previous requirement.

>=20
> TODOs on the architecture & board:
> - loongson,ls7a-rtc driver
>  - The only device on QEMU board haven't been supported yet
> - LoongArch sandbox host support
> - TLB enablement
>  - This is required for real CPU to utilize caches
> - Possibly EFI-APP support for real machine
>=20
> I have one question regarding the process: I've decided to
> coordinate with Jiaxun to maintain the loongarch port, and AFAIK we
> would need a custodian tree on U-Boot's GitLab instance in order to run
> CI. If this true, what's the process of creating a tree?

I can work with you both off-list to get one created.

--=20
Tom

--bV1TlDrcmV9Z0h43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVVfgAKCRAr4qD1Cr/k
Cl60AQCyazNY4Y6HFH+eDf6VXpB/6Di+ZQNZvgrLXNl2KcCe8gD9G3eZpi+l2Dv1
/IHDXHiqsEjDqeghRacMoP/OKQH+uQM=
=nnft
-----END PGP SIGNATURE-----

--bV1TlDrcmV9Z0h43--
