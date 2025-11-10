Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FCCCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E7B83A56;
	Mon, 10 Nov 2025 16:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="CG3rjwdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A67083A57; Mon, 10 Nov 2025 16:26:02 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AD483A03
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 60DC9148009E; Mon, 10 Nov 2025 16:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762788359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=YG/a8guvzwc3Bf7DqJC18q82Rs4C947uVnRygb8Gdmc=;
 b=CG3rjwdyp3F4FK6nDk5i+of786gXvSSagN16IaHHjTVFX8G7UpulOaFy+1GfD9PEXrNDcC
 /MepRYgymjXNEJUgPob43G5pH4vQYKjGEFflpsYQlF8T/AS5tMg/g8eme3sBQ7uCF4n2rq
 O6jS8S2QVlm/LcZtAE07bd03ICYnUlou2SL2WwkddOqwWEurCfWyENgICbdLKBskM9obij
 vmwH+F8Wkwww2zCjuXM352xUrae55kBXaVpnFiDQbQNR5LHVIhUCN6a1JfWQU+5nogIaqT
 YTJIygri/IzLFOoBLwJOZOSRnswoR1EiikZhCucMbX1ECS2Ri28Ay/+YOPFb5A==
Date: Mon, 10 Nov 2025 16:25:56 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH v2 2/2] mtd: rawnand: atmel: atmel_pmecc_create: Remove
 unused code
Message-ID: <20251110-crouch-motor-2a2bdfbd6486@thorsis.com>
Mail-Followup-To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
 <20251107-pmecc-v2-2-271e6aea3231@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-pmecc-v2-2-271e6aea3231@hifiphile.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Fri, Nov 07, 2025 at 04:02:24PM +0100 schrieb Zixun LI:
> "timing" and "timing_res_idx" are unused and not exist in Linux driver,
> let's remove them.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 7 ++-----
>  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..1acaa5d0e0783f11be8236ad12b42540ca530a5b 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -820,8 +820,7 @@ EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
>  static struct atmel_pmecc *
>  atmel_pmecc_create(struct udevice *dev,
>  		   const struct atmel_pmecc_caps *caps,
> -		   int pmecc_res_idx, int errloc_res_idx,
> -		   int timing_res_idx)
> +		   int pmecc_res_idx, int errloc_res_idx)
>  {
>  	struct atmel_pmecc *pmecc;
>  	struct resource res;
> @@ -839,8 +838,6 @@ atmel_pmecc_create(struct udevice *dev,
>  	ofnode_read_resource(dev->node_, 1, &res);
>  	pmecc->regs.errloc = (void *)res.start;
>  
> -	pmecc->regs.timing = 0;
> -
>  	/* pmecc data setup time */
>  	if (caps->clk_ctrl)
>  		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> @@ -952,7 +949,7 @@ static int atmel_pmecc_probe(struct udevice *dev)
>  		return -EINVAL;
>  	}
>  
> -	pmecc = atmel_pmecc_create(dev, caps, 0, 1, 2);
> +	pmecc = atmel_pmecc_create(dev, caps, 0, 1);
>  	if (IS_ERR(pmecc))
>  		return PTR_ERR(pmecc);
>  
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
> index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.h
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
> @@ -65,7 +65,6 @@ struct atmel_pmecc {
>  	struct {
>  		void __iomem *base;
>  		void __iomem *errloc;
> -		void __iomem *timing;
>  	} regs;
>  
>  	/* Mutex used for pmecc enable/disable */

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

