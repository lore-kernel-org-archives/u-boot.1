Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E8FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530DD83693;
	Mon, 27 Apr 2026 13:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KyzHqlPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608EA839D9; Mon, 27 Apr 2026 13:14:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2CBEA80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EACCE1684;
 Mon, 27 Apr 2026 04:14:19 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EF63F763;
 Mon, 27 Apr 2026 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777288465; bh=08fWottf4AmlW0qtE0qWyEgorO2vuPWPlTW6Uu5W3Qo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KyzHqlPOu7ZfONB085Wp3LZpG3ry5M6xanIEw5aVVfkmo78rb7y2LoaVkwO6NGkJk
 58DTfVF4bu6MneIC4IURir4YdKk40chs7xb781leoYeQ7hfiHmz8ysdGUFoGmMxCh6
 qqPg7DpymRnzywI8D4URxhBr6apt41wqVhZuVISU=
Message-ID: <6317b12b-5ae4-4fca-8331-5377f6fac213@arm.com>
Date: Mon, 27 Apr 2026 13:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mtd: rawnand: sunxi: Replace hard coded value by a
 define
To: Richard Genoud <richard.genoud@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <20260327140508.3680105-2-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260327140508.3680105-2-richard.genoud@bootlin.com>
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

On 3/27/26 15:05, Richard Genoud wrote:
> The user data length (4) used all over the code hard coded.
> And sometimes, it's not that trivial to know that it's the user data
> length and not something else.
> Moreover, for the H6/H616 this value is no more fixed by hardware, but
> could be modified.
> 
> Using a define here makes the code more readable.
> 
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/mtd/nand/raw/sunxi_nand.c     | 58 +++++++++++++--------------
>   drivers/mtd/nand/raw/sunxi_nand.h     |  3 ++
>   drivers/mtd/nand/raw/sunxi_nand_spl.c |  7 +++-
>   3 files changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index ef27a4b7a36a..91f7da2c5ce5 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -772,7 +772,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   		return ret;
>   
>   	sunxi_nfc_reset_user_data_len(nfc);
> -	sunxi_nfc_set_user_data_len(nfc, 4, 0);
> +	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
>   
>   	sunxi_nfc_randomizer_enable(mtd);
>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
> @@ -783,7 +783,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   	if (ret)
>   		return ret;
>   
> -	*cur_off = oob_off + ecc->bytes + 4;
> +	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
>   
>   	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
>   	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
> @@ -794,7 +794,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   			pattern = 0x0;
>   
>   		memset(data, pattern, ecc->size);
> -		memset(oob, pattern, ecc->bytes + 4);
> +		memset(oob, pattern, ecc->bytes + USER_DATA_SZ);
>   
>   		return 1;
>   	}
> @@ -804,7 +804,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
>   
>   	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
> -	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4, true, page);
> +	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ, true, page);
>   
>   	status = readl(nfc->regs + NFC_REG_ECC_ST);
>   	if (status & NFC_ECC_ERR(0)) {
> @@ -816,17 +816,17 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
>   			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
>   			nand->read_buf(mtd, data, ecc->size);
>   			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
> -			nand->read_buf(mtd, oob, ecc->bytes + 4);
> +			nand->read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ);
>   		}
>   
>   		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
> -						  oob, ecc->bytes + 4,
> +						  oob, ecc->bytes + USER_DATA_SZ,
>   						  NULL, 0, ecc->strength);
>   		if (ret >= 0)
>   			raw_mode = 1;
>   	} else {
>   		/*
> -		 * The engine protects 4 bytes of OOB data per chunk.
> +		 * The engine protects USER_DATA_SZ bytes of OOB data per chunk.
>   		 * Retrieve the corrected OOB bytes.
>   		 */
>   		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
> @@ -854,7 +854,7 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
>   {
>   	struct nand_chip *nand = mtd_to_nand(mtd);
>   	struct nand_ecc_ctrl *ecc = &nand->ecc;
> -	int offset = ((ecc->bytes + 4) * ecc->steps);
> +	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
>   	int len = mtd->oobsize - offset;
>   
>   	if (len <= 0)
> @@ -896,9 +896,9 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
>   
>   	/* Fill OOB data in */
>   	if ((nand->options & NAND_NEED_SCRAMBLING) && bbm) {
> -		u8 user_data[4];
> +		u8 user_data[USER_DATA_SZ];
>   
> -		memcpy(user_data, oob, 4);
> +		memcpy(user_data, oob, USER_DATA_SZ);
>   		sunxi_nfc_randomize_bbm(mtd, page, user_data);
>   		writel(sunxi_nfc_buf_to_user_data(user_data),
>   		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
> @@ -915,7 +915,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
>   		return ret;
>   
>   	sunxi_nfc_reset_user_data_len(nfc);
> -	sunxi_nfc_set_user_data_len(nfc, 4, 0);
> +	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
>   
>   	sunxi_nfc_randomizer_enable(mtd);
>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
> @@ -927,7 +927,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
>   	if (ret)
>   		return ret;
>   
> -	*cur_off = oob_off + ecc->bytes + 4;
> +	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
>   
>   	return 0;
>   }
> @@ -938,7 +938,7 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
>   {
>   	struct nand_chip *nand = mtd_to_nand(mtd);
>   	struct nand_ecc_ctrl *ecc = &nand->ecc;
> -	int offset = ((ecc->bytes + 4) * ecc->steps);
> +	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
>   	int len = mtd->oobsize - offset;
>   
>   	if (len <= 0)
> @@ -966,7 +966,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
>   
>   	for (i = 0; i < ecc->steps; i++) {
>   		int data_off = i * ecc->size;
> -		int oob_off = i * (ecc->bytes + 4);
> +		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
>   		u8 *data = buf + data_off;
>   		u8 *oob = chip->oob_poi + oob_off;
>   
> @@ -1004,7 +1004,7 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
>   	for (i = data_offs / ecc->size;
>   	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
>   		int data_off = i * ecc->size;
> -		int oob_off = i * (ecc->bytes + 4);
> +		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
>   		u8 *data = bufpoi + data_off;
>   		u8 *oob = chip->oob_poi + oob_off;
>   
> @@ -1032,7 +1032,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
>   
>   	for (i = 0; i < ecc->steps; i++) {
>   		int data_off = i * ecc->size;
> -		int oob_off = i * (ecc->bytes + 4);
> +		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
>   		const u8 *data = buf + data_off;
>   		const u8 *oob = chip->oob_poi + oob_off;
>   
> @@ -1066,7 +1066,7 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
>   	for (i = data_offs / ecc->size;
>   	     i < DIV_ROUND_UP(data_offs + data_len, ecc->size); i++) {
>   		int data_off = i * ecc->size;
> -		int oob_off = i * (ecc->bytes + 4);
> +		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
>   		const u8 *data = buf + data_off;
>   		const u8 *oob = chip->oob_poi + oob_off;
>   
> @@ -1095,10 +1095,10 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
>   	sunxi_nfc_hw_ecc_enable(mtd);
>   
>   	for (i = 0; i < ecc->steps; i++) {
> -		int data_off = i * (ecc->size + ecc->bytes + 4);
> +		int data_off = i * (ecc->size + ecc->bytes + USER_DATA_SZ);
>   		int oob_off = data_off + ecc->size;
>   		u8 *data = buf + (i * ecc->size);
> -		u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
> +		u8 *oob = chip->oob_poi + (i * (ecc->bytes + USER_DATA_SZ));
>   
>   		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
>   						  oob_off, &cur_off,
> @@ -1129,10 +1129,10 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
>   	sunxi_nfc_hw_ecc_enable(mtd);
>   
>   	for (i = 0; i < ecc->steps; i++) {
> -		int data_off = i * (ecc->size + ecc->bytes + 4);
> +		int data_off = i * (ecc->size + ecc->bytes + USER_DATA_SZ);
>   		int oob_off = data_off + ecc->size;
>   		const u8 *data = buf + (i * ecc->size);
> -		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
> +		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + USER_DATA_SZ));
>   
>   		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
>   						   oob, oob_off, &cur_off,
> @@ -1390,7 +1390,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
>   	layout = &data->layout;
>   	nsectors = mtd->writesize / ecc->size;
>   
> -	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
> +	if (mtd->oobsize < ((ecc->bytes + USER_DATA_SZ) * nsectors)) {
>   		ret = -EINVAL;
>   		goto err;
>   	}
> @@ -1440,14 +1440,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
>   				layout->oobfree[i - 1].offset +
>   				layout->oobfree[i - 1].length +
>   				ecc->bytes;
> -			layout->oobfree[i].length = 4;
> +			layout->oobfree[i].length = USER_DATA_SZ;
>   		} else {
>   			/*
>   			 * The first 2 bytes are used for BB markers, hence we
> -			 * only have 2 bytes available in the first user data
> -			 * section.
> +			 * only have USER_DATA_SZ - 2 bytes available in the
> +			 * first user data section.
>   			 */
> -			layout->oobfree[i].length = 2;
> +			layout->oobfree[i].length = USER_DATA_SZ - 2;
>   			layout->oobfree[i].offset = 2;
>   		}
>   
> @@ -1457,13 +1457,13 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
>   					layout->oobfree[i].length + j;
>   	}
>   
> -	if (mtd->oobsize > (ecc->bytes + 4) * nsectors) {
> +	if (mtd->oobsize > (ecc->bytes + USER_DATA_SZ) * nsectors) {
>   		layout->oobfree[nsectors].offset =
>   				layout->oobfree[nsectors - 1].offset +
>   				layout->oobfree[nsectors - 1].length +
>   				ecc->bytes;
>   		layout->oobfree[nsectors].length = mtd->oobsize -
> -				((ecc->bytes + 4) * nsectors);
> +				((ecc->bytes + USER_DATA_SZ) * nsectors);
>   	}
>   
>   	return 0;
> @@ -1481,7 +1481,7 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
>   	if (ret)
>   		return ret;
>   
> -	ecc->prepad = 4;
> +	ecc->prepad = USER_DATA_SZ;
>   	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
>   	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
>   
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 6ee3ea14ee17..d7a8b3dd40c3 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -181,6 +181,9 @@
>   
>   #define NFC_MAX_CS		7
>   
> +/* On A10, the user data length register is 4 bytes */
> +#define USER_DATA_SZ 4
> +
>   /*
>    * NAND Controller capabilities structure: stores NAND controller capabilities
>    * for distinction between compatible strings.
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 67f7d22ed2c8..3a5271b49c36 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -269,6 +269,11 @@ static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
>   	writel_nfc(val, NFC_REG_USER_DATA_LEN(nfc, step));
>   }
>   
> +/*
> + * Values in this table are obtained by doing:
> + * DIV_ROUND_UP(info->ecc_strength * 14, 8) + USER_DATA_SZ
> + * So it's the number of bytes needed for ECC + user data for one step.
> + */
>   #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
>   static const int ecc_bytes[] = {
>   	32, 46, 54, 60, 74, 82, 88, 96, 102, 110, 116, 124, 130, 138, 144
> @@ -338,7 +343,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
>   		nand_change_column(oob_off);
>   
>   		sunxi_nfc_reset_user_data_len(conf);
> -		sunxi_nfc_set_user_data_len(conf, 4, 0);
> +		sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, 0);
>   
>   		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
>   		/* Get the ECC status */

