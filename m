Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC371C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5C5837F5;
	Tue, 27 May 2025 15:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="sURhqFmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886E1837FC; Tue, 27 May 2025 15:14:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049B9830B6
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RC70EG008575;
 Tue, 27 May 2025 15:14:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 vX04oCtlZ5msCLNWXBvJLNO+844R7934z6v/izDjR4I=; b=sURhqFmxHSEWCc9E
 s2DrCvBMYh5KahMZw7Q/Vn0B60hX2DQiVpGOTgWfItRm+Vtu759QZLDrdroEbO5h
 GFz8m8OEnOaWrWbaNhXO/YdZj75CkEoUWQni7hcbXv2XmY/3FudTS0pUH67W4CiT
 gl/Np6ams9Bk/xYbRNxuBZzrLZGDiGv/rvRd4JzDthlrJkftHC2a9n73vixSocIW
 9IcLsymfTDOUMgAdBJZFUix/tXQUTYCtCF5sCU364viBI1TtCoI2qXp2aRr74DP1
 fi+aZfkuwNe8i4lNyYa0scC15ZjU3k5LAjiMS4j1RFulOyDc0c9V3M/z7j1swcWP
 +pIKxQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u50gkvv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:14:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 591684004F;
 Tue, 27 May 2025 15:14:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E31A2AE5AD2;
 Tue, 27 May 2025 15:13:57 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:13:57 +0200
Message-ID: <f57075e7-e3fc-4bf6-8182-1aebefccfc08@foss.st.com>
Date: Tue, 27 May 2025 15:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] include: configs: add STM32H747 discovery board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-8-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-8-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:24, Johannes Krottmayer wrote:
> Add initial support for the STM32H747 discovery board. The
> header is copied and modified from the STM32H743 discovery
> board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  include/configs/stm32h747-disco.h | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 include/configs/stm32h747-disco.h
> 
> diff --git a/include/configs/stm32h747-disco.h b/include/configs/stm32h747-disco.h
> new file mode 100644
> index 00000000000..582c0289137
> --- /dev/null
> +++ b/include/configs/stm32h747-disco.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copied from include/configs/stm32h743-disco.h:
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.

Remove STMicroelectronics Copyright and my name as i am not the author of this file.

> + *
> + * Modified for the STM32H747-DISCO: Author: Johannes Krottmayer <johannes@krotti42.com>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <config.h>
> +#include <linux/sizes.h>
> +
> +/* For booting Linux, use the first 16MB of memory */
> +#define CFG_SYS_BOOTMAPSZ		SZ_16M
> +
> +#define CFG_SYS_FLASH_BASE		0x08000000
> +
> +#define CFG_SYS_HZ_CLOCK		1000000
> +
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(MMC, mmc, 0)
> +
> +#include <config_distro_bootcmd.h>
> +#define CFG_EXTRA_ENV_SETTINGS				\
> +			"kernel_addr_r=0xD0008000\0"		\
> +			"fdtfile=stm32h747i-disco.dtb\0"	\
> +			"fdt_addr_r=0xD0408000\0"		\
> +			"scriptaddr=0xD0418000\0"		\
> +			"pxefile_addr_r=0xD0428000\0" \
> +			"ramdisk_addr_r=0xD0438000\0"		\
> +			BOOTENV
> +
> +#endif /* __CONFIG_H */


