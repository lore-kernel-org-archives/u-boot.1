Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64ECC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F4782B27;
	Thu, 15 May 2025 13:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WJfyFHPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 135AC82B44; Thu, 15 May 2025 13:36:16 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5C282B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBa08d2925080
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 06:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747308960;
 bh=iBb3SWP4VtUPgoalsBWnOE/vZM5jOvldvGs1RoQfbTo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WJfyFHPopU90BYx1gypC2CnCH6X40zTfWbwTwuBYjPK6ItYo4u9i6Xe/E9OB/jUpT
 EOYyb+WN5TC49euSV9RO85R/AA4Pzc+x8JlZ4RyKW9NewZzGT4yl3t4LQaEbtq8dHM
 d1DCW7pLIbsyOSv/IIJ1vGlijn4SkVN43aVoqeR8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBa0Of103444
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 06:36:00 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:35:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:35:59 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBZwKv058611;
 Thu, 15 May 2025 06:35:59 -0500
Date: Thu, 15 May 2025 17:05:58 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vishal Mahaveer
 <vishalm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Chandru Dhavamani
 <chandru@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vitor Soares
 <vitor.soares@toradex.com>
Subject: Re: [PATCH 1/3] arm: dts: k3-*-r5: Remove clocks from mcu_timer0
Message-ID: <20250515113558.h5wrc3z7anl5evy2@uda0497581-HP>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
 <20241121-b4-upstream-pll-fix-v1-1-904f618897a7@ti.com>
 <20250515101859.GA43440@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515101859.GA43440@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Francesco,

On 12:18-20250515, Francesco Dolcini wrote:
> Hello Manorit,
> 
> On Thu, Nov 21, 2024 at 05:32:51PM +0530, Manorit Chawdhry wrote:
> > Updated PLL driver sequencing requires us to use udelay in the PLL
> > driver as there is no poll bit to get the status of operations.
> > tick-timer(mcu_timer0/main_timer0) setting up the clocks for itself is
> > something that won't work as the PLL driver will be using udelay and
> > PLLs are configured during clock probe which would end up in a recursive
> > probe.
> > 
> > tick-timer being used by K3 devices are configured by ROM and we really
> > don't need to configure any of the clocks.
> > 
> > Remove the clock dependency from R5 stage as we don't need to setup
> > clocks for it.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi         | 10 ----------
> >  arch/arm/dts/k3-am62-r5-lp-sk.dts              |  9 +++++++++
> >  arch/arm/dts/k3-am625-r5-sk.dts                |  9 +++++++++
> >  arch/arm/dts/k3-am625-sk-u-boot.dtsi           | 10 ----------
> >  arch/arm/dts/k3-am62a7-r5-sk.dts               | 10 ++++++++++
> >  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi          |  5 -----
> >  arch/arm/dts/k3-am62p5-r5-sk.dts               |  8 ++++++++
> >  arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  4 ++++
> >  arch/arm/dts/k3-j721e-r5.dtsi                  |  6 +++++-
> >  arch/arm/dts/k3-j721s2-r5.dtsi                 |  4 ++++
> >  arch/arm/dts/k3-j722s-r5-evm.dts               |  8 ++++++++
> >  arch/arm/dts/k3-j784s4-r5.dtsi                 |  5 ++++-
> >  12 files changed, 61 insertions(+), 27 deletions(-)
> 
> This change should have been done to any board using any of those SoC,
> correct? verdin-am62 was not changed, for example.
> 

Yes, you are right, I somehow missed it. Though I realise that I think
making a common r5.dtsi just like k3-j721e-r5.dtsi would have helped
mitigated this I think, might be cleanup for next time. 

I won't be able to test this change but am sending a series to cover the
remaining boards that I could notice, let me know if it works for you..

Thanks for bringing it to the notice. Apologies for any inconveniences.

Regards,
Manorit

> Francesco
> 
> 
