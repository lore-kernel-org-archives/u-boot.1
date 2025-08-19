Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE182CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24309809A5;
	Tue, 19 Aug 2025 17:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDRSidRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD62180FA1; Tue, 19 Aug 2025 17:03:14 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5754E802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-30ccec2515dso3935782fac.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755615791; x=1756220591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f/PhPUm7UISgXrfP/1uegymidi4T5Eq0kCR44VfVTeo=;
 b=KDRSidRHCHLidlNpExoDmxVMO68VDck3SFHbfFM2vZJSlBHCR0+wujhP1QbYrL9Wwl
 WmVL2/lI8Se9RToxtha2mys8nY2hbDYIMU2t0CHXUOg1g9Mpfo/NJXlARONlZxV936bF
 /FazEpfyAqwTj5kRiJg/KpZDKtUwOGqGIuIJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615791; x=1756220591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/PhPUm7UISgXrfP/1uegymidi4T5Eq0kCR44VfVTeo=;
 b=HhA4lNrVny6CJQyIKEhLBI4KsD+1VEPb8BYOCiuk2LI/AdTp76nF2DC3bFF9dk4qxj
 ybSRRXGp0KIExCf/4Ny6gVfbF9k6DcJ20qd1G/PQZ1wjb1UjaUFbxiXVtp2myiPsQzCB
 walNaq1/DM55K3vFYUuvMclUkzdbvCpoKqVTU9YAImeGdKTXhngnueKdtN9GDW08ciPA
 8J/FJtw5eyJMuwTYLWWcwbd1zG1ce9YV5c9DEEoJhFcFw1c2TWO0LJt6p6a5c1Mwu4Xm
 lWxxAvR/hGOUcNuQWtErmnItnLGmKUYWcjMqpng7BrgKWQWkQpTJBoU8rK+hHVMTBsm8
 25XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZcxSjrfWGPWTaTeRmDyXEQ9qFG5Wac9j8P6XAYTye8722zkEgMtU8LbPugbTt/lq5cxoa0NM=@lists.denx.de
X-Gm-Message-State: AOJu0YzTiyaiF24j5zCweVtbJmPNpDEUlmraJrWbCWVfEkKeh/pqLIox
 4RE03XJrzW2Hv83lbIJhd5l1m+aN5iy81UZcki+UpN7gl4kI+T/MxWo/H3XQugVbMVqA2ecKw6y
 gC2AicVs=
X-Gm-Gg: ASbGncuvTLJGsWtxvmj5fz8jEhqYYWjAnFun55C20go1r1uvbpAVWLQUg/XTz0oqawW
 U6o09tylhNRtmiLKdrhIpUbpZFYww1KW6xw6h+m0qKwCYhp7jj3zIzNyEGwa+286bWtoG1mAUks
 DYXQ9WwrEo70kiYSQ0TOe2JizIr3MblmTK+9O5/2f+EUyIdU/UNcrfmXUBXZ/okt8aY5w2he4lS
 HtBVetKmzG2wiUWrYs4deB+83RzzvNtJjR1XfqvUERSXAPv2vw4u6D1o+4dsO2pFo2TzX5bQDM4
 QFF3oTyt1Y9yCe7H4gxFYNEbBAYNIGo3/87sjxnwEoiSzXBgKnhqdwWALbWqoM+qQCVGrzNuHYE
 5OSk1ZFWtv1UMKiRoDEoNYJiOHEbp/E9oukU49WYfWmcONrFNTzkYE9zG
X-Google-Smtp-Source: AGHT+IGHE4vmc1uo2KrLaeTf/x6drtZukYQrPcrxqh9O5m6hGB8tIEMLXOBe+yUzy3bX7ETYI2E6tw==
X-Received: by 2002:a05:6870:b605:b0:2ea:7574:e243 with SMTP id
 586e51a60fabf-3110c1cd90bmr2121194fac.9.1755615790492; 
 Tue, 19 Aug 2025 08:03:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310abbb1d26sm3485902fac.28.2025.08.19.08.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:03:09 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:03:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: legacy image format on BBB / Debian (was: Re: [PATCH v6 8/8]
 Drop the special am335x_boneblack_vboot target)
Message-ID: <20250819150306.GC124814@bill-the-cat>
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
 <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
 <20250818141704.GW124814@bill-the-cat>
 <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CYnlCz/LZtWg1HaK"
Content-Disposition: inline
In-Reply-To: <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
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


--CYnlCz/LZtWg1HaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:29:29AM +0200, Sascha Silbe wrote:
> Hello Tom,
>=20
> Tom Rini <trini@konsulko.com> writes:
>=20
> > It's frustrating that it looks like Debian 13 is shipping with this
> > legacy option as the default, I assume for all 32bit ARM systems, rather
> > than any of the more modern options. I'll take a look at what the impact
> > is on adding LEGACY_IMAGE_FORMAT to the "distro boot" option so that
> > nothing else is missing this.
>=20
> flash-kernel has no way of knowing whether the boot loader used to boot
> will be the stock boot loader or the one shipped in the u-boot-omap
> Debian package (if installed and manually copied to SD card / eMMC by
> the user). Did all BBB rev C boards ship with an U-Boot version that had
> FIT image support? The oldest version I could find on the BBBs I have
> running and reachable via SSH is U-Boot 2015.10-00001-g143c9ee (probably
> shipped in 2017).

Yes, it's a choice of what the distribution is / isn't going to support
and require end users to do. And lots of people are opinionated about
it, and different distributions disagree on what's needed. I'm not even
saying Debian should have worked out the tooling for FIT (my thought
would be why not EFI for all the ARMv7a supported platforms, but I'm
sure there would end up being some other problem).

My frustration is what the patch I posted solves, U-Boot broke our
agreement at large at some point (DISTRO_DEFAULTS provides what common
distros use) and so here we are, Debian doesn't work.

> FWIW, the main README in the U-Boot repo only mentions FIT image format
> in passing (referencing a file that doesn't exist) and then goes on to
> explain the "Old uImage format" in detail. To a casual reader that
> suggests that the old format is still the primary format and that FIT is
> the more modern one that can be used for more complicated cases if
> needed.

Yes, we need to continue to work on removing the top-level README as
it's so out of date and https://docs.u-boot.org/en/latest/ is where we
have more up to date documentation.

--=20
Tom

--CYnlCz/LZtWg1HaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKSSKQAKCRAr4qD1Cr/k
CglGAQD8biwC3eYmzSAXEmLgkuASbBPqfuihU0fx1+zA2na31QEAxxB2PzhA/FGA
jHmelclbzPca5Bf2zETld5bTCxdIiAE=
=/W6K
-----END PGP SIGNATURE-----

--CYnlCz/LZtWg1HaK--
