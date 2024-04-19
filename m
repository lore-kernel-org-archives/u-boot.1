Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27484C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6935C887DA;
	Fri, 19 Apr 2024 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Z2sHSeqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766CD88809; Fri, 19 Apr 2024 14:21:52 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C36488789
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9MgiH005448; Fri, 19 Apr 2024 14:21:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=i6b6Re3mbJ4rbI5lH1AE3PU35xYbzHB52NyBgBxNd7U=; b=Z2
 sHSeqwvmBaF/qQsTEOPjYbp5rv6I1pXfl2YN0Zw5ZflGyEzoEcj/mdGJ+84uHfHK
 ShfKkDKHqAeC+2Bd/Z5JKbokN99hkPxd44MylNivOHdrAYoP55c4p001bofK5Dvc
 r/LgN8L3iDkj4bTSjtngA8pY75JxutRAzypWeZWpdxprFSvjd9cUOv21KtvRV6Ls
 js9Ixb05I2Loy4/bnryo4aNk1swB8x83bElYZm8QbpG1z/dxgguIoc2jyzy+azEd
 i3yqX9O+dmTcNgxiPWkKsqIfemFsBvHJSL60KLA6NtMxcQ1Ykr8x2ridFZzt/QAD
 f0LDz3Fhde31VwU4ERIg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50j9esc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:21:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E202E40045;
 Fri, 19 Apr 2024 14:21:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D2EB21A8E6;
 Fri, 19 Apr 2024 14:21:31 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:21:31 +0200
Message-ID: <cd1722ab-0d3a-47f4-8e73-0204044f81f9@foss.st.com>
Date: Fri, 19 Apr 2024 14:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/25] ARM: dts: stm32: Update red led node for
 stm32mp157a-dk1-scmi-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-13-patrice.chotard@foss.st.com>
 <1441dbdb-deb2-4b92-9852-7b73940041d4@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1441dbdb-deb2-4b92-9852-7b73940041d4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/17/24 11:08, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> As indicated in kernel led dt-bindings, label is a deprecated
>> property, so remove it and use red led node's name instead
>> for u-boot,error-led property.
>> Rename "red" led node's name to "led-red".
>> Remove status property which is useless.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> index 8760d6c7d93..e61814fd66e 100644
>> --- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> @@ -14,7 +14,7 @@
>>         config {
>>           u-boot,boot-led = "heartbeat";
>> -        u-boot,error-led = "error";
>> +        u-boot,error-led = "led-red";
>>           u-boot,mmc-env-partition = "u-boot-env";
>>           st,adc_usb_pd = <&adc1 18>, <&adc1 19>;
>>       };
>> @@ -36,10 +36,8 @@
>>       };
>>         led {
>> -        red {
>> -            label = "error";
>> +        led-red {
>>               gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
>> -            status = "okay";
>>           };
>>       };
>>   };
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
