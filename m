Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD7FE7719A
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BB4800DF;
	Wed,  8 Jan 2025 19:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="G3j9d9XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EC48006D; Wed,  8 Jan 2025 19:50:08 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2100B8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508GxA5A007614;
 Wed, 8 Jan 2025 19:50:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 DiZbQuMyGDBE8DtGvk+MlJGbv9FnwUCyOGUzj5PUge4=; b=G3j9d9XEsJfDVU2V
 twIKcZsa2qMfJMvuCNucAOuHyv1zDzTSNa1tWrDnWe7guNX9reddk+zon9+OIMJu
 BNLaz6T5eaygOBocNNc5ltXcEgGOv5Laipp9wPrh+4e+nvN7FuYyGZECSfz/tkR0
 NZvZEvEvNIHgftJAPo9eUQXBlF0XdZxjPKz0ys8UCrsHvMJLNhNmiDH1oneCQ6gx
 IY6zYpNkekCPKxikr6ufY33OxyfFJrvrClWQ43UEGF+iOvulQ5iC9CyrghPT7GUY
 j5H/F9pVJy3gtnKs/dUMXUWlsobBQGGVVgbsA17h/Qe20hKJsfpBGoSsE2ZkIMf+
 2D9MDw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441wc6rbm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:50:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 792CD40048;
 Wed,  8 Jan 2025 19:49:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D80AC29E87C;
 Wed,  8 Jan 2025 19:48:46 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:48:46 +0100
Message-ID: <1cccf0a2-e317-4b00-9624-d2d25c8b4ae4@foss.st.com>
Date: Wed, 8 Jan 2025 19:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] arm: stm32mp: stm32prog: fix warning when
 CONFIG_SYS_64BIT_LBA is enable
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129122711.411917-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi,

On 11/29/24 13:27, Patrice Chotard wrote:
> If CONFIG_SYS_64BIT_LBA flag is enable, following warning is triggered:
>
> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c: In function 'init_device':
> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:27: warning: format
> '%ld' expects argument of type 'long int', but argument 8 has type
> 'lbaint_t' {aka 'long long unsigned int'} [-Wformat=]
>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../include/log.h:157:21: note: in definition of macro 'pr_fmt'
>    157 | #define pr_fmt(fmt) fmt
>        |                     ^~~
> ../include/log.h:182:33: note: in expansion of macro 'log'
>    182 | #define log_debug(_fmt...)      log(LOG_CATEGORY, LOGL_DEBUG, ##_fmt)
>        |                                 ^~~
> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:17: note: in expansion
> of macro 'log_debug'
>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>        |                 ^~~~~~~~~
> ../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:42: note: format string
> is defined here
>    793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
>        |                                        ~~^
>        |                                          |
>        |                                          long int
>        |                                        %lld
>
> Cast block_dev->lba to u64 and set the length specifier to %lld which
> is ok with or without CONFIG_SYS_64BIT_LBA flag.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

