Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40FBCF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE30389343;
	Fri, 20 Sep 2024 09:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y9NircSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DCB89343; Fri, 20 Sep 2024 09:06:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4D189348
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso15838495e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726815977; x=1727420777; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=11XZ1Wx6DBxknOncBki8+9uI93Ad331upBn7idox8Hs=;
 b=Y9NircSncmKFGJMmABXCXDZS6tVy9IZoJOh9G8TM94DyBMKD/BZsjJrN/uEhoa6tPw
 sJtBRAxVms0azf2BfDTPAVugku1cS5i4Eyq+eTzZciKSWpRVeZAza/JreqBeNNvHx6CM
 WG96rH6Z91EV4y/dlDYysuFgeJ+7LOrLSjdSSmubtl9fjdEvaH22DCiasYJqERUejQRy
 2Z7r1mkz49NZn7jSIgTNtfS8VCIxT9OkmP6RcdttPokkVmZ+mcrXVCr8lTrtLa8NN6lU
 mMVeo0Jd3tzo3Hsp7uctqmfMvJLl7JvOjVwSwQrlDYQYT4CJ6dU/xFdIiBpNS1yWo1WN
 FCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726815977; x=1727420777;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=11XZ1Wx6DBxknOncBki8+9uI93Ad331upBn7idox8Hs=;
 b=VpZJil2iWX+cHd7NXZzxo1CgX/sgnUhzkaF+VGeGHt3czzvwqwC6aLI3iCeL1dvBL2
 25ekpmm8m0Yu+Q4JwL25iw4XeJHQRsDi8gvQ2tNC9NleO8P7G8Symc1ybz6tUmCowvGj
 pxhRDWUvcP1icekFWigH6JlrVFEqJMRK9dGLlvINXgoFsJjMHjUrQRFKDp+hVpnxvbZy
 CrjL/Dt3pg+HZ3B+kebBNgtdnfQhQvFRKKUe5WwPl6hzTwPNE2e82Tf+rrC5OZZ14c4X
 +vnWuWuMKU5rPFDOI1sU/COlW5t5TSQu8RXC6GQuXV+GFGZ6gLQekoA3ZVNrzRFsCpQi
 5eMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOjrFESKjNOH+BFJS/npa1QB8HFEDzuCRNZZqsFtunvQ07mzQaWUQE1Ec25jFMA8GNjnR2bbs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyig9dnBxXNaDCV7DWNj8rq2DuRfE7OmdCX49xNo3lwx147p3aT
 OiT+13AQXfyhyFDklN3cWtZ9kUF/oZiZQABsf7V3FRkUW/YarfOkqJhKrenRkBA=
X-Google-Smtp-Source: AGHT+IHeYu3XUm16m5kDBTIPh1EzSOjWoZf3lTqQWjhnbpTbQxxuYM40v06BygpUhwZOHnOW8ERN8g==
X-Received: by 2002:a05:600c:4e44:b0:42c:bf94:f9ad with SMTP id
 5b1f17b1804b1-42e7c1a51b8mr9363145e9.34.1726815976485; 
 Fri, 20 Sep 2024 00:06:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f?
 ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e6bc42fb8sm68316205e9.0.2024.09.20.00.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 00:06:16 -0700 (PDT)
Message-ID: <1eb57c83-a92b-4914-bac9-9ae5e11142e6@linaro.org>
Date: Fri, 20 Sep 2024 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/3] ufs: add support for DesignWare Controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
 <20240920041651.18173-2-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240920041651.18173-2-venkatesh.abbarapu@amd.com>
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

On 20/09/2024 06:16, Venkatesh Yadav Abbarapu wrote:
> This patch has the goal to add support for DesignWare UFS Controller
> specific operations.
> 
> This is based on linux kernel commit:
> "drivers/scsi/ufs/ufshcd-dwc.c: ufs: add support for DesignWare
> Controller" (sha1: 4b9ffb5a353bdee49f1f477ffe2b95ab3f9cbc0c)
> It is ported from linux kernel 6.11-rc1.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the ufshcd_vops_phy_initialization function.
> - Removed the ufshcd_set_link_active function.
> 
>   drivers/ufs/ufshcd-dwc.c | 133 +++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufshcd-dwc.h |  23 +++++++
>   drivers/ufs/ufshci-dwc.h |  32 ++++++++++
>   3 files changed, 188 insertions(+)
>   create mode 100644 drivers/ufs/ufshcd-dwc.c
>   create mode 100644 drivers/ufs/ufshcd-dwc.h
>   create mode 100644 drivers/ufs/ufshci-dwc.h
> 
> diff --git a/drivers/ufs/ufshcd-dwc.c b/drivers/ufs/ufshcd-dwc.c
> new file mode 100644
> index 0000000000..3f62e59a06
> --- /dev/null
> +++ b/drivers/ufs/ufshcd-dwc.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UFS Host driver for Synopsys Designware Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + */
> +#include <clk.h>
> +#include <dm.h>
> +#include <ufs.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/time.h>
> +
> +#include "ufs.h"
> +#include "ufshci-dwc.h"
> +#include "ufshcd-dwc.h"
> +
> +int ufshcd_dwc_dme_set_attrs(struct ufs_hba *hba,
> +			     const struct ufshcd_dme_attr_val *v, int n)
> +{
> +	int ret = 0;
> +	int attr_node = 0;
> +
> +	for (attr_node = 0; attr_node < n; attr_node++) {
> +		ret = ufshcd_dme_set_attr(hba, v[attr_node].attr_sel,
> +					  ATTR_SET_NOR, v[attr_node].mib_val, v[attr_node].peer);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ufshcd_dwc_program_clk_div() - program clock divider.
> + * @hba: Private Structure pointer
> + * @divider_val: clock divider value to be programmed
> + *
> + */
> +static void ufshcd_dwc_program_clk_div(struct ufs_hba *hba, u32 divider_val)
> +{
> +	ufshcd_writel(hba, divider_val, DWC_UFS_REG_HCLKDIV);
> +}
> +
> +/**
> + * ufshcd_dwc_link_is_up() - check if link is up.
> + * @hba: private structure pointer
> + *
> + * Return: 0 on success, non-zero value on failure.
> + */
> +static int ufshcd_dwc_link_is_up(struct ufs_hba *hba)
> +{
> +	int dme_result = 0;
> +
> +	ufshcd_dme_get(hba, UIC_ARG_MIB(VS_POWERSTATE), &dme_result);
> +
> +	if (dme_result == UFSHCD_LINK_IS_UP)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/**
> + * ufshcd_dwc_connection_setup() - configure unipro attributes.
> + * @hba: pointer to drivers private data
> + *
> + * This function configures both the local side (host) and the peer side
> + * (device) unipro attributes to establish the connection to application/
> + * cport.
> + * This function is not required if the hardware is properly configured to
> + * have this connection setup on reset. But invoking this function does no
> + * harm and should be fine even working with any ufs device.
> + *
> + * Return: 0 on success non-zero value on failure.
> + */
> +static int ufshcd_dwc_connection_setup(struct ufs_hba *hba)
> +{
> +	static const struct ufshcd_dme_attr_val setup_attrs[] = {
> +		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(N_DEVICEID), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(N_DEVICEID_VALID), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_PEERDEVICEID), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_PEERCPORTID), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_TRAFFICCLASS), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_CPORTFLAGS), 0x6, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_CPORTMODE), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 0, DME_PEER },
> +		{ UIC_ARG_MIB(N_DEVICEID), 1, DME_PEER },
> +		{ UIC_ARG_MIB(N_DEVICEID_VALID), 1, DME_PEER },
> +		{ UIC_ARG_MIB(T_PEERDEVICEID), 1, DME_PEER },
> +		{ UIC_ARG_MIB(T_PEERCPORTID), 0, DME_PEER },
> +		{ UIC_ARG_MIB(T_TRAFFICCLASS), 0, DME_PEER },
> +		{ UIC_ARG_MIB(T_CPORTFLAGS), 0x6, DME_PEER },
> +		{ UIC_ARG_MIB(T_CPORTMODE), 1, DME_PEER },
> +		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 1, DME_PEER }
> +	};
> +	return ufshcd_dwc_dme_set_attrs(hba, setup_attrs, ARRAY_SIZE(setup_attrs));
> +}
> +
> +/**
> + * ufshcd_dwc_link_startup_notify() - program clock divider.
> + * @hba: private structure pointer
> + * @status: Callback notify status
> + *
> + * Return: 0 on success, non-zero value on failure.
> + */
> +int ufshcd_dwc_link_startup_notify(struct ufs_hba *hba,
> +				   enum ufs_notify_change_status status)
> +{
> +	int err = 0;
> +
> +	if (status == PRE_CHANGE) {
> +		ufshcd_dwc_program_clk_div(hba, DWC_UFS_REG_HCLKDIV_DIV_125);
> +	} else { /* POST_CHANGE */
> +		err = ufshcd_dwc_link_is_up(hba);
> +		if (err) {
> +			dev_err(hba->dev, "Link is not up\n");
> +			return err;
> +		}
> +
> +		err = ufshcd_dwc_connection_setup(hba);
> +		if (err)
> +			dev_err(hba->dev, "Connection setup failed (%d)\n",
> +				err);
> +	}
> +
> +	return err;
> +}
> diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
> new file mode 100644
> index 0000000000..d997045d3c
> --- /dev/null
> +++ b/drivers/ufs/ufshcd-dwc.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS Host driver for Synopsys Designware Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors: Joao Pinto <jpinto@synopsys.com>
> + */
> +
> +#ifndef _UFSHCD_DWC_H
> +#define _UFSHCD_DWC_H
> +
> +struct ufshcd_dme_attr_val {
> +	u32 attr_sel;
> +	u32 mib_val;
> +	u8 peer;
> +};
> +
> +int ufshcd_dwc_link_startup_notify(struct ufs_hba *hba,
> +				   enum ufs_notify_change_status status);
> +int ufshcd_dwc_dme_set_attrs(struct ufs_hba *hba,
> +			     const struct ufshcd_dme_attr_val *v, int n);
> +#endif /* End of Header */
> diff --git a/drivers/ufs/ufshci-dwc.h b/drivers/ufs/ufshci-dwc.h
> new file mode 100644
> index 0000000000..9e24c230c6
> --- /dev/null
> +++ b/drivers/ufs/ufshci-dwc.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS Host driver for Synopsys Designware Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors: Joao Pinto <jpinto@synopsys.com>
> + */
> +
> +#ifndef _UFSHCI_DWC_H
> +#define _UFSHCI_DWC_H
> +
> +/* DWC HC UFSHCI specific Registers */
> +enum dwc_specific_registers {
> +	DWC_UFS_REG_HCLKDIV	= 0xFC,
> +};
> +
> +/* Clock Divider Values: Hex equivalent of frequency in MHz */
> +enum clk_div_values {
> +	DWC_UFS_REG_HCLKDIV_DIV_62_5	= 0x3e,
> +	DWC_UFS_REG_HCLKDIV_DIV_125	= 0x7d,
> +	DWC_UFS_REG_HCLKDIV_DIV_200	= 0xc8,
> +};
> +
> +/* Selector Index */
> +enum selector_index {
> +	SELIND_LN0_TX	= 0x00,
> +	SELIND_LN1_TX	= 0x01,
> +	SELIND_LN0_RX	= 0x04,
> +	SELIND_LN1_RX	= 0x05,
> +};
> +#endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
