Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEC7C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C59A84BE0;
	Wed,  1 Jul 2026 19:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="RtvTjFzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BF584C0D; Wed,  1 Jul 2026 19:12:35 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D4384BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782925945; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D8iRnthvxBmxgyFsxbA17Rr8OXMk8tgWO5hncAtFmuqMija5D1ER3D4r8EolZn5Bn0ax61Ml+j5trD+FrpsLs9ZQnRaY7mWJxkvKP53CqH3BqXOanFAiuM+3NrzwvWRY0Ih7gLU29UYxtYVRBC36aAzPI31eDm4bNwIRpsnFLSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782925945;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZcU2hbdfiV/3ek0dLo3gqlASx5vOCkL9RtNoujMccAE=; 
 b=WXhbRpbTzz0dnaiB+kY8T7CFLhCGay2DHJ8LnZ3yY6jzanmInXR5I6bd6vUFVaAfeUHBcSA3hoqckCn7s27nncb/NtUvl/EEST/R/W0eIatwL5LQ0HQPtEItsPeK/1LITvkMJ6b026DieXaCWR+DrYYXBtHE6gpKni5yX0OlvsI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782925945; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ZcU2hbdfiV/3ek0dLo3gqlASx5vOCkL9RtNoujMccAE=;
 b=RtvTjFzjNWZU1KK229pZPRHIBjBpBdBOnGbHH36QkCbOe0cUiccCRGLjranjA0fh
 3mu110V4KRtMOJ+ByU0jueg/kiSAlzZSFymdFZx71lKDLP6iBfNtS/pHhgiHUZo3UWo
 jOslzyK1BvJGYKEJkXakBakvLCnBS2CREghKYbOk=
Received: by mx.zohomail.com with SMTPS id 1782925942800346.02122631538236;
 Wed, 1 Jul 2026 10:12:22 -0700 (PDT)
Date: Wed, 1 Jul 2026 17:12:05 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
Subject: Re: Unresolved conflicts after 0d8e33717d7e in MAINTAINERS
Message-ID: <akVKZT2DE88Eosm4@pie>
References: <akT0Mqg2JpDoKVOB@pie> <akT1-Mwmc2022vTl@pie>
 <20260701141646.GH749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701141646.GH749385@bill-the-cat>
X-ZohoMailClient: External
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

On Wed, Jul 01, 2026 at 08:16:46AM -0600, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:11:52AM +0000, Yao Zi wrote:
> > On Wed, Jul 01, 2026 at 11:04:18AM +0000, Yao Zi wrote:
> > > Hi list,
> > > 
> > > I noticed merge commit 0d8e33717d7e ("Merge patch series "arm: aspeed:
> > > add initial AST2700 SoC support""), which has already landed in next,
> > > seems to leave a part of conflicted changes unresolved.
> > > 
> > > ARM AXIADO AX3005 SCM3005
> > > M:      Siu Ming Tong <smtong@axiado.com>
> > > M:      Karthikeyan Mitran <kmitran@axiado.com>
> > > M:      Prasad Bolisetty <pbolisetty@axiado.com>
> > > S:      Maintained
> > > F:      arch/arm/dts/ax3005*
> > > F:      arch/arm/mach-axiado/
> > > F:      board/axiado/scm3005/
> > > F:      configs/ax3005_scm3005_defconfig
> > > F:      include/configs/ax3005-scm3005.h
> > > =======
> > > F:      drivers/pinctrl/aspeed/
> > > F:      drivers/pwm/pwm-aspeed.c
> > > F:      drivers/ram/aspeed/
> > > F:      drivers/reset/reset-ast*.c
> > > F:      drivers/watchdog/ast_wdt.c
> > > N:      aspeed
> > > N:      ast2700
> > > >>>>>>> 4a72fd9fb09109857303ca64fd259009e1d4b554
> > 
> > Adding list to cc, sorry for the mistake.
> 
> I thought this was resolved in the merge commit? I don't see that in the
> current file at the tip of the next branch.

It's strange. It's still there in the tip of next branch fetched in my
side, and I could find it on both U-Boot's GitLab instance[1] and
GitHub[2] as well.

> -- 
> Tom

Best regards,
Yao Zi

[1]: https://source.denx.de/u-boot/u-boot/-/blob/next/MAINTAINERS?ref_type=heads#L235
[2]: https://github.com/u-boot/u-boot/blob/5602e89a834ccbedc686053b14206c062a144107/MAINTAINERS#L235
