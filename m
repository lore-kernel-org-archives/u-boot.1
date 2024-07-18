Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03408C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA4688758;
	Thu, 18 Jul 2024 15:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T1DrJA1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DD188786; Thu, 18 Jul 2024 15:52:25 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5058874C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c9cc66c649so452121b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310742; x=1721915542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zV4Q/m7ZL3NWqCgaxGBmY8hjcQVuOQMnonW1mdfVDCY=;
 b=T1DrJA1Lg2T/0SWSiijmhU6cu7sQ88QndnjcITMzk4aJKTEY7wwzVTz4r2o+bzgUOf
 1j3z3NkTYWOVguQB7P5QW5/W1vVX2FlxI6xy/wojXl3susOaPy9dqU4Kt+21P2PGP+gR
 iuhI2E6tj42d3Vc6jnDGAfMxF/xPeQDqPn66g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310742; x=1721915542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zV4Q/m7ZL3NWqCgaxGBmY8hjcQVuOQMnonW1mdfVDCY=;
 b=DuPc833ueKB61rA80GS6JAP+OT+avCciuEXXeeJ9EqsvRk7txH9RqGLAthX5Kl+THQ
 UKAdW3yCK/EO0XFzVxxrSvkURS3YhbSCSdtDgAa4hUIl4nY5UsHIRbLrGMj4ycvLjEXG
 qxdyKz+rDez1BXsYZ6kCCkDCc7yM0gwoe8kpuw7uwUk3fvgcpo7R4mMPhiwUO2xSa8zs
 ANc3RCiOPfBbm34P+WVcUfHGwcHPgc4WSul8nYo6MMVs2JnunQ4yelViJEvHdhVWxmOs
 l2o7USV3aSS1jvfombvXEQo6NymVAqpYpD7EwccZi7la/XKRO5hIlHmmA0CLpr0SzBcQ
 WrGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1bUqL+ZJcCN91585lCh2hlDtZ2nPFwti1U1/b+EF2F7NVrRjMTLV1Q1bb7fDEKX303XPc/L4R40XnmasRaPBDmnfaiA==
X-Gm-Message-State: AOJu0YxQVyey0qOcxcBOkckDlgpTUNVjWS852WRtwp2XbSebNYgIREhF
 A0imydr9LG+ysVxdO/mmUuwI/aQOSv3GWb4f7Zlv3ZBoYuxTvu82tVWmZQHnuMo=
X-Google-Smtp-Source: AGHT+IEk9/fc986in1Xr+vEoI4loAQ80qOTgFmAuh7pDmuLCRajNlTHMvdcTZDgr7DeEF8l1Qyon8g==
X-Received: by 2002:a05:6808:f8b:b0:3d5:2ab4:8dc2 with SMTP id
 5614622812f47-3dad521e6a2mr5258896b6e.26.1721310741906; 
 Thu, 18 Jul 2024 06:52:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708e7900b37sm437611a34.67.2024.07.18.06.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:52:21 -0700 (PDT)
Date: Thu, 18 Jul 2024 07:52:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Walter Lozano <walter.lozano@collabora.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Martyn Welch <martyn@collabora.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] board: rpi: Update memory layout for Aarch64
Message-ID: <20240718135219.GV561963@bill-the-cat>
References: <20240716171602.2279766-1-walter.lozano@collabora.com>
 <20240716172113.GG561963@bill-the-cat>
 <CALeDE9PUF4-oCk+CXB0FiL=Haq9o0MkHa5BS4JTvZw7HbwjjaQ@mail.gmail.com>
 <20240717154437.GP561963@bill-the-cat>
 <1f85166d-5ec9-48bb-b4d9-6a76158e0d4e@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJwVRncQKMQm/7J0"
Content-Disposition: inline
In-Reply-To: <1f85166d-5ec9-48bb-b4d9-6a76158e0d4e@collabora.com>
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


--RJwVRncQKMQm/7J0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 03:32:00PM -0300, Walter Lozano wrote:
>=20
>=20
> On 7/17/24 12:44, Tom Rini wrote:
> > On Wed, Jul 17, 2024 at 11:59:50AM +0100, Peter Robinson wrote:
> > > On Tue, 16 Jul 2024 at 18:21, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Tue, Jul 16, 2024 at 02:16:02PM -0300, Walter Lozano wrote:
> > > >=20
> > > > > ARM and Aarch64 have different restrictions and trying to accommo=
date
> > > > > larger kernels like the ones used in distros can be challenging. =
For this
> > > > > reason, separate the layout and rearrange the map for Aarch64 to =
support
> > > > > kernels larger than 36 MB.
> > > > >=20
> > > > > Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> > > > > ---
> > > > >=20
> > > > >   board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
> > > > >   1 file changed, 18 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rp=
i/rpi.env
> > > > > index 30228285edd..37c7f6a920e 100644
> > > > > --- a/board/raspberrypi/rpi/rpi.env
> > > > > +++ b/board/raspberrypi/rpi/rpi.env
> > > > > @@ -42,13 +42,19 @@ dfu_alt_info+=3DzImage fat 0 1
> > > > >    *   For Aarch64, the kernel image is uncompressed and must be =
loaded at
> > > > >    *   text_offset bytes (specified in the header of the Image) i=
nto a 2MB
> > > > >    *   boundary. The 'booti' command relocates the image if neces=
sary. Linux uses
> > > > > - *   a default text_offset of 0x80000.  In summary, loading at 0=
x80000
> > > > > - *   satisfies all these constraints and reserving memory up to =
0x02400000
> > > > > - *   permits fairly large (roughly 36M) kernels.
> > > > > + *   a default text_offset of 0x80000.  However, loading it at 0=
x80000
> > > > > + *   will allow to reserve only up to 0x02400000 which permits m=
edium size
> > > > > + *   kernels (roughly 36M). This is good enough for customized k=
ernels but
> > > > > + *   not for distros which by default enable drivers for many di=
fferent
> > > > > + *   boards. Under these circumstances, using 0x00200000 provide=
s room for
> > > > > + *   larger kernels.
> > > > >    *
> > > > >    * scriptaddr and pxefile_addr_r can be pretty much anywhere th=
at doesn't
> > > > >    * conflict with something else. Reserving 1M for each of them =
at
> > > > > - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be ple=
nty.
> > > > > + * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be ple=
nty for ARM.
> > > > > + *
> > > > > + *   For Aarch64, since the kernel is placed in different locati=
on,
> > > > > + *   accommodate them to reserver 1M for each of them.
> > > > >    *
> > > > >    * On ARM, both the DTB and any possible initrd must be loaded =
such that they
> > > > >    * fit inside the lowmem mapping in Linux. In practice, this us=
ually means not
> > > > > @@ -62,16 +68,21 @@ dfu_alt_info+=3DzImage fat 0 1
> > > > >    * large initrds before they start colliding with U-Boot.
> > > > >    */
> > > > >   #ifdef CONFIG_ARM64
> > > > > +pxefile_addr_r=3D0x00080000
> > > > > +scriptaddr=3D0x00100000
> > > > > +kernel_addr_r=3D0x00200000
> > > > > +fdt_addr_r=3D0x03400000
> > > > > +ramdisk_addr_r=3D0x03500000
> > > > >   fdt_high=3Dffffffffffffffff
> > > > >   initrd_high=3Dffffffffffffffff
> > > > >   #else
> > > > > -fdt_high=3Dffffffff
> > > > > -initrd_high=3Dffffffff
> > > > > -#endif
> > > > >   kernel_addr_r=3D0x00080000
> > > > >   scriptaddr=3D0x02400000
> > > > >   pxefile_addr_r=3D0x02500000
> > > > >   fdt_addr_r=3D0x02600000
> > > > >   ramdisk_addr_r=3D0x02700000
> > > > > +fdt_high=3Dffffffff
> > > > > +initrd_high=3Dffffffff
> > > > > +#endif
> > > > >=20
> > > > >   boot_targets=3Dmmc usb pxe dhcp
> > > >=20
> > > > We need to drop the disabling of device tree / initrd relocation as
> > > > that's sure not going to help matters. What's the minimum amount of
> > > > memory an aarch64 Pi will have? I really prefer reserving 128MiB (e=
ven
> > > > if that's not the maximum Linux Kernel Image size anymore) and then
> > > > device tree and then initrd.
> > >=20
> > > 512Mb on the Zero2W and RPi3A.
> > >=20
> > > We've not seen an issue here on the very large Fedora kernel, but I
> > > suspect that's because using UEFI mitigates this somewhat because here
> > > we're actually loading shim/grub.
> >=20
> > OK, that should be enough to put a 128MiB spot for kernel, then 512KiB
> > for device tree, and then rest for initrd, and not be disabling
> > relocation (and thus preventing U-Boot from fixing failures).
> >=20
>=20
> Thanks for the feedback! If I understood it correctly a layout like the
> the one bellow would be the right thing. The only difference is in
> device tree for which is reserved a bit more.
>=20
> pxefile_addr_r=3D0x00080000
> scriptaddr=3D0x00100000
> kernel_addr_r=3D0x00200000
> fdt_addr_r=3D0x09800000
> ramdisk_addr_r=3D0x09900000
>=20
> If this matches the expectations I will prepare the V2.

Looks right to me, Peter or Matthias ? Thanks!

--=20
Tom

--RJwVRncQKMQm/7J0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaZHg8ACgkQFHw5/5Y0
tywAdgwAq6B38Mdi2O7UyP17htc39PtDSjBDdCQXb5VicECStCGrmce/NknQS7h4
LrpOBMg8m/5pW+v8SowLlOlLAy5yFAFbI3HigA1lX0ESBCpuDyNPc9H2LA7rs0KA
8RgjmQx0R8BpD4nIpdMDEVo+cyEUn8eQepO88vnu6Za9IXQ/uW5GLK3ZLRZ7JNna
YpKGl1ZWtuMfaCMxPjn5SmbHCBlpLez6oFYZAp+5CIDrkoYS5l/pqXGAQcC/f/cp
CsHMJJPqwdatDEzQvC83MgF5oV52UKMks27V2NeCLYhfDUNtRE5r1X4xT22HUdA9
wCDItumOtLwH5rQt9ZCnCioflPZLCNVopkKi7osiHNsJhq0V86XZ1++aL298PKq9
fCWmliZrz/Scw/3jXpkYO6MusQnlRMXuO4+utPqgIIuYKy6mwOhgwYsvVLxrJOiA
Cfepmh6cpeM2GEaa95XPuVji6ROyokoy1G0LHLFI0+hq6rwSnv+Ldw73P889Atry
hLhsJWQB
=8Nbu
-----END PGP SIGNATURE-----

--RJwVRncQKMQm/7J0--
