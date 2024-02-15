Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F8FC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 16:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9158987D6B;
	Thu, 15 Feb 2024 17:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FC6877D3; Thu, 15 Feb 2024 17:51:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2B347877D3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 17:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EDE51FB;
 Thu, 15 Feb 2024 08:51:40 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070BB3F766;
 Thu, 15 Feb 2024 08:50:56 -0800 (PST)
Date: Thu, 15 Feb 2024 16:50:54 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Fabio Estevam <festevam@gmail.com>, Bruce
 Suen <bruce_suen@163.com>, Dhruva Gole <d-gole@ti.com>, Jim Liu
 <jim.t90615@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Neal Frager
 <neal.frager@amd.com>, Nishanth Menon <nm@ti.com>, Ricardo Pardini
 <ricardo@pardini.net>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
Message-ID: <20240215165054.4ddc8846@donnerap.manchester.arm.com>
In-Reply-To: <20240215133527.216126-1-frieder@fris.de>
References: <20240215133527.216126-1-frieder@fris.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 15 Feb 2024 14:35:19 +0100
Frieder Schrempf <frieder@fris.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The datasheet can be found here:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes in v3:
> * none

Why do you resend then? Also v4 seems unchanged? Did you adjust the people
in CC:? If you want to notify more people, please just reply to your own
patch.

Cheers,
Andre

> Changes in v2:
> * Add R-b tag from Fabio (Thanks!)
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 38a287487ed..4e83b8c94c9 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -80,6 +80,7 @@ const struct flash_info spi_nor_ids[] = {
>  #endif
>  #ifdef CONFIG_SPI_FLASH_EON		/* EON */
>  	/* EON -- en25xxx */
> +	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
>  	{ INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
>  	{ INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
>  	{ INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },

