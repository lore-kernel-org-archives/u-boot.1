Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3621AC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4020877FD;
	Tue,  9 Jan 2024 15:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ajxIRX1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2472C87871; Tue,  9 Jan 2024 15:24:05 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0ECA877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409EO1kn015353;
 Tue, 9 Jan 2024 08:24:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704810241;
 bh=lnbSa6uXIaZ6Auvie1cjbl6Ea+OfNlms1Lwljncq2kQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ajxIRX1pVxdDrvGMUuIVzc6cDRWc4NL5gZAw9q+fpfwvOMBo5toLI2TtNv4DYifko
 /q9aN4TxKcCITeyWl03uMKyiY9e6PhvES1oTmN2GEfhSyTqli2VwVEaI1cV/6ebxZc
 w+5Twl9nnJXug/rJAvQZcb7+2iTB+mUQ8stdh7bk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409EO1ow038098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:24:01 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:24:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:24:00 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409EO0hl087214;
 Tue, 9 Jan 2024 08:24:00 -0600
Date: Tue, 9 Jan 2024 08:24:00 -0600
From: Nishanth Menon <nm@ti.com>
To: Sekhar Nori <nsekhar@ti.com>
CC: Tom Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, U-Boot
 Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arch: mach-k3: Fix incorrect mapping of higher DDR
 addresses as device memory
Message-ID: <20240109142400.kxpxovrd4ngroghw@empathy>
References: <20240109084551.21155-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109084551.21155-1-nsekhar@ti.com>
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

On 14:15-20240109, Sekhar Nori wrote:
> Entry for physical address 0x500000000 in memory map table for MMU
> configuration is spilling over and inadvertently making DDR available at
> higher address (above 4GB address space) get mapped as device memory
> (nGnRnE).
> 
> Fix this by adjusting entry size. Tested on AM62A SK. Before this patch:
> 
> => time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff ==> 7f34d7ca
> 
> time: 1 minutes, 14.716 seconds
> 
> After patch:
> 
> => time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff ==> 7f34d7ca
> 
> time: 2.710 seconds
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Applies to u-boot/next
> 
>  arch/arm/mach-k3/arm64-mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
> index b4308205b2..0e07b1b7ce 100644
> --- a/arch/arm/mach-k3/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64-mmu.c
> @@ -41,7 +41,7 @@ struct mm_region k3_mem_map[] = {
>  	}, {
>  		.virt = 0x500000000UL,
>  		.phys = 0x500000000UL,
> -		.size = 0x400000000UL,
> +		.size = 0x380000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -- 
> 2.40.0
> 

Thanks.

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
