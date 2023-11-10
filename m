Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E5C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF27877FC;
	Fri, 10 Nov 2023 14:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dRx+IZEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9943E876E3; Fri, 10 Nov 2023 14:21:17 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F1C877E2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AAAIMaC010116; Fri, 10 Nov 2023 14:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=xexKF8UIrKmP99Q8IcuS1bzGmGClRbtrWWHrBgVbG0w=; b=dR
 x+IZEjKSbpPM5yAXEVaXvJfL9evCox3lhClLNE+38blAOcC0Ay9whFabNTZs4+Jy
 +Cc7b1E7aNdij7s9d3FxVjogUC3YI5AOU7E6pZZmxgbmk39aP6qaZcSbLwH1Bbz0
 YtWYEv4WjdhLCE4EiDILqz3X95mgX2n6Xbcd/iStfnb4RysiYdZLpSeSniY4I3Lx
 zg25pnWTWbhmTd9XB0Z9LbHsdItWXxB+DwzPs32fCvrDnrPwXBDpWNw2HbIdqJX/
 hIhjAUfcJv+iVrODm5w7zcSeeSGMCGBTp6MN8W5eMIFeeU3iyq5CODhU7onk+NXd
 lcI5aM0eDSfJkf7doqfw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26pddh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:21:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5B82100056;
 Fri, 10 Nov 2023 14:21:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE15325E535;
 Fri, 10 Nov 2023 14:21:12 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:21:12 +0100
Message-ID: <d3e8e391-a4a0-4efd-8b3c-2c8aea8634b8@foss.st.com>
Date: Fri, 10 Nov 2023 14:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] stm32mp: dram_init: Fix AARCH64 compilation
 warnings
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-4-patrice.chotard@foss.st.com>
 <473399db-ac71-4cdc-9f2c-fe2b2645d9d5@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <473399db-ac71-4cdc-9f2c-fe2b2645d9d5@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
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



On 11/9/23 10:13, Patrick DELAUNAY wrote:
> Hi,
> 
> 
> On 10/27/23 16:42, Patrice Chotard wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> When building with AARCH64 defconfig, we got warnings for debug
>> message
>> - format '%x' expects argument of type 'unsigned int',
>>     but argument 3 has type 'size_t' {aka 'long unsigned int'}).
>> - format '%lx' expects argument of type 'long unsigned int',
>>    but argument 2 has type 'phys_addr_t' {aka 'long long unsigned
>>    int'}
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/dram_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
>> index a1e77a42e4f..cb35ed60ca1 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -36,7 +36,7 @@ int dram_init(void)
>>           log_debug("Cannot get RAM size: %d\n", ret);
>>           return ret;
>>       }
>> -    log_debug("RAM init base=%lx, size=%x\n", ram.base, ram.size);
>> +    log_debug("RAM init base=%p, size=%zx\n", (void *)ram.base, ram.size);
>>         gd->ram_size = ram.size;
>>   
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
