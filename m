Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD9C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 14:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DA587D8E;
	Fri,  5 Apr 2024 16:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EXVEwC5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F7C88502; Fri,  5 Apr 2024 12:10:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A686884FB
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 12:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C774A618CC;
 Fri,  5 Apr 2024 10:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E68C43394;
 Fri,  5 Apr 2024 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712311803;
 bh=z5NuZNGe7SxffnfzRyueOy3lHWYoHVLrMm27gixtC8g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EXVEwC5yu3Wwj7nPyhGF5dGiXe4YMifQdVorluXMFTdKbhtuQar83VO8pqflknFpQ
 oBO2eUB6bnYvzlVszlrhMxPpXS6+PJ+2iFAvx9qdtgQmHWSoRJLVli9evL6M3+FrAf
 9856gVK14Rft+OU7xDdCB4k1XdPC7nU7sQu284hpkPg14rD3hAAsTRULsNoriwXAqf
 MgbUkGZMsxfmV/v3HfSlGMvwOmcojdeWd8AsPRjM8YUKEIJBFfoLb2mVXSSUjZcUyl
 hpAXQSWYxxHPND5b0GDPHszNMbOuhVbH73+Ol1WYCSjrN4E/OTbKN1bsD1qQT509B1
 NhKVPS0vqT+nA==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  d-gole@ti.com,  pratyush@kernel.org,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for Infineon S25FS-S family
In-Reply-To: <20240405064746.1600-1-Takahiro.Kuwano@infineon.com> (tkuw's
 message of "Fri, 5 Apr 2024 15:47:46 +0900")
References: <20240405064746.1600-1-Takahiro.Kuwano@infineon.com>
Date: Fri, 05 Apr 2024 12:10:01 +0200
Message-ID: <mafs0il0w15om.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 05 Apr 2024 16:10:05 +0200
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

Just a couple small comments. Looks good otherwise.

On Fri, Apr 05 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
> Flash devices with S25FS512S. Some difference depending on the device
> densities are taken care in fixup hooks.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
> Datasheets:
> https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
> https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758
> ---
>  drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
>  drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index f86003ca8c..9b81b31e8e 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3299,8 +3299,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
>
>  static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
>  {
> +	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
> +
>  	/* Support 8 x 4KB sectors at bottom */
> -	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
> +	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);

Looks like an unrelated bugfix. Should this be a separate patch?

>  }
>
>  static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
> @@ -3354,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
>  static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
>  				    struct spi_nor_flash_parameter *params)
>  {
> -	/* READ_1_1_2 is not supported */
> -	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
> -	/* READ_1_1_4 is not supported */
> -	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
> -	/* PP_1_1_4 is not supported */
> -	params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
> +	/*
> +	 * The S25FS064S(8MB) supports 1-1-2 and 1-1-4 commands, but params for
> +	 * read ops in SFDP are wrong. The other density parts do not support
> +	 * 1-1-2 and 1-1-4 commands.
> +	 */
> +	if (params->size == SZ_8M) {
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
> +					  0, 8, SPINOR_OP_READ_1_1_2,
> +					  SNOR_PROTO_1_1_2);
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
> +					  0, 8, SPINOR_OP_READ_1_1_4,
> +					  SNOR_PROTO_1_1_4);
> +	} else {
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
> +	}
> +
>  	/* Use volatile register to enable quad */
>  	params->quad_enable = s25fs_s_quad_enable;
>  }
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 4e83b8c94c..9ca1f244f0 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -338,9 +338,12 @@ const struct flash_info spi_nor_ids[] = {
>  	 */
>  	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> -	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> +	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> +	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },

Unrelated change. Is this intentional? If so, please make it a separate
patch.

>  	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> +	{ INFO6("s25fs064s",  0x010217, 0x4d0181,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> +	{ INFO6("s25fs128s",  0x012018, 0x4d0181,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> +	{ INFO6("s25fs256s",  0x010219, 0x4d0181,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>  	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>  	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>  	{ INFO("s25fl512s_64k",  0x010220, 0x4d01, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },

-- 
Regards,
Pratyush Yadav
