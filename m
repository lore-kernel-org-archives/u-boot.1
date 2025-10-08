Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB64CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2323A83E8E;
	Wed,  8 Oct 2025 17:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j9E2+DWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4142A84014; Wed,  8 Oct 2025 17:03:16 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04E2839DE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598F34LD3999442;
 Wed, 8 Oct 2025 10:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759935784;
 bh=JaOI9UQLW0VH3e2FpSsbFIwbu9YIP40jcgHyQAVlJOg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=j9E2+DWTZNuDOpKmWm2Sqlij1q6kGLZFujfns9OIHL+FNE1IkUZyKrPT8SH+b7U9/
 rqf+ZhOx5veaRhUB9DSyWW8UFqx0neic117jayBVyxv1rqsyQovKBgE7EchBaDZ465
 LBWnjtVSpeWkrO9XTA9F5DxTSQ2ec08FT8xLnF60=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598F341N725540
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 10:03:04 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 10:03:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 10:03:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598F336F2727058;
 Wed, 8 Oct 2025 10:03:03 -0500
Date: Wed, 8 Oct 2025 10:03:03 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 11/11] arm: mach-k3: reserve space for page
 table entries
Message-ID: <20251008150303.zzf4vxshdap3pdpb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-12-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On October  6, 2025 thus sayeth Anshul Dalal:
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

How are we calculating this size? With 2^39 addresses this should bring 
us into the MBs of TLB data. 

I see we limit U-Boot to 512 entries, but that doesn't match this either

~Bryan
