Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD97BC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440E98849A;
	Fri,  5 Apr 2024 11:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bMRrZ5N+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AB28849C; Fri,  5 Apr 2024 11:25:34 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5C88847A
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34175878e3cso1309302f8f.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712309131; x=1712913931; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CbA7wwzaZw9dZXdw3thiTe2x4DIChrhGkM/G2LS9eBI=;
 b=bMRrZ5N+Jb/M9IeFq6x4mubChU3FhTUSH5n4vBI6KhQBZPIAuFghgyKTKZX6U3Q0Qp
 V4qUa++zi53bLluZ26j7Z6ZEG35j/GHegjUJVPf/dNthe7Hq/eGma4sfsZqZ3cjUd0jE
 cnPw4PYftSVg3MXVux4l4OCt7Lx+Ef8xoZZ8a3Z22kCtnzHS+n1CF9ZhbXYsxZgKxZWZ
 4zIx/iIgNvIUwtBhMRJi4j27vfB3CkYOogV2wPu51TDFBjrfnRGZlOtHFJG6vZcTYBJo
 saF7AP1hFv43TN5JDNSmhgQ0igbPw7pbVBlhF5l3I/6g6SqrpJGsyQQ8A1Uc1mJ7f64w
 oQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712309131; x=1712913931;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CbA7wwzaZw9dZXdw3thiTe2x4DIChrhGkM/G2LS9eBI=;
 b=kaG09Wb5lVd33wP6JIGER5MFso/cHak+5gB33aXhjQ6/jCiOGLvcJzFFUe5P+iaTDN
 NGt23rBq7adjoydp534qVwSl8szTXyRRf07JvNMoCkAR9NQ8uVw4SrVM3bu9qIVrTv8Q
 LaLXWtYu5zdrwiIpSfWv/HXvC2aaJGbolP6mYShwX8mWhmwdcxPuGquOW4OEiNGgbBG+
 DCtVXiOyARfdcV2kJIf4T02kLCY3gJ9uacLqCR/bMHrlPBAj+nfH0qawZhJhy+6Tkm23
 2rRU6+UYnFYis10IBsp5Pbf5fErwD3GrFsKHGF/X/uVl1w0bT25aCpfh6YRlD+ZE+Pnc
 nzfg==
X-Gm-Message-State: AOJu0YwxaPd3WOOwp74QAcugGOPVJFDkD83BkW927myWA3FXQF8XS3A0
 k8iUmq4OShSj311P5fR+iznGn3WhqJDYMChP92RnNUMt+CDAPwiVb05QMm6BK05baxFaHxe0LVW
 UvsY=
X-Google-Smtp-Source: AGHT+IFK91bdDVbqQAad5gejGKzUFVWeIUGBwOFMA1aO25mlMO7Ex3vfKJZsWRm3YCoAbgpWJ81m4g==
X-Received: by 2002:adf:ed89:0:b0:33e:34b7:895f with SMTP id
 c9-20020adfed89000000b0033e34b7895fmr644651wro.24.1712309131257; 
 Fri, 05 Apr 2024 02:25:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8e64:fc77:aa3a:87a?
 ([2a01:e0a:982:cbb0:8e64:fc77:aa3a:87a])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a5d638c000000b003432ffc3aeasm1557308wru.56.2024.04.05.02.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 02:25:30 -0700 (PDT)
Message-ID: <e33871b8-f994-4d69-8128-3f2fd3ffb602@linaro.org>
Date: Fri, 5 Apr 2024 11:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] phy: qcom: add Synopsys eUSB2 PHY driver
To: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
 <20240405-topic-sm8x50-usb-phy-v1-1-8a8604bf818f@linaro.org>
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
In-Reply-To: <20240405-topic-sm8x50-usb-phy-v1-1-8a8604bf818f@linaro.org>
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

On 05/04/2024 10:35, Neil Armstrong wrote:
> Add a driver for the new Synopsys eUSB2 PHY found in the SM8550
> and SM8650 SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/phy/qcom/Kconfig               |   8 +
>   drivers/phy/qcom/Makefile              |   1 +
>   drivers/phy/qcom/phy-qcom-snps-eusb2.c | 365 +++++++++++++++++++++++++++++++++
>   3 files changed, 374 insertions(+)
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index b9fe608c279..3aae1813352 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -27,6 +27,14 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
>   	  High-Speed PHY driver. This driver supports the Hi-Speed PHY which
>   	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
>   
> +config PHY_QCOM_SNPS_EUSB2
> +	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
> +	depends on PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
> +	  High-Speed PHY driver. This driver supports the Hi-Speed PHY which
> +	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
> +
>   config PHY_QCOM_USB_HS_28NM
>   	tristate "Qualcomm 28nm High-Speed PHY"
>   	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 5f4db4a5378..a5153061dfb 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -2,5 +2,6 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>   obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>   obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>   obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
> +obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
>   obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
>   obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
> diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
> new file mode 100644
> index 00000000000..853b88458b7
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023-2024, Linaro Limited
> + *
> + * Based on the Linux phy-qcom-snps-eusb2.c driver
> + */
> +
> +#include <clk.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <generic-phy.h>
> +#include <malloc.h>
> +#include <reset.h>
> +
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +
> +#define USB_PHY_UTMI_CTRL0		(0x3c)
> +#define SLEEPM				BIT(0)
> +#define OPMODE_MASK			GENMASK(4, 3)
> +#define OPMODE_NONDRIVING		BIT(3)
> +
> +#define USB_PHY_UTMI_CTRL5		(0x50)
> +#define POR				BIT(1)
> +
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
> +#define PHY_ENABLE			BIT(0)
> +#define SIDDQ_SEL			BIT(1)
> +#define SIDDQ				BIT(2)
> +#define RETENABLEN			BIT(3)
> +#define FSEL_MASK			GENMASK(6, 4)
> +#define FSEL_19_2_MHZ_VAL		(0x0)
> +#define FSEL_38_4_MHZ_VAL		(0x4)
> +
> +#define USB_PHY_CFG_CTRL_1		(0x58)
> +#define PHY_CFG_PLL_CPBIAS_CNTRL_MASK	GENMASK(7, 1)
> +
> +#define USB_PHY_CFG_CTRL_2		(0x5c)
> +#define PHY_CFG_PLL_FB_DIV_7_0_MASK	GENMASK(7, 0)
> +#define DIV_7_0_19_2_MHZ_VAL		(0x90)
> +#define DIV_7_0_38_4_MHZ_VAL		(0xc8)
> +
> +#define USB_PHY_CFG_CTRL_3		(0x60)
> +#define PHY_CFG_PLL_FB_DIV_11_8_MASK	GENMASK(3, 0)
> +#define DIV_11_8_19_2_MHZ_VAL		(0x1)
> +#define DIV_11_8_38_4_MHZ_VAL		(0x0)
> +
> +#define PHY_CFG_PLL_REF_DIV		GENMASK(7, 4)
> +#define PLL_REF_DIV_VAL			(0x0)
> +
> +#define USB_PHY_HS_PHY_CTRL2		(0x64)
> +#define VBUSVLDEXT0			BIT(0)
> +#define USB2_SUSPEND_N			BIT(2)
> +#define USB2_SUSPEND_N_SEL		BIT(3)
> +#define VBUS_DET_EXT_SEL		BIT(4)
> +
> +#define USB_PHY_CFG_CTRL_4		(0x68)
> +#define PHY_CFG_PLL_GMP_CNTRL_MASK	GENMASK(1, 0)
> +#define PHY_CFG_PLL_INT_CNTRL_MASK	GENMASK(7, 2)
> +
> +#define USB_PHY_CFG_CTRL_5		(0x6c)
> +#define PHY_CFG_PLL_PROP_CNTRL_MASK	GENMASK(4, 0)
> +#define PHY_CFG_PLL_VREF_TUNE_MASK	GENMASK(7, 6)
> +
> +#define USB_PHY_CFG_CTRL_6		(0x70)
> +#define PHY_CFG_PLL_VCO_CNTRL_MASK	GENMASK(2, 0)
> +
> +#define USB_PHY_CFG_CTRL_7		(0x74)
> +
> +#define USB_PHY_CFG_CTRL_8		(0x78)
> +#define PHY_CFG_TX_FSLS_VREF_TUNE_MASK	GENMASK(1, 0)
> +#define PHY_CFG_TX_FSLS_VREG_BYPASS	BIT(2)
> +#define PHY_CFG_TX_HS_VREF_TUNE_MASK	GENMASK(5, 3)
> +#define PHY_CFG_TX_HS_XV_TUNE_MASK	GENMASK(7, 6)
> +
> +#define USB_PHY_CFG_CTRL_9		(0x7c)
> +#define PHY_CFG_TX_PREEMP_TUNE_MASK	GENMASK(2, 0)
> +#define PHY_CFG_TX_RES_TUNE_MASK	GENMASK(4, 3)
> +#define PHY_CFG_TX_RISE_TUNE_MASK	GENMASK(6, 5)
> +#define PHY_CFG_RCAL_BYPASS		BIT(7)
> +
> +#define USB_PHY_CFG_CTRL_10		(0x80)
> +
> +#define USB_PHY_CFG0			(0x94)
> +#define DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
> +#define CMN_CTRL_OVERRIDE_EN		BIT(1)
> +
> +#define UTMI_PHY_CMN_CTRL0		(0x98)
> +#define TESTBURNIN			BIT(6)
> +
> +#define USB_PHY_FSEL_SEL		(0xb8)
> +#define FSEL_SEL			BIT(0)
> +
> +#define USB_PHY_APB_ACCESS_CMD		(0x130)
> +#define RW_ACCESS			BIT(0)
> +#define APB_START_CMD			BIT(1)
> +#define APB_LOGIC_RESET			BIT(2)
> +
> +#define USB_PHY_APB_ACCESS_STATUS	(0x134)
> +#define ACCESS_DONE			BIT(0)
> +#define TIMED_OUT			BIT(1)
> +#define ACCESS_ERROR			BIT(2)
> +#define ACCESS_IN_PROGRESS		BIT(3)
> +
> +#define USB_PHY_APB_ADDRESS		(0x138)
> +#define APB_REG_ADDR_MASK		GENMASK(7, 0)
> +
> +#define USB_PHY_APB_WRDATA_LSB		(0x13c)
> +#define APB_REG_WRDATA_7_0_MASK		GENMASK(3, 0)
> +
> +#define USB_PHY_APB_WRDATA_MSB		(0x140)
> +#define APB_REG_WRDATA_15_8_MASK	GENMASK(7, 4)
> +
> +#define USB_PHY_APB_RDDATA_LSB		(0x144)
> +#define APB_REG_RDDATA_7_0_MASK		GENMASK(3, 0)
> +
> +#define USB_PHY_APB_RDDATA_MSB		(0x148)
> +#define APB_REG_RDDATA_15_8_MASK	GENMASK(7, 4)
> +
> +struct qcom_snps_eusb2_phy_priv {
> +	void __iomem *base;
> +	struct clk *ref_clk;
> +	struct reset_ctl_bulk resets;
> +};
> +
> +static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
> +					     u32 mask, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(base + offset);
> +	reg &= ~mask;
> +	reg |= val & mask;
> +	writel_relaxed(reg, base + offset);
> +
> +	/* Ensure above write is completed */
> +	readl_relaxed(base + offset);
> +}
> +
> +static void qcom_eusb2_default_parameters(struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2)
> +{
> +	/* default parameters: tx pre-emphasis */
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_PREEMP_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_PREEMP_TUNE_MASK, 0));
> +
> +	/* tx rise/fall time */
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_RISE_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_RISE_TUNE_MASK, 0x2));
> +
> +	/* source impedance adjustment */
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_RES_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_RES_TUNE_MASK, 0x1));
> +
> +	/* dc voltage level adjustement */
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_8,
> +					 PHY_CFG_TX_HS_VREF_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_HS_VREF_TUNE_MASK, 0x3));
> +
> +	/* transmitter HS crossover adjustement */
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_8,
> +					 PHY_CFG_TX_HS_XV_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_HS_XV_TUNE_MASK, 0x0));
> +}
> +
> +static int qcom_eusb2_ref_clk_init(struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2)
> +{
> +	unsigned long ref_clk_freq = clk_get_rate(qcom_snps_eusb2->ref_clk);
> +
> +	switch (ref_clk_freq) {
> +	case 19200000:
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +						 FSEL_MASK,
> +						 FIELD_PREP(FSEL_MASK, FSEL_19_2_MHZ_VAL));
> +
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_2,
> +						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
> +						 DIV_7_0_19_2_MHZ_VAL);
> +
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
> +						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
> +						 DIV_11_8_19_2_MHZ_VAL);
> +		break;
> +
> +	case 38400000:
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +						 FSEL_MASK,
> +						 FIELD_PREP(FSEL_MASK, FSEL_38_4_MHZ_VAL));
> +
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_2,
> +						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
> +						 DIV_7_0_38_4_MHZ_VAL);
> +
> +		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
> +						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
> +						 DIV_11_8_38_4_MHZ_VAL);
> +		break;
> +
> +	default:
> +		printf("%s: unsupported ref_clk_freq:%lu\n", __func__, ref_clk_freq);
> +		return -EINVAL;
> +	}
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
> +					 PHY_CFG_PLL_REF_DIV, PLL_REF_DIV_VAL);
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_eusb2_usb_init(struct phy *phy)
> +{
> +	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG0,
> +					 CMN_CTRL_OVERRIDE_EN, CMN_CTRL_OVERRIDE_EN);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL5, POR, POR);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 PHY_ENABLE | RETENABLEN, PHY_ENABLE | RETENABLEN);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_APB_ACCESS_CMD,
> +					 APB_LOGIC_RESET, APB_LOGIC_RESET);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, UTMI_PHY_CMN_CTRL0, TESTBURNIN, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_FSEL_SEL,
> +					 FSEL_SEL, FSEL_SEL);
> +
> +	/* update ref_clk related registers */
> +	ret = qcom_eusb2_ref_clk_init(qcom_snps_eusb2);
> +	if (ret)
> +		return ret;
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_1,
> +					 PHY_CFG_PLL_CPBIAS_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_4,
> +					 PHY_CFG_PLL_INT_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_INT_CNTRL_MASK, 0x8));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_4,
> +					 PHY_CFG_PLL_GMP_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_GMP_CNTRL_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_5,
> +					 PHY_CFG_PLL_PROP_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_PROP_CNTRL_MASK, 0x10));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_6,
> +					 PHY_CFG_PLL_VCO_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_VCO_CNTRL_MASK, 0x0));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_5,
> +					 PHY_CFG_PLL_VREF_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_VREF_TUNE_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
> +					 VBUS_DET_EXT_SEL, VBUS_DET_EXT_SEL);
> +
> +	/* set default parameters */
> +	qcom_eusb2_default_parameters(qcom_snps_eusb2);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
> +					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
> +					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL0, SLEEPM, SLEEPM);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 SIDDQ_SEL, SIDDQ_SEL);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 SIDDQ, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL5, POR, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
> +					 USB2_SUSPEND_N_SEL, 0);
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_eusb2_phy_power_on(struct phy *phy)
> +{
> +	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	/* TODO Repeater */
> +
> +	clk_prepare_enable(qcom_snps_eusb2->ref_clk);
> +
> +	ret = reset_deassert_bulk(&qcom_snps_eusb2->resets);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_snps_eusb2_usb_init(phy);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_eusb2_phy_power_off(struct phy *phy)
> +{
> +	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
> +
> +	reset_assert_bulk(&qcom_snps_eusb2->resets);
> +	clk_disable_unprepare(qcom_snps_eusb2->ref_clk);
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_eusb2_phy_probe(struct udevice *dev)
> +{
> +	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(dev);
> +	int ret;
> +
> +	qcom_snps_eusb2->base = (void __iomem *)dev_read_addr(dev);
> +	if (IS_ERR(qcom_snps_eusb2->base))
> +		return PTR_ERR(qcom_snps_eusb2->base);
> +
> +	qcom_snps_eusb2->ref_clk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(qcom_snps_eusb2->ref_clk)) {
> +		printf("%s: failed to get ref clk %d\n", __func__, ret);
> +		return PTR_ERR(qcom_snps_eusb2->ref_clk);
> +	}
> +
> +	ret = reset_get_bulk(dev, &qcom_snps_eusb2->resets);
> +	if (ret < 0) {
> +		printf("failed to get resets, ret = %d\n", ret);
> +		return ret;

missing }

Will send a v2 after a few days.

Neil

> +
> +	return 0;
> +}
> +
> +static struct phy_ops qcom_snps_eusb2_phy_ops = {
> +	.power_on = qcom_snps_eusb2_phy_power_on,
> +	.power_off = qcom_snps_eusb2_phy_power_off,
> +};
> +
> +static const struct udevice_id qcom_snps_eusb2_phy_ids[] = {
> +	{
> +		.compatible = "qcom,sm8550-snps-eusb2-phy",
> +	},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(qcom_usb_qcom_snps_eusb2) = {
> +	.name = "qcom-snps-eusb2-hsphy",
> +	.id = UCLASS_PHY,
> +	.of_match = qcom_snps_eusb2_phy_ids,
> +	.ops = &qcom_snps_eusb2_phy_ops,
> +	.probe = qcom_snps_eusb2_phy_probe,
> +	.priv_auto = sizeof(struct qcom_snps_eusb2_phy_priv),
> +};
> 

