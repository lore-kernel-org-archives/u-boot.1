Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A5BCCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD0183BBE;
	Thu,  6 Nov 2025 17:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="IeoNqyiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA08983BCE; Thu,  6 Nov 2025 17:27:49 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBCF83B9B
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1F3EC14850C0; Thu,  6 Nov 2025 17:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762446466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=7dPFrV5y5ROzq8UnTJPYjGinSVcT09mngObd4R4MaZ0=;
 b=IeoNqyiZdJ2dshbAuLTY/YRPouJs3PCgvDsZo4HpMfVjnfR87S4EscEZK5iLh571mRK2KZ
 tpUYlSsjM5gt4b4Tjpg7BymNNvro7hXYICFX3SMLaTT/9RQ2QnqWnI9rxMjcrKcC1VWzEq
 UGdZ8J7DN7vTR8GYZZ/2S5PTbrG/ottlWgziY5SLfOeQNj6hc9nXsSwmVKMReYPsLWt2lC
 ysIKcSJWYhXUtSRxFUD0gmtlMClZSZY2nHgUwBtVgJFeaeEZFZnjQsy7SMlxfPlPV21TZS
 BO5YhhN9QNE0PGuB1pCTOj+2ewc70Kuk+tYIihU3qKANDvXCHgLyo2AzzSQwpA==
Date: Thu, 6 Nov 2025 17:27:40 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: atmel: Remove timing from atmel_pmecc
 struct
Message-ID: <20251106-saffron-backboned-8fef05ffca87@thorsis.com>
Mail-Followup-To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
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

this is a nice coincident, I'm currently working on sam9x60 u-boot
support anyways. ^^

Am Thu, Nov 06, 2025 at 12:12:02PM +0100 schrieb Zixun LI:
> "timing" is unused in atmel_pmecc struct, also it's not exist in Linux
> driver, let's remove it.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 2 --
>  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..8fc5614cc0091d3e0f4b9280beee9e684fe2a57d 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -839,8 +839,6 @@ atmel_pmecc_create(struct udevice *dev,
>  	ofnode_read_resource(dev->node_, 1, &res);
>  	pmecc->regs.errloc = (void *)res.start;
>  
> -	pmecc->regs.timing = 0;
> -
>  	/* pmecc data setup time */
>  	if (caps->clk_ctrl)
>  		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
> index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.h
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
> @@ -65,7 +65,6 @@ struct atmel_pmecc {
>  	struct {
>  		void __iomem *base;
>  		void __iomem *errloc;
> -		void __iomem *timing;

Acked-by: Alexander Dahl <ada@thorsis.com>

Tested both patches on a sam9x60-curiosity rev 4 board.

Note: the NAND flash is terribly slow without the following additional
patch, I reported this before, someone at Microchip confirmed and
wanted to investigate, never got an answer, you might find the
discussion in the mailing list archive:

diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
index 9144387861e..3dd2309be10 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
+++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
@@ -56,6 +56,12 @@
         bootph-all;
 };
 
+&nand_controller {
+        nand@3 {
+                /delete-property/ rb-gpios;
+        };
+};
+
 &pinctrl {
         bootph-all;
 };

Want to give your patches another try on a sam9x60 custom board with a
different NAND flash. I'm confident it will work, already does on
Linux.  Will report tomorrow.

Greets
Alex

>  	} regs;
>  
>  	/* Mutex used for pmecc enable/disable */
> 
> -- 
> 2.51.0
> 
