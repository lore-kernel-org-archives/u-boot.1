Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6E6CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1FD83873;
	Sat, 18 Oct 2025 01:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2611B83804; Sat, 18 Oct 2025 01:10:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E6DCA83885
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4781914BF;
 Fri, 17 Oct 2025 16:10:47 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A5F3F66E;
 Fri, 17 Oct 2025 16:10:51 -0700 (PDT)
Message-ID: <f3971f9d-3d5e-4005-9f5f-631aa3d59850@arm.com>
Date: Sat, 18 Oct 2025 00:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] mtd: rawnand: sunxi: cosmetic: move USER_DATA
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
 <20251016142752.2627710-10-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-10-richard.genoud@bootlin.com>
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
> USER_DATA register offset moved in H616, so let's make it a SoC cap
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

The pattern looks familiar by now ;-)

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/mtd/nand/raw/sunxi_nand.c | 7 ++++---
>   drivers/mtd/nand/raw/sunxi_nand.h | 5 ++++-
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 359f6cdda08a..64a0db37f3f0 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -767,7 +767,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   		 * Retrieve the corrected OOB bytes.
>   		 */
>   		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
> -						 NFC_REG_USER_DATA(0)),
> +						 NFC_REG_USER_DATA(nfc, 0)),
>   					   oob);
>   
>   		/* De-randomize the Bad Block Marker. */
> @@ -838,10 +838,10 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
>   		memcpy(user_data, oob, 4);
>   		sunxi_nfc_randomize_bbm(mtd, page, user_data);
>   		writel(sunxi_nfc_buf_to_user_data(user_data),
> -		       nfc->regs + NFC_REG_USER_DATA(0));
> +		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
>   	} else {
>   		writel(sunxi_nfc_buf_to_user_data(oob),
> -		       nfc->regs + NFC_REG_USER_DATA(0));
> +		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
>   	}
>   
>   	if (data_off + ecc->size != oob_off)
> @@ -1714,6 +1714,7 @@ static int sunxi_nand_probe(struct udevice *dev)
>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>   	.nstrengths = 9,
>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
> +	.reg_user_data = NFC_REG_A10_USER_DATA,
>   };
>   
>   static const struct udevice_id sunxi_nand_ids[] = {
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index b961f2ef3bf2..1977d1bd8eaf 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -43,7 +43,8 @@
>   #define NFC_REG_DEBUG		0x003C
>   #define NFC_REG_A10_ECC_ERR_CNT	0x0040
>   #define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
> -#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
> +#define NFC_REG_A10_USER_DATA	0x0050
> +#define NFC_REG_USER_DATA(nfc, x)	((nfc)->caps->reg_user_data + ((x) * 4))
>   #define NFC_REG_SPARE_AREA	0x00A0
>   #define NFC_REG_PAT_ID		0x00A4
>   #define NFC_RAM0_BASE		0x0400
> @@ -160,10 +161,12 @@
>    *
>    * @nstrengths:		Number of element of ECC strengths array
>    * @reg_ecc_err_cnt:	ECC error counter register
> + * @reg_user_data:	User data register
>    */
>   struct sunxi_nfc_caps {
>   	unsigned int nstrengths;
>   	unsigned int reg_ecc_err_cnt;
> +	unsigned int reg_user_data;
>   };
>   
>   #endif

