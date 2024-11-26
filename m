Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0F3D5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F342189634;
	Tue, 26 Nov 2024 06:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rGXZA//g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3226A896C1; Tue, 26 Nov 2024 06:03:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF3C8942F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ53Z38010018;
 Mon, 25 Nov 2024 23:03:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732597415;
 bh=/rpQJQhRCldE+1RxojxtR9uTFgT3lB99wqgMgsEAb/U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=rGXZA//gF6lu4NA14LaueosHHF+UCWRmljwyRSP8nr8+gpXK2Gtb/n7RtUyji4wT6
 Dvo725jxbHaBaiB7ptic4W1VWzhVwr4owXKeaRmUn4ajQthoWkWUOGNZraJXDKSC1a
 OpumEYoxiphGLDc3QnjpA63c5DTJ/0+bAFDmX/xc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ53ZA9028971;
 Mon, 25 Nov 2024 23:03:35 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 23:03:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 23:03:35 -0600
Received: from [10.24.72.152] (uda0132425.dhcp.ti.com [10.24.72.152])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ53VFn074214;
 Mon, 25 Nov 2024 23:03:31 -0600
Message-ID: <f348c51f-3f34-406d-8013-9c4185c8d40b@ti.com>
Date: Tue, 26 Nov 2024 10:33:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] board: ti: am64x: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <rogerq@kernel.org>,
 <sjg@chromium.org>, <nm@ti.com>, <j-humphreys@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <u-kumar1@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <trini@konsulko.com>, <bb@ti.com>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-2-s-vadapalli@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20241124070828.617558-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 24/11/24 12:37, Siddharth Vadapalli wrote:
> Commit 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
> updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
> However, this breaks use-cases where interface is not Serial Flash ("sf").
> Fix this by setting "dfu_alt_info" only when the interface is "sf".
> 
> Fixes: 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20241124051545.382397-2-s-vadapalli@ti.com/
> Changes since v1:
> - Replaced "SPI Flash" with "Serial Flash" everywhere.
> 
> Regards,
> Siddharth.
> 
>  board/ti/am64x/evm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 00b8317d6b..18f7770bc1 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -56,7 +56,13 @@ struct efi_capsule_update_info update_info = {
>  #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>  void set_dfu_alt_info(char *interface, char *devstr)
>  {
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +	/*
> +	 * Since the EFI Capsule support is enabled only for Serial Flash,
> +	 * update the "dfu_alt_info" environment variable only if the
> +	 * interface happens to be "sf" (Serial Flash).
> +	 */
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> +	    (strcmp(interface, "sf") == 0))

IIUC, EFI_HAVE_CAPSULE_SUPPORT is probably only functional at U-Boot
proper and not at SPL (I dont see any SPL_EFI_* options), so would this
work instead?

	if (CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT) {
		...
	}

>  		env_set("dfu_alt_info", update_info.dfu_string);
>  }
>  #endif

-- 
Regards
Vignesh
https://ti.com/opensource

