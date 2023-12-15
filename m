Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55466C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D374987BEC;
	Fri, 15 Dec 2023 15:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2WIOo0ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C905987BF6; Fri, 15 Dec 2023 15:13:03 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC8687BE4
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9dlJF028436; Fri, 15 Dec 2023 15:13:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=6xCcXQyn99iRhLZ8grv5OFshDt5uJrWpGPlmJk9r4Zg=; b=2W
 IOo0roxy6f2LRe2LM7n7GPnLwY7VCf3oqEi+nozEXGVK4RoAprOtxYeiVAiDfONE
 PrsPB08tQosMvbVk6vpv11BgdsBn4aPcizlyYCHUZfN3AAayO+STggHXYA8CpDfe
 ESnCKpFBSkrRgVJieYchbyl7vUxZRKgerkzVeHwaNG9f9Du+QSX03Fv49HgNQjvA
 L0Mdo9eZ0cr4DoTjoag3iFZeIypNLwVvZjaXavDr1NiL6lW2Xk6JfUQITNv37+OS
 U0xTxHouc6h53CBKpdzQz9Ae6cdLvVmfn495yXAAnKiZJlKvh9gAmiLgjgzAGjz5
 zPfsG22SuMroZ4y7O8eQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmtn0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:13:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0857E100058;
 Fri, 15 Dec 2023 15:13:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F31E42278B6;
 Fri, 15 Dec 2023 15:13:00 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:13:00 +0100
Message-ID: <593de0a9-9c11-445e-8254-372d485b011a@foss.st.com>
Date: Fri, 15 Dec 2023 15:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: st: common: Fix board_get_alt_info_mtd()
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
 <7e2b0b40-1193-4a4f-8397-0ccc99d9122a@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7e2b0b40-1193-4a4f-8397-0ccc99d9122a@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.23.141]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
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



On 12/15/23 12:52, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/17/23 18:01, Patrice Chotard wrote:
>> Since MTD devices are partioned, we got the following
>> error when command "dfu 0" is executed:
>>
>> DFU alt info setting: done
>> ERROR: Too many arguments for nor0
>> ERROR: DFU entities configuration failed!
>> ERROR: (partition table does not match dfu_alt_info?)
>>
>> Fixes: 31325e1b8b9c ("stm32mp1: dynamically build DFU_ALT_INFO")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   board/st/common/stm32mp_dfu.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
>> index a8eb8d5cae2..ded3bf81961 100644
>> --- a/board/st/common/stm32mp_dfu.c
>> +++ b/board/st/common/stm32mp_dfu.c
>> @@ -73,7 +73,6 @@ static void board_get_alt_info_mmc(struct udevice *dev, char *buf)
>>   static void board_get_alt_info_mtd(struct mtd_info *mtd, char *buf)
>>   {
>>       struct mtd_info *part;
>> -    bool first = true;
>>       const char *name;
>>       int len, partnum = 0;
>>   @@ -86,17 +85,13 @@ static void board_get_alt_info_mtd(struct mtd_info *mtd, char *buf)
>>               "mtd %s=", name);
>>         len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
>> -            "%s raw 0x0 0x%llx ",
>> +            "%s raw 0x0 0x%llx",
>>               name, mtd->size);
>>         list_for_each_entry(part, &mtd->partitions, node) {
>>           partnum++;
>> -        if (!first)
>> -            len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, ";");
>> -        first = false;
>> -
>>           len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
>> -                "%s_%s part %d",
>> +                ";%s_%s part %d",
>>                   name, part->name, partnum);
>>       }
>>   }
> 
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
