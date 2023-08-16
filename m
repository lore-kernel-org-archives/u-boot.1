Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA45C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E5D869F2;
	Wed, 16 Aug 2023 15:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="R5nNJsKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DC286A01; Wed, 16 Aug 2023 15:38:49 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044E5869F2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6592a39e51=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37GDEm7S002221; Wed, 16 Aug 2023 15:38:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=GnAUrQc5kL49IFwOnXv9fKKvaeYFfDw39MdhvomWLlg=; b=R5
 nNJsKgd9YoqUdffuM2LDL5kNZVfMZLbwj9U7nhULeSSs2gmEri4w1l05hxx2Gs1B
 RCH66XvisQFukx5J7gX3YZGLkuGgmaQRCInExCao62X5OJClr79FruhZM/cLNCqd
 LZQvaZS/O0ecyw04KvA2PkEfvr+ZQSNHCXMzw2UvUpfdd4PBfe492RKwVNXO0DGb
 MEQ73zTm3XqDBG9aCmTwZfJ3tTH+zeKCjMdthkofzM66KMbKcEncpLtEaYS36QUy
 KiLEFIHmbQtoBq6wHeWC+KIt7OwsyNTFQwtvRRJNPjM5wfUvt4T0gcsb6r6wl3Yb
 Z4n1LXHXavGmlqg7yj8A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgth621ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 15:38:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C4D810005D;
 Wed, 16 Aug 2023 15:38:46 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25120245516;
 Wed, 16 Aug 2023 15:38:46 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 15:38:45 +0200
Message-ID: <555aa903-74bc-855e-ebd0-7a6f5c9683f8@foss.st.com>
Date: Wed, 16 Aug 2023 15:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: stm32: extend TC timeout
Content-Language: en-US
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Valentin Caron
 <valentin.caron@foss.st.com>
References: <20230804140904.176552-1-patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230804140904.176552-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_13,2023-08-15_02,2023-05-22_02
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



On 8/4/23 16:09, Patrice Chotard wrote:
> From: Valentin Caron <valentin.caron@foss.st.com>
> 
> Waiting 150us TC bit couldn't be enough.
> 
> If TFA lets 16 bits in USART fifo, we has to wait 16 times 87 us (time
> of 10 bits (1 byte in most use cases) at a baud rate of 115200).
> 
> Fixes: b4dbc5d65a67 ("serial: stm32: Wait TC bit before performing initialization")
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>  drivers/serial/serial_stm32.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/serial/serial_stm32.c b/drivers/serial/serial_stm32.c
> index 0085113f674..23d476fba28 100644
> --- a/drivers/serial/serial_stm32.c
> +++ b/drivers/serial/serial_stm32.c
> @@ -22,6 +22,14 @@
>  #include "serial_stm32.h"
>  #include <dm/device_compat.h>
>  
> +/*
> + * At 115200 bits/s
> + * 1 bit = 1 / 115200 = 8,68 us
> + * 8 bits = 69,444 us
> + * 10 bits are needed for worst case (8 bits + 1 start + 1 stop) = 86.806 us
> + */
> +#define ONE_BYTE_B115200_US		87
> +
>  static void _stm32_serial_setbrg(fdt_addr_t base,
>  				 struct stm32_uart_info *uart_info,
>  				 u32 clock_rate,
> @@ -209,12 +217,10 @@ static int stm32_serial_probe(struct udevice *dev)
>  	 * before uart initialization, wait for TC bit (Transmission Complete)
>  	 * in case there is still chars from previous bootstage to transmit
>  	 */
> -	ret = read_poll_timeout(readl, isr, isr & USART_ISR_TC, 10, 150,
> -				plat->base + ISR_OFFSET(stm32f4));
> -	if (ret) {
> -		clk_disable(&clk);
> -		return ret;
> -	}
> +	ret = read_poll_timeout(readl, isr, isr & USART_ISR_TC, 50,
> +				16 * ONE_BYTE_B115200_US, plat->base + ISR_OFFSET(stm32f4));
> +	if (ret)
> +		dev_dbg(dev, "FIFO not empty, some character can be lost (%d)\n", ret);
>  
>  	ret = reset_get_by_index(dev, 0, &reset);
>  	if (!ret) {
Applied on stm32-master

