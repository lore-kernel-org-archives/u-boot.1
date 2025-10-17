Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7944FCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 09:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E1983710;
	Fri, 17 Oct 2025 11:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5476483734; Fri, 17 Oct 2025 11:35:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 06ECD83655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 11:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4895A1595;
 Fri, 17 Oct 2025 02:35:34 -0700 (PDT)
Received: from [192.168.178.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B1FC3F66E;
 Fri, 17 Oct 2025 02:35:37 -0700 (PDT)
Message-ID: <4b3b84b7-f1de-4942-af18-368aa5cafc46@arm.com>
Date: Fri, 17 Oct 2025 10:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] mtd: rawnand: sunxi_spl: cosmetic: use definitions
 from linux/mtd/rawnand.h
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
 <20251016142752.2627710-5-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251016142752.2627710-5-richard.genoud@bootlin.com>
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
> Remove unneeded definitions NFC_CMD_R* in sunxi_nand_spl.c
> 
> No need to define NFC_CMD_RNDOUTSTART, NFC_CMD_RNDOUT and
> NFC_CMD_READSTART here since they are already in linux/mtd/rawnand.h
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 3ccf716b99ac..306c1c0d0989 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -62,10 +62,6 @@
>   #define NFC_RND_READ_CMD0_OFFSET    8
>   #define NFC_RND_READ_CMD1_OFFSET    16
>   
> -#define NFC_CMD_RNDOUTSTART        0xE0
> -#define NFC_CMD_RNDOUT             0x05
> -#define NFC_CMD_READSTART          0x30
> -
>   struct nfc_config {
>   	int page_size;
>   	int ecc_strength;
> @@ -199,9 +195,9 @@ static int nand_load_page(const struct nfc_config *conf, u32 offs)
>   {
>   	int page = offs / conf->page_size;
>   
> -	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
> -	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
> -	       (NFC_CMD_READSTART << NFC_READ_CMD_OFFSET),
> +	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
> +	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
> +	       (NAND_CMD_READSTART << NFC_READ_CMD_OFFSET),
>   	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
>   	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
>   	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_REG_ADDR_HIGH);
> @@ -215,15 +211,15 @@ static int nand_change_column(u16 column)
>   {
>   	int ret;
>   
> -	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
> -	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
> -	       (NFC_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
> +	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
> +	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
> +	       (NAND_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
>   	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
>   	writel(column, SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
>   
>   	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
>   			    (1 << NFC_ADR_NUM_OFFSET) | NFC_SEND_ADR |
> -			    NFC_CMD_RNDOUT);
> +			    NAND_CMD_RNDOUT);
>   	if (ret)
>   		return ret;
>   

