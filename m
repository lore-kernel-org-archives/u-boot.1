Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C8DC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6153487A10;
	Fri, 15 Dec 2023 15:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GcXRWCQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B7C28761B; Fri, 15 Dec 2023 15:12:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F09E87536
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9b4Mk028439; Fri, 15 Dec 2023 15:12:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=BEOeenzKA4OB1w+LsG5+JBtGetax5kbKMIN0N7yrbn8=; b=Gc
 XRWCQI3ugmom2NkNdb/33REHUNqWO6Wz2ZPkZwXEi9kWZzvbf+xPb6f1hPeVxZaN
 ZIhXKVjbyjMRDumTwd3cMWRutKGVFM+v9wZiGe0Amlw8kaq7OhnROlnwTIfir3tS
 2cTLPbr1LdtV+u5cYDMFlwTWcsw2jRXh+6fRNwosFi3/42zgPlBSm+3BcGbF4Tf1
 gJTP65MWZkgFyQk7IQ1IgOmyugT6rEbSU79F7WlrumlE5nypz0Kp+sBuF4u4QAWu
 KiaNqFfiIflMQJeGZYQW3eFubr7V/sCPzGmU14jpWU0rv6OSz9cWvVVzta3lH2mI
 YhduaojAvGPFUbvEZEcQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmtmyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:12:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87CF2100052;
 Fri, 15 Dec 2023 15:12:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 800512278B3;
 Fri, 15 Dec 2023 15:12:44 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:12:44 +0100
Message-ID: <85143540-3b4b-4d3e-bcf6-e1084f605336@foss.st.com>
Date: Fri, 15 Dec 2023 15:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: st: common: simplify MTD device parsing
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
 <20231117170107.1147598-2-patrice.chotard@foss.st.com>
 <7137cd11-03ee-4a3c-8ff6-4e5c9268981d@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7137cd11-03ee-4a3c-8ff6-4e5c9268981d@foss.st.com>
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



On 12/15/23 12:53, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/17/23 18:01, Patrice Chotard wrote:
>> Simplify the way all MTD devices are parsed.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   board/st/common/stm32mp_dfu.c | 19 ++-----------------
>>   1 file changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
>> index ded3bf81961..77edb86e78c 100644
>> --- a/board/st/common/stm32mp_dfu.c
>> +++ b/board/st/common/stm32mp_dfu.c
>> @@ -123,24 +123,9 @@ void set_dfu_alt_info(char *interface, char *devstr)
>>           /* probe all MTD devices */
>>           mtd_probe_devices();
>>   -        /* probe SPI flash device on a bus */
>> -        if (!uclass_get_device(UCLASS_SPI_FLASH, 0, &dev)) {
>> -            mtd = get_mtd_device_nm("nor0");
>> -            if (!IS_ERR_OR_NULL(mtd))
>> +        mtd_for_each_device(mtd)
>> +            if (!mtd_is_partition(mtd))
>>                   board_get_alt_info_mtd(mtd, buf);
>> -
>> -            mtd = get_mtd_device_nm("nor1");
>> -            if (!IS_ERR_OR_NULL(mtd))
>> -                board_get_alt_info_mtd(mtd, buf);
>> -        }
>> -
>> -        mtd = get_mtd_device_nm("nand0");
>> -        if (!IS_ERR_OR_NULL(mtd))
>> -            board_get_alt_info_mtd(mtd, buf);
>> -
>> -        mtd = get_mtd_device_nm("spi-nand0");
>> -        if (!IS_ERR_OR_NULL(mtd))
>> -            board_get_alt_info_mtd(mtd, buf);
>>       }
>>         if (IS_ENABLED(CONFIG_DFU_VIRT)) {
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
