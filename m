Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42292C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7388C86A50;
	Thu, 17 Aug 2023 08:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BGujx6F1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E55C86A53; Thu, 17 Aug 2023 08:31:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65148696B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H6VQ3K110837;
 Thu, 17 Aug 2023 01:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692253886;
 bh=2sHIu2IbpojTlUPuFmSqS7iF06vDalmM1yS4gv4DdKU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BGujx6F1wdRCJJGY63MAgfYkdMeNWf54n6p03gmL79z20jqp9T2aerrmqUIRHK2/9
 lB6WhAKGcIdm6TYG58w6U722yXHYnrKM3W3skXOqsZX67Jo3JkCUN53KKAf2Vdqssb
 NG/VrMaYx1t5obiW5q3QpUnMA3LR8LGFRZn3nsnw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H6VQYl016910
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 01:31:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 01:31:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 01:31:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H6VK0J031528;
 Thu, 17 Aug 2023 01:31:24 -0500
Date: Thu, 17 Aug 2023 12:01:20 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
Message-ID: <20230817063120.kdaaszy7qja2kfrk@ula0497581>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
 <20230816114445.c4c7rgdp5arhmiaq@polyester>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816114445.c4c7rgdp5arhmiaq@polyester>
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

Hi Nishanth,

On 06:44-20230816, Nishanth Menon wrote:
> On 14:53-20230816, Manorit Chawdhry wrote:
> > The following commit syncs the device tree from Linux tag
> > next-20230815 to U-boot and fixes the following to be compatible with
> > the future syncs -
> 
> NAK - please use 6.5-rc1 as baseline to integrate. we can use v6.6-rc1
> once that occurs to clean up further.

Sure, would use 6.5-rc1 as baseline.

> 
> [..]
> Nice first attempt, but there is more to do: - Same comments apply for
> am68, so please take it there as well.
> 
> > 
> > All these have been put in a single commit to not break the
> > bisectability.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> [..]
> 
> >  &wkup_i2c0 {
> >  	bootph-pre-ram;
> >  };
> > @@ -35,16 +17,17 @@
> >  	bootph-pre-ram;
> >  };
> >  
> > -&cbass_mcu_wakeup {
> > -	bootph-pre-ram;
> > -
> > -	timer1: timer@40400000 {
> > -		compatible = "ti,omap5430-timer";
> > -		reg = <0x0 0x40400000 0x0 0x80>;
> > +&mcu_timer0 {
> > +		/delete-property/ power-domains;
> > +		/delete-property/ assigned-clocks;
> > +		/delete-property/ assigned-clock-parents;
> 
> NAK - this should come in from R5 data.
> >  		ti,timer-alwon;
> NAK.
> >  		clock-frequency = <250000000>;
> >  		bootph-pre-ram;
> > -	};
> 
> you should just have:
> &mcu_timer0 {
> 	clock-frequency = <250000000>;
> 	bootph-pre-ram;
> };
> 
> Introduce the required data into the power / clock data for R5.
> A72 side should just work fine with this since DM should be up and
> running by this time.

Let me give this a try to see if that works as I believe Udit was having
some problems with this..

> 
> > +};
> > +
> > +&cbass_mcu_wakeup {
> > +	bootph-pre-ram;
> >  
> >  	chipid@43000014 {
> >  		bootph-pre-ram;
> > @@ -56,12 +39,6 @@
> >  };
> >  
> >  &mcu_ringacc {
> > -	reg =   <0x0 0x2b800000 0x0 0x400000>,
> > -		<0x0 0x2b000000 0x0 0x400000>,
> > -		<0x0 0x28590000 0x0 0x100>,
> > -		<0x0 0x2a500000 0x0 0x40000>,
> > -		<0x0 0x28440000 0x0 0x40000>;
> > -	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
> 
> You need to retain this for v6.5-rc1 in 6.6-rc1 sync we will do this change.
> 

Sure, would do the needful!

> >  	bootph-pre-ram;
> >  };
> >  
> > @@ -129,19 +106,6 @@
> >  	bootph-pre-ram;
> >  };
> >  
> > -&mcu_cpsw {
> > -	reg = <0x0 0x46000000 0x0 0x200000>,
> > -	      <0x0 0x40f00200 0x0 0x8>;
> > -	reg-names = "cpsw_nuss", "mac_efuse";
> > -	/delete-property/ ranges;
> > -
> > -	cpsw-phy-sel@40f04040 {
> > -		compatible = "ti,am654-cpsw-phy-sel";
> > -		reg= <0x0 0x40f04040 0x0 0x4>;
> > -		reg-names = "gmii-sel";
> > -	};
> > -};
> > -
> >  &main_sdhci0 {
> >  	bootph-pre-ram;
> >  };
> 
> [...]
> 
> > diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > index c74e8e58ae81..dd1c371ba6b5 100644
> > --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > @@ -5,7 +5,7 @@
> >  
> >  /dts-v1/;
> >  
> > -#include "k3-j721s2-som-p0.dtsi"
> > +#include <k3-j721s2-common-proc-board.dts>
> 
> Why <> instead of ""?

Ah, I can keep it "", don't know why I went with <>
> 
> Is there a reason to go with proc-board instead of som-p0?

I see the same in k3-am625-r5-sk.dts..

#include "k3-am625-sk.dts"
#include "k3-am62x-sk-ddr4-1600MTs.dtsi"
#include "k3-am62-ddr.dtsi"

#include "k3-am625-sk-u-boot.dtsi"

And I believe the reason must be so that all the Linux fixes get
propagated to R5 dts as I mentioned in the commit message.

> >  [snip]
> >    - Include k3-j721s2-common-proc-board.dts file
> >
> >        Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
> >        include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
> >        to U-boot.
> >  [snip]

Let me know if the reasoning is wrong..

> 
> >  #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
> >  #include "k3-j721s2-ddr.dtsi"
> >  #include "k3-j721s2-binman.dtsi"
> > @@ -14,7 +14,7 @@
> >  	chosen {
> >  		firmware-loader = &fs_loader0;
> >  		stdout-path = &main_uart8;
> > -		tick-timer = &timer1;
> > +		tick-timer = &mcu_timer0;
> >  	};
> >  
> >  	aliases {
> > @@ -51,38 +51,22 @@
> >  		bootph-pre-ram;
> >  	};
> >  
> > -	clk_19_2mhz: dummy_clock_19_2mhz {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		clock-frequency = <19200000>;
> > -		bootph-pre-ram;
> > -	};
> >  };
> 
> Why do you need the clk_200mhz ? we have a clock and dm functionality.

This was being used by some sdhci things so I didn't touch this as I
wasn't sure how to handle that, maybe some clk-data/dev-data is missing
that is causing all these hacks to come. Would have to look at what is
missing and how to make this work without these dummy clocks

> 
> Why do you need fs_loader0 anymore? there is no phandlepart property.
> 
> [...]
> 
> did you check for overlaps between u-boot.dtsi and r5.dts?
> &sms for example has duplicate bootph-pre-ram property.

Ah no, haven't checked this, Thanks for the reminder!

> 
> >  
> >  &main_sdhci0 {
> >  	/delete-property/ power-domains;
> >  	/delete-property/ assigned-clocks;
> > @@ -182,11 +105,8 @@
> >  	/delete-property/ power-domains;
> >  	/delete-property/ assigned-clocks;
> >  	/delete-property/ assigned-clock-parents;
> 
> Why do you need to delete-property of power-domains, assigned-clocks
> etc? you should be able to rely on clock and power domain data in R5
> SPL.

This had been existing previously only and I didn't touch it thinking it
was required, would revisit these changes to see how they can work
without these things.

> 
> > -	pinctrl-0 = <&main_mmc1_pins_default>;
> > -	pinctrl-names = "default";
> >  	clock-names = "clk_xin";
> >  	clocks = <&clk_200mhz>;
> > -	ti,driver-strength-ohm = <50>;
> 
> Is this even correct?
> >  };
> >  
> >  &mcu_ringacc {
> 
> I see that you are overriding &mcu_udmap -> But I have not seen kernel
> patches to clean that up to introduce reg-names "rchan" "tchan" and "rflow".

I believe the patch is posted Nishanth if you are asking about mcu_udmap, 
I had added that in the cover letter, You can have a look at [0].
Vignesh is handling adding those nodes in Linux.

[0]: https://lore.kernel.org/all/20230810174356.3322583-4-vigneshr@ti.com/

> 
> Why not? looks like 6.6-rc1 wont have things cleaned up either.
> 
> 
> [...]
> 
> Move the #include "k3-j721s2-common-proc-board-u-boot.dtsi" 
> to the top.
> 
> The order should be:
> 
> #include "board.dts"

I see that you are also using board.dts here and not som-p0.dts, let me
know what should be done about it. As I recall you having a previous
comment mentioning about this.

Thanks and Regards,
Manorit

> #include "ddr-timing.dtsi"
> #include "ddr.dtsi"
> #include "board-uboot.dtsi"
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
