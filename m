Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D72E82CAE
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 16:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3E186BD7;
	Wed, 27 Sep 2023 18:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9019686BE1; Wed, 27 Sep 2023 18:34:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 936198648D
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 18:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43638DA7;
 Wed, 27 Sep 2023 09:34:52 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D35F3F59C;
 Wed, 27 Sep 2023 09:34:13 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:34:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 1/5] sunxi: psci: clean away preprocessor macros
Message-ID: <20230927173410.32710be1@donnerap.manchester.arm.com>
In-Reply-To: <00d8e7d3-15a0-20cc-90bd-7a2fbc1867e8@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-2-CFSworks@gmail.com>
 <20230818151103.3fe5a32e@donnerap.manchester.arm.com>
 <ba7bf86f-3f4d-036a-9531-72a97d741f91@gmail.com>
 <00d8e7d3-15a0-20cc-90bd-7a2fbc1867e8@gmail.com>
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

On Fri, 18 Aug 2023 14:17:07 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

> On 8/18/23 10:40, Sam Edwards wrote:
> > On 8/18/23 07:11, Andre Przywara wrote:
> > 
> > Hi Andre,
> >   
> >> The resulting object file is different (8 byte larger,
> >> even), so it's hard to prove  
> > 
> > I'm no stranger to reading object code. Since the output should be 
> > identical in principle, I'll spend a little bit of time today seeing if 
> > I can identify what's changing. If it's easy enough, I'd like to adjust 
> > my patch so that the optimizer does produce the same output. (Keep in 
> > mind I'm on Clang, though. If Clang already gives the same output for 
> > both, I'll just report back to use that when comparing.)  
> 
> I built only psci.o from every ARM32 sunxi for which we have a defconfig 
> (and for which PSCI is supported), for 81 targets total (though there 
> are only 4 variations: R40, sun7i, H3/sun6i, and "everything else"). I 
> am working with Clang version 16.0.6.
> 
> I compared only the secure text section. The command to extract this 
> looks like:
> llvm-objcopy -O binary --only-section=._secure.text psci.o text.bin
> This is important because there are debug sections that will change when 
> the source file line numbers change, so we must ignore those when comparing.
> 
> In the majority of cases, there are no changes to the text section 
> introduced by this patch. In the R40 case, there's a small change where 
> the compiler adds a NULL check onto the result of the `(void *)cpucfg + 
> SUN8I_R40_PWR_CLAMP(cpu)` computation, which we can ignore as it won't 
> affect anything in practice. In the sun7i case, the only changes are 
> because I am NOT hardcoding the CPU to 0, which does look like I broke 
> it (since that means it will use cpu=1). So I'm going to need to fix 
> that in v3.

      ^^^^^^^
Do you have an update on this? I will try to test it on an R40 ASAP.

Cheers,
Andre

> For good measure, I also applied the same methodology to patch 2 in this 
> series, and that introduces no text section changes whatsoever in any of 
> the tested cases. So patch 2 (theoretically, anyway) needs no bugfixes 
> or hardware testing.
> 
> Patch 3 does cause a text section change for all targets. I will have to 
> investigate why, in case I messed up any of the offsets when migrating 
> off of structs.
> 
> Regards,
> Sam

