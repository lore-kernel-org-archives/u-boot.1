Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA92C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C859F8880A;
	Fri, 19 Apr 2024 14:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eWXbT64A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE5F8880F; Fri, 19 Apr 2024 14:21:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3A8887ED
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAnTBP006062; Fri, 19 Apr 2024 14:21:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=+l3Bg64fEOVYBYQiH/zOf9nif6yALnP4RYRkHIzlKgQ=; b=eW
 XbT64AqQP8fotR0LBn8r2pj2E5PPifoHVLPh2A7oo1I/CGtC+a6OJYJyw5+PJF/B
 HnXikd02HkDU2NyrjrxFCtZ6utKryNsNsPlR5Cg3whIOgqCKRdbLQ9tVeekSSO18
 fc5Fl5rasXiPJkGGWX/oq2s1O8winem4CxzFg+lGZp8OTSW60+JRLCc0alDwJj0G
 DYzcN5JJyWG6CiIB9+r6IEKR6P+udv32fUKajCUvMLFXUzqhVBK5o3U8vB1A1/7R
 dU65g2KZCwKqsyBHKXDGC6yCrIYH1F8ana+lwg05/elm4631JjDIGK07fug7kkiv
 mRTgWUQQ8kRh32U2G6Yw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m129yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:21:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A0C4E40044;
 Fri, 19 Apr 2024 14:21:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC6E521A8F9;
 Fri, 19 Apr 2024 14:21:37 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:21:37 +0200
Message-ID: <e23ea82e-1ff1-41eb-adea-5ffdf7b4e2de@foss.st.com>
Date: Fri, 19 Apr 2024 14:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/25] ARM: dts: stm32: Add led-blue for
 stm32mp157a-dk1-scmi-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-14-patrice.chotard@foss.st.com>
 <07727744-f8c7-4e88-8fa9-3d8f7dc4b54b@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <07727744-f8c7-4e88-8fa9-3d8f7dc4b54b@foss.st.com>
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



On 4/17/24 11:09, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> As indicated in kernel led dt-bindings, label is a deprecated
>> property, so remove it and use blue led node's name instead
>> for u-boot,boot-led property.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> index e61814fd66e..a5158fec7ef 100644
>> --- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> @@ -13,7 +13,7 @@
>>       };
>>         config {
>> -        u-boot,boot-led = "heartbeat";
>> +        u-boot,boot-led = "led-blue";
>>           u-boot,error-led = "led-red";
>>           u-boot,mmc-env-partition = "u-boot-env";
>>           st,adc_usb_pd = <&adc1 18>, <&adc1 19>;
>> @@ -36,6 +36,10 @@
>>       };
>>         led {
>> +        led-blue {
>> +            /delete-property/label;
>> +        };
>> +
>>           led-red {
>>               gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
>>           };
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
