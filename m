Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EA2EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6D586D3E;
	Mon, 11 Sep 2023 11:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DJiNjjd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBED86D3F; Mon, 11 Sep 2023 11:39:25 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D2386D3C
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76189757ae=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38B9StwS005195; Mon, 11 Sep 2023 11:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=SX5rKiMWgs8d5D27AetWoBlYJxOZSYOPTdmU13q/82U=; b=DJ
 iNjjd88UmtDSCbkw5umqKqbELz/zRCRvadYHlxleP2+1R9kyJAu2EjtvhyjuwFuq
 2EEy97ZgZYukODaKASEFyKcabZ5So1GBzz8QrUWn2vDRklV/dKnmSVBfbB0Xrxw8
 b+hx39mURPEGrrDif1lRKYqpMwkE82P22v21mNYvo17fDEvQZ5Ao6pJ44FjyeW4M
 rVGSLk8ka+fWuTzpGnsuju96MP1fx+zeQqbFRqYMrN5s9p3hv1tD0cKNC+dHShC+
 3d2MEXtoJIcpZ12p1fTA0R+gLNbVjChFLGABm3diOWUr5LNbEXI5nxEGCUYRWhYq
 SGvaa1EkkXbAj7Fxh21g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t13nhcwp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 11:39:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DDDE10005A;
 Mon, 11 Sep 2023 11:39:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12804237D94;
 Mon, 11 Sep 2023 11:39:18 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:39:17 +0200
Message-ID: <597ffeca-d81c-7d06-2a85-a3d69a461806@foss.st.com>
Date: Mon, 11 Sep 2023 11:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] rng: stm32: Implement configurable RNG clock error
 detection
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-3-gatien.chevallier@foss.st.com>
 <99b66fba-e92a-4a6f-b1f7-428d814d402a@gmx.de>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <99b66fba-e92a-4a6f-b1f7-428d814d402a@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
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

Hi,

On 9/8/23 21:07, Heinrich Schuchardt wrote:
> On 9/7/23 18:21, Gatien Chevallier wrote:
>> RNG clock error detection is now enabled if the "clock-error-detect"
>> property is set in the device tree.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   drivers/rng/stm32_rng.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
>> index 89da78c6c8..ada5d92214 100644
>> --- a/drivers/rng/stm32_rng.c
>> +++ b/drivers/rng/stm32_rng.c
>> @@ -40,6 +40,7 @@ struct stm32_rng_plat {
>>       struct clk clk;
>>       struct reset_ctl rst;
>>       const struct stm32_rng_data *data;
>> +    bool ced;
>>   };
>>
>>   static int stm32_rng_read(struct udevice *dev, void *data, size_t len)
>> @@ -97,25 +98,34 @@ static int stm32_rng_init(struct stm32_rng_plat 
>> *pdata)
>>
>>       cr = readl(pdata->base + RNG_CR);
>>
>> -    /* Disable CED */
>> -    cr |= RNG_CR_CED;
>>       if (pdata->data->has_cond_reset) {
>>           cr |= RNG_CR_CONDRST;
>> +        if (pdata->ced)
>> +            cr &= ~RNG_CR_CED;
>> +        else
>> +            cr |= RNG_CR_CED;
>>           writel(cr, pdata->base + RNG_CR);
>>           cr &= ~RNG_CR_CONDRST;
>> +        cr |= RNG_CR_RNGEN;
>>           writel(cr, pdata->base + RNG_CR);
>>           err = readl_poll_timeout(pdata->base + RNG_CR, cr,
>>                        (!(cr & RNG_CR_CONDRST)), 10000);
>>           if (err)
>>               return err;
>> +    } else {
>> +        if (pdata->ced)
>> +            cr &= ~RNG_CR_CED;
>> +        else
>> +            cr |= RNG_CR_CED;
>> +
>> +        cr |= RNG_CR_RNGEN;
>> +
>> +        writel(cr, pdata->base + RNG_CR);
>>       }
>>
>>       /* clear error indicators */
>>       writel(0, pdata->base + RNG_SR);
>>
>> -    cr |= RNG_CR_RNGEN;
>> -    writel(cr, pdata->base + RNG_CR);
>> -
>>       err = readl_poll_timeout(pdata->base + RNG_SR, sr,
>>                    sr & RNG_SR_DRDY, 10000);
>>       return err;
>> @@ -165,6 +175,8 @@ static int stm32_rng_of_to_plat(struct udevice *dev)
>>       if (err)
>>           return err;
>>
>> +    pdata->ced = dev_read_bool(dev, "clock-error-detect");
>
> The kernel describes this property in
> Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
>
> Which patch is adding it to the U-Boot device-trees?
> I can't find it in this patch series.


For STM32 platform we rely on the bindin files of kernel to avoid to 
duplicate the binding after yaml migration

and we add the U-Boot specificity only when it is needed (for clock and ram)


See Documentation: 
https://u-boot.readthedocs.io/en/stable/board/st/st-dt.html

doc/board/st/st-dt.rst

* rng
     - rng/st,stm32-rng.yaml


So for me no need of binding patch in U-Boot since [1] as this property 
is already supported by kernel binding.

[1] 551a959a8c11 ("doc: stm32mp1: add page for device tree bindings")

http://patchwork.ozlabs.org/project/uboot/patch/20210802180823.1.I3aa79d907e5213c8692d2d428f5a1fbccdce555b@changeid/


Patrick


>
> It would have been helpful to send a cover-letter with the patch series
> to get an overview of the changed files in the patch set.
>
> Best regards
>
> Heinrich
>
>> +
>>       return 0;
>>   }
>>
>
