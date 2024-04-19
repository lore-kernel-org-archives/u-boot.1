Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8B8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9E0880F4;
	Fri, 19 Apr 2024 13:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ht8psUs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDF587D70; Fri, 19 Apr 2024 13:47:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913CC880F4
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-346b96f1483so1085125f8f.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713527235; x=1714132035; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W03zlkQGFQY6+g44Ck0VscvL/fMWS6C9aB/Ah2lFrRM=;
 b=ht8psUs741frqftIj49zdmBpEhO4r7RDZonWB4s2BINW8zLu4IZzzEylEYmgzs0fxj
 b50NwAlW2dLPd0mTvMN6AkA3x7MfFeZzzEJ8hzP5UbVqh1e2iUkPQ65VKHNuoPulJzSn
 aaDqeJ2VuAk2/XV1/zs2I1h8vy96PC4hSrGM0ypiAu4GnzRWiEnKeACbq++EbdpZnhT+
 4+3k80wZQvqYMug6M9QR4Wkh2JDozDqYTxWqILlEmMd4T17RC1DZ4Wb3T7ObKuJq5PRa
 IwCwRty+8nZTwdZT1PoJCej7FxOdUcCNnKs/fNwObFzXOUPfVJdvRtAuiph4GreGhIIb
 JDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713527235; x=1714132035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W03zlkQGFQY6+g44Ck0VscvL/fMWS6C9aB/Ah2lFrRM=;
 b=oLIucLDcjcC+gWYVSqujQY2/PNpDR5Da1q7QqyquLFFjdTgzCdaq5r18YzE+fruw94
 eIN0zaC3Ub/j7fJCiL0faHfR4QZBlr2EZGvrHlIMfuN0slkjt68NXnfTsZSC7FM/SkBC
 W5+NxgEgocrokvrtlVESXgimlT1dKTiiHo3waeyTKeOW7VjcrQ7x1Fa/8gXC9YG7ot30
 +zqTn6cdrcjuqYTB/mwa8ANWpzP0LTSetvY/EQkoIsHNGxmUVLpHoGyNvk4K+CLUfxQm
 IQjTLqphM7KnO6BB0EPz6bj1mxKP9tnl8I7RItlc8I+r8d7zVQXz68XmXp+ACT0bxf6+
 tpqQ==
X-Gm-Message-State: AOJu0YxHapyhYhn4NWVJNAatTPEzU1JXn4SfwxHUZOUZSc6reF9zoaZh
 QTCRbDRMlMNf0C8oYkmKnkNNt3tgIiAL8G49Wk/geBqzf+7fYVlo0qZhKTqyVow=
X-Google-Smtp-Source: AGHT+IGoZcBxV+m3sEbgMR5whYhDAJVkvlMeJT7nk3Y1SWoLMlPzgZu+8zd+BojI+Pdz334FH0goRA==
X-Received: by 2002:a5d:59ab:0:b0:34a:6f29:f19f with SMTP id
 p11-20020a5d59ab000000b0034a6f29f19fmr866910wrr.15.1713527234778; 
 Fri, 19 Apr 2024 04:47:14 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a5d544f000000b00349c63eb484sm4228700wrv.23.2024.04.19.04.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 04:47:14 -0700 (PDT)
Message-ID: <21f97af3-bc5b-4136-abc1-c1466e172ae2@linaro.org>
Date: Fri, 19 Apr 2024 12:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org>
 <20240419-topic-sm8x50-i2c-v1-1-67651e27f23a@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240419-topic-sm8x50-i2c-v1-1-67651e27f23a@linaro.org>
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

Hi Neil,

On 18/04/2024 23:47, Neil Armstrong wrote:
> Add Support for the Qualcomm Generic Interface (GENI) I2C interface
> found on newer Qualcomm SoCs.

\o/
> 
> The Generic Interface (GENI) is a firmware based Qualcomm Universal
> Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
> bus protocols depending on the firmware type loaded at early boot time
> based on system configuration.
> 
> It also supports the "I2C Master Hub" which is a single function Wrapper
> that only FIFO mode I2C.
> 
> It replaces the fixed-function QUP Wrapper found on older SoCs.
> 
> The geni-se.h containing the generic GENI Serial Engine registers defines
> is imported from Linux.
> 
> Only FIFO mode is implemented, nor SE DMA nor GPI DMA is implemented.
nit: "neither SE DMA nor GPI DMA are implemented"

A few minor things below, but otherwise LGTM!
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/i2c/Kconfig        |  10 +
>  drivers/i2c/Makefile       |   1 +
>  drivers/i2c/geni_i2c.c     | 576 +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/geni-se.h | 265 +++++++++++++++++++++
>  4 files changed, 852 insertions(+)
> 
[...]
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> new file mode 100644
> index 00000000000..8c3ed3bef89
> --- /dev/null
> +++ b/drivers/i2c/geni_i2c.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Linaro Limited
> + * Author: Neil Armstrong <neil.armstrong@linaro.org>
> + *
> + * Based on Linux driver: drivers/i2c/busses/i2c-qcom-geni.c
> + */
> +
[...]
> +static int geni_i2c_fifo_tx_fill(struct geni_i2c_priv *geni, struct i2c_msg *msg)
> +{
> +	ulong start = get_timer(0);
> +	ulong cur_xfer = 0;
> +	int i;
> +
> +	while (get_timer(start) < I2C_TIMEOUT_MS) {
> +		u32 status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
> +
> +		if (status & (M_CMD_ABORT_EN |
> +			      M_CMD_OVERRUN_EN |
> +			      M_ILLEGAL_CMD_EN |
> +			      M_CMD_FAILURE_EN |
> +			      M_GP_IRQ_1_EN |
> +			      M_GP_IRQ_3_EN |
> +			      M_GP_IRQ_4_EN)) {
> +			debug("%s:%d cmd err\n", __func__, __LINE__);

How likely are we to hit this? Would it make sense to promote it to a
pr_warn()?

Please drop the __LINE__ and (if it makes sense to?) print the value of
status.
> +			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +			writel(0, geni->base + SE_GENI_TX_WATERMARK_REG);
> +			return -EREMOTEIO;
> +		}
> +
> +		if ((status & M_TX_FIFO_WATERMARK_EN) == 0) {
> +			udelay(1);
> +			goto skip_fill;
> +		}
> +
> +		for (i = 0; i < geni->tx_wm; i++) {
> +			u32 temp, tx = 0;
> +			unsigned int p = 0;
> +
> +			while (cur_xfer < msg->len && p < sizeof(tx)) {
> +				temp = msg->buf[cur_xfer++];
> +				tx |= temp << (p * 8);
> +				p++;
> +			}
> +
> +			writel(tx, geni->base + SE_GENI_TX_FIFOn);
> +
> +			if (cur_xfer == msg->len) {
> +				writel(0, geni->base + SE_GENI_TX_WATERMARK_REG);
> +				break;
> +			}
> +		}
> +
> +skip_fill:
> +		writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +
> +		if (status & M_CMD_DONE_EN)
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int geni_i2c_fifo_rx_drain(struct geni_i2c_priv *geni, struct i2c_msg *msg)
> +{
> +	ulong start = get_timer(0);
> +	ulong cur_xfer = 0;
> +	int i;
> +
> +	while (get_timer(start) < I2C_TIMEOUT_MS) {
> +		u32 status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
> +		u32 rxstatus = readl(geni->base + SE_GENI_RX_FIFO_STATUS);
> +		u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
> +
> +		if (status & (M_CMD_ABORT_EN |
> +			      M_CMD_FAILURE_EN |
> +			      M_CMD_OVERRUN_EN |
> +			      M_ILLEGAL_CMD_EN |
> +			      M_GP_IRQ_1_EN |
> +			      M_GP_IRQ_3_EN |
> +			      M_GP_IRQ_4_EN)) {
> +			debug("%s:%d cmd err\n", __func__, __LINE__);

Ditto
> +			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +			return -EIO;
> +		}
> +
> +		if ((status & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) == 0) {
> +			udelay(1);
> +			goto skip_drain;
> +		}
> +
> +		for (i = 0; cur_xfer < msg->len && i < rxcnt; i++) {
> +			u32 rx = readl(geni->base + SE_GENI_RX_FIFOn);
> +			unsigned int p = 0;
> +
> +			while (cur_xfer < msg->len && p < sizeof(rx)) {
> +				msg->buf[cur_xfer++] = rx & 0xff;
> +				rx >>= 8;
> +				p++;
> +			}
> +		}
> +
> +skip_drain:
> +		writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +
> +		if (status & M_CMD_DONE_EN)
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int geni_i2c_xfer_tx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32 params)
> +{
> +	writel(msg->len, geni->base + SE_I2C_TX_TRANS_LEN);
> +	geni_i2c_setup_m_cmd(geni, I2C_WRITE, params);
> +	writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	return geni_i2c_fifo_tx_fill(geni, msg);
> +}
> +
> +static int geni_i2c_xfer_rx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32 params)
> +{
> +	writel(msg->len, geni->base + SE_I2C_RX_TRANS_LEN);
> +	geni_i2c_setup_m_cmd(geni, I2C_READ, params);
> +
> +	return geni_i2c_fifo_rx_drain(geni, msg);
> +}
> +
> +static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
> +{
> +	struct geni_i2c_priv *geni = dev_get_priv(bus);
> +	int i, ret;
> +
> +	qcom_geni_i2c_conf(geni);
> +
> +	for (i = 0; i < num; i++) {
> +		struct i2c_msg *msg = &msgs[i];
> +		u32 m_param = i < (num - 1) ? STOP_STRETCH : 0;
> +
> +		m_param |= ((msg->addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
> +
> +		if (msg->flags & I2C_M_RD)
> +			ret = geni_i2c_xfer_rx(geni, msg, m_param);
> +		else
> +			ret = geni_i2c_xfer_tx(geni, msg, m_param);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		if (ret == -ETIMEDOUT) {
> +			u32 status;
> +
> +			writel(M_GENI_CMD_ABORT, geni->base + SE_GENI_M_CMD_CTRL_REG);
> +
> +			/* Wait until Abort has finished */
> +			do {
> +				status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
> +			} while ((status & M_CMD_ABORT_EN) == 0);
> +
> +			writel(status, geni->base + SE_GENI_M_IRQ_STATUS);
> +		}
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int geni_i2c_enable_clocks(struct udevice *dev, struct geni_i2c_priv *geni)
> +{
> +	int ret;
> +
> +	if (geni->is_master_hub) {
> +		ret = clk_enable(&geni->core);
> +		if (ret) {
> +			dev_err(dev, "clk_enable core failed %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_enable(&geni->se);
> +	if (ret) {
> +		dev_err(dev, "clk_enable se failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *geni)
> +{
> +	int ret;
> +
> +	if (geni->is_master_hub) {
> +		ret = clk_disable(&geni->core);
> +		if (ret) {
> +			dev_err(dev, "clk_enable core failed %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_disable(&geni->se);
> +	if (ret) {
> +		dev_err(dev, "clk_enable se failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#define NUM_PACKING_VECTORS 4
> +#define PACKING_START_SHIFT 5
> +#define PACKING_DIR_SHIFT 4
> +#define PACKING_LEN_SHIFT 1
> +#define PACKING_STOP_BIT BIT(0)
> +#define PACKING_VECTOR_SHIFT 10
> +void geni_i2c_config_packing(struct geni_i2c_priv *geni, int bpw, int pack_words,
> +			     bool msb_to_lsb, bool tx_cfg, bool rx_cfg)
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
> +static void geni_i2c_init(struct geni_i2c_priv *geni, unsigned int tx_depth)
> +{
> +	u32 val;
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
> +	writel(tx_depth - 1, geni->base + SE_GENI_RX_WATERMARK_REG);
> +	writel(tx_depth, geni->base + SE_GENI_RX_RFR_WATERMARK_REG);
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
> +}
> +
> +static u32 geni_i2c_get_tx_fifo_depth(struct geni_i2c_priv *geni)
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
> +static int geni_i2c_probe(struct udevice *dev)
> +{
> +	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
> +	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +	u32 proto, tx_depth, fifo_disable;
> +	int ret;
> +
> +	geni->is_master_hub = dev_get_driver_data(dev) & GENI_I2C_IS_MASTER_HUB;
> +
> +	geni->wrapper = ofnode_get_addr(parent_node);
> +	if (geni->wrapper == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	geni->base = (phys_addr_t)dev_read_addr_ptr(dev);
> +	if (!geni->base)
> +		return -EINVAL;
> +
> +	if (geni->is_master_hub) {
> +		ret = clk_get_by_name(dev, "core", &geni->core);
> +		if (ret) {
> +			pr_err("clk_get_by_name(core) failed: %d\n", ret);

In other places you used dev_err(), but here it's pr_err() (even though
dev is available), and below it's pr_err() with __func__ as the prefix.
Please make these consistent.
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_get_by_name(dev, "se", &geni->se);
> +	if (ret) {
> +		pr_err("clk_get_by_name(iface) failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	geni_i2c_enable_clocks(dev, geni);
> +
> +	proto = readl(geni->base + GENI_FW_REVISION_RO);
> +	proto &= FW_REV_PROTOCOL_MSK;
> +	proto >>= FW_REV_PROTOCOL_SHFT;
> +
> +	if (proto != GENI_SE_I2C) {
> +		pr_err("%s: Invalid proto %d\n", __func__, proto);
> +		geni_i2c_disable_clocks(dev, geni);
> +		return -ENXIO;
> +	}
> +
> +	fifo_disable = readl(geni->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> +	if (fifo_disable) {
> +		geni_i2c_disable_clocks(dev, geni);
> +		pr_err("%s: FIFO mode disabled, DMA mode unsupported\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	if (!geni->is_master_hub) {
> +		tx_depth = geni_i2c_get_tx_fifo_depth(geni);
> +		if (!tx_depth) {
> +			geni_i2c_disable_clocks(dev, geni);
> +			pr_err("%s: Invalid TX FIFO depth\n", __func__);
> +			return -ENXIO;
> +		}
> +	} else {
> +		tx_depth = 16;
> +	}
> +	geni->tx_wm = tx_depth - 1;
> +
> +	geni_i2c_init(geni, tx_depth);
> +	geni_i2c_config_packing(geni, BITS_PER_BYTE,
> +				PACKING_BYTES_PW, true, true, true);
> +
> +	/* Setup for standard rate */
> +	return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
> +}
> +
> +static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned int clk_freq)
> +{
> +	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +
> +	return geni_i2c_clk_map_idx(geni, clk_freq);
> +}
> +
> +static const struct dm_i2c_ops geni_i2c_ops = {
> +	.xfer		= geni_i2c_xfer,
> +	.set_bus_speed	= geni_i2c_set_bus_speed,
> +};
> +
> +static const struct udevice_id geni_i2c_ids[] = {
> +	{ .compatible = "qcom,geni-i2c" },
> +	{ .compatible = "qcom,geni-i2c-master-hub", .data = GENI_I2C_IS_MASTER_HUB},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(i2c_geni) = {
> +	.name	= "i2c_geni",
> +	.id	= UCLASS_I2C,
> +	.of_match = geni_i2c_ids,
> +	.probe	= geni_i2c_probe,
> +	.priv_auto = sizeof(struct geni_i2c_priv),
> +	.ops	= &geni_i2c_ops,
> +};
> +
> +static const struct udevice_id geni_i2c_master_hub_ids[] = {
> +	{ .compatible = "qcom,geni-se-i2c-master-hub" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(geni_i2c_master_hub) = {
> +	.name = "geni-se-master-hub",
> +	.id = UCLASS_NOP,
> +	.of_match = geni_i2c_master_hub_ids,
> +	.bind = dm_scan_fdt_dev,
> +	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
> new file mode 100644
> index 00000000000..698a9256d26
> --- /dev/null
> +++ b/include/soc/qcom/geni-se.h
> @@ -0,0 +1,265 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _QCOM_GENI_SE
> +#define _QCOM_GENI_SE
> +
> +/* Protocols supported by GENI Serial Engines */
> +enum geni_se_protocol_type {
> +	GENI_SE_NONE,
> +	GENI_SE_SPI,
> +	GENI_SE_UART,
> +	GENI_SE_I2C,
> +	GENI_SE_I3C,
> +	GENI_SE_SPI_SLAVE,
> +};
> +
> +#define QUP_HW_VER_REG			0x4
> +
> +/* Common SE registers */
> +#define GENI_INIT_CFG_REVISION		0x0
> +#define GENI_S_INIT_CFG_REVISION	0x4
> +#define GENI_FORCE_DEFAULT_REG		0x20
> +#define GENI_OUTPUT_CTRL		0x24
> +#define GENI_CGC_CTRL			0x28
> +#define SE_GENI_STATUS			0x40
> +#define GENI_SER_M_CLK_CFG		0x48
> +#define GENI_SER_S_CLK_CFG		0x4c
> +#define GENI_IF_DISABLE_RO		0x64
> +#define GENI_FW_REVISION_RO		0x68
> +#define SE_GENI_CLK_SEL			0x7c
> +#define SE_GENI_CFG_SEQ_START		0x84
> +#define SE_GENI_BYTE_GRAN		0x254
> +#define SE_GENI_DMA_MODE_EN		0x258
> +#define SE_GENI_TX_PACKING_CFG0		0x260
> +#define SE_GENI_TX_PACKING_CFG1		0x264
> +#define SE_GENI_RX_PACKING_CFG0		0x284
> +#define SE_GENI_RX_PACKING_CFG1		0x288
> +#define SE_GENI_M_CMD0			0x600
> +#define SE_GENI_M_CMD_CTRL_REG		0x604
> +#define SE_GENI_M_IRQ_STATUS		0x610
> +#define SE_GENI_M_IRQ_EN		0x614
> +#define SE_GENI_M_IRQ_CLEAR		0x618
> +#define SE_GENI_S_CMD0			0x630
> +#define SE_GENI_S_CMD_CTRL_REG		0x634
> +#define SE_GENI_S_IRQ_STATUS		0x640
> +#define SE_GENI_S_IRQ_EN		0x644
> +#define SE_GENI_S_IRQ_CLEAR		0x648
> +#define SE_GENI_TX_FIFOn		0x700
> +#define SE_GENI_RX_FIFOn		0x780
> +#define SE_GENI_TX_FIFO_STATUS		0x800
> +#define SE_GENI_RX_FIFO_STATUS		0x804
> +#define SE_GENI_TX_WATERMARK_REG	0x80c
> +#define SE_GENI_RX_WATERMARK_REG	0x810
> +#define SE_GENI_RX_RFR_WATERMARK_REG	0x814
> +#define SE_GENI_IOS			0x908
> +#define SE_DMA_TX_IRQ_STAT		0xc40
> +#define SE_DMA_TX_IRQ_CLR		0xc44
> +#define SE_DMA_TX_FSM_RST		0xc58
> +#define SE_DMA_RX_IRQ_STAT		0xd40
> +#define SE_DMA_RX_IRQ_CLR		0xd44
> +#define SE_DMA_RX_LEN_IN		0xd54
> +#define SE_DMA_RX_FSM_RST		0xd58
> +#define SE_GSI_EVENT_EN			0xe18
> +#define SE_IRQ_EN			0xe1c
> +#define SE_HW_PARAM_0			0xe24
> +#define SE_HW_PARAM_1			0xe28
> +
> +/* GENI_FORCE_DEFAULT_REG fields */
> +#define FORCE_DEFAULT	BIT(0)
> +
> +/* GENI_OUTPUT_CTRL fields */
> +#define GENI_IO_MUX_0_EN		BIT(0)
> +#define DEFAULT_IO_OUTPUT_CTRL_MSK	GENMASK(6, 0)
> +
> +/* GENI_CGC_CTRL fields */
> +#define CFG_AHB_CLK_CGC_ON		BIT(0)
> +#define CFG_AHB_WR_ACLK_CGC_ON		BIT(1)
> +#define DATA_AHB_CLK_CGC_ON		BIT(2)
> +#define SCLK_CGC_ON			BIT(3)
> +#define TX_CLK_CGC_ON			BIT(4)
> +#define RX_CLK_CGC_ON			BIT(5)
> +#define EXT_CLK_CGC_ON			BIT(6)
> +#define PROG_RAM_HCLK_OFF		BIT(8)
> +#define PROG_RAM_SCLK_OFF		BIT(9)
> +#define DEFAULT_CGC_EN			GENMASK(6, 0)
> +
> +/* GENI_STATUS fields */
> +#define M_GENI_CMD_ACTIVE		BIT(0)
> +#define S_GENI_CMD_ACTIVE		BIT(12)
> +
> +/* GENI_SER_M_CLK_CFG/GENI_SER_S_CLK_CFG */
> +#define SER_CLK_EN			BIT(0)
> +#define CLK_DIV_MSK			GENMASK(15, 4)
> +#define CLK_DIV_SHFT			4
> +
> +/* GENI_IF_DISABLE_RO fields */
> +#define FIFO_IF_DISABLE			(BIT(0))
> +
> +/* GENI_FW_REVISION_RO fields */
> +#define FW_REV_PROTOCOL_MSK		GENMASK(15, 8)
> +#define FW_REV_PROTOCOL_SHFT		8
> +
> +/* GENI_CLK_SEL fields */
> +#define CLK_SEL_MSK			GENMASK(2, 0)
> +
> +/* SE_GENI_CFG_SEQ_START fields */
> +#define START_TRIGGER			BIT(0)
> +
> +/* SE_IRQ_EN fields */
> +#define DMA_RX_IRQ_EN			BIT(0)
> +#define DMA_TX_IRQ_EN			BIT(1)
> +#define GENI_M_IRQ_EN			BIT(2)
> +#define GENI_S_IRQ_EN			BIT(3)
> +
> +/* SE_GENI_DMA_MODE_EN */
> +#define GENI_DMA_MODE_EN		BIT(0)
> +
> +/* GENI_M_CMD0 fields */
> +#define M_OPCODE_MSK			GENMASK(31, 27)
> +#define M_OPCODE_SHFT			27
> +#define M_PARAMS_MSK			GENMASK(26, 0)
> +
> +/* GENI_M_CMD_CTRL_REG */
> +#define M_GENI_CMD_CANCEL		BIT(2)
> +#define M_GENI_CMD_ABORT		BIT(1)
> +#define M_GENI_DISABLE			BIT(0)
> +
> +/* GENI_S_CMD0 fields */
> +#define S_OPCODE_MSK			GENMASK(31, 27)
> +#define S_OPCODE_SHFT			27
> +#define S_PARAMS_MSK			GENMASK(26, 0)
> +
> +/* GENI_S_CMD_CTRL_REG */
> +#define S_GENI_CMD_CANCEL		BIT(2)
> +#define S_GENI_CMD_ABORT		BIT(1)
> +#define S_GENI_DISABLE			BIT(0)
> +
> +/* GENI_M_IRQ_EN fields */
> +#define M_CMD_DONE_EN			BIT(0)
> +#define M_CMD_OVERRUN_EN		BIT(1)
> +#define M_ILLEGAL_CMD_EN		BIT(2)
> +#define M_CMD_FAILURE_EN		BIT(3)
> +#define M_CMD_CANCEL_EN			BIT(4)
> +#define M_CMD_ABORT_EN			BIT(5)
> +#define M_TIMESTAMP_EN			BIT(6)
> +#define M_RX_IRQ_EN			BIT(7)
> +#define M_GP_SYNC_IRQ_0_EN		BIT(8)
> +#define M_GP_IRQ_0_EN			BIT(9)
> +#define M_GP_IRQ_1_EN			BIT(10)
> +#define M_GP_IRQ_2_EN			BIT(11)
> +#define M_GP_IRQ_3_EN			BIT(12)
> +#define M_GP_IRQ_4_EN			BIT(13)
> +#define M_GP_IRQ_5_EN			BIT(14)
> +#define M_TX_FIFO_NOT_EMPTY_EN		BIT(21)
> +#define M_IO_DATA_DEASSERT_EN		BIT(22)
> +#define M_IO_DATA_ASSERT_EN		BIT(23)
> +#define M_RX_FIFO_RD_ERR_EN		BIT(24)
> +#define M_RX_FIFO_WR_ERR_EN		BIT(25)
> +#define M_RX_FIFO_WATERMARK_EN		BIT(26)
> +#define M_RX_FIFO_LAST_EN		BIT(27)
> +#define M_TX_FIFO_RD_ERR_EN		BIT(28)
> +#define M_TX_FIFO_WR_ERR_EN		BIT(29)
> +#define M_TX_FIFO_WATERMARK_EN		BIT(30)
> +#define M_SEC_IRQ_EN			BIT(31)
> +#define M_COMMON_GENI_M_IRQ_EN	(GENMASK(6, 1) | \
> +				M_IO_DATA_DEASSERT_EN | \
> +				M_IO_DATA_ASSERT_EN | M_RX_FIFO_RD_ERR_EN | \
> +				M_RX_FIFO_WR_ERR_EN | M_TX_FIFO_RD_ERR_EN | \
> +				M_TX_FIFO_WR_ERR_EN)
> +
> +/* GENI_S_IRQ_EN fields */
> +#define S_CMD_DONE_EN			BIT(0)
> +#define S_CMD_OVERRUN_EN		BIT(1)
> +#define S_ILLEGAL_CMD_EN		BIT(2)
> +#define S_CMD_FAILURE_EN		BIT(3)
> +#define S_CMD_CANCEL_EN			BIT(4)
> +#define S_CMD_ABORT_EN			BIT(5)
> +#define S_GP_SYNC_IRQ_0_EN		BIT(8)
> +#define S_GP_IRQ_0_EN			BIT(9)
> +#define S_GP_IRQ_1_EN			BIT(10)
> +#define S_GP_IRQ_2_EN			BIT(11)
> +#define S_GP_IRQ_3_EN			BIT(12)
> +#define S_GP_IRQ_4_EN			BIT(13)
> +#define S_GP_IRQ_5_EN			BIT(14)
> +#define S_IO_DATA_DEASSERT_EN		BIT(22)
> +#define S_IO_DATA_ASSERT_EN		BIT(23)
> +#define S_RX_FIFO_RD_ERR_EN		BIT(24)
> +#define S_RX_FIFO_WR_ERR_EN		BIT(25)
> +#define S_RX_FIFO_WATERMARK_EN		BIT(26)
> +#define S_RX_FIFO_LAST_EN		BIT(27)
> +#define S_COMMON_GENI_S_IRQ_EN	(GENMASK(5, 1) | GENMASK(13, 9) | \
> +				 S_RX_FIFO_RD_ERR_EN | S_RX_FIFO_WR_ERR_EN)
> +
> +/*  GENI_/TX/RX/RX_RFR/_WATERMARK_REG fields */
> +#define WATERMARK_MSK			GENMASK(5, 0)
> +
> +/* GENI_TX_FIFO_STATUS fields */
> +#define TX_FIFO_WC			GENMASK(27, 0)
> +
> +/*  GENI_RX_FIFO_STATUS fields */
> +#define RX_LAST				BIT(31)
> +#define RX_LAST_BYTE_VALID_MSK		GENMASK(30, 28)
> +#define RX_LAST_BYTE_VALID_SHFT		28
> +#define RX_FIFO_WC_MSK			GENMASK(24, 0)
> +
> +/* SE_GENI_IOS fields */
> +#define IO2_DATA_IN			BIT(1)
> +#define RX_DATA_IN			BIT(0)
> +
> +/* SE_DMA_TX_IRQ_STAT Register fields */
> +#define TX_DMA_DONE			BIT(0)
> +#define TX_EOT				BIT(1)
> +#define TX_SBE				BIT(2)
> +#define TX_RESET_DONE			BIT(3)
> +
> +/* SE_DMA_RX_IRQ_STAT Register fields */
> +#define RX_DMA_DONE			BIT(0)
> +#define RX_EOT				BIT(1)
> +#define RX_SBE				BIT(2)
> +#define RX_RESET_DONE			BIT(3)
> +#define RX_FLUSH_DONE			BIT(4)
> +#define RX_DMA_PARITY_ERR		BIT(5)
> +#define RX_DMA_BREAK			GENMASK(8, 7)
> +#define RX_GENI_GP_IRQ			GENMASK(10, 5)
> +#define RX_GENI_CANCEL_IRQ		BIT(11)
> +#define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
> +
> +/* SE_HW_PARAM_0 fields */
> +#define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
> +#define TX_FIFO_WIDTH_SHFT		24
> +/*
> + * For QUP HW Version >= 3.10 Tx fifo depth support is increased
> + * to 256bytes and corresponding bits are 16 to 23
> + */
> +#define TX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
> +#define TX_FIFO_DEPTH_MSK		GENMASK(21, 16)
> +#define TX_FIFO_DEPTH_SHFT		16
> +
> +/* SE_HW_PARAM_1 fields */
> +#define RX_FIFO_WIDTH_MSK		GENMASK(29, 24)
> +#define RX_FIFO_WIDTH_SHFT		24
> +/*
> + * For QUP HW Version >= 3.10 Rx fifo depth support is increased
> + * to 256bytes and corresponding bits are 16 to 23
> + */
> +#define RX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
> +#define RX_FIFO_DEPTH_MSK		GENMASK(21, 16)
> +#define RX_FIFO_DEPTH_SHFT		16
> +
> +#define HW_VER_MAJOR_MASK		GENMASK(31, 28)
> +#define HW_VER_MAJOR_SHFT		28
> +#define HW_VER_MINOR_MASK		GENMASK(27, 16)
> +#define HW_VER_MINOR_SHFT		16
> +#define HW_VER_STEP_MASK		GENMASK(15, 0)
> +
> +#define GENI_SE_VERSION_MAJOR(ver) ((ver & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT)
> +#define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
> +#define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
> +
> +/* QUP SE VERSION value for major number 2 and minor number 5 */
> +#define QUP_SE_VERSION_2_5                  0x20050000
> +
> +#endif
> 

-- 
// Caleb (they/them)
