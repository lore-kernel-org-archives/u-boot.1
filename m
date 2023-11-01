Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDE5C4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 15:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2C3876C5;
	Wed,  1 Nov 2023 16:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CvW/rVCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04F8876D9; Wed,  1 Nov 2023 16:57:41 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4B2875E5
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 16:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1FvZp9030899;
 Wed, 1 Nov 2023 10:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698854255;
 bh=DdpR1G8AGvqIGEnGXalqTXxL/RzB2kUkd6jnGm8xFUA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CvW/rVCN6ZxBdkoq/gJmyttJy7uR5MngqHxrCnuXI5S62ld7kiZC70QG3LkTP29aF
 6S/CNzyWjg54lSk2+dc4kIdzs1iHGRtiee7HD5prMllUqpfOx+Fp7r/pANCVqgO+E6
 AhqPh/ETHlcsvMYGKTglC+34zofgI/iexS0n/g88=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1FvZh5005146
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 10:57:35 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 10:57:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 10:57:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1FvYjw085866;
 Wed, 1 Nov 2023 10:57:35 -0500
Date: Wed, 1 Nov 2023 21:27:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>
Subject: Re: [PATCH 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20231101155734.5mzpvq4xcm2o5emm@dhruva>
References: <20231031133732.265589-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231031133732.265589-1-w.egorov@phytec.de>
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

Hi,

On Oct 31, 2023 at 14:37:31 +0100, Wadim Egorov wrote:
> Add basic support for PHYTEC phyCORE-AM62x SoM.
> 
> Supported features:
>   - 2GB DDR4 RAM
>   - eMMC Flash
>   - OSPI NOR Flash
>   - external uSD
>   - Ethernet
>   - debug UART
> 
> Product page SoM: https://www.phytec.com/product/phycore-am62x
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/dts/Makefile                         |    4 +-
>  .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
>  arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
>  .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  229 ++
>  arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  532 ++++
>  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  134 +
>  arch/arm/mach-k3/Kconfig                      |    1 +
>  board/phytec/phycore_am62x/Kconfig            |   52 +
>  board/phytec/phycore_am62x/MAINTAINERS        |   15 +
>  board/phytec/phycore_am62x/Makefile           |    8 +
>  board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
>  board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
>  board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
>  board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
>  board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
>  board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
>  configs/phycore_am62x_a53_defconfig           |  116 +
>  configs/phycore_am62x_r5_defconfig            |  131 +
>  include/configs/phycore_am62x.h               |   15 +
>  20 files changed, 5613 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
>  create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
>  create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
>  create mode 100644 board/phytec/phycore_am62x/Kconfig
>  create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
>  create mode 100644 board/phytec/phycore_am62x/Makefile
>  create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
>  create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
>  create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
>  create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
>  create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
>  create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
>  create mode 100644 configs/phycore_am62x_a53_defconfig
>  create mode 100644 configs/phycore_am62x_r5_defconfig
>  create mode 100644 include/configs/phycore_am62x.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 55aceb51cd..8b371266dc 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1383,7 +1383,9 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>  			      k3-am625-beagleplay.dtb \
>  			      k3-am625-r5-beagleplay.dtb \
>  			      k3-am625-verdin-wifi-dev.dtb \
> -			      k3-am625-verdin-r5.dtb
> +			      k3-am625-verdin-r5.dtb \
> +			      k3-am625-phyboard-lyra-rdk.dtb \
> +			      k3-am625-r5-phycore-som-2gb.dtb

Thanks for upstreaming Wadim!

However I would prefer that you split all these patches into smaller
chunks for each file (preferrably) or group together files that have
like 20-30 lines of changes.

It's difficult to review thousands of lines of code at once, hope you
understand.

Also would appreciate it if you sent the series with a cover letter
summarising your changes. You can also attach boot logs or any
additional info you may want the people reviewing/ testing the patches to
know in the cover letter.

>  
>  dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-sk.dtb \
>  			      k3-am62a7-r5-sk.dtb
[..snip..]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
