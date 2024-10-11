Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC5BD0D7BA
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174AB89331;
	Fri, 11 Oct 2024 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kZUumVAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3571289356; Fri, 11 Oct 2024 17:31:39 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A6089319
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCrEgr028633;
 Fri, 11 Oct 2024 17:31:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 9CoLkqNEZuu6mrwH7b6JinaJ50fIMiKU+K+FhVk6Q7o=; b=kZUumVAcifOwMSjl
 mE4XE7f41Jk1I2fhm1xYO3zgBpP9nTgvBB36Q3YKHM+FMc0jIZcBw1kn2Pmxa8H1
 dD7Onz6DuUB6b46WfGSIqmj2gPaPJYuBbYCFYxKPYBjs7mra1aIxsHrqcCeOhPcE
 MwXKH71bWdsdOW+KbwsPt2k21/MJ1R2oTkXPBV9/MlvLMdVaEXLABIDb56VLhR1j
 CO6GElZN1ruk6P0HWBA5iUT92Xsjpx5wYo4DLULP6p+D9Kjed+I4oOGQ59NfibLk
 fd5zmCN8/zhICcc+9RaGrR/ecPCJ2s9M2Zg6BdBdZQdkxZWgGuJJMpe5WjI00N8p
 X7qXaA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4263439sc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:31:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0AA3A40050;
 Fri, 11 Oct 2024 17:30:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0138829886B;
 Fri, 11 Oct 2024 17:30:14 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 17:30:13 +0200
Message-ID: <dc0a0638-0724-46d1-99c7-ee8b84e5541b@foss.st.com>
Date: Fri, 11 Oct 2024 17:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Add script to install U-Boot from SD/eMMC to
 SPI NOR on DH STM32MP15xx DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240930192343.59359-1-marex@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240930192343.59359-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
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

On 9/30/24 21:23, Marek Vasut wrote:
> Make the dh_update_sd_to_sf script generic, rename it to dh_update_sdmmc_to_sf
> and implement two specific dh_update_sd_to_sf and dh_update_emmc_to_sf scripts
> which load U-Boot from either SD or eMMC and install it into SPI NOR.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   include/configs/stm32mp15_dh_dhsom.h | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
> index de39b19219d..fa759c938b3 100644
> --- a/include/configs/stm32mp15_dh_dhsom.h
> +++ b/include/configs/stm32mp15_dh_dhsom.h
> @@ -38,16 +38,26 @@
>   		"setenv loadaddr1 && "					\
>   		"setenv sblkcnt && "					\
>   		"setenv ublkcnt\0"					\
> -	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
> +	"dh_update_sdmmc_to_sf=" /* Erase SPI NOR and install U-Boot from SD/eMMC */ \
>   		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
> -		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
> +		"load ${dh_update_iface} ${dh_update_dev} "		\
> +			"${loadaddr1} /boot/u-boot-spl.stm32 && "	\
>   		"env set filesize1 ${filesize} && "			\
> -		"load mmc 0:4 ${loadaddr} /boot/u-boot.itb && "		\
> +		"load ${dh_update_iface} ${dh_update_dev} "		\
> +			"${loadaddr} /boot/u-boot.itb && "		\
>   		"sf probe && sf erase 0 0x200000 && "			\
>   		"sf update ${loadaddr1} 0 ${filesize1} && "		\
>   		"sf update ${loadaddr1} 0x40000 ${filesize1} && "	\
>   		"sf update ${loadaddr} 0x80000 ${filesize} && "		\
>   		"env set filesize1 && env set loadaddr1\0"		\
> +	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
> +		"setenv dh_update_iface mmc && "			\
> +		"setenv dh_update_dev 0:4 && "				\
> +		"run dh_update_sdmmc_to_sf\0"				\
> +	"dh_update_emmc_to_sf=" /* Erase SPI NOR and install U-Boot from eMMC */ \
> +		"setenv dh_update_iface mmc && "			\
> +		"setenv dh_update_dev 1:4 && "				\
> +		"run dh_update_sdmmc_to_sf\0"				\
>   	"stdin=serial\0"						\
>   	"stdout=serial\0"						\
>   	"stderr=serial\0"						\
>

ok I will merge it as it

with 2 minor question

a)  it is strange to define interface variable for macro
     but use only with "mmc" device with

> setenv dh_update_iface mmc

it can be simplified with

"load mmc ${dh_update_dev}

or it is to prepare other device then "mmc" .....


b) you are using "sf" command and not "mtd" to udpate SPI NOR ?


the MTD command allows to use the MTD partition name, defined in DT,
so no need to know offset in script (and avoid "sf probe")

mtd erase fsbl1; mtd write fsbl1 ${loadaddr1} 0 ${filesize1} \
mtd erase fsbl2; mtd write fsbl2 ${loadaddr1} 0 ${filesize1} \
mtd erase uboot; mtd write uboot ${loadaddr} 0 ${filesize}



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

