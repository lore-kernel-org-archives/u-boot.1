Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B9CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5BC84868;
	Wed,  3 Jun 2026 18:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JOeg2MAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078788486D; Wed,  3 Jun 2026 18:10:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E58383EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6d14aaef8so1204593a34.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780503036; x=1781107836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x9AXYA1tO5+RbvoFhWfrTk/wZ8KEW3Z+cQ0Ya+S8D4s=;
 b=JOeg2MAhHeq9DMW9ZPU/vyydfuI0rUeTWUP/WHSYNpWExkdGjPC4XQAQRL8TvO8kQY
 xrnYiStC8j7GyBB66Ow8eFIpRCrs2cqrVDs+0fkg5JpmewsKcTefoxElf7v/2swGwr8p
 0V7bIwgXUSIMW+zoUPXlIuRTX/Acb6UnqhqPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503036; x=1781107836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9AXYA1tO5+RbvoFhWfrTk/wZ8KEW3Z+cQ0Ya+S8D4s=;
 b=jpRUXzuaOxwYglx7iJU1N64fp5/vWyiDkmiHa8SoLzz/ftVkioPu0zYo5amDGzLb3d
 JFUOWZQPRmPtaaBjVdnVyDZa6C8VM//Rzf6XJmsbIo+DgO2QYLc5VWe1wdOmNj89O22L
 85HA2M1XVforOPRNfwwqbcIGB1EaVSyz4J2d74VSN67IK/TnIxfi7wEzqCuPnsdJ7CIv
 i0rXSRkcisC5kGfiEguIW/t+8QHTvomjT1nr29tq20M+POZkacTOjGow1bddzK4zsEM0
 PDFtZPK/UsCizwjy+3Rcj3QKnNYGvquh1HRQLTIc7LZdPNULaAFQNC299GSf1GXTVmtz
 5ysw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wgyi4B/cuvnaCrVr6FkesbymDCoIsGUVi3DdR/zgda5HuFELGXFW+CIJK5hKECzkRzozhxw0=@lists.denx.de
X-Gm-Message-State: AOJu0YyJBlDx6lw/trHfSIp9Yq9THkcgIMZRaSUeA8m7JkCCp/8u5wWy
 nJjZZ7IsoYcc/Vi+/4tVZgNdrV6leWt/1jr4D4mp2SzRg8uvgySgZ9nFqI8QdRhWGZk=
X-Gm-Gg: Acq92OG1uz/ZcsW8yTj66+ew6g6dmDuIubpf9DOoGAAXPXMkxL2JwR1Uh+IVjr8kyFR
 bTXVK0Iqyj5zfb9ihJd4rKSHPYWevsmZoYJUkoVEBQA5dSKjrko+NATrcGkYEF70zxJyvJn9OMA
 ttRtkZxLyHVwnQBnOq5KkzfA40aJ3/9QiCA6mtd+73B4a1WrcmYJoI3IuDoTwH07UHN77iDSSW3
 Sp58wjBVAxgdMFx8mse+Bpp/vX30IM6z3cNoaYYDiu07r2d6nU1iQ7DJWBxgSKqMDqoCO5Gfaca
 3aoo983l3otezplwuQPLXdOdfXixIbQ6lewtS0S/WtDosCkszhZTRTEnRah6g3gqR4Lc382Rz5d
 bDnv+NSyP2kbv6BacEc0ljZeEWa0Q9FXAh3oJhCQy2PcKV8WXc9L2krnzbGI5W4sM2QKlPIE44f
 EpYS5KWrNZwZT+ZfQ6TnbNqNYgqDHXrjO/E8Jpe6huEHUXMXXJdbXfkdg3VbmBH9eRD5Ivj0WLu
 V3qzqJJH0bdveZUXo0cE9t8bvzZoL4JTjOfcp51SVcCb6itsiJikXDkosrU+Q==
X-Received: by 2002:a05:6830:2703:b0:7d7:4fc7:21a with SMTP id
 46e09a7af769-7e6e9d35cc6mr2096698a34.13.1780503036028; 
 Wed, 03 Jun 2026 09:10:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e746965asm1949801a34.4.2026.06.03.09.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:10:34 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:10:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, afd@ti.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCHv8 0/3] various memory related fixups
Message-ID: <20260603161032.GP627328@bill-the-cat>
References: <20260513204943.736142-1-rs@ti.com>
 <20260527000924.GA4051518@bill-the-cat>
 <DIYTJM7IRHSK.3UG460C1ZOUWF@ti.com>
 <20260602203147.GO627328@bill-the-cat>
 <DIYY3OHVR8RJ.1PB5CX4VZJPN@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vUMLCAqEkejMB+BO"
Content-Disposition: inline
In-Reply-To: <DIYY3OHVR8RJ.1PB5CX4VZJPN@ti.com>
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


--vUMLCAqEkejMB+BO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 06:17:26PM -0500, Randolph Sapp wrote:
> On Tue Jun 2, 2026 at 3:31 PM CDT, Tom Rini wrote:
> > On Tue, Jun 02, 2026 at 02:43:09PM -0500, Randolph Sapp wrote:
> >> On Tue May 26, 2026 at 7:09 PM CDT, Tom Rini wrote:
> >> > On Wed, May 13, 2026 at 03:49:40PM -0500, rs@ti.com wrote:
> >> >
> >> >> From: Randolph Sapp <rs@ti.com>
> >> >>=20
> >> >> Nitpicks and fixes from the discovery thread on adding PocketBeagle=
2 support
> >> >> [1]. This does a lot of general setup required for the device, but =
these
> >> >> modifications themselves aren't device specific. For those specific=
ally
> >> >> interested in PocketBeagle2 support and don't care about these deta=
ils, my
> >> >> development branch is public [2].
> >> >>=20
> >> >> That first patch may provoke some opinions, but honestly if that wa=
rning was
> >> >> still present I wouldn't have spent a week poking holes in both the=
 EFI and LMB
> >> >> allocations systems. Please let me know if there is a specific usec=
ase that it
> >> >> breaks though.
> >> >>=20
> >> >> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
> >> >> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagl=
e2
> >> >
> >> > This leads to test failures now (that either need to be fixed or
> >> > updated):
> >> > https://source.denx.de/u-boot/u-boot/-/jobs/1464028 and please see
> >> > https://docs.u-boot.org/en/latest/develop/ci_testing.html as well for
> >> > starting CI, however you might want to run the tests locally first.
> >> > Thanks.
> >>=20
> >> So, that's the fun part. I ran qcheck with this. I went tracing throug=
h that
> >> make target and even started manually issuing "./test/py/test.py --bd
> >> sandbox_flattree --build -k ut_image_fdt_test_boot_fdt_add_mem_rsv_reg=
ions -s"
> >> (and again with sandbox, sandbox64, etc.) to see exactly why that's fa=
iling in
> >> CI. I cannot reproduce the issue reported. It passes and reports all t=
he
> >> messages I'm expecting on my end.
> >>=20
> >> The CI pipeline must not be loading the test.dtb. No idea how that's o=
ccurring,
> >> or how the other UT_DM tests are passing. I don't see any particularly=
 weird
> >> parameters in the test logs.
> >>=20
> >> It's not like this test is dependent on the same things UTF_DM tagged =
tests are,
> >> but I expected to be able to reuse that device tree without having to =
specify
> >> that flag. That's the behavior I have locally at least. Adding an expl=
icit check
> >> for CONFIG_UT_DM didn't seem to help at all.
> >>=20
> >> Any advice here?
> >
> > Have you tried running it the way it's shown in the
> > .azure-pipelines.yml or .gitlab-ci.yml files? And I wouldn't limit
> > things to just the single test, it's possible there's some unexpected
> > thing to be cleaned up from another test that's contaminating things.
>=20
> Hell. Had to bisect all of the ut tests just to find out
> ut_bootstd_bootflow_cmd_boot is changing out the device tree before my te=
st.
>=20
> I didn't want to make my test dynamic because there's a chance any reserv=
ations
> I try to make could overlap with a device or some already allocated range=
=2E I
> need some known working allocation that's in a valid DT to be safe.
>=20
> The bootflow_cmd_boot test will change the state of the running sandbox i=
n a way
> that I assume can not be easily reverted. Please inform me if this assump=
tion is
> untrue.
>=20
> I can add a wrapper fixture in pytest to make sure the sandbox is restart=
ed
> specifically after that test, but I'm not sure if that's appropriate.
>=20
> ---
>=20
> As an aside, test_ut_dm_init_bootstd should absolutely be a fixture inste=
ad of a
> test. May need to fix that later.

There's other tests which force a reboot, and so it wouldn't surprise me
if one got missed. And then yes, our pytests themselves would benefit
=66rom someone with a bit better understanding of pytest spending time on
it, or just someone spending time on them and not a dozen other things
at the same time as well. Thanks!

--=20
Tom

--vUMLCAqEkejMB+BO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiBR9AAKCRAr4qD1Cr/k
Ch5aAP4m8kijzi3fRJ6xFaObr5WIa05JqGlkiDmjaugo0wrHogD/RQGwGCHkXlYF
ZTiWfbyvwqKQxrs14LLuvXuyl42nTgY=
=oG/0
-----END PGP SIGNATURE-----

--vUMLCAqEkejMB+BO--
