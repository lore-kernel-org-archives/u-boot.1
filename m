Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF397E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0971A86537;
	Thu, 28 Sep 2023 16:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oFxys0/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EC4865ED; Thu, 28 Sep 2023 16:30:21 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F48864C3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SEUGA3051347;
 Thu, 28 Sep 2023 09:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695911416;
 bh=Y3NgdLnHdt/8LZkv9TNLPL9ukXKeC3WEcwThJxFqh/8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oFxys0/7LO0XC2po65wSgahkIa7V0d9GTbk7gm3bG0b+GpO3BxWmb+/wzzVArEpIr
 +J35/wRw0W9/Lh3h0dyPcIV12lkA9YhtlCCrx8dG5Qyo5Lhx6rcTexRYiFGBXAZZ7C
 B1Y1OW3wuXzEvCkLntMECZU9+Bgj7FLCOtn8bzrE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SEUFmn000849
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 09:30:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 09:30:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 09:30:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SEUFi8012195;
 Thu, 28 Sep 2023 09:30:15 -0500
Date: Thu, 28 Sep 2023 09:30:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] arm: dts: Add support for AM62x LP SK
Message-ID: <20230928143015.gzofmiqtjyh2ls57@darkening>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-3-n-yadav@ti.com>
 <20230927115231.i3kg3wvpvqmmexnd@dazzling>
 <d51d4e84-71b8-1282-0007-7b5f1061e012@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d51d4e84-71b8-1282-0007-7b5f1061e012@ti.com>
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

On 15:00-20230928, Nitin Yadav wrote:
> Hi,
> 
> On 27/09/23 17:22, Nishanth Menon wrote:
> > On 13:51-20230927, Nitin Yadav wrote:
> >> The AM62x LP SK board is similar to the AM62x SK board,
> >> but has some significant changes that requires different
> >> device tree.
> >>
> >> The differences are mainly:
> >> - AM62x SoC in the AMC package that meets AECQ100 automotive standard.
> >> - LPDDR4 versus DDR4 on the AM62x SK.
> >> - TPS65219 PMIC instead of discrete regulators.
> >> - IO expander pin names are wired differently.
> >> - Second ethernet port is currently disabled as the boards do not have
> >>   the part physically installed.
> >> - OSPI NAND vs OSPI NOR.
> >> - No WLAN chip instead a SDIO M.2 connector.
> >>
> >> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >> ---
> >>  arch/arm/dts/Makefile                         |    2 +
> >>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |    9 +
> >>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
> > 
> >>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   21 +
> >>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
> >>  5 files changed, 2453 insertions(+)
> >>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> >>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
> >>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
> >>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
> >>
> >> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> >> index bde2176ec7..72ea57885f 100644
> >> --- a/arch/arm/dts/Makefile
> >> +++ b/arch/arm/dts/Makefile
> >> @@ -1337,6 +1337,8 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
> >>  
> >>  dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
> >>  			      k3-am625-r5-sk.dtb \
> >> +			      k3-am62-lp-sk.dtb \
> >> +			      k3-am62-r5-lp-sk.dtb \
> >>  			      k3-am625-beagleplay.dtb \
> >>  			      k3-am625-r5-beagleplay.dtb \
> >>  			      k3-am625-verdin-wifi-dev.dtb \
> >> diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> >> new file mode 100644
> >> index 0000000000..7da94fe4b6
> >> --- /dev/null
> >> +++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> >> @@ -0,0 +1,9 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * AM62x LP SK dts file for SPLs
> >> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> >> + */
> >> +
> >> +#include "k3-am62x-sk-common-u-boot.dtsi"
> >> +
> >> +#include "k3-am62-lp-sk-binman.dtsi"
> > 
> > Are you sure you don't need the dt phase properties for regulators for
> > mmc to work?
> > 
> >> diff --git a/arch/arm/dts/k3-am62-lp-sk.dts b/arch/arm/dts/k3-am62-lp-sk.dts
> > 
> > Is this coming in from v6.6-rc1 if so document that in commit message.
> > 
> > [...]
> > 
> >> diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> >> new file mode 100644
> >> index 0000000000..ed2c028bad
> >> --- /dev/null
> >> +++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> >> @@ -0,0 +1,21 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * AM62x LP SK dts file for R5 SPL
> >> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> >> + */
> >> +
> >> +#include "k3-am62-lp-sk.dts"
> >> +#include "k3-am62x-ddr-lp4-50-800-800.dtsi"
> >> +#include "k3-am62-ddr.dtsi"
> >> +
> >> +#include "k3-am62-lp-sk-u-boot.dtsi"
> >> +#include "k3-am62x-r5-sk-common.dtsi"
> >> +
> >> +/ {
> >> +	memory@80000000 {
> >> +		device_type = "memory";
> >> +		/* 2G RAM */
> >> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> >> +		bootph-pre-ram;
> >> +	};
> >> +};
> > 
> > NAK. should come from board.dts.
> 
> am62sip support is also in the queue where we have only 512M of RAM.
> That's why I'm adding this node in r5-sk.dts

NAK.

Do this cleanup in the context of the new platform addition - when you
get it in the kernel first.

Side note: I don't see anything in ti.com for the search text.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
