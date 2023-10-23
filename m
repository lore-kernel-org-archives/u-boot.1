Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9473CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6808787536;
	Mon, 23 Oct 2023 12:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XgD0avxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94008789D; Mon, 23 Oct 2023 12:11:21 +0200 (CEST)
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com
 [115.236.127.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1378087536
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=XgD0avxGmOPaEqmybZDROMxR2No7P+OXwUas/zpvmf/w06vv1aZ+fKnnK5RUTTmgfgiSglP89rLbI2Pccc/hTX8U3ehpWgmvl5IlY9/0PRlfLXGE0B+kLNerYZDvAF7Tehcjot4hZ0dNe1E/3Afp3HRuZGW/P56f+2qwO+lZzTM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=x7M2K54zwmskg2+SaAmYtn32c0ooBX1ihof8DAWoPjA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 135CF40035C;
 Mon, 23 Oct 2023 18:11:07 +0800 (CST)
Message-ID: <5417986b-de72-4369-b83b-d128bfbb744c@rock-chips.com>
Date: Mon, 23 Oct 2023 18:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add support for XMC XM25QU128C
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Ricardo Pardini <ricardo@pardini.net>
References: <20231017214031.1704250-1-jonas@kwiboo.se>
 <20231017214031.1704250-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017214031.1704250-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhMSlYaH0tOQx5KQhgaSUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b5c044c842eb3kusn135cf40035c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6USo*Cjw0FzgKSUoQQh0I
 VhQaCw9VSlVKTUJDS05OQ01DSk9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEJDNwY+
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


On 2023/10/18 05:40, Jonas Karlman wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
>
> Add support for XMC XM25QU128C (128M-bit) Serial Flash memory. Used on
> the Xunlong Orange Pi 3B, 5 and 5 Plus boards.
>
> Datasheet:
> https://www.xmcwh.com/uploads/806/XM25QU128C_Ver2.0.pdf
>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> [jonas@kwiboo.se: update commit message]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 5c35171ffd55..392db5c99e84 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -536,6 +536,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   #endif
>   #ifdef CONFIG_SPI_FLASH_XTX
>   	/* XTX Technology Limited */
