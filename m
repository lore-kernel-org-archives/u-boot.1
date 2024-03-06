Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFDCC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826D687DA1;
	Wed,  6 Mar 2024 14:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IzF/m0B6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9016887DE2; Wed,  6 Mar 2024 14:27:15 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D78287C35
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426DR9r0115752;
 Wed, 6 Mar 2024 07:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709731629;
 bh=r2ppSLh+OR+vCTUMnasZtjM7G8hj+lTp6BePn9u4xwo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IzF/m0B6BLdf0WcpdoxAQmFZyKYmMeOYoH0ql5Ux6Z0YMPGlT4Htux9mk+Oqq5rhB
 6rfuwXjGbvB7QINrs3nboyVGpM8z+iIfaRQ2ct2g4q0JvLDwYnBJMUqFIlfXCFgGLG
 gpKbp7rtAnWL1LTFHQUi5Suhfcz0D2kIazWA6QKs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426DR9aK021937
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 07:27:09 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:27:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:27:09 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426DR97c018232;
 Wed, 6 Mar 2024 07:27:09 -0600
Date: Wed, 6 Mar 2024 07:27:09 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
Message-ID: <20240306132709.bczkn3ku7qdhkxgt@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-2-afd@ti.com>
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
> There is a default ATF load address that is used for devices that have
> ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
> of having to override the address in every defconfig, make add a
> default for these ATF in DRAM devices.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Bryan Brattlof <bb@ti.com>

> ---
>  arch/arm/mach-k3/Kconfig               | 5 +++--
>  configs/am62ax_evm_a53_defconfig       | 1 -
>  configs/am62x_beagleplay_a53_defconfig | 1 -
>  configs/am62x_evm_a53_defconfig        | 1 -
>  configs/phycore_am62x_a53_defconfig    | 1 -
>  configs/verdin-am62_a53_defconfig      | 1 -
>  6 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 03898424c95..0bd3f9fa12d 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -123,10 +123,11 @@ config SYS_K3_SPL_ATF
>  
>  config K3_ATF_LOAD_ADDR
>  	hex "Load address of ATF image"
> +	default 0x9e780000 if (SOC_K3_AM625 || SOC_K3_AM62A7)

I went ahead an added this to the TODO for 62p's respin

~Bryan
