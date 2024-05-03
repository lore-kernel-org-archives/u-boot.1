Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EBDC25B10
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 14:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F32882D7;
	Fri,  3 May 2024 16:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CiX1NT0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CDD882F5; Fri,  3 May 2024 16:45:07 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEB0882B3
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 16:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443EiwMJ016906;
 Fri, 3 May 2024 09:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714747498;
 bh=gwGhCdDjgbc8tX2E6TIAY2xvAuvYlkYxj38k07T6R/8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CiX1NT0ThsOMNbh6Heb9no0xCYtZvHWn+D3h4PYUhbFxaK4mhiDXfaTpljwO4PusS
 ZWdOO1k4TowjP2d90q4J3/0wVMFR3yHjRWYnaDujbHDpCoj2jCn1b0+CcUK0DixaIT
 WkaxMNBayRoa/dUlVwcgiBi1H5uEv58uP9lCEnBM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443EiwbQ025027
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 09:44:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 09:44:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 09:44:57 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443Eiv3e053100;
 Fri, 3 May 2024 09:44:57 -0500
Date: Fri, 3 May 2024 09:44:57 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Michal Simek
 <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Apurva Nandan <a-nandan@ti.com>, Hari Nagalla
 <hnagalla@ti.com>
Subject: Re: [PATCH 63/81] soc: Remove <common.h> and add needed includes
Message-ID: <20240503144457.yhy32eulizpabhat@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-63-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240502013138.2383421-63-trini@konsulko.com>
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

On May  1, 2024 thus sayeth Tom Rini:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Apurva Nandan <a-nandan@ti.com>
> Cc: Hari Nagalla <hnagalla@ti.com>
> Cc: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/soc/soc-uclass.c            | 1 -
>  drivers/soc/soc_sandbox.c           | 1 -
>  drivers/soc/soc_ti_k3.c             | 1 -
>  drivers/soc/soc_xilinx_versal.c     | 1 -
>  drivers/soc/soc_xilinx_versal_net.c | 1 -
>  drivers/soc/soc_xilinx_zynqmp.c     | 1 -
>  drivers/soc/ti/k3-navss-ringacc.c   | 1 -
>  drivers/soc/ti/keystone_serdes.c    | 1 -
>  drivers/soc/ti/pruss.c              | 1 -
>  9 files changed, 9 deletions(-)
> 

...

>  
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index 3a4e58bba671..b585e47d46fe 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -4,7 +4,6 @@
>   *	Dave Gerlach <d-gerlach@ti.com>
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  #include <soc.h>
>  

Thanks Tom!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
