Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C4CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B0587988;
	Wed,  3 Jan 2024 09:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="r3qS2XdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F6287987; Wed,  3 Jan 2024 09:21:25 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075C7879B3
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e7abe4be4so8243508e87.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 00:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704270080; x=1704874880;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsrfLQ0ypsNlO2pN+0hMO97g3rnjB55GT4En5+zhAnc=;
 b=r3qS2XdJx+jvkRV4xmPc8k9zgP2ocua+HGzC8+tWMT8Slxxu828RyegL6kj8aJix0b
 rkVtemMOrcJkT1tQn7V/ZmvuNslYvoYjOkyBuk8oNJWPWlWDromcTTvuB0Tg+6mnBza5
 6+Q35gYWpCarvW0Ve7UC4KWIKMhKS1w6XLrwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704270080; x=1704874880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsrfLQ0ypsNlO2pN+0hMO97g3rnjB55GT4En5+zhAnc=;
 b=SIQq5hzzcf3ZttcphCzsA1zEfTFRFPK1O2I9Yq/44YEk/RynwLyMXTA+wSMzI7uQSJ
 kCT12/FeKxqUZJNz0aUmEPRMIoD62qg35lTf7grXCsfLBLCrmf3AMJriE9uZVW5a6KvY
 vuaY5sML8t2sxDT6X232U/gvmbxZuKZwYhx4NF6oHV/6tWjfLGEFlPENcZEz3Ksm3B1t
 IwXhmFQCkBqTl+1B3xfiM5MYrVbjdfdkFrlWU7zFYcqRYZrx+6nNyUErVJr4rRdNm+tf
 eU0BkfiPHJFe2XZv5FcPL0qkL1q236BgUutKKsTeVT31UbeCdCtxr2x4CfIMLvibLQRT
 LloA==
X-Gm-Message-State: AOJu0Yxqbt58IWmkNoQ86hk2NY8fL7VR3dM7yAD0vi2kkPEhKK/DNwy/
 6IqWtAvykOZBVrI3h/pfgF3jefkK3ZrRhN+w1MUWB3oMizVpwQ==
X-Google-Smtp-Source: AGHT+IGXxdp8waGuDb7jNO4DqDk6bSwynkgCtskEWsGki6UMpiwCDFMzFEnLD/mcBdpT99rijmQ3so+8m8yPNPK/Lgo=
X-Received: by 2002:a05:6512:1107:b0:50e:7e13:811b with SMTP id
 l7-20020a056512110700b0050e7e13811bmr8344182lfg.8.1704270079743; Wed, 03 Jan
 2024 00:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-5-avromanov@salutedevices.com>
In-Reply-To: <20231228153922.84323-5-avromanov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 3 Jan 2024 09:21:08 +0100
Message-ID: <CAOf5uwmr9CvdthHEf2Jx+H7Jm+5vQht7f2t5-V+dkQBO68k6hw@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] nand: move nand_erase_opts() to core NAND folder
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: michal.simek@amd.com, marex@denx.de, michael@walle.cc, 
 stcarlso@linux.microsoft.com, tobias@waldekranz.com, seanedmond@microsoft.com, 
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com, 
 xypron.glpk@gmx.de, dario.binacchi@amarulasolutions.com, 
 frieder.schrempf@kontron.de, sjg@chromium.org, hs@denx.de, 
 sean.anderson@seco.com, dimorinny@google.com, mkorpershoek@baylibre.com, 
 patrick.delaunay@foss.st.com, u-boot@lists.denx.de, kernel@salutedevices.com
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

Hi Alexey

On Thu, Dec 28, 2023 at 4:39=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Currently nand_erase_opts() placed in the nand/raw/ folder,
> because it uses the RAW NAND specific API (struct nand_chip).
> This patch move it to core NAND folder and make function generic,
> for both RAW/SPI NAND's usage.
>
> Also, nand_erase_opts() used in fastboot/fb_nand.c, cmd/nand.c
> and env/nand.c code. This is also the reason why we should move
> it to core folder and make it more general.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/nand_util.c | 153 ----------------------------
>  drivers/mtd/nand/util.c          | 166 +++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+), 153 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand=
_util.c
> index 9c18ce63b9..f7704d4697 100644
> --- a/drivers/mtd/nand/raw/nand_util.c
> +++ b/drivers/mtd/nand/raw/nand_util.c
> @@ -32,159 +32,6 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <nand.h>
> -#include <jffs2/jffs2.h>
> -
> -typedef struct erase_info      erase_info_t;
> -
> -/* support only for native endian JFFS2 */
> -#define cpu_to_je16(x) (x)
> -#define cpu_to_je32(x) (x)
> -
> -/**
> - * nand_erase_opts: - erase NAND flash with support for various options
> - *                   (jffs2 formatting)
> - *
> - * @param mtd          nand mtd instance to erase
> - * @param opts         options,  @see struct nand_erase_options
> - * Return:             0 in case of success
> - *
> - * This code is ported from flash_eraseall.c from Linux mtd utils by
> - * Arcom Control System Ltd.
> - */
> -int nand_erase_opts(struct mtd_info *mtd,
> -                   const nand_erase_options_t *opts)
> -{
> -       struct jffs2_unknown_node cleanmarker;
> -       erase_info_t erase;
> -       unsigned long erase_length, erased_length; /* in blocks */
> -       int result;
> -       int percent_complete =3D -1;
> -       const char *mtd_device =3D mtd->name;
> -       struct mtd_oob_ops oob_opts;
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -
> -       if ((opts->offset & (mtd->erasesize - 1)) !=3D 0) {
> -               printf("Attempt to erase non block-aligned data\n");
> -               return -1;
> -       }
> -
> -       memset(&erase, 0, sizeof(erase));
> -       memset(&oob_opts, 0, sizeof(oob_opts));
> -
> -       erase.mtd =3D mtd;
> -       erase.len =3D mtd->erasesize;
> -       erase.addr =3D opts->offset;
> -       erase_length =3D lldiv(opts->length + mtd->erasesize - 1,
> -                            mtd->erasesize);
> -
> -       cleanmarker.magic =3D cpu_to_je16(JFFS2_MAGIC_BITMASK);
> -       cleanmarker.nodetype =3D cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER);
> -       cleanmarker.totlen =3D cpu_to_je32(8);
> -
> -       /* scrub option allows to erase badblock. To prevent internal
> -        * check from erase() method, set block check method to dummy
> -        * and disable bad block table while erasing.
> -        */
> -       if (opts->scrub) {
> -               erase.scrub =3D opts->scrub;
> -               /*
> -                * We don't need the bad block table anymore...
> -                * after scrub, there are no bad blocks left!
> -                */
> -               if (chip->bbt) {
> -                       kfree(chip->bbt);
> -               }
> -               chip->bbt =3D NULL;
> -               chip->options &=3D ~NAND_BBT_SCANNED;
> -       }
> -
> -       for (erased_length =3D 0;
> -            erased_length < erase_length;
> -            erase.addr +=3D mtd->erasesize) {
> -
> -               schedule();
> -
> -               if (opts->lim && (erase.addr >=3D (opts->offset + opts->l=
im))) {
> -                       puts("Size of erase exceeds limit\n");
> -                       return -EFBIG;
> -               }
> -               if (!opts->scrub) {
> -                       int ret =3D mtd_block_isbad(mtd, erase.addr);
> -                       if (ret > 0) {
> -                               if (!opts->quiet)
> -                                       printf("\rSkipping %s at  "
> -                                              "0x%08llx                 =
"
> -                                              "                         =
\n",
> -                                              ret =3D=3D 1 ? "bad block"=
 : "bbt reserved",
> -                                              erase.addr);
> -
> -                               if (!opts->spread)
> -                                       erased_length++;
> -
> -                               continue;
> -
> -                       } else if (ret < 0) {
> -                               printf("\n%s: MTD get bad block failed: %=
d\n",
> -                                      mtd_device,
> -                                      ret);
> -                               return -1;
> -                       }
> -               }
> -
> -               erased_length++;
> -
> -               result =3D mtd_erase(mtd, &erase);
> -               if (result !=3D 0) {
> -                       printf("\n%s: MTD Erase failure: %d\n",
> -                              mtd_device, result);
> -                       continue;
> -               }
> -
> -               /* format for JFFS2 ? */
> -               if (opts->jffs2 && chip->ecc.layout->oobavail >=3D 8) {
> -                       struct mtd_oob_ops ops;
> -                       ops.ooblen =3D 8;
> -                       ops.datbuf =3D NULL;
> -                       ops.oobbuf =3D (uint8_t *)&cleanmarker;
> -                       ops.ooboffs =3D 0;
> -                       ops.mode =3D MTD_OPS_AUTO_OOB;
> -
> -                       result =3D mtd_write_oob(mtd, erase.addr, &ops);
> -                       if (result !=3D 0) {
> -                               printf("\n%s: MTD writeoob failure: %d\n"=
,
> -                                      mtd_device, result);
> -                               continue;
> -                       }
> -               }
> -
> -               if (!opts->quiet) {
> -                       unsigned long long n =3D erased_length * 100ULL;
> -                       int percent;
> -
> -                       do_div(n, erase_length);
> -                       percent =3D (int)n;
> -
> -                       /* output progress message only at whole percent
> -                        * steps to reduce the number of messages printed
> -                        * on (slow) serial consoles
> -                        */
> -                       if (percent !=3D percent_complete) {
> -                               percent_complete =3D percent;
> -
> -                               printf("\rErasing at 0x%llx -- %3d%% comp=
lete.",
> -                                      erase.addr, percent);
> -
> -                               if (opts->jffs2 && result =3D=3D 0)
> -                                       printf(" Cleanmarker written at 0=
x%llx.",
> -                                              erase.addr);
> -                       }
> -               }
> -       }
> -       if (!opts->quiet)
> -               printf("\n");
> -
> -       return 0;
> -}
>
>  #ifdef CONFIG_CMD_NAND_LOCK_UNLOCK
>
> diff --git a/drivers/mtd/nand/util.c b/drivers/mtd/nand/util.c
> index 4a372bb67d..f02c1ef4ca 100644
> --- a/drivers/mtd/nand/util.c
> +++ b/drivers/mtd/nand/util.c
> @@ -28,10 +28,176 @@
>  #include <asm/cache.h>
>  #include <dm/devres.h>
>
> +#include <jffs2/jffs2.h>
>  #include <linux/errno.h>
>  #include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/rawnand.h>
>  #include <nand.h>
>
> +typedef struct erase_info      erase_info_t;
> +
> +/* support only for native endian JFFS2 */
> +#define cpu_to_je16(x) (x)
> +#define cpu_to_je32(x) (x)
> +
> +/**
> + * nand_erase_opts: - erase NAND flash with support for various options
> + *                   (jffs2 formatting)
> + *
> + * @param mtd          nand mtd instance to erase
> + * @param opts         options,  @see struct nand_erase_options
> + * Return:             0 in case of success
> + *
> + * This code is ported from flash_eraseall.c from Linux mtd utils by
> + * Arcom Control System Ltd.
> + */
> +int nand_erase_opts(struct mtd_info *mtd,
> +                   const nand_erase_options_t *opts)
> +{
> +       struct jffs2_unknown_node cleanmarker;
> +       erase_info_t erase;
> +       unsigned long erase_length, erased_length; /* in blocks */
> +       int result;
> +       int percent_complete =3D -1;
> +       const char *mtd_device =3D mtd->name;
> +       struct mtd_oob_ops oob_opts;
> +       u32 oobavail =3D mtd->oobavail;
> +#if CONFIG_IS_ENABLED(MTD_RAW_NAND)
> +       struct nand_chip *chip =3D mtd_to_nand(mtd);
> +#elif CONFIG_IS_ENABLED(MTD_SPI_NAND)
> +       struct nand_device *nand =3D mtd_to_nanddev(mtd);
> +#endif
> +
> +       if ((opts->offset & (mtd->erasesize - 1)) !=3D 0) {
> +               printf("Attempt to erase non block-aligned data\n");
> +               return -1;
> +       }
> +
> +       memset(&erase, 0, sizeof(erase));
> +       memset(&oob_opts, 0, sizeof(oob_opts));
> +
> +       erase.mtd =3D mtd;
> +       erase.len =3D mtd->erasesize;
> +       erase.addr =3D opts->offset;
> +       erase_length =3D lldiv(opts->length + mtd->erasesize - 1,
> +                            mtd->erasesize);
> +
> +       cleanmarker.magic =3D cpu_to_je16(JFFS2_MAGIC_BITMASK);
> +       cleanmarker.nodetype =3D cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER);
> +       cleanmarker.totlen =3D cpu_to_je32(8);
> +
> +       /* scrub option allows to erase badblock. To prevent internal
> +        * check from erase() method, set block check method to dummy
> +        * and disable bad block table while erasing.
> +        */
> +       if (opts->scrub) {
> +               erase.scrub =3D opts->scrub;
> +
> +               /*
> +                * We don't need the bad block table anymore...
> +                * after scrub, there are no bad blocks left!
> +                */
> +#if CONFIG_IS_ENABLED(MTD_RAW_NAND)
> +               if (chip->bbt) {
> +                       kfree(chip->bbt);
> +               }
> +               chip->bbt =3D NULL;
> +               chip->options &=3D ~NAND_BBT_SCANNED;
> +#elif CONFIG_IS_ENABLED(MTD_SPI_NAND)
> +               if (nanddev_bbt_is_initialized(nand))
> +                       nanddev_bbt_cleanup(nand);
> +#endif
> +       }
> +
> +       for (erased_length =3D 0;
> +            erased_length < erase_length;
> +            erase.addr +=3D mtd->erasesize) {
> +
> +               schedule();
> +
> +               if (opts->lim && (erase.addr >=3D (opts->offset + opts->l=
im))) {
> +                       puts("Size of erase exceeds limit\n");
> +                       return -EFBIG;
> +               }
> +               if (!opts->scrub) {
> +                       int ret =3D mtd_block_isbad(mtd, erase.addr);
> +                       if (ret > 0) {
> +                               if (!opts->quiet)
> +                                       printf("\rSkipping %s at  "
> +                                              "0x%08llx                 =
"
> +                                              "                         =
\n",
> +                                              ret =3D=3D 1 ? "bad block"=
 : "bbt reserved",
> +                                              erase.addr);
> +
> +                               if (!opts->spread)
> +                                       erased_length++;
> +
> +                               continue;
> +
> +                       } else if (ret < 0) {
> +                               printf("\n%s: MTD get bad block failed: %=
d\n",
> +                                      mtd_device,
> +                                      ret);
> +                               return -1;
> +                       }
> +               }
> +
> +               erased_length++;
> +
> +               result =3D mtd_erase(mtd, &erase);
> +               if (result !=3D 0) {
> +                       printf("\n%s: MTD Erase failure: %d\n",
> +                              mtd_device, result);
> +                       continue;
> +               }
> +
> +               /* format for JFFS2 ? */
> +               if (opts->jffs2 && oobavail >=3D 8) {
> +                       struct mtd_oob_ops ops;
> +                       ops.ooblen =3D 8;
> +                       ops.datbuf =3D NULL;
> +                       ops.oobbuf =3D (uint8_t *)&cleanmarker;
> +                       ops.ooboffs =3D 0;
> +                       ops.mode =3D MTD_OPS_AUTO_OOB;
> +
> +                       result =3D mtd_write_oob(mtd, erase.addr, &ops);
> +                       if (result !=3D 0) {
> +                               printf("\n%s: MTD writeoob failure: %d\n"=
,
> +                                      mtd_device, result);
> +                               continue;
> +                       }
> +               }
> +
> +               if (!opts->quiet) {
> +                       unsigned long long n =3D erased_length * 100ULL;
> +                       int percent;
> +
> +                       do_div(n, erase_length);
> +                       percent =3D (int)n;
> +
> +                       /* output progress message only at whole percent
> +                        * steps to reduce the number of messages printed
> +                        * on (slow) serial consoles
> +                        */
> +                       if (percent !=3D percent_complete) {
> +                               percent_complete =3D percent;
> +
> +                               printf("\rErasing at 0x%llx -- %3d%% comp=
lete.",
> +                                      erase.addr, percent);
> +
> +                               if (opts->jffs2 && result =3D=3D 0)
> +                                       printf(" Cleanmarker written at 0=
x%llx.",
> +                                              erase.addr);
> +                       }
> +               }
> +       }
> +       if (!opts->quiet)
> +               printf("\n");
> +
> +       return 0;
> +}
> +
>  /**
>   * check_skip_len
>   *
> --
> 2.30.1
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
