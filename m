Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4DDC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D877788348;
	Thu,  2 May 2024 16:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GOjUsaT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92DE88363; Thu,  2 May 2024 16:21:16 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9523A88339
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 16:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 442ELDiC105011;
 Thu, 2 May 2024 09:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714659673;
 bh=vyoGJ4EmUAbHxuPcMT8gOZI+WD5uXCFoualWspjiIcA=;
 h=Date:Subject:To:References:CC:From:In-Reply-To;
 b=GOjUsaT2U2ZzPinBqK7Byeflog3stkwZEBL8xDCUpdWy5aVfPN+4eZ0ngCumFvWC4
 on5Ufye/9dOAI7Am+ljT1eR9XNDGpJ71C5ki7kfBP8CcENfycSQeUCTp8aQGOksffF
 Lgy0h0x7g/FCs0XCqMqRfbzyrZACntFF/7q2sA1Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 442ELDYf001433
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 May 2024 09:21:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 09:21:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 09:21:12 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 442ELCHF014691;
 Thu, 2 May 2024 09:21:12 -0500
Message-ID: <087f03f8-61bc-437b-81fe-9229a6afa8d3@ti.com>
Date: Thu, 2 May 2024 09:21:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, <u-boot@lists.denx.de>
References: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
CC: Ian Roberts <ian.roberts@timesys.com>, Greg Malysa
 <greg.malysa@timesys.com>, Jaehoon Chung <jh80.chung@samsung.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
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

Hi,

On 5/1/24 1:53 PM, A. Sverdlin wrote:
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
>   include/sdhci.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sdhci.h b/include/sdhci.h
> index d73a725609be3..810ef56e4be66 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -300,7 +300,7 @@ struct sdhci_ops {
>   
>   #define ADMA_MAX_LEN	65532
>   #ifdef CONFIG_DMA_ADDR_T_64BIT
> -#define ADMA_DESC_LEN	16
> +#define ADMA_DESC_LEN	12
>   #else
>   #define ADMA_DESC_LEN	8
>   #endif

on TI AM62 platform:

Tested-by: Judith Mendez <jm@ti.com>

