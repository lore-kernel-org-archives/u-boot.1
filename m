Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E3DC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5AD680FF4;
	Thu, 27 Feb 2025 13:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2vx0w3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325FB810EA; Thu, 27 Feb 2025 13:16:18 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6943A801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390e3b3d432so498867f8f.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658575; x=1741263375; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=AGkcj2p5QPdjehGYFD+pLdn72AQGoRGMixM6orB428Y=;
 b=Z2vx0w3MZuGgpbXqvTVO0xym4pIbymYS+wUOF+f3PF2+PJuzTY/3fz7cM1z27awcfM
 TW10vWOhZSr/y2KaCEBmUYSamIKyphp3zd2HLervPVegBzRMLHkKXmqDUe240PhbRAZQ
 fIOGNeriayp8appugMMRQY6awS79elQZTFKFXC17+IKIBBp5XwK4g1OCc8SuYtkCd9hs
 TIZL45EubnZHT/Xtbdbb8lmcT3UJnC3pVOKNs/i+Qy3JfRK18+BHoMWxoSezQTxo5jE/
 3HLOs8aE3LC4O8ds6oVA5pzqGH7SAcXnoAt4wZs4OQ/Uv2g3rnxHOFbP0LExOdYulmiq
 47yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658575; x=1741263375;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AGkcj2p5QPdjehGYFD+pLdn72AQGoRGMixM6orB428Y=;
 b=oR9VVrlrDaedsKVM0zgmVx5WEuoWFNx4ydNu1fXzE6fMDaSTSYsJoX6Qr4OpwlwYD3
 3CqxNH6n4OPcIjCDXQVQwiQ7d6hjDVqTC0rMI6tb4FmlcwrfQmdtXz8zq501J1F6VtaX
 v7WJaOSojwCglad85b1W3iYMBfR/X9qOsSpdpGFxHrjQYR3NIBQsSzO3l+a2jf7+sjwo
 /pzTi4xRdteGY/BElefQCt5zvpnrtODhHUgT8pnV6YRqMjCd+/O15HAceDxHBrdS/8dg
 BhzqaTOXB6ab9JWPmcqvJ8YzV8MU4XXNU6gkK7enw6IUFqaTXkKdaVJUUt497oGJtaX1
 aqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULCPhvXZ4fw1yUUz6ZfcqgYdJ21o/1d55eyZ2ErwwrB0x5Lpu6IHNXJN/PtFVxsjNu3UsQLp4=@lists.denx.de
X-Gm-Message-State: AOJu0YzCFCT8DdYpGvLN7/EBSWn7UwnQytFL8cxJ8RPE7Tlg/pfljKHw
 bdVPShC9LZEZvgZ6xc9wP2y7f43+/wO/vPIW0DG+hymwpMjiZ2+JxgoTCzbaBoc=
X-Gm-Gg: ASbGnctcWybWsbnyWhGzvHX35BekNpKyeqidAUJIJhuWW8QESepRbRqAkQEvR56B6MS
 yXyLiD5BCUyUuJzaUyPi44S7My+jg6CxzanP5tX1uw3D+fcUWFQkmx8fMPcVkhSxIAoFVFQST2/
 B0Z5C/3XZymOR2tCj59EbuLBsHwDAcRC+aBCRBZDYnbTpsN7yqgPevTydnlBoT+qkqlMBCy3Z3D
 ZV7XVY4cg3sCa6nT32n0CLZMGLsQtHWu4miTFKzv/SlFq5tQoxXilEWNYqRPCb3kISlAdlJWVtW
 rOD7tjFufH9d/OfAl+Rn11sjRA1Ov0v83g5gohrlGh4iuTCBQNA1KDluUuizc7bL8Kcnj9ow+R6
 vogU=
X-Google-Smtp-Source: AGHT+IFR1YESK/x+MOrTPEhg0lBWJHd+gnR2hlXmHcyEd92AZQ8mDQ0ZUmzvity871tQGhTIkzqOMQ==
X-Received: by 2002:a05:6000:381:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-390ea347e46mr286219f8f.31.1740658574674; 
 Thu, 27 Feb 2025 04:16:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958?
 ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d17sm1842389f8f.28.2025.02.27.04.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 04:16:14 -0800 (PST)
Message-ID: <0ff1ec8d-6374-47f0-96db-dcf272f15271@linaro.org>
Date: Thu, 27 Feb 2025 13:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 04/15] spi: Add Qualcomm GENI SPI driver
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-5-swboyd@chromium.org>
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
In-Reply-To: <20250226221607.1283592-5-swboyd@chromium.org>
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

On 26/02/2025 23:15, Stephen Boyd wrote:
> Add a SPI driver for Qualcomm's GENI hardware.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/spi/Kconfig         |  10 +
>   drivers/spi/Makefile        |   1 +
>   drivers/spi/spi-geni-qcom.c | 527 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 538 insertions(+)
>   create mode 100644 drivers/spi/spi-geni-qcom.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 96ea033082b5..29e84098cb2f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -414,6 +414,16 @@ config SPI_QUP
>   	  mode supports up to 50MHz, up to four chip selects, programmable
>   	  data path from 4 bits to 32 bits and numerous protocol variants.
>   
> +config SPI_GENI_QCOM
> +	bool "Qualcomm Generic Interface (GENI) SPI controller"
> +	depends on ARCH_SNAPDRAGON
> +	help
> +	  Support for the Qualcomm Generic Interface (GENI) SPI controller.
> +	  The Generic Interface (GENI) is a firmware based Qualcomm Universal
> +	  Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
> +	  bus protocols depending on the firmware type loaded at early boot time
> +	  based on system configuration.
> +
>   config RENESAS_RPC_SPI
>   	bool "Renesas RPC SPI driver"
>   	depends on RCAR_64 || RZA1
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 7051e2a00c60..385e5b87d675 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
>   obj-$(CONFIG_PIC32_SPI) += pic32_spi.o
>   obj-$(CONFIG_PL022_SPI) += pl022_spi.o
>   obj-$(CONFIG_SPI_QUP) += spi-qup.o
> +obj-$(CONFIG_SPI_GENI_QCOM) += spi-geni-qcom.o
>   obj-$(CONFIG_SPI_MXIC) += spi-mxic.o
>   obj-$(CONFIG_RENESAS_RPC_SPI) += renesas_rpc_spi.o
>   obj-$(CONFIG_ROCKCHIP_SFC) += rockchip_sfc.o
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> new file mode 100644
> index 000000000000..9371f1530c9f
> --- /dev/null
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <linux/iopoll.h>
> +#include <spi.h>
> +#include <log.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <dm/read.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/bitops.h>
> +#include <time.h>
> +#include <soc/qcom/geni-se.h>
> +
> +/* SPI SE specific registers and respective register fields */
> +#define SE_SPI_CPHA		0x224
> +#define CPHA			BIT(0)
> +
> +#define SE_SPI_LOOPBACK		0x22c
> +#define LOOPBACK_ENABLE		0x1
> +#define NORMAL_MODE		0x0
> +#define LOOPBACK_MSK		GENMASK(1, 0)
> +
> +#define SE_SPI_CPOL		0x230
> +#define CPOL			BIT(2)
> +
> +#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
> +
> +#define SE_SPI_DEMUX_SEL	0x250
> +
> +#define SE_SPI_TRANS_CFG	0x25c
> +#define CS_TOGGLE		BIT(1)
> +
> +#define SE_SPI_WORD_LEN		0x268
> +#define WORD_LEN_MSK		GENMASK(9, 0)
> +#define MIN_WORD_LEN		4
> +
> +#define SE_SPI_TX_TRANS_LEN	0x26c
> +#define SE_SPI_RX_TRANS_LEN	0x270
> +#define TRANS_LEN_MSK		GENMASK(23, 0)
> +
> +#define SE_SPI_PRE_POST_CMD_DLY	0x274
> +
> +#define SE_SPI_DELAY_COUNTERS	0x278
> +#define SPI_INTER_WORDS_DELAY_MSK	GENMASK(9, 0)
> +#define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
> +#define SPI_CS_CLK_DELAY_SHFT		10
> +
> +#define SE_GENI_M_IRQ_CLEAR	0x618
> +#define SE_GENI_M_IRQ_STATUS	0x610
> +
> +/* M_CMD OP codes for SPI */
> +#define SPI_TX_ONLY		1
> +#define SPI_RX_ONLY		2
> +#define SPI_TX_RX		7
> +#define SPI_CS_ASSERT		8
> +#define SPI_CS_DEASSERT		9
> +#define SPI_SCK_ONLY		10
> +/* M_CMD params for SPI */
> +#define SPI_PRE_CMD_DELAY	BIT(0)
> +#define TIMESTAMP_BEFORE	BIT(1)
> +#define FRAGMENTATION		BIT(2)
> +#define TIMESTAMP_AFTER		BIT(3)
> +#define POST_CMD_DELAY		BIT(4)
> +
> +#define BYTES_PER_FIFO_WORD	4U
> +
> +struct geni_spi_priv {
> +	fdt_addr_t wrapper;
> +	phys_addr_t base;
> +	struct clk clk;
> +	u32 tx_depth;
> +	bool cs_high;
> +};
> +
> +static void geni_se_setup_m_cmd(struct geni_spi_priv *priv, u32 cmd, u32 params)
> +{
> +	u32 m_cmd;
> +
> +	debug("%s: cmd=%#x, parms=%#x\n", __func__, cmd, params);
> +	m_cmd = (cmd << M_OPCODE_SHFT) | (params & M_PARAMS_MSK);
> +	writel(m_cmd, priv->base + SE_GENI_M_CMD0);
> +}
> +
> +static void handle_se_timeout(struct geni_spi_priv *priv)
> +{
> +	int ret;
> +	u32 m_irq;
> +
> +	writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	writel(M_CMD_CANCEL_EN, priv->base + SE_GENI_M_CMD_CTRL_REG);
> +
> +	ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
> +				 (m_irq & M_CMD_CANCEL_EN) == M_CMD_CANCEL_EN,
> +				 100);
> +	writel(M_CMD_CANCEL_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
> +	if (ret < 0) {
> +		printf("spi-geni-qcom: Cancel failed. Abort the operation\n");
> +
> +		writel_relaxed(M_CMD_ABORT_EN, priv->base + SE_GENI_M_CMD_CTRL_REG);
> +		ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
> +					 (m_irq & M_CMD_ABORT_EN) == M_CMD_ABORT_EN,
> +					 100);
> +		writel(M_CMD_ABORT_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
> +		if (ret < 0)
> +			printf("spi-geni-qcom: Abort failed\n");
> +	}
> +}
> +
> +static int geni_spi_set_speed(struct udevice *dev, uint speed)
> +{
> +	/* TODO: Set a clk frequency or change divider here */
> +	return 0;
> +}
> +
> +static int geni_spi_set_mode(struct udevice *bus, uint mode)
> +{
> +	struct geni_spi_priv *priv = dev_get_priv(bus);
> +	u32 loopback_cfg = 0, cpol = 0, cpha = 0;
> +
> +	if (mode & SPI_LOOP)
> +		loopback_cfg = LOOPBACK_ENABLE;
> +
> +	if (mode & SPI_CPOL)
> +		cpol = CPOL;
> +
> +	if (mode & SPI_CPHA)
> +		cpha = CPHA;
> +
> +	if (mode & SPI_CS_HIGH)
> +		priv->cs_high = true;
> +
> +	writel(loopback_cfg, priv->base + SE_SPI_LOOPBACK);
> +	writel(cpha, priv->base + SE_SPI_CPHA);
> +	writel(cpol, priv->base + SE_SPI_CPOL);
> +
> +	return 0;
> +}
> +
> +static void geni_spi_reset(struct udevice *dev)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct geni_spi_priv *priv = dev_get_priv(bus);
> +
> +	/* Driver may not be probed yet */
> +	if (!priv)
> +		return;
> +}
> +
> +#define NUM_PACKING_VECTORS 4
> +#define PACKING_START_SHIFT 5
> +#define PACKING_DIR_SHIFT 4
> +#define PACKING_LEN_SHIFT 1
> +#define PACKING_STOP_BIT BIT(0)
> +#define PACKING_VECTOR_SHIFT 10
> +static void geni_spi_config_packing(struct geni_spi_priv *geni, int bpw,
> +				    int pack_words, bool msb_to_lsb,
> +				    bool tx_cfg, bool rx_cfg)
> +{
> +	u32 cfg0, cfg1, cfg[NUM_PACKING_VECTORS] = {0};
> +	int len;
> +	int temp_bpw = bpw;
> +	int idx_start = msb_to_lsb ? bpw - 1 : 0;
> +	int idx = idx_start;
> +	int idx_delta = msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE;
> +	int ceil_bpw = ALIGN(bpw, BITS_PER_BYTE);
> +	int iter = (ceil_bpw * pack_words) / BITS_PER_BYTE;
> +	int i;
> +
> +	if (iter <= 0 || iter > NUM_PACKING_VECTORS)
> +		return;
> +
> +	for (i = 0; i < iter; i++) {
> +		len = min_t(int, temp_bpw, BITS_PER_BYTE) - 1;
> +		cfg[i] = idx << PACKING_START_SHIFT;
> +		cfg[i] |= msb_to_lsb << PACKING_DIR_SHIFT;
> +		cfg[i] |= len << PACKING_LEN_SHIFT;
> +
> +		if (temp_bpw <= BITS_PER_BYTE) {
> +			idx = ((i + 1) * BITS_PER_BYTE) + idx_start;
> +			temp_bpw = bpw;
> +		} else {
> +			idx = idx + idx_delta;
> +			temp_bpw = temp_bpw - BITS_PER_BYTE;
> +		}
> +	}
> +	cfg[iter - 1] |= PACKING_STOP_BIT;
> +	cfg0 = cfg[0] | (cfg[1] << PACKING_VECTOR_SHIFT);
> +	cfg1 = cfg[2] | (cfg[3] << PACKING_VECTOR_SHIFT);
> +
> +	if (tx_cfg) {
> +		writel(cfg0, geni->base + SE_GENI_TX_PACKING_CFG0);
> +		writel(cfg1, geni->base + SE_GENI_TX_PACKING_CFG1);
> +	}
> +	if (rx_cfg) {
> +		writel(cfg0, geni->base + SE_GENI_RX_PACKING_CFG0);
> +		writel(cfg1, geni->base + SE_GENI_RX_PACKING_CFG1);
> +	}
> +
> +	/*
> +	 * Number of protocol words in each FIFO entry
> +	 * 0 - 4x8, four words in each entry, max word size of 8 bits
> +	 * 1 - 2x16, two words in each entry, max word size of 16 bits
> +	 * 2 - 1x32, one word in each entry, max word size of 32 bits
> +	 * 3 - undefined
> +	 */
> +	if (pack_words || bpw == 32)
> +		writel(bpw / 16, geni->base + SE_GENI_BYTE_GRAN);
> +}
> +
> +static u32 geni_spi_get_tx_fifo_depth(struct geni_spi_priv *geni)
> +{
> +	u32 val, hw_version, hw_major, hw_minor, tx_fifo_depth_mask;
> +
> +	hw_version = readl(geni->wrapper + QUP_HW_VER_REG);
> +	hw_major = GENI_SE_VERSION_MAJOR(hw_version);
> +	hw_minor = GENI_SE_VERSION_MINOR(hw_version);
> +
> +	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
> +		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK_256_BYTES;
> +	else
> +		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK;
> +
> +	val = readl(geni->base + SE_HW_PARAM_0);
> +
> +	return (val & tx_fifo_depth_mask) >> TX_FIFO_DEPTH_SHFT;
> +}
> +
> +static void geni_spi_drain_rx(struct geni_spi_priv *geni)
> +{
> +	u32 rx_fifo_status;
> +	unsigned int rx_bytes;
> +	unsigned int rx_last_byte_valid;
> +	unsigned int i;
> +
> +	rx_fifo_status = readl(geni->base + SE_GENI_RX_FIFO_STATUS);
> +	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * BYTES_PER_FIFO_WORD;
> +	if (rx_fifo_status & RX_LAST) {
> +		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
> +		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
> +		if (rx_last_byte_valid && rx_last_byte_valid < 4)
> +			rx_bytes -= BYTES_PER_FIFO_WORD - rx_last_byte_valid;
> +	}
> +
> +	for (i = 0; i < DIV_ROUND_UP(rx_bytes, BYTES_PER_FIFO_WORD); i++)
> +		readl(geni->base + SE_GENI_RX_FIFOn);
> +}
> +
> +static void geni_spi_hw_init(struct udevice *dev)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct geni_spi_priv *geni = dev_get_priv(bus);
> +	u32 demux_output_inv = 0;
> +	u32 val, demux_sel;
> +
> +	writel(0, geni->base + SE_GSI_EVENT_EN);
> +	writel(0xffffffff, geni->base + SE_GENI_M_IRQ_CLEAR);
> +	writel(0xffffffff, geni->base + SE_GENI_S_IRQ_CLEAR);
> +	writel(0xffffffff, geni->base + SE_IRQ_EN);
> +
> +	val = readl(geni->base + GENI_CGC_CTRL);
> +	val |= DEFAULT_CGC_EN;
> +	writel(val, geni->base + GENI_CGC_CTRL);
> +
> +	writel(DEFAULT_IO_OUTPUT_CTRL_MSK, geni->base + GENI_OUTPUT_CTRL);
> +	writel(FORCE_DEFAULT, geni->base + GENI_FORCE_DEFAULT_REG);
> +
> +	val = readl(geni->base + SE_IRQ_EN);
> +	val |= GENI_M_IRQ_EN | GENI_S_IRQ_EN;
> +	writel(val, geni->base + SE_IRQ_EN);
> +
> +	val = readl(geni->base + SE_GENI_DMA_MODE_EN);
> +	val &= ~GENI_DMA_MODE_EN;
> +	writel(val, geni->base + SE_GENI_DMA_MODE_EN);
> +
> +	writel(0, geni->base + SE_GSI_EVENT_EN);
> +
> +	writel(geni->tx_depth - 3, geni->base + SE_GENI_RX_WATERMARK_REG);
> +	writel(geni->tx_depth - 2, geni->base + SE_GENI_RX_RFR_WATERMARK_REG);
> +
> +	val = readl(geni->base + SE_GENI_M_IRQ_EN);
> +	val |= M_COMMON_GENI_M_IRQ_EN;
> +	val |= M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN;
> +	val |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> +	writel(val, geni->base + SE_GENI_M_IRQ_EN);
> +
> +	val = readl(geni->base + SE_GENI_S_IRQ_EN);
> +	val |= S_COMMON_GENI_S_IRQ_EN;
> +	writel(val, geni->base + SE_GENI_S_IRQ_EN);
> +
> +	if (geni->cs_high)
> +		demux_output_inv = BIT(spi_chip_select(dev));
> +	demux_sel = spi_chip_select(dev);
> +	writel(demux_sel, geni->base + SE_SPI_DEMUX_SEL);
> +	writel(demux_output_inv, geni->base + SE_SPI_DEMUX_OUTPUT_INV);
> +
> +	writel(((8 - MIN_WORD_LEN) & WORD_LEN_MSK), geni->base + SE_SPI_WORD_LEN);
> +	geni_spi_config_packing(geni, BITS_PER_BYTE, 4, true, true, true);
> +
> +	geni_spi_drain_rx(geni);
> +}
> +
> +static int geni_spi_claim_bus(struct udevice *dev)
> +{
> +	geni_spi_hw_init(dev);
> +	return 0;
> +}
> +
> +static int geni_spi_release_bus(struct udevice *dev)
> +{
> +	/* Reset the SPI hardware */
> +	geni_spi_reset(dev);
> +
> +	return 0;
> +}
> +
> +static int geni_spi_set_cs(struct udevice *bus, bool enable)
> +{
> +	struct geni_spi_priv *priv = dev_get_priv(bus);
> +	u32 m_cmd = 0, m_irq;
> +	int ret;
> +
> +	debug("%s: enable=%d\n", __func__, enable);
> +
> +	m_cmd = enable ? SPI_CS_ASSERT : SPI_CS_DEASSERT;
> +	geni_se_setup_m_cmd(priv, m_cmd, 0);
> +
> +	ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
> +				 (m_irq & M_CMD_DONE_EN) == M_CMD_DONE_EN,
> +				 100);
> +	writel(M_CMD_DONE_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
> +	if (ret) {
> +		printf("spi-geni-qcom: Timeout setting cs\n");
> +		handle_se_timeout(priv);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int
> +geni_spi_handle_tx(struct geni_spi_priv *geni, const u8 *dout, unsigned int tx_rem_bytes)
> +{
> +	unsigned int max_bytes;
> +	unsigned int i = 0;
> +
> +	max_bytes = (geni->tx_depth - 1) * BYTES_PER_FIFO_WORD;
> +	if (tx_rem_bytes < max_bytes)
> +		max_bytes = tx_rem_bytes;
> +
> +	while (i < max_bytes) {
> +		unsigned int j;
> +		unsigned int bytes_to_write;
> +		u32 fifo_word = 0;
> +		u8 *fifo_byte = (u8 *)&fifo_word;
> +
> +		bytes_to_write = min(BYTES_PER_FIFO_WORD, max_bytes - i);
> +		for (j = 0; j < bytes_to_write; j++)
> +			fifo_byte[j] = dout[i++];
> +		iowrite32_rep((void *)(geni->base + SE_GENI_TX_FIFOn), &fifo_word, 1);
> +	}
> +	tx_rem_bytes -= max_bytes;
> +	if (!tx_rem_bytes)
> +		writel(0, geni->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	return max_bytes;
> +}
> +
> +static int geni_spi_handle_rx(struct geni_spi_priv *geni, u8 *din, unsigned int rx_rem_bytes)
> +{
> +	u32 rx_fifo_status;
> +	unsigned int rx_bytes;
> +	unsigned int rx_last_byte_valid;
> +	unsigned int i = 0;
> +
> +	rx_fifo_status = readl(geni->base + SE_GENI_RX_FIFO_STATUS);
> +	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * BYTES_PER_FIFO_WORD;
> +	if (rx_fifo_status & RX_LAST) {
> +		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
> +		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
> +		if (rx_last_byte_valid && rx_last_byte_valid < 4)
> +			rx_bytes -= BYTES_PER_FIFO_WORD - rx_last_byte_valid;
> +	}
> +
> +	if (rx_rem_bytes < rx_bytes)
> +		rx_bytes = rx_rem_bytes;
> +
> +	while (i < rx_bytes) {
> +		u32 fifo_word = 0;
> +		u8 *fifo_byte = (u8 *)&fifo_word;
> +		unsigned int bytes_to_read;
> +		unsigned int j;
> +
> +		bytes_to_read = min(BYTES_PER_FIFO_WORD, rx_bytes - i);
> +		ioread32_rep((void *)(geni->base + SE_GENI_RX_FIFOn), &fifo_word, 1);
> +		for (j = 0; j < bytes_to_read; j++)
> +			din[i++] = fifo_byte[j];
> +	}
> +
> +	return rx_bytes;
> +}
> +
> +static int geni_spi_xfer(struct udevice *dev, unsigned int bitlen,
> +			 const void *dout, void *din, unsigned long flags)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct geni_spi_priv *priv = dev_get_priv(bus);
> +	unsigned int len = bitlen >> 3;
> +	unsigned int rx_rem_bytes = din ? len : 0;
> +	unsigned int tx_rem_bytes = dout ? len : 0;
> +	int ret = 0;
> +	u32 m_cmd = 0, m_irq;
> +	ulong start;
> +
> +	if (len & ~TRANS_LEN_MSK) {
> +		printf("spi-geni-qcom: transfer length too long (%d)\n", len);
> +		return -EINVAL;
> +	}
> +
> +	if (flags & SPI_XFER_BEGIN) {
> +		geni_spi_hw_init(dev);
> +		ret = geni_spi_set_cs(bus, true);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +	if (len) {
> +		if (din) {
> +			m_cmd |= SPI_RX_ONLY;
> +			writel(len, priv->base + SE_SPI_RX_TRANS_LEN);
> +		}
> +		if (dout) {
> +			m_cmd |= SPI_TX_ONLY;
> +			writel(len, priv->base + SE_SPI_TX_TRANS_LEN);
> +			writel(1, priv->base + SE_GENI_TX_WATERMARK_REG);
> +		}
> +
> +		geni_se_setup_m_cmd(priv, m_cmd, FRAGMENTATION);
> +
> +		start = get_timer(0);
> +		do {
> +			ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
> +						 m_irq != 0, 1000);
> +			if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN)) {
> +				rx_rem_bytes -= geni_spi_handle_rx(priv, din + len - rx_rem_bytes,
> +								   rx_rem_bytes);
> +			}
> +			if (m_irq & M_TX_FIFO_WATERMARK_EN) {
> +				tx_rem_bytes -= geni_spi_handle_tx(priv, dout + len - tx_rem_bytes,
> +								   tx_rem_bytes);
> +			}
> +			writel(m_irq, priv->base + SE_GENI_M_IRQ_CLEAR);
> +			if (m_irq & M_CMD_DONE_EN)
> +				break;
> +		} while (get_timer(start) < 100000);
> +
> +		if (!(m_irq & M_CMD_DONE_EN) || tx_rem_bytes || rx_rem_bytes) {
> +			printf("spi-geni-qcom: Transfer failed\n");
> +			handle_se_timeout(priv);
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	if (flags & SPI_XFER_END) {
> +		ret = geni_spi_set_cs(bus, false);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dm_spi_ops geni_spi_ops = {
> +	.claim_bus	= geni_spi_claim_bus,
> +	.release_bus	= geni_spi_release_bus,
> +	.xfer		= geni_spi_xfer,
> +	.set_speed	= geni_spi_set_speed,
> +	.set_mode	= geni_spi_set_mode,
> +};
> +
> +static int geni_spi_probe(struct udevice *dev)
> +{
> +	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
> +	struct geni_spi_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->base = dev_read_addr(dev);
> +	if (priv->base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	priv->wrapper = ofnode_get_addr(parent_node);
> +	if (priv->wrapper == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_index(dev, 0, &priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret < 0)
> +		return ret;

I think you should check for the protocol type and if FIFO is disabled
like the i2c driver:
https://elixir.bootlin.com/u-boot/v2025.01/source/drivers/i2c/geni_i2c.c#L504

Neil

> +
> +	priv->tx_depth = geni_spi_get_tx_fifo_depth(priv);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id spi_geni_ids[] = {
> +	{ .compatible = "qcom,geni-spi" },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(geni_spi) = {
> +	.name		= "geni_spi",
> +	.id		= UCLASS_SPI,
> +	.of_match	= spi_geni_ids,
> +	.ops		= &geni_spi_ops,
> +	.priv_auto	= sizeof(struct geni_spi_priv),
> +	.probe		= geni_spi_probe,
> +};

