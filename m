Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EFDCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D232483885;
	Sat, 18 Oct 2025 01:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4A6838A0; Sat, 18 Oct 2025 01:11:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A95B383804
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9B71063;
 Fri, 17 Oct 2025 16:11:43 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26C13F66E;
 Fri, 17 Oct 2025 16:11:46 -0700 (PDT)
Message-ID: <7faa8c8a-cc41-4108-bee9-ef7e24af94ce@arm.com>
Date: Sat, 18 Oct 2025 00:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] mtd: rawnand: sunxi: cosmetic: add
 has_ecc_block_512 capability
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
 <20251016142752.2627710-12-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-12-richard.genoud@bootlin.com>
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
> Introduce has_ecc_block_512 capability
> 
> The H616 controller can't handle 512 bytes ECC block size.
> Let it be a capability.
> 
> No functional change.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/mtd/nand/raw/sunxi_nand.c | 14 +++++++++++---
>   drivers/mtd/nand/raw/sunxi_nand.h |  2 ++
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 869b3ddd971c..fddb1cada023 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -660,11 +660,12 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
>   	u32 ecc_ctl;
>   
>   	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
> -	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
> -		     NFC_ECC_BLOCK_SIZE_MSK);
> +	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE);
> +	if (nfc->caps->has_ecc_block_512)
> +		ecc_ctl &= ~NFC_ECC_BLOCK_SIZE_MSK;

So if I get this correctly, then NFC_ECC_BLOCK_SIZE_MSK and 
NFC_ECC_BLOCK_512 are referring to the same single bit register field, 
in bit 5? Can we lose the MSK definition then, and clear the field 
unconditionally? Or is it that on the H6/H616 we must never touch bit 5, 
because it refers to something else (NDFC_RANDOM_EN?)?
In any case I think we don't need identical MSK and BLOCK_512 
definitions, do we?

By the way: Do you have any MMIO frame register description for the old 
NAND device? I checked some of the older manuals, but the ones I looked 
at were only showing timing diagrams, but no register map.

Cheers,
Andre

>   	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
>   
> -	if (nand->ecc.size == 512)
> +	if (nand->ecc.size == 512 && nfc->caps->has_ecc_block_512)
>   		ecc_ctl |= NFC_ECC_BLOCK_512;
>   
>   	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
> @@ -1454,6 +1455,8 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
>   static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
>   {
>   	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
> +	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
>   	int ret;
>   
>   	if (!ecc->size) {
> @@ -1464,6 +1467,10 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
>   	if (!ecc->size || !ecc->strength)
>   		return -EINVAL;
>   
> +	/* If 512B ECC is not supported, switch to 1024 */
> +	if (ecc->size == 512 && !nfc->caps->has_ecc_block_512)
> +		ecc->size = 1024;
> +
>   	switch (ecc->mode) {
>   	case NAND_ECC_SOFT_BCH:
>   		break;
> @@ -1715,6 +1722,7 @@ static int sunxi_nand_probe(struct udevice *dev)
>   }
>   
>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
> +	.has_ecc_block_512 = true,
>   	.nstrengths = 9,
>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>   	.reg_user_data = NFC_REG_A10_USER_DATA,
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 35079d37bb1f..be294d7cea0a 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -169,6 +169,7 @@
>    * NAND Controller capabilities structure: stores NAND controller capabilities
>    * for distinction between compatible strings.
>    *
> + * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
>    * @nstrengths:		Number of element of ECC strengths array
>    * @reg_ecc_err_cnt:	ECC error counter register
>    * @reg_user_data:	User data register
> @@ -176,6 +177,7 @@
>    * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
>    */
>   struct sunxi_nfc_caps {
> +	bool has_ecc_block_512;
>   	unsigned int nstrengths;
>   	unsigned int reg_ecc_err_cnt;
>   	unsigned int reg_user_data;

