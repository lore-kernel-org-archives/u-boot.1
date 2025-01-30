Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147D3C0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3D081F69;
	Thu, 30 Jan 2025 14:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WJnKYCx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77ED7820A0; Thu, 30 Jan 2025 14:04:43 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4753280E9A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCevak016263;
 Thu, 30 Jan 2025 14:04:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 O2ibzUAgZz1/oJIrHD3Iq0kfKaNskhpf25ggHlGmaO4=; b=WJnKYCx0fUEPO5Oz
 btkUd0ipKAGyv9I/S2ibL+1ZZj4g6UsrPWrTT/n5K0O75qDIeJOEsivQSAtdzBGg
 ubdb4QyUmYs39tRvY9SMAIfjrYhPfM+AgOuNT2ClBUvGTiHzQDfyPw2+kXKtRU0J
 gpMBcV50ERul8OJHoByu32NIQ9fprbtMkaQlu6GANzjIs9VCNB2ASLgU8XkyP8p3
 BGqFC9l6ZF89VXm/Iq95Korgp5x39JRcNgjP2TAsYDHC9GhgEyho8pRqQWGHdyQ2
 co+biqVztmOvZ7cV69rcT0o+V6A6Gd8ZVn3ZMGOHUmxMiv/HPI6ruAl5ro4tTnIy
 xm8zhA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g6v6h2e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 14:04:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C47C44002D;
 Thu, 30 Jan 2025 14:03:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E9F82D7F40;
 Thu, 30 Jan 2025 13:57:30 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:57:30 +0100
Message-ID: <28bf891c-8b01-4d3e-8812-1e2e8ad49f3a@foss.st.com>
Date: Thu, 30 Jan 2025 13:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] usb: dwc3-generic: Reorder include
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Caleb
 Connolly <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250123144718.1139824-4-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
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

On 1/23/25 15:47, Patrice Chotard wrote:
> Reorder include following rules available here :
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>
> Remove useless include files.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
>    - Update comment by adding "Remove useless include files"
>
> Changes in v2:
>    - remove useless include files
>
>   drivers/usb/dwc3/dwc3-generic.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..bc7d2d4234b 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -7,29 +7,17 @@
>    * Based on dwc3-omap.c.
>    */
>   
> -#include <cpu_func.h>
> -#include <log.h>
>   #include <dm.h>
> -#include <dm/device-internal.h>
> +#include <reset.h>
> +#include <asm/gpio.h>
>   #include <dm/lists.h>
> -#include <dwc3-uboot.h>
> -#include <generic-phy.h>
> -#include <linux/bitops.h>
>   #include <linux/delay.h>
> -#include <linux/printk.h>
> -#include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
> -#include <malloc.h>
>   #include <power/regulator.h>
> -#include <usb.h>
> -#include "core.h"
> -#include "gadget.h"
> -#include <reset.h>
> -#include <clk.h>
>   #include <usb/xhci.h>
> -#include <asm/gpio.h>
> -
> +#include "core.h"
>   #include "dwc3-generic.h"
> +#include "gadget.h"
>   
>   struct dwc3_generic_plat {
>   	fdt_addr_t base;




Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

