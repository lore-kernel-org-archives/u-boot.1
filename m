Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA7ECFA773
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AE180433;
	Fri, 21 Nov 2025 11:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cwq9yfdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98BA835FD; Fri, 21 Nov 2025 11:46:21 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8DC802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so10279305e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763721978; x=1764326778; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0+byQWc/Zir0vxV973jfGWk6FiIU18YcdzMCB8mExrY=;
 b=cwq9yfdxXjdZ38PfxeUn1g5BbIoLaj3Nvq3GALE3Z+85EOXFzhBiRKJF2/yCjcSN7n
 TybEYXgx/VTFg/jOh0FVzUaWlxpcWrPtIDBg5ejpzKcoTIOmE7PBkKlduAunEDv0FbMG
 mBMRhEp2OeEkyKR43w6+Q/Yegqy7xXZh07dLOeNQYhnuJPoF3oPZvywUtnU5cmotCOPf
 FmJw7Eea51gln6rFe9YEdt6eO4UD4+09ZYTy62Kc6gC/gOTd2FLvbZzrNhhhpMXyur3+
 XFCMSSynNDs3YpYAGCaBdxyImBe7oVxcxB5ahW8hV5mUoa0w8nG0WC3hgp3TxP3YebPv
 Ypow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763721978; x=1764326778;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+byQWc/Zir0vxV973jfGWk6FiIU18YcdzMCB8mExrY=;
 b=LRVQNIYysZy4bJ/Uxm1mS98iJmAIhc3TvkGvSGt7i1n1SJeUvgrNpp6OHmHn9dZVq7
 Ra+QyqZvyJeFdo9GoUJUCyNC7vJjqX57i55hCZ0imQOkL44IGv06Rlv/mMMMJwFoVwip
 Ow+4rgziezBZRnjkXlFNQxP4h/lUip/BYowuuq5gtAwNNcSLh3J3CzvDY5ELPqadG/Do
 P+fjNk+eJEjDVrigog7C/9/BxyRGsbkUww3OPmwDw1vlcWMdDipAOt7J9q2CpxdxXZSf
 7Yo8W1OOibQxgXFqslXnrtW52S2WacL/vBPm30T2mAGwmo69se/a2umvQTxnppMmYOI1
 uIzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2t3up5Mkt/yqvDsSfgq5cbxbOaarZyRyH3InkrNnO0B0Hyb3Mxts5+qLm9DGpE1yPHDVel54=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6YtjQb3VyjQyfzgcQ1TuqGjjONkiMZ0PGoA/4hNFJWS5OMVmZ
 +UUog/JKEOPT+ipwISb0Vac7VsEVHFDtup5EBlMj/rD7/XC4YW4JgphSQ5OOaOlLB5A=
X-Gm-Gg: ASbGncuUaMBhAtKI12XlVPr03bqsVTgcX72jVozcq6RKososlMcxW/HioIXDb4wAz0M
 9D5AnpT1XuAXBV6AK6/4D4e7e4MAC2d5uKlZOwQr1fGT5CzIfkFTRvNKMU/NZeb8s3J/3bgHLm3
 3Dlbs8TDvD01Carv/rQSHVeaEbtyUxenk8josdE7BooXLwECjyu3YcBYec8wWptwKkTjDDR24vJ
 7snwJYlFdCiDbxmAbwcNZ8V0a1IgZMYES4rlz9NbzrU+fUXAVbHFtStyURCCrwmlKnf7QHbJt8/
 0OSL4fuc0GEgMxXUlnftH/Oc97j377KY7wSEFRrgqYcYb4/dc3mBFKLwSf6UZUlV5+PyT0A0IOr
 +YNwSCRLfOuq5zGS7In/Xy9YeWGW84QnYmPgKjId7NkB9yP4C63xK+4js8ZaqCdU4JiJ9DpSwi6
 IM0HCjflfedx/obnTN7Qfpsjzj7/uJ9hiFTIvVaoubAcBEuRPTEdgPvNczP806nL8=
X-Google-Smtp-Source: AGHT+IHcGClb74jl8RWJMb/U54C1F86F1i+yy6ZEcEp5pf9o0keC2n+LHZR+6T7i/EG3xmdkSZw2ug==
X-Received: by 2002:a05:600c:a08:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-477c11254damr16295185e9.23.1763721977660; 
 Fri, 21 Nov 2025 02:46:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:159f:1839:bb92:1eca?
 ([2a01:e0a:3d9:2080:159f:1839:bb92:1eca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aafb3sm85023705e9.0.2025.11.21.02.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 02:46:17 -0800 (PST)
Message-ID: <6500cdbc-b7e5-481e-a9ff-385aefa0921b@linaro.org>
Date: Fri, 21 Nov 2025 11:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
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

Hi,

On 11/19/25 16:25, Balaji Selvanathan wrote:
> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
> SC7280 and QCM6490 platforms. This driver currently implements
> USB3 super-speed functionality of the combo PHY.
> 
> The QMP Combo PHY is a dual-mode PHY
> that can operate in either USB3 mode or DisplayPort mode. This
> initial implementation focuses on USB3 mode to enable Super-Speed
> USB support.
> 
> This is a port of the upstream Linux files to U-Boot:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0
> 
> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/Kconfig                   |   8 +
>   drivers/phy/qcom/Makefile                  |   1 +
>   drivers/phy/qcom/phy-qcom-qmp-combo.c      | 503 +++++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 +++
>   drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
>   drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
>   7 files changed, 643 insertions(+)
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 0dd69f7ffd0..4be18628b4d 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -12,6 +12,14 @@ config PHY_QCOM_IPQ4019_USB
>   	help
>   	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
>   
> +config PHY_QCOM_QMP_COMBO
> +	tristate "Qualcomm QMP USB3-DP Combo PHY driver"
> +	depends on PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the USB3-DP Combo QMP PHY on various Qualcomm
> +	  chipsets. This driver supports the USB3 PHY functionality of the combo
> +	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
> +
>   config PHY_QCOM_QMP_PCIE
>   	tristate "Qualcomm QMP PCIe PHY driver"
>   	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 1c4e7d8d391..714013dc572 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -1,5 +1,6 @@
>   obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>   obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
> +obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
>   obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
>   obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
>   obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> new file mode 100644
> index 00000000000..74d67b0b96b
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> @@ -0,0 +1,503 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <reset.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/err.h>
> +
> +#include "phy-qcom-qmp-common.h"
> +
> +#include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-pcs-misc-v3.h"
> +#include "phy-qcom-qmp-pcs-usb-v4.h"
> +#include "phy-qcom-qmp-dp-com-v3.h"
> +
> +/* QPHY_V3_DP_COM_RESET_OVRD_CTRL register bits */
> +/* DP PHY soft reset */
> +#define SW_DPPHY_RESET                          BIT(0)
> +/* mux to select DP PHY reset control, 0:HW control, 1: software reset */
> +#define SW_DPPHY_RESET_MUX                      BIT(1)
> +/* USB3 PHY soft reset */
> +#define SW_USB3PHY_RESET                        BIT(2)
> +/* mux to select USB3 PHY reset control, 0:HW control, 1: software reset */
> +#define SW_USB3PHY_RESET_MUX                    BIT(3)
> +
> +/* QPHY_V3_DP_COM_PHY_MODE_CTRL register bits */
> +#define USB3_MODE                               BIT(0) /* enables USB3 mode */
> +#define DP_MODE                                 BIT(1) /* enables DP mode */
> +
> +/* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
> +#define SW_PORTSELECT_MUX                       BIT(1)
> +
> +#define PHY_INIT_COMPLETE_TIMEOUT		10000
> +
> +struct qmp_combo_offsets {
> +	u16 com;
> +	u16 txa;
> +	u16 rxa;
> +	u16 txb;
> +	u16 rxb;
> +	u16 usb3_serdes;
> +	u16 usb3_pcs_misc;
> +	u16 usb3_pcs;
> +	u16 usb3_pcs_usb;
> +};
> +
> +/*
> + * Initialisation tables
> + */
> +
> +static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
> +	.com		= 0x0000,
> +	.txa		= 0x1200,
> +	.rxa		= 0x1400,
> +	.txb		= 0x1600,
> +	.rxb		= 0x1800,
> +	.usb3_serdes	= 0x1000,
> +	.usb3_pcs_misc	= 0x1a00,
> +	.usb3_pcs	= 0x1c00,
> +	.usb3_pcs_usb	= 0x1f00,
> +};
> +
> +static const struct qmp_phy_init_tbl sm8150_usb3_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0xde),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_IPTRIM, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_TX, 0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_RX, 0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x40, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x54, 2),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0xff, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f, 2),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f, 1),
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff, 2),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x97),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VTH_CODE, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8250_usb3_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +};
> +
> +struct qmp_phy_cfg {
> +	const struct qmp_combo_offsets *offsets;
> +	const struct qmp_phy_init_tbl *serdes_tbl;
> +	int serdes_tbl_num;
> +	const struct qmp_phy_init_tbl *tx_tbl;
> +	int tx_tbl_num;
> +	const struct qmp_phy_init_tbl *rx_tbl;
> +	int rx_tbl_num;
> +	const struct qmp_phy_init_tbl *pcs_tbl;
> +	int pcs_tbl_num;
> +	const struct qmp_phy_init_tbl *pcs_usb_tbl;
> +	int pcs_usb_tbl_num;
> +	/* true, if PHY needs delay after POWER_DOWN */
> +	bool has_pwrdn_delay;
> +};
> +
> +struct qmp_combo {
> +	struct udevice *dev;
> +	void __iomem *com;
> +	void __iomem *serdes;
> +	void __iomem *tx;
> +	void __iomem *rx;
> +	void __iomem *tx2;
> +	void __iomem *rx2;
> +	void __iomem *pcs;
> +	void __iomem *pcs_usb;
> +	void __iomem *pcs_misc;
> +	struct clk_bulk clks;
> +	struct clk *pipe_clk;
> +	int num_clks;
> +	struct reset_ctl_bulk resets;
> +	int num_resets;
> +	const struct qmp_phy_cfg *cfg;
> +};
> +
> +static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg |= val;
> +	writel(reg, base + offset);
> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +	u32 reg;
> +
> +	reg = readl(base + offset);
> +	reg &= ~val;
> +	writel(reg, base + offset);
> +
> +	/* ensure that above write is through */
> +	readl(base + offset);
> +}
> +
> +static int qmp_combo_power_on(struct phy *phy)
> +{
> +	struct qmp_combo *qmp = dev_get_priv(phy->dev);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *serdes = qmp->serdes;
> +	void __iomem *tx = qmp->tx;
> +	void __iomem *rx = qmp->rx;
> +	void __iomem *tx2 = qmp->tx2;
> +	void __iomem *rx2 = qmp->rx2;
> +	void __iomem *pcs = qmp->pcs;
> +	void __iomem *pcs_usb = qmp->pcs_usb;
> +	void __iomem *com = qmp->com;
> +	u32 val;
> +	int ret;
> +
> +	/* Assert and then deassert resets */
> +	ret = reset_assert_bulk(&qmp->resets);
> +	if (ret) {
> +		printf("Failed to assert resets: %d\n", ret);
> +		return ret;
> +	}

Please add blank line here

> +	ret = reset_deassert_bulk(&qmp->resets);
> +	if (ret) {
> +		printf("Failed to deassert resets: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable clocks */
> +	ret = clk_enable_bulk(&qmp->clks);
> +	if (ret) {
> +		printf("Failed to enable clocks: %d\n", ret);
> +		reset_assert_bulk(&qmp->resets); /* Assert resets on error */
> +		return ret;
> +	}
> +
> +	/* Common block register writes */
> +	qphy_setbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
> +	qphy_setbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +		     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +
> +	val = SW_PORTSELECT_MUX;
> +	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
> +
> +	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +		     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +
> +	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
> +
> +	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> +
> +	qphy_setbits(pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +
> +	/* Serdes configuration */
> +	qmp_configure(qmp->dev, serdes, qmp->cfg->serdes_tbl, qmp->cfg->serdes_tbl_num);
> +
> +	ret = clk_prepare_enable(qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "pipe_clk enable failed err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Tx, Rx configurations */
> +	qmp_configure_lane(qmp->dev, tx, qmp->cfg->tx_tbl, qmp->cfg->tx_tbl_num, 1);
> +	qmp_configure_lane(qmp->dev, tx2, qmp->cfg->tx_tbl, qmp->cfg->tx_tbl_num, 2);
> +
> +	qmp_configure_lane(qmp->dev, rx, qmp->cfg->rx_tbl, qmp->cfg->rx_tbl_num, 1);
> +	qmp_configure_lane(qmp->dev, rx2, qmp->cfg->rx_tbl, qmp->cfg->rx_tbl_num, 2);
> +
> +	/* PCS configuration */
> +	qmp_configure(qmp->dev, pcs, qmp->cfg->pcs_tbl, qmp->cfg->pcs_tbl_num);
> +
> +	if (pcs_usb) {
> +		qmp_configure(qmp->dev, pcs_usb,
> +			      qmp->cfg->pcs_usb_tbl,
> +			      qmp->cfg->pcs_usb_tbl_num);
> +	}
> +
> +	if (cfg->has_pwrdn_delay)
> +		udelay(20);
> +
> +	/* Pull PHY out of reset */
> +	qphy_clrbits(pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
> +
> +	/* Start SerDes and Phy-Coding-Sublayer */
> +	qphy_setbits(pcs, QPHY_V4_PCS_START_CONTROL,
> +		     SERDES_START | PCS_START);
> +
> +	/* Wait for PHY initialization */
> +	ret = readl_poll_timeout(pcs + QPHY_V4_PCS_PCS_STATUS1, val,
> +				 !(val & PHYSTATUS), PHY_INIT_COMPLETE_TIMEOUT);
> +
> +	if (ret) {
> +		printf("QMP USB3 PHY initialization timeout\n");
> +		clk_disable_bulk(&qmp->clks);
> +		reset_assert_bulk(&qmp->resets);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmp_combo_power_off(struct phy *phy)
> +{
> +	struct qmp_combo *qmp = dev_get_priv(phy->dev);
> +	void __iomem *com = qmp->com;

You don't disable the pipe_clk ??

> +
> +	/* PHY reset */
> +	qphy_setbits(qmp->pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
> +
> +	/* Stop SerDes and Phy-Coding-Sublayer */
> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_START_CONTROL,
> +		     SERDES_START | PCS_START);
> +
> +	/* Put PHY into POWER DOWN state: active low */
> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +
> +	/* Power down common block */
> +	qphy_clrbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
> +
> +	/* Disable clocks */
> +	clk_disable_bulk(&qmp->clks);
> +
> +	/* Assert resets */
> +	reset_assert_bulk(&qmp->resets);
> +
> +	return 0;
> +}
> +
> +static int qmp_combo_reset_init(struct qmp_combo *qmp)
> +{
> +	struct udevice *dev = qmp->dev;
> +	int ret;
> +
> +	ret = reset_get_bulk(dev, &qmp->resets);
> +	if (ret) {
> +		printf("Failed to get resets: %d\n", ret);
> +		return ret;
> +	}
> +
> +	qmp->num_resets = qmp->resets.count;
> +
> +	return 0;
> +}
> +
> +static int qmp_combo_clk_init(struct qmp_combo *qmp)
> +{
> +	struct udevice *dev = qmp->dev;
> +	int ret;
> +
> +	ret = clk_get_bulk(dev, &qmp->clks);

This can't work well, you need to get all clocks except the pipe_clk,
please add back the clocks list qmp_combo_phy_clk_l ands get them
all separately.

> +
> +	if (!ret)
> +		qmp->num_clks = qmp->clks.count;
> +
> +	return ret;
> +}
> +
> +static int qmp_combo_parse_dt(struct qmp_combo *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_combo_offsets *offs = cfg->offsets;
> +	struct udevice *dev = qmp->dev;
> +	void __iomem *base;
> +	int ret;
> +
> +	if (!offs)
> +		return -EINVAL;
> +
> +	base = (void __iomem *)dev_read_addr(dev);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	qmp->com = base + offs->com;
> +	qmp->serdes = base + offs->usb3_serdes;
> +	qmp->tx = base + offs->txa;
> +	qmp->rx = base + offs->rxa;
> +	qmp->tx2 = base + offs->txb;
> +	qmp->rx2 = base + offs->rxb;
> +	qmp->pcs = base + offs->usb3_pcs;
> +	qmp->pcs_usb = base + offs->usb3_pcs_usb;
> +	qmp->pcs_misc = base + offs->usb3_pcs_misc; /* Assign pcs_misc */
> +
> +	ret = qmp_combo_clk_init(qmp);
> +	if (ret)
> +		return ret;
> +
> +	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
> +	if (IS_ERR(qmp->pipe_clk)) {
> +		dev_err(dev, "failed to get pipe clock (%ld)\n",
> +			PTR_ERR(qmp->pipe_clk));
> +		return ret;
> +	}
> +
> +	ret = qmp_combo_reset_init(qmp);
> +	if (ret)
> +		return ret;

No support for power supplies ? Please add support for them

> +
> +	return 0;
> +}
> +
> +static int qmp_combo_probe(struct udevice *dev)
> +{
> +	struct qmp_combo *qmp = dev_get_priv(dev);
> +	int ret;
> +
> +	qmp->dev = dev;
> +	/* Get configuration from device match data */
> +	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
> +	if (!qmp->cfg) {
> +		printf("Failed to get PHY configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = qmp_combo_parse_dt(qmp);
> +
> +	return ret;
> +}
> +
> +static const struct qmp_phy_cfg sc7280_usb3dpphy_cfg = {
> +	.offsets		= &qmp_combo_offsets_v3,
> +	.serdes_tbl		= sm8150_usb3_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
> +	.tx_tbl			= sm8250_usb3_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_tx_tbl),
> +	.rx_tbl			= sm8250_usb3_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_rx_tbl),
> +	.pcs_tbl		= sm8250_usb3_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
> +	.pcs_usb_tbl		= sm8250_usb3_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_pcs_usb_tbl),
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
> +static struct phy_ops qmp_combo_ops = {
> +	.init = qmp_combo_power_on,
> +	.exit = qmp_combo_power_off,

Add a minimal xlate to only return the USB3 phy:

static int qmp_combo_xlate(struct phy *phy, struct ofnode_phandle_args *args)
{
	if (args->args_count != 1) {
		debug("Invalid args_count: %d\n", args->args_count);
		return -EINVAL;
	}

	/* We only support the USB3 phy at slot 0 */
	if (args->args[0] == QMP_USB43DP_DP_PHY)
		return -EINVAL;

	phy->id = QMP_USB43DP_USB3_PHY;

	return 0;
}


> +};
> +
> +static const struct udevice_id qmp_combo_ids[] = {
> +	{
> +		.compatible = "qcom,sc7280-qmp-usb3-dp-phy",
> +		.data = (ulong)&sc7280_usb3dpphy_cfg,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qmp_combo) = {
> +	.name = "qcom-qmp-usb3-dp-phy",
> +	.id = UCLASS_PHY,
> +	.of_match = qmp_combo_ids,
> +	.ops = &qmp_combo_ops,
> +	.probe = qmp_combo_probe,
> +	.priv_auto = sizeof(struct qmp_combo),
> +};
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-common.h b/drivers/phy/qcom/phy-qcom-qmp-common.h
> new file mode 100644
> index 00000000000..71356fb7dd0
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-common.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_COMMON_H_
> +#define QCOM_PHY_QMP_COMMON_H_
> +
> +struct qmp_phy_init_tbl {
> +	unsigned int offset;
> +	unsigned int val;
> +	char *name;
> +	/*
> +	 * mask of lanes for which this register is written
> +	 * for cases when second lane needs different values
> +	 */
> +	u8 lane_mask;
> +};
> +
> +#define QMP_PHY_INIT_CFG(o, v)		\
> +	{				\
> +		.offset = o,		\
> +		.val = v,		\
> +		.name = #o,		\
> +		.lane_mask = 0xff,	\
> +	}
> +
> +#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
> +	{				\
> +		.offset = o,		\
> +		.val = v,		\
> +		.name = #o,		\
> +		.lane_mask = l,		\
> +	}
> +
> +static inline void qmp_configure_lane(struct udevice *dev, void __iomem *base,
> +				      const struct qmp_phy_init_tbl tbl[],
> +				      int num, u8 lane_mask)
> +{
> +	int i;
> +	const struct qmp_phy_init_tbl *t = tbl;
> +
> +	if (!t)
> +		return;
> +
> +	for (i = 0; i < num; i++, t++) {
> +		if (!(t->lane_mask & lane_mask))
> +			continue;
> +
> +		dev_dbg(dev, "Writing Reg: %s Offset: 0x%04x Val: 0x%02x\n",
> +			t->name, t->offset, t->val);
> +		writel(t->val, base + t->offset);
> +	}
> +}
> +
> +static inline void qmp_configure(struct udevice *dev, void __iomem *base,
> +				 const struct qmp_phy_init_tbl tbl[], int num)
> +{
> +	qmp_configure_lane(dev, base, tbl, num, 0xff);
> +}
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
> new file mode 100644
> index 00000000000..396179ef38b
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_DP_COM_V3_H_
> +#define QCOM_PHY_QMP_DP_COM_V3_H_
> +
> +/* Only for QMP V3 & V4 PHY - DP COM registers */
> +#define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
> +#define QPHY_V3_DP_COM_SW_RESET				0x04
> +#define QPHY_V3_DP_COM_POWER_DOWN_CTRL			0x08
> +#define QPHY_V3_DP_COM_SWI_CTRL				0x0c
> +#define QPHY_V3_DP_COM_TYPEC_CTRL			0x10
> +#define QPHY_V3_DP_COM_TYPEC_PWRDN_CTRL			0x14
> +#define QPHY_V3_DP_COM_RESET_OVRD_CTRL			0x1c
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> new file mode 100644
> index 00000000000..d7fd4ac0fc5
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V4_H_
> +#define QCOM_PHY_QMP_PCS_USB_V4_H_
> +
> +/* Only for QMP V4 PHY - USB3 PCS registers */
> +#define QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1		0x000
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
> +#define QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
> +#define QPHY_V4_PCS_USB3_LFPS_TX_ECSTART		0x01c
> +#define QPHY_V4_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
> +#define QPHY_V4_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x028
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x02c
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x030
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x034
> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x038
> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x03c
> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x040
> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x044
> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_CM_DLY		0x048
> +#define QPHY_V4_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x04c
> +#define QPHY_V4_PCS_USB3_ALFPS_DEGLITCH_VAL		0x050
> +#define QPHY_V4_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x054
> +#define QPHY_V4_PCS_USB3_TEST_CONTROL			0x058
> +
> +#endif
> diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
> index 99f4d447caf..06dac21ddc4 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp.h
> +++ b/drivers/phy/qcom/phy-qcom-qmp.h
> @@ -12,12 +12,17 @@
>   #include "phy-qcom-qmp-qserdes-com-v3.h"
>   #include "phy-qcom-qmp-qserdes-txrx-v3.h"
>   
> +#include "phy-qcom-qmp-qserdes-com-v4.h"
> +#include "phy-qcom-qmp-qserdes-txrx-v4.h"
> +
>   #include "phy-qcom-qmp-qserdes-pll.h"
>   
>   #include "phy-qcom-qmp-pcs-v2.h"
>   
>   #include "phy-qcom-qmp-pcs-v3.h"
>   
> +#include "phy-qcom-qmp-pcs-v4.h"
> +
>   /* Only for QMP V3 & V4 PHY - DP COM registers */
>   #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
>   #define QPHY_V3_DP_COM_SW_RESET				0x04
> @@ -112,4 +117,16 @@
>   #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
>   #define QSERDES_V6_DP_PHY_STATUS			0x0e4
>   
> +/* QPHY_SW_RESET bit */
> +#define SW_RESET                                BIT(0)
> +/* QPHY_POWER_DOWN_CONTROL */
> +#define SW_PWRDN                                BIT(0)
> +
> +/* QPHY_START_CONTROL bits */
> +#define SERDES_START                            BIT(0)
> +#define PCS_START                               BIT(1)
> +
> +/* QPHY_PCS_STATUS bit */
> +#define PHYSTATUS                               BIT(6)
> +
>   #endif

Thanks,
Neil
