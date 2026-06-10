Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DEBCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 05:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE87280087;
	Wed, 10 Jun 2026 07:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="q/P3h2uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08B2807C4; Wed, 10 Jun 2026 07:52:09 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A0080086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (unknown [185.12.129.182])
 by mail11.truemail.it (Postfix) with ESMTPA id 7414A1FA89;
 Wed, 10 Jun 2026 07:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1781070721;
 bh=SesNk0p6f1sk474f2OxqlEKMQaMl3aPSIgb/HMOmryc=; h=From:To:Subject;
 b=q/P3h2ucc+7aqk2MW46Kvyjo8L7Py0fbW93qvoADUN19BGPygO1eH3aPfgnmjT9qn
 jIvlxuhQD0kr5v4L0TxujYrI9LlW7rKWfMs9A5lgD5ZZoVxVq5a3zsIM3p8AiFRLpB
 doP6rHcP8JqQKano2j0j5Ps7/VjyUz245UlCR1xOdJmwKcTIKKAgFcWMUMgvMdhz3u
 FGYvTM8T2vwsEExBcHBxvXbBttoaqjcnbJKltQjkvlHTpdyCiHLpCP2AFMq6l8KBFH
 El1+kxjPMSttBGgeyPRn98Pe+NmkxK836ebLfBRf3x9Ms14qXyHf/0W3d4uR9uXjWO
 pbettQ7b/cebA==
Date: Wed, 10 Jun 2026 07:51:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>, Shiva Tripathi <s-tripathi1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, vigneshr@ti.com,
 bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com,
 kamlesh@ti.com, vishalm@ti.com, k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260610055141.GA13255@francesco-nb>
References: <20260522061515.GA8642@francesco-nb>
 <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
 <20260522162048.GA114365@francesco-nb>
 <20260522173637.GW1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522173637.GW1858239@bill-the-cat>
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

Hello Shiva,

On Fri, May 22, 2026 at 11:36:37AM -0600, Tom Rini wrote:
> On Fri, May 22, 2026 at 06:20:48PM +0200, Francesco Dolcini wrote:
> > On Fri, May 22, 2026 at 07:49:27PM +0530, Shiva Tripathi wrote:
> > > On 5/22/26 11:45, Francesco Dolcini wrote:
> > > > On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
> > > > On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> > > >> This makes me think we are at the stage in boot where EFI variables
> > > >> are trying to be persisted to some media, and when trying to use
> > > >> the fTPM for this it fails (as would be expected without RPMB).
> > > >> So this should be harmless, but why there is such a large error
> > > >> printout we need to investigate and try to make it less verbose.
> > > > 
> > > > Any chance TI can help on this?
> > > Yes, I am looking into it. The logs are showing up as OPTEE's fTPM TA is
> > > failing to load, since the eMMC RPMB isn't provisioned.
> > 
> > Thanks for looking into that, and I am glad you can reproduce the issue.
> > 
> > > Even though these logs don't affect functionality, you can revert this
> > > patch to avoid confusion. I am checking if there's a cleaner way to
> > > handle this.
> > 
> > I am using mainline U-Boot, if this needs to be reverted, it must be
> > reverted here. Given the release timeline, and the fact that this is not
> > breaking the functionality I am fine waiting a little bit to see if it
> > is possible to fix it, we have some time before the v2026.07 release.
> 
> And for the release I would like to make sure someone has a clear path
> on what changes are needed, if any in the end, on mainline U-Boot by
> rc4, which is June 8th. We have the last one on June 22nd but I'd rather
> not have to revert then unless things are just unresolved. Thanks!

Shiva: what's the plan? As of now the issue is still there.

Francesco

