Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7138CC36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9289E8171B;
	Mon, 31 Mar 2025 18:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JL8ysLo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC56481DE3; Mon, 31 Mar 2025 18:30:52 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE40C81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bb97260ceso1035642a34.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743438648; x=1744043448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SGElBS9snNRTheOko1yVvRsZFZ544lRfiMFQY9Zm8yY=;
 b=JL8ysLo0NV7V6rzDHgbwjoCbe9Nllj/7sL8YqwDjBe13XnMKxukTpjDQbdP5xX/Fyd
 e3nkxgenENyN1rFuewe2+7x/fyodFljixwhCjLW+PFN5KvvLLO57kN7JProJIIxCTG2r
 A5tyetbXFC9kpYHEXNxT0yBD4EbESChwNSwaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743438648; x=1744043448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGElBS9snNRTheOko1yVvRsZFZ544lRfiMFQY9Zm8yY=;
 b=wut+NvjLg6MMT0yMiK76pTG1sHWcdfo0PkxFR7sPg9reqSeEOJI92Y0wxsbB1ZsRHN
 W0S9b0+u5+ysUhnbh2jsoewSXRoUqRkP+iffFpyc6WvQqbNY94l5k1c68BrhXz+Rjn/t
 8ZSa7g33bQRsyFhvlblSlveEVOnAQi1sB9kRN+5SZ73u56j2FeOYOZt9WK2krkIVZPfo
 J5rNk7T5ui4IeDvWt4ZOY54otS0GXHmSTykRV+eMg5JI/2fwy7YiqGJQ/tcDuR1AkZCJ
 2/I9Z5zK8i6Lf/hzYvT2oP2B/tRbE88vejvu1+wMR2YivjfGEQcdE/qRteumIPdW29Rt
 Yb3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4FFdJHO7QBjgKi0x7eEkJFiHHGrd8PFp2Lx2ZSUTaAh/hS71JI62qJtgaikHVKOuRIjqBNSs=@lists.denx.de
X-Gm-Message-State: AOJu0YxCxafsdpk3VbCUKWaT+Biad5+X6pabA/F2l055BXCezxK9MDI7
 aB4WIMXe2C5f2b6e9QJhcE4QKEJTWTeaGzzpbEoigdgosmQmGMUJqrzLVDqdhsc=
X-Gm-Gg: ASbGncujIelqaAVVHF4O3tt2cB5b+n7wn2xSq9Wyv0N8PxJxM9lCqHrJUcDCedD4Mag
 P04qPUa6vxDNnb7fX+1WsJ0kO/6FBq3fB7Ld5NgVUp7UcO7nhPPkvt2+UwEIRXllRVYyZlOFKPb
 Z2aLCj32o8sKAsVCGAxPgJbl0re2xnb0V/ii5qZ78z9q6QdEa3zxmNHr+jk9urYW2ZY/F3Vxv1y
 3f4EFRPnmyopIsDMOcZYOgR8ulQlAu2GgmPdF2b2JpU6P3xXKQFho1hzluSaovCXOA0GfEcxw4x
 RegTvPnonIOI2TzXSwwgU5gDVq4R9ocrFNl25T7yn9g2DZQJdUSD/EF2Bvd5+QBjubXuSmaQ3Vo
 BA9KMviFWuJb0y38J
X-Google-Smtp-Source: AGHT+IGAY/5ig/OoOty5I3LPKSfbOhbkLvJdNkguCWMpjfswWQx+m5YRy4tUirYFa125bplSaNonyA==
X-Received: by 2002:a05:6830:698c:b0:727:3664:ca25 with SMTP id
 46e09a7af769-72c6367d320mr5886011a34.0.1743438648317; 
 Mon, 31 Mar 2025 09:30:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580d30e0sm1524761a34.37.2025.03.31.09.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:30:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:30:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Message-ID: <20250331163045.GF93000@bill-the-cat>
References: <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
 <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
 <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
 <db43d704-8f6d-4583-9b86-d1d2709f7bf6@linaro.org>
 <CAFLszTgaZC6eOdtSV5Ukny3zffiixVep14iSiYzc8RpykmBE9g@mail.gmail.com>
 <657308f0-bc64-49c3-bd14-c932a88e5ccd@linaro.org>
 <9c6ac5b0-8a4d-47fd-8be3-d9d49f9cb644@canonical.com>
 <98a9629c-a6b4-4e01-8f2b-694ee6ca7c06@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2BGS5SRpCYd2GZ/f"
Content-Disposition: inline
In-Reply-To: <98a9629c-a6b4-4e01-8f2b-694ee6ca7c06@linaro.org>
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


--2BGS5SRpCYd2GZ/f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 04:38:12PM +0200, Caleb Connolly wrote:
> Hi Heinrich,
>=20
> On 3/28/25 15:18, Heinrich Schuchardt wrote:
> > On 28.03.25 14:00, Caleb Connolly wrote:
> > >=20
> > >=20
> > > On 3/28/25 13:01, Simon Glass wrote:
> > > > Hi Caleb,
> > > >=20
> > > > On Sun, 23 Mar 2025 at 12:39, Caleb Connolly
> > > > <caleb.connolly@linaro.org> wrote:
> > > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > Reviving this as it is still very much an issue, and
> > > > > especially relevant
> > > > > for Qualcomm platforms.
> > > > >=20
> > > > > On 11/3/23 20:44, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >=20
> > > > > > On Wed, 25 Oct 2023 at 15:22, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >=20
> > > > > > > On 10/25/23 23:13, Tom Rini wrote:
> > > > > > > > On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wro=
te:
> > > > > > > > > > Date: Wed, 25 Oct 2023 21:57:44 +0200
> > > > > > > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonica=
l.com>
> > > > > > > > > >=20
> > > > > > > > > > On 10/25/23 20:23, Simon Glass wrote:
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >=20
> > > > > > > > > > > On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google=
=2Ecom> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> > > > > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Forward and backward
> > > > > > > > > > > > > compatibility of Linux
> > > > > > > > > > > > > kernel device- trees is
> > > > > > > > > > > > > sometimes missing. One
> > > > > > > > > > > > > solution approach is to load
> > > > > > > > > > > > > a kernel specific
> > > > > > > > > > > > > device-tree. This can either
> > > > > > > > > > > > > be done via a U-Boot scripts
> > > > > > > > > > > > > (like the one
> > > > > > > > > > > > > generated by Debian package
> > > > > > > > > > > > > flash-kernel or by a boot
> > > > > > > > > > > > > loader like GRUB.
> > > > > > > > > > > > > The boot loader approach
> > > > > > > > > > > > > currently requires to know
> > > > > > > > > > > > > the device-tree name
> > > > > > > > > > > > > before first boot which makes it unusable for gen=
eric images.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Expose the device-tree file name as EFI variable =
FdtFile.
> > > > > > > > > > > > > This will allow bootloaders
> > > > > > > > > > > > > to load a kernel specific
> > > > > > > > > > > > > device- tree.
> > > > > > > > > > > >=20
> > > > > > > > > > > > kernel-specific
> > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The variable will not be
> > > > > > > > > > > > > exposed on ACPI based
> > > > > > > > > > > > > systems or if the
> > > > > > > > > > > > > environment variable fdtfile is not defined.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Heinrich
> > > > > > > > > > > > > Schuchardt
> > > > > > > > > > > > > <heinrich.schuchardt@canonical.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > v4:
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Generalize the
> > > > > > > > > > > > > description of the content
> > > > > > > > > > > > > of $fdtfile.
> > > > > > > > > > > > > v3:
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Add documentati=
on
> > > > > > > > > > > > > v2:
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Use a unique
> > > > > > > > > > > > > GUID to enable future U-Boot
> > > > > > > > > > > > > independent
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 standardization.
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Do not try to
> > > > > > > > > > > > > add the variable on ACPI
> > > > > > > > > > > > > based systems.
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > =A0=A0=A0=A0 doc/develop/uefi/uefi.rst=A0 | 14 ++=
++++++++++++
> > > > > > > > > > > > > =A0=A0=A0=A0 include/efi_loader.h=A0=A0=A0=A0=A0=
=A0 |=A0 5 +++++
> > > > > > > > > > > > > =A0=A0=A0=A0
> > > > > > > > > > > > > lib/efi_loader/efi_setup.c |
> > > > > > > > > > > > > 30 +++++++++++++++++++++++ +
> > > > > > > > > > > > > ++++++
> > > > > > > > > > > > > =A0=A0=A0=A0 3 files changed, 49 insertions(+)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/doc/develop/uefi/uefi.rst
> > > > > > > > > > > > > b/doc/develop/uefi/ uefi.rst
> > > > > > > > > > > > > index fb16ac743a..702c490831 100644
> > > > > > > > > > > > > --- a/doc/develop/uefi/uefi.rst
> > > > > > > > > > > > > +++ b/doc/develop/uefi/uefi.rst
> > > > > > > > > > > > > @@ -916,6 +916,20 @@ So our
> > > > > > > > > > > > > final format of the
> > > > > > > > > > > > > FilePathList[] is::
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0 Loaded image - end
> > > > > > > > > > > > > node (0xff) - VenMedia -
> > > > > > > > > > > > > initrd_1 - [end node (0x01)
> > > > > > > > > > > > > - initrd_n ...] - end node
> > > > > > > > > > > > > (0xff)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > +EFI variable FdtFile
> > > > > > > > > > > > > +~~~~~~~~~~~~~~~~~~~~
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +Ideally U-Boot would always
> > > > > > > > > > > > > expose a device-tree that
> > > > > > > > > > > > > can be used for booting
> > > > > > > > > > > > > +any operating systems.
> > > > > > > > > > > > > Unfortunately operating
> > > > > > > > > > > > > systems like Linux sometimes
> > > > > > > > > > > > > +break forward and backward
> > > > > > > > > > > > > compatibility. In this case
> > > > > > > > > > > > > there is a need to load
> > > > > > > > > > > > > +an operating system version specific device-tree.
> > > > > > > > > > > >=20
> > > > > > > > > > > > This seems to be a strong
> > > > > > > > > > > > statement. Given the effort that
> > > > > > > > > > > > goes into
> > > > > > > > > > > > the DT, changes are supposed to be backwards-compat=
ible. Is this
> > > > > > > > > > > > generally true, or is it just
> > > > > > > > > > > > that we want an up-to-date DT
> > > > > > > > > > > > for the
> > > > > > > > > > > > kernel to enable new features?
> > > > > > > > > > >=20
> > > > > > > > > > > Did you see this comment?
> > > > > > > > > >=20
> > > > > > > > > > It would have been nice to put the
> > > > > > > > > > person which made that comment on copy.
> > > > > > > > > >=20
> > > > > > > > > > The truth lies in the world "supposed":
> > > > > > > > > >=20
> > > > > > > > > > The idea of a device-tree that never
> > > > > > > > > > needs to change is quite old and
> > > > > > > > > > never became true on ARM devices.
> > > > > > > > > >=20
> > > > > > > > > > We all know Linux tends to break both
> > > > > > > > > > forward and backward compatibility
> > > > > > > > > > of device-trees. Here is a nice example:
> > > > > > > > > >=20
> > > > > > > > > > d0c6707ca423 ("arm64: dts: allwinner:
> > > > > > > > > > H5: NanoPi Neo Plus2: phy- mode
> > > > > > > > > > rgmii-id")
> > > > > > > > > >=20
> > > > > > > > > > Driver changes broke forward and
> > > > > > > > > > backwards compatibility of a lot of
> > > > > > > > > > Allwinner boards.
> > > > > > > > >=20
> > > > > > > > > Well, that happened in 2020.=A0 Things have gotten better=
 over time.
> > > > >=20
> > > > > (kinda off-topic context on DT version compat)
> > > > >=20
> > > > > =A0 From what I've seen, there is not yet very much infrastructur=
e or
> > > > > common practise in place in the kernel to handle parsing DTB in a
> > > > > backwards compatible way. For example there has been efforts
> > > > > to simplify
> > > > > the dwc3 devicetree for Qualcomm platforms with a series dating b=
ack
> > > > > about as far as this U-Boot patch!
> > > > >=20
> > > > > https://lore.kernel.org/linux-arm-msm/20250318-dwc3-refactor-
> > > > > v5-1-90ea6e5b3ba4@oss.qualcomm.com/
> > > > >=20
> > > > > Earlier versions attempted to convert the older DTS to the newer =
format
> > > > > internally, but after much discussion it was decided that this wa=
sn't
> > > > > really feasible, instead the new approach is to duplicate the ent=
ire
> > > > > dwc3 driver to maintain DT compatibility.
> > > > >=20
> > > > > It's obviously good to see compatibility taken seriously,
> > > > > since it seems
> > > > > clear that if we ever want to treat DT as firmware, the
> > > > > kernel will need
> > > > > to do this (and eventually vendors could ship laptops with
> > > > > DT out of the
> > > > > box which works with upstream -- crazier things have happened).
> > > > >=20
> > > > > But I think in the mean time we still want to be able to drive di=
stro
> > > > > adoption, and the way I see it teaching GRUB and systemd-boot abo=
ut a
> > > > > new FdtFile EFI variable is going to make that way simpler...
> >=20
> > There was a discussion in the context of EBBR if this is the right way
> > forward. And the general opinion was that the compatible string should
> > be used for matching the dtb files.
>=20
> Ideally, the file name should contain the same information as the compati=
ble
> string, or more. Currently in upstream there are devices with different
> display variants that have identical compatible strings but different dtb
> files.

I've asked before for clarification on if that's allowed or a bug and
not really gotten an answer. It sure feels wrong and I think the
argument is that devices doing things like that aren't likely to be
general purpose anyhow.

--=20
Tom

--2BGS5SRpCYd2GZ/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqwzEACgkQFHw5/5Y0
tywsawwAj0Fxk57N92INbvV3+zbiNw4JKo/0R85OdSjLHeI6yzbjvJgfzb/yceJa
LlNxZnB7niXOFEmiNs06DSbu/372cHYLzJmSgojjk5rmBUcSslRXE43RE/Dweu3T
pud2zVXZi+oRBaSmVVW81hqJSS+RjPLvbRoimdU1SKvC+Kmbu5GHrWMq+dDY6JJj
yqG7UxPZ45Od6Y4Kh3qbTEiCrVxENKAbGF3vYXKv7GhcFZmGSWbVXWMSSKOTxDA9
owC26H+wnGPhFfP76U02vCN8kC49LrBFqaS+u8YRZx3dcqWvegiw5mbT3ncS2hy2
A2oWxhf93d9RWrh+QI9sPU/w+9hxxhNFzxQFoQ6C7BwFUekoYitW8eLtNNYUpxLc
nZe9J4QaV6p8qyrad71Dtj+gJ0FRdYDsVyuB5Q7xrBINoyWwIBx5sorBIQZJiSEb
J+td2MBHToLIDJu8pz71JPRJFW62BezO5BAmH7BBj/kVtyy8yhaVW6UjAArVQD/W
yN60FeTK
=5MMx
-----END PGP SIGNATURE-----

--2BGS5SRpCYd2GZ/f--
