Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EA0E7B5F5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BFF8750F;
	Wed,  4 Oct 2023 13:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xvh7cQcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183438750B; Wed,  4 Oct 2023 13:39:48 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3137986199
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394ATau4022722; Wed, 4 Oct 2023 13:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=JldkG0wkxzw1qyHSCVh/A4kGvKM0130xv33MLzwR+VI=; b=xv
 h7cQcuA+jCAJX9gmNCxem6z46sjHv5cfFwmnSkDLv+SsRKwkkMLLjC+nN4NoaBa+
 IEf/VknYIdGll/eBBSpAUvXMyoNn0Oi2MDljLJjcMfNTpFEGsrQjaKtR2XMJhtcu
 TuDUdwKHbefdx1ouHGpcr/4YgZ2pbmrKRZWFH7Jfsw18+LJK5WNxzwfNDEdUtAVg
 qydosIeq5gnLGtEnETh+tX1z3WP07+Z9lI5z3bJ4LJr+1NCAcJr2t0/R8ua5wKv4
 ACda3RLkMxBD6xA1qwWdySSCR8XFHhI3HhHT9Dlb+U8W8PPIJ/Uxpu2Xjs10QGR8
 VegEeAyG02goh0eJ1Wng==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tggx359cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:39:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4733100053;
 Wed,  4 Oct 2023 13:39:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD2BD235F11;
 Wed,  4 Oct 2023 13:39:44 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 13:39:44 +0200
Message-ID: <9a7983aa-3049-f057-1dce-7f1c6e84d854@foss.st.com>
Date: Wed, 4 Oct 2023 13:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 5/6] configs: stm32mp13: add support of usb boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-6-patrice.chotard@foss.st.com>
 <fb1f4a63-40b5-e675-70a5-2b80e93f945a@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <fb1f4a63-40b5-e675-70a5-2b80e93f945a@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_03,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:57, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/26/23 17:09, Patrice Chotard wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> Add support of USB key boot in distro boot command.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   include/configs/stm32mp13_common.h | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
>> index d36fbf00548..5b0658ced92 100644
>> --- a/include/configs/stm32mp13_common.h
>> +++ b/include/configs/stm32mp13_common.h
>> @@ -35,9 +35,16 @@
>>   #define BOOT_TARGET_MMC1(func)
>>   #endif
>>   +#ifdef CONFIG_CMD_USB
>> +#define BOOT_TARGET_USB(func)    func(USB, usb, 0)
>> +#else
>> +#define BOOT_TARGET_USB(func)
>> +#endif
>> +
>>   #define BOOT_TARGET_DEVICES(func)    \
>>       BOOT_TARGET_MMC1(func)        \
>> -    BOOT_TARGET_MMC0(func)
>> +    BOOT_TARGET_MMC0(func)        \
>> +    BOOT_TARGET_USB(func)
>>     /*
>>    * default bootcmd for stm32mp13:
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
Apply on stm32/next

Thanks
Patrice
