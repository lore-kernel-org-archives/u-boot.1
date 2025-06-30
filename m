Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79666C7EE2A
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 06:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EE580B9B;
	Mon, 30 Jun 2025 08:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5gA/6GtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E3A81E13; Mon, 30 Jun 2025 08:19:49 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC61800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9276cc0828=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U1QaWn007824;
 Mon, 30 Jun 2025 08:19:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 z78TZXXIQuxinNR/tHGylfGf5nNgbBeTiX1xTuY2PtY=; b=5gA/6GtMXooKaJ1O
 3f1IW9/6evofCGxxmjr2312g2DzfbNr60CTvWkSyWCzLgUoCMf4MB5bCyKM8a9XB
 S8vXY7d1KAKd0x3BsUOhDkI+4rH3Cd6C++hf4a+XoKW0i/l9llctUe0kLOuiECdX
 vCYNvfYVPWuIxSkRt0BIS75hddY5bF8DLm2fCn32m+PFmupNVZG7kKjxT6lkd/00
 KNcWq5FfbT99Jet8oa4USx+PRAyfo0CHQD5l7fElYn2JFOzfdRlIpFwI7fN/7WBX
 cfb0tEB0yfR/w1VGoHRngoLHjwV+KrO7E08Af/0BHj9+WVbfzsmyI4tdUdctIiSr
 a/aNcg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jsy4kdb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 08:19:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D543640046;
 Mon, 30 Jun 2025 08:18:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E86264997D;
 Mon, 30 Jun 2025 08:17:51 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 08:17:50 +0200
Message-ID: <8341a0eb-4182-4c40-9f0a-26b92941c18e@foss.st.com>
Date: Mon, 30 Jun 2025 08:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reset: stm32: Fix header misuse
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250630000926.952277-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250630000926.952277-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
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



On 6/30/25 02:09, Marek Vasut wrote:
> The stm32-reset-core.h is located in drivers/reset/stm32/ , it has to
> be included using "stm32-reset-core.h" and not <stm32-reset-core.h> ,
> otherwise the build fails. Fix it.
> 
> Fixes: 0994a627c278 ("reset: stm32mp25: add stm32mp25 reset driver")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  MAINTAINERS                            | 1 -
>  drivers/reset/stm32/stm32-reset-core.c | 2 +-
>  drivers/reset/stm32/stm32-reset-mp1.c  | 2 +-
>  drivers/reset/stm32/stm32-reset-mp25.c | 2 +-
>  drivers/reset/stm32/stm32-reset.c      | 2 +-
>  5 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92119667618..da16816e51c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -730,7 +730,6 @@ F:	include/dt-bindings/clock/stm32fx-clock.h
>  F:	include/dt-bindings/clock/stm32mp*
>  F:	include/dt-bindings/pinctrl/stm32-pinfunc.h
>  F:	include/dt-bindings/reset/stm32mp*
> -F:	include/stm32-reset-core.h
>  F:	include/stm32_rcc.h
>  F:	tools/logos/st.bmp
>  F:	tools/stm32image.c
> diff --git a/drivers/reset/stm32/stm32-reset-core.c b/drivers/reset/stm32/stm32-reset-core.c
> index 7dd92e07e1a..9eeed6536e0 100644
> --- a/drivers/reset/stm32/stm32-reset-core.c
> +++ b/drivers/reset/stm32/stm32-reset-core.c
> @@ -6,7 +6,7 @@
>  
>  #include <dm.h>
>  #include <reset-uclass.h>
> -#include <stm32-reset-core.h>
> +#include "stm32-reset-core.h"
>  #include <stm32_rcc.h>
>  #include <dm/device_compat.h>
>  #include <linux/iopoll.h>
> diff --git a/drivers/reset/stm32/stm32-reset-mp1.c b/drivers/reset/stm32/stm32-reset-mp1.c
> index 6863f6e64b7..ce4532561e5 100644
> --- a/drivers/reset/stm32/stm32-reset-mp1.c
> +++ b/drivers/reset/stm32/stm32-reset-mp1.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <dm.h>
> -#include <stm32-reset-core.h>
> +#include "stm32-reset-core.h"
>  
>  /* Reset clear offset for STM32MP RCC */
>  #define RCC_CLR_OFFSET			0x4
> diff --git a/drivers/reset/stm32/stm32-reset-mp25.c b/drivers/reset/stm32/stm32-reset-mp25.c
> index 91c0336bc58..1cbe5c7f3d5 100644
> --- a/drivers/reset/stm32/stm32-reset-mp25.c
> +++ b/drivers/reset/stm32/stm32-reset-mp25.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <dm.h>
> -#include <stm32-reset-core.h>
> +#include "stm32-reset-core.h"
>  #include <stm32mp25_rcc.h>
>  #include <dt-bindings/reset/st,stm32mp25-rcc.h>
>  
> diff --git a/drivers/reset/stm32/stm32-reset.c b/drivers/reset/stm32/stm32-reset.c
> index 975f67f712a..918e81e588f 100644
> --- a/drivers/reset/stm32/stm32-reset.c
> +++ b/drivers/reset/stm32/stm32-reset.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <dm.h>
> -#include <stm32-reset-core.h>
> +#include "stm32-reset-core.h"
>  
>  /* Timeout for deassert */
>  #define STM32_DEASSERT_TIMEOUT_US	10000

Which version of gcc do you use ? on my side i got no issue with arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
But nevertheless :

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

