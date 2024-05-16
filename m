Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B26C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 16:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D297F88368;
	Thu, 16 May 2024 18:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CTDbnE1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D99D88352; Thu, 16 May 2024 18:15:18 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344DE88368
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 18:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-69b5de48126so38190546d6.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715876115; x=1716480915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l3IghZ6fjxHXxwIeydt+CDiyKhW1lzlk+egyq7FzkDs=;
 b=CTDbnE1B1E1Iz8Q8Nwfg+TqxB4yrUgdfC1cO8c1lPUOno1lWbapidkhRIE3JRS2umO
 QwdOU91a+6Pg0nkotY2jB50n2vEbEQrhIO0/3wmidol3MAx9DHB0u2IeBAwWZTnNOnLC
 HmU2/8KR0eDeh/nsIM6cqRDHs916B2C84Px5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715876115; x=1716480915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3IghZ6fjxHXxwIeydt+CDiyKhW1lzlk+egyq7FzkDs=;
 b=lPnXZe2sWUNQbj1KucIFKbx1IMXVpN4r/OJSF4Udb7Xe3FrRXxIYG832hQlbM8+o4c
 b6Gyd4FT83Js6FN9iqGfgpRSVT2w7/ExbnR5081LrOv4QDnHqAECJsjp3APBvZeGHq5s
 FvyFT8xTwDAI6+favoN1YBE8jts4IFPHpaM9NrkPX7iXtAsp6v6L5BmSGqr8k7Tvn+hI
 Ro0LsnMb1ZJnXYGmSuNq6HNA788OAMFCI39/rlk4ia0bM7mxDyWE6mw9yBwx/8S4AYL0
 HPBRXXyNQFWsE6v+lwaXSGtOkF4ytInBX//6uTMaqlYoIryh7Wg4Rt6S2qQR5Qw9h1/u
 mydw==
X-Gm-Message-State: AOJu0YxmfkNeoizwTsMlgv0xIrO/hosQi8MiutH/suWobpQDVKG30dW5
 MORPFy52tHL41AHbgls4mMkdk8ISrutblHME550X+DH2UYJyQy+C42NjwXqLGpUPOtF3A/VrI/+
 R
X-Google-Smtp-Source: AGHT+IGF8xn5Iomj35BJZAECi5Dp8QsIRnSDsR1I/KETanBi6E+YhkEZfahNYbdNhOiGkYaYfqxKHw==
X-Received: by 2002:a05:6214:419c:b0:6a0:d612:a1a6 with SMTP id
 6a1803df08f44-6a1681506ccmr213360056d6.19.1715876114801; 
 Thu, 16 May 2024 09:15:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd3aasm77363596d6.84.2024.05.16.09.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 09:15:14 -0700 (PDT)
Date: Thu, 16 May 2024 10:15:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ruchika Gupta <ruchika.gupta@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Thomas Hebb <tommyhebb@gmail.com>, Sumit Garg <sumit.garg@nxp.com>,
 Michael Walle <michael@walle.cc>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG
 is enabled
Message-ID: <20240516161510.GB2568172@bill-the-cat>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hwcLJLFxcL/0VRQw"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
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


--hwcLJLFxcL/0VRQw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 08:58:09AM -0700, Tim Harvey wrote:
> On Wed, May 15, 2024 at 1:50=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > If we have DM_RNG enabled populate this value automatically when
> > fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> > it's implementation uses a different source of entropy.
> >
> > As this fdt node is added elsewhere create a library function and
> > use it to deduplicate code.
> >
> > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> > but left in place in case boot scripts exist that rely on this command
> > existing and returning success. An informational message is printed to
> > alert users of this command that it is likely no longer needed.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2:
> >  - fix typo in commit msg
> >  - use stack for seed to avoid unecessary malloc/free
> >  - move to a library function and deduplicate code by using it elsewhere
> > ---
> >  board/xilinx/common/board.c | 35 -----------------------------
> >  boot/fdt_support.c          | 10 +++++++++
> >  boot/pxe_utils.c            | 35 +++--------------------------
> >  cmd/kaslrseed.c             | 45 ++++++-------------------------------
> >  include/kaslrseed.h         | 17 ++++++++++++++
> >  lib/Makefile                |  1 +
> >  lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
> >  7 files changed, 72 insertions(+), 105 deletions(-)
> >  create mode 100644 include/kaslrseed.h
> >  create mode 100644 lib/kaslrseed.c
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 30a81376ac41..f741e8957818 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >         if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFI=
G_NAND_ZYNQ))
> >                 fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> >
> > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -               debug("No RNG device\n");
> > -               return 0;
> > -       }
> > -
> > -       if (dm_rng_read(dev, buf, n)) {
> > -               debug("Reading RNG failed\n");
> > -               return 0;
> > -       }
> > -
> > -       if (!blob) {
> > -               debug("No FDT memory address configured. Please configu=
re\n"
> > -                     "the FDT address via \"fdt addr <address>\" comma=
nd.\n"
> > -                     "Aborting!\n");
> > -               return 0;
> > -       }
> > -
> > -       ret =3D fdt_check_header(blob);
> > -       if (ret < 0) {
> > -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> > -               return ret;
> > -       }
> > -
> > -       nodeoffset =3D fdt_find_or_add_subnode(blob, 0, "chosen");
> > -       if (nodeoffset < 0) {
> > -               debug("Reading chosen node failed\n");
> > -               return nodeoffset;
> > -       }
> > -
> > -       ret =3D fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof=
(buf));
> > -       if (ret < 0) {
> > -               debug("Unable to set kaslr-seed on chosen node: %s\n", =
fdt_strerror(ret));
> > -               return ret;
> > -       }
> > -
> >         return 0;
> >  }
> >  #endif
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 874ca4d6f5af..3455d60d69dc 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <abuf.h>
> >  #include <env.h>
> > +#include <kaslrseed.h>
> >  #include <log.h>
> >  #include <mapmem.h>
> >  #include <net.h>
> > @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
> >         if (nodeoffset < 0)
> >                 return nodeoffset;
> >
> > +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE=
_SUPPORT)) {
> > +               err =3D fdt_kaslrseed(fdt);
> > +               if (err) {
> > +                       printf("WARNING: could not set kaslr-seed %s.\n=
",
> > +                              fdt_strerror(err));
> > +                       return err;
> > +               }
> > +       }
> > +
> >         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf))=
 {
> >                 err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> >                                   abuf_data(&buf), abuf_size(&buf));
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index 4b22bb6f525a..8d70233fc08d 100644
> > --- a/boot/pxe_utils.c
> > +++ b/boot/pxe_utils.c
> > @@ -8,6 +8,7 @@
> >  #include <dm.h>
> >  #include <env.h>
> >  #include <image.h>
> > +#include <kaslrseed.h>
> >  #include <log.h>
> >  #include <malloc.h>
> >  #include <mapmem.h>
> > @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
> >  #if CONFIG_IS_ENABLED(DM_RNG)
> >         ulong fdt_addr;
> >         struct fdt_header *working_fdt;
> > -       size_t n =3D 0x8;
> > -       struct udevice *dev;
> > -       u64 *buf;
> > -       int nodeoffset;
> >         int err;
> >
> >         /* Get the main fdt and map it */
> > @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
> >         if (err <=3D 0)
> >                 return;
> >
> > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -               printf("No RNG device\n");
> > -               return;
> > -       }
> > -
> > -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen"=
);
> > -       if (nodeoffset < 0) {
> > -               printf("Reading chosen node failed\n");
> > -               return;
> > -       }
> > -
> > -       buf =3D malloc(n);
> > -       if (!buf) {
> > -               printf("Out of memory\n");
> > -               return;
> > -       }
> > -
> > -       if (dm_rng_read(dev, buf, n)) {
> > -               printf("Reading RNG failed\n");
> > -               goto err;
> > -       }
> > -
> > -       err =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf,=
 sizeof(buf));
> > -       if (err < 0) {
> > +       err =3D fdt_kaslrseed(working_fdt);
> > +       if (err < 0)
> >                 printf("Unable to set kaslr-seed on chosen node: %s\n",=
 fdt_strerror(err));
> > -               goto err;
> > -       }
> > -err:
> > -       free(buf);
> >  #endif
> >         return;
> >  }
> > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > index e0d3c7fe7489..ea5c07d729cf 100644
> > --- a/cmd/kaslrseed.c
> > +++ b/cmd/kaslrseed.c
> > @@ -9,33 +9,16 @@
> >  #include <command.h>
> >  #include <dm.h>
> >  #include <hexdump.h>
> > +#include <kaslrseed.h>
> >  #include <malloc.h>
> >  #include <rng.h>
> >  #include <fdt_support.h>
> >
> >  static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, ch=
ar *const argv[])
> >  {
> > -       size_t n =3D 0x8;
> > -       struct udevice *dev;
> > -       u64 *buf;
> > -       int nodeoffset;
> > -       int ret =3D CMD_RET_SUCCESS;
> > +       int err;
> >
> > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -               printf("No RNG device\n");
> > -               return CMD_RET_FAILURE;
> > -       }
> > -
> > -       buf =3D malloc(n);
> > -       if (!buf) {
> > -               printf("Out of memory\n");
> > -               return CMD_RET_FAILURE;
> > -       }
> > -
> > -       if (dm_rng_read(dev, buf, n)) {
> > -               printf("Reading RNG failed\n");
> > -               return CMD_RET_FAILURE;
> > -       }
> > +       printf("Notice: a /chosen/kaslr-seed is automatically added to =
the device-tree when booted via booti/bootm/bootz therefore using this comm=
and is likely no longer needed");
> >
> >         if (!working_fdt) {
> >                 printf("No FDT memory address configured. Please config=
ure\n"
> > @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int=
 flag, int argc, char *const
> >                 return CMD_RET_FAILURE;
> >         }
> >
> > -       ret =3D fdt_check_header(working_fdt);
> > -       if (ret < 0) {
> > -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > +       err =3D fdt_kaslrseed(working_fdt);
> > +       if (err < 0) {
> > +               printf("Unable to set kaslr-seed on chosen node: %s\n",=
 fdt_strerror(err));
> >                 return CMD_RET_FAILURE;
> >         }
> >
> > -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen"=
);
> > -       if (nodeoffset < 0) {
> > -               printf("Reading chosen node failed\n");
> > -               return CMD_RET_FAILURE;
> > -       }
> > -
> > -       ret =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf,=
 sizeof(buf));
> > -       if (ret < 0) {
> > -               printf("Unable to set kaslr-seed on chosen node: %s\n",=
 fdt_strerror(ret));
> > -               return CMD_RET_FAILURE;
> > -       }
> > -
> > -       free(buf);
> > -
> > -       return ret;
> > +       return CMD_RET_SUCCESS;
> >  }
> >
> >  U_BOOT_LONGHELP(kaslrseed,
> > diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> > new file mode 100644
> > index 000000000000..3fe82f418acf
> > --- /dev/null
> > +++ b/include/kaslrseed.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > + */
> > +
> > +#if !defined _KASLRSEED_H_
> > +#define _KASLRSEED_H_
> > +
> > +/**
> > + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> > + *
> > + * @blob:      fdt blob
> > + * Return:     0 if OK, -ve on error
> > + */
> > +int fdt_kaslrseed(void *blob);
> > +
> > +#endif /* _KASLRSEED_H_ */
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 2a76acf100d0..20a0242055fa 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -149,6 +149,7 @@ obj-y +=3D date.o
> >  obj-y +=3D rtc-lib.o
> >  obj-$(CONFIG_LIB_ELF) +=3D elf.o
> >
> > +obj-$(CONFIG_DM_RNG) +=3D kaslrseed.o
> >  obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) +=3D semihosting.o
> >
> >  #
> > diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> > new file mode 100644
> > index 000000000000..ad06bee2b88d
> > --- /dev/null
> > +++ b/lib/kaslrseed.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > + */
> > +#include <dm.h>
> > +#include <rng.h>
> > +#include <fdt_support.h>
> > +
> > +int fdt_kaslrseed(void *fdt)
> > +{
> > +       struct udevice *dev;
> > +       int nodeoffset;
> > +       u64 data;
> > +       int err;
> > +
> > +       err =3D fdt_check_header(fdt);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       /* find or create "/chosen" node. */
> > +       nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
> > +       if (nodeoffset < 0)
> > +               return nodeoffset;
> > +
> > +       err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> > +       if (!err)
> > +               err =3D dm_rng_read(dev, &data, sizeof(data));
> > +       if (!err)
> > +               err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &dat=
a, sizeof(data));
> > +       if (err < 0)
> > +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_s=
trerror(err));
> > +
> > +       return err;
> > +}
[snip]
> Tom, can sec_firmware.c be moved to dm-rng to eliminate the need for a
> separate fdt_fixup_kaslr?

I'm really just the "last resort" on that file, and git history by
default is too short, in this case. Adding a few more people now.

--=20
Tom

--hwcLJLFxcL/0VRQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZGMQoACgkQFHw5/5Y0
tywWrgv8DMJcG4MU/D0vTNyW1O0agbAdZnmSjjVxsRiMNprcakZKt7sL11zgIN1f
I30ZNcNMyWtOoP0JcQX42n48ftTrKx+J2rAeY3RGI5F+7t4IDPHKNXqfOdepivKW
zIaW4rKupameiKeyk/sV9pgO/+9jn2JJMF/537GGHvVAFcrP7Cro3b2WiRL8uhyA
G+4i1V6SyTd4PEHrW6ZRh+MtsvyY4W2UsILIP56jtzu2XMKZ60DXjPUHNklh0RFP
uYBwaTSNO6QYJ2EY1GoviFrWMmjHVMe7UCTTKGQs45OfVZRPA95lnQJa121gQsJo
rr7MgsN7fETfwvMrg7ejVzA5nhqPLIXpZg8KjMlatlZXKjFzPh6p5OiiadCduyhk
10GDL5NBMHxF3diGLjzYczHiPLobH6o8MbKcfYlq9ZSSf8J+nDdgKosIewwfUd8I
COewawYb/0maWRbhaXRMQqFG9rRbf/+4mIZDDr9qF/Jfm81TwYqraq14oKgGrsEY
RjUeUOvx
=NmFY
-----END PGP SIGNATURE-----

--hwcLJLFxcL/0VRQw--
