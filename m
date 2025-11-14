Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE51CE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D96D83F54;
	Fri, 14 Nov 2025 15:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l9jM/opw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC0383EF2; Fri, 14 Nov 2025 15:22:11 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3D884107
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e80c483a13so1339699fac.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763130126; x=1763734926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8mgtTkxLXKs2XSncg0HXyw8TcAfcTiduqAYQHGanHbs=;
 b=l9jM/opwFp4+LSpcinG6qfKuqTg0AH+rIPtPDxArct/bZbecTD1SFp1blPjC0JwH2+
 Sf4xfyUcPjqam6/72GmFlEPuniHwRCqlI+/KiocpDW4CBtYwoimY3ROmscf/1bdUqoqs
 tr+qV5/n+7HybRypC2W7spjrtMVM8XmY84fko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130126; x=1763734926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mgtTkxLXKs2XSncg0HXyw8TcAfcTiduqAYQHGanHbs=;
 b=JdPYxyX9/ZqMGnWWhBpW2tpe1J16/E3boKBcb8iY/xH1+5VXYHycCSHPQeXws+833q
 3puKci5yh4AhJL46R4B75LOVPA7Bdt2LrDn9/BMcF+bUyw01MuaBSKMx9g3yzt4yktIw
 Rp74kY+OmibJ++E6AAgfnnccYypPGGGrtIPMxn+2hwNzfpgn+LuYFw8xKrYvMkErVpG0
 C8JxPykZg36Wck+vEVGXgqdr8LqZ/FhJtpVCludsUSXzvcIJiDgdqW8l7QN7RTyalHm2
 t47iUgA6sTOy9YPsXIOQGpxLCGCK+UIOjlT/sHII5dgCxCYXLWdk8sRVy4pqejWDfWur
 Kk6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8qUvbKg+ytgKtDpfaiiuN6lpc6XOsajo2rEsdO8xmC8vObpU+TKdEe0FRHjJYN0//PgtPoPw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj0kFX9CaXlAG68letkNz8xivXkGBCqaGrUyf0fE1tkQUjZ+DY
 eQcHJCqtkk8BVtz8EsDRVCLJJHQAnUaPTx5Gv3QXPkSHhInlxI1+XsNMS0mBg/Qi88Y=
X-Gm-Gg: ASbGncsaDeHhWCTZBHg87MDRs2WkGuCF1vhRV5uSFTdxWoSJEP1cug3CXX5uDLpxiyU
 AXZ92x8cBYKHMt5Wm3wCif2Hm46SpIKTkyxTIW09xWGxuwPGtf2kR4YoG7XNfILGo9uX/RcaHjn
 qUef7it0lfnFdVXVOP2Mp0HjiwoWl3LXXxaLVYs7NOavSFa3LGyFap6tsyFO3/YdRHmXnshzBZR
 v6/9qyCi2E+aEdfJnxuA33/Cv4cO1ZveqlkKLoWtfaAR5HdrTpQO7UqwxPyZxfON6mi9B3GBMoE
 LYmA5MrbWISGZoreUHq3e3WqTbx2AzHULKjQqaEe6zo+Fql1BPbl9+TYspuj5g5bg0ER1owjp5s
 IUfaqoJGusznQ6AHeRCV2znEW1X+wVXPE0aexRxT1nD9qKtKswJLBxD6BqZj1ip2R56zgpDpW7W
 13Fe+ncdK7cK5b1Ws9W9BD6fxFvS2XDANY/HqO2dc=
X-Google-Smtp-Source: AGHT+IFPQNqyrw9Wo2ZWvyLL/ud8Ha9EzM9GWnvdLlB77JR6kIQUs1RidknhDRx6ycUN3uMsB8twkg==
X-Received: by 2002:a05:6871:500e:b0:3de:51f3:b08a with SMTP id
 586e51a60fabf-3e869136a79mr1285504fac.39.1763130126482; 
 Fri, 14 Nov 2025 06:22:06 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ff9dfesm2750424fac.2.2025.11.14.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:22:05 -0800 (PST)
Date: Fri, 14 Nov 2025 08:22:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/9] test: cmd/fdt: do not assume RNG device exists
Message-ID: <20251114142203.GW6688@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
 <CAFLszTgy0enQW_G1rW0RDNVJa4TEK2fL-moY6RarRZ4xc_xH8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="27ggLuKNhu+Ck7Nf"
Content-Disposition: inline
In-Reply-To: <CAFLszTgy0enQW_G1rW0RDNVJa4TEK2fL-moY6RarRZ4xc_xH8w@mail.gmail.com>
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


--27ggLuKNhu+Ck7Nf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 05:44:08AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > In fdt_test_chosen() currently we test if DM_RNG is configured.
> > CONFIG_DM_RNG=3Dy does not imply that a RNG device actually exists.
> > For instance QEMU may be called with -device virtio-rng-device or not.
> > The current test framework evicts the virtio RNG device even if QEMU is
> > called with -device virtio-rng-device.
> >
> > In the fdt_test_chosen() check if a RNG device exists.
> > Ignore 'No RNG device' messages.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  test/cmd/fdt.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > index a36f2dcdda8..b950123b6da 100644
> > --- a/test/cmd/fdt.c
> > +++ b/test/cmd/fdt.c
> > @@ -10,6 +10,7 @@
> >  #include <fdt_support.h>
> >  #include <mapmem.h>
> >  #include <asm/global_data.h>
> > +#include <dm/uclass.h>
> >  #include <linux/libfdt.h>
> >  #include <test/ut.h>
> >
> > @@ -1267,6 +1268,7 @@ static int fdt_test_chosen(struct unit_test_state=
 *uts)
> >  {
> >         const char *env_bootargs =3D env_get("bootargs");
> >         char fdt[8192];
> > +       struct udevice *dev;
> >         ulong addr;
> >
> >         ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
> > @@ -1280,11 +1282,16 @@ static int fdt_test_chosen(struct unit_test_sta=
te *uts)
> >         /* Test add new chosen node without initrd */
> >         ut_assertok(run_commandf("fdt chosen"));
> >         ut_assertok(run_commandf("fdt print /chosen"));
> > -       ut_assert_nextline("chosen {");
> > +       ut_assert(0 < console_record_readline(uts->actual_str,
> > +                                             sizeof(uts->actual_str)));
> > +       if (!strcmp("No RNG device", uts->actual_str))
> > +               ut_assert(0 < console_record_readline(uts->actual_str,
> > +                                                     sizeof(uts->actua=
l_str)));
>=20
> But then this test isn't really making sure that the RNG code works.

This isn't an RNG test. That would be test/dm/rng.c or
test/dm/virtio_rng.c

--=20
Tom

--27ggLuKNhu+Ck7Nf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc7CwAKCRAr4qD1Cr/k
CuDBAQCDPy8PwKM7xG01n2s25sQT/YC/Jq7Z+AZwUksum4gHEQD7Bu8Y04lVYeCh
pZbogbhiCuOX2wltn9yTyOJ6/LInVQA=
=rM48
-----END PGP SIGNATURE-----

--27ggLuKNhu+Ck7Nf--
