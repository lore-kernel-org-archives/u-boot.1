Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD2CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 16:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D693287497;
	Fri, 20 Oct 2023 18:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HWMHR63I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4008587498; Fri, 20 Oct 2023 18:24:18 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96268748E
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 18:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9abc069c8bso1004464276.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697819053; x=1698423853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=41f72yuUZxncXQbZyPg7ukUCbup7ljK2WAzNHhbXqo0=;
 b=HWMHR63INg5tXwWzPlhSqyltfeViAss2axmDdtHy8S5oAWd69AbW7BLDD3JV4el4XJ
 rfbhvOoZ5R8NPye7dmccnHttG8AnmyNYB4tswL94OtW0OxQEWefC2BqLKM6sDgqksKQX
 /35c1/Vbg41STGVSjLI50Ranwqwwa3RBT5TNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819053; x=1698423853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41f72yuUZxncXQbZyPg7ukUCbup7ljK2WAzNHhbXqo0=;
 b=YC83c5xg8fz1wlsE9gXH3F7iThOYMfCpE2Zv2e8qcZaL+WSkshJC7R/gBlCcSH8Rt4
 zvdO7KOh5CZswc06EI/g3DGGJETdNBNP5YyalkhE6i6dYoqc8HNtlaYCVE1MvUbPHfgg
 AhgHk1O3VbcYJG/bRaDPvNCPIDcujAAwIEArfkQThgEV7Jxp08KwzvzFDBwzDCt6GnYn
 KkVdP0+s6zC/KubyRDFKTFsm2nepIZjHTfr6x+o52jBIwpOvRUiK/3db0HcQVzRIRnxc
 0+ISbTXlrGXCD3fsWGBGI4pOhZbJMNDRkCLcNAIMzx2CWsKP+Hn3ahq1sIpbfP56tNy8
 xSsQ==
X-Gm-Message-State: AOJu0Yyti5PhPiAD+qWfWW9ngDHmpbCZEfvAhek/WttXGXoayPA/ntMq
 XduFwZl3DWLCA3jTIYeO1qEiaw==
X-Google-Smtp-Source: AGHT+IGbe826ZJ6FLHF7YMdarj5krevHvFngCODbPBjFa/8yZnP0jLmhW9ukDyeh5KaBTKbiC79bZg==
X-Received: by 2002:a25:680d:0:b0:d9a:5859:bf14 with SMTP id
 d13-20020a25680d000000b00d9a5859bf14mr2121807ybc.64.1697819053035; 
 Fri, 20 Oct 2023 09:24:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 w10-20020a25ef4a000000b00d815cb9accbsm646285ybm.32.2023.10.20.09.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 09:24:12 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:24:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231020162410.GK3119521@bill-the-cat>
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nNathArkBoqgVLqx"
Content-Disposition: inline
In-Reply-To: <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
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


--nNathArkBoqgVLqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 05:40:03PM +0200, Heinrich Schuchardt wrote:
> On 20.10.23 15:21, Simon Glass wrote:
> > +Doug Anderson
> >=20
> > Hi Heinrich,
> >=20
> > On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > On 19.10.23 15:55, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >=20
> > > > On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >=20
> > > > > On 10/18/23 05:33, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >=20
> > > > > > On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >=20
> > > > > > > Forward and backward compatibility of Linux kernel device-tre=
es is
> > > > > > > sometimes missing. One solution approach is to load a kernel =
specific
> > > > > > > device-tree. This can either be done via a U-Boot scripts (li=
ke the one
> > > > > > > generated by Debian package flash-kernel or by a boot loader =
like GRUB.
> > > > > > > The boot loader approach currently requires to know the devic=
e-tree name
> > > > > > > before first boot which makes it unusable for generic images.
> > > > > > >=20
> > > > > > > Expose the device-tree file name as EFI variable FdtFile.
> > > > > > > This will allow bootloaders to load a kernel specific device-=
tree.
> > > > > > >=20
> > > > > > > The variable will not be exposed on ACPI based systems or if =
the
> > > > > > > environment variable fdtfile is not defined.
> > > > > > >=20
> > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canon=
ical.com>
> > > > > > > ---
> > > > > > > v2:
> > > > > > >            Use a unique GUID to enable future U-Boot independ=
ent
> > > > > > >            standardization.
> > > > > > >            Do not try to add the variable on ACPI based syste=
ms.
> > > > > > > ---
> > > > > > >     include/efi_loader.h       |  5 +++++
> > > > > > >     lib/efi_loader/efi_setup.c | 30 +++++++++++++++++++++++++=
+++++
> > > > > > >     2 files changed, 35 insertions(+)
> > > > > >=20
> > > > > > I was too slow to reply to v1.
> > > > > >=20
> > > > > > Does grub load the DT? I was assuming that U-Boot would pass it=
 on?
> > > > > > What is the interface between U-Boot and grub?
> > > > >=20
> > > > > The device-tree built into U-Boot is often out of date and not us=
able to
> > > > > boot current Linux. A single device-tree can be loaded by U-Boot =
=66rom
> > > > > file and passed on as EFI configuration table. This device-tree m=
ay not
> > > > > be compatible with all kernel versions exposed by GRUB.
> > > > >=20
> > > > > GRUB provides a devicetree command. It is disabled if you use sec=
ure
> > > > > boot. At least in Debian and Ubuntu GRUB invokes the
> > > > > EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tr=
ee
> > > > > fix-ups after loading a device-tree.
> > > > >=20
> > > > > Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> > > > > devicetree commands to the boot options in grub.cfg.
> > > >=20
> > > > Thanks. I wonder if you could document this somewhere? It seems like
> > > > there are a lot of options and it is quite complicated.
> > > >=20
> > > > Back to the question, I suppose you are expecting grub to load the =
DT
> > > > using this filename? But why doesn't U-Boot load it instead? It see=
ms
> > > > very convoluted.
> > >=20
> > > A separate file of this name exists for every kernel version installe=
d.
> > > The loaded dtb must match the kernel. U-Boot does not know what kernel
> > > version will be chosen in GRUB. And for a generic image GRUB does not
> > > what board it is on.
> > >=20
> > > >=20
> > > > Also, can we test this interface?
> > >=20
> > > Neither the sandbox nor QEMU have environment variable fdtfile. And we
> > > don't create the EFI variable with ACPI as used on the sandbox.
> >=20
> > I worry that this is creating another interface that some poor sod is
> > going to have to deal with in the future. Is this part of the EFI
> > standard?
>=20
> No, the UEFI standard does not care much about device-trees. It only defi=
nes
> the GUID for the configuration table.
>=20
> >=20
> > We should really be using the compatible string to choose the
> > devicetree. Why are we using filenames at all? What is the
> > relationship between the compatible string and the filename? Is there
> > a lookup table, or should we create one?
>=20
> There is no 1:1 relationship between compatible string and filename, e.g.
> the following arm64 device-trees use the same compatible string:
>=20
> amd/amd-overdrive-rev-b0.dts
> amd/amd-overdrive-rev-b1.dts
>=20
> amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
>=20
> xilinx/zynqmp-zc1751-xm015-dc1.dts
> xilinx/zynqmp-zc1751-xm015-dc1.dts
> xilinx/zynqmp-zc1751-xm015-dc1.dts
> xilinx/zynqmp-zc1751-xm015-dc1.dts
>=20
> >=20
> > The correct way of doing this is implemented in U-Boot with
> > CONFIG_FIT_BEST_MATCH.
>=20
> Why should we write complicated code to find a *possibly* matching file if
> we already know the filename that needs to be loaded?

I think that is the unfortunate key here. We can make a guess, or best
match, but it might not be right. And we need a reliable way to find and
use the correct tree. And the U-Boot portion of that may be "set the EFI
var if it's not already set" rather than "and now load it".

> > Can we mirror something like that in grub, etc?

I'm splitting this part out because no, having to have N projects write
the same bit of code, but with its own quirks and bugs doesn't sound
like the right direction. It's why today we have a few different sets of
logic to try and find / set the right device tree, so that whatever
follows after doesn't have to also do that, and get updated for every
new platform too.

And of course yes, ideally, boards would be manufactured with an up to
date and correct device tree on them.

--=20
Tom

--nNathArkBoqgVLqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUyqaQACgkQFHw5/5Y0
tyygLQv+IFCNqYg0N/B+hRFPlJ5XsAl7mn/I9VO7+UqkHROsS5Dk6P1knS/FtQ7r
3UENZeCwA3/0RpEyjU3jiQUpN1mefMEiRo513Am+g+gOyUg7BQ4BfnCijIP1LWVc
aOUG70cIhnYd8ydGjP84APJDX1q6wxflppbqw79Vje3bSRSzsouhSGk0/wae+2ZB
Z8l44/xy+IW9B4Vsog1nwABczAVPVsup2jqOEskJBaxM4kwpPzGG6ZaxT8mWg032
at7oylI/+IU8wL6YJxNfisSmhJ2iNXyVM8X5vX7WPUXtwZyCGTRHrvA+saHcrJLD
zAnXPG42xSYB/dSi6cRkntBd9pA80kS7RVFmNZZEk2GIYZIxrm4LKpQcedToL4s+
NzmesLwSsaRDmNXPu1M4mLWH+6LV1lfnY91BcX39/JPDQWhtJiZ4A321ib6B/TqD
U3AhL5+wEhAIoJ25QhlJlRqytFJ5D6Gd1klZm3OcMm2UHe+9kG2hKJOcEu7YseCv
XX4wtal3
=qrJZ
-----END PGP SIGNATURE-----

--nNathArkBoqgVLqx--
