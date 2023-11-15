Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB0C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 11:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11AB286BDF;
	Wed, 15 Nov 2023 12:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXwe6rLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED20987197; Wed, 15 Nov 2023 12:09:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A107186996
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 12:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A9A226148B;
 Wed, 15 Nov 2023 11:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D801C433C8;
 Wed, 15 Nov 2023 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700046593;
 bh=Z+AzaLfodJzSdecDlHJ4EV9izy2Q34bfoPr+1MCk/64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oXwe6rLu7wkOBQzLe+YrbvH1gjdgx1XDPzymbPRvsUbm5ZIC5RL7leUpjCN2rKqTE
 vndA32m830+8YznBtyWr3HY4A1XuVuLja2iyMRxaamr29JrkxcgV0IxvVgnooQq6Ie
 RjE83VghIyLulbIWd/ZK/OqisQah4yaPwURo/pFZGU/rpZhtwXTM+yn3uWv7Y+j++x
 CSoehDSuAzDxeboMcB19coxylqZ3/RxQNmkYtcaUrTVp4LR5xZ9KLsYNF+enieZdBE
 SkwX+XbxgE82+gAyi3/Z9cJo/gUBM21Ru3mcYSVNutMbXOHaWkL+PpRNSBfw5eIbnD
 saJrdujhy+OXg==
Message-ID: <f21f052e-1b6d-45bc-8987-3b33eee7e09a@kernel.org>
Date: Wed, 15 Nov 2023 13:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
Content-Language: en-US
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>
References: <20231115054044.3937543-1-hs@denx.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231115054044.3937543-1-hs@denx.de>
Content-Type: text/plain; charset=UTF-8
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



On 15/11/2023 07:40, Heiko Schocher wrote:
> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
> 
> broke AM335x based boards booting from NAND with ECC BCH8 code.
> 
> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch()
> in SPL restores correct SPL nand_read_page functionality.
> 
> Tested on draco thuban board.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> fix NAND boot for BCH8 based TI AM335x boards
> 
> Fix is based on series from Enrico:
> 
> https://lists.denx.de/pipermail/u-boot/2023-November/536793.html
> 
> and fixes NAND boot for the draco thuban board. But this patch
> apply also without the patches from above patchseries, see
> azure build:
> 
> https://dev.azure.com/hs0298/hs/_build/results?buildId=111&view=results
> 
> which is clean.
> 
> Above commit seems to change only U-Boot code and did not
> adapt am335x_spl_bch.c, which breaks nand_read_page in SPL
> code for AM335x based boards. So use in SPL "old" hw setup
> and reading page from NAND in SPL works again.
> 
> 
>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
> index 1a5ed0de31..c9b66dadbd 100644
> --- a/drivers/mtd/nand/raw/omap_gpmc.c
> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>  		nand->ecc.strength	= 8;
>  		nand->ecc.size		= SECTOR_BYTES;
>  		nand->ecc.bytes		= 14;
> +#if defined(CONFIG_SPL_BUILD)
> +		nand->ecc.hwctl		= omap_enable_hwecc;

I don't think this is correct. omap_enable_hwecc does not setup
the BCH settings and should be used only for 1-bit ECC i.e. OMAP_ECC_HAM1_CODE_*

I'm sure it will break the boards not using
CONFIG_SPL_NAND_AM33XX_BCH which is
pretty much most TI boards that are not AM335x.

Now, I need to identify why AM335x NAND is broken.

> +#else
>  		nand->ecc.hwctl		= omap_enable_hwecc_bch;
> +#endif
>  		nand->ecc.correct	= omap_correct_data_bch;
>  		nand->ecc.calculate	= omap_calculate_ecc_bch;
>  		nand->ecc.read_page	= omap_read_page_bch;

-- 
cheers,
-roger
