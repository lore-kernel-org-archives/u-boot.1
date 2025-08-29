Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF754CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 23:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4100783622;
	Sat, 30 Aug 2025 01:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M6avW/KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2790D83642; Sat, 30 Aug 2025 01:58:20 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35158835EA
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 01:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cDFZt2CLQz9tmC;
 Sat, 30 Aug 2025 01:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756511894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SmnCoCE1Stq8prjaM5bmJWnW/m7RUg7evZsqGoOCjY=;
 b=M6avW/KKwFNrevpdyZQJVB/n5BVyKlK+sLi+fQqU5atLarQWc3dXk0uPFRdQx1S6tEgoxv
 /d8DE+gcwi2HEmeJZrop2xNB4ceW3tO8WcSLguu6dXKuUVG/pv7+JYXlD9Fop3xMJV/J5u
 8s429pbpqaiFI7ntA36T8kSRJI7sY59aRz9SjPIdcTzOZRZOU9ZHySjbn7XGOtoppvC534
 eNQ5FcSTEhIZj182N2RRcLFY4VkZSO1lrHdU5rkPx9kJSSpIf0delA/pDpQljSwqGeEOaH
 3/uvctW71f++FTd8zJLe0ow0OrFuumdjXIkf7pJaMY2w5EXp36FTy3xM+zwKjA==
Message-ID: <59b3e8d4-3a00-4ddd-a23c-332ab7ec15ae@mailbox.org>
Date: Sat, 30 Aug 2025 01:58:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 75abb656b5675ec5ed5
X-MBO-RS-META: 9wmxxxrc4qxhgubu3sy7tzdidqpm33sg
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

On 8/28/25 3:51 PM, Naresh Kumar Ravulapalli wrote:
> Fix the incorrect bit masking and bit shift used to compute EMAC
> control which in turn is used to select EMAC clock from EMAC
> source A or B.
> 
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
> ---
>   drivers/clk/altera/clk-agilex.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
> index e1ddd02f356..2ad8cfd8856 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -1,6 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Copyright (C) 2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>    */
>   
>   #include <log.h>
> @@ -11,6 +12,7 @@
>   #include <dm/lists.h>
>   #include <dm/util.h>
>   #include <dt-bindings/clock/agilex-clock.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   
>   #include <asm/arch/clock_manager.h>
> @@ -515,14 +517,11 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
>   	/* Get EMAC clock source */
>   	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>   	if (emac_id == AGILEX_EMAC0_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
> +		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
>   	else if (emac_id == AGILEX_EMAC1_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
> +		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
>   	else if (emac_id == AGILEX_EMAC2_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
> +		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, ctl);
Please do the actual fix separately from FIELD_GET() conversion.
