Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873FBCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 04:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F3E8817B;
	Thu,  4 Apr 2024 06:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iS+xTe09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20827881BB; Thu,  4 Apr 2024 06:24:59 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB03D87FF0
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 06:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4344OsU3054871;
 Wed, 3 Apr 2024 23:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712204694;
 bh=gGWy0jl3l5WLjVPoDwTTGbjGfAX9utLJ+R+QEU+g2f4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iS+xTe09o+ncX3ynToewXPSX8He1PaOl+Nd94/gW58f+V0fol0gCUoYV8w9BA5IZW
 07Gxzg8Ai6u6ZYOOhzn/yFbmyJvvCpTekFB7DtVOXJVzK/XwFw65i67Jr4BNQyw9bA
 y6pa/PIUECWUsC0Ev/n4tQ7YGilTsZFTiU+UBX48=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4344OsGK001414
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 23:24:54 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 23:24:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 23:24:53 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4344Opjl009512;
 Wed, 3 Apr 2024 23:24:52 -0500
Message-ID: <c3c8f358-372b-4bae-b3e7-3b23f9fc946d@ti.com>
Date: Thu, 4 Apr 2024 09:54:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: add support for detecting TIFSSTUB
 images
To: Dhruva Gole <d-gole@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>
References: <20240403120309.4026170-1-d-gole@ti.com>
 <20240403120309.4026170-2-d-gole@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240403120309.4026170-2-d-gole@ti.com>
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

Hi Dhruva,

On 03/04/24 17:33, Dhruva Gole wrote:
> From: Kamlesh Gurudasani <kamlesh@ti.com>
> 
> Add support for detecting and processing TIFSSTUB images for HS, HSFS
> and GP devices.
> 
> TIFSSTUB image for related device type will be loaded, rest TIFSSTUB
> images will be discarded.
> 
> Example, for GP device, tifsstub-gp will be loaded, tifsstub-hs and
> tifsstub-fs will be discarded.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm/mach-k3/r5/common.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index c02f8d330998..0f6c294f1eb2 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -24,6 +24,9 @@ enum {
>   	IMAGE_ID_OPTEE,
>   	IMAGE_ID_SPL,
>   	IMAGE_ID_DM_FW,
> +	IMAGE_ID_TIFSSTUB_HS,
> +	IMAGE_ID_TIFSSTUB_FS,
> +	IMAGE_ID_T,
>   	IMAGE_AMT,
>   };
>   
> @@ -33,6 +36,9 @@ static const char *image_os_match[IMAGE_AMT] = {
>   	"tee",
>   	"U-Boot",
>   	"DM",
> +	"tifsstub-hs",
> +	"tifsstub-fs",
> +	"tifsstub-gp",
>   };
>   #endif
>   
> @@ -314,6 +320,24 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>   			break;
>   		}
>   	}
> +
> +	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
> +		int device_type = get_device_type();
> +
> +		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
> +		     strcmp(os, "tifsstub-hs")) ||
> +		   (device_type == K3_DEVICE_TYPE_HS_FS &&
> +		     strcmp(os, "tifsstub-fs")) ||
> +		   (device_type == K3_DEVICE_TYPE_GP &&
> +		     strcmp(os, "tifsstub-gp"))) {
> +			*p_size = 0;
> +		} else {
> +			debug("tifsstub-type: %s\n", os);
> +		}
> +
> +		return;
> +	}
> +
>   	/*
>   	 * Only DM and the DTBs are being authenticated here,
>   	 * rest will be authenticated when A72 cluster is up

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
