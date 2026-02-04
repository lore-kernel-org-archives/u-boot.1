Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97104E83F11
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25F180212;
	Wed,  4 Feb 2026 14:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lx/WPBpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3CB802C1; Wed,  4 Feb 2026 14:53:48 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB48E80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4042cd2a336so4235603fac.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213222; x=1770818022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X0mlWcr3SgcCuEdUF95AjUFUcO7aIkhoZSbDDAQFfJY=;
 b=lx/WPBpZ4780gzWQx1gjXr+vCbtODsGissdjO3SEM3QCdhWlk7k8Fl0tg3SuvWn80F
 B/O5+WDfFOArbY0IKeAE+h7adYwLoZEembEggbIYVz9n3diwcguU3BtMJ7ug1ATl2JJb
 DhKI0OScZV03/VA4eB/7Sk1PVD9QkAM3y1T88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213222; x=1770818022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0mlWcr3SgcCuEdUF95AjUFUcO7aIkhoZSbDDAQFfJY=;
 b=RP8GaXKIaRqzTcSP0bo3cKeeGspCZrArthOWVz+v+lGmjo00hkiLYRUnYTNpRY+0uL
 0tSX/2Brx3ZCvHtjOnNt0yYtU6/b5OmjrcdLisbBexDLqs/uEjR3mJkpJRiQu0f7VTX9
 5gB5MRJ5R7JhDv0n48ECIInnuBrZiYeSaljc6CBD7qL+rKx/ABLCaHfMKtPBZLkHdMXD
 MtZ3ZWsfKfhUXMU0+Njyy7eAbUCQcWIsyW+MiDthFGPs0C2sOXW9I6KUOc6tEOzAT6Mw
 h+bExuvxnoNhAe9Y52NGm7D8YogUvmd7aemaoQm1nDh0hwjemqEb3VFsEpdLJkhIfeuH
 +n8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwAHvTa58GejX3nPsNs40b7I4V3Z9xJEDdk1lUqmxPsjjQETHzbsJaiz95fXDeN5R1MZ9o3/E=@lists.denx.de
X-Gm-Message-State: AOJu0YxzbONR+sNjdz3rafj3gv1oCbMiswcDDK0Cat0f98kAvkdn/SaU
 JhC21ncj3w3AztA5jvsbCkce59pN4hk5inmKXXlnvYG09ozazAz0h9xXfoXS0TWAdadk4oz/1dL
 OsVdmbM0=
X-Gm-Gg: AZuq6aL+U6RGv57YEfN6KtMvUIOmeI7PLnFd9MpwPGNNrrGPUlPkJOWv9kdSlp7yD0p
 USLf9hWuUYlKhEjJcvq8x/bZ1BTU2MkLEGtSN4OJYgkplXNO0+k49m0CKn+E6dTzQ8pxi4WFflb
 YTVmIkF+czs7W64lXMEj942/DGz62iOVIs0E+W34lmmq7+qEQxkafePFTqDR2T6gdNUM8oBdRln
 SGXPK4aNI4DWTnYnwE1+j/4Or/OA12kAkNAyy0jQ8nLqIo4LRnKrVrLfxvjCmDORFFp0hL7C/t/
 t2cyCuQg8E9njhaEDiP2tAPxss7xzOneNFwLDwAguZSTPT2GENzY18/Ngae6Otv909TFYJfUTlI
 uoHv3O3bJtoPJu6EFhJkm/2VkXBcbNnf/dZzOnKgMuiaP8k1Ge1P2D8pGRvL28O9xDkgpplnLFP
 z/9enipm+edc+X8NcNfxydWDUO0whckvEjbMOloUWPCilEDXWaeLcBRYLkgkcztzaLzXufKQ7eS
 cE8rZp0Xhn2KmawHvWPy5EDTYWE0fpe7Raa3xA=
X-Received: by 2002:a05:6820:2d0a:b0:662:f90e:cdf2 with SMTP id
 006d021491bc7-66a203a70d2mr1558789eaf.12.1770213222193; 
 Wed, 04 Feb 2026 05:53:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a3318c761sm1296737eaf.8.2026.02.04.05.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:53:41 -0800 (PST)
Date: Wed, 4 Feb 2026 07:53:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v6 2/3] test: cmd: add test for memsize
Message-ID: <20260204135338.GV2603314@bill-the-cat>
References: <20260125131254.23210-1-linux@fw-web.de>
 <20260125131254.23210-3-linux@fw-web.de>
 <20260203233402.GU2603314@bill-the-cat>
 <5E5EDF2D-9CDF-4640-9639-88FD888B688B@public-files.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DtZ9aYde1KsWr9Ny"
Content-Disposition: inline
In-Reply-To: <5E5EDF2D-9CDF-4640-9639-88FD888B688B@public-files.de>
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


--DtZ9aYde1KsWr9Ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 07:40:05AM +0100, Frank Wunderlich wrote:
> Am 4. Februar 2026 00:34:02 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sun, Jan 25, 2026 at 02:12:52PM +0100, Frank Wunderlich wrote:
> >
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>=20
> >> Add a test for memsize command in same way as meminfo.
> >>=20
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >> tested via:
> >> $ ./u-boot -T -c "ut cmd cmd_test_memsize"
> >> ...
> >> Test: memsize: meminfo.c
> >> Tests run: 1, 0 ms, average: 0 ms, failures: 0
> >> ---
> >>  cmd/Kconfig        |  1 +
> >>  test/cmd/meminfo.c | 17 +++++++++++++++++
> >>  2 files changed, 18 insertions(+)
> >>=20
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index be79bf0747df..2bafa156ca8a 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
> >> =20
> >>  config CMD_MEMSIZE
> >>  	bool "memsize"
> >> +	default y if SANDBOX
> >>  	depends on CMD_MEMINFO
> >>  	help
> >>  	  Get RAM via command for use in scripts.
> >> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> >> index 53b41e3b49e0..ba772a8b7616 100644
> >> --- a/test/cmd/meminfo.c
> >> +++ b/test/cmd/meminfo.c
> >> @@ -7,6 +7,7 @@
> >>   */
> >> =20
> >>  #include <dm/test.h>
> >> +#include <env.h>
> >>  #include <test/cmd.h>
> >>  #include <test/ut.h>
> >> =20
> >> @@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_state =
*uts)
> >> =20
> >>  	return 0;
> >>  }
> >> +
> >> +/* Test 'memsize' command */
> >> +static int cmd_test_memsize(struct unit_test_state *uts)
> >> +{
> >> +	ut_assertok(run_command("memsize", 0));
> >> +	ut_assert_nextline("256 MiB");
> >> +	ut_assert_console_end();
> >> +
> >> +	ut_assertok(run_command("memsize memsz", 0));
> >> +	ut_asserteq_str("256", env_get("memsz"));
> >> +	ut_assert_console_end();
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
> >> +CMD_TEST(cmd_test_memsize, UTF_CONSOLE);
> >
> >Since the new test isn't guarded with memsize, this fails on qemu-x86_64
> >where meminfo is enabled, but memsize is not.
>=20
> Does x86_64 test not use SANDBOX? Do i need to enable it somewhere else? =
Imho it should ve tested also there so guarding just prevents the test. But=
 of course i can add guards for it.

No, it's qemu-x86_64 which is a different board :)

--=20
Tom

--DtZ9aYde1KsWr9Ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYNPXwAKCRAr4qD1Cr/k
CgfhAP4gm0jtAmwJTTc7jYkzA7FNFcfYMhW9PZpAb0k6B9G3lgEAy2ajLHrsMJLU
8EY4Tl1WFmbGdEPUOSOsq2b9NYzg3Qc=
=Hu2k
-----END PGP SIGNATURE-----

--DtZ9aYde1KsWr9Ny--
