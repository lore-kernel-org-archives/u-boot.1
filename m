Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4EDCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A896A82A9E;
	Mon, 27 Oct 2025 06:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NhoY4Kbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C478982C7F; Mon, 27 Oct 2025 06:14:45 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C595680422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 71B83103244; Mon, 27 Oct 2025 06:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761542083;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5sqIAxaHd/wV0S9UmAgNgy0DA8K4rsE4F2HbknOM7Wk=;
 b=NhoY4KbbeVXTZqUQXmlXMwVWvpnCJPlNyGDK1NGj7CYtxddv7N4r7P86EQfiuwRi9NG48K
 DYctZBy/fyj37KxfjxBuy10p9ibeVBg4cdjjhK2FaEjrqEfqDYCWi/3or8hJRyvdeTVz43
 pCH0cmW/weUTV8AZImy7HfOPfrVg7a6dH2kMIjlbzkpHufxUJ7IX+Zsj9bl//T92RbIVon
 0w8lkF+foPyC2moNOanfa0O31BVoXEyfYh5fHjfzd3+h5FVh81XBYVP11v9Gs93m01YB8l
 JcxTk47fiuhKwhxhdeDEy0qbXCPa7I8l/pg3wybqS38l/6/74hLzcjdDqMtQOA==
Message-ID: <adc78ad5-9ad5-7207-d85e-7d7530fd5f82@nabladev.com>
Date: Mon, 27 Oct 2025 06:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: samsung: add support for Exynos7 HS-I2C
Content-Language: en-US
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Kaustabh,

On 17.10.25 17:23, Kaustabh Chakraborty wrote:
> Exynos7 (and later) HS-I2C blocks have special interrupts regarding
> various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
> for enabling and handling these interrupt bits.
> 
> Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
> differentiate between the multiple device variants, an enum is
> introduced which is used where difference in implementations exist.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/i2c/exynos_hs_i2c.c | 105 ++++++++++++++++++++++++++++++++++++--------
>   drivers/i2c/s3c24x0_i2c.h   |   7 +++
>   2 files changed, 94 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
> index fa0d1c8f64ab593942a4ebe52f7b028366ce489c..67b497b228b151a2b23befc7fa62b34bbd07f388 100644
> --- a/drivers/i2c/exynos_hs_i2c.c
> +++ b/drivers/i2c/exynos_hs_i2c.c
> @@ -54,6 +54,17 @@ DECLARE_GLOBAL_DATA_PTR;
>   				 HSI2C_RX_OVERRUN_EN  |\
>   				 HSI2C_INT_TRAILING_EN)
>   
> +#define HSI2C_INT_TRANS_DONE		(1u << 7)
> +#define HSI2C_INT_TRANS_ABORT		(1u << 8)
> +#define HSI2C_INT_NO_DEV_ACK		(1u << 9)
> +#define HSI2C_INT_NO_DEV		(1u << 10)
> +#define HSI2C_INT_TIMEOUT_AUTO		(1u << 11)
> +#define HSI2C_INT_I2C_TRANS_EN		(HSI2C_INT_TRANS_DONE  |\
> +					 HSI2C_INT_TRANS_ABORT |\
> +					 HSI2C_INT_NO_DEV_ACK  |\
> +					 HSI2C_INT_NO_DEV      |\
> +					 HSI2C_INT_TIMEOUT_AUTO)
> +
>   /* I2C_CONF Register bits */
>   #define HSI2C_AUTO_MODE			(1u << 31)
>   #define HSI2C_10BIT_ADDR_MODE		(1u << 30)
> @@ -99,24 +110,32 @@ DECLARE_GLOBAL_DATA_PTR;
>    * bit to be set, which indicates copletion of a transaction.
>    *
>    * @param i2c: pointer to the appropriate register bank
> + * @param variant: hardware variant of the i2c device
>    *
>    * @return: I2C_OK in case of successful completion, I2C_NOK_TIMEOUT in case
>    *          the status bits do not get set in time, or an approrpiate error
>    *          value in case of transfer errors.
>    */
> -static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
> +static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c,
> +			      enum s3c24x0_i2c_variant variant)
>   {
>   	int i = HSI2C_TIMEOUT_US;
>   
>   	while (i-- > 0) {
>   		u32 int_status = readl(&i2c->usi_int_stat);
> +		u32 trans_status;
>   
> -		if (int_status & HSI2C_INT_I2C_EN) {
> -			u32 trans_status = readl(&i2c->usi_trans_status);
> +		switch (variant) {
> +		case VARIANT_HSI2C_EXYNOS5:
> +			trans_status = readl(&i2c->usi_trans_status);
>   
>   			/* Deassert pending interrupt. */
>   			writel(int_status, &i2c->usi_int_stat);
>   
> +			if (!(int_status & HSI2C_INT_I2C_EN)) {
> +				udelay(1);
> +				continue;
> +			}
>   			if (trans_status & HSI2C_NO_DEV_ACK) {
>   				debug("%s: no ACK from device\n", __func__);
>   				return I2C_NACK;
> @@ -134,8 +153,32 @@ static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
>   				return I2C_NOK_TOUT;
>   			}
>   			return I2C_OK;
> +		case VARIANT_HSI2C_EXYNOS7:
> +			if (int_status & HSI2C_INT_TRANS_DONE)
> +				return I2C_OK;
> +
> +			if (int_status & HSI2C_INT_TRANS_ABORT) {
> +				debug("%s: arbitration lost\n", __func__);
> +				return I2C_NOK_LA;
> +			}
> +			if (int_status & HSI2C_NO_DEV_ACK) {
> +				debug("%s: no ACK from device\n", __func__);
> +				return I2C_NACK;
> +			}
> +			if (int_status & HSI2C_NO_DEV) {
> +				debug("%s: no device\n", __func__);
> +				return I2C_NOK;
> +			}
> +			if (int_status & HSI2C_TIMEOUT_AUTO) {
> +				debug("%s: device timed out\n", __func__);
> +				return I2C_NOK_TOUT;
> +			}
> +			udelay(1);
> +			continue;
> +		default:
> +			debug("%s: unknown variant\n", __func__);
> +			return I2C_NOK;
>   		}
> -		udelay(1);
>   	}
>   	debug("%s: transaction timeout!\n", __func__);
>   	return I2C_NOK_TOUT;

May I oversee something .. but is for the new variant the i2c->usi_int_stat
register ever cleared? I do not see a write for it in this case... or
is it there cleared on read?

In linux driver:/drivers/i2c/busses/i2c-exynos5.c

  501 static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
[...]
  512         int_status = readl(i2c->regs + HSI2C_INT_STATUS);
  513         writel(int_status, i2c->regs + HSI2C_INT_STATUS);

independent from the variant... may it is valid to do this in our
driver too?

Some Testing on VARIANT_HSI2C_EXYNOS5 would be nice ... do you have
such a hardware?

Beside of this, change looks good to me.

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
