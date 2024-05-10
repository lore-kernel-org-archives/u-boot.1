Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A78C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 12:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0D5884B0;
	Fri, 10 May 2024 14:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kLM7glrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718F8884B1; Fri, 10 May 2024 14:22:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFDC880A8
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 14:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ACMNCN053197;
 Fri, 10 May 2024 07:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715343743;
 bh=nIARaKsQ4yaaB8R4IBLGVoVgXkne0Abd0tJXAyN4I70=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kLM7glrgLXTCjCiojoDmlM0KjsYTSk1CY9Oo6sGWTy0Dco4I9RaSsvJj1jm61vfGS
 gOrszgGAB4FXUjThb7DIImLOGifNw37Y4q6BmXH/EDl3tSvFilfKdVa/TM0eLyrHS/
 vSLmN28wwBbGtSps8YYhOEx7P70a/MUOtWa8yW+c=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ACMMX2060739
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 07:22:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 07:22:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 07:22:22 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ACMJf8010553;
 Fri, 10 May 2024 07:22:20 -0500
Message-ID: <ce8c71d3-97e0-ff77-79d3-2f37acc529e1@ti.com>
Date: Fri, 10 May 2024 17:52:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] configs: am62ax: enable remote proc drivers
Content-Language: en-US
To: Hari Nagalla <hnagalla@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <afd@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
 <20240509142037.32064-4-hnagalla@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240509142037.32064-4-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 09/05/24 19:50, Hari Nagalla wrote:
> Enable K3-DSP and K3-R5FSS remote proc drivers for am62ax.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  configs/am62ax_evm_a53_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
> index c4556f5dd2..6b29a4b9cf 100644
> --- a/configs/am62ax_evm_a53_defconfig
> +++ b/configs/am62ax_evm_a53_defconfig
> @@ -72,6 +72,8 @@ CONFIG_POWER_DOMAIN=y
>  CONFIG_TI_SCI_POWER_DOMAIN=y
>  CONFIG_K3_SYSTEM_CONTROLLER=y
>  CONFIG_REMOTEPROC_TI_K3_ARM64=y
> +CONFIG_REMOTEPROC_TI_K3_R5F=y
> +CONFIG_REMOTEPROC_TI_K3_DSP=y
>  CONFIG_RESET_TI_SCI=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_SOC_DEVICE=y
> @@ -81,3 +83,4 @@ CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_CMD_REMOTEPROC=y
