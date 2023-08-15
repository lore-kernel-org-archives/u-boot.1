Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DFC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 23:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C11E86785;
	Wed, 16 Aug 2023 01:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12378679B; Wed, 16 Aug 2023 01:00:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0216D8671F
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 01:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E549B1063;
 Tue, 15 Aug 2023 16:01:27 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE033F6C4;
 Tue, 15 Aug 2023 16:00:44 -0700 (PDT)
Date: Tue, 15 Aug 2023 23:59:46 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH 3/3] sunxi: psci: implement PSCI on R528
Message-ID: <20230815235946.0c8b0dce@slackpad.lan>
In-Reply-To: <225be7f9-558e-4695-0b38-b30b0229cdcd@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-4-CFSworks@gmail.com>
 <20230814151642.6f47f6b5@donnerap.manchester.arm.com>
 <225be7f9-558e-4695-0b38-b30b0229cdcd@gmail.com>
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

On Tue, 15 Aug 2023 13:17:33 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> On 8/14/23 08:16, Andre Przywara wrote:
> > Hi Sam,
> >   
> >> This patch adds the necessary code to make nonsec booting and PSCI
> >> secondary core management functional on the R528/T113.  
> > 
> > Unfortunately this patch breaks the build on older 32-bit SoCs, as
> > SUNXI_CPUX_BASE is not defined there. That's a typical problem of the
> > "C-if" approach, but typically there is a clean, albeit not trivial,
> > solution:
> > 
> > It seems like SUNXI_CPUX_BASE and SUNXI_CPUCFG_BASE are mutually
> > exclusive, and I actually carry a "#define SUNXI_CPUCFG_BASE 0" hack in my
> > patches already.
> > So I wonder if we should unify those two into SUNXI_CPUCFG_BASE, with the
> > following rework:  
> 
> The SUNXI_CPUX_BASE -> SUNXI_CPUCFG_BASE rename worked excellently. 
> We're having the same problem with SUNXI_R_CPUCFG_BASE as well, though. 
> How do you want to handle that?

So that's a bit more nasty indeed. I don't even know if R_CPUCFG really
makes sense here, as the _R_ term typically refers to the management
processor, which the D1/R528 don't have. Or at least the always-on power
domain, but then again this hardly relates to the secondary entry
point. I think the name was just used because the address matches the
one used in the H6. Anyway, I got the impression that Allwinner just
uses registers wherever they find them, and that they don't care too
much about logical grouping or compatibility.

So taking a step back, I wonder if we should actually just define a
CONFIG_SUNXI_CPU_SOFT_ENTRY (or so) *Kconfig* symbol, which holds that
address, and let the per-SoC definition be solved in Kconfig instead.
Because SUNXI_R_CPUCFG_BASE and also SUNXI_RTC_BASE seem to be just
used as the base address for that purpose, with some magic offset
added, across all of U-Boot (ARMv8 FEL and v7 PSCI).

So can you try to work on that base? I will take care of
armv8/fel_utils.S, which uses some post-increment assembly trick to
keep the code small, which wouldn't work anymore. But I have an idea
how to solve this.

Cheers,
Andre
