Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC314C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474DC80F5F;
	Fri, 31 Jan 2025 09:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="t5Ymlj5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D50780F70; Fri, 31 Jan 2025 09:08:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E22A80F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80u0P022725;
 Fri, 31 Jan 2025 09:08:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 UeuAcUWsoR0sGUl8MEvncYQgp+hLbg4YlG/fUSs/l8I=; b=t5Ymlj5c3o1Paol0
 Lb15IqapOG2Q2qo9p7Zb9E1HmjtZgTW66XtlywMJO57us3yYlKPron4nhvYcN9PL
 W8YoHHc5bBQr5TZ62E+FB+JJ5hQUCjxjGjOYKcvV7SJhn/hc8Nl6Jx8vPYJOEdYN
 jXdfD7lqvxllgSkhzjp5VB7BbneLiz57cOAp+fJKkIBRYjxlD8R3qddwKLEEJcgJ
 8TKM3JbvA3W2LP5EyP7QOi/FlMNzXV5lzD3dNn5fKxl4ouPgmA1nhUw6S2NMbNfE
 WSZa1efDLuhQtwN29qz1kPGd3E1SEaSAZvE7eN/sITr1rD+XpvN5pPeCYfulu5e1
 sH7TyQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7ghtyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:08:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AACF94004C;
 Fri, 31 Jan 2025 09:07:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCC4A2AA51B;
 Fri, 31 Jan 2025 09:04:49 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:04:49 +0100
Message-ID: <0efcb80b-2f5e-44c6-97d3-d629cacf9454@foss.st.com>
Date: Fri, 31 Jan 2025 09:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32mp13: Add support of ck_usbo_48m in
 pre-reloc stage
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129123325.426138-1-patrice.chotard@foss.st.com>
 <773255e7-0df2-463d-b388-6dbb6bf5f61f@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <773255e7-0df2-463d-b388-6dbb6bf5f61f@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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



On 1/8/25 19:51, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/29/24 13:33, Patrice Chotard wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> The clock ck_usbo_48m is a clock source for RCC, so the ck_usbo_48m
>> clock provided by usbphyc need to be probed when RCC clock driver is
>> required, in pre-reloc stage.
>>
>> This patch allow to remove the following warning:
>>
>> clk_register: failed to get ck_usbo_48m device (parent of usbo_k)
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp13-u-boot.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp13-u-boot.dtsi b/arch/arm/dts/stm32mp13-u-boot.dtsi
>> index aa5cfc6e41d..af7edc7e2b2 100644
>> --- a/arch/arm/dts/stm32mp13-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp13-u-boot.dtsi
>> @@ -111,3 +111,8 @@
>>   &syscfg {
>>       bootph-all;
>>   };
>> +
>> +&usbphyc {
>> +    /* stm32-usbphyc-clk = ck_usbo_48m is a source clock of RCC CCF */
>> +    bootph-all;
>> +};
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
