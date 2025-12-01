Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E5D116E2
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 05:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C77083923;
	Mon,  1 Dec 2025 06:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8EF839DD; Mon,  1 Dec 2025 03:39:19 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1FF83935
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 03:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F5BF200490;
 Mon,  1 Dec 2025 03:39:17 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 183C72003A6;
 Mon,  1 Dec 2025 03:39:17 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0EAF41800081;
 Mon,  1 Dec 2025 10:39:14 +0800 (+08)
Date: Mon, 1 Dec 2025 11:39:14 +0900
From: Joseph Guo <qijian.guo@nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <aSz/0jfNn9A3pUmB@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <20251127141451.GV2125796@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127141451.GV2125796@bill-the-cat>
X-Mailman-Approved-At: Mon, 01 Dec 2025 06:04:25 +0100
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

On Thu, Nov 27, 2025 at 08:14:51AM -0600, Tom Rini wrote:
> On Thu, Nov 27, 2025 at 06:54:58PM +0900, Joseph Guo wrote:
> > Add i.MX91 11x11 EVK Board support.
> >  - Four ddr scripts included w/o inline ecc feature. Support
> >    both 1gb and 2gb DDR
> >  - SDHC/EQOS/I2C/UART supported
> >  - PCA9451 supported, default nominal drive mode
> >  - Documentation added.
> > 
> > Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> > ---
> >  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |  195 ++
> >  arch/arm/mach-imx/imx9/Kconfig                     |    8 +
> >  board/freescale/imx91_frdm/Kconfig                 |   19 +
> >  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
> >  board/freescale/imx91_frdm/Makefile                |   16 +
> >  board/freescale/imx91_frdm/imx91_frdm.c            |   28 +
> >  board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
> >  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
> >  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
> >  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
> >  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
> >  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
> >  board/freescale/imx91_frdm/spl.c                   |  204 ++
> >  configs/imx91_11x11_frdm_defconfig                 |  143 ++
> >  configs/imx91_11x11_frdm_inline_ecc_defconfig      |  143 ++
> >  doc/board/nxp/imx91_frdm.rst                       |   99 +
> >  doc/board/nxp/index.rst                            |    1 +
> >  include/configs/imx91_frdm.h                       |   25 +
> >  18 files changed, 8972 insertions(+)
> > 
> > diff --git a/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7934ec89cfa58c1c033ba08ae7be826f5823bc1b
> > --- /dev/null
> > +++ b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> > @@ -0,0 +1,195 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include "imx91-u-boot.dtsi"
> > +
> > +/ {
> > +	wdt-reboot {
> > +		compatible = "wdt-reboot";
> > +		wdt = <&wdog3>;
> > +		bootph-pre-ram;
> > +		bootph-some-ram;
> > +	};
> > +
> > +	firmware {
> > +		optee {
> > +			compatible = "linaro,optee-tz";
> > +			method = "smc";
> > +		};
> > +	};
> > +};
> > +
> > +&{/soc@0} {
> > +	bootph-all;
> > +	bootph-pre-ram;
> > +};
> 
> These should be upstreamed and are not u-boot specific.
>

Hi Tom,

Thanks for your comments.

Can you please point out which node and why?
optee and wdt are always u-boot specific. These nodes have
never been put into upstream before.

Regards,
Joseph

> [snip]
> > diff --git a/board/freescale/imx91_frdm/imx91_frdm.c b/board/freescale/imx91_frdm/imx91_frdm.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..28201a8d62207672c837a34e8619ca9ef4638ed0
> > --- /dev/null
> > +++ b/board/freescale/imx91_frdm/imx91_frdm.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <env.h>
> > +#include <init.h>
> > +#include <miiphy.h>
> > +#include <netdev.h>
> > +#include <asm/arch/sys_proto.h>
> > +
> > +int board_late_init(void)
> > +{
> > +#ifdef CONFIG_ENV_IS_IN_MMC
> > +	board_late_mmc_env_init();
> > +#endif
> > +
> > +	env_set("sec_boot", "no");
> > +#ifdef CONFIG_AHAB_BOOT
> > +	env_set("sec_boot", "yes");
> > +#endif
> > +
> > +#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
> > +	env_set("board_name", "11X11_FRDM");
> > +	env_set("board_rev", "iMX91");
> > +#endif
> > +	return 0;
> > +}
> 
> There are extraneous includes here, please fix and recheck the rest of
> the files too.
> 
> [snip]
> > diff --git a/configs/imx91_11x11_frdm_inline_ecc_defconfig b/configs/imx91_11x11_frdm_inline_ecc_defconfig
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b1daad00c24aff1628c76aa06cbdf7d8c498ab9c
> > --- /dev/null
> > +++ b/configs/imx91_11x11_frdm_inline_ecc_defconfig
> > @@ -0,0 +1,143 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_IMX9=y
> 
> This should make use of #include to avoid having to keep them in sync,
> and make sure that buildman can still build them both when done (or CI
> will fail).
> 
> > diff --git a/doc/board/nxp/imx91_frdm.rst b/doc/board/nxp/imx91_frdm.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..04780f1d8db693f8a32c0bf293d59454862166da
> > --- /dev/null
> > +++ b/doc/board/nxp/imx91_frdm.rst
> > @@ -0,0 +1,99 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +imx91_frdm
> > +=======================
> 
> Please see the docs on building the documentation, this and likely other
> style errors will fail in CI.
> 
> Thanks!
> 
> -- 
> Tom


