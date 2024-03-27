Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A16ACD1283
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3518800D;
	Wed, 27 Mar 2024 12:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pt5PKvMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3607E88073; Wed, 27 Mar 2024 12:21:46 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C3287E47
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42RBLG0U106507;
 Wed, 27 Mar 2024 06:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711538476;
 bh=Gj+AjcGTrQlbTRtZXFgftontx/OE/A6nH2r1rIy59zg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pt5PKvMcSfaDDDYitFpA26Vpmv5C56VdNBcCgUWOzsw+OFESophl/dUQkdQNzJISb
 uN65P5vXc9vyhCOkJtPzPM2ysa79Pg00vDFafbyqiEx+wFLPyrCRILoTrIejR9GeN5
 oca6snyVYkFsIlOm3iFxzSNh8ebvJBTifqcToPjk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42RBLGUw114202
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Mar 2024 06:21:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 06:21:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 06:21:15 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42RBLBS8014533;
 Wed, 27 Mar 2024 06:21:11 -0500
Message-ID: <a281c494-d04d-1757-0f01-12e1a9fa2111@ti.com>
Date: Wed, 27 Mar 2024 16:51:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] spl: Introduce SoC specific init function
Content-Language: en-US
To: <lukas.funke-oss@weidmueller.com>, <u-boot@lists.denx.de>
CC: Lukas Funke <lukas.funke@weidmueller.com>, Andre Przywara
 <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>, Chanho Park
 <chanho61.park@samsung.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
 <20240327104638.2432672-2-lukas.funke-oss@weidmueller.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240327104638.2432672-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
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



On 27/03/24 16:16, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Some architectures use spl_board_init() in their SoC specific
> implementation. Board developers should be able to add board specific
> implementation via spl_board_init(). Hence, introduce a spl_soc_init()
> method which is called right before spl_board_init() for SoC
> specific implementation.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>  common/spl/Kconfig | 7 +++++++
>  common/spl/spl.c   | 3 +++
>  include/spl.h      | 8 ++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 6405374bcc..9b5cc8daa7 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -272,6 +272,13 @@ config SPL_TEXT_BASE
>  	help
>  	  The address in memory that SPL will be running from.
>  
> +config SPL_SOC_INIT
> +	bool "Call arch-specific initialization in SPL"

Call SoC specific intialization in SPL

With above change,
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> +	help
> +	  If this option is enabled, U-Boot will call the function
> +	  spl_soc_init() from board_init_r(). This function should be
> +	  provided by the architecture.
> +
>  config SPL_BOARD_INIT
>  	bool "Call board-specific initialization in SPL"
>  	help
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index b65c439e7a..9b83c85df5 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -711,6 +711,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  		}
>  	}
>  
> +	if (CONFIG_IS_ENABLED(SOC_INIT))
> +		spl_soc_init();
> +
>  	if (CONFIG_IS_ENABLED(BOARD_INIT))
>  		spl_board_init();
>  
> diff --git a/include/spl.h b/include/spl.h
> index 043875f10f..5dfdf778d2 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -816,6 +816,14 @@ int spl_early_init(void);
>   */
>  int spl_init(void);
>  
> +/*
> + * spl_soc_init() - Do architecture-specific init in SPL
> + *
> + * If SPL_SOC_INIT is enabled, this is called from board_init_r() before
> + * jumping to the next phase.
> + */
> +void spl_soc_init(void);
> +
>  /*
>   * spl_board_init() - Do board-specific init in SPL
>   *
