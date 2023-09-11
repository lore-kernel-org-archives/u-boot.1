Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180FBEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 11:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4588886D80;
	Mon, 11 Sep 2023 13:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wPdPLIwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443BD86DE4; Mon, 11 Sep 2023 13:06:21 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D602086C8C
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 13:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BB6EMs123931;
 Mon, 11 Sep 2023 06:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694430374;
 bh=D1NrG9rxxJuqQSP2TodksyzyUF44y6HBJj0EBBbxu7E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wPdPLIwWDO4t+ZTEP7bM0xPD6p8+5J7j692BrVyQu6bulHYeItJX4NUdB51u+eWg6
 /XBm6K5Y2hNNbLC7ocfdBvAOiNtFHGxIYWujBa47Ss6X7HsfVoYVR4drLGyylPWpM4
 1C6fgUFHKzG22r0EVFFcAFPNtwOMdjXH/rqEQjHw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BB6ECI000955
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 06:06:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 06:06:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 06:06:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BB6DRt024072;
 Mon, 11 Sep 2023 06:06:13 -0500
Date: Mon, 11 Sep 2023 06:06:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Trevor Woerner <twoerner@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Pierre Lebleu
 <pierre.lebleu@pile-engineering.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-pocketbeagle: choose tick-timer
Message-ID: <20230911110613.fas6yjqtds6fkjpu@remission>
References: <20230830152553.15465-1-twoerner@gmail.com>
 <20230908173617.7c2xto3n4hqltnf2@ferris>
 <20230909132734.GA9887@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230909132734.GA9887@localhost>
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

On 09:27-20230909, Trevor Woerner wrote:
> On Fri 2023-09-08 @ 12:36:17 PM, Nishanth Menon wrote:
> > On 11:25-20230830, Trevor Woerner wrote:
> > > Commit 4b2be78ab66c ("time: Fix get_ticks being non-monotonic")
> > > requires '/chosen/tick-timer' in device-tree. Otherwise we get:
> > > 
> > > 	U-Boot 2023.07.02 (Jul 11 2023 - 15:20:44 +0000)
> > > 
> > > 	CPU  : AM335X-GP rev 2.1
> > > 	Model: TI AM335x PocketBeagle
> > > 	DRAM:  512 MiB
> > > 	Core:  154 devices, 16 uclasses, devicetree: separate
> > > 	Could not initialize timer (err -19)
> > > 
> > > 	resetting ...
> > > 
> > > Suggested-by: Pierre Lebleu <pierre.lebleu@pile-engineering.com>
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > >  arch/arm/dts/am335x-pocketbeagle.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/dts/am335x-pocketbeagle.dts b/arch/arm/dts/am335x-pocketbeagle.dts
> > > index b379e3a5570d..02e3aac56064 100644
> > > --- a/arch/arm/dts/am335x-pocketbeagle.dts
> > > +++ b/arch/arm/dts/am335x-pocketbeagle.dts
> > > @@ -15,6 +15,7 @@
> > >  
> > >  	chosen {
> > >  		stdout-path = &uart0;
> > > +		tick-timer = &timer2;
> > >  	};
> > >  
> > >  	leds {
> > > -- 
> > > 2.41.0.327.gaa9166bcc0ba
> > > 
> > 
> > Does enabling CONFIG_SYS_ARCH_TIMER solve this?

[...]

> Getting the code to compile with CONFIG_SYS_ARCH_TIMER would require a deeper
> reworking of the configuration/Make logic in order to swap out the functions
> in arch/arm/mach-omap2/timer.c for the ones in
> arch/arm/cpu/armv7/arch_timer.c. The definitions of those functions in both
> those locations are quite different, so even after getting the build to work
> there's no guarantee the arch functions would work.

The difference is using SoC level dmtimer vs cpu level arch timer.
Either way, it will be good to send this upstream kernel.org.

Looking at the trm[1], it looks like arch timer isn't there for
cortex-a8?

[1] https://developer.arm.com/documentation/ddi0344/latest/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
