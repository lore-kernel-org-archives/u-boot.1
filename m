Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE6CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EB283F6C;
	Tue, 11 Nov 2025 13:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Ypbke4x9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484C083F72; Tue, 11 Nov 2025 13:17:12 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AF283A91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E065E14800B1; Tue, 11 Nov 2025 13:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762863429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Xek+8GDZ+cm8YQbuwqQ2PJKcxwSYIiCimMgxxPgZ1ZY=;
 b=Ypbke4x9hfx2cJoaemmw1jvDQS20otzUm6ER8IKNLrad3Hdxxf2136EcMMk36ZjXczB+oB
 JvMqCGTjMHTChU8pt75t8nfHVmaIKxy3LB/1Hf1Oq9nEKhQ9IeGyFo0Nz6z+EFldaPgLI6
 XjijXXPYrqGMBl+idRLxtryt7MiuKvGYl8AeHPLTn2xuxdBAprp/K4dGs1Aud92wG6Cw3g
 jlbYzrpajbCqCFZI3TuR3yZdYFXEwDYk8Wj3NaqIVQYPYYw3KRW1RL3hIUP2jfQXPsVXKQ
 m4rAJBHUlwzoiFk9N4azDYBmD2zS0ZTs9uX/gnklExVyaT5IECAniSR8DAMU2Q==
Date: Tue, 11 Nov 2025 13:17:07 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: atmel: set pmecc data setup time
Message-ID: <20251111-extortion-spotting-4744fb581f6f@thorsis.com>
Mail-Followup-To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
 <20251107-pmecc-v2-1-271e6aea3231@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107-pmecc-v2-1-271e6aea3231@hifiphile.com>
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

Am Fri, Nov 07, 2025 at 04:02:23PM +0100 schrieb Zixun LI:
> Setup the pmecc data setup time as 3 clock cycles for 133MHz as
> recommended by the datasheet.
> 
> Backported from Linux: f55f552a7c7e0a1 ("mtd: rawnand: atmel: set pmecc
> data setup time")
> 
> Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

One nit I forgot, for next time: please avoid empty lines between the
trailers.

Greets
Alex

> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
>  	int nstrengths;
>  	int el_offset;
>  	bool correct_erased_chunks;
> +	bool clk_ctrl;
>  };
>  
>  struct atmel_pmecc_user_conf_cache {
> @@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
>  
>  	pmecc->regs.timing = 0;
>  
> +	/* pmecc data setup time */
> +	if (caps->clk_ctrl)
> +		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> +
>  	/* Disable all interrupts before registering the PMECC handler. */
>  	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
>  	atmel_pmecc_reset(pmecc);
> @@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
>  	.strengths = atmel_pmecc_strengths,
>  	.nstrengths = 5,
>  	.el_offset = 0x8c,
> +	.clk_ctrl = true,
>  };
>  
>  static struct atmel_pmecc_caps sama5d4_caps = {
> 
> -- 
> 2.51.0
> 

-- 
Alexander Dahl           Thorsis Technologies GmbH   T +49 391 544 563 1000
Industrieautomation      Oststr. 18                  F +49 391 544 563 9099
T +49 391 544 563 3036   39114 Magdeburg             https://www.thorsis.com/

Sitz der Gesellschaft: Magdeburg
Amtsgericht Stendal HRB 30646
Geschäftsführer: Dipl.-Inf. Michael Huschke
