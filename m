Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D568C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E59D882ED;
	Mon, 17 Jun 2024 16:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pxijy9wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E526988283; Mon, 17 Jun 2024 16:47:14 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA4388283
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HElAmM033356;
 Mon, 17 Jun 2024 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718635630;
 bh=aAO2B9WaGOlWs7MyM9sj1lL+b7O75wAXoR0YRxlpVxs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Pxijy9wt/gRQPDroaHRbF20ua5cZ/rvQ9/a2+kWP1mOQ+fV/hBP27fPqxVTFeR7Ly
 9MfL8G81oniwjWnvec3F0bBQtMsDPdmRlIOwN7n9t8nFR9Pl5NqBKes5pqjOROBkFW
 fglwM51PRGgtLwWeb9ZRWdzuK+KIAvPVp3l+cH+E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HElAeh068486
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 09:47:10 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 09:47:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 09:47:09 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HEl9m1002551;
 Mon, 17 Jun 2024 09:47:09 -0500
Date: Mon, 17 Jun 2024 09:47:09 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vibhore Vardhan <vibhore@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishant Menon <nm@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Judith Mendez <jm@ti.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
Message-ID: <20240617144709.wamf6gzjl75l7erp@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240613080604.3828083-1-d-gole@ti.com>
 <20240616015536.7qqiwnipnnp7m37t@bryanbrattlof.com>
 <CAOCHtYhcCj5=9iAspz-UcqxPzCqNhSLOtsSQ7kW0Hu3hgE27pw@mail.gmail.com>
 <20240617062512.fz2kle5wnxeq5fgb@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617062512.fz2kle5wnxeq5fgb@dhruva>
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

On June 17, 2024 thus sayeth Dhruva Gole:
> Hi Robert and Bryan,
> 
> On Jun 15, 2024 at 21:30:55 -0500, Robert Nelson wrote:
> > On Sat, Jun 15, 2024 at 8:55 PM Bryan Brattlof <bb@ti.com> wrote:
> > >
> > > On June 13, 2024 thus sayeth Dhruva Gole:
> > > > The Kernel Image and DTB files are supposed to be picked from the rootfs
> > > > of the SD Card, this fails in legacy boot flow because bootpart is set
> > > > to 1:1. Fix it.
> > > >
> > > > Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_*
> > > > defconfigs and env file")
> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > > ---
> > > >  board/beagle/beagleplay/beagleplay.env | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> > > > index bbf6b925d02c..190181c8ad0c 100644
> > > > --- a/board/beagle/beagleplay/beagleplay.env
> > > > +++ b/board/beagle/beagleplay/beagleplay.env
> > > > @@ -11,7 +11,7 @@ set_led_state_start_load=led led-0 on; led led-1 off;
> > > >       led led-2 on; led led-3 off; led led-4 on
> > > >  boot=mmc
> > > >  mmcdev=1
> > > > -bootpart=1:1
> > > > +bootpart=1:2
> > > >  bootdir=/boot
> > > >  boot_targets=mmc1 mmc0
> > > >  bootmeths=script extlinux efi pxe
> > >
> > > Shouldn't the fix be to just drop 'script' from bootmeths. These TI
> > > scripts needed to go away years ago.
> > 
> > I agree! nuke the non bootmeth's. ;)
> 
> People are still using legacy bootmethods out there. I think the cleanup
> will still take time till everyone is on the same page and I feel like
> beagle being a community platform, doesn't mandate to use a "fixed" boot
> flow atleast until stdboot is fully at feature parity with legacy boot.
> Some users may still care for the legacy boot method.
> 

> From the discussions so far it seems evident to me that the BeagleBone
> debian images are anyway going to be unaffected by this change so that
> removes the question of it causing any regressions on that end.
> 
> People who do want to use legacy boot and pick kernel image and DTB from
> their root partitions will benefit from this change for sure.
> 
> So I don't really see the need/argument here to not go ahead with this patch?
> 
> We can definitely have separate discussion around whether we need to remove
> legacy flow bits from upstream U-Boot, but no reason to keep this small fix
> blocked till we have those discussions is what I feel.

config_distro_bootcmd.h was introduced in 2014. If we or these 
distributions cannot update their packaging in a decade we cannot 
support them. Simply hiding their inability to update their builds and 
shifting the work to U-Boot is not acceptable. 

As you have just demonstrated these legacy boot scripts have no way of 
being tested. You've linked to a fundamental boot issue since the very 
introduction of the beagleplay support. Obviously no one is using them.

   a200f428b5b2 ("oard: ti: am62x: Add am62x_beagleplay_* ...

Fixing these scripts continue to signal to these distributions that 
relying on custom scripting to boot their distribution rather than 
packing a EFI stub or extlinux.conf file is acceptable. 

The reason I'm trying to block this is because we will never be able to 
remove them if we keep fixing them. I'm fine if we want to fix our 
reference boards booting Arago, but we shouldn't block BeaglePlay from 
cleaning up their codebase because of our reference distributions.

~Bryan
