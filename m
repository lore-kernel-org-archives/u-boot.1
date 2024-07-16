Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F986C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 00:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE3E87E13;
	Tue, 16 Jul 2024 02:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860B688633; Tue, 16 Jul 2024 02:34:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6082587D14
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 02:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F31061063;
 Mon, 15 Jul 2024 17:35:19 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878E83F762;
 Mon, 15 Jul 2024 17:34:53 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:32:43 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] spi: sunxi: Improve the loading speed
Message-ID: <20240716013243.13ce69ce@minigeek.lan>
In-Reply-To: <CALeDE9P05YN092mYQ15Kha+1sd6Yp97qkk-ODMyXASB2Ae_SVQ@mail.gmail.com>
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <CALeDE9P05YN092mYQ15Kha+1sd6Yp97qkk-ODMyXASB2Ae_SVQ@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Fri, 12 Jul 2024 18:28:15 +0100
Peter Robinson <pbrobinson@gmail.com> wrote:

> On Fri, 12 Jul 2024 at 18:25, Michael Walle <mwalle@kernel.org> wrote:
> >
> > Right now, the maximal transfer speed from an SPI flash on a V3s is
> > about 240kb/s. That is pretty slow. It turns out, that due to an
> > error u-boot is setting the maximum frequency to 1MHz. By fixing
> > that another bug is unearthed: one cannot set a clock divider of 1:1
> > due to the handling between CDR1 and CDR2 handling. By fixing that
> > I achieved loading speeds of about 1.5MB/s.  
> 
> Minor nit, should the clock fix go first so there's not a regression
> if someone needs to do a bisect on the first commit?

I am not sure this really matters here, since this patch just lifts the
frequency from 12 MHz to 24 MHz, while patch 1/2 lifts it from 1 MHz to
12 MHz. So there is no regression as such.

Cheers,
Andre

> 
> > Michael Walle (2):
> >   spi: sunxi: drop max_hz handling
> >   spi: sunxi: fix clock divider calculation for max frequency setting
> >
> >  drivers/spi/spi-sunxi.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > --
> > 2.39.2
> >  

