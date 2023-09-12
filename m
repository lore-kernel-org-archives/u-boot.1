Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6289DCA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470086E71;
	Tue, 12 Sep 2023 14:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P2B9e37C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F271386ECA; Tue, 12 Sep 2023 14:35:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63D186E1B
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CCZKiu042269;
 Tue, 12 Sep 2023 07:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694522120;
 bh=PoPJjTCulAc4BGwifeS6b0uvFbdHNQBgW4GZoOFPwKo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=P2B9e37C+Skni+i3cvtCtK16KY7Fdp4gkZ/DQWlndNmQH5VYYGeWCz7TaJs+cQ6/z
 2ET1jgO8lKw9lQOdjWTcHMNk8zgi/HrDcpf9MZI+LdjjVVxumvVWrj0+hr6hOp3nGQ
 zO1g5mm1E7g47x1KLeFOXFcdIxvqtaAQbKmXlUGk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CCZK1R071062
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 07:35:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 07:35:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 07:35:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CCZKIS043320;
 Tue, 12 Sep 2023 07:35:20 -0500
Date: Tue, 12 Sep 2023 07:35:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "j-kacines@ti.com"
 <j-kacines@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "rasmus.villemoes@prevas.dk"
 <rasmus.villemoes@prevas.dk>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>, "rogerq@kernel.org"
 <rogerq@kernel.org>
Subject: Re: [PATCH v3 10/16] arm: dts: Introduce am69-sk dts from linux kernel
Message-ID: <20230912123520.apessa2vva7qrjvl@snowiness>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-11-a-nandan@ti.com>
 <3479ca4023a23c81d7ef3ca44d1e740ce73960c2.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3479ca4023a23c81d7ef3ca44d1e740ce73960c2.camel@toradex.com>
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

On 12:10-20230912, Marcel Ziswiler wrote:
> On Fri, 2023-09-08 at 16:35 +0530, Apurva Nandan wrote:
> > From: Dasnavis Sabiya <sabiya.d@ti.com>
> > 
> > Introduce the basic am69-sk evm dts from the next-20230905 tag of the
> > linux kernel.
> > 
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  arch/arm/dts/Makefile       |   3 +-
> >  arch/arm/dts/k3-am69-sk.dts | 364 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 366 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/k3-am69-sk.dts
> > 
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 363f7a1171..1bcdbea9e5 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -1330,7 +1330,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
> >                                k3-am68-sk-r5-base-board.dtb\
> >                                k3-j721s2-common-proc-board.dtb\
> >                                k3-j721s2-r5-common-proc-board.dtb
> > -dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-evm.dtb\
> > +dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-sk.dtb\
> > +                              k3-j784s4-evm.dtb\
> >                                k3-j784s4-r5-evm.dtb
> >  dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
> >                               k3-am642-r5-evm.dtb \
> > diff --git a/arch/arm/dts/k3-am69-sk.dts b/arch/arm/dts/k3-am69-sk.dts
> > new file mode 100644
> > index 0000000000..0699370911
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-am69-sk.dts
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Should be:
> 
> GPL-2.0-only

Nope - comes from the kernel and is in sync with what the rest of dts
imports look like.

> 
> > +/*
> > + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> > + *
> > + * Design Files: https://www.ti.com/lit/zip/SPRR466
> > + * TRM: https://www.ti.com/lit/zip/spruj52
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/net/ti-dp83867.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "k3-j784s4.dtsi"
> > +
> > +/ {
> > +       compatible = "ti,am69-sk", "ti,j784s4";
> > +       model = "Texas Instruments AM69 SK";
> 
> I never understood TI's naming. Somewhere they call it Evaluation Module (EVM), somewhere Starter Kit (SK) and
> even at other places Evaluation Board (EVB).
> 

Hehe - neither do we understand marketing speak - changes over time
etc.. overall pattern: SK is cost optimized (aka "low cost"
and limited expansion) vs evm - relatively large expansion and expensive ;)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
