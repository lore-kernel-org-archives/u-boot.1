Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2FBC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 15:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB0F881B8;
	Thu, 11 Jul 2024 17:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C56881C3; Thu, 11 Jul 2024 17:18:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 34814880D8
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 17:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7E31007;
 Thu, 11 Jul 2024 08:18:45 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2883F762;
 Thu, 11 Jul 2024 08:18:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:18:17 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Jagan Teki" <jagan@amarulasolutions.com>, "Tom Rini"
 <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] sunxi: SPL SPI: add support for the V3s SoC
Message-ID: <20240711161817.6a71b39f@donnerap.manchester.arm.com>
In-Reply-To: <D2MR3PWR6RGY.1OTMOYJLMSNYR@kernel.org>
References: <20240513234319.1966434-1-mwalle@kernel.org>
 <D2MR3PWR6RGY.1OTMOYJLMSNYR@kernel.org>
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

On Thu, 11 Jul 2024 15:40:47 +0200
"Michael Walle" <mwalle@kernel.org> wrote:

> On Tue May 14, 2024 at 1:43 AM CEST, Michael Walle wrote:
> > The V3s is identical regarding register layout, clocks and resets to
> > the sun6i variants. Therefore, we can just add the MACH_SUN8I_V3S to
> > the sun6i compatible ones.
> >
> > SPI boot was tested on a custom board with a Gigadevice GD25Q64 8MiB
> > SPI flash.  
> 
> Also here.. any news?

I have all of them in my queue, to be part of the first pull request in
the next few days.

Cheers,
Andre.

> 
> -michael

