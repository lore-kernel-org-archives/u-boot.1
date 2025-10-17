Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4443ACCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57CB8383F;
	Sat, 18 Oct 2025 01:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52ED83849; Sat, 18 Oct 2025 01:10:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ADAE183804
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EB5E1063;
 Fri, 17 Oct 2025 16:10:38 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0483F66E;
 Fri, 17 Oct 2025 16:10:41 -0700 (PDT)
Message-ID: <48f1f667-4e5d-4bc9-982f-0b2bc95bcc12@arm.com>
Date: Sat, 18 Oct 2025 00:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] mtd: rawnand: sunxi: cosmetic: move ECC_ERR_CNT
 register offset in SoC caps
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
 <20251016142752.2627710-9-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-9-richard.genoud@bootlin.com>
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
> ECC_ERR_CNT register offset moved in H616, so let's make it a SoC cap
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>   drivers/mtd/nand/raw/sunxi_nand.c | 3 ++-
>   drivers/mtd/nand/raw/sunxi_nand.h | 5 ++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 3f30077b3d15..359f6cdda08a 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -737,7 +737,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   		return 1;
>   	}
>   
> -	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0)));
> +	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, 0)));
>   
>   	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
>   
> @@ -1713,6 +1713,7 @@ static int sunxi_nand_probe(struct udevice *dev)
>   
>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>   	.nstrengths = 9,
> +	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>   };
>   
>   static const struct udevice_id sunxi_nand_ids[] = {
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 80fbc8df0090..b961f2ef3bf2 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -41,7 +41,8 @@
>   #define NFC_REG_ECC_CTL		0x0034
>   #define NFC_REG_ECC_ST		0x0038
>   #define NFC_REG_DEBUG		0x003C
> -#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
> +#define NFC_REG_A10_ECC_ERR_CNT	0x0040
> +#define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
>   #define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
>   #define NFC_REG_SPARE_AREA	0x00A0
>   #define NFC_REG_PAT_ID		0x00A4
> @@ -158,9 +159,11 @@
>    * for distinction between compatible strings.
>    *
>    * @nstrengths:		Number of element of ECC strengths array
> + * @reg_ecc_err_cnt:	ECC error counter register
>    */
>   struct sunxi_nfc_caps {
>   	unsigned int nstrengths;
> +	unsigned int reg_ecc_err_cnt;
>   };
>   
>   #endif

