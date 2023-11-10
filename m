Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E207C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70614877E9;
	Fri, 10 Nov 2023 14:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tanALpOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FF3876E3; Fri, 10 Nov 2023 14:20:56 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64191877E9
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AA9mEJt021404; Fri, 10 Nov 2023 14:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=SkpJ65dFskSeS6TTsFHaipi0F6nycEuCJl49ZqQMKvw=; b=ta
 nALpOu4rxTrjyNElJQfsJIodNC4ojjNjC+Ftt2CQ54mxPzmQZVywUa7QSXcY9OcJ
 y/FPMU5slE7+9xXHCRR8bxqEw/A4JxH/Za8GU90h6nISCvI4DGcj1sxvDSrKweXb
 EM5sg6qHoLNnvAb0okSlZCeS9bXnXf8eePU++u1S3WccY6TfT+0BHQri3aV/KwqA
 FosDWo5AagtgNIstvoKEMnjis+hENoCSxg9YrR1Fv2GfmqntNadv1+L9ZyTor5Xj
 Ec8+fnqQZp9IkRtMuPvmSPPhSEMxVelrc7meyr80a8TR3Krgjc6D/DnZUCa0gx52
 lEvRw6FmXtjIFIaC5ZjQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u84a5n1fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:20:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8880100056;
 Fri, 10 Nov 2023 14:20:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A193A25E53B;
 Fri, 10 Nov 2023 14:20:51 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:20:51 +0100
Message-ID: <533af786-67af-4918-9f8d-ca3055241cab@foss.st.com>
Date: Fri, 10 Nov 2023 14:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] stm32mp: dram_init: Get RAM size from DT if no RAM
 driver found
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrice Chotard
 <patrice.chotard@st.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-3-patrice.chotard@foss.st.com>
 <8febd85e-b390-46c2-b75b-fc4e75122718@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <8febd85e-b390-46c2-b75b-fc4e75122718@foss.st.com>
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



On 11/9/23 10:11, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:42, Patrice Chotard wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> In case there is no RAM driver retrieve RAM size from DT as fallback.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/dram_init.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
>> index 7f37b0d2aa2..a1e77a42e4f 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -24,8 +24,11 @@ int dram_init(void)
>>       int ret;
>>         ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>> -    if (ret) {
>> -        log_debug("RAM init failed: %d\n", ret);
>> +    /* in case there is no RAM driver, retrieve DDR size from DT */
>> +    if (ret == -ENODEV) {
>> +        return fdtdec_setup_mem_size_base();
>> +    } else if (ret) {
>> +        log_err("RAM init failed: %d\n", ret);
>>           return ret;
>>       }
>>       ret = ram_get_info(dev, &ram);
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
