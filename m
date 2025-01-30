Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC2EC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FB680E9A;
	Thu, 30 Jan 2025 17:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nr5DU1wO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D0A80EBA; Thu, 30 Jan 2025 17:05:19 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB57580E90
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125720023=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UEUtwI022423;
 Thu, 30 Jan 2025 17:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 g48sfWxh2Firgpq8bu1Oh9W+cOrR5D3jKHB6A9tquDg=; b=nr5DU1wOW+hh2FoV
 f24c+LEq+SoTWQpTsMZr3UcsiLemDN2x6Wf4WFS144lzdQarnio41ySWuxAkAz3K
 P7DarVb3JZncsZIzCuoqELdKvOe67FbY8sjtPgW0X7y/OZLX+5O8BQu8l4UpzUTy
 pt07uSHh0aJaN1lADlIHtZrBvauAd4Q5EAu1FupKamjKxttN31QgLQfakRG/1xE1
 4YqBQSw93YiEmTl63BYRYnfaPDQdYS9CUUcF65VEz35HoHOlc2vzCf+qMPxVYnYh
 trBRZ+Zhlgo7TdeKp9C6Xw3z7J87cnTAoE5HwP27N+6CtxmseWf5jESf/g21n22e
 aO4Dww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g6v6hygy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 17:05:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 72B0E4004A;
 Thu, 30 Jan 2025 17:04:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96F303CBA10;
 Thu, 30 Jan 2025 16:59:24 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 16:59:24 +0100
Message-ID: <2a619cae-ac94-4b53-a6c9-e1fad0fe2747@foss.st.com>
Date: Thu, 30 Jan 2025 16:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] configs: stih410-b2260: Enable USB_DWC3_GENERIC
 and USB_DWC3_STI flags
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-6-patrice.chotard@foss.st.com>
 <26ecfad5-b3fa-43a6-bc6d-cb83b5197dc8@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <26ecfad5-b3fa-43a6-bc6d-cb83b5197dc8@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
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



On 1/30/25 14:25, Patrick DELAUNAY wrote:
> Hi,
> 
> On 1/23/25 15:47, Patrice Chotard wrote:
>> Enable USB_DWC3_GENERIC and USB_DWC3_STI flags.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Marek Vasut <marex@denx.de>
>> ---
>>
>> (no changes since v1)
>>
>>   configs/stih410-b2260_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/stih410-b2260_defconfig b/configs/stih410-b2260_defconfig
>> index e312ca492d2..4fcbf75548b 100644
>> --- a/configs/stih410-b2260_defconfig
>> +++ b/configs/stih410-b2260_defconfig
>> @@ -61,6 +61,8 @@ CONFIG_USB_EHCI_GENERIC=y
>>   CONFIG_USB_OHCI_HCD=y
>>   CONFIG_USB_OHCI_GENERIC=y
>>   CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_DWC3_STI=y
>>   CONFIG_USB_HOST_ETHER=y
>>   CONFIG_USB_ETHER_ASIX=y
>>   CONFIG_USB_ETHER_MCS7830=y
> 
> 
> with CONFIG_USB_XHCI_STI = y (default in Kconfig)
> you have 2 drvier for the same compatible now  = "st,stih407-dwc3"
> 
> can be solve with adding temporarily (up to next patch)
> 
> # CONFIG_USB_XHCI_STI is not set

I will first remove the "old" dwc3-sti-glue.c driver
and then introduce the "new" dwc3-generic-sti.c to avoid this kind of situation.

So "[PATCH 6/9] usb: dwc3: Remove dwc3 glue driver support for STi" becomes [patch 3/9] ...

Thanks
Patrice

> 
> 
> Patrick
> 
> 
