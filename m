Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B302CCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893E58394A;
	Wed,  8 Oct 2025 14:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i0Y4yKMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98DC839DE; Wed,  8 Oct 2025 14:44:51 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382A68393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598CilUf4039851;
 Wed, 8 Oct 2025 07:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759927487;
 bh=4EHjx8DajQfHM6CNAc7+bCv3I8C1/J99j0bq+9Ul+C0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=i0Y4yKMbMD9FzLeCHoEbukPcg8uvJ5ozCIx2AUKj7XrX9LrKeOyqktxQ6Ne8tZ5fy
 eEdFZQ85eOtrrCKuBduTEyeN1H10+gMSUF8kjg5zMjPXfXXlDmHaZn7gESoP2n10C7
 yUZ1yEluPBlbB0wpuyfqLT0cxxCpF+XooM8Jv8Z8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598Cilb23724857
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 07:44:47 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 07:44:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 07:44:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598CilIv2546745;
 Wed, 8 Oct 2025 07:44:47 -0500
Date: Wed, 8 Oct 2025 07:44:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH -next] arm: dts: k3-am654: add vin-supply regulators for
 DDR
Message-ID: <20251008124447.b4l34thkb52qozil@volatile>
References: <20251003-654-next-fix-v1-1-55d803b07d6e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003-654-next-fix-v1-1-55d803b07d6e@ti.com>
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

On 07:15-20251003, Bryan Brattlof wrote:
> As of f98d812e53534 ("power: regulator: Add vin-supply for GPIO and Fixed regulators")
> we must ensure the parent nodes of a regulator are present in DT if
> they are described in the vin-supply property
> 
> For the am65x reference board the DRAM chips are fed by the 3v3 rail
> which is fed by the main 12v rail. Add the bootph properties to these
> DT nodes to prevent them from being pruned during the SPL build so we
> can enable power to the DRAM chips
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> index 4fd188fa191b469d69b461b49b17635f914eb53e..baf5dd562f99310f3c8fe1d272cea2fd85164be0 100644
> --- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> @@ -17,6 +17,14 @@
>  	bootph-all;
>  };
>  
> +&evm_12v0 {
> +	bootph-all;
> +};
> +
> +&vcc3v3_io {
> +	bootph-all;
> +};
> +
>  &vtt_supply {
>  	bootph-all;
>  };
> 
> ---
> base-commit: aff68c8514858ddd8d2e508d47bede566511521b
> change-id: 20251002-654-next-fix-985fc18d370b


Tom,

we have had a boot regression on AM654x-IDK for a while now. this patch fixes the same.

https://gist.github.com/nmenon/582820aa718a7d2f8939d6676f70d917

Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
