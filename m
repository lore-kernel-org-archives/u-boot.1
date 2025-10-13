Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B76CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64EE98383F;
	Mon, 13 Oct 2025 09:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IJgcfQCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1C08384E; Mon, 13 Oct 2025 09:07:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105638381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9D39821AC1;
 Mon, 13 Oct 2025 09:06:58 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYaJOvdtGTDu; Mon, 13 Oct 2025 09:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760339217; bh=XXBVgVV67jkzJa+Zbk2CmwIAp0gMDTL9MmGvNyyOC04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IJgcfQCwpbMDNWZn2ku2Dhk8haNYwYqR8Rswvi3ew4YFSDstIprGzEDbe70EnjXov
 cry9LrEb2Sw0r7TTe61EBR6ktIzFWH09Y3jejOVdItLExDxXIUOdyy1emnUHrROsWr
 iG+ejAiLnccX/7HoPETsswgqEfmHFoTeTa27yX2Rop/JbwCFsncHITk8a0xP43TIbx
 0YhNzmSPW6TeWkBTGjxeM8U4+esyS/yBzsjoP+v2pfXnQmK5gfmBgoxiFFfkOBlbyf
 L5SX/5d4PuRdbOpTM4RHMQdAXfD6lnsi+2yPGO8l9kRFaPr2Tyu6l8eCSxf1RtVrH2
 3FTh97rRiuBNg==
Date: Mon, 13 Oct 2025 07:06:45 +0000
From: Yao Zi <ziyao@disroot.org>
To: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [SPAM Warning!]Re: [PATCH] Revert "riscv: Add a Zalrsc-only
 alternative for synchronization in start.S"
Message-ID: <aOylBeAxyoKuPJYa@pie>
References: <20250925160148.21624-1-ziyao@disroot.org>
 <9113dd29-b862-4722-96d7-ad6d51219050@freeshell.de>
 <aNYSirEoll4m18QW@pie>
 <eae25847-b568-433a-9244-4443a2e6316b@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae25847-b568-433a-9244-4443a2e6316b@freeshell.de>
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

On Sun, Oct 12, 2025 at 02:49:59PM -0700, E Shattow wrote:
> Leo (and Tom?) please give Yao the attention they deserve for their
> contributions, starfive_visionfive2 has been broken for several weeks by
> this error and the revert needs to happen sooner rather than later. Thanks!
> 
> Hi Yao,
> 
> On 9/25/25 21:11, Yao Zi wrote:
> > On Thu, Sep 25, 2025 at 09:27:25AM -0700, E Shattow wrote:
> >>
> >>
> >> On 9/25/25 09:01, Yao Zi wrote:
> >>> This reverts commit a681cfecb4346107212f377e2075f6eb1bdc6a2b.
> >>>
> >>> It has been reported that the commit causes boot regression for SPL on
> >>> StarFive VisionFive 2 or compatible boards. Inspecting the code, I did
> >>> spot one logic error for deciding whether Zaamo or Zalrsc is used, and
> >>> it's still unclear what exactly causes the regression, let's revert it
> >>> for now.
> >>>
> >>> Reported-by: E Shattow <e@freeshell.de>
> >>> Link: https://lore.kernel.org/u-boot/1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de/
> >>> Signed-off-by: Yao Zi <ziyao@disroot.org>
> >>> ---
> >>>
> >>> The original series causing the problem[1] contains 3 patches, and I
> >>> think it should be enough to revert the change of start.S only, since
> >>> the others touch no code, and should be relatively safe. I'll fix the
> >>> reverted change up and get it work on VisionFive 2 when I got my new
> >>> board. Sorry for the inconvenience.
> >>>
> >>> [1]: https://lore.kernel.org/u-boot/20250902081932.21103-1-ziyao@disroot.org/
> >>>
> >>>  arch/riscv/cpu/start.S | 26 +-------------------------
> >>>  1 file changed, 1 insertion(+), 25 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> >>> index 6324ff585d4..7bafdfd390a 100644
> >>> --- a/arch/riscv/cpu/start.S
> >>> +++ b/arch/riscv/cpu/start.S
> >>> @@ -151,15 +151,8 @@ call_harts_early_init:
> >>>  	 */
> >>>  	la	t0, hart_lottery
> >>>  	li	t1, 1
> >>> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >>>  	amoswap.w s2, t1, 0(t0)
> >>>  	bnez	s2, wait_for_gd_init
> >>> -#else
> >>> -	lr.w	s2, (t0)
> >>> -	bnez	s2, wait_for_gd_init
> >>> -	sc.w	s2, t1, (t0)
> >>> -	bnez	s2, wait_for_gd_init
> >>> -#endif
> >>>  #else
> >>>  	/*
> >>>  	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
> >>> @@ -184,12 +177,7 @@ call_harts_early_init:
> >>>  #if !CONFIG_IS_ENABLED(XIP)
> >>>  #ifdef CONFIG_AVAILABLE_HARTS
> >>>  	la	t0, available_harts_lock
> >>> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >>>  	amoswap.w.rl zero, zero, 0(t0)
> >>> -#else
> >>> -	fence	rw, w
> >>> -	sw	zero, 0(t0)
> >>> -#endif
> >>>  #endif
> >>>  
> >>>  wait_for_gd_init:
> >>> @@ -202,14 +190,7 @@ wait_for_gd_init:
> >>>  #ifdef CONFIG_AVAILABLE_HARTS
> >>>  	la	t0, available_harts_lock
> >>>  	li	t1, 1
> >>> -1:
> >>> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >>> -	amoswap.w.aq t1, t1, 0(t0)
> >>> -#else
> >>> -	lr.w.aq	t1, 0(t0)
> >>> -	bnez	t1, 1b
> >>> -	sc.w.rl t1, t1, 0(t0)
> >>> -#endif
> >>> +1:	amoswap.w.aq t1, t1, 0(t0)
> >>>  	bnez	t1, 1b
> >>>  
> >>>  	/* register available harts in the available_harts mask */
> >>> @@ -219,12 +200,7 @@ wait_for_gd_init:
> >>>  	or	t2, t2, t1
> >>>  	SREG	t2, GD_AVAILABLE_HARTS(gp)
> >>>  
> >>> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >>>  	amoswap.w.rl zero, zero, 0(t0)
> >>> -#else
> >>> -	fence	rw, w
> >>> -	sw	zero, 0(t0)
> >>> -#endif
> >>>  #endif
> >>>  
> >>>  	/*
> >>
> >> Argument in favor of reverting three patches in the series are as: I do
> >> not understand the use of invisible config symbols in this way for a
> >> transition of something so dependent on toolchain implementation. How
> >> would I express this from menuconfig selections without directly editing
> >> symbols in the config ?
> > 
> > I'm not sure what do you mean about "invisible", the two newly
> > introduced Kconfig symbols have their description, are visible in
> > menuconfig and thus could be changed by hand manually.
> 
> Invisible means you cannot select the option with menuconfig. Visible
> symbols show up as user-selectable in the menuconfig interface.

But RISCV_ISA_ZAAMO and RISCV_ISA_ZALRSC are visible in menuconfig, you
could find them in "RISC-V architecture" -> "Standard extension for
Atomic Memory Operations" / "Standard extensions for LR/SC
instructions". I do provide description for them and don't realize why
you think they're invisible in the menu.

> > 
> > I introduced these symbols for describing whether Zaamo/Zalrsc is
> > availalbe on the targetted platform, and expecting one of them to be
> > explicitly disabled by board-level config if a platform doesn't support
> > Zalrsc or Zaamo, like how CONFIG_RISCV_ISA_A is tackled in
> > ibex-ast2700_defconfig.
> > 
> >> I only have some JH7110 boards (and one EIC7700X there is not U-Boot for
> >> this upstream yet) that I can offer to do some testing for, what all
> >> hardware for should this affect?  It's every riscv board ?
> > 
> > Technically speaking, yes, it introduces two Kconfig symbols that change
> > the logic of determining the ISA extension string for a build, so every
> > board is "affected".
> 
> Yes, then this is a failure to test affected configurations, and further
> a failure to communicate this fact in the series and in the commit
> message. Now the `git bisect` story is utterly broken for visionfive2
> for a month worth of commits since.
> 
> Because of some unfortunate luck the mail host I am using was offline
> for maintenance when your series posted. I was not aware of this
> breaking change sooner or else I would have resolved my own concerns now
> by having tested and found the error then, and especially if there was
> another revision or two of the series that made some mention asking to
> test this hardware specifically.

I should have been more explicit about affected platforms in the
original series, which may raise more attention on testing and review.
Will do it in v3, and I'm sorry for the mistake.

> > 
> > However, among all the RISC-V board-level configs we've already
> > supported, only ibex-ast2700_defconfig explicitly disables
> > CONFIG_RISCV_ISA_A, which means all other ports are compiled with "a"
> > extension contained in ISA extension string before. For these ports, "a"
> > will still be added to the ISA extension string, since
> > CONFIG_RISCV_ISA_ZAAMO and CONFIG_RISCV_ISA_ZALRSC are default to "y".
> > 
> > For ibex-ast2700_defconfig, as long as we adjust the defconfig to
> > disable CONFIG_RISCV_ISA_ZAAMO and CONFIG_RISCV_ISA_ZALRSC, it will be
> > built with the same ISA extension string as before (without "a"), too,
> > which is done in PATCH 2.
> > 
> > I only revert PATCH 3 since it really causes problems: I'm willing to
> > rework it, and since it depends on PATCH 1, 2, they'll be probably added
> > back as-is latter when I send v3 if they have been reverted together. If
> > it's the case, I think reverting only PATCH 3 makes Git log clearer.
> > 
> > If it's found PATCH 1, 2 really break something, I'm willing to revert
> > them. Thanks for the comment.
> 
> It is not helpful to argue about code which you did not communicate
> upfront of what was tested and what was not. I would trust your opinion
> however it is equally important to verify your assertions, and that has
> not been done properly.

For verification for the first two patches, as it only modifies the
logic to determine availability of RISCV_ISA_A Kconfig option, and the
option is only used to construct the -march compiler option string, I've
written a script to automatically compare the "-march" argument passed
to compilers with or without the first two patches applied[1].

I've run it locally for all mainline U-Boot ports, and found no
-march argument difference with the two patches applied. Do you think
it's a clue strong enough to consider the two patches safe and
unnecessary to be reverted?

Best regards,
Yao Zi

[1]: https://gist.github.com/ziyao233/13490f0a51bd556bfeb6017427c3b594

> > 
> >> Anyhow a revert of this one patch in the series is the minimum to
> >> restore working SPL for starfive visionfive2 (as Star64, and Mars
> >> CM/Lite). Thanks, Yao!
> >>
> >> Acked-by: E Shattow <e@freeshell.de>
> >>
> > 
> > Best regards,
> > Yao Zi
> 
> I emphasize that I appreciate your work, Yao.
> 
> Sincerely,
> 
> -E
