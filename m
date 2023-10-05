Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC2EE92706
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDAD86D04;
	Thu,  5 Oct 2023 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MxMK4qKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEA286D04; Thu,  5 Oct 2023 16:29:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A15E86B67
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395E4RJb010026;
 Thu, 5 Oct 2023 09:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696514667;
 bh=lN5BbeAydTxTYpaHiFQQL0rNK+MQlIkRuMnXG3Og/XY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MxMK4qKVi9kYRYMeNhpH/sn8y6lBaUThe6qLTpr7LrvfRkbJ3R7TIfatHE1d2vu+H
 lPMsSydAKa76k8HTSr9+5cTq3FrVfdv9qukxXASQnQmNTXWP7adh2Fr0Sdkx4/DFcJ
 mkzYVfcrkMoYVNmVWSvkO7uXJpGA3bHULAnvoLR0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395E4RF5063133
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 09:04:27 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 09:04:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 09:04:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395E4QtB017450;
 Thu, 5 Oct 2023 09:04:26 -0500
Date: Thu, 5 Oct 2023 09:04:26 -0500
From: reidt <reidt@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>
Subject: Re: [PATCH v4 2/2] arm: dts: j7200: dts sync with Linux 6.6-rc1
Message-ID: <20231005140426.44wnkiguqa2agb25@reidt-HP-Z2>
References: <20231004165629.506664-1-reidt@ti.com>
 <20231004165629.506664-3-reidt@ti.com>
 <20231005113336.tysphzl4dvc65oks@litigate>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005113336.tysphzl4dvc65oks@litigate>
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

On 06:33-20231005, Nishanth Menon wrote:
> On 11:56-20231004, Reid Tonking wrote:
> > Sync j7200 dts with Linux 6.6-rc1
> [..]
> > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > index e62f9218e8..9469dca39f 100644
> > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > @@ -1,13 +1,14 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
> >   */
> >  
> >  /dts-v1/;
> >  
> > -#include "k3-j7200-som-p0.dtsi"
> > +#include "k3-j7200-common-proc-board.dts"
> >  #include "k3-j7200-ddr-evm-lp4-2666.dtsi"
> >  #include "k3-j721e-ddr.dtsi"
> > +#include "k3-j7200-common-proc-board-u-boot.dtsi"
> >  
> >  / {
> >  	aliases {
> > @@ -15,17 +16,6 @@
> >  		remoteproc1 = &a72_0;
> >  	};
> >  
> > -	chosen {
> > -		stdout-path = &main_uart0;
> > -		tick-timer = &timer1;
> > -		firmware-loader = &fs_loader0;
> > -	};
> > -
> > -	fs_loader0: fs_loader@0 {
> > -		bootph-all;
> > -		compatible = "u-boot,fs-loader";
> > -	};
> > -
> >  	a72_0: a72@0 {
> >  		compatible = "ti,am654-rproc";
> >  		reg = <0x0 0x00a90000 0x0 0x10>;
> > @@ -39,21 +29,17 @@
> >  		ti,sci = <&dmsc>;
> >  		ti,sci-proc-id = <32>;
> >  		ti,sci-host-id = <10>;
> > -		bootph-pre-ram;
> > -	};
> > -
> > -	clk_200mhz: dummy_clock_200mhz {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		clock-frequency = <200000000>;
> > -		bootph-pre-ram;
> > +		bootph-all;
> 
> Here and else where in the r5 file: why switch from pre-ram to bootph-all
> ? dont we need these prior to ddr initialization?
>

Due to the change in how booth-pre-ram works [0], bootph-pre-ram alone no
longer works. U-boot docs Pre-Relocation Support section says some-ram
can be used for u-boot prior to reloc, but not spl. So like Massimo
mentioned in the linked discussion, some-ram + pre-ram can work, as well
as -all. Outside of affecting the TPL phase, I'm not sure I know of a
difference in regards to how it affects pre-ddr.


[0]: https://lore.kernel.org/u-boot/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/

> [...]
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
