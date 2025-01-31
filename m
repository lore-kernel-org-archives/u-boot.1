Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06614C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9099280F5F;
	Fri, 31 Jan 2025 09:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eSnvxPSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D7D82148; Fri, 31 Jan 2025 09:12:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA1180F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80wu6012210;
 Fri, 31 Jan 2025 09:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 9wmxY4iYkUNU063hceEtVTkj7QCiBjuLuFR0hAkhL+U=; b=eSnvxPSSdzvpT+NH
 HGQIpgkXu/fwxTjEcdT6op6XTaF0L/soBIoz/E5klUwkGBDvjKECRg/KkAXf27rB
 ybjg230lrICXNaJ24bvdpQiQeIml6mCmbwxo1k+haBKT5FTQ+75E8NiCHOO5RGd7
 F3KvN2xiOeqL3CNncAna+EdgoUgdCeLZ82ozC/y0TNI8YNorqOKwp1CkiB2GT164
 EE3Iwwh6I46G+tXabZlBvRG1UW1JLL0/7EfTsU+U/YuqKXX8c4/0vq2Vxuu2n0/j
 uNGseQye/qNRslK2SSaWB27+nQ1X/ZFXrLa/Ai89YageNBqAj+GYqxyXkD5TxicG
 r4mMMQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7d9spe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:12:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CEC4A4004B;
 Fri, 31 Jan 2025 09:11:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 023C9281AEF;
 Fri, 31 Jan 2025 09:06:37 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:06:36 +0100
Message-ID: <4a0771a4-fabe-4f23-8437-c245822c243d@foss.st.com>
Date: Fri, 31 Jan 2025 09:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: stm32f769-disco: Set CYCLIC_MAX_CPU_TIME_US
 to 8000 for stm32f769-disco
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>
References: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
 <a6c8c93d-0f9f-41c4-9874-2c57544e4eac@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <a6c8c93d-0f9f-41c4-9874-2c57544e4eac@foss.st.com>
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



On 1/8/25 19:53, Patrick DELAUNAY wrote:
> Hi,
> 
> On 12/11/24 09:09, Patrice Chotard wrote:
>> Updating the framebuffer takes quite a long time on this slow patform,
>> set CYCLIC_MAX_CPU_TIME_US to 8000 for stm32f769-disco to avoid
>> following cyclic warning:
>>
>> "cyclic function video_init took too long: 7280us vs 5000us max"
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32f769-disco_defconfig     | 1 +
>>   configs/stm32f769-disco_spl_defconfig | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
>> index 1e09c224fc0..5be221afd2f 100644
>> --- a/configs/stm32f769-disco_defconfig
>> +++ b/configs/stm32f769-disco_defconfig
>> @@ -21,6 +21,7 @@ CONFIG_USE_BOOTARGS=y
>>   CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>>   CONFIG_SYS_PBSIZE=1050
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_CYCLIC_MAX_CPU_TIME_US=8000
>>   CONFIG_SYS_PROMPT="U-Boot > "
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_MMC=y
>> diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
>> index 787571dba0c..7d4bda44068 100644
>> --- a/configs/stm32f769-disco_spl_defconfig
>> +++ b/configs/stm32f769-disco_spl_defconfig
>> @@ -30,6 +30,7 @@ CONFIG_USE_BOOTARGS=y
>>   CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>>   CONFIG_SYS_PBSIZE=1050
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_CYCLIC_MAX_CPU_TIME_US=8000
>>   CONFIG_SPL_PAD_TO=0x9000
>>   CONFIG_SPL_NO_BSS_LIMIT=y
>>   CONFIG_SPL_BOARD_INIT=y
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
