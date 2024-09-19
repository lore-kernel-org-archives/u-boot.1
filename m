Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0CBCF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DDB891E4;
	Thu, 19 Sep 2024 17:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QGRds0+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E441288A24; Thu, 19 Sep 2024 17:45:18 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC4E7892A2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so9545655e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726760715; x=1727365515; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iG1bcLCrNVZdOxjqIcN8ScwQaeyg0bKD09v88YP02ZQ=;
 b=QGRds0+s1YXzbUvOm8eBNgCPW5D+ZdJPaNJ+6uNPNBO2GK0UKd3y4a1MxTMVyzYgmJ
 kL2T8k3HDKitUx5aou0LViGi1gw2oJzH7XFdcx2V94PzxrNDrd0+fQB8dA9sYuovxnlp
 IF7BpvWyj2RpvtsLaoPu5l0HuP7KATk1oiTwch6T1No6BWWDw2IvMkL2tWiDp9AlWRsL
 5TZWiz+hAVcDXcRvT0qBRy/Uil7UOdukblk+x0uSjuvIWXE4io3cJ/DdRM4uuqvhGJTj
 FzmG99mZ4tLDNX0VO8x4KyodMr5UoZJ8WD4cCWxjl5U8gCmGcUyHghf+efB/7VGO8ZJh
 9qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760715; x=1727365515;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iG1bcLCrNVZdOxjqIcN8ScwQaeyg0bKD09v88YP02ZQ=;
 b=HOrJvwNvB1208793MolzzrER+cdltzzInGV5Cap2YvM3Izjpewo+mY2YgYKWbSED/o
 yYcUR3tEUe6r+K6M2UkKa05UDEe+Ub9z5I48qPyS+snuDGpc4YnV47I4GtXGBF/1dKVm
 du8qYOLscufdMdteFtDFgS4yWRIiV9n0Xqz+T0a+bPYY9n25IGiJAwofBU+8q+kaKEwE
 8C2Hc8eZ8dGUsHXaL0Q69awYo7Vj7p8udM6hN1D0BOv2Au37rfDzYE5ikp6i6g7X3Ja7
 HNbB8DnJslm0wUDX83YAW5IG1ysGd/HRQjHlXBYO83yaSQc0i+uvx+uF85l8sDyhe263
 ik4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeB9FlJojPwkf7kVBNBO7x/pN4aedF8X/6EPXoAlHeL27e9evU0DtX74y4kL3MAoTZoYSO+xk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn6pYtntXlAQ8f5wSSYenNLhnNbEXxOWa3/r3X5H+/6rjESn3u
 tUAc6axJB0Nsa7w0B2QXV0nwspQLPUE1ptzGIj1sAijRPT4ObSrRg4kT5uUSsgo=
X-Google-Smtp-Source: AGHT+IH9wl+frczv2XUKjJLh8jFMN0afjOliik/Dumslhtl/F2nDLUIgpdfoAOcZefQ/LYiQ6G6/tw==
X-Received: by 2002:a05:600c:4fd6:b0:42c:d084:ed7e with SMTP id
 5b1f17b1804b1-42cdb509eafmr181258945e9.4.1726760714959; 
 Thu, 19 Sep 2024 08:45:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ea1:6137:3157:6e66?
 ([2a01:e0a:982:cbb0:8ea1:6137:3157:6e66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f9875sm15258816f8f.54.2024.09.19.08.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 08:45:14 -0700 (PDT)
Message-ID: <b5ebe6ff-3272-46b9-b97f-de3cb9589883@linaro.org>
Date: Thu, 19 Sep 2024 17:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] ufs: ufs-amd-versal2: Add support for AMD UFS
 controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
 <20240919091731.26338-3-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240919091731.26338-3-venkatesh.abbarapu@amd.com>
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

On 19/09/2024 11:17, Venkatesh Yadav Abbarapu wrote:
> Add UFS AMD platform support on top of the UFS DWC
> and UFS platform driver. UFS AMD platform requires
> some platform specific configurations like M-PHY/RMMI/UniPro
> and vendor specific registers programming before doing the LINKSTARTUP.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/ufs/Kconfig           |   8 +
>   drivers/ufs/Makefile          |   1 +
>   drivers/ufs/ufs-amd-versal2.c | 501 ++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufshcd-dwc.h      |  46 ++++
>   drivers/ufs/unipro.h          |   1 +
>   5 files changed, 557 insertions(+)
>   create mode 100644 drivers/ufs/ufs-amd-versal2.c
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 7da46faed6..ad5d0316f6 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -41,4 +41,12 @@ config UFS_RENESAS
>   	  UFS host on Renesas needs some vendor specific configuration before
>   	  accessing the hardware.
>   
> +config UFS_AMD_VERSAL2
> +	bool "AMD Versal Gen 2 UFS controller platform driver"
> +	depends on UFS && ZYNQMP_FIRMWARE
> +	help
> +	  This selects the AMD specific additions to UFSHCD platform driver.
> +	  UFS host on AMD needs some vendor specific configuration before accessing
> +	  the hardware.
> +
>   endmenu
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 67c42621ab..745de5c3db 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
>   obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
>   obj-$(CONFIG_UFS_PCI) += ufs-pci.o
>   obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
> +obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> new file mode 100644
> index 0000000000..bfd844e419
> --- /dev/null
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -0,0 +1,501 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <ufs.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <zynqmp_firmware.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/time.h>
> +#include <reset.h>
> +
> +#include "ufs.h"
> +#include "ufshcd-dwc.h"
> +#include "ufshci-dwc.h"
> +
> +#define VERSAL2_UFS_DEVICE_ID		4
> +
> +#define SRAM_CSR_INIT_DONE_MASK		BIT(0)
> +#define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
> +#define SRAM_CSR_BYPASS_MASK		BIT(2)
> +
> +#define MPHY_FAST_RX_AFE_CAL		BIT(2)
> +#define MPHY_FW_CALIB_CFG_VAL		BIT(8)
> +
> +#define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
> +
> +#define TIMEOUT_MICROSEC		1000000L
> +
> +#define IOCTL_UFS_TXRX_CFGRDY_GET	40
> +#define IOCTL_UFS_SRAM_CSR_SEL		41
> +
> +#define PM_UFS_SRAM_CSR_WRITE		0
> +#define PM_UFS_SRAM_CSR_READ		1
> +
> +struct ufs_versal2_priv {
> +	struct ufs_hba *hba;
> +	struct reset_ctl *rstc;
> +	struct reset_ctl *rstphy;
> +	u32 phy_mode;
> +	u32 host_clk;
> +	u32 pd_dev_id;
> +	u8 attcompval0;
> +	u8 attcompval1;
> +	u8 ctlecompval0;
> +	u8 ctlecompval1;
> +};
> +
> +static int ufs_versal2_phy_reg_write(struct ufs_hba *hba, u32 addr, u32 val)
> +{
> +	static struct ufshcd_dme_attr_val phy_write_attrs[] = {
> +		{ UIC_ARG_MIB(CBCREGADDRLSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGADDRMSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGWRLSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGWRMSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGRDWRSEL), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
> +	};
> +
> +	phy_write_attrs[0].mib_val = (u8)addr;
> +	phy_write_attrs[1].mib_val = (u8)(addr >> 8);
> +	phy_write_attrs[2].mib_val = (u8)val;
> +	phy_write_attrs[3].mib_val = (u8)(val >> 8);
> +
> +	return ufshcd_dwc_dme_set_attrs(hba, phy_write_attrs, ARRAY_SIZE(phy_write_attrs));
> +}
> +
> +static int ufs_versal2_phy_reg_read(struct ufs_hba *hba, u32 addr, u32 *val)
> +{
> +	u32 mib_val;
> +	int ret;
> +	static struct ufshcd_dme_attr_val phy_read_attrs[] = {
> +		{ UIC_ARG_MIB(CBCREGADDRLSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGADDRMSB), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCREGRDWRSEL), 0, DME_LOCAL },
> +		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
> +	};
> +
> +	phy_read_attrs[0].mib_val = (u8)addr;
> +	phy_read_attrs[1].mib_val = (u8)(addr >> 8);
> +
> +	ret = ufshcd_dwc_dme_set_attrs(hba, phy_read_attrs, ARRAY_SIZE(phy_read_attrs));
> +	if (ret)
> +		return ret;
> +
> +	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(CBCREGRDLSB), &mib_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = mib_val;
> +	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(CBCREGRDMSB), &mib_val);
> +	if (ret)
> +		return ret;
> +
> +	*val |= (mib_val << 8);
> +
> +	return 0;
> +}
> +
> +int versal2_pm_ufs_get_txrx_cfgrdy(u32 node_id, u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_TXRX_CFGRDY_GET,
> +				0, 0, ret_payload);
> +	*value = ret_payload[1];
> +
> +	return ret;
> +}
> +
> +int versal2_pm_ufs_sram_csr_sel(u32 node_id, u32 type, u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	if (type == PM_UFS_SRAM_CSR_READ) {
> +		ret =  xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
> +					 type, 0, ret_payload);
> +		*value = ret_payload[1];
> +	} else {
> +		ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
> +					type, *value, 0);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ufs_versal2_enable_phy(struct ufs_hba *hba)
> +{
> +	u32 offset, reg;
> +	int ret;
> +
> +	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYDISABLE), 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYCFGUPDT), 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Check Tx/Rx FSM states */
> +	for (offset = 0; offset < 2; offset++) {
> +		u32 time_left, mibsel;
> +
> +		time_left = TIMEOUT_MICROSEC;
> +		mibsel = UIC_ARG_MIB_SEL(MTX_FSM_STATE, UIC_ARG_MPHY_TX_GEN_SEL_INDEX(offset));
> +		do {
> +			ret = ufshcd_dme_get(hba, mibsel, &reg);
> +			if (ret)
> +				return ret;
> +
> +			if (reg == TX_STATE_HIBERN8 || reg == TX_STATE_SLEEP ||
> +			    reg == TX_STATE_LSBURST)
> +				break;
> +
> +			time_left--;
> +			mdelay(5);
> +		} while (time_left);
> +
> +		if (!time_left) {
> +			dev_err(hba->dev, "Invalid Tx FSM state.\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		time_left = TIMEOUT_MICROSEC;
> +		mibsel = UIC_ARG_MIB_SEL(MRX_FSM_STATE, UIC_ARG_MPHY_RX_GEN_SEL_INDEX(offset));
> +		do {
> +			ret = ufshcd_dme_get(hba, mibsel, &reg);
> +			if (ret)
> +				return ret;
> +
> +			if (reg == RX_STATE_HIBERN8 || reg == RX_STATE_SLEEP ||
> +			    reg == RX_STATE_LSBURST)
> +				break;
> +
> +			time_left--;
> +			mdelay(5);
> +		} while (time_left);
> +
> +		if (!time_left) {
> +			dev_err(hba->dev, "Invalid Rx FSM state.\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ufs_versal2_setup_phy(struct ufs_hba *hba)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	int ret;
> +	u32 reg;
> +
> +	/* Bypass RX-AFE offset calibrations (ATT/CTLE) */
> +	ret = ufs_versal2_phy_reg_read(hba, FAST_FLAGS(0), &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg |= MPHY_FAST_RX_AFE_CAL;
> +	ret = ufs_versal2_phy_reg_write(hba, FAST_FLAGS(0), reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufs_versal2_phy_reg_read(hba, FAST_FLAGS(1), &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg |= MPHY_FAST_RX_AFE_CAL;
> +	ret = ufs_versal2_phy_reg_write(hba, FAST_FLAGS(1), reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Program ATT and CTLE compensation values */
> +	if (priv->attcompval0) {
> +		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_ATT_IDAC(0), priv->attcompval0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (priv->attcompval1) {
> +		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_ATT_IDAC(1), priv->attcompval1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (priv->ctlecompval0) {
> +		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_CTLE_IDAC(0), priv->ctlecompval0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (priv->ctlecompval1) {
> +		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_CTLE_IDAC(1), priv->ctlecompval1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ufs_versal2_phy_reg_read(hba, FW_CALIB_CCFG(0), &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg |= MPHY_FW_CALIB_CFG_VAL;
> +	ret = ufs_versal2_phy_reg_write(hba, FW_CALIB_CCFG(0), reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufs_versal2_phy_reg_read(hba, FW_CALIB_CCFG(1), &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg |= MPHY_FW_CALIB_CFG_VAL;
> +	return ufs_versal2_phy_reg_write(hba, FW_CALIB_CCFG(1), reg);
> +}
> +
> +static int ufs_versal2_phy_init(struct ufs_hba *hba)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	u32 reg, time_left;
> +	int ret;
> +	static const struct ufshcd_dme_attr_val rmmi_attrs[] = {
> +		{ UIC_ARG_MIB(CBREFCLKCTRL2), CBREFREFCLK_GATE_OVR_EN, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBCRCTRL), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(CBC10DIRECTCONF2), 1, DME_LOCAL },
> +		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
> +	};
> +
> +	/* Wait for Tx/Rx config_rdy */
> +	time_left = TIMEOUT_MICROSEC;
> +	do {
> +		time_left--;
> +		ret = versal2_pm_ufs_get_txrx_cfgrdy(priv->pd_dev_id, &reg);
> +		if (ret)
> +			return ret;
> +
> +		reg &= TX_RX_CFG_RDY_MASK;
> +		if (!reg)
> +			break;
> +
> +		mdelay(5);
> +	} while (time_left);
> +
> +	if (!time_left) {
> +		dev_err(hba->dev, "Tx/Rx configuration signal busy.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = ufshcd_dwc_dme_set_attrs(hba, rmmi_attrs, ARRAY_SIZE(rmmi_attrs));
> +	if (ret)
> +		return ret;
> +
> +	/* DeAssert PHY reset */
> +	ret = reset_deassert(priv->rstphy);
> +	if (ret) {
> +		dev_err(hba->dev, "ufsphy reset deassert failed\n");
> +		return ret;
> +	}
> +
> +	/* Wait for SRAM init done */
> +	time_left = TIMEOUT_MICROSEC;
> +	do {
> +		time_left--;
> +		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> +						  PM_UFS_SRAM_CSR_READ, &reg);
> +		if (ret)
> +			return ret;
> +
> +		reg &= SRAM_CSR_INIT_DONE_MASK;
> +		if (reg)
> +			break;
> +
> +		mdelay(5);
> +	} while (time_left);
> +
> +	if (!time_left) {
> +		dev_err(hba->dev, "SRAM initialization failed.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = ufs_versal2_setup_phy(hba);
> +	if (ret)
> +		return ret;
> +
> +	return ufs_versal2_enable_phy(hba);
> +}
> +
> +static int ufs_versal2_init(struct ufs_hba *hba)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	struct clk clk;
> +	unsigned long core_clk_rate = 0;
> +	int ret = 0;
> +
> +	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
> +	priv->pd_dev_id = VERSAL2_UFS_DEVICE_ID;
> +
> +	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
> +	if (ret) {
> +		dev_err(hba->dev, "failed to get core_clk clock\n");
> +		return ret;
> +	}
> +
> +	core_clk_rate = clk_get_rate(&clk);
> +	if (IS_ERR_VALUE(core_clk_rate)) {
> +		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
> +			__func__);
> +		return core_clk_rate;
> +	}
> +	priv->host_clk = core_clk_rate;
> +
> +	priv->rstc = devm_reset_control_get(hba->dev, "ufshc-rst");
> +	if (IS_ERR(priv->rstc)) {
> +		dev_err(hba->dev, "failed to get reset ctl: ufshc-rst\n");
> +		return PTR_ERR(priv->rstc);
> +	}
> +	priv->rstphy = devm_reset_control_get(hba->dev, "ufsphy-rst");
> +	if (IS_ERR(priv->rstphy)) {
> +		dev_err(hba->dev, "failed to get reset ctl: ufsphy-rst\n");
> +		return PTR_ERR(priv->rstphy);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
> +					 enum ufs_notify_change_status status)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	u32 sram_csr;
> +	int ret;
> +
> +	switch (status) {
> +	case PRE_CHANGE:
> +		/* Assert RST_UFS Reset for UFS block in PMX_IOU */
> +		ret = reset_assert(priv->rstc);
> +		if (ret) {
> +			dev_err(hba->dev, "ufshc reset assert failed, err = %d\n", ret);
> +			return ret;
> +		}
> +
> +		/* Assert PHY reset */
> +		ret = reset_assert(priv->rstphy);
> +		if (ret) {
> +			dev_err(hba->dev, "ufsphy reset assert failed, err = %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> +						  PM_UFS_SRAM_CSR_READ, &sram_csr);
> +		if (ret)
> +			return ret;
> +
> +		if (!priv->phy_mode) {
> +			sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
> +			sram_csr |= SRAM_CSR_BYPASS_MASK;
> +		} else {
> +			dev_err(hba->dev, "Invalid phy-mode %d.\n", priv->phy_mode);
> +			return -EINVAL;
> +		}
> +
> +		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> +						  PM_UFS_SRAM_CSR_WRITE, &sram_csr);
> +		if (ret)
> +			return ret;
> +
> +		/* De Assert RST_UFS Reset for UFS block in PMX_IOU */
> +		ret = reset_deassert(priv->rstc);
> +		if (ret)
> +			dev_err(hba->dev, "ufshc reset deassert failed, err = %d\n", ret);
> +
> +		break;
> +	case POST_CHANGE:
> +		ret = ufs_versal2_phy_init(hba);
> +		if (ret)
> +			dev_err(hba->dev, "Phy init failed (%d)\n", ret);
> +
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ufs_versal2_link_startup_notify(struct ufs_hba *hba,
> +					   enum ufs_notify_change_status status)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	int ret = 0;
> +
> +	switch (status) {
> +	case PRE_CHANGE:
> +		if (priv->host_clk) {
> +			u32 core_clk_div = priv->host_clk / TIMEOUT_MICROSEC;
> +
> +			ufshcd_writel(hba, core_clk_div, DWC_UFS_REG_HCLKDIV);
> +		}
> +		break;
> +	case POST_CHANGE:
> +		ret = ufshcd_dwc_link_startup_notify(hba, status);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct ufs_hba_ops ufs_versal2_hba_ops = {
> +	.init = ufs_versal2_init,
> +	.link_startup_notify = ufs_versal2_link_startup_notify,
> +	.hce_enable_notify = ufs_versal2_hce_enable_notify,
> +};
> +
> +static int ufs_versal2_probe(struct udevice *dev)
> +{
> +	int ret;
> +
> +	/* Perform generic probe */
> +	ret = ufshcd_probe(dev, &ufs_versal2_hba_ops);
> +	if (ret)
> +		dev_err(dev, "ufshcd_probe() failed %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int ufs_versal2_bind(struct udevice *dev)
> +{
> +	struct udevice *scsi_dev;
> +
> +	return ufs_scsi_bind(dev, &scsi_dev);
> +}
> +
> +static const struct udevice_id ufs_versal2_ids[] = {
> +	{
> +		.compatible = "amd,versal2-ufs",
> +	},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(ufs_versal2_pltfm) = {
> +	.name           = "ufs-versal2-pltfm",
> +	.id             = UCLASS_UFS,
> +	.of_match       = ufs_versal2_ids,
> +	.probe          = ufs_versal2_probe,
> +	.bind           = ufs_versal2_bind,
> +};
> diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
> index d997045d3c..fc1bcca8cc 100644
> --- a/drivers/ufs/ufshcd-dwc.h
> +++ b/drivers/ufs/ufshcd-dwc.h
> @@ -10,6 +10,52 @@
>   #ifndef _UFSHCD_DWC_H
>   #define _UFSHCD_DWC_H
>   
> +/* PHY modes */
> +#define UFSHCD_DWC_PHY_MODE_ROM		0
> +
> +/* RMMI Attributes */
> +#define CBREFCLKCTRL2		0x8132
> +#define CBCRCTRL		0x811F
> +#define CBC10DIRECTCONF2	0x810E
> +#define CBCREGADDRLSB		0x8116
> +#define CBCREGADDRMSB		0x8117
> +#define CBCREGWRLSB		0x8118
> +#define CBCREGWRMSB		0x8119
> +#define CBCREGRDLSB		0x811A
> +#define CBCREGRDMSB		0x811B
> +#define CBCREGRDWRSEL		0x811C
> +
> +#define CBREFREFCLK_GATE_OVR_EN		BIT(7)
> +
> +/* M-PHY Attributes */
> +#define MTX_FSM_STATE		0x41
> +#define MRX_FSM_STATE		0xC1
> +
> +/* M-PHY registers */
> +#define FAST_FLAGS(n)		(0x401C + ((n) * 0x100))
> +#define RX_AFE_ATT_IDAC(n)	(0x4000 + ((n) * 0x100))
> +#define RX_AFE_CTLE_IDAC(n)	(0x4001 + ((n) * 0x100))
> +#define FW_CALIB_CCFG(n)	(0x404D + ((n) * 0x100))
> +
> +/* Tx/Rx FSM state */
> +enum rx_fsm_state {
> +	RX_STATE_DISABLED = 0,
> +	RX_STATE_HIBERN8 = 1,
> +	RX_STATE_SLEEP = 2,
> +	RX_STATE_STALL = 3,
> +	RX_STATE_LSBURST = 4,
> +	RX_STATE_HSBURST = 5,
> +};
> +
> +enum tx_fsm_state {
> +	TX_STATE_DISABLED = 0,
> +	TX_STATE_HIBERN8 = 1,
> +	TX_STATE_SLEEP = 2,
> +	TX_STATE_STALL = 3,
> +	TX_STATE_LSBURST = 4,
> +	TX_STATE_HSBURST = 5,
> +};
> +
>   struct ufshcd_dme_attr_val {
>   	u32 attr_sel;
>   	u32 mib_val;
> diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
> index b30b17fa5a..2f5726d4d3 100644
> --- a/drivers/ufs/unipro.h
> +++ b/drivers/ufs/unipro.h
> @@ -148,6 +148,7 @@
>   #define VS_MPHYCFGUPDT		0xD085
>   #define VS_DEBUGOMC		0xD09E
>   #define VS_POWERSTATE		0xD083
> +#define VS_MPHYDISABLE		0xD0C1
>   
>   #define PA_GRANULARITY_MIN_VAL	1
>   #define PA_GRANULARITY_MAX_VAL	6

Looks fine!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
