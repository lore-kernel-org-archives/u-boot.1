Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399A9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 12:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B27587506;
	Wed, 13 Dec 2023 13:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jUOP7duJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF9D87509; Wed, 13 Dec 2023 13:57:09 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8668747A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 13:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCv1JT071080;
 Wed, 13 Dec 2023 06:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702472221;
 bh=MJSZFtI9KPhKW/lE8ggjsZD8FMZHlQo/wnr7pPgLvKg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jUOP7duJa64U80Rv0SHX0kPc0ShWi3Br/e8FWb3mopFxfXn8NiKvoSSnl4zc1s31W
 OcEn2P5G971yZjtrWiSbscRzdAdG69L9bSzNeAuSIdMZqXlf4QPdNjFKjvTi52H9Dc
 cGU7LNNOl/3BNxVM5eHMgQhRn3R+40NQdakqgS1k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDCv1Oq078434
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Dec 2023 06:57:01 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 06:57:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 06:57:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCv0Hu099867;
 Wed, 13 Dec 2023 06:57:00 -0600
Date: Wed, 13 Dec 2023 06:57:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Martyn Welch
 <martyn.welch@collabora.com>, Dave Gerlach <d-gerlach@ti.com>, "Marcel
 Ziswiler" <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 4/4] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20231213125700.dy2y6zuqmh3hk35x@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-5-sjoerd@collabora.com>
 <20231213035845.m77fgbgik7pu6mdo@bryanbrattlof.com>
 <f7b9a398f05e690cb556e52e3bb7d6cd9f0f41f6.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7b9a398f05e690cb556e52e3bb7d6cd9f0f41f6.camel@collabora.com>
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

On December 13, 2023 thus sayeth Sjoerd Simons:
> Hey Brian,
> 
> On Tue, 2023-12-12 at 21:58 -0600, Bryan Brattlof wrote:
> [...]
> > > 
> > >  configs/am62x_evm_a53_defconfig       |  31 ++++++-
> > >  configs/am62x_evm_r5_usbdfu_defconfig | 111
> > > ++++++++++++++++++++++++++
> > 
> > One of the newer developments was the addition of config fragments[0]
> > to 
> > try to minimize all the duplicate defconfigs for all the different 
> > evaluation boards for the same SoC we have in the pipeline. I'm 
> > wondering what people would think if we did this for the different 
> > boot-mode defconfigs for the 62xx extended family like this usbdfu
> > and 
> > cpsw? 
> > 
> > idk how messy it would get trying to disable one of the primary boot 
> > modes like MMC and enable USB though... So this may be a idea for 
> > another day.
> 
> Nishanth mentioned the same and it's something i'd like to play with

Ah Ok! As long as you saw it :)

> (a beagleplay is on the way, but stuck in customs atm for some 
> practical tests).
> 

Nice! It's a fun little board

> However I think it would make sense to get this landed first and then
> try refactoring with config fragments for a second step?
> 

I agree. It's on my TODO list to try to clean up some of the messes 
we've made so I thought I chime in

Don't let me stop you from adding features

~Bryan
