Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC82C0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413ED8743C;
	Fri, 20 Oct 2023 15:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OXvv01BD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B14B86F42; Fri, 20 Oct 2023 15:55:25 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F916874B7
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7c08b7744so8844137b3.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697810118; x=1698414918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X6Of/RtUzSXxybJLfO+776Vg/EKFqDZFbl90vk/vbL0=;
 b=OXvv01BDFRisCCt/10rgxTgsW0Z+fwMbtSw8yWRfRWw4MGcJ3eaXSVHCmRY9WlEgY3
 +Zw5tZ/Og0Znwci9kYFSxWwjgSC0R97K3BnZtLCpcCmqowFqHCeNw+K0l0BaICcgpzyw
 tm36cjHOiSMixK71PjoDMWkWWnx5eVSYYFmZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810118; x=1698414918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6Of/RtUzSXxybJLfO+776Vg/EKFqDZFbl90vk/vbL0=;
 b=HPc2uOCtV7sOfBXIS3zTO/lk+7TRKop5aVfqzn8p6WzYQlta9OM3J5CxctsyNH8uE8
 Crj7cyHNdwNMh+rRvOVXTcJ3TYEH9044hN9mnU4CGO8h6MUjDqhAxj1J8ELOczl+gtKm
 POquUyoqlUZqCiBhk2LUQGpaSdyQQlqVMkHg/m2qgY3MFP6ejrdxh1Qn5pUPP5ZgN8xQ
 J20kgzrAFITeoA4OwwHbqE3jJ1PK9MmMIyIdQWaeM0ztF8ApAkkEDAity6fgkhye0zTh
 mSR2A5gupENpLaCLqkFJM3aWKPEUP8Ur10nSoLd4GzkLKzG2N76NA8gRwpQJRRGxDGgA
 5wLQ==
X-Gm-Message-State: AOJu0YyCCUZ9KbLztI7JxFGAZ1pVOKeXQ/FijohK6kz61xgmCUt6Z/Fx
 IY4j9l2Uj10JFntCcS6E4Syo5Q==
X-Google-Smtp-Source: AGHT+IHJNUS7+Qb5lqcq/n/vVaF3yoMFqrbmOAaZSbjs+W5s2BBh0s5NKIOJAQxzjLTzQ1zDelZ7Hg==
X-Received: by 2002:a81:4983:0:b0:5a7:b515:ae47 with SMTP id
 w125-20020a814983000000b005a7b515ae47mr2210394ywa.9.1697810117757; 
 Fri, 20 Oct 2023 06:55:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 w74-20020a81494d000000b005a206896d62sm681228ywa.111.2023.10.20.06.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 06:55:17 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:55:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231020135515.GG3119521@bill-the-cat>
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZbZcGFvRCCGlM6S4"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
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


--ZbZcGFvRCCGlM6S4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 06:21:33AM -0700, Simon Glass wrote:
> +Doug Anderson
>=20
> Hi Heinrich,
>=20
> On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 19.10.23 15:55, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> On 10/18/23 05:33, Simon Glass wrote:
> > >>> Hi Heinrich,
> > >>>
> > >>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> > >>> <heinrich.schuchardt@canonical.com> wrote:
> > >>>>
> > >>>> Forward and backward compatibility of Linux kernel device-trees is
> > >>>> sometimes missing. One solution approach is to load a kernel speci=
fic
> > >>>> device-tree. This can either be done via a U-Boot scripts (like th=
e one
> > >>>> generated by Debian package flash-kernel or by a boot loader like =
GRUB.
> > >>>> The boot loader approach currently requires to know the device-tre=
e name
> > >>>> before first boot which makes it unusable for generic images.
> > >>>>
> > >>>> Expose the device-tree file name as EFI variable FdtFile.
> > >>>> This will allow bootloaders to load a kernel specific device-tree.
> > >>>>
> > >>>> The variable will not be exposed on ACPI based systems or if the
> > >>>> environment variable fdtfile is not defined.
> > >>>>
> > >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
> > >>>> ---
> > >>>> v2:
> > >>>>           Use a unique GUID to enable future U-Boot independent
> > >>>>           standardization.
> > >>>>           Do not try to add the variable on ACPI based systems.
> > >>>> ---
> > >>>>    include/efi_loader.h       |  5 +++++
> > >>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > >>>>    2 files changed, 35 insertions(+)
> > >>>
> > >>> I was too slow to reply to v1.
> > >>>
> > >>> Does grub load the DT? I was assuming that U-Boot would pass it on?
> > >>> What is the interface between U-Boot and grub?
> > >>
> > >> The device-tree built into U-Boot is often out of date and not usabl=
e to
> > >> boot current Linux. A single device-tree can be loaded by U-Boot from
> > >> file and passed on as EFI configuration table. This device-tree may =
not
> > >> be compatible with all kernel versions exposed by GRUB.
> > >>
> > >> GRUB provides a devicetree command. It is disabled if you use secure
> > >> boot. At least in Debian and Ubuntu GRUB invokes the
> > >> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
> > >> fix-ups after loading a device-tree.
> > >>
> > >> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> > >> devicetree commands to the boot options in grub.cfg.
> > >
> > > Thanks. I wonder if you could document this somewhere? It seems like
> > > there are a lot of options and it is quite complicated.
> > >
> > > Back to the question, I suppose you are expecting grub to load the DT
> > > using this filename? But why doesn't U-Boot load it instead? It seems
> > > very convoluted.
> >
> > A separate file of this name exists for every kernel version installed.
> > The loaded dtb must match the kernel. U-Boot does not know what kernel
> > version will be chosen in GRUB. And for a generic image GRUB does not
> > what board it is on.
> >
> > >
> > > Also, can we test this interface?
> >
> > Neither the sandbox nor QEMU have environment variable fdtfile. And we
> > don't create the EFI variable with ACPI as used on the sandbox.
>=20
> I worry that this is creating another interface that some poor sod is
> going to have to deal with in the future. Is this part of the EFI
> standard?
>=20
> We should really be using the compatible string to choose the
> devicetree. Why are we using filenames at all? What is the
> relationship between the compatible string and the filename? Is there
> a lookup table, or should we create one?
>=20
> The correct way of doing this is implemented in U-Boot with
> CONFIG_FIT_BEST_MATCH. Can we mirror something like that in grub, etc?

I'm adding Peter here as well because we spent a good chunk of time
yesterday digging in to issues that turn out to be, in short the patch
to make Fedora load the device tree that matches the kernel be loaded
wasn't in the actively used path anymore.

So we continue to be in the place where the hope is that in a few years,
platforms will ship with a device tree that the OS can use, but that
reality is generally not there yet.

--=20
Tom

--ZbZcGFvRCCGlM6S4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUyhsAACgkQFHw5/5Y0
tyxerQwAqJno8Wc2iAMxVslsqOZ43MdeGYWhXD/uTAKVyVgpSRjoMUqEmpMhAR4S
AzFd3yh0GZH9mSjT3eQJUAbYFwrxMFM0FN2Bh53MeAUdUxKMRPa8PaPYfNJZ6oUX
xHH5ir6Bnu+abRqvM7c+KHr2THq0OQpunPwVpaRpnXFJIB4H8gvShm5Mh2nQ5alp
UlUp4tc5FKYEz9yKL3dO221nOpOn1QgxUiNs1UstiguL6C07V5Iq9Fovnj/evXVO
UlMeOOAbUcszi74m4+0hlimhakwBgYgEnI35RzyCKooDf05VX/PeVq7vwmAERuNC
RJwrRjiKL+ewH3X8cuoO2DgbJpMqT4IiDHsFFdPPuRNoTaCnC1gzGdqx+S3rzh5i
x9CMlQjYGOpmdTMeDHASV2jEaMgo/vCOYKtIdVKwL1fz4YdmHxnvhZXjaK9k5EK9
FNdCcOigPtrvF/a9AcfEoeFrHAaUgODVPe0Q4PCiY36ueEQUtXG2l4TozDEniMWf
ZYCcOMNa
=+Kxs
-----END PGP SIGNATURE-----

--ZbZcGFvRCCGlM6S4--
