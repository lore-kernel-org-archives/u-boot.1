Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D37C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2912986852;
	Sun,  3 Sep 2023 22:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JML4RIW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0710F86824; Sun,  3 Sep 2023 22:36:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F3D867B5
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4E94860B88;
 Sun,  3 Sep 2023 20:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C30C433C8;
 Sun,  3 Sep 2023 20:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693773378;
 bh=gtjDe8Zr9Jh0j7YH0J9byoWtcdApyE+7i5Vkn9kVLzA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JML4RIW+fK0AD0XA2lhycBiXSt07goH0R8NLhKbhL/dsYcb4iUaxxI15HeR8j4Kkd
 39Rd6XES7wb7g4N9MBmRyGTkFoFt1ebRj8tgYAislXS+zSibHs4NN4DkYFDIBVHq0h
 eCKzy2YAboTGUdQdNBW09HqmcAj6gAv/IIggscMXj1ay3rnsBJLLWF2r89Qr0Yzj6V
 7fij09dZH28w8mMuFnxOUKgYjzFEcKK7uj+Dch8zFd5P7ZbJStbshpvW1j+4RUHL7n
 zp67YhMVprYg3x+dFOR8nAhRwat8ZWnjaA3NW6pfoe2oRSM30wzT6ELgJw6ZQ1oU8I
 SqgSMMX80SHPA==
Received: by pali.im (Postfix)
 id 873CA736; Sun,  3 Sep 2023 22:36:15 +0200 (CEST)
Date: Sun, 3 Sep 2023 22:36:15 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 32/32] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230903203615.ncyjug2prctiufk2@pali>
References: <20230830190422.GE3101304@bill-the-cat>
 <20230830191036.hecw3vyabdsczxrb@pali>
 <20230830194157.GF3101304@bill-the-cat>
 <20230830194409.a7acogmn54gajmk6@pali>
 <20230830205145.t75fkjhnc7kjux3z@pali>
 <20230830210842.GG3101304@bill-the-cat>
 <20230830211316.5ywrzq6gmxzvdl4o@pali>
 <20230830212620.GH3101304@bill-the-cat>
 <20230830212934.tl2bnmmls2ajdj46@pali>
 <20230830214201.GM3101304@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830214201.GM3101304@bill-the-cat>
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

You are not saying truth here, you are lying and you know it. mvebu
changes? ignored, no answer. ppc changes? ignored no answer in 10
months. mmc changes, no answer at all. rx-51 bug reports and regression
which you and your people broke? you wrote me: fuck you and fix it
yourself. So what does compromise means for you? Just "Pali has to do
anything". So yes, I'm refusing to do all this dirty jobs for you. This
is not any compromise, maybe just in your head or your language.
Compromise is something like, you will fix regression what you and your
people caused and I then I will look at some of the pending patches for
which I'm listed as reviewer. Helping do debug? Nobody helped me with
anything. Do you still you think that I'm such idiot who is going to
review more and more of your code and you continue ignoring me?? No.

On Wednesday 30 August 2023 17:42:01 Tom Rini wrote:
> On Wed, Aug 30, 2023 at 11:29:34PM +0200, Pali Rohár wrote:
> 
> > There were no answers.
> > 
> > On Wednesday 30 August 2023 17:26:20 Tom Rini wrote:
> > > I'm trimming the CC list. All of those points you list were addressed
> > > and answered in your last long running argument. You need to decide what
> > > is best for you moving forward and I would ask that it not involve
> > > complaining that you're being asked to review code that you're a listed
> > > maintainer of.
> > > 
> > > On Wed, Aug 30, 2023 at 11:13:16PM +0200, Pali Rohár wrote:
> > > > Seems that you completely miss the point of the argument, then the only
> > > > option for such people is to repeat them. Or have I repeat you again
> > > > that you have not answered the first question, why you are asking for
> > > > review from somebody who you are ignoring and not taking into account?
> > > > You do not want to answer this question, right? So you rather change a
> > > > topic and talking about something totally different.
> > > > 
> > > > On Wednesday 30 August 2023 17:08:42 Tom Rini wrote:
> > > > > I don't think it's worth re-hashing the same arguments over and over.
> > > > > There is no "my persons", there is the public community.  If you no
> > > > > longer wish to participate, I can remove you from the maintainers
> > > > > entries you're listed in.  But please stop with the long arguments
> > > > > unrelated to the patches at hand when there's a dozen people and other
> > > > > lists on CC.
> > > > > 
> > > > > On Wed, Aug 30, 2023 at 10:51:45PM +0200, Pali Rohár wrote:
> > > > > > So lets recap what you and your persons have done in last 6 months:
> > > > > > 
> > > > > > * Ignored my changes
> > > > > > * Ignored my reviews
> > > > > > * Ignored my reminders
> 
> Not ignored, changes requested and refused.  Compromises refused.
> Apologies from others who had said they would pick up the platform and
> push it, but did not have time ignored.
> 
> > > > > > * Ignored my regression reports
> 
> Not ignored, debugged, problems with your platform implementation
> reported and questions asked, patches provided to help you debug the
> problem on the single place that seems to show a problem which no one
> else can reproduce ignored.
> 
> -- 
> Tom


