Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF43C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7805F8804F;
	Fri, 21 Jun 2024 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8tJ5+95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03408851C; Fri, 21 Jun 2024 15:49:26 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD7F88013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LDnLEt056535;
 Fri, 21 Jun 2024 08:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718977761;
 bh=eEeCMRtUCU8rCrHjRwt7R09F19xBQXp7oe5/9m0H2Kg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g8tJ5+95JBkHf3i/eyG7juc22qpe0qj4vme0qG1Dx/N8kClGWxDVerca1wO5h7TEY
 T6zj9ZGL2PxszC2HoXWV7XyW9nEGsybWP5Wh9us8EjUjWeACnQwWBQT0adclUsr19O
 mzA9II1nWal57t5b4on5Ji6lC8w9zug/NFPE7GjA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LDnLpR016584
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2024 08:49:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 08:49:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 08:49:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LDnLgl063178;
 Fri, 21 Jun 2024 08:49:21 -0500
Date: Fri, 21 Jun 2024 08:49:21 -0500
From: Bryan Brattlof <bb@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
Message-ID: <20240621134921.wh7onmz3upk576ob@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-2-afd@ti.com>
 <20240619114916.72icpumb2tumsnbt@dhruva>
 <20240619182005.yfkvf6ongwijorzz@dividable>
 <59c391a7-c6fe-4b04-891a-c6905ef29f20@ti.com>
 <0f41cd97-6876-43b8-a79a-9b047ae7485b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f41cd97-6876-43b8-a79a-9b047ae7485b@phytec.de>
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

On June 20, 2024 thus sayeth Wadim Egorov:
> 
> 
> Am 19.06.24 um 22:02 schrieb Andrew Davis:
> > On 6/19/24 1:20 PM, Nishanth Menon wrote:
> > > On 17:19-20240619, Dhruva Gole wrote:
> > > > Hi,
> > > > 
> > > > On Feb 14, 2024 at 10:30:04 -0600, Andrew Davis wrote:
> > > > > There is a default ATF load address that is used for devices that have
> > > > > ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
> > > > > of having to override the address in every defconfig, make add a
> > > > > default for these ATF in DRAM devices.
> > > > > 
> > > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > > ---
> > > > >   arch/arm/mach-k3/Kconfig               | 5 +++--
> > > > >   configs/am62ax_evm_a53_defconfig       | 1 -
> > > > >   configs/am62x_beagleplay_a53_defconfig | 1 -
> > > > >   configs/am62x_evm_a53_defconfig        | 1 -
> > > > >   configs/phycore_am62x_a53_defconfig    | 1 -
> > > > >   configs/verdin-am62_a53_defconfig      | 1 -
> > > > >   6 files changed, 3 insertions(+), 7 deletions(-)
> > > > > 
> > > > 
> > > > Beagleplay stops booting completely with latest U-boot so I did a little
> > > > bisect and it seems like reverting this patch helps.
> > > > 
> > > > I am not sure what other implications there are of reverting this so I
> > > > don't suggest immediately dropping it, however some hints around what's
> > > > missing on beagleplay vs other platforms would be helpful.
> > > > 
> > > > Because other platforms based off the same SoC don't seem to be
> > > > affected.
> > > 
> > > Grumble... I had to rediscover this in parallel as well - Thanks Dhruva.
> > > mkimage -l tispl.bin and comparing with kernel log of reserved mem
> > > had me completely confused.
> > > 
> > > a) Memory maps are already notorious to manage on complex heterogenous
> > >    systems. From beagle perspective, we have no need to go and monkey
> > >    with DT defined memory map and DT should be the default and modifying
> > 
> > Your DT source file is wrong, ATF is at 0x8000_0000 (or any address one
> > wants to put in K3_ATF_LOAD_ADDR). DT doesn't "define" hardware, it
> > "describes"
> > it. ATF's location is dynamic and configurable, it doesn't belong in DT.
> > 
> > You have two options, either go update your DT, then update it again every
> > time ATF moves. *OR* simply turn on OF_SYSTEM_SETUP and let U-Boot add the
> > correct location reserved memory node for you.
> > 
> > Then you can also drop out the reserved-node from the DT template file.
> > Only U-Boot knows where ATF is really placed in RAM, so U-Boot must add
> > this info to DT.
> 
> I think it is a good idea to remove the nodes from the device tree or at
> least mark them as "templates" and note that they are actually provided by
> the bootloader to make it less confusing.
> 

I have a patch lined up for this. My hope was we could remove all memory 
nodes completely from the kernel and have U-Boot fix these up. It's 
initialize DDR knows about capacity, inline ECC, and trowing all the 
different binaries into it. 

Our memory{} node fixup isn't ready yet unfortunately so I think just the 
reserved-memory{} node can be ripped out for now.

~Bryan

>
> > 
> > >    DT should be explicitly called out with a log (instead of done
> > >    "transparently") - so instead of CONFIG_K3_OPTEE_LOAD_ADDR default
> > >    being forced from u-boot, it should be made optional, where when
> > >    defined, it can overide the dt definition or some variant of that.
> > > 
> > > b) Looks like
> > >     https://lore.kernel.org/u-boot/20240214163009.983034-4-afd@ti.com/
> > >     missed beagleplay? and we were in for a surprise there - i dont want
> > 
> > This was the only miss, OF_SYSTEM_SETUP didn't get added to the beagleplay
> > config. Bryan just sent the fix for that now. I'll go look for a way to
> > make this common across the whole SoC family so we don't again miss any
> > new boards.
> > 
> > Andrew
> > 
> > >     to switch from default dts for beagleplay to something different just
> > >     because of simplicity for users to know exactly the carveouts and
> > >     with other s/w starting up on uC, dts is our "canonical truth".
> > > 
