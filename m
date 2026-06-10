Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257CCCD98C5
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F2584878;
	Wed, 10 Jun 2026 21:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="shtMIyT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58798489F; Wed, 10 Jun 2026 21:43:35 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7300841C2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so4715915eaf.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781120612; x=1781725412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IpZAHAs7w1aFe/X0snrVRswtIjLW6Y09ukkY6T4gFKM=;
 b=shtMIyT9X0GtHfBaY+0TJHbPRJGoon+mlLaeVqUFxQqrp88lAXd3qyMjjr6Mk/lGyq
 l/1+NaHpvE8Dssrh6Op3uALn4uSORxOn33HTtCHkAjfYMD93wS66rDz4xDfSk7w7AqHN
 SQudHmAQOTPY5IDjdiDmaJ2O5lgipP+FcWJ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781120612; x=1781725412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpZAHAs7w1aFe/X0snrVRswtIjLW6Y09ukkY6T4gFKM=;
 b=MpHOTUntCmUyz34JWvzGMbudIzq28ppd6O0akBziCDp1SfNS3tNbztxINjgMRrapMK
 Z6E/CvGjCMB9MD1Axx8n/52qRComqBPwVAi2oqTe2681049nklKTRjKs//BeNFfcLMmz
 w9cJvCzdYbBX4msVi/aO9UkTMczjOJTCtBFm+0i/5L43/4g6tmaFd1TuuZS44zCL0L+T
 04mWbCkbauD5k2ChPWBhV35S5knmzhtVzfuNN2F/WtqfvN3642VYBbYuZhBBcdTspfX3
 Higor1EfXOfcw6jgmNBHYwyvxC4zOF+wAeqvJQo+4Qo5wUlMq28Jh//Otblws58fBfuq
 pGqA==
X-Gm-Message-State: AOJu0YwuYtC0RxBl9ML36fbZi8Yq/0yF7VsNPUH/wLnW83AcLweInBC9
 HUakkVYpfOl3YafWAn89kcBrFv+X4f0AwNJoIGwVsNxnDce5yXttkMZe2FOX+VpGdP8=
X-Gm-Gg: Acq92OEQmOFauwdHyH7hxD7RHa4BNW1eksY/yd+LgYDg0dO/ycgQFvZEBU9FkOb7MUz
 bycVoDr7dDLmwnwJ89KTyYNoQzAZdBv4oOrhwkxSid4skZmSwFqtnWnvNTA3GIZg/iXygdHOBPG
 +vHIJp8/5P+n9KxKxY/HxUDfbXVQFwtyfP10EqaIEREzvrm0nIRLqvk0cHZJhnyREM7pghCGq9D
 Nc3eOmDSDskptGabN7+nqxShkXb4OwlVV4G3SOa0VlLIfRca+QfvhZFJcKCGxg6r572kNPGbMU3
 n+ZxjIGBCdtNoBbE3TqdJ9UazNpVkvAFXDB7IcwD7R4EmsyWYU9RYxpfCEL16h7KkB8OzNsuHok
 8DabJUs2PreUOzmGYICjA/pgGagNLNgWMV9gW3KAJfAIeZ8VOBzuaDPtXxtBYrBh7TZ4SRFodez
 6BxHxzUrSHf5oeVDK0F8tWXQNe/M2qkFbKy7TVarHb0hiCq6GCxiftMrChNIezeEFHdZWnwI2Xq
 7BNue/3VcX8u3E59KK+Cp7/+Q0+6I49HyTmQXk/xDj7XuTrr64CrlRhEvWP5BMFDhqOPD3t
X-Received: by 2002:a05:6820:1844:b0:69e:98c0:4bd6 with SMTP id
 006d021491bc7-69eac88f516mr5159716eaf.1.1781120612475; 
 Wed, 10 Jun 2026 12:43:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46298798sm13537962eaf.8.2026.06.10.12.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:43:31 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:43:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v4 0/3] allow control DTB to double as "FIT image"
Message-ID: <20260610194327.GF382693@bill-the-cat>
References: <aCmpHnZEXcpacr17WR2tm6Q0j2ueBUlvPHGCKvwwR9vxbxa_MS7Z_sw8J_URvO7dCZ_he6LLPMS7cYo6aiEwfw==@protonmail.internalid>
 <20260602213013.558064-1-rv@rasmusvillemoes.dk>
 <87zf12pv17.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOw0m/hU31S4iQpV"
Content-Disposition: inline
In-Reply-To: <87zf12pv17.fsf@rasmusvillemoes.dk>
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


--YOw0m/hU31S4iQpV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 12:08:36PM +0200, Rasmus Villemoes wrote:

> Hi Tom
>=20
> I know it's only been a little over a week, but can I ask you if you
> plan to apply these to -next, or if there's more for me to do?
>=20
> I have tested them on some real hardware and they do seem to work as
> advertised, but I'd like to backport them to our 2026.04 branch and test
> across all our boards in CI, to give the feature as much testing time as
> possible before 2026.10. Which I can of course do as-is, it's just that
> I really prefer to only cherry-pick stuff which has a stable sha1 and is
> in or heading into master.

This seems fine, yes. I'll pull it to next a bit sooner than I would
otherwise as well. I've got a few things in queue right now before
getting to this series.

--=20
Tom

--YOw0m/hU31S4iQpV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaim+XAAKCRAr4qD1Cr/k
Cg+RAP4x66p+vSjZYi6NThhLPAB0XKkP1L95jakTwkN0aGmmQAD+InTJAMPfa3v/
BCZHi1qFspIP6B1xz1aQJXI1behz2Qc=
=0Lb+
-----END PGP SIGNATURE-----

--YOw0m/hU31S4iQpV--
