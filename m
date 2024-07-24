Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D1AC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375FF8892F;
	Wed, 24 Jul 2024 12:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721818624;
	bh=KKAp+cIJPcwRus76f4xI5544tVzH6qzEYlX1YBeLg2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aAmKdTCRL7oJQGwvvwB/cI5S7fEI3YcHkJoxbbbGUuKs7NHkdnYLyS2c2E0v8537o
	 cINAkDdg3gNl4zkID8nF7oJZvxz001LBqV7wuCiOwA/AHK29hvgqhssoVsCPzIUtF7
	 icNZm6m+XRjMt4gWBPO0cDZ52TN9eCHJbcj3o06g7ABFc34r/fKkibD852029MWBVm
	 WIZLFyytvoXVL+4V0X2WrRARFZ3QO2LKtmTIV4CnR++I4jmS6fVyIWiwF5ku1iY3IJ
	 H+2I4AnxGZ/v5j9UVmYee6oOWWhRbXRATPnJEMovakJ3Vq/9P0Yu9Xb0Kaguq7tPl2
	 Bzjfao3PbYK1g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 69197888AB;
 Wed, 24 Jul 2024 12:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721818620;
 bh=KKAp+cIJPcwRus76f4xI5544tVzH6qzEYlX1YBeLg2g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DFblL6f/CkNUsDNiRzg1QsLk0ggQA/0b3UV5PtWjUjayOZXUhKhpPvTm8hiQIbKMp
 UCZZ/QBdEJM1t+eF8L8ZnFblgBcJRZ5YVh+MgBA98M8snyZ4caxaWzjhtQNPXQM6vp
 uThHJtPQKwO9HXA8D4ReGEzf5eX9kFW2f/qXUPnL0qOOWV35OIIyPCpvnLnENXZkFT
 fLneCXNdd7iGlw2Ez7hQxctUGN31cSYkksyGRHe2Bxfo8o3zCyKueF9CCe3iSJi7wg
 NGUpsgNxEJl/xBDJSTNJ5Bu3oX0Kh7Frdr96vPYujoGsnHDXSNbksjilMqL6CzmkGC
 CKy5nvdTP6lxA==
Message-ID: <4c4bbfdc-1a35-4445-8039-8693020b1658@denx.de>
Date: Wed, 24 Jul 2024 12:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: imx_lpi2c: Support read transfers longer than
 256 bytes
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240724095943.214967-1-fedor.ross@ifm.com>
 <20240724095943.214967-3-fedor.ross@ifm.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240724095943.214967-3-fedor.ross@ifm.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/24/24 11:59 AM, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> The TXFIFO register of LPI2C only has one byte length, and if the length
> of the data that needs to be read exceeds 256 bytes, it needs to be
> written to TXFIFO multiple times.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>

Add ---

> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>   drivers/i2c/imx_lpi2c.c | 72 +++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index 7b10b2b252d..dd97228ddc7 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -19,6 +19,8 @@
>   #define LPI2C_NACK_TOUT_MS 1
>   #define LPI2C_TIMEOUT_MS 100
>   
> +#define CHUNK_DATA      256

Use LPI2C_CHUNK_DATA to namespace this macro.

>   static int bus_i2c_init(struct udevice *bus, int speed);
>   
>   /* Weak linked function for overridden by some SoC power function */
> @@ -118,8 +120,10 @@ static int bus_i2c_send(struct udevice *bus, u8 *txbuf, int len)
>   
>   static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
>   {
> +	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
>   	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
>   	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
> +	unsigned int chunk_len, rx_remain, timeout;
>   	lpi2c_status_t result = LPI2C_SUCESS;
>   	u32 val;
>   	ulong start_time = get_timer(0);
> @@ -128,33 +132,51 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
>   	if (!len)
>   		return result;
>   
> -	result = bus_i2c_wait_for_tx_ready(regs);
> -	if (result) {
> -		debug("i2c: receive wait for tx ready: %d\n", result);
> -		return result;
> -	}
> +	/*
> +	 * Extend the timeout for a bulk read if needed.
> +	 * The calculated timeout is the result of multiplying the
> +	 * transfer length with 8 bit + ACK + one clock of extra time,
> +	 * considering the I2C bus frequency.
> +	 */
> +	timeout = max(len * 10 * 1000 / i2c->speed_hz, LPI2C_TIMEOUT_MS);
>   
> -	/* clear all status flags */
> -	writel(0x7f00, &regs->msr);
> -	/* send receive command */
> -	val = LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(len - 1);
> -	writel(val, &regs->mtdr);
> +	rx_remain = len;
> +	while (rx_remain > 0) {
> +		chunk_len = clamp(rx_remain, 1, CHUNK_DATA) - 1;
>   
> -	while (len--) {
> -		do {
> -			result = imx_lpci2c_check_clear_error(regs);
> -			if (result) {
> -				debug("i2c: receive check clear error: %d\n",
> -				      result);
> -				return result;
> -			}
> -			if (get_timer(start_time) > LPI2C_TIMEOUT_MS) {
> -				debug("i2c: receive mrdr: timeout\n");
> -				return -1;
> -			}
> -			val = readl(&regs->mrdr);
> -		} while (val & LPI2C_MRDR_RXEMPTY_MASK);
> -		*rxbuf++ = LPI2C_MRDR_DATA(val);
> +		result = bus_i2c_wait_for_tx_ready(regs);
> +		if (result) {
> +			debug("i2c: receive wait for tx ready: %d\n", result);
> +			return result;
> +		}
> +
> +		/* clear all status flags */
> +		writel(0x7f00, &regs->msr);
> +		/* send receive command */
> +		val = LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len);
> +		writel(val, &regs->mtdr);

writel(LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len);, &regs->mtdr);

and drop the val = assignment here.

> +		rx_remain = rx_remain - (chunk_len & 0xff) - 1;
> +
> +		while (len--) {
> +			do {
> +				result = imx_lpci2c_check_clear_error(regs);
> +				if (result) {
> +					debug("i2c: receive check clear error: %d\n",
> +					      result);
> +					return result;
> +				}
> +				if (get_timer(start_time) > timeout) {
> +					debug("i2c: receive mrdr: timeout\n");
> +					return -1;
> +				}
> +				val = readl(&regs->mrdr);
> +			} while (val & LPI2C_MRDR_RXEMPTY_MASK);
> +			*rxbuf++ = LPI2C_MRDR_DATA(val);
> +
> +			/* send next receive command before controller NACKs last byte */
> +			if ((len - rx_remain) < 2 && rx_remain > 0)
> +				break;
> +		}
>   	}
