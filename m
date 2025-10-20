Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A4FCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 07:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2391D82C84;
	Mon, 20 Oct 2025 09:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W/ncX/m1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD1882E34; Mon, 20 Oct 2025 09:40:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9789E807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so42353505e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760946008; x=1761550808; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XV202iPWVNklgEM7kxqWx7RGTs7LIe4+XFFy8JPoLvY=;
 b=W/ncX/m1Iy9Zi8vUmTAI0BNIFYLhpa7VCtHj5jjrVJ0utGLRjCdpTEK1ReVIG4hpRc
 nI0zgVID+DWEPTjRo2Pn9ALSYH3PHflDLDOIsiePljbVtYYWOXmT4eQ2ZvtnPa3Yws2A
 pA+BHsQV+xksg2FgDyAgoQOZTGpAqBGXAuO6HCfO749daZEqYGM9WBK24gcSUucNQMu1
 P4A0JwXrhuTgh8Y9WR75U4FE5b2sDT3t4xGGwNqC5JvLe8kGIQh3RtIvZ/vZx1Yu8x+Q
 FLu9/5UqltCDbc9CEeHq8nwsQEug/xFhkAJS7BO2ug7FCIQ+ieCH03F9y0ds+GnG3gpS
 k3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760946008; x=1761550808;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XV202iPWVNklgEM7kxqWx7RGTs7LIe4+XFFy8JPoLvY=;
 b=jkVhd8gC3pPNKSwyNhNBIx9U3vI0M763igqeHRUKUxADRRuFlgtKVBy4jQ3GxPwOb2
 P9O9GHdGPFI5NmZNsWjpkcEYytQU4MrmSFSbcm1+yT9TL9jZifdMiOZk9X2G+FV7D3sg
 VgyUGV0hy/jsvyVIsZ47n3Z1zM0h/xi4kx7U43cDWsRD0nYbw0VOE0H0ux3tZBgp85TI
 rQZOW5MTzODBMezDafRVfmLqlCR/NqIwkc1EoUMTmJjzQ7bRZBNwKaQ1+YpApefhd9pT
 mS/q7SRMTW6MKql/XnIFXLFMzdiRmNweIIAMwoqPlg4slg3oPVr3f72z1Hpb1au5E84+
 x7ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYDR5c/b9H0u/wm4hyS5WOlTU4kL/a+KgjFDouzAxiVbI015bnfGZcwP6S9psGHwgRbai4uzE=@lists.denx.de
X-Gm-Message-State: AOJu0YwxPtedDNW/N0ido6cTD6YGWSReC0j/RmodXBLvdik/S97takI/
 hetHZu9ZlvXdgX41+X/Iy83/fQUD72ViDq32HNB5P5RBy8Z+7I5x67YHoQwfTnjT5Hw=
X-Gm-Gg: ASbGncvYVwvj0hyn93tRMRwSqdwIQvrPrA8ZAO6K6xu2SYcxbph0sJm32vFWCgIh3ae
 gAGfdTNMV0am+c8vECSo39TlQhEQJJp8IIC1AWtsHb9Mpkg/RYuA3ViAfNaGFj03N9hpXWEUCV5
 3tUt18Or+GhOtTMybw7BW+EZxl+OuT7RFZHEZmZ5/nIY9vmuaRtekssmtf8ca904BumwwFn4dXf
 bY8GBEIsSBRLCBEgm2SXp48X5KgXTUOj4w7G+RFaDddlV/cLMFDJYhLagHlL/Ukk0STXaoQ+8vh
 XIJdWG3YgXw429nNgF45C0H7Hd4re9WxQ8KYM9WaV9yLwDGw6IrC0kfLIM12s71U9sB/Pg0SlAw
 OPfVW+fQnBIlBQW5XHEYVGrjCjKQ4TicuXm+bqA9xSgKCK3pMBht67T3Q4+zPwVTgqvqAH0CGMe
 ueJXPLnPCCvRJqLoNFnZyXKa2rYvgyKeMWY2nY8QWDzPqViKbdUQttIprafnif
X-Google-Smtp-Source: AGHT+IGGSsU+VJFQx4L1jOb8dOUwOCh7KZ+XdnYK++gW9c5x+NsUPZtnEDfTPevGE1o8lYmOkIHj4A==
X-Received: by 2002:a05:600c:190f:b0:46e:49fd:5e30 with SMTP id
 5b1f17b1804b1-471178705b0mr92916335e9.6.1760946007819; 
 Mon, 20 Oct 2025 00:40:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4f9c:f978:568:7b9c?
 ([2a01:e0a:3d9:2080:4f9c:f978:568:7b9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d753sm130880205e9.13.2025.10.20.00.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:40:07 -0700 (PDT)
Message-ID: <02a28eba-57b8-43c3-b432-fb2bb22c504b@linaro.org>
Date: Mon, 20 Oct 2025 09:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] ufs: rockchip: Add initial support
To: Shawn Lin <shawn.lin@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>, YiFeng Zhao <zyf@rock-chips.com>, 
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
 <1760923754-47718-2-git-send-email-shawn.lin@rock-chips.com>
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
In-Reply-To: <1760923754-47718-2-git-send-email-shawn.lin@rock-chips.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/20/25 03:29, Shawn Lin wrote:
> This patch adds initial support for UFS controller on Rockchip
> platforms.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> Changes since v1:
> 
> - remove unused structures from header file
> - correct U-Boot driver name
> 
> ---
>   MAINTAINERS                |   1 +
>   drivers/ufs/Kconfig        |   9 ++
>   drivers/ufs/Makefile       |   1 +
>   drivers/ufs/ufs-rockchip.c | 211 +++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-rockchip.h |  88 ++++++++++++++++
>   5 files changed, 310 insertions(+)
>   create mode 100644 drivers/ufs/ufs-rockchip.c
>   create mode 100644 drivers/ufs/ufs-rockchip.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 671903605d1..ee4ab3711b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -575,6 +575,7 @@ F:	drivers/mmc/rockchip_dw_mmc.c
>   F:	drivers/pinctrl/rockchip/
>   F:	drivers/ram/rockchip/
>   F:	drivers/sysreset/sysreset_rockchip.c
> +F:	drivers/ufs/*rockchip*
>   F:	drivers/video/rockchip/
>   F:	tools/rkcommon.c
>   F:	tools/rkcommon.h
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index b08ca08b07c..3d367855173 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -33,6 +33,15 @@ config QCOM_UFS
>   	  This selects the platform driver for the UFS host
>   	  controller present on Qualcomm Snapdragon SoCs.
>   
> +config ROCKCHIP_UFS
> +	bool "Rockchip specific hooks to UFS controller platform driver"
> +	depends on UFS
> +	help
> +	  This selects the Rockchip specific additions to UFSHCD platform driver.
> +
> +	  Select this if you have UFS controller on Rockchip chipset.
> +	  If unsure, say N.
> +
>   config TI_J721E_UFS
>   	bool "Glue Layer driver for UFS on TI J721E devices"
>   	help
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 2a378e45111..41e910cfc51 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
>   obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
>   obj-$(CONFIG_UFS_PCI) += ufs-pci.o
>   obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
> +obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
>   obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> new file mode 100644
> index 00000000000..c8578fae2c0
> --- /dev/null
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Rockchip UFS Host Controller driver
> + *
> + * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <reset.h>
> +#include <ufs.h>
> +
> +#include "ufs.h"
> +#include "unipro.h"
> +#include "ufs-rockchip.h"
> +
> +static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
> +					  enum ufs_notify_change_status status)
> +{
> +	int err = 0;
> +
> +	if (status != POST_CHANGE)
> +		return 0;
> +
> +	ufshcd_dme_reset(hba);
> +	ufshcd_dme_enable(hba);
> +
> +	if (hba->ops->phy_initialization) {
> +		err = hba->ops->phy_initialization(hba);
> +		if (err)
> +			dev_err(hba->dev,
> +				"Phy init failed (%d)\n", err);
> +	}
> +
> +	return err;
> +}
> +
> +static void ufs_rockchip_rk3576_phy_parameter_init(struct ufs_hba *hba)
> +{
> +	struct ufs_rockchip_host *host = dev_get_priv(hba->dev);
> +
> +	ufs_sys_writel(host->mphy_base, 0x80, CMN_REG23);
> +	ufs_sys_writel(host->mphy_base, 0xB5, TRSV0_REG14);
> +	ufs_sys_writel(host->mphy_base, 0xB5, TRSV1_REG14);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG15);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG15);
> +	ufs_sys_writel(host->mphy_base, 0x38, TRSV0_REG08);
> +	ufs_sys_writel(host->mphy_base, 0x38, TRSV1_REG08);
> +	ufs_sys_writel(host->mphy_base, 0x50, TRSV0_REG29);
> +	ufs_sys_writel(host->mphy_base, 0x50, TRSV1_REG29);
> +	ufs_sys_writel(host->mphy_base, 0x80, TRSV0_REG2E);
> +	ufs_sys_writel(host->mphy_base, 0x80, TRSV1_REG2E);
> +	ufs_sys_writel(host->mphy_base, 0x18, TRSV0_REG3C);
> +	ufs_sys_writel(host->mphy_base, 0x18, TRSV1_REG3C);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG16);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG16);
> +	ufs_sys_writel(host->mphy_base, 0x20, TRSV0_REG17);
> +	ufs_sys_writel(host->mphy_base, 0x20, TRSV1_REG17);
> +	ufs_sys_writel(host->mphy_base, 0xC0, TRSV0_REG18);
> +	ufs_sys_writel(host->mphy_base, 0xC0, TRSV1_REG18);
> +	ufs_sys_writel(host->mphy_base, 0x03, CMN_REG25);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV0_REG3D);
> +	ufs_sys_writel(host->mphy_base, 0x03, TRSV1_REG3D);
> +	ufs_sys_writel(host->mphy_base, 0xC0, CMN_REG23);
> +	udelay(1);
> +	ufs_sys_writel(host->mphy_base, 0x00, CMN_REG23);
> +	udelay(200);
> +}
> +
> +static int ufs_rockchip_rk3576_phy_init(struct ufs_hba *hba)
> +{
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(PA_LOCAL_TX_LCC_ENABLE, 0x0), 0x0);
> +	/* enable the mphy DME_SET cfg */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_ENABLE);
> +	for (int i = 0; i < 2; i++) {
> +		/* Configuration M-TX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD, SEL_TX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD_EN, SEL_TX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_VALUE, SEL_TX_LANE0 + i), 0x44);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE1, SEL_TX_LANE0 + i), 0xe6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE2, SEL_TX_LANE0 + i), 0x07);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_TASE_VALUE, SEL_TX_LANE0 + i), 0x93);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_BASE_NVALUE, SEL_TX_LANE0 + i), 0xc9);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_POWER_SAVING_CTRL, SEL_TX_LANE0 + i), 0x00);
> +		/* Configuration M-RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD, SEL_RX_LANE0 + i), 0x06);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD_EN, SEL_RX_LANE0 + i), 0x00);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE, SEL_RX_LANE0 + i), 0x58);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE1, SEL_RX_LANE0 + i), 0x8c);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_PVALUE2, SEL_RX_LANE0 + i), 0x02);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_OPTION, SEL_RX_LANE0 + i), 0xf6);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_POWER_SAVING_CTRL, SEL_RX_LANE0 + i), 0x69);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_SAVE_DET_CTRL, SEL_RX_LANE0 + i), 0x18);
> +	}
> +
> +	/* disable the mphy DME_SET cfg */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MPHY_CFG, 0x0), MPHY_CFG_DISABLE);
> +
> +	ufs_rockchip_rk3576_phy_parameter_init(hba);
> +
> +	/* start link up */
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_TX_ENDIAN, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(MIB_T_DBG_CPORT_RX_ENDIAN, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID, 0), 0x0);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(N_DEVICEID_VALID, 0), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_PEERDEVICEID, 0), 0x1);
> +	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(T_CONNECTIONSTATE, 0), 0x1);
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_common_init(struct ufs_hba *hba)
> +{
> +	struct udevice *dev = hba->dev;
> +	struct ufs_rockchip_host *host = dev_get_priv(dev);
> +	struct resource res;
> +	int err = 0;

No need to initialize at 0 here

> +
> +	/* system control register for hci */
> +	err = dev_read_resource_byname(dev, "hci_grf", &res);
> +	if (err) {
> +		dev_err(dev, "cannot ioremap for hci system control register\n");
> +		return -ENODEV;

Just return err

> +	}
> +	host->ufs_sys_ctrl = (void *)(res.start);
> +
> +	/* system control register for mphy */
> +	err = dev_read_resource_byname(dev, "mphy_grf", &res);
> +	if (err) {
> +		dev_err(dev, "cannot ioremap for mphy system control register\n");
> +		return -ENODEV;

Ditto

> +	}
> +	host->ufs_phy_ctrl = (void *)(res.start);
> +
> +	/* mphy base register */
> +	err = dev_read_resource_byname(dev, "mphy", &res);
> +	if (err) {
> +		dev_err(dev, "cannot ioremap for mphy base register\n");
> +		return -ENODEV;

Ditto

> +	}
> +	host->mphy_base = (void *)(res.start);
> +
> +	host->phy_config_mode = dev_read_u32_default(dev, "ufs-phy-config-mode", 0);
> +
> +	err = reset_get_bulk(dev, &host->rsts);
> +	if (err) {
> +		dev_err(dev, "Can't get reset: %d\n", err);
> +		return err;
> +	}
> +
> +	host->hba = hba;
> +
> +	return 0;
> +}
> +
> +static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
> +{
> +	int ret = 0;
> +
> +	ret = ufs_rockchip_common_init(hba);
> +	if (ret) {
> +		dev_err(hba->dev, "%s: ufs common init fail\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct ufs_hba_ops ufs_hba_rk3576_vops = {
> +	.init = ufs_rockchip_rk3576_init,
> +	.phy_initialization = ufs_rockchip_rk3576_phy_init,
> +	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
> +};
> +
> +static const struct udevice_id ufs_rockchip_of_match[] = {
> +	{ .compatible = "rockchip,rk3576-ufshc", .data = (ulong)&ufs_hba_rk3576_vops},
> +	{},
> +};
> +
> +static int ufs_rockchip_probe(struct udevice *dev)
> +{
> +	struct ufs_hba_ops *ops = (struct ufs_hba_ops *)dev_get_driver_data(dev);
> +	int err;
> +
> +	err = ufshcd_probe(dev, ops);
> +	if (err)
> +		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
> +
> +	return err;
> +}
> +
> +static int ufs_rockchip_bind(struct udevice *dev)
> +{
> +	struct udevice *scsi_dev;
> +
> +	return ufs_scsi_bind(dev, &scsi_dev);
> +}
> +
> +U_BOOT_DRIVER(rockchip_ufs) = {
> +	.name		= "ufshcd-rockchip",
> +	.id		= UCLASS_UFS,
> +	.of_match	= ufs_rockchip_of_match,
> +	.probe		= ufs_rockchip_probe,
> +	.bind		= ufs_rockchip_bind,
> +	.priv_auto	= sizeof(struct ufs_rockchip_host),
> +};
> diff --git a/drivers/ufs/ufs-rockchip.h b/drivers/ufs/ufs-rockchip.h
> new file mode 100644
> index 00000000000..b6d44dcc4b3
> --- /dev/null
> +++ b/drivers/ufs/ufs-rockchip.h
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Rockchip UFS Host Controller driver
> + *
> + * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
> + */
> +
> +#ifndef _UFS_ROCKCHIP_H_
> +#define _UFS_ROCKCHIP_H_
> +
> +#define UFS_MAX_CLKS 3
> +
> +#define SEL_TX_LANE0			0x0
> +#define SEL_TX_LANE1			0x1
> +#define SEL_TX_LANE2			0x2
> +#define SEL_TX_LANE3			0x3
> +#define SEL_RX_LANE0			0x4
> +#define SEL_RX_LANE1			0x5
> +#define SEL_RX_LANE2			0x6
> +#define SEL_RX_LANE3			0x7
> +
> +#define VND_TX_CLK_PRD                  0xAA
> +#define VND_TX_CLK_PRD_EN               0xA9
> +#define VND_TX_LINERESET_PVALUE2        0xAB
> +#define VND_TX_LINERESET_PVALUE1        0xAC
> +#define VND_TX_LINERESET_VALUE          0xAD
> +#define VND_TX_BASE_NVALUE              0x93
> +#define VND_TX_TASE_VALUE               0x94
> +#define VND_TX_POWER_SAVING_CTRL        0x7F
> +#define VND_RX_CLK_PRD                  0x12
> +#define VND_RX_CLK_PRD_EN               0x11
> +#define VND_RX_LINERESET_PVALUE2        0x1B
> +#define VND_RX_LINERESET_PVALUE1        0x1C
> +#define VND_RX_LINERESET_VALUE          0x1D
> +#define VND_RX_LINERESET_OPTION         0x25
> +#define VND_RX_POWER_SAVING_CTRL        0x2F
> +#define VND_RX_SAVE_DET_CTRL            0x1E
> +
> +#define CMN_REG23                       0x8C
> +#define CMN_REG25                       0x94
> +#define TRSV0_REG08                     0xE0
> +#define TRSV1_REG08                     0x220
> +#define TRSV0_REG14                     0x110
> +#define TRSV1_REG14                     0x250
> +#define TRSV0_REG15                     0x134
> +#define TRSV1_REG15                     0x274
> +#define TRSV0_REG16                     0x128
> +#define TRSV1_REG16                     0x268
> +#define TRSV0_REG17                     0x12C
> +#define TRSV1_REG17                     0x26c
> +#define TRSV0_REG18                     0x120
> +#define TRSV1_REG18                     0x260
> +#define TRSV0_REG29                     0x164
> +#define TRSV1_REG29                     0x2A4
> +#define TRSV0_REG2E                     0x178
> +#define TRSV1_REG2E                     0x2B8
> +#define TRSV0_REG3C                     0x1B0
> +#define TRSV1_REG3C                     0x2F0
> +#define TRSV0_REG3D                     0x1B4
> +#define TRSV1_REG3D                     0x2F4
> +
> +#define MPHY_CFG                        0x200
> +#define MPHY_CFG_ENABLE                 0x40
> +#define MPHY_CFG_DISABLE                0x0
> +
> +#define MIB_T_DBG_CPORT_TX_ENDIAN	0xc022
> +#define MIB_T_DBG_CPORT_RX_ENDIAN	0xc023
> +
> +struct ufs_rockchip_host {
> +	struct ufs_hba *hba;
> +	void __iomem *ufs_phy_ctrl;
> +	void __iomem *ufs_sys_ctrl;
> +	void __iomem *mphy_base;
> +	struct reset_ctl_bulk rsts;
> +	struct clk ref_out_clk;
> +	uint64_t caps;
> +	uint32_t phy_config_mode;
> +};
> +
> +#define ufs_sys_writel(base, val, reg)	\
> +	writel((val), (base) + (reg))
> +#define ufs_sys_readl(base, reg) readl((base) + (reg))
> +#define ufs_sys_set_bits(base, mask, reg)	\
> +	ufs_sys_writel((base), ((mask) | (ufs_sys_readl((base), (reg)))), (reg))
> +#define ufs_sys_ctrl_clr_bits(base, mask, reg)	\
> +	ufs_sys_writel((base), ((~(mask)) & (ufs_sys_readl((base), (reg)))), (reg))
> +
> +#endif /* _UFS_ROCKCHIP_H_ */

Otherwise loooks good,with the commens fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
