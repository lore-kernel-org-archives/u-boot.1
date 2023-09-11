Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A54FEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A525A86D70;
	Mon, 11 Sep 2023 11:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OaDlMCaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631EF86D11; Mon, 11 Sep 2023 11:51:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D140D86D6F
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7618c49428=gatien.chevallier@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38B9SvjU023324; Mon, 11 Sep 2023 11:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=6KoLANZw2GZQ0fvfBNZpQL3T7V/SfT/NHJKNuINKmEE=; b=Oa
 DlMCaRbH1ansgME7Knkb/9SL4qUEVHiMdCq/LTSsGE9OCensKwGlEepQs3XuSizC
 IjMXQIFT4spcuuPCP2/Z0SyUgyHdEG39/eVLogsnOwfx/kfwIMba1Sap7UfMYGj7
 V4QDh5G9o8CsBW5nUQ7QdRFC16Fd/AdyxUhM13+mwxN7fgam06So16Fa6Vdf0uGJ
 ZsshRV4tkFmDatnU9xu3JtGvB49Id4ye7Do84jdUfIAc35lhAIwAC/MDJMOZ3Zxa
 ATmkz0CWs58F08crI6zfTztTewK3EOmM0YWEonJH9BaarEaJh83huLuvewRICatX
 chVuFfV7HSAnhgDc6mcA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0g21yan6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 11:51:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CF9810005A;
 Mon, 11 Sep 2023 11:51:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 469E123A163;
 Mon, 11 Sep 2023 11:51:18 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:51:17 +0200
Message-ID: <64679ab9-ecde-2af7-a16e-658172d5b57a@foss.st.com>
Date: Mon, 11 Sep 2023 11:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/7] configs: default activate CONFIG_RNG_STM32 for
 STM32MP13x platforms
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-2-gatien.chevallier@foss.st.com>
 <7cad48d4-7dd2-474d-b8cc-20de2e75e33b@gmx.de>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <7cad48d4-7dd2-474d-b8cc-20de2e75e33b@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
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



On 9/8/23 20:58, Heinrich Schuchardt wrote:
> On 9/7/23 18:21, Gatien Chevallier wrote:
>> Default embed this configuration. If OP-TEE PTA RNG is present as well,
>> the priority will be given to it instead of the U-Boot driver.
> 
> Are you relying here on drivers being probed in alphabetical sequence?
> 
> Best regards
> 
> Heinrich
> 

Hello Heinrich,

I've made a strange wording here.

OP-TEE RNG PTA shouldn't be exposed if the RNG is non-secure as it
shouldn't be handled by the secure world. If it is, it is a bad
OP-TEE configuration.

On the contrary, if the RNG OPTEE PTA is exposed, then the OP-TEE
RNG PTA should be used. Therefore, the RNG node status shouldn't
be set to "okay" in U-boot's device tree.

Hope this solves the confusion, I'll reword the sentence.

Best regards,
Gatien

>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   configs/stm32mp13_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>> index 82b62744f6..4a899c85de 100644
>> --- a/configs/stm32mp13_defconfig
>> +++ b/configs/stm32mp13_defconfig
>> @@ -65,6 +65,7 @@ CONFIG_DM_REGULATOR_GPIO=y
>>   CONFIG_DM_REGULATOR_SCMI=y
>>   CONFIG_RESET_SCMI=y
>>   CONFIG_DM_RNG=y
>> +CONFIG_RNG_STM32=y
>>   CONFIG_DM_RTC=y
>>   CONFIG_RTC_STM32=y
>>   CONFIG_SERIAL_RX_BUFFER=y
> 
