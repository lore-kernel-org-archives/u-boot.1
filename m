Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6634E6C61A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC7B895F7;
	Tue,  3 Dec 2024 10:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qHbGcizP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FBE89618; Tue,  3 Dec 2024 10:01:56 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E465895CE
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B391gPG1425443
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2024 03:01:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733216502;
 bh=6k7EefgXpkJWKBjuFmahoR4u3Z7M8bjoSPoIznaEtt0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qHbGcizPOhBs0ZQQSyIAG3vUElSY3qPddpT12lWc8jump2mkp8V9ZbUL+wf1nREY0
 9WrlWp9UQpwa9xkUBBJWG5npeF+HWp7wm8W8+VycjTA9PQ98hUqLb52BewdFO4HPVP
 ynBHuS6np8UZuA55dIoxELEmzC3CTSSj8QAiMHK4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B391gEJ005413
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Dec 2024 03:01:42 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 03:01:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 03:01:42 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B391fij014871;
 Tue, 3 Dec 2024 03:01:41 -0600
Date: Tue, 3 Dec 2024 14:31:40 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <j-humphreys@ti.com>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>,
 <stefan_b@posteo.net>, <quentin.schulz@cherry.de>,
 <tudor.ambarus@linaro.org>, <Takahiro.Kuwano@infineon.com>,
 <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Message-ID: <20241203090140.x55lecs5dy4ecnna@prasanth-server>
References: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 15:52, Venkatesh Yadav Abbarapu wrote:
> Enable mt35xu512aba_fixups for all mt35 series flashes to work
> in DTR mode, and return after nor->fixups is updated, otherwise
> it will get overwritten with macronix_octal_fixups.
> This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
> is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the SPI_XFER_SET_DDR flag.
> ---
>  drivers/mtd/spi/spi-nor-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..96f749f7a8 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4404,8 +4404,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>  #endif
>  
>  #ifdef CONFIG_SPI_FLASH_MT35XU
> -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> +	    !strcmp(nor->info->name, "mt35xu01g") ||
> +	    !strcmp(nor->info->name, "mt35xu02g")) {
>  		nor->fixups = &mt35xu512aba_fixups;
> +		return;
> +	}
>  #endif
>  
>  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> -- 
> 2.34.1
> 

Reviewed-by: Prasanth Babu Mantena <p-mantena@ti.com>
