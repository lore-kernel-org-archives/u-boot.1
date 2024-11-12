Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6A7D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762D888FED;
	Tue, 12 Nov 2024 15:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NsQ/zEnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D2289440; Tue, 12 Nov 2024 15:19:20 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD49F889D2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACD676f008150;
 Tue, 12 Nov 2024 15:19:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 NSLkuKVwxuXT/8oeC1ZmgSbpAlfSk/CcFqcGDOKmacg=; b=NsQ/zEnD3O3223Gs
 RNl7udTVQg/LJA7uNtaUPJNBjV424xwKxGsloxvOu67ZHO2ETTAr3rTv0K+FYzN2
 CSscFeY3DnoZISMiIBgbUtr9LXO2fWL6trgpqFrcx16v/ilZWjqbPMVlHFDM6CNL
 /2rWAmNwMm6iJ20haGSMdREYA3ZXEsqWhBVfYrHogEKlzKFY3U3uqp1YEGNecJKn
 k3NkXsHCJUeJ5fXDFnTHTSKLeMWv3m0uUolyGoTVA1eNb90BBbKL9DXaNg3jcDEP
 r4ipwu5+aPU0HfM45Sz/sNGK5ThxLHJmSCE8R4dKsds5xFhyMQGMqJYfZHuqbYQ+
 GrqpfQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tj642gcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:19:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3CC584005A;
 Tue, 12 Nov 2024 15:17:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42C532A1E9A;
 Tue, 12 Nov 2024 15:15:10 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 15:15:09 +0100
Message-ID: <0ca4f01b-d743-4634-9031-4ea490dee67f@foss.st.com>
Date: Tue, 12 Nov 2024 15:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Drop remnants of upstream DT switch on
 DH STM32 DHSOM
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241021193522.195834-1-marex@denx.de>
 <67aeed9c-73f5-462b-becd-7bb370a022d0@foss.st.com>
Content-Language: en-US
In-Reply-To: <67aeed9c-73f5-462b-becd-7bb370a022d0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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


On 11/12/24 12:29, Patrick DELAUNAY wrote:
> Hi,
>
> On 10/21/24 21:34, Marek Vasut wrote:
>> Remove unused local DT copies after the OF_UPSTREAM conversion.
>>
>> Fixes: cccb29fc1270 ("ARM: dts: stm32: Switch to using upstream DT on 
>> DH STM32 DHSOM")
>> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/dts/stm32mp13xx-dhcor-som.dtsi       | 308 ------------------
>>   .../arm/dts/stm32mp153c-dhcor-drc-compact.dts |  30 --
>>   arch/arm/dts/stm32mp157a-dhcor-avenger96.dts  |  38 ---
>>   3 files changed, 376 deletions(-)
>>   delete mode 100644 arch/arm/dts/stm32mp13xx-dhcor-som.dtsi
>>   delete mode 100644 arch/arm/dts/stm32mp153c-dhcor-drc-compact.dts
>>   delete mode 100644 arch/arm/dts/stm32mp157a-dhcor-avenger96.dts
>>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>
>
Applied to u-boot-stm/master, thanks!

Regards
Patrick

