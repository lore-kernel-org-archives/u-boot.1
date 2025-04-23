Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B5C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDBF80EE5;
	Wed, 23 Apr 2025 09:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eXR4IYnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E60280F03; Wed, 23 Apr 2025 09:38:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F18E80BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso38183615e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745393929; x=1745998729; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aDluRQ3kJw/anEzNItaPESU2oZ9iGntKiWyVeCrHpRU=;
 b=eXR4IYnEPLi4jXLLoJVPqNtEWwd7oiQArPWnIQS2Sw/pAtnw8pOav4wvvshhxwtfuJ
 EH+fEDKYHomGN2iGHKW8bhtLGqQTLYCqV5hbNKQJZlhDjVfQ9BOxOe3bvdYJlbdOiyuZ
 dGaTzDXuwq0FnMRucaPWYK4weUrD/leZdxfnFGh2GSpU5eRU6YSZKErQD7tUGolq5p5Z
 oJqY44JxViq7O4CCcG69St+xgwaoUA+SrdprybS9GNPGfMsoT95gWjNXAZFLm0LfcMbx
 RZhFE0tr/MJLaCm35wvWy1ebGGFAeKKKiLE6aUXdUbmwnhrS4TMlLIlJFqu/P1vWCxW/
 4FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745393929; x=1745998729;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aDluRQ3kJw/anEzNItaPESU2oZ9iGntKiWyVeCrHpRU=;
 b=YGcVo/4/qp3qCuPaxTr8UdFN3IpLcLJnTpEEhG0T2ntRYtih3ONFxNOHpEjYDhorty
 MrVoQT/jeYxyWhNV9YKeFeUyCJftvle2V1lKmkiJe4F9VgzrUuNJHv+2dT3Ryw0bo02K
 YuIkBMPOQ8Q31Oyi7aZHP+3fV04uJd0flhzZyvTwWIhKtCMx5JDkokrxdTCHpPGxeUG1
 CZGAcOgxF94lAD+O7q3lK+5iXUaT1iu0wjoXgpvwRaxaOOWklU07LC8tagUIAgZrXupy
 M59YPtl/TRc3siX6WNk5Lfs09EvNlS562bBuemkByALGgPVAQRFmW1CkbZYnVJPgUmFv
 QgPw==
X-Gm-Message-State: AOJu0YwJLeG4QKBxydL/J5k08hKlsA/kfcBA65ZC+ngeEak/Ea0QxgCs
 YPM0RPt2Wp+ZaPZrVzkYPwj39Nt/wLoan2O9OSUXCZIemTOcaZ7+kvjUXtJA2LI=
X-Gm-Gg: ASbGncs/0XRh2lcVzCkGMbOgnVY/qIeWaCWM3pmWL9MuTe++eA5OOH1WLia87kZmJoh
 KNNl8yOAQpNhoh2ahzh7mxjm/iuPUN7JAsDK4ahwu0zf9ErJoXsZeWcj/KXPfBkCX7oByuzNT8W
 nvqSOMtaOS/TIk9s0TF23KPxJHc30NoXR238v3WIpm21H4bxnXG+vwRHEP/4RAA7rM7owhkQRvO
 ep8VR/QC+hfnKeAXtP5tjyV9K2Az0YtK7KZFXLsKxuKnoQup6aLHLIbClvMIdDUJ0CpMAQnG3WM
 EdlekpDJco5XdIfkwzFvaVYOlIg0i55Q8nH/IWgpu/m7TOV3mArmDJiwT/lYO0LFPpd3j9I4bWr
 mPpX4yZhtDzwBMBtH7w==
X-Google-Smtp-Source: AGHT+IFGLs17wWhzbrADF0gx+te7PK5oSdeX4EZPbrbDfVzTCnFOVVvk4fDiF/jH+sdrvzUTsC9IJQ==
X-Received: by 2002:a05:600c:4f12:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-4406ab950admr138241675e9.9.1745393929515; 
 Wed, 23 Apr 2025 00:38:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd?
 ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d0a7802sm26922435e9.1.2025.04.23.00.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 00:38:49 -0700 (PDT)
Message-ID: <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
Date: Wed, 23 Apr 2025 09:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <877c3cgwsf.fsf@kernel.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 22/04/2025 15:17, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> Thank you for the patch.

Thx for the review

> 
> On mer., avril 09, 2025 at 09:58, neil.armstrong@linaro.org wrote:
> 
>> From: Dmitrii Merkurev <dimorinny@google.com>
>>
>> Introduce fastboot block flashing functions and helpers
>> to be shared with the MMC implementation.
>>
>> The write logic comes from the mmc implementation, while
>> the partition lookup is much simpler and could be extended.
>>
>> For the erase logic, allmost no block drivers exposes the
>> erase operation, except mmc & virtio, so in order to allow
>> erasiong any partition a soft-erase logic has been added
>> to write zero-ed buffers in a loop.
>>
>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/fastboot/Kconfig    |  20 ++-
>>   drivers/fastboot/Makefile   |   4 +-
>>   drivers/fastboot/fb_block.c | 313 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/fb_block.h          | 104 +++++++++++++++
>>   4 files changed, 438 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 1eb460f5a02a87089d85b252375202d9acaec9fa..76b35d8419e02a7f1d36988fbdac190b10bff35e 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
>>   config FASTBOOT_FLASH
>>   	bool "Enable FASTBOOT FLASH command"
>>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>>   	select IMAGE_SPARSE
>>   	help
>>   	  The fastboot protocol includes a "flash" command for writing
>> @@ -114,12 +114,16 @@ choice
>>   
>>   config FASTBOOT_FLASH_MMC
>>   	bool "FASTBOOT on MMC"
>> -	depends on MMC
>> +	depends on MMC && BLK
>>   
>>   config FASTBOOT_FLASH_NAND
>>   	bool "FASTBOOT on NAND"
>>   	depends on MTD_RAW_NAND && CMD_MTDPARTS
>>   
>> +config FASTBOOT_FLASH_BLOCK
>> +	bool "FASTBOOT on block device"
>> +	depends on BLK
>> +
>>   endchoice
>>   
>>   config FASTBOOT_FLASH_MMC_DEV
>> @@ -194,6 +198,18 @@ config FASTBOOT_MMC_USER_NAME
>>   	  defined here.
>>   	  The default target name for erasing EMMC_USER is "mmc0".
>>   
>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>> +	string "Define FASTBOOT block interface name"
>> +	depends on FASTBOOT_FLASH_BLOCK
>> +	help
>> +	  "Fastboot block interface name (mmc, virtio, etc)"
> 
> Maybe use another example in the help mmc. for MMC, we have FASTBOOT_FLASH_MMC.
> FASTBOOT_FLASH_MMC has more features than FASTBOOT_FLASH_BLOCK_INTERFACE="mmc".
> 
> For example, boot partition labels.
> 
> When using this diff:
> 
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index b77a44ce859b..bfe4db90963c 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -65,8 +65,9 @@ CONFIG_BUTTON_ADC=y
>   CONFIG_USB_FUNCTION_FASTBOOT=y
>   CONFIG_FASTBOOT_BUF_ADDR=0x6000000
>   CONFIG_FASTBOOT_FLASH=y
> -CONFIG_FASTBOOT_FLASH_MMC_DEV=2
> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_FASTBOOT_FLASH_BLOCK=y
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=2
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_MESON=y
>   CONFIG_MMC_MESON_GX=y
> 
> We cannot flash the "bootloader" partition:
> $ fastboot flash bootloader u-boot_kvim3_noab.bin
> Warning: skip copying bootloader image avb footer (bootloader partition size: 0, bootloader image size: 1285488).
> Sending 'bootloader' (1255 KB)                     OKAY [  0.054s]
> Writing 'bootloader'                               FAILED (remote: 'failed to get partition info')
> fastboot: error: Command failed
> 
> If we do want to merge both (at some later time) the above should be supported.

Right, I don't think we want to merge them, and boot partitions are an MMC specific feature,
I don't think any other storages has those specific hardware boot partitions.

In any case, we can still just name the boot partition "bootloader" and raw flash it.

> 
>> +
>> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>> +	int "Define FASTBOOT block device id"
>> +	depends on FASTBOOT_FLASH_BLOCK
>> +	help
>> +	  "Fastboot block device id"
> 
> This is similar as CONFIG_FASTBOOT_FLASH_MMC_DEV, no?

No, the MMC one makes the mmc type implicit, while the block one
can target any block device (and mmc)

> 
> To me, it's confusing to have similar KConfig entries based on interface
> type.
> 
> If we really want to do it this way, then we should add a safeguard in
> the code: test if FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "mmc" and if so, add a
> warning to recommend using FASTBOOT_FLASH_MMC instead.
> 
> What's your opinion on this?

Perhaps, not sure it's really problematic

> 
>> +
>>   config FASTBOOT_GPT_NAME
>>   	string "Target name for updating GPT"
>>   	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
>> index 048af5aa823436956142a536c5f7dcf1a8948726..91e98763e8eab84ccd9b8e5354ff1419f61ef372 100644
>> --- a/drivers/fastboot/Makefile
>> +++ b/drivers/fastboot/Makefile
>> @@ -3,5 +3,7 @@
>>   obj-y += fb_common.o
>>   obj-y += fb_getvar.o
>>   obj-y += fb_command.o
>> -obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
>> +obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
>> +# MMC reuses block implementation
>> +obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
>>   obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..e79429a9732c1da1ce88358747cf1cb9419cd12b
>> --- /dev/null
>> +++ b/drivers/fastboot/fb_block.c
>> @@ -0,0 +1,313 @@
>> +// SPDX-License-Identifier: BSD-2-Clause
> 
> Should this be GPL?

Very good qustion, I'm not the copyright holder, the original author is Dmitrii, not sure about
the legal things here.

Tom can you help ?

> 
> See:
> https://docs.u-boot.org/en/latest/develop/sending_patches.html#notes
> 
>> +/*
>> + * Copyright (C) 2024 The Android Open Source Project
>> + */
>> +
>> +#include <blk.h>
>> +#include <div64.h>
>> +#include <fastboot-internal.h>
>> +#include <fastboot.h>
>> +#include <fb_block.h>
>> +#include <image-sparse.h>
>> +#include <part.h>
>> +#include <malloc.h>
>> +
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
>> + *
>> + * in the ERASE case we can have much larger buffer size since
>> + * we're not transferring an actual buffer
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at once
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
>> +
>> +struct fb_block_sparse {
>> +	struct blk_desc	*dev_desc;
>> +};
>> +
>> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t start,
>> +			       lbaint_t blkcnt, const void *buffer)
>> +{
>> +	lbaint_t blk = start;
>> +	lbaint_t blks_written = 0;
>> +	lbaint_t cur_blkcnt = 0;
>> +	lbaint_t blks = 0;
>> +	void *erase_buf = NULL;
>> +	int erase_buf_blks = 0;
>> +	int step = buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_ERASE;
>> +	int i;
>> +
>> +	for (i = 0; i < blkcnt; i += step) {
>> +		cur_blkcnt = min((int)blkcnt - i, step);
>> +		if (buffer) {
>> +			if (fastboot_progress_callback)
>> +				fastboot_progress_callback("writing");
>> +			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
>> +						  buffer + (i * block_dev->blksz));
>> +		} else {
>> +			if (fastboot_progress_callback)
>> +				fastboot_progress_callback("erasing");
>> +
>> +			if (!erase_buf) {
>> +				blks_written = blk_derase(block_dev, blk, cur_blkcnt);
>> +
>> +				/* Allocate erase buffer if erase is not implemented */
>> +				if ((long)blks_written == -ENOSYS) {
>> +					erase_buf_blks = min_t(long, blkcnt,
>> +							       FASTBOOT_MAX_BLOCKS_SOFT_ERASE);
>> +					erase_buf = malloc(erase_buf_blks * block_dev->blksz);
>> +					memset(erase_buf, 0, erase_buf_blks * block_dev->blksz);
>> +
>> +					printf("Slowly writing empty buffers due to missing erase operation\n");
>> +				}
>> +			}
>> +
>> +			/* Write 0s instead of using erase operation, inefficient but functional */
>> +			if (erase_buf) {
>> +				int j;
>> +
>> +				blks_written = 0;
>> +				for (j = 0; j < cur_blkcnt; j += erase_buf_blks) {
>> +					lbaint_t remain = min_t(lbaint_t, cur_blkcnt - j,
>> +								erase_buf_blks);
>> +
>> +					blks_written += blk_dwrite(block_dev, blk + j,
>> +								   remain, erase_buf);
>> +					printf(".");
> 
> Can we move soft erase to a separate function? Here we already handle
> normal block write and normal block erase. Having software erase as well
> makes the function a bit too long/nested in my opinion.
> 
> I't also avoid writing things like:
> 
>      blks_written = blk_derase(block_dev, blk, cur_blkcnt);
> 
> Where blks_written actually means "amount of blocks that were erased".
> 
> Or maybe split write/erase to make each function do only one thing.

Sure, I'll move it to a separate function

> 
>> +				}
>> +			}
>> +		}
>> +		blk += blks_written;
>> +		blks += blks_written;
>> +	}
>> +
>> +	if (erase_buf)
>> +		free(erase_buf);
>> +
>> +	return blks;
>> +}
>> +
>> +static lbaint_t fb_block_sparse_write(struct sparse_storage *info,
>> +				      lbaint_t blk, lbaint_t blkcnt,
>> +				      const void *buffer)
>> +{
>> +	struct fb_block_sparse *sparse = info->priv;
>> +	struct blk_desc *dev_desc = sparse->dev_desc;
>> +
>> +	return fb_block_write(dev_desc, blk, blkcnt, buffer);
>> +}
>> +
>> +static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
>> +					lbaint_t blk, lbaint_t blkcnt)
>> +{
>> +	return blkcnt;
>> +}
>> +
>> +int fastboot_block_get_part_info(const char *part_name,
>> +				 struct blk_desc **dev_desc,
>> +				 struct disk_partition *part_info,
>> +				 char *response)
>> +{
>> +	int ret;
>> +	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>> +						   NULL);
>> +	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>> +
>> +	if (!part_name || !strcmp(part_name, "")) {
>> +		fastboot_fail("partition not given", response);
>> +		return -ENOENT;
>> +	}
>> +	if (!interface || !strcmp(interface, "")) {
>> +		fastboot_fail("block interface isn't provided", response);
>> +		return -EINVAL;
>> +	}
>> +
>> +	*dev_desc = blk_get_dev(interface, device);
>> +	if (!dev_desc) {
>> +		fastboot_fail("no such device", response);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
>> +	if (ret < 0)
>> +		fastboot_fail("failed to get partition info", response);
>> +
>> +	return ret;
>> +}
>> +
>> +void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_name,
>> +				   char *response)
>> +{
>> +	lbaint_t written;
>> +
>> +	debug("Start Erasing %s...\n", disk_name);
>> +
>> +	written = fb_block_write(dev_desc, 0, dev_desc->lba, NULL);
>> +	if (written != dev_desc->lba) {
>> +		pr_err("Failed to erase %s\n", disk_name);
>> +		fastboot_response("FAIL", response, "Failed to erase %s", disk_name);
>> +		return;
>> +	}
>> +
>> +	printf("........ erased " LBAFU " bytes from '%s'\n",
>> +	       dev_desc->lba * dev_desc->blksz, disk_name);
>> +	fastboot_okay(NULL, response);
>> +}
>> +
>> +void fastboot_block_raw_erase(struct blk_desc *dev_desc, struct disk_partition *info,
>> +			      const char *part_name, uint alignment, char *response)
>> +{
>> +	lbaint_t written, blks_start, blks_size;
>> +
>> +	if (alignment) {
>> +		blks_start = (info->start + alignment - 1) & ~(alignment - 1);
>> +		if (info->size >= alignment)
>> +			blks_size = (info->size - (blks_start - info->start)) &
>> +				(~(alignment - 1));
>> +		else
>> +			blks_size = 0;
>> +
>> +		printf("Erasing blocks " LBAFU " to " LBAFU " due to alignment\n",
>> +		       blks_start, blks_start + blks_size);
>> +	} else {
>> +		blks_start = info->start;
>> +		blks_size = info->size;
>> +	}
>> +
>> +	written = fb_block_write(dev_desc, blks_start, blks_size, NULL);
>> +	if (written != blks_size) {
>> +		fastboot_fail("failed to erase partition", response);
>> +		return;
>> +	}
>> +
>> +	printf("........ erased " LBAFU " bytes from '%s'\n",
>> +	       blks_size * info->blksz, part_name);
>> +	fastboot_okay(NULL, response);
>> +}
>> +
>> +void fastboot_block_erase(const char *part_name, char *response)
>> +{
>> +	struct blk_desc *dev_desc;
>> +	struct disk_partition part_info;
>> +
>> +	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
>> +		return;
>> +
>> +	fastboot_block_raw_erase(dev_desc, &part_info, part_name, 0, response);
>> +}
>> +
>> +void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_name,
>> +				   void *buffer, u32 download_bytes, char *response)
>> +{
>> +	lbaint_t blkcnt;
>> +	lbaint_t blks;
>> +
>> +	/* determine number of blocks to write */
>> +	blkcnt = ((download_bytes + (dev_desc->blksz - 1)) & ~(dev_desc->blksz - 1));
>> +	blkcnt = lldiv(blkcnt, dev_desc->blksz);
>> +
>> +	if (blkcnt > dev_desc->lba) {
>> +		pr_err("too large for disk: '%s'\n", disk_name);
>> +		fastboot_fail("too large for disk", response);
>> +		return;
>> +	}
>> +
>> +	puts("Flashing Raw Image\n");
> 
> Can't we use printf() here for consistency in the code?

Ack

> 
>> +
>> +	blks = fb_block_write(dev_desc, 0, blkcnt, buffer);
>> +
>> +	if (blks != blkcnt) {
>> +		pr_err("failed writing to %s\n", disk_name);
>> +		fastboot_fail("failed writing to device", response);
>> +		return;
>> +	}
>> +
>> +	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * dev_desc->blksz,
>> +	       disk_name);
>> +	fastboot_okay(NULL, response);
>> +}
>> +
>> +void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
>> +				    struct disk_partition *info, const char *part_name,
>> +				    void *buffer, u32 download_bytes, char *response)
>> +{
>> +	lbaint_t blkcnt;
>> +	lbaint_t blks;
>> +
>> +	/* determine number of blocks to write */
>> +	blkcnt = ((download_bytes + (info->blksz - 1)) & ~(info->blksz - 1));
>> +	blkcnt = lldiv(blkcnt, info->blksz);
>> +
>> +	if (blkcnt > info->size) {
>> +		pr_err("too large for partition: '%s'\n", part_name);
>> +		fastboot_fail("too large for partition", response);
>> +		return;
>> +	}
>> +
>> +	puts("Flashing Raw Image\n");
> 
> Can't we use printf() here for consistency in the code?
> 
>> +
>> +	blks = fb_block_write(dev_desc, info->start, blkcnt, buffer);
>> +
>> +	if (blks != blkcnt) {
>> +		pr_err("failed writing to device %d\n", dev_desc->devnum);
>> +		fastboot_fail("failed writing to device", response);
>> +		return;
>> +	}
>> +
>> +	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * info->blksz,
>> +	       part_name);
>> +	fastboot_okay(NULL, response);
>> +}
>> +
>> +void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
>> +				       const char *part_name, void *buffer, char *response)
>> +{
>> +	struct fb_block_sparse sparse_priv;
>> +	struct sparse_storage sparse;
>> +	int err;
>> +
>> +	sparse_priv.dev_desc = dev_desc;
>> +
>> +	sparse.blksz = info->blksz;
>> +	sparse.start = info->start;
>> +	sparse.size = info->size;
>> +	sparse.write = fb_block_sparse_write;
>> +	sparse.reserve = fb_block_sparse_reserve;
>> +	sparse.mssg = fastboot_fail;
>> +
>> +	printf("Flashing sparse image at offset " LBAFU "\n",
>> +	       sparse.start);
>> +
>> +	sparse.priv = &sparse_priv;
>> +	err = write_sparse_image(&sparse, part_name, buffer,
>> +				 response);
>> +	if (!err)
>> +		fastboot_okay(NULL, response);
>> +}
>> +
>> +void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>> +				u32 download_bytes, char *response)
>> +{
>> +	struct blk_desc *dev_desc;
>> +	struct disk_partition part_info;
>> +
>> +	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
>> +		return;
>> +
>> +	if (is_sparse_image(download_buffer)) {
>> +		fastboot_block_write_sparse_image(dev_desc, &part_info, part_name,
>> +						  download_buffer, response);
>> +	} else {
>> +		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
>> +					       download_buffer, download_bytes, response);
>> +	}
>> +}
>> diff --git a/include/fb_block.h b/include/fb_block.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..cfc824214acb515a0cc2f13fd786c606c6141489
>> --- /dev/null
>> +++ b/include/fb_block.h
>> @@ -0,0 +1,104 @@
>> +/* SPDX-License-Identifier: BSD-2-Clause */
> 
> Same here for the licence.
> 
> 
>> +/*
>> + * Copyright (C) 2024 The Android Open Source Project
>> + */
>> +
>> +#ifndef _FB_BLOCK_H_
>> +#define _FB_BLOCK_H_
>> +
>> +struct blk_desc;
>> +struct disk_partition;
>> +
>> +/**
>> + * fastboot_block_get_part_info() - Lookup block partition by name
>> + *
>> + * @part_name: Named partition to lookup
>> + * @dev_desc: Pointer to returned blk_desc pointer
>> + * @part_info: Pointer to returned struct disk_partition
>> + * @response: Pointer to fastboot response buffer
> 
> The doc is missing a Return: section where we specify the return code.


Ack

> 
>> + */
>> +int fastboot_block_get_part_info(const char *part_name,
>> +				 struct blk_desc **dev_desc,
>> +				 struct disk_partition *part_info,
>> +				 char *response);
>> +
>> +/**
>> + * fastboot_block_raw_erase() - Erase raw block device partition
>> + *
>> + * @dev_desc: Block device we're going write to
>> + * @info: Partition we're going write to
>> + * @part_name: Name of partition we're going write to
>> + * @alignment: erase start and size alignment, specify 0 to ignore
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_raw_erase(struct blk_desc *dev_desc, struct disk_partition *info,
>> +			      const char *part_name, uint alignment, char *response);
>> +
>> +/**
>> + * fastboot_block_raw_erase_disk() - Erase raw block device
>> + *
>> + * @dev_desc: Block device we're going write to
>> + * @disk_name: Name of disk we're going write to
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_name,
>> +				   char *response);
>> +
>> +/**
>> + * fastboot_block_erase() - Erase partition on block device for fastboot
>> + *
>> + * @part_name: Named partition to erase
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_erase(const char *part_name, char *response);
>> +
>> +/**
>> + * fastboot_block_write_raw_disk() - Write raw image to block device
>> + *
>> + * @dev_desc: Block device we're going write to
>> + * @disk_name: Name of disk we're going write to
>> + * @buffer: Downloaded buffer pointer
>> + * @download_bytes: Size of content on downloaded buffer pointer
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_name,
>> +				   void *buffer, u32 download_bytes, char *response);
>> +
>> +/**
>> + * fastboot_block_write_raw_image() - Write raw image to block device partition
>> + *
>> + * @dev_desc: Block device we're going write to
>> + * @info: Partition we're going write to
>> + * @part_name: Name of partition we're going write to
>> + * @buffer: Downloaded buffer pointer
>> + * @download_bytes: Size of content on downloaded buffer pointer
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
>> +				    struct disk_partition *info, const char *part_name,
>> +				    void *buffer, u32 download_bytes, char *response);
>> +
>> +/**
>> + * fastboot_block_write_sparse_image() - Write sparse image to block device partition
>> + *
>> + * @dev_desc: Block device we're going write to
>> + * @info: Partition we're going write to
>> + * @part_name: Name of partition we're going write to
>> + * @buffer: Downloaded buffer pointer
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
>> +				       const char *part_name, void *buffer, char *response);
>> +
>> +/**
>> + * fastboot_block_flash_write() - Write image to block device for fastboot
>> + *
>> + * @part_name: Named partition to write image to
>> + * @download_buffer: Pointer to image data
>> + * @download_bytes: Size of image data
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>> +				u32 download_bytes, char *response);
>> +
>> +#endif // _FB_BLOCK_H_
>>
>> -- 
>> 2.34.1

