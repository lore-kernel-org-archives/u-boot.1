Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE62D1D89F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 09:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7582B83F5D;
	Thu,  4 Dec 2025 10:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD35483F69; Thu,  4 Dec 2025 10:38:40 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360C883F32
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 10:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B49bPeL003955
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 4 Dec 2025 17:37:25 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Dec
 2025 17:37:25 +0800
Date: Thu, 4 Dec 2025 17:37:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: Hal Feng <hal.feng@starfivetech.com>
CC: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, "Emil Renner
 Berthing" <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Message-ID: <aTFWSF-MFs40a37w@swlinux02>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
 <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
 <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B49bPeL003955
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

Hi Hal, E,

On Mon, Oct 27, 2025 at 08:14:55AM +0000, Hal Feng wrote:
> [EXTERNAL MAIL]
> 
> > On 24.10.25 18:58, E Shattow wrote:
> > Hi Hal, this is very good, I have some suggestion to improve more.
> >
> > On 10/24/25 01:59, Hal Feng wrote:
> > >
> > /****************************************************************/
> > > This patch picked from [1] is just for test and can be ignored.
> > > dts/upstream should be synced regularly with devicetree-rebasing.
> > >
> > > [1]
> > > https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivete
> > > ch.com/
> > >
> > /****************************************************************/
> > >
> > > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> > >
> > > Board features:
> > > - JH7110S SoC
> > > - 2/4/8 GiB LPDDR4 DRAM
> > > - AXP15060 PMIC
> > > - 40 pin GPIO header
> > > - 1x USB 3.0 host port
> > > - 3x USB 2.0 host port
> > > - 1x M.2 M-Key (size: 2242)
> > > - 1x MicroSD slot (optional non-removable eMMC)
> > > - 1x QSPI Flash
> > > - 1x I2C EEPROM
> > > - 1x 1Gbps Ethernet port
> > > - SDIO-based Wi-Fi & UART-based Bluetooth
> > > - 1x HDMI port
> > > - 1x 2-lane DSI
> > > - 1x 2-lane CSI
> > >
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
> > >  1 file changed, 159 insertions(+)
> > >  create mode 100644
> > > dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > >
> > > diff --git
> > > a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.d
> > > ts
> > > b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.d
> > > ts
> > > new file mode 100644
> > > index 00000000000..30842b0cd1f
> > > --- /dev/null
> > > +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-li
> > > +++ te.dts
> > > @@ -0,0 +1,159 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> > > + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>  */
> > > +
> > > +/dts-v1/;
> > > +#include "jh7110-common.dtsi"
> > > +
> > > +/ {
> > > +   model = "StarFive VisionFive 2 Lite";
> > > +   compatible = "starfive,visionfive-2-lite", "starfive,jh7110s"; };
> > ...
> >
> > FYI as a follow-up to my earlier comments about modifying the dts subtree I
> > have now a working recommendation:
> >
> > 1). Return to using "RFC" subject prefix for the series while any modification
> > exists to dts subtree. The comment said about this is do not post any "DO
> > NOT MERGE" type patches that touch dts subtree, however...
> >
> > 2). Additions to CONFIG_OF_LIST will cause a build error if there is not any
> > corresponding file in the dts subtree. Use a workaround:
> >
> > git mv
> > dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> > touch dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > git add
> > dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> 
> Thank you for providing another way to deal with this situation.
> 
> With your method,
> 1. The situation will be more complicated in this patch, because I try to modify the
> common dtsi (jh7110-common.dtsi).
> 2. The maintainers have to revert the temporary device trees we added in arch/riscv/dts/
> after the same device trees appear in dts/upstream/src/riscv/starfive/. It will bring more
> work to the OF_UPSTREAM maintainers.
> 
> I think it may be easier for maintainers to merge the u-boot patches after the
> Linux device trees has already appeared in dts/upstream/.

Got it. I have learned that the patchset is still being reviewed.
(https://lore.kernel.org/linux-riscv/20251125075604.69370-1-hal.feng@starfivetech.com/T/#t)
I will merge this patchset after the dts/upstream/ is sync'ed with Linux device tree.

Best regards,
Leo

> 
> >
> > Alternatively for your local development environment:
> >
> > echo '#include
> > "/path/to/linux.git/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-
> > lite-u-boot.dtsi"'
> 
> Maybe you mean "/path/to/linux.git/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts"
> 
> > > arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> >
> > This "-u-boot.dtsi" suffix file will get picked up by the build system
> > automatically when there is a corresponding file (empty file is okay) in dts
> > subtree. The empty file in dts subtree is a simple git file operation with no
> > actual content. It is not perfect as an answer but it is better for the review
> > now, and for anyone else reading this that may want to do the same.
> >
> > You can see this in the working example of RFC v1 series for Milk-V Mars CM
> > re-introduction:
> >
> > https://lore.kernel.org/u-boot/20250925053233.1874027-1-e@freeshell.de/
> >
> > and the follow-up as v2 series as this lands in devicetree-rebasing:
> >
> > https://lore.kernel.org/u-boot/20251021231021.196336-1-e@freeshell.de/
> >
> > I hope that is a good example to follow for v3, v4 of your series
> >
> > 3). If you follow RFC -> PATCH -> RFC the version does increment (RFC v1,
> > PATCH v2, RFC v3, ...)
> 
> Thanks for your suggestions.
> 
> Best regards,
> Hal
