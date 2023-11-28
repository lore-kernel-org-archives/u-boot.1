Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114CAC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 09:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F85E870AB;
	Tue, 28 Nov 2023 10:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YAgXvvl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89C28753B; Tue, 28 Nov 2023 10:22:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E8386E81
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 10:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 38C0861589;
 Tue, 28 Nov 2023 09:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0589C433C7;
 Tue, 28 Nov 2023 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701163321;
 bh=MRjCxzU3b2sF3aI9eRISTTpqzjn6KOHZ3MGmVq5tlcc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YAgXvvl8u74V2Gmla10i1LN3CjUS5tIfSwXrbRYx6cITBg5qL7QAh4S+a0eDz8lAy
 3Ldzx300l3bm8izmnR4i644pEhC9IFbrDm7li8pAZzhe5lIZBk4VGYVdR3z2NZtaw0
 A9Q7BPR6Rf767V9NfA1WQQZgfbjJ65/gHkHI9GCCWcem2+8+MRLWrx0Tg4aZM0BUeg
 HG8LZVly8++q/dqbWQ4to14Gs8VRYPWLI/k5vzFjPh3qtaONAOX7wkBQT60rTezgqm
 tJJ6/ns+ihrh9LlaipY8sSPcBzv5CjHvm5q+l6xkR1CPAk3GRWcNCclutWGLr1LXPF
 cTMRCK288zzYw==
Message-ID: <40ba6115-405d-4def-bbde-fb9e1a8fa471@kernel.org>
Date: Tue, 28 Nov 2023 11:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>
Cc: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "hs@denx.de" <hs@denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "praneeth@ti.com"
 <praneeth@ti.com>, "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20231125111605.47536-1-rogerq@kernel.org>
 <CAOf5uwk7So4o-rrTpY0Uy9OqmGTZkqVvuzYaE_z1Rdo0mLhmxg@mail.gmail.com>
 <DB8PR10MB373722A24CF47C907D8C3EECFFBDA@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
 <CAOf5uwkiF+wM9=bCiMMtGvUj1Yq4GKmh1o8qmKyJpqPXbMGQOA@mail.gmail.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAOf5uwkiF+wM9=bCiMMtGvUj1Yq4GKmh1o8qmKyJpqPXbMGQOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 27/11/2023 16:43, Michael Nazzareno Trimarchi wrote:
> Hi dario
> 
> On Mon, Nov 27, 2023 at 3:00 PM Leto, Enrico <enrico.leto@siemens.com> wrote:
>>
>> Hi,
>>
>> Works on my draco thuban AM335x based boards booting from NAND with ECC BCH8 code.
>>
>> Tested-by: Enrico Leto <enrico.leto@siemens.com>
>>
>> Thanks
>>
>>
>>> -----Original Message-----
>>> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
>>> Sent: Saturday, November 25, 2023 2:07 PM
>>> To: Roger Quadros <rogerq@kernel.org>
>>> Cc: dario.binacchi@amarulasolutions.com; Schocher, Heiko (EXT) (DENX
>>> Software Engineering GmbH) <hs@denx.de>; Leto, Enrico (SI BP R&D ZG FW
>>> CCP) <enrico.leto@siemens.com>; trini@konsulko.com; praneeth@ti.com;
>>> nm@ti.com; vigneshr@ti.com; u-boot@lists.denx.de
>>> Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
>>>
>>> Hi Roger
>>>
>>> On Sat, Nov 25, 2023 at 12:16 PM Roger Quadros <rogerq@kernel.org>
>>> wrote:
>>>>
>>>> AM335x uses a special driver "am335x_spl_bch.c" as SPL NAND loader.
>>>> This driver expects 1 sector at a time ECC and doesn't work well with
>>>> multi-sector ECC that was implemented in commit 04fcd2587321 ("mtd:
>>>> rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>>>>
>>>> Switch back to 1 sector at a time read/ECC.
>>>>
>>>> Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based
>>>> correction")
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  drivers/mtd/nand/raw/omap_gpmc.c | 95
>>>> ++++++++++----------------------
>>>>  1 file changed, 29 insertions(+), 66 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c
>>>> b/drivers/mtd/nand/raw/omap_gpmc.c
>>>> index 1a5ed0de31..2d2d2c2b6d 100644
>>>> --- a/drivers/mtd/nand/raw/omap_gpmc.c
>>>> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
>>>> @@ -293,7 +293,7 @@ static void __maybe_unused
>>> omap_enable_hwecc_bch(struct mtd_info *mtd,
>>>>                 break;
>>>>         case OMAP_ECC_BCH8_CODE_HW:
>>>>                 bch_type = 1;
>>>> -               nsectors = chip->ecc.steps;
>>>> +               nsectors = 1;
>>>>                 if (mode == NAND_ECC_READ) {
>>>>                         wr_mode   = BCH_WRAPMODE_1;
>>>>                         ecc_size0 = BCH8R_ECC_SIZE0; @@ -306,7 +306,7
>>>> @@ static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info
>>> *mtd,
>>>>                 break;
>>>>         case OMAP_ECC_BCH16_CODE_HW:
>>>>                 bch_type = 0x2;
>>>> -               nsectors = chip->ecc.steps;
>>>> +               nsectors = 1;
>>>>                 if (mode == NAND_ECC_READ) {
>>>>                         wr_mode   = 0x01;
>>>>                         ecc_size0 = 52; /* ECC bits in nibbles per
>>>> sector */ @@ -345,17 +345,16 @@ static void __maybe_unused
>>>> omap_enable_hwecc_bch(struct mtd_info *mtd,  }
>>>>
>>>>  /**
>>>> - * _omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
>>>> + * omap_calculate_ecc_bch - Generate BCH ECC bytes for one sector
>>>>   * @mtd:        MTD device structure
>>>>   * @dat:        The pointer to data on which ecc is computed
>>>>   * @ecc_code:   The ecc_code buffer
>>>> - * @sector:     The sector number (for a multi sector page)
>>>>   *
>>>>   * Support calculating of BCH4/8/16 ECC vectors for one sector
>>>>   * within a page. Sector number is in @sector.
>>>>   */
>>>> -static int _omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *dat,
>>>> -                                  u8 *ecc_code, int sector)
>>>> +static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *dat,
>>>> +                                 u8 *ecc_code)
>>>>  {
>>>>         struct nand_chip *chip = mtd_to_nand(mtd);
>>>>         struct omap_nand_info *info = nand_get_controller_data(chip);
>>>> @@ -368,7 +367,7 @@ static int _omap_calculate_ecc_bch(struct mtd_info
>>> *mtd, const u8 *dat,
>>>>         case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
>>>>  #endif
>>>>         case OMAP_ECC_BCH8_CODE_HW:
>>>> -               ptr = &gpmc_cfg->bch_result_0_3[sector].bch_result_x[3];
>>>> +               ptr = &gpmc_cfg->bch_result_0_3[0].bch_result_x[3];
>>>>                 val = readl(ptr);
>>>>                 ecc_code[i++] = (val >>  0) & 0xFF;
>>>>                 ptr--;
>>>> @@ -383,21 +382,21 @@ static int _omap_calculate_ecc_bch(struct
>>>> mtd_info *mtd, const u8 *dat,
>>>>
>>>>                 break;
>>>>         case OMAP_ECC_BCH16_CODE_HW:
>>>> -               val = readl(&gpmc_cfg->bch_result_4_6[sector].bch_result_x[2]);
>>>> +               val =
>>>> + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[2]);
>>>>                 ecc_code[i++] = (val >>  8) & 0xFF;
>>>>                 ecc_code[i++] = (val >>  0) & 0xFF;
>>>> -               val = readl(&gpmc_cfg->bch_result_4_6[sector].bch_result_x[1]);
>>>> +               val =
>>>> + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[1]);
>>>>                 ecc_code[i++] = (val >> 24) & 0xFF;
>>>>                 ecc_code[i++] = (val >> 16) & 0xFF;
>>>>                 ecc_code[i++] = (val >>  8) & 0xFF;
>>>>                 ecc_code[i++] = (val >>  0) & 0xFF;
>>>> -               val = readl(&gpmc_cfg->bch_result_4_6[sector].bch_result_x[0]);
>>>> +               val =
>>>> + readl(&gpmc_cfg->bch_result_4_6[0].bch_result_x[0]);
>>>>                 ecc_code[i++] = (val >> 24) & 0xFF;
>>>>                 ecc_code[i++] = (val >> 16) & 0xFF;
>>>>                 ecc_code[i++] = (val >>  8) & 0xFF;
>>>>                 ecc_code[i++] = (val >>  0) & 0xFF;
>>>>                 for (j = 3; j >= 0; j--) {
>>>> -                       val = readl(&gpmc_cfg->bch_result_0_3[sector].bch_result_x[j]
>>>> +                       val =
>>>> + readl(&gpmc_cfg->bch_result_0_3[0].bch_result_x[j]
>>>>                                                                         );
>>>>                         ecc_code[i++] = (val >> 24) & 0xFF;
>>>>                         ecc_code[i++] = (val >> 16) & 0xFF; @@ -431,22
>>>> +430,6 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd, const
>>> u8 *dat,
>>>>         return 0;
>>>>  }
>>>>
>>>> -/**
>>>> - * omap_calculate_ecc_bch - ECC generator for 1 sector
>>>> - * @mtd:        MTD device structure
>>>> - * @dat:       The pointer to data on which ecc is computed
>>>> - * @ecc_code:  The ecc_code buffer
>>>> - *
>>>> - * Support calculating of BCH4/8/16 ECC vectors for one sector. This
>>>> is used
>>>> - * when SW based correction is required as ECC is required for one
>>>> sector
>>>> - * at a time.
>>>> - */
>>>> -static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
>>>> -                                 const u_char *dat, u_char *ecc_calc)
>>>> -{
>>>> -       return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
>>>> -}
>>>> -
>>>>  static inline void omap_nand_read_buf(struct mtd_info *mtd, uint8_t
>>>> *buf, int len)  {
>>>>         struct nand_chip *chip = mtd_to_nand(mtd); @@ -572,34 +555,6
>>>> @@ static void omap_nand_read_prefetch(struct mtd_info *mtd, uint8_t
>>>> *buf, int len)
>>>>
>>>>  #ifdef CONFIG_NAND_OMAP_ELM
>>>>
>>>> -/**
>>>> - * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
>>>> - * @mtd:       MTD device structure
>>>> - * @dat:       The pointer to data on which ecc is computed
>>>> - * @ecc_code:  The ecc_code buffer
>>>> - *
>>>> - * Support calculating of BCH4/8/16 ecc vectors for the entire page in one
>>> go.
>>>> - */
>>>> -static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
>>>> -                                       const u_char *dat, u_char *ecc_calc)
>>>> -{
>>>> -       struct nand_chip *chip = mtd_to_nand(mtd);
>>>> -       int eccbytes = chip->ecc.bytes;
>>>> -       unsigned long nsectors;
>>>> -       int i, ret;
>>>> -
>>>> -       nsectors = ((readl(&gpmc_cfg->ecc_config) >> 4) & 0x7) + 1;
>>>> -       for (i = 0; i < nsectors; i++) {
>>>> -               ret = _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
>>>> -               if (ret)
>>>> -                       return ret;
>>>> -
>>>> -               ecc_calc += eccbytes;
>>>> -       }
>>>> -
>>>> -       return 0;
>>>> -}
>>>> -
>>>>  /*
>>>>   * omap_reverse_list - re-orders list elements in reverse order [internal]
>>>>   * @list:      pointer to start of list
>>>> @@ -752,7 +707,6 @@ static int omap_read_page_bch(struct mtd_info
>>>> *mtd, struct nand_chip *chip,  {
>>>>         int i, eccsize = chip->ecc.size;
>>>>         int eccbytes = chip->ecc.bytes;
>>>> -       int ecctotal = chip->ecc.total;
>>>>         int eccsteps = chip->ecc.steps;
>>>>         uint8_t *p = buf;
>>>>         uint8_t *ecc_calc = chip->buffers->ecccalc; @@ -760,24 +714,30
>>>> @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip
>>> *chip,
>>>>         uint32_t *eccpos = chip->ecc.layout->eccpos;
>>>>         uint8_t *oob = chip->oob_poi;
>>>>         uint32_t oob_pos;
>>>> +       u32 data_pos = 0;
>>>>
>>>>         /* oob area start */
>>>>         oob_pos = (eccsize * eccsteps) + chip->ecc.layout->eccpos[0];
>>>>         oob += chip->ecc.layout->eccpos[0];
>>>>
>>>> -       /* Enable ECC engine */
>>>> -       chip->ecc.hwctl(mtd, NAND_ECC_READ);
>>>> +       for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize,
>>>> +            oob += eccbytes) {
>>>> +               /* Enable ECC engine */
>>>> +               chip->ecc.hwctl(mtd, NAND_ECC_READ);
>>>>
>>>> -       /* read entire page */
>>>> -       chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, -1);
>>>> -       chip->read_buf(mtd, buf, mtd->writesize);
>>>> +               /* read data */
>>>> +               chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_pos, -1);
>>>> +               chip->read_buf(mtd, p, eccsize);
>>>>
>>>> -       /* read all ecc bytes from oob area */
>>>> -       chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
>>>> -       chip->read_buf(mtd, oob, ecctotal);
>>>> +               /* read respective ecc from oob area */
>>>> +               chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
>>>> +               chip->read_buf(mtd, oob, eccbytes);
>>>> +               /* read syndrome */
>>>> +               chip->ecc.calculate(mtd, p, &ecc_calc[i]);
>>>>
>>>> -       /* Calculate ecc bytes */
>>>> -       omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
>>>> +               data_pos += eccsize;
>>>> +               oob_pos += eccbytes;
>>>> +       }
>>>>
>>>>         for (i = 0; i < chip->ecc.total; i++)
>>>>                 ecc_code[i] = chip->oob_poi[eccpos[i]]; @@ -945,6
>>>> +905,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>>>>                 nand->ecc.hwctl         = omap_enable_hwecc_bch;
>>>>                 nand->ecc.correct       = omap_correct_data_bch_sw;
>>>>                 nand->ecc.calculate     = omap_calculate_ecc_bch;
>>>> +               nand->ecc.steps         = eccsteps;
>>>>                 /* define ecc-layout */
>>>>                 ecclayout->eccbytes     = nand->ecc.bytes * eccsteps;
>>>>                 ecclayout->eccpos[0]    = BADBLOCK_MARKER_LENGTH;
>>>> @@ -987,6 +948,7 @@ static int omap_select_ecc_scheme(struct
>>> nand_chip *nand,
>>>>                 nand->ecc.correct       = omap_correct_data_bch;
>>>>                 nand->ecc.calculate     = omap_calculate_ecc_bch;
>>>>                 nand->ecc.read_page     = omap_read_page_bch;
>>>> +               nand->ecc.steps         = eccsteps;
>>>>                 /* define ecc-layout */
>>>>                 ecclayout->eccbytes     = nand->ecc.bytes * eccsteps;
>>>>                 for (i = 0; i < ecclayout->eccbytes; i++) @@ -1020,6
>>>> +982,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>>>>                 nand->ecc.correct       = omap_correct_data_bch;
>>>>                 nand->ecc.calculate     = omap_calculate_ecc_bch;
>>>>                 nand->ecc.read_page     = omap_read_page_bch;
>>>> +               nand->ecc.steps         = eccsteps;
>>>>                 /* define ecc-layout */
>>>>                 ecclayout->eccbytes     = nand->ecc.bytes * eccsteps;
>>>>                 for (i = 0; i < ecclayout->eccbytes; i++)
>>>>
>>>> base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Let's wait on some tested-by
>>>
> 
> I'm not a fan of this patch but we need to cover this regression

Is it because of the performance hit for non AM335x platforms?
Any suggestions for improvement?

-- 
cheers,
-roger
