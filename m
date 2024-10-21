Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8612ED0E6C0
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 07:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6B7892D9;
	Mon, 21 Oct 2024 09:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UGnagbWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2792892DC; Mon, 21 Oct 2024 09:36:14 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880408852D
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6459D148AB3D; Mon, 21 Oct 2024 09:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729496171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=bTpUqpaY/SHO9DxUquBAqGfoBBwpiZTJhoSEEmJgWVo=;
 b=UGnagbWYZeixU1Ah09LnE3tyJe0xCp/kx8QVyoHoMuHvTtqfU3uiwXUkmcxFMaK0xEc1kE
 9YYgC/RkDYHtW34Ad46yO/Ne6jIaLMuCjjcHsXRZGOSOkd6TWuMB/bKGsVolR7hlzh6y0h
 rQWlWiiDv/ohVg+w1XjDdjxFdBtHDh8+fVFTBVtBsKZguD4kiffI9OhBggEVGa1wyjwIMO
 aubcENpOtlirhIejx0sjRq7ATHr70RzInO6Z7JKJG0MP0A87L/mUvoVXzlkdyHfEtCIevd
 k2HrXEGqF0IJOIscuaIkOd7eZ2qQOXyi2jbo8uBRtBwSzNX3CDyGrfEjcP7v1g==
Date: Mon, 21 Oct 2024 09:36:09 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de,
 John Ogness <john.ogness@linutronix.de>, ada@thorsis.com
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241021-profile-among-48555c7055b9@thorsis.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@linaro.org>,
 Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de,
 John Ogness <john.ogness@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
 <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Eugen,

Am Mon, Oct 21, 2024 at 10:17:54AM +0300 schrieb Eugen Hristev:
> Hello,
> 
> On 10/21/24 09:03, Alexander Dahl wrote:
> > Hello Benedikt,
> > 
> > Am Fri, Oct 18, 2024 at 04:19:08PM +0200 schrieb Benedikt Spranger:
> > > On Fri, 18 Oct 2024 15:11:20 +0200
> > > Alexander Dahl <ada@thorsis.com> wrote:
> > > 
> > > Hello Alexander,
> > > 
> > > > Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt Spranger:
> > > > > OK, you might say the nand_atmel NAND driver is obsolete, but it
> > > > > was the only solution to get booting from NAND running. The new DM
> > > > > based NAND driver refused to do anything usefull, so I dropped it
> > > > > after spending a couple of days debugging it:
> > > > 
> > > > Strange.  I have at least three different boards with SAMA5D27
> > > > successfully booting from NAND flash with the new DM based driver
> > > > (unfortunately none of them upstreamed, which also won't change in the
> > > > foreseeable future, sorry).
> > > OK.
> > > > Do you use at91bootstrap as 2nd level bootloader like me or something
> > > > else?
> > > I use the U-Boot SPL. There is no UBI support in at91boostrap. There
> > > were some attemps, but...
> > > No interest at the at91bootstrap side.
> 
> It's not about interest. There are two main reasons:
> First, all open source UBI stacks are GPL. At91bootstrap is not GPL and it
> cannot take GPL restricted code (being MIT ).
> Second, all UBI stacks are huge in terms of code and memory. At91bootstrap
> is a second stage that should fit in 16k , 32k or 64k depending on the
> platform. So far this restriction could not be met by any UBI
> implementation.
> ... and yes, doing a custom in-house small UBI implementation would be
> challenging, and costly.

I suspected technical reasons, but nice to know it's also licensing.

(Side note: To increase robustness we considered storing bootloaders
(and maybe U-Boot env) in SPI-NOR flash with longer data retention,
and use UBI on raw NAND for everything else.)

> 
> > 
> > Yeah, been there.  Wanted at91bootstrap to boot from SPI-NOR which is
> > _not_ Quad-SPI, and the feature request was closed with "if you wanna
> > do it by yourself, ask our support for help". :-/
> 
> iirc at91bootstrap can boot from raw spi-nor (yes, not UBI)

Speaking of at91bootstrap 3.x and later: It can, but only if you use
the QSPI port, it does not work with flexcom for example.  See
https://github.com/linux4sam/at91bootstrap/issues/181 for reference.

> > 
> > > > For me it was basically getting the dts for U-Boot correct, but
> > > > I got that running with all U-Boot releases since 2023.04 up to
> > > > 2024.10.  Could you share some more detail?
> > > I face all the trouble in SPL. And since the SPL is the essential part
> > > here (UBI support) I gave up at one point. I simply couldn't any
> > > usefull read data from the NAND flash, but all 0.
> > 
> > You can not store bootstrap or SPL in UBI, it must sit in first sector
> > of raw NAND, I suppose that's how you load SPL?  Did you try
> > reading/writing raw NAND from there?  I'm not familiar with SPL, does
> > it consider dts?  I could share my dts parts if that helps you.
> 
> SPL should use dts. However on at91 platforms, SPL is dangerously close to
> the SRAM limit where it should fit, and it has been challenging in the last
> years to either make it fit or remove it.
> 
> > 
> > (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
> > at91bootstrap loads U-Boot from raw NAND at some offset like 0x20000,
> > U-Boot (proper) loads everything else from UBI.)
> 
> Either way, it is interesting to see that the U-boot proper NAND dm driver
> does not work without at91bootstrap.
> There may be NAND quirks in at91bootstrap board init that may influence this
> (pins resets, timing delays, etc).

Think this is a misunderstanding here.  I have this combination
running, and from the discussions on NAND issues on at91 on this list
I think at least two developers at Microchip, too.  From my
understanding U-Boot proper completely (re)initializes everything
required to get NAND to work.  I can not speak about U-Boot SPL
though, never tried that.

> You can test NAND driver by booting at91bootstrap and Uboot from another
> medium, like sd-card. In this way, at91bootstrap will not touch NAND device,
> and you have a clean U-boot booted.

Lets hear what Benedikt has tried. ;-)

Greets
Alex

