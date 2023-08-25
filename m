Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFC8C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C193869C3;
	Fri, 25 Aug 2023 03:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ARhlVWOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AFF869AC; Fri, 25 Aug 2023 03:59:43 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0175E869C3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37P1xVq4117446;
 Thu, 24 Aug 2023 20:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692928771;
 bh=8g3IwzVWUxVnm0JmbQOVa+ljRgGFqsP2Ljs7ruYMdh8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ARhlVWOPs+2EqftO8DIp/rYez9kmZMhtc48BDk7ys4yaZ44nGmLaY5dkxtqDGlUp8
 BG/5Nxw5L+rPPVB7ObvPOpUjUUtA08/5jwrZEGf0tSWsVzeYMSOoj48WYxAYMqGM/4
 yhkwfKxLw+a84XXBQ3mVmv8I85mxSNrJDaX+pU14=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37P1xVks110106
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 20:59:31 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 20:59:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 20:59:31 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37P1xVaf046754;
 Thu, 24 Aug 2023 20:59:31 -0500
Date: Thu, 24 Aug 2023 20:59:31 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@google.com>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230825015931.fkx7jx4sqxdr7cqe@directly>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
 <20230825012224.ydk4332yb4qodrdb@unfazed>
 <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
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

On 19:31-20230824, Simon Glass wrote:
> > >
> > > Also I tried the mmc instructions and managed to brick the board. Is
> > Hmm.. This is just documenting what Robert has in his scripts[1]
> >
> > > there a recovery procedure?
> >
> > Oopsie.. Sorry you had to hit that..
> >
> > >
> > > I suppose I should have tries it on an SD card first. I thought that
> > > was what I was doing, but I didn't know about the internal mmc...
> >
> > Recovery currently involves booting off sd and flashing the emmc up :(
> > unfortunately.. USB DFU etc are still work in progress.
> 
> Hmm so does that mean I need an ARM machine do to the SD
> boot-partition magic, or can I use a USB reader on an x86 box

I just have x86box with SDcard reader - and I use Balena etcher app
image to keep my head straight.

> 
> >
> > A ready to go image such as [2] emmc flasher image might help speed
> > things up.
> >
> > [1] https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-u-boot-beagleplay-mainline/suite/bookworm/debian/install-emmc.sh
> > [2] https://rcn-ee.net/rootfs/debian-arm64-12-bookworm-xfce-v5.10-ti/2023-08-24/

I realized I just pointed you to Robert's in-work space.. rather not do
that. Sorry.

> > emmc flasher image
> 
> OK thanks. I am not sure how to use those yet, but will make a note.

Just https://etcher.balena.io/ and flash an SD card with the official
image here: https://www.beagleboard.org/distros/beagleplay-debian-11-flasher

https://files.beagle.cc/file/beagleboard-public-2021/images/am625x-emmc-flasher-debian-11.6-xfce-arm64-2023-02-04-10gb.img.xz


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
