Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9AC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A5483759;
	Tue, 27 May 2025 15:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="PNDfkEDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0690E837B0; Tue, 27 May 2025 15:12:04 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DCE830B6
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R90A32003182;
 Tue, 27 May 2025 15:11:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 l7JeLx0pXA/s4xm15VJLvW2CIHDSzseNQeO6GrxSlOg=; b=PNDfkEDGXntbVOb8
 RWpeX3fNaPda2VR20Au0CW+UhxbDJQg28yjY9xmgOEfae0MjO8QcS8ApsCwry3YB
 3Hv2yDd4NL37Kzj8Rep8AskjoTKqKM7nT9D0lZKNjACUF96GzlYPw7BHHvfZEhyV
 jttL17hAd0VhLOkqFgkkINnJLWy5ilDtqPdnwjm5pafS2f4WlEFrowV0sCkKr7CV
 uzwYNsCzMhU1J2wgM2FpAKu0JqYpHhUBc75fVVuI4jhPwgYmceD8CZVDZpPGtNsU
 gE3cw33VU7Q7ZXUhw4hjf7WGRizcdG8jaU02FeNPbLxksDKQ0OcRH5HotTIhkpbe
 ieum0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u5f246rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:11:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DBFB740051;
 Tue, 27 May 2025 15:11:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AEA7AE2CBD;
 Tue, 27 May 2025 15:11:04 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:11:04 +0200
Message-ID: <96be1ad0-865b-4611-a957-cba38c766fbe@foss.st.com>
Date: Tue, 27 May 2025 15:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] board: st: add STM32H747 discovery board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-6-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-6-johannes@krotti42.com>
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
> The code was copied from the STM32H743 discovery board and
> modified for the STM32H747 discovery board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  board/st/stm32h747-disco/Kconfig           | 15 ++++++++
>  board/st/stm32h747-disco/MAINTAINERS       |  8 ++++
>  board/st/stm32h747-disco/Makefile          | 10 +++++
>  board/st/stm32h747-disco/stm32h747-disco.c | 43 ++++++++++++++++++++++
>  4 files changed, 76 insertions(+)
>  create mode 100644 board/st/stm32h747-disco/Kconfig
>  create mode 100644 board/st/stm32h747-disco/MAINTAINERS
>  create mode 100644 board/st/stm32h747-disco/Makefile
>  create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
> 
> diff --git a/board/st/stm32h747-disco/Kconfig b/board/st/stm32h747-disco/Kconfig
> new file mode 100644
> index 00000000000..a7b2c09a327
> --- /dev/null
> +++ b/board/st/stm32h747-disco/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_STM32H747_DISCO
> +
> +config SYS_BOARD
> +	default "stm32h747-disco"
> +
> +config SYS_VENDOR
> +	default "st"
> +
> +config SYS_SOC
> +	default "stm32h7"
> +
> +config SYS_CONFIG_NAME
> +	default "stm32h747-disco"
> +
> +endif
> diff --git a/board/st/stm32h747-disco/MAINTAINERS b/board/st/stm32h747-disco/MAINTAINERS
> new file mode 100644
> index 00000000000..afca1b913ce
> --- /dev/null
> +++ b/board/st/stm32h747-disco/MAINTAINERS
> @@ -0,0 +1,8 @@
> +STM32H747 DISCOVERY BOARD
> +M:	Patrice Chotard <patrice.chotard@foss.st.com>

Add your name please.

> +S:	Maintained
> +F:	doc/board/st/
> +F:	board/st/stm32h747-disco
> +F:	include/configs/stm32h747-disco.h
> +F:	configs/stm32h747-disco_defconfig
> +F:	arch/arm/dts/stm32h7*
> diff --git a/board/st/stm32h747-disco/Makefile b/board/st/stm32h747-disco/Makefile
> new file mode 100644
> index 00000000000..b0ba62fa3b7
> --- /dev/null
> +++ b/board/st/stm32h747-disco/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copied from board/st/stm32h743-disco/Makefile:
> +#
> +# Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> +# Author(s): Patrice CHOTARD, <patrice.chotard@foss.st.com> for STMicroelectronics.

Remove or update the copyright and authors with your own.

> +#
> +# Modified for the STM32H747-DISCO: Author: Johannes Krottmayer <johannes@krotti42.com>
> +
> +obj-y	:= stm32h747-disco.o
> diff --git a/board/st/stm32h747-disco/stm32h747-disco.c b/board/st/stm32h747-disco/stm32h747-disco.c
> new file mode 100644
> index 00000000000..538174391d6
> --- /dev/null
> +++ b/board/st/stm32h747-disco/stm32h747-disco.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copied from board/st/stm32h743-disco/stm32h743-disco.c:
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.

Same remark as above

> + */
> +
> +#include <dm.h>
> +#include <init.h>
> +#include <log.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +	if (ret) {
> +		debug("DRAM init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (fdtdec_setup_mem_size_base() != 0)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	fdtdec_setup_memory_banksize();
> +
> +	return 0;
> +}
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
