Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56767C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 20:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A734F86886;
	Mon,  4 Sep 2023 22:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M3DGPS5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72315868BB; Mon,  4 Sep 2023 22:07:36 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2388675B
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 22:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9DFC0CE0ECA;
 Mon,  4 Sep 2023 20:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD6BC433C8;
 Mon,  4 Sep 2023 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693858049;
 bh=K0Ky4ZNic3pKyUwt+ecOtaY5cNuKHU1d/eeiKxB9DYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M3DGPS5rp4X740WiBaxDlsBq+8koJtTb9pPfzQI6MDWA2G3d6EujdNBfZP85ewKfE
 ugtKywZ5AQ1rQaTR3wqEb2ueZhjQHVCMAweoND/oNumMUvbOrTgp1jnC0GBWDQoDRC
 4F7ANB7eG4DvnIHjj83dA/S9GXNXSN27mTAZTsH9MYk5/+E9wQvwHpB2PyWWh9HOAk
 lSJ4H8xUtJXQTLjdFLvMXMbQX/noU90g5N7iPzCe4d/zsOQq4JIDy3VSZwYYRAZyA9
 W6f3GkGTS8Y/dfknswHBiM8/e3GadGNOH9dXwDRAIJuI/2Uz16wgy9TfFKiYr+X7kP
 GiEO90P1++DiQ==
Received: by pali.im (Postfix)
 id CA77DB61; Mon,  4 Sep 2023 22:07:25 +0200 (CEST)
Date: Mon, 4 Sep 2023 22:07:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 32/32] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230904200725.q2sjy7obn2vwzrci@pali>
References: <20230830194157.GF3101304@bill-the-cat>
 <20230830194409.a7acogmn54gajmk6@pali>
 <20230830205145.t75fkjhnc7kjux3z@pali>
 <20230830210842.GG3101304@bill-the-cat>
 <20230830211316.5ywrzq6gmxzvdl4o@pali>
 <20230830212620.GH3101304@bill-the-cat>
 <20230830212934.tl2bnmmls2ajdj46@pali>
 <20230830214201.GM3101304@bill-the-cat>
 <20230903203615.ncyjug2prctiufk2@pali>
 <20230904195518.GG3101304@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904195518.GG3101304@bill-the-cat>
User-Agent: NeoMutt/20180716
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

On Monday 04 September 2023 15:55:18 Tom Rini wrote:
> On Sun, Sep 03, 2023 at 10:36:15PM +0200, Pali Rohár wrote:
> > You are not saying truth here, you are lying and you know it. mvebu
> > changes? ignored, no answer. ppc changes? ignored no answer in 10
> > months. mmc changes, no answer at all. rx-51 bug reports and regression
> > which you and your people broke? you wrote me: fuck you and fix it
> > yourself. So what does compromise means for you? Just "Pali has to do
> > anything". So yes, I'm refusing to do all this dirty jobs for you. This
> > is not any compromise, maybe just in your head or your language.
> > Compromise is something like, you will fix regression what you and your
> > people caused and I then I will look at some of the pending patches for
> > which I'm listed as reviewer. Helping do debug? Nobody helped me with
> > anything. Do you still you think that I'm such idiot who is going to
> > review more and more of your code and you continue ignoring me?? No.
> 
> No, I'm still speaking the truth. Your MMC changes broke other
> platforms, and you didn't respin the whole patch, you just posted
> another patch instead despite me asking you to respin things to include
> it.  What I summarized there is exactly what happened with the powerpc
> changes, and a similar but shorter timeline for the rx-51 report that
> you still refuse to further debug after being repeatedly told that no
> one else can reproduce the problem anywhere else.

Your changes broke rx-51 and you refused to revert that change, you
refused to work on fixing this change and you refused to respin the new
version. I have provided all detailed information and you refused to
work with it.

I sent a new mmc version, I sent two new ppc changes and all of them
you ignored.

So stop writing bullshit here.

And now I'm really refusing to do other work as I see that you and your
people would ignore also this stuff, like all other.

Once you stop doing this, stop ignoring me, review and reapply my
changes, then come back to me and after that I may decided if I look at
any your or your people changes. Not before.

> And Simon contacted you on this thread because you're the listed
> maintainer of one of the files changed here.

And I have contacted him and he refused to reply and is continuing
ignoring me.

So what I wrote is truth there, you are continuing saying untruth here.

> > 
> > On Wednesday 30 August 2023 17:42:01 Tom Rini wrote:
> > > On Wed, Aug 30, 2023 at 11:29:34PM +0200, Pali Rohár wrote:
> > > 
> > > > There were no answers.
> > > > 
> > > > On Wednesday 30 August 2023 17:26:20 Tom Rini wrote:
> > > > > I'm trimming the CC list. All of those points you list were addressed
> > > > > and answered in your last long running argument. You need to decide what
> > > > > is best for you moving forward and I would ask that it not involve
> > > > > complaining that you're being asked to review code that you're a listed
> > > > > maintainer of.
> > > > > 
> > > > > On Wed, Aug 30, 2023 at 11:13:16PM +0200, Pali Rohár wrote:
> > > > > > Seems that you completely miss the point of the argument, then the only
> > > > > > option for such people is to repeat them. Or have I repeat you again
> > > > > > that you have not answered the first question, why you are asking for
> > > > > > review from somebody who you are ignoring and not taking into account?
> > > > > > You do not want to answer this question, right? So you rather change a
> > > > > > topic and talking about something totally different.
> > > > > > 
> > > > > > On Wednesday 30 August 2023 17:08:42 Tom Rini wrote:
> > > > > > > I don't think it's worth re-hashing the same arguments over and over.
> > > > > > > There is no "my persons", there is the public community.  If you no
> > > > > > > longer wish to participate, I can remove you from the maintainers
> > > > > > > entries you're listed in.  But please stop with the long arguments
> > > > > > > unrelated to the patches at hand when there's a dozen people and other
> > > > > > > lists on CC.
> > > > > > > 
> > > > > > > On Wed, Aug 30, 2023 at 10:51:45PM +0200, Pali Rohár wrote:
> > > > > > > > So lets recap what you and your persons have done in last 6 months:
> > > > > > > > 
> > > > > > > > * Ignored my changes
> > > > > > > > * Ignored my reviews
> > > > > > > > * Ignored my reminders
> > > 
> > > Not ignored, changes requested and refused.  Compromises refused.
> > > Apologies from others who had said they would pick up the platform and
> > > push it, but did not have time ignored.
> > > 
> > > > > > > > * Ignored my regression reports
> > > 
> > > Not ignored, debugged, problems with your platform implementation
> > > reported and questions asked, patches provided to help you debug the
> > > problem on the single place that seems to show a problem which no one
> > > else can reproduce ignored.
> > > 
> > > -- 
> > > Tom
> > 
> > 
> 
> -- 
> Tom


