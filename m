Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1979C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2BE86BD6;
	Tue,  7 Nov 2023 08:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W690wOFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAF186D3F; Tue,  7 Nov 2023 08:06:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1DF86BA4
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A776RaB071042;
 Tue, 7 Nov 2023 01:06:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699340787;
 bh=Nb2b3249LaMBfa3Giqs5bT8d12ouXZzincYXuqyKVAA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W690wOFbnrWDfA6LSRHoPXEatBRp1rs6RcUyFPgRL0jTDZHc2abStLOB+E2MIQuR2
 QP27/gosCkHoT/3RvDI/hmIyl4nHOyz9xTlLE8J44Oi239uRsArq/5rEBBx0MKBuHv
 XoYemQ0HbzXAHpMK1uAQQLUOI3VwiAThWeFis1Wg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A776QFw123405
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 01:06:27 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 01:06:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 01:06:26 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A776MB0054811;
 Tue, 7 Nov 2023 01:06:23 -0600
Message-ID: <d356205f-da56-40c8-9003-9c5904913d1f@ti.com>
Date: Tue, 7 Nov 2023 12:36:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/12] board: ti: j721e: evm: Drop board check for ESM
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-3-nm@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231104072150.3339-3-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Nishanth,

On 04/11/23 12:51, Nishanth Menon wrote:
> When config is enabled, the esm dt probe makes sense. Simplify by
> dropping board specific checks.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   board/ti/j721e/evm.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index aa22f1653fec..8f0996c32ee6 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -523,10 +523,8 @@ err_free_gpio:
>   
>   void spl_board_init(void)
>   {
> -#if defined(CONFIG_ESM_K3) || defined(CONFIG_ESM_PMIC)
>   	struct udevice *dev;
>   	int ret;
> -#endif
>   
>   	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
>   	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
> @@ -535,24 +533,20 @@ void spl_board_init(void)
>   			probe_daughtercards();
>   	}
>   
> -#ifdef CONFIG_ESM_K3
> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> +	if (IS_ENABLED(CONFIG_ESM_K3)) {
>   		ret = uclass_get_device_by_driver(UCLASS_MISC,
>   						  DM_DRIVER_GET(k3_esm), &dev);
>   		if (ret)
>   			printf("ESM init failed: %d\n", ret);
>   	}
> -#endif
>   
> -#ifdef CONFIG_ESM_PMIC
> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> +	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
>   		ret = uclass_get_device_by_driver(UCLASS_MISC,
>   						  DM_DRIVER_GET(pmic_esm),
>   						  &dev);
>   		if (ret)
>   			printf("ESM PMIC init failed: %d\n", ret);
>   	}
> -#endif

Add empty line here?

>   	if ((IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) &&
>   	    IS_ENABLED(CONFIG_HBMC_AM654)) {
>   		struct udevice *dev;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
