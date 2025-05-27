Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB43C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C566382FD6;
	Tue, 27 May 2025 15:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HB0ivkar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7A5830A0; Tue, 27 May 2025 15:01:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BB982A25
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCGuuO003391;
 Tue, 27 May 2025 15:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 QFCBRRnb6aHugLSp+iT6MR8Q87eGQl4hfnpBUgsanAU=; b=HB0ivkarszseyL+c
 f2e0hQ8PONmcWrubsErCSwuyXbvzxCmqWm/uTxS9J6TKWUwsrvpCz0AC6/LqOVv3
 TeABiI+4KbgfPvdsj6iXdE8yF+6Xyo6Df6kVaqkZoVg4ELWtyx8yfuK3HdiBxINv
 paxyWg6zpl+AQWFDiy8j984SYK/rxdpZhqkHabZgQ0XjbBo4wRwvMOIgev4gdnTc
 c1qn86jiS/Nrpt+GfFsz04Yo04cF0KjQaYnUBcXU6TVlJX6CqR8T3k2Sqjfh0kBg
 OOkB5pWdnLVg2XB+t/RZK7UZnmHfH4oB0JnOtAf1CWgDkg9o4F7LttAhldtYQ1Yf
 IrDdCA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u5f245a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:01:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BEE874006A;
 Tue, 27 May 2025 15:00:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 75DA8AD0024;
 Tue, 27 May 2025 14:59:58 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 14:59:58 +0200
Message-ID: <f7c0c3ca-dd2b-4af6-a4c9-e03aaa6ca208@foss.st.com>
Date: Tue, 27 May 2025 14:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] arm: mach-stm32: stm32h7: add initial lowlevel
 early function
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-2-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-2-johannes@krotti42.com>
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



On 5/8/25 23:23, Johannes Krottmayer wrote:
> Add new assembly function 'arch_very_early_init'
> 
> This functions setups the power supply for STM32H7 SoC's to
> direct SMPS mode, which is required for some boards like
> the STM32H747I-DISCO in the default configuration.
> 
> If this isn't done in an early stage it cause a deadlock and
> also the SoC is running in a limited mode according to the
> TRM from the SoC.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/mach-stm32/stm32h7/lowlevel.S | 45 ++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 arch/arm/mach-stm32/stm32h7/lowlevel.S
> 
> diff --git a/arch/arm/mach-stm32/stm32h7/lowlevel.S b/arch/arm/mach-stm32/stm32h7/lowlevel.S
> new file mode 100644
> index 00000000000..97f4e383e3b
> --- /dev/null
> +++ b/arch/arm/mach-stm32/stm32h7/lowlevel.S
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025, Johannes Krottmayer <johannes@krotti42.com>
> + */
> +
> +#include <linux/linkage.h>
> +
> +/*
> + * STM32H7 PWR registers
> + */
> +#define PWR_CR3			0x5802480C
> +#define PWR_CR3_LDOEN		1
> +
> +#define PWR_CSR1			0x58024804
> +#define PWR_CSR1_ACTVOSRDY	13
> +
> +ENTRY(arch_very_early_init)
> +	/*
> +	 * Setup power supply for STM32H7 to direct SMPS mode.
> +	 * This is the default configuration from some boards
> +	 * like the SMT32H747i-DISCO.
> +	 *
> +	 * If these steps will not be done, this cause a deadlock.
> +	 */
> +	ldr r6, =PWR_CR3
> +	/* Disable LDO */
> +	movs r0, #1
> +	lsl r1, r0, #PWR_CR3_LDOEN
> +	mvn r2, r1
> +	ldr r3, [r6]
> +	and r3, r2
> +	str r3, [r6]
> +	lsl r1, r0, #PWR_CSR1_ACTVOSRDY
> +
> +	/* Loop until ACTVOSRDY is valid */
> +1:
> +	ldr r6, =PWR_CSR1
> +	ldr r3, [r6]
> +	and r3, r1
> +	cmp r3, r1
> +	bne 1b
> +
> +	/* Jump back to C runtime setup */
> +	bx lr
> +ENDPROC(arch_very_early_init)

Hi Johannes

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
