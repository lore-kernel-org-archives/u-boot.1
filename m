Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088EECCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 13:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1978A8307F;
	Sun,  2 Nov 2025 14:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ElzVBdJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3FD83642; Sun,  2 Nov 2025 14:58:10 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA16800B1
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 14:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4czxBP3nPYz9snk;
 Sun,  2 Nov 2025 14:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762091885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14fMnbbG7SVcQtpuhAFgD29uiz80DSVva1gZ+11m9r4=;
 b=ElzVBdJ65JUWwdB6gPrT6YKVyRtNmToe2QgcO7iMzvhTe29owuJ72vheVYuOTfLvwbtdDG
 09s83XrH8bpWcgRgqb3odGcnRqQTRzF1Nyp0c0GATzCdi0Xqaf0Neu1CqGBPd0gc+GIVY1
 cUO/jFguM4nk3DXtE0l77FA7BN21PUwVmK4gNjj/UkaLkQAU6Yfsmr6snF8RWywUlDQmmp
 U3yRus5vkG5xsF+0Z53zVH5YCKJiOSHklLtxhUNk7DlMWQzQW8VDXGnzXUgiVJdRaxsVlS
 rrYaEx8R27fIY34aZF/Jlmmp/ENHua0YYNQaiZbE2CFFehS1xiCwwEocuCqlPw==
Message-ID: <05d93ac3-b79b-4503-8745-7442033b7b2a@mailbox.org>
Date: Sun, 2 Nov 2025 14:58:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] spi-nor: add support for XM25QH01D
To: Ssunk <ssunkkan@gmail.com>, u-boot@lists.denx.de,
 tudor.ambarus@linaro.org, trini@konsulko.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com,
 Takahiro.Kuwano@infineon.com, pratyush@kernel.org
References: <20250827105854.10746-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250827105854.10746-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3k4y7yy6diwx4fc1orwj9pwih5b39191
X-MBO-RS-ID: 6bcf55d2f7e043e7037
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

On 8/27/25 12:58 PM, Ssunk wrote:
> Add support for the XMC XM25QH01D SPI NOR flash.
> 
> This device has 1Gbit (128MB) capacity, with 64KB sectors and
> supports 4KB erase, dual and quad read modes, and 4-byte opcodes.
> Datasheet link: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf
> 
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 0383175beb5..330ab77ee5d 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -603,6 +603,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   #endif
>   #ifdef CONFIG_SPI_FLASH_XTX
>   	/* XTX Technology Limited */

Keep the list sorted please.

+CC Tom, Tudor.
