Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D76CCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E23783869;
	Sat, 18 Oct 2025 01:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F698386B; Sat, 18 Oct 2025 01:10:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1E992836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0631063;
 Fri, 17 Oct 2025 16:10:14 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2173F66E;
 Fri, 17 Oct 2025 16:10:18 -0700 (PDT)
Message-ID: <f98bb4eb-a4b5-49b0-a51d-53b94217731e@arm.com>
Date: Sat, 18 Oct 2025 00:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] mtd: rawnand: sunxi: cosmetic: add per SoC
 capabilities
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
 <20251016142752.2627710-8-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-8-richard.genoud@bootlin.com>
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
> Introduce per SoC capabilities in sunxi_nand.c
> 
> This prepares for the H616 support that has quite a lot differences in
> registers offset and capabilities.
> 
> Start with the ECC strength table.
> 
> No functional change.

Looks good, just one nit below:

> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/mtd/nand/raw/sunxi_nand.c | 18 ++++++++++++++++--
>   drivers/mtd/nand/raw/sunxi_nand.h | 10 ++++++++++
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 000ebd0439f1..3f30077b3d15 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -149,6 +149,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
>    * @clk_rate:		NAND controller current clock rate
>    * @chips:		a list containing all the NAND chips attached to
>    *			this NAND controller
 > + * @caps: NAND Controller capabilities

Please indent the description to line up with the other ones.

With that fixed:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

>    */
>   struct sunxi_nfc {
>   	struct nand_hw_control controller;
> @@ -159,6 +160,7 @@ struct sunxi_nfc {
>   	unsigned long assigned_cs;
>   	unsigned long clk_rate;
>   	struct list_head chips;
> +	const struct sunxi_nfc_caps *caps;
>   };
>   
>   static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_hw_control *ctrl)
> @@ -1270,6 +1272,9 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
>   					      struct nand_ecc_ctrl *ecc)
>   {
>   	static const u8 strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
> +	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
>   	struct sunxi_nand_hw_ecc *data;
>   	struct nand_ecclayout *layout;
>   	int nsectors;
> @@ -1292,7 +1297,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
>   	}
>   
>   	/* Add ECC info retrieval from DT */
> -	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
> +	for (i = 0; i < nfc->caps->nstrengths; i++) {
>   		if (ecc->strength <= strengths[i]) {
>   			/*
>   			 * Update ecc->strength value with the actual strength
> @@ -1303,7 +1308,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
>   		}
>   	}
>   
> -	if (i >= ARRAY_SIZE(strengths)) {
> +	if (i >= nfc->caps->nstrengths) {
>   		dev_err(mtd->dev, "unsupported strength\n");
>   		ret = -ENOTSUPP;
>   		goto err;
> @@ -1681,6 +1686,10 @@ static int sunxi_nand_probe(struct udevice *dev)
>   	if (!nfc->regs)
>   		return -EINVAL;
>   
> +	nfc->caps = (const struct sunxi_nfc_caps *)dev_get_driver_data(dev);
> +	if (!nfc->caps)
> +		return -EINVAL;
> +
>   	ret = reset_get_bulk(dev, &rst_bulk);
>   	if (!ret)
>   		reset_deassert_bulk(&rst_bulk);
> @@ -1702,9 +1711,14 @@ static int sunxi_nand_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
> +	.nstrengths = 9,
> +};
> +
>   static const struct udevice_id sunxi_nand_ids[] = {
>   	{
>   		.compatible = "allwinner,sun4i-a10-nand",
> +		.data = (unsigned long)&sunxi_nfc_a10_caps,
>   	},
>   	{ }
>   };
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 59803ccc9f22..80fbc8df0090 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -153,4 +153,14 @@
>   
>   #define NFC_MAX_CS		7
>   
> +/*
> + * NAND Controller capabilities structure: stores NAND controller capabilities
> + * for distinction between compatible strings.
> + *
> + * @nstrengths:		Number of element of ECC strengths array
> + */
> +struct sunxi_nfc_caps {
> +	unsigned int nstrengths;
> +};
> +
>   #endif

