Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDACCC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 11:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84403871CC;
	Fri,  1 Dec 2023 12:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xrW5eCIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B242871CC; Fri,  1 Dec 2023 12:09:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E780887185
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 12:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1B9GPj034396;
 Fri, 1 Dec 2023 05:09:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701428956;
 bh=jRfPCm3LhZBy1/N5Bx9Otg/Lq0TcrIjevDXzK7MFDXs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xrW5eCICqmiKqY4BZQPEuNVJv98VwnP1AzCowSQdE4xanbFyNAELC5Yd0djedy88X
 qKeDFRJQK+xnuEV23DDeqqgDbdwcbRSGb4nzq/kaxiNRYzc6oH2aHzm7yMzHcl/WaX
 4q2Now2xSjtXMzuru8WJEYH42oQVudm/ziQ9/sjc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1B9GLi007644
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 05:09:16 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 05:09:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 05:09:15 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1B9Ful071956;
 Fri, 1 Dec 2023 05:09:15 -0600
Date: Fri, 1 Dec 2023 16:39:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20231201110914.rgwjbjmq53hyjesr@dhruva>
References: <20231130115607.2150349-1-w.egorov@phytec.de>
 <20231130115607.2150349-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130115607.2150349-2-w.egorov@phytec.de>
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

On Nov 30, 2023 at 12:56:06 +0100, Wadim Egorov wrote:
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
> Device trees were taken from Linux v6.7-rc3.

Thanks for providing the Linux tag, since DT changes are in sync with
kernel,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2:
>   - Add cover-letter & mention Linux version I took the DTs from
>   - Move board selection to mach-k3
>   - Add missing SPL_LDSCRIPT definition
>   - Refactore binman file for templated FITs & drop key overrides
>   - Drop SoC provided bootph params from dt files
>     Note: Later we can drop more bootph params after we added them to Linux
>   - Drop CONFIG_TI_SECURE_DEVICE as it is set as default for K3
>   - Drop cpsw3g custom DT property 'mac_efuse' and custom DT node cpsw-phy-sel
>     as driver picks these from standard property/node (-u-boot.dtsi)
>   - Add a53 cluster power to control from the rproc driver (a53 dt node)
> 
> ---
>  arch/arm/dts/Makefile                         |    4 +-
>  .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
>  arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
>  .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  166 ++
>  arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  380 +++
>  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  119 +
>  arch/arm/mach-k3/am62x/Kconfig                |   17 +
>  board/phytec/phycore_am62x/Kconfig            |   33 +
>  board/phytec/phycore_am62x/MAINTAINERS        |   15 +
>  board/phytec/phycore_am62x/Makefile           |    8 +
>  board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
>  board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
>  board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
>  board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
>  board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
>  board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
>  configs/phycore_am62x_a53_defconfig           |  115 +
>  configs/phycore_am62x_r5_defconfig            |  130 +
>  include/configs/phycore_am62x.h               |   15 +
>  20 files changed, 5378 insertions(+), 1 deletion(-)
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
[....]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
