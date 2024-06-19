Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EB9C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 18:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1A28839C;
	Wed, 19 Jun 2024 20:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Atywlw7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E818844C; Wed, 19 Jun 2024 20:20:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6987881C6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 20:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JIK5iT004044;
 Wed, 19 Jun 2024 13:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718821205;
 bh=xo7sMFO0OzO1TxPNl/76GmheAU3tDGFyFENraZtr8iE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Atywlw7V9KrI815S+LyGItHj2O/kol01qYuq3fEjBBT9SHzFb117C4PebZJB/nGqJ
 iD+5WeB9ODX2xtQ9J+H37I7AsCny4PcseustZpAFy+SOYnsIvkhWamfLzU+MQ8xq2j
 STxmIefZyyzORPNEXW7RkY8lLj1aAXJ3kR3MfDZc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JIK53B097119
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 13:20:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 13:20:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 13:20:05 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JIK56O122459;
 Wed, 19 Jun 2024 13:20:05 -0500
Date: Wed, 19 Jun 2024 13:20:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>, <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
Message-ID: <20240619182005.yfkvf6ongwijorzz@dividable>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-2-afd@ti.com>
 <20240619114916.72icpumb2tumsnbt@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619114916.72icpumb2tumsnbt@dhruva>
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

On 17:19-20240619, Dhruva Gole wrote:
> Hi,
> 
> On Feb 14, 2024 at 10:30:04 -0600, Andrew Davis wrote:
> > There is a default ATF load address that is used for devices that have
> > ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
> > of having to override the address in every defconfig, make add a
> > default for these ATF in DRAM devices.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  arch/arm/mach-k3/Kconfig               | 5 +++--
> >  configs/am62ax_evm_a53_defconfig       | 1 -
> >  configs/am62x_beagleplay_a53_defconfig | 1 -
> >  configs/am62x_evm_a53_defconfig        | 1 -
> >  configs/phycore_am62x_a53_defconfig    | 1 -
> >  configs/verdin-am62_a53_defconfig      | 1 -
> >  6 files changed, 3 insertions(+), 7 deletions(-)
> > 
> 
> Beagleplay stops booting completely with latest U-boot so I did a little
> bisect and it seems like reverting this patch helps.
> 
> I am not sure what other implications there are of reverting this so I
> don't suggest immediately dropping it, however some hints around what's
> missing on beagleplay vs other platforms would be helpful.
> 
> Because other platforms based off the same SoC don't seem to be
> affected.

Grumble... I had to rediscover this in parallel as well - Thanks Dhruva.
mkimage -l tispl.bin and comparing with kernel log of reserved mem
had me completely confused.

a) Memory maps are already notorious to manage on complex heterogenous
  systems. From beagle perspective, we have no need to go and monkey
  with DT defined memory map and DT should be the default and modifying
  DT should be explicitly called out with a log (instead of done
  "transparently") - so instead of CONFIG_K3_OPTEE_LOAD_ADDR default
  being forced from u-boot, it should be made optional, where when
  defined, it can overide the dt definition or some variant of that.

b) Looks like
   https://lore.kernel.org/u-boot/20240214163009.983034-4-afd@ti.com/
   missed beagleplay? and we were in for a surprise there - i dont want
   to switch from default dts for beagleplay to something different just
   because of simplicity for users to know exactly the carveouts and
   with other s/w starting up on uC, dts is our "canonical truth".

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
