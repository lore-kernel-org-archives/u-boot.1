Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0842C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 14:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51151889F1;
	Tue, 16 Jul 2024 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89E7889A2; Tue, 16 Jul 2024 16:20:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 89AE7889A2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F70D1063;
 Tue, 16 Jul 2024 07:21:07 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081523F762;
 Tue, 16 Jul 2024 07:20:40 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:20:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Jagan Teki" <jagan@amarulasolutions.com>, "Tom Rini"
 <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] spi: sunxi: drop max_hz handling
Message-ID: <20240716152038.02743da0@donnerap.manchester.arm.com>
In-Reply-To: <D2QRO88MEAKU.2AJR76UULNW16@kernel.org>
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <20240712171457.3104804-2-mwalle@kernel.org>
 <20240716010541.745a6c09@minigeek.lan>
 <D2QRO88MEAKU.2AJR76UULNW16@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 16 Jul 2024 08:58:14 +0200
"Michael Walle" <mwalle@kernel.org> wrote:

> Hi,
> 
> > > The driver is trying to read the "spi-max-frequency" property of the
> > > *controller* driver node. There is no such property. The
> > > "spi-max-frequency" property belongs to the SPI devices on the bus.  
> >
> > Ah, indeed, good catch! Many thanks for sending this!
> >    
> > > Right now, the driver will always fall back to the default value of 1MHz
> > > and thus flash reads are very slow with just about 215kb/s.  
> >
> > That's even slower, right? I guess around 125 KB/s?  
> 
> Yes of course :) 1Mhz/8 at most. I was fooled by the "sf update"
> command which will skip the same sectors and then the overall speed
> will be faster.
> 
> > > In fact, the SPI uclass will already take care of everything and we just
> > > have to clamp the frequency to the values the driver/hardware supports.
> > > Thus, drop the whole max_hz handling.  
> >
> > Looks good to me, I verified this by timing the read, this patch indeed 
> > significantly increases the performance. Also changing the limit in the
> > DT gets reflected in the driver and in the read speed. Also verified
> > that the values read from the SPI flash are the same in all cases.
> >  
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>  
> >
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > Tested-by: Andre Przywara <andre.przywara@arm.com>
> >
> > I will make this part of the first 2024.10 PR.  
> 
> This means just 1/2 or both? Because there was no Rb on the second
> patch.

Just this one for now, as I was preparing the pull request. It's a fix, so
I can send it anytime later, it doesn't have to wait for anything.
I was hoping we can fix that other calculation issue at the same time.

Cheers,
Andre.
