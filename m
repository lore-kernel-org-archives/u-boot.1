Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B8BC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF3388616;
	Wed, 29 May 2024 18:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="pi3mIQs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FBA88253; Wed, 29 May 2024 18:51:43 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751BE88616
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a61b70394c0so270493266b.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1717001499; x=1717606299; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzpnHlBy+eW/wKR1dvCYtSrJY0V/7RZw0fH5S/AsNJk=;
 b=pi3mIQs1nFK1KtufFe7sOedShar1+aiOkb47GThpSK0ml+p8+G7h30FaexS8HJEWUp
 cBCZNj8CUqXdpmg9OesM86eBAJPX98WB64++V+UCdrhYF+jNlvs+SN0ehFaePxgiuSHE
 V/5uPZA/zHoNdOZPfUs+Y1OaUQGIjxGY5SXdMAa2g75JVns6WBlH08x8BG1Abu6Kcm3L
 TxzLi/6awE5YdsZgyVPNPhqaUMfVECKgv8jSncP6ogvL0VF7s975KRxBotzyySj4uafk
 CikZ0jKtQrXfMeQuLbu8JL4kI3j7sldvYvudjKSiiEt4od5xh5MvLsI1jj+Awo2Engqt
 2ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717001499; x=1717606299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzpnHlBy+eW/wKR1dvCYtSrJY0V/7RZw0fH5S/AsNJk=;
 b=CkNAP/wbbAuL6Yg+/qyttP4fRM8L9/Cu53XFnJleof7i9e+xJuhV+/B6IUrJi7GUhg
 XcxaBgYSV4CU/OukOEl1i4h6sZ1ZI4MEIE7xaChka/Jnu3Igcf+cO1pE1LLoHEed93cS
 qhXCv4ngmDztQMO63iakDhFDrgsmvrXORCAQSGzP9uVI4B5kHra05cBHEJ/A55YyCGR1
 0YVMJSdNSTLeaeIr55PjHtQfsvj6nRv9zYhTvBw1dsFW0TFkMXO8AnErB7C/RzNjneua
 ScyS2X7W92nVGERsKh+gv37kDnlHlLC9xsJl/0h7fH82ctojwMOjUPJreFiHaQi5NSRG
 IaKg==
X-Gm-Message-State: AOJu0Yz+Kiakc6NcAD/9l5CM5+HLvppsQsQXSw7m+SpvIvz+hNP8o8Ns
 toyJ8IatoTuJGp5H5Wt9cKaWpQ5Am/OzBqNkLTsAWsncdv9wDSxvpLub9bH6SIzFHp7SGSqLYSS
 QFoQE0QXvdsQgbliiS8LV6dbUBDXH8NbJ4wLlnA==
X-Google-Smtp-Source: AGHT+IHV8k4zerXz6egKn0JrzAGtdrAEO/q3z0iYZj02Q1u8Cy1vvke+TaN/BB0Q1Y8zVw7iPqMulPfzrTCsVm42JCs=
X-Received: by 2002:a17:906:491a:b0:a59:c844:beea with SMTP id
 a640c23a62f3a-a626511622emr913407266b.73.1717001498573; Wed, 29 May 2024
 09:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200249.3904352-1-tharvey@gateworks.com>
 <CAFLszTifTgSGjAZ-t7-7q6FYRjQ1kfH6hn2dw-hb0PK-2Z3WRg@mail.gmail.com>
In-Reply-To: <CAFLszTifTgSGjAZ-t7-7q6FYRjQ1kfH6hn2dw-hb0PK-2Z3WRg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 29 May 2024 09:51:26 -0700
Message-ID: <CAJ+vNU1yQaLgW5f1tSHiZtbWQ_7GPs87GV3FHNK3uvCiFpLvZw@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
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

On Wed, May 29, 2024 at 9:30=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tim,
>
> On Sat, 25 May 2024 at 14:02, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > If we have DM_RNG enabled populate this value automatically when
> > fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> > is enabled as it's implementation uses a different source of entropy
>
> its
>

Hi Simon,

Thanks for the review. I can fix that.

> > that is not yet implemented as DM_RNG. We also skip this if
> > MEASURED_BOOT is enabled as in that case any modifications to the
> > dt will cause measured boot to fail (although there are many other
> > places the dt is altered).
> >
> > As this fdt node is added elsewhere create a library function and
> > use it to deduplicate code. We will provide a parameter to specify the
> > index of the rng device as well as a boolean to overwrite if present.
> >
> > For our automatic injection, we will use the first rng device and
> > not overwrite if already present with a non-zero value (which may
> > have been populated by an earlier boot stage). This way if a board
> > specific ft_board_setup() function wants to customize this behavior
> > it can call fdt_kaslrseed with a rng device index of its choosing and
> > set overwrite true.
>
> I suggest creating a sysinfo driver which can provide the RNG device.

I'm not really clear what you mean but that seems out of scope for
this patch. If/when someone needs to extend the functionality of
specifying one of many RNG's perhaps they can follow that approach.

>
> >
> > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> > but left in place in case boot scripts exist that rely on this command
> > existing and returning success. An informational message is printed to
> > alert users of this command that it is likely no longer needed.
> >
> > Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> > randomization and completely ignores the kaslr-seed for its own
> > randomness needs (i.e the randomization of the physical placement of
> > the kernel). It gets weeded out from the DTB that gets handed over via
> > efi_install_fdt() as it would also mess up the measured boot DTB TPM
> > measurements as well.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Andy Yan <andy.yan@rock-chips.com>
> > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Devarsh Thakkar <devarsht@ti.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > v4:
> >  - add missing /n to notice in kaslrseed cmd
> >  - combine ints in declaration
> >  - remove unused vars from board/xilinx/common/board.c ft_board_setup
> > v3:
> >  - skip if CONFIG_MEASURED_BOOT
> >  - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
> >  - pass in rng index and bool to specify overwrite
> >  - remove duplicate error strings printed outside of fdt_kaslrseed
> >  - added note to commit log about how EFI STUB weeds out kalsr-seed
> > v2:
> >  - fix typo in commit msg
> >  - use stack for seed to avoid unecessary malloc/free
> >  - move to a library function and deduplicate code by using it
> >    elsewhere
> > ---
> >  board/xilinx/common/board.c | 40 ------------------------------
> >  boot/fdt_support.c          |  6 +++++
> >  boot/pxe_utils.c            | 35 ++------------------------
> >  cmd/kaslrseed.c             | 45 +++++-----------------------------
> >  include/kaslrseed.h         | 19 ++++++++++++++
> >  lib/Makefile                |  1 +
> >  lib/kaslrseed.c             | 49 +++++++++++++++++++++++++++++++++++++
> >  7 files changed, 83 insertions(+), 112 deletions(-)
> >  create mode 100644 include/kaslrseed.h
> >  create mode 100644 lib/kaslrseed.c
>
> Are you able to split this patch into a few patches, one of which
> handles the refactoring first?

as in the following?
1/3 Add fdt_kaslrseed function to add kaslr-seed to chosen node
2/3 fdt: automatically add /chosen/kaslr-seed if DM_RNG is enabled
3/3 Use fdt_kaslrseed function to de-duplicate code

>
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 30a81376ac41..0b43407b9e94 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -701,11 +701,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t t=
otal_size)
> >  #define MAX_RAND_SIZE 8
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> > -       size_t n =3D MAX_RAND_SIZE;
> > -       struct udevice *dev;
> > -       u8 buf[MAX_RAND_SIZE];
> > -       int nodeoffset, ret;
> > -
> >         static const struct node_info nodes[] =3D {
> >                 { "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
> >         };
> > @@ -713,41 +708,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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
> > index 874ca4d6f5af..b64cdd34825a 100644
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
> > @@ -300,6 +301,11 @@ int fdt_chosen(void *fdt)
> >         if (nodeoffset < 0)
> >                 return nodeoffset;
> >
> > +       if (IS_ENABLED(CONFIG_DM_RNG) &&
> > +           !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> > +           !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> > +               fdt_kaslrseed(fdt, 0, false);
> > +
>
> This looks like it needs a new Kconfig to enable this behaviour,
> rather than inferring it from others.

I hate to add additional Kconfigs when I don't feel they are
necessary. I'm doing this for the following reason (which I can add a
comment for):

!CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT:
We are skipping this case temporarily until that code is refactored to
use DM_RNG (which is out of the scope of this patch). If someone could
provide a patch that make CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT a DM_RNG
driver I could add it to my series.

!CONFIG_MEASURED_BOOT:
We do not want to modify the dt as it will break measured boot.
Honestly I think I should drop this as if you are in this function you
are modifying other dt props. I believe keeping the dt unmodified for
measured boot should be out of the scope of this patch and will
require additional work elsewhere. When this work is done (out of
scope of this patch) then it likely could/should be implmeneted via a
new Kconfig (ie CONFIG_NO_DTMODS).

Thoughts?

>
> >         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf))=
 {
> >                 err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> >                                   abuf_data(&buf), abuf_size(&buf));
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index 4b22bb6f525a..35d5b9ed3ecc 100644
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
> > @@ -342,35 +339,7 @@ static void label_boot_kaslrseed(void)
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
> > -               printf("Unable to set kaslr-seed on chosen node: %s\n",=
 fdt_strerror(err));
> > -               goto err;
> > -       }
> > -err:
> > -       free(buf);
> > +       fdt_kaslrseed(working_fdt, 0, true);
> >  #endif
> >         return;
> >  }
> > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > index e0d3c7fe7489..ebe4058d7ac6 100644
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
and is likely no longer needed\n");
> >
> >         if (!working_fdt) {
> >                 printf("No FDT memory address configured. Please config=
ure\n"
> > @@ -44,27 +27,11 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int=
 flag, int argc, char *const
> >                 return CMD_RET_FAILURE;
> >         }
> >
> > -       ret =3D fdt_check_header(working_fdt);
> > -       if (ret < 0) {
> > -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > +       err =3D fdt_kaslrseed(working_fdt, 0, true);
> > +       if (err < 0)
> >                 return CMD_RET_FAILURE;
> > -       }
> > -
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
> >
> > -       return ret;
> > +       return CMD_RET_SUCCESS;
> >  }
> >
> >  U_BOOT_LONGHELP(kaslrseed,
> > diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> > new file mode 100644
> > index 000000000000..7f9911c59fa4
> > --- /dev/null
> > +++ b/include/kaslrseed.h
> > @@ -0,0 +1,19 @@
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
> > + * @index:     index of UCLASS_RNG device to use
> > + * @overwrite: do not overwrite existing non-zero node unless true
> > + * Return:     0 if OK, -ve on error
> > + */
> > +int fdt_kaslrseed(void *blob, int index, bool overwrite);
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
> > index 000000000000..5ba3700e9e06
> > --- /dev/null
> > +++ b/lib/kaslrseed.c
>
> Shouldn't this go in fdt_support.c ?

Sure, I can change that. Are you happy with the function prototype?

Best Regards,

Tim

>
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> > + */
> > +#include <dm.h>
> > +#include <rng.h>
> > +#include <fdt_support.h>
> > +#include <dm/device_compat.h>
> > +
> > +int fdt_kaslrseed(void *fdt, int index, bool overwrite)
> > +{
> > +       int len, err, nodeoffset;
> > +       struct udevice *dev;
> > +       const u64 *orig;
> > +       u64 data =3D 0;
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
> > +       /* return without error if we are not overwriting and existing =
non-zero node */
> > +       orig =3D fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
> > +       if (orig && len =3D=3D sizeof(*orig))
> > +               data =3D fdt64_to_cpu(*orig);
> > +       if (data && !overwrite) {
> > +               debug("not overwriting existing kaslr-seed\n");
> > +               return 0;
> > +       }
> > +       err =3D uclass_get_device(UCLASS_RNG, index, &dev);
> > +       if (err) {
> > +               printf("No RNG device at index %d\n", index);
> > +               return err;
> > +       }
> > +       err =3D dm_rng_read(dev, &data, sizeof(data));
> > +       if (err) {
> > +               dev_err(dev, "dm_rng_read failed: %d\n", err);
> > +               return err;
> > +       }
> > +       err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeo=
f(data));
> > +       if (err < 0)
> > +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_s=
trerror(err));
> > +
> > +       return err;
> > +}
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
