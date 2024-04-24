Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC2C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 15:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446ED886E9;
	Wed, 24 Apr 2024 17:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCAA886EC; Wed, 24 Apr 2024 17:49:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E9CC988564
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DCA81063;
 Wed, 24 Apr 2024 08:49:40 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5DBD3F73F;
 Wed, 24 Apr 2024 08:49:11 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:49:09 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] sysreset: psci: drop reliance on SPL support
Message-ID: <20240424164909.77cb7792@donnerap.manchester.arm.com>
In-Reply-To: <20240424010144.GB1054907@bill-the-cat>
References: <20240423234604.10674-1-andre.przywara@arm.com>
 <20240424010144.GB1054907@bill-the-cat>
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

On Tue, 23 Apr 2024 19:01:44 -0600
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> On Wed, Apr 24, 2024 at 12:46:04AM +0100, Andre Przywara wrote:
> > At the moment enabling CONFIG_SYSRESET_PSCI *selects* SPL_ARM_PSCI_FW,
> > even though this is a platform design property, so nothing any driver
> > should enforce. Some platforms load the PSCI runtime (TF-A) only in the
> > SPL, so PSCI is naturally not available during SPL runtime.
> > 
> > Spit CONFIG_SYSRESET_PSCI up into an SPL and a U-Boot proper version,
> > and let the former *depend* on SPL_ARM_PSCI_FW.
> > 
> > This allows to enable CONFIG_SYSRESET_PSCI on platforms without SPL PSCI
> > support.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/sysreset/Kconfig  | 8 +++++++-
> >  drivers/sysreset/Makefile | 2 +-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index 49c0787b26d..62fe9eb6220 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -119,11 +119,17 @@ config SYSRESET_PALMAS
> >  config SYSRESET_PSCI
> >  	bool "Enable support for PSCI System Reset"
> >  	depends on ARM_PSCI_FW
> > -	select SPL_ARM_PSCI_FW if SPL
> >  	help
> >  	  Enable PSCI SYSTEM_RESET function call.  To use this, PSCI firmware
> >  	  must be running on your system.
> >  
> > +config SYSRESET_SPL_PSCI  
> 
> This should be SPL_SYSRESET_PSCI so that..

Ouch, you are of course right! Will send a fixed v2.

Cheers,
Andre

> 
> [snip]
> > -obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
> > +obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PSCI) += sysreset_psci.o  
> 
> This works.
> 

