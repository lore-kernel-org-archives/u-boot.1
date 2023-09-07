Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE5EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A30986A14;
	Thu,  7 Sep 2023 17:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lgM/ITMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC63386A22; Thu,  7 Sep 2023 17:57:56 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B5A86A22
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387FvnAs091643;
 Thu, 7 Sep 2023 10:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694102269;
 bh=nlsLKf9xw/+L7ZwISDBN3lUMF4nMBpdZtojc9ueD00I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lgM/ITMS/Ufs79ZM1Otdn8gRZIVunqN1DeArNvF+y+RNR0l8xKyBu7++925ytQK17
 BQOcibOvP/8+w+hcHQf882hplp9vzBWxkCSh4MG+sIFZRsrNpmH3jst+9XPCJCE+KG
 cxsIPjTB2/ZfdCsfivor40OdDiujgYYjXNQKzzcE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387FvnuA029270
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 10:57:49 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 10:57:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 10:57:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387Fvm1x048767;
 Thu, 7 Sep 2023 10:57:48 -0500
Date: Thu, 7 Sep 2023 10:57:48 -0500
From: reidt <reidt@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] arm: dts: j7200: dtb sync with Linux 6.5-rc1
Message-ID: <20230907155748.shdgy5unxe3svxt4@reidt-HP-Z2>
References: <20230905181309.61666-1-reidt@ti.com>
 <20230905181309.61666-4-reidt@ti.com>
 <20230907043337.j6o4c7wvnqutp6ms@ula0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907043337.j6o4c7wvnqutp6ms@ula0497581>
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

On 10:03-20230907, Manorit Chawdhry wrote:
> Hi Reid,
> 
> On 13:13-20230905, Reid Tonking wrote:
> > Sync j7200 device tree files with Linux 6.5-rc1
> > 
> > - k3-j7200-r5-common-proc-board.dts now inherits from
> >   k3-j7200-common-proc-board.dts instead of k3-j7200-som-p0.dtsi. This
> >   allows us to trim down the r5 file considerably by using existing
> >   properties.
> > 
> > - remove pimux nodes from r5 file
> > 
> > - remove duplicate nodes & node properties from r5/u-boot files
> > 
> > - mcu_timer0 now used instead of timer1
> > 
> >   mcu_timer0 device id added to dev-data.c file in order to work
> > 
> > - remove cpsw node
> > 
> >   This node is no longer required since the compatible is now fixed
> > 
> > - remove dummy_clock_19_2_mhz
> > 
> >   This node wasn't being used anyhere, so it was removed.
> > 
> > - remove dummy_clock_200mhz
> > 
> >   main_sdhci0 & main_sdhci1 no longer need dummy clock for eMMC/SD
> > 
> > - fix secure proxy node
> > 
> >   mcu_secproxy changed to used secure_prxy_mcu which is already
> >   defined in k3-j7200-mcu-wakeup.dtsi
> > 
> > Signed-off-by: Reid Tonking <reidt@ti.com>
> > ---
> >  .../k3-j7200-common-proc-board-u-boot.dtsi    | 160 +++---
> >  arch/arm/dts/k3-j7200-common-proc-board.dts   | 170 ++++--
> >  arch/arm/dts/k3-j7200-main.dtsi               | 512 +++++++++++++++++-
> >  arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 265 ++++++++-
> >  .../arm/dts/k3-j7200-r5-common-proc-board.dts | 301 +---------
> >  arch/arm/dts/k3-j7200-som-p0.dtsi             | 153 ++++--
> >  arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
> >  arch/arm/dts/k3-j7200.dtsi                    |  30 +-
> >  8 files changed, 1150 insertions(+), 488 deletions(-)
> >  create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
> > 
> > diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > index f25c7136c9..c32df00e9c 100644
> > --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi

[...]

> > @@ -78,10 +63,6 @@
> >  
> >  &dmsc {
> >  	bootph-pre-ram;
> > -	k3_sysreset: sysreset-controller {
> > -		compatible = "ti,sci-sysreset";
> > -		bootph-pre-ram;
> > -	};
> 
> This is required for resetting the board in U-boot I believe, can only
> see the compatible present in U-boot.
> 
> Regards,
> Manorit
> 

Thanks for catching that, I'll add that back in for v3. 

Thanks,
Reid
