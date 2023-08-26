Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261DCC83F08
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 00:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCF986A91;
	Sat, 26 Aug 2023 02:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iShkS8po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7886F86AC1; Sat, 26 Aug 2023 02:37:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B422F86A7D
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 02:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 483803F65C
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693010224;
 bh=S27FOU39Vo5+NiTg6defSuyj1AvY7YAXobgrMLLb3QM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=iShkS8pogccTnBvQYj1RjXEIUxp90xyqGmyuzx+9ybTG6/q4+JPgqq1576oMpCdZj
 hJCO+SFeXLcmF5vMrhJP4DdYPqhFYKWd4SI1QKyrKgF8DdhN7KYEvkVrHKqernAirX
 g3d0JWRBw7EKEknxZThp9KuQLAgYQEVa9nwISAb7qaKkrPUCH1Ldokv+NH4M5BYOpS
 25kDP2HojgpZOrJ/JIqAs4u95ECRZDVoopcgcTz1m72jzCYzdql06De9VVFnJoRKN1
 ugtRx+/zGbLdqdqhdGioCbkA7kVKrbxY/6fk5QLcQP6p8tBXURY4DUJlv9vce+1gqS
 mV2AQOEGoyDyw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe4cca36b7so10442745e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693010224; x=1693615024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S27FOU39Vo5+NiTg6defSuyj1AvY7YAXobgrMLLb3QM=;
 b=DDj4jpLonVfw1zX5Rt70KAV8CwaW8SwdnT3m1MRwvapY8Wud7Cu1QAJ3msqxTwTIY9
 WEa4vZfmYnJBD7UjZNc6S+6PBF1R+J0Bb5jbPgQO4qijrl+BZYdrSWITdNC7zN+A0GMY
 GEQut4RGfySCvs5iMGNpVY/j7oqIGmjI+kzYxEuUL6AsffFE4D1BKIcRuU5zW+/q9VVu
 LURrRolpgr1iLM4Rzj/81POe8cPpOmHEljIoobcUNvQvr3+Ai+NvGqxdWBoTRsiIlEMf
 Hu8jNUtBGplliF/QRP3SKb56GRqjWJkfhd9D/bA4loiTgDI7gnbbQHBwva4n36fR7gxJ
 hh/Q==
X-Gm-Message-State: AOJu0Yz3OvtVajEJOACjovmP7ougtuS6oT/ZGyUJukxisRh75eglxI99
 7N15YsBzCMbmnXh3RK43QH84qsyesXGYCEEekVLYGlGIUX5uemrzcBf0R1lI9icgUP/KBNVjYm4
 5PXRSRMsyJI8r/0HZf976narwrpizDJU=
X-Received: by 2002:a5d:494c:0:b0:317:1b08:b317 with SMTP id
 r12-20020a5d494c000000b003171b08b317mr14363497wrs.6.1693010223835; 
 Fri, 25 Aug 2023 17:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEojmhzOKgs2AMoB4RLl/eW/2lRiUXivAsi7LhZ5JIoN//+hTiZiaAltppRVe11AxShtWDaDw==
X-Received: by 2002:a5d:494c:0:b0:317:1b08:b317 with SMTP id
 r12-20020a5d494c000000b003171b08b317mr14363487wrs.6.1693010223386; 
 Fri, 25 Aug 2023 17:37:03 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 g5-20020a056000118500b00317b063590fsm3463189wrx.55.2023.08.25.17.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 17:37:02 -0700 (PDT)
Message-ID: <01a5437a-9018-d962-8568-e1abdc96c8ad@canonical.com>
Date: Sat, 26 Aug 2023 02:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/8] cmd: gpt: Preserve type GUID if enabled
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>, u-boot@lists.denx.de
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-7-JPEWhacker@gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230825193830.2753640-7-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/25/23 21:38, Joshua Watt wrote:
> If CONFIG_PARTITION_TYPE_GUID is enabled, the type GUID will be
> preserved when writing out the partition string. It was already
> respected when writing out partitions; this ensures that if you capture
> the current partition layout and write it back (such as when renaming),
> the type GUIDs are preserved.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   cmd/gpt.c                 | 16 ++++++++++
>   test/py/tests/test_gpt.py | 66 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 1fe7f1a7db..b7d861aa1e 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -173,6 +173,9 @@ static int calc_parts_list_len(int numparts)
>   	/* see part.h for definition of struct disk_partition */
>   	partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
>   	partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +	partlistlen += numparts * (strlen("type=,") + UUID_STR_LEN + 1);
> +#endif
>   	partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
>   	/* for the terminating null */
>   	partlistlen++;
> @@ -211,6 +214,11 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
>   		PART_TYPE_LEN);
>   	newpart->gpt_part_info.type[PART_TYPE_LEN - 1] = '\0';
>   	newpart->gpt_part_info.bootable = info->bootable;
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +	strncpy(newpart->gpt_part_info.type_guid, (const char *)info->type_guid,
> +		UUID_STR_LEN);
> +	newpart->gpt_part_info.type_guid[UUID_STR_LEN] = '\0';
> +#endif
>   #ifdef CONFIG_PARTITION_UUIDS
>   	strncpy(newpart->gpt_part_info.uuid, (const char *)info->uuid,
>   		UUID_STR_LEN);
> @@ -252,6 +260,9 @@ static void print_gpt_info(void)
>   		       curr->gpt_part_info.name);
>   		printf("Type %s, bootable %d\n", curr->gpt_part_info.type,
>   		       curr->gpt_part_info.bootable & PART_BOOTABLE);
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +		printf("Type GUID %s\n", curr->gpt_part_info.type_guid);
> +#endif
>   #ifdef CONFIG_PARTITION_UUIDS
>   		printf("UUID %s\n", curr->gpt_part_info.uuid);
>   #endif
> @@ -299,6 +310,11 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
>   					    curr->gpt_part_info.blksz);
>   		strncat(partitions_list, partstr, PART_NAME_LEN + 1);
>   
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +		strcat(partitions_list, ",type=");
> +		strncat(partitions_list, curr->gpt_part_info.type_guid,
> +			UUID_STR_LEN + 1);
> +#endif
>   		strcat(partitions_list, ",uuid=");
>   		strncat(partitions_list, curr->gpt_part_info.uuid,
>   			UUID_STR_LEN + 1);
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index 5d23f9b292..09a90f026f 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -16,6 +16,35 @@ the test.
>   # Mark all tests here as slow
>   pytestmark = pytest.mark.slow
>   
> +def parse_gpt_parts(disk_str):
> +    """Parser a partition string into a list of partitions.
> +
> +    Args:
> +        disk_str: The disk description string, as returned by `gpt read`
> +
> +    Returns:
> +        A list of parsed partitions. Each partition is a dictionary with the
> +        string value from each specified key in the partition description, or a
> +        key with with the value True for a boolean flag
> +    """
> +    parts = []
> +    for part_str in disk_str.split(';'):
> +        part = {}
> +        for option in part_str.split(","):
> +            if not option:
> +                continue
> +
> +            if "=" in option:
> +                k, v = option.split("=")

This results in a pylint warning:

C0103: Variable name "v" doesn't conform to snake_case naming style 
(invalid-name)

How about key, value?

> +                part[k] = v
> +            else:
> +                part[option] = True
> +
> +        if part:
> +            parts.append(part)
> +
> +    return parts
> +
>   class GptTestDiskImage(object):
>       """Disk Image used by the GPT tests."""
>   
> @@ -49,11 +78,13 @@ class GptTestDiskImage(object):
>                   u_boot_utils.run_and_log(u_boot_console, cmd)
>                   # part1 offset 1MB size 1MB
>                   cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
> +                    '--partition-guid=1:33194895-67f6-4561-8457-6fdeed4f50a3',
>                       '-A 1:set:2',
>                       persistent)
>                   # part2 offset 2MB size 1.5MB
>                   u_boot_utils.run_and_log(u_boot_console, cmd)
>                   cmd = ('sgdisk', '--new=2:4096:7167', '--change-name=2:part2',
> +                    '--partition-guid=2:cc9c6e4a-6551-4cb5-87be-3210f96c86fb',
>                       persistent)
>                   u_boot_utils.run_and_log(u_boot_console, cmd)
>                   cmd = ('sgdisk', '--load-backup=' + persistent)
> @@ -88,6 +119,40 @@ def test_gpt_read(state_disk_image, u_boot_console):
>       assert '0x00000800	0x00000fff	"part1"' in output
>       assert '0x00001000	0x00001bff	"part2"' in output
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
>   @pytest.mark.boardspec('sandbox')
>   @pytest.mark.buildconfigspec('cmd_gpt')
>   @pytest.mark.requiredtool('sgdisk')
> @@ -263,3 +328,4 @@ def test_gpt_write(state_disk_image, u_boot_console):
>       assert '0x00001000	0x00001bff	"second"' in output
>       output = u_boot_console.run_command('gpt guid host 0')
>       assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
> +

Please, remove this white space line.

Best regards

Heinrich
