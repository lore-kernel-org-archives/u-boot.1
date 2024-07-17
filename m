Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA1EC3DA49
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 01:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EE08870C;
	Wed, 17 Jul 2024 03:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UqonzibM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238338870C; Wed, 17 Jul 2024 03:47:53 +0200 (CEST)
Received: from mail-m15594.qiye.163.com (mail-m15594.qiye.163.com
 [101.71.155.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E5D8852E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 03:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=UqonzibMRMyzuX7ORFvg28oOZ70wwRNOXAiK0bE1F7iBpIP8+5CrqVknaxqVbvD+algIYQQ0S1s8QzmY/Q+WvShHhHuSZv4QjNP4LG+HqXYzS+BgrinFzy27AGARIfiEpemKZxc2j5lYjxYB5+7o6n+UkeK2Y3mOM8+IDscMEPI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iA/hTRKphOgXdNCcGzF9cIiDTM5vMyt4o2ySmewTSfQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DE82C900374;
 Wed, 17 Jul 2024 09:47:30 +0800 (CST)
Message-ID: <2ff9c66b-f8b7-42b8-b6ff-23a97f9171d3@rock-chips.com>
Date: Wed, 17 Jul 2024 09:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: rockchip: using generic capsule update mechanism
To: Weizhao Ouyang <o451686892@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 John Keeping <john@metanate.com>, Dragan Simic <dsimic@manjaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240508111600.154919-1-o451686892@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240508111600.154919-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJDT1YdTR4fSkpOTUgYHh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90be5f8dc703a9kunmde82c900374
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6AQw*MjIxMhwqNxYfEikO
 DxgwCgNVSlVKTElKSkNLQ05JSUlNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU9LSjcG
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

Hi WeiZhao,

On 2024/5/8 19:16, Weizhao Ouyang wrote:
> Currently Rockchip's capsule update mechanism only accepts capsules in
> form of a mmc partition, but a generic capsule update mechanism should
> be used to satisfy the universal requirements.
First of all, the capsule update source code can stay in board.c because 
other boards may
also need this feature;
And then what's this change for "generic capsule update"?

Thanks,
- Kever
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   arch/arm/mach-rockchip/board.c              | 153 ------------------
>   board/radxa/rockpi4-rk3399/rockpi4-rk3399.c | 166 +++++++++++++++++++-
>   2 files changed, 158 insertions(+), 161 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index cd226844b6..73fbb3f58c 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -35,155 +35,6 @@
>   #include <asm/arch-rockchip/periph.h>
>   #include <power/regulator.h>
>   
> -#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> -
> -#define DFU_ALT_BUF_LEN			SZ_1K
> -
> -static struct efi_fw_image *fw_images;
> -
> -static bool updatable_image(struct disk_partition *info)
> -{
> -	int i;
> -	bool ret = false;
> -	efi_guid_t image_type_guid;
> -
> -	uuid_str_to_bin(info->type_guid, image_type_guid.b,
> -			UUID_STR_FORMAT_GUID);
> -
> -	for (i = 0; i < update_info.num_images; i++) {
> -		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
> -			ret = true;
> -			break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static void set_image_index(struct disk_partition *info, int index)
> -{
> -	int i;
> -	efi_guid_t image_type_guid;
> -
> -	uuid_str_to_bin(info->type_guid, image_type_guid.b,
> -			UUID_STR_FORMAT_GUID);
> -
> -	for (i = 0; i < update_info.num_images; i++) {
> -		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
> -			fw_images[i].image_index = index;
> -			break;
> -		}
> -	}
> -}
> -
> -static int get_mmc_desc(struct blk_desc **desc)
> -{
> -	int ret;
> -	struct mmc *mmc;
> -	struct udevice *dev;
> -
> -	/*
> -	 * For now the firmware images are assumed to
> -	 * be on the SD card
> -	 */
> -	ret = uclass_get_device(UCLASS_MMC, 1, &dev);
> -	if (ret)
> -		return -1;
> -
> -	mmc = mmc_get_mmc_dev(dev);
> -	if (!mmc)
> -		return -ENODEV;
> -
> -	if ((ret = mmc_init(mmc)))
> -		return ret;
> -
> -	*desc = mmc_get_blk_desc(mmc);
> -	if (!*desc)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	const char *name;
> -	bool first = true;
> -	int p, len, devnum, ret;
> -	char buf[DFU_ALT_BUF_LEN];
> -	struct disk_partition info;
> -	struct blk_desc *desc = NULL;
> -
> -	ret = get_mmc_desc(&desc);
> -	if (ret) {
> -		log_err("Unable to get mmc desc\n");
> -		return;
> -	}
> -
> -	memset(buf, 0, sizeof(buf));
> -	name = blk_get_uclass_name(desc->uclass_id);
> -	devnum = desc->devnum;
> -	len = strlen(buf);
> -
> -	len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
> -			 "%s %d=", name, devnum);
> -
> -	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> -		if (part_get_info(desc, p, &info))
> -			continue;
> -
> -		/* Add entry to dfu_alt_info only for updatable images */
> -		if (updatable_image(&info)) {
> -			if (!first)
> -				len += snprintf(buf + len,
> -						DFU_ALT_BUF_LEN - len, ";");
> -
> -			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
> -					"%s%d_%s part %d %d",
> -					name, devnum, info.name, devnum, p);
> -			first = false;
> -		}
> -	}
> -
> -	log_debug("dfu_alt_info => %s\n", buf);
> -	env_set("dfu_alt_info", buf);
> -}
> -
> -__weak void rockchip_capsule_update_board_setup(void)
> -{
> -}
> -
> -static void gpt_capsule_update_setup(void)
> -{
> -	int p, i, ret;
> -	struct disk_partition info;
> -	struct blk_desc *desc = NULL;
> -
> -	fw_images = update_info.images;
> -	rockchip_capsule_update_board_setup();
> -
> -	ret = get_mmc_desc(&desc);
> -	if (ret) {
> -		log_err("Unable to get mmc desc\n");
> -		return;
> -	}
> -
> -	for (p = 1, i = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> -		if (part_get_info(desc, p, &info))
> -			continue;
> -
> -		/*
> -		 * Since we have a GPT partitioned device, the updatable
> -		 * images could be stored in any order. Populate the
> -		 * image_index at runtime.
> -		 */
> -		if (updatable_image(&info)) {
> -			set_image_index(&info, i);
> -			i++;
> -		}
> -	}
> -}
> -#endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
> -
>   __weak int rk_board_late_init(void)
>   {
>   	return 0;
> @@ -193,10 +44,6 @@ int board_late_init(void)
>   {
>   	setup_boot_mode();
>   
> -#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> -	gpt_capsule_update_setup();
> -#endif
> -
>   	return rk_board_late_init();
>   }
>   
> diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> index a533128b92..01c3b7d5a2 100644
> --- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> +++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> @@ -4,22 +4,132 @@
>    */
>   
>   #include <dm.h>
> +#include <mmc.h>
> +#include <part.h>
>   #include <efi_loader.h>
>   
>   #define ROCKPI4_UPDATABLE_IMAGES	2
>   
> -#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> -static struct efi_fw_image fw_images[ROCKPI4_UPDATABLE_IMAGES] = {0};
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> +
> +#define DFU_ALT_BUF_LEN			SZ_1K
> +
> +static struct efi_fw_image *fw_images = {0};
> +static struct efi_fw_image fw_images_d[ROCKPI4_UPDATABLE_IMAGES] = {0};
>   
>   struct efi_capsule_update_info update_info = {
>   	.num_images = ROCKPI4_UPDATABLE_IMAGES,
> -	.images = fw_images,
> +	.images = fw_images_d,
>   };
>   
> -#endif
> +static bool updatable_image(struct disk_partition *info)
> +{
> +	int i;
> +	bool ret = false;
> +	efi_guid_t image_type_guid;
> +
> +	uuid_str_to_bin(info->type_guid, image_type_guid.b,
> +			UUID_STR_FORMAT_GUID);
> +
> +	for (i = 0; i < update_info.num_images; i++) {
> +		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void set_image_index(struct disk_partition *info, int index)
> +{
> +	int i;
> +	efi_guid_t image_type_guid;
> +
> +	uuid_str_to_bin(info->type_guid, image_type_guid.b,
> +			UUID_STR_FORMAT_GUID);
> +
> +	for (i = 0; i < update_info.num_images; i++) {
> +		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
> +			fw_images[i].image_index = index;
> +			break;
> +		}
> +	}
> +}
> +
> +static int get_mmc_desc(struct blk_desc **desc)
> +{
> +	int ret;
> +	struct mmc *mmc;
> +	struct udevice *dev;
> +
> +	/*
> +	 * For now the firmware images are assumed to
> +	 * be on the SD card
> +	 */
> +	ret = uclass_get_device(UCLASS_MMC, 1, &dev);
> +	if (ret)
> +		return -1;
> +
> +	mmc = mmc_get_mmc_dev(dev);
> +	if (!mmc)
> +		return -ENODEV;
> +
> +	ret = mmc_init(mmc);
> +	if (ret)
> +		return ret;
> +
> +	*desc = mmc_get_blk_desc(mmc);
> +	if (!*desc)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +	const char *name;
> +	bool first = true;
> +	int p, len, devnum, ret;
> +	char buf[DFU_ALT_BUF_LEN];
> +	struct disk_partition info;
> +	struct blk_desc *desc = NULL;
> +
> +	ret = get_mmc_desc(&desc);
> +	if (ret) {
> +		log_err("Unable to get mmc desc\n");
> +		return;
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	name = blk_get_uclass_name(desc->uclass_id);
> +	devnum = desc->devnum;
> +	len = strlen(buf);
> +
> +	len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
> +			 "%s %d=", name, devnum);
> +
> +	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> +		if (part_get_info(desc, p, &info))
> +			continue;
> +
> +		/* Add entry to dfu_alt_info only for updatable images */
> +		if (updatable_image(&info)) {
> +			if (!first)
> +				len += snprintf(buf + len,
> +						DFU_ALT_BUF_LEN - len, ";");
> +
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
> +					"%s%d_%s part %d %d",
> +					name, devnum, info.name, devnum, p);
> +			first = false;
> +		}
> +	}
> +
> +	log_debug("dfu_alt_info => %s\n", buf);
> +	env_set("dfu_alt_info", buf);
> +}
>   
> -#ifndef CONFIG_SPL_BUILD
> -#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
>   static bool board_is_rockpi_4b(void)
>   {
>   	return of_machine_is_compatible("radxa,rockpi4b");
> @@ -30,7 +140,7 @@ static bool board_is_rockpi_4c(void)
>   	return of_machine_is_compatible("radxa,rockpi4c");
>   }
>   
> -void rockchip_capsule_update_board_setup(void)
> +static void rockchip_capsule_update_board_setup(void)
>   {
>   	if (board_is_rockpi_4b()) {
>   		efi_guid_t idbldr_image_type_guid =
> @@ -54,5 +164,45 @@ void rockchip_capsule_update_board_setup(void)
>   		fw_images[1].fw_name = u"ROCKPI4C-UBOOT";
>   	}
>   }
> +
> +static void gpt_capsule_update_setup(void)
> +{
> +	int p, i, ret;
> +	struct disk_partition info;
> +	struct blk_desc *desc = NULL;
> +
> +	fw_images = update_info.images;
> +	rockchip_capsule_update_board_setup();
> +
> +	ret = get_mmc_desc(&desc);
> +	if (ret) {
> +		log_err("Unable to get mmc desc\n");
> +		return;
> +	}
> +
> +	for (p = 1, i = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> +		if (part_get_info(desc, p, &info))
> +			continue;
> +
> +		/*
> +		 * Since we have a GPT partitioned device, the updatable
> +		 * images could be stored in any order. Populate the
> +		 * image_index at runtime.
> +		 */
> +		if (updatable_image(&info)) {
> +			set_image_index(&info, i);
> +			i++;
> +		}
> +	}
> +}
>   #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
> -#endif /* !CONFIG_SPL_BUILD */
> +
> +int rk_board_late_init(void)
> +{
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> +	gpt_capsule_update_setup();
> +#endif
> +
> +	return 0;
> +}
> +
