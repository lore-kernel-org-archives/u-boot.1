Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CDE7B5F5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E0C874EB;
	Wed,  4 Oct 2023 13:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ts93CPXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01912874FF; Wed,  4 Oct 2023 13:39:35 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A58869BC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3947jGOG008905; Wed, 4 Oct 2023 13:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=hReQH4uPiBXRHJk0qvYx9bup7q0NtewxgDJbZYx0Wsc=; b=ts
 93CPXK+YTPVaycxb3gQMsISYk4WWRIyxwT3IYZP+NiY3TygyPpYWoFaIz1L1ojeq
 7E9HyxRqJ5KVgENj8pjZTEa6VMISB4JRPkBABxzq6LuWzemnWXSihS87OfENv8+m
 oMQyxJrfREvMtVaCbDBgI2wZlCZ50TUeFxapTku3L2jRxOiIMPByCy1m71IxIdvF
 BaBMM+S1cpOG05eJfq56R+kJ2i9Q1MznpqRYUKzN8/CFC/df7+fV4xO304dVNmsG
 urC2HLn/8p3T5FXXRNApS/GC4tdyyohFvxUJ4WheuY2lAep/A8ctTgmLDKu+KbkB
 VvUhOZWzTKZLdDXuLmuQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te8t5113k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:39:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0B0A100053;
 Wed,  4 Oct 2023 13:39:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C99ED21B533;
 Wed,  4 Oct 2023 13:39:23 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 13:39:23 +0200
Message-ID: <93a94efb-327e-5d24-ee0d-063fca6abf84@foss.st.com>
Date: Wed, 4 Oct 2023 13:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/6] ARM: dts: stm32: force b-session-valid for otg on
 stm32mp135f-dk board
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Tom Rini
 <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-3-patrice.chotard@foss.st.com>
 <e9fff0fc-27db-20f9-b2b5-1abee5ac739e@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <e9fff0fc-27db-20f9-b2b5-1abee5ac739e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_03,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:55, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/26/23 17:09, Patrice Chotard wrote:
>> From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>
>> stm32mp135f-dk board has a type-c connector to retrieve the connection
>> state. For now, simply force an active peripheral mode in u-boot for
>> flashing.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
>> index 48605ff8bbe..ba0c02489d1 100644
>> --- a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
>> @@ -38,3 +38,7 @@
>>           bootph-all;
>>       };
>>   };
>> +
>> +&usbotg_hs {
>> +    u-boot,force-b-session-valid;
>> +};
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
Apply on stm32/next

Thanks
Patrice
