Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C40BCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8C88391C;
	Mon,  3 Nov 2025 13:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SdQNxJ0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3962A8391B; Mon,  3 Nov 2025 13:38:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F3880050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d0WN25D9Gz9t7f;
 Mon,  3 Nov 2025 13:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762173506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vYeqhjTf/Rki+ScNC75Jz4G3+KXvLagKGiteOyq54k=;
 b=SdQNxJ0RjLixf3o79W9b4/RM7XU+xVEVdgjwrDth0xrH7yT01FrEnUHPyHea+bSbPT74G0
 QJc/ioIabdQgpZ2SONjRsG5NKDJWCn1WXodMcq83sOFK/2fDOA5nH3345vp01CuzCHV5tn
 QDqOILjaNN/Nwd1yJCNmV7H6fxuX9y2K4XkaWhGRrtOcJ1zBfQfQ+KoSHzbz8AG4cH0Smo
 t2ZlxfSY4rx8BJ2VHxVjD+C9IFfTTMQe0yMB+FWpLjLQH3CQI53y6qSgyLeb2I2jGGGQXM
 pw+drGqn8YdZKS5yTFgXhW+dMPe1BfPI4TNR18yBqYyyAsyg/afA9CyDS+usvw==
Message-ID: <fda19051-7b72-4f11-aa8e-b8eb70ff04b7@mailbox.org>
Date: Mon, 3 Nov 2025 13:38:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] spi-nor: add support for XM25QH01D
To: Ssunk <ssunkkan@gmail.com>
Cc: u-boot@lists.denx.de, tudor.ambarus@linaro.org, trini@konsulko.com,
 jagan@amarulasolutions.com, vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
 pratyush@kernel.org
References: <05d93ac3-b79b-4503-8745-7442033b7b2a@mailbox.org>
 <20251103111225.3161-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251103111225.3161-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: is3x5aqpf9mo67hnij4u7irm335e3b19
X-MBO-RS-ID: c975b01cd132421050d
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

On 11/3/25 12:12 PM, Ssunk wrote:
> Add support for the XMC XM25QH01D SPI NOR flash.
> 
> This device has 1Gbit (128MB) capacity, with 64KB sectors and
> supports 4KB erase, dual and quad read modes, and 4-byte opcodes.
> Datasheet link: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf
> 
> Changes in v2:
> - Keep the list sorted of XMC
> 
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 0383175beb5..03596d38e6e 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -595,13 +595,14 @@ const struct flash_info spi_nor_ids[] = {
>   #endif
>   #ifdef CONFIG_SPI_FLASH_XMC
>   	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
> +	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
I'm sorry, my original suggestion was unclear.

If you want to sort the whole XMC part list, then please do 2-patch 
series, sort the list in patch 1/2 and then add the chip in 2/2 .
