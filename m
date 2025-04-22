Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18E7C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31C680194;
	Tue, 22 Apr 2025 10:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Q3msbC76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939588056A; Tue, 22 Apr 2025 10:33:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E4D800D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7dHtq023461;
 Tue, 22 Apr 2025 10:33:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 OcAejmSOkWnSvqdkMRqZ24+MEKOqVzyMJWX6U4FWu/4=; b=Q3msbC76PXeCzr3W
 HwfhrgwHBtxQrZjlw7bLB5oCfM9whCz6udnnpi1e21ZOl4SC3qGL6rlC1tuK8Smi
 MKBn3/MJ0yVcsm1J51X6ffXAI34PQUDAApKV5LNPjDDLIN8I7K9tX5iMMO0jskKP
 sbgAa1CidwdEgwuuJoAj4JSHmFkh+O5EmYTePzbquporJe0apCo5pdgoPdGd9O2j
 pkuY7vT8dndtGs9vKYCt51hOR/O1rv4j0xyGXaPLEOiy6+zmJXzMuzd8ywiH68DD
 sfwPkBwi3JMpE1E6oUT+a1H7ngFES1iNHkhtlb3Y9CTUw9QNOfbKMVawVMHukKAh
 HHtXjA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464nd3y0u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:33:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3DC0A40057;
 Tue, 22 Apr 2025 10:32:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D03DA9D24E3;
 Tue, 22 Apr 2025 10:32:00 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:32:00 +0200
Message-ID: <a7491caf-a8a1-427d-a4e3-fe70add98218@foss.st.com>
Date: Tue, 22 Apr 2025 10:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ARM: stm32mp: add ETZPC system bus driver for
 STM32MP1
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-10-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-10-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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


On 4/1/25 15:14, Patrice Chotard wrote:
> From: Lionel Debieve <lionel.debieve@foss.st.com>
>
> This driver is checking the access rights of the different
> peripherals connected to the ETZPC bus. If access is denied,
> the associated device is not bound.
>
> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/include/mach/etzpc.h |  32 ++++
>   arch/arm/mach-stm32mp/stm32mp1/Makefile    |   1 +
>   arch/arm/mach-stm32mp/stm32mp1/etzpc.c     | 194 +++++++++++++++++++++
>   3 files changed, 227 insertions(+)
>   create mode 100644 arch/arm/mach-stm32mp/include/mach/etzpc.h
>   create mode 100644 arch/arm/mach-stm32mp/stm32mp1/etzpc.c
>
...
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/etzpc.c b/arch/arm/mach-stm32mp/stm32mp1/etzpc.c
> new file mode 100644
> index 00000000000..b7aefb84069
> --- /dev/null
> +++ b/arch/arm/mach-stm32mp/stm32mp1/etzpc.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
> + */
> +
> +#define LOG_CATEGORY UCLASS_SIMPLE_BUS


minor  => why SIMPLE_BUS here ?


#define LOG_CATEGORY UCLASS_NOP


> +
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/lists.h>
> +#include <linux/bitfield.h>
> +#include <mach/etzpc.h>
> +
...
> +
> +U_BOOT_DRIVER(stm32_etzpc) = {
> +	.name = "stm32_etzpc",
> +	.id = UCLASS_NOP,
> +	.of_match = stm32_etzpc_ids,
> +	.bind = stm32_etzpc_bind,
> +	.plat_auto = sizeof(struct stm32_etzpc_plat),
> +};



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



