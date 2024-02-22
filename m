Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3907C54798
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 15:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC4587C80;
	Thu, 22 Feb 2024 16:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ivT4V8Ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31F887C63; Thu, 22 Feb 2024 16:42:17 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF8287ABC
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 16:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MFgDtU086767
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 09:42:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708616533;
 bh=8Cw3gdScaCFX1Y2DUw7OcdSHFj7GwyKbsCBFJ6QRifU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ivT4V8Ne9mtIBimzRD3hZTNHYmCSIxG95BImATkXen+r4Nuboa5gqOn8S4yFMZryE
 k8osifJnTLNIedvahM3hX7RvYHHaSoURdesXOdQ61Xr2KIxWfPNbGM1BLMU4FcIvJx
 EmjkCRmJPHefdlmami2tvW1V0x4GlWibW7EJvE34=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MFgDfi059403
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 09:42:13 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 09:42:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 09:42:12 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MFgClt048773;
 Thu, 22 Feb 2024 09:42:12 -0600
Date: Thu, 22 Feb 2024 09:42:12 -0600
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <afd@ti.com>, <kamlesh@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH] arch: mach-k3: fix mapping higher DDR addresses as
 device memory
Message-ID: <20240222154212.qpymyhdtbyy3a6ma@phantom>
References: <20240222064556.1051458-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222064556.1051458-1-n-francis@ti.com>
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

On 12:15-20240222, Neha Malcom Francis wrote:
> From: Sekhar Nori <nsekhar@ti.com>
> 
> An entry in memory map table for MMU configuration is spilling over and
> inadvertently mapping DDR available at higher address (above 4GB address
> space) as device memory (nGnRnE).
> 
> Fix this by adjusting entry size. Tested on AM62A SK by enabling
> CONFIG_CMD_TIME. Before this patch:
> 
> => time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff ==> 5a7a5760
> 
> time: 1 minutes, 14.715 seconds
> 
> After patch:
> 
> => time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff ==> 3df1ce02
> 
> time: 2.711 seconds
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> [n-francis@ti.com: rebased on next, retested on all devices inc. commit]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Cc: Andrew Davis <afd@ti.com>
> ---
> Boot logs:
> https://gist.github.com/nehamalcom/7b101ea8b97f5a9433a553ef881166a1
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
> 2.34.1
> 
https://lore.kernel.org/u-boot/20240119160900.GU12635@bill-the-cat/ ??

Something was missing?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
