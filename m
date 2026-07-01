Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECBCC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EA1849FB;
	Wed,  1 Jul 2026 19:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FSmp5mSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F17884B0E; Wed,  1 Jul 2026 19:47:07 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DDD8494B
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a0e525db1eso588126eaf.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782928023; x=1783532823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r0A2asuCZ5LcTySpugnnfwbDAn1UbDv3fLvit7qTrDY=;
 b=FSmp5mSDJnBH+UKYW3fafxOft6BJRKibJfPMUnPT2BiG0w2cJ9Pon7yMZxOs+AyBfg
 phZNlhvMuWNc1ClrQuVRtWptQ8pC5apAGWqFYIllLnR/YbMXgp3Rl6b967csda9r+adK
 XeFI6luP5Sw2oT5rk/lwBQ6JFVQDVazOdDlyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928023; x=1783532823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0A2asuCZ5LcTySpugnnfwbDAn1UbDv3fLvit7qTrDY=;
 b=DLohCQNJlEWAmi/pHS8g3holbsc91k359aKtUT6k05ETJ3aDbCaJf1V2Pqx/Tq/zGl
 KyU2RJ4Un76zRoLKTnW4Za8kP4tZkrrzD+XXhB62JcYAuCk7D3GdJtF4QCSL5ntsK5co
 TzMDQkGeyf3dgd0PgI523erUQudbScTdSxO22bAsgWTYZ1pdAgRH0sW3tU35U8VmmPBe
 zocziREGWSbp6+e4b0JY647Y1qqMIoZdZcFjQ0mvXIbXlVqklu3y9bS/i/rxaGS6e5Ev
 hi0KaGQ/8HqDBveCZuSTxxnVJJggu8p/xGOZkbaudREalVKoPvFe5tk1rtI/numRsTUW
 Enfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F2vSscg0mGsxreTgmgrswMmDQp2ZBtre8KXFhSfZinotSJRkn7EjeUK0LfXzNqiluKRzH4uM=@lists.denx.de
X-Gm-Message-State: AOJu0YyI2olPmseEchK4Xr4QAwF2nWc84FF5VGjH8ehVDoABK36KM6Me
 uqsW11/aej3Z5DbKx5YsmsVE2oqO3LFdMp6s0OqV5YoKTjHB7/DQfcsibyB1bu2TgC0=
X-Gm-Gg: AfdE7clPGo9sgxwEsZz6rfln5fq2Iwo+zbWbzYyPui8ESiZm0L8kMxzu9Rto7aQQgWU
 cOuuJC+Qymb2Pcq6760rsgXrxgEpZbN0PDhKWJgJfKsalPQPhYkX++aQUAHwaDWJH3OwVVwb0S0
 wORhXAyH7lfTdK1vWu0u5dKj1M8+wuP6+8dgSEt2xcJkgU7btOckFCqduETUl25ylbvt81mUxZd
 dkL3hQzlTghAm6n8zcmixdRJtFMQE1X4P5nlR9I+FIL+B07LTGoQQjI5BQ6e4ozPRiGUHpcMQhN
 Ih5tSQ269C60+LseA+vODsuCnwi+OtTuM3igN5iMrY5h3u4bcQK9HIXgQDsbdmdsh6y8Wj0Wqtw
 bBYWLmcIC2OZhxwuXBgCrW5aBhjVgAwi7fnOKG1DTHPLT8IiN6J2tQPXXexhMAkZqLmSJ3Cuxff
 UPoDnL/nKoMASu1nVJgDC4vqn7k/XKQr8uo1acfqGcsLVqd1hJW2Pi/YJZCw0yBsBW0O1IUOQ6J
 v8z+0euQQyjDyKDSTFsCRrY0QSOsDE2PjvWrA==
X-Received: by 2002:a4a:e909:0:b0:6a1:1fa7:eb49 with SMTP id
 006d021491bc7-6a309bb84afmr1515030eaf.50.1782928023455; 
 Wed, 01 Jul 2026 10:47:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbed29e7asm362357fac.13.2026.07.01.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:47:02 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:47:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 06/16] LoongArch: skeleton and headers
Message-ID: <20260701174700.GO749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-7-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6g365v/3wY3C5KuK"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-7-me@ziyao.cc>
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


--6g365v/3wY3C5KuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:17:58AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Commit for directories, Kconfig, Makefile and headers
>=20
> Some of them are copied from linux, some of them are derived
> from other architectures, the rest are wriiten on my own.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> Hi Heinrich,
>=20
> I kept the naming of CONFIG_ARCH_LA64 (instead of using the full name
> ARCH_LOONGARCH64) since it's shorter, and we already have similar
> CONFIG_ARCH_RV64I, and etc. in U-Boot. Is is okay for you?

We should use CONFIG_LOONGARCH here, to mirror the kernel I think. The
CONFIG_ARCH_ namespace in U-Boot maps more to the usage of CONFIG_ARCH_
in the kernel, for ARM (and ARM64) platforms rather than describing a
CPU level architectural feature.

--=20
Tom

--6g365v/3wY3C5KuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVSkwAKCRAr4qD1Cr/k
CjjfAQCMETmVqxh8tuNDcT2BQhqCuqSnJP2zhxClevXX4LWfSwD/boY5WEk2IFdu
9PlJ3+vi5OW5t+SHDDrJkH1sdg1WpQc=
=lV8q
-----END PGP SIGNATURE-----

--6g365v/3wY3C5KuK--
