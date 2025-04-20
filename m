Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3C8C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 05:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263DF8205A;
	Sun, 20 Apr 2025 07:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4/qWES0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE40882075; Sun, 20 Apr 2025 05:10:57 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8B682063
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 05:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2386435b3a.1
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745118654; x=1745723454; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CeJn7jU4Iv7Mqe1VhuBe142Q9fEtDuJ/YVuEfulTxTs=;
 b=d4/qWES0Cpt1KXrLU2gpEJNohggf1APsVQVjFvp5aCZA47X8SD6qxnDIo9j7PKMUK9
 Lp6d7Dg+xrfnyzMvdoGYDRirVrZaPP4o7b4DFwbMyFQF5kr1JnmazVTWCmuwE3KmkqOA
 fR56+J8rD42cfkK+2Xk6LMns9Fee/5v9mB6L+B/CNW5hxRvxP/DOVZWHOPoOyoitm2fl
 cUlzbV7OzpmU8io8662Lk0+ewIsx3yIZQV7MmD/0a/dqtonrCFDDLIe7jksO5jRawrx0
 aM2Yn5/C2hGaUarVeI40MGyqOkgyeegALxDzPTYKjQnSOzB0woVKHzYI+ANfw1BjWYbA
 R6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745118654; x=1745723454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CeJn7jU4Iv7Mqe1VhuBe142Q9fEtDuJ/YVuEfulTxTs=;
 b=AmZzK92YQ6DxyvmKA/+NQJbC/YV3vMwJ9jnP0eU1FraTWz7eJPGPo4agaNQyPYBMaw
 QeKQWO61/+MD89x95TM4yPTgBBt6VzuWvICphNTdwSn/Bv8MjrO9vZwZb/lgjROPJuV4
 Ln+eelzZUb5jqcfWCs7KkT6M/+wmrc/CKNAPLHj+3xh7OXLDoU24cuT+dupUHqyO2EZt
 lQGOgTSOngEJINfzgOo/Zcc2gA3eahhbMWSYbIuYhq2EGJotNGqdlShx/LADvBc8RDj3
 LjZpnELSUra33HIQt8eBJ7MMuXSIRMgyQOIDX0/lw6vVtQP6BXAkp4Lem5I+bqHtaU4X
 Sj1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXshAo98Z4ruRbUobsFokkyI6hjw7na3hX1wA298hW5giK9JGKnbdaCqBpSphm4nU8phnNM02U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/uP2xtsvx1IIDYovVqkZJ/NXKkLrl8qNlivf7kBCRmq7BWkL9
 CEgnOrAFa+E9FWqqRgBJjmzfyrMmFB4Gp7nW4PgMo/fiUCRQurc5JSQEPm7+
X-Gm-Gg: ASbGncsQOHv0Ewyrn/GboUJmW3sRWNNN8DqBOhsIA4Y9ndHnvnDZfAlUsvOWIdmENr9
 bGerS3m82+LvXrerngo+8WUDMz+3spwTnXsTrJzILW8NxYvQDCkDZ3xg7xDby+UhPbzDjy1/rkO
 FQWIekpW9+gVQXtcjvQlsW8ttIdqsXZaD6VRArgsYVV366Ic+Nq1C69NZTePzK/KtNzDnAi5Ud7
 8A7BFr1Vegjlbo9uinx7NwzLeZiO/bAq1p8f+13NzAj9dXpql9/Bys4qWcbODmhFrroUqFRB94+
 Sz8JGpMW0Tn8viaMAjhxbT0KTyPrHBxnb7HxijtKwBY7NY0hhjF6yvBK6A+HKhTw+az0E72FjF8
 p/0Fu/EMPJJbKANOqlv7I9rnF6A==
X-Google-Smtp-Source: AGHT+IF2b/tyB71pWyoonsIoWjCOl9ibWjmfBLdsQciUsu9rLz6JQwS4EwEFMZBLRSbu423vRET6Iw==
X-Received: by 2002:a05:6a20:439f:b0:1f5:8e04:f186 with SMTP id
 adf61e73a8af0-203cbd4e457mr13236292637.35.1745118653719; 
 Sat, 19 Apr 2025 20:10:53 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db1273ed0sm3377821a12.12.2025.04.19.20.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 20:10:53 -0700 (PDT)
Message-ID: <1f290d17-147e-4dcc-89cd-af5031cdeb2d@gmail.com>
Date: Sun, 20 Apr 2025 11:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v1, 1/1] net: phy: air_en8811h: load the PHY firmware
 from filesystem on block device instead
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
References: <20250419094319.148380-1-lucienzx159@gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20250419094319.148380-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Apr 2025 07:29:15 +0200
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

Deal maintainers

Considering system-level factors, this commit will not be submitted at 
this time.

Thank you.

Lucien.Jheng 於 2025/4/19 下午 05:43 寫道:
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via MDIO.
>
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
>   drivers/net/phy/Kconfig       | 39 ++++++++------
>   drivers/net/phy/air_en8811h.c | 97 +++++++++++++++++++----------------
>   2 files changed, 78 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 5b4cf30b0a3..384cef845e1 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -94,24 +94,33 @@ choice
>   	depends on PHY_AIROHA_EN8811H
>
>   config PHY_AIROHA_FW_IN_MMC
> -	bool "Airoha firmware in MMC boot1 partition"
> -
> -endchoice
> +	bool "Airoha firmware in MMC partition"
> +	help
> +		Airoha PHYs use firmware which can be loaded automatically
> +		from storage directly attached to the PHY, and then loaded
> +		via MDIO commands by the boot loader. The firmware is loaded
> +		from a file specified by the PHY_AIROHA_FW_PART,
> +		PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
> +
> +config PHY_AIROHA_FW_PART
> +	string "Airoha firmware partition"
> +	depends on PHY_AIROHA_FW_IN_MMC
> +	help
> +		Partition containing the firmware file.
>
> -config AIROHA_FW_ADDR
> -	hex "Airoha Firmware Address"
> -	depends on PHY_AIROHA_EN8811H
> -	default 0x0
> +config PHY_AIROHA_FW_DM_FILEPATH
> +	string "Airoha firmware DM file path in the filesystem"
> +	depends on PHY_AIROHA_FW_IN_MMC
> +	help
> +		Specify Airoha firmware DM file path in the filesystem.
>
> -config AIROHA_MD32_DM_SIZE
> -	hex "Airoha Firmware MD32 DM Size"
> -	depends on PHY_AIROHA_EN8811H
> -	default 0x4000
> +config PHY_AIROHA_FW_DSP_FILEPATH
> +	string "Airoha firmware DSP file path in the filesystem"
> +	depends on PHY_AIROHA_FW_IN_MMC
> +	help
> +		Specify Airoha firmware DSP file path in the filesystem.
>
> -config AIROHA_MD32_DSP_SIZE
> -	hex "Airoha Firmware MD32 DSP Size"
> -	depends on PHY_AIROHA_EN8811H
> -	default 0x20000
> +endchoice
>
>   menuconfig PHY_AQUANTIA
>   	bool "Aquantia Ethernet PHYs support"
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index 96bb24418a0..8a2a25a8c74 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -12,12 +12,14 @@
>    */
>   #include <phy.h>
>   #include <errno.h>
> +#include <log.h>
>   #include <malloc.h>
> +#include <fs.h>
>   #include <asm/unaligned.h>
>   #include <linux/iopoll.h>
> -#include <dm/device_compat.h>
>   #include <linux/bitops.h>
> -#include <mmc.h>
> +#include <dm/device_compat.h>
> +#include <u-boot/crc.h>
>
>   #define EN8811H_PHY_ID		0x03a2a411
>
> @@ -415,11 +417,6 @@ restore_page:
>   	return air_phy_restore_page(phydev, saved_page, ret);
>   }
>
> -__weak ulong *en8811h_get_fw_addr(void)
> -{
> -	return (ulong *)CONFIG_AIROHA_FW_ADDR;
> -}
> -
>   static int en8811h_wait_mcu_ready(struct phy_device *phydev)
>   {
>   	int ret, reg_value;
> @@ -437,85 +434,99 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
>   	return 0;
>   }
>
> +static void crc32_check(unsigned char *name, unsigned char *buf, u32 len)
> +{
> +	u32 ca_crc32;
> +
> +	ca_crc32 = crc32(0, buf, len);
> +	debug("%s: crc32 is 0x%x\n", name, ca_crc32);
> +}
> +
>   static int en8811h_load_firmware(struct phy_device *phydev)
>   {
>   	int ret;
> -	char *addr = NULL;
> +	void *addr = NULL;
>   	struct en8811h_priv *priv = phydev->priv;
> -	int dev = CONFIG_SYS_MMC_ENV_DEV;
> -	u32 cnt = (CONFIG_AIROHA_MD32_DM_SIZE +
> -		   CONFIG_AIROHA_MD32_DSP_SIZE) / 512;
> -	ulong airoha_fw_addr = (ulong)en8811h_get_fw_addr();
> -	u32 blk = airoha_fw_addr / 512;
> -
> -	addr = malloc(CONFIG_AIROHA_MD32_DM_SIZE + CONFIG_AIROHA_MD32_DSP_SIZE);
> -	if (!addr) {
> -		puts("cannot allocated buffer for firmware.\n");
> -		return -ENOMEM;
> -	}
>
>   	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
> -		struct mmc *mmc = find_mmc_device(dev);
> +		loff_t read;
>
> -		if (!mmc) {
> -			puts("Failed to find MMC device for Airoha ucode\n");
> -			goto en8811h_load_firmware_out;
> +		addr = malloc(EN8811H_MD32_DM_SIZE +
> +			      EN8811H_MD32_DSP_SIZE);
> +		if (!addr) {
> +			puts("cannot allocated buffer for firmware.\n");
> +			return -ENOMEM;
>   		}
>
> -		printf("MMC read: dev # %u, block # %u, count %u ...\n",
> -		       dev, blk, cnt);
> +		debug("\nLoading Airoha FW from %s %s\n",
> +		      CONFIG_PHY_AIROHA_FW_PART,
> +		      CONFIG_PHY_AIROHA_FW_DM_FILEPATH);
> +		ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
> +		if (ret < 0)
> +			goto en8811h_load_firmware_out;
>
> -		if (mmc_init(mmc)) {
> -			puts("initializing MMC device failed.\n");
> +		ret = fs_read(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
> +			      (ulong)addr, 0, EN8811H_MD32_DM_SIZE, &read);
> +		if (ret < 0)
>   			goto en8811h_load_firmware_out;
> -		}
>
> -		ret = mmc_set_part_conf(mmc, 1, 2, 2);
> -		if (ret) {
> -			puts("cannot access eMMC boot1 hw partition.\n");
> +		/* Calculate the CRC32 */
> +		crc32_check(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
> +			    (unsigned char *)addr, EN8811H_MD32_DM_SIZE);
> +
> +		debug("Loading Airoha FW from %s %s\n",
> +		      CONFIG_PHY_AIROHA_FW_PART,
> +		      CONFIG_PHY_AIROHA_FW_DSP_FILEPATH);
> +		ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
> +		if (ret < 0)
>   			goto en8811h_load_firmware_out;
> -		}
>
> -		(void)blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
> +		ret = fs_read(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
> +			      (ulong)addr + EN8811H_MD32_DM_SIZE,
> +			      0, EN8811H_MD32_DSP_SIZE, &read);
> +		if (ret < 0)
> +			goto en8811h_load_firmware_out;
>
> -		mmc_set_part_conf(mmc, 1, 1, 0);
> +		/* Calculate the CRC32 */
> +		crc32_check(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
> +			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE,
> +			    EN8811H_MD32_DSP_SIZE);
>
>   	} else {
>   		puts("EN8811H firmware loading not implemented");
> -		free(addr);
> -		addr = NULL;
>   		return -EOPNOTSUPP;
>   	}
>
>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>   				     EN8811H_FW_CTRL_1_START);
>   	if (ret < 0)
> -		return ret;
> +		goto en8811h_load_firmware_out;
>
>   	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
>   				      EN8811H_FW_CTRL_2_LOADING,
>   				      EN8811H_FW_CTRL_2_LOADING);
>   	if (ret < 0)
> -		return ret;
> +		goto en8811h_load_firmware_out;
>
> -	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, CONFIG_AIROHA_MD32_DM_SIZE, addr);
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE,
> +			    (unsigned char *)addr);
>   	if (ret < 0)
>   		goto en8811h_load_firmware_out;
>
> -	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, CONFIG_AIROHA_MD32_DSP_SIZE,
> -			    addr + CONFIG_AIROHA_MD32_DM_SIZE);
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
> +			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE);
>   	if (ret < 0)
>   		goto en8811h_load_firmware_out;
>
>   	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
>   				      EN8811H_FW_CTRL_2_LOADING, 0);
>   	if (ret < 0)
> -		return ret;
> +		goto en8811h_load_firmware_out;
>
>   	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>   				     EN8811H_FW_CTRL_1_FINISH);
>   	if (ret < 0)
> -		return ret;
> +		goto en8811h_load_firmware_out;
>
>   	ret = en8811h_wait_mcu_ready(phydev);
>
> --
> 2.34.1
>
