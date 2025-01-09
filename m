Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DABAE7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 19:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBC8800C2;
	Thu,  9 Jan 2025 20:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EDxHA+hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA04800D0; Thu,  9 Jan 2025 20:48:53 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE87F8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 20:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 509JmjT63205539
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Jan 2025 13:48:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736452125;
 bh=9G/sEjO1ZDEB4HE3KCexi2jSFz6PmbFNjokOUGYymz4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=EDxHA+hpnntUa7aCZrmNSfGqBd8SBZKteEYc4km/6B7Dx5XT/ZtCh5pewzh6OXaOz
 AMzdacV6d6dtcbsvSoJZ2IxDeTQm6CyJG9DPZGmRfONKjVhymF5pdjPga0+WRR5mIG
 uq22iVm9bZktBTRWeFGapO/3REXDIzioHiv6XOrI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 509JmjkC082059;
 Thu, 9 Jan 2025 13:48:45 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Jan 2025 13:48:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Jan 2025 13:48:44 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 509JmiLC009520;
 Thu, 9 Jan 2025 13:48:44 -0600
Date: Thu, 9 Jan 2025 13:48:44 -0600
From: Bryan Brattlof <bb@ti.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <u-boot@lists.denx.de>, "Limaye, Aniket" <a-limaye@ti.com>
Subject: Re: [PATCH] board: ti: j722s: j722s.env: Set remoteproc firmware names
Message-ID: <20250109194844.icvp3futji3qamoy@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250108102516.2103132-1-b-padhi@ti.com>
 <20250108141659.rsvnmlurqdyxnocc@bryanbrattlof.com>
 <251ea7ec-03b9-4f73-9951-0f89f9cf2959@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <251ea7ec-03b9-4f73-9951-0f89f9cf2959@ti.com>
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

On January  9, 2025 thus sayeth Beleswar Prasad Padhi:
> Hi Bryan!
> 
> On 08/01/25 19:46, Bryan Brattlof wrote:
> > Hi Beleswar!
> > 
> > On January  8, 2025 thus sayeth Beleswar Padhi:
> > > Include k3_rproc.env to access rproc boot commands and specify rproc
> > > firmware names for adding remoteproc support in J722S SoCs.
> > > 
> > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > ---
> > > This patch is independent and puts the environment in place to boot remote
> > > processors at U-Boot stage.
> > > 
> > > However, for successfully loading the firmwares into remote cores, rproc
> > > DT node definitions are required. These DT changes have been merged into
> > > Linux and available with v6.12 tag[0]. Once the DT Sync happens in U-Boot,
> > > remote processors can be probed and booted with the help of env commands
> > > enabled with this patch.
> > > 
> > > Sample Boot Test logs after manually adding DT nodes in U-Boot:
> > > https://gist.github.com/3V3RYONE/0b5c7df5b5c88d2a2f273b6a04a3dd46
> > > 
> > > [0]: https://lore.kernel.org/all/20240830161742.925145-1-b-padhi@ti.com/
> > > 
> > > Thanks,
> > > Beleswar
> > > 
> > >   board/ti/j722s/j722s.env | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/board/ti/j722s/j722s.env b/board/ti/j722s/j722s.env
> > > index f8b6aff2c2f..10d62034e1a 100644
> > > --- a/board/ti/j722s/j722s.env
> > > +++ b/board/ti/j722s/j722s.env
> > > @@ -1,6 +1,10 @@
> > >   #include <env/ti/ti_common.env>
> > >   #include <env/ti/mmc.env>
> > > +#if CONFIG_CMD_REMOTEPROC
> > > +#include <env/ti/k3_rproc.env>
> > > +#endif
> > > +
> > >   name_kern=Image
> > >   console=ttyS2,115200n8
> > >   args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> > > @@ -13,3 +17,5 @@ mmcdev=1
> > >   bootpart=1:2
> > >   bootdir=/boot
> > >   rd_spec=-
> > > +
> > > +rproc_fw_binaries= 0 /lib/firmware/j722s-mcu-r5f0_0-fw 2 /lib/firmware/j722s-main-r5f0_0-fw 3 /lib/firmware/j722s-c71_0-fw 4 /lib/firmware/j722s-c71_1-fw
> > For SE devices do these firmware have that *-sig suffix?
> 
> 
> Yes, for all K3 SE devices, the "*-sec" suffix is appended to the existing
> firmware paths[0].
> 
> > My thinking is
> > this seems fairly specific to yocto with other distributions like debian
> > or QNX will have different names or paths. Should this be put in the env
> > that yocto builds?
> 
> 
> Debian currently uses the same firmware names like Yocto. But yes, thinking
> about multi-distro, we can leave the default firmware paths as empty, and
> leave it to the user to override these paths according to their distro. That
> will have to be done for all K3 devices, as currently all those define Yocto
> based firmware paths in the U-Boot board environment.
> 
> However, if we leave the default `rproc_fw_binaries` as empty, rproc boot
> will fail silently without complaining, which could be confusing to the
> user. Whereas, if we have Yocto (or any other distro's) firmware paths as
> default, rproc boot will complain "No such file or directory" and fail when
> using with a different distro. What are your thoughts?
> 
> [0]: https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/k3_rproc.env?ref_type=heads#L18

Yeah it puts a dependency on U-Boot to keep up any time debian or yocto 
wishes to change where they put the firmware on their rootfs in future 
releases as well :/ Ideally all of the scripting should go into the 
distros using them and let U-Boot stay distro neutral.

Unfortunately I don't see a clean way to do this unless yocto and debian 
take all of the env scripts so we can rip them out here.

A problem for another day though

Reviewed-by: Bryan Brattlof <bb@ti.com>

Thanks Beleswar!

~Bryan
