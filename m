Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F74CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A0483211;
	Mon, 20 Oct 2025 11:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="lPKoPAXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D818334F; Mon, 20 Oct 2025 11:13:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94827807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 512FF261AF;
 Mon, 20 Oct 2025 11:13:38 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InUzu_sz2B_s; Mon, 20 Oct 2025 11:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760951615; bh=tbEpl9NrDTvyaECVWiFVtddKPcQ2nh3aB23zoHbur+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lPKoPAXejr+0A30+7/0lwpLVkCKw6DPuCRvzrCUsu2gGTTvgAeKeuoUeafkS1sEmh
 Q24FHh+ccmXPBcRvT9ALngnMOlHP3e4k5bA5Dn6iEmDw2DRho8Op02hcrYaVnVdtQf
 5E4A9HspltV88I93rkpuvd+k38ihOMEN++QeH659P/RErsGWCfS9i6S4aS0JJl3AUz
 R6KY33MdtUvilo3lgLY0CpHViXO+kL9qdvJsceJPUeGMWgTKcn+/jOsN/KFL7Ej1kQ
 HhgYBrQZCXZDQoLKORfUJxVoSMsDj0Pb2oEWVks82wzxo1MRd0Mugq2W6Hv/nkQ6+a
 HeIc4qWu5Meyg==
Date: Mon, 20 Oct 2025 09:13:19 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
Message-ID: <aPX80KCYCvnDRIgM@pie>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
 <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com>
 <aPGc12v2H5sCZNMi@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPGc12v2H5sCZNMi@pie>
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

On Fri, Oct 17, 2025 at 01:33:11AM +0000, Yao Zi wrote:
> On Thu, Oct 16, 2025 at 07:04:48PM +0200, Heinrich Schuchardt wrote:
> > On 10/16/25 18:58, Heinrich Schuchardt wrote:
> > > Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
> > > synchronization in start.S") changed the hart synchronization in start.S.
> > > It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
> > > use. If the macro evaluates to true the old behavior is maintained.
> > > 
> > > The macro evaluates to false for SPL builds which was unintended. Use
> > > IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
> > > 
> > > This fixes a boot failure on StarFive JH7110 based boards.
> > > 
> > > Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
> > > Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> 
> Hi Heinrich,
> 
> Thanks for sending the patch!
> 
> > 
> > Hello Yao,
> > 
> > It would be worthwhile to understand why your new method does not work on
> > the StarFive VisionFive 2. I only addressed the Kconfig issue. But I suspect
> > there is something broken in the alternative pass.
> 
> A possible reason is that, on JH7110 not all the cores support LR/SC
> instructions: the S7 small core always raises access exception for it
> since the implementation of LR/SC requires data cache to present, while
> S7 doesn't have one.
> 
> This is documented in SiFive U74-MC Core Complex Manual,
> 
> > Load-reserved (LR) and store-conditional (SC) instructions are special
> > atomic instructions that are only supported in data cacheable regions.
> > As the S7 core does not have a data cache, the LR and SC instructions
> > will always generate a precise access exception.[1]
> 
> As S7 also takes part in the initial HART lottery, usage of LR/SC
> instructions might just crash its boot process with exception.
> 
> However I could only confirm the idea days later when I have access to
> a JH7110 board. Since earlier Tom has merged the patch[2] that reverts
> the problematic commit, do you think it's better to wait for me to
> confirm the cause and write v3 of the patch, instead of fixing it up
> now? I'll carry your Co-developed-by tag in v3 if you're okay with this.

Hi Heinrich,

I finally got a JH7110 board on hand and could find out what happens
here. As stated in the U74-MC Core Complex Manual,

> > Load-reserved (LR) and store-conditional (SC) instructions are special
> > atomic instructions that are only supported in data cacheable regions.
> > As the S7 core does not have a data cache, the LR and SC instructions
> > will always generate a precise access exception.[1]

This is correct, and with my patch the S7 core does trigger an
exception when doing LR/SC stuff, but this alone isn't enough to break
the whole SPL booting process up without even a banner shown up.

With some hand-written assembly added, I found that not only the S7
core, but also the four U74 cores are trapped in exceptions as well.
This is because U-Boot SPL, including the available_harts_lock variable,
is loaded in 0x8000000, as pointed out by CONFIG_SPL_TEXT_BASE and
spl/u-boot-spl.sym. According to StarFive JH7110's manual[3], the region
is mapped to the L2 Loosely-Integrated Memory.

And the U74-MC Core Complex Manual again points out,

> When cache ways are disabled, they are addressable in the L2
> Loosely-Integrated Memory (L2 LIM) address space as described in the
> U74-MC Core Complex memory map in Section 5.2. The L2 LIM is an
> uncacheable port into unused L2 SRAM and provides deterministic
> access time.

The L2 LIM region is uncachable, too. Since U74 and S7 could only
perform LR/SC instructions in cachable regions, the new LR/SC
implementation will always trigger an Load Access Fault exception, thus
doesn't work for JH7110.

Another simple patch[4] could confirm this, which just adds a simple
load-reserved operation on available_harts_lock in
arch/riscv/cpu/start.S, but still hangs the boot process on JH7110.

I've reviewed v2 of my patch again, and think besides the usage of
CONFIG_IS_ENALBED() which you just pointed out, there should be no logic
error. I'll probably send v3 of the patch carrying your fix along with
a new patch to explicitly disable RISCV_ISA_ZALRSC on JH7110 platforms,

Thanks again for sending the fix.

Best regards,
Yao Zi

> > Best regards
> > 
> > Heinrich
> 
> Best regards,
> Yao Zi
> 
> [1]: https://starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
> (Chapter 3.6, Atomic Memory Operations)
> [2]: https://lore.kernel.org/u-boot/176063629917.212270.1145034876136991424.b4-ty@konsulko.com/

[3]: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/u74_memory_map.html
[4]: https://gist.github.com/ziyao233/75fc0e40956a19e4383ab360dd06c784
