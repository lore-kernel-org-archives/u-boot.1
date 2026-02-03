Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73FDE8B37E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 23:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1875B83DEB;
	Wed,  4 Feb 2026 00:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D6ql994c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DD383DFA; Wed,  4 Feb 2026 00:34:08 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679DE83D9C
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 00:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d15b8feca3so5809991a34.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770161645; x=1770766445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zBmzh1J+y5rJso85QPzFj2RfLOQxKoLqFEk079Dbmdo=;
 b=D6ql994cKTnKwuinvOtlLcUygX/3x3CWtCu1kXjmbxbJ2lD0J0/XaPDXmYLISgHEVc
 e3LVwOT6ThCvEntqE/RbRMVKblHLj5sy3sVhGJ7K4uqknj3I7x2nzU/SyrYBbgSNkKYi
 JKpCRaK17QUNdlfwwln8Nqr6+13NfaGdOae8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770161645; x=1770766445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBmzh1J+y5rJso85QPzFj2RfLOQxKoLqFEk079Dbmdo=;
 b=ORiT8OrBOAs2/ztD2g7nVUMv114zUmFBzVGi3+LLsWa+GwAzPovNPU393z6AmgeWRe
 /EEcM40wPstkVqyE50EedziKiLSNIlyihfFPJBgFIrKnQIsPmGHGgp3w5RVP7BNYnbB2
 TICQ6rvJuYYoa/9lU+5xenGTTCbvh4kgCTueKxmzNZ72KGkNf63+YP0MM4NFqkx/SEr2
 3GV1u5EoGNzQySOR4PjfAhg0Eog4lt//kXfzezv7Mr5pv3Xz4YnNaxXTZoz5LMrR+qxT
 LZi0sypjDrEG+kKD+t4ah68K8rqq0h2N/X3ZOy2SnyQyqHVhQSqvLxlA1oTdqRAs8pBc
 2BzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmpcfME6MmvJ6GP8kP0OG07QJ0Zok9r4IN4Y5DmWD8Ad3vyFDmbsfNpxK3Q17tAOSkUEs0YAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt4gJ/ngOLF0VqcKTocsHuLlECKZCYMxCFoT5E8iEUYW/V8FjL
 ZVyfXDr6DIYFfiiJG2I4Jw3+z5r/c8153qcKn7aXD2EawigUKJmRUOwKjtjmoJJa21g=
X-Gm-Gg: AZuq6aKEnsbFjR9UvJIXBpai+u7FCyr9x+ZtDpxJ/5V4tT9ZMz6AgRkhvSaBfcuaNG+
 iPf3ZzoRjlksPpPIl2PtWoBYqfxzRQS06N9JbTf3oh5uEfOml5Z37Fg4XPnZl5QmcLm9dsol5pk
 vR8i/JXMGaI2D7VTsMRe5R6j/F0lFgnuPgEXKom6AKsXyvPiAR3Pfk9Msi4AJX4tCTYDo8gTBVr
 GGGZ+gv+9aRGa+wPMOWRy/z8GF1MGI0eg0l6c+dTcomd4RT458u+MgjNhXFFSKYeNRII/7JNGaO
 +e3L2YXxbDyFqk94+RxhB0O5agBW4gsk1uVREP4QtrrAf8au3xJE55ouaq/JwROMsg/aUFSWkgN
 a0x32KCwVCexH81t3mJDJiaUtVHcy3Yg2acxsWiNYB7nPncKTrNM8efpzU32ytU7dw3PGVTAqrC
 KUx/B5HHErgX7DJoUfJtRb16V3OAUHPu9QfiUfa625CZVRh7zWFZY5FHYFEWq32J6WrNultOUBX
 7Ff1baKyyDRdBUAxJkeKFe3uE7IdJWUg7XhoVjencsW8zRwbw==
X-Received: by 2002:a05:6830:6012:b0:7cf:e4e6:2d42 with SMTP id
 46e09a7af769-7d44899f658mr974380a34.8.1770161645084; 
 Tue, 03 Feb 2026 15:34:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4490f3591sm662638a34.4.2026.02.03.15.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 15:34:04 -0800 (PST)
Date: Tue, 3 Feb 2026 17:34:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v6 2/3] test: cmd: add test for memsize
Message-ID: <20260203233402.GU2603314@bill-the-cat>
References: <20260125131254.23210-1-linux@fw-web.de>
 <20260125131254.23210-3-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3yeXisxQ6RWsdUqp"
Content-Disposition: inline
In-Reply-To: <20260125131254.23210-3-linux@fw-web.de>
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


--3yeXisxQ6RWsdUqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 02:12:52PM +0100, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add a test for memsize command in same way as meminfo.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> tested via:
> $ ./u-boot -T -c "ut cmd cmd_test_memsize"
> ...
> Test: memsize: meminfo.c
> Tests run: 1, 0 ms, average: 0 ms, failures: 0
> ---
>  cmd/Kconfig        |  1 +
>  test/cmd/meminfo.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index be79bf0747df..2bafa156ca8a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
> =20
>  config CMD_MEMSIZE
>  	bool "memsize"
> +	default y if SANDBOX
>  	depends on CMD_MEMINFO
>  	help
>  	  Get RAM via command for use in scripts.
> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> index 53b41e3b49e0..ba772a8b7616 100644
> --- a/test/cmd/meminfo.c
> +++ b/test/cmd/meminfo.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <dm/test.h>
> +#include <env.h>
>  #include <test/cmd.h>
>  #include <test/ut.h>
> =20
> @@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_state *ut=
s)
> =20
>  	return 0;
>  }
> +
> +/* Test 'memsize' command */
> +static int cmd_test_memsize(struct unit_test_state *uts)
> +{
> +	ut_assertok(run_command("memsize", 0));
> +	ut_assert_nextline("256 MiB");
> +	ut_assert_console_end();
> +
> +	ut_assertok(run_command("memsize memsz", 0));
> +	ut_asserteq_str("256", env_get("memsz"));
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +
>  CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
> +CMD_TEST(cmd_test_memsize, UTF_CONSOLE);

Since the new test isn't guarded with memsize, this fails on qemu-x86_64
where meminfo is enabled, but memsize is not.

--=20
Tom

--3yeXisxQ6RWsdUqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYKF5wAKCRAr4qD1Cr/k
CjcqAP49vIuyfEYGc/tkqrf2uKK/qL8Z2MG1ozQKvxeBXI5h1wD/dfC++1r2k/Qw
MMyY57Lg29nWXR92/NAn42Niq4nviQo=
=NW4j
-----END PGP SIGNATURE-----

--3yeXisxQ6RWsdUqp--
