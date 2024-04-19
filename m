Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D0BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B49887D8;
	Fri, 19 Apr 2024 14:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="b7Cnwx4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03ABE887D3; Fri, 19 Apr 2024 14:17:05 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1AE8887E0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J7svtN019688; Fri, 19 Apr 2024 14:16:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=21KzfnT0nHvkJ6GaDehhAMlM0GB+gOGj37cixEivcC8=; b=b7
 Cnwx4id7J6jUDR+VWKk1DhuWPdTQT3PPH6PNdyumNp8m54SjKPr4O0CS7A/L4Qzl
 HlHAOVUwZR62Zvp8zKdYwsGQPDP1A5w2S51PkJSZJu7RidAhmesFy+axBFpvgeOH
 zAyMqnUBqQJyBL75IAqt2aAYi0zBc11rDWZadwfh/9frTCS1Ftl+DVZgWBgY1vSK
 e4BHhybFMAO0eq7PfctFx0FQbfysszznAhTERNuTn8a+EUPkJf/n9FyanCfufPjB
 h47XyrdBD1i8SAj1rkLiMdoI4aeRs53lwoKiqngp8c5Yl9jksncV63nPa9/4UYna
 f3kj0WhVX7fm7Zr6tWzw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50j9e4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:16:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AB2A94002D;
 Fri, 19 Apr 2024 14:16:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C07C421861A;
 Fri, 19 Apr 2024 14:16:24 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:16:24 +0200
Message-ID: <0baafe54-5626-4005-ac76-933839dab6a9@foss.st.com>
Date: Fri, 19 Apr 2024 14:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp15_defconfig
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-3-patrice.chotard@foss.st.com>
 <ab4ee155-7826-4502-8389-5f5a9369b320@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ab4ee155-7826-4502-8389-5f5a9369b320@foss.st.com>
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



On 4/17/24 11:03, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:01, Patrice Chotard wrote:
>> Enable BUTTON_GPIO flag for STM32MP15.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32mp15_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
>> index 3302b306996..ffe7512650e 100644
>> --- a/configs/stm32mp15_defconfig
>> +++ b/configs/stm32mp15_defconfig
>> @@ -69,6 +69,8 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_SCMI=y
>>   CONFIG_SET_DFU_ALT_INFO=y
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied on u-boot-stm32/master 
