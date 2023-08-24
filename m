Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD8C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8828083C;
	Thu, 24 Aug 2023 14:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m0cZBqon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2431283F7D; Thu, 24 Aug 2023 14:14:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5674E805C2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OCECNb002615;
 Thu, 24 Aug 2023 07:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692879252;
 bh=PCnoMEugmOHJinW1XvY/st3T5xzdV3yocc4AXMeX+Eg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=m0cZBqon/QVyXxLI1qcKUqhvUHgjqafAA+4mp9DILkjibYBJliXv7ohBj+Pjptj2l
 q1XKSyPIpRsNsnyh3LQT+yngDY7ZI3l5nZzxNQkSnllrlIwVhPaXOz0tkrHKlzJYAL
 YytCJxs7pTahz8kiK2bTHna0vxNUbDNDynA1bT50=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OCECRT014050
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 07:14:12 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 07:14:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 07:14:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OCECSa107699;
 Thu, 24 Aug 2023 07:14:12 -0500
Date: Thu, 24 Aug 2023 07:14:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
CC: <u-boot@lists.denx.de>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/2] board: verdin-am62: fix check for minimum memory
 size
Message-ID: <20230824121412.vxgvwo5g2ozk62xt@evergreen>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
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

On 10:08-20230824, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> verdin am62 SKUs comes in multiple memory configuration, check that
> the detected memory is at least 512MB since we have some
> reserved memory just before this threshold and therefore
> the module cannot work with less memory.
> 
> Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
>  board/toradex/verdin-am62/verdin-am62.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> index a3d1d07a0cbf..d09dda5bccc9 100644
> --- a/board/toradex/verdin-am62/verdin-am62.c
> +++ b/board/toradex/verdin-am62/verdin-am62.c
> @@ -28,8 +28,8 @@ int dram_init(void)
>  {
>  	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
>  
> -	if (gd->ram_size < SZ_64M)
> -		puts("## WARNING: Less than 64MB RAM detected\n");
> +	if (gd->ram_size < SZ_512M)
> +		puts("## WARNING: Less than 512MB RAM detected\n");


Have you considered fdtdec_setup_mem_size_base
fdtdec_setup_memory_banksize  - in which case the reserved memory
regions can be changed in dt (will need corresponding custom binaries
ofcourse)..

>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
