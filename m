Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F62C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 06:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B08877CC;
	Fri, 10 Nov 2023 07:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="1Va21+Wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34096877D7; Fri, 10 Nov 2023 07:06:57 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FCA877BF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 07:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40837124e1cso152325e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 22:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699596413; x=1700201213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Te4cXC7cAG5GXNHf3hTlBdUefiR3FiIO4sTBRLNFI40=;
 b=1Va21+WmBnh7GwC+gjQ6AnxG0U8+AnQRoUpX6aY+J86Q9qmm2G2aopPcdaYQB1fGfn
 +WxKZSsL04qZVwy5svC5/Bx9VnSBTGUdGAEGL7x0R1bAhRB49QIr399A0nIBxLKtlSvN
 agPRyPoK1nx/74qvKrjLpBwA1Nb+Ze/9r+uN/TXwBiEg5AFBaEzA6pszCqFLswHJLJ56
 ZgtlPnc8jGXfgYe6dcZ1C1nwS0xZhPgpmyEHoZBi2+3s9/WTcAbkD08sX7YjXvNlwRO6
 JqgCD7L5t2VPiFAv9gGaCzcBesv75Vf3cGevoejifE0dMTGEypJc2Dm0VcpEhWCJojmE
 qhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699596413; x=1700201213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Te4cXC7cAG5GXNHf3hTlBdUefiR3FiIO4sTBRLNFI40=;
 b=cbjC+kroRR0KiMrNO0ipCsfCNPlKl9i81cpmYuc+mBdh0dtKPD1Fhhp0jnaq252i+/
 i2OYZ9Pc4UdQqI0tMQO06PnknCS45Mq4JXvvgnPa8aL3OE1DIXlSjf8B7LFhZWJK4ou7
 GWyeqL6ig6r4v7NpG6aHL+CPLCteeBk0PiX9BRUkshdl89rbboaXrU/+vSRD0wK5QyrJ
 NMb0H6QrbAhpwn9b1rhvHu8nPOZUJVbenfReC0+XD2R1JJj/0/WYSQBPhR8BpOZ4XU1c
 aZ6hcbMh9ZauhZeFh5FWKflW5t9sxeoo/LpypX2efq4TAGNz7tSMeF5KSZ+41d3FD62l
 Z6DQ==
X-Gm-Message-State: AOJu0YxexHGTdUe7pJ413QSuWbC2VgrBMYrfqlUDxW9rs8lyFgrerR1Q
 8r6KBJAmoHA9VnkeS27T0bbKaTXWIgkfeYEeQ/E53LzFUCdB2AN4VeabKA==
X-Google-Smtp-Source: AGHT+IFcE2OUD8ziUGdylnz5zdEZh/OWEq4yDx6E67NbTP5tdKR+r2gRYw5PmNzdEkUOseOAqKgW0u8z3DuFbWV0Bqg=
X-Received: by 2002:a05:600c:2d8b:b0:408:3725:b96a with SMTP id
 i11-20020a05600c2d8b00b004083725b96amr288879wmg.0.1699596413024; Thu, 09 Nov
 2023 22:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20231109003634.577152-1-dimorinny@google.com>
 <20231109003634.577152-3-dimorinny@google.com>
 <877cmr9r91.fsf@baylibre.com>
In-Reply-To: <877cmr9r91.fsf@baylibre.com>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Thu, 9 Nov 2023 22:06:41 -0800
Message-ID: <CAOWkq4=X0F9QbZUN29mxYMF3zoNTTiOj-=fWTVJYRnD4uisqgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: bcb: extend BCB C API to allow read/write the
 fields
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com, 
 Cody Schuffelen <schuffelen@google.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <sean.anderson@seco.com>
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

Uploaded v2 with fixes

On Thu, Nov 9, 2023 at 2:05=E2=80=AFAM Mattijs Korpershoek <
mkorpershoek@baylibre.com> wrote:

> Hi Dmitrii,
>
> Thank you for your patch.
>
> On jeu., nov. 09, 2023 at 00:36, Dmitrii Merkurev <dimorinny@google.com>
> wrote:
>
> > Currently BCB C API only allows to modify 'command' BCB field.
> > Extend it so that we can also read and modify all the available
> > BCB fields (command, status, recovery, stage).
> >
> > Co-developed-by: Cody Schuffelen <schuffelen@google.com>
> > Signed-off-by: Cody Schuffelen <schuffelen@google.com>
> > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> > Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Cc: Sean Anderson <sean.anderson@seco.com>
> > Cc: Cody Schuffelen <schuffelen@google.com>
>
> I could test this after applying the diffs from:
> https://lore.kernel.org/all/87a5rn9sdm.fsf@baylibre.com/
>
> I tested with:
> $ fastboot reboot bootloader
> =3D> bcb load mmc 2 misc
> =3D> bcb dump command
>
> I also tested
> =3D> bcb set status hello
> =3D> bcb dump status
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Some small nitpicks below.
> The nitpick do not have to be adressed if you don't want to.
>
> > ---
> >  cmd/bcb.c                    | 162 +++++++++++++++++++++++------------
> >  drivers/fastboot/fb_common.c |  14 ++-
> >  include/bcb.h                |  60 ++++++++++++-
> >  3 files changed, 179 insertions(+), 57 deletions(-)
> >
> > diff --git a/cmd/bcb.c b/cmd/bcb.c
> > index 5d8c232663..7a77b7f7b0 100644
> > --- a/cmd/bcb.c
> > +++ b/cmd/bcb.c
> > @@ -25,10 +25,18 @@ enum bcb_cmd {
> >       BCB_CMD_STORE,
> >  };
> >
> > -static enum uclass_id bcb_uclass_id =3D UCLASS_INVALID;
> > -static int bcb_dev =3D -1;
> > -static int bcb_part =3D -1;
> > +static const char * const fields[] =3D {
> > +     "command",
> > +     "status",
> > +     "recovery",
> > +     "stage"
> > +};
> > +
> >  static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) =3D =
{ {
> 0 } };
> > +static struct disk_partition partition_data;
> > +
> > +static struct blk_desc *block;
> > +static struct disk_partition *partition =3D &partition_data;
> >
> >  static int bcb_cmd_get(char *cmd)
> >  {
> > @@ -82,7 +90,7 @@ static int bcb_is_misused(int argc, char *const argv[=
])
> >               return -1;
> >       }
> >
> > -     if (cmd !=3D BCB_CMD_LOAD && (bcb_dev < 0 || bcb_part < 0)) {
> > +     if (cmd !=3D BCB_CMD_LOAD && !block) {
> >               printf("Error: Please, load BCB first!\n");
> >               return -1;
> >       }
> > @@ -94,7 +102,7 @@ err:
> >       return -1;
> >  }
> >
> > -static int bcb_field_get(char *name, char **fieldp, int *sizep)
> > +static int bcb_field_get(const char *name, char **fieldp, int *sizep)
> >  {
> >       if (!strcmp(name, "command")) {
> >               *fieldp =3D bcb.command;
> > @@ -119,16 +127,21 @@ static int bcb_field_get(char *name, char
> **fieldp, int *sizep)
> >       return 0;
> >  }
> >
> > -static int __bcb_load(const char *iface, int devnum, const char *partp=
)
> > +static void __bcb_reset(void)
> > +{
> > +     block =3D NULL;
> > +     partition =3D &partition_data;
> > +     memset(&partition_data, 0, sizeof(struct disk_partition));
> > +     memset(&bcb, 0, sizeof(struct bootloader_message));
> > +}
> > +
> > +static int __bcb_initialize(const char *iface, int devnum, const char
> *partp)
> >  {
> > -     struct blk_desc *desc;
> > -     struct disk_partition info;
> > -     u64 cnt;
> >       char *endp;
> >       int part, ret;
> >
> > -     desc =3D blk_get_dev(iface, devnum);
> > -     if (!desc) {
> > +     block =3D blk_get_dev(iface, devnum);
> > +     if (!block) {
> >               ret =3D -ENODEV;
> >               goto err_read_fail;
> >       }
> > @@ -137,7 +150,7 @@ static int __bcb_load(const char *iface, int devnum=
,
> const char *partp)
> >        * always select the first hwpart in case another
> >        * blk operation selected a different hwpart
> >        */
> > -     ret =3D blk_dselect_hwpart(desc, 0);
> > +     ret =3D blk_dselect_hwpart(block, 0);
> >       if (IS_ERR_VALUE(ret)) {
> >               ret =3D -ENODEV;
> >               goto err_read_fail;
> > @@ -145,49 +158,63 @@ static int __bcb_load(const char *iface, int
> devnum, const char *partp)
> >
> >       part =3D simple_strtoul(partp, &endp, 0);
> >       if (*endp =3D=3D '\0') {
> > -             ret =3D part_get_info(desc, part, &info);
> > +             ret =3D part_get_info(block, part, partition);
> >               if (ret)
> >                       goto err_read_fail;
> >       } else {
> > -             part =3D part_get_info_by_name(desc, partp, &info);
> > +             part =3D part_get_info_by_name(block, partp, partition);
> >               if (part < 0) {
> >                       ret =3D part;
> >                       goto err_read_fail;
> >               }
> >       }
> >
> > -     cnt =3D DIV_ROUND_UP(sizeof(struct bootloader_message), info.blks=
z);
> > -     if (cnt > info.size)
> > +     return CMD_RET_SUCCESS;
> > +
> > +err_read_fail:
> > +     printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
> > +            block->devnum, partition->name, ret);
> > +     goto err;
>
> Nitpick: No need for this goto, we can just fall-through.
>
> > +err:
> > +     __bcb_reset();
> > +     return CMD_RET_FAILURE;
> > +}
> > +
> > +static int __bcb_load(void)
> > +{
> > +     u64 cnt;
> > +     int ret;
> > +
> > +     cnt =3D DIV_ROUND_UP(sizeof(struct bootloader_message),
> partition->blksz);
> > +     if (cnt > partition->size)
> >               goto err_too_small;
> >
> > -     if (blk_dread(desc, info.start, cnt, &bcb) !=3D cnt) {
> > +     if (blk_dread(block, partition->start, cnt, &bcb) !=3D cnt) {
> >               ret =3D -EIO;
> >               goto err_read_fail;
> >       }
> >
> > -     bcb_uclass_id =3D desc->uclass_id;
> > -     bcb_dev =3D desc->devnum;
> > -     bcb_part =3D part;
> > -     debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev,
> bcb_part);
> > +     debug("%s: Loaded from %d %d:%s\n", __func__, block->uclass_id,
> > +           block->devnum, partition->name);
> >
> >       return CMD_RET_SUCCESS;
> >  err_read_fail:
> > -     printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp=
,
> ret);
> > +     printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
> > +            block->devnum, partition->name, ret);
> >       goto err;
> >  err_too_small:
> > -     printf("Error: %s %d:%s too small!", iface, devnum, partp);
> > +     printf("Error: %d %d:%s too small!", block->uclass_id,
> > +            block->devnum, partition->name);
> >       goto err;
> >  err:
> > -     bcb_uclass_id =3D UCLASS_INVALID;
> > -     bcb_dev =3D -1;
> > -     bcb_part =3D -1;
> > -
> > +     __bcb_reset();
>
> Nitpick: __bcb_reset() introduction could have been done in a separate
> patch
>
> >       return CMD_RET_FAILURE;
> >  }
> >
> >  static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
> >                      char * const argv[])
> >  {
> > +     int ret;
> >       int devnum;
> >       char *endp;
> >       char *iface =3D "mcc";
> > @@ -204,10 +231,14 @@ static int do_bcb_load(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >               return CMD_RET_FAILURE;
> >       }
> >
> > -     return __bcb_load(iface, devnum, argv[2]);
> > +     ret =3D __bcb_initialize(iface, devnum, argv[2]);
> > +     if (ret !=3D CMD_RET_SUCCESS)
> > +             return ret;
> > +
> > +     return __bcb_load();
> >  }
> >
> > -static int __bcb_set(char *fieldp, const char *valp)
> > +static int __bcb_set(const char *fieldp, const char *valp)
> >  {
> >       int size, len;
> >       char *field, *str, *found, *tmp;
> > @@ -307,31 +338,20 @@ static int do_bcb_dump(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >
> >  static int __bcb_store(void)
> >  {
> > -     struct blk_desc *desc;
> > -     struct disk_partition info;
> >       u64 cnt;
> >       int ret;
> >
> > -     desc =3D blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
> > -     if (!desc) {
> > -             ret =3D -ENODEV;
> > -             goto err;
> > -     }
> > -
> > -     ret =3D part_get_info(desc, bcb_part, &info);
> > -     if (ret)
> > -             goto err;
> > -
> > -     cnt =3D DIV_ROUND_UP(sizeof(struct bootloader_message), info.blks=
z);
> > +     cnt =3D DIV_ROUND_UP(sizeof(struct bootloader_message),
> partition->blksz);
> >
> > -     if (blk_dwrite(desc, info.start, cnt, &bcb) !=3D cnt) {
> > +     if (blk_dwrite(block, partition->start, cnt, &bcb) !=3D cnt) {
> >               ret =3D -EIO;
> >               goto err;
> >       }
> >
> >       return CMD_RET_SUCCESS;
> >  err:
> > -     printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id,
> bcb_dev, bcb_part, ret);
> > +     printf("Error: %d %d:%s write failed (%d)\n", block->uclass_id,
> > +            block->devnum, partition->name, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -342,23 +362,59 @@ static int do_bcb_store(struct cmd_tbl *cmdtp, in=
t
> flag, int argc,
> >       return __bcb_store();
> >  }
> >
> > -int bcb_write_reboot_reason(const char *iface, int devnum, char *partp=
,
> const char *reasonp)
> > +int bcb_find_partition_and_load(const char *iface, int devnum, char
> *partp)
> >  {
> >       int ret;
> >
> > -     ret =3D __bcb_load(iface, devnum, partp);
> > -     if (ret !=3D CMD_RET_SUCCESS)
> > -             return ret;
> > +     __bcb_reset();
> >
> > -     ret =3D __bcb_set("command", reasonp);
> > +     ret =3D __bcb_initialize(iface, devnum, partp);
> >       if (ret !=3D CMD_RET_SUCCESS)
> >               return ret;
> >
> > -     ret =3D __bcb_store();
> > -     if (ret !=3D CMD_RET_SUCCESS)
> > -             return ret;
> > +     return __bcb_load();
> > +}
> >
> > -     return 0;
> > +int bcb_load(struct blk_desc *block_description, struct disk_partition
> *disk_partition)
> > +{
> > +     __bcb_reset();
> > +
> > +     block =3D block_description;
> > +     partition =3D disk_partition;
> > +
> > +     return __bcb_load();
> > +}
> > +
> > +int bcb_set(enum bcb_field field, const char *value)
> > +{
> > +     if (field > BCB_FIELD_STAGE)
> > +             return CMD_RET_FAILURE;
> > +     return __bcb_set(fields[field], value);
> > +}
> > +
> > +int bcb_get(enum bcb_field field, char *value_out, size_t value_size)
> > +{
> > +     int size;
> > +     char *field_value;
> > +
> > +     if (field > BCB_FIELD_STAGE)
> > +             return CMD_RET_FAILURE;
> > +     if (bcb_field_get(fields[field], &field_value, &size))
> > +             return CMD_RET_FAILURE;
> > +
> > +     strlcpy(value_out, field_value, value_size);
> > +
> > +     return CMD_RET_SUCCESS;
> > +}
> > +
> > +int bcb_store(void)
> > +{
> > +     return __bcb_store();
> > +}
> > +
> > +void bcb_reset(void)
> > +{
> > +     __bcb_reset();
> >  }
> >
> >  static struct cmd_tbl cmd_bcb_sub[] =3D {
> > diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.=
c
> > index 2a6608b28c..3576b06772 100644
> > --- a/drivers/fastboot/fb_common.c
> > +++ b/drivers/fastboot/fb_common.c
> > @@ -91,6 +91,7 @@ void fastboot_okay(const char *reason, char *response=
)
> >   */
> >  int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason=
)
> >  {
> > +     int ret;
> >       static const char * const boot_cmds[] =3D {
> >               [FASTBOOT_REBOOT_REASON_BOOTLOADER] =3D
> "bootonce-bootloader",
> >               [FASTBOOT_REBOOT_REASON_FASTBOOTD] =3D "boot-fastboot",
> > @@ -105,7 +106,18 @@ int __weak fastboot_set_reboot_flag(enum
> fastboot_reboot_reason reason)
> >       if (reason >=3D FASTBOOT_REBOOT_REASONS_COUNT)
> >               return -EINVAL;
> >
> > -     return bcb_write_reboot_reason("mmc", mmc_dev, "misc",
> boot_cmds[reason]);
> > +     ret =3D bcb_find_partition_and_load("mmc", mmc_dev, "misc");
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret =3D bcb_set(BCB_FIELD_COMMAND, boot_cmds[reason]);
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret =3D bcb_store();
> > +out:
> > +     bcb_reset();
> > +     return ret;
> >  }
> >
> >  /**
> > diff --git a/include/bcb.h b/include/bcb.h
> > index a6326523c4..1941d8c28b 100644
> > --- a/include/bcb.h
> > +++ b/include/bcb.h
> > @@ -8,15 +8,69 @@
> >  #ifndef __BCB_H__
> >  #define __BCB_H__
> >
> > +#include <part.h>
> > +
> > +enum bcb_field {
> > +     BCB_FIELD_COMMAND,
> > +     BCB_FIELD_STATUS,
> > +     BCB_FIELD_RECOVERY,
> > +     BCB_FIELD_STAGE
> > +};
> > +
> >  #if IS_ENABLED(CONFIG_CMD_BCB)
> > -int bcb_write_reboot_reason(const char *iface, int devnum, char *partp=
,
> const char *reasonp);
> > +
> > +int bcb_find_partition_and_load(const char *iface,
> > +                             int devnum, char *partp);
> > +int bcb_load(struct blk_desc *block_description,
> > +          struct disk_partition *disk_partition);
> > +int bcb_set(enum bcb_field field, const char *value);
> > +
> > +/**
> > + * bcb_get() - get the field value.
> > + * @field: field to get
> > + * @value_out: buffer to copy bcb field value to
> > + * @value_size: buffer size to avoid overflow in case
> > + *              value_out is smaller then the field value
> > + */
> > +int bcb_get(enum bcb_field field, char *value_out, size_t value_size);
> > +
> > +int bcb_store(void);
> > +void bcb_reset(void);
> > +
> >  #else
> > +
> >  #include <linux/errno.h>
> > -static inline int bcb_write_reboot_reason(const char *iface, int devnu=
m,
> > -                                       char *partp, const char *reason=
p)
> > +
> > +static inline int bcb_load(struct blk_desc *block_description,
> > +                        struct disk_partition *disk_partition)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int bcb_find_partition_and_load(const char *iface,
> > +                                           int devnum, char *partp)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int bcb_set(enum bcb_field field, const char *value)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int bcb_get(enum bcb_field field, char *value_out)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +
> > +static inline int bcb_store(void)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void bcb_reset(void)
> > +{
> > +}
> >  #endif
> >
> >  #endif /* __BCB_H__ */
> > --
> > 2.42.0.869.gea05f2083d-goog
>
