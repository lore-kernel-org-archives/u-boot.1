Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76015C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 11:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78C28656C;
	Thu, 31 Aug 2023 13:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ODAS/wRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BC88656D; Thu, 31 Aug 2023 13:36:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5538656A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 13:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37VBZvlB077835;
 Thu, 31 Aug 2023 06:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693481757;
 bh=FRKW8WPP34dENQg8DMS3Umb8ypxgcJ0g8vlDBEptBew=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ODAS/wRP+fh5rXM+5S5pjCmToQ81boW+QFjZcjXR2y81B51lkxNuUOOvOjo36ijcl
 mmE6wGO6w/8eikooD72BHUzwBBZ8E70hgHu4JalOeZR39LjyhKGu/ys0ACZZxRHQNq
 DYqOWpR2iCU2+olJH3o5CO6mmCnupakQuO1KAGGI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37VBZvId022436
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 06:35:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 06:35:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 06:35:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37VBZu3s009627;
 Thu, 31 Aug 2023 06:35:56 -0500
Date: Thu, 31 Aug 2023 06:35:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v1 0/4] J721E DTS Sync with Kernel v6.5-rc1
Message-ID: <20230831113556.axqxldonwz6edjvu@repave>
References: <20230828113109.2533045-1-n-francis@ti.com>
 <20230828173316.tpzluxjvcnwmcyjj@circus>
 <36818daf-81f5-a41d-0f20-9f4cb81537d2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36818daf-81f5-a41d-0f20-9f4cb81537d2@ti.com>
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

On 13:56-20230831, Neha Malcom Francis wrote:
> Hi Nishanth
> 
> On 28/08/23 23:03, Nishanth Menon wrote:
> > On 17:01-20230828, Neha Malcom Francis wrote:
> > > This series aims to sync kernel.org v6.5-rc1 DTS with that of U-Boot. It
> > > also includes cleanups where necessary along with certain changes to
> > > ensure boot is unaffected.
> > > 
> > > While it's mainly synced to the tag v6.5-rc1, one extra commit has been
> > > added that cleans up duplicating wkup_i2c0 nodes [1] in Kernel.
> > > 
> > > Same as with other board series that have taken up this effort, cleanup
> > > of mcu_ringacc and mcu_udmap are dependent on MCU Ringacc [2] and DMA
> > > [3] fixes. This will be taken up after their merge to Linux.
> > > 
> > > [1] https://lore.kernel.org/all/20230721082344.1534094-1-u-kumar1@ti.com/
> > > [2] https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
> > > [3] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
> > > 
> > > Boot logs:
> > > https://gist.github.com/nehamalcom/231426b784e0ba96ef3a0da84346e038
> > > 
> > > Neha Malcom Francis (4):
> > >    arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
> > >    arm: dts: k3-j721e: Sync with v6.5-rc1
> > >    drivers: misc: k3_avs: Add linux compatible to maintain sync
> > >    configs: j721e: Remove HBMC_AM654 config
> > please change the order of patches:
> > a) introduce the driver change for vtm
> > b) cleanup config and drop the hbmc node stuff
> > c) rest of dts sync
> > 
> > NOTE:
> > * J721e does'nt use SYSFW - it uses TIFS
> > * for properties that dont use bootph or u-boot, properties, we
> >    should'nt be including property changes in u-boot.dtsi or r5.dts
> >    without explanation as to what.
> > * There is a bunch of /delete-property/ plugged in for no clear reason.
> >    I see that even for timer - but timer data could have been included in
> >    arch/arm/mach-k3/j721e/dev-data.c and so could have been others too.
> >    This needs clear explanation.
> > 
> 
> All valid points, will factor these in. However regarding the timer, we have
> already tried to do the same for J721E by adding in the data in dev-data.c
> however this does not work since TIFS is in sysfw.itb which has not been
> loaded yet. Will take action to debug and root cause that further as well as
> try adding data for all the other existing /delete-property/ using nodes.

Thanks. What helped us on other platforms was to setup a breakpoints
with openocd ti_clk_probe and omap_timer_probe using the debug
technique[1] (board_init_f) and looking at the call stacks. in case of
am62, ti_clk_probe is hit first and call stack looks like [2] followed
by omap_timer_probe where the call stack looks like [3].

[1] https://u-boot.readthedocs.io/en/latest/board/ti/k3.html#code-modification
[2] https://gist.github.com/nmenon/495f85267ecd0c833218b5054b568b00
[3] https://gist.github.com/nmenon/c7a3a8c0de0a65b06334190ca9350ead

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
