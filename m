Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A678C47E49
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 18:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0AF877DE;
	Wed, 24 Jan 2024 19:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tZLwVIZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6A987B3D; Wed, 24 Jan 2024 19:13:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51EC876EF
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 19:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIDbXQ120482
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:13:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706120017;
 bh=gXH68ic20m/Yr0gtytWAlQvgI5nEPVuTqI60pp4Ya7c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tZLwVIZ5khCOsCar0caYNX4A2nJmCAHRhjUJejbnpZI2+e0KGOWXaNw9NwXVWKCQb
 xiIDDOqGhq7xWUgMErnTcv+4jsZCC01N9JHwvNejBKDxCu2e096dzemKI2i1rhKRCk
 rkUG4IGNdxo2lTWah/Hs6KjPQX+tXsGSzlh8tNdE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIDbdj017603
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:13:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:13:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:13:37 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIDbBB114270;
 Wed, 24 Jan 2024 12:13:37 -0600
Date: Wed, 24 Jan 2024 12:13:37 -0600
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: Re: [PATCH 1/2] env: ti: mmc: add save_uenv command
Message-ID: <20240124181337.niorbonmzjrs5jk5@tweak>
References: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
 <20240124-b4-upstream-save_uenv-v1-1-4a4dfbd3eca9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124-b4-upstream-save_uenv-v1-1-4a4dfbd3eca9@ti.com>
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

On 12:56-20240124, Manorit Chawdhry wrote:
> This is to make easier development with uEnv.txt to update from the
> board on the fly from u-boot to MMC boot media.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  include/env/ti/mmc.env | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
> index 0256a2d2aaca..886e4cab36fe 100644
> --- a/include/env/ti/mmc.env
> +++ b/include/env/ti/mmc.env
> @@ -34,6 +34,9 @@ envboot=if mmc dev ${mmcdev}; then
>  		fi;
>  	fi;
>    fi;
> +save_uenv=
> +	env export -t $loadaddr $save_to_env save_to_env;
> +	fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize};

Please NO! saveenv has ability.. why not use that? it is better to
improve the commands themselves.

>  mmcloados=
>  	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
>  		if run get_fdt_mmc; then
> 
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
