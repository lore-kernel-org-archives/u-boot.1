Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D73CC3600C
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 08:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6080381F4D;
	Mon, 24 Mar 2025 09:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742805492;
	bh=KhVo67wOUL+ExdHhcw2WZa11clmQmZmwL4MTo4iwIEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9SComD0jekJrScPDN4nJjsZrDIp2163QpxD1dMTd/wFR0DYJlUJOWN+A9zj0fxO1
	 92a1j3UiECZC01dXqAplJ0lR3HkPeqjeyOJWb2HpIacpJh/eSG1ZUjC4f5F80IKDs/
	 FY5NncpZmwF+fVtx86PG9gXudngUPaYL4Lh1CSSKS2ZC4xlwIsmiXpmJp9CKvHMem8
	 TGMk4Dyy6rwWEj95Ry0SYZ7lydNRxo2baxc+OOSThQ0GdDW/jerGZDn8/1dfFplYRW
	 oT4JGFy4vAL2XYErQ6s7KuSmIBlLL01Ci1GBBwXnlwsvCRhZ9yNZm1M7P10SfOIPGl
	 GOJt12XUje8Cw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE18981F6B; Mon, 24 Mar 2025 09:38:10 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A3481F28
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZLmf63XwTz9t1R;
 Mon, 24 Mar 2025 09:38:06 +0100 (CET)
Message-ID: <db53fe94-669e-49d0-a1b5-5a77a280ab9a@denx.de>
Date: Mon, 24 Mar 2025 09:38:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 19/34] watchdog: sunxi: add A523 support
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-20-andre.przywara@arm.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250323113544.7933-20-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 23.03.25 12:35, Andre Przywara wrote:
> The Allwinner A523 SoC moved the watchdog into a separate MMIO frame,
> and also shifted the registers a bit: the control, config, and mode
> register are located four bytes earlier.
> 
> Add the new compatible string, and connect it to the new struct
> describing the new register layout.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/sunxi_wdt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 8eeac935760..467db5fe9bf 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -153,10 +153,21 @@ static const struct sunxi_wdt_reg sun20i_wdt_reg = {
>   	.wdt_key_val		= 0x16aa0000,
>   };
>   
> +static const struct sunxi_wdt_reg sun55i_wdt_reg = {
> +	.wdt_ctrl		= 0x0c,
> +	.wdt_cfg		= 0x10,
> +	.wdt_mode		= 0x14,
> +	.wdt_timeout_shift	= 4,
> +	.wdt_reset_mask		= 0x03,
> +	.wdt_reset_val		= 0x01,
> +	.wdt_key_val		= 0x16aa0000,
> +};
> +
>   static const struct udevice_id sunxi_wdt_ids[] = {
>   	{ .compatible = "allwinner,sun4i-a10-wdt", .data = (ulong)&sun4i_wdt_reg },
>   	{ .compatible = "allwinner,sun6i-a31-wdt", .data = (ulong)&sun6i_wdt_reg },
>   	{ .compatible = "allwinner,sun20i-d1-wdt", .data = (ulong)&sun20i_wdt_reg },
> +	{ .compatible = "allwinner,sun55i-a523-wdt", .data = (ulong)&sun55i_wdt_reg },
>   	{ /* sentinel */ }
>   };
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

