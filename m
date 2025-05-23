Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C88C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD2283535;
	Fri, 23 May 2025 18:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AJsBvm2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E091831FE; Fri, 23 May 2025 12:07:49 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3272183145
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 12:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=c-shilwant@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54NA7jn3886044;
 Fri, 23 May 2025 05:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747994865;
 bh=LJA2iJcedf0odDH/QjscoUCLWLFmpRp8FhRLtUWjJWM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AJsBvm2iQGMzzusCzVF2BMsvLGPiL0sWcUKMW81w48wMc+320tN6sFrPcjhzDq4dc
 Kh/s6e9/IfxqNshgcfcok+gg0hmTwgxnHZXrErTjfLwHdF6SgdAI4QIaqn09X7R7zc
 BmsC0RalkC85zRcSq3g2RowQmYuySU1gITAVYlSA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54NA7jar4182741
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 23 May 2025 05:07:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 05:07:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 05:07:44 -0500
Received: from [172.24.227.238] (chirag-hp-z2-tower-g5-workstation.dhcp.ti.com
 [172.24.227.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54NA7gPU1142599;
 Fri, 23 May 2025 05:07:43 -0500
Message-ID: <a89e2eaf-8d78-4efa-ae0b-140e85947089@ti.com>
Date: Fri, 23 May 2025 15:37:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: am62ax: env: Use default MMC related args
To: <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
References: <20250522164013.125496-1-afd@ti.com>
Content-Language: en-US
From: Chirag Shilwant <c-shilwant@ti.com>
In-Reply-To: <20250522164013.125496-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 23 May 2025 18:55:52 +0200
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

Hi Andrew,
On 22/05/25 22:10, Andrew Davis wrote:
> There are common MMC args for TI plats in include/environment/ti/mmc.env.
> Since we already include this, there is no need to redefine these
> MMC vars. Use the defaults.
>
> This seems like something that could have been done while refactoring
> these vars in the first place as it happened after this AM62A file
> was available hence the fixes tag.
>
> Reported-by: Chirag Shilwant <c-shilwant@ti.com>
> Fixes: 3709b529156e ("env: ti: mmc.env: Move mmc related args to common place")
> Signed-off-by: Andrew Davis <afd@ti.com>



Acked-by: Chirag Shilwant <c-shilwant@ti.com>

> ---
>   board/ti/am62ax/am62ax.env | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
> index 96d9e1e2797..dc7af56a6f7 100644
> --- a/board/ti/am62ax/am62ax.env
> +++ b/board/ti/am62ax/am62ax.env
> @@ -17,18 +17,5 @@ mmcdev=1
>   bootpart=1:2
>   bootdir=/boot
>   rd_spec=-
> -init_mmc=run args_all args_mmc
> -get_overlay_mmc=
> -	fdt address ${fdtaddr};
> -	fdt resize 0x100000;
> -	for overlay in $name_overlays;
> -	do;
> -	load mmc ${bootpart} ${dtboaddr} ${bootdir}/${overlay} &&
> -	fdt apply ${dtboaddr};
> -	done;
> -get_kern_mmc=load mmc ${bootpart} ${loadaddr}
> -	${bootdir}/${name_kern}
> -get_fit_mmc=load mmc ${bootpart} ${addr_fit}
> -	${bootdir}/${name_fit}
> -partitions=name=rootfs,start=0,size=-,uuid=${uuid_gpt_rootfs}
> +
>   rproc_fw_binaries= 0 /lib/firmware/am62a-mcu-r5f0_0-fw 1 /lib/firmware/am62a-c71_0-fw
