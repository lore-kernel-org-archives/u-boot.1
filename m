Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C4C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5868841D;
	Tue, 28 May 2024 17:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="JEkKcqBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045F888544; Tue, 28 May 2024 17:55:28 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B5E87128
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a62972c88a9so138110666b.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1716911724; x=1717516524; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=096RYAlKLVQv+klOw5eAf3jtoRwX3P8Sxov1GEi7Gsg=;
 b=JEkKcqBX+KAzfOnPwpdNyw0zGHjO84VaG85E30MsP5l5L/W571szBuK3kxGGO/p31F
 BiGI0bZMH3AAa1JxhSv8PBqwtkzk1mIQRRLeTWOXov7it2UwQFMjIUF7vSKIJS9qtTUL
 MYIN/PR83607fgEx+WvAoYEOC7cfEZzlshP6H+atVLsj5n8wIKlSpm7Xyaoqm6RhHhUx
 gLXvlfv85vcrSu6F8vgxErg47FkaA2x/udciFJcpWOSuvNfQEc/LBpk5/TkhoiwSfu9r
 MKeujbC6rE4KuBKRRb9LXwPFpfrVqGNZ7obENiVWqTG8uJLHv17jobvwbMZ9Rkq96cOc
 mPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911724; x=1717516524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=096RYAlKLVQv+klOw5eAf3jtoRwX3P8Sxov1GEi7Gsg=;
 b=Z7k9bRl8x39ukqHgrmMhd7Cy+kNP83cYiZxT58yoVSm7OgGAII2aPJgNGDgIt9YdPF
 CjnqJ1bz6UVjNhQihMfz3eXU10Cc1oFdD5XPAqmKQPYQRzuFBZhg9RAb7LrlYlGs8g4E
 O0kL/Tb4TMLP9igkhyP2Peo2SPdiaPYOGKI2RkV/iqv0JV+Rs8Ws75tQwu3NXq4Y/GBI
 eM0YpvrCqpQZ1T7LIzS116TTJRuQUvL1HRL2C96XkZair29YH1YL0lMDSycta0WbgyrE
 LtSB4OtiWUJ48RKH4ICvNSxn4Y1U2hC4F73wln2TQVNLhtjO4Bf+MkneWggeTXLdfMZR
 63MQ==
X-Gm-Message-State: AOJu0Yz25cUoR/6XNIlou2AEkEtYbyvnLawmvICtUd8xcsySbN5RibXH
 Lgk4V4Fx+s1NMleAGyVM2vCTW232Hq1JEumV8m30wEOdCaT9/5xIi1YxxpIee+EaDZciWC/1v8f
 IRXbbNyyd/6Akqc0I1/0mXtJEOOj0TmgnGVttjw==
X-Google-Smtp-Source: AGHT+IEM1KS1CUdcyatlAUteTo6PpbYwa0cZycbh/0e41ONN1y+k0lKSa+FzLcNsU8dlvLw27F5GQ3E8JOH1mjk8Tnk=
X-Received: by 2002:a17:906:4a89:b0:a63:5196:9d33 with SMTP id
 a640c23a62f3a-a6351969ec3mr125423266b.74.1716911724654; Tue, 28 May 2024
 08:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200249.3904352-1-tharvey@gateworks.com>
 <4d428c50-1396-4f6b-a9dc-0f3cc925ab4e@amd.com>
In-Reply-To: <4d428c50-1396-4f6b-a9dc-0f3cc925ab4e@amd.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 28 May 2024 08:55:12 -0700
Message-ID: <CAJ+vNU1q6J9GPV+YQ1N8xOvbja4a83krGZN2RzC_465t=iHA_A@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Andy Yan <andy.yan@rock-chips.com>, 
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

On Mon, May 27, 2024 at 1:30=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 5/25/24 22:02, Tim Harvey wrote:
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > If we have DM_RNG enabled populate this value automatically when
> > fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> > is enabled as it's implementation uses a different source of entropy
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
> >   - add missing /n to notice in kaslrseed cmd
> >   - combine ints in declaration
> >   - remove unused vars from board/xilinx/common/board.c ft_board_setup
> > v3:
> >   - skip if CONFIG_MEASURED_BOOT
> >   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
> >   - pass in rng index and bool to specify overwrite
> >   - remove duplicate error strings printed outside of fdt_kaslrseed
> >   - added note to commit log about how EFI STUB weeds out kalsr-seed
> > v2:
> >   - fix typo in commit msg
> >   - use stack for seed to avoid unecessary malloc/free
> >   - move to a library function and deduplicate code by using it
> >     elsewhere
> > ---
> >   board/xilinx/common/board.c | 40 ------------------------------
> >   boot/fdt_support.c          |  6 +++++
> >   boot/pxe_utils.c            | 35 ++------------------------
> >   cmd/kaslrseed.c             | 45 +++++-----------------------------
> >   include/kaslrseed.h         | 19 ++++++++++++++
> >   lib/Makefile                |  1 +
> >   lib/kaslrseed.c             | 49 ++++++++++++++++++++++++++++++++++++=
+
> >   7 files changed, 83 insertions(+), 112 deletions(-)
> >   create mode 100644 include/kaslrseed.h
> >   create mode 100644 lib/kaslrseed.c
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 30a81376ac41..0b43407b9e94 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -701,11 +701,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t t=
otal_size)
> >   #define MAX_RAND_SIZE 8
> >   int ft_board_setup(void *blob, struct bd_info *bd)
> >   {
> > -     size_t n =3D MAX_RAND_SIZE;
> > -     struct udevice *dev;
> > -     u8 buf[MAX_RAND_SIZE];
> > -     int nodeoffset, ret;
> > -
> >       static const struct node_info nodes[] =3D {
> >               { "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
> >       };
> > @@ -713,41 +708,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >       if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_=
NAND_ZYNQ))
> >               fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> >
> > -     if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -             debug("No RNG device\n");
> > -             return 0;
> > -     }
> > -
> > -     if (dm_rng_read(dev, buf, n)) {
> > -             debug("Reading RNG failed\n");
> > -             return 0;
> > -     }
> > -
> > -     if (!blob) {
> > -             debug("No FDT memory address configured. Please configure=
\n"
> > -                   "the FDT address via \"fdt addr <address>\" command=
.\n"
> > -                   "Aborting!\n");
> > -             return 0;
> > -     }
> > -
> > -     ret =3D fdt_check_header(blob);
> > -     if (ret < 0) {
> > -             debug("fdt_chosen: %s\n", fdt_strerror(ret));
> > -             return ret;
> > -     }
> > -
> > -     nodeoffset =3D fdt_find_or_add_subnode(blob, 0, "chosen");
> > -     if (nodeoffset < 0) {
> > -             debug("Reading chosen node failed\n");
> > -             return nodeoffset;
> > -     }
> > -
> > -     ret =3D fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(b=
uf));
> > -     if (ret < 0) {
> > -             debug("Unable to set kaslr-seed on chosen node: %s\n", fd=
t_strerror(ret));
> > -             return ret;
> > -     }
> > -
> >       return 0;
> >   }
> >   #endif
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 874ca4d6f5af..b64cdd34825a 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -8,6 +8,7 @@
> >
> >   #include <abuf.h>
> >   #include <env.h>
> > +#include <kaslrseed.h>
> >   #include <log.h>
> >   #include <mapmem.h>
> >   #include <net.h>
> > @@ -300,6 +301,11 @@ int fdt_chosen(void *fdt)
> >       if (nodeoffset < 0)
> >               return nodeoffset;
> >
> > +     if (IS_ENABLED(CONFIG_DM_RNG) &&
> > +         !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> > +         !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> > +             fdt_kaslrseed(fdt, 0, false);
> > +
> >       if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
> >               err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> >                                 abuf_data(&buf), abuf_size(&buf));
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index 4b22bb6f525a..35d5b9ed3ecc 100644
> > --- a/boot/pxe_utils.c
> > +++ b/boot/pxe_utils.c
> > @@ -8,6 +8,7 @@
> >   #include <dm.h>
> >   #include <env.h>
> >   #include <image.h>
> > +#include <kaslrseed.h>
> >   #include <log.h>
> >   #include <malloc.h>
> >   #include <mapmem.h>
> > @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
> >   #if CONFIG_IS_ENABLED(DM_RNG)
> >       ulong fdt_addr;
> >       struct fdt_header *working_fdt;
> > -     size_t n =3D 0x8;
> > -     struct udevice *dev;
> > -     u64 *buf;
> > -     int nodeoffset;
> >       int err;
> >
> >       /* Get the main fdt and map it */
> > @@ -342,35 +339,7 @@ static void label_boot_kaslrseed(void)
> >       if (err <=3D 0)
> >               return;
> >
> > -     if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -             printf("No RNG device\n");
> > -             return;
> > -     }
> > -
> > -     nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > -     if (nodeoffset < 0) {
> > -             printf("Reading chosen node failed\n");
> > -             return;
> > -     }
> > -
> > -     buf =3D malloc(n);
> > -     if (!buf) {
> > -             printf("Out of memory\n");
> > -             return;
> > -     }
> > -
> > -     if (dm_rng_read(dev, buf, n)) {
> > -             printf("Reading RNG failed\n");
> > -             goto err;
> > -     }
> > -
> > -     err =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, s=
izeof(buf));
> > -     if (err < 0) {
> > -             printf("Unable to set kaslr-seed on chosen node: %s\n", f=
dt_strerror(err));
> > -             goto err;
> > -     }
> > -err:
> > -     free(buf);
> > +     fdt_kaslrseed(working_fdt, 0, true);
> >   #endif
> >       return;
> >   }
> > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > index e0d3c7fe7489..ebe4058d7ac6 100644
> > --- a/cmd/kaslrseed.c
> > +++ b/cmd/kaslrseed.c
> > @@ -9,33 +9,16 @@
> >   #include <command.h>
> >   #include <dm.h>
> >   #include <hexdump.h>
> > +#include <kaslrseed.h>
> >   #include <malloc.h>
> >   #include <rng.h>
> >   #include <fdt_support.h>
> >
> >   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, c=
har *const argv[])
> >   {
> > -     size_t n =3D 0x8;
> > -     struct udevice *dev;
> > -     u64 *buf;
> > -     int nodeoffset;
> > -     int ret =3D CMD_RET_SUCCESS;
> > +     int err;
> >
> > -     if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > -             printf("No RNG device\n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > -
> > -     buf =3D malloc(n);
> > -     if (!buf) {
> > -             printf("Out of memory\n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > -
> > -     if (dm_rng_read(dev, buf, n)) {
> > -             printf("Reading RNG failed\n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     printf("Notice: a /chosen/kaslr-seed is automatically added to th=
e device-tree when booted via booti/bootm/bootz therefore using this comman=
d is likely no longer needed\n");
> >
> >       if (!working_fdt) {
> >               printf("No FDT memory address configured. Please configur=
e\n"
> > @@ -44,27 +27,11 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int=
 flag, int argc, char *const
> >               return CMD_RET_FAILURE;
> >       }
> >
> > -     ret =3D fdt_check_header(working_fdt);
> > -     if (ret < 0) {
> > -             printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > +     err =3D fdt_kaslrseed(working_fdt, 0, true);
> > +     if (err < 0)
> >               return CMD_RET_FAILURE;
> > -     }
> > -
> > -     nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > -     if (nodeoffset < 0) {
> > -             printf("Reading chosen node failed\n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > -
> > -     ret =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, s=
izeof(buf));
> > -     if (ret < 0) {
> > -             printf("Unable to set kaslr-seed on chosen node: %s\n", f=
dt_strerror(ret));
> > -             return CMD_RET_FAILURE;
> > -     }
> > -
> > -     free(buf);
> >
> > -     return ret;
> > +     return CMD_RET_SUCCESS;
>
> You should consider to use standard function here.
> return cmd_process_error(cmdtp, err);

how about this on top?:

diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index ebe4058d7ac6..3e93369e9372 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -16,7 +16,7 @@

 static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc,
char *const argv[])
 {
-       int err;
+       int err =3D CMD_RET_SUCCESS;

        printf("Notice: a /chosen/kaslr-seed is automatically added to
the device-tree when booted via booti/bootm/bootz therefore us
ing this command is likely no longer needed\n");

@@ -24,14 +24,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp,
int flag, int argc, char *const
                printf("No FDT memory address configured. Please configure\=
n"
                       "the FDT address via \"fdt addr <address>\" command.=
\n"
                       "Aborting!\n");
-               return CMD_RET_FAILURE;
+               err =3D CMD_RET_FAILURE;
+       } else {
+               if (fdt_kaslrseed(working_fdt, 0, true) < 0)
+                       err =3D CMD_RET_FAILURE;
        }

-       err =3D fdt_kaslrseed(working_fdt, 0, true);
-       if (err < 0)
-               return CMD_RET_FAILURE;
-
-       return CMD_RET_SUCCESS;
+       return cmd_process_error(cmdtp, err);
 }

 U_BOOT_LONGHELP(kaslrseed,

Best Regards,

Tim


>
> Anyway looks good to me.
> Acked-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Michal Simek <michal.simek@amd.com> # ZynqMP Kria
>
> Thanks,
> Michal
