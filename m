Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9D2C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 16:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4F3886BB;
	Mon, 20 May 2024 18:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="WxOFwPV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2941A8825E; Mon, 20 May 2024 18:37:39 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1868D886D0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 18:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51f45104ef0so3867442e87.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1716223053; x=1716827853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgmohgqHvR5/pmqi5DR2qxm1X5GFxWDvQIWLDOaUqXI=;
 b=WxOFwPV7IDWIkyfn5BfdIto+5bOHmwXzHwnlpn8o/cqYVWnSf7zCxcGz432xF+8Hvs
 em2zii5j3j6+bacikXRTCnFuHs/ejrJJK32AfIPDNU3XlK3w27flNep/NLZFL7+HMSW4
 VP96E8RK++BB9ruSdKP58w15VtWLa5TUPi0YphmEq46MkCfkNXN6pktbvVl1iLmL/+Wl
 cjXVBKHyNINe0uFe5bpdKvmIhP31sF5BZZ/QR4GOuG1n6k9vsif++67WcibqGF/AWwn7
 WQyYHIqpPaDWW2Y5Fp+CQDvMdQWv95nljog5qaUXndx4Cn7FhPXgR/K+OduavcVglGKj
 IlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716223053; x=1716827853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgmohgqHvR5/pmqi5DR2qxm1X5GFxWDvQIWLDOaUqXI=;
 b=ee3dNFd9Zrpv7elSdhi05oCjH7CVcst/vShvO0i9m26qmX4hrTsjpX8TNNOCQfLN9j
 qu/BvpueNuoNOZakwbUlihhsBVPHtWrI4VT9HUk8OcsDtuTHbRRRneGhdYfJNnCDzHsP
 F0Ru9d3/82NA0W5JjX1e3MTmaR4cJSqKMc5fktAz7AJGvZavOqWpE0o6SEupkDkpM7tQ
 YOP7rM6+ONbm8rHJd6n2FkDzpVTMnsWahO9YwNP//FQec8ykJRUp7wkekMgnMe/pAbt4
 U9emwU07kdE7/YYSuGg1AV2+ddfUarsMwmpEVWf+7hTTZoa2UO531YD+eFFrhQ4f8gb0
 RURg==
X-Gm-Message-State: AOJu0Yw+hX96NcKd37AZfFo+2exLgp9GC7fDkZZjIMXzqlKGnIvWvbHc
 e4Hb2lVL4vufL9iNe2+SQ0GCfB3wBI2oAXYAFchPryQpVclfP/qXx3wdEvnopwAHOupAdbEbCH4
 +wgoEov0lQXVOsF9ZEoMdqkZUkNQBS201Tct2Jg==
X-Google-Smtp-Source: AGHT+IF6yyw9SVStx8XivsTmPaUChOBjq0QZDsb6rtAdpZWWrrL0VFT3KDZvJCQsqCr1VBNe6Upz+KMBT+dQ+tTb86w=
X-Received: by 2002:ac2:51b8:0:b0:51c:cd8d:2865 with SMTP id
 2adb3069b0e04-5220fe799efmr14686394e87.44.1716223053206; Mon, 20 May 2024
 09:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
 <07c0000c-c60a-42ad-8c49-608b7b15e7f8@amd.com>
In-Reply-To: <07c0000c-c60a-42ad-8c49-608b7b15e7f8@amd.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 20 May 2024 09:37:21 -0700
Message-ID: <CAJ+vNU3HZT=5An0hXCxoyTSJhpsTtOg=gUHf+ks_JKq38jEjRw@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Chris Morgan <macromorgan@hotmail.com>
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

On Mon, May 20, 2024 at 1:29=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Hi Tim,
>
> On 5/16/24 17:58, Tim Harvey wrote:
> > On Wed, May 15, 2024 at 1:50=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> >>
> >> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> >> randomize the virtual address at which the kernel image is loaded, it
> >> expects entropy to be provided by the bootloader by populating
> >> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >>
> >> If we have DM_RNG enabled populate this value automatically when
> >> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> >> it's implementation uses a different source of entropy.
> >>
> >> As this fdt node is added elsewhere create a library function and
> >> use it to deduplicate code.
> >>
> >> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless no=
w
> >> but left in place in case boot scripts exist that rely on this command
> >> existing and returning success. An informational message is printed to
> >> alert users of this command that it is likely no longer needed.
> >>
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> ---
> >> v2:
> >>   - fix typo in commit msg
> >>   - use stack for seed to avoid unecessary malloc/free
> >>   - move to a library function and deduplicate code by using it elsewh=
ere
> >> ---
> >>   board/xilinx/common/board.c | 35 -----------------------------
> >>   boot/fdt_support.c          | 10 +++++++++
> >>   boot/pxe_utils.c            | 35 +++--------------------------
> >>   cmd/kaslrseed.c             | 45 ++++++-----------------------------=
--
> >>   include/kaslrseed.h         | 17 ++++++++++++++
> >>   lib/Makefile                |  1 +
> >>   lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
> >>   7 files changed, 72 insertions(+), 105 deletions(-)
> >>   create mode 100644 include/kaslrseed.h
> >>   create mode 100644 lib/kaslrseed.c
> >>
> >> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> >> index 30a81376ac41..f741e8957818 100644
> >> --- a/board/xilinx/common/board.c
> >> +++ b/board/xilinx/common/board.c
> >> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd=
)
> >>          if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CON=
FIG_NAND_ZYNQ))
> >>                  fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> >>
> >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> >> -               debug("No RNG device\n");
> >> -               return 0;
> >> -       }
> >> -
> >> -       if (dm_rng_read(dev, buf, n)) {
> >> -               debug("Reading RNG failed\n");
> >> -               return 0;
> >> -       }
> >> -
> >> -       if (!blob) {
> >> -               debug("No FDT memory address configured. Please config=
ure\n"
> >> -                     "the FDT address via \"fdt addr <address>\" comm=
and.\n"
> >> -                     "Aborting!\n");
> >> -               return 0;
> >> -       }
> >> -
> >> -       ret =3D fdt_check_header(blob);
> >> -       if (ret < 0) {
> >> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> >> -               return ret;
> >> -       }
> >> -
> >> -       nodeoffset =3D fdt_find_or_add_subnode(blob, 0, "chosen");
> >> -       if (nodeoffset < 0) {
> >> -               debug("Reading chosen node failed\n");
> >> -               return nodeoffset;
> >> -       }
> >> -
> >> -       ret =3D fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeo=
f(buf));
> >> -       if (ret < 0) {
> >> -               debug("Unable to set kaslr-seed on chosen node: %s\n",=
 fdt_strerror(ret));
> >> -               return ret;
> >> -       }
> >> -
> >>          return 0;
> >>   }
> >>   #endif
> >> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> >> index 874ca4d6f5af..3455d60d69dc 100644
> >> --- a/boot/fdt_support.c
> >> +++ b/boot/fdt_support.c
> >> @@ -8,6 +8,7 @@
> >>
> >>   #include <abuf.h>
> >>   #include <env.h>
> >> +#include <kaslrseed.h>
> >>   #include <log.h>
> >>   #include <mapmem.h>
> >>   #include <net.h>
> >> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
> >>          if (nodeoffset < 0)
> >>                  return nodeoffset;
> >>
> >> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWAR=
E_SUPPORT)) {
> >> +               err =3D fdt_kaslrseed(fdt);
> >> +               if (err) {
> >> +                       printf("WARNING: could not set kaslr-seed %s.\=
n",
> >> +                              fdt_strerror(err));
> >> +                       return err;
> >> +               }
> >> +       }
> >> +
> >>          if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf=
)) {
> >>                  err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> >>                                    abuf_data(&buf), abuf_size(&buf));
> >> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> >> index 4b22bb6f525a..8d70233fc08d 100644
> >> --- a/boot/pxe_utils.c
> >> +++ b/boot/pxe_utils.c
> >> @@ -8,6 +8,7 @@
> >>   #include <dm.h>
> >>   #include <env.h>
> >>   #include <image.h>
> >> +#include <kaslrseed.h>
> >>   #include <log.h>
> >>   #include <malloc.h>
> >>   #include <mapmem.h>
> >> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
> >>   #if CONFIG_IS_ENABLED(DM_RNG)
> >>          ulong fdt_addr;
> >>          struct fdt_header *working_fdt;
> >> -       size_t n =3D 0x8;
> >> -       struct udevice *dev;
> >> -       u64 *buf;
> >> -       int nodeoffset;
> >>          int err;
> >>
> >>          /* Get the main fdt and map it */
> >> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
> >>          if (err <=3D 0)
> >>                  return;
> >>
> >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> >> -               printf("No RNG device\n");
> >> -               return;
> >> -       }
> >> -
> >> -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen=
");
> >> -       if (nodeoffset < 0) {
> >> -               printf("Reading chosen node failed\n");
> >> -               return;
> >> -       }
> >> -
> >> -       buf =3D malloc(n);
> >> -       if (!buf) {
> >> -               printf("Out of memory\n");
> >> -               return;
> >> -       }
> >> -
> >> -       if (dm_rng_read(dev, buf, n)) {
> >> -               printf("Reading RNG failed\n");
> >> -               goto err;
> >> -       }
> >> -
> >> -       err =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf=
, sizeof(buf));
> >> -       if (err < 0) {
> >> +       err =3D fdt_kaslrseed(working_fdt);
> >> +       if (err < 0)
> >>                  printf("Unable to set kaslr-seed on chosen node: %s\n=
", fdt_strerror(err));
> >> -               goto err;
> >> -       }
> >> -err:
> >> -       free(buf);
> >>   #endif
> >>          return;
> >>   }
> >> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> >> index e0d3c7fe7489..ea5c07d729cf 100644
> >> --- a/cmd/kaslrseed.c
> >> +++ b/cmd/kaslrseed.c
> >> @@ -9,33 +9,16 @@
> >>   #include <command.h>
> >>   #include <dm.h>
> >>   #include <hexdump.h>
> >> +#include <kaslrseed.h>
> >>   #include <malloc.h>
> >>   #include <rng.h>
> >>   #include <fdt_support.h>
> >>
> >>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, =
char *const argv[])
> >>   {
> >> -       size_t n =3D 0x8;
> >> -       struct udevice *dev;
> >> -       u64 *buf;
> >> -       int nodeoffset;
> >> -       int ret =3D CMD_RET_SUCCESS;
> >> +       int err;
> >>
> >> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> >> -               printf("No RNG device\n");
> >> -               return CMD_RET_FAILURE;
> >> -       }
> >> -
> >> -       buf =3D malloc(n);
> >> -       if (!buf) {
> >> -               printf("Out of memory\n");
> >> -               return CMD_RET_FAILURE;
> >> -       }
> >> -
> >> -       if (dm_rng_read(dev, buf, n)) {
> >> -               printf("Reading RNG failed\n");
> >> -               return CMD_RET_FAILURE;
> >> -       }
> >> +       printf("Notice: a /chosen/kaslr-seed is automatically added to=
 the device-tree when booted via booti/bootm/bootz therefore using this com=
mand is likely no longer needed");
> >>
> >>          if (!working_fdt) {
> >>                  printf("No FDT memory address configured. Please conf=
igure\n"
> >> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, in=
t flag, int argc, char *const
> >>                  return CMD_RET_FAILURE;
> >>          }
> >>
> >> -       ret =3D fdt_check_header(working_fdt);
> >> -       if (ret < 0) {
> >> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> >> +       err =3D fdt_kaslrseed(working_fdt);
> >> +       if (err < 0) {
> >> +               printf("Unable to set kaslr-seed on chosen node: %s\n"=
, fdt_strerror(err));
> >>                  return CMD_RET_FAILURE;
> >>          }
> >>
> >> -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen=
");
> >> -       if (nodeoffset < 0) {
> >> -               printf("Reading chosen node failed\n");
> >> -               return CMD_RET_FAILURE;
> >> -       }
> >> -
> >> -       ret =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf=
, sizeof(buf));
> >> -       if (ret < 0) {
> >> -               printf("Unable to set kaslr-seed on chosen node: %s\n"=
, fdt_strerror(ret));
> >> -               return CMD_RET_FAILURE;
> >> -       }
> >> -
> >> -       free(buf);
> >> -
> >> -       return ret;
> >> +       return CMD_RET_SUCCESS;
> >>   }
> >>
> >>   U_BOOT_LONGHELP(kaslrseed,
> >> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> >> new file mode 100644
> >> index 000000000000..3fe82f418acf
> >> --- /dev/null
> >> +++ b/include/kaslrseed.h
> >> @@ -0,0 +1,17 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> >> + */
> >> +
> >> +#if !defined _KASLRSEED_H_
> >> +#define _KASLRSEED_H_
> >> +
> >> +/**
> >> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> >> + *
> >> + * @blob:      fdt blob
> >> + * Return:     0 if OK, -ve on error
> >> + */
> >> +int fdt_kaslrseed(void *blob);
> >> +
> >> +#endif /* _KASLRSEED_H_ */
> >> diff --git a/lib/Makefile b/lib/Makefile
> >> index 2a76acf100d0..20a0242055fa 100644
> >> --- a/lib/Makefile
> >> +++ b/lib/Makefile
> >> @@ -149,6 +149,7 @@ obj-y +=3D date.o
> >>   obj-y +=3D rtc-lib.o
> >>   obj-$(CONFIG_LIB_ELF) +=3D elf.o
> >>
> >> +obj-$(CONFIG_DM_RNG) +=3D kaslrseed.o
> >>   obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) +=3D semihosting.o
> >>
> >>   #
> >> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> >> new file mode 100644
> >> index 000000000000..ad06bee2b88d
> >> --- /dev/null
> >> +++ b/lib/kaslrseed.c
> >> @@ -0,0 +1,34 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> >> + */
> >> +#include <dm.h>
> >> +#include <rng.h>
> >> +#include <fdt_support.h>
> >> +
> >> +int fdt_kaslrseed(void *fdt)
> >> +{
> >> +       struct udevice *dev;
> >> +       int nodeoffset;
> >> +       u64 data;
> >> +       int err;
> >> +
> >> +       err =3D fdt_check_header(fdt);
> >> +       if (err < 0)
> >> +               return err;
> >> +
> >> +       /* find or create "/chosen" node. */
> >> +       nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
> >> +       if (nodeoffset < 0)
> >> +               return nodeoffset;
> >> +
> >> +       err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> >> +       if (!err)
> >> +               err =3D dm_rng_read(dev, &data, sizeof(data));
> >> +       if (!err)
> >> +               err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &da=
ta, sizeof(data));
> >> +       if (err < 0)
> >> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_=
strerror(err));
>
> I have used debug messages to better track if error happens. I think it w=
ould be
> good if you can extend your code with it.
> Because if this fails people have to start tracking if issue is that ther=
e is
> RNG device or reading fails or issue with setting up property.

Hi Michal,

I'm assuming there is no valid case to have DM_RNG enabled and no
UCLASS_RNG driver which is why I'm printing an error if it ultimately
fails (vs a silent debug statement). If that is true then I should
probably printf errors for all the cases above vs debugs wouldn't you
think?

>
> In v1 it was said that you won't update it if the kaslr-seed property exi=
sts.
> I can't see this in the code. Or do I read it incorrectly?
>

That was a question posed in the discussion but I didn't get an answer
if that was what I should do. None of the three places I'm
deduplicating the functionality from check to see if it already
exists... they would overwrite an existing one. Is there a valid case
where you would not want to overwrite it?

>
> >> +
> >> +       return err;
> >> +}
> >> --
> >> 2.25.1
> >>
> >
> > I realized I forgot a few CC's here. Adding:
> >
> > Michal Simek <michal.simek@amd.com> (board/xilinx/common/board.c and
> > configs/xilinx* which have CMD_KASLRSEED)
> > Andy Yan <andy.yan@rock-chips.com> (configs/evb-rk3308_defconfig and
> > configs/roc-cc-rk3308_defconfig which have CMD_KASLRSEED)
> > Akash Gajjar <gajjar04akash@gmail.com>
> > (configs/rock-pi-s-rk3308_defconfig which has CMD_KASLRSEED)
> > Ilias Apalodimas <ilias.apalodimas@linaro.org> (MEASURE_DEVICETREE,
> > MEASURED_BOOT)
> >
> > Michal, I see that board/xilinx/common/board.c is adding
> > chosen/kaslr-seed in ft_board_setup as well as some of the
> > configs/xilinx boards enabling CMD_KASLRSEED - can we remove
> > CMD_ASLRSEED from those boards? (ie no bootscripts require it?)
>
>
> Based on my note above that you shouldn't change kaslr-seed if exists.

I can add that if you think it's the correct behavior, but that is not
what is done in the current code.

>
> What would also make sense is to extend kaslrseed command to pass one mor=
e
> parameter to pass which RNG instance should generate data on system with =
more
> RNGs. Then pretty much with command you can choose different RNG because =
current
> code hardcoded it to instance 0.

Do you mean extend the command or the fdt_kaslrseed function? I'm
trying to obsolete the command.

I can add an index to fdt_kaslrseed but would it be more useful to add
a udevice* that is used unless null? I can't see where someone wanting
to call this function would know the index of a specific UCLASS_RNG
device and not have the device * handy instead.

It sounds like with the question of not overwriting an existing value
you are anticipating board specific ft_board_setup functions that may
want to behave differently and choose a different rng source? If so,
ft_board_setup is called 'after' fdt_chosen so maybe fdt_kaslrseed
also needs a boolean to tell it to overwrite existing?

Are you open to removing CMD_KASLRSEED from the configs/xilinx* which
have it? If I can get everyone's approval for the few boards that
include CMD_KASLRSEED I would like to remove the command if we are
doing it automatically.

(adding Chris Morgan <macromorgan@hotmail.com> to cc who authored that cmd)

>
> Do you have correct dependency in generic code when MEASURED_BOOT is enab=
led as
> was mentioned in v1? If yes it should be mentioned in commit message.
>

Likely something is needed but I'm not sure if it's MEASURED_BOOT or
MEASURE_DEVICETREE - That's a question I posed to Ilias.

Best Regards,

Tim
