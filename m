Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC69E7B61E
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307368757F;
	Wed,  4 Oct 2023 15:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zj5s/nzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18D68758B; Wed,  4 Oct 2023 15:59:35 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C124B87576
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394DxQbJ059626;
 Wed, 4 Oct 2023 08:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696427966;
 bh=lW3UocHE9ytO8s0pvXdOVvb4NJLlW77TwGA0VoI3kxk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Zj5s/nzw7Lc/uUqY6UFvcOKbr1V4+IMJY/DSMXD/Aw3LrhzjZ2lXMy3LbBGqus74P
 R8JAtgJGxeQvvyHl7E0p+ddnPXvriRNcfOeuvNE5tEkldC0F0P2BLH0rt2tb/2Nh1s
 iYfskcodVpdroutzLt6DhFLa4M2BCrbXM1/7g4L8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394DxQOm114851
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 08:59:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 08:59:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 08:59:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394DxQE7000944;
 Wed, 4 Oct 2023 08:59:26 -0500
Date: Wed, 4 Oct 2023 08:59:26 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231004135926.wz3tonnwsilk2uwn@wreckage>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004132324.44198-2-rogerq@kernel.org>
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

On 16:23-20231004, Roger Quadros wrote:
> ti_mmc is not a valid boot_target for standard boot flow so
> remove it. Prefer mmc1 (sd-card) over mmc0 (emmc).
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
>  board/ti/am62x/am62x.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 22a6c2c91b..e53a55c38f 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -8,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
>  	${mtdparts}
>  run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>  
> -boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
> +boot_targets=mmc1 mmc0 usb pxe dhcp
>  boot=mmc
>  mmcdev=1
>  bootpart=1:2
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
