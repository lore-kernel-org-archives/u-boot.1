Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDCFC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 14:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAEFC8643D;
	Wed, 30 Aug 2023 16:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AtK7STlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5FE80771; Wed, 30 Aug 2023 16:23:02 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F7C8646A
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-579de633419so63804677b3.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693405378; x=1694010178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIWHXHuoajwOHo9k0jU4x+DOstBMTiM8u9wQZGt6qJA=;
 b=AtK7STlX79OLuWCqLxhvaWmThBhrpNwITTXGF/2iX2kBME10VVxbkIZhToxARuD5mp
 EoG6UMA5S5XPfGcGU78XxsLroyC2Otkfuxji4xX7BVHIe9stpj/cgzHXyHV4oays6YS5
 K+fLPGsGXAKsYx89ep2n06gWBus74L5C1mYKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405378; x=1694010178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIWHXHuoajwOHo9k0jU4x+DOstBMTiM8u9wQZGt6qJA=;
 b=f6OhZBKJtKuvRsPD66CBNTfielMWEu2R0MRg8ilU+gbw3Kdkl6xnAb6vW76sQxyYiv
 2LDn+PA6hnbDt4QxIPb2JNtKHqApG7PcA/whnkDegDOe46Y2MOuxG6UJcYEiWqgTrQJg
 bW2fkvDGInfMJdw5EnrXU0sVMoP+Z2zBrffVY8sf1Yx15uNvG6g3C5NGKHAGrv+PqKkF
 Pf9PXeBUg4mrTNuazGO8fH3AuFW8CpxQyKc7M5U5C18LaN6Pko8gC75QvSNRjiy0oXcc
 C/BjFfMQY0qS7/WEM1dql9w+MBMGG7XFBYI37G3FKNYpfGxPqTbuCM07vEtCIgFEgGPC
 mX8A==
X-Gm-Message-State: AOJu0YwYl+A6AJxXyC9CCyA7yflquUINZiOawSWtMWrcO+qZEv5l9d9v
 FSB+0iUjDsKHAtHqSH/1jlU35g==
X-Google-Smtp-Source: AGHT+IFvmJenC6vzrUhDelwGRGAd3+S/ihPYOqq0VNMjj45kCB5+2U1I+tfCu57SAD0lr1ySVn4BLg==
X-Received: by 2002:a81:6203:0:b0:583:741c:5fe6 with SMTP id
 w3-20020a816203000000b00583741c5fe6mr1905212ywb.52.1693405378083; 
 Wed, 30 Aug 2023 07:22:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 fc2-20020a05690c314200b0057a67df3308sm660630ywb.101.2023.08.30.07.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:22:57 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:22:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>
Cc: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Message-ID: <20230830142255.GB3101304@bill-the-cat>
References: <20230829221457.101469-1-afd@ti.com>
 <20230829221457.101469-3-afd@ti.com>
 <20230830123151.rp7wkhi5m4leg6ny@ravishing>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aZvLMXNQgqrAUA5t"
Content-Disposition: inline
In-Reply-To: <20230830123151.rp7wkhi5m4leg6ny@ravishing>
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


--aZvLMXNQgqrAUA5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 07:31:51AM -0500, Nishanth Menon wrote:
> On 17:14-20230829, Andrew Davis wrote:
> > Add am62x_beagleplay_r5_defconfig for R5 SPL and
> > am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.
> >=20
> > These defconfigs are composite defconfigs built from the config fragment
> > board/ti/am62x/beagleplay_*.config applied onto the base
> > am62x_evm_*_defconfig.
> >=20
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  configs/am62x_beagleplay_a53_defconfig | 3 +++
> >  configs/am62x_beagleplay_r5_defconfig  | 3 +++
> >  2 files changed, 6 insertions(+)
> >  create mode 100644 configs/am62x_beagleplay_a53_defconfig
> >  create mode 100644 configs/am62x_beagleplay_r5_defconfig
> >=20
> > diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_bea=
gleplay_a53_defconfig
> > new file mode 100644
> > index 00000000000..ad708e15397
> > --- /dev/null
> > +++ b/configs/am62x_beagleplay_a53_defconfig
> > @@ -0,0 +1,3 @@
> > +// The BeaglePlay defconfig for A53 core
> > +#include "configs/am62x_evm_a53_defconfig"
> > +#include "board/ti/am62x/beagleplay_a53.config"
> > diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beag=
leplay_r5_defconfig
> > new file mode 100644
> > index 00000000000..276b1f81a3e
> > --- /dev/null
> > +++ b/configs/am62x_beagleplay_r5_defconfig
> > @@ -0,0 +1,3 @@
> > +// The BeaglePlay defconfig for R5 core
> > +#include "configs/am62x_evm_r5_defconfig"
> > +#include "board/ti/am62x/beagleplay_r5.config"
> > --=20
> > 2.39.2
> >=20
>=20
> my only complaint is that if we add lets say
> board/ti/am62x/dfu.config, Then:
>=20
> R5:
> 1. am62x_evm_r5_defconfig =3D am62x_evm_r5_defconfig
> 2. am62x_beagleplay_r5_defconfig =3D am62x_evm_r5_defconfig + beagleplay_=
r5.config
> 3. am62x_evm_r5_dfu_defconfig =3D am62x_evm_r5_defconfig + dfu.config
> 4. am62x_beagleplay_r5_dfu_defconfig =3D am62x_evm_r5_defconfig + beaglep=
lay_r5.config + dfu.config
>=20
> This information can be in a single txt file Rather than have a
> defconfig file for each combination.

I know Andrew is trying to do what Simon's asked.  But yes, this is why
I don't think the right approach is to have some file that says "here
are all of the valid combinations".  We aren't going to be breaking
"make am62x_beagleplay_r5_dfu_defconfig local-fragment.config" in the
above example. And we don't need every possible combination in CI, we
just need to make sure unique paths are tested. So long as something
builds all of the dts files, the Tegra example in-tree now is fine
because we're checking all of those.  The beagle examples here too
should be fine.

--=20
Tom

--aZvLMXNQgqrAUA5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvUL8ACgkQFHw5/5Y0
tyxLYQwAp8k4u5NGJoC08yoiPtUSb47N0GuVE2A2Ojf5TR5qnOb18w6ZNLqUWC85
IrGSZKFAjicq0dOc/3reJu4er/Axxfu0Mt3hwSDwb4Ge6i33WkpIiWeq850wUWc+
QaUoL03XER5/4tiImFQE3ylcDuevSl6QSnc9U/da2Gi1KqjT9IbzyWaIPYwfA3Vd
b6pOcFt4u4MNZJHQmcYZfqYOcX69SSNRR7H9ozZuZap5PM8xuSVTV7DxvYylb/bI
WBeXuZ8etn24DBVVFvrVt0BDPSDwKCGh9W/SMtz7BCy0YmFcmhir6r0aNzJPrveZ
/q3jEtN+0QjX9GD0ORXgfkRk9d821DYvjGIp3pTSNKwV62Lbpg/kjtCqXmJ0r5mC
yhlvrBNf6HC6MzNiybUAFO7WUqo8yGP4Q/WT0CAeTm7HK6q6KOL05oAkv9q15ZYP
3TQLrXXnVYVMJjZCH3Ne4Wb9cq/kMo0bH3c0pDtWN7KR1XfhgbsCI0cdBGKOJSLr
1uDtKnBd
=Klpm
-----END PGP SIGNATURE-----

--aZvLMXNQgqrAUA5t--
