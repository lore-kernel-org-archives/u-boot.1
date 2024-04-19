Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE94C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC1E887FD;
	Fri, 19 Apr 2024 14:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="M3DrZ8Yx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9C1887ED; Fri, 19 Apr 2024 14:21:46 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF3188789
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9VfDQ030184; Fri, 19 Apr 2024 14:21:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=+N6KuyqWFO3NLo2aN4iAkT0lCbgmmOGZqRDwy/+cI/w=; b=M3
 DrZ8Yxjd8cDsb41zEBhZHGC+XZIaQMBlwYt9NeYI8vrrAiLTmQyAzVsREHx4DBxi
 J6jJLPSlrKxK7YdSWRzSTOvTSZ/sfCicKCuY3xohFjM6b1XatPjzcDPwTdogPqpl
 MQ6NpUs4iz9UlcMZOA/aU+QsmPOjn12eW9KWOI7hEqhUNE8s0GN4t7F4Xc8iNqff
 wZs33tCxOYk0AecO8hpIzgVcSacPEs7XfFn/wqvXiP1WjGv3AQfVBBg7SyRp7StD
 F8qm2/8RW3GwOAkJEr89fRROgMxRWAmqPWLvHh1EkwGh9BZrQaGrF4AB9XvT/ctA
 +WtEUmMwEgGUo/WwEKiQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyrc5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:21:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F0F840045;
 Fri, 19 Apr 2024 14:21:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFACE21A23B;
 Fri, 19 Apr 2024 14:21:25 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:21:25 +0200
Message-ID: <c1bcf4ca-31f0-4d44-b51f-0e4f1b98a318@foss.st.com>
Date: Fri, 19 Apr 2024 14:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/25] ARM: dts: stm32: Don't probe red led at boot for
 stm32mp157a-dk1-scmi-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-12-patrice.chotard@foss.st.com>
 <6bf28011-bf01-429f-a941-31c835bce16c@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <6bf28011-bf01-429f-a941-31c835bce16c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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



On 4/17/24 11:07, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> red led and button dedicated to fastboot share the same gpio GPIOA13.
>> Led driver is probed early so the corresponding gpio is taken and
>> configured in output which forbid fastboot and stm32prog button usage.
>>
>> To avoid this, remove the "default-state" property from red led node.
>>
>> This will avoid to trigger the led driver probe() to configure the led
>> default state during startup.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> index 5d49b09c35d..8760d6c7d93 100644
>> --- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> @@ -39,7 +39,6 @@
>>           red {
>>               label = "error";
>>               gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
>> -            default-state = "off";
>>               status = "okay";
>>           };
>>       };
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied on u-boot-stm32/master 
