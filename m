Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2DEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78524884F9;
	Thu, 27 Jun 2024 18:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a0zMf56e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CEB881EC; Thu, 27 Jun 2024 18:45:02 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BC7883F6
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 18:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGipSt024248;
 Thu, 27 Jun 2024 11:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719506691;
 bh=O8Z++9OeiCePQ2ASHnvkyhXbGYsvl0udiLHCtI68Lu0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=a0zMf56ezHYuHi12dNhMIE36ayPdorEQkxG55a+DQnbxlDt3GcuX6EFBs3ro8mRxi
 8FpgD+14/KemlQPmt8tL2snS7BQHd33IlXePxktXFiszCWSVbORXw5y0kXcSgVK8fU
 /8x0dY3SEzanTIywRcBLcHveYhIdlfzNsNKWaUdQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGioO1110891
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Jun 2024 11:44:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:44:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:44:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGiolL028922;
 Thu, 27 Jun 2024 11:44:50 -0500
Date: Thu, 27 Jun 2024 11:44:50 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <trini@konsulko.com>, <joe.hershberger@ni.com>, <m-chawdhry@ti.com>,
 <afd@ti.com>, <n-jain1@ti.com>, <rogerq@kernel.org>, <vigneshr@ti.com>,
 <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <andriy.shevchenko@linux.intel.com>, <bmeng.cn@gmail.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] board/include: ti/env: j721e.env/ti_common: Fix
 cpsw0_qsgmii_phyinit
Message-ID: <20240627164450.y7ziouhui3kmc2qq@gating>
References: <20240627094952.2074528-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627094952.2074528-1-s-vadapalli@ti.com>
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

On 15:19-20240627, Siddharth Vadapalli wrote:
> The command "main_cpsw0_qsgmii_phyinit" has to be run depending on
> whether or not the "do_main_cpsw0_qsgmii_phyinit" variable is set.
> However, there is no support for the cases where the environment variable
> "do_main_cpsw0_qsgmii_phyinit" is updated at runtime. On J721E, the value
> of "do_main_cpsw0_qsgmii_phyinit" is updated at runtime.
> 
> Fix the existing implementation in order to handle the case where the
> value of "do_main_cpsw0_qsgmii_phyinit" is updated at runtime. Do so by
> introducing the environment variable "update_do_main_cpsw0_qsgmii_phyinit"
> which defaults to setting "do_main_cpsw0_qsgmii_phyinit" to zero, but at
> the same time, it allows the board to update the value at runtime.
> 
> Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>


Why cant we do this entirely in board files? we do the board detection
there anyways..

> ---
> 
> Hello,
> 
> This patch is based on commit
> 899b088674 Merge patch series "pxe: Add debugging for booting"
> of U-Boot's next branch.
> 
> Regards,
> Siddharth.
> 
>  board/ti/j721e/j721e.env     | 9 +++++----
>  include/env/ti/ti_common.env | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index 38bfd7d496..03d7e81aa8 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -29,7 +29,7 @@ bootdir=/boot
>  rd_spec=-
>  
>  #if CONFIG_TARGET_J7200_A72_EVM
> -do_main_cpsw0_qsgmii_phyinit=1
> +update_do_main_cpsw0_qsgmii_phyinit=setenv do_main_cpsw0_qsgmii_phyinit 1;
>  init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
>  	gpio clear gpio@22_16
>  main_cpsw0_qsgmii_phyinit=
> @@ -39,10 +39,11 @@ main_cpsw0_qsgmii_phyinit=
>  #elif CONFIG_TARGET_J721E_A72_EVM
>  init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
>  	gpio clear gpio@22_16
> -main_cpsw0_qsgmii_phyinit=
> +update_do_main_cpsw0_qsgmii_phyinit=
>  	if test $board_name = J721EX-PM1-SOM || test $board_name = J721EX-PM2-SOM || test $board_name = j721e; then
> -		do_main_cpsw0_qsgmii_phyinit=1; else
> -		do_main_cpsw0_qsgmii_phyinit=0; fi;
> +		setenv do_main_cpsw0_qsgmii_phyinit 1; else
> +		setenv do_main_cpsw0_qsgmii_phyinit 0; fi;
> +main_cpsw0_qsgmii_phyinit=
>  	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
>  		run init_main_cpsw0_qsgmii_phy;			\
>  	fi;
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index c5c3642177..d0b3d698a0 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -23,9 +23,10 @@ get_fit_overlaystring=
>  	done;
>  get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
>  run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
> -do_main_cpsw0_qsgmii_phyinit=0
> +update_do_main_cpsw0_qsgmii_phyinit=setenv do_main_cpsw0_qsgmii_phyinit 0;
>  bootcmd_ti_mmc=
>  	run findfdt; run init_${boot};
> +	run update_do_main_cpsw0_qsgmii_phyinit;
>  #if CONFIG_CMD_REMOTEPROC
>  	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>  		then run main_cpsw0_qsgmii_phyinit;
> -- 
> 2.40.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
