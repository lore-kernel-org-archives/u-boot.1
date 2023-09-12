Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ACFCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B953486DFF;
	Tue, 12 Sep 2023 11:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gB5BLNXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6966986E23; Tue, 12 Sep 2023 11:37:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F281486AFD
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C9bKcT079836;
 Tue, 12 Sep 2023 04:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694511440;
 bh=D7t1ql9opSya6dhWBOLfe8VVjTDEunhHLlMAchzbllY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gB5BLNXKo7IkoDNnvgb1n0UsRcEm1whCDYjCT2hSDQUgyEO2VEsa+9eoF9uxHZDS2
 R5Ir8bST35915nUCEK+nBzqP8rMzH87B3xqh7xmJU/ykmh25eiGyG6haY7NXcmscX1
 Hbt6XszwEvuFZstJ1TWLyuzfa1k7/KI8GfZKtgs4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C9bKsX105124
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 04:37:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 04:37:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 04:37:19 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C9bHUi025632;
 Tue, 12 Sep 2023 04:37:17 -0500
Message-ID: <14ccab2a-57a0-9866-91be-2ba40337a9a4@ti.com>
Date: Tue, 12 Sep 2023 15:07:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH] spi: cadence_qspi: Select flash subnode at runtime
Content-Language: en-US
To: Udit Kumar <u-kumar1@ti.com>, <jagan@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
References: <20230907092143.4110817-1-u-kumar1@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230907092143.4110817-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Udit

On 07/09/23 14:51, Udit Kumar wrote:
> Currently spi driver gets flash parameter from first subnode.
> 
> Few boards have more than one flash with different parameters
> and selection of flash is done by on board switch settings.
> In such case, uboot needs to be recompiled with updated
> device tree to align with board switch settings.
> 
> This patch allows to select flash node at runtime.
> 
> Boards those are supporting multiple flashes
> needs to implement cadence_qspi_get_subnode function and return correct
> flash node.
> 
> Cc: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> One of such platform is J721S2 EVM
> link https://www.ti.com/lit/pdf/spruj67

I think this link is wrong, may be you mean
https://www.ti.com/lit/pdf/spruj69

> Fig 3.1, Page 18 has details of two flashes connected with one controller.
> 
>   drivers/spi/cadence_qspi.c | 7 ++++++-
>   drivers/spi/cadence_qspi.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index cc3a54f295..7a02ceed10 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -40,6 +40,11 @@ __weak int cadence_qspi_versal_flash_reset(struct udevice *dev)
>   	return 0;
>   }
>   
> +__weak ofnode  cadence_qspi_get_subnode(struct udevice *dev)

Extra space after ofnode.

> +{
> +	return dev_read_first_subnode(dev);
> +}
> +
>   static int cadence_spi_write_speed(struct udevice *bus, uint hz)
>   {
>   	struct cadence_spi_priv *priv = dev_get_priv(bus);
> @@ -401,7 +406,7 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
>   	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
>   
>   	/* All other parameters are embedded in the child node */
> -	subnode = dev_read_first_subnode(bus);
> +	subnode = cadence_qspi_get_subnode(bus);
>   	if (!ofnode_valid(subnode)) {
>   		printf("Error: subnode with SPI flash config missing!\n");
>   		return -ENODEV;
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 1c59d1a9d9..12825f8911 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -304,6 +304,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
>   int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
>   int cadence_qspi_versal_flash_reset(struct udevice *dev);
> +ofnode cadence_qspi_get_subnode(struct udevice *dev);
>   void cadence_qspi_apb_enable_linear_mode(bool enable);
>   
>   #endif /* __CADENCE_QSPI_H__ */

But otherwise
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
