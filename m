Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A116E82CBC
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 00:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1708655F;
	Thu, 28 Sep 2023 02:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8095586679; Thu, 28 Sep 2023 02:36:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 686C3864EE
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B7D1FB;
 Wed, 27 Sep 2023 17:36:48 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6A23F5A1;
 Wed, 27 Sep 2023 17:36:09 -0700 (PDT)
Date: Thu, 28 Sep 2023 01:35:02 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 5/5] HACK: sunxi: psci: be compatible with v1 of R528
 patchset
Message-ID: <20230928013502.2c3b4f53@slackpad.lan>
In-Reply-To: <123596d6-f7c8-f7f1-9a0a-07f68a5ed1b8@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-6-CFSworks@gmail.com>
 <20230927173221.122c8de2@donnerap.manchester.arm.com>
 <123596d6-f7c8-f7f1-9a0a-07f68a5ed1b8@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 27 Sep 2023 17:28:51 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

> On 9/27/23 10:32, Andre Przywara wrote:
> > On Wed, 16 Aug 2023 10:34:20 -0700
> > Sam Edwards <cfsworks@gmail.com> wrote:
> > 
> > Hi Sam,  
> 
> Hi Andre,
> 
> > Mmh, I didn't find a better solution than keeping this in.  
> 
> I'll keep it if your R528 v2 doesn't find some other way to address it.
> 
> >> +#endif
> >> +#if defined(SUNXI_CPUX_BASE) && defined(SUNXI_CPUCFG_BASE)
> >> +#undef SUNXI_CPUCFG_BASE
> >> +#define SUNXI_CPUCFG_BASE SUNXI_CPUX_BASE  
> > 
> > So what's the story with this? Do we name this differently
> > (SUNXI_CPUX_BASE) because the IP block is different from the other SoCs?
> > Or is there another SUNXI_CPUCFG IP block on the R528/T113s SoCs?
> > 
> > If not, I think we should use the SUNXI_CPUCFG_BASE name directly in
> > cpu_sunxi_ncat2.h, as we never claimed that same names for some MMIO
> > address blocks means they are compatible.
> > 
> > Please let me know if I miss something.  
> 
> That's just for compatibility with R528 series v1. It's expected that 
> you'll rename it to SUNXI_CPUCFG_BASE for v2. The preprocessor trickery 
> looks for *both* being defined and applies the update. The rest of the 
> code proceeds using SUNXI_CPUCFG_BASE. (Keep in mind this is particular 
> patch is a hack patch, it's not considered for inclusion.)

Yes, I got this, but surely the expectation is that those fixes should
not be needed anymore after a v2 of the R528 support series, right?
Which I am preparing as we speak, so I am supposed to fix them there,
and just wanted to double check whether my solution is in line with what
you had in mind. After all you seem to be deeper into this CPUCFG stuff
than I am.

Cheers,
Andre
