Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46964C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6E488349;
	Wed,  1 May 2024 22:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r0nwXLuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268DF88349; Wed,  1 May 2024 22:06:56 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9BF8831B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441K6odd051981;
 Wed, 1 May 2024 15:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714594010;
 bh=aBDotIHP8RkBokd7k5SuHowoCFA2TvmWt2y246yF1sQ=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=r0nwXLuUbuAphq9m4F8I5fq6g2w3HTldef2Kv9Uvp4m80k1EqY1alK6y/7DjoMb9o
 q1F7Eh20aPZE6B86FTCo68EwjLkyAKL9BQSvADodjzYZOsZjc2OgkTng+94kje4Y7z
 xntv6sgO28OUFT6tL5D2EjEbUZH+gaXUrTQIf5RA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441K6ob1003303
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 May 2024 15:06:50 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 15:06:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 15:06:49 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441K6ngT021679;
 Wed, 1 May 2024 15:06:49 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, Ian Roberts
 <ian.roberts@timesys.com>, Greg Malysa <greg.malysa@timesys.com>, "Jaehoon
 Chung" <jh80.chung@samsung.com>, <u-boot@lists.denx.de>
CC: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
In-Reply-To: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
References: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
Date: Wed, 1 May 2024 15:06:49 -0500
Message-ID: <86wmode1pi.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

"A. Sverdlin" <alexander.sverdlin@siemens.com> writes:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Commit 37cb626da25d0d ("mmc: sdhci: Add Support for ADMA2") introduced
> ADMA_DESC_LEN == 16 (64 bit case), but it was never used before commit
> 74755c1fed1b0 ("mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops").
>
> "sizeof(struct sdhci_adma_desc)" (== 12 for 64bit case) was used instead.
>
> Confusion probably originates from Linux commit 685e444bbaa0
> ("mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode"), but
> the latter "V4 mode" was never ported to U-Boot.
>
> Fixes: 74755c1fed1b0 ("mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  include/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/sdhci.h b/include/sdhci.h
> index d73a725609be3..810ef56e4be66 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -300,7 +300,7 @@ struct sdhci_ops {
>  
>  #define ADMA_MAX_LEN	65532
>  #ifdef CONFIG_DMA_ADDR_T_64BIT
> -#define ADMA_DESC_LEN	16
> +#define ADMA_DESC_LEN	12
>  #else
>  #define ADMA_DESC_LEN	8
>  #endif
> -- 
> 2.44.0

on TI AM64 and AM62p platforms:

Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
