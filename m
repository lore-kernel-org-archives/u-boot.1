Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC66CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F60E848B0;
	Mon,  1 Jun 2026 15:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nyoLYdK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C851848B0; Mon,  1 Jun 2026 15:52:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E38D84898
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490686877a1so59198095e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780321971; x=1780926771; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WyrJW+N7S4Qi9nR+LDwwqA8i0v1f98E5FlXcpCs5o/E=;
 b=nyoLYdK9wx8SRVUp6QnlAUXlY63Kajk+HmB/4KjxAAEeInmqyXrxff2XElPlVxiiD8
 eZhIHX6EjsmvkMMLEQ9BMwkyMdszaPj0j2qxNLN0YHSMqZjyTcjPAvCXz/OuDWuCjI0U
 2PZCJMjSxspevKymiszAuWdbIn1NbRCxfiAXdID069Kbwa9MOdbLTvgWL6xGzL95tGp/
 llPW/6QUnCU1z+dJ/f9DR4VxPn02nLdOi+66VJIvJVlEAXL3Ce3OkJcroHp2FsyBjJUC
 yUAZCXQjuTaICw0U4giw7mR37S2CU+NTtJs/WigKYk0lt6XWr4v9geZtbwDCL7nONALT
 N9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780321971; x=1780926771;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyrJW+N7S4Qi9nR+LDwwqA8i0v1f98E5FlXcpCs5o/E=;
 b=OwDEZbZiU7wuQVPy+kh9umu0PU5SZ9G0bzi3K+Mb1IEZrHd9Gy1fvZztsplPQROYuO
 ogDgXADU78dogTE0N04expA3MS0da4YjSfYRWQ0tGf6NI01lj6BhqXwYxOsf0VwxjYwI
 2dfTUbSEr4jV+DfB+t9yjQd6hwH3x5J7YyI1WXRxxHN5RfmZB3Fyi6mc3H+fyhrtVTim
 RIi1sivesThzkoHZDqZZC85bbT1QCz5y7GDtEWvCQOnDdo1LPx/Li2KQPpKj9AP5VsX+
 U6pt7RK5OrSE6bOzOnnllfBpdU++KJNucJmXSQeOizXMOhKRD/EUqBP/cyd3RS5eCQew
 bBJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QBbMHMBr3p84qeYsCW7aDdvz+6guXooMAJMM/TXeV6c/QNWmzO0h43e9TJOOeVqzyF3pnhW8=@lists.denx.de
X-Gm-Message-State: AOJu0YwIjDW5BDwhoHEqsCiCayunrpUYXdQAJ/oP2EnL7WD7kcpL2v0q
 LwuQFseNHk/OYy5hK3yGhUKznC/MYlkUyjluIu6ZSEl5PoLT+i+3omX/RKucuPEzR8MD6ilhO8Z
 2TrTJcHw=
X-Gm-Gg: Acq92OFA/lk/3+3JosAO5mYeT9vNMefKlo1pKPRuIs8w6MSAXE4L7B4ZWS+afnwWWY3
 TiDZ6/NF0KBWjrwwKoFfzbTu5rjr+aFqhpT2ZdFWyc2+QhLjyE9jexxE5L0nS4eKM/GPCiXOdtj
 LOMGVjYx8U0qcYMWFvJEsY3W/EArhf8bX+bC7SECzxP8ecFsRggy1dwoBaRe9bQXSa1vLVs60y0
 1oHsyJN43f4OMgCSh1Em1qXNibdAH3mRhpAKoWH9B+wrRdj47lVeFvi5MeERXDZRx1l/TjigVW4
 da/JLUAQaZgrTimtoSNHr76GI8jwLWX+YIunn3AVo0ruWGr+XWspB1BlAQ1k91zlBEgkLYV24P7
 yrU9bPqsFHw23mf2SjRApzR4R4bfeL7/Z+pXAtq9EThXQc4KWhFyLCg/BI+XKWwdXFmqYfpYi7x
 EFtcv1jg9gIgpB7ZaxsthU/gaJcUwY5Zrncmm9FKmXbXeEA/lN4TEEk8WRARaP92IurxqeFKqJa
 qNVKLmBBl3adXbKLA==
X-Received: by 2002:a05:600c:c1d7:10b0:490:b080:4835 with SMTP id
 5b1f17b1804b1-490b08049d6mr413925e9.0.1780321971053; 
 Mon, 01 Jun 2026 06:52:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:16ad:add5:5f53:d8d4?
 ([2a01:e0a:106d:1080:16ad:add5:5f53:d8d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09be7fsm77677355e9.7.2026.06.01.06.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:52:50 -0700 (PDT)
Message-ID: <c0592de2-3310-401e-8a53-ae0812c2d7fc@linaro.org>
Date: Mon, 1 Jun 2026 15:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ufs: add UFS descriptor/configuration utility support
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/1/26 13:26, Raz Ben Yehuda wrote:
> Add a UFS tool implementation for querying, printing, and updating
> UFS descriptors and configuration parameters.
> 
> Features include:
> 
> * Query and print device, geometry, unit, config, and power descriptors
> * Display LUN configuration and calculated capacities
> * Support updating LUN, config, and device descriptor fields
> * Add WriteBooster-related configuration handling
> * Add flag query support for common UFS runtime flags
> * Add commit and clear-all configuration helpers
> * Improve descriptor decoding and formatted debug output
> 
> The tool is intended for U-Boot/UFS debugging, provisioning,
> and configuration workflows.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   drivers/ufs/ufs_tool.c | 1251 ++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs_tool.h |  394 +++++++++++++
>   2 files changed, 1645 insertions(+)
>   create mode 100644 drivers/ufs/ufs_tool.c
>   create mode 100644 drivers/ufs/ufs_tool.h
> 
> diff --git a/drivers/ufs/ufs_tool.c b/drivers/ufs/ufs_tool.c
> new file mode 100644
> index 00000000000..1f5ce85beed
> --- /dev/null
> +++ b/drivers/ufs/ufs_tool.c
> @@ -0,0 +1,1251 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/io.h>
> +#include <dm/devres.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <linux/bitops.h>
> +#include <linux/byteorder/little_endian.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <malloc.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <dm/uclass.h>
> +#include <dm/device.h>
> +
> +#include "ufs.h"
> +#include "ufs_tool.h"
> +#include <ufs.h>
> +
> +#define UFS_DESC_SIZE (unsigned char)0xff
> +
> +static int ufshcd_query_desc_idn_geometry(struct ufs_hba *,
> +					  struct ufs_geometry_descriptor *decs);
> +static int ufshcd_query_desc_idn_config(struct ufs_hba *hba,
> +					struct ufs_config_descriptor *cfg);
> +static int ufshcd_query_desc_idn_device(struct ufs_hba *hba,
> +					struct ufs_device_descriptor *desc);
> +static int ufshcd_query_desc_idn_unit(struct ufs_hba *hba, int lun,
> +				      struct unit_descriptor *desc);
> +
> +static void
> +ufshcd_print_idn_geometry_desc(struct ufs_geometry_descriptor *desc);
> +static void ufshcd_print_device_descriptor(struct ufs_device_descriptor *desc);
> +static void ufshcd_print_unit_descriptor(struct unit_descriptor *desc);
> +static void
> +ufshcd_print_idn_desc_config(struct ufs_config_descriptor *user_cfg,
> +			     struct ufs_geometry_descriptor *geometry,
> +			     u32 b_ud0_base_offset, u32 b_u_dconfig_p_length);
> +
> +static int
> +ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
> +			    struct ufs_power_parameters_descriptor *desc);
> +
> +static void
> +print_ufs_power_parameters(struct ufs_power_parameters_descriptor *desc);
> +
> +static int ufshcd_query_user_flag(struct ufs_hba *hba, const char *flag_name);
> +static int ufshcd_write_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> +				   int desc_index, unsigned char param_offset,
> +				   unsigned char *param_write_buf,
> +				   unsigned char param_size);
> +
> +static struct ufs_config_descriptor g_cfg_desc;
> +
> +struct ufs_hba *ufstool_probe_dev(int index)
> +{
> +	struct udevice *dev;
> +	struct ufs_hba *hba = NULL;
> +
> +	if (!uclass_get_device(UCLASS_UFS, index, &dev))
> +		hba = dev_get_uclass_priv(dev);

Add an empty line before return

> +	return hba;
> +}
> +
> +int ufshcd_query_desc_idn_device(struct ufs_hba *hba,
> +				 struct ufs_device_descriptor *desc)
> +{
> +	int ret;
> +	int param_offset = 0;
> +	int desc_index = 0;	/* LUNS 0-7 controlled by index 0 */
> +
> +	memset(desc, 0x00, sizeof(*desc));
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, desc_index,
> +				     param_offset, (void *)desc,
> +				     UFS_DESC_SIZE);

Drop ret and directly return ufshcd_read_desc_param()

> +	return ret;
> +}
> +
> +void ufshcd_print_device_descriptor(struct ufs_device_descriptor *descriptor)
> +{
> +	u32 val = descriptor->num_shared_write_booster_buffer_allocunits;
> +
> +	printf("--- UFS Device Descriptor (IDN: 00h %ld) ---\n",
> +	       sizeof(struct ufs_device_descriptor));
> +
> +	printf(" Name | Value | Description\n");
> +	printf("-----------------------------------------------------------\n");
> +	/* Descriptor Header (Offset 00h – 01h) */
> +	printf("Length | 0x%x\n", descriptor->length);
> +	printf("DescriptorIdn | 0x%x\n", descriptor->descriptor_idn);
> +
> +	/* Device Identification & Core configuration (Offset 02h – 0Dh) */
> +	printf("Device | 0x%x\n", descriptor->device);
> +	printf("DeviceClass | 0x%x\n", descriptor->device_class);
> +	printf("DeviceSubClass | 0x%x\n", descriptor->device_sub_class);
> +	printf("protocol | 0x%x\n", descriptor->protocol);
> +	printf("NumberLu | %d\n", descriptor->number_lu);
> +	printf("NumberWLu | %d\n", descriptor->number_wlu);
> +	printf("BootEnable | 0x%x\n", descriptor->boot_enable);
> +	printf("DescrAccessEn | 0x%x\n", descriptor->descr_access_en);
> +	printf("InitPowerMode | 0x%x\n", descriptor->init_power_mode);
> +	printf("highPriorityLun | 0x%x\n",
> +	       descriptor->high_priority_lun);
> +	printf("SecureRemovalType | 0x%x\n",
> +	       descriptor->secure_removal_type);
> +	printf("SecurityLu | 0x%x\n", descriptor->security_lu);
> +
> +	/* power Management, Version & Pointers (Offset 0Eh – 2Ah) */
> +	printf("b_background_ops_term_lat | 0x%x\n",
> +	       descriptor->background_ops_term_lat);
> +	printf("b_init_active_icc_level | 0x%x\n",
> +	       descriptor->init_active_icc_level);
> +	printf("SpecVersion | 0x%x\n",
> +	       __builtin_bswap16(descriptor->spec_version));
> +	printf("ManufactureDate | 0x%x\n", descriptor->manufacture_date);
> +	printf("ManufacturerName | 0x%x\n", descriptor->manufacturer_name);
> +	printf("ProductName | 0x%x\n", descriptor->product_name);
> +	printf("SerialNumber | 0x%x\n", descriptor->serial_number);
> +	printf("OEMId | 0x%x\n", descriptor->oem_id);
> +	printf("ManufacturerId | 0x%x\n", descriptor->manufacturer_id);
> +	printf("Ud0BaseOffset | %d\n", descriptor->ud0_base_offset);
> +	printf("DConfigLength | %d\n",
> +	       descriptor->config_length);
> +	printf("DeviceRttCap | 0x%x\n", descriptor->device_rtt_cap);
> +	printf("PeriodicRtcUpdate | 0x%x\n",
> +	       descriptor->periodic_rtc_update);
> +	printf("UfsFeaturesSupport | 0x%x\n",
> +	       descriptor->ufs_features_support);
> +	printf("FfuTimeout | %d\n", descriptor->ffu_timeout);
> +	printf("QueueDepth | %d\n", descriptor->queue_depth);
> +	printf("DeviceVersion | 0x%x\n", descriptor->device_version);
> +	printf("NumSecureWpArea | 0x%x\n",
> +	       descriptor->num_secure_wp_area);
> +	printf("PsaMaxDataSize | 0x%x\n",
> +	       descriptor->psa_max_data_size);
> +	printf("PsaStateTimeout | 0x%x\n",
> +	       descriptor->psa_state_timeout);
> +	printf("ProductRevisionLevel | 0x%x\n",
> +	       descriptor->product_revision_level);
> +
> +	/* Extended Features (Offset 4Fh – 58h) */
> +	printf("ExtendedUfsFeaturesSupport ");
> +	printf("| 0x%x |(includes  WriteBooster/Throttling)\n",
> +	       be32_to_cpu(descriptor->extended_ufs_features_support));
> +
> +	printf("WriteBoosterBufferPreserveUserSpaceEn");
> +	printf("| 0x%x | Preserve User Space mode for WriteBooster Buffer\n",
> +	       descriptor->write_booster_buffer_preserve_user_space_en);
> +
> +	printf("write booster buffer type");
> +	printf("| 0x%x | WriteBooster Buffer Type",
> +	       descriptor->write_booster_buffer_type);
> +	puts("(00h: LU dedicated, 01h: shared)\n");
> +
> +	printf("NumSharedWriteBooster_buffer_allocunits |");
> +	printf("%d | Shared WriteBooster Buf size (in Allocation units)\n",
> +	       be32_to_cpu(val));
> +}
> +
> +int ufshcd_query_desc_idn_geometry(struct ufs_hba *hba,
> +				   struct ufs_geometry_descriptor *desc)
> +{
> +	int param_offset = 0;
> +	int desc_index = 0;
> +
> +	memset(desc, 0xc, sizeof(*desc));

Can you explain why you memset with 0xc ?

> +	return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, desc_index,
> +				      param_offset, (void *)desc,
> +				      QUERY_DESC_GEOMETRY_DEF_SIZE);
> +}
> +
> +void ufshcd_print_idn_geometry_desc(struct ufs_geometry_descriptor *desc)
> +{
> +	u64 cap = be64_to_cpu(desc->total_raw_device_capacity);
> +
> +	cap = ((cap << 9) >> 30);
> +
> +	printf("--- UFS geometry Descriptor (IDN: 07h) ---\n");
> +	printf(" Name   | Value              | Description\n");
> +	printf("-------------------------------------------------------\n");
> +
> +	/* Header and Core Capacity (Offset 00h - 0Ch) */
> +	printf("Length | 0x%x  | Size of descriptor\n", desc->length);
> +	printf("DescriptorIdn   | 0x%x | geometry Descriptor ID\n",
> +	       desc->descriptor_idn);
> +	printf("MediaTechnology | 0x%x | Reserved (00h)\n",
> +	       desc->media_technology);
> +
> +	printf("TotalRawDeviceCapacity | %lld GB\n", cap);
> +
> +	printf("MaxNumberLu | %d | Max LUs (00h: 8, 01h: 32)\n",
> +	       desc->max_number_lu);
> +
> +	/* Segment and Allocation unit constraints (Offset 0Dh - 12h) */
> +	printf("SegmentSize | %d | Segment size (512B units)\n",
> +	       be32_to_cpu(desc->segment_size));
> +
> +	printf("AllocationunitSize | %d | Alloc unit size (in segments)\n",
> +	       desc->allocationunit_size);
> +
> +	printf("MinAddrBlockSize | %d | Min addressable block size\n",
> +	       desc->min_addr_block_size);
> +
> +	/* Performance and Buffer parameters (Offset 13h - 17h) */
> +	printf("OptimalReadBlockSize");
> +	printf("| %d | Optimal read size (512B units)\n",
> +	       desc->optimal_read_block_size);
> +
> +	printf("OptimalWriteBlockSize ");
> +	printf("| 0x%x | Optimal write size (512B units)\n",
> +	       desc->optimal_write_block_size);
> +
> +	printf("MaxInBufferSize | 0x%x | Max Data-In buffer (512B units)\n",
> +	       desc->max_in_buffer_size);
> +
> +	printf("MaxOutBufSize | 0x%x | Max Data-Out buffer (512B)\n",
> +	       desc->max_out_buffer_size);
> +
> +	printf("bRPMBReadWriteSize | 0x%x | Max RPMB frames per command\n",
> +	       desc->rpmb_read_write_size);
> +
> +	/* Feature Support Bitmaps (Offset 18h - 1Fh) */
> +	printf("DynamicCapacityResourcePolicy| 0x%x |",
> +	       desc->dynamic_capacity_resource_policy);
> +
> +	printf("00h: per LU, 01h: per Memory Type\n");
> +	printf("DataOrdering | 0x%x | 01h: Out-of-order supported\n",
> +	       desc->data_ordering);
> +	printf("MaxContexIdNumber | 0x%x | Max supported contexts (min 5)\n",
> +	       desc->max_contex_id_number);
> +
> +	printf("SysDataTagUnitSize | 0x%x | System data tag granularity\n",
> +	       desc->sys_data_tagunit_size);
> +
> +	printf("SysDataTagResSize  | 0x%x | Max area for tagged system data\n",
> +	       desc->sys_data_tag_res_size);
> +
> +	printf("SupportedSecRTypes | 0x%x | Supported secure removal types\n",
> +	       desc->supported_sec_r_types);
> +
> +	printf("SupportedMemoryTypes | 0x%x | Bitmap of memory types\n",
> +	       be16_to_cpu(desc->supported_memory_types));
> +	/*
> +	 * Memory Type Specific Capacities and Adjustment Factors
> +	 */
> +	printf("SystemCodeMaxNAlloc | 0x%x | Max Alloc units\n",
> +	       desc->system_code_max_n_alloc_u);
> +
> +	printf("SystemCodeCapAdjFac | 0x%x | cap_adj_factor: System Code\n",
> +	       desc->system_code_cap_adj_fac);
> +
> +	printf("NonPersistMaxNAlloc | 0x%x | Max Alloc units: Non-Persist\n",
> +	       desc->non_persist_max_n_alloc_u);
> +
> +	printf("NonPersistCapAdjFac   | 0x%x | cap_adj_factor: Non-Persist\n",
> +	       desc->non_persist_cap_adj_fac);
> +
> +	printf("Enhanced1MaxNAlloc | %d | Max Alloc units: Enhanced 1\n",
> +	       be32_to_cpu(desc->enhanced1_max_n_alloc_u));
> +
> +	printf("Enhanced1CapAdjFac | %d | cap_adj_factor: Enhanced 1\n",
> +	       be16_to_cpu(desc->enhanced1_cap_adj_fac));
> +
> +	printf("Enhanced2MaxNAlloc_u | %d | Max Alloc units: Enhanced 2\n",
> +	       be32_to_cpu(desc->enhanced2_max_n_alloc_u));
> +
> +	printf("Enhanced2CapAdjFac | %d | cap_adj_factor: Enhanced 2\n",
> +	       be16_to_cpu(desc->enhanced2_cap_adj_fac));
> +	printf("Enhanced3MaxNAlloc | %d | Max Alloc units: Enhanced 3\n",
> +	       be32_to_cpu(desc->enhanced3_max_n_alloc_u));
> +
> +	printf("Enhanced3CapAdjFac | %d | cap_adj_factor: Enhanced 3\n",
> +	       be32_to_cpu(desc->enhanced3_cap_adj_fac));
> +
> +	printf("Enhanced4MaxNAlloc | %d | Max Alloc units: Enhanced 4\n",
> +	       be32_to_cpu(desc->enhanced4_max_n_alloc_u));
> +
> +	printf("Enhanced4CapAdjFac | %d | cap_adj_factor: Enhanced 4\n",
> +	       be16_to_cpu(desc->enhanced4_cap_adj_fac));
> +
> +	/* Performance and WriteBooster (Offset 44h - 56h) */
> +	printf("OptimalLogicalBlockSize | %d | Optimal Blk Size per type\n",
> +	       be32_to_cpu(desc->optimal_logical_block_size));
> +
> +	printf("WriteBoosterBufferMaxNAllocunits");
> +	printf("| %d | Max tot WB buf size\n",
> +	       be32_to_cpu(desc->write_booster_buffer_max_alloc_units));
> +
> +	printf("DeviceMaxWriteBoosterLus ");
> +	printf("| %d | Max LUs supporting WB (MDV:1)\n",
> +	       desc->device_max_write_booster_lus);
> +
> +	printf("WriteBoosterBufferCapAdjFac");
> +	printf("| %d | WB Capacity Adjustment Factor\n",
> +	       desc->write_booster_buffer_capadjfac);
> +
> +	printf("SupportedwbBufferUserSpaceReductionType");
> +	printf(" | 0x%x | Reduction/Preserve mode support\n",
> +	       desc->supported_write_booster_buffer_userspace_reduction_types);
> +
> +	printf("SupportedWriteBoosterBufferTypes");
> +	printf("| 0x%x | 00h: LU based, 01h: Shared\n",
> +	       desc->supported_write_booster_buffer_types);
> +}
> +
> +void ufshcd_print_config_descriptor(const struct config_descriptor *cd)
> +{
> +	if (!cd)
> +		return;
> +
> +	printf("Config Descriptor:\n");
> +
> +	printf("Length                          : 0x0%x\n", cd->length);
> +	printf("DescriptorIdn                   : 0x0%x\n",
> +	       cd->descriptor_idn);
> +	printf("ConfDescContinue                : 0x0%x\n",
> +	       cd->conf_desc_continue);
> +
> +	printf("BootEnable                      : 0x0%x\n",
> +	       cd->boot_enable);
> +	printf("DescrAccess_en                   : 0x0%x\n",
> +	       cd->descr_access_en);
> +	printf("InitPowerMode                   : 0x0%x\n",
> +	       cd->initpower_mode);
> +	printf("HighPriorityLun                 : 0x0%x\n",
> +	       cd->high_priority_lun);
> +	printf("SecureRemovalType               : 0x0%x\n",
> +	       cd->secure_removal_type);
> +	printf("InitActiveIccLevel              : 0x0%x\n",
> +	       cd->init_active_icc_level);
> +	printf("PeriodicRtcUpdate               : 0x0%x\n",
> +	       cd->periodic_rtc_update);
> +	printf("Reserved_HPB                    : 0x0%x\n",
> +	       cd->reserved_HPB);
> +
> +	printf("RpmbRegionEnable                : 0x0%x\n",
> +	       cd->rpmb_region_enable);
> +	printf("RpmbRegion1Size                 : 0x0%x\n",
> +	       cd->rpmb_region1_size);
> +	printf("RpmbRegion2Size                 : 0x0%x\n",
> +	       cd->rpmb_region2_size);
> +	printf("RpmbRegion3Size                 : 0x0%x\n",
> +	       cd->rpmb_region3_size);
> +
> +	printf("WriteBoosterBufferPreserveUserSpaceEN : 0x0%x\n",
> +	       cd->write_booster_buffer_preserve_user_space_en);
> +	printf("WriteBoosterBufferType           : 0x0%x\n",
> +	       cd->write_booster_buffer_type);
> +	printf("NumSharedWriteBoosterBufferAllocUnits : 0x0%x\n",
> +	       cd->num_shared_write_booster_buffer_allocunits);
> +}
> +
> +int ufshcd_query_desc_idn_config(struct ufs_hba *hba,
> +				 struct ufs_config_descriptor *user_cfg)
> +{
> +	int ret;
> +	int param_offset = 0;
> +	int desc_index = 0;
> +
> +	ret =
> +	    ufshcd_read_desc_param(hba, QUERY_DESC_IDN_CONFIGURATION,
> +				   desc_index, param_offset, (void *)user_cfg,
> +				   QUERY_DESC_CONFIGURATION_DEF_SIZE);

The alignment is wrong, it should be:

ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_CONFIGURATION,
			desc_index, param_offset, (void *)user_cfg,
			QUERY_DESC_CONFIGURATION_DEF_SIZE);

it you don't want to go pass 80cols, but up tp 100colums is allowed.

> +	if (ret)
> +		printf("Failed to read config\n");

Use log.h infrastruture to handle errors and use log_err() here.

and

Add empty line before return

> +	return ret;
> +}
> +
> +void ufshcd_print_unit_param_descriptor(struct ufs_unit_configurable_parameters
> +					*unit)
> +{
> +	/* Header segment (Offset 00h - 03h) */
> +	printf("LuEnable  | 0x%x  | Enabled, 00h: Disabled\n",
> +	       unit->lu_enable);
> +	printf("BootLunId | 0x%x  | Boot LU A, 02h: Boot LU B\n",
> +	       unit->boot_lun_id);
> +	printf("LuWriteProtect | 0x%x | power-on, 02h: Permanent\n",
> +	       unit->lu_write_protect);
> +	printf("MemoryType| 0x%x | Normal, 01h: System Code\n",
> +	       unit->memory_type);
> +	/* Allocation and Sizing (Offset 04h - 0Ah) */
> +	printf("NumAllocunits | %d | Number of Allocation units for LU\n",
> +	       be32_to_cpu(unit->num_allocunits));
> +	printf("DataReliability | 0x%x | power failure protection\n",
> +	       unit->data_reliability);
> +	printf("LogicalBlockSize | 0x%x | Block size exponent (Min: 0Ch)\n",
> +	       unit->logical_block_size);
> +	printf("ProvisioningType | 0x%x | Full, 02h/03h: Thin\n",
> +	       unit->provisioning_type);
> +
> +	/* Context and HPB (Offset 0Bh - 15h) */
> +	puts("ContextCapabilities");
> +	printf("	| 0x%x | LU Context support/multipliers\n",
> +	       unit->context_capabilities);
> +	/* printf("Reserved  | --   | Reserved\n"); */
> +	/* printf("Reserved (HPB) | -- | Reserved for HPB Extension\n"); */
> +	/* WriteBooster (Offset 16h) */
> +	printf("LuNumWriteBoosterBufferAllocunits");
> +	printf("| 0x%x | WB Buffer size (LUs 0-7 only)\n",
> +	       unit->lu_num_write_booster_buffer_allocunits);
> +}
> +
> +void ufshcd_clearall_luns(struct ufs_config_descriptor *user_cfg,
> +			  u32 base_offset, u32 config_length)
> +
> +{
> +	int i;
> +	int off;
> +	u8 *config = (u8 *)user_cfg;
> +	struct ufs_unit_configurable_parameters *unit;

Use the reverse christmas order for variables:

 > +	struct ufs_unit_configurable_parameters *unit;
 > +	u8 *config = (u8 *)user_cfg;
 > +	int off;
 > +	int i;

> +
> +	for (i = 0; i < 8; i++) {
> +		off = base_offset + (i * config_length);
> +
> +		unit = (struct ufs_unit_configurable_parameters *)&config[off];
> +
> +		unit->num_allocunits = cpu_to_be32(0);
> +		unit->memory_type = 0;
> +		unit->lu_enable = 0;
> +		unit->boot_lun_id = 0;
> +		unit->logical_block_size = 0xC;
> +		unit->data_reliability = 0;
> +		unit->provisioning_type = 0;
> +		unit->context_capabilities = cpu_to_be16(0);
> +		unit->lu_num_write_booster_buffer_allocunits = cpu_to_be32(0);
> +	}
> +}
> +
> +static float calc_lun_capacity(struct ufs_unit_configurable_parameters *unit,
> +			       struct ufs_geometry_descriptor *geometry)
> +{
> +	u16 cap_adj_fac = 1;
> +	float cap_adj_facfl = 1;
> +	u64 lun_capacity;
> +
> +	switch (unit->memory_type) {
> +	case 0:	/* Normal */
> +		cap_adj_fac = 1;
> +		break;
> +	case 1:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->system_code_cap_adj_fac);

Use a single line, you're allowed up to 100cols

> +		break;
> +	case 2:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->non_persist_cap_adj_fac);
> +		break;
> +	case 3:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->enhanced1_cap_adj_fac);
> +		break;
> +	case 4:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->enhanced2_cap_adj_fac);
> +		break;
> +	case 5:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->enhanced3_cap_adj_fac);
> +		break;
> +	case 6:
> +		cap_adj_fac =
> +		    be16_to_cpu(geometry->enhanced4_cap_adj_fac);
> +		break;
> +	default:
> +		printf("ilegal memory type\n");
> +	}
> +
> +	if (unit->memory_type) {
> +		/* See geometry Descriptor/cap_adj_fac in Jedec. */
> +		cap_adj_facfl = (float)(cap_adj_fac / 256.00);
> +	}
> +
> +	lun_capacity = 512 * (u64)be32_to_cpu(unit->num_allocunits) *
> +		    geometry->allocationunit_size *
> +		    (u64)be32_to_cpu(geometry->segment_size);
> +
> +	lun_capacity /= cap_adj_facfl;
> +	u32 mb = (u32)(lun_capacity >> 20);

Directly return (u32)(lun_capacity >> 20) & drop mb

> +	return mb;
> +}
> +
> +void ufs_tool_print_luns(void)
> +{
> +	struct ufs_geometry_descriptor geometry;
> +	struct ufs_config_descriptor config_desc;
> +	struct ufs_device_descriptor device_desc;
> +	struct ufs_hba *hba;
> +	int i;
> +
> +	hba = ufstool_probe_dev(0);
> +	if (!hba) {
> +		printf("ufs_tool: failed to get hba\n");

log_err()

> +		return;
> +	}

Add empty line

> +	if (ufshcd_query_desc_idn_config(hba, &config_desc)) {
> +		printf("Failed to read configuration\n");

log_err()

> +		return;
> +	}
> +
> +	if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
> +		printf("Failed to read 0h\n");

log_err()

> +		return;
> +	}
> +
> +	if (ufshcd_query_desc_idn_geometry(hba, &geometry)) {
> +		printf("Failed to read geometry\n");

log_err()

> +		return;
> +	}
> +
> +	u8 *config = (u8 *)&config_desc;
> +	/* Header */
> +	for (i = 0; i < 8; i++) {
> +		const int COL_WIDTH  = 14;
> +		int off;
> +		char buf[32];
> +		struct ufs_unit_configurable_parameters *unit;
> +
> +		off = device_desc.ud0_base_offset +
> +		      (i * device_desc.config_length);
> +
> +		unit = (struct ufs_unit_configurable_parameters *)&config[off];
> +
> +		if (unit->lu_enable != 1)
> +			continue;
> +
> +		snprintf(buf, sizeof(buf), "LUN %d", i);
> +		printf("| %-*s", COL_WIDTH - 2, buf);
> +	}

Add empty line

> +	printf("|\n");
> +	/* Sizes */
> +	for (i = 0; i < 8; i++) {
> +		int off;
> +		s64 mb;
> +		char size_str[32];
> +		const int COL_WIDTH = 14;
> +		struct ufs_unit_configurable_parameters *unit;

Reverse christmas tree order

> +
> +		off = device_desc.ud0_base_offset +
> +		      (i * device_desc.config_length);
> +
> +		unit = (struct ufs_unit_configurable_parameters *)&config[off];
> +
> +		if (unit->lu_enable != 1)
> +			continue;
> +
> +		mb = calc_lun_capacity(unit, &geometry);
> +
> +		snprintf(size_str, sizeof(size_str), "%lld MB", mb);
> +
> +		printf("| %-*s", COL_WIDTH - 2, size_str);
> +	}
> +	printf("|\n");
> +}
> +
> +static void ufshcd_print_idn_desc_config(struct ufs_config_descriptor *user_cfg,
> +					 struct ufs_geometry_descriptor *geometry,
> +					 u32 base_offset, u32 config_ength)
> +{
> +	int i;
> +	int off;
> +	struct ufs_unit_configurable_parameters *unit;
> +	u8 *config = (u8 *)user_cfg;
> +	u32 mb;

Reverse christmas tree order

> +
> +	ufshcd_print_config_descriptor(&user_cfg->cfg_desc);
> +	for (i = 0; i < 8; i++) {
> +		off = base_offset + (i * config_ength);
> +
> +		unit = (struct ufs_unit_configurable_parameters *)&config[off];
> +		mb = calc_lun_capacity(unit, geometry);
> +		printf("-------------------------------------------------\n");
> +		printf("LUN %d Capacity %d MB\n", i, mb);
> +		printf("Name  | Value      | Description\n");
> +		printf("-------------------------------------------------\n");
> +		ufshcd_print_unit_param_descriptor(unit);
> +	}
> +}
> +
> +/**

Drop /** otherwise it will be interpreted as doc

> + * Decodes and prints a single 16-bit power Parameter Element.
> + * Format based on Table 7.13.
> + */
> +void print_power_element(struct ufs_power_parameter_element desc)
> +{
> +	static const char * const units[] = { "n_a", "u_a", "m_a", "A" };
> +	u16 element = desc.upower_value;
> +
> +	/* Bits [15:14] define the unit */
> +	u8 unit_code = (element >> 14) & 0x03;
> +
> +	/* Bits [9:0] define the maximum current value */
> +	u16 value = element & 0x03FF;

Declare variable on top

> +
> +	printf("%d %s", value, units[unit_code]);
> +}
> +
> +/**

Same here

> + * Print function for UFS power Parameters Descriptor (IDN: 08h).
> + * References: Table 14.16, Table 7.12, and Table 7.13.
> + */
> +void print_ufs_power_parameters(struct ufs_power_parameters_descriptor *desc)
> +{
> +	printf("--- UFS power Parameters Descriptor (IDN: 08h) ---\n");
> +	printf("Descriptor Length: 0x%x (%u bytes)\n", desc->length, desc->length);
> +	printf("Descriptor IDN:    0x%x\n\n", desc->descriptor_idn);
> +
> +	printf("Level | VCC Current | VCCQ Current | VCCQ2 Current\n");
> +	printf("--------------------------------------------------\n");
> +
> +	for (int i = 0; i < 5; i++) {
> +		printf(" %x  | ", i);
> +		/* Accessing the  levels for each supply (VCC, VCCQ, VCCQ2) */
> +		/* Values represent worst-case maximum peak current */
> +		print_power_element(desc->active_icc_levels_vcc[i]);
> +		printf("      | ");
> +		print_power_element(desc->active_icc_levels_vccq[i]);
> +		printf("       | ");
> +		print_power_element(desc->active_icc_levels_vccq2[i]);
> +		printf("\n");
> +	}
> +}
> +
> +int ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
> +				struct ufs_power_parameters_descriptor
> +				*out_desc)
> +{
> +	int ret;
> +	unsigned char Space[QUERY_DESC_POWER_DEF_SIZE];

Reverse christmas tree order

> +
> +	memset(out_desc, 0xFF, sizeof(*out_desc));
> +
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_POWER, lun, 0, Space,
> +				     QUERY_DESC_POWER_DEF_SIZE);
> +
> +	if (ret) {
> +		puts("Err:--- UFS power Descriptor");

log_err()

> +		return ret;
> +	}
> +	memcpy(out_desc, Space, sizeof(*out_desc));

Empty line

> +	return ret;
> +}
> +
> +int ufshcd_query_desc_idn_unit(struct ufs_hba *hba, int lun,
> +			       struct unit_descriptor *out_desc)
> +{
> +	int ret;
> +	unsigned char unit_space[QUERY_DESC_UNIT_DEF_SIZE];
> +	struct unit_descriptor *desc = (struct unit_descriptor *)&unit_space;
> +
> +	memset(desc, 0xFF, sizeof(*desc));
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun, 0,
> +				     (void *)desc, QUERY_DESC_UNIT_DEF_SIZE);
> +	if (ret) {
> +		puts("Err:--- UFS unit Descriptor");

log_err()

> +		return ret;
> +	}
> +	memcpy(out_desc, desc, sizeof(*out_desc));

Empty line

> +	return ret;
> +}
> +
> +void ufshcd_print_unit_descriptor(struct unit_descriptor *desc)
> +{
> +	printf("--- UFS unit Descriptor (IDN: 02h) ---\n");
> +	printf(" Name   | Value              | Description\n");
> +	printf("---------------------------------------------\n");
> +
> +	/* Descriptor Header */
> +	printf("Length | %d    | Size of descriptor\n", desc->length);
> +	printf("DescriptorIdn | 0x%x | unit Descriptor ID\n",
> +	       desc->descriptor_idn);
> +	printf("BunitIndex     | 0x%x | Logical unit Index\n",
> +	       desc->bunit_index);
> +
> +	/* configuration Parameters */
> +	printf("luEnable | 0x%x | LU Enabled (01h) or Disabled (00h)\n",
> +	       desc->lu_enable);
> +	printf("BootLunId | 0x%x| Boot LU ID (01h: A, 02h: B\n",
> +	       desc->boot_lun_id);
> +	printf("luWriteProtect | 0x%x | WP (01h: power-on, 02h: Perm)\n",
> +	       desc->lu_write_protect);
> +	printf("luQueueDepth   | 0x%x | Queue depth (0 if shared)\n",
> +	       desc->lu_queue_depth);
> +	printf("psaSensitive | 0x%x  | Soldering sensitivity indicator\n",
> +	       desc->psa_sensitive);
> +	printf("MemoryType | 0x%x  | Memory type (00h: Normal\n",
> +	       desc->memory_type);
> +	printf("DataReliability | 0x%x | power failure protection enabled\n",
> +	       desc->data_reliability);
> +	printf("LogicalBlockSize| 0x%x | Block size exponent (2^n)\n",
> +	       desc->logical_block_size);
> +	/* Capacity and geometry */
> +	printf("LogicalBlockCount | %d %d | Total addressable blocks\n",
> +	       be32_to_cpu(upper_32_bits(desc->logical_block_count)),
> +	       be32_to_cpu(lower_32_bits(desc->logical_block_count)));
> +	printf("EraseBlockSize | 0x%x | Optimal erase granularity\n",
> +	       desc->erase_block_size);
> +	printf("ProvisioningType | 0x%x | 00h: Full, 02h/03h: Thin\n",
> +	       desc->provisioning_type);
> +	printf("phyMemResourceCount| %d %d  Available physical resources\n",
> +	       lower_32_bits(desc->phy_mem_resource_count),
> +	       upper_32_bits(desc->phy_mem_resource_count));
> +	/* Performance and Extended Features */
> +	printf("ContextCapabilities | 0x%x | Context ID & LU Multiplier\n",
> +	       desc->context_capabilities);
> +	printf("bLargeunitGranularity_M1|");
> +	printf("0x%x | Large unit granularity minus one",
> +	       desc->largeunit_granularity_M1);
> +	puts("Reserved | Reserved for extension standards");
> +	puts("luNumWriteBoosterBufferAllocunits");
> +	printf(" | 0x%x | WB Buffer size in Alloc units\n",
> +	       desc->lu_num_write_booster_buffer_allocunits);
> +}
> +
> +#define str_eq !strcmp

Directly use !strcmp

> +
> +int set_param_field(struct ufs_unit_configurable_parameters *ud,
> +		    const char *name, u32 value)
> +{
> +	if (str_eq(name, "boot_lun_id"))
> +		ud->boot_lun_id = (u8)value;
> +	else if (str_eq(name, "lu_enable"))
> +		ud->lu_enable = (u8)value;
> +	else if (str_eq(name, "lu_write_protect"))
> +		ud->lu_write_protect = (u8)value;
> +	else if (str_eq(name, "memory_type"))
> +		ud->memory_type = (u8)value;
> +	else if (str_eq(name, "data_reliability"))
> +		ud->data_reliability = (u8)value;
> +	else if (str_eq(name, "num_allocunits"))
> +		ud->num_allocunits = cpu_to_be32(value);
> +	else if (str_eq(name, "provisioning_type"))
> +		ud->provisioning_type = (u8)value;
> +	else if (str_eq(name, "context_capabilities"))
> +		ud->context_capabilities = (u16)value;
> +	else if (str_eq(name, "lu_num_write_booster_buffer_allocunits"))
> +		ud->lu_num_write_booster_buffer_allocunits = (u32)value;
> +	else
> +		return -1;
> +	return 0;
> +}
> +
> +int ufshcd_update_lun(struct ufs_hba *hba, int lun,
> +		      const char *field, u32 val)
> +{
> +	int off;
> +	int ret;
> +	u8 *config;
> +	struct ufs_unit_configurable_parameters *unit;
> +	struct ufs_device_descriptor dev_desc;
> +
> +	// Populate descriptor
> +	if (g_cfg_desc.cfg_desc.length == 0 &&
> +	    ufshcd_query_desc_idn_config(hba, &g_cfg_desc))
> +		return -EINVAL;
> +
> +	if (ufshcd_query_desc_idn_device(hba, &dev_desc)) {
> +		printf("Failed to read IDN 0h\n");

log_err()

> +		return -EINVAL;
> +	}
> +
> +	config = (__u8 *)&g_cfg_desc;
> +	off = dev_desc.ud0_base_offset + (lun * dev_desc.config_length);
> +
> +	unit = (struct ufs_unit_configurable_parameters *)&config[off];
> +
> +	unit->logical_block_size = 0xC;
> +	// Always enable the Lun
> +	unit->lu_enable = 1;
> +	// Enable Lun configuration
> +	//g_cfg_desc.cfg_desc.write_booster_buffer_type = 0;
> +
> +	// Now change the required value
> +	if (set_param_field(unit, field, val)) {
> +		printf("ilegal value to set %s\n", field);

log_err()

> +		return -EINVAL;
> +	}
> +	ufshcd_print_unit_param_descriptor(unit);
> +	return ret;
> +}
> +
> +static int ufshcd_write_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> +				   int desc_index, unsigned char param_offset,
> +				   unsigned char *param_write_buf,
> +				   unsigned char param_size)
> +{
> +	int ret;
> +	int buff_len;
> +	int selector = 0;
> +
> +	if (desc_id >= QUERY_DESC_IDN_MAX || !param_size)
> +		return -EINVAL;
> +
> +	buff_len = param_size;
> +	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
> +					    desc_id, desc_index, selector,
> +					    param_write_buf, &buff_len);
> +	if (!ret)
> +		return 0;
> +	printf("Err: desc_id %d desc_index %d, param_offset %d,buflen %d,ret=%d\n",
> +	       (unsigned int)desc_id, desc_index,
> +	       (unsigned int)param_offset, buff_len, ret);

log_err(), and handle the error in the if

> +	return ret;
> +}
> +
> +enum flag_idn ufshcd_get_flag(const char *name)
> +{
> +	if (str_eq(name, "deviceinit"))
> +		return QUERY_FLAG_IDN_FDEVICEINIT;
> +
> +	if (str_eq(name, "permanent_wpe"))
> +		return QUERY_FLAG_IDN_PERMANENT_WPE;
> +
> +	if (str_eq(name, "pwr_on_wpe"))
> +		return QUERY_FLAG_IDN_PWR_ON_WPE;
> +
> +	if (str_eq(name, "bkops_en"))
> +		return QUERY_FLAG_IDN_BKOPS_EN;
> +
> +	if (str_eq(name, "life_span_mode"))
> +		return QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE;
> +
> +	if (str_eq(name, "purge_enable"))
> +		return QUERY_FLAG_IDN_PURGE_ENABLE;
> +
> +	if (str_eq(name, "fphy_resource_removal"))
> +		return QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL;
> +
> +	if (str_eq(name, "busy_rtc"))
> +		return QUERY_FLAG_IDN_BUSY_RTC;
> +
> +	if (str_eq(name, "permanently_disable_fw_update"))
> +		return QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE;
> +
> +	if (str_eq(name, "write_booster_en"))
> +		return QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN;
> +
> +	if (str_eq(name, "wb_buf_flush_en"))
> +		return QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN;
> +
> +	if (str_eq(name, "wb_buf_flush_h8"))
> +		return QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8;
> +	return -1;

Return a proper value like EINVAL

> +}
> +
> +int ufshcd_query_user_flag(struct ufs_hba *hba, const char *flag_name)
> +{
> +	enum flag_idn idn;
> +	bool flag_res;
> +	int ret;
> +
> +	if (!hba) {
> +		printf("invalid hba\n");

log_err()

> +		return -EINVAL;
> +	}
> +
> +	idn = ufshcd_get_flag(flag_name);
> +	if ((int)idn < 0) {
> +		printf("%s invalid\n", __func__);

log_err()

> +		return -EINVAL;
> +	}
> +	ret =
> +	    ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG, idn, &flag_res);

Use single line

> +	if (!ret) {
> +		printf("%s = %x\n", flag_name, flag_res);
> +		return 0;
> +	}
> +	printf("%s idn query failed\n", flag_name);

Switch off, handle the err in the if() and use log_err

> +	return ret;
> +}
> +
> +#define CMD_HELP \
> +		"query:\n" \
> +		"\tDevice desc (0h)\n" \
> +		"\tGeometry desc(7h)\n" \
> +		"\tPower desc (8h)\n" \
> +		"\tUnit desc(2h)\n" \
> +		"\tConfig desc(1h)\n" \
> +		"****************************\n" \
> +		"\n\tset_lun [LUN] (parm)\n" \
> +		"\t\tlu_enable\n" \
> +		"\t\tboot_lun_id\n" \
> +		"\t\tlu_write_protect\n" \
> +		"\t\tmemory_type\n" \
> +		"\t\tdata_reliability\n" \
> +		"\t\tnum_allocunits\n" \
> +		"\t\tlogical_block_size\n" \
> +		"\t\tprovisioning_type\n" \
> +		"\t\tcontext_capabilities\n" \
> +		"\t\tlu_num_write_booster_buffer_allocunits\n\n" \
> +		"****************************\n" \
> +		"\n\tset_dev_desc [parm] [value]\n" \
> +		"\t\tdescriptor_idn\n" \
> +		"\t\tdevice\n" \
> +		"\t\tdevice_class\n" \
> +		"\t\tdevice_sub_class\n" \
> +		"\t\tnumber_lu\n" \
> +		"\t\tboot_enable\n" \
> +		"\t\tdescr_access_en\n" \
> +		"\t\tinit_power_mode\n" \
> +		"\t\thigh_priority_lun\n" \
> +		"\t\tsecure_removal_type\n" \
> +		"\t\tinitactive_icc_level\n" \
> +		"\t\tqueue_depth\n" \
> +		"\t\twrite_booster_buffer_preserve_user_space_en\n" \
> +		"\t\twrite_booster_buffer_type\n" \
> +		"\t\tspec_version\n" \
> +		"\t\tmanufacturer_id\n" \
> +		"\t\tperiodic_rtc_update\n" \
> +		"\t\tdevice_version\n" \
> +		"\t\tpsa_max_data_size\n" \
> +		"\t\textended_ufs_features_support\n" \
> +		"\t\tnum_shared_write_booster_buffer_allocunits\n" \
> +		"\t\twrite_booster_buffer_preserve_user_space_en\n" \
> +		"****************************\n" \
> +		"\n\tset_cfg_desc [parm] [value]\n" \
> +		"\t\tlength\n" \
> +		"\t\tdescriptor_idn\n" \
> +		"\t\tconf_desc_continue\n" \
> +		"\t\tboot_enable\n" \
> +		"\t\tdescr_access_en\n" \
> +		"\t\tinitpower_mode\n" \
> +		"\t\thigh_priority_lun\n" \
> +		"\t\tsecure_removal_type\n" \
> +		"\t\tinit_active_icc_level\n" \
> +		"\t\tperiodic_rtc_update\n" \
> +		"\t\treserved_HPB\n" \
> +		"\t\trpmb_region_enable\n" \
> +		"\t\trpmb_region1_size\n" \
> +		"\t\trpmb_region2_size\n" \
> +		"\t\trpmb_region3_size\n" \
> +		"\t\twrite_booster_buffer_preserve_user_space_en\n" \
> +		"\t\twrite_booster_buffer_type\n" \
> +		"\t\tnum_shared_write_booster_buffer_allocunits\n" \
> +		"****************************\n" \
> +		"\n\tflag [flag name]\n" \
> +		"\t\tdeviceinit\n" \
> +		"\t\tpermanent_wpe\n" \
> +		"\t\tpwr_on_wpe\n" \
> +		"\t\tbkops_en\n" \
> +		"\t\tlife_span_mode\n" \
> +		"\t\tpurge_enable\n" \
> +		"\t\tfphy_resource_removal\n" \
> +		"\t\tbusy_rtc\n" \
> +		"\t\tpermanently_disable_fw_update\n" \
> +		"\t\twrite_booster_en\n" \
> +		"\t\twb_buf_flush_en\n" \
> +		"\t\twb_buf_flush_h8\n" \
> +		"****************************\n" \
> +		"\texamples :\n" \
> +		"\n\nto write lun please\n" \
> +		"\tufs query 0 1\n" \
> +		"\tfix the luns, disable lu_enable\n" \
> +		"\tuse ufs set [LUN] num_allocunits=xxx to set size\n" \
> +		"\tufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000\n" \
> +		"\tufs set_cfg_desc write_booster_buffer_type 1\n" \
> +		"\tufs commit\n"
> +
> +void ufs_tool_help(void)
> +{
> +	puts(CMD_HELP);
> +}
> +
> +void idn_read(struct ufs_hba *hba, int idn, int lun)
> +{
> +	struct ufs_device_descriptor device_desc;
> +	struct unit_descriptor unit_desc;
> +	struct ufs_geometry_descriptor geometry;
> +	struct ufs_power_parameters_descriptor power_desc;
> +
> +	switch (idn) {
> +	case QUERY_DESC_IDN_DEVICE:	/* 0x0 */
> +		if (!ufshcd_query_desc_idn_device(hba, &device_desc))
> +			ufshcd_print_device_descriptor(&device_desc);
> +		break;
> +
> +	case QUERY_DESC_IDN_GEOMETRY:	/* 0x7 */
> +		if (!ufshcd_query_desc_idn_geometry(hba, &geometry)) {
> +			ufshcd_print_idn_geometry_desc(&geometry);
> +			return;
> +		}
> +		printf("Failed to read geometry\n");

log_err()

> +		break;
> +
> +	case QUERY_DESC_IDN_UNIT:	/* 0x2 */
> +		unit_desc.bunit_index = lun;
> +		if (!ufshcd_query_desc_idn_unit(hba, lun, &unit_desc))
> +			ufshcd_print_unit_descriptor(&unit_desc);
> +		break;
> +
> +	case QUERY_DESC_IDN_POWER:
> +		if (!ufshcd_query_desc_idn_power(hba, lun, &power_desc))
> +			print_ufs_power_parameters(&power_desc);
> +		break;
> +
> +	case QUERY_DESC_IDN_CONFIGURATION:	/* 0x1 */
> +		if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
> +			printf("Failed to read IDN 0h\n");
> +			return;
> +		}
> +
> +		if (ufshcd_query_desc_idn_geometry(hba, &geometry)) {
> +			printf("Failed to read geometry\n");

log_err()

> +			return;
> +		}
> +
> +		ufshcd_query_desc_idn_config(hba, &g_cfg_desc);
> +		ufshcd_print_idn_desc_config(&g_cfg_desc, &geometry,
> +					     device_desc.ud0_base_offset,
> +					     device_desc.config_length);
> +		break;
> +
> +	default:
> +		printf("Ilegal IDN %d\n", idn);
> +		ufs_tool_help();
> +	}
> +}
> +
> +static int set_config_desc_field(struct config_descriptor *desc,
> +				 const char *fieldname, u32 value)
> +{
> +	/* --- Descriptor Header & Flow Control --- */
> +	if (!strcmp(fieldname, "length"))
> +		desc->length = (u8)value;
> +	else if (!strcmp(fieldname, "descriptor_idn"))
> +		desc->descriptor_idn = (u8)value;
> +	else if (!strcmp(fieldname, "conf_desc_continue"))
> +		desc->conf_desc_continue = (u8)value;
> +	/* --- Device Descriptor Configurable Parameters --- */
> +	else if (!strcmp(fieldname, "boot_enable"))
> +		desc->boot_enable = (u8)value;
> +	else if (!strcmp(fieldname, "descr_access_en"))
> +		desc->descr_access_en = (u8)value;
> +	else if (!strcmp(fieldname, "initpower_mode"))
> +		desc->initpower_mode = (u8)value;
> +	else if (!strcmp(fieldname, "high_priority_lun"))
> +		desc->high_priority_lun = (u8)value;
> +	else if (!strcmp(fieldname, "secure_removal_type"))
> +		desc->secure_removal_type = (u8)value;
> +	else if (!strcmp(fieldname, "init_active_icc_level"))
> +		desc->init_active_icc_level = (u8)value;
> +	else if (!strcmp(fieldname, "periodic_rtc_update"))
> +		desc->periodic_rtc_update = (u16)value;
> +	else if (!strcmp(fieldname, "reserved_HPB"))
> +		desc->reserved_HPB = (u8)value;
> +	/* --- RPMB Configuration Parameters --- */
> +	else if (!strcmp(fieldname, "rpmb_region_enable"))
> +		desc->rpmb_region_enable = (u8)value;
> +	else if (!strcmp(fieldname, "rpmb_region1_size"))
> +		desc->rpmb_region1_size = (u8)value;
> +	else if (!strcmp(fieldname, "rpmb_region2_size"))
> +		desc->rpmb_region2_size = (u8)value;
> +	else if (!strcmp(fieldname, "rpmb_region3_size"))
> +		desc->rpmb_region3_size = (u8)value;
> +	else if (!strcmp(fieldname,
> +			 "write_booster_buffer_preserve_user_space_en"))
> +		desc->write_booster_buffer_preserve_user_space_en = (u8)value;
> +	else if (!strcmp(fieldname, "write_booster_buffer_type"))
> +		desc->write_booster_buffer_type = (u8)value;
> +	else if (!strcmp(fieldname,
> +			 "num_shared_write_booster_buffer_allocunits"))
> +		desc->num_shared_write_booster_buffer_allocunits =
> +		cpu_to_be32(value);
> +	else
> +		return -1;

Return a proper value like EINVAL

> +	return 0;
> +}
> +
> +static int set_device_desc_field(struct ufs_device_descriptor *dev_desc,
> +				 const char *name, u32 value)
> +{
> +	if (!strcmp(name, "descriptor_idn"))
> +		dev_desc->descriptor_idn = (u8)value;
> +	else if (!strcmp(name, "device"))
> +		dev_desc->device = (u8)value;
> +	else if (!strcmp(name, "device_class"))
> +		dev_desc->device_class = (u8)value;
> +	else if (!strcmp(name, "device_sub_class"))
> +		dev_desc->device_sub_class = (u8)value;
> +	else if (!strcmp(name, "number_lu"))
> +		dev_desc->number_lu = (u8)value;
> +	else if (!strcmp(name, "boot_enable"))
> +		dev_desc->boot_enable = (u8)value;
> +	else if (!strcmp(name, "descr_access_en"))
> +		dev_desc->descr_access_en = (u8)value;
> +	else if (!strcmp(name, "bInitPowerMode"))
> +		dev_desc->init_power_mode = (u8)value;
> +	else if (!strcmp(name, "high_priority_lun"))
> +		dev_desc->high_priority_lun = (u8)value;
> +	else if (!strcmp(name, "secure_removal_type"))
> +		dev_desc->secure_removal_type = (u8)value;
> +	else if (!strcmp(name, "initactive_icc_level"))
> +		dev_desc->init_active_icc_level = (u8)value;
> +	else if (!strcmp(name, "queue_depth"))
> +		dev_desc->queue_depth = (u8)value;
> +	else if (!strcmp(name, "write_booster_buffer_preserve_user_space_en"))
> +		dev_desc->write_booster_buffer_preserve_user_space_en = (u8)value;
> +	else if (!strcmp(name, "write_booster_buffer_type"))
> +		dev_desc->write_booster_buffer_type = (u8)value;
> +	else if (!strcmp(name, "spec_version"))
> +		dev_desc->spec_version = cpu_to_be16(value);
> +	else if (!strcmp(name, "manufacturer_id"))
> +		dev_desc->manufacturer_id = cpu_to_be16(value);
> +	else if (!strcmp(name, "periodic_rtc_update"))
> +		dev_desc->periodic_rtc_update = cpu_to_be16(value);
> +	else if (!strcmp(name, "device_version"))
> +		dev_desc->device_version = cpu_to_be16(value);
> +	else if (!strcmp(name, "psa_max_data_size"))
> +		dev_desc->psa_max_data_size = cpu_to_be32(value);
> +	else if (!strcmp(name, "extended_ufs_features_support"))
> +		dev_desc->extended_ufs_features_support = cpu_to_be32(value);
> +	else if (!strcmp(name, "num_shared_write_booster_buffer_allocunits"))
> +		dev_desc->num_shared_write_booster_buffer_allocunits = be32_to_cpu(value);
> +	else
> +		return -1;

Return a proper value like EINVAL

> +	return 0;
> +}
> +
> +int ufs_tool_set_config_desc(const char *name, u32 value)
> +{
> +	struct ufs_hba *hba = ufstool_probe_dev(0);
> +
> +	if (g_cfg_desc.cfg_desc.length == 0) {
> +		if (ufshcd_query_desc_idn_config(hba, &g_cfg_desc)) {
> +			printf("Failed to read device descriptor\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (set_config_desc_field(&g_cfg_desc.cfg_desc, name, value)) {
> +		printf("Failed to set parameters %s descriptor\n", name);

log_err()

> +		return -EINVAL;
> +	}
> +	ufshcd_print_config_descriptor(&g_cfg_desc.cfg_desc);
> +	return 0;
> +}
> +
> +int ufs_tool_set_device_desc(const char *name, u32 value)
> +{
> +	struct ufs_device_descriptor device_desc;
> +	struct ufs_hba *hba = ufstool_probe_dev(0);
> +	int ret;
> +
> +	if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
> +		printf("Failed to read device descriptor\n");
log_err()

> +		return -EINVAL;
> +	}
> +
> +	if (set_device_desc_field(&device_desc, name, value)) {
> +		printf("Failed to set parameters %s descriptor\n", name);

log_err()

> +		return -EINVAL;
> +	}
> +
> +	ret = ufshcd_write_desc_param(hba, QUERY_DESC_IDN_DEVICE,
> +				      0, 0, (void *)&device_desc,
> +				      UFS_DESC_SIZE);
> +	if (ret) {
> +		printf("Failed to write %s\n", name);

log_err()
> +		return -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +int ufs_tool_commit(void)
> +{
> +	int ret;
> +	u8 *config;
> +	struct ufs_hba *hba = ufstool_probe_dev(0);

Why can't we select the UFS device ?

> +
> +	config = (__u8 *)&g_cfg_desc;
> +	ufshcd_cache_flush(config, QUERY_DESC_UNIT_DEF_SIZE);
> +	ret = ufshcd_write_desc_param(hba,
> +				      QUERY_DESC_IDN_CONFIGURATION,
> +				      0, 0, config,
> +				      g_cfg_desc.cfg_desc.length);
> +
> +	if (ret)
> +		printf("Failed to write Configuration\n");

log_err()

> +	return ret;
> +}
> +
> +int ufs_tool_clearall(void)
> +{
> +	int ret;
> +	u8 *config;
> +	struct ufs_device_descriptor device_desc;
> +	struct ufs_hba *hba = ufstool_probe_dev(0);

Why can't we select the UFS device ?

> +
> +	// Populate descriptor
> +	if (g_cfg_desc.cfg_desc.length == 0 &&
> +	    ufshcd_query_desc_idn_config(hba, &g_cfg_desc)) {
> +		return -EINVAL;
> +	}
> +	config = (__u8 *)&g_cfg_desc;
> +
> +	ufshcd_cache_flush(config, QUERY_DESC_UNIT_DEF_SIZE);
> +	if (ufshcd_query_desc_idn_device(hba, &device_desc)) {
> +		printf("Failed to read IDN 0h\n");
> +		return -1;

Return a proper value

> +	}
> +
> +	ufshcd_clearall_luns(&g_cfg_desc,
> +			     device_desc.ud0_base_offset,
> +			     device_desc.config_length);

The flush should here instead

> +
> +	ret = ufshcd_write_desc_param(hba,
> +				      QUERY_DESC_IDN_CONFIGURATION,
> +				      0, 0, config,
> +				      g_cfg_desc.cfg_desc.length);
> +
> +	if (ret)
> +		printf("Failed to Clear Configuration\n");

log_err()

> +	return ret;
> +}
> +
> +int ufs_tool_set_lun(int lun, const char *parm, u32 val)
> +{
> +	struct ufs_hba *hba = ufstool_probe_dev(0);

Why can't we select the UFS device ?

> +
> +	return ufshcd_update_lun(hba, lun, parm, val);
> +}
> +
> +int ufs_tool_query_flag(const char *flag)
> +{
> +	struct ufs_hba *hba = ufstool_probe_dev(0);

Why can't we select the UFS device ?

> +
> +	return ufshcd_query_user_flag(hba, flag);
> +}
> +
> +int ufs_tool_query(int lun, int idn)
> +{
> +	struct ufs_hba *hba;
> +
> +	hba = ufstool_probe_dev(0);

Why can't we select the UFS device ?

> +	if (!hba) {
> +		printf("ufs_tool: failed to get hba\n");
> +		return -1;
> +	}
> +
> +	if (lun >= 0 && idn >= 0) {
> +		idn_read(hba, idn, lun);
> +		return 0;
> +	}
> +
> +	ufs_tool_help();
> +	return -1;
> +}
> diff --git a/drivers/ufs/ufs_tool.h b/drivers/ufs/ufs_tool.h
> new file mode 100644
> index 00000000000..7ba852ceed0
> --- /dev/null
> +++ b/drivers/ufs/ufs_tool.h
> @@ -0,0 +1,394 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __UFS2_H
> +#define __UFS2_H
> +#include <linux/types.h>
> +
> +/*
> + * In a QUERY REQUEST UPIU, the Device Descriptor
> + * is addressed setting: DESCRIPTOR IDN = 00h
> + */
> +struct ufs_device_descriptor {
> +	u8 length;		/* Size of this descriptor */
> +	u8 descriptor_idn;	/* Descriptor Type Identifier (00h) */
> +	u8 device;		/* Device type (00h: Device) */
> +	u8 device_class;
> +	/* UFS Device Class (00h: Mass Storage) */
> +	u8 device_sub_class;
> +	/* UFS Mass Storage Subclass (e.g., 00h: Embedded Bootable) */
> +	u8 protocol;
> +	/* Protocol supported by UFS Device (00h: SCSI) */
> +	u8 number_lu;
> +	/* Number of Logical units (non-well known)  */
> +	u8 number_wlu;
> +	/* Number of Well known Logical units (MDV = 04h) */
> +	u8 boot_enable;	/* Boot Enable (01h: enabled) */
> +	u8 descr_access_en;
> +	/* Descriptor Access Enable during partial boot initialization */
> +
> +	/* --- power Management & Priority (Offset 0x0A) --- */
> +	u8 init_power_mode;
> +	/* Initial power Mode after device initi (00h: UFS-Sleep, 01h: */
> +	/*   Active) [4, 5] */
> +	u8 high_priority_lun;
> +	/* High Priority Logical unit (7Fh if all LUs have same priority) */
> +	u8 secure_removal_type;
> +	/* Secure Removal Type (00h: erase, 01h: overwrite/erase, etc.) */
> +	u8 security_lu;
> +	/* Support for security LU (01h: RPMB) */
> +	u8 background_ops_term_lat;
> +	/* Background Operations Termination Latency (in units of 10 ms) */
> +	u8 init_active_icc_level;
> +	/* Initial Active ICC Level after power on/reset (00h to 0Fh) */
> +
> +	/* --- Version, Naming, & configuration Pointers (Offset 0x10) --- */
> +	u16 spec_version;
> +	/* Specification version in BCD format (e.g., 3.1 = 0310h) */
> +	u16 manufacture_date;	/* Manufacturing Date in BCD format */
> +	u8 manufacturer_name;
> +	/* Index to the Manufacturer Name string descriptor */
> +	u8 product_name;
> +	/* Index to the Product Name string descriptor */
> +	u8 serial_number;
> +	/* Index to the Serial Number string descriptor */
> +	u8 oem_id;
> +	/* Index to the OEM ID string descriptor */
> +	u16 manufacturer_id;
> +	/* Manufacturer ID code and Bank Index (JEP106 definition) */
> +	u8 ud0_base_offset;
> +	/* Offset of unit Descriptor 0 configurable parameters within the */
> +	/* configuration Descriptor */
> +	u8 config_length;
> +	/* Total size of the configurable unit Descriptor parameters */
> +	u8 device_rtt_cap;
> +	/* Maximum number of outstanding Ready To Transfer (RTT) UPIUs */
> +	/* supported  (min 2) */
> +	u16 periodic_rtc_update;
> +	/* Frequency and method of Real-Time Clock update */
> +
> +	/* --- Feature Support & Device Status (Offset 0x1F) --- */
> +	u8 ufs_features_support;
> +	/* Bitmap indicating supported UFS features (FFU, PSA, etc.) */
> +	u8 ffu_timeout;
> +	/* Field Firmware Update Timeout (in seconds) */
> +	u8 queue_depth;
> +	/* Queue Depth (0: per-LU queueing; 1-255: shared queue depth) */
> +	u16 device_version;	/* Device Version */
> +	u8 num_secure_wp_area;
> +	/* Total number of Secure Write Protect */
> +	/* Areas supported (max 32) */
> +	u32 psa_max_data_size;
> +	/* PSA Maximum Data Size (in units of 4 Kbyte) */
> +	u8 psa_state_timeout;
> +	/* PSA State Timeout (max command timeout for b_psa_state change) */
> +	u8 product_revision_level;
> +	/* Index to the Product Revision Level string descriptor */
> +	u8 reserved_2bh[18];	/* reserved */
> +	u8 reserved_30h[19];
> +	/* Reserved for Unified Memory Extension standard */
> +	u8 reserved_40h[20];
> +	/* Reserved for Host Performance Booster (HPB) Extension Standard */
> +	u8 reserved_43h[21];	/* Reserved */
> +
> +	/* --- Extended Feature Support (Offset 0x4F) --- */
> +	u32 extended_ufs_features_support;
> +	/* Extended UFS Features Support (including WriteBooster, */
> +	/* offset 53h Performance Throttling) */
> +	u8 write_booster_buffer_preserve_user_space_en;
> +	/* offset 54h Preserve User Space mode for WriteBooster Buffer */
> +	u8 write_booster_buffer_type;
> +	/*  offset 55h WriteBooster Buffer Type
> +	 *  (0h:dedicated buffer,01h: shared buffer)
> +	 */
> +	u32 num_shared_write_booster_buffer_allocunits;
> +	/* WriteBooster Buffer size for shared configuration */
> +	/* (in Allocation units) */
> +} __packed;

Can you specify the source of those structs in the commit message ?

> +
> +struct unit_descriptor {
> +	u8 length;		/* Size of this descriptor (Default: 2Dh) */
> +	u8 descriptor_idn;	/* unit Descriptor Type Identifier (02h) */
> +	u8 bunit_index;		/* The index of the Logical unit */
> +
> +	/* --- configuration Parameters --- */
> +	u8 lu_enable;		/* 01h: LU enabled, 00h: LU disabled */
> +	u8 boot_lun_id;
> +	/* 01h: Boot LU A, 02h: Boot LU B, 00h: Not bootable */
> +	u8 lu_write_protect;
> +	/* 01h: power-on WP, 02h: Permanent WP, 00h: None */
> +	u8 lu_queue_depth;
> +	/* LU-specific queue depth (0 if shared queuing is used) */
> +	u8 psa_sensitive;
> +	/* 01h: Sensitive to soldering, 00h: Not sensitive */
> +	u8 memory_type;
> +	/* Memory type (e.g., 00h: Normal, 01h: System Code) */
> +	u8 data_reliability;
> +	/* 01h: Data protected against power failure */
> +	u8 logical_block_size;
> +	/* Logical Block Size exponent (e.g., 0Ch = 4 Kbyte) */
> +
> +	/* --- Capacity and geometry --- */
> +	u64 logical_block_count;
> +	/* Total number of addressable logical blocks in the LU */
> +	u32 erase_block_size;
> +	/* Optimal granularity for erase/discard operations */
> +	u8 provisioning_type;
> +	/* 00h: Full, 02h: Thin (TPRZ=0), 03h: Thin (TPRZ=1) */
> +	u64 phy_mem_resource_count;
> +	/* Total physical memory resources available to the LU */
> +
> +	/* --- Performance and Extended Features --- */
> +	u16 context_capabilities;
> +	/* Bits [3:0]: MaxContextID; Bits [6:4]: Large unit Multiplier */
> +	u8 largeunit_granularity_M1;
> +	/* Large unit Granularity = 1MB * (value + 1) */
> +	u8 reserved[11];	/* Reserved for HPB Extension Standard */
> +	u32 lu_num_write_booster_buffer_allocunits;
> +	/* WriteBooster Buffer size in Allocation units */
> +} __packed;
> +
> +/*
> + *
> + * UFS Geometry Descriptor (IDN 07h)
> + * Total Size: 87 bytes (0x57)
> + */
> +struct ufs_geometry_descriptor {
> +	/* --- Descriptor Header (Offset 0x00) --- */
> +	u8 length;		/* Size of this descriptor (57h) */
> +	u8 descriptor_idn;	/* geometry Descriptor ID (07h) */
> +	u8 media_technology;	/* Reserved (00h) */
> +	u8 reserved_03h;	/* Reserved (00h) */
> +
> +	/* --- Capacity and Device geometry (Offset 0x04) --- */
> +	u64 total_raw_device_capacity; /* Total memory available (units of 512B) */
> +	u8 max_number_lu;	/* Max LUs: 00h (8 LUs) or 01h (32 LUs) */
> +	u32 segment_size;	/* Segment size (units of 512B) */
> +	u8 allocationunit_size;	/* Allocation unit Size (number of segments) */
> +	u8 min_addr_block_size;
> +	/* Min addressable block size (units of 512B, min 08h) */
> +	u8 optimal_read_block_size;	/* Optimal read granularity (units of 512B) */
> +	u8 optimal_write_block_size;	/* Optimal write granularity (units of 512B) */
> +	u8 max_in_buffer_size;	/* Max data-in buffer size (units of 512B) */
> +	u8 max_out_buffer_size;	/* Max data-out buffer size (units of 512B) */
> +	u8 rpmb_read_write_size;	/* Max RPMB frames (256B) per command */
> +	u8 dynamic_capacity_resource_policy;	/* 00h: per LU, 01h: per memory type */
> +	u8 data_ordering;	/* 01h: Out-of-order data transfer supported */
> +	u8 max_contex_id_number;	/* Maximum supported contexts (min 5) */
> +	u8 sys_data_tagunit_size;	/* Granularity for System Data Tagging */
> +	u8 sys_data_tag_res_size;	/* Max storage area for system data tagging */
> +	u8 supported_sec_r_types;	/* Bitmap of supported Secure Removal Types */
> +	u16 supported_memory_types;
> +	/* Bitmap of supported memory types (Normal, Enhanced, etc.) */
> +
> +	/* --- Memory Type Capacity and Factors (Offset 0x20) --- */
> +	u32 system_code_max_n_alloc_u;
> +	/* Max Allocation units for System Code memory */
> +	u16 system_code_cap_adj_fac;
> +	/* Capacity Adjustment Factor for System Code */
> +	u32 non_persist_max_n_alloc_u;
> +	/* Max Allocation units for Non-Persistent memory */
> +	u16 non_persist_cap_adj_fac;
> +	/* Capacity Adjustment Factor for Non-Persistent */
> +	u32 enhanced1_max_n_alloc_u;
> +	/* Max Allocation units for Enhanced memory */
> +	/* Capacity Adjustment Factor for Enhanced */
> +	u16 enhanced1_cap_adj_fac;
> +	u32 enhanced2_max_n_alloc_u;
> +	/* Max Allocation units for Enhanced memory */
> +	/* Capacity Adjustment Factor for Enhanced */
> +	u16 enhanced2_cap_adj_fac;
> +	u32 enhanced3_max_n_alloc_u;
> +	/* Max Allocation units for Enhanced memory */
> +	/* Capacity Adjustment Factor for Enhanced */
> +	u16 enhanced3_cap_adj_fac;
> +	u32 enhanced4_max_n_alloc_u;
> +	/* Max Allocation units for Enhanced memory */
> +	/* Capacity Adjustment Factor for Enhanced */
> +	u16 enhanced4_cap_adj_fac;
> +	/* --- Performance Optimization (Offset 0x44) --- */
> +	/* Optimal Logical Block Size per memory type */
> +	u32 optimal_logical_block_size;
> +	u8  reserved_hpb[4]; // 48h: Reserved for HPB Extension
> +	u16 reserved2;   // 4Dh: Reserved
> +	/* WriteBooster Parameters */
> +	/* 4Fh: Max total WriteBooster Buffer size */
> +	u32 write_booster_buffer_max_alloc_units;
> +	/* 53h: Max LUs supporting WriteBooster (Valid: 1) */
> +	u8  device_max_write_booster_lus;
> +	/* 54h: LBA space reduction factor (e.g., 3 for TLC) */
> +	u8  write_booster_buffer_capadjfac;
> +	/* 55h: User space vs Preserve types */
> +	u8  supported_write_booster_buffer_userspace_reduction_types;
> +	/* 56h: LU based vs Shared buffer type */
> +	u8  supported_write_booster_buffer_types;
> +} __packed;
> +
> +/**
> + * UFS configuration Descriptor - Header and Device configurable Parameters
> + * Based on Table 14.10 (INDEX = 00h)
> + */
> +struct config_descriptor {
> +	/* --- Descriptor Header --- */
> +	u8 length;
> +	/* 00h: Size of this descriptor (MDV: E6h) */
> +	u8 descriptor_idn;
> +	/* 01h: configuration Descriptor Type ID (01h) */
> +
> +	/* --- configuration Flow Control --- */
> +	u8 conf_desc_continue;
> +	/* 02h: 00h = Last descriptor (apply config); */
> +	/* 01h = More descriptors follow */
> +
> +	/* --- Device Descriptor configurable Parameters --- */
> +	u8 boot_enable;
> +	/* 03h: Enables boot feature (01h: enabled) */
> +	u8 descr_access_en;
> +	/* 04h: Enables Device Descriptor access after partial init */
> +	u8 initpower_mode;
> +	/* 05h: Initial power Mode after reset (01h: Active) */
> +	u8 high_priority_lun;
> +	/* 06h: LUN of the high priority logical unit */
> +	u8 secure_removal_type;
> +	/* 07h: configures secure removal (e.g., 00h: erase) */
> +	u8 init_active_icc_level;
> +	/* 08h: Initial ICC level after reset (00h-0Fh) */
> +	u16 periodic_rtc_update;
> +	/* 09h: Frequency/method of Real-Time Clock update */
> +	u8 reserved_HPB;
> +	/* 0Bh: Reserved for Host Performance Booster */
> +
> +	/* --- RPMB configuration Parameters --- */
> +	u8 rpmb_region_enable;
> +	/* 0Ch: Bitmask to enable RPMB regions 1-3 */
> +	u8 rpmb_region1_size;
> +	/* 0Dh: Size of RPMB region 1 in 128KB units */
> +	u8 rpmb_region2_size;
> +	/* 0Eh: Size of RPMB region 2 in 128KB units */
> +	u8 rpmb_region3_size;
> +	/* 0Fh: Size of RPMB region 3 in 128KB units */
> +
> +	/* --- WriteBooster configuration Parameters --- */
> +	u8 write_booster_buffer_preserve_user_space_en;
> +	/* 10h: 01h = Preserve user space */
> +	u8 write_booster_buffer_type;
> +	/* 11h: 00h = Dedicated LU; 01h = Shared */
> +	u32 num_shared_write_booster_buffer_allocunits;
> +	/* 12h: Shared buffer size in Alloc units */
> +} __packed;
> +
> +/**
> + * UFS unit Descriptor configurable Parameters
> + * Found within the configuration Descriptor (IDN: 01h)
> + * Based on Table 14.12
> + */
> +struct ufs_unit_configurable_parameters {
> +	u8 lu_enable;		/* 01h: Enabled, 00h: Disabled */
> +
> +	u8 boot_lun_id;		/* 0 Not Bootable,1-A or 2-B */
> +
> +	/* 01h: Boot LU A, 02h: Boot LU B, 00h: Not bootable */
> +	u8 lu_write_protect;
> +	/* 00h: None, 01h: power-on WP, 02h: Permanent WP */
> +	u8 memory_type;
> +	/* Memory type (00h: Normal, 01h: System Code) */
> +
> +	/* Number of allocation units assigned to the LU. */
> +	u32 num_allocunits;
> +
> +	u8 data_reliability; /* 01h: Protected against power failure */
> +
> +	/* Block size exponent (e.g., 0Ch = 4 KB) */
> +	u8 logical_block_size;
> +
> +	/* 00h: Full, 02h: Thin (TPRZ=0), 03h: Thin (TPRZ=1) */
> +	u8 provisioning_type;
> +
> +	u16 context_capabilities; /* LU Context support and multipliers */
> +
> +	u8 reserved_0dh[6];	/* Reserved */
> +
> +	u8 reserved_hpb[7];
> +	/* Reserved for Host Performance Booster Extension */
> +
> +	u32 lu_num_write_booster_buffer_allocunits;
> +	/* WriteBooster Buffer size in Allocation units. */
> +} __packed;
> +
> +struct ufs_config_descriptor {
> +	struct config_descriptor cfg_desc;
> +	/*
> +	 * NOTE: For INDEX = 00h, configurable parameters
> +	 * for unit Descriptors 0 to 7
> +	 */
> +	/* follow this header at the offset defined
> +	 * by b_ud0_base_offset
> +	 */
> +	unsigned char space[QUERY_DESC_CONFIGURATION_DEF_SIZE -
> +			    sizeof(struct config_descriptor)];
> +} __packed;
> +
> +/**
> + * UFS power Parameter Element Format
> + * Based on Table 7.13
> + */
> +struct ufs_power_parameter_element {
> +	/* Bits [15:14]: unit (00b:n_a, 01b:u_a, 10b:m_a, 11b:A) */
> +	/* Bits [13:10]: Reserved (0000b) */
> +	/* Bits [9:0]:   Value (Maximum current expected) */
> +	u16 upower_value;
> +};
> +
> +/**
> + * UFS power Parameters Descriptor (IDN: 08h)
> + * Based on Table 14.16
> + */
> +struct ufs_power_parameters_descriptor {
> +	/* Offset 00h */
> +	u8 length;		/* Size of descriptor (62h) */
> +	u8 descriptor_idn;	/* Descriptor Type ID (08h) */
> +
> +	/* Offset 02h: Maximum current for VCC (16 levels) */
> +	struct ufs_power_parameter_element active_icc_levels_vcc[5];
> +	/* Offset 22h: Maximum current for VCCQ (16 levels) */
> +	struct ufs_power_parameter_element active_icc_levels_vccq[5];
> +	/* Offset 42h: Maximum current for VCCQ2 (16 levels) */
> +	struct ufs_power_parameter_element active_icc_levels_vccq2[5];
> +} __packed;
> +
> +/**
> + * UFS Temperature-related Attributes
> + * These are device-level attributes (Type 'D') retrieved via Query Requests.
> + * All temperature values follow the formula: Temperature (ºC) = Value – 80.
> + */
> +struct  ufs_temp_parameters_descriptor {
> +	/**
> +	 * IDN 18h: bDeviceCaseRoughTemperature [1]
> +	 * Represents the rough package case surface temperature.
> +	 * 0: Unknown Temperature.
> +	 * 1 ~ 250: Calculated as (Value - 80) in Celsius (-79ºC ~ 170ºC).
> +	 */
> +	u8 device_case_rough_temperature;
> +	/**
> +	 * IDN 19h: bDeviceTooHighTempBoundary
> +	 * High temperature boundary that triggers
> +	 * the TOO_HIGH_TEMP exception event.
> +	 * 100 ~ 250: Calculated as (Value - 80) in Celsius (20ºC ~ 170ºC).
> +	 */
> +	u8 device_too_high_temp_boundary;
> +	/*
> +	 * IDN 1Ah: bDeviceTooLowTempBoundary
> +	 * Low temperature boundary that triggers the TOO_LOW_TEMP
> +	 * exception event.
> +	 * 1 ~ 80: Calculated as (Value - 80) in Celsius (-79ºC ~ 0ºC).
> +	 */
> +	u8 device_too_low_temp_boundary;
> +	/**
> +	 * IDN 1Bh: bThrottlingStatus
> +	 * Indicates if the device is limiting performance due
> +	 * to specific conditions.
> +	 * bit 0: Set to 1 if performance is throttled due to Temperature.
> +	 * bits [7:1]: Reserved.
> +	 */
> +	u8 throttling_status;
> +} __packed__;
> +
> +#endif

Thanks,
Neil
