Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972FFC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 06:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A3E877CC;
	Fri, 10 Nov 2023 07:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Fr7Zj6PS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2379E877BF; Fri, 10 Nov 2023 07:06:13 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35758877CC
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 07:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so26451a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 22:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699596369; x=1700201169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWs6j0ZFemKVl1PMkDarETJLwSj/Snkbmbmi9F3aUfs=;
 b=Fr7Zj6PStjV6d4/OhenCakbFWst752XhOcZGFmOuhNac3zydqIObreDy/EKDNEfb9G
 6AOYkRAa0dl/Qmoua+KSfdzVfe52vV7GwkzqyFMpeDVR9vlv1BslEmkqDEPqzuvUuvoS
 7q6q+iIxAcH1pRhP5p/S2JcJqk8HBUslcu41cUFPB/gZFyCujDtUOCvMUDd4EZGbaxfp
 C3HWDVnIDt4Zp9oIM9PIIZnS6O2Rctpq2Puso3BTV2HsdBrdxlPxKXb8hjsV3ECQC7R8
 X2IW/UlzAiKCOPNNI7RaWCVnT9uYlVls11/1sdbo/Qy91czhB2EYcRQrfB/feN7b2bnj
 pYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699596369; x=1700201169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWs6j0ZFemKVl1PMkDarETJLwSj/Snkbmbmi9F3aUfs=;
 b=rdswwkx3ZGk2ao6Pp5EYJbq7mx5KHVxaHEsPRT38+gskMvgJit7rrdHEmC7bhpaHwP
 cOMnb4wywxssAbg3igpPBNfuLb7p0xZCy7Ti7Th9A1Is++5SDPXWVBaMm/9YU3Ue2I21
 Az7q86bVY3hLrl8krrKIzsS1E3SvsRoRHF8+hWNhQLUR+EZWvlfjyWCsm0djtRZs6Vki
 5uyqNUoUG/42VcMeNGNdGK5vKn4qR1l1ZyVkz3UoPC+HywAWF004cQabsfwSlZI6LNfp
 5bCEHSlOIWDjOEkkjSJmKhJgAkrSNyYZm6/QjeyKIiVzOFXn+Q3RBXVHVGUfhkFBuxds
 LsHA==
X-Gm-Message-State: AOJu0YzIy4j8LJE593B2+Nb5qwCalcIbMo3A1vSGF/vvTNyTQdx07jjP
 zkL9xMWaLUsyF6h+TwOBRCsqpNimUODnVz8irfQWDA==
X-Google-Smtp-Source: AGHT+IFMHndPhRIHcriUxZUsI+caj9mpbx4IzJrzKxiB26pDMZYx1PMoRPmTsbFdzp/tvI1TQ2pjSoPNgVfDmKNsOL4=
X-Received: by 2002:a05:6402:2b8a:b0:544:e2b8:ba6a with SMTP id
 fj10-20020a0564022b8a00b00544e2b8ba6amr745529edb.3.1699596369464; Thu, 09 Nov
 2023 22:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20231109003634.577152-1-dimorinny@google.com>
 <20231109003634.577152-2-dimorinny@google.com>
 <87a5rn9sdm.fsf@baylibre.com> <874jhv9r6z.fsf@baylibre.com>
In-Reply-To: <874jhv9r6z.fsf@baylibre.com>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Thu, 9 Nov 2023 22:05:57 -0800
Message-ID: <CAOWkq4n+EbNJ2EyY28BPdYbRq3F_aJCEr1SpvXcXNbYYjWyGXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: bcb: support various block device interfaces for
 BCB command
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>, 
 Cody Schuffelen <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you Mattijs for taking time to verify it, uploaded v2 with "mcc"
thing fixed

On Thu, Nov 9, 2023 at 2:06=E2=80=AFAM Mattijs Korpershoek <
mkorpershoek@baylibre.com> wrote:

> On jeu., nov. 09, 2023 at 10:40, Mattijs Korpershoek <
> mkorpershoek@baylibre.com> wrote:
>
> > Hi Dmitrii,
> >
> > Thank you for your patch.
> >
> > Thank you as well for taking the time to upstream things from:
> > https://android.googlesource.com/platform/external/u-boot/
> >
> > On jeu., nov. 09, 2023 at 00:36, Dmitrii Merkurev <dimorinny@google.com=
>
> wrote:
> >
> >> Currently BCB command-line, C APIs and implementation only
> >> support MMC interface. Extend it to allow various block
> >> device interfaces.
> >>
> >> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> >> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> >> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> Cc: Sean Anderson <sean.anderson@seco.com>
> >> Cc: Cody Schuffelen <schuffelen@google.com>
> >
> > This breaks vim3/vim3l android boot flow because both rely on the usage
> > of the bcb command in their U-Boot environment:
> >
> >   Error: 1572575691 110528528: read failed (-19)
> >   Warning: BCB is corrupted or does not exist
> >
> > The following diff fixes it:
> >
> > diff --git a/include/configs/meson64_android.h
> b/include/configs/meson64_android.h
> > index c0e977abb01f..442233e827d8 100644
> > --- a/include/configs/meson64_android.h
> > +++ b/include/configs/meson64_android.h
> > @@ -164,7 +164,7 @@
> >                         "fi; " \
> >                 "fi;" \
> >                 "if test \"${run_fastboot}\" -eq 0; then " \
> > -                       "if bcb load "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> > +                       "if bcb load mmc "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> >                         CONTROL_PARTITION "; then " \
> >                                 "if bcb test command =3D
> bootonce-bootloader; then " \
> >                                         "echo BCB: Bootloader boot...; =
"
> \
> > @@ -195,7 +195,7 @@
> >                         "echo Recovery button is pressed;" \
> >                         "setenv run_recovery 1;" \
> >                 "fi; " \
> > -               "if bcb load "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> > +               "if bcb load mmc "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> >                 CONTROL_PARTITION "; then " \
> >                         "if bcb test command =3D boot-recovery; then " =
\
> >                                 "echo BCB: Recovery boot...; " \
> > diff --git a/include/configs/ti_omap5_common.h
> b/include/configs/ti_omap5_common.h
> > index 4e5aa74147d4..f571744adaf8 100644
> > --- a/include/configs/ti_omap5_common.h
> > +++ b/include/configs/ti_omap5_common.h
> > @@ -168,7 +168,7 @@
> >                 "mmc dev $mmcdev; " \
> >                 "mmc rescan; " \
> >                 AB_SELECT_SLOT \
> > -               "if bcb load "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> > +               "if bcb load mmc "
> __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
> >                 CONTROL_PARTITION "; then " \
> >                         "setenv ardaddr -; " \
> >                         "if bcb test command =3D bootonce-bootloader; t=
hen
> " \
> >
> > Can you consider including this as part of this patch ?
> >
> >> ---
> >>  cmd/Kconfig                  |  1 -
> >>  cmd/bcb.c                    | 70 ++++++++++++++++++++++-------------=
-
> >>  doc/android/bcb.rst          | 34 +++++++++---------
> >>  drivers/fastboot/fb_common.c |  2 +-
> >>  include/bcb.h                |  5 +--
> >>  5 files changed, 65 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index df6d71c103..ce2435bbb8 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -981,7 +981,6 @@ config CMD_ADC
> >>
> >>  config CMD_BCB
> >>      bool "bcb"
> >> -    depends on MMC
> >>      depends on PARTITIONS
> >>      help
> >>        Read/modify/write the fields of Bootloader Control Block, usual=
ly
> >> diff --git a/cmd/bcb.c b/cmd/bcb.c
> >> index 02d0c70d87..5d8c232663 100644
> >> --- a/cmd/bcb.c
> >> +++ b/cmd/bcb.c
> >> @@ -25,6 +25,7 @@ enum bcb_cmd {
> >>      BCB_CMD_STORE,
> >>  };
> >>
> >> +static enum uclass_id bcb_uclass_id =3D UCLASS_INVALID;
> >>  static int bcb_dev =3D -1;
> >>  static int bcb_part =3D -1;
> >>  static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) =3D=
 {
> { 0 } };
> >> @@ -53,6 +54,9 @@ static int bcb_is_misused(int argc, char *const
> argv[])
> >>
> >>      switch (cmd) {
> >>      case BCB_CMD_LOAD:
> >> +            if (argc !=3D 3 && argc !=3D 4)
> >> +                    goto err;
> >> +            break;
> >>      case BCB_CMD_FIELD_SET:
> >>              if (argc !=3D 3)
> >>                      goto err;
> >> @@ -115,7 +119,7 @@ static int bcb_field_get(char *name, char **fieldp=
,
> int *sizep)
> >>      return 0;
> >>  }
> >>
> >> -static int __bcb_load(int devnum, const char *partp)
> >> +static int __bcb_load(const char *iface, int devnum, const char *part=
p)
> >>  {
> >>      struct blk_desc *desc;
> >>      struct disk_partition info;
> >> @@ -123,14 +127,14 @@ static int __bcb_load(int devnum, const char
> *partp)
> >>      char *endp;
> >>      int part, ret;
> >>
> >> -    desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC, devnum);
> >> +    desc =3D blk_get_dev(iface, devnum);
> >>      if (!desc) {
> >>              ret =3D -ENODEV;
> >>              goto err_read_fail;
> >>      }
> >>
> >>      /*
> >> -     * always select the USER mmc hwpart in case another
> >> +     * always select the first hwpart in case another
> >>       * blk operation selected a different hwpart
> >>       */
> >>      ret =3D blk_dselect_hwpart(desc, 0);
> >> @@ -161,18 +165,20 @@ static int __bcb_load(int devnum, const char
> *partp)
> >>              goto err_read_fail;
> >>      }
> >>
> >> +    bcb_uclass_id =3D desc->uclass_id;
> >>      bcb_dev =3D desc->devnum;
> >>      bcb_part =3D part;
> >> -    debug("%s: Loaded from mmc %d:%d\n", __func__, bcb_dev, bcb_part)=
;
> >> +    debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev,
> bcb_part);
> >>
> >>      return CMD_RET_SUCCESS;
> >>  err_read_fail:
> >> -    printf("Error: mmc %d:%s read failed (%d)\n", devnum, partp, ret)=
;
> >> +    printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp=
,
> ret);
> >>      goto err;
> >>  err_too_small:
> >> -    printf("Error: mmc %d:%s too small!", devnum, partp);
> >> +    printf("Error: %s %d:%s too small!", iface, devnum, partp);
> >>      goto err;
> >>  err:
> >> +    bcb_uclass_id =3D UCLASS_INVALID;
> >>      bcb_dev =3D -1;
> >>      bcb_part =3D -1;
> >>
> >> @@ -182,15 +188,23 @@ err:
> >>  static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
> >>                     char * const argv[])
> >>  {
> >> +    int devnum;
> >>      char *endp;
> >> -    int devnum =3D simple_strtoul(argv[1], &endp, 0);
> >> +    char *iface =3D "mcc";
> >
> > Should this be mmc instead of mcc ?
>
> Just to clarify: having "mmc" instead of "mcc" also fixes the bcb
> reading on vim3.
>
> >
> >> +
> >> +    if (argc =3D=3D 4) {
> >> +            iface =3D argv[1];
> >> +            argc--;
> >> +            argv++;
> >> +    }
> >>
> >> +    devnum =3D simple_strtoul(argv[1], &endp, 0);
> >>      if (*endp !=3D '\0') {
> >>              printf("Error: Device id '%s' not a number\n", argv[1]);
> >>              return CMD_RET_FAILURE;
> >>      }
> >>
> >> -    return __bcb_load(devnum, argv[2]);
> >> +    return __bcb_load(iface, devnum, argv[2]);
> >>  }
> >>
> >>  static int __bcb_set(char *fieldp, const char *valp)
> >> @@ -298,7 +312,7 @@ static int __bcb_store(void)
> >>      u64 cnt;
> >>      int ret;
> >>
> >> -    desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC, bcb_dev);
> >> +    desc =3D blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
> >>      if (!desc) {
> >>              ret =3D -ENODEV;
> >>              goto err;
> >> @@ -317,7 +331,7 @@ static int __bcb_store(void)
> >>
> >>      return CMD_RET_SUCCESS;
> >>  err:
> >> -    printf("Error: mmc %d:%d write failed (%d)\n", bcb_dev, bcb_part,
> ret);
> >> +    printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id,
> bcb_dev, bcb_part, ret);
> >>
> >>      return CMD_RET_FAILURE;
> >>  }
> >> @@ -328,11 +342,11 @@ static int do_bcb_store(struct cmd_tbl *cmdtp,
> int flag, int argc,
> >>      return __bcb_store();
> >>  }
> >>
> >> -int bcb_write_reboot_reason(int devnum, char *partp, const char
> *reasonp)
> >> +int bcb_write_reboot_reason(const char *iface, int devnum, char
> *partp, const char *reasonp)
> >>  {
> >>      int ret;
> >>
> >> -    ret =3D __bcb_load(devnum, partp);
> >> +    ret =3D __bcb_load(iface, devnum, partp);
> >>      if (ret !=3D CMD_RET_SUCCESS)
> >>              return ret;
> >>
> >> @@ -385,21 +399,23 @@ static int do_bcb(struct cmd_tbl *cmdtp, int
> flag, int argc, char *const argv[])
> >>  U_BOOT_CMD(
> >>      bcb, CONFIG_SYS_MAXARGS, 1, do_bcb,
> >>      "Load/set/clear/test/dump/store Android BCB fields",
> >> -    "load  <dev> <part>       - load  BCB from mmc <dev>:<part>\n"
> >> -    "bcb set   <field> <val>      - set   BCB <field> to <val>\n"
> >> -    "bcb clear [<field>]          - clear BCB <field> or all fields\n=
"
> >> -    "bcb test  <field> <op> <val> - test  BCB <field> against <val>\n=
"
> >> -    "bcb dump  <field>            - dump  BCB <field>\n"
> >> -    "bcb store                    - store BCB back to mmc\n"
> >> +    "load <interface> <dev> <part>  - load  BCB from <interface>
> <dev>:<part>\n"
> >> +    "load <dev> <part>              - load  BCB from mmc
> <dev>:<part>\n"
> >> +    "bcb set   <field> <val>        - set   BCB <field> to <val>\n"
> >> +    "bcb clear [<field>]            - clear BCB <field> or all
> fields\n"
> >> +    "bcb test  <field> <op> <val>   - test  BCB <field> against
> <val>\n"
> >> +    "bcb dump  <field>              - dump  BCB <field>\n"
> >> +    "bcb store                      - store BCB back to <interface>\n=
"
> >>      "\n"
> >>      "Legend:\n"
> >> -    "<dev>   - MMC device index containing the BCB partition\n"
> >> -    "<part>  - MMC partition index or name containing the BCB\n"
> >> -    "<field> - one of {command,status,recovery,stage,reserved}\n"
> >> -    "<op>    - the binary operator used in 'bcb test':\n"
> >> -    "          '=3D' returns true if <val> matches the string stored =
in
> <field>\n"
> >> -    "          '~' returns true if <val> matches a subset of <field>'=
s
> string\n"
> >> -    "<val>   - string/text provided as input to bcb {set,test}\n"
> >> -    "          NOTE: any ':' character in <val> will be replaced by
> line feed\n"
> >> -    "          during 'bcb set' and used as separator by upper
> layers\n"
> >> +    "<interface> - storage device interface (virtio, mmc, etc)\n"
> >> +    "<dev>       - storage device index containing the BCB partition\=
n"
> >> +    "<part>      - partition index or name containing the BCB\n"
> >> +    "<field>     - one of {command,status,recovery,stage,reserved}\n"
> >> +    "<op>        - the binary operator used in 'bcb test':\n"
> >> +    "              '=3D' returns true if <val> matches the string sto=
red
> in <field>\n"
> >> +    "              '~' returns true if <val> matches a subset of
> <field>'s string\n"
> >> +    "<val>       - string/text provided as input to bcb {set,test}\n"
> >> +    "              NOTE: any ':' character in <val> will be replaced
> by line feed\n"
> >> +    "              during 'bcb set' and used as separator by upper
> layers\n"
> >>  );
> >> diff --git a/doc/android/bcb.rst b/doc/android/bcb.rst
> >> index 8861608300..2226517d39 100644
> >> --- a/doc/android/bcb.rst
> >> +++ b/doc/android/bcb.rst
> >> @@ -41,23 +41,25 @@ requirements enumerated above. Below is the
> command's help message::
> >>     bcb - Load/set/clear/test/dump/store Android BCB fields
> >>
> >>     Usage:
> >> -   bcb load  <dev> <part>       - load  BCB from mmc <dev>:<part>
> >> -   bcb set   <field> <val>      - set   BCB <field> to <val>
> >> -   bcb clear [<field>]          - clear BCB <field> or all fields
> >> -   bcb test  <field> <op> <val> - test  BCB <field> against <val>
> >> -   bcb dump  <field>            - dump  BCB <field>
> >> -   bcb store                    - store BCB back to mmc
> >> +   bcb load <interface> <dev> <part>  - load  BCB from <interface>
> <dev>:<part>
> >> +   load <dev> <part>              - load  BCB from mmc <dev>:<part>
> >> +   bcb set   <field> <val>        - set   BCB <field> to <val>
> >> +   bcb clear [<field>]            - clear BCB <field> or all fields
> >> +   bcb test  <field> <op> <val>   - test  BCB <field> against <val>
> >> +   bcb dump  <field>              - dump  BCB <field>
> >> +   bcb store                      - store BCB back to <interface>
> >>
> >>     Legend:
> >> -   <dev>   - MMC device index containing the BCB partition
> >> -   <part>  - MMC partition index or name containing the BCB
> >> -   <field> - one of {command,status,recovery,stage,reserved}
> >> -   <op>    - the binary operator used in 'bcb test':
> >> -             '=3D' returns true if <val> matches the string stored in
> <field>
> >> -             '~' returns true if <val> matches a subset of <field>'s
> string
> >> -   <val>   - string/text provided as input to bcb {set,test}
> >> -             NOTE: any ':' character in <val> will be replaced by lin=
e
> feed
> >> -             during 'bcb set' and used as separator by upper layers
> >> +   <interface> - storage device interface (virtio, mmc, etc)
> >> +   <dev>       - storage device index containing the BCB partition
> >> +   <part>      - partition index or name containing the BCB
> >> +   <field>     - one of {command,status,recovery,stage,reserved}
> >> +   <op>        - the binary operator used in 'bcb test':
> >> +                 '=3D' returns true if <val> matches the string store=
d
> in <field>
> >> +                 '~' returns true if <val> matches a subset of
> <field>'s string
> >> +   <val>       - string/text provided as input to bcb {set,test}
> >> +                 NOTE: any ':' character in <val> will be replaced by
> line feed
> >> +                 during 'bcb set' and used as separator by upper laye=
rs
> >>
> >>
> >>  'bcb'. Example of getting reboot reason
> >> @@ -91,7 +93,7 @@ The following Kconfig options must be enabled::
> >>
> >>     CONFIG_PARTITIONS=3Dy
> >>     CONFIG_MMC=3Dy
> >> -   CONFIG_BCB=3Dy
> >> +   CONFIG_CMD_BCB=3Dy
> >>
> >>  .. [1] https://android.googlesource.com/platform/bootable/recovery
> >>  .. [2] https://source.android.com/devices/bootloader
> >> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common=
.c
> >> index 4e9d9b719c..2a6608b28c 100644
> >> --- a/drivers/fastboot/fb_common.c
> >> +++ b/drivers/fastboot/fb_common.c
> >> @@ -105,7 +105,7 @@ int __weak fastboot_set_reboot_flag(enum
> fastboot_reboot_reason reason)
> >>      if (reason >=3D FASTBOOT_REBOOT_REASONS_COUNT)
> >>              return -EINVAL;
> >>
> >> -    return bcb_write_reboot_reason(mmc_dev, "misc", boot_cmds[reason]=
);
> >> +    return bcb_write_reboot_reason("mmc", mmc_dev, "misc",
> boot_cmds[reason]);
> >>  }
> >>
> >>  /**
> >> diff --git a/include/bcb.h b/include/bcb.h
> >> index 5edb17aa47..a6326523c4 100644
> >> --- a/include/bcb.h
> >> +++ b/include/bcb.h
> >> @@ -9,10 +9,11 @@
> >>  #define __BCB_H__
> >>
> >>  #if IS_ENABLED(CONFIG_CMD_BCB)
> >> -int bcb_write_reboot_reason(int devnum, char *partp, const char
> *reasonp);
> >> +int bcb_write_reboot_reason(const char *iface, int devnum, char
> *partp, const char *reasonp);
> >>  #else
> >>  #include <linux/errno.h>
> >> -static inline int bcb_write_reboot_reason(int devnum, char *partp,
> const char *reasonp)
> >> +static inline int bcb_write_reboot_reason(const char *iface, int
> devnum,
> >> +                                      char *partp, const char *reason=
p)
> >>  {
> >>      return -EOPNOTSUPP;
> >>  }
> >> --
> >> 2.42.0.869.gea05f2083d-goog
>
