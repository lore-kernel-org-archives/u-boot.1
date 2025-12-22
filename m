Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CBEE6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AAB83BF1;
	Mon, 22 Dec 2025 12:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W0+tDsRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FA483BF1; Mon, 22 Dec 2025 12:37:53 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB5983C28
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dZbjS5xXJz9tZ9;
 Mon, 22 Dec 2025 12:37:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766403468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIpEpVvfvKOi+D9auoW8Z1JjeBEp4lKqxCW4z/4b0Ng=;
 b=W0+tDsRmqw1gh7QyoUQCBfFZv97OXQfKc+9eC2W3J//fEVnrXnrmeaNCTGLc51DC52z6dF
 Rq6X9BMRBBmhvjQFbYa5pi4m/rLF6SQKlL5quA9Dl+fum3cjwrBOLgRLjsXlHXT1Mp3F68
 +MIFq2hdZLXYalawe146HXYNwwQeXVgbBx0pl8vpZyWjMTgOEZRC5ZC7P0tWlOTCVM6d/9
 zgOJzXHnzD9I10P0aoZxKySmiUrCrfB27+3nfVxNF2gZ8lyMDDQL5d9v7qeTB92j+D/t1f
 Kl3aH9Xr2QKXgdeOC1W8R9nGEX7M5Q7Ejt+a3AAxT0ad7pVB7TD1MXXKLgtPew==
Message-ID: <36fd598f-2543-4ebb-a079-e8de4148cbbd@mailbox.org>
Date: Mon, 22 Dec 2025 12:37:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] mtd: nand: pxa3xx: Pass valid dev to dev_err()
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
 <20251218225936.2016920-2-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251218225936.2016920-2-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f9465b9992aa9cd00e6
X-MBO-RS-META: b75n19fnueqmt48hd8s3smrq319e1btz
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

On 12/18/25 23:59, Chris Packham wrote:
> info->controller.active is not initialised so the dev_err() call ends up
> dereferencing a null pointer causing a crash instead of outputting the
> error. Add a dev member to struct pxa3xx_nand_info and use that instead
> of info->controller.active->mtd.dev.
> 
> Fixes: 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx with a device")
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> Cc: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> 
> Notes:
>      Changes in v2:
>      - Add a dev member to pxa3xx_nand_info so we can keep using dev_err()
> 
>   drivers/mtd/nand/raw/pxa3xx_nand.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
> index 7bf54fa46540..a5293563a9fd 100644
> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> @@ -187,6 +187,7 @@ struct pxa3xx_nand_host {
>   struct pxa3xx_nand_info {
>   	struct nand_hw_control	controller;
>   	struct pxa3xx_nand_platform_data *pdata;
> +	struct udevice *dev;
>   
>   	struct clk		*clk;
>   	void __iomem		*mmio_base;
> @@ -588,8 +589,7 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
>   			ts = get_timer(0);
>   			while (!(nand_readl(info, NDSR) & NDSR_RDDREQ)) {
>   				if (get_timer(ts) > TIMEOUT_DRAIN_FIFO) {
> -					dev_err(info->controller.active->mtd.dev,
> -						"Timeout on RDDREQ while draining the FIFO\n");
> +					dev_err(info->dev, "Timeout on RDDREQ while draining the FIFO\n");
>   					return;
>   				}
>   			}
> @@ -641,8 +641,7 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
>   				   DIV_ROUND_UP(info->step_spare_size, 4));
>   		break;
>   	default:
> -		dev_err(info->controller.active->mtd.dev,
> -			"%s: invalid state %d\n", __func__, info->state);
> +		dev_err(info->dev, "%s: invalid state %d\n", __func__, info->state);
>   		BUG();
>   	}
>   
> @@ -1560,8 +1559,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
>   		ecc->size = 512;
>   
>   	if (ecc_stepsize != 512 || !(nfc_layouts[i].strength)) {
> -		dev_err(info->controller.active->mtd.dev,
> -			"ECC strength %d at page size %d is not supported\n",
> +		dev_err(info->dev, "ECC strength %d at page size %d is not supported\n",
>   			strength, page_size);
>   		return -ENODEV;
>   	}
> @@ -1802,6 +1800,7 @@ static int pxa3xx_nand_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> +	info->dev = dev;
>   	pdata = info->pdata;
>   
>   	ret = alloc_nand_resource(dev, info);

