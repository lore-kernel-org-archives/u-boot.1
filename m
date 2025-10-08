Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F26CCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E931183D77;
	Wed,  8 Oct 2025 15:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b1YaTQzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4479B83E8E; Wed,  8 Oct 2025 15:53:41 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE3B83C91
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598DrXrW309183;
 Wed, 8 Oct 2025 08:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759931613;
 bh=42LgPW1dZ9Z6GrpTUuhy7+xZBC/lR7THXwgSOq5EMc4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=b1YaTQzIb2qPRBZ8IoTkA/Trsf26XVKY3P7r7VA5vUITbifyYp24hS/xkG3eENIyd
 LCgln5zj+KAKRa5wqrklDE3zIJxthZKd7Gg2KtyBKg0I5bGpqhAwwqysLPE2ceofx2
 ez4t49OYdtHmozF7wSscJVjrRE4THIriJnFiLU/s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598DrXhZ1497305
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 08:53:33 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 08:53:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:53:33 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598DrW3v2867975;
 Wed, 8 Oct 2025 08:53:32 -0500
Date: Wed, 8 Oct 2025 19:23:31 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 11/11] arm: mach-k3: reserve space for page
 table entries
Message-ID: <20251008135331.ypddmszr34e2b4yd@lcpd911>
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-12-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006082852.4008937-12-anshuld@ti.com>
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

On Oct 06, 2025 at 13:58:49 +0530, Anshul Dalal wrote:
> With the memory map configuration being done dynamically, reserve extra
> space during U-Boot relocation to ensure we have enough for the fixups.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/arm64/arm64-mmu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
> index 479451452a2..f999af143fb 100644
> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
> @@ -41,3 +41,8 @@ struct mm_region k3_mem_map[K3_MEM_MAP_LEN] = {
>  };
>  
>  struct mm_region *mem_map = k3_mem_map;
> +
> +u64 get_page_table_size(void)
> +{
> +	return SZ_128K;
> +}

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
