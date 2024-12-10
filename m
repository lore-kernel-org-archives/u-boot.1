Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337C8E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261F28027E;
	Tue, 10 Dec 2024 17:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="R5plHman";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAAA80285; Tue, 10 Dec 2024 17:59:53 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59FB80196
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2074364ab7=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADIIB9030060;
 Tue, 10 Dec 2024 17:59:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 U7w6RTw92Tfb2+nKsXNCmOkJQDAAvbbARox8EL4e1gM=; b=R5plHman0vI3gRN3
 9MITxeBtadZ7YyC3Ey6mQMTZN1D+/lFVDMWuPLoI6vFSBwvcXSN6GsxivPGa7B+S
 bRhJ5x+hqyjm9vAlF5DVs/dtsA2PgoGDK49q9fypGWJ5cdUek1kLx6duvwthsB0y
 76uAUY4IJ1h/g+tcswk1tu/MxKopCw5gWETZWZqBT5DXzbWbqSWVP3tWW4zohGF0
 +CDbZHBM1XzN74xOlfzeMqBNy84hkMTcgF2jgSEOKV1J//9mfbX1R1qMr5ILTZoT
 7An9Vl/ADpZOGrJT9EuEDf+pfhequWazFg0uNoC7ylHA1nUQcNJ91dLjYrpF+fyp
 ylIDhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43d26nb5u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 17:59:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A71B640044;
 Tue, 10 Dec 2024 17:58:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0F21270F05;
 Tue, 10 Dec 2024 17:57:46 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 17:57:46 +0100
Message-ID: <7a6b321e-fe47-4e05-8c67-0fda19c6e614@foss.st.com>
Date: Tue, 10 Dec 2024 17:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/25] st: stm32f429: Drop old LED code
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-9-sjg@chromium.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241103003322.626036-9-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
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



On 11/3/24 01:33, Simon Glass wrote:
> This predates the LED framework, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  board/st/stm32f429-discovery/Makefile |  1 -
>  board/st/stm32f429-discovery/led.c    | 39 ---------------------------
>  2 files changed, 40 deletions(-)
>  delete mode 100644 board/st/stm32f429-discovery/led.c
> 
> diff --git a/board/st/stm32f429-discovery/Makefile b/board/st/stm32f429-discovery/Makefile
> index 6b02c0fddec..233eafdad3d 100644
> --- a/board/st/stm32f429-discovery/Makefile
> +++ b/board/st/stm32f429-discovery/Makefile
> @@ -7,4 +7,3 @@
>  # Kamil Lulko, <kamil.lulko@gmail.com>
>  
>  obj-y	:= stm32f429-discovery.o
> -obj-y	+= led.o
> diff --git a/board/st/stm32f429-discovery/led.c b/board/st/stm32f429-discovery/led.c
> deleted file mode 100644
> index 4b8038341b9..00000000000
> --- a/board/st/stm32f429-discovery/led.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2015
> - * Kamil Lulko, <kamil.lulko@gmail.com>
> - */
> -
> -#include <status_led.h>
> -#include <asm-generic/gpio.h>
> -
> -#define RED_LED			110
> -#define GREEN_LED		109
> -
> -void coloured_LED_init(void)
> -{
> -	gpio_request(RED_LED, "red led");
> -	gpio_direction_output(RED_LED, 0);
> -	gpio_request(GREEN_LED, "green led");
> -	gpio_direction_output(GREEN_LED, 0);
> -}
> -
> -void red_led_off(void)
> -{
> -	gpio_set_value(RED_LED, 0);
> -}
> -
> -void green_led_off(void)
> -{
> -	gpio_set_value(GREEN_LED, 0);
> -}
> -
> -void red_led_on(void)
> -{
> -	gpio_set_value(RED_LED, 1);
> -}
> -
> -void green_led_on(void)
> -{
> -	gpio_set_value(GREEN_LED, 1);
> -}

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
