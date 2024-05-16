Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B9C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47A08825A;
	Thu, 16 May 2024 17:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OGBxG4SP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE9A88287; Thu, 16 May 2024 17:58:26 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1149D88258
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so3616090a12.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715875101; x=1716479901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5+q7qnRjKdcp82rSl8gEBpx3eEUGpEsNFAqv038CQk=;
 b=OGBxG4SPn8dEtbo5k05o8ZgkC+ztlyeXpt3L/OWI/+JlFgQOuAWPrEmpoQlZQE9rGz
 rvY/NCyd+/vSUHbBrY3iSURGABXquiwc6PVHzpuPqYXy+WCPWqtS5aFBqk83zqvqQ9ck
 UhYlKi/wIVntAAgJ8x6MRixxgGXjLQG+YqlnO818LK4dWNLtq2XG5BwQ3s2ozEUbcdhy
 cowx6kdsnm7VgAaVFPfjtPQmfgz2poBVs4LE7Gn53fHDraANo1GofQiXX2XEnsJF9gUu
 QZYuqqun7YE7sUxioliuLEo9M3QbU9YPUALl9zl71RFr4vFuGkJwDM0hrkz+eyqiuxsz
 HP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715875101; x=1716479901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5+q7qnRjKdcp82rSl8gEBpx3eEUGpEsNFAqv038CQk=;
 b=dSTd3WdD3BLuw0qwGfYoDR14jZ3TJ4Vs97Nb/u9EWR7QUasGm4CVPnOIcz7JxEBxlD
 HWnI/fJZzqaCP+5iP0NAtFRKqtF9gZCg3kcuutxdZCtilSG+jhvVlFkZMkNNT3rL7kId
 RAmJzVbUe03A42Hv0FeeVzx3HEf9K2RxxVoJ0e7KQUmSnCDtlK6Ml4yXB3PbPhpRs7Kp
 HztLiQNMnzErKA/sUhZyoEN/pyVG69kWJLVPHQ80Zdk74A5ncw62yjBHOvd8NuZ+ZefM
 cKz9RFd6JVVQfrwfCTTOzpWlz4yCYryqdLtPHRuW7mlQNnaXd5PXJarE4Avl8FWcMokD
 8GQw==
X-Gm-Message-State: AOJu0YxP5G14CZOJdaFy+3xQT4x1b0/S60f3OY/D5P21E8J5tWwHRvL6
 CUU6bnzzEOR4jkUWz4SGljEAvb+VVW9U/fvejwdTS7sjkwpkJORhOeV9wh00rBYy74t+IwGV0PI
 XdN/Z95ajIDRuR+cGvOchfmV2Y5KaCc+GBvFCQryK0qhy7Kl3DpVTlw==
X-Google-Smtp-Source: AGHT+IH1S1l6OXXG0xKzETC4vMSnbgrlkXbUq+OSeeq6LTsDdWNgKEAzhYqf3+ABhnHNSbDpb01tXC4+vawWa2r2YZ0=
X-Received: by 2002:a17:906:c78c:b0:a5a:1b60:7c9a with SMTP id
 a640c23a62f3a-a5a2d676415mr1759866766b.71.1715875101194; Thu, 16 May 2024
 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240515205049.3005256-1-tharvey@gateworks.com>
In-Reply-To: <20240515205049.3005256-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 May 2024 08:58:09 -0700
Message-ID: <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
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

On Wed, May 15, 2024 at 1:50=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> it's implementation uses a different source of entropy.
>
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code.
>
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>  - fix typo in commit msg
>  - use stack for seed to avoid unecessary malloc/free
>  - move to a library function and deduplicate code by using it elsewhere
> ---
>  board/xilinx/common/board.c | 35 -----------------------------
>  boot/fdt_support.c          | 10 +++++++++
>  boot/pxe_utils.c            | 35 +++--------------------------
>  cmd/kaslrseed.c             | 45 ++++++-------------------------------
>  include/kaslrseed.h         | 17 ++++++++++++++
>  lib/Makefile                |  1 +
>  lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
>  7 files changed, 72 insertions(+), 105 deletions(-)
>  create mode 100644 include/kaslrseed.h
>  create mode 100644 lib/kaslrseed.c
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 30a81376ac41..f741e8957818 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>         if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_=
NAND_ZYNQ))
>                 fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               debug("No RNG device\n");
> -               return 0;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               debug("Reading RNG failed\n");
> -               return 0;
> -       }
> -
> -       if (!blob) {
> -               debug("No FDT memory address configured. Please configure=
\n"
> -                     "the FDT address via \"fdt addr <address>\" command=
.\n"
> -                     "Aborting!\n");
> -               return 0;
> -       }
> -
> -       ret =3D fdt_check_header(blob);
> -       if (ret < 0) {
> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> -               return ret;
> -       }
> -
> -       nodeoffset =3D fdt_find_or_add_subnode(blob, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               debug("Reading chosen node failed\n");
> -               return nodeoffset;
> -       }
> -
> -       ret =3D fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(b=
uf));
> -       if (ret < 0) {
> -               debug("Unable to set kaslr-seed on chosen node: %s\n", fd=
t_strerror(ret));
> -               return ret;
> -       }
> -
>         return 0;
>  }
>  #endif
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..3455d60d69dc 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -8,6 +8,7 @@
>
>  #include <abuf.h>
>  #include <env.h>
> +#include <kaslrseed.h>
>  #include <log.h>
>  #include <mapmem.h>
>  #include <net.h>
> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>         if (nodeoffset < 0)
>                 return nodeoffset;
>
> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_S=
UPPORT)) {
> +               err =3D fdt_kaslrseed(fdt);
> +               if (err) {
> +                       printf("WARNING: could not set kaslr-seed %s.\n",
> +                              fdt_strerror(err));
> +                       return err;
> +               }
> +       }
> +
>         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>                 err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
>                                   abuf_data(&buf), abuf_size(&buf));
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 4b22bb6f525a..8d70233fc08d 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -8,6 +8,7 @@
>  #include <dm.h>
>  #include <env.h>
>  #include <image.h>
> +#include <kaslrseed.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>  #if CONFIG_IS_ENABLED(DM_RNG)
>         ulong fdt_addr;
>         struct fdt_header *working_fdt;
> -       size_t n =3D 0x8;
> -       struct udevice *dev;
> -       u64 *buf;
> -       int nodeoffset;
>         int err;
>
>         /* Get the main fdt and map it */
> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
>         if (err <=3D 0)
>                 return;
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               printf("No RNG device\n");
> -               return;
> -       }
> -
> -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               printf("Reading chosen node failed\n");
> -               return;
> -       }
> -
> -       buf =3D malloc(n);
> -       if (!buf) {
> -               printf("Out of memory\n");
> -               return;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               printf("Reading RNG failed\n");
> -               goto err;
> -       }
> -
> -       err =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, s=
izeof(buf));
> -       if (err < 0) {
> +       err =3D fdt_kaslrseed(working_fdt);
> +       if (err < 0)
>                 printf("Unable to set kaslr-seed on chosen node: %s\n", f=
dt_strerror(err));
> -               goto err;
> -       }
> -err:
> -       free(buf);
>  #endif
>         return;
>  }
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index e0d3c7fe7489..ea5c07d729cf 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -9,33 +9,16 @@
>  #include <command.h>
>  #include <dm.h>
>  #include <hexdump.h>
> +#include <kaslrseed.h>
>  #include <malloc.h>
>  #include <rng.h>
>  #include <fdt_support.h>
>
>  static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char=
 *const argv[])
>  {
> -       size_t n =3D 0x8;
> -       struct udevice *dev;
> -       u64 *buf;
> -       int nodeoffset;
> -       int ret =3D CMD_RET_SUCCESS;
> +       int err;
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               printf("No RNG device\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       buf =3D malloc(n);
> -       if (!buf) {
> -               printf("Out of memory\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               printf("Reading RNG failed\n");
> -               return CMD_RET_FAILURE;
> -       }
> +       printf("Notice: a /chosen/kaslr-seed is automatically added to th=
e device-tree when booted via booti/bootm/bootz therefore using this comman=
d is likely no longer needed");
>
>         if (!working_fdt) {
>                 printf("No FDT memory address configured. Please configur=
e\n"
> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int f=
lag, int argc, char *const
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret =3D fdt_check_header(working_fdt);
> -       if (ret < 0) {
> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> +       err =3D fdt_kaslrseed(working_fdt);
> +       if (err < 0) {
> +               printf("Unable to set kaslr-seed on chosen node: %s\n", f=
dt_strerror(err));
>                 return CMD_RET_FAILURE;
>         }
>
> -       nodeoffset =3D fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               printf("Reading chosen node failed\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       ret =3D fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, s=
izeof(buf));
> -       if (ret < 0) {
> -               printf("Unable to set kaslr-seed on chosen node: %s\n", f=
dt_strerror(ret));
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       free(buf);
> -
> -       return ret;
> +       return CMD_RET_SUCCESS;
>  }
>
>  U_BOOT_LONGHELP(kaslrseed,
> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> new file mode 100644
> index 000000000000..3fe82f418acf
> --- /dev/null
> +++ b/include/kaslrseed.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +
> +#if !defined _KASLRSEED_H_
> +#define _KASLRSEED_H_
> +
> +/**
> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> + *
> + * @blob:      fdt blob
> + * Return:     0 if OK, -ve on error
> + */
> +int fdt_kaslrseed(void *blob);
> +
> +#endif /* _KASLRSEED_H_ */
> diff --git a/lib/Makefile b/lib/Makefile
> index 2a76acf100d0..20a0242055fa 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -149,6 +149,7 @@ obj-y +=3D date.o
>  obj-y +=3D rtc-lib.o
>  obj-$(CONFIG_LIB_ELF) +=3D elf.o
>
> +obj-$(CONFIG_DM_RNG) +=3D kaslrseed.o
>  obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) +=3D semihosting.o
>
>  #
> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> new file mode 100644
> index 000000000000..ad06bee2b88d
> --- /dev/null
> +++ b/lib/kaslrseed.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +#include <dm.h>
> +#include <rng.h>
> +#include <fdt_support.h>
> +
> +int fdt_kaslrseed(void *fdt)
> +{
> +       struct udevice *dev;
> +       int nodeoffset;
> +       u64 data;
> +       int err;
> +
> +       err =3D fdt_check_header(fdt);
> +       if (err < 0)
> +               return err;
> +
> +       /* find or create "/chosen" node. */
> +       nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
> +       if (nodeoffset < 0)
> +               return nodeoffset;
> +
> +       err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> +       if (!err)
> +               err =3D dm_rng_read(dev, &data, sizeof(data));
> +       if (!err)
> +               err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data,=
 sizeof(data));
> +       if (err < 0)
> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_str=
error(err));
> +
> +       return err;
> +}
> --
> 2.25.1
>

I realized I forgot a few CC's here. Adding:

Michal Simek <michal.simek@amd.com> (board/xilinx/common/board.c and
configs/xilinx* which have CMD_KASLRSEED)
Andy Yan <andy.yan@rock-chips.com> (configs/evb-rk3308_defconfig and
configs/roc-cc-rk3308_defconfig which have CMD_KASLRSEED)
Akash Gajjar <gajjar04akash@gmail.com>
(configs/rock-pi-s-rk3308_defconfig which has CMD_KASLRSEED)
Ilias Apalodimas <ilias.apalodimas@linaro.org> (MEASURE_DEVICETREE,
MEASURED_BOOT)

Michal, I see that board/xilinx/common/board.c is adding
chosen/kaslr-seed in ft_board_setup as well as some of the
configs/xilinx boards enabling CMD_KASLRSEED - can we remove
CMD_ASLRSEED from those boards? (ie no bootscripts require it?)

Andy, if we automatically add chosen/kaslr-seed in fdt_chosen can we
remove CMD_KASLRSEED from configs/evb-rk3308_defconfig and
configs/roc-cc-rk3308_defconfig? (ie no bootscripts require it?)

Akash, if we automatically add chosen/kaslr-seed in fdt_chosen can we
remove CMD_KASLRSEED from configs/rock-pi-s-rk3308_defconfig? (ie no
bootscripts require it?)

Ilias, this patch adds chosen/kaslr-seed in fdt_chosen automatically
if DM_RNG is enabled, should I skip that for MEASURE_DEVICETREE?

Tom, can sec_firmware.c be moved to dm-rng to eliminate the need for a
separate fdt_fixup_kaslr?

Best Regards,

Tim
