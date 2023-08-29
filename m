Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DBFC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 13:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03899864E9;
	Tue, 29 Aug 2023 15:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sVFNAyJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0383B8648F; Tue, 29 Aug 2023 15:25:07 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8059864EA
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso66499501fa.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693315503; x=1693920303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRyq6F2l9QwXbLNDBPgI7Xv0kZnhKDsVlNyG7S3eano=;
 b=sVFNAyJwneB640PhDEGr5ZHY3ftu8AFwuciq3mFWEqL10bNklUXjdCmur4IqCtmje+
 9H9B/2Ok5Rl1KzxLe3kzL/m0Os6PO3Ch2jv7JXDJqmT5X1Fp1ORwFGHXJgg6iyucJhfY
 sQsD7WXDLXSqGVcfJhujRtha+k5eC6y613LMzUuO+L2QC2Sj5lANoKZbWQDEZxf0vU9i
 Ao8LEfuUqMob6Avyp56Yj03HZiNjPmGptXruQWoYPqj0bU4Gmc6imJc4+qT16iKAV4FQ
 XfJT3NTWzCodwhRqVXTrhsO3gO/MYEsOjMFPgs6Q8kuVCZ+HVifIDhFg2l2ORDaH+fcL
 8aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315503; x=1693920303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRyq6F2l9QwXbLNDBPgI7Xv0kZnhKDsVlNyG7S3eano=;
 b=TrOX1AazOcHrHb55iYAgrTdCyIFIFqQzW1Ht91jQe8TxwQISsonMcdOH0ZDWY5IskH
 pyFCqITGhhjk0OyR2jsRwoOjT3oZ8ChezHU+SvcmK7Pxe73lvF/On3wen1m6w1l2pInp
 umC9Kx3mm/yaiaoZYyBEyfVFwsesFYqABGJRznjIkBK7YAhzXYS0jNksktNnW47D8UPv
 baM6hJp/QHlKuqlF05bmCr25IzHcV1KiM8Vp9u7JtnRKR002CGe6RkTF/Jd82/wqoDTm
 rT3p+oDuX0Np5VgVOaNN4cRJwtt3GKov2fYIgFe4kAZo9QqnmWJhH648pKSV2VNvv1r+
 f3Fg==
X-Gm-Message-State: AOJu0Yy5cFJwW7M0T2iZH1dr74EzWjtcN0mtZyKkHVcC4KhZ74ui8GFm
 2BpLwK/NPO9SPfawtUaV1Q4X/hz2nHuqtFgEyRk=
X-Google-Smtp-Source: AGHT+IEC7IOdA4GaB4w0pYZlSIXNEfSEMw1f7Sj4FW/NuNcBqYXrg0qkwRy2TNGeATAqe8n8Jp9j9ABn38DY4UkYJ8o=
X-Received: by 2002:a05:651c:1022:b0:2bc:b6ce:eab with SMTP id
 w2-20020a05651c102200b002bcb6ce0eabmr19724048ljm.51.1693315502898; Tue, 29
 Aug 2023 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-6-JPEWhacker@gmail.com>
 <9299df67-7e0f-44cc-b4c5-29b337116e4c@gmx.de>
In-Reply-To: <9299df67-7e0f-44cc-b4c5-29b337116e4c@gmx.de>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 29 Aug 2023 07:24:50 -0600
Message-ID: <CAJdd5GZZ=mhjC8uzbSkAhWcUAEOb+D9gBQ+n6rio_qesz5Cj3g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] cmd: gpt: Add command to set bootable flags
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Aug 28, 2023, 4:53 PM Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 8/28/23 23:56, Joshua Watt wrote:
> > Adds a command that can be used to modify the GPT partition table to
> > indicate which partitions should have the bootable flag set
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   cmd/gpt.c                 | 80 +++++++++++++++++++++++++++++++++++++++
> >   doc/usage/cmd/gpt.rst     | 12 ++++++
> >   test/py/tests/test_gpt.py | 22 +++++++++++
> >   3 files changed, 114 insertions(+)
> >
> > diff --git a/cmd/gpt.c b/cmd/gpt.c
> > index c6c8282ac9..45fbe07404 100644
> > --- a/cmd/gpt.c
> > +++ b/cmd/gpt.c
> > @@ -972,6 +972,81 @@ static int do_rename_gpt_parts(struct blk_desc
> *dev_desc, char *subcomm,
> >       free(partitions_list);
> >       return ret;
> >   }
> > +
> > +/**
> > + * gpt_set_bootable() - Set bootable flags for partitions
> > + *
> > + * Sets the bootable flag for any partition names in the comma
> separated list of
> > + * partition names. Any partitions not in the list have their bootable
> flag
> > + * cleared
> > + *
> > + * @desc: block device descriptor
> > + * @name: Comma separated list of partition names
> > + *
> > + * @Return: '0' on success and -ve error on failure
> > + */
> > +static int gpt_set_bootable(struct blk_desc *blk_dev_desc, char *const
> part_list)
> > +{
> > +     char *name;
> > +     char disk_guid[UUID_STR_LEN + 1];
> > +     struct list_head *pos;
> > +     struct disk_part *curr;
> > +     struct disk_partition *partitions = NULL;
> > +     int part_count = 0;
> > +     int ret = get_disk_guid(blk_dev_desc, disk_guid);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = get_gpt_info(blk_dev_desc);
> > +     if (ret <= 0)
> > +             goto out;
> > +
> > +     part_count = ret;
> > +     partitions = malloc(sizeof(*partitions) * part_count);
> > +     if (!partitions) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     /* Copy partitions and clear bootable flag */
> > +     part_count = 0;
> > +     list_for_each(pos, &disk_partitions) {
> > +             curr = list_entry(pos, struct disk_part, list);
> > +             partitions[part_count] = curr->gpt_part_info;
> > +             partitions[part_count].bootable &= ~PART_BOOTABLE;
> > +             part_count++;
> > +     }
> > +
> > +     name = strtok(part_list, ",");
> > +     while (name) {
> > +             bool found = false;
> > +
> > +             for (int i = 0; i < part_count; i++) {
> > +                     if (strcmp((char *)partitions[i].name, name) == 0)
> {
> > +                             partitions[i].bootable |= PART_BOOTABLE;
> > +                             found = true;
> > +                     }
> > +             }
> > +
> > +             if (!found) {
> > +                     printf("Warning: No partition matching '%s'
> found\n",
> > +                            name);
> > +             }
> > +
> > +             name = strtok(NULL, ",");
> > +     }
> > +
> > +     ret = gpt_restore(blk_dev_desc, disk_guid, partitions, part_count);
> > +
> > +out:
> > +     del_gpt_info();
> > +
> > +     if (partitions)
> > +             free(partitions);
> > +
> > +     return ret;
> > +}
> >   #endif
> >
> >   /**
> > @@ -1031,6 +1106,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag,
> int argc, char *const argv[])
> >       } else if ((strcmp(argv[1], "swap") == 0) ||
> >                  (strcmp(argv[1], "rename") == 0)) {
> >               ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4],
> argv[5]);
> > +     } else if ((strcmp(argv[1], "set-bootable") == 0)) {
> > +             ret = gpt_set_bootable(blk_dev_desc, argv[4]);
> >   #endif
> >       } else {
> >               return CMD_RET_USAGE;
> > @@ -1082,8 +1159,11 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
> >       "      and vice-versa\n"
> >       " gpt rename <interface> <dev> <part> <name>\n"
> >       "    - rename the specified partition\n"
> > +     " gpt set-bootable <interface> <dev> <list>\n"
> > +     "    - make partition names in list bootable\n"
> >       " Example usage:\n"
> >       " gpt swap mmc 0 foo bar\n"
> >       " gpt rename mmc 0 3 foo\n"
> > +     " gpt set-bootable mmc 0 boot_a,boot_b\n"
> >   #endif
> >   );
> > diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> > index b505b159d0..288dd365c0 100644
> > --- a/doc/usage/cmd/gpt.rst
> > +++ b/doc/usage/cmd/gpt.rst
> > @@ -13,6 +13,7 @@ Synopsis
> >       gpt read <interface> <dev> [<varname>]
> >       gpt rename <interface> <dev> <part> <name>
> >       gpt repair <interface> <dev>
> > +    gpt set-bootable <interface> <dev> <partition list>
> >       gpt setenv <interface> <dev> <partition name>
> >       gpt swap <interface> <dev> <name1> <name2>
> >       gpt verify <interface> <dev> [<partition string>]
> > @@ -90,6 +91,13 @@ gpt repair
> >
> >   Repairs the GPT partition tables if it they become corrupted.
> >
> > +gpt set-bootable
> > +~~~~~~~~~~~~~~~~
> > +
> > +Sets the bootable flag for all partitions in the table. If the
> partition name
> > +is in 'partition list' (separated by ','), the bootable flag is set,
> otherwise
> > +it is cleared. CONFIG_CMD_GPT_RENAME=y is required.
>
> Why should this feature be related to CONFIG_CMD_GPT_RENAME?


Commands that write to the partition table seem to need this (probably
poorly named) config.


> Why do we need this sub-command? You can use gpt read and gpt write for
> this rarely needed manipulation.
>

Dealing with the string parsing in a script is cantankerous and annoying,
unless I'm missing something that magically makes it easy


> Best regards
>
> Heinrich
>
> > +
> >   gpt setenv
> >   ~~~~~~~~~~
> >
> > @@ -187,3 +195,7 @@ Get the GUID for a disk::
> >       => gpt guid mmc gpt_disk_uuid
> >       => echo ${gpt_disk_uuid}
> >       bec9fc2a-86c1-483d-8a0e-0109732277d7
> > +
> > +Set the bootable flag for the 'boot' partition and clear it for all
> others::
> > +
> > +    => gpt set-bootable mmc 0 boot
> > diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> > index 946858800d..5d23f9b292 100644
> > --- a/test/py/tests/test_gpt.py
> > +++ b/test/py/tests/test_gpt.py
> > @@ -222,6 +222,28 @@ def test_gpt_swap_partitions(state_disk_image,
> u_boot_console):
> >       assert '0x00000800      0x00000fff      "part2"' in output
> >       assert '0x00001000      0x00001bff      "part1"' in output
> >
> > +@pytest.mark.buildconfigspec('cmd_gpt')
> > +@pytest.mark.buildconfigspec('cmd_gpt_rename')
> > +@pytest.mark.buildconfigspec('cmd_part')
> > +@pytest.mark.requiredtool('sgdisk')
> > +def test_gpt_set_bootable(state_disk_image, u_boot_console):
> > +    """Test the gpt set-bootable command."""
> > +
> > +    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
> > +    parts = ('part2', 'part1')
> > +    for bootable in parts:
> > +        output = u_boot_console.run_command(f'gpt set-bootable host 0
> {bootable}')
> > +        assert 'success!' in output
> > +
> > +        for p in parts:
> > +            output = u_boot_console.run_command(f'gpt setenv host 0
> {p}')
> > +            assert 'success!' in output
> > +            output = u_boot_console.run_command('echo
> ${gpt_partition_bootable}')
> > +            if p == bootable:
> > +                assert output.rstrip() == '1'
> > +            else:
> > +                assert output.rstrip() == '0'
> > +
> >   @pytest.mark.boardspec('sandbox')
> >   @pytest.mark.buildconfigspec('cmd_gpt')
> >   @pytest.mark.buildconfigspec('cmd_part')
>
>
