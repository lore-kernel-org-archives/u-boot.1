Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F54AE7B5E0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9088724B;
	Wed,  4 Oct 2023 11:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qihyskj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5811687253; Wed,  4 Oct 2023 11:35:58 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744EC8723B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3946Hg7f022073; Wed, 4 Oct 2023 11:35:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=tMd90J5lWn1A/sL402gt7bjvWlE0s5YK5lJEb1IZGFI=; b=qi
 hyskj4WxOFY0S3ohoV1UbpYctzYyra2lAWRSBcxXVGw3KgZ9BZj/RgIiTFjW9sB0
 3XGNMZlfNP3++r5wM/+rzRQ7FpnuxWhmP+HQ8+drZk66HgXC4Wh+1eKqtwYvqjHS
 naHdHkqETazFAtQZa1uc3z0vHb7+AkaIT6hQzNiJJi9zL4/ACJJOqzzgnRRdqv3O
 wGooSVuJKwqsiLCRdxEbJkUSdvWxaCwsoYavBHhLdcSCQxW0ez0C3z1aqJSuAdyM
 pAs46v3r68NoYvtA74eraqAK59q10bMotZL9jpmT7AlnNZVa+dpKUrS+GXtvtos0
 dLxAqzMaT5ZpacwTrrUw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3teajd07wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:35:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F735100053;
 Wed,  4 Oct 2023 11:35:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4617222AFEE;
 Wed,  4 Oct 2023 11:35:47 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:35:46 +0200
Message-ID: <33a6d293-d91d-ee7d-5c3d-b82bbbc27edb@foss.st.com>
Date: Wed, 4 Oct 2023 11:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] ARM: stm32: Rename update_sf to dh_update_sd_to_sf on
 STM32MP15xx DHCOR
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231002155234.138630-1-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231002155234.138630-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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



On 10/2/23 17:52, Marek Vasut wrote:
> Align the script name with DH i.MX8MP DHCOM script name. Add
> backward compatibility script to avoid breaking user scripts.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  include/configs/stm32mp15_dh_dhsom.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
> index 91921690624..c7ebf5cd180 100644
> --- a/include/configs/stm32mp15_dh_dhsom.h
> +++ b/include/configs/stm32mp15_dh_dhsom.h
> @@ -20,7 +20,7 @@
>  
>  #define STM32MP_BOARD_EXTRA_ENV \
>  	"usb_pgood_delay=1000\0" \
> -	"update_sf=" /* Erase SPI NOR and install U-Boot from SD */	\
> +	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
>  		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
>  		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
>  		"env set filesize1 ${filesize} && "			\
> @@ -29,7 +29,9 @@
>  		"sf update ${loadaddr1} 0 ${filesize1} && "		\
>  		"sf update ${loadaddr1} 0x40000 ${filesize1} && "	\
>  		"sf update ${loadaddr} 0x80000 ${filesize} && "		\
> -		"env set filesize1 && env set loadaddr1\0"
> +		"env set filesize1 && env set loadaddr1\0"		\
> +	"update_sf=run dh_update_sd_to_sf\0"
> +
>  
>  #include <configs/stm32mp15_common.h>
>  

Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
