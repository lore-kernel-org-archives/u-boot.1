Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D524C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8374988208;
	Tue, 28 May 2024 12:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="q1V/t7hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44835883A5; Tue, 28 May 2024 12:32:50 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAED787EAC
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 211731485AE7; Tue, 28 May 2024 12:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1716892366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=V6d4xcHIVpbCZ9nc/7Crn8dCR0Ldgu7sXPyE5Cg0B60=;
 b=q1V/t7hlwiL3LPaCHBMJtRbs93WYoeoR4BwF2djvPf+ur6YdJTRKoH2wSipzdLIDZFuNhX
 p+Ayx6s+hgploRxwl5etgaK82YBGhPSvKWM7P9vDUz1hTeDuAmslGTu+yAt16H9I2VSCb+
 0D2HJ+GlT6Du6VPCAj8R+QpwO1AHSyxzk7nq3AdC2pDGDPAPX5SFbXqxC8J/yXpE4yReBF
 ycNmbMQZv5f2hCP4KWp96PJ9gEyO44CnKrLI1U5nEV5HHCsWCryvhfs09OfO5gdZ0Mg3+i
 A/vPq8zAcYCljrubkABw2N3cdWEAk+4Fg6I9ShgQz8v5f/fX2CzEhde0HrZ4qQ==
Date: Tue, 28 May 2024 12:32:44 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Message-ID: <20240528-among-detective-e8ad4c9b5457@thorsis.com>
Mail-Followup-To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415075755.780653-1-ada@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hei hei,

Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
> From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
> like we have to wait tREA after rising RE# before sampling the data.
> Thus pulse time must be at least tREA.
> 
> Without this fix we got PMECC errors when reading, after switching to
> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
> 
> The approach to set timings used before worked on sam9g20 and sama5d2
> with the same flash (S34ML02G1), probably because those have a slower
> mck clock rate and thus the resolution of the timings setup is not as
> tight as with sam9x60.
> 
> The approach to fix the issue was carried over from at91bootstrap, and
> has been successfully tested in at91bootstrap, U-Boot and Linux.
> 
> Link: https://github.com/linux4sam/at91bootstrap/issues/174
> Cc: Li Bin <bin.li@microchip.com>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
> 
> Notes:
>     v3:
>     - initial patch version (not present in v1 and v2)

This patch was send as part of a series, which you wanted to have some
more time to test.  Besides that, has anyone looked into this
particular fix?  Maybe it can be applied separately?

Greets
Alex

> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index bbafc88e44c..00ffeadd113 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>  					  const struct nand_data_interface *conf,
>  					  struct atmel_smc_cs_conf *smcconf)
>  {
> -	u32 ncycles, totalcycles, timeps, mckperiodps;
> +	u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
>  	struct atmel_nand_controller *nc;
>  	int ret;
>  
> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>  			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
>  
>  	/*
> -	 * Read pulse timing directly matches tRP:
> +	 * Read pulse timing would directly match tRP,
> +	 * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
> +	 * do not work properly in timing mode 3.
> +	 * The workaround is to extend the SMC NRD pulse to meet tREA
> +	 * timing.
>  	 *
> -	 * NRD_PULSE = tRP
> +	 * NRD_PULSE = max(tRP, tREA)
>  	 */
> -	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
> +	pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
> +	ncycles = DIV_ROUND_UP(pulse, mckperiodps);
>  	totalcycles += ncycles;
>  	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
>  					  ncycles);
> -- 
> 2.39.2
> 

-- 
Alexander Dahl           Thorsis Technologies GmbH   T +49 391 544 563 1000
Industrieautomation      Oststr. 18                  F +49 391 544 563 9099
T +49 391 544 563 3036   39114 Magdeburg             https://www.thorsis.com/

Sitz der Gesellschaft: Magdeburg
Amtsgericht Stendal HRB 30646
Geschäftsführer: Dipl.-Inf. Michael Huschke
