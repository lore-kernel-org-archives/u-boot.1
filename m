Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB8C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 06:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2919F8848D;
	Fri, 17 May 2024 08:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cFjN6FbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A5888491; Fri, 17 May 2024 08:06:46 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2563F883BA
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5867d29662=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GM0Jra009990;
 Fri, 17 May 2024 08:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=cUA3BgyXxuLug22O16wdtR1H/LYKUYP0J65QcnZLQrU=; b=cF
 jN6FbEq+Esj31cD7ePWqwv9C89NE6kRCkIr1ysxrydKOgWRFG45g1SCLnXGh6p61
 0mAoQSg7yrHpc1ilGdsvw3QcR9wkuue8MKIHkP+rq8qn4kChvlFL9BFRNocFnU6B
 TmfbDUI1qdLgPV4/LiuEffc0lLrldMkwsu0UMEkg3H+5hoTZnioa6WuwSx/jJr6i
 /jhSeF6WOLn2BSXWvrOfcSpHat29S/rcU8mrtmqzoBXdG33hNzqowWCQUcJtps8d
 k3lnRVVI4MlzOpdnhND003oKUCpvv8HePVwAd99fZV3/8eGAe5KnOTBtuUFdWOlq
 Aup/H6siATDOCQ/lmxwQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxv8gc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 08:06:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6464340044;
 Fri, 17 May 2024 08:06:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 49EED20F540;
 Fri, 17 May 2024 08:06:22 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 08:06:21 +0200
Message-ID: <539b18bd-b241-40b1-ac9f-56a5c1f8bd9b@foss.st.com>
Date: Fri, 17 May 2024 08:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 126/149] board: st: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Kamil Lulko
 <kamil.lulko@gmail.com>, Vikas Manocha <vikas.manocha@st.com>, Dillon Min
 <dillon.minfei@gmail.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-126-trini@konsulko.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240501024316.1767971-126-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
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



On 5/1/24 04:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Kamil Lulko <kamil.lulko@gmail.com>
> Cc: Vikas Manocha <vikas.manocha@st.com>
> Cc: Dillon Min <dillon.minfei@gmail.com>
> ---
>  board/st/common/cmd_stboard.c                        | 1 -
>  board/st/common/stm32mp_dfu.c                        | 1 -
>  board/st/common/stm32mp_dfu_virt.c                   | 1 -
>  board/st/common/stpmic1.c                            | 1 -
>  board/st/common/stusb160x.c                          | 1 -
>  board/st/stih410-b2260/board.c                       | 1 -
>  board/st/stm32f429-discovery/led.c                   | 1 -
>  board/st/stm32f429-discovery/stm32f429-discovery.c   | 1 -
>  board/st/stm32f429-evaluation/stm32f429-evaluation.c | 1 -
>  board/st/stm32f469-discovery/stm32f469-discovery.c   | 1 -
>  board/st/stm32f746-disco/stm32f746-disco.c           | 2 +-
>  board/st/stm32h743-disco/stm32h743-disco.c           | 1 -
>  board/st/stm32h743-eval/stm32h743-eval.c             | 1 -
>  board/st/stm32h750-art-pi/stm32h750-art-pi.c         | 1 -
>  board/st/stm32mp1/spl.c                              | 1 -
>  board/st/stm32mp1/stm32mp1.c                         | 1 -
>  16 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
> index c8c0bad5da16..50da063051b8 100644
> --- a/board/st/common/cmd_stboard.c
> +++ b/board/st/common/cmd_stboard.c
> @@ -30,7 +30,6 @@
>   */
>  
>  #ifndef CONFIG_SPL_BUILD
> -#include <common.h>
>  #include <command.h>
>  #include <console.h>
>  #include <misc.h>
> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
> index 77edb86e78c1..1db8e45480e1 100644
> --- a/board/st/common/stm32mp_dfu.c
> +++ b/board/st/common/stm32mp_dfu.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
>   */
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <dfu.h>
> diff --git a/board/st/common/stm32mp_dfu_virt.c b/board/st/common/stm32mp_dfu_virt.c
> index f0f99605796a..4049d72bf9d5 100644
> --- a/board/st/common/stm32mp_dfu_virt.c
> +++ b/board/st/common/stm32mp_dfu_virt.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
>   */
>  
> -#include <common.h>
>  #include <dfu.h>
>  #include <dm.h>
>  #include <misc.h>
> diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
> index 969ad484864d..45c2bb5bceac 100644
> --- a/board/st/common/stpmic1.c
> +++ b/board/st/common/stpmic1.c
> @@ -5,7 +5,6 @@
>  
>  #define LOG_CATEGORY LOGC_BOARD
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/board/st/common/stusb160x.c b/board/st/common/stusb160x.c
> index f0385e5e3830..e1ad8b00717a 100644
> --- a/board/st/common/stusb160x.c
> +++ b/board/st/common/stusb160x.c
> @@ -8,7 +8,6 @@
>  
>  #define LOG_CATEGORY UCLASS_I2C_GENERIC
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <i2c.h>
>  
> diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
> index 82817571ae3d..a912712c9dd9 100644
> --- a/board/st/stih410-b2260/board.c
> +++ b/board/st/stih410-b2260/board.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <asm/cache.h>
> diff --git a/board/st/stm32f429-discovery/led.c b/board/st/stm32f429-discovery/led.c
> index 8dda6a97bd1c..4b8038341b9e 100644
> --- a/board/st/stm32f429-discovery/led.c
> +++ b/board/st/stm32f429-discovery/led.c
> @@ -4,7 +4,6 @@
>   * Kamil Lulko, <kamil.lulko@gmail.com>
>   */
>  
> -#include <common.h>
>  #include <status_led.h>
>  #include <asm-generic/gpio.h>
>  
> diff --git a/board/st/stm32f429-discovery/stm32f429-discovery.c b/board/st/stm32f429-discovery/stm32f429-discovery.c
> index 55e464cc7cf1..22d751b44d3d 100644
> --- a/board/st/stm32f429-discovery/stm32f429-discovery.c
> +++ b/board/st/stm32f429-discovery/stm32f429-discovery.c
> @@ -10,7 +10,6 @@
>   * Kamil Lulko, <kamil.lulko@gmail.com>
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <init.h>
> diff --git a/board/st/stm32f429-evaluation/stm32f429-evaluation.c b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
> index 25472f041fef..db59ebb838e7 100644
> --- a/board/st/stm32f429-evaluation/stm32f429-evaluation.c
> +++ b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <init.h>
> diff --git a/board/st/stm32f469-discovery/stm32f469-discovery.c b/board/st/stm32f469-discovery/stm32f469-discovery.c
> index 9ed6c1e67680..134d207d95d8 100644
> --- a/board/st/stm32f469-discovery/stm32f469-discovery.c
> +++ b/board/st/stm32f469-discovery/stm32f469-discovery.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice CHOTARD, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <init.h>
> diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
> index 0f9666008430..6d86e4fe7aab 100644
> --- a/board/st/stm32f746-disco/stm32f746-disco.c
> +++ b/board/st/stm32f746-disco/stm32f746-disco.c
> @@ -4,7 +4,7 @@
>   * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/st/stm32h743-disco/stm32h743-disco.c b/board/st/stm32h743-disco/stm32h743-disco.c
> index 4ca5e847212e..35ef9ff9e288 100644
> --- a/board/st/stm32h743-disco/stm32h743-disco.c
> +++ b/board/st/stm32h743-disco/stm32h743-disco.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/st/stm32h743-eval/stm32h743-eval.c b/board/st/stm32h743-eval/stm32h743-eval.c
> index 4ca5e847212e..35ef9ff9e288 100644
> --- a/board/st/stm32h743-eval/stm32h743-eval.c
> +++ b/board/st/stm32h743-eval/stm32h743-eval.c
> @@ -4,7 +4,6 @@
>   * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
> index 0d39ce849a62..75aa4d139fb4 100644
> --- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
> +++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
> @@ -4,7 +4,6 @@
>   * Author(s): Dillon Min <dillon.minfei@gmail.com>
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/st/stm32mp1/spl.c b/board/st/stm32mp1/spl.c
> index 8b4a529f759a..d63dffd97e87 100644
> --- a/board/st/stm32mp1/spl.c
> +++ b/board/st/stm32mp1/spl.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <config.h>
> -#include <common.h>
>  #include <power/pmic.h>
>  #include <power/stpmic1.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
> index db15d78237ea..97532a8156ff 100644
> --- a/board/st/stm32mp1/stm32mp1.c
> +++ b/board/st/stm32mp1/stm32mp1.c
> @@ -5,7 +5,6 @@
>  
>  #define LOG_CATEGORY LOGC_BOARD
>  
> -#include <common.h>
>  #include <adc.h>
>  #include <bootm.h>
>  #include <button.h>

Hi Tom

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
