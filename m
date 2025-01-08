Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D5CE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4A8800D0;
	Wed,  8 Jan 2025 19:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="c5K2jkeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F13800DF; Wed,  8 Jan 2025 19:49:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6005F8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DgFt3000938;
 Wed, 8 Jan 2025 19:49:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 acReBbNlQ3yGsRNCuxvuW1twfFxl/M9bWXohRMty+ns=; b=c5K2jkeN1Pqz4z3z
 jwAtbEPO39Q2WG4FGszspTxxpZdHwhEbgH/dQM+aXFztMOB634AFRDA0Wver39+Z
 TVqA85PW3NyW2DxJmQ41KVl3yPTlVwTR+pyklz/JvQC4TaR/qjTozIFSXtbOdml6
 X05umoCz29jMyO+826S81IEyXKrA6qGU7DpioS5C8RYH1lCBSgQVzsO85HX1LPrV
 yLv4A7xhBsWhlTrOAc3pd03XLi7Hg/4Uw6RQzJR1lY8rTKfeYcsWXejZpBN+l3je
 OHt2WRby4i1s3gexaCHfitHRVFJkXEwyuDVU3YcSAT4i6rLtPikNSMp2BkNTgtdr
 ynZnSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441tfu9885-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:49:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 451F240047;
 Wed,  8 Jan 2025 19:48:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EDB67298E0E;
 Wed,  8 Jan 2025 19:48:01 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:48:01 +0100
Message-ID: <ae469951-f6f2-4be8-99d5-38db13ed85bc@foss.st.com>
Date: Wed, 8 Jan 2025 19:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] fastboot: Fix warning when CONFIG_SYS_64BIT_LBA is
 enable
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129122711.411917-2-patrice.chotard@foss.st.com>
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
> If CONFIG_SYS_64BIT_LBA is enable, following compilation warning is
> triggered:
>
>   CC      drivers/fastboot/fb_mmc.o
> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_erase_mmc_hwpart':
> ../drivers/fastboot/fb_mmc.c:215:35: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'long long unsigned int' [-Wformat=]
>    215 |         printf("........ erased %lu bytes from mmc hwpart[%u]\n",
>        |                                 ~~^
>        |                                   |
>        |                                   long unsigned int
>        |                                 %llu
>    216 |                dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
>        |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                              |
>        |                              long long unsigned int
> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_boot_ops':
> ../drivers/fastboot/fb_mmc.c:261:42: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'long long unsigned int' [-Wformat=]
>    261 |                 printf("........ wrote %lu bytes to EMMC_BOOT%d\n",
>        |                                        ~~^
>        |                                          |
>        |                                          long unsigned int
>        |                                        %llu
>    262 |                        blkcnt * blksz, hwpart);
>        |                        ~~~~~~~~~~~~~~
>        |                               |
>        |                               long long unsigned int
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   drivers/fastboot/fb_mmc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

