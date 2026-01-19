Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE69CCF2D0
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBFF80B98;
	Mon, 19 Jan 2026 10:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YoKUaAkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A6D58313B; Mon, 19 Jan 2026 06:25:28 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B818004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 06:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08D6D10E683; Mon, 19 Jan 2026 06:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1768800323;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xvGvs36J11Hh/q0QkJV7zjrGhF5zgo+NIH1/SE7mgMo=;
 b=YoKUaAkjyToqX6BCe5h+hD0u7bvOO+GeSre/+xFjQlUSrEP6Sga0PzWv8beUQUZNwgrqhQ
 iaiUGMh7dFuI+2ENVSBXzuwzN1rloNwYC78Mc6lQEy3+2XsfbhHTp80tnDUk5KoDCLSBVX
 vnCyA+zktsbxSH2Z7/xsd22qTKgbmV3XDFNTf6IkdJkhJYR+5Wvfm/mL3GV5w7vleatcsA
 Irr8j77I8rXpj/rM+xPRm/NnhuMg1UCDoYmLtYOiGl7stWhAZ05HHGc8un23yo82h17sBy
 vs3Yk9Mp/zZaemYvI6q6ojlzKOAUmfHqD/oys1qmivdPOOdiRFT8d8pMzoknFA==
Message-ID: <21e9be82-6871-5b71-2c16-396a711fdbae@nabladev.com>
Date: Mon, 19 Jan 2026 06:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 11/17] i2c: k1: add I2C driver support
Content-Language: en-US
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Greg Malysa <malysagreg@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Andre Przywara <andre.przywara@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-12-raymondmaoca@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260117190231.977686-12-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 19 Jan 2026 10:12:16 +0100
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

Hello Raymond,

On 17.01.26 20:01, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Add I2C driver support on Spacemit K1 SoC using driver model.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>   drivers/i2c/Kconfig  |   7 +
>   drivers/i2c/Makefile |   1 +
>   drivers/i2c/k1_i2c.c | 521 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/i2c/k1_i2c.h |  69 ++++++
>   4 files changed, 598 insertions(+)
>   create mode 100644 drivers/i2c/k1_i2c.c
>   create mode 100644 drivers/i2c/k1_i2c.h
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 55465dc1d46..eb7219f15a6 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -817,6 +817,13 @@ config SYS_I2C_IHS
>           help
>             Support for gdsys IHS I2C driver on FPGA bus.
>   
> +config SYS_I2C_SPACEMIT_K1
> +	bool "Spacemit K1 I2C driver"
> +	depends on DM_I2C
> +	help
> +	  Support for Spacemit I2C controller. It's based on
> +	  Driver Model.
> +
>   source "drivers/i2c/muxes/Kconfig"
>   
>   endif
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index 5fe30d0df4f..f25c56a37c7 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_SYS_I2C_UNIPHIER) += i2c-uniphier.o
>   obj-$(CONFIG_SYS_I2C_UNIPHIER_F) += i2c-uniphier-f.o
>   obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
>   obj-$(CONFIG_SYS_I2C_XILINX_XIIC) += xilinx_xiic.o
> +obj-$(CONFIG_SYS_I2C_SPACEMIT_K1) += k1_i2c.o

Nitpick, please sort alphabetical.

>   obj-$(CONFIG_TEGRA186_BPMP_I2C) += tegra186_bpmp_i2c.o
>   
>   obj-$(CONFIG_$(PHASE_)I2C_MUX) += muxes/
> diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
> new file mode 100644
> index 00000000000..2de24ac779b
> --- /dev/null
> +++ b/drivers/i2c/k1_i2c.c
> @@ -0,0 +1,521 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023-2026 Spacemit, Inc
> + * Copyright (C) 2025-2026 RISCStar Ltd.
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <i2c.h>
> +#include <linux/delay.h>
> +#include <reset.h>
> +#include "k1_i2c.h"
> +
> +#define ICR_OFFSET		0x00
> +#define ISR_OFFSET		0x04
> +#define ISAR_OFFSET		0x08
> +#define IDBR_OFFSET		0x0c
> +#define ILCR_OFFSET		0x10
> +#define IWCR_OFFSET		0x14
> +#define IRCR_OFFSET		0x18
> +#define IBMR_OFFSET		0x1c
> +#define WFIFO_OFFSET		0x20
> +#define WFIFO_WPTR_OFFSET	0x24
> +#define WFIFO_RPTR_OFFSET	0x28
> +#define RFIFO_OFFSET		0x2c
> +#define RFIFO_WPTR_OFFSET	0x30
> +#define RFIFO_RPTR_OFFSET	0x34
> +
> +/* All transfers are described by this data structure */
> +struct k1_i2c_msg {
> +	u8 condition;
> +	u8 acknack;
> +	u8 direction;
> +	u8 data;
> +};
> +
> +struct k1_i2c {
> +	u32 icr;
> +	u32 isr;
> +	u32 isar;
> +	u32 idbr;
> +	u32 ilcr;
> +	u32 iwcr;
> +	u32 irst_cyc;
> +	u32 ibmr;
> +};
> +
> +struct k1_i2c_priv {
> +	int id;
> +	void __iomem *base;
> +	struct reset_ctl_bulk resets;
> +	struct clk clk;
> +	u32 clk_rate;
> +};
> +
> +/*
> + * i2c_reset: - reset the host controller
> + *
> + */
> +static void i2c_reset(void __iomem *base)
> +{
> +	u32 icr_mode;
> +	u32 val;
> +
> +	/* Save bus mode (standard or fast speed) for later use */
> +	icr_mode = readl(base + ICR_OFFSET) & ICR_MODE_MASK;
> +	/* disable unit */
> +	val = readl(base + ICR_OFFSET);
> +	writel(val & ~ICR_IUE, base + ICR_OFFSET);
> +	udelay(10);
> +	/* reset the unit */
> +	val = readl(base + ICR_OFFSET);
> +	val |= ICR_UR;
> +	writel(val, base + ICR_OFFSET);
> +	udelay(100);
> +	/* disable unit */
> +	val = readl(base + ICR_OFFSET);
> +	writel(val & ~ICR_IUE, base + ICR_OFFSET);
> +
> +	/* set slave address */
> +	writel(0x00, base + ISR_OFFSET);
> +	/* set control reg values */
> +	writel(I2C_ICR_INIT | icr_mode, base + ICR_OFFSET);
> +	writel(I2C_ISR_INIT, base + ISR_OFFSET); /* set clear interrupt bits */
> +	val = readl(base + ICR_OFFSET);
> +	val |= ICR_IUE;
> +	writel(val, base + ICR_OFFSET); /* enable unit */
> +	udelay(100);
> +}
> +
> +/*
> + * i2c_isr_set_cleared: - wait until certain bits of the I2C status register
> + *	                  are set and cleared
> + *
> + * @return: 1 in case of success, 0 means timeout (no match within 10 ms).

may you can rework this to return 0 on success and on error -ETIMEDOUT ?

> + */
> +static int /(void __iomem *base, unsigned long set_mask,
> +			       unsigned long cleared_mask)
> +{
> +	int timeout = 1000, isr;
> +
> +	do {
> +		isr = readl(base + ISR_OFFSET);
> +		udelay(10);
> +		if (timeout-- < 0)
> +			return 0;
> +	} while (((isr & set_mask) != set_mask) ||
> +		 ((isr & cleared_mask) != 0));

may you can use readl_poll_timeout ?

> +
> +	return 1;


> +}
> +
> +/*
> + * i2c_transfer: - Transfer one byte over the i2c bus
> + *
> + * This function can transfer a byte over the i2c bus in both directions.
> + * It is used by the public API functions.
> + *
> + * @return:  0: transfer successful or error code
> + */
> +static int i2c_transfer(void __iomem *base, struct k1_i2c_msg *msg)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (!msg)
> +		goto transfer_error_msg_empty;
> +
> +	switch (msg->direction) {
> +	case I2C_WRITE:
> +		/* check if bus is not busy */
> +		if (!i2c_isr_set_cleared(base, 0, ISR_IBB))
> +			goto transfer_error_bus_busy;
> +
> +		/* start transmission */
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_START;
> +		writel(val, base + ICR_OFFSET);
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_STOP;
> +		writel(val, base + ICR_OFFSET);
> +		writel(msg->data, base + IDBR_OFFSET);
> +		if (msg->condition == I2C_COND_START) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_START;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->condition == I2C_COND_STOP) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_STOP;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_ACKNAK;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->acknack == I2C_ACKNAK_SENDACK) {
> +			val = readl(base + ICR_OFFSET);
> +			val &= ~ICR_ACKNAK;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_ALDIE;
> +		writel(val, base + ICR_OFFSET);
> +		val = readl(base + ICR_OFFSET);
> +		val |= ICR_TB;
> +		writel(val, base + ICR_OFFSET);
> +
> +		/* transmit register empty? */
> +		if (!i2c_isr_set_cleared(base, ISR_ITE, 0))
> +			goto transfer_error_transmit_timeout;
> +
> +		/* clear 'transmit empty' state */
> +		val = readl(base + ISR_OFFSET);
> +		val |= ISR_ITE;
> +		writel(val, base + ISR_OFFSET);
> +
> +		/* wait for ACK from slave */
> +		if (msg->acknack == I2C_ACKNAK_WAITACK)
> +			if (!i2c_isr_set_cleared(base, 0, ISR_ACKNAK))
> +				goto transfer_error_ack_missing;
> +		break;
> +
> +	case I2C_READ:
> +

please remove empty line

> +		/* check if bus is not busy */
> +		if (!i2c_isr_set_cleared(base, 0, ISR_IBB))
> +			goto transfer_error_bus_busy;
> +
> +		/* start receive */
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_START;
> +		writel(val, base + ICR_OFFSET);
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_STOP;
> +		writel(val, base + ICR_OFFSET);
> +		if (msg->condition == I2C_COND_START) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_START;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->condition == I2C_COND_STOP) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_STOP;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
> +			val = readl(base + ICR_OFFSET);
> +			val |= ICR_ACKNAK;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		if (msg->acknack == I2C_ACKNAK_SENDACK) {
> +			val = readl(base + ICR_OFFSET);
> +			val &= ~ICR_ACKNAK;
> +			writel(val, base + ICR_OFFSET);
> +		}
> +		val = readl(base + ICR_OFFSET);
> +		val &= ~ICR_ALDIE;
> +		writel(val, base + ICR_OFFSET);
> +		val = readl(base + ICR_OFFSET);
> +		val |= ICR_TB;
> +		writel(val, base + ICR_OFFSET);
> +
> +		/* receive register full? */
> +		if (!i2c_isr_set_cleared(base, ISR_IRF, 0))
> +			goto transfer_error_receive_timeout;
> +
> +		msg->data = readl(base + IDBR_OFFSET);
> +
> +		/* clear 'receive empty' state */
> +		val = readl(base + ISR_OFFSET);
> +		val |= ISR_IRF;
> +		writel(val, base + ISR_OFFSET);
> +		break;
> +	default:
> +		goto transfer_error_illegal_param;
> +	}
> +
> +	return 0;
> +
> +transfer_error_msg_empty:
> +	debug("%s: error: 'msg' is empty\n", __func__);
> +	ret = -EINVAL;
> +	goto i2c_transfer_finish;
> +
> +transfer_error_transmit_timeout:
> +	debug("%s: error: transmit timeout\n", __func__);
> +	ret = -ETIMEDOUT;
> +	goto i2c_transfer_finish;
> +
> +transfer_error_ack_missing:
> +	debug("%s: error: ACK missing\n", __func__);
> +	ret = -EREMOTEIO;
> +	goto i2c_transfer_finish;
> +
> +transfer_error_receive_timeout:
> +	debug("%s: error: receive timeout\n", __func__);
> +	ret = -ETIMEDOUT;
> +	goto i2c_transfer_finish;
> +
> +transfer_error_illegal_param:
> +	debug("%s: error: illegal parameters\n", __func__);
> +	ret = -EINVAL;
> +	goto i2c_transfer_finish;
> +
> +transfer_error_bus_busy:
> +	debug("%s: error: bus is busy\n", __func__);
> +	ret = -EIO;
> +	goto i2c_transfer_finish;
> +
> +i2c_transfer_finish:
> +	debug("%s: ISR: 0x%04x\n", __func__, readl(base + ISR_OFFSET));
> +	i2c_reset(base);
> +	return ret;
> +}
> +
> +static int __i2c_read(void __iomem *base, uchar chip, u8 *addr, int alen,
> +		      uchar *buffer, int len)
> +{
> +	struct k1_i2c_msg msg;
> +	int ret;
> +
> +	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
> +	      __func__, chip, *addr, alen, len);
> +
> +	if (len == 0) {
> +		pr_err("reading zero byte is invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	i2c_reset(base);
> +
> +	/* dummy chip address write */
> +	debug("%s: dummy chip address write\n", __func__);
> +	msg.condition = I2C_COND_START;
> +	msg.acknack   = I2C_ACKNAK_WAITACK;
> +	msg.direction = I2C_WRITE;
> +	msg.data = (chip << 1);
> +	msg.data &= 0xFE;
> +	ret = i2c_transfer(base, &msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * send memory address bytes;
> +	 * alen defines how much bytes we have to send.
> +	 */
> +	while (--alen >= 0) {
> +		debug("%s: send address byte %02x (alen=%d)\n",
> +		      __func__, *addr, alen);
> +		msg.condition = I2C_COND_NORMAL;
> +		msg.acknack   = I2C_ACKNAK_WAITACK;
> +		msg.direction = I2C_WRITE;
> +		msg.data      = addr[alen];
> +		ret = i2c_transfer(base, &msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* start read sequence */
> +	debug("%s: start read sequence\n", __func__);
> +	msg.condition = I2C_COND_START;
> +	msg.acknack   = I2C_ACKNAK_WAITACK;
> +	msg.direction = I2C_WRITE;
> +	msg.data      = (chip << 1);
> +	msg.data     |= 0x01;
> +	ret = i2c_transfer(base, &msg);
> +	if (ret)
> +		return ret;
> +
> +	/* read bytes; send NACK at last byte */
> +	while (len--) {
> +		if (len == 0) {
> +			msg.condition = I2C_COND_STOP;
> +			msg.acknack   = I2C_ACKNAK_SENDNAK;
> +		} else {
> +			msg.condition = I2C_COND_NORMAL;
> +			msg.acknack   = I2C_ACKNAK_SENDACK;
> +		}
> +
> +		msg.direction = I2C_READ;
> +		msg.data      = 0x00;
> +		ret = i2c_transfer(base, &msg);
> +		if (ret)
> +			return ret;
> +
> +		*buffer = msg.data;
> +		debug("%s: reading byte (%p)=0x%02x\n",
> +		      __func__, buffer, *buffer);
> +		buffer++;
> +	}
> +
> +	i2c_reset(base);
> +
> +	return 0;
> +}
> +
> +static int __i2c_write(struct k1_i2c *base, uchar chip, u8 *addr, int alen,
> +		       uchar *buffer, int len)
> +{
> +	struct k1_i2c_msg msg;
> +	int ret;
> +
> +	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
> +	      __func__, chip, *addr, alen, len);
> +
> +	i2c_reset(base);
> +
> +	/* chip address write */
> +	debug("%s: chip address write\n", __func__);
> +	msg.condition = I2C_COND_START;
> +	msg.acknack   = I2C_ACKNAK_WAITACK;
> +	msg.direction = I2C_WRITE;
> +	msg.data = (chip << 1);
> +	msg.data &= 0xFE;
> +	ret = i2c_transfer(base, &msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * send memory address bytes;
> +	 * alen defines how much bytes we have to send.
> +	 */
> +	while (--alen >= 0) {
> +		debug("%s: send address byte %02x (alen=%d)\n",
> +		      __func__, *addr, alen);
> +		msg.condition = I2C_COND_NORMAL;
> +		msg.acknack   = I2C_ACKNAK_WAITACK;
> +		msg.direction = I2C_WRITE;
> +		msg.data      = addr[alen];
> +		ret = i2c_transfer(base, &msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* write bytes; send NACK at last byte */
> +	while (len--) {
> +		debug("%s: writing byte (%p)=0x%02x\n",
> +		      __func__, buffer, *buffer);
> +
> +		if (len == 0)
> +			msg.condition = I2C_COND_STOP;
> +		else
> +			msg.condition = I2C_COND_NORMAL;
> +
> +		msg.acknack   = I2C_ACKNAK_WAITACK;
> +		msg.direction = I2C_WRITE;
> +		msg.data      = *(buffer++);
> +
> +		ret = i2c_transfer(base, &msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	i2c_reset(base);
> +
> +	return 0;
> +}
> +
> +static int k1_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
> +{
> +	struct k1_i2c_priv *i2c = dev_get_priv(bus);
> +	struct i2c_msg *dmsg, *omsg, dummy;
> +
> +	memset(&dummy, 0, sizeof(struct i2c_msg));
> +
> +	/*
> +	 * We expect either two messages (one with an offset and one with the
> +	 * actual data) or one message (just data or offset/data combined)
> +	 */
> +	if (nmsgs > 2 || nmsgs == 0) {
> +		debug("%s: Only one or two messages are supported.", __func__);
> +		return -EINVAL;
> +	}
> +
> +	omsg = nmsgs == 1 ? &dummy : msg;
> +	dmsg = nmsgs == 1 ? msg : msg + 1;
> +
> +	if (dmsg->flags & I2C_M_RD)
> +		return __i2c_read(i2c->base, dmsg->addr, omsg->buf,
> +				  omsg->len, dmsg->buf, dmsg->len);
> +	else
> +		return __i2c_write(i2c->base, dmsg->addr, omsg->buf,
> +				   omsg->len, dmsg->buf, dmsg->len);
> +}
> +
> +static int k1_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
> +{
> +	struct k1_i2c_priv *priv = dev_get_priv(bus);
> +	void __iomem *base = priv->base;
> +	u32 val;
> +
> +	if (speed > 100000)

please use I2C_SPEED_STANDARD_RATE

> +		val = ICR_FM;
> +	else
> +		val = ICR_SM;
> +	clrsetbits_le32(base + ICR_OFFSET, ICR_MODE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int k1_i2c_bind(struct udevice *bus)
> +{
> +	return 0;
> +}

I think you can remove this function complete (and so in U_BOOT_DRIVER(i2c_spacemit))

> +
> +static int k1_i2c_probe(struct udevice *bus)
> +{
> +	struct k1_i2c_priv *priv = dev_get_priv(bus);
> +	struct reset_ctl reset;
> +	int ret;
> +
> +	priv->id = dev_seq(bus);
> +	ret = reset_get_by_index(bus, 0, &reset);
> +	if (ret) {
> +		dev_err(bus, "%s: can not get reset\n", __func__);
> +		return ret;
> +	}
> +	reset_assert(&reset);
> +	udelay(10);
> +	reset_deassert(&reset);
> +	udelay(10);
> +
> +	ret = clk_get_by_index(bus, 0, &priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
> +		debug("%s: failed to enable clock\n", __func__);
> +		return ret;
> +	}
> +	priv->clk_rate = clk_get_rate(&priv->clk);
> +
> +	priv->base = (void *)devfdt_get_addr_ptr(bus);
> +	k1_i2c_set_bus_speed(bus, priv->clk_rate);
> +	return 0;
> +}
> +
> +static const struct dm_i2c_ops k1_i2c_ops = {
> +	.xfer		= k1_i2c_xfer,
> +	.set_bus_speed	= k1_i2c_set_bus_speed,
> +};
> +
> +static const struct udevice_id k1_i2c_ids[] = {
> +	{ .compatible = "spacemit,k1-i2c" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(i2c_spacemit) = {
> +	.name	= "i2c_spacemit",
> +	.id	= UCLASS_I2C,
> +	.of_match = k1_i2c_ids,
> +	.bind	= k1_i2c_bind,
> +	.probe	= k1_i2c_probe,
> +	.priv_auto = sizeof(struct k1_i2c_priv),
> +	.ops	= &k1_i2c_ops,
> +};
> diff --git a/drivers/i2c/k1_i2c.h b/drivers/i2c/k1_i2c.h
> new file mode 100644
> index 00000000000..a755abf054d
> --- /dev/null
> +++ b/drivers/i2c/k1_i2c.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023-2026 Spacemit Ltd.
> + * Copyright (C) 2025-2026 RISCStar Ltd.
> + */
> +
> +#ifndef __SPACEMIT_I2C_H
> +#define __SPACEMIT_I2C_H
> +
> +/* Shall the current transfer have a start/stop condition? */
> +#define I2C_COND_NORMAL		0
> +#define I2C_COND_START		1
> +#define I2C_COND_STOP		2
> +
> +/* Shall the current transfer be ack/nacked or being waited for it? */
> +#define I2C_ACKNAK_WAITACK	1
> +#define I2C_ACKNAK_SENDACK	2
> +#define I2C_ACKNAK_SENDNAK	4
> +
> +/* Specify who shall transfer the data (master or slave) */
> +#define I2C_READ		0
> +#define I2C_WRITE		1
> +
> +#if (CONFIG_SYS_I2C_SPEED == 400000)
> +#define I2C_ICR_INIT	(ICR_FM | ICR_BEIE | ICR_IRFIE | ICR_ITEIE |	\
> +			 ICR_GCD | ICR_SCLE)
> +#else
> +#define I2C_ICR_INIT	(ICR_BEIE | ICR_IRFIE | ICR_ITEIE | ICR_GCD |	\
> +			 ICR_SCLE)
> +#endif
> +
> +/* ----- Control register bits ---------------------------------------- */
> +
> +#define ICR_START	0x1		/* start bit */
> +#define ICR_STOP	0x2		/* stop bit */
> +#define ICR_ACKNAK	0x4		/* send ACK(0) or NAK(1) */
> +#define ICR_TB		0x8		/* transfer byte bit */
> +#define ICR_MA		BIT(12)		/* master abort */
> +#define ICR_SCLE	BIT(13)		/* master clock enable, mona SCLEA */
> +#define ICR_IUE		BIT(14)		/* unit enable */
> +#define ICR_GCD		BIT(21)		/* general call disable */
> +#define ICR_ITEIE	BIT(19)		/* enable tx interrupts */
> +#define ICR_IRFIE	BIT(20)		/* enable rx interrupts, mona: DRFIE */
> +#define ICR_BEIE	BIT(22)		/* enable bus error ints */
> +#define ICR_SSDIE	BIT(24)		/* slave STOP detected int enable */
> +#define ICR_ALDIE	BIT(18)		/* enable arbitration interrupt */
> +#define ICR_SADIE	BIT(23)		/* slave address detected int enable */
> +#define ICR_UR		BIT(10)		/* unit reset */
> +#define ICR_SM		(0x0)		/* Standard Mode */
> +#define ICR_FM		BIT(8)		/* Fast Mode */
> +#define ICR_MODE_MASK	(0x300)		/* Mode mask */
> +
> +/* ----- Status register bits ----------------------------------------- */
> +
> +#define ISR_RWM		BIT(13)		/* read/write mode */
> +#define ISR_ACKNAK	BIT(14)		/* ack/nak status */
> +#define ISR_UB		BIT(15)		/* unit busy */
> +#define ISR_IBB		BIT(16)		/* bus busy */
> +#define ISR_SSD		BIT(24)		/* slave stop detected */
> +#define ISR_ALD		BIT(18)		/* arbitration loss detected */
> +#define ISR_ITE		BIT(19)		/* tx buffer empty */
> +#define ISR_IRF		BIT(20)		/* rx buffer full */
> +#define ISR_GCAD	BIT(21)		/* general call address detected */
> +#define ISR_SAD		BIT(23)		/* slave address detected */
> +#define ISR_BED		BIT(22)		/* bus error no ACK/NAK */
> +
> +#define I2C_ISR_INIT	0x1FDE000
> +
> +#endif
> 

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
