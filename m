Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD28E7718B
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 06:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E427B8021D;
	Thu, 19 Dec 2024 07:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TpYcFavN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FF78022B; Thu, 19 Dec 2024 07:43:50 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE11801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ6hOmb3744105
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 00:43:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734590604;
 bh=tqQXgWFvQxoYOMitdZefqIC8b9PEFfGqft/3InVkEzI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TpYcFavNurihnsbcQDg33MorT67XKHA80gTZqW74E353UYUSZGprPuvXTSrL2l66X
 wZNbK7duQ6RPEHMDtDf8kiwS38FMs52CGNyLiH9xRgpfoIUta1WYDMPHyKv5k+V074
 C7N1ZH7zTDdSWe5X9H3oUr8AyI7mWxBXTfhiv2mc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ6hOP4104549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Dec 2024 00:43:24 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 00:43:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 00:43:24 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ6hNJd094413;
 Thu, 19 Dec 2024 00:43:23 -0600
Date: Thu, 19 Dec 2024 12:13:22 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <mkorpershoek@baylibre.com>, <afd@ti.com>, <glaroque@baylibre.com>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>,
 <rasmus.villemoes@prevas.dk>, <caleb.connolly@linaro.org>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 5/5] doc: board: document support for USB DFU boot on
 AM62Px SoC
Message-ID: <rxpqzluyl7cdpqpujehhej6xycqrcphnkmzppbfq6rmxikcgng@kamzjftilzsy>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-6-s-vadapalli@ti.com>
 <ebc7bc88-1545-4a53-8cd0-1c9812723025@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ebc7bc88-1545-4a53-8cd0-1c9812723025@kernel.org>
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

On Wed, Dec 18, 2024 at 04:08:01PM +0200, Roger Quadros wrote:

Hello Roger,

> 
> 
> On 18/12/2024 14:45, Siddharth Vadapalli wrote:

[...]

> > +DFU based boot
> > +--------------
> > +
> > +To boot the board over DFU, set the switches to DFU mode and connect to the
> > +USB type C DRD port on the board. After power-on the build artifacts needs to be
> > +uploaded one by one with a tool like dfu-util.
> > +
> > +The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
> > +upload. The next stages as exposed by U-Boot have target alts matching the name
> > +of the artifacts, for these a USB reset has to be done after each upload.
> > +
> > +When using dfu-util the following commands can be used to boot to a U-Boot shell:
> > +
> > +.. prompt:: bash $
> > +
> > +  dfu-util -a bootloader -D tiboot3.bin
> > +  dfu-util -R -a tispl -D tispl.bin
> > +  dfu-util -R -a u-boot.img -D u-boot.img
> 
> Is there a known reason why -R was not used for the first command but required in last two?
> What about if -R is not used for all 3 commands?

According to the "dfu-util" help menu, the "-R" option is defined as:
"Issue USB Reset signalling once we're finished"

While the "-R" option is not required in the first stage / command, it
is required in the next stages. Without "-R", the user would have to
press "Ctrl+C" to proceed i.e. tispl.bin / u-boot.img are transferred
/ downloaded onto the device but not executed until user presses "Ctrl+C".

As to why "-R" is not required in the first stage, I suppose that ROM
automatically executes tiboot3.bin after it has been transferred.

Regards,
Siddharth.
