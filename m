Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD7C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FDB88263;
	Tue, 18 Jun 2024 20:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vuAodqU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F108824C; Tue, 18 Jun 2024 20:55:18 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9163E88307
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IItC0S065054;
 Tue, 18 Jun 2024 13:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718736912;
 bh=4P6rF5BwrgK2GCwzGl2R1/6ZmRJ5RzTtzVvWEuHLSF8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vuAodqU+1r8dMCQJayToNFHIupSYVEXCSueub8WSLvqtelFUPPxm1HvSsIKwOzTLV
 CtUSyW9SBFcxTKp3nZ06HLArInLpuucM4S27PtDKRq1UZ2ZC0gHjzsiK0IhdOAp4Ys
 3orAnCXxBZNqstNZPgqlfbAsPUUfOPRXqBwZAtoc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IItCW4006957
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:55:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:55:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:55:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IItCw6057894;
 Tue, 18 Jun 2024 13:55:12 -0500
Date: Tue, 18 Jun 2024 13:55:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Hari Nagalla <hnagalla@ti.com>
CC: <trini@konsulko.com>, <devarsht@ti.com>, <afd@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: Re: [PATCH 3/3] board: ti: am62x: Add remote proc env variables
Message-ID: <20240618185512.p6hc2bbjxfbeftnk@trough>
References: <20240618184636.30642-1-hnagalla@ti.com>
 <20240618184636.30642-4-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618184636.30642-4-hnagalla@ti.com>
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

On 13:46-20240618, Hari Nagalla wrote:
> Add remote proc support environment variables.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  board/ti/am62x/am62x.env | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 9cb186c2a0..f8a73d4c47 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -1,5 +1,8 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
> +#if CONFIG_CMD_REMOTEPROC
> +#include <env/ti/k3_rproc.env>
> +#endif
>  
>  name_kern=Image
>  console=ttyS2,115200n8
> @@ -18,3 +21,4 @@ splashfile=ti_logo_414x97_32bpp.bmp.gz
>  splashimage=0x80200000
>  splashpos=m,m
>  splashsource=sf
> +rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
> -- 
> 2.34.1
> 

Grumble - instead of keeping on adding new SoCs, can we not spend some
effort in trying to integrate to stdboot bootmethod?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
