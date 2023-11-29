Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92490C07CB1
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 08:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D9586DB1;
	Wed, 29 Nov 2023 09:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Oc6TYm94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5D486F7E; Wed, 29 Nov 2023 09:00:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F11586D34
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AT80JGN097699;
 Wed, 29 Nov 2023 02:00:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701244819;
 bh=AFTV6urka/MQqr2sU0rNamXPv8nfxRP0xxxbsZ5SGJg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Oc6TYm94EQmQTrpo9W3qP7Ubc9f9H2TqaOUmUCnIDjfSbz9EGAvVLsXTgMsPkhUrR
 hbmqVxkh7F/A6126pfZlpVfqM4DwKY/l2i+21VrKdMZxzwUHbZ3UxPNP3nbCAUm+iR
 pp7GsX4m6oKkF9NyULNzJl8m3cPg2kJWKLZMaTac=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AT80JiF120064
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Nov 2023 02:00:19 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Nov 2023 02:00:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Nov 2023 02:00:18 -0600
Received: from [172.24.227.49] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AT80FnS037546;
 Wed, 29 Nov 2023 02:00:16 -0600
Message-ID: <2c6f7369-ff74-455d-a3f3-d40abde033de@ti.com>
Date: Wed, 29 Nov 2023 13:30:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm: mach-k3: Do not map ATF and OPTEE regions in
 MMU
To: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-3-afd@ti.com>
Content-Language: en-US
From: Manorit Chawdhry <m-chawdhry@ti.com>
In-Reply-To: <20231128170528.407707-3-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Andrew,

On 28/11/23 22:35, Andrew Davis wrote:
> ATF and OPTEE regions may be firewalled from non-secure entities. To
> prevent access to this area we leave a hole there in the MMU map. This
> is the same idea as [0] but we complete that patch by adding the same
> for AM65, J721e, J7200, and J721s2 here.
>
> [0] commit 0688ff3ae23c ("arm: mach-k3: arm64-mmu: do not map ATF and OPTEE regions in A53 MMU")
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/arm64-mmu.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
> index d872ed714c4..5c858ae0f84 100644
> --- a/arch/arm/mach-k3/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64-mmu.c
> @@ -24,7 +24,7 @@ struct mm_region am654_mem_map[] = {
>  	}, {
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x1e780000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  			 PTE_BLOCK_INNER_SHARE
>  	}, {
> @@ -75,7 +75,7 @@ struct mm_region j7200_mem_map[] = {
>  	}, {
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x1e780000UL,

ATF lies 0x70000000 for j7 devices.

For reference.

configs/am62ax_evm_a53_defconfig:8:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000                                                                                                                 
 
configs/verdin-am62_a53_defconfig:11:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000                                                                                                               
 
configs/am64x_evm_a53_defconfig:11:8:CONFIG_K3_ATF_LOAD_ADDR=0x701c0000  -> This
is also different
                                                                                                               

configs/am62x_beagleplay_a53_defconfig:9:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000                                                                                                            
configs/am62x_evm_a53_defconfig:8:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000

and rest all devices use 0x70000000

OP-TEE is consistent across all SoCs and lies at 9e800000 and I can see that
removing the map after 9e780000 does
handle that but am not sure if I see the ATF being unified with all this flow.

Regards,
Manorit

>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  			 PTE_BLOCK_INNER_SHARE
>  	}, {
> @@ -123,7 +123,7 @@ struct mm_region j721e_mem_map[] = {
>  	}, {
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x1e780000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  			 PTE_BLOCK_INNER_SHARE
>  	}, {
> @@ -180,7 +180,13 @@ struct mm_region j721s2_mem_map[] = {
>  	}, {
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x80000000UL,
> +		.size = 0x1e780000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0xa0000000UL,
> +		.phys = 0xa0000000UL,
> +		.size = 0x60000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  			 PTE_BLOCK_INNER_SHARE
>  	}, {
