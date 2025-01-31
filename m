Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE48C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EBF80F95;
	Fri, 31 Jan 2025 08:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="T1kU3bjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3163080F88; Fri, 31 Jan 2025 08:59:49 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AB280F5F
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7pCuk006643;
 Fri, 31 Jan 2025 08:59:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 jmHqe/u/fURXqvPgUarxrI6iVLGQh5qQO1RK31RQ/gs=; b=T1kU3bjOaRCcTa7t
 pWh7pmYEocGtewKsG3Rs882hLstOSMi1DtyQ53VyF/1A3B5HeTExZaJNYCU46rP5
 kcpYHZZqWDnQfRy0h5bmB/J2xbXI3cwqRWgPLb0F3aZ6s72alNPdcgdTHsexhtVb
 06GjnIS6h9YJEuEtJdB4O6F+D0bewnZW5qMSPE4JIuZvv5nJeF3HEYh2vLvOQ9zt
 mlX2xzSy5gBE8JjkGLdykx+vfms5cuJdAK9GA6f1gy2WQj0Xw+VmTqLkaJQpfBNc
 AxPf+6LOSdvELMoCFPSy0bI5uiUhbn/wqgQqx5wC9bcxAhEUtKXu6n5OA3SPGIxt
 TrmaKQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7ghss6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 08:59:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 17F6A40053;
 Fri, 31 Jan 2025 08:58:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BADC4272A13;
 Fri, 31 Jan 2025 08:56:31 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 08:56:31 +0100
Message-ID: <9ca8b081-81d6-4f4f-b525-8b0cfb2e8502@foss.st.com>
Date: Fri, 31 Jan 2025 08:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] fastboot: Fix warning when CONFIG_SYS_64BIT_LBA is
 enable
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-2-patrice.chotard@foss.st.com>
 <ae469951-f6f2-4be8-99d5-38db13ed85bc@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ae469951-f6f2-4be8-99d5-38db13ed85bc@foss.st.com>
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
>> If CONFIG_SYS_64BIT_LBA is enable, following compilation warning is
>> triggered:
>>
>>   CC      drivers/fastboot/fb_mmc.o
>> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_erase_mmc_hwpart':
>> ../drivers/fastboot/fb_mmc.c:215:35: warning: format '%lu' expects
>> argument of type 'long unsigned int', but argument 2 has type
>> 'long long unsigned int' [-Wformat=]
>>    215 |         printf("........ erased %lu bytes from mmc hwpart[%u]\n",
>>        |                                 ~~^
>>        |                                   |
>>        |                                   long unsigned int
>>        |                                 %llu
>>    216 |                dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
>>        |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>        |                              |
>>        |                              long long unsigned int
>> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_boot_ops':
>> ../drivers/fastboot/fb_mmc.c:261:42: warning: format '%lu' expects
>> argument of type 'long unsigned int', but argument 2 has type
>> 'long long unsigned int' [-Wformat=]
>>    261 |                 printf("........ wrote %lu bytes to EMMC_BOOT%d\n",
>>        |                                        ~~^
>>        |                                          |
>>        |                                          long unsigned int
>>        |                                        %llu
>>    262 |                        blkcnt * blksz, hwpart);
>>        |                        ~~~~~~~~~~~~~~
>>        |                               |
>>        |                               long long unsigned int
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/fastboot/fb_mmc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
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
