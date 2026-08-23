Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B57C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 10:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91D04606E5;
	Sun, 23 Aug 2026 10:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmrA2M-1zD1S; Sun, 23 Aug 2026 10:15:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787480111;
	bh=9g12rOBKcTEvlOx6IAGCJFBokOcrmy0Av4c1jjFJPLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8rz5s5PDOm6jrp8qvGzpLjNH0s1m8zn5POq3/V+z+s/Gk/1+AEIJ4T4lZK8ZSVzm
	 gBZy0fP2qFbJNzeXpD210/10NAo6ZTCly9K+O6GNNGR1EUuG+0cTUowsw+BbG/ZNR/
	 bXG3ZDbFKLFHAwktFnLTgh3Q9yZMCTg7gv75gtlLItcPIV+KLiQ5gy+txPbjgbVSKk
	 9W0fPLfgbs7Qklo+YTRCbsEbviNZojPE7aMw9b5NMhyHUjjjFY5x9AvfuJkQfURswK
	 5IzA46dj1Q0Ydnn9b2CqeUl6XxprRbMBoNZLk3qdGWcIS4RUOPnnYsoIRzLy6Bn4NG
	 NDYq4Y748rn9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4495F6066F;
	Sun, 23 Aug 2026 10:15:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F56E2FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2587540534
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wdxyhKWRWBti for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 10:15:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=VKLYeO++
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C0DD40533
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:15:07 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A8EA13F427
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787480104;
 bh=9g12rOBKcTEvlOx6IAGCJFBokOcrmy0Av4c1jjFJPLQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VKLYeO++wfsniL7j9B6vDFP7GOOoHen0jjQewRHrBzxovj/iFLiY+jR878nvpE7XR
 0+AfyCvEzGu8Ik80MlJngclWxOVpO40z90MV+IRsd+omzik2Q6hfMImaElJF41jJVy
 aHrEhEkH44m1dg3iInJeVfZNJhZfHgTFiTuI5xVejOf2fN4pY74wtn1aHEPpj3VHIw
 Sw+emi12FEhX71KqiQ34UDPrLtd7l8yeukjgPNbMxIVRRz8vJ5IA83tfbtSd0FGLRI
 rzGmpwO64OXcCUkihId5ilIVPnDhLzffTSNDbjZG8fM+Hd+8yTtSBNdYWJjqDMsb2C
 hZPL6pJonSa4Og+YcDQC7uHrh1OYsSs9p1EOiXxo2jim5wwiYzR6lWE+SPUY//h6Dk
 wWJKVWMWm9oCtttW5C7hS+YEPfqp7Pmok13pbftgiRQRi1BItnhKzFmTjCgS4tHnuY
 9ZnRiuASNwHsdK8/l2xgfH3/8moaH0ZTZp0l68LUtAOjwDRoAPP61iuVJnc+Drv9Ag
 PMPkwrsI5zg0hRgUUoLPdZYFD6VYYmNbrQXgIxSQtCGNwGPqM6QFgb7Vg+l6MH0eGe
 /lsuqHsjKELJ8xE9ExIJPYRbAQaFho9uc8O60+fAo2dAW/49SkhIrxevoOjVGcURxR
 7m2Ph7e17cgLmjqL1ryH/isU=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a18e266026so2425917a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 03:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787480104; x=1788084904;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9g12rOBKcTEvlOx6IAGCJFBokOcrmy0Av4c1jjFJPLQ=;
 b=sFZ2s6Z3Qua4ehz7lFSdhsHhQ1CZGT3oL7D+J/hQ5xYTeMmP5/K8XB7ptyedgvJGfm
 XRokPeUyVro100gPaOj1KB7ztBJ2mxRExP8zXkA7El65hxABd44MGmlH6wricL79P88Z
 gO8rJRtyzWxEKEthLZYqpKxHIDLM+sw3WisSbxOUejQ0ZRM8JX+MEDwOfZ4phVBgblbG
 0Ticy/FAwCLSby/YIxZoqrjtGQtgR++sR4EpEZ1OQUol8QVbAB7BFyjOkAkHsXcQ03HZ
 svXfzDVDUjiafJIcZtAHFTTtYmBhFBtGl5Ug3gcgdbFFCnq9wSmmCRwL6blvrrVZZEVU
 8jsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpowEAUDi3HjgUr9j54G0rl6qm4KzQTSKWoWwVYrAFi3bYcDC3e7MSyufIs/qCHYUUaEFsEpPI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nou2+HxrTfe+aWxuaQlWFpG6mgs9C7f1rU24BOoygAUBK5wyDG
 Ls9maoIvkFmGtB3lFNjw7uUG+eWlF/TnVopzwZGo6PoB1ZuAAgvxgB1xxcGAEAF/Pn7C3FFCe6L
 TuAphGc0StyVn5HSsx2ZH12QSyRRRk1Akj5vO2JDls4VgGW6i/0kSOj6KM/YUAaw84BnaMIgJK/
 6JrT6sohPl3Q==
X-Gm-Gg: AR+sD12Uzfd8fdxYO/AQ0lXzSBM973RSyCXc98LMCh6krccN8xpRhwI2yhOvsURdb4S
 UbNaCCQkGGsg8JytXgTcUGrV9TIp3mzK+DgAAFHwo17pmpPTEDk0DzckIyyDt1CO2SSfSKoRNPw
 B3Uf+JuIw17TssKHK+9N4iW9Vaxlynz01L5X8uoZHRam73peFm3N4+OXos+HAdXduIGn08EriaG
 KX5OfO7J/doWqPce3WM31fwqtTHT0/q7CN4MUvcy5xxybg5jCEzCqmGEtwTgLYfUIs0Nqakx4Bh
 RY/tQMXnDkMMrkoFa2oL6E1pJeAd5upvGhxiqeanRwcFhcQKWInBxujPRLGqaNDHu460L/13byD
 pyCkTP8JTTCboUcq0gyUwVPsbaCsCaR4sMjBj0Dq1oyBhpBTtWyo7DIiwDLx7tWVL0S0VM17+3q
 oogPQL1KwCHFVYr+Rh8A==
X-Received: by 2002:a05:6402:847:b0:69e:9213:11b with SMTP id
 4fb4d7f45d1cf-6a42f1bca7amr19604335a12.13.1787480104161; 
 Sun, 23 Aug 2026 03:15:04 -0700 (PDT)
X-Received: by 2002:a05:6402:847:b0:69e:9213:11b with SMTP id
 4fb4d7f45d1cf-6a42f1bca7amr19604306a12.13.1787480103751; 
 Sun, 23 Aug 2026 03:15:03 -0700 (PDT)
Received: from ?IPV6:2a02:3035:619:f914:538:f8d7:b9f:1ca3?
 ([2a02:3035:619:f914:538:f8d7:b9f:1ca3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e025158sm2768154a12.11.2026.08.23.03.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 03:15:03 -0700 (PDT)
Message-ID: <879f223c-eabd-4a7c-9b3c-01b5fc9930e0@canonical.com>
Date: Sun, 23 Aug 2026 12:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] disk: update partition type reporting
To: dmukhin@ford.com
Cc: ilias.apalodimas@linaro.org, mikhail.kshevetskiy@iopsys.eu,
 quentin.schulz@cherry.de, sjg@chromium.org, u-boot@lists.u-boot-project.org,
 trini@konsulko.com
References: <20260818190426.3567429-3-dmukhin@ford.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260818190426.3567429-3-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/18/26 21:04, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Partition drivers currently report "U-Boot" as the human-readable
> partition type. This does not describe the actual partition and can be
> misleading to the users of this information.
> 
> Update the human-readable partition type from "U-Boot" to
> partition-specific type.
> 
> For GUID partitions, when CONFIG_PARTITION_TYPE_GUID is enabled, use
> gpt_pte.partition_type_guid.b directly for type reporting.
> 
> Update the relevant tests and drop "U-Boot" check in
> blk_get_device_part_str() since it can match against
> gpt_pte.partition_type_guid.b (e.g. "linux").
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v1:
> - use gpt_pte.partition_type_guid.b for CONFIG_PARTITION_TYPE_GUID=y
> - add per-type partition string names
> - updated commit message text
> 
> v1: https://lore.kernel.org/u-boot/20260730013946.1858341-2-dmukhin@ford.com/
> CI: https://github.com/u-boot/u-boot/pull/1036
> ---
>   disk/part.c     | 13 +++----------
>   disk/part_dos.c |  5 ++---
>   disk/part_efi.c |  5 ++++-
>   disk/part_iso.c |  2 +-
>   include/part.h  | 10 ++++++++++
>   test/dm/scsi.c  |  2 +-
>   6 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 4923dc44593c..0661394d2e5d 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -383,7 +383,7 @@ int part_get_info_whole_disk(struct blk_desc *desc,
>   	info->size = desc->lba;
>   	info->blksz = desc->blksz;
>   	info->bootable = 0;
> -	strcpy((char *)info->type, BOOT_PART_TYPE);
> +	strcpy((char *)info->type, PART_TYPE_NAME_UNKNOWN);
>   	strcpy((char *)info->name, "Whole Disk");
>   	disk_partition_clr_uuid(info);
>   	disk_partition_clr_type_guid(info);
> @@ -475,7 +475,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
>   	 * host's own filesystem.
>   	 */
>   	if (!strcmp(ifname, "hostfs")) {
> -		strcpy((char *)info->type, BOOT_PART_TYPE);
> +		strcpy((char *)info->type, PART_TYPE_NAME_HOSTFS);
>   		strcpy((char *)info->name, "Host filesystem");
>   
>   		return 0;
> @@ -493,7 +493,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
>   			return -EINVAL;
>   		}
>   
> -		strcpy((char *)info->type, BOOT_PART_TYPE);
> +		strcpy((char *)info->type, PART_TYPE_NAME_UBI);
>   		strcpy((char *)info->name, "UBI");
>   		return 0;
>   	}
> @@ -645,13 +645,6 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
>   			goto cleanup;
>   		}
>   	}
> -	if (strncmp((char *)info->type, BOOT_PART_TYPE, sizeof(info->type)) != 0) {
> -		printf("** Invalid partition type \"%.32s\""
> -			" (expect \"" BOOT_PART_TYPE "\")\n",
> -			info->type);
> -		ret  = -EINVAL;
> -		goto cleanup;
> -	}
>   
>   	(*desc)->log2blksz = LOG2((*desc)->blksz);
>   
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 4e1d01b2f21e..2336321dc77e 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -273,8 +273,7 @@ static int part_get_info_extended(struct blk_desc *desc,
>   				info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
>   				part_set_generic_name(desc, part_num,
>   						      (char *)info->name);
> -				/* sprintf(info->type, "%d, pt->sys_ind); */
> -				strcpy((char *)info->type, "U-Boot");
> +				strcpy((char *)info->type, PART_TYPE_NAME_DOS);

For GPT partitions the output of the gpt read command looks good with 
this patch.

Like GPT partitions, MBR partitions have different types.

For type ef, info->type could be 'EFI System Partition'.
For type 83, info->type could be 'Linux'.

If you don't want a conversion function, write the hex number to info->type:

sprintf(info->type, "%02x", pt->sys_ind);

>   				info->bootable = get_bootable(pt);
>   				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
>   					char str[12];
> @@ -321,7 +320,7 @@ static int part_get_info_extended(struct blk_desc *desc,
>   		else
>   			info->blksz = DOS_PART_DEFAULT_SECTOR;
>   		info->bootable = 0;
> -		strcpy((char *)info->type, "U-Boot");
> +		strcpy((char *)info->type, PART_TYPE_NAME_DOS);
>   		disk_partition_clr_uuid(info);
>   		return 0;
>   	}
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91a..de7048639a6d 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -304,7 +304,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>   
>   	snprintf((char *)info->name, sizeof(info->name), "%s",
>   		 print_efiname(&gpt_pte));
> -	strcpy((char *)info->type, "U-Boot");
>   	info->bootable = get_bootable(&gpt_pte);
>   	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
>   	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> @@ -316,6 +315,10 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>   		uuid_bin_to_str(gpt_pte.partition_type_guid.b,
>   				(char *)disk_partition_type_guid(info),
>   				UUID_STR_FORMAT_GUID);
> +		snprintf((char *)info->type, sizeof(info->type), "%pUs",
> +			 gpt_pte.partition_type_guid.b);
> +	} else {
> +		strcpy((char *)info->type, PART_TYPE_NAME_EFI);
>   	}
>   
>   	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
> diff --git a/disk/part_iso.c b/disk/part_iso.c
> index 6e05b2feffba..7b4e61f2099e 100644
> --- a/disk/part_iso.c
> +++ b/disk/part_iso.c
> @@ -135,7 +135,7 @@ int part_get_info_iso_verb(struct blk_desc *desc, int part_num,
>   	/* the validation entry seems to be ok, now search the "partition" */
>   	entry_num=1;
>   	offset=0x20;
> -	strcpy((char *)info->type, "U-Boot");
> +	strcpy((char *)info->type, PART_TYPE_NAME_ISO);
>   	part_set_generic_name(desc, part_num, (char *)info->name);
>   	/* the bootcatalog (including validation Entry) is limited to 2048Bytes
>   	 * (63 boot entries + validation entry) */
> diff --git a/include/part.h b/include/part.h
> index 15daacd7faaa..6fee58b290c9 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -31,6 +31,16 @@ struct block_drvr {
>   #define PART_TYPE_MTD		0x06
>   #define PART_TYPE_UBI		0x07
>   
> +#define PART_TYPE_NAME_UNKNOWN	"unknown"
> +#define PART_TYPE_NAME_MAC	"mac"

This is not a valid MAC partition type name.

struct mac_partition has a field uchar type[32].
This is what you should copy in part_get_info_mac().

> +#define PART_TYPE_NAME_DOS	"dos"

Neither the constant name and nor the value make sense to me.
There is nothing called 'dos' in an MBR partition table.

> +#define PART_TYPE_NAME_ISO	"iso"
> +#define PART_TYPE_NAME_AMIGA	"amiga"

I sent a patch to drop the Amiga driver.

> +#define PART_TYPE_NAME_EFI	"efi"

The table type is GPT not efi.

Best regards

Heinrich

> +#define PART_TYPE_NAME_MTD	"mtd"
> +#define PART_TYPE_NAME_UBI	"ubi"
> +#define PART_TYPE_NAME_HOSTFS	"hostfs"
> +
>   /* maximum number of partition entries supported by search */
>   #define DOS_ENTRY_NUMBERS	8
>   #define ISO_ENTRY_NUMBERS	64
> diff --git a/test/dm/scsi.c b/test/dm/scsi.c
> index fbc36a742446..fbf4d1000a10 100644
> --- a/test/dm/scsi.c
> +++ b/test/dm/scsi.c
> @@ -30,7 +30,7 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
>   
>   	info = &part->gpt_part_info;
>   	ut_asserteq_str("sda1", info->name);
> -	ut_asserteq_str("U-Boot", info->type);
> +	ut_asserteq_str(PART_TYPE_NAME_DOS, info->type);
>   	ut_asserteq(0x83 /* linux */, info->sys_ind);
>   
>   	return 0;

