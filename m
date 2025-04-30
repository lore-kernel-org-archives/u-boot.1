Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A204C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 19:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA328007D;
	Wed, 30 Apr 2025 21:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MnDRqXiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E508059D; Wed, 30 Apr 2025 21:31:55 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803088004F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UJVnIL014735
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 14:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746041510;
 bh=wvljx4gVDMgK2DsF0HpX76IzA1fAejYhE0W2YcAkgnc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MnDRqXiKQU1j6pa/45LKnhUD/YBc5O2W1IFYMz4neg3f5bQx6ca1JLj8BgAF5sI6v
 DxqXMxrRn0TG35EdSufaAyHb2/gEY3BriGVhvAaANa3QtyzSHCRp0UVCGPu9B/F1DD
 bEI6v1C2u37pQ69UNtRVLRartAKfDVcZsPCKyCYA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UJVnD4023483
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 14:31:49 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 14:31:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 14:31:49 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UJVnlE105606;
 Wed, 30 Apr 2025 14:31:49 -0500
Date: Wed, 30 Apr 2025 14:31:49 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430193149.gbfzi37e6yx2edfs@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
 <20250430163156.GV1261075@bill-the-cat>
 <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
 <20250430174004.GX1261075@bill-the-cat>
 <20250430192604.5dmv465thftsm2uj@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250430192604.5dmv465thftsm2uj@bryanbrattlof.com>
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

On April 30, 2025 thus sayeth Bryan Brattlof:
> On April 30, 2025 thus sayeth Tom Rini:
> > On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrote:
> > > 
> > > 
> > > On 4/30/2025 10:01 PM, Tom Rini wrote:
> > > > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> > > >> On April 30, 2025 thus sayeth Anshul Dalal:
> > > >>> As discussed here[1], the go command causes undefined behavior when used
> > > >>> for running custom OSes since the icache might hold outdated data. OSes
> > > >>> usually also expect the MMU to be disabled upon execution.
> > > >>>
> > > >>> Therefore this patch adds a call to cleanup_before_linux before we jump
> > > >>> to the loaded program/os which disables both the caches and the MMU.
> > > >>> This makes the go command's behavior consistent with riscv platforms.
> > > >>>
> > > >>
> > > >> I know quite a few other OSes are beginning to use U-Boot (QNX, 
> > > >> GreenHills or all the other RTOSes) each with their own requirements 
> > > >> from the bootloader. I'm curious if we should make boot* a little more 
> > > >> generic rather than abuse the 'go' command.
> > > 
> > > VXworks has its own:
> > > https://docs.u-boot.org/en/stable/usage/os/vxworks.html
> > > 
> > > I suppose QNX and others should ideally have their own cmds as needed.
> > 
> > Well, what's the QNX output file format (options?) again?
> 
> I've only ever seen outputs in compressed binary formats but I've been 
> told there are tools to produce an ELF for the simulators
> 

Ah as soon as I hit send I find it in the QNX docs[0] it's their own IFS 
format :)

[0] https://www.qnx.com/developers/docs/7.1/#com.qnx.doc.neutrino.building/topic/intro/intro_ifs.html

> > 
> > > > Well, that's what bootelf is for :)
> > > > 
> > > 
> > > And if its not an elf but some .bin file "go" cmd should be used in
> > > conjunction with "cache" cmd here to flush/disable cache, I guess?
> > 
> > Well, what exactly are we talking about? Is this an "in theory" or some
> > project(s) which exist today?
> > 
> 
> I noticed this thread mainly because of the number of RTOS people asking 
> me about low level stuff U-Boot and TF-A is doing. I haven't seen any 
> 'In-Production' type bugs but I wouldn't be surprised if U-Boot is being 
> used in their CI environments today.
> 
> ~Bryan
> 
> > There's a whole lot of reasons for either a legacy header and bootm or a
> > not-legacy FIT image. The "go" command is for the "U-Boot is a debugger"
> > side of the world, not how you should kick off some OS/application in
> > production. It is all of the "this is dangerous" idioms.
> > 
> > > If so, we should probably update the docs for this cmd appropriately so
> > > as to avoid end users overloading like what RISC-V did?
> > 
> > Yes, we should clarify things as needed and unwind, most likely, what
> > RISC-V is doing. But not blindly so as perhaps there's now, sigh, a
> > production / in-the-wild case here and we're now in a sticky spot.
> > 
> 
> I like the idea of boot${OS} flags if only to standardize the interface 
> of how each OS should boot. I worry about situation where custom 
> scripting is being used to boot in production rather than stdboot
> 
> ~Bryan
