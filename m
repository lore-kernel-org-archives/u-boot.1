Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA8FC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 18:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08EE68881B;
	Wed, 31 Jul 2024 20:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rHgEVgFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AA388886; Wed, 31 Jul 2024 20:19:24 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B00E88637
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 20:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 93537100002;
 Wed, 31 Jul 2024 21:19:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 93537100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1722449958;
 bh=bIEXVDJYaH7XPYqXgWDJO4/nb44seyk4O12/bzGG+Lo=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=rHgEVgFFhTYrA6PYjNntz62kPwEUc+SARC2XI+DQtgaHrpV2mqpMjkvlurHaQ7bF+
 rkciUoS88WOVbBhEj9pM9JdqhU8YA2ffEBXdS952MW3zWlUp+QpgGa9cglQaX+VeP1
 TZegZOsalG0OcHZVsFLUVRdSpoQz42WKAoXvSrN+BYLJSrsQlaZnAvHTsYex5x3X88
 j8oGuRc0E3EZGx2JdS52ltwLFU+4P4RZ8/m3w+Y4y65hPAWlk+eeYnKo3crIv5bgnk
 n8dK5/KeiF45SCTFJLPa9UXXa4EfyccRsj8vtOtMvHBXha98njmiLY9ETUXzRBqw/k
 76A4ygttcvsdw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 31 Jul 2024 21:19:18 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jul
 2024 21:19:18 +0300
Date: Wed, 31 Jul 2024 21:19:17 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, <igor.opaniuk@gmail.com>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v1 2/4] cmd: ab: introduce 'ab_dump' command to print BCB
 block content
Message-ID: <20240731181917.6en7ducpjaofwmlk@CAB-WSD-L081021>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-3-ddrokosov@salutedevices.com>
 <CAFLszThbAAQ3Fwtf_t0k-K5xO6Yu8x_37Fejntqq=svwt-gdcQ@mail.gmail.com>
 <87ed7bqolf.fsf@baylibre.com>
 <CAFLszTik6sK+dU5hK8bfXq-Ho+V1FwfgBaXuGPDRwFYkzw9=VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTik6sK+dU5hK8bfXq-Ho+V1FwfgBaXuGPDRwFYkzw9=VA@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186817 [Jul 31 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 android.googlesource.com:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/31 17:55:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/31 17:55:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/31 09:51:00 #26190769
X-KSMG-AntiVirus-Status: Clean, skipped
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

On Wed, Jul 31, 2024 at 08:38:49AM -0600, Simon Glass wrote:
> Hi Mattijs,
> 
> On Tue, 30 Jul 2024 at 02:19, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
> >
> > Hi Dmitry,
> >
> > Thank you for the patch.
> >
> > Hi Simon,
> >
> > On dim., juil. 28, 2024 at 13:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > > Hi Dmitry,
> > >
> > > On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
> > > <ddrokosov@salutedevices.com> wrote:
> > >>
> > >> It's really helpful to have the ability to dump BCB block for debugging
> > >> A/B logic on the board supported this partition schema.
> > >>
> > >> Command 'ab_dump' prints all fields of bootloader_control struct
> > >> including slot_metadata for all presented slots.
> > >>
> > >> Output example:
> > >> =====
> > >> > board# ab_dump ubi 0#misc
> > >> > Read 512 bytes from volume misc to 000000000bf51900
> > >> > Bootloader Control:   [misc]
> > >> > Active Slot:          _a
> > >> > Magic Number:                 0x42414342
> > >> > Version:              1
> > >> > Number of Slots:      2
> > >> > Recovery Tries Remaining: 7
> > >> > CRC:                  0x61378F6F (Valid)
> > >> >
> > >> > Slot[0] Metadata:
> > >> >       - Priority:             15
> > >> >       - Tries Remaining:      4
> > >> >       - Successful Boot:      0
> > >> >       - Verity Corrupted:     0
> > >> >
> > >> > Slot[1] Metadata:
> > >> >       - Priority:             15
> > >> >       - Tries Remaining:      5
> > >> >       - Successful Boot:      0
> > >> >       - Verity Corrupted:     0
> > >> ====
> > >>
> > >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > >> ---
> > >>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
> > >>  cmd/ab_select.c      | 30 +++++++++++++++++++
> > >>  include/android_ab.h |  9 ++++++
> > >>  3 files changed, 107 insertions(+)
> > >>
> > >> diff --git a/boot/android_ab.c b/boot/android_ab.c
> > >> index 1e5aa81b7503..359cc1a00428 100644
> > >> --- a/boot/android_ab.c
> > >> +++ b/boot/android_ab.c
> > >> @@ -363,3 +363,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
> > >>
> > >>         return slot;
> > >>  }
> > >> +
> > >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
> > >> +{
> > >> +       struct bootloader_control *abc;
> > >> +       u32 crc32_le;
> > >> +       int i, ret;
> > >> +       struct slot_metadata *slot;
> > >> +
> > >> +       if (!dev_desc || !part_info) {
> > >> +               log_err("ANDROID: Empty device descriptor or partition info\n");
> > >> +               return -EINVAL;
> > >> +       }
> > >> +
> > >> +       ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
> > >> +       if (ret < 0) {
> > >> +               log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
> > >> +               return ret;
> > >> +       }
> > >> +
> > >> +       if (abc->magic != BOOT_CTRL_MAGIC) {
> > >> +               log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> > >> +               ret = -ENODATA;
> > >> +               goto error;
> > >> +       }
> > >> +
> > >> +       if (abc->version > BOOT_CTRL_VERSION) {
> > >> +               log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
> > >> +                       abc->version);
> > >> +               ret = -ENODATA;
> > >> +               goto error;
> > >> +       }
> > >> +
> > >> +       if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
> > >> +               log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
> > >> +                       abc->nb_slot, ARRAY_SIZE(abc->slot_info));
> > >> +               ret = -ENODATA;
> > >> +               goto error;
> > >> +       }
> > >> +
> > >> +       printf("Bootloader Control: \t[%s]\n", part_info->name);
> > >> +       printf("Active Slot: \t\t%s\n", abc->slot_suffix);
> > >> +       printf("Magic Number: \t\t0x%X\n", abc->magic);
> > >> +       printf("Version: \t\t%u\n", abc->version);
> > >> +       printf("Number of Slots: \t%u\n", abc->nb_slot);
> > >> +       printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
> >
> > In the console, this rendered not perfectly aligned, which is a bit of a
> > shame:
> >
> > (done on sandbox)
> >
> > => ab_dump mmc 7#misc
> > Bootloader Control:     [misc]
> > Active Slot:            _a
> > Magic Number:           0x42414342
> > Version:                1
> > Number of Slots:        2
> > Recovery Tries Remaining: 0
> > CRC:                    0x321FEF27 (Valid)
> >
> > >> +
> > >> +       printf("CRC: \t\t\t0x%.8X", abc->crc32_le);
> > >> +
> > >> +       crc32_le = ab_control_compute_crc(abc);
> > >> +       if (abc->crc32_le != crc32_le)
> > >> +               printf(" (Invalid, Expected: \t0x%.8X)\n", crc32_le);
> > >> +       else
> > >> +               printf(" (Valid)\n");
> > >> +
> > >> +       for (i = 0; i < abc->nb_slot; ++i) {
> > >> +               slot = &abc->slot_info[i];
> > >> +               printf("\nSlot[%d] Metadata:\n", i);
> > >> +               printf("\t- Priority: \t\t%u\n", slot->priority);
> > >> +               printf("\t- Tries Remaining: \t%u\n", slot->tries_remaining);
> > >> +               printf("\t- Successful Boot: \t%u\n", slot->successful_boot);
> > >> +               printf("\t- Verity Corrupted: \t%u\n", slot->verity_corrupted);
> > >> +       }
> > >> +
> > >> +error:
> > >> +       free(abc);
> > >> +
> > >> +       return ret;
> > >> +}
> > >> diff --git a/cmd/ab_select.c b/cmd/ab_select.c
> > >> index 9e2f74573c22..1d34150ceea9 100644
> > >> --- a/cmd/ab_select.c
> > >> +++ b/cmd/ab_select.c
> > >> @@ -51,6 +51,31 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
> > >>         return CMD_RET_SUCCESS;
> > >>  }
> > >>
> > >> +static int do_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> > >> +                     char *const argv[])
> > >> +{
> > >> +       int ret;
> > >> +       struct blk_desc *dev_desc;
> > >> +       struct disk_partition part_info;
> > >> +
> > >> +       if (argc < 3)
> > >> +               return CMD_RET_USAGE;
> > >> +
> > >> +       if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> > >> +                                                &dev_desc, &part_info,
> > >> +                                                false) < 0) {
> > >> +               return CMD_RET_FAILURE;
> > >> +       }
> > >> +
> > >> +       ret = ab_dump_abc(dev_desc, &part_info);
> > >> +       if (ret < 0) {
> > >> +               printf("Cannot dump ABC data, error %d.\n", ret);
> > >> +               return CMD_RET_FAILURE;
> > >> +       }
> > >> +
> > >> +       return CMD_RET_SUCCESS;
> > >> +}
> > >> +
> > >>  U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
> > >>            "Select the slot used to boot from and register the boot attempt.",
> > >>            "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
> > >> @@ -66,3 +91,8 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
> > >>            "    - If '--no-dec' is set, the number of tries remaining will not\n"
> > >>            "      decremented for the selected boot slot\n"
> > >>  );
> > >> +
> > >> +U_BOOT_CMD(ab_dump, 3, 0, do_ab_dump,
> > >> +          "Dump boot_control information from specific partition.",
> > >> +          "<interface> <dev[:part|#part_name]>\n"
> > >> +);
> > >> diff --git a/include/android_ab.h b/include/android_ab.h
> > >> index 1fee7582b90a..e53bf7eb6a02 100644
> > >> --- a/include/android_ab.h
> > >> +++ b/include/android_ab.h
> > >> @@ -33,4 +33,13 @@ struct disk_partition;
> > >>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
> > >>                     bool dec_tries);
> > >>
> > >> +/**
> > >> + * Dump ABC information for specific partition.
> > >> + *
> > >> + * @param[in] dev_desc Device description pointer
> > >> + * @param[in] part_info Partition information
> > >
> > > We have moved to the @ notation now:
> > >
> > > @dev_desc: ...
> >
> > I agree with this comment, but the file uses @param[in] already. We
> > should to a preparatory patch to convert this file to the new notation.
> 
> OK, can do later.
> 

I can provide a separate patch in the next patch series to rework the
files to the new notation.

> >
> > >
> > >> + * Return: 0 on success, or a negative on error
> > >> + */
> > >> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
> > >> +
> > >>  #endif /* __ANDROID_AB_H */
> > >> --
> > >> 2.43.0
> > >>
> > >
> > > Rather than creating a new command I think this should be a subcommand
> > > of abootimg.
> >
> > To me, they are not the same thing.
> >
> > - ab_* commands are for manipulating specific bits from the BCB (Boot
> >   Control Block, usually "misc" partition)
> >   ab_* operates on partitions
> >
> > - abootimg is for manipulating boot.img and vendor_boot.img headers
> >   (which are not on the same partitions)
> >   abootimg operations on memory regions (so someone else is responsible
> >   for reading the partitions)
> >
> > We also have a 3rd command "bcb". "bcb" also reads the "misc" partition
> > but can only read the "boot reason".
> > If we really want to merge ab_select and ab_dump into another command,
> > "bcb" is more relevant, in my opinion.
> 
> That sounds good.
> 

From my perspective, the 'bcb' command seems like a suitable choice
here. It already has the necessary subcommands to work with the BCB
block. Since the commands 'ab_select' and the new 'ab_dump' are also BCB
operations, I believe it would be beneficial to merge them.

I will work on preparing the next version with the merging of the 'bcb'
command.

> >
> > I'd prefer to keep 3 commands for the following reasons:
> >
> > 1. Easier to track/port changes from Google's fork [1]
> > 2. Better separation of responsabilities
> > 3. Merging the commands requires the update of the existing U-Boot
> >    environment users (meson64_android.h for example)
> >
> > I don't strongly disagree with merging, but I'd prefer to keep it this way.
> >
> > [1] https://android.googlesource.com/platform/external/u-boot
> >
> > Simon, can you elaborate on why we should merge the commands? Do you
> > think that for U-Boot users it will be easier to have a single command
> > for all Android related topics?
> 
> Not necessarily, it's just that we do try to keep similar pieces of
> functionality together. Perhaps we should create an entirely new
> command to bring all (or most) these things together, with aliases for
> compatibility?
> 
> Note that 'boota' might be a better name for actually booting an
> Android image, since we have bootm, booti, etc. Having said that, with
> bootstd it might just be automatic.
> 
> Why does Android have its own fork? I am not keen on any argument that
> says that mainline needs to follow a fork!
> 
> 
> >
> > >
> > > Can you please create some docs in doc/usage/cmd/abootimg for the command?
> > >
> > > I also wonder if ab_select should move under that command?
> 
> Regards,
> SImon

-- 
Thank you,
Dmitry
