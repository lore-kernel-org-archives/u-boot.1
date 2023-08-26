Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B5C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5AE86AB1;
	Sat, 26 Aug 2023 03:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Qc66QdyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C6686AE0; Sat, 26 Aug 2023 03:00:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ADD86A91
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A80F93F65C
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693011599;
 bh=QrkQH1pkLQYmE/qIp6Htd8QLdRAu/cTEiwP8OdGhtmA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Qc66QdyWOHJR4dmeQENyLpJVxoX8KhJ53lRugTXLIilqeiTzyWq+DoK7+s20/jqe4
 y55/WBcfb6UaU9RXORGZQAMy32LEDn6L14wnoJKagXhPPHz9R+8C73eGZTZHcSfbfG
 4uRU2tLyFxOLSgBSYCnkJg+pVe9wHkSwvJXIxiBx1O+fzFAAVwGku47KFqObKt2MFV
 FpGgHtNqdda5x4hiGzEQO4VBQt05nJdzWeL9Ea0EVAlsjo6ajJIdtN9vnJsr6/0Eag
 RTzvEis2F3XPEgZw3ef6zXO0lgY5ubOzWlQcUBCmYwGv+aslVKM1bWwPQ0JloZUtut
 1zyVuWR1L9eIg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so11757015e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693011599; x=1693616399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrkQH1pkLQYmE/qIp6Htd8QLdRAu/cTEiwP8OdGhtmA=;
 b=CyHEig3Gu5lIZfE17Cqtpl68YGuRUMDNseujm02lEEH5ufZV3sIkOUuLLz4cs+G/Vm
 wpSbcZGSNoHKhqy8o3XyJshSS0RreWWiuafTGDhcFdQjvvdXC8/RbQxphn7oS2+YhCbh
 8IMQBgfe9XcQ/ez47G2EHYn6MV+L1fWMVP7FJbb5NyozdE9WTA7QBz0tsOj3HM88CsU8
 khFxg5YizSwvDYTmXXU/dKoWpG0i1xBM96s2n6X2G663JDyhwWkDXcWkUC2FPlkV6Fyj
 tcmWxjQXGW+vs7SR3O3gUXYUdo8qf/Z6ybT8dXU4RToclkTOPLwvuEdgZVOysbGqoKhN
 SIKg==
X-Gm-Message-State: AOJu0YzS33QXfE4p+nPuwMsc1gRn8/Tbhkb4dtxOh1yhDUhuHj/n0XJc
 Ph5QVBRoMPG788ZmMk/HGQRMoe9PywUF1UokPIv1tn1lCsQFsfeWYWuCbTfjU/nUFMF4XuoFRit
 jM+aZxoIb7qhGR/7jWJJ5e+I6xEaV5d8=
X-Received: by 2002:a7b:c4c3:0:b0:3fc:85c:5ed2 with SMTP id
 g3-20020a7bc4c3000000b003fc085c5ed2mr15784817wmk.11.1693011599223; 
 Fri, 25 Aug 2023 17:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5otsAHLY9d0e8DX6ZLfhcKEmNDcPq0A48WONUMl06qt1diPwL7DyOWbge+aKMbDRh2B6fyw==
X-Received: by 2002:a7b:c4c3:0:b0:3fc:85c:5ed2 with SMTP id
 g3-20020a7bc4c3000000b003fc085c5ed2mr15784810wmk.11.1693011598751; 
 Fri, 25 Aug 2023 17:59:58 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c045000b003fee0741b8csm6628834wmb.23.2023.08.25.17.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 17:59:58 -0700 (PDT)
Message-ID: <8f228c24-8f3c-4d87-395e-122c0dc2ff22@canonical.com>
Date: Sat, 26 Aug 2023 03:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] cmd: gpt: Add command to swap partition order
Content-Language: en-US, de-DE
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-9-JPEWhacker@gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230825193830.2753640-9-JPEWhacker@gmail.com>
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
> Adds a command called "gpt swap-postition" which will swap the order two
> partitions are listed in the GPT partition table (but leaves them
> pointing to the same locations on disk).

Why is this functionality needed in a boot firmware?

> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org > ---
>   cmd/gpt.c                 | 52 ++++++++++++++++++++++++++++++++++++---
>   doc/usage/cmd/gpt.rst     | 23 +++++++++++++++++
>   test/py/tests/test_gpt.py | 18 ++++++++++++++
>   3 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 0479b3a6a4..3c39446258 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -858,8 +858,9 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
>   	u8 part_count = 0;
>   	int partlistlen, ret, numparts = 0, partnum, i = 1, ctr1 = 0, ctr2 = 0;
>   
> -	if ((subcomm == NULL) || (name1 == NULL) || (name2 == NULL) ||
> -	    (strcmp(subcomm, "swap") && (strcmp(subcomm, "rename"))))
> +	if (!subcomm || !name1 || !name2 ||
> +	    (strcmp(subcomm, "swap") && strcmp(subcomm, "rename") &&
> +	     strcmp(subcomm, "swap-position")))
>   		return -EINVAL;
>   
>   	ret = get_disk_guid(dev_desc, disk_guid);
> @@ -920,6 +921,47 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
>   			ret = -EINVAL;
>   			goto out;
>   		}
> +	} else if (!strcmp(subcomm, "swap-position")) {
> +		int idx1, idx2;
> +		struct disk_partition first, second;
> +
> +		idx1 = simple_strtoul(name1, NULL, 10);
> +		if (idx1 <= 0 || idx1 > numparts) {

The number of partitions is irrelevant here.

Take a partition table with two partitions 37 and 63. numparts is 2. But 
of course you can swap the two. You have to check that idx1 relates to 
an existing partition here.

I would have preferred to see the numerous bugs in the gpt command to be 
fixed before adding new functionality.

> +			printf("Illegal partition number %s\n", name1);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		idx2 = simple_strtoul(name2, NULL, 10);
> +		if (idx2 <= 0 || idx2 > numparts) {
> +			printf("Illegal partition number %s\n", name2);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (idx1 == idx2) {
> +			printf("Cannot swap partition with itself\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		i = 1;
> +		list_for_each(pos, &disk_partitions) {
> +			curr = list_entry(pos, struct disk_part, list);
> +			if (i == idx1)
> +				first = curr->gpt_part_info;
> +			else if (i == idx2)
> +				second = curr->gpt_part_info;
> +			i++;
> +		}
> +
> +		i = 1;
> +		list_for_each(pos, &disk_partitions) {
> +			curr = list_entry(pos, struct disk_part, list);
> +			if (i == idx1)
> +				curr->gpt_part_info = second;
> +			else if (i == idx2)
> +				curr->gpt_part_info = first;
> +			i++;
> +		}
>   	} else { /* rename */
>   		if (strlen(name2) > PART_NAME_LEN) {
>   			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
> @@ -1123,7 +1165,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	} else if (strcmp(argv[1], "read") == 0) {
>   		ret = do_get_gpt_info(blk_dev_desc, (argc == 5) ? argv[4] : NULL);
>   	} else if ((strcmp(argv[1], "swap") == 0) ||
> -		   (strcmp(argv[1], "rename") == 0)) {
> +		   (strcmp(argv[1], "rename") == 0) ||
> +		   (strcmp(argv[1], "swap-position") == 0)) {
>   		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
>   	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
>   		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
> @@ -1176,6 +1219,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>   	" gpt swap <interface> <dev> <name1> <name2>\n"
>   	"    - change all partitions named name1 to name2\n"
>   	"      and vice-versa\n"
> +	" gpt swap-position <interface> <dev> <part1> <part2>\n"
> +	"    - Swap the order of name1 with name2 in the partition table\n"
>   	" gpt rename <interface> <dev> <part> <name>\n"
>   	"    - rename the specified partition\n"
>   	" gpt set-bootable <interface> <dev> <list>\n"
> @@ -1184,5 +1229,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>   	" gpt swap mmc 0 foo bar\n"
>   	" gpt rename mmc 0 3 foo\n"
>   	" gpt set-bootable mmc 0 boot_a,boot_b\n"
> +	" gpt swap-position mmc 0 1 2\n"
>   #endif
>   );
> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> index 353dfb05cf..bc14bda6e5 100644
> --- a/doc/usage/cmd/gpt.rst
> +++ b/doc/usage/cmd/gpt.rst
> @@ -17,6 +17,7 @@ Synopsis
>       gpt read <interface> <device no> [<varname>]
>       gpt swap <interface> <dev> <name1> <name2>
>       gpt rename <interface> <dev> <part> <name>
> +    gpt swap-position <interface> <dev> <part1> <part2>
>       gpt set-bootable <interface> <dev> <partition list>
>   
>   Description
> @@ -138,6 +139,28 @@ CONFIG_CMD_GPT_RENAME=y is required.
>   The 'gpt rename' command renames all partitions named 'part' to be 'name1'.
>   CONFIG_CMD_GPT_RENAME=y is required.
>   
> +The 'gpt swap-position' command swaps the order of two partition index in the

Two requires a plural form.

You don't swap indices, you swap the partition table entries indexed by 
part1 and part2.

> +partition table, but otherwise leaves the actual partition data untouched. For
> +example, to swap the order of the 'boot' and 'rootfs' partitions in the disk

You don't swap the order in the disks. You swap the entries in the 
partition table.

Best regards

Heinrich

> +described above, you would do:
> +
> +::
> +    => gpt setenv mmc 0 rootfs
> +    => echo ${gpt_partition_entry}
> +    2
> +    => gpt setenv mmc 0 boot
> +    => echo ${gpt_partition_entry}
> +    1
> +
> +    => gpt swap-position mmc 0 1 2
> +
> +    => gpt setenv mmc 0 rootfs
> +    => echo ${gpt_partition_entry}
> +    1
> +    => gpt setenv mmc 0 boot
> +    => echo ${gpt_partition_entry}
> +    2
> +
>   The 'gpt set-bootable' command sets the bootable flag for all partitions in the
>   table. If the partition name is in 'partition list' (separated by ','), the
>   bootable flag is set, otherwise it is cleared. CONFIG_CMD_GPT_RENAME=y is
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index 666d387ac8..3d23b98cea 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -330,3 +330,21 @@ def test_gpt_write(state_disk_image, u_boot_console):
>       output = u_boot_console.run_command('gpt guid host 0')
>       assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
>   
> +@pytest.mark.buildconfigspec('cmd_gpt')
> +@pytest.mark.buildconfigspec('cmd_gpt_rename')
> +@pytest.mark.buildconfigspec('cmd_part')
> +@pytest.mark.requiredtool('sgdisk')
> +def test_gpt_swap_position(state_disk_image, u_boot_console):
> +    """Test the gpt swap-position command."""
> +
> +    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
> +    output = u_boot_console.run_command('part list host 0')
> +    assert '1\t0x00000800\t0x00000fff\t"part1"' in output
> +    assert '2\t0x00001000\t0x00001bff\t"part2"' in output
> +
> +    output = u_boot_console.run_command('gpt swap-position host 0 1 2')
> +    assert 'success!' in output
> +
> +    output = u_boot_console.run_command('part list host 0')
> +    assert '2\t0x00000800\t0x00000fff\t"part1"' in output
> +    assert '1\t0x00001000\t0x00001bff\t"part2"' in output
