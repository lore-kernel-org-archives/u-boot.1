Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3004FC3601A
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7ADE82006;
	Tue,  1 Apr 2025 10:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VdTMpHsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECD982012; Tue,  1 Apr 2025 10:45:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08F481FEE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so49690975e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743497105; x=1744101905; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Z0VKXzHnuGEbxkQYTAon4RpSsIhJXDf7cRtYne1i0ZE=;
 b=VdTMpHsVaGUhRkAPM1rYOHXY26h9N8alQ8qie6g7sab4D4hEi36LoGXdHJmBMyKvmZ
 K4dyvPsfpL09qItwudxvBbdvbMoBf9mef236Mo8UxfBX8Mv28ruWtbzn2ychqBMnsc8A
 gzQSg8KLtu38KkQHkeeO9JT2do14PuedraISy8kUBHwFIpa+BToq8T+f/spOsl9vZRIF
 SDI9NvdsFGcAJ8RgMmjTV61frPfZ6QeqGBmYpS2xrMT1S1Cqo2d/giXMLjGs7BTVtWdf
 jC2AMZI4jHBtz6x2ue68jPVAGwJoREXFZEWhfbjzS9OBrhCf1Puhh26WGpjqk183VbXh
 f2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743497105; x=1744101905;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z0VKXzHnuGEbxkQYTAon4RpSsIhJXDf7cRtYne1i0ZE=;
 b=Tw6F6xSoDMhDP1sECS4P5KiEYkVlm4dC+G2hKmcCXcDlRPTU/SCcixgUvhXo8MmjWm
 s0gd24bswpyJdW/xFKP4ruqYj4hdtJFawseq4AJ6dpcWRRReaqHzMlWwa64rBz2ujDcb
 MP2Q9vbnHBDDaeSnvrCQnTDaAm/+hY7gIHempv3BgmhF6wg2uXKySvtEvdWXLUolw2V5
 zJ7In0aXw6cU5bvuaVRz7oh3cjHgGkSd9eczoRpxy7mxHXZAPPa2gQj95GjvKRl0sBGa
 9iZpe/JN0s38hZlQges5q2u94ya4Rt9M0uNwFGT5LIwS00KkKb1eS26weLUsFGMQ2CIh
 T10Q==
X-Gm-Message-State: AOJu0YwHzLnLdYPguXLvVkPYFDmnOYqUTD9Jn3yEzHbNUmA88YlyLr+s
 5xlfAkbsZS+ITgwLoHIIenEmOvrm+7Jc7MJ3jWpwXSrIrKnt8qqEIgbjoEr9U6DPkTe3CajlDjD
 G
X-Gm-Gg: ASbGncvPk8AS3TT7UjTna8AZoqe7bu622iFEpRga/JjwyI1GTlaNrTYgTAu/utGDOd/
 kirubRM8b4re+UDhRjxsjBFLTAADv+HJROy/ZaVlTcm526zE+tjAaoWqdR1PMZjyQLZtTZx9j5A
 Ywgep+XBWZqkcU0Dk3OdB5hMQ7cJr9XJmOV8IlztzWIpJ9VHbQMUtz2GtNKF/MFsqojAFnkZANH
 V9FSeBVjxb+Ki1cOqj5HrFPmzU7zX/dBZUtf84c6P3E6emUHejLhgYj7PtMHjaCWDxWFDuCQ850
 hMGMa/HQeCzF0aCqVSAhK7vyOs9kDLSho7u8/36fEZHB1MDFGYSkOAyDvO8B1RcAVScurH/Zx8T
 1o1IJZNHYR9IEC1R9Hu/tEw==
X-Google-Smtp-Source: AGHT+IEXQBWiHwUmdGq5gh0/kgWCs4ymDeqPZJ5bNbmdgZcpdQMS1vuIs22l/Ws28CwWMOVrZCLH2A==
X-Received: by 2002:a05:600c:4593:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43dbc6f7b3fmr88549575e9.26.1743497105193; 
 Tue, 01 Apr 2025 01:45:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0?
 ([2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dedc2dsm191333745e9.2.2025.04.01.01.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:45:04 -0700 (PDT)
Message-ID: <ab310f36-bec7-42d5-b25f-f3e4d738e26c@linaro.org>
Date: Tue, 1 Apr 2025 10:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] mach-snapdragon: CapsuleUpdate: support all boot
 methods
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
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
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
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

On 26/03/2025 18:40, Caleb Connolly wrote:
> Expand capsule update support to correctly identify which partition
> U-Boot is flashed to (between xbl, uefi, and boot including A/B
> variants).
> 
> Use qcom_boot_source to determine if we were chainloaded from ABL,
> meaning U-Boot is on the boot partition, otherwise we assume uefi if
> it's available, finally leaving the xbl partition.
> 
> Set a different fw_name based on the target partition to prevent GUID
> collisions, since a board may support U-Boot flashed to boot or XBL we
> need to differentiate them since the U-Boot binary must be built
> differently.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/capsule_update.c | 256 +++++++++++++++++++++++-------
>   1 file changed, 203 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> index bf75a9a1b24c714792bae3712b83b96353b1df8f..eedfc40004c06aa6271c685aaca32ccab8f5c491 100644
> --- a/arch/arm/mach-snapdragon/capsule_update.c
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -19,24 +19,21 @@
>   
>   #include "qcom-priv.h"
>   
>   /*
> - * NOTE: for now this implementation only supports the rb3gen2. Supporting other
> - * boards that boot in different ways (e.g. chainloaded from ABL) will require
> - * additional complexity to properly create the dfu string and fw_images array.
> - */
> -
> -/*
> - * To handle different variants like chainloaded U-Boot here we'll need to
> - * build the fw_images array dynamically at runtime. It looks like
> - * mach-rockchip is a good example for how to do this.
> - * Detecting which image types a board uses is TBD, hence for now we only
> - * support the one new board that runs U-Boot as its primary bootloader.
> + * To handle different variants like chainloaded U-Boot here we need to
> + * build the fw_images array dynamically at runtime. These are the possible
> + * implementations:
> + *
> + * - Devices with U-Boot on the uefi_a/b partition
> + * - Devices with U-Boot on the boot (a/b) partition
> + * - Devices with U-Boot on the xbl (a/b) partition
> + *
> + * Which partition actually has U-Boot on it is determined based on the
> + * qcom_boot_source variable and additional logic in find_target_partition().
>    */
>   struct efi_fw_image fw_images[] = {
>   	{
> -		/* U-Boot flashed to the uefi_X partition (e.g. rb3gen2) */
> -		.fw_name = u"UBOOT_UEFI_PARTITION",
>   		.image_index = 1,
>   	},
>   };
>   
> @@ -46,8 +43,14 @@ struct efi_capsule_update_info update_info = {
>   	.num_images = ARRAY_SIZE(fw_images),
>   	.images = fw_images,
>   };
>   
> +enum target_part_type {
> +	TARGET_PART_UEFI = 1,
> +	TARGET_PART_XBL,
> +	TARGET_PART_BOOT,
> +};
> +
>   /* LSB first */
>   struct part_slot_status {
>   	u16: 2;
>   	u16 active : 1;
> @@ -56,37 +59,182 @@ struct part_slot_status {
>   	u16 unbootable : 1;
>   	u16 tries_remaining : 4;
>   };
>   
> -static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, char *name)
> +enum ab_slot {
> +	SLOT_NONE,
> +	SLOT_A,
> +	SLOT_B,
> +};
> +
> +static enum ab_slot get_part_slot(const char *partname)
> +{
> +	int len = strlen(partname);
> +
> +	if (partname[len - 2] != '_')
> +		return SLOT_NONE;
> +	if (partname[len - 1] == 'a')
> +		return SLOT_A;
> +	if (partname[len - 1] == 'b')
> +		return SLOT_B;
> +
> +	return SLOT_NONE;
> +}
> +
> +/*
> + * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
> + * the slot status, and prioritising the uefi partition over xbl if found.

			   prioritizing

> + */
> +static int find_target_partition(int *devnum, enum uclass_id *uclass,
> +				 enum target_part_type *target_part_type)
>   {
>   	int ret;
> -	int partnum;
> +	int partnum, uefi_partnum = -1, xbl_partnum = -1;
>   	struct disk_partition info;
>   	struct part_slot_status *slot_status;
> +	struct udevice *dev = NULL;
> +	struct blk_desc *desc = NULL, *xbl_desc = NULL;
> +	uchar ptn_name[32] = { 0 };
>   
> -	for (partnum = 1;; partnum++) {
> -		ret = part_get_info(blk_dev, partnum, &info);
> -		if (ret)
> -			return ret;
> +	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +		if (device_get_uclass_id(dev) != UCLASS_BLK)
> +			continue;
>   
> -		slot_status = (struct part_slot_status *)&info.type_flags;
> -		log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
> -		       info.name, slot_status->active,
> -		       slot_status->successful, slot_status->unbootable,
> -		       slot_status->tries_remaining);
> -		/*
> -		 * FIXME: eventually we'll want to find the active/inactive variant of the partition
> -		 * but on the rb3gen2 these values might all be 0
> -		 */
> -		if (!strncmp(info.name, partname, strlen(partname))) {
> -			log_debug("Found active %s partition: '%s'!\n", partname, info.name);
> -			strlcpy(name, info.name, sizeof(info.name));
> -			return partnum;
> +		desc = dev_get_uclass_plat(dev);
> +		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
> +			continue;
> +		for (partnum = 1;; partnum++) {
> +			ret = part_get_info(desc, partnum, &info);
> +			if (ret)
> +				break;
> +
> +			slot_status = (struct part_slot_status *)&info.type_flags;
> +
> +			/*
> +			 * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
> +			 * flags might not be set so we assume the A partition unless the B
> +			 * partition is active.
> +			 */
> +			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
> +				/*
> +				 * If U-Boot was chainloaded somehow we can't be flashed to
> +				 * the uefi partition
> +				 */
> +				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
> +					continue;
> +
> +				*target_part_type = TARGET_PART_UEFI;
> +				/*
> +				 * Found an active UEFI partition, this is where U-Boot is
> +				 * flashed.
> +				 */
> +				if (slot_status->active)
> +					goto found;
> +
> +				/* Prefer A slot if it's not marked active */
> +				if (get_part_slot(info.name) == SLOT_A) {
> +					/*
> +					 * If we found the A slot after the B slot (both
> +					 * inactive) then we assume U-Boot is on the A slot.
> +					 */
> +					if (uefi_partnum >= 0)
> +						goto found;
> +
> +					/* Didn't find the B slot yet */
> +					uefi_partnum = partnum;
> +					strlcpy(ptn_name, info.name, 32);
> +				} else {
> +					/*
> +					 * Found inactive B slot after inactive A slot, return
> +					 * the A slot
> +					 */
> +					if (uefi_partnum >= 0) {
> +						partnum = uefi_partnum;
> +						goto found;
> +					}
> +
> +					/*
> +					 * Didn't find the A slot yet. Record that we found the
> +					 * B slot
> +					 */
> +					uefi_partnum = partnum;
> +					strlcpy(ptn_name, info.name, 32);
> +				}
> +				/* xbl and aboot are effectively the same */
> +			} else if ((!strncmp(info.name, "xbl", strlen("xbl")) &&
> +				    strlen(info.name) == 5) ||
> +				    !strncmp(info.name, "aboot", strlen("aboot"))) {
> +				/*
> +				 * If U-Boot was booted via ABL, we can't be flashed to the
> +				 * XBL partition
> +				 */
> +				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
> +					continue;
> +
> +				/*
> +				 * ignore xbl partition if we have uefi partitions, U-Boot will
> +				 * always be on the UEFI partition in this case.
> +				 */
> +				if (*target_part_type == TARGET_PART_UEFI)
> +					continue;
> +
> +				/* Either non-A/B or find the active XBL partition */
> +				if (slot_status->active || !get_part_slot(info.name)) {
> +					/*
> +					 * No quick return since we might find a uefi partition
> +					 * later
> +					 */
> +					xbl_partnum = partnum;
> +					*target_part_type = TARGET_PART_XBL;
> +					xbl_desc = desc;
> +					strlcpy(ptn_name, info.name, 32);
> +				}
> +
> +				/*
> +				 * No fast return since we might also have a uefi partition which
> +				 * will take priority.
> +				 */
> +			} else if (!strncmp(info.name, "boot", strlen("boot"))) {
> +				/* We can only be flashed to boot if we were chainloaded */
> +				if (qcom_boot_source != QCOM_BOOT_SOURCE_ANDROID)
> +					continue;
> +
> +				/*
> +				 * Either non-A/B or find the active partition. We can return
> +				 * immediately here since we've narrowed it down to a single option
> +				 */
> +				if (slot_status->active || !get_part_slot(info.name)) {
> +					*target_part_type = TARGET_PART_BOOT;
> +					goto found;
> +				}
> +			}
>   		}
>   	}
>   
> +	/*
> +	 * Now we've exhausted all options, if we didn't find a uefi partition
> +	 * then we are indeed flashed to the xbl partition.
> +	 */
> +	if (*target_part_type == TARGET_PART_XBL) {
> +		partnum = xbl_partnum;
> +		desc = xbl_desc;
> +		goto found;
> +	}
> +
> +	/* Found no candidate partitions */
>   	return -1;
> +
> +found:
> +	if (desc) {
> +		*devnum = desc->devnum;
> +		*uclass = desc->uclass_id;
> +	}
> +
> +	/* info won't match for XBL hence the copy. */
> +	log_info("Capsule update target: %s (disk %d:%d)\n",
> +		 *target_part_type == TARGET_PART_BOOT ? info.name : ptn_name,
> +		 *devnum, partnum);
> +	return partnum;
>   }
>   
>   /**
>    * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
> @@ -100,14 +248,12 @@ static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, c
>    * in the GPT partition vendor attribute bits.
>    */
>   void qcom_configure_capsule_updates(void)
>   {
> -	struct blk_desc *desc;
>   	int ret = 0, partnum = -1, devnum;
>   	static char dfu_string[32] = { 0 };
> -	char name[32]; /* GPT partition name */
> -	char *partname = "uefi_a";
> -	struct udevice *dev = NULL;
> +	enum target_part_type target_part_type = 0;
> +	enum uclass_id dev_uclass;
>   
>   	if (IS_ENABLED(CONFIG_SCSI)) {
>   		/* Scan for SCSI devices */
>   		ret = scsi_scan(false);
> @@ -116,38 +262,42 @@ void qcom_configure_capsule_updates(void)
>   			return;
>   		}
>   	}
>   
> -	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> -		if (device_get_uclass_id(dev) != UCLASS_BLK)
> -			continue;
> -
> -		desc = dev_get_uclass_plat(dev);
> -		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
> -			continue;
> -		devnum = desc->devnum;
> -		partnum = find_boot_partition(partname, desc,
> -					      name);
> -		if (partnum >= 0)
> -			break;
> -	}
> -
> +	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
>   	if (partnum < 0) {
>   		log_err("Failed to find boot partition\n");
>   		return;
>   	}
>   
> -	switch (desc->uclass_id) {
> +	/*
> +	 * Set the fw_name based on the partition type. This causes the GUID to be different
> +	 * so we will never accidentally flash a U-Boot image intended for XBL to the boot
> +	 * partition.
> +	 */
> +	switch (target_part_type) {
> +	case TARGET_PART_UEFI:
> +		fw_images[0].fw_name = u"UBOOT_UEFI_PARTITION";
> +		break;
> +	case TARGET_PART_XBL:
> +		fw_images[0].fw_name = u"UBOOT_XBL_PARTITION";
> +		break;
> +	case TARGET_PART_BOOT:
> +		fw_images[0].fw_name = u"UBOOT_BOOT_PARTITION";
> +		break;
> +	}
> +
> +	switch (dev_uclass) {
>   	case UCLASS_SCSI:
>   		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
>   		break;
>   	case UCLASS_MMC:
>   		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
>   		break;
>   	default:
> -		debug("Unsupported storage uclass: %d\n", desc->uclass_id);
> +		debug("Unsupported storage uclass: %d\n", dev_uclass);
>   		return;
>   	}
> -	log_debug("boot partition is %s, DFU string: '%s'\n", name, dfu_string);
> +	log_debug("DFU string: '%s'\n", dfu_string);
>   
>   	update_info.dfu_string = dfu_string;
>   }
> 

The logic is complex but looks to be good.

What would happen if we plug an eMMC with conflicting partitions names ?

Is there a way to get the boot media from xBL ?

Anyway, with the typo fix:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
