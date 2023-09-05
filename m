Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6C0C83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 06:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61703833DE;
	Tue,  5 Sep 2023 08:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hvbILCWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB29863C3; Tue,  5 Sep 2023 08:02:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533F48071F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 08:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38562UfC114521;
 Tue, 5 Sep 2023 01:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693893750;
 bh=uzmu1jErDGoFY1dpK8n7ujhn4vyJ+54kLJ5O74ZDQnM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hvbILCWb42zRp4a+x48qqfvrK45Gk4JYvBsLs3rB5T3bjqicv9nlGwXX6Q5tOmqeM
 K5edixJVTz9EDEXtiTOXXk57e4pSq2g0hNfrwvcc/BfT+wWuMqV8Ld0imYqLfWRIsF
 dRKYJBXYL7pvPB86TNpfYv36mwjYvis7449MeM/w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38562Uk7121297
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 01:02:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 01:02:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 01:02:30 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38562SFY122759;
 Tue, 5 Sep 2023 01:02:28 -0500
Message-ID: <4d4ba0e7-be19-56f3-36b6-e6865fcc2b84@ti.com>
Date: Tue, 5 Sep 2023 11:32:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tools: logos: Rename TI logo files
Content-Language: en-US
To: Nikhil M Jain <n-jain1@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <vigneshr@ti.com>
References: <20230901103913.38407-1-n-jain1@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230901103913.38407-1-n-jain1@ti.com>
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



On 01/09/23 16:09, Nikhil M Jain wrote:
> Change the file name from ti.gz and ti.bmp to ti_logos_414x97_32bpp to
> help user understand the resolution and identify the logo files when
> placed in the boot partition and update the splashfile name with the
> same in .env file.
> 
> Signed-off-by: Nikhil M Jain <n-jain1@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  board/ti/am62x/am62x.env                           |   2 +-
>  tools/logos/{ti.bmp => ti_logo_414x97_32bpp.bmp}   | Bin
>  tools/logos/{ti.gz => ti_logo_414x97_32bpp.bmp.gz} | Bin
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/logos/{ti.bmp => ti_logo_414x97_32bpp.bmp} (100%)
>  rename tools/logos/{ti.gz => ti_logo_414x97_32bpp.bmp.gz} (100%)
> 
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index f2dc87893a..ece9eacc08 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -17,7 +17,7 @@ bootpart=1:2
>  bootdir=/boot
>  rd_spec=-
>  
> -splashfile=ti.gz
> +splashfile=ti_logo_414x97_32bpp.bmp.gz
>  splashimage=0x80200000
>  splashpos=m,m
>  splashsource=sf
> diff --git a/tools/logos/ti.bmp b/tools/logos/ti_logo_414x97_32bpp.bmp
> similarity index 100%
> rename from tools/logos/ti.bmp
> rename to tools/logos/ti_logo_414x97_32bpp.bmp
> diff --git a/tools/logos/ti.gz b/tools/logos/ti_logo_414x97_32bpp.bmp.gz
> similarity index 100%
> rename from tools/logos/ti.gz
> rename to tools/logos/ti_logo_414x97_32bpp.bmp.gz
