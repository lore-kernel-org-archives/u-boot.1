Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC26CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BE78383F;
	Sat, 18 Oct 2025 01:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60D783869; Sat, 18 Oct 2025 01:11:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8E0F283804
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D861063;
 Fri, 17 Oct 2025 16:11:17 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8663F66E;
 Fri, 17 Oct 2025 16:11:21 -0700 (PDT)
Message-ID: <16241b87-7589-40ff-9280-cbacf32dc227@arm.com>
Date: Sat, 18 Oct 2025 00:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] mtd: rawnand: sunxi: cosmetic: move ECC_PAT_FOUND
 register in SoC caps
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
 <20251016142752.2627710-11-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-11-richard.genoud@bootlin.com>
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
> Move ECC_PAT_FOUND register in SoC capabilities structure
> 
> This register offset moved in H616, it's now its own register, not
> shared with NFC_ECC_ST.
> Push that specificity in caps structure.

Right, so if I understand correctly, this moves from bits[31:16] of 
ECC_ST to bits[31:0] of a new separate register.
If this is correct, can you add this piece of information to the commit 
message, to motivate the addition of the whole field masking operation?

Assuming that this looks alright to me:

> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


> ---
>   drivers/mtd/nand/raw/sunxi_nand.c |  9 +++++++--
>   drivers/mtd/nand/raw/sunxi_nand.h | 16 +++++++++++++++-
>   2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 64a0db37f3f0..869b3ddd971c 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -699,6 +699,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   	struct nand_ecc_ctrl *ecc = &nand->ecc;
>   	int raw_mode = 0;
>   	u32 status;
> +	u32 pattern_found;
>   	int ret;
>   
>   	if (*cur_off != data_off)
> @@ -724,8 +725,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   
>   	*cur_off = oob_off + ecc->bytes + 4;
>   
> -	status = readl(nfc->regs + NFC_REG_ECC_ST);
> -	if (status & NFC_ECC_PAT_FOUND(0)) {
> +	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
> +	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
> +	if (pattern_found & NFC_ECC_PAT_FOUND(0)) {
>   		u8 pattern = 0xff;
>   
>   		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1)))
> @@ -744,6 +746,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
>   	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4, true, page);
>   
> +	status = readl(nfc->regs + NFC_REG_ECC_ST);
>   	if (status & NFC_ECC_ERR(0)) {
>   		/*
>   		 * Re-read the data with the randomizer disabled to identify
> @@ -1715,6 +1718,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>   	.nstrengths = 9,
>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>   	.reg_user_data = NFC_REG_A10_USER_DATA,
> +	.reg_pat_found = NFC_REG_ECC_ST,
> +	.pat_found_mask = GENMASK(31, 16),
>   };
>   
>   static const struct udevice_id sunxi_nand_ids[] = {
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 1977d1bd8eaf..35079d37bb1f 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -25,6 +25,9 @@
>   
>   #include <linux/bitops.h>
>   
> +/* non compile-time field get */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +
>   #define NFC_REG_CTL		0x0000
>   #define NFC_REG_ST		0x0004
>   #define NFC_REG_INT		0x0008
> @@ -146,7 +149,14 @@
>   
>   /* define bit use in NFC_ECC_ST */
>   #define NFC_ECC_ERR(x)		BIT(x)
> -#define NFC_ECC_PAT_FOUND(x)	BIT((x) + 16)
> +
> +/*
> + * define bit use in NFC_REG_PAT_FOUND
> + * For A10/A23, NFC_REG_PAT_FOUND == NFC_ECC_ST register
> + */
> +#define NFC_ECC_PAT_FOUND(x)	BIT(x)
> +#define NFC_ECC_PAT_FOUND_MSK(nfc) ((nfc)->caps->pat_found_mask)
> +
>   #define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
>   
>   #define NFC_DEFAULT_TIMEOUT_MS	1000
> @@ -162,11 +172,15 @@
>    * @nstrengths:		Number of element of ECC strengths array
>    * @reg_ecc_err_cnt:	ECC error counter register
>    * @reg_user_data:	User data register
> + * @reg_pat_found:	Data Pattern Status Register
> + * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
>    */
>   struct sunxi_nfc_caps {
>   	unsigned int nstrengths;
>   	unsigned int reg_ecc_err_cnt;
>   	unsigned int reg_user_data;
> +	unsigned int reg_pat_found;
> +	unsigned int pat_found_mask;
>   };
>   
>   #endif

