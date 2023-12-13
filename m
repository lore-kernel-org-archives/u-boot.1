Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F73C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45148726C;
	Wed, 13 Dec 2023 15:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RGK81xXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA94B87780; Wed, 13 Dec 2023 15:23:28 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC4E86F28
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDENGh7106688;
 Wed, 13 Dec 2023 08:23:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702477396;
 bh=8Xl81sbQqMdN++ZDazBgUeDve2Nn5TMkOWAyCQQv9mM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RGK81xXLan0SClYlpJCFh1S4TDUCs6Cm7WL0qaq5iv9qS6rAGw1Wqf70wciwrEdvx
 EZeZrsad2rQY8b4LRZPZO/JPcttSaF9TaJvoY+h2/yzLSXyFVOc2CwnOqZYyHvlnVo
 kSZsB8XVsw9LA6sCEQzXyzZCBph8ybYsNsLXC+cQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDENFeM021316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Dec 2023 08:23:15 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 08:23:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 08:23:15 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDENFxs014247;
 Wed, 13 Dec 2023 08:23:15 -0600
Date: Wed, 13 Dec 2023 08:23:15 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Sjoerd Simons <sjoerd@collabora.com>, <u-boot@lists.denx.de>, Martyn Welch
 <martyn.welch@collabora.com>, Dave Gerlach <d-gerlach@ti.com>, "Marcel
 Ziswiler" <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 4/4] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20231213142315.cxmz3jaglqxxi3ax@snugness>
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-5-sjoerd@collabora.com>
 <20231213035845.m77fgbgik7pu6mdo@bryanbrattlof.com>
 <f7b9a398f05e690cb556e52e3bb7d6cd9f0f41f6.camel@collabora.com>
 <20231213125700.dy2y6zuqmh3hk35x@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213125700.dy2y6zuqmh3hk35x@bryanbrattlof.com>
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

On 06:57-20231213, Bryan Brattlof wrote:
> On December 13, 2023 thus sayeth Sjoerd Simons:
> > Hey Brian,
> > 
> > On Tue, 2023-12-12 at 21:58 -0600, Bryan Brattlof wrote:
> > [...]
> > > > 
> > > >  configs/am62x_evm_a53_defconfig       |  31 ++++++-
> > > >  configs/am62x_evm_r5_usbdfu_defconfig | 111
> > > > ++++++++++++++++++++++++++
> > > 
> > > One of the newer developments was the addition of config fragments[0]
> > > to 
> > > try to minimize all the duplicate defconfigs for all the different 
> > > evaluation boards for the same SoC we have in the pipeline. I'm 
> > > wondering what people would think if we did this for the different 
> > > boot-mode defconfigs for the 62xx extended family like this usbdfu
> > > and 
> > > cpsw? 
> > > 
> > > idk how messy it would get trying to disable one of the primary boot 
> > > modes like MMC and enable USB though... So this may be a idea for 
> > > another day.
> > 
> > Nishanth mentioned the same and it's something i'd like to play with
> 
> Ah Ok! As long as you saw it :)
> 
> > (a beagleplay is on the way, but stuck in customs atm for some 
> > practical tests).
> > 
> 
> Nice! It's a fun little board
> 
> > However I think it would make sense to get this landed first and then
> > try refactoring with config fragments for a second step?
> > 
> 
> I agree. It's on my TODO list to try to clean up some of the messes 
> we've made so I thought I chime in
> 
> Don't let me stop you from adding features

I prefer we do the fragments with this series. We can validate and
update the fragment if required with follow on. but rather not keep
churning the usage model.

Also missing is documentation update on how to build/use dfu mode.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
