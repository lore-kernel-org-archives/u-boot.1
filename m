Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0B4E9D3ED
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4DE838FA;
	Wed,  4 Feb 2026 15:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lS/n2C/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A85838FA; Wed,  4 Feb 2026 15:52:04 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DF980086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45c715116dbso4723780b6e.3
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770216709; x=1770821509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pLBaQl0yHBwfbfRcvKAgLXZUDBtYhHv7qGRYrIx9/e0=;
 b=lS/n2C/CUX2Yg36ku6dbFJ6i9l76zy2uOy3v6D10QFdB17l+H3pRBzVfH9lzy0sFw7
 4xqxpV5MCNCJ2g9DENxZi8xaDvOMLXCIIzDIpFVwcAxPle4VLCiR8u0+7Ux9Da7EXo/O
 jbwkfgl/8hm5fPWjT0pPvSlyP8xTLh3Bpu8HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770216709; x=1770821509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLBaQl0yHBwfbfRcvKAgLXZUDBtYhHv7qGRYrIx9/e0=;
 b=jNmUtkmOgKhCyKFw7txTEzh68RsImIsj8idyHp/k/3cwicAA24Wo48Kif572pTHp7Q
 hpbZWAQuOVxcc5dp84VkgysZKwwy8+FgkUGypA2RmTEsH5QaXzjOX6kv8UpjEcXP/mj1
 XxbQ62SMGrZLCxEtx/G4jso8kz0uM3u8gMouU6SHb1Oim+nQP6v2dQe6Nk0kT2r4cZT9
 jugs1nb/aVqeO0rpukD6v6V6JVcX10FIvja1d3F7DTI2ybGdEICh2GHxnoOa6s47Qeaz
 8HYB8vDJdT/L85nN7TZYzKjmi1Afh4Kf/x3yrUzlaW6AiK6HXxPnAKMSg2MMsmvumrno
 +XCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSEuAIFOzgAomtpugPnRrBFUJNYorqDg1f7AlqLmFIsW/YC9HQvVUbFjq/WKKnXfcaghIDt0=@lists.denx.de
X-Gm-Message-State: AOJu0YxWtj+u5CePjMXE/q2M5JS1zlV3UdfsQbiio+ywxzcld6d0Rr/M
 rGuJ7u3sdd6IY63zDHOiozwJ+mVEs8b1UNwvpbbSIyXugP0CW99J+pdSOupj6A+554IoWyM7GBk
 zWgcy3ow=
X-Gm-Gg: AZuq6aI/7nlUCs2VhcUCEk7qJ8RND0wVSt6wIG2Mwnw1A6bGZmOQbwkNAygTkWpRqNr
 4Gf5P/LUdLpXrilqsp3LweZwa4MzeXnsMwovzRtOGm3kfyRQxrZmlsooA9JArawdOTG2pZ8FXy8
 s6NcSycT7IbgTx+lLqqGG8czQtz1ZwmW8sxbOf9DyB4QmuNfdgcgCAcdb9BmeNlLZPFg9/4195h
 mCJmQ9P+fI9dNvJPmYzfxQ4yII59ouwaru8fDiqfpVEPGBDWIk+cA4Vw+K9hyvKiluPJPXWQEtz
 5EgEym4roQTkxFNAco4ZQviLayS805aftlF/oZkW0KxlyY5e1+/I3ouUdHG8DCGGQLHN4YIuVan
 /Du+uuxGfZrw1Ch1R0spWYbMTX2g1oHEytCfdFSyVnWvcZINruubj4pbJ4puw7I6tgG9HeVunaC
 Dw8BVdHxdhqCmn8gKcR0yvwDBn0B5+S25A5I+RYIU6Vt22ZIRLvQ57bULL6v54zTyZJqqgPs9YR
 lgOAjb+2ppb9X88rPCVi2efYlMPCNlf67Hcydg=
X-Received: by 2002:a05:6808:1581:b0:459:b564:dd64 with SMTP id
 5614622812f47-462d5a7682fmr1431756b6e.61.1770216708863; 
 Wed, 04 Feb 2026 06:51:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d6614885sm1450794b6e.1.2026.02.04.06.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:51:48 -0800 (PST)
Date: Wed, 4 Feb 2026 08:51:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v6 2/3] test: cmd: add test for memsize
Message-ID: <20260204145146.GX2603314@bill-the-cat>
References: <20260125131254.23210-1-linux@fw-web.de>
 <20260125131254.23210-3-linux@fw-web.de>
 <20260203233402.GU2603314@bill-the-cat>
 <5E5EDF2D-9CDF-4640-9639-88FD888B688B@public-files.de>
 <20260204135338.GV2603314@bill-the-cat>
 <5B1F4D3D-1013-41BD-801E-1EAAEEE004B8@public-files.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HxvyY+43pHc5GNoL"
Content-Disposition: inline
In-Reply-To: <5B1F4D3D-1013-41BD-801E-1EAAEEE004B8@public-files.de>
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


--HxvyY+43pHc5GNoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 03:48:17PM +0100, Frank Wunderlich wrote:
> Am 4. Februar 2026 14:53:38 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Wed, Feb 04, 2026 at 07:40:05AM +0100, Frank Wunderlich wrote:
> >> Am 4. Februar 2026 00:34:02 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >> >On Sun, Jan 25, 2026 at 02:12:52PM +0100, Frank Wunderlich wrote:
> >> >
> >> >> From: Frank Wunderlich <frank-w@public-files.de>
> >> >>=20
> >> >> Add a test for memsize command in same way as meminfo.
> >> >>=20
> >> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> >> ---
> >> >> tested via:
> >> >> $ ./u-boot -T -c "ut cmd cmd_test_memsize"
> >> >> ...
> >> >> Test: memsize: meminfo.c
> >> >> Tests run: 1, 0 ms, average: 0 ms, failures: 0
> >> >> ---
> >> >>  cmd/Kconfig        |  1 +
> >> >>  test/cmd/meminfo.c | 17 +++++++++++++++++
> >> >>  2 files changed, 18 insertions(+)
> >> >>=20
> >> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> >> index be79bf0747df..2bafa156ca8a 100644
> >> >> --- a/cmd/Kconfig
> >> >> +++ b/cmd/Kconfig
> >> >> @@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
> >> >> =20
> >> >>  config CMD_MEMSIZE
> >> >>  	bool "memsize"
> >> >> +	default y if SANDBOX
> >> >>  	depends on CMD_MEMINFO
> >> >>  	help
> >> >>  	  Get RAM via command for use in scripts.
> >> >> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> >> >> index 53b41e3b49e0..ba772a8b7616 100644
> >> >> --- a/test/cmd/meminfo.c
> >> >> +++ b/test/cmd/meminfo.c
> >> >> @@ -7,6 +7,7 @@
> >> >>   */
> >> >> =20
> >> >>  #include <dm/test.h>
> >> >> +#include <env.h>
> >> >>  #include <test/cmd.h>
> >> >>  #include <test/ut.h>
> >> >> =20
> >> >> @@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_sta=
te *uts)
> >> >> =20
> >> >>  	return 0;
> >> >>  }
> >> >> +
> >> >> +/* Test 'memsize' command */
> >> >> +static int cmd_test_memsize(struct unit_test_state *uts)
> >> >> +{
> >> >> +	ut_assertok(run_command("memsize", 0));
> >> >> +	ut_assert_nextline("256 MiB");
> >> >> +	ut_assert_console_end();
> >> >> +
> >> >> +	ut_assertok(run_command("memsize memsz", 0));
> >> >> +	ut_asserteq_str("256", env_get("memsz"));
> >> >> +	ut_assert_console_end();
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >>  CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
> >> >> +CMD_TEST(cmd_test_memsize, UTF_CONSOLE);
> >> >
> >> >Since the new test isn't guarded with memsize, this fails on qemu-x86=
_64
> >> >where meminfo is enabled, but memsize is not.
> >>=20
> >> Does x86_64 test not use SANDBOX? Do i need to enable it somewhere els=
e? Imho it should ve tested also there so guarding just prevents the test. =
But of course i can add guards for it.
> >
> >No, it's qemu-x86_64 which is a different board :)
>=20
> Ah ok,thought it is a platform test :)
> Then i add only config-guards.
>=20
> Should it send full series with the requested changes (squashed) or an up=
date (afair you have already applied to next/master)?

Please send a v7 that include this fix in this patch, I didn't apply it
to master because it caused CI to fail :)

--=20
Tom

--HxvyY+43pHc5GNoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYNc/QAKCRAr4qD1Cr/k
CskIAQD1E/rLryrP2B+pzFbXXaVD3A2BUJyT3BsvkCbrJg0F+wD8DyBgNymY52CI
SxQntS9HCurT3p1BQxOlcJ9jJ/GC8AI=
=4Ww5
-----END PGP SIGNATURE-----

--HxvyY+43pHc5GNoL--
