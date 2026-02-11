Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB0EE9E31E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B886583A47;
	Wed, 11 Feb 2026 15:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s3aGS4Ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFB183CE3; Wed, 11 Feb 2026 15:18:35 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7601683015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cfdf0c8908so4007364a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770819512; x=1771424312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SgGbeAyKN1pVelDoYtvykQ31KnrFjAiHjhNQk7VKoGI=;
 b=s3aGS4IifrVVPrggTKmrZkJm6amHCbK6FPEN3eO47CeAn2uqPz4cZPQNsAylvGjs62
 Is+4+bxDVtRTr/rQJnaRH9LrIWtM+GpVUNl5XbVVoUjGBAizslknN7Q9RFGlSeY/WqMZ
 gdr9qqOY8rl1fiJtJ2YIhRc9+c3mUyCM7DPnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770819512; x=1771424312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgGbeAyKN1pVelDoYtvykQ31KnrFjAiHjhNQk7VKoGI=;
 b=cdF/g0KnIEqQ3IzsyvfECAimPIexUBQ28JU20g6eWxBbruFhIb8SIxFSBQ0B4SY/J4
 pxT4oR43B9tUadnGVnWa+a2Sx51gAMI7eAV1cz9XTe6wpwQsz5QbcIinw6vQSZ9calz1
 cU3gVW9bXEVJSvnnsMjlX7x2Hc9kLTLCnhrkzlUMVOBzgyPLezsYwSCYQLuY2v6n7wXs
 G5Fnibqf0u+/0B3oTBLtrbelr/tQ6cfT6CuRtqCOWUZra9xkIKNoYs7Xo1gBmH/MNlN8
 JFJSxtS5B97wa50CdCButy+Mp16Ww15fzZ5hlcR/GE9PVelOtUwHFJUfo/otGHLkDrf1
 yE9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ADwP0iFElLAvP4zlyChxpG561cEYJ+zkLO7yxMAlaEz9p+wzJW7DjZJnxiYYbY2QYYh/Avg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8hNTQrvOzCsRz6qq+/ZBdJUBTItj1ItFucZbhoUkR3jQcb2Ao
 3d7yEwGk+Ep/m2e7MOCePHqtyDuKJEzw5feZ4WqQHzQP2Zf3wLdttqzsvkng4M1LybI=
X-Gm-Gg: AZuq6aJYokjZMCIC/zAewNsXC/hfjrNyC72+2DRW0aKZgOZJj82l+H8UfRxxFDhbDUM
 aDvQmk5VV7NK8oZswFJlpZ/7MS7RzOIviwYXisC5/cbCT5hJzIXgDpUq0VxHN3dAOV/B9QO+mL+
 v1txBluKbjKb4Lr4PXcO8pgOY1jgWrGyZy9SygPpmZHV6No/D802jkRlO6TiX5aVEDCr49SQ8Sa
 jE9hxKuCba4h6GQW4z6AuRjOQAFEbCFEKx3fjUOlmgDbyBbPSDQdftsqwKydPBPLCt+puD5A24w
 GuPCWi66a2fbx8Wf9prujiH+1Wh3USL0Z/7l+S5CHpqCvWCXymxb4sayW+QatJ5UQzgAM9Xt6yx
 qDMJWgnJiI+qT6rCmDx9YvXFUfYpBsrPg7d14wZR0yHyxYN0RzYgjM4YxTZEeqAr+djIY7bTLqu
 Ei3jcLHDkK0YFPSwAsCXM47aJvcM9d8eDZnhhzP6rLyfbfDcMeu1MYa9R6HphSt/nyRKK3ZRZ/R
 YFt4mYJ366a/yzE1Mi8kLSkGCcFqu5R5HWqrXmsiu2nALDY1E8=
X-Received: by 2002:a05:6830:6487:b0:7d0:2e9e:3984 with SMTP id
 46e09a7af769-7d4a6d61c24mr1033614a34.4.1770819512195; 
 Wed, 11 Feb 2026 06:18:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm1293031a34.14.2026.02.11.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 06:18:31 -0800 (PST)
Date: Wed, 11 Feb 2026 08:18:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 E Shattow <e@freeshell.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
Message-ID: <20260211141827.GA2747538@bill-the-cat>
References: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
 <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tl9mTS8uVEwtNL+d"
Content-Disposition: inline
In-Reply-To: <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 11 Feb 2026 15:55:26 +0100
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


--tl9mTS8uVEwtNL+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 02:34:59PM +0100, Frieder Schrempf wrote:
> On 16.12.25 10:16, Ilias Apalodimas wrote:
> > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> >=20
> > Our last sync with the kernel was 5.1.
> >=20
> > We are so out of sync now, that tracking the patches and backporting
> > them one by one makes little sense and it's going to take ages.
> >=20
> > This is an attempt to sync up Makefiles to 6.1.
> > Unfortunately due to sheer amount of patches this is not easy to review,
> > but that's what we decided during a community call for the bump to 5.1,
> > so we are following the same guidelines here.
> >=20
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased=
 on -next
>=20
> To me, it looks like this is breaking "make cross_tools" in some way. Or
> am I missing something?
>=20
> With v2026.04-rc2:
>=20
> > make tools-only_defconfig
> > make cross_tools
>   UPD     include/generated/timestamp_autogenerated.h
>   PYMOD   rebuild
> tools/Makefile:359: *** insufficient number of arguments (1) to function
> 'filter'.  Stop.
> make: *** [Makefile:2191: tools] Error 2
>=20
> If the problem is not on my end, then I would have assumed the CI would
> be able to catch it. But "make cross_tools" is not part of any test, righ=
t?

It is not, but we should add it to the tools-only CI job I think.

--=20
Tom

--tl9mTS8uVEwtNL+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYyPsAAKCRAr4qD1Cr/k
ChNrAQC+HhFrVfqKY435OOJNNXASjBHlMHJBuZypIBZhMlBP/QEA2pnmiwbFR48T
8G19rBl9Lrg4zCtUOX6mGDERo5S0MAA=
=oqoT
-----END PGP SIGNATURE-----

--tl9mTS8uVEwtNL+d--
