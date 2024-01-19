Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABCEC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E26E87C5A;
	Fri, 19 Jan 2024 14:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JU529w0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5586B87C8A; Fri, 19 Jan 2024 14:25:55 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF1D87BBC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40J9b5wc020013; Fri, 19 Jan 2024 14:25:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=ZGXU45uES7rzrKnTQMBkjyhgi/MgJ4O3QlrDA0/5C/E=; b=JU
 529w0ytv1bkV5ZpnahKZF7teG3+4NRLX3cQhILenHN7KV8CHQKnP5fGbEXhOO/2c
 zDq5X7K4R5fFujFltH1uq3iIvdFE49YsVe4zj6x/M6G4gJkHy/gsMRJlpxzNf3fQ
 c70DB3yD5P4xqv2JqLgQzX4uWDfWVDKICKxAq7dez3e75KN7GrYnJGxEaEqr8lLV
 VAIM8o54QzYndNj2JaS6pIsaGNtAbtccaXQuRboLd8KuFEZGc95Z9mnQYhBnh7Fm
 wyhy4/vVsjHcxtHTpYW2tG5j0fIpk62ISeEYXbYnE5tBicIIqkH+d/7BICub6UXu
 xtDadDWntKCmPa1GBTfQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y5budg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 14:25:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6DF2100081;
 Fri, 19 Jan 2024 14:25:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFD4823D41E;
 Fri, 19 Jan 2024 14:25:47 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 14:25:47 +0100
Message-ID: <bd33b14f-e356-471b-b817-bda60a94f11e@foss.st.com>
Date: Fri, 19 Jan 2024 14:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] stm32mp: add setup_serial_number for stm32mp25
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.7.I122ede30eb83184b996b7d3e1c480418b29ffbe1@changeid>
 <CAByghJaABf37PeVgEPWaQAtpZK4O=brECrLLAWnhWc5mrpW92g@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAByghJaABf37PeVgEPWaQAtpZK4O=brECrLLAWnhWc5mrpW92g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/15/24 17:23, Igor Opaniuk wrote:
> Hello Patrick,
> 
> On Mon, Jan 15, 2024 at 5:03 PM Patrick Delaunay
> <patrick.delaunay@foss.st.com> wrote:
>>
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add support of serial number for stm32mp25, gets from OTP with BSEC driver.
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> (no changes since v1)
>>
>>  .../arm/mach-stm32mp/include/mach/sys_proto.h |  1 +
>>  arch/arm/mach-stm32mp/soc.c                   | 31 +++++++++++++++++++
>>  arch/arm/mach-stm32mp/stm32mp1/cpu.c          | 27 ----------------
>>  arch/arm/mach-stm32mp/stm32mp2/cpu.c          |  2 ++
>>  4 files changed, 34 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> index 83388fdb7371..2a65efc0a50a 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> @@ -97,6 +97,7 @@ u32 get_bootauth(void);
>>
>>  int get_eth_nb(void);
>>  int setup_mac_address(void);
>> +int setup_serial_number(void);
>>
>>  /* board power management : configure vddcore according OPP */
>>  void board_vddcore_init(u32 voltage_mv);
>> diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
>> index 8d5fa474ccaf..ff70ebe97464 100644
>> --- a/arch/arm/mach-stm32mp/soc.c
>> +++ b/arch/arm/mach-stm32mp/soc.c
>> @@ -3,7 +3,11 @@
>>   * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
>>   */
>>
>> +#include <env.h>
>> +#include <misc.h>
>>  #include <asm/arch/sys_proto.h>
>> +#include <dm/device.h>
>> +#include <dm/uclass.h>
>>
>>  /* used when CONFIG_DISPLAY_CPUINFO is activated */
>>  int print_cpuinfo(void)
>> @@ -15,3 +19,30 @@ int print_cpuinfo(void)
>>
>>         return 0;
>>  }
>> +
>> +int setup_serial_number(void)
>> +{
>> +       char serial_string[25];
>> +       u32 otp[3] = {0, 0, 0 };
>> +       struct udevice *dev;
>> +       int ret;
>> +
>> +       if (env_get("serial#"))
>> +               return 0;
>> +
>> +       ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +                                         DM_DRIVER_GET(stm32mp_bsec),
>> +                                         &dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_SERIAL),
>> +                       otp, sizeof(otp));
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       sprintf(serial_string, "%08X%08X%08X", otp[0], otp[1], otp[2]);
>> +       env_set("serial#", serial_string);
>> +
>> +       return 0;
>> +}
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index 00fea7929b2f..f84cb26fa565 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -336,33 +336,6 @@ __weak int setup_mac_address(void)
>>         return 0;
>>  }
>>
>> -static int setup_serial_number(void)
>> -{
>> -       char serial_string[25];
>> -       u32 otp[3] = {0, 0, 0 };
>> -       struct udevice *dev;
>> -       int ret;
>> -
>> -       if (env_get("serial#"))
>> -               return 0;
>> -
>> -       ret = uclass_get_device_by_driver(UCLASS_MISC,
>> -                                         DM_DRIVER_GET(stm32mp_bsec),
>> -                                         &dev);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_SERIAL),
>> -                       otp, sizeof(otp));
>> -       if (ret < 0)
>> -               return ret;
>> -
>> -       sprintf(serial_string, "%08X%08X%08X", otp[0], otp[1], otp[2]);
>> -       env_set("serial#", serial_string);
>> -
>> -       return 0;
>> -}
>> -
>>  __weak void stm32mp_misc_init(void)
>>  {
>>  }
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> index c0f6519e8d7c..301e365cf4f4 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> @@ -69,6 +69,8 @@ void enable_caches(void)
>>
>>  int arch_misc_init(void)
>>  {
>> +       setup_serial_number();
>> +
>>         return 0;
>>  }
>>
>> --
>> 2.25.1
>>
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> 
Applied to u-boot-stm32/master

Thanks
Patrice
