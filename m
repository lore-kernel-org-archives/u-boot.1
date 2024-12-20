Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F966E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E468007D;
	Fri, 20 Dec 2024 11:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gZ2rjA6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD8C80087; Fri, 20 Dec 2024 11:16:26 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CA580079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKAGIcE447481
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Dec 2024 04:16:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734689778;
 bh=bCx/MhE5W4GgdCXWaz5Tt3kMJIyygSwH+wnrIjGFEIk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gZ2rjA6jAOvj4veFBuuz8hxvWdtvAMUp79yHRVRO4e/aKFgEOgilww/rKnQV5xTfh
 rMJMyUBFtG5iX1YV7nSO8JC372box6DIN34o5OO4rlsLR12uQNalOnAEsEv56yvIeA
 Z0RwDHBDhYA0+QlAN893iicvDcuzM8Cq9ab2AOdY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKAGIlM100859;
 Fri, 20 Dec 2024 04:16:18 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 04:16:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 04:16:18 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKAGHpa051060;
 Fri, 20 Dec 2024 04:16:18 -0600
Date: Fri, 20 Dec 2024 15:46:17 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
Message-ID: <20241220101617.7kwwtfjtebomtx2p@uda0497581>
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
 <20241217145300.GN1505244@bill-the-cat>
 <20241218050837.5fppn7j7s5vv5f5m@uda0497581>
 <20241218173837.GJ1505244@bill-the-cat>
 <CAFLszTjCez6yRW1F9HayLPk3deqPEAx-4uwYfpLcaQft=az-+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTjCez6yRW1F9HayLPk3deqPEAx-4uwYfpLcaQft=az-+A@mail.gmail.com>
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

Hi Simon,

On 08:08-20241219, Simon Glass wrote:
> Hi Tom,
> 
> On Wed, 18 Dec 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 18, 2024 at 10:38:37AM +0530, Manorit Chawdhry wrote:
> > > Hi Tom,
> > >
> > > On 08:53-20241217, Tom Rini wrote:
> > > > On Tue, Dec 17, 2024 at 02:24:37PM +0530, Manorit Chawdhry wrote:
> > > >
> > > > > Currently the driver relies on bootph flag to probe it during PRE_RELOC
> > > > > stage but with the upcoming cleanup of v6.13, we don't have the bootph
> > > > > property in the parent nodes anymore and ti_sci driver being one of the
> > > > > parent nodes required during SPL stage would end up hampering the probe
> > > > > model [0].
> > > > >
> > > > > Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.
> > > >
> > > >
> > > > Can you please expand on why with v6.13 we don't have the flag anymore?
> > > > Thanks.
> > >
> > > So the idea was that following series [0] would help us cleanup all the
> > > parent node bootph-* tags as putting a bootph-* in child node implies
> > > that it applies to parent nodes as well, though even if the parent node
> > > gets packed after the following series, the parent node still don't get
> > > probed as from my understanding, we need bootph-* tag to probe the
> > > driver as well but the phase tag doesn't get propagated as such.
> > >
> > > So while working in Linux, some comments related to this was raised [1]
> > > and after confirming the behaviour with Simon [2], the cleanup was done
> > > in Linux and meanwhile this way was found to probe the driver so that
> > > even after cleaning up the parent bootph-* tags we can continue.
> > >
> > > I don't think it's a hack also as this driver is required pre-relocation
> > > and this is another way to probe it pre-relocation but the only thing is
> > > that since the cleanup is done right now, we would kind of need it to be
> > > booting in some platforms ( that were fully reliant on Linux DT and
> > > don't have -u-boot override for this particular node with bootph-* )
> > > before 6.13 DT gets synced up.
> > >
> > > [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-1-sjg@chromium.org/
> > > [1]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda0497581/#t
> > > [2]: https://lore.kernel.org/u-boot/CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com/
> >
> > Thanks. Did you end up filing an issue about this? And can you now
> > perhaps push to make doing the fdtgrep work a priority? There's going to
> > be a lot of other cases like this to resolve I suspect.
> 
> fdtgrep is done, the confusion is that there are two [0] references in
> this chain. 
> 

Ah yeah, sorry for the confusion. 

> The one you want is:
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21
> 
> For SPL and U-Boot proper, all is well. But for pre-relocation, U-Boot
> doesn't actually bind parents even if their children have a bootph
> property, as I understand it. I believe that is what needs to be
> fixed?

So I see that when we jump from our SPL stage to U-boot proper and end
up in board_init_f with the common sequence, we end up in
dm_probe_devices.

#0  dm_probe_devices (dev=0x80478030, pre_reloc_only=pre_reloc_only@entry=true) drivers/core/root.c:294
#1  0x0000000080834f9c in dm_scan (pre_reloc_only=true) drivers/core/root.c:348
#2  dm_init_and_scan (pre_reloc_only=<optimized out>) drivers/core/root.c:361
#3  0x000000008089393c in initcall_run_list (init_sequence=init_sequence@entry=0x808b9dc0 <init_sequence_f>) lib/initcall.c:75
#4  0x0000000080828908 in board_init_f (boot_flags=<optimized out>) common/board_f.c:1026
#5  0x000000008080252c in _main () arch/arm/lib/crt0_64.S:100
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

dm_probe_devices act differently with and without this patch even though
there is no DT change and child node has the bootph. During traversal,
in working case we go to "system-controller@44083000" ( parent node of
power-controller ) from "bus@28380000" [5] but in failing case we don't
[6] ( DT model can be found at [7] )

Since the dm_probe_devices act differently, while going to serial_init
we end up not finding the driver for probing the clock and power domains
( children of system-controller ) and fail.

Though am not sure as to why it's not going to that node during
dm_probe_devices in the failing case, suspecting something around [8]
but not sure. Let me know if it helps Simon.

[5]: https://gist.github.com/manorit2001/a9b82b40b6c32643fb10d523cab9da70#file-with-the-dm_flag_pre_reloc-patch-L26-L48
[6]: https://gist.github.com/manorit2001/a9b82b40b6c32643fb10d523cab9da70#file-without-the-patch-L25-L39
[7]: https://github.com/torvalds/linux/blob/v6.13-rc3/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi#L9
[8]: https://github.com/u-boot/u-boot/blob/078542c346347406cfacdec8adeac66ae6758880/drivers/core/root.c#L297-L301

Regards,
Manorit

> 
> Regards,
> SImon
