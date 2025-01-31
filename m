Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E76C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 07:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA9980EBD;
	Fri, 31 Jan 2025 08:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tpGtvP39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A30F80F67; Fri, 31 Jan 2025 08:59:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA9F80EB6
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7pCul006643;
 Fri, 31 Jan 2025 08:59:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 p3D3uZm14Bxs32shxz6j/vJai7XG+wd0011jwgidSTA=; b=tpGtvP39fGe4FDGH
 JxXB59LTEn5MuJ124G1IHbDti51yApWDOe45Yk25WM+dZNdHx5L5onV7Vyp5Aqlt
 ckUo8c0m3o+kzw7NJYcv8h3m8u62wb3I9MR0H9K5zv9hdBrsuuCFGpKzBuOqGsnw
 UcIkxe0/yUrE/U3FM44qOaoEeXsbQj05p8aQxB2OdQ6jt9y01s47AQbMyj+b+AmX
 Jl4mxk7Xkb7+P5JVDoVLB6R9Z7YWT4WrtsK0+nYifa9bzxOcILbeGj/hXSzqDmwH
 i6idLBaemO8zB1LlIED2vPtDIuYeX8HPSKuYl8YZSwOAnvwosgoYDXrVdxQVQpKk
 toDXoQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7ghss9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 08:59:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A4E7E40054;
 Fri, 31 Jan 2025 08:58:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 434B427EEDB;
 Fri, 31 Jan 2025 08:56:43 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 08:56:42 +0100
Message-ID: <36fb582a-2c6d-4102-bd80-e1850f23021e@foss.st.com>
Date: Fri, 31 Jan 2025 08:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] arm: stm32mp: stm32prog: fix warning when
 CONFIG_SYS_64BIT_LBA is enable
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-3-patrice.chotard@foss.st.com>
 <1cccf0a2-e317-4b00-9624-d2d25c8b4ae4@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1cccf0a2-e317-4b00-9624-d2d25c8b4ae4@foss.st.com>
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



On 1/8/25 19:48, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/29/24 13:27, Patrice Chotard wrote:
>> If CONFIG_SYS_64BIT_LBA flag is enable, following warning is triggered:
>>
>> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c: In function 'init_device':
>> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:27: warning: format
>> '%ld' expects argument of type 'long int', but argument 8 has type
>> 'lbaint_t' {aka 'long long unsigned int'} [-Wformat=]
>>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../include/log.h:157:21: note: in definition of macro 'pr_fmt'
>>    157 | #define pr_fmt(fmt) fmt
>>        |                     ^~~
>> ../include/log.h:182:33: note: in expansion of macro 'log'
>>    182 | #define log_debug(_fmt...)      log(LOG_CATEGORY, LOGL_DEBUG, ##_fmt)
>>        |                                 ^~~
>> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:17: note: in expansion
>> of macro 'log_debug'
>>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>>        |                 ^~~~~~~~~
>> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:42: note: format string
>> is defined here
>>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>>        |                                        ~~^
>>        |                                          |
>>        |                                          long int
>>        |                                        %lld
>>
>> Cast block_dev->lba to u64 and set the length specifier to %lld which
>> is ok with or without CONFIG_SYS_64BIT_LBA flag.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
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
