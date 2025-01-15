Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5B3C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 09:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7935E80040;
	Wed, 15 Jan 2025 10:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RgXrYAbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295B880214; Wed, 15 Jan 2025 10:39:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA26A80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3110841290=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F3w7eN007100;
 Wed, 15 Jan 2025 10:39:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 LSVrs6qM+IKY0aB7vbMLMhV6qq7CH6U/3k4F/PM0Y28=; b=RgXrYAbciOahIsVz
 Y56hYoVahkBrgVxk46PsGrHLnoN40aSzjxVg/+78/2Y7YALtKyoYYUZggAOu9lP3
 qsY59U3/oNmky17zdJMt75sBsoWFxNtdZzWRwWm54gPwBz8VBgv0CXaNLSV4RcN4
 4FZgNUUPbe21T1nsD7bO1nScCDaw7HyIkcg7J+RslZqyikBBmVNmKSNnHaPaasWu
 jXDYbiDAa5YzcTtT3GVjN6hN0xVwvhxbJFGlKTa9HRx6ZQNsiUr7G13yT73GseRA
 RbTS2B7yZhOYQ90w3iPOJ/tk9nb5m1XYb7+kfu13mtsAjMRfP+LvY4g4RiksURag
 Et8bPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4465jns801-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 10:39:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 85C8740044;
 Wed, 15 Jan 2025 10:37:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C4BB246C80;
 Wed, 15 Jan 2025 10:37:19 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 15 Jan
 2025 10:37:18 +0100
Message-ID: <a0a4a9c1-a0b2-4ad7-90e6-95c34cf89e79@foss.st.com>
Date: Wed, 15 Jan 2025 10:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] usb: dwc3-generic: Reorder include
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-4-patrice.chotard@foss.st.com>
 <912f42f2-9358-4295-8382-8a5aa82c7804@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <912f42f2-9358-4295-8382-8a5aa82c7804@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
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



On 1/14/25 15:51, Marek Vasut wrote:
> On 1/14/25 3:45 PM, Patrice Chotard wrote:
>> Reorder include following rules available here :
>> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Marek Vasut <marex@denx.de>
>> ---
>>
>>   drivers/usb/dwc3/dwc3-generic.c | 21 ++++++++++-----------
>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 2ab41cbae45..cb96e1f344f 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -7,29 +7,28 @@
>>    * Based on dwc3-omap.c.
>>    */
>>   +#include <clk.h>
>>   #include <cpu_func.h>
>> -#include <log.h>
>>   #include <dm.h>
>> -#include <dm/device-internal.h>
>> -#include <dm/lists.h>
>>   #include <dwc3-uboot.h>
>>   #include <generic-phy.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <reset.h>
>> +#include <usb.h>
>> +#include <asm/gpio.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/printk.h>
>>   #include <linux/usb/ch9.h>
>>   #include <linux/usb/gadget.h>
>> -#include <malloc.h>
>>   #include <power/regulator.h>
>> -#include <usb.h>
>> -#include "core.h"
>> -#include "gadget.h"
>> -#include <reset.h>
>> -#include <clk.h>
>>   #include <usb/xhci.h>
>> -#include <asm/gpio.h>
> Can you remove some of them too ?
Hi Marek

Effectively, some seems useless, i will fix this in v2

Thanks
Patrice
