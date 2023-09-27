Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBAFE80A9E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 07:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9588486D9A;
	Wed, 27 Sep 2023 09:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lqx9pY3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CE986DB1; Wed, 27 Sep 2023 09:26:47 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C2F86DA7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 09:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76345cf035=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38R6bZ1e022685; Wed, 27 Sep 2023 09:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=B7o97jpxKgz5NGJeXk5Ahw9sXyoRtqMLFCaos6lK4E0=; b=lq
 x9pY3VD+CLL43/hDfE3MFGxZqwXOX4jULLiS896Q9q6nhl2VTWw/40VuhH/2PtlQ
 zmls+RMq9lyx2gnyAiLzCiUH8yp3bwJ+pvkQUQmboI9AWN4ML74Rrwa9b7DodGv4
 Ns2SWum4k0gXIA6uJ6ZBAZPAaWDu+7VzUZtxE4oYGkKyzoL55CbAZ+oUAcODTUEA
 4VTT/u8Z75EAOQdHlgw2RTL6NDJ3dJKqSPMupDpeIYI8B/KykXLAW/c7v8eJ0whC
 ZpeaR9xAda626tkhPQYjLAao7fwkejtPOX50p3KlPxdawzz6TtUdWrM8V2TIH1Dx
 4Qs/WPzq1pjtvzaFEh1g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3taayhp9xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 09:26:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3AA31100057;
 Wed, 27 Sep 2023 09:26:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32E3F214D05;
 Wed, 27 Sep 2023 09:26:42 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 09:26:41 +0200
Message-ID: <c053f303-3213-f48d-ba77-766f0e380bd5@foss.st.com>
Date: Wed, 27 Sep 2023 09:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/7] rng: stm32: add error concealment sequence
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230919152759.327420-1-gatien.chevallier@foss.st.com>
 <20230919152759.327420-6-gatien.chevallier@foss.st.com>
 <90d559b8-8626-70f7-0d78-f1eaa81e5219@foss.st.com>
In-Reply-To: <90d559b8-8626-70f7-0d78-f1eaa81e5219@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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



On 9/27/23 08:57, Patrice CHOTARD wrote:
> 
> 
> On 9/19/23 17:27, Gatien Chevallier wrote:
>> Seed errors can occur when using the hardware RNG. Implement the
>> sequences to handle them. This avoids irrecoverable RNG state.
>>
>> Try to conceal seed errors when possible. If, despite the error
>> concealing tries, a seed error is still present, then return an error.
>>
>> A clock error does not compromise the hardware block and data can
>> still be read from RNG_DR. Just warn that the RNG clock is too slow
>> and clear RNG_SR.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>> Changes in V2:
>> 	- Added Patrick's tag
>>
>>  drivers/rng/stm32_rng.c | 163 ++++++++++++++++++++++++++++++++++------
>>  1 file changed, 140 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
>> index f943acd7d2..b1a790b217 100644
>> --- a/drivers/rng/stm32_rng.c
>> +++ b/drivers/rng/stm32_rng.c
>> @@ -32,6 +32,8 @@
>>  
>>  #define RNG_DR		0x08
>>  
>> +#define RNG_NB_RECOVER_TRIES	3
>> +
>>  /*
>>   * struct stm32_rng_data - RNG compat data
>>   *
>> @@ -52,45 +54,160 @@ struct stm32_rng_plat {
>>  	bool ced;
>>  };
>>  
>> +/*
>> + * Extracts from the STM32 RNG specification when RNG supports CONDRST.
>> + *
>> + * When a noise source (or seed) error occurs, the RNG stops generating
>> + * random numbers and sets to “1” both SEIS and SECS bits to indicate
>> + * that a seed error occurred. (...)
>> + *
>> + * 1. Software reset by writing CONDRST at 1 and at 0 (see bitfield
>> + * description for details). This step is needed only if SECS is set.
>> + * Indeed, when SEIS is set and SECS is cleared it means RNG performed
>> + * the reset automatically (auto-reset).
>> + * 2. If SECS was set in step 1 (no auto-reset) wait for CONDRST
>> + * to be cleared in the RNG_CR register, then confirm that SEIS is
>> + * cleared in the RNG_SR register. Otherwise just clear SEIS bit in
>> + * the RNG_SR register.
>> + * 3. If SECS was set in step 1 (no auto-reset) wait for SECS to be
>> + * cleared by RNG. The random number generation is now back to normal.
>> + */
>> +static int stm32_rng_conceal_seed_error_cond_reset(struct stm32_rng_plat *pdata)
>> +{
>> +	u32 sr = readl_relaxed(pdata->base + RNG_SR);
>> +	u32 cr = readl_relaxed(pdata->base + RNG_CR);
>> +	int err;
>> +
>> +	if (sr & RNG_SR_SECS) {
>> +		/* Conceal by resetting the subsystem (step 1.) */
>> +		writel_relaxed(cr | RNG_CR_CONDRST, pdata->base + RNG_CR);
>> +		writel_relaxed(cr & ~RNG_CR_CONDRST, pdata->base + RNG_CR);
>> +	} else {
>> +		/* RNG auto-reset (step 2.) */
>> +		writel_relaxed(sr & ~RNG_SR_SEIS, pdata->base + RNG_SR);
>> +		return 0;
>> +	}
>> +
>> +	err = readl_relaxed_poll_timeout(pdata->base + RNG_SR, sr, !(sr & RNG_CR_CONDRST), 100000);
>> +	if (err) {
>> +		log_err("%s: timeout %x\n", __func__, sr);
>> +		return err;
>> +	}
>> +
>> +	/* Check SEIS is cleared (step 2.) */
>> +	if (readl_relaxed(pdata->base + RNG_SR) & RNG_SR_SEIS)
>> +		return -EINVAL;
>> +
>> +	err = readl_relaxed_poll_timeout(pdata->base + RNG_SR, sr, !(sr & RNG_SR_SECS), 100000);
>> +	if (err) {
>> +		log_err("%s: timeout %x\n", __func__, sr);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Extracts from the STM32 RNG specification, when CONDRST is not supported
>> + *
>> + * When a noise source (or seed) error occurs, the RNG stops generating
>> + * random numbers and sets to “1” both SEIS and SECS bits to indicate
>> + * that a seed error occurred. (...)
>> + *
>> + * The following sequence shall be used to fully recover from a seed
>> + * error after the RNG initialization:
>> + * 1. Clear the SEIS bit by writing it to “0”.
>> + * 2. Read out 12 words from the RNG_DR register, and discard each of
>> + * them in order to clean the pipeline.
>> + * 3. Confirm that SEIS is still cleared. Random number generation is
>> + * back to normal.
>> + */
>> +static int stm32_rng_conceal_seed_error_sw_reset(struct stm32_rng_plat *pdata)
>> +{
>> +	uint i = 0;
>> +	u32 sr = readl_relaxed(pdata->base + RNG_SR);
>> +
>> +	writel_relaxed(sr & ~RNG_SR_SEIS, pdata->base + RNG_SR);
>> +
>> +	for (i = 12; i != 0; i--)
>> +		(void)readl_relaxed(pdata->base + RNG_DR);
>> +
>> +	if (readl_relaxed(pdata->base + RNG_SR) & RNG_SR_SEIS)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_rng_conceal_seed_error(struct stm32_rng_plat *pdata)
>> +{
>> +	log_debug("Concealing RNG seed error\n");
>> +
>> +	if (pdata->data->has_cond_reset)
>> +		return stm32_rng_conceal_seed_error_cond_reset(pdata);
>> +	else
>> +		return stm32_rng_conceal_seed_error_sw_reset(pdata);
>> +};
>> +
>>  static int stm32_rng_read(struct udevice *dev, void *data, size_t len)
>>  {
>> -	int retval, i;
>> -	u32 sr, count, reg;
>> +	int retval;
>> +	u32 sr, reg;
>>  	size_t increment;
>>  	struct stm32_rng_plat *pdata = dev_get_plat(dev);
>> +	uint tries = 0;
>>  
>>  	while (len > 0) {
>>  		retval = readl_poll_timeout(pdata->base + RNG_SR, sr,
>> -					    sr & RNG_SR_DRDY, 10000);
>> -		if (retval)
>> +					    sr, 10000);
>> +		if (retval) {
>> +			log_err("%s: Timeout RNG no data",  __func__);
>>  			return retval;
>> +		}
>>  
>> -		if (sr & (RNG_SR_SEIS | RNG_SR_SECS)) {
>> -			/* As per SoC TRM */
>> -			clrbits_le32(pdata->base + RNG_SR, RNG_SR_SEIS);
>> -			for (i = 0; i < 12; i++)
>> -				readl(pdata->base + RNG_DR);
>> -			if (readl(pdata->base + RNG_SR) & RNG_SR_SEIS) {
>> -				log_err("RNG Noise");
>> -				return -EIO;
>> +		if (sr != RNG_SR_DRDY) {
>> +			if (sr & RNG_SR_SEIS) {
>> +				retval = stm32_rng_conceal_seed_error(pdata);
>> +				tries++;
>> +				if (retval || tries > RNG_NB_RECOVER_TRIES) {
>> +					log_err("%s: Couldn't recover from seed error",  __func__);
>> +					return -ENOTRECOVERABLE;
>> +				}
>> +
>> +				/* Start again */
>> +				continue;
>> +			}
>> +
>> +			if (sr & RNG_SR_CEIS) {
>> +				log_info("RNG clock too slow");
>> +				writel_relaxed(0, pdata->base + RNG_SR);
>>  			}
>> -			/* start again */
>> -			continue;
>>  		}
>>  
>>  		/*
>>  		 * Once the DRDY bit is set, the RNG_DR register can
>> -		 * be read four consecutive times.
>> +		 * be read up to four consecutive times.
>>  		 */
>> -		count = 4;
>> -		while (len && count) {
>> -			reg = readl(pdata->base + RNG_DR);
>> -			memcpy(data, &reg, min(len, sizeof(u32)));
>> -			increment = min(len, sizeof(u32));
>> -			data += increment;
>> -			len -= increment;
>> -			count--;
>> +		reg = readl(pdata->base + RNG_DR);
>> +		/* Late seed error case: DR being 0 is an error status */
>> +		if (!reg) {
>> +			retval = stm32_rng_conceal_seed_error(pdata);
>> +			tries++;
>> +
>> +			if (retval || tries > RNG_NB_RECOVER_TRIES) {
>> +				log_err("%s: Couldn't recover from seed error",  __func__);
>> +				return -ENOTRECOVERABLE;
>> +			}
>> +
>> +			/* Start again */
>> +			continue;
>>  		}
>> +
>> +		increment = min(len, sizeof(u32));
>> +		memcpy(data, &reg, increment);
>> +		data += increment;
>> +		len -= increment;
>> +
>> +		tries = 0;
>>  	}
>>  
>>  	return 0;
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Apply on stm32/next

Patrice
