Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C782C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8240887D3;
	Sun, 28 Jul 2024 21:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c3Uxz8PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1971088730; Sun, 28 Jul 2024 21:36:19 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1036884C6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-49297fca3c2so405995137.1
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195376; x=1722800176; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uD1bmSkJ9zEKwwwGbkXS5uhg+dIbYUE/0H1FqSj4vco=;
 b=c3Uxz8PM59LxGLfDBUcn7xcuSbKBCBYXAGSgJR/604UXtgom0b8/nFeH/KGgfpm2o8
 pJCdmame53897EV7CHGCO2PhyVh/yEbwJfXfFapHIfJU1zd8aLNcwC4Q98ajssYCSefD
 13aIORgkYFXfo39fxNclcee73AhuDN8NBiYME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195376; x=1722800176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uD1bmSkJ9zEKwwwGbkXS5uhg+dIbYUE/0H1FqSj4vco=;
 b=RgJKHerLzvgBWvwVKdBt0cj30QPArykEQuC4c43tTzfrHij7dd3Lx5ClDm0h8Ij06k
 NPJxzH7Q2tTYCS9IzH4thOgiU7qbQjfxsZ9P7q4pwHJ8Wf9MLtIrpopo9NY7tfCx0LJb
 6JB+aJLhe84dmVaQ04lDU55mMu0/O6XzDYSdnpPbM0uV1vNdREiX4NX8b/0rDrAbc/MT
 4zF0LG+MIEzBPb5b/iYJYizY77PSHVa4ikkL85jr16ixxCX3KSWNl3UjkRltQH+aly8f
 OYtSlgDtWCSOtqxzmmXkKWTCwe6nEBKT/MR0qpLoS170dJGHGpnaJchUm8sSptYo2sLj
 57Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+lmnNCeSO8CVVAwITIsNZnMIjEiI6bcxYi0yN87PoD1af//k95UFOty7hDU76YcrXJ4ZDA8/x0079nqsXjBUuTqkYpg==
X-Gm-Message-State: AOJu0YxjsE0+Q/NX0pYYnZY8GwwOTS89ZiZW1Fx9NIM9S2YDR146iUAs
 kBuI2P3el1ZHecHckO0JrNrO+dj9mKP6gvwB/bdHXTTCnDFqCkyu3U77kWnE/o5VzGI2M0zaCyU
 gkoeFnyM42R8vnUuZXGEUcabVdg7/LGzfcDkJ
X-Google-Smtp-Source: AGHT+IGocQ/H1cazjV8ulwF/jrhqisZH9aG/t/M0qJqYwHQbIeOp+J6qlawnooY6OzKUpsr/d4JuYdprHX7A3Lsnyyg=
X-Received: by 2002:a05:6102:3ec2:b0:48f:e724:4c79 with SMTP id
 ada2fe7eead31-493fad9f0a0mr6965002137.29.1722195375613; Sun, 28 Jul 2024
 12:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-3-ddrokosov@salutedevices.com>
In-Reply-To: <20240725194716.32232-3-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:04 -0600
Message-ID: <CAFLszThbAAQ3Fwtf_t0k-K5xO6Yu8x_37Fejntqq=svwt-gdcQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] cmd: ab: introduce 'ab_dump' command to print BCB
 block content
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

Hi Dmitry,

On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
> > board# ab_dump ubi 0#misc
> > Read 512 bytes from volume misc to 000000000bf51900
> > Bootloader Control:   [misc]
> > Active Slot:          _a
> > Magic Number:                 0x42414342
> > Version:              1
> > Number of Slots:      2
> > Recovery Tries Remaining: 7
> > CRC:                  0x61378F6F (Valid)
> >
> > Slot[0] Metadata:
> >       - Priority:             15
> >       - Tries Remaining:      4
> >       - Successful Boot:      0
> >       - Verity Corrupted:     0
> >
> > Slot[1] Metadata:
> >       - Priority:             15
> >       - Tries Remaining:      5
> >       - Successful Boot:      0
> >       - Verity Corrupted:     0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/ab_select.c      | 30 +++++++++++++++++++
>  include/android_ab.h |  9 ++++++
>  3 files changed, 107 insertions(+)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 1e5aa81b7503..359cc1a00428 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -363,3 +363,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>
>         return slot;
>  }
> +
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
> +{
> +       struct bootloader_control *abc;
> +       u32 crc32_le;
> +       int i, ret;
> +       struct slot_metadata *slot;
> +
> +       if (!dev_desc || !part_info) {
> +               log_err("ANDROID: Empty device descriptor or partition info\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
> +       if (ret < 0) {
> +               log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (abc->magic != BOOT_CTRL_MAGIC) {
> +               log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> +               ret = -ENODATA;
> +               goto error;
> +       }
> +
> +       if (abc->version > BOOT_CTRL_VERSION) {
> +               log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
> +                       abc->version);
> +               ret = -ENODATA;
> +               goto error;
> +       }
> +
> +       if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
> +               log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
> +                       abc->nb_slot, ARRAY_SIZE(abc->slot_info));
> +               ret = -ENODATA;
> +               goto error;
> +       }
> +
> +       printf("Bootloader Control: \t[%s]\n", part_info->name);
> +       printf("Active Slot: \t\t%s\n", abc->slot_suffix);
> +       printf("Magic Number: \t\t0x%X\n", abc->magic);
> +       printf("Version: \t\t%u\n", abc->version);
> +       printf("Number of Slots: \t%u\n", abc->nb_slot);
> +       printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
> +
> +       printf("CRC: \t\t\t0x%.8X", abc->crc32_le);
> +
> +       crc32_le = ab_control_compute_crc(abc);
> +       if (abc->crc32_le != crc32_le)
> +               printf(" (Invalid, Expected: \t0x%.8X)\n", crc32_le);
> +       else
> +               printf(" (Valid)\n");
> +
> +       for (i = 0; i < abc->nb_slot; ++i) {
> +               slot = &abc->slot_info[i];
> +               printf("\nSlot[%d] Metadata:\n", i);
> +               printf("\t- Priority: \t\t%u\n", slot->priority);
> +               printf("\t- Tries Remaining: \t%u\n", slot->tries_remaining);
> +               printf("\t- Successful Boot: \t%u\n", slot->successful_boot);
> +               printf("\t- Verity Corrupted: \t%u\n", slot->verity_corrupted);
> +       }
> +
> +error:
> +       free(abc);
> +
> +       return ret;
> +}
> diff --git a/cmd/ab_select.c b/cmd/ab_select.c
> index 9e2f74573c22..1d34150ceea9 100644
> --- a/cmd/ab_select.c
> +++ b/cmd/ab_select.c
> @@ -51,6 +51,31 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>         return CMD_RET_SUCCESS;
>  }
>
> +static int do_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> +                     char *const argv[])
> +{
> +       int ret;
> +       struct blk_desc *dev_desc;
> +       struct disk_partition part_info;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> +                                                &dev_desc, &part_info,
> +                                                false) < 0) {
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       ret = ab_dump_abc(dev_desc, &part_info);
> +       if (ret < 0) {
> +               printf("Cannot dump ABC data, error %d.\n", ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
>  U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
>            "Select the slot used to boot from and register the boot attempt.",
>            "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
> @@ -66,3 +91,8 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
>            "    - If '--no-dec' is set, the number of tries remaining will not\n"
>            "      decremented for the selected boot slot\n"
>  );
> +
> +U_BOOT_CMD(ab_dump, 3, 0, do_ab_dump,
> +          "Dump boot_control information from specific partition.",
> +          "<interface> <dev[:part|#part_name]>\n"
> +);
> diff --git a/include/android_ab.h b/include/android_ab.h
> index 1fee7582b90a..e53bf7eb6a02 100644
> --- a/include/android_ab.h
> +++ b/include/android_ab.h
> @@ -33,4 +33,13 @@ struct disk_partition;
>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>                     bool dec_tries);
>
> +/**
> + * Dump ABC information for specific partition.
> + *
> + * @param[in] dev_desc Device description pointer
> + * @param[in] part_info Partition information

We have moved to the @ notation now:

@dev_desc: ...

> + * Return: 0 on success, or a negative on error
> + */
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
> +
>  #endif /* __ANDROID_AB_H */
> --
> 2.43.0
>

Rather than creating a new command I think this should be a subcommand
of abootimg.

Can you please create some docs in doc/usage/cmd/abootimg for the command?

I also wonder if ab_select should move under that command?

Regards,
SImon
