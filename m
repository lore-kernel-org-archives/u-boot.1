Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF0C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD27883B1A;
	Thu,  7 Aug 2025 06:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iqwamw2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5942B83B27; Thu,  7 Aug 2025 06:22:01 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E192B83AFD
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 06:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5774Lu7u667460;
 Wed, 6 Aug 2025 23:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754540516;
 bh=Qxa//e5t6+h/kypndl1nFFv7fIFiSiyH2OUQbwzFq9Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iqwamw2Dkr1kEMYorDERugzArmBGbwfqWevtEIFSuN52DD3K3drbtiePl1MZzm9ii
 gaYgMqs/ek5l6UW9pC816kNYYND2EVdzKENldsa8Ov7IUO6LB3zBGVIDd3rHNJhclb
 UeQ0YTVPjvxJuK4W2o9Qw5mLt62maWMbRGQbguyY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5774Luh3529025
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 23:21:56 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 23:21:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 23:21:55 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5774LqBk424314;
 Wed, 6 Aug 2025 23:21:53 -0500
Message-ID: <da36b723-14d4-4f82-a8d4-43abd4683d4f@ti.com>
Date: Thu, 7 Aug 2025 09:51:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ram: k3-ddrss: Use DDR address instead of system
 address for ecc_regions
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <sabiya.d@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250730133720.3315478-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Neha

On 7/30/2025 7:07 PM, Neha Malcom Francis wrote:
> Let ecc_regions[x].start reflect the start of the ECC region in terms of
> DDR addressing rather than system addressing. This will make it easier
> to extend the usage of the same ecc_regions structure for multi-DDR
> systems as well.

comments are not inline with patch contents ,

LTM, you are doing clean up how ecc_regions[0].start is being used.

Originally ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];

and while using it  we did (ecc_region_start - ddrss->ddr_bank_base[0])

other then that I don't see we are using ecc_region_start anywhere.

With update in commit message , Please use


Reviewed-by: Udit Kumar <u-kumar1@ti.com>



> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 6590d57ad84..7389fd8b82f 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -752,7 +752,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   	u32 val;
>   
>   	/* Only Program region 0 which covers full ddr space */
> -	k3_ddrss_set_ecc_range_r0(base, ecc_region_start - ddrss->ddr_bank_base[0], ecc_range);
> +	k3_ddrss_set_ecc_range_r0(base, ecc_region_start, ecc_range);
>   
>   	/* Enable ECC, RMW, WR_ALLOC */
>   	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
> @@ -817,7 +817,7 @@ static int k3_ddrss_probe(struct udevice *dev)
>   		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>   
>   		/* Always configure one region that covers full DDR space */
> -		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
> +		ddrss->ecc_regions[0].start = 0;
>   		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
>   		k3_ddrss_lpddr4_ecc_init(ddrss);
>   	}
