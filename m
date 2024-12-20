Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD94EE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E99580381;
	Fri, 20 Dec 2024 17:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VxMhEiOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB387803A9; Fri, 20 Dec 2024 17:51:40 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1928036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so18377956d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734713497; x=1735318297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=on3RhqSX1qaJVSlP30T5eL1TUnRGG9bXh/YkZ/ZhzAc=;
 b=VxMhEiOdopVWYbGMJrT66DcvgEapxINbLvy5Y6PthK+Sa8ysthXP+j9+lGP58T/9IO
 yT4qS4FZQeqDNz4+9U/VzSi4//MpH+zSSBLo6S72goxsvvPgI4lY7X5kxFpHuh1nv1B3
 quXQ77wGHS2FFFoZ89EgQbzQwNeOFI/yUyVC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734713497; x=1735318297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on3RhqSX1qaJVSlP30T5eL1TUnRGG9bXh/YkZ/ZhzAc=;
 b=SmiIZp2/1IMZdL2SAtDbwVpTkZHVz3cbt80R20H0fGmA2rocN13fBqmLE2c/ix0uvm
 Dux5tSOs9iLsnKNPR9fqrb/E9hlNpznot7vSDDAVWveNjtAqj/aYUyMXEFgfGgozDs4N
 fYZsQURLqH3OSDaFoAXt/vKFqiu8hHs96MN9Jp4D+S9gACB+JTDE/g9G11B480pFKy7s
 K0h/EjmhAAMCJLc3B0+qajgGF8rF7rrPZnqBbGcCvw19LrzRf/oBGPKRDk6RvCYUJBiD
 KO0w5OeLEtWQyxBTRxtcyUXlYlwVcmunr2nl7SgyD7zrYyBxES/Jsw3aHOX4aTxpvG0+
 PkPQ==
X-Gm-Message-State: AOJu0YwvhhKPGZqQEGhI9/xKFizGzMSw23DwFOkmqFVZvDzdHi5z9Er4
 4C1L/2tAZNX4uIsvdRYhojN8pCwXhc4ir0oYtVn1Nn6Ew0pIu2PmrjKKFwxMIDQ=
X-Gm-Gg: ASbGncvaKYHacuCl7pmfu3iUnPm+jwqLbfzNngbTH1MVFFuq1UdhPDOLGQflOArcUhF
 w9k4NMQfncAj+iqsUQmY7HCrd01+L7nKMvo7MMjnjOWZ4VHZqanXATZjYboG2CN6UgS70RtCLGn
 caqQarud3Tw7ctZxgbgRrbd2bbeOAggcmy5meelT88yE+U/zL+3esQPhytNkQFjupAtcCigXuyr
 B0pWgZeHgnKp8wphmV8ANt3ZdWRKM9D1NKriiEbPDHzmWnN7bN6I/XB
X-Google-Smtp-Source: AGHT+IFwjzcGRkUuPIJkgQlxnYflzv3GAcRAQ9JT68O3EtOCEM/l4Hcg+wYm7S1Cvigru+qbFNU2ug==
X-Received: by 2002:a05:6214:5786:b0:6da:dc79:a3cd with SMTP id
 6a1803df08f44-6dd231f1d7dmr60579586d6.0.1734713496867; 
 Fri, 20 Dec 2024 08:51:36 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb5c6sm18524496d6.79.2024.12.20.08.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:51:35 -0800 (PST)
Date: Fri, 20 Dec 2024 10:51:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Message-ID: <20241220165132.GI1505244@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-6-sjg@chromium.org>
 <20241209190202.GU2457179@bill-the-cat>
 <CAFLszTgqahZeBccxEt+DUGy2CivC3ed-v8Dd1qR8SZ2mfyRoow@mail.gmail.com>
 <20241209203325.GX2457179@bill-the-cat>
 <CAFLszTgJ0kRkBOCpa9YbMdMQ+yL2bKfKXTm54vLHKHX-AV2feA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vZaKdayEjmKZbMx5"
Content-Disposition: inline
In-Reply-To: <CAFLszTgJ0kRkBOCpa9YbMdMQ+yL2bKfKXTm54vLHKHX-AV2feA@mail.gmail.com>
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


--vZaKdayEjmKZbMx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 10:22:24AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 9 Dec 2024 at 13:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 12:27:18PM -0700, Simon Glass wrote:
> > > HI Tom,
> > >
> > > On Mon, 9 Dec 2024 at 12:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 11:20:01AM -0700, Simon Glass wrote:
> > > >
> > > > > The fdt_addr variable is used in extlinux as a fallback devicetre=
e if
> > > > > none is provided by the boot command.
> > > > >
> > > > > The existing mechanism uses the devicetree provided to U-Boot, bu=
t in
> > > > > its original, unrelocated position. For the rpi_4 I am using, thi=
s is
> > > > > at 2b35ef00 which is not a convenient place in memory, if the ram=
disk
> > > > > is large.
> > > > >
> > > > > U-Boot already deals with this sort of problem by relocating the =
FDT
> > > > > to a safe address.
> > > > >
> > > > > So use the control-FDT address instead.
> > > > >
> > > > > Remove the existing comment, which is confusing, since the FDT is=
 not
> > > > > actually passed unmodified to the kernel: U-Boot adds various thi=
ngs
> > > > > using its FDT-fixup mechanism.
> > > > >
> > > > > Note that board_get_usable_ram_top() reduces the RAM top for boar=
ds with
> > > > > less RAM. This behaviour is left unchanged as there is no other
> > > > > mechanism for U-Boot to handle this.
> > > > >
> > > > > In version 2, it incorporates some changes to fdt_addr, etc. sugg=
ested
> > > > > by Tom, as well as adding myself as a maintainer.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Drop patch to allow expanding the devicetree during relocation
> > > > >
> > > > >  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
> > > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/=
rpi.c
> > > > > index 9122f33d88d..8f6ab1b1b9b 100644
> > > > > --- a/board/raspberrypi/rpi/rpi.c
> > > > > +++ b/board/raspberrypi/rpi/rpi.c
> > > > > @@ -3,6 +3,8 @@
> > > > >   * (C) Copyright 2012-2016 Stephen Warren
> > > > >   */
> > > > >
> > > > > +#define LOG_CATEGORY LOGC_BOARD
> > > > > +
> > > > >  #include <config.h>
> > > > >  #include <dm.h>
> > > > >  #include <env.h>
> > > > > @@ -325,19 +327,10 @@ static void set_fdtfile(void)
> > > > >       env_set("fdtfile", fdtfile);
> > > > >  }
> > > > >
> > > > > -/*
> > > > > - * If the firmware provided a valid FDT at boot time, let's expo=
se it in
> > > > > - * ${fdt_addr} so it may be passed unmodified to the kernel.
> > > > > - */
> > > > > +/* Allow U-Boot to use its control FDT with extlinux if one is n=
ot provided */
> > > > >  static void set_fdt_addr(void)
> > > > >  {
> > > > > -     if (env_get("fdt_addr"))
> > > > > -             return;
> > > > > -
> > > > > -     if (fdt_magic(fw_dtb_pointer) !=3D FDT_MAGIC)
> > > > > -             return;
> > > > > -
> > > > > -     env_set_hex("fdt_addr", fw_dtb_pointer);
> > > > > +     env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> > > > >  }
> > > > >
> > > > >  /*
> > > > > @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_inf=
o *bd)
> > > > >  {
> > > > >       int node;
> > > > >
> > > > > -     update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> > > > > +     if (blob =3D=3D gd->fdt_blob)
> > > > > +             log_debug("Same FDT: nothing to do\n");
> > > > > +     else
> > > > > +             update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> > > > >
> > > > >       node =3D fdt_node_offset_by_compatible(blob, -1, "simple-fr=
amebuffer");
> > > > >       if (node < 0)
> > > >
> > > > Have you tested this to make sure that assorted overlays specified =
in
> > > > config.txt are still passed on correctly to the kernel? Or do we en=
d up
> > > > being OK here due to board_fdt_blob_setup() meaning that we set
> > > > gd->fdt_blob to fw_dtb_pointer much earlier on, and that hook simply
> > > > didn't exist back in 2016 when commit
> > > > ade243a211d6 ("rpi: passthrough of the firmware provided FDT blob")
> > > > introduced some of what you're removing here?
> > >
> > > No I have not tested what happens with overlays, but I believe they
> > > are handled by the pre-U-Boot firmware. U-Boot certainly doesn't look
> > > at the config.txt file.
> >
> > Yes, they're handled by being applied to the device tree we're passed by
> > the previous stage and stored in fw_dtb_pointer. So checking that the
> > device tree has the expected overlay applied is something that needs
> > doing before this can be applied.
>=20
> Just so I understand this request, the checks are:
>=20
> 1. That adding/removing an overlay in config.txt is reflected in the
> devicetree seen by U-Boot
> 2. That U-Boot then passes that DT to Linux?
>=20
> If I add this line:
>=20
> dtoverlay=3Ddisable-bt
>=20
> then Linux boots with serial output (I have enable_uart=3D1 in there as w=
ell)
>=20
> If I remove the dtoverlay, it does not have serial output. So yes,
> this seems to be working fine.
>=20
>=20
> For the record, the flow (within U-Boot, with this series) is:
>=20
> a. fw_dtb_pointer is set in lowlevel.S
> b. board_fdt_blob_setup() is called to set gd->fdt_blob to that value
> c. during relocation, U-Boot copies the devicetree to the top of
> memory, setting gd->fdt_blob to the new value
> d. during loading, U-Boot creates a copy of the gd->fdt_blob
> devicetree and sets working_fdt to it*
> e. U-Boot applies fix-ups to working_fdt
>=20
> * fdt_high is unset and there is no devicetree packaged with the OS

Thanks. It seems likely that some no longer required work-arounds have
built up in the pi code. But it's worth being extra cautious here given
the breadth of the user base for these platforms and the need for them
to really Just Work and the high cost associated with breakage.

--=20
Tom

--vZaKdayEjmKZbMx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdloIkACgkQFHw5/5Y0
tywCFwwAtt5Nay+ElMlu3StgpvUe0njeimErLPoZUS39iyHr1WljKkxHWUt9u7kG
P1OKwEVrtEEFT/P8n2obOPC2JbPhvwzzJg5g0+5nkuNnCWAcmOCvLt3OcPRowRKi
NAwAhQDt8TUEGJqeOId7yel9QJvg471uMoUESeGnqeWDszVm0sSguMnXv8Ayyxnh
uEsmPQjbfY0RvCcsuEL3WX5bPMhHjRo78RTGqMpWWmWPgliFf8WzC/t7JAwWG5a8
iPYrgAhEehyev3yWEdfWlXHCBZNzjpA+cEdBypjBjKLdxeonvBrsbHl65Djo+UNZ
wf30O+ZSwFhUPReV6Oap/7qeOm8Y6S1fAh/p/uwNbRb7BKqoZBHTGShxhW1el8Ly
H/yTgvro0N8KI40knK+N7r3EGVY2UXyA5GE1dl8ZrwSV/HVHgazoZEk7qvq2MRvj
Md/4vaMVcWAX6/gfKyM6cDHEA3BYMp6P9G5797siuQlgoTd27162mi2gW/uskJd4
hVmPCwDz
=1AEE
-----END PGP SIGNATURE-----

--vZaKdayEjmKZbMx5--
