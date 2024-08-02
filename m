Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 07:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8E38862D;
	Fri,  2 Aug 2024 09:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aUPn1CqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 712278863C; Fri,  2 Aug 2024 09:20:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD03388606
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 09:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so16579345e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722583198; x=1723187998;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+gLUZ234pmEsrq4gP+Zjn6CP4HKlmvdTOByZiV7ivzQ=;
 b=aUPn1CqVF7Q3Wf7HYC3l240qsxNay8aNDM38gUsBPKfwoy+I/glRvOutN8+YxjyIPn
 bbJjpYaXcwUWWv6VZYmt1Mf+skNTVKvdeOmImMxe572j8Ay1zj7WNa1BL4HaWBhJLMrk
 Vo45ocUXIxZCrji8yHRA2TgxogxmyJlrzfCCbXTVjvrf5IoFeIEDPbNHSY5WzGnX1eLX
 SXvuA/2GWfkjZM71uUUwK1jZSlLQpSZI8HAiZ608Pf8ZqxvK7HiQte/y5CUYyUT+eQOV
 I9pbxGkVVZYGrzSxO1SQv7mIM4HXTAR/+ANIMnbZQmFYT2ZG9+BPg6fcP3X+5a44Pa6+
 mL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722583198; x=1723187998;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gLUZ234pmEsrq4gP+Zjn6CP4HKlmvdTOByZiV7ivzQ=;
 b=ZMrYdDMYGpHVdCoTIOkwkRgknfbAiXjYzQaiRHCHskZHEzlsuEDxym8AfDkaMLTvfO
 qoxfQRm8rd5M0U4utnC8IQXVp4hiEzmhrRJQBjDXdLdh6hZMZ+sBuYB+R387R2oAWKR8
 46zjtfXhM14Ug71TmOQ4Q8xGR+dmsjlCVH3m6YBAJtEUIr9zYhdutJy1ewjLXLRwcPUM
 o3iEkPbDdH3CqUD7n6mNl2GM5+F6bxfZTixOTYzbDXHbv4aO2lU0T+PbVLUB/JWyBsoU
 c9qINopzcRVv7h61wUNWqv3/5q71t0n/BlOsqrsFmJ6OeMb8coYOf0If0OI8QYL4bEQj
 uHYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdZR4d9iPcQj8/agRGHzaSsoFga8CeWYJEt9usr6lcyEDIajjnELId7zhktrutVMA4z3UDSis9AYhVlg1dGmdHOCISJQ==
X-Gm-Message-State: AOJu0Yzr9n9sfjBMlf1mjkqLRes8eaDzjPYzpyM7oop3vkgBu7t/QXSM
 GXZmvqgFShYWspgBGE0bpNaKg1984vJNyS4ju4cWDjVLavSBLKS11WwcfNE+sVE=
X-Google-Smtp-Source: AGHT+IG5TeUiP/nPtGl37JgzbZzpQObCh3UmwzRx2VCNrzR53mQCrcAxCU+LBaF6xbEy2+Tc1ZKbmw==
X-Received: by 2002:a05:600c:35cd:b0:426:6eb6:1374 with SMTP id
 5b1f17b1804b1-428e465b0c2mr35491685e9.0.1722583197323; 
 Fri, 02 Aug 2024 00:19:57 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm21980005e9.16.2024.08.02.00.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 00:19:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com,
 avromanov@salutedevices.com, u-boot@lists.denx.de,
 kernel@salutedevices.com, rockosov@gmail.com
Subject: Re: [PATCH v1 2/4] cmd: ab: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <CAFLszTik6sK+dU5hK8bfXq-Ho+V1FwfgBaXuGPDRwFYkzw9=VA@mail.gmail.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-3-ddrokosov@salutedevices.com>
 <CAFLszThbAAQ3Fwtf_t0k-K5xO6Yu8x_37Fejntqq=svwt-gdcQ@mail.gmail.com>
 <87ed7bqolf.fsf@baylibre.com>
 <CAFLszTik6sK+dU5hK8bfXq-Ho+V1FwfgBaXuGPDRwFYkzw9=VA@mail.gmail.com>
Date: Fri, 02 Aug 2024 09:19:56 +0200
Message-ID: <87wmkz5r37.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

On mer., juil. 31, 2024 at 08:38, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Tue, 30 Jul 2024 at 02:19, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Dmitry,
>>
>> Thank you for the patch.
>>
>> Hi Simon,
>>
>> On dim., juil. 28, 2024 at 13:36, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi Dmitry,
>> >
>> > On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
>> > <ddrokosov@salutedevices.com> wrote:
>> >>
>> >> It's really helpful to have the ability to dump BCB block for debugging
>> >> A/B logic on the board supported this partition schema.
>> >>
>> >> Command 'ab_dump' prints all fields of bootloader_control struct
>> >> including slot_metadata for all presented slots.
>> >>
>> >> Output example:
>> >> =====
>> >> > board# ab_dump ubi 0#misc
>> >> > Read 512 bytes from volume misc to 000000000bf51900
>> >> > Bootloader Control:   [misc]
>> >> > Active Slot:          _a
>> >> > Magic Number:                 0x42414342
>> >> > Version:              1
>> >> > Number of Slots:      2
>> >> > Recovery Tries Remaining: 7
>> >> > CRC:                  0x61378F6F (Valid)
>> >> >
>> >> > Slot[0] Metadata:
>> >> >       - Priority:             15
>> >> >       - Tries Remaining:      4
>> >> >       - Successful Boot:      0
>> >> >       - Verity Corrupted:     0
>> >> >
>> >> > Slot[1] Metadata:
>> >> >       - Priority:             15
>> >> >       - Tries Remaining:      5
>> >> >       - Successful Boot:      0
>> >> >       - Verity Corrupted:     0
>> >> ====
>> >>
>> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> >> ---
>> >>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  cmd/ab_select.c      | 30 +++++++++++++++++++
>> >>  include/android_ab.h |  9 ++++++
>> >>  3 files changed, 107 insertions(+)
>> >>
>> >> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> >> index 1e5aa81b7503..359cc1a00428 100644
>> >> --- a/boot/android_ab.c
>> >> +++ b/boot/android_ab.c
>> >> @@ -363,3 +363,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>> >>
>> >>         return slot;
>> >>  }
>> >> +
>> >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
>> >> +{
>> >> +       struct bootloader_control *abc;
>> >> +       u32 crc32_le;
>> >> +       int i, ret;
>> >> +       struct slot_metadata *slot;
>> >> +
>> >> +       if (!dev_desc || !part_info) {
>> >> +               log_err("ANDROID: Empty device descriptor or partition info\n");
>> >> +               return -EINVAL;
>> >> +       }
>> >> +
>> >> +       ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
>> >> +       if (ret < 0) {
>> >> +               log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
>> >> +               return ret;
>> >> +       }
>> >> +
>> >> +       if (abc->magic != BOOT_CTRL_MAGIC) {
>> >> +               log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
>> >> +               ret = -ENODATA;
>> >> +               goto error;
>> >> +       }
>> >> +
>> >> +       if (abc->version > BOOT_CTRL_VERSION) {
>> >> +               log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
>> >> +                       abc->version);
>> >> +               ret = -ENODATA;
>> >> +               goto error;
>> >> +       }
>> >> +
>> >> +       if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
>> >> +               log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
>> >> +                       abc->nb_slot, ARRAY_SIZE(abc->slot_info));
>> >> +               ret = -ENODATA;
>> >> +               goto error;
>> >> +       }
>> >> +
>> >> +       printf("Bootloader Control: \t[%s]\n", part_info->name);
>> >> +       printf("Active Slot: \t\t%s\n", abc->slot_suffix);
>> >> +       printf("Magic Number: \t\t0x%X\n", abc->magic);
>> >> +       printf("Version: \t\t%u\n", abc->version);
>> >> +       printf("Number of Slots: \t%u\n", abc->nb_slot);
>> >> +       printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
>>
>> In the console, this rendered not perfectly aligned, which is a bit of a
>> shame:
>>
>> (done on sandbox)
>>
>> => ab_dump mmc 7#misc
>> Bootloader Control:     [misc]
>> Active Slot:            _a
>> Magic Number:           0x42414342
>> Version:                1
>> Number of Slots:        2
>> Recovery Tries Remaining: 0
>> CRC:                    0x321FEF27 (Valid)
>>
>> >> +
>> >> +       printf("CRC: \t\t\t0x%.8X", abc->crc32_le);
>> >> +
>> >> +       crc32_le = ab_control_compute_crc(abc);
>> >> +       if (abc->crc32_le != crc32_le)
>> >> +               printf(" (Invalid, Expected: \t0x%.8X)\n", crc32_le);
>> >> +       else
>> >> +               printf(" (Valid)\n");
>> >> +
>> >> +       for (i = 0; i < abc->nb_slot; ++i) {
>> >> +               slot = &abc->slot_info[i];
>> >> +               printf("\nSlot[%d] Metadata:\n", i);
>> >> +               printf("\t- Priority: \t\t%u\n", slot->priority);
>> >> +               printf("\t- Tries Remaining: \t%u\n", slot->tries_remaining);
>> >> +               printf("\t- Successful Boot: \t%u\n", slot->successful_boot);
>> >> +               printf("\t- Verity Corrupted: \t%u\n", slot->verity_corrupted);
>> >> +       }
>> >> +
>> >> +error:
>> >> +       free(abc);
>> >> +
>> >> +       return ret;
>> >> +}
>> >> diff --git a/cmd/ab_select.c b/cmd/ab_select.c
>> >> index 9e2f74573c22..1d34150ceea9 100644
>> >> --- a/cmd/ab_select.c
>> >> +++ b/cmd/ab_select.c
>> >> @@ -51,6 +51,31 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>> >>         return CMD_RET_SUCCESS;
>> >>  }
>> >>
>> >> +static int do_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>> >> +                     char *const argv[])
>> >> +{
>> >> +       int ret;
>> >> +       struct blk_desc *dev_desc;
>> >> +       struct disk_partition part_info;
>> >> +
>> >> +       if (argc < 3)
>> >> +               return CMD_RET_USAGE;
>> >> +
>> >> +       if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
>> >> +                                                &dev_desc, &part_info,
>> >> +                                                false) < 0) {
>> >> +               return CMD_RET_FAILURE;
>> >> +       }
>> >> +
>> >> +       ret = ab_dump_abc(dev_desc, &part_info);
>> >> +       if (ret < 0) {
>> >> +               printf("Cannot dump ABC data, error %d.\n", ret);
>> >> +               return CMD_RET_FAILURE;
>> >> +       }
>> >> +
>> >> +       return CMD_RET_SUCCESS;
>> >> +}
>> >> +
>> >>  U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
>> >>            "Select the slot used to boot from and register the boot attempt.",
>> >>            "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
>> >> @@ -66,3 +91,8 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
>> >>            "    - If '--no-dec' is set, the number of tries remaining will not\n"
>> >>            "      decremented for the selected boot slot\n"
>> >>  );
>> >> +
>> >> +U_BOOT_CMD(ab_dump, 3, 0, do_ab_dump,
>> >> +          "Dump boot_control information from specific partition.",
>> >> +          "<interface> <dev[:part|#part_name]>\n"
>> >> +);
>> >> diff --git a/include/android_ab.h b/include/android_ab.h
>> >> index 1fee7582b90a..e53bf7eb6a02 100644
>> >> --- a/include/android_ab.h
>> >> +++ b/include/android_ab.h
>> >> @@ -33,4 +33,13 @@ struct disk_partition;
>> >>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>> >>                     bool dec_tries);
>> >>
>> >> +/**
>> >> + * Dump ABC information for specific partition.
>> >> + *
>> >> + * @param[in] dev_desc Device description pointer
>> >> + * @param[in] part_info Partition information
>> >
>> > We have moved to the @ notation now:
>> >
>> > @dev_desc: ...
>>
>> I agree with this comment, but the file uses @param[in] already. We
>> should to a preparatory patch to convert this file to the new notation.
>
> OK, can do later.
>
>>
>> >
>> >> + * Return: 0 on success, or a negative on error
>> >> + */
>> >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
>> >> +
>> >>  #endif /* __ANDROID_AB_H */
>> >> --
>> >> 2.43.0
>> >>
>> >
>> > Rather than creating a new command I think this should be a subcommand
>> > of abootimg.
>>
>> To me, they are not the same thing.
>>
>> - ab_* commands are for manipulating specific bits from the BCB (Boot
>>   Control Block, usually "misc" partition)
>>   ab_* operates on partitions
>>
>> - abootimg is for manipulating boot.img and vendor_boot.img headers
>>   (which are not on the same partitions)
>>   abootimg operations on memory regions (so someone else is responsible
>>   for reading the partitions)
>>
>> We also have a 3rd command "bcb". "bcb" also reads the "misc" partition
>> but can only read the "boot reason".
>> If we really want to merge ab_select and ab_dump into another command,
>> "bcb" is more relevant, in my opinion.
>
> That sounds good.
>
>>
>> I'd prefer to keep 3 commands for the following reasons:
>>
>> 1. Easier to track/port changes from Google's fork [1]
>> 2. Better separation of responsabilities
>> 3. Merging the commands requires the update of the existing U-Boot
>>    environment users (meson64_android.h for example)
>>
>> I don't strongly disagree with merging, but I'd prefer to keep it this way.
>>
>> [1] https://android.googlesource.com/platform/external/u-boot
>>
>> Simon, can you elaborate on why we should merge the commands? Do you
>> think that for U-Boot users it will be easier to have a single command
>> for all Android related topics?
>
> Not necessarily, it's just that we do try to keep similar pieces of
> functionality together. Perhaps we should create an entirely new
> command to bring all (or most) these things together, with aliases for
> compatibility?

I think that merging the ab_* features into BCB is the most
relevant.

>
> Note that 'boota' might be a better name for actually booting an
> Android image, since we have bootm, booti, etc. Having said that, with
> bootstd it might just be automatic.

Boards relying on boot* commands for booting android use the bootm
command, see: include/configs/meson64_android.h

In my opinion, everyone booting Android should migrate to use bootstd.

>
> Why does Android have its own fork? I am not keen on any argument that
> says that mainline needs to follow a fork!

I don't know why Android has its own fork, but it's unfortunate.

Looking at the code, I suspect:
- Android bootflow (for cuttlefish) (cmd/boot_android)
- Fixes on fastboot
- Fixes on AB
- Fixes on AVB (support for block devices instead of only mmc)

For example, here are some relevant fixes that I want to port to
upstream:

- https://android-review.googlesource.com/c/platform/external/u-boot/+/1446442
- https://android-review.googlesource.com/c/platform/external/u-boot/+/1451016

I completely agree with you. It's non-sense say that "mainline needs to
follow a fork".
I'm just a bit worried that porting over relevant changes from this
particular fork might get more difficult in the future.

Thinking again about this, if we just move the command bits and keep the
boot/android_ab.c part it should be too troublesome.

So I'm ok to proceed with this.

Thanks!

>
>
>>
>> >
>> > Can you please create some docs in doc/usage/cmd/abootimg for the command?
>> >
>> > I also wonder if ab_select should move under that command?
>
> Regards,
> SImon
