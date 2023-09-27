Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1689E80A9A
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 07:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706DD86DB0;
	Wed, 27 Sep 2023 09:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kN4JHwKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1927D86DB4; Wed, 27 Sep 2023 09:27:21 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B6186D73
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 09:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76345cf035=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38R6lb8I016376; Wed, 27 Sep 2023 09:27:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=IFWg806DWDOkKjEbxiEIS7XgcO8Jg5eg2vfpqSs/9gc=; b=kN
 4JHwKhUUdwcIvNaiD8hibZWF8ybrV7euqWOO2XNofdjL9iEimxFA7Inlgc7EUBRx
 yzn6LboAWraBROzg8xCQ0L0SvzJBG3cOPc+cL9QzAb3sc1QqNqStDz61pi6fFSHP
 eb7rC4VbatBiQ+pVg7LMrxdY4mS0Om+guxEiuB2nXrWkLNGACjksIiuljV5i5P0M
 UzK75sQmaGYBxnGTzqhpe4RCXmIWhwo6P0unKCgh42+MnQFsMr8K5BwnAbJCmL7p
 U2OQiS6Aj/5brVX5fiAoeJ5hXtOnZFnMGM3aqDGDZFR8T8yV11IcFPHoaO4teqJB
 BjQti/7K9veH3+DIR5Dw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3taayhpa1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 09:27:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D68210005A;
 Wed, 27 Sep 2023 09:27:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0680F214D09;
 Wed, 27 Sep 2023 09:27:16 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 09:27:15 +0200
Message-ID: <875fd48f-a029-9d01-9e30-ed54c5251925@foss.st.com>
Date: Wed, 27 Sep 2023 09:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Uboot-stm32] [PATCH v3 6/7] rng: stm32: Implement custom RNG
 configuration support
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, <uboot-stm32@st-md-mailman.stormreply.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>
References: <20230919152759.327420-1-gatien.chevallier@foss.st.com>
 <20230919152759.327420-7-gatien.chevallier@foss.st.com>
 <1978924e-2256-b858-c3fe-335e71c0d472@foss.st.com>
In-Reply-To: <1978924e-2256-b858-c3fe-335e71c0d472@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
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



On 9/27/23 09:11, Patrice CHOTARD wrote:
> 
> 
> On 9/19/23 17:27, Gatien Chevallier wrote:
>> STM32 RNG configuration should best fit the requirements of the
>> platform. Therefore, put a platform-specific RNG configuration
>> field in the platform data. Default RNG configuration for STM32MP13
>> is the NIST certified configuration [1].
>>
>> While there, fix and the RNG init sequence to support all RNG
>> versions.
>>
>> [1] https://csrc.nist.gov/projects/cryptographic-module-validation-program/entropy-validations/certificate/53
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>> Changes in V2:
>> 	- Added Patrick's tag
>>
>>  drivers/rng/stm32_rng.c | 54 ++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
>> index b1a790b217..c397b4d95c 100644
>> --- a/drivers/rng/stm32_rng.c
>> +++ b/drivers/rng/stm32_rng.c
>> @@ -21,8 +21,15 @@
>>  #define RNG_CR			0x00
>>  #define RNG_CR_RNGEN		BIT(2)
>>  #define RNG_CR_CED		BIT(5)
>> +#define RNG_CR_CONFIG1		GENMASK(11, 8)
>> +#define RNG_CR_NISTC		BIT(12)
>> +#define RNG_CR_CONFIG2		GENMASK(15, 13)
>>  #define RNG_CR_CLKDIV_SHIFT	16
>> +#define RNG_CR_CLKDIV		GENMASK(19, 16)
>> +#define RNG_CR_CONFIG3		GENMASK(25, 20)
>>  #define RNG_CR_CONDRST		BIT(30)
>> +#define RNG_CR_ENTROPY_SRC_MASK	(RNG_CR_CONFIG1 | RNG_CR_NISTC | RNG_CR_CONFIG2 | RNG_CR_CONFIG3)
>> +#define RNG_CR_CONFIG_MASK	(RNG_CR_ENTROPY_SRC_MASK | RNG_CR_CED | RNG_CR_CLKDIV)
>>  
>>  #define RNG_SR		0x04
>>  #define RNG_SR_SEIS	BIT(6)
>> @@ -32,17 +39,28 @@
>>  
>>  #define RNG_DR		0x08
>>  
>> +#define RNG_NSCR		0x0C
>> +#define RNG_NSCR_MASK		GENMASK(17, 0)
>> +
>> +#define RNG_HTCR	0x10
>> +
>>  #define RNG_NB_RECOVER_TRIES	3
>>  
>>  /*
>>   * struct stm32_rng_data - RNG compat data
>>   *
>>   * @max_clock_rate:	Max RNG clock frequency, in Hertz
>> + * @cr:			Entropy source configuration
>> + * @nscr:		Noice sources control configuration
>> + * @htcr:		Health tests configuration
>>   * @has_cond_reset:	True if conditionnal reset is supported
>>   *
>>   */
>>  struct stm32_rng_data {
>>  	uint max_clock_rate;
>> +	u32 cr;
>> +	u32 nscr;
>> +	u32 htcr;
>>  	bool has_cond_reset;
>>  };
>>  
>> @@ -244,28 +262,48 @@ static int stm32_rng_init(struct stm32_rng_plat *pdata)
>>  
>>  	cr = readl(pdata->base + RNG_CR);
>>  
>> -	if (pdata->data->has_cond_reset) {
>> +	/*
>> +	 * Keep default RNG configuration if none was specified, that is when conf.cr is set to 0.
>> +	 */
>> +	if (pdata->data->has_cond_reset && pdata->data->cr) {
>>  		uint clock_div = stm32_rng_clock_freq_restrain(pdata);
>>  
>> -		cr |= RNG_CR_CONDRST | (clock_div << RNG_CR_CLKDIV_SHIFT);
>> +		cr &= ~RNG_CR_CONFIG_MASK;
>> +		cr |= RNG_CR_CONDRST | (pdata->data->cr & RNG_CR_ENTROPY_SRC_MASK) |
>> +		      (clock_div << RNG_CR_CLKDIV_SHIFT);
>>  		if (pdata->ced)
>>  			cr &= ~RNG_CR_CED;
>>  		else
>>  			cr |= RNG_CR_CED;
>>  		writel(cr, pdata->base + RNG_CR);
>> +
>> +		/* Health tests and noise control registers */
>> +		writel_relaxed(pdata->data->htcr, pdata->base + RNG_HTCR);
>> +		writel_relaxed(pdata->data->nscr & RNG_NSCR_MASK, pdata->base + RNG_NSCR);
>> +
>>  		cr &= ~RNG_CR_CONDRST;
>>  		cr |= RNG_CR_RNGEN;
>>  		writel(cr, pdata->base + RNG_CR);
>>  		err = readl_poll_timeout(pdata->base + RNG_CR, cr,
>>  					 (!(cr & RNG_CR_CONDRST)), 10000);
>> -		if (err)
>> +		if (err) {
>> +			log_err("%s: Timeout!",  __func__);
>>  			return err;
>> +		}
>>  	} else {
>> +		if (pdata->data->has_cond_reset)
>> +			cr |= RNG_CR_CONDRST;
>> +
>>  		if (pdata->ced)
>>  			cr &= ~RNG_CR_CED;
>>  		else
>>  			cr |= RNG_CR_CED;
>>  
>> +		writel(cr, pdata->base + RNG_CR);
>> +
>> +		if (pdata->data->has_cond_reset)
>> +			cr &= ~RNG_CR_CONDRST;
>> +
>>  		cr |= RNG_CR_RNGEN;
>>  
>>  		writel(cr, pdata->base + RNG_CR);
>> @@ -276,6 +314,9 @@ static int stm32_rng_init(struct stm32_rng_plat *pdata)
>>  
>>  	err = readl_poll_timeout(pdata->base + RNG_SR, sr,
>>  				 sr & RNG_SR_DRDY, 10000);
>> +	if (err)
>> +		log_err("%s: Timeout!",  __func__);
>> +
>>  	return err;
>>  }
>>  
>> @@ -335,11 +376,18 @@ static const struct dm_rng_ops stm32_rng_ops = {
>>  static const struct stm32_rng_data stm32mp13_rng_data = {
>>  	.has_cond_reset = true,
>>  	.max_clock_rate = 48000000,
>> +	.htcr = 0x969D,
>> +	.nscr = 0x2B5BB,
>> +	.cr = 0xF00D00,
>>  };
>>  
>>  static const struct stm32_rng_data stm32_rng_data = {
>>  	.has_cond_reset = false,
>>  	.max_clock_rate = 3000000,
>> +	/* Not supported */
>> +	.htcr = 0,
>> +	.nscr = 0,
>> +	.cr = 0,
>>  };
>>  
>>  static const struct udevice_id stm32_rng_match[] = {
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32
Apply on stm32/next

Patrice
