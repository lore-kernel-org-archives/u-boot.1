Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB0FD58D75
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39514894C0;
	Mon, 25 Nov 2024 18:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GGQTPmh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC6989390; Mon, 25 Nov 2024 18:59:45 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B846C88CC9
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso3356870f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732557582; x=1733162382; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8PaDv9OqaaGp5327DE6W/g7QkVPWRcd/4WXIy8mIe4=;
 b=GGQTPmh6Iek3l2UNPW66voW1YObNMbVxtkiPk/O3/VCYE2jiOMmzuZmaqQBsu5vxdT
 JpBqvwseUUGxSTBbU1sPGWETHaUWjAiOVJI6AoqRwB9OQNGkOnpVGK50fNrj6hUWzGhu
 Zq50r5ULVVbRYjABKfUcj5FBSqGwyX3v/p8WsEIi/3U8zI52JIvqt/QQzs8igCz+7frU
 UiuA4YdTl/koyK1zlwuyJe8ruwsJj0pq+Gc5MBpVVE8hPjS2nSc2Vl8YWLSxsrz+mPub
 Eqh9utXdIP9G0Ssxu0qwxgubjHCYZIhgGdZT0Tbd7Vq8lSIfM+crEA8cneczHWsnsaRm
 xCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557582; x=1733162382;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8PaDv9OqaaGp5327DE6W/g7QkVPWRcd/4WXIy8mIe4=;
 b=uhGY/WxwaV6xKSil2s66hgewCLEgZ3wzCq8FGbuNLryHboTnfIEbt8d+y/dCaAtxKA
 Ic0obu/EHNaChbIu4SZ+QG0kDzXahGHWGIiER/N+JTPZlqy3dSdgh+LhNdgDwTowaufB
 Nq+AZ/lhH0QNsdFEXg58U8GgAdRSk/fxFGyT8LLuY5iy3n14sf2EK7bfe3qImj8PqBLI
 ZOpCFlsscL5DG8EQDGfZcuMdQBJAy4QRj4Q8lSK3Mp5nFFIrLFypul1azZLKjQrhccVz
 tImyZWgi+0N4yKPrRBsbhBg9k7RVP2Xqxb45mkdOgAntdBgYeFqUe3RsVSAZA+9Zr4pl
 mG8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFmc4O5C619wRKgV8U4MIXyCSIHK/pUCVsBdEpCTkqTUYjTgul3QnC2xfsPAYWaB7U7ceLJEE=@lists.denx.de
X-Gm-Message-State: AOJu0YzopeOkCd+FUwv1XTbaVJYngdKHUXsTfNFE8Z5Jnv30osGvFyDS
 bdJZJ83cbznNjJ6S0bD3PIk/hu3CfsD3vWEub7+rrVZ+7FqtnIVsjutklZeCHVM=
X-Gm-Gg: ASbGncvKDdCQFqMoLnoWW3g6xptUJkr7QZ6arVp5njbqsYFEk7TLwZsCwNNLcqRN4sp
 8y1W0CoGecJzqr0H4eKxjOuq86hnUk0MPb0fncpAL8u3NSbo9HnFfh41AA6c/njtYoTqkj1yLrr
 4fwcGfdktanl6sgI/X3bpPd17PJg0R1JDFIj3HFLwveeaw8Wo3ALvEb18Jv6Adv9YGuIyfwLC1+
 Qu1+y0ZAiXf50NB1Y/sA6ok4mH1uC+bNRlpjxeZDzGxBUCuS8Ny/pzaYkqjc+JBJkc99wSu0krU
 FfvHteQnoD+wAjYfyaydUglCWK2SWRmW
X-Google-Smtp-Source: AGHT+IFvVjBFiaqZqCE9f8tnzHe/E7PVSCvR45TSR+gOTO6HuxGSZSbv1TraY0mutuXp9kXPHjRgZw==
X-Received: by 2002:a5d:6d01:0:b0:382:4c36:e072 with SMTP id
 ffacd0b85a97d-38260b969b2mr11426134f8f.30.1732557582071; 
 Mon, 25 Nov 2024 09:59:42 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d01d3fc663sm4361754a12.66.2024.11.25.09.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 09:59:41 -0800 (PST)
Message-ID: <d741a762-f56d-44b9-898f-38a4ae3c5689@linaro.org>
Date: Mon, 25 Nov 2024 18:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: fastboot: Enable flashing support for UFS
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 mkorpershoek@baylibre.com, trini@konsulko.com, jerome.forissier@linaro.org,
 avromanov@salutedevices.com, sjg@chromium.org, ion@agorria.com,
 clamor95@gmail.com, quentin.schulz@cherry.de, u-boot@lists.denx.de
References: <20241125110354.602124-1-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241125110354.602124-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Varadarajan,

On 25/11/2024 12:03, Varadarajan Narayanan wrote:
> MMC and UFS seem to execute very similar steps to identify the
> partition and write to it. Hence try to enable fastboot flashing
> support in UFS leveraging the MMC functions.

Thanks for this! Do you think we could make this dynamic at runtime?
Since it's currently possible to build a single binary with
qcom_defconfig that will work across a wide range of boards (both with
eMMC and UFS), I don't think it makes sense to pick a fastboot backend
at build time.

Some additional comments below.
> 
> Tested on rb3gen2 platform.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/fastboot/Kconfig      | 19 +++++++++++++++---
>  drivers/fastboot/Makefile     |  1 +
>  drivers/fastboot/fb_command.c |  6 ++++--
>  drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++++++++-----------
>  4 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 1eb460f5a0..5c41fc4684 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || UFS || (MTD_RAW_NAND && CMD_MTDPARTS)
>  	select IMAGE_SPARSE
>  	help
>  	  The fastboot protocol includes a "flash" command for writing
> @@ -120,6 +120,10 @@ config FASTBOOT_FLASH_NAND
>  	bool "FASTBOOT on NAND"
>  	depends on MTD_RAW_NAND && CMD_MTDPARTS
>  
> +config FASTBOOT_FLASH_UFS
> +	bool "FASTBOOT on UFS"
> +	depends on UFS && EFI_PARTITION
> +
>  endchoice
>  
>  config FASTBOOT_FLASH_MMC_DEV
> @@ -133,6 +137,15 @@ config FASTBOOT_FLASH_MMC_DEV
>  	  regarding the non-volatile storage device. Define this to
>  	  the eMMC device that fastboot should use to store the image.
>  
> +config FASTBOOT_FLASH_UFS_DEV
> +	int "Define FASTBOOT UFS FLASH default device"
> +	depends on FASTBOOT_FLASH_UFS
> +	default 0 if CONFIG_ARCH_SNAPDRAGON
> +	help
> +	  The fastboot "flash" command requires additional information
> +	  regarding the non-volatile storage device. Define this to
> +	  the UFS device that fastboot should use to store the image.

This doesn't map at all to how fastboot is intended to work. We would
expect to see all partitions exposed not just those of a specific LUN.
> +
>  config FASTBOOT_FLASH_NAND_TRIMFFS
>  	bool "Skip empty pages when flashing NAND"
>  	depends on FASTBOOT_FLASH_NAND
> @@ -196,7 +209,7 @@ config FASTBOOT_MMC_USER_NAME
>  
>  config FASTBOOT_GPT_NAME
>  	string "Target name for updating GPT"
> -	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
>  	default "gpt"
>  	help
>  	  The fastboot "flash" command supports writing the downloaded
> @@ -209,7 +222,7 @@ config FASTBOOT_GPT_NAME
>  
>  config FASTBOOT_MBR_NAME
>  	string "Target name for updating MBR"
> -	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && DOS_PARTITION
>  	default "mbr"
>  	help
>  	  The fastboot "flash" command allows to write the downloaded image
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index 048af5aa82..772276cb6c 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -4,4 +4,5 @@ obj-y += fb_common.o
>  obj-y += fb_getvar.o
>  obj-y += fb_command.o
>  obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
> +obj-$(CONFIG_FASTBOOT_FLASH_UFS) += fb_mmc.o
>  obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index e4484d65ac..a6fa8299b8 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -336,7 +336,8 @@ void fastboot_data_complete(char *response)
>   */
>  static void __maybe_unused flash(char *cmd_parameter, char *response)
>  {
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
> +	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
>  		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
>  					 image_size, response);
>  
> @@ -356,7 +357,8 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
>   */
>  static void __maybe_unused erase(char *cmd_parameter, char *response)
>  {
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
> +	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
>  		fastboot_mmc_erase(cmd_parameter, response);
>  
>  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index f11eb66761..bf242e4b2a 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -20,6 +20,16 @@
>  
>  #define BOOT_PARTITION_NAME "boot"
>  
> +#if defined(CONFIG_FASTBOOT_FLASH_MMC)
> +#define fb_flash_str	"mmc"

Macros be in upper case.

This is something I think would make more sense as a variable. Perhaps
the fastboot command could be extended to allow passing in a device (or
list of devices?) to use.
> +#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_MMC_DEV
> +#elif defined(CONFIG_FASTBOOT_FLASH_UFS)
> +#define fb_flash_str	"scsi"
> +#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_UFS_DEV
> +#else
> +#error "Incorrect flash type"
> +#endif
> +
>  struct fb_mmc_sparse {
>  	struct blk_desc	*dev_desc;
>  };
> @@ -78,7 +88,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
>  	int ret;
>  
>  	/* First try partition names on the default device */
> -	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +	*dev_desc = blk_get_dev(fb_flash_str, fb_flash_dev);
>  	if (*dev_desc) {
>  		ret = part_get_info_by_name(*dev_desc, name, info);
>  		if (ret >= 0)
> @@ -91,8 +101,8 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
>  	}
>  
>  	/* Then try dev.hwpart:part */
> -	ret = part_get_info_by_dev_and_name_or_num("mmc", name, dev_desc,
> -						   info, true);
> +	ret = part_get_info_by_dev_and_name_or_num(fb_flash_str, name,
> +						   dev_desc, info, true);
>  	return ret;
>  }
>  
> @@ -202,17 +212,20 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
>  {
>  	lbaint_t blks;
>  
> -	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
> +	debug("Start Erasing %s hwpart[%u]...\n",
> +	      fb_flash_str, dev_desc->hwpart);
>  
>  	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
>  
>  	if (blks != dev_desc->lba) {
> -		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
> +		pr_err("Failed to erase %s hwpart[%u]\n",
> +		       fb_flash_str, dev_desc->hwpart);
>  		return 1;
>  	}
>  
> -	printf("........ erased %lu bytes from mmc hwpart[%u]\n",
> -	       dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
> +	printf("........ erased %lu bytes from %s hwpart[%u]\n",
> +	       dev_desc->lba * dev_desc->blksz, fb_flash_str,
> +	       dev_desc->hwpart);
>  
>  	return 0;
>  }
> @@ -487,11 +500,10 @@ int fastboot_mmc_get_part_info(const char *part_name,
>  
>  static struct blk_desc *fastboot_mmc_get_dev(char *response)
>  {
> -	struct blk_desc *ret = blk_get_dev("mmc",
> -					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +	struct blk_desc *ret = blk_get_dev(fb_flash_str, fb_flash_dev);
>  
>  	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
> -		pr_err("invalid mmc device\n");
> +		pr_err("invalid %s device\n", fb_flash_str);

		pr_err("invalid "fb_flash_str" device\n"); -- and the same for all
other cases.
>  		fastboot_fail("invalid mmc device", response);
>  		return NULL;
>  	}
> @@ -644,10 +656,11 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   */
>  void fastboot_mmc_erase(const char *cmd, char *response)
>  {
> +#ifdef CONFIG_FASTBOOT_FLASH_MMC
>  	struct blk_desc *dev_desc;
>  	struct disk_partition info;
>  	lbaint_t blks, blks_start, blks_size, grp_size;
> -	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +	struct mmc *mmc = find_mmc_device(fb_flash_dev);
>  
>  #ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
>  	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
> @@ -706,5 +719,6 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>  
>  	printf("........ erased " LBAFU " bytes from '%s'\n",
>  	       blks_size * info.blksz, cmd);
> +#endif
>  	fastboot_okay(NULL, response);

I don't think it's really acceptable to just lie that we erase a
partition when in fact we did nothing at all.

This should respond with some error indicating that the command isn't
supported.
>  }

-- 
// Caleb (they/them)

