Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A0C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 13:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E5D81FEE;
	Fri,  6 Jun 2025 15:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LD/Yz7UY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2778682977; Fri,  6 Jun 2025 15:51:03 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74303800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 15:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-40337dd3847so1420555b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749217859; x=1749822659; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N/M+suNnp2rY+LoB6C+piu5Ej1u2b4seVqBXuqb+KP4=;
 b=LD/Yz7UYrS6xYYyWuhP0a61M00ll8KNuVIWDylJ9UCX1yjAJNDWgqcojqrtUuZdCp5
 7Mfh1voLHyEvJAIkGYBvmHyVxdH1ZTTsy6+7i4i4Axd779ewONSq862iecCP0ujQhUMF
 lUWjWCwLpD14x98SbxAgHrT8FRzb6+rf5bSio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749217859; x=1749822659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/M+suNnp2rY+LoB6C+piu5Ej1u2b4seVqBXuqb+KP4=;
 b=ZY3M3somg2ub9hEFhTMBeOMx5M6mEqQtXk07SWJMwOEPpfd9ltLLHQUscKvhkaL7BA
 4+rUYCXFbRo3SXJoIz5xDUWX/ZG1Z5ruE+ztZov+R0vsIEDo0VQvAlEucASG1OrOJuiP
 X1RMBUzklFX10whnJpjW/VshIYyU/dHZnaQ7vgtIaE2DSk1yG32p6wO8n6CvWSno4t0W
 cTEPgROoIkDmbywBtwvtm64ya7c/XylXVDDhNnaPE2OvbbvBrqtqXBBYWXfWOUsVLxQY
 5wlBuz72EBCYvB0yZnAkfByeqoHDHofwrgAAMyoieDp6yfcqUvvPWyF9bGEsj1Ot7kIb
 JRCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWM48iPSKZPgKicXjmzROrceRGC6/XcgWb9ubPagMYUfMHd+ikH+Rz4kP+djCrtapjB69mm88=@lists.denx.de
X-Gm-Message-State: AOJu0YxzwkuE5ks/pTH8vRi+yJ0XnGwM0WQ2jBE8W4U1GfjoXTsgozEf
 mmVEawB17NDLTrNsC263UIJHSvIjo2DcRzbUGglynB6zooPkFB88mgp/xwVX25/x/BXnD3kRpD6
 /QkAu1DM=
X-Gm-Gg: ASbGnctMNcFs3VzS6V65aoGbUoId9tjrJ3ehsEUJVuuWd4KSY4cyg+ikaw/fFUQFtpf
 WY0VrRelDt2LpuBzY0rRHKpgpjutriIVJjxf2y9QYbd8zi88MQY47ks9WrY69NTikgsa4wBUGLN
 A8RtwKIibdLZnLbMe6cq3P+jUUcVUxvCJPHL/It9+s3cLAkcgfXALVhhowVXpD4rHcTYPirq8kG
 es3cKEww/0rLzsTibqMDqUDWcNcSEBX2HfGm1q4Eau/IsjR67oZz7jZ/3A/nFaykC9MWvSPV3+G
 CJnoKdMl+BDmeBFHXRtop3e08qmNO3C0GD/FqaVaV6KHgSry9eeJUchEKyaOCDmYI8EqLpoJRwc
 8DDbZbB9+YdBs
X-Google-Smtp-Source: AGHT+IGM+u0dgkdbmZoQ4mTDCmZ9Wp8iTLAaG8z/e9ZknevaQg2HR8427Y1dAPvuZge37q8FGW4rYw==
X-Received: by 2002:a05:6808:dd0:b0:406:4e0c:9bfe with SMTP id
 5614622812f47-409050dc4ebmr1819313b6e.22.1749217859057; 
 Fri, 06 Jun 2025 06:50:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40906a0fdcasm297460b6e.39.2025.06.06.06.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:50:58 -0700 (PDT)
Date: Fri, 6 Jun 2025 07:50:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <M.Schwan@phytec.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Message-ID: <20250606135056.GK1382132@bill-the-cat>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <CAFLszTjWqhg1baNSF5rLqjYdoDNyjmy=5hXXq5AzwNF_QSfAQg@mail.gmail.com>
 <421b73636b30472302e5751e9c001ffd4e6b4eb4.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MVYpImcZfUMrtyIi"
Content-Disposition: inline
In-Reply-To: <421b73636b30472302e5751e9c001ffd4e6b4eb4.camel@phytec.de>
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


--MVYpImcZfUMrtyIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 06:59:05AM +0000, Martin Schwan wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>=20
> Hi Simon,
>=20
> On Thu, 2025-06-05 at 11:29 -0600, Simon Glass wrote:
> > Hi Martin,
> >=20
> > On Wed, 4 Jun 2025 at 06:16, Martin Schwan <m.schwan@phytec.de>
> > wrote:
> > >=20
> > > This series implements a new bootmeth for RAUC A/B systems. RAUC
> > > (Robust
> > > Auto Update Controller) is a lightweight update client, providing
> > > "Safe
> > > and Secure OTA Updates for Embedded Linux". See the following links
> > > for
> > > more information about RAUC:
> > >=20
> > > =A0 https://rauc.io/
> > > =A0 https://rauc.readthedocs.io/en/latest/
> > >=20
> > > PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
> > > default way of updating embedded devices based on PHYTEC hardware.
> > > So
> > > far, the logic selecting the correct partitions and files to boot
> > > was
> > > being implemented in the U-Boot environment. While this is a
> > > straightforward way to do it, adding and supporting new platforms
> > > became
> > > somewhat tedious and is platform-specific. The introduction of U-
> > > Boot's
> > > "Standard Boot" provided a convincing alternative, promising a
> > > simpler
> > > and more portable way of booting, even for RAUC systems. This led
> > > me to
> > > implement a new bootmeth supporting RAUC A/B systems. Note, that
> > > this
> > > new bootmeth is not proprietary to PHYTEC products and is designed
> > > to
> > > work on other hardware with a RAUC A/B system, too.
> > >=20
> > > The bootmeth currently only supports symmetric A/B partitioning
> > > layouts.
> > > E.g. A/rescue is not (yet) supported. The partition indexes and
> > > default
> > > slot tries can be specified via configuration options.
> > >=20
> > > For now, the bootmeth_rauc uses a similar approach for loading the
> > > Kernel and device tree as the bootmeth_script, in that it requires
> > > a FIT
> > > containing a U-Boot script loading the desired distro. It could be
> > > possible to support booting without a script and load the Kernel
> > > and DT
> > > directly with this bootmeth, but I found the script method to be
> > > very
> > > flexible for now, in letting the distro decide what to load.
> > >=20
> > > The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1]
> > > with
> > > BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
> > >=20
> > > Supported boot devices are currently only MMC devices, but it
> > > should be
> > > possible to add SPI flashes in the future.
> > >=20
> > > To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
> > > board, you need to adjust the boot files to include the
> > > boot.scr.uimg
> > > containing the distro's boot script and set "optargs" to
> > > "${raucargs}"
> > > in it. Also disable any legacyboot in the U-Boot environment and
> > > simply
> > > boot with Standard Boot:
> > >=20
> > > =A0 bootmeth order rauc
> > > =A0 bootflow scan -lb
> > >=20
> > > Regards,
> > > Martin
> > >=20
> > > [1]:
> > > https://www.phytec.eu/en/produkte/single-board-computer/phyboard-poll=
ux/
> > > [2]:
> > > https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yocto=
-Ampliphy-i.MX8MP-PD24.1.2/
> > >=20
> > > ---
> > > Changes in v3:
> > > - Invert if-statement check for setting default value of
> > > BOOT_*_LEFT env
> > > =A0 variables. This would falsely trigger an error message before.
> > > - Link to v2:
> > > https://lore.kernel.org/r/20250602-wip-bootmeth-rauc-v2-0-9d238413148=
6@phytec.de
> > >=20
> > > Changes in v2:
> > > - Remove LOG_DEBUG from boot/bootmeth_rauc.c
> > > - Reorder asm/cache.h include to be last
> > > - Do not check for RAUC-specific files in the rootfs anymore. This
> > > does
> > > =A0 not work on encrypted root filesystems and is not a stable
> > > indicator
> > > =A0 for a functioning RAUC system.
> > > - Add a description of the term "slot" in the corresponding private
> > > =A0 struct.
> > > - Remove boot tries left from struct distro_rauc_slot. The boot
> > > tries
> > > =A0 are read directly from the environment, as that's the only
> > > correct
> > > =A0 source RAUC is relying on.
> > > - Remove the current boot_order from struct distro_rauc_priv, for
> > > the
> > > =A0 same reason as above (env is correct source).
> > > - Add function for retrieving a slot struct, to ease finding the
> > > right
> > > =A0 one when e.g. iterating or getting by name.
> > > - Fix multiline comments.
> > > - Fix various if-statements which were explicitly comparing to 0 or
> > > =A0 NULL.
> > > - Free various, temporary instances of allocated string lists.
> > > - Set default env values for BOOT_ORDER and associated BOOT_*_LEFT
> > > =A0 variables. These variables are mandatory for RAUC to work.
> > > - Use calloc() instead of malloc() for allocating the private
> > > slots.
> > > - Use config options for configuring the partitions and default
> > > boot
> > > =A0 order, instead of setting them via the U-Boot env.
> > > - Use bootstd_get_prefixes()'s return value and check all available
> > > =A0 prefixes for the boot script.
> > > - Add a proper boot order selection logic for the rauc bootmeth,
> > > similar
> > > =A0 to the previous environment scripting, with fallbacks and slot
> > > try
> > > =A0 checks.
> > > - Introduce config option for resetting all slot tries in case they
> > > are
> > > =A0 all zero. This may prevent a system from locking up in the
> > > bootloader.
> > > - Rename env variable "mmcroot" to "distro_rootpart", to be in line
> > > with
> > > =A0 "distro_bootpart".
> > > - Change the bootmeth flag to "global", as the rauc bootmeth does
> > > not
> > > =A0 work for individual partitions.
> > > - Update documentation accordingly.
> > > - Link to v1:
> > > https://lore.kernel.org/r/20250129-wip-bootmeth-rauc-v1-0-6308e732f31=
4@phytec.de
> > >=20
> > > ---
> > > Martin Schwan (2):
> > > =A0=A0=A0=A0=A0 bootstd: Add implementation for bootmeth rauc
> > > =A0=A0=A0=A0=A0 doc: Add description for bootmeth rauc
> > >=20
> > > =A0boot/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 51 +++++
> > > =A0boot/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 1 +
> > > =A0boot/bootmeth_rauc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 432
> > > +++++++++++++++++++++++++++++++++++++++
> > > =A0doc/develop/bootstd/index.rst=A0=A0=A0 |=A0=A0 1 +
> > > =A0doc/develop/bootstd/overview.rst |=A0=A0 1 +
> > > =A0doc/develop/bootstd/rauc.rst=A0=A0=A0=A0 |=A0 56 +++++
> > > =A06 files changed, 542 insertions(+)
> > > ---
> > > base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
> > > change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
> > >=20
> > > Best regards,
> > > --
> > > Martin Schwan <m.schwan@phytec.de>
> > >=20
> >=20
> > Great to see this. Could you please add a test, e.g. to
> > test/boot/bootflow.c ? Let me know if you need help.
>=20
> Thank you! :)
>=20
> I will have a look into adding a test for it. Sorry, that I didn't make
> it for the first iteration, as you mentioned it previously. Will it be
> okay, if I add this in a separate patch?
>=20
> I'll probably not have time for this until end of June, as I'm on
> vacation the next two weeks. But I definitely have it on my agenda.

We can add the tests in a follow-up, that's fine. I'm assuming you'll be
putting this in to some test framework for practical testing internally?

--=20
Tom

--MVYpImcZfUMrtyIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC8kAACgkQFHw5/5Y0
tywtlAwAh4GSFcG9iuoOOY7K1UhfbzY5jwPYOwx5KlxtVViZqFY0WlSx/ZiUSE++
4FnbPnICixCF7378oKkQofvasEPC82Geugmcp3RNHQazNv0rTDXiMeY/HvxdWjl9
IuuuSVR2ydohJbLBNtNzbLq7RHze8b3U64IeeVzpsM0KHMsqyC3vmwGdRdqAEF1a
6C1pL7GWALHx/SBbh6Icdfi+wFpMaqrE0M4oS+7LAoeMxT37mkZQYUztuf0aH35W
AKZ9b+mW5gh/GBeAw9Spg21jTBm7LpjkmAP/tj46IRpR6l6Dl7haCJOy+vht93+/
ncVhNswzARoXawOuNtuvkPB1ojZRkkBQa9CI0RV0TsNvHlsqGj4gJeTYWlgixL0c
Ev0LrdBYO3yi7cnsrbCA0usdwc1mtZE6JCSj0s8Poorh9ciKffPB3wO5Nlrsv6pf
MgFhqMsxkw+9q49Ne+DR9ceR2XbZ5aCUxsKOQ+s4tl0/QQiPZtKj1YCDGywwdef5
hOh9gpVM
=TjiG
-----END PGP SIGNATURE-----

--MVYpImcZfUMrtyIi--
