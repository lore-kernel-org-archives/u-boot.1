Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D243CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 07:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C52B83734;
	Fri, 17 Oct 2025 09:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F6A83775; Fri, 17 Oct 2025 09:57:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1636283631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 09:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D27C1596;
 Fri, 17 Oct 2025 00:57:24 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B123F59E;
 Fri, 17 Oct 2025 00:57:27 -0700 (PDT)
Message-ID: <ac8a38f3-bfa7-4124-94f0-139326de5cbb@arm.com>
Date: Fri, 17 Oct 2025 08:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] mtd: rawnand: sunxi_spl: fix pointer from integer
 without a cast
To: Richard Genoud <richard.genoud@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
 <20251016142752.2627710-3-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-3-richard.genoud@bootlin.com>
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

Hi,

On 16/10/2025 15:27, Richard Genoud wrote:
> Fix pointer from interget warning when compiling for ARM64
> 
> When compiling for arm64, we get this error:
> error: passing argument 2 of ‘__memcpy_fromio’ makes pointer from
> 			integer without a cast [-Wint-conversion]
> 
> Fix that with a cast to (void *)(uintptr_t)
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 4f1e2d9a5775..19091ece632b 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -310,7 +310,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
>   			return 1;
>   
>   		/* Retrieve the data from SRAM */
> -		memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
> +		memcpy_fromio(data,
> +			      (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,

I don't think memcpy_fromio() is correct here in the first place. It 
looks tempting to use it, but the implementation is not safe to use with 
Allwinner peripherals: we need to stick to the predefined device 
register access width. Neither the arm nor the arm64 implementation are 
fully compliant. If you go by the book, the peripheral registers are 
32-bit wide, and must only be accessed via a 32-bit wide access 
(readl/writel). Empirically 8-bit accesses to a 32-bit aligned address 
also seem to work, but not to other addresses. Everything else is unsafe 
and should be avoided.
So can you please replace this call with a for-loop of readl() 
invocations? This should be safe with all devices, and since the base 
address is 32-bit aligned, and I assume ecc_size is as well, we are good 
here.

Cheers,
Andre

>   			      conf->ecc_size);
>   
>   		/* Stop the ECC engine */

