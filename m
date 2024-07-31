Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03BAC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D2B88A47;
	Wed, 31 Jul 2024 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nIRf0NVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD09588A3E; Wed, 31 Jul 2024 16:39:05 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3815E88A2F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-704466b19c4so3522001a34.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436740; x=1723041540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5eFoaptJI8ypc7kLczpdwXpANq7oq5cQCbANowwjHOA=;
 b=nIRf0NVEEVb8+/M3l2STv20t02P7NDdDfUNiitjso9QnMaccXQBO12zrdjsnvGBUGP
 98+iEbpUyIpjr81tMhpSIjGS0XEk3YnvNw16Fu8Jksu/B6mMCeuN8khSUTXw8Gy3Wsyp
 tOtxrhCFHurTrq3NrlgDK6fLIIXrlv1/b0GRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436740; x=1723041540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5eFoaptJI8ypc7kLczpdwXpANq7oq5cQCbANowwjHOA=;
 b=Ef2lu9eIC/NdK6FbDxYA49krapAJ4DCpsEVa7u8dotd+NVuUFs7rB+JJyxTC3N1Rvw
 CO2DPub4MF5OhkOFpnwFnVzD0OAxwxyb5QGJuz93R/Y/fRtXf/nL7o1CsAx/FvOYd/8z
 jCnJsk15toOqzFcyTydGzfDtUMVRFy4xpuo7s9rjb3JwWDr+z9Mr+RWnOVZdcGRzupOJ
 8eh8qWhYOZ1Erg+7q3AIxG5K5Bbivwt70APBbjFSgt8TW8fcQ8+HkayGn529gexmm/gK
 lSfurQKS+4iCIkITikySnYXOL7nGg58x8A9eaQkVXGl/jnK3IiXTCiV7I57LjxlplvB3
 4EWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqlt6qSbaFmyQ+L+pE3tC6cj2LdLgLU4A6bIhEjwENtn0mGdbI8LvOSwlu+d33q/xxHzWia213Cxic4On3SWiY/UeoQ==
X-Gm-Message-State: AOJu0YzdPgacsKBcDDu4+8wc60D310QYRBM4FmgVnhkXjhazBqGk1hG2
 ulI1VCWuuo6tqlPp/zXuKtS2jIcQt9CjxVmtCEF9GDmPu5EMMS4dsGSMKb1RGqmhSgAOnro6usV
 wIozluaGMEcSFUM/K6r1AVSfpDNIYX3iARVxK9UN887Nl5rc=
X-Google-Smtp-Source: AGHT+IE8BZZXRhVAVp4fZqwou3qkfZonmX3LQebnHjScirhYTaQhvpA1zxPEQy9/QDi4FNZxSLi2XJZvNeZyLYIARok=
X-Received: by 2002:a05:6358:758e:b0:1aa:9fdd:af89 with SMTP id
 e5c5f4694b2df-1adc06d4d7dmr2657253355d.20.1722436739874; Wed, 31 Jul 2024
 07:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-3-ddrokosov@salutedevices.com>
 <CAFLszThbAAQ3Fwtf_t0k-K5xO6Yu8x_37Fejntqq=svwt-gdcQ@mail.gmail.com>
 <87ed7bqolf.fsf@baylibre.com>
In-Reply-To: <87ed7bqolf.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:49 -0600
Message-ID: <CAFLszTik6sK+dU5hK8bfXq-Ho+V1FwfgBaXuGPDRwFYkzw9=VA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] cmd: ab: introduce 'ab_dump' command to print BCB
 block content
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com, 
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

Hi Mattijs,

On Tue, 30 Jul 2024 at 02:19, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Dmitry,
>
> Thank you for the patch.
>
> Hi Simon,
>
> On dim., juil. 28, 2024 at 13:36, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Dmitry,
> >
> > On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
> > <ddrokosov@salutedevices.com> wrote:
> >>
> >> It's really helpful to have the ability to dump BCB block for debugging
> >> A/B logic on the board supported this partition schema.
> >>
> >> Command 'ab_dump' prints all fields of bootloader_control struct
> >> including slot_metadata for all presented slots.
> >>
> >> Output example:
> >> =====
> >> > board# ab_dump ubi 0#misc
> >> > Read 512 bytes from volume misc to 000000000bf51900
> >> > Bootloader Control:   [misc]
> >> > Active Slot:          _a
> >> > Magic Number:                 0x42414342
> >> > Version:              1
> >> > Number of Slots:      2
> >> > Recovery Tries Remaining: 7
> >> > CRC:                  0x61378F6F (Valid)
> >> >
> >> > Slot[0] Metadata:
> >> >       - Priority:             15
> >> >       - Tries Remaining:      4
> >> >       - Successful Boot:      0
> >> >       - Verity Corrupted:     0
> >> >
> >> > Slot[1] Metadata:
> >> >       - Priority:             15
> >> >       - Tries Remaining:      5
> >> >       - Successful Boot:      0
> >> >       - Verity Corrupted:     0
> >> ====
> >>
> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> ---
> >>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
> >>  cmd/ab_select.c      | 30 +++++++++++++++++++
> >>  include/android_ab.h |  9 ++++++
> >>  3 files changed, 107 insertions(+)
> >>
> >> diff --git a/boot/android_ab.c b/boot/android_ab.c
> >> index 1e5aa81b7503..359cc1a00428 100644
> >> --- a/boot/android_ab.c
> >> +++ b/boot/android_ab.c
> >> @@ -363,3 +363,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
> >>
> >>         return slot;
> >>  }
> >> +
> >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
> >> +{
> >> +       struct bootloader_control *abc;
> >> +       u32 crc32_le;
> >> +       int i, ret;
> >> +       struct slot_metadata *slot;
> >> +
> >> +       if (!dev_desc || !part_info) {
> >> +               log_err("ANDROID: Empty device descriptor or partition info\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
> >> +       if (ret < 0) {
> >> +               log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +
> >> +       if (abc->magic != BOOT_CTRL_MAGIC) {
> >> +               log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> >> +               ret = -ENODATA;
> >> +               goto error;
> >> +       }
> >> +
> >> +       if (abc->version > BOOT_CTRL_VERSION) {
> >> +               log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
> >> +                       abc->version);
> >> +               ret = -ENODATA;
> >> +               goto error;
> >> +       }
> >> +
> >> +       if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
> >> +               log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
> >> +                       abc->nb_slot, ARRAY_SIZE(abc->slot_info));
> >> +               ret = -ENODATA;
> >> +               goto error;
> >> +       }
> >> +
> >> +       printf("Bootloader Control: \t[%s]\n", part_info->name);
> >> +       printf("Active Slot: \t\t%s\n", abc->slot_suffix);
> >> +       printf("Magic Number: \t\t0x%X\n", abc->magic);
> >> +       printf("Version: \t\t%u\n", abc->version);
> >> +       printf("Number of Slots: \t%u\n", abc->nb_slot);
> >> +       printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
>
> In the console, this rendered not perfectly aligned, which is a bit of a
> shame:
>
> (done on sandbox)
>
> => ab_dump mmc 7#misc
> Bootloader Control:     [misc]
> Active Slot:            _a
> Magic Number:           0x42414342
> Version:                1
> Number of Slots:        2
> Recovery Tries Remaining: 0
> CRC:                    0x321FEF27 (Valid)
>
> >> +
> >> +       printf("CRC: \t\t\t0x%.8X", abc->crc32_le);
> >> +
> >> +       crc32_le = ab_control_compute_crc(abc);
> >> +       if (abc->crc32_le != crc32_le)
> >> +               printf(" (Invalid, Expected: \t0x%.8X)\n", crc32_le);
> >> +       else
> >> +               printf(" (Valid)\n");
> >> +
> >> +       for (i = 0; i < abc->nb_slot; ++i) {
> >> +               slot = &abc->slot_info[i];
> >> +               printf("\nSlot[%d] Metadata:\n", i);
> >> +               printf("\t- Priority: \t\t%u\n", slot->priority);
> >> +               printf("\t- Tries Remaining: \t%u\n", slot->tries_remaining);
> >> +               printf("\t- Successful Boot: \t%u\n", slot->successful_boot);
> >> +               printf("\t- Verity Corrupted: \t%u\n", slot->verity_corrupted);
> >> +       }
> >> +
> >> +error:
> >> +       free(abc);
> >> +
> >> +       return ret;
> >> +}
> >> diff --git a/cmd/ab_select.c b/cmd/ab_select.c
> >> index 9e2f74573c22..1d34150ceea9 100644
> >> --- a/cmd/ab_select.c
> >> +++ b/cmd/ab_select.c
> >> @@ -51,6 +51,31 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
> >>         return CMD_RET_SUCCESS;
> >>  }
> >>
> >> +static int do_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> >> +                     char *const argv[])
> >> +{
> >> +       int ret;
> >> +       struct blk_desc *dev_desc;
> >> +       struct disk_partition part_info;
> >> +
> >> +       if (argc < 3)
> >> +               return CMD_RET_USAGE;
> >> +
> >> +       if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> >> +                                                &dev_desc, &part_info,
> >> +                                                false) < 0) {
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >> +
> >> +       ret = ab_dump_abc(dev_desc, &part_info);
> >> +       if (ret < 0) {
> >> +               printf("Cannot dump ABC data, error %d.\n", ret);
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >> +
> >> +       return CMD_RET_SUCCESS;
> >> +}
> >> +
> >>  U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
> >>            "Select the slot used to boot from and register the boot attempt.",
> >>            "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
> >> @@ -66,3 +91,8 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
> >>            "    - If '--no-dec' is set, the number of tries remaining will not\n"
> >>            "      decremented for the selected boot slot\n"
> >>  );
> >> +
> >> +U_BOOT_CMD(ab_dump, 3, 0, do_ab_dump,
> >> +          "Dump boot_control information from specific partition.",
> >> +          "<interface> <dev[:part|#part_name]>\n"
> >> +);
> >> diff --git a/include/android_ab.h b/include/android_ab.h
> >> index 1fee7582b90a..e53bf7eb6a02 100644
> >> --- a/include/android_ab.h
> >> +++ b/include/android_ab.h
> >> @@ -33,4 +33,13 @@ struct disk_partition;
> >>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
> >>                     bool dec_tries);
> >>
> >> +/**
> >> + * Dump ABC information for specific partition.
> >> + *
> >> + * @param[in] dev_desc Device description pointer
> >> + * @param[in] part_info Partition information
> >
> > We have moved to the @ notation now:
> >
> > @dev_desc: ...
>
> I agree with this comment, but the file uses @param[in] already. We
> should to a preparatory patch to convert this file to the new notation.

OK, can do later.

>
> >
> >> + * Return: 0 on success, or a negative on error
> >> + */
> >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
> >> +
> >>  #endif /* __ANDROID_AB_H */
> >> --
> >> 2.43.0
> >>
> >
> > Rather than creating a new command I think this should be a subcommand
> > of abootimg.
>
> To me, they are not the same thing.
>
> - ab_* commands are for manipulating specific bits from the BCB (Boot
>   Control Block, usually "misc" partition)
>   ab_* operates on partitions
>
> - abootimg is for manipulating boot.img and vendor_boot.img headers
>   (which are not on the same partitions)
>   abootimg operations on memory regions (so someone else is responsible
>   for reading the partitions)
>
> We also have a 3rd command "bcb". "bcb" also reads the "misc" partition
> but can only read the "boot reason".
> If we really want to merge ab_select and ab_dump into another command,
> "bcb" is more relevant, in my opinion.

That sounds good.

>
> I'd prefer to keep 3 commands for the following reasons:
>
> 1. Easier to track/port changes from Google's fork [1]
> 2. Better separation of responsabilities
> 3. Merging the commands requires the update of the existing U-Boot
>    environment users (meson64_android.h for example)
>
> I don't strongly disagree with merging, but I'd prefer to keep it this way.
>
> [1] https://android.googlesource.com/platform/external/u-boot
>
> Simon, can you elaborate on why we should merge the commands? Do you
> think that for U-Boot users it will be easier to have a single command
> for all Android related topics?

Not necessarily, it's just that we do try to keep similar pieces of
functionality together. Perhaps we should create an entirely new
command to bring all (or most) these things together, with aliases for
compatibility?

Note that 'boota' might be a better name for actually booting an
Android image, since we have bootm, booti, etc. Having said that, with
bootstd it might just be automatic.

Why does Android have its own fork? I am not keen on any argument that
says that mainline needs to follow a fork!


>
> >
> > Can you please create some docs in doc/usage/cmd/abootimg for the command?
> >
> > I also wonder if ab_select should move under that command?

Regards,
SImon
