Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D71CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFC986B4E;
	Mon, 25 Sep 2023 15:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X3KMoC7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3EAB86BFF; Mon, 25 Sep 2023 15:35:35 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF5F86B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDZTQb082790;
 Mon, 25 Sep 2023 08:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695648929;
 bh=yQMWrQW/ws8DxWwXAMTqy7xoeJtnZ/cfZsFI64CRGwE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=X3KMoC7KImV90bGuvrfbo291J4ihnYIKZKUo1tVp/DXmySdAoZIn1pwZExh6pzdCt
 JJbylPUdSEPGt+P0t7rk+8IotECDIPFxxxPX8X7fSchdGjh+WQv693zWmWSZz2ONdc
 2bp4GFmrxtvJTD9Pnj0hAoWiMOOaCtCwhYJuP9gc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDZTUJ060649
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 08:35:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:35:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:35:29 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDZSm5081788;
 Mon, 25 Sep 2023 08:35:29 -0500
Message-ID: <a769b102-245e-f57c-6cc4-5cc5529951ab@ti.com>
Date: Mon, 25 Sep 2023 08:35:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] env: ti: ti_common.env: Fix get_overlaystring for FIT
 Image
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
References: <20230925-b4-upstream-overlaystring-v3-1-47bd6b973cfd@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230925-b4-upstream-overlaystring-v3-1-47bd6b973cfd@ti.com>
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

On 9/25/23 1:23 AM, Manorit Chawdhry wrote:
> After the refactor with conf- nodes in fitImage, overlaystring wasn't
> didn't handle the new conf- nodes in FIT Booting. Fix get_overlaystring
> to handle conf- nodes.
> 
> Fixes: 837833a724b7 ("environment: ti: Add get_fit_config command to get FIT config string")
> Reported-by: Aniket Limaye <a-limaye@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> Test Logs:
> => setenv name_overlays ti/k3-dt.dtbo ti/k3-dt1.dtbo
> => run get_overlaystring
> => printenv overlaystring
> overlaystring=#conf-ti_k3-dt.dtbo#conf-ti_k3-dt1.dtbo
> ---
> Changes in v3:
> - Refactor to remove dependency on boot_fit ( Andrew )
> - Rename it to get_fit_overlaystring as it is not used anywhere else
> - Link to v2: https://lore.kernel.org/r/20230921-b4-upstream-overlaystring-v2-1-22e0b71e3334@ti.com
> ---
>   include/env/ti/ti_common.env | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index e87a41a6590b..f5d84216e3ce 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -15,10 +15,10 @@ boot_fit=0
>   addr_fit=0x90000000
>   name_fit=fitImage
>   update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
> -get_overlaystring=
> -	for overlay in $name_overlays;
> -	do;
> -	setenv overlaystring ${overlaystring}'#'${overlay};
> +get_fit_overlaystring=
> +	for overlay in $name_overlays; do;
> +		setexpr name_fit_overlay gsub / _ conf-${overlay};
> +		setenv overlaystring ${overlaystring}'#'${name_fit_overlay};
>   	done;
>   get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
>   run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
> @@ -28,7 +28,7 @@ bootcmd_ti_mmc=
>   	run main_cpsw0_qsgmii_phyinit; run boot_rprocs;
>   #endif
>   	if test ${boot_fit} -eq 1;
> -		then run get_fit_${boot}; run get_overlaystring; run run_fit;
> +		then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
>   	else;
>   		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern;
>   	fi;
> 
> ---
> base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
> change-id: 20230915-b4-upstream-overlaystring-207e28b8c5fb
> 
> Best regards,
