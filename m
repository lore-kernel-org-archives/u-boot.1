Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0D0C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268D98650F;
	Thu, 24 Aug 2023 01:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bEHOB+iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85E78651E; Thu, 24 Aug 2023 01:59:25 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE57186503
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d6fcffce486so5893428276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wo3Iy9ewyGSDtWSMvwex7p0dCiBF1TP0+K7qgb8A0Ww=;
 b=bEHOB+iWUTsq9i+8dUGQ8Oo5zseeRphi0pl+1BEi1xmimjJ0FpoUOuBPJcum/9hrvM
 YNZYICIOlZMNZiEcX4/qGf5VvoBPsGHxzzix+cjliYq5KrbVmrzvlkGzGDwj3k4GhA6f
 Bte2YK4vbmBmGNSItk1XxIgidzTSShlRotmxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wo3Iy9ewyGSDtWSMvwex7p0dCiBF1TP0+K7qgb8A0Ww=;
 b=GmbMu28Uuh6eWdrVVw024e6G/oT5O5FYtDz9vqcI8j9M7CSzYiauHnip3tGDlzjQl/
 tWZ52NvFIiD8ictp7L8feWanKBqhI1+08zmUfR8aOUng+I2YQdLR8lhttpUFg3njQyhu
 oKY20T7Mrto/tcR7aCOjo3zOCciu8hC/r0VXu2B7QKOlkR034XeA2x93Yo9OZORvFN/L
 x4s9sjirntfd2v6CnFlo2Q8hI1hQtZloZvIb6yK8IePxSFvaN915ToSL6fYclgj3V6xX
 mhEVPpXOfLqmuqFVHeXO7hV7LI0ed7rJY/Tv+8Y48d+TudsywjxQ3pcGePsg6TC7LetG
 YxSQ==
X-Gm-Message-State: AOJu0Yw2iLGtzIdGcxCJ1bEwn96N3z1zUr+uGsMS+Bk741r/0dWuZMkq
 ohrZDUcD8A39BGPoRTGM+mIx6kTB30jbC9iPLFB71Vtm8D//7oz1oVM=
X-Google-Smtp-Source: AGHT+IGcwKXkyqfrtGH2oBQO3gT2Ms5RDuzhWvi1mM/SPNBKKXYTla/EQ7vzUwGvv1MzlsgGB5NqkQIgwsoZU9EP7Ak=
X-Received: by 2002:a25:d1c9:0:b0:d4d:b6de:69bd with SMTP id
 i192-20020a25d1c9000000b00d4db6de69bdmr12926805ybg.23.1692835156449; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-7-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-7-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:46 -0600
Message-ID: <CAPnjgZ1TRVx3=zBNSSt5nzimYzv=iE7MZDbmNJs8vfBSo=F=3Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cmd: gpt: Preserve type GUID if enabled
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

Hi Joshua,

On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> If CONFIG_PARTITION_TYPE_GUID is enabled, the type GUID will be
> preserved when writing out the partition string. It was already
> respected when writing out partitions; this ensures that if you capture
> the current partition layout and write it back (such as when renaming),
> the type GUIDs are preserved.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 | 16 +++++++++++
>  test/py/tests/test_gpt.py | 57 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 70a01f7da1..fdd9c429f6 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -173,6 +173,9 @@ static int calc_parts_list_len(int numparts)
>         /* see part.h for definition of struct disk_partition */
>         partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
>         partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +       partlistlen += numparts * (strlen("type=,") + UUID_STR_LEN + 1);
> +#endif
>         partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
>         /* for the terminating null */
>         partlistlen++;
> @@ -211,6 +214,11 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
>                 PART_TYPE_LEN);
>         newpart->gpt_part_info.type[PART_TYPE_LEN - 1] = '\0';
>         newpart->gpt_part_info.bootable = info->bootable;
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +       strncpy(newpart->gpt_part_info.type_guid, (const char *)info->type_guid,
> +               UUID_STR_LEN);
> +       newpart->gpt_part_info.type_guid[UUID_STR_LEN] = '\0';
> +#endif
>  #ifdef CONFIG_PARTITION_UUIDS
>         strncpy(newpart->gpt_part_info.uuid, (const char *)info->uuid,
>                 UUID_STR_LEN);
> @@ -252,6 +260,9 @@ static void print_gpt_info(void)
>                        curr->gpt_part_info.name);
>                 printf("Type %s, bootable %d\n", curr->gpt_part_info.type,
>                        curr->gpt_part_info.bootable & PART_BOOTABLE);
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +               printf("Type GUID %s\n", curr->gpt_part_info.type_guid);
> +#endif
>  #ifdef CONFIG_PARTITION_UUIDS
>                 printf("UUID %s\n", curr->gpt_part_info.uuid);
>  #endif
> @@ -299,6 +310,11 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
>                                             curr->gpt_part_info.blksz);
>                 strncat(partitions_list, partstr, PART_NAME_LEN + 1);
>
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +               strcat(partitions_list, ",type=");
> +               strncat(partitions_list, curr->gpt_part_info.type_guid,
> +                       UUID_STR_LEN + 1);
> +#endif
>                 strcat(partitions_list, ",uuid=");
>                 strncat(partitions_list, curr->gpt_part_info.uuid,
>                         UUID_STR_LEN + 1);
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index 8203515e05..f9351f0274 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -16,6 +16,26 @@ the test.
>  # Mark all tests here as slow
>  pytestmark = pytest.mark.slow
>
> +def parse_gpt_parts(s):
> +    """Part a partition string into a list of partitions"""

Please remember to fully comment functions, including arg and return value.

Also 's' can be used in loops but not as a var or param. I think we
need to use 3 chars or more.

> +    parts = []
> +    for part_str in s.split(';'):
> +        part = {}
> +        for option in part_str.split(","):
> +            if not option:
> +                continue
> +
> +            if "=" in option:
> +                k, v = option.split("=")
> +                part[k] = v
> +            else:
> +                part[option] = True
> +
> +        if part:
> +            parts.append(part)
> +
> +    return parts
> +
>  class GptTestDiskImage(object):
>      """Disk Image used by the GPT tests."""
>
> @@ -49,11 +69,13 @@ class GptTestDiskImage(object):
>                  u_boot_utils.run_and_log(u_boot_console, cmd)
>                  # part1 offset 1MB size 1MB
>                  cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
> +                    '--partition-guid=1:33194895-67f6-4561-8457-6fdeed4f50a3',
>                      '-A 1:set:2',
>                      persistent)
>                  # part2 offset 2MB size 1.5MB
>                  u_boot_utils.run_and_log(u_boot_console, cmd)
>                  cmd = ('sgdisk', '--new=2:4096:7167', '--change-name=2:part2',
> +                    '--partition-guid=2:cc9c6e4a-6551-4cb5-87be-3210f96c86fb',
>                      persistent)
>                  u_boot_utils.run_and_log(u_boot_console, cmd)
>                  cmd = ('sgdisk', '--load-backup=' + persistent)
> @@ -88,6 +110,40 @@ def test_gpt_read(state_disk_image, u_boot_console):
>      assert '0x00000800 0x00000fff      "part1"' in output
>      assert '0x00001000 0x00001bff      "part2"' in output
>
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('cmd_gpt')
> +@pytest.mark.buildconfigspec('partition_type_guid')
> +@pytest.mark.requiredtool('sgdisk')
> +def test_gpt_read_var(state_disk_image, u_boot_console):
> +    """Test the gpt read command."""
> +
> +    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
> +    output = u_boot_console.run_command('gpt read host 0 gpt_parts')
> +    assert 'success!' in output
> +
> +    output = u_boot_console.run_command('echo ${gpt_parts}')
> +    parts = parse_gpt_parts(output.rstrip())
> +
> +    assert parts == [
> +        {
> +            "uuid_disk": "375a56f7-d6c9-4e81-b5f0-09d41ca89efe",
> +        },
> +        {
> +            "name": "part1",

single quotes

> +            "start": "0x100000",
> +            "size": "0x100000",
> +            "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
> +            "uuid": "33194895-67f6-4561-8457-6fdeed4f50a3",
> +        },
> +        {
> +            "name": "part2",
> +            "start": "0x200000",
> +            "size": "0x180000",
> +            "type": "0fc63daf-8483-4772-8e79-3d69d8477de4",
> +            "uuid": "cc9c6e4a-6551-4cb5-87be-3210f96c86fb",
> +        },
> +    ]
> +
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('cmd_gpt')
>  @pytest.mark.requiredtool('sgdisk')
> @@ -263,3 +319,4 @@ def test_gpt_write(state_disk_image, u_boot_console):
>      assert '0x00001000 0x00001bff      "second"' in output
>      output = u_boot_console.run_command('gpt guid host 0')
>      assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
> +
> --
> 2.33.0
>

Regards,
Simon
