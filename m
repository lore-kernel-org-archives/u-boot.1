Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF1DC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 19:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9444A8776E;
	Wed, 27 Dec 2023 20:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tpio4egi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D413E87801; Wed, 27 Dec 2023 20:48:18 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DB9807D9
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 20:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRJlxIM069185;
 Wed, 27 Dec 2023 13:47:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703706479;
 bh=s/wo/CPs2BbLdKb+QA5yqmRn5+kT5KuuHVnf0KH3jlA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Tpio4egiq3hhrBD56TwjzVAAXo4GpEXefRmEEV8ZxcFSagSQaG6/WKjYGoSdTQsky
 ZR3VtpHaRhgE5+fWpnNwbBLEf/nm+TYdxO5dY9U8PUNePr4jHg8kDy4CV/8+ktw8ym
 mF21mktb9pU0mP0gJFcz54VUDUB9sYxSuKleAvx4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRJlx3D038128
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 13:47:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 13:47:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 13:47:59 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRJlwA5122221;
 Wed, 27 Dec 2023 13:47:59 -0600
Date: Thu, 28 Dec 2023 01:17:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: <tkuw584924@gmail.com>
CC: <u-boot@lists.denx.de>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <Bacem.Daassi@infineon.com>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 9/9] mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt
 ID
Message-ID: <20231227194758.b37l2vaxqynzj22i@dhruva>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <1e205ee9275691afdc41129009a18dd715e6d1f2.1703220284.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e205ee9275691afdc41129009a18dd715e6d1f2.1703220284.git.Takahiro.Kuwano@infineon.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi!

On Dec 22, 2023 at 14:46:06 +0900, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Infineon(Cypress) S28HS02GT is 1.8V, 2Gb (256MB) NOR Flash memory with
> Octal interface. It is a dual-die package parts and has same features
> with existing S28 series.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index f86e7ff8e5..949ceee375 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -370,6 +370,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
> +	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  #endif
>  #endif
>  #ifdef CONFIG_SPI_FLASH_SST		/* SST */
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
