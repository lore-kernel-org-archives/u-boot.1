Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14093C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 21:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABE28307F;
	Sun, 20 Jul 2025 23:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tabH5tOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F1C83093; Sun, 20 Jul 2025 23:27:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70AF8304F
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 23:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4blc7B5Tgsz9smk;
 Sun, 20 Jul 2025 23:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753046838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvjg2KCzmoC8H+b73ivrxufRqdruQaqoUtwlmRwmi0g=;
 b=tabH5tOxAWRPTHed0eifiOZX9wj7ZgSjPPIHWRHGyc90YQf0r23NTKBMnuqOxrjdgjcN0k
 ASxVtCX31/eqvDGI3/d9wO0txoUe8TBVFsgMz7TjXv025q5gsoeGgsBGPfvjxHNDtM3FLF
 a4+t+BJKc4gMoUbJ/fnWkZgcoQ4r4qNyKAi9B1ScIUn1JzbNxMjx8RpQ1TFaITESd1JS8Q
 z+1Q/yeVS75CUxyT17gXgte5q29KLHYBbpD2DpRNiHusqbITlhyYUdxBhuIvceFKF9N644
 IqWjsXcEpNF76AfhhSr3A7PeYMlCmqtlJTxLg3+X0xfqLydvzvVA4yjE/lCxTw==
Message-ID: <a0643292-b5df-4148-a0cb-d3dc9ac1a65d@mailbox.org>
Date: Sun, 20 Jul 2025 21:45:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] RZ/A1 Genmai SDRAM setup prototype
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
References: <175221930820.13074.8101998451225642919.sendpatchset@bjoern-magnuss-macbook-pro.local>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175221930820.13074.8101998451225642919.sendpatchset@bjoern-magnuss-macbook-pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ccd030a64dbaeff6bda
X-MBO-RS-META: 5k35dird1gxn6zgj4dtwfdj4wzufizzx
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

On 7/11/25 9:35 AM, Magnus Damm wrote:

Hello Magnus,

sorry for the late reply.

> Here's a hack that adds SDRAM setup code to the r7s72100 Genmai board.
> 
> Might be useful in case someone wants to boot Linux on the Genmai board.
> 
> Before merge a few unclear points remain:
>   - How to make best use of the on-chip SDRAM?
>     The U-Boot DTS currently has a node for the 10 MiB at 0x20000000
>     Also used by CONFIG_CUSTOM_SYS_INIT_SP_ADDR in renesas_rza1.config

Can we use SRAM for U-Boot and (optional) SDRAM for Linux ?

[...]

> --- 0001/board/renesas/genmai/genmai.c
> +++ work/board/renesas/genmai/genmai.c	2025-07-11 16:11:32.621707802 +0900
> @@ -12,6 +12,16 @@
>   #define CS0WCR		(RZA1_BCR_BASE + 0x28)
>   #define CS1BCR		(RZA1_BCR_BASE + 0x08)
>   #define CS1WCR		(RZA1_BCR_BASE + 0x2c)
> +#define CS2BCR		(RZA1_BCR_BASE + 0x0c)
> +#define CS2WCR		(RZA1_BCR_BASE + 0x30)
> +#define CS3BCR		(RZA1_BCR_BASE + 0x10)
> +#define CS3WCR		(RZA1_BCR_BASE + 0x34)
> +#define SDCR		(RZA1_BCR_BASE + 0x4c)
> +#define RTCOR		(RZA1_BCR_BASE + 0x58)
> +#define RTCSR		(RZA1_BCR_BASE + 0x50)
> +
> +#define SDRAM_MODE_CS2 0x3FFFD040 /* CS2: CAS=2, burst write, 16bit bus */
> +#define SDRAM_MODE_CS3 0x3FFFE040 /* CS3: CAS=2, burst write, 16bit bus */

It would be good to convert this to 'memory' driver instead, see e.g.:

6d47598629f6 ("memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller 
driver")

Hacking more of this memory mapping into board files does not scale well.

>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -27,23 +37,101 @@ int board_init(void)
>   	return 0;
>   }
>   
> -/*
> - * The Genmai DT will most likely contain memory nodes describing the external
> - * SDRAM memory connected to CS2 and CS3, however we do not yet have any code
> - * in U-Boot to setup the memory controller. For now ignore DT and make use of
> - * the RZ/A1H on-chip memory which is 10 MiB at CFG_SYS_SDRAM_BASE.
> - */
> +// nicked from pinctrl-rza1.c

Can this be configured using pinctrl-rza1.c , maybe once the 'memory' 
driver which would configure the chipselects is in place ?

[...]

The external memory (DRAM) could even be brought up using drivers/ram/ 
driver ?
