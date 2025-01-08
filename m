Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01E2E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3F6800DF;
	Wed,  8 Jan 2025 19:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dB+FLTfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A7C800D0; Wed,  8 Jan 2025 19:50:54 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E717F805E2
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DgAWk000874;
 Wed, 8 Jan 2025 19:50:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ZhlGca6Yvl3R84I8E9x6/Xxv4P7ls6USfZgESrB5nJs=; b=dB+FLTfLywzLteqI
 TsnxWa6sJs1oDvYC6WCjyBmncPyyQ27bn2mW7jOUDUBVz5QkKN7KfG/b7Y97mLIJ
 DBSA2+anAAdycZ6VgFLMdTuRSFT3vlAiVJr4nO87RbHjBWmJdtXTy1Fy3+d/5Yr2
 gFyx6UeQlNRQovgehFHAnrLq1K61QDGQiFVijTblEyjZEZqf2ZrAoRFQtYX7wQiG
 y5jT/PO7Z1pvlSWsR1PIE9lxxPQUmxqYcL+h5Ek8xh7yK6WepsStUBx4VltyC7AJ
 m2bZyIs0NQf2A9YIpn8JxqMjlmlCmM08HoDqT3KdsITy5kCOrMVxCMvoMdeYbgmQ
 PBfetw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441tfu98by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:50:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 16D134004A;
 Wed,  8 Jan 2025 19:49:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59E552A0B1E;
 Wed,  8 Jan 2025 19:49:27 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:49:26 +0100
Message-ID: <e77fc839-c13a-4c66-89d0-3d4de158b3db@foss.st.com>
Date: Wed, 8 Jan 2025 19:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] configs: stm32mp13: enable CONFIG_SYS_64BIT_LBA
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129122711.411917-5-patrice.chotard@foss.st.com>
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
> In arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c, in init_device(),
> in case of RAW_IMAGE, part->size = block_dev->lba * block_dev->blksz.
>
>    _ part->size is declared as u64.
>    _ block_dev->lba is declared as lbaint_t which is uint64_t
>      if CONFIG_SYS_64BIT_LBA is enable, otherwise ulong.
>    _ block_dev->blksz is declared as unsigned long.
>
> For example, in case block_dev->lba = 0x1dacc00, block_dev->blksz = 0x200
> then part->size 0x5980000 which is incorrect as both are declared as ulong.
>
> To fix this overflow issue, enable CONFIG_SYS_64BIT_LBA, block_dev->lba is
> then declared as uint64_t and part->size get the correct value 0x3b5980000.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32mp13_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 7f705808089..e4c92e851e1 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SYS_MMC_ENV_DEV=-1
>   CONFIG_ENV_MMC_USE_DT=y
>   CONFIG_BUTTON=y
>   CONFIG_BUTTON_GPIO=y
> +CONFIG_SYS_64BIT_LBA=y
>   CONFIG_CLK_SCMI=y
>   CONFIG_SET_DFU_ALT_INFO=y
>   CONFIG_USB_FUNCTION_FASTBOOT=y

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

