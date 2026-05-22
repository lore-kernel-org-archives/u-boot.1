Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7E7CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 16:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88080846EB;
	Fri, 22 May 2026 18:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="k6gODxb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B30484867; Fri, 22 May 2026 18:20:57 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A467846C0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 18:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-38-247-131.ip73.fastwebnet.it [93.38.247.131])
 by mail11.truemail.it (Postfix) with ESMTPA id 922472285D;
 Fri, 22 May 2026 18:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779466853;
 bh=Yl8lN6HHjNSsp0kXkWiQTM9tKSfGvksJSYkKTB98y/k=; h=From:To:Subject;
 b=k6gODxb1e9ULPD3M+ec0KV5bLvTUN/QahkPGVRK8K4jt4SxO57ufzPnY3X+251x6F
 dTxwPfZR5Bvc2O3vDtXex1vP8J9XL44LEZ8it5pfhC26P57g8fzdsTGJVufT4Na5HB
 CkrV9sxRit6YpnVNbxpTU7RBTeyOwZWiiiK0xnoErEht5fxqSZ1Y9kJzjGhj6yTRHD
 Jgip1WSqgATAWy2D2GFO0MIlNSv68gJxjgtRisliWYfSZsocULYfbP/CzJEUF5MTN9
 skGlsCOsEmru1FcF1wSEPW1dGLZB/531EuXyniEZcg3bH5MzNjmmxekEY06JGfMw5Z
 H6FyfK8VEZRZA==
Date: Fri, 22 May 2026 18:20:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shiva Tripathi <s-tripathi1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, trini@konsulko.com,
 vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 praneeth@ti.com, kamlesh@ti.com, vishalm@ti.com,
 k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260522162048.GA114365@francesco-nb>
References: <20260522061515.GA8642@francesco-nb>
 <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
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

On Fri, May 22, 2026 at 07:49:27PM +0530, Shiva Tripathi wrote:
> On 5/22/26 11:45, Francesco Dolcini wrote:
> > On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
> > On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> >> This makes me think we are at the stage in boot where EFI variables
> >> are trying to be persisted to some media, and when trying to use
> >> the fTPM for this it fails (as would be expected without RPMB).
> >> So this should be harmless, but why there is such a large error
> >> printout we need to investigate and try to make it less verbose.
> > 
> > Any chance TI can help on this?
> Yes, I am looking into it. The logs are showing up as OPTEE's fTPM TA is
> failing to load, since the eMMC RPMB isn't provisioned.

Thanks for looking into that, and I am glad you can reproduce the issue.

> Even though these logs don't affect functionality, you can revert this
> patch to avoid confusion. I am checking if there's a cleaner way to
> handle this.

I am using mainline U-Boot, if this needs to be reverted, it must be
reverted here. Given the release timeline, and the fact that this is not
breaking the functionality I am fine waiting a little bit to see if it
is possible to fix it, we have some time before the v2026.07 release.

Francesco

