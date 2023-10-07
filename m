Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812FAE95A80
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FA786DD5;
	Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VqBDSMC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F63886DF5; Sun,  8 Oct 2023 01:12:21 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF6286D82
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59c215f2f4aso40848677b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720286; x=1697325086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/i6Ilta+bxRrw3q3+FQ+SfFUvFwlqxSugD4YKuJ1rbI=;
 b=VqBDSMC2lCjwvcP1QjZoQ6WpFFMHhGxLoQDOxpd6LGCe13pOVkrnA9LLhhcvR2qIrH
 t8wo8KgkQoy3+VnTq0akOF+6mwicbbK8QmsB1jxqPW9F88Nj8uBL+yESwckOOG8KclaT
 5C47B7IFSLAY47DdH4MAurV3Im+kAF/PqdDojGdtGfQrTDqn5q4UGwMIgXfbVVyw2wPk
 dUZRHLlD54/7woP8yMWlvHw+065CR2bJawauRBzzn5XGMaPYrZy77v6KnCczLbPMY5T5
 DUwH1A/RqfHVwdy+gV4VrvQZmZfTtIDf4WcEiBNpaw3o1camZCxWpBA5hJmYcLr6mOzf
 jAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720286; x=1697325086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/i6Ilta+bxRrw3q3+FQ+SfFUvFwlqxSugD4YKuJ1rbI=;
 b=ZswE259zyK/IxlsMGDeP0DPW2YYOtpEIlzxqvyirl0FAiQ4UE+UX698DAECry5g5WU
 rHW3ecORc2QGKsbc4suxZHe7Ns2g2HAEDs7gBJC9JOksKLNGwoWmlDfkXvKjSk4vfvva
 LkmB4KDDcOMPKn9sH+rnrZezd/y++aQ/l1l/RDxjiizaSKmD/qdtzw3DUoJ83c+g+vKE
 zbb6GkpZFkjhHS723abQWZal3Osi1EtYVCxLVAQFGMd3PyZSRYjwAKMgLJRrF4D34AQ7
 U8B4PL00xMNE1gUb/fJxVfDZZLRXu+9YTOX2e6M1qHpnIGZ7dqYX6wckg07yC5fpyRfB
 UFEA==
X-Gm-Message-State: AOJu0Yyszjo71TLuT+04dTSzgZzJaOszC33ibJT5V2qAO6BZl8087NQI
 3TYUY1bR/mWBDc8Mzj+iPBN7+nJJCGY0tuhqUvQhFdu5q75fsf0z+dw=
X-Google-Smtp-Source: AGHT+IEZoH/pT4yBAxJiUTykyhHx50J8xtUTu0ERqiYZlWcRdHSREh40pX2IbUVy9zrE+CjqwhlWEtnn22bXmOeuh/I=
X-Received: by 2002:a0d:d611:0:b0:577:1560:9e17 with SMTP id
 y17-20020a0dd611000000b0057715609e17mr12455450ywd.35.1696720285467; Sat, 07
 Oct 2023 16:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <ZSCw7eCcnSRpgkBN@alg-gentoo>
In-Reply-To: <ZSCw7eCcnSRpgkBN@alg-gentoo>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:10:02 -0600
Message-ID: <CAPnjgZ1jyvKku8V5UKqVxBHC4qEy7EtHN+yBuUNQW0pxxHpwkg@mail.gmail.com>
Subject: Re: [PATCH] cmd: mbr: Allow 4 MBR partitions without need for extended
To: Alexander Gendin <agendin@matrox.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexander,

On Fri, 6 Oct 2023 at 21:58, Alexander Gendin <agendin@matrox.com> wrote:
>
> Current code allows up to 3 MBR partitions without extended one.
> If more than 3 partitions are required, then extended partition(s)
> must be used.
> This commit allows up to 4 primary MBR partitions without the
> need for extended partition.
>
> Add mbr test unit. In order to use the test, mmc1.img file of size
> 12 MiB or greater is required in the same directory as u-boot.
> Running mbr test is only supported in sandbox mode.
>
> Signed-off-by: Alex Gendin <agendin@matrox.com>
> ---
>  disk/part_dos.c       |   2 +-
>  include/test/suites.h |   1 +
>  test/cmd/Makefile     |   1 +
>  test/cmd/mbr.c        | 440 ++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c         |   4 +
>  5 files changed, 447 insertions(+), 1 deletion(-)
>  create mode 100644 test/cmd/mbr.c

This looks OK apart from one thing...also I have a few suggestions /
questions below.

>
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 3337438437..567ead7511 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -466,7 +466,7 @@ int layout_mbr_partitions(struct disk_partition *p, int count,
>                         ext = &p[i];
>         }
>
> -       if (count < 4)
> +       if (count <= 4)
>                 return 0;
>
>         if (!ext) {
> diff --git a/include/test/suites.h b/include/test/suites.h
> index 1c7dc65966..51acbe47b2 100644
> --- a/include/test/suites.h
> +++ b/include/test/suites.h
> @@ -45,6 +45,7 @@ int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
> +int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 6e3d7e919e..2f251e07b4 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_CMD_PINMUX) += pinmux.o
>  obj-$(CONFIG_CMD_PWM) += pwm.o
>  obj-$(CONFIG_CMD_SEAMA) += seama.o
>  ifdef CONFIG_SANDBOX
> +obj-$(CONFIG_CMD_MBR) += mbr.o
>  obj-$(CONFIG_CMD_READ) += rw.o
>  obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
> diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
> new file mode 100644
> index 0000000000..bedcef0638
> --- /dev/null
> +++ b/test/cmd/mbr.c
> @@ -0,0 +1,440 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for mbr command
> + *
> + * Copyright 2023 Matrox Video
> + * Written by Alex Gendin <agendin@matrox.com>
> + */
> +
> +#include <common.h>
> +#include <console.h>
> +#include <mapmem.h>
> +#include <part.h>
> +#include <asm/global_data.h>
> +#include <test/suites.h>
> +#include <test/ut.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +/*
> + * Test requirements:
> + * mmc1.img - File size needs to be at least 12 MiB
> + *
> + * Command to create mmc1.img:
> + * $ dd if=/dev/zero of=mmc1.img bs=12M count=1
> + *
> + * Place mmc1.img into the same directory as sandboxed u-boot
> + *
> + * To run this test manually:
> + * $ ./u-boot -Tc 'ut mbr'

These requirements need to be dealt with by a test script. You can set
up this device in test_ut_dm_init_bootstd(). You may need to create a
new mmc as the others are in use.

> + */
> +
> +static char * mbr_parts_header = "setenv mbr_parts '";
> +static char * mbr_parts_p1 = "uuid_disk=0x12345678;name=p1,start=8M,bootable,size=1M,id=0x0e";
> +static char * mbr_parts_p2 = ";name=p2,size=1M,id=0x0e";
> +static char * mbr_parts_p3 = ";name=p3,size=1M,id=0x0e";
> +static char * mbr_parts_p4 = ";name=p4,size=1M,id=0x0e";
> +static char * mbr_parts_p5 = ";name=[ext],size=2M,id=0x05;name=p5,size=1M,id=0x0e";
> +static char * mbr_parts_tail = "'";
> +
> +/*
> + * One MBR partition
> +000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 00  |...%$..@........|
> +000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +*/
> +static unsigned mbr_cmp_start = 0x1B8;
> +static unsigned mbr_cmp_size = 0x48;
> +static unsigned char mbr_parts_ref_p1[] = {
> +                                                0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
> +0x05, 0x01, 0x0e, 0x25, 0x24, 0x01, 0x00, 0x40, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> +};
> +
> +/*
> + * Two MBR partitions
> +000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 00  |%..F...H........|
> +000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +*/
> +static unsigned char mbr_parts_ref_p2[] = {
> +                                                0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
> +0x05, 0x01, 0x0e, 0x25, 0x24, 0x01, 0x00, 0x40, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x25,
> +0x25, 0x01, 0x0e, 0x46, 0x05, 0x01, 0x00, 0x48, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> +};
> +
> +/*
> + * Three MBR partitions
> +000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 00  |...f%..P........|
> +000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +*/
> +static unsigned char mbr_parts_ref_p3[] = {
> +                                                0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
> +0x05, 0x01, 0x0e, 0x25, 0x24, 0x01, 0x00, 0x40, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x25,
> +0x25, 0x01, 0x0e, 0x46, 0x05, 0x01, 0x00, 0x48, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x46,
> +0x06, 0x01, 0x0e, 0x66, 0x25, 0x01, 0x00, 0x50, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> +};
> +
> +/*
> + * Four MBR partitions
> +000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
> +000001f0  26 01 0e 87 06 01 00 58  00 00 00 08 00 00 55 aa  |&......X......U.|
> +*/
> +static unsigned char mbr_parts_ref_p4[] = {
> +                                                0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
> +0x05, 0x01, 0x0e, 0x25, 0x24, 0x01, 0x00, 0x40, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x25,
> +0x25, 0x01, 0x0e, 0x46, 0x05, 0x01, 0x00, 0x48, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x46,
> +0x06, 0x01, 0x0e, 0x66, 0x25, 0x01, 0x00, 0x50, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x66,
> +0x26, 0x01, 0x0e, 0x87, 0x06, 0x01, 0x00, 0x58, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x55, 0xaa
> +};
> +
> +/*
> + * Five MBR partitions
> +000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
> +000001f0  26 01 05 a7 26 01 00 58  00 00 00 10 00 00 55 aa  |&...&..X......U.|
> +*/
> +static unsigned char mbr_parts_ref_p5[] = {
> +                                                0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
> +0x05, 0x01, 0x0e, 0x25, 0x24, 0x01, 0x00, 0x40, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x25,
> +0x25, 0x01, 0x0e, 0x46, 0x05, 0x01, 0x00, 0x48, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x46,
> +0x06, 0x01, 0x0e, 0x66, 0x25, 0x01, 0x00, 0x50, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x66,
> +0x26, 0x01, 0x05, 0xa7, 0x26, 0x01, 0x00, 0x58, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x55, 0xaa
> +};
> +static unsigned ebr_cmp_start = 0x1B8;
> +static unsigned ebr_cmp_size = 0x48;
> +/*
> + * EBR
> +00b001b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 87  |................|
> +00b001c0  07 01 0e a7 26 01 00 08  00 00 00 08 00 00 00 00  |....&...........|
> +00b001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +00b001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +00b001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +*/
> +static unsigned char ebr_parts_ref_p5[] = {
> +                                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87,
> +0x07, 0x01, 0x0e, 0xa7, 0x26, 0x01, 0x00, 0x08, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> +};

What do you think about creating these in code? E.g. have a function
which outputs the bytes for a partition and then call it 1 to 4 times?

> +
> +static void init_buffers(char *rb, size_t rb_size, char *mbr_wb, size_t mbr_wb_size,
> +                       char *ebr_wb, size_t ebr_wb_size, unsigned seed)

Needs a comment

> +{
> +       memset(rb, 0, rb_size);
> +       while (mbr_wb_size--) {
> +               *mbr_wb++ = seed;
> +               seed *= 43;
> +               seed += 17 + mbr_wb_size/4;
> +       }
> +       while (ebr_wb_size--) {
> +               *ebr_wb++ = seed;
> +               seed *= 43;
> +               seed += 17 + ebr_wb_size/4;
> +       }
> +}
> +
> +static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
> +{
> +       size_t bytes_remaining, cur_str_size;
> +       char * cur_buf;
> +
> +       if (0 == num_parts || 5 < num_parts || NULL == buf)
> +               return 1;

!num_parts
!buf

(we normally put the var before the value, so numparts >= 5)

> +
> +       cur_buf = buf;
> +       *cur_buf = '\0';
> +       bytes_remaining = buf_size;
> +
> +       cur_str_size = sizeof(mbr_parts_header);
> +       if (1 + cur_str_size > bytes_remaining)

Again, better to use cur_str_size + 1

> +               return 1;
> +       strcat(cur_buf, mbr_parts_header);
> +       bytes_remaining -= cur_str_size;
> +
> +       if (1 <= num_parts) {
> +               cur_str_size = sizeof(mbr_parts_p1);
> +               if (1 + cur_str_size > bytes_remaining)
> +                       return 1;
> +               strcat(cur_buf, mbr_parts_p1);
> +               bytes_remaining -= cur_str_size;
> +
> +               if (2 <= num_parts) {
> +                       cur_str_size = sizeof(mbr_parts_p2);
> +                       if (1 + cur_str_size > bytes_remaining)
> +                               return 1;
> +                       strcat(cur_buf, mbr_parts_p2);
> +                       bytes_remaining -= cur_str_size;
> +
> +                       if (3 <= num_parts) {
> +                               cur_str_size = sizeof(mbr_parts_p3);
> +                               if (1 + cur_str_size > bytes_remaining)
> +                                       return 1;
> +                               strcat(cur_buf, mbr_parts_p3);
> +                               bytes_remaining -= cur_str_size;
> +
> +                               if (4 == num_parts) {
> +                                       cur_str_size = sizeof(mbr_parts_p4);
> +                                       if (1 + cur_str_size > bytes_remaining)
> +                                               return 1;
> +                                       strcat(cur_buf, mbr_parts_p4);
> +                                       bytes_remaining -= cur_str_size;
> +
> +                               }
> +                       else if (5 == num_parts) {
> +                               cur_str_size = sizeof(mbr_parts_p5);
> +                               if (1 + cur_str_size > bytes_remaining)
> +                                       return 1;
> +                               strcat(cur_buf, mbr_parts_p5);
> +                               bytes_remaining -= cur_str_size;
> +
> +                       }
> +                       else if (5 < num_parts)
> +                               return 1;
> +                       }
> +               }
> +       }
> +
> +       cur_str_size = sizeof(mbr_parts_tail);
> +       if (1 + cur_str_size > bytes_remaining)
> +               return 1;
> +       strcat(cur_buf, mbr_parts_tail);
> +
> +       return 0;
> +}
> +
> +static int mbr_test_run(struct unit_test_state *uts)
> +{
> +       struct blk_desc *mmc_dev_desc;
> +       unsigned char mbr_wbuf[512], ebr_wbuf[512], rbuf[512];
> +       char mbr_parts_buf[256];
> +       ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
> +
> +       mbr_parts_max = 2 + sizeof('\0')
> +               + strlen(mbr_parts_header)
> +               + strlen(mbr_parts_p1)
> +               + strlen(mbr_parts_p2)
> +               + strlen(mbr_parts_p3)
> +               + strlen(mbr_parts_p4)
> +               + strlen(mbr_parts_p5)
> +               + strlen(mbr_parts_tail);
> +       ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %ld; buffer req: %ld\n",
> +               sizeof(mbr_parts_buf), mbr_parts_max);
> +
> +       mbr_wa = map_to_sysmem(mbr_wbuf);
> +       ebr_wa = map_to_sysmem(ebr_wbuf);
> +       ra = map_to_sysmem(rbuf);
> +       ebr_blk = (ulong)0xB00000 / 0x200;
> +
> +       /* Make sure mmc1 exists */
> +       ut_asserteq(1, blk_get_device_by_str("mmc", "1", &mmc_dev_desc));
> +       ut_assertok(console_record_reset_enable());

You shouldn't need these

> +       ut_assertok(run_commandf("mmc dev 1"));
> +       ut_assert_nextline("switch to partitions #0, OK");
> +       ut_assert_nextline("mmc1 is current device");
> +       ut_assertok(ut_check_console_end(uts));
> +
> +       /* Make sure mmc1 is 12+ MiB in size */
> +       ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra, (ulong)0xBFFE00 / 0x200));
> +
> +       /* Test one MBR partition */
> +       init_buffers(rbuf, sizeof(rbuf), mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> +       ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 1));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0 1", mbr_wa));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assertok(run_commandf("mbr write mmc 1"));
> +       ut_assert_nextline("MBR: write success!");
> +       ut_assertok(run_commandf("mbr verify mmc 1"));
> +       ut_assert_nextline("MBR: verify success!");
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(ut_check_console_end(uts));
> +       /*
> +       000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +       000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 00  |...%$..@........|
> +       000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +       000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +       000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       for (unsigned i = 0; i < mbr_cmp_size; i++) {
> +               ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p1[i],
> +                       "1P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       mbr_cmp_start + i, mbr_parts_ref_p1[i], rbuf[mbr_cmp_start + i]);
> +       }
> +
> +       /* Test two MBR partitions */
> +       init_buffers(rbuf, sizeof(rbuf), mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> +       ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 2));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0 1", mbr_wa));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assertok(run_commandf("mbr write mmc 1"));
> +       ut_assert_nextline("MBR: write success!");
> +       ut_assertok(run_commandf("mbr verify mmc 1"));
> +       ut_assert_nextline("MBR: verify success!");
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(ut_check_console_end(uts));
> +       /*
> +       000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +       000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +       000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 00  |%..F...H........|
> +       000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +       000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       for (unsigned i = 0; i < mbr_cmp_size; i++) {
> +               ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p2[i],
> +                       "2P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       mbr_cmp_start + i, mbr_parts_ref_p2[i], rbuf[mbr_cmp_start + i]);
> +       }
> +
> +       /* Test three MBR partitions */
> +       init_buffers(rbuf, sizeof(rbuf), mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> +       ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 3));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0 1", mbr_wa));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assertok(run_commandf("mbr write mmc 1"));
> +       ut_assert_nextline("MBR: write success!");
> +       ut_assertok(run_commandf("mbr verify mmc 1"));
> +       ut_assert_nextline("MBR: verify success!");
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(ut_check_console_end(uts));
> +       /*
> +       000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +       000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +       000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +       000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 00  |...f%..P........|
> +       000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       for (unsigned i = 0; i < mbr_cmp_size; i++) {
> +               ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p3[i],
> +                       "3P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       mbr_cmp_start + i, mbr_parts_ref_p3[i], rbuf[mbr_cmp_start + i]);
> +       }
> +
> +       /* Test four MBR partitions */
> +       init_buffers(rbuf, sizeof(rbuf), mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> +       ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 4));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0 1", mbr_wa));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assertok(run_commandf("mbr write mmc 1"));
> +       ut_assert_nextline("MBR: write success!");
> +       ut_assertok(run_commandf("mbr verify mmc 1"));
> +       ut_assert_nextline("MBR: verify success!");
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(ut_check_console_end(uts));
> +       /*
> +       000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +       000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +       000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +       000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
> +       000001f0  26 01 0e 87 06 01 00 58  00 00 00 08 00 00 55 aa  |&......X......U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       for (unsigned i = 0; i < mbr_cmp_size; i++) {
> +               ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p4[i],
> +                       "4P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       mbr_cmp_start + i, mbr_parts_ref_p4[i], rbuf[mbr_cmp_start + i]);
> +       }
> +
> +       /* Test five MBR partitions */
> +       init_buffers(rbuf, sizeof(rbuf), mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> +       ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 5));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0 1", mbr_wa));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(run_commandf("write mmc 1:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assertf(0 == run_commandf("mbr write mmc 1"), "Invalid partitions string: %s\n", mbr_parts_buf);
> +       ut_assert_nextline("MBR: write success!");
> +       ut_assertok(run_commandf("mbr verify mmc 1"));
> +       ut_assert_nextline("MBR: verify success!");
> +       ut_assertok(ut_check_console_end(uts));
> +       /*
> +       000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> +       000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
> +       000001d0  25 01 0e 46 05 01 00 48  00 00 00 08 00 00 00 46  |%..F...H.......F|
> +       000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
> +       000001f0  26 01 05 a7 26 01 00 58  00 00 00 10 00 00 55 aa  |&...&..X......U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0 1", ra));
> +       for (unsigned i = 0; i < mbr_cmp_size; i++) {
> +               ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p5[i],
> +                       "5P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       mbr_cmp_start + i, mbr_parts_ref_p5[i], rbuf[mbr_cmp_start + i]);
> +       }
> +       /*
> +       00b001b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 87  |................|
> +       00b001c0  07 01 0e a7 26 01 00 08  00 00 00 08 00 00 00 00  |....&...........|
> +       00b001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +       00b001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +       00b001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
> +       */
> +       ut_assertok(run_commandf("read mmc 1:0 0x%lx 0x%lx 1", ra, ebr_blk));
> +       for (unsigned i = 0; i < ebr_cmp_size; i++) {
> +               ut_assertf(rbuf[ebr_cmp_start + i] == ebr_parts_ref_p5[i],
> +                       "5P EBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
> +                       ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
> +       }
> +
> +       return 0;
> +}
> +
> +/* Declare mbr test */
> +UNIT_TEST(mbr_test_run, UT_TESTF_CONSOLE_REC, mbr_test);
> +
> +int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       struct unit_test *tests = UNIT_TEST_SUITE_START(mbr_test);
> +       const int n_ents = UNIT_TEST_SUITE_COUNT(mbr_test);
> +
> +       return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
> +}
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 0f56409e80..123db7cc7d 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -86,6 +86,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
>  #endif
>  #ifdef CONFIG_UT_LOG
>         U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_ut_log, "", ""),
> +#endif
> +#if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
> +        && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
> +       U_BOOT_CMD_MKENT(mbr, CONFIG_SYS_MAXARGS, 1, do_ut_mbr, "", ""),
>  #endif
>         U_BOOT_CMD_MKENT(mem, CONFIG_SYS_MAXARGS, 1, do_ut_mem, "", ""),
>  #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
> --
> 2.41.0

Regards,
Simon
