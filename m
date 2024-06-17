Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB7C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CF5882DA;
	Mon, 17 Jun 2024 17:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PU4lKmpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633F1882E8; Mon, 17 Jun 2024 17:54:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CEA88271
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HFspxL032171;
 Mon, 17 Jun 2024 10:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718639691;
 bh=12X3oj25NSuiz0iG1Rhd6NI0AajyYCyvQyLNE0A6W1o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PU4lKmpkWCsi7vVTOGqBHxAGK4S9hi6MyCLgvGPfdtuyEImEawP1LitzuhL3yMJON
 s/leiEfWzOdxqJQH3TAiwY6DpOiS+wU3SQdrZ25jHRbK4JMXwTwylEpGw7BdAtRxjZ
 R/kzDOtcsvXwDd9yKTa/9bjzIbg94DUD3Dss0bKU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HFspO7100660
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 10:54:51 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 10:54:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 10:54:51 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HFspx6071352;
 Mon, 17 Jun 2024 10:54:51 -0500
Date: Mon, 17 Jun 2024 10:54:51 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vibhore Vardhan
 <vibhore@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
Message-ID: <20240617155451.v3ztgnnazvfztoct@krypton>
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

On 11:55-20240617, Dhruva Gole wrote:
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


Based on an offline discussion, while it is in the ineterest of dropping
legacy boot, we are currently supporting both set of users at the
moment. The fix is valid for legacy boot folks.. so, for this patch, at
this point in time:

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
