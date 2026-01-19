Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04475CCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8196383015;
	Mon, 19 Jan 2026 12:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2168389A; Mon, 19 Jan 2026 12:12:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2E259800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25091517;
 Mon, 19 Jan 2026 03:12:34 -0800 (PST)
Received: from [10.57.8.47] (unknown [10.57.8.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241F93F740;
 Mon, 19 Jan 2026 03:12:36 -0800 (PST)
Message-ID: <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
Date: Mon, 19 Jan 2026 11:12:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from
 integer without a cast
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
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-3-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251028091256.600992-3-richard.genoud@bootlin.com>
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

On 28/10/2025 09:12, Richard Genoud wrote:
> Fix pointer from interget warning when compiling for ARM64
> 
> When compiling for arm64, we get this error:
> error: passing argument 2 of ‘__memcpy_fromio’ makes pointer from
> 			integer without a cast [-Wint-conversion]
> 
> Moreover the copy should be made with dedicated readl(), like for any
> register access on this peripheral, since they are 32bit wide.
> 
> So, instead of memcpy_fromio(), just use a readl() loop.
> Introduce nand_readlcpy() to implement this loop.
> 
> Fixes: 6ddbb1e936c7 ("spl: nand: sunxi: use PIO instead of DMA")
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 4f1e2d9a5775..a15f54573df2 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -251,6 +251,17 @@ static int nand_change_column(u16 column)
>   
>   static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
>   
> +static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
> +{
> +	if (len & 0x3)
> +		printf("length should be multiple of 4 (32bits access), data will be incomplete.\n");

This should not be a message printed on the console. There is only 
one(?) internal user, and the argument is a multiple of 512, if I see 
that correctly. So it's an internal error that wouldn't happen at all in 
the moment. It just blows up the code size, and isn't even very descriptive.

If you *really* want to check that, you could try to use something like 
builtin_constant_p, to create a compile-time error, or maybe use 
debug(). But I would suggest to drop it completely, as it would be 
pointless with the current code anyway.

The rest looks fine, thanks for adding that function.

Cheers,
Andre

> +	len >>= 2;
> +
> +	while (len--)
> +		*dest++ = readl(src++);
> +}
> +
>   static int nand_read_page(const struct nfc_config *conf, u32 offs,
>   			  void *dest, int len)
>   {
> @@ -310,7 +321,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
>   			return 1;
>   
>   		/* Retrieve the data from SRAM */
> -		memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
> +		nand_readlcpy((u32 *)data,
> +			      (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
>   			      conf->ecc_size);
>   
>   		/* Stop the ECC engine */

