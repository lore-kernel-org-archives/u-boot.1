Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70173C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A6987FC2;
	Tue, 21 May 2024 18:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBTGoTQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4A387FA7; Tue, 21 May 2024 18:54:33 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551E887FC2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e73359b8fbso22598261fa.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716310469; x=1716915269; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mf/GSiez410r4fZpzA04UI0/6piF3U+DBa/obxGr7cQ=;
 b=GBTGoTQfNnKCmj1T0dg2SVX4WpcvQrsBDmf9ZRCXNTowmEpvxHm8kxDXcP+3lTdiek
 /hyQ4jXJjunid5rroPoBz2LW7i8zguvBYjkqBqBd0QzpDu+kf+Y0koCslxJEfENtDa1L
 woWkUcp4FrGcgQZgGUm3vyp0ny9EnD+c2hi+wRKEG9FSGzs/6ZBIdJfPXMFa+GAUV/YI
 hvxtCa1MiArrQoQALu+cnlm320kDf5Ofaea3O49wewah2/xJKtUUV9bBOtBvSzI5fugC
 w/i4C28sB1ufogCERm5eCLxvmVjNw3FGsCDlqIZMnS5YTHzVeH8T+EpEgpF/yq5JFfb4
 n2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716310469; x=1716915269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mf/GSiez410r4fZpzA04UI0/6piF3U+DBa/obxGr7cQ=;
 b=QGki2Nv5PjK14DaQBfWMBiY8uqgT7Ezp8rIXGmBzehEhFZXoGEb6p2+RXapA62ARck
 CiVZwO0+rMOfTmfuKlnYFjsCBml18Dq1seZdVhSxPCRyarM21xn1ofCsGGqXtqB1LPGN
 ZyuR7+NGqRZ8SxRR8ua4zw4LkBF6qNqy16HCN87kxyewwCo2gnonQQuwvUaX/Mju+/3M
 QNiW7/M2jfAneQnBC97rChlaiyNAV/xeSyZFUD9meGTHZo0hGuyPF6qWQVmiWpgAMpMQ
 VwSXJiUWmmJcrTkqgmL7XIEpVJu5CcBPhEsaFGOtaTPKVNvVEhfhmsJaz55SsU4o+lov
 sggw==
X-Gm-Message-State: AOJu0YzICaU6jeeaHfPG+ATo0qppdN01FBSOIyiezK8LZ0r7yvLI9GHx
 2VMEEoIBXBKBl/ffUFwlUA79QqGwMVXiteMa0l1jrrwa+cTxTZCW0+pgnY5yywh5MCo78ABo4cQ
 dK5mC6yd5G7bYTzJnyjmM6aC5wWSisXoURh3dq7b8Pt5XhExf
X-Google-Smtp-Source: AGHT+IGHOahlR06EYOKm6vK/FxA8eU8JjHdBuRuSu05+/ulpdmqfpqhSeX4jkUFzF6Shg1PTmMNiof4xh+QxTE9xyOY=
X-Received: by 2002:a2e:81c3:0:b0:2e1:ae29:f28a with SMTP id
 38308e7fff4ca-2e5203b41d4mr307952851fa.34.1716310469390; Tue, 21 May 2024
 09:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAC_iWjL2LwY7V4SbwRqsgjnYqnLEU1curr7ZXLLQWWmrTX=nTQ@mail.gmail.com>
 <CAJ+vNU3A2BkNEGBvOKuXvXxW9bJSXW=Hyt3LxH1C+=gw0qd3Pg@mail.gmail.com>
In-Reply-To: <CAJ+vNU3A2BkNEGBvOKuXvXxW9bJSXW=Hyt3LxH1C+=gw0qd3Pg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 19:53:52 +0300
Message-ID: <CAC_iWj+1NK3YRRUZ4M21SQgD8huPqQujb3f=YFe8YSZ_CUpyXg@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tim,

On Tue, 21 May 2024 at 19:37, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, May 21, 2024 at 5:05=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim
> >
> > On Wed, 15 May 2024 at 23:50, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > > randomize the virtual address at which the kernel image is loaded, it
> > > expects entropy to be provided by the bootloader by populating
> > > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot=
.
> >
> > Since you'll send a v2, mind adding some description for UEFI on the
> > commit message?
> > efi_try_purge_kaslr_seed() has a comment of the behaviour
> >
>
> Hi  Ilias,
>
> Ok, I will add the following to the commit log for clarity:
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
>
> Does the above mean that I don't need to worry about protecting the
> call to fdt_kaslrseed() with a check for MEASURED BOOT as
> efi_install_fdt/efi_try_purge_kaslr_seed always gets called in that
> case?

There are 2 ways to do measured boot. One is via the bootm command and
the other is via the EFI protocols.
CONFIG_MEASURED_BOOT  only applies to bootm.
OTOH kaslr-seed might still have value if EFI_RNG is disabled, even
when booting with EFI, since the kernel will randomize the virtual
placement if it finds that.

But in any case, a kaslr-seed entry can't be present in the DTB if you
plan to measure it.

Cheers
/Ilias

>
> Best Regards,
>
> Tim
>
> > Thanks
> > /Ilias
> > >
> > > If we have DM_RNG enabled populate this value automatically when
> > > fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> > > it's implementation uses a different source of entropy.
> > >
> > > As this fdt node is added elsewhere create a library function and
> > > use it to deduplicate code.
> > >
> > > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless n=
ow
> > > but left in place in case boot scripts exist that rely on this comman=
d
> > > existing and returning success. An informational message is printed t=
o
> > > alert users of this command that it is likely no longer needed.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > > v2:
> > >  - fix typo in commit msg
> > >  - use stack for seed to avoid unecessary malloc/free
> > >  - move to a library function and deduplicate code by using it elsewh=
ere
> > > ---
> > >  board/xilinx/common/board.c | 35 -----------------------------
> > >  boot/fdt_support.c          | 10 +++++++++
> > >  boot/pxe_utils.c            | 35 +++--------------------------
> > >  cmd/kaslrseed.c             | 45 ++++++-----------------------------=
--
> > >  include/kaslrseed.h         | 17 ++++++++++++++
> > >  lib/Makefile                |  1 +
> > >  lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
> > >  7 files changed, 72 insertions(+), 105 deletions(-)
> > >  create mode 100644 include/kaslrseed.h
> > >  create mode 100644 lib/kaslrseed.c
> > >
> > > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.=
c
> > > index 30a81376ac41..f741e8957818 100644
> > > --- a/board/xilinx/common/board.c
> > > +++ b/board/xilinx/common/board.c
> > > @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *b=
d)
> > >         if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CON=
FIG_NAND_ZYNQ))
> > >                 fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> > >
> > > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > > -               debug("No RNG device\n");
> > > -               return 0;
> > > -       }
> > > -
> > > -       if (dm_rng_read(dev, buf, n)) {
> > > -               debug("Reading RNG failed\n");
> > > -               return 0;
> > > -       }
> > > -
> > > -       if (!blob) {
> > > -               debug("No FDT memory address configured. Please confi=
gure\n"
> > > -                     "the FDT address via \"fdt addr <address>\" com=
mand.\n"
> > > -                     "Aborting!\n");
> > > -               return 0;
> > > -       }
> > > -
> > > -       ret =3D fdt_check_header(blob);
> > > -       if (ret < 0) {
> > > -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> > > -               return ret;
> > > -       }
> > > -
> > > -       nodeoffset =3D fdt_find_or_add_subnode(blob, 0, "chosen");
> > > -       if (nodeoffset < 0) {
> > > -               debug("Reading chosen node failed\n");
> > > -               return nodeoffset;
> > > -       }
> > > -
> > > -       ret =3D fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, size=
of(buf));
> > > -       if (ret < 0) {
> > > -               debug("Unable to set kaslr-seed on chosen node: %s\n"=
, fdt_strerror(ret));
> > > -               return ret;
> > > -       }
> > > -
> > >         return 0;
> > >  }
> > >  #endif
> > > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > > index 874ca4d6f5af..3455d60d69dc 100644
> > > --- a/boot/fdt_support.c
> > > +++ b/boot/fdt_support.c
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <abuf.h>
> > >  #include <env.h>
> > > +#include <kaslrseed.h>
> > >  #include <log.h>
> > >  #include <mapmem.h>
> > >  #include <net.h>
> > > @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
> > >         if (nodeoffset < 0)
> > >                 return nodeoffset;
> > >
> > > +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWA=
RE_SUPPORT)) {
> > > +               err =3D fdt_kaslrseed(fdt);
> > > +               if (err) {
> > > +                       printf("WARNING: could not set kaslr-seed %s.=
\n",
> > > +                              fdt_strerror(err));
> > > +                       return err;
> > > +               }
> > > +       }
> > > +
> > >         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf=
)) {
> > >                 err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> > >                                   abuf_data(&buf), abuf_size(&buf));
> > > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > > index 4b22bb6f525a..8d70233fc08d 100644
> > > --- a/boot/pxe_utils.c
> > > +++ b/boot/pxe_utils.c
> > > @@ -8,6 +8,7 @@
> > >  #include <dm.h>
> > >  #include <env.h>
> > >  #include <image.h>
> > > +#include <kaslrseed.h>
> > >  #include <log.h>
> > >  #include <malloc.h>
> > >  #include <mapmem.h>
> > > @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
> > >  #if CONFIG_IS_ENABLED(DM_RNG)
> > >         ulong fdt_addr;
> > >         struct fdt_header *working_fdt;
> > > -       size_t n =3D 0x8;
> > > -       struct udevice *dev;
> > > -       u64 *buf;
> > > -       int nodeoffset;
> > >         int err;
> > >
> > >         /* Get the main fdt and map it */
> > > @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
> > >         if (err <=3D 0)
> > >                 return;
> > >
> > > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > > -               printf("No RNG device\n");
> > > -               return;
> > > -       }
> > > -
> > > -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chose=
n");
> > > -       if (nodeoffset < 0) {
> > > -               printf("Reading chosen node failed\n");
> > > -               return;
> > > -       }
> > > -
> > > -       buf =3D malloc(n);
> > > -       if (!buf) {
> > > -               printf("Out of memory\n");
> > > -               return;
> > > -       }
> > > -
> > > -       if (dm_rng_read(dev, buf, n)) {
> > > -               printf("Reading RNG failed\n");
> > > -               goto err;
> > > -       }
> > > -
> > > -       err =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", bu=
f, sizeof(buf));
> > > -       if (err < 0) {
> > > +       err =3D fdt_kaslrseed(working_fdt);
> > > +       if (err < 0)
> > >                 printf("Unable to set kaslr-seed on chosen node: %s\n=
", fdt_strerror(err));
> > > -               goto err;
> > > -       }
> > > -err:
> > > -       free(buf);
> > >  #endif
> > >         return;
> > >  }
> > > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > > index e0d3c7fe7489..ea5c07d729cf 100644
> > > --- a/cmd/kaslrseed.c
> > > +++ b/cmd/kaslrseed.c
> > > @@ -9,33 +9,16 @@
> > >  #include <command.h>
> > >  #include <dm.h>
> > >  #include <hexdump.h>
> > > +#include <kaslrseed.h>
> > >  #include <malloc.h>
> > >  #include <rng.h>
> > >  #include <fdt_support.h>
> > >
> > >  static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, =
char *const argv[])
> > >  {
> > > -       size_t n =3D 0x8;
> > > -       struct udevice *dev;
> > > -       u64 *buf;
> > > -       int nodeoffset;
> > > -       int ret =3D CMD_RET_SUCCESS;
> > > +       int err;
> > >
> > > -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > > -               printf("No RNG device\n");
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > -
> > > -       buf =3D malloc(n);
> > > -       if (!buf) {
> > > -               printf("Out of memory\n");
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > -
> > > -       if (dm_rng_read(dev, buf, n)) {
> > > -               printf("Reading RNG failed\n");
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > +       printf("Notice: a /chosen/kaslr-seed is automatically added t=
o the device-tree when booted via booti/bootm/bootz therefore using this co=
mmand is likely no longer needed");
> > >
> > >         if (!working_fdt) {
> > >                 printf("No FDT memory address configured. Please conf=
igure\n"
> > > @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, i=
nt flag, int argc, char *const
> > >                 return CMD_RET_FAILURE;
> > >         }
> > >
> > > -       ret =3D fdt_check_header(working_fdt);
> > > -       if (ret < 0) {
> > > -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > > +       err =3D fdt_kaslrseed(working_fdt);
> > > +       if (err < 0) {
> > > +               printf("Unable to set kaslr-seed on chosen node: %s\n=
", fdt_strerror(err));
> > >                 return CMD_RET_FAILURE;
> > >         }
> > >
> > > -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chose=
n");
> > > -       if (nodeoffset < 0) {
> > > -               printf("Reading chosen node failed\n");
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > -
> > > -       ret =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", bu=
f, sizeof(buf));
> > > -       if (ret < 0) {
> > > -               printf("Unable to set kaslr-seed on chosen node: %s\n=
", fdt_strerror(ret));
> > > -               return CMD_RET_FAILURE;
> > > -       }
> > > -
> > > -       free(buf);
> > > -
> > > -       return ret;
> > > +       return CMD_RET_SUCCESS;
> > >  }
> > >
> > >  U_BOOT_LONGHELP(kaslrseed,
> > > diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> > > new file mode 100644
> > > index 000000000000..3fe82f418acf
> > > --- /dev/null
> > > +++ b/include/kaslrseed.h
> > > @@ -0,0 +1,17 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > > + */
> > > +
> > > +#if !defined _KASLRSEED_H_
> > > +#define _KASLRSEED_H_
> > > +
> > > +/**
> > > + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> > > + *
> > > + * @blob:      fdt blob
> > > + * Return:     0 if OK, -ve on error
> > > + */
> > > +int fdt_kaslrseed(void *blob);
> > > +
> > > +#endif /* _KASLRSEED_H_ */
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index 2a76acf100d0..20a0242055fa 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -149,6 +149,7 @@ obj-y +=3D date.o
> > >  obj-y +=3D rtc-lib.o
> > >  obj-$(CONFIG_LIB_ELF) +=3D elf.o
> > >
> > > +obj-$(CONFIG_DM_RNG) +=3D kaslrseed.o
> > >  obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) +=3D semihosting.o
> > >
> > >  #
> > > diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> > > new file mode 100644
> > > index 000000000000..ad06bee2b88d
> > > --- /dev/null
> > > +++ b/lib/kaslrseed.c
> > > @@ -0,0 +1,34 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > > + */
> > > +#include <dm.h>
> > > +#include <rng.h>
> > > +#include <fdt_support.h>
> > > +
> > > +int fdt_kaslrseed(void *fdt)
> > > +{
> > > +       struct udevice *dev;
> > > +       int nodeoffset;
> > > +       u64 data;
> > > +       int err;
> > > +
> > > +       err =3D fdt_check_header(fdt);
> > > +       if (err < 0)
> > > +               return err;
> > > +
> > > +       /* find or create "/chosen" node. */
> > > +       nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
> > > +       if (nodeoffset < 0)
> > > +               return nodeoffset;
> > > +
> > > +       err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> > > +       if (!err)
> > > +               err =3D dm_rng_read(dev, &data, sizeof(data));
> > > +       if (!err)
> > > +               err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &d=
ata, sizeof(data));
> > > +       if (err < 0)
> > > +               printf("WARNING: could not set kaslr-seed %s.\n", fdt=
_strerror(err));
> > > +
> > > +       return err;
> > > +}
> > > --
> > > 2.25.1
> > >
