Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5DAC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02C3887CB;
	Fri, 19 Apr 2024 14:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RzMyWpCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BE2887D0; Fri, 19 Apr 2024 14:27:32 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75783887CA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J7tg8W027245; Fri, 19 Apr 2024 14:27:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=s7DRaI6XT/zsgmEXQ7M6r5NYuBl/t14Sc3ibZuIPOR0=; b=Rz
 MyWpCmC7Nay+aSarx3wc0wjYhQQEzM8/0vNVWR+a0Ay59B+Gg3TgvRuAALDY9QCu
 rKI/kxiebSP3R9bFHcE8B2GUjLEQCuvdsXOvxM8QuPt5J9jrSljpjVDa+w1XlNOP
 owr70l94HiWN2IQu6WiG7FS4v5Esp/IbSxS9VtSJCJzXMB5iTv+9PJh9UMr0TX61
 7bChtRDr+3N1k/8l0hs3EJ3yYg4l0uuTQu4Iat4qvKfuenEoNMQqj1LBzOcdES9I
 yjyCX2vdyqJBwVnsbtn0cvNTAr/XWkfdiD3JM9N72UIBsJgvlJ1v0Jd86uKwTf+C
 vE90zmUDHQ8nafZbJFBQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m12anj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:27:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5F26C4002D;
 Fri, 19 Apr 2024 14:27:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8186A21A907;
 Fri, 19 Apr 2024 14:27:06 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:27:06 +0200
Message-ID: <dca987a3-9df3-4873-8eda-c151956dddac@foss.st.com>
Date: Fri, 19 Apr 2024 14:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/25] ARM: dts: stm32: Don't probe red led at boot for
 stm32mp157a-dk1-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-16-patrice.chotard@foss.st.com>
 <c7094883-b9ac-4df2-8335-6907e560f1db@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c7094883-b9ac-4df2-8335-6907e560f1db@foss.st.com>
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
>>   arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
>> index 6bf6136c5fd..ee9b51d42b7 100644
>> --- a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
>> @@ -67,7 +67,6 @@
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
