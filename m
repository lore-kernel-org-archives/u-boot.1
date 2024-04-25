Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3594CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 18:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBB6886FA;
	Thu, 25 Apr 2024 20:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hSQEVXI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B0D886DD; Thu, 25 Apr 2024 20:30:19 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4845B886FA
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 20:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PIUElm003084;
 Thu, 25 Apr 2024 13:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714069814;
 bh=H+1EvvYL1QfnlO/msH5CEQbP+QcLQj6VsYpDFYQYcsk=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=hSQEVXI8cW9i9jihfAKlAXbVuaCkedu9cBks7ggCWQpko2wWy5ilt8r2llxxMvEpE
 vlaUpw8FvDfIu68LkpJi1Y2/L1upx212tTM0/TqbiNTcWtPrVlovpJ6C9E7J3Y0p2/
 PFAdNGAvK12foxixmZZsKAVyrjB6T+xkffbH1fAY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PIUEHN082140
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 13:30:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 13:30:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 13:30:14 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PIUD1D113198;
 Thu, 25 Apr 2024 13:30:14 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, "Simon Glass"
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Jon Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am642: Fix reset for workaround errata ID
 i2331
In-Reply-To: <20240418175828.84548-1-afd@ti.com>
References: <20240418175828.84548-1-afd@ti.com>
Date: Fri, 26 Apr 2024 00:00:13 +0530
Message-ID: <87o79xguru.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
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

Andrew Davis <afd@ti.com> writes:

> To workaround an issue in AM642 we reset the SoC in early boot. For that
> we first probed the sysreset driver by calling uclass_get_device(). The
> ti-sci sysreset driver is now probed during the ti-sci firmware probe.
> Update this call to probe the firmware driver which will then probe
> the sysreset driver allowing do_reset() to again function as expected.
>
> Reported-by: Jonathan Humphreys <j-humphreys@ti.com>
> Fixes: fc5d40283483 ("firmware: ti_sci: Bind sysreset driver when enabled")
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/am642_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
> index ddf47ef0a9b..80c3cb3479f 100644
> --- a/arch/arm/mach-k3/am642_init.c
> +++ b/arch/arm/mach-k3/am642_init.c
> @@ -226,7 +226,7 @@ void board_init_f(ulong dummy)
>  	 * The warm reset realigns internal clocks and prevents the lockup from
>  	 * happening.
>  	 */
> -	ret = uclass_first_device_err(UCLASS_SYSRESET, &dev);
> +	ret = uclass_get_device_by_driver(UCLASS_FIRMWARE, DM_DRIVER_GET(ti_sci), &dev);
>  	if (ret)
>  		printf("\n%s:uclass device error [%d]\n",__func__,ret);
>  
> -- 
> 2.39.2
Tested-by: Kamlesh Gurudasani <kamlesh@ti.com>

on am64x-evm
