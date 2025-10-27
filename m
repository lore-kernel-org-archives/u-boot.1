Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36128CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA21838D5;
	Mon, 27 Oct 2025 14:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PcvpSowB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB10F82C7F; Mon, 27 Oct 2025 11:32:38 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90FD580107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 667C2263A5;
 Mon, 27 Oct 2025 11:32:35 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6wRZfjsAKpX; Mon, 27 Oct 2025 11:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761561154; bh=lZLV8ty2HPZB0eHS4DT4WzoZNfp2DK+Aze77x6ThOkg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PcvpSowBiCo5v7KWXhZjZT3mU5ilBmwABO2NxsLHxabNEg/y7O4OnwLnHz+TN8CPy
 0IvcdlFCf9xsUCY8trvRa4rFM955uWnTWkCWnSZ8g32C7nl3ksnYw8UpfEHZXhZAnm
 PYJuHEkjWVJl0XbaJoDw4AQIAx34H1aV5b9R+Q3cdS+6LWt64LdVgb2pdZhlKcqq4i
 iNwypHr7QqENCbCkD32A2oLEGiV4OHKp/59fZzx4jwgrxNgR0bwtTFz9n5y61j3eVD
 RuofXqrBB5PZrCv6upOarLrNlXv8H7niqUQWzqPctQxWzLvrEn4cCtheyz/j4bKdNX
 cnxqna+pDlwoA==
MIME-Version: 1.0
Date: Mon, 27 Oct 2025 10:32:34 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] i2c: samsung: add support for Exynos7 HS-I2C
In-Reply-To: <adc78ad5-9ad5-7207-d85e-7d7530fd5f82@nabladev.com>
References: <20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org>
 <adc78ad5-9ad5-7207-d85e-7d7530fd5f82@nabladev.com>
Message-ID: <ae1cdb639a1f2c27cee7579c725955f9@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:02:31 +0100
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

On 2025-10-27 05:15, Heiko Schocher wrote:
> Hello Kaustabh,
> 
> On 17.10.25 17:23, Kaustabh Chakraborty wrote:
>> Exynos7 (and later) HS-I2C blocks have special interrupts regarding
>> various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
>> for enabling and handling these interrupt bits.
>> 
>> Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
>> differentiate between the multiple device variants, an enum is
>> introduced which is used where difference in implementations exist.
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>   drivers/i2c/exynos_hs_i2c.c | 105 ++++++++++++++++++++++++++++++++++++--------
>>   drivers/i2c/s3c24x0_i2c.h   |   7 +++
>>   2 files changed, 94 insertions(+), 18 deletions(-)
>> 
>> diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
>> index fa0d1c8f64ab593942a4ebe52f7b028366ce489c..67b497b228b151a2b23befc7fa62b34bbd07f388 100644
>> --- a/drivers/i2c/exynos_hs_i2c.c
>> +++ b/drivers/i2c/exynos_hs_i2c.c
>> @@ -54,6 +54,17 @@ DECLARE_GLOBAL_DATA_PTR;
>>   				 HSI2C_RX_OVERRUN_EN  |\
>>   				 HSI2C_INT_TRAILING_EN)
>>   +#define HSI2C_INT_TRANS_DONE		(1u << 7)
>> +#define HSI2C_INT_TRANS_ABORT		(1u << 8)
>> +#define HSI2C_INT_NO_DEV_ACK		(1u << 9)
>> +#define HSI2C_INT_NO_DEV		(1u << 10)
>> +#define HSI2C_INT_TIMEOUT_AUTO		(1u << 11)
>> +#define HSI2C_INT_I2C_TRANS_EN		(HSI2C_INT_TRANS_DONE  |\
>> +					 HSI2C_INT_TRANS_ABORT |\
>> +					 HSI2C_INT_NO_DEV_ACK  |\
>> +					 HSI2C_INT_NO_DEV      |\
>> +					 HSI2C_INT_TIMEOUT_AUTO)
>> +
>>   /* I2C_CONF Register bits */
>>   #define HSI2C_AUTO_MODE			(1u << 31)
>>   #define HSI2C_10BIT_ADDR_MODE		(1u << 30)
>> @@ -99,24 +110,32 @@ DECLARE_GLOBAL_DATA_PTR;
>>    * bit to be set, which indicates copletion of a transaction.
>>    *
>>    * @param i2c: pointer to the appropriate register bank
>> + * @param variant: hardware variant of the i2c device
>>    *
>>    * @return: I2C_OK in case of successful completion, I2C_NOK_TIMEOUT in case
>>    *          the status bits do not get set in time, or an approrpiate error
>>    *          value in case of transfer errors.
>>    */
>> -static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
>> +static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c,
>> +			      enum s3c24x0_i2c_variant variant)
>>   {
>>   	int i = HSI2C_TIMEOUT_US;
>>     	while (i-- > 0) {
>>   		u32 int_status = readl(&i2c->usi_int_stat);
>> +		u32 trans_status;
>>   -		if (int_status & HSI2C_INT_I2C_EN) {
>> -			u32 trans_status = readl(&i2c->usi_trans_status);
>> +		switch (variant) {
>> +		case VARIANT_HSI2C_EXYNOS5:
>> +			trans_status = readl(&i2c->usi_trans_status);
>>     			/* Deassert pending interrupt. */
>>   			writel(int_status, &i2c->usi_int_stat);
>>   +			if (!(int_status & HSI2C_INT_I2C_EN)) {
>> +				udelay(1);
>> +				continue;
>> +			}
>>   			if (trans_status & HSI2C_NO_DEV_ACK) {
>>   				debug("%s: no ACK from device\n", __func__);
>>   				return I2C_NACK;
>> @@ -134,8 +153,32 @@ static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
>>   				return I2C_NOK_TOUT;
>>   			}
>>   			return I2C_OK;
>> +		case VARIANT_HSI2C_EXYNOS7:
>> +			if (int_status & HSI2C_INT_TRANS_DONE)
>> +				return I2C_OK;
>> +
>> +			if (int_status & HSI2C_INT_TRANS_ABORT) {
>> +				debug("%s: arbitration lost\n", __func__);
>> +				return I2C_NOK_LA;
>> +			}
>> +			if (int_status & HSI2C_NO_DEV_ACK) {
>> +				debug("%s: no ACK from device\n", __func__);
>> +				return I2C_NACK;
>> +			}
>> +			if (int_status & HSI2C_NO_DEV) {
>> +				debug("%s: no device\n", __func__);
>> +				return I2C_NOK;
>> +			}
>> +			if (int_status & HSI2C_TIMEOUT_AUTO) {
>> +				debug("%s: device timed out\n", __func__);
>> +				return I2C_NOK_TOUT;
>> +			}
>> +			udelay(1);
>> +			continue;
>> +		default:
>> +			debug("%s: unknown variant\n", __func__);
>> +			return I2C_NOK;
>>   		}
>> -		udelay(1);
>>   	}
>>   	debug("%s: transaction timeout!\n", __func__);
>>   	return I2C_NOK_TOUT;
> 
> May I oversee something .. but is for the new variant the i2c->usi_int_stat
> register ever cleared? I do not see a write for it in this case... or
> is it there cleared on read?

Yes, it should be cleared. That is not intended.

> 
> In linux driver:/drivers/i2c/busses/i2c-exynos5.c
> 
>  501 static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
> [...]
>  512         int_status = readl(i2c->regs + HSI2C_INT_STATUS);
>  513         writel(int_status, i2c->regs + HSI2C_INT_STATUS);
> 
> independent from the variant... may it is valid to do this in our
> driver too?

I believe this should be implemented. I did not observe any issues
with this method though, maybe it is cleared on read? Even if
that's the case, I reckon this should be the case for all variants
and follow the Linux driver's approach as its more battle-tested.

> 
> Some Testing on VARIANT_HSI2C_EXYNOS5 would be nice ... do you have
> such a hardware?

No, unfortunately.

> 
> Beside of this, change looks good to me.
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

I will apply this at the next revision which will clear the register
for all variants.

> 
> bye,
> Heiko
> 
> -- 
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschäftsführer : Stefano Babic
