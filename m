Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6240DC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB9A87D7E;
	Wed,  6 Mar 2024 14:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lM/SHBEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0293F87E03; Wed,  6 Mar 2024 14:37:35 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EB886FB2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426DbTuU090461;
 Wed, 6 Mar 2024 07:37:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709732249;
 bh=pXCJx05JIq1pCeR1C7Jk2uUn/wk2IShUIkGRZkXY06M=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lM/SHBEko6Bgfze2BFbgzcPOskU64J+stpH0QYZdZWaEd/FoCWvdiV6mAAstCayFm
 nL0oP+naiz3cPyo1jwY/pSe60A+rucWGb3u1w/QAtD4EH4NeKOUllhHgkjtJUBwEIm
 BV75vVCLfbeVApv9uQOEf0jKU8qra+9S7BwtFrKM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426DbTxQ030607
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 07:37:29 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:37:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:37:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426DbTrg031157;
 Wed, 6 Mar 2024 07:37:29 -0600
Date: Wed, 6 Mar 2024 07:37:29 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 6/6] arm: mach-k3: Move DRAM address of ATF for AM62/AM62a
Message-ID: <20240306133729.lh2aodg356dltvs7@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-7-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-7-afd@ti.com>
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

On February 14, 2024 thus sayeth Andrew Davis:
> The current address of TF-A in DRAM is just below the 512MB address line.
> This means if the DRAM in a system is 512MB then TF-A is right at the
> end of memory which is often reused, for instance U-Boot relocates itself
> here. If a system has less than 512MB then that system wouldn't work at
> all as TF-A would fail to load.
> 
> To avoid the issues above, move TF-A to the start of DRAM, which doesn't
> change from system to system.
> 
> As TF-A is position independent, this has no dependency on TF-A. We
> also fixup DT as needed when TF-A address is moved, so this change also
> has no dependency on Linux and is fully forward/backward compatible.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Bryan Brattlof <bb@ti.com>

Thanks for this! This will make adding SIP support much easier.

~Bryan

> ---
>  arch/arm/mach-k3/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 55bb874d9aa..33f20f61f83 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -123,7 +123,7 @@ config SYS_K3_SPL_ATF
>  
>  config K3_ATF_LOAD_ADDR
>  	hex "Load address of ATF image"
> -	default 0x9e780000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
> +	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
>  	default 0x70000000
>  	help
>  	  The load address for the ATF image. This value is used to build the
> -- 
> 2.39.2
> 
