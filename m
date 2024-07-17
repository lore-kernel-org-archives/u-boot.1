Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A5FC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2D988A52;
	Wed, 17 Jul 2024 17:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OnUg5o0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DA88859B; Wed, 17 Jul 2024 17:44:44 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D5688A48
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-704466b19c4so196029a34.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721231081; x=1721835881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ScEhvHPPdpItXQP5T3JjfI6ZpmloUSe0dAdiOQ9U+Pk=;
 b=OnUg5o0bG3XTZJv1kOoHOKM6EjnJZGVqrG9IzlNxL6udETKpl8h8aMMB2XKG6jwO4z
 PbyjpgCVYe+5Gzd9qQ7xzCDK6LNRHp/b9IVMNzbCnIU68Hnz5jW3i6K1voUZyI7ZynME
 i6mGO03F2hAt3oL8dQNh1OQBx/18q4wpM55wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231081; x=1721835881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScEhvHPPdpItXQP5T3JjfI6ZpmloUSe0dAdiOQ9U+Pk=;
 b=ebFRt/mIp477svxbTe3q6AH6FDStUC2sSA9Hiy7N3/Qm1AIbRefJ6TxpyeloQAtVhC
 iP2foKokWJgKH6cv+1IdwmoADPR4PZUq652DeGUvleLii1WGSRibOcGaWUEKvfh9jP2M
 G4QEtjlhsEjjcAdnQP41Vl/2AvkfxF6gReTbBlyLu+Rwddz4FL7fi4gv6B5+hFyR4tzt
 /HkhvJJKvmI0+oqoY69ImeRPE2ndxA4S4UVGPx6eymMMop/pmyAXZgJeaTXe9Xot4MMc
 oYJxBFPEujjBUnVndIwcEfOMa88EkrK8WbmqgNjfAfi0rweCsWRbiXNdCVTU/B0VdsRX
 HHzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBeUcgQw3LmOX2YAEgdPusN0yUJ99U9knbtpVcTiZ/WpU9u9a1jv9eRXzSmWF/Q768s/Csr82f3sLkuxsCLjdgPRV3g==
X-Gm-Message-State: AOJu0YyS0hWfovbouA7EC809iLj7NfhHT7QH3PFU/kZBYooHSzgy7wyl
 229/e7QgVfiwPRH5xq0A/OTkGDyn/aesAnlTwhoYgIIh6i5LvswGa7LYIWTP6nk=
X-Google-Smtp-Source: AGHT+IFM35M+gZkNWD25Q8uI+GFF94KlWoHOjwyIGFDWIOFETbL4b4BpEqrJF9SYkEhakNUPkedvGg==
X-Received: by 2002:a05:6870:a252:b0:258:df79:291d with SMTP id
 586e51a60fabf-260d913c6d5mr1760951fac.5.1721231080788; 
 Wed, 17 Jul 2024 08:44:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260752a904csm1792554fac.41.2024.07.17.08.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:44:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:44:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Walter Lozano <walter.lozano@collabora.com>, u-boot@lists.denx.de,
 Martyn Welch <martyn@collabora.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] board: rpi: Update memory layout for Aarch64
Message-ID: <20240717154437.GP561963@bill-the-cat>
References: <20240716171602.2279766-1-walter.lozano@collabora.com>
 <20240716172113.GG561963@bill-the-cat>
 <CALeDE9PUF4-oCk+CXB0FiL=Haq9o0MkHa5BS4JTvZw7HbwjjaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DRW9IyesgM0B6U0W"
Content-Disposition: inline
In-Reply-To: <CALeDE9PUF4-oCk+CXB0FiL=Haq9o0MkHa5BS4JTvZw7HbwjjaQ@mail.gmail.com>
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


--DRW9IyesgM0B6U0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:59:50AM +0100, Peter Robinson wrote:
> On Tue, 16 Jul 2024 at 18:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 02:16:02PM -0300, Walter Lozano wrote:
> >
> > > ARM and Aarch64 have different restrictions and trying to accommodate
> > > larger kernels like the ones used in distros can be challenging. For =
this
> > > reason, separate the layout and rearrange the map for Aarch64 to supp=
ort
> > > kernels larger than 36 MB.
> > >
> > > Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> > > ---
> > >
> > >  board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
> > >  1 file changed, 18 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rp=
i.env
> > > index 30228285edd..37c7f6a920e 100644
> > > --- a/board/raspberrypi/rpi/rpi.env
> > > +++ b/board/raspberrypi/rpi/rpi.env
> > > @@ -42,13 +42,19 @@ dfu_alt_info+=3DzImage fat 0 1
> > >   *   For Aarch64, the kernel image is uncompressed and must be loade=
d at
> > >   *   text_offset bytes (specified in the header of the Image) into a=
 2MB
> > >   *   boundary. The 'booti' command relocates the image if necessary.=
 Linux uses
> > > - *   a default text_offset of 0x80000.  In summary, loading at 0x800=
00
> > > - *   satisfies all these constraints and reserving memory up to 0x02=
400000
> > > - *   permits fairly large (roughly 36M) kernels.
> > > + *   a default text_offset of 0x80000.  However, loading it at 0x800=
00
> > > + *   will allow to reserve only up to 0x02400000 which permits mediu=
m size
> > > + *   kernels (roughly 36M). This is good enough for customized kerne=
ls but
> > > + *   not for distros which by default enable drivers for many differ=
ent
> > > + *   boards. Under these circumstances, using 0x00200000 provides ro=
om for
> > > + *   larger kernels.
> > >   *
> > >   * scriptaddr and pxefile_addr_r can be pretty much anywhere that do=
esn't
> > >   * conflict with something else. Reserving 1M for each of them at
> > > - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> > > + * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty =
for ARM.
> > > + *
> > > + *   For Aarch64, since the kernel is placed in different location,
> > > + *   accommodate them to reserver 1M for each of them.
> > >   *
> > >   * On ARM, both the DTB and any possible initrd must be loaded such =
that they
> > >   * fit inside the lowmem mapping in Linux. In practice, this usually=
 means not
> > > @@ -62,16 +68,21 @@ dfu_alt_info+=3DzImage fat 0 1
> > >   * large initrds before they start colliding with U-Boot.
> > >   */
> > >  #ifdef CONFIG_ARM64
> > > +pxefile_addr_r=3D0x00080000
> > > +scriptaddr=3D0x00100000
> > > +kernel_addr_r=3D0x00200000
> > > +fdt_addr_r=3D0x03400000
> > > +ramdisk_addr_r=3D0x03500000
> > >  fdt_high=3Dffffffffffffffff
> > >  initrd_high=3Dffffffffffffffff
> > >  #else
> > > -fdt_high=3Dffffffff
> > > -initrd_high=3Dffffffff
> > > -#endif
> > >  kernel_addr_r=3D0x00080000
> > >  scriptaddr=3D0x02400000
> > >  pxefile_addr_r=3D0x02500000
> > >  fdt_addr_r=3D0x02600000
> > >  ramdisk_addr_r=3D0x02700000
> > > +fdt_high=3Dffffffff
> > > +initrd_high=3Dffffffff
> > > +#endif
> > >
> > >  boot_targets=3Dmmc usb pxe dhcp
> >
> > We need to drop the disabling of device tree / initrd relocation as
> > that's sure not going to help matters. What's the minimum amount of
> > memory an aarch64 Pi will have? I really prefer reserving 128MiB (even
> > if that's not the maximum Linux Kernel Image size anymore) and then
> > device tree and then initrd.
>=20
> 512Mb on the Zero2W and RPi3A.
>=20
> We've not seen an issue here on the very large Fedora kernel, but I
> suspect that's because using UEFI mitigates this somewhat because here
> we're actually loading shim/grub.

OK, that should be enough to put a 128MiB spot for kernel, then 512KiB
for device tree, and then rest for initrd, and not be disabling
relocation (and thus preventing U-Boot from fixing failures).

--=20
Tom

--DRW9IyesgM0B6U0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaX5uIACgkQFHw5/5Y0
tyyBAQv8DgJ5k7nz+li4da2RyTO+r2O4xhBmRaNOyGLiuU58kAj7il6ul0iIw4hc
hHDIYwqySxog9CD9D8bBK1Ousq7zNb8rdE/+yD3GHw0ypdcDK4soskRMbWYvOD7Z
jhWgtSTpzMFbzHs0S3Utdu4+0FjMo4o/ZdhJEYWxMXCrwjLOWXqzDzZzcyj4nABJ
IZm+1h4QKTXKCw4WAkMWyT3ROcqFeqoeI7L/kWWdKe76kEGWv7F/tVyi6WPFMEyT
DKFTaD0b7gS96YimcwvagyfaVn66KQHZCDdX3+1YanqVcwL2tNq1e06/TVMXqL6I
FBps2z5sP2S5dOrbp8jEjqutWnH5t38xFvvKR9pJT6Jiu8Fq2olE99fX4oWUvcVl
zW7hPhKJYfSfKldUPyyiPiRYKLBDk9iJ1kfioZxd0GMZPmKI/fl9AEsWTEr96wah
a+UfLDHtjQzCzCcccUD1exG0IKYGg/+elC8wzULIH1TsnK591Ap5VEVWlsa4jbRS
oqAax09R
=nQD2
-----END PGP SIGNATURE-----

--DRW9IyesgM0B6U0W--
