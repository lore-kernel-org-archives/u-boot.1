Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75CECD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 12:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C0587F01;
	Tue,  9 Apr 2024 14:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kzkQe1rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10081880BB; Tue,  9 Apr 2024 13:54:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7AC487A4B
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 13:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 78B96614F0;
 Tue,  9 Apr 2024 11:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0262C433F1;
 Tue,  9 Apr 2024 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712663662;
 bh=T7qRp73RXIBA1ShlCndYs67DU+Q/MejpgSPCDslo37g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kzkQe1rpMJU2gcfBOAfHgKonZnApGGPkUfBR3cadXx8yuoAGX5YsIi9kj68WC6bwI
 UVUVSTm0zp3YD6CFO5cwZXtuofRfZDg6bEzzNw6QppOZgxcJFivLoLwS9P3ZZbWHzp
 KxyfywRmrSSvUVvSpAP5aG2a0P8XOz32QaQpO6DDRHw4JaCw/I0qxf8+Wj9PufeZm9
 rNO+UyjuWxQ9B5fhK+moAEWdO3QET0/kE8gjrl7Oq4inJaw8HpBE2w81TTV75LCGDz
 9Nc8dFLjo7ygOcNrcE72v8GI7pHo0DTBYQhh4kkT1NJEffGL27vqs3mwPJD67/lnBY
 8BBhRbhNZLBxA==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  pratyush@kernel.org,  d-gole@ti.com,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 3/3] mtd: spi-nor-id: Add S25FS064S, S25FS128S,
 S25FS256S IDs
In-Reply-To: <37d92e2931b646f97f73650c0306adb736bd0efc.1712638210.git.Takahiro.Kuwano@infineon.com>
 (tkuw's message of "Tue, 9 Apr 2024 15:20:22 +0900")
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
 <37d92e2931b646f97f73650c0306adb736bd0efc.1712638210.git.Takahiro.Kuwano@infineon.com>
Date: Tue, 09 Apr 2024 13:54:19 +0200
Message-ID: <mafs0edbe92fo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 09 Apr 2024 14:57:26 +0200
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

On Tue, Apr 09 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
> Flash devices with S25FS512S. Some difference depending on the device
> densities are taken care in post SFDP fixup.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 24 ++++++++++++++++++------
>  drivers/mtd/spi/spi-nor-ids.c  |  3 +++
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 9620852817..9b81b31e8e 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3356,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
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

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

BTW (not directly related to this patch), I looked at the datasheet you
provided in the cover letter and it says dual and quad I/O is supported
for the 16 MB and 32 MB parts as well. Why do you mask them out here
then?

>  	/* Use volatile register to enable quad */
>  	params->quad_enable = s25fs_s_quad_enable;
>  }
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index a3dca506a3..9ca1f244f0 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -341,6 +341,9 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>  	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
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
