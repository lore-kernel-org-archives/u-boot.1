Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BCCCD19A
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 09:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD7483710;
	Fri, 17 Oct 2025 11:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A801483804; Fri, 17 Oct 2025 11:36:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B195F83655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 11:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C181595;
 Fri, 17 Oct 2025 02:36:12 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE1A3F66E;
 Fri, 17 Oct 2025 02:36:15 -0700 (PDT)
Message-ID: <98174913-3877-4038-a5f3-064808b29650@arm.com>
Date: Fri, 17 Oct 2025 10:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] mtd: rawnand: sunxi_spl: cosmetic: replace
 AHB_DIV_1 by CCM_NAND_CTRL_M/N
To: Richard Genoud <richard.genoud@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
 <20251016142752.2627710-6-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-6-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 16/10/2025 15:27, Richard Genoud wrote:
> CCM_NAND_CTRL_M/N is defined in clock headers, and it's more readable
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 306c1c0d0989..9f80a8010d7b 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -531,5 +531,6 @@ void nand_deselect(void)
>   #else
>   	clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
>   #endif
> -	clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
> +	clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE |
> +		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));

The change looks alright, but can you please use the opportunity to 
change the CCM access to the new scheme, away from using a struct, and 
towards using #define'd offsets? You have that conditionally in a later 
patch, so please rather move the legacy users over here.
No need to change *every* clock user for the older SoCs, or to remove 
the NAND clocks from the struct, just define the NAND related offsets in 
clock_sun4i.h and clock_sun6i.h, then use the H6/H616 way here for all.

Thanks!
Andre


>   }

