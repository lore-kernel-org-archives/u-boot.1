Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4ACD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 20:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5927A84837;
	Tue,  2 Jun 2026 22:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C0XGwCkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9205784852; Tue,  2 Jun 2026 22:31:54 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8C7839A8
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 22:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4864abba33fso613636b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780432310; x=1781037110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YRiYQtCTASq9sg+KYhcvyj4sx/JlMi22WKFwRPAC0eE=;
 b=C0XGwCkf3MpSg4suZn3OfxDsGVSrzkauHkXG9Kf2fhXOkUCkcLUdBZpTgsNASrRn7N
 e+YXl3YR+tMK+UAzM4pDGIJVZWPxB5jfJp00CpGgbjqBL5/Sd02dFlu1UKS/N3/j7a3u
 qp+EGzzJ7rALDGxD9HMycHLkkawm91ipkzDyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780432310; x=1781037110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRiYQtCTASq9sg+KYhcvyj4sx/JlMi22WKFwRPAC0eE=;
 b=JaHOLXWhEJalVSQ4dpu+i6AAvtQlhntXv76RYKLS811oZ0jhRSF7z/Y8Ui1cT03hsR
 tfJmKelPp4x0aeyMYqaBCbEJG0cM4tILH9z77t4ce8mpT5LE4TLLHrUaxRzR5OSjS2C3
 4ZmnUQWn4OBJ4yh3pPfNQD8xgpihZxfEMcowAfVB/T4mJ6yjCNowCJvyAarQet6jFcgl
 ywuffhAsXbhVizq/QyZpgKrQUFaloLm95olt3YmlG10z72PQ3Fw3lkjP/ypB/ql+jtz6
 KBzNXQOnRCBjB6u/V/2Q6Q/p6R8lORsHhXVKdeFCnGwW41pIZ2+GTqeWMPEcH1na0aHB
 YwkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BdjSX2O5JkiWHlxS3i3onOX4hFdjPWEDiemvqNRxMHjwnmBXYkgWu4cwYpAT4W/3fwguddjs=@lists.denx.de
X-Gm-Message-State: AOJu0YwmoFcx6Zp+3V4S+zIuFxjzfSKLYMOzbjwq4h7gT+5BhLp90Xev
 Ww/aFkMWX1gTAF5AkBlNP+EEmcTA3v5IHDocKMiD8q8U7tuB/Ld7Is4oCs9b+bUUDU8=
X-Gm-Gg: Acq92OEhGlL07ajRjSPgAyGHQqbJo/lpdK2oEQgK0l4vRSZGGff/goMRqUUfoEXJKTD
 dUpyN8gHYFIACoDNZjnEczSy6lFDcoVBvIy8kdHc83SSixqq/7cVMw+YRKa3nhlvMy1ebflQOCs
 B/Bi81hsyImK/+5xc11uJ6Dawbn205lJxWoMwWo4i6UMey1yw5WcfBjxpLD4JkEVW+W5g6sdmgu
 NZqOlX5qfx3CehQUtEY/jwT5ZVNRb9FXMVMV1YaOmzXp9R/5xM4Zvkm4buVmzp0zu79BMXNsv3R
 fZNi2YwJExqDVVpBwiY4OO/28YL7tVQ3ApZr44LIFcoWnqC6CS4/CtLo2skgNzpApIfNW4Z4Oa3
 N7QKfpeoCMU89yRrc+mitCApyLB/rW1UOy5kLapEJBAiw946GgDMwUXwPQilC6iOoMViijkGff4
 J5B/yMdKAGWbRRJm63AF3UrpnOmsKqt1GLw5DuyQX6ovrNe6hzZOZNbdA+eN+zVahoTA/2dLBub
 sF7BOiAFlCe+Msfxz5m+kMdbWCFEEN48Gdf6TBvxhkeaJaPlTmAzq5LXYk+jg==
X-Received: by 2002:a05:6808:4f50:b0:485:6029:90e7 with SMTP id
 5614622812f47-4865ae64015mr196318b6e.10.1780432310452; 
 Tue, 02 Jun 2026 13:31:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78dd7b9sm299316a34.15.2026.06.02.13.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:31:49 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:31:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, afd@ti.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCHv8 0/3] various memory related fixups
Message-ID: <20260602203147.GO627328@bill-the-cat>
References: <20260513204943.736142-1-rs@ti.com>
 <20260527000924.GA4051518@bill-the-cat>
 <DIYTJM7IRHSK.3UG460C1ZOUWF@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fbOOxNmG9Cvlo8jP"
Content-Disposition: inline
In-Reply-To: <DIYTJM7IRHSK.3UG460C1ZOUWF@ti.com>
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


--fbOOxNmG9Cvlo8jP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 02:43:09PM -0500, Randolph Sapp wrote:
> On Tue May 26, 2026 at 7:09 PM CDT, Tom Rini wrote:
> > On Wed, May 13, 2026 at 03:49:40PM -0500, rs@ti.com wrote:
> >
> >> From: Randolph Sapp <rs@ti.com>
> >>=20
> >> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 s=
upport
> >> [1]. This does a lot of general setup required for the device, but the=
se
> >> modifications themselves aren't device specific. For those specifically
> >> interested in PocketBeagle2 support and don't care about these details=
, my
> >> development branch is public [2].
> >>=20
> >> That first patch may provoke some opinions, but honestly if that warni=
ng was
> >> still present I wouldn't have spent a week poking holes in both the EF=
I and LMB
> >> allocations systems. Please let me know if there is a specific usecase=
 that it
> >> breaks though.
> >>=20
> >> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
> >> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2
> >
> > This leads to test failures now (that either need to be fixed or
> > updated):
> > https://source.denx.de/u-boot/u-boot/-/jobs/1464028 and please see
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html as well for
> > starting CI, however you might want to run the tests locally first.
> > Thanks.
>=20
> So, that's the fun part. I ran qcheck with this. I went tracing through t=
hat
> make target and even started manually issuing "./test/py/test.py --bd
> sandbox_flattree --build -k ut_image_fdt_test_boot_fdt_add_mem_rsv_region=
s -s"
> (and again with sandbox, sandbox64, etc.) to see exactly why that's faili=
ng in
> CI. I cannot reproduce the issue reported. It passes and reports all the
> messages I'm expecting on my end.
>=20
> The CI pipeline must not be loading the test.dtb. No idea how that's occu=
rring,
> or how the other UT_DM tests are passing. I don't see any particularly we=
ird
> parameters in the test logs.
>=20
> It's not like this test is dependent on the same things UTF_DM tagged tes=
ts are,
> but I expected to be able to reuse that device tree without having to spe=
cify
> that flag. That's the behavior I have locally at least. Adding an explici=
t check
> for CONFIG_UT_DM didn't seem to help at all.
>=20
> Any advice here?

Have you tried running it the way it's shown in the
=2Eazure-pipelines.yml or .gitlab-ci.yml files? And I wouldn't limit
things to just the single test, it's possible there's some unexpected
thing to be cleaned up from another test that's contaminating things.

--=20
Tom

--fbOOxNmG9Cvlo8jP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCah89sAAKCRAr4qD1Cr/k
CnAnAQCLGkIXnmVund0mayDhxE+cFGCji15VYKfgfCXbVBh7zQEAtE/2fnsFJlua
btJ6WdTjF40++PyLCJOdZlnKtf0XeQg=
=pL2Y
-----END PGP SIGNATURE-----

--fbOOxNmG9Cvlo8jP--
