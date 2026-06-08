Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C753CD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5996B807C4;
	Mon,  8 Jun 2026 21:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HvM/2ylw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4CF8405A; Mon,  8 Jun 2026 21:13:09 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D54800AE
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so3180125eaf.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780945984; x=1781550784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ERaxGlQv7n9ZKbVGbhDs+K/uRpJ9tP2FIP06Klq0l7I=;
 b=HvM/2ylwoSyjm6JCHV431fab6HZ38Qx1XCF2sbMX7To8dlnnByS9dFic33QY+bd/Tf
 0rBSNe5bICxmAtPpBFRNktnIlLekfoN8HVLdX4kKE7ebWw1ap3MdlVsHPiUyapA394/9
 AkzAirk0Z2vRkiiDIa0wKoWt+9+wXkaTHxkc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945984; x=1781550784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERaxGlQv7n9ZKbVGbhDs+K/uRpJ9tP2FIP06Klq0l7I=;
 b=sj5Be8xzhPb5jamLrYEsrYEK3Whrfc8xaXYaXkinCkHo4qByw9HdzXTDjW/OMKU04C
 UPrNDMjFobFum8XqdbdNsRvZiIC+mKWkKLcYntF6JgJ065p6vMSkxr27WbyZL9bnHTuA
 5ntaTVuHxGslXFk+OLZ6cryOzxxxefGmRh9AfkJwmEbYHr4g/qRDQR9FpHE05jE1SZzt
 JF5cyqoOUb45/NJEoBTiSYqYsvOeNWqlK+32xzqMXLpvBl8MoWoaRMhUw/zEJre/v4PE
 UrLuUEdkhj1ygs+WVytczpPSPyZBt7WpWSbt0DdSRC2hRl9UVVWdQnoRB68v9GV+59CE
 5e4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mcrt9FG/YRYCgHlRwnxsU0sZ7f6uA4MEAVBje9RmiJSUp6e9YCBBrnhbSTKaDaAdrsR5ygOE=@lists.denx.de
X-Gm-Message-State: AOJu0YxfE6wlNF3KIcv5bHzg3xDEL4XFDrkjb2+VPjvPGwttbGh3ix/1
 PYgp9EhPQE5Vu+g8f72ihk1e9Wm/l6lfknrU71X9TmF9DSh/MN+qHidFMvi8opLiNWI=
X-Gm-Gg: Acq92OEa1n8QTtMyHNkE6gGpRfBwkZrSXR0WCQk8pyzLpV6STaEToW4GqoLwbdlqoIR
 fWZOQ8R3Q0LWyPbUhc++AGmDXHd5869QxjGG8jvydcazHRG5zZx3Ze2wFW1IAjbTmGCYat/HT4e
 I3azKM4w+bAJNEV6YK8mR7zY0RtNRGZjqgNPkUfA0gzePULxvUGK8AwyOVMCS9Fw3zVWp7a3Agl
 VPuYjN7Hjo8bx4qNovh+ymTl4pIrlEeHkGq4eD86fGDNFuJmBegAHSiwuO2Jb62t6NeRLVIN1Jk
 jisjogCqaFEzWrCEh+sbT1UntXTW9ArJGrlH0QPEPX1W9Ym33SyrE5Py1lVRu5I17ZcvTX1YFdY
 nf3qvAvyWUAaxLjhFJEnmZ9PvASKU4rY1Uy8Ju6A1ndIHl7CCtdVEtydvjmzZvqVpIZeFfQSre5
 gIuYOQ8ToF+p5GJAiDu60n3pwJ4mRoa6RjY08HAu2DBK5w7BXic2ZSaUqS9NTR5q6HBmOGt/hjs
 XpoYgQW1FEU4f4KqHWEnu83lBu32rQVyNDc7HepFhjQ/oi8RK4lh5HHAEVbXA==
X-Received: by 2002:a05:6820:1512:b0:69e:4c05:f6aa with SMTP id
 006d021491bc7-69e68b15754mr8567447eaf.3.1780945984067; 
 Mon, 08 Jun 2026 12:13:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e4644dacdsm11314471eaf.13.2026.06.08.12.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:13:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:13:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>, andre.przywara@arm.com,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
Message-ID: <20260608191301.GQ382693@bill-the-cat>
References: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
 <DJ11OP03ERX3.OQJE3XQ1QJ3F@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5d6Mmefpf6LJSV84"
Content-Disposition: inline
In-Reply-To: <DJ11OP03ERX3.OQJE3XQ1QJ3F@linaro.org>
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


--5d6Mmefpf6LJSV84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 01:31:16PM +0300, Ilias Apalodimas wrote:

> Andre,
> this has been assigned to me by mistake in patchwork.

Yeah, sorry. I blame typing "ap" in to the box and not looking hard
enough that the correct person was selected.

--=20
Tom

--5d6Mmefpf6LJSV84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaicUPQAKCRAr4qD1Cr/k
Cs+iAPwOhGcX4aXX2UcXM0oL2yB5TEeeOn5Dp6lICzBDrJcShQEAt66bXCp1S6K8
C3D2FWGVvPTmTFBiShPlXDqWfjSFbAQ=
=ic61
-----END PGP SIGNATURE-----

--5d6Mmefpf6LJSV84--
