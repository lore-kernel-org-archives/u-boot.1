Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79692C46CA2
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 11:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6CA87B72;
	Fri, 15 Dec 2023 12:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kbw55/Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6CF87B6C; Fri, 15 Dec 2023 12:53:23 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0D787A8C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713fbabb1=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9WxgJ016099; Fri, 15 Dec 2023 12:53:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=QLqK4YgDGBqX7A29+HOxX5p3YJL5BTFLCWZfinvIE6s=; b=kb
 w55/UucEHMYPbYAqXV3H3qtmDZlthzJm1rLhdY3zbxYKI3T59Mh1E6L12rI601TU
 czsa3DrjNWuLAc4w1zjOfZhMiv533Wu9ZKBsi9wze3eR4CX4G3L22ZhkcVHDTZA6
 dlG7VWHNRibNQrlM73RJEfk0ZIPXb9eInGgQPGNHdTgJAi4esaccBiDC598i+02I
 04jeHf7YK18hI1Vlih4QFibnPhbY7JPWq1kAxYd4i34rn0TdYeiEMTSkix1p2sYC
 azVdWeKYIDAs00VR2dk0w5o0cCZASZP+y28bff0eDjzMtWvjx5cSD8kjaM7TpDIz
 iXWx8n0+l5UenpQfB4rQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uw42ny9um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 12:53:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2786100052;
 Fri, 15 Dec 2023 12:53:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A458215BE7;
 Fri, 15 Dec 2023 12:53:19 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 12:53:19 +0100
Message-ID: <7137cd11-03ee-4a3c-8ff6-4e5c9268981d@foss.st.com>
Date: Fri, 15 Dec 2023 12:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: st: common: simplify MTD device parsing
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
 <20231117170107.1147598-2-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231117170107.1147598-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_06,2023-12-14_01,2023-05-22_02
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

On 11/17/23 18:01, Patrice Chotard wrote:
> Simplify the way all MTD devices are parsed.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   board/st/common/stm32mp_dfu.c | 19 ++-----------------
>   1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
> index ded3bf81961..77edb86e78c 100644
> --- a/board/st/common/stm32mp_dfu.c
> +++ b/board/st/common/stm32mp_dfu.c
> @@ -123,24 +123,9 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		/* probe all MTD devices */
>   		mtd_probe_devices();
>   
> -		/* probe SPI flash device on a bus */
> -		if (!uclass_get_device(UCLASS_SPI_FLASH, 0, &dev)) {
> -			mtd = get_mtd_device_nm("nor0");
> -			if (!IS_ERR_OR_NULL(mtd))
> +		mtd_for_each_device(mtd)
> +			if (!mtd_is_partition(mtd))
>   				board_get_alt_info_mtd(mtd, buf);
> -
> -			mtd = get_mtd_device_nm("nor1");
> -			if (!IS_ERR_OR_NULL(mtd))
> -				board_get_alt_info_mtd(mtd, buf);
> -		}
> -
> -		mtd = get_mtd_device_nm("nand0");
> -		if (!IS_ERR_OR_NULL(mtd))
> -			board_get_alt_info_mtd(mtd, buf);
> -
> -		mtd = get_mtd_device_nm("spi-nand0");
> -		if (!IS_ERR_OR_NULL(mtd))
> -			board_get_alt_info_mtd(mtd, buf);
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DFU_VIRT)) {



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

