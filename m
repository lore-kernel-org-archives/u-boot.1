Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A2D5B847
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 23:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205C989160;
	Tue, 29 Oct 2024 00:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XgQiiogf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD9A89145; Tue, 29 Oct 2024 00:27:10 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB40189160
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b152a923a3so379577885a.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730158027; x=1730762827; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HYtK7K+gmi35vW/gzDXF7i6TJ/+qeq7NMMcCWEVu3zA=;
 b=XgQiiogfWJ8IOZZLapeKM31v4fGVQheS7RhbicInTgQwOaIFp8iE2r0x8e1SUplObm
 UO1PKOX+kKmLftI0dMVnFUdtQQQ68QPxL1KQqZtm7Euhi7l51wqbQnDPoKH5I5ABVgbO
 iSx8XF5UUDOr/wYhOidXzk7gZLkQ0sg9HH0/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730158027; x=1730762827;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HYtK7K+gmi35vW/gzDXF7i6TJ/+qeq7NMMcCWEVu3zA=;
 b=d6trScEkS7MP7vNxzCfODX+kCFToba/QOC+E70JyrJyaiZAvtekc7twjG32bItSOFj
 vddJFDhxEXjYY8Rx+zcIKpvlaMkFIoQcR7P8OonHaZHA4gJxV+gMZzFMp4hrjLtdkvPq
 TMRCaA/yIyUyc8SocU84M/rraTBWm0BjurAxfd7QJ/HC8fJSRZRuyTKWIe4pkr0eI14z
 h5KbnmwWzC5Dk/KZluEzVIyuL+tJM7RBSuKxhqHq3PrKJOV4T0D7N+l1KqfEtUgO8XtL
 raZbg7Wn2Z4iGlQ96BEoOlGUYHUSm8ZVCT5TT8m2/ule5CgqxVVUVm8NEWeK3kHoV1tf
 dnFA==
X-Gm-Message-State: AOJu0Yyif4cq1yJqKOGp31lxqVAummR1uzltlEp0Ynt+jmNOipyWmdcc
 0Xk5mOMkuFyZJz61jNmaG2wcWt45PqBM4ohUhtztMu1oIErS14WSO+8X9UiNU+yMJlAWcPeqt4q
 txRQ=
X-Google-Smtp-Source: AGHT+IFdkcXkIvkuMYmy0p1BlP5qGQl6xkK6kPd/W4evNFa41ZqM5yDSTjdswqkiF+QReRL0xWMoyA==
X-Received: by 2002:a05:620a:1a91:b0:7b1:4806:351f with SMTP id
 af79cd13be357-7b193f57653mr1567507485a.59.1730158026714; 
 Mon, 28 Oct 2024 16:27:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d334efcsm365584385a.97.2024.10.28.16.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 16:27:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:27:03 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.01-rc1 released
Message-ID: <20241028232703.GX4959@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OsH3affvgva61QZv"
Content-Disposition: inline
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


--OsH3affvgva61QZv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here's v2025.01-rc1. It's full of big changes,
which overall, is good. These changes have been in process for a while
and are ready for wider testing. We now have MbedTLS available for a
number of cryptographic routines, and lwIP is now available as an
alternate network stack. There's changes that I hope to merge soon that
will let you combine the two and have grabbing of files via https work
correctly. We've also reworked how the "lmb" code works so that it's now
persistent rather than being setup with each caller. That said, there's
some known issues:
- I just now see that the lmb rework is broken for Apple hardware, so I
  would expect problems with (any/all?) peripherals there as I believe
  they're behind the IOMMU which now doesn't get mapping done as
  expected.
- There's problems with a number of SPI NOR flashes right now, of which
  the question is how to fix that without breaking new support too. This
  will be resolved one way or another before the final release.
- We've started with support for working with (for the benefit of the
  OS) ACPI tables on 64bit ARM platforms. While there is a Raspberry Pi
  config that makes use of it, I've been told today there's likely some
  big issues with it on real hardware, so please be careful with it, if
  you try it. This too will get resolved one way or another before
  release.

My queue is in alright shape, but aside from the above mentioned issues,
there's a few other things I need to clear out still.

In terms of a changelog,=20
git log --merges v2024.10..v2025.01-rc1
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

The merge window is now closed (but we aren't as strict about that as
the Linux Kernel), and the next branch is not yet open as it will open
with -rc2 in 2 weeks time. The next release, v2025.01 is scheduled for
Monday, January 6th, 2025 As usual I plan to do an rc release every two
weeks with the exception of I'm also doing -rc6 on Monday, December 30th
to have one more tag over the end of year holidays, to see if that helps
with people finding time to test.  We'll how that went in January.

Thanks all!

--=20
Tom

--OsH3affvgva61QZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgHccACgkQFHw5/5Y0
tyy/hgv/aQ+01Fx9jV4K6KPfF74V/J3c4M5/vUNFL3t3VBEgz3eoC4No2bUExCZA
s6+SWfVxzQZXLt0FVww0GH6KSrRUwmpxNUpaVZ0kZthTXeiJtwRnyuZOHtXFa1Vy
WVkORCvqU5Hpge0kZN0yc5xhv9LXVKDysdtvXFL1ajyniAcYPXb5jEfkM1uy0Lb3
TLsqjeMCiAtkBIJH2P3s2klHlfTuz52zvCS7i+upntQP5m31RwMKxnytQwUhEJ5D
CrGj2S628h+EKMjebseDTvkTBOVPffdu1PGCAWUJPkbqafQWbEkiWpXd2IBOwWeH
nE56S+KpymMXuylWSOjovabP0N4i3l2xqPoCSGQwrr1baFcN1lKG8gLY6yxIoDt6
h7JwQqOD+gWzBMq/ET2wfpySX1FDktwL6+w/KihdeAkL3Fgv+xOtElqEREazVf9k
fz+xcjmdbCdTbNkSeeq4MEtFxM99tKHB4iOefG1JpzBxY+c9dS5OLPWf6VRPflVZ
ngWvRcdA
=H+wd
-----END PGP SIGNATURE-----

--OsH3affvgva61QZv--
