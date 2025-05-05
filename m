Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE405C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC39D829D4;
	Mon,  5 May 2025 15:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="c7ZA4OIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2EB8212B; Mon,  5 May 2025 15:38:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA511829CD
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545B2iVM029905;
 Mon, 5 May 2025 15:38:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 7m//M2srdJ6uvxinmwdUBz1VHlLMuOiYxQeU20/DFSY=; b=c7ZA4OIrclgH5CNg
 g2fRAD22pvZB88zhoQ+HC5jH4UYLCr0Sgm7/A4rmlprle9gtb7otQdBMJyibZlM4
 rGroMd2KEixBsLJX3ud1SVaxWuJv3V/g5lQhO3d7E6c1jycI50AV+B9W/N5NWEcw
 zh6vHRsgzq6Ov6yDqWgnKjsPj5C1vKgzqBlIL9JKqDki1T9mWKc56flwsDBLsnii
 3YDJTTtw/v0ro6Gt0PWtxMskS0S75DarWLCZ++kbrw/XmYR/YySdhQxEnJb6Hk5G
 qelA25V6/TkIob1cjCI2VQHlB2P5zh4bSNTCA2ZqIEjqrdpzCVhjx3E7isKMVfmH
 gsfpIg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbkq6w0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 15:38:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D11B340049;
 Mon,  5 May 2025 15:37:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89D3CB3EE49;
 Mon,  5 May 2025 15:35:33 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 15:35:32 +0200
Message-ID: <21830c81-1570-4096-b07c-b5b9ee9cae6a@foss.st.com>
Date: Mon, 5 May 2025 15:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] configs: stm32746-eval_spl: Fix console cmdline
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20250401135132.395518-1-patrice.chotard@foss.st.com>
 <20250401135132.395518-6-patrice.chotard@foss.st.com>
 <b2736555-6b4f-4c28-a525-9d5e3c1a4020@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <b2736555-6b4f-4c28-a525-9d5e3c1a4020@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
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



On 4/22/25 09:51, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/1/25 15:51, Patrice Chotard wrote:
>> The Linux cmdline encoded in the defconfig is wrong, the
>> STM32 USART driver registers as ttySTM0 not ttyS0.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32746g-eval_spl_defconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
>> index 8a0b1e21fb5..4706a72cb9c 100644
>> --- a/configs/stm32746g-eval_spl_defconfig
>> +++ b/configs/stm32746g-eval_spl_defconfig
>> @@ -27,7 +27,7 @@ CONFIG_AUTOBOOT_KEYED=y
>>   CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
>>   CONFIG_AUTOBOOT_STOP_STR=" "
>>   CONFIG_USE_BOOTARGS=y
>> -CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>> +CONFIG_BOOTARGS="console=ttySTM0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>>   CONFIG_DEFAULT_FDT_FILE="stm32746g-eval"
>>   CONFIG_SYS_PBSIZE=1050
>>   # CONFIG_DISPLAY_CPUINFO is not set
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
