Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CD7C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDFA86430;
	Mon, 28 Aug 2023 18:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s1buNnZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F148B8645D; Mon, 28 Aug 2023 18:35:25 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337DA805C9
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SGZKsD074585;
 Mon, 28 Aug 2023 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693240520;
 bh=q0JWefwgkMwAXBoTLBETYTFvYdHBivZ66HLRe1eBCWI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=s1buNnZ1dWJh/kwJhHIzx2kZj62CcUjvcbB6aZrsIUjKd0BDN4RB8cAORTjaJqfC+
 aJwa7mMBbDKFbnB9u2VKy9DYX0CQKTbFffgiU77TktsSTgU+FEjKDroNUiIQCVHMks
 t/EoZYpZJNBIaLbiS8b+/rjVlSErpGf8JZqM7i7A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SGZKMi048191
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 11:35:20 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 11:35:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 11:35:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SGZJSI004791;
 Mon, 28 Aug 2023 11:35:19 -0500
Date: Mon, 28 Aug 2023 11:35:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 2/6] arm: mach-k3: j721s2: Add mcu_timer0 id to the
 dev list
Message-ID: <20230828163519.cjzjuwcbqlcdztdm@shady>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-2-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-2-a5f141be40bc@ti.com>
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

On 16:47-20230825, Manorit Chawdhry wrote:
> mcu_timer0 is used by u-boot as the tick-timer. Add it to the soc
> devices lsit so it an be enabled via the k3 power controller.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

> ---
>  arch/arm/mach-k3/j721s2/dev-data.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/j721s2/dev-data.c
> index 8c999a3c5a8b..df70c5e5d7c0 100644
> --- a/arch/arm/mach-k3/j721s2/dev-data.c
> +++ b/arch/arm/mach-k3/j721s2/dev-data.c
> @@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
>  };
>  
>  static struct ti_dev soc_dev_list[] = {
> +	PSC_DEV(35, &soc_lpsc_list[0]),

Reviewed that mcu_timer0 with device ID 35 maps to LPSC_wkup_alwayson
which maps to index 0.

Reviewed-by: Nishanth Menon <nm@ti.com>

>  	PSC_DEV(108, &soc_lpsc_list[0]),
>  	PSC_DEV(109, &soc_lpsc_list[0]),
>  	PSC_DEV(110, &soc_lpsc_list[0]),
> 
> -- 
> 2.41.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
