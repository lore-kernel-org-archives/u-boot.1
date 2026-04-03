Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E3E7E34C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 08:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A5083DC9;
	Fri,  3 Apr 2026 10:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dzQifYOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E748407E; Fri,  3 Apr 2026 10:53:36 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFB783CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 10:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id BD8781F93F;
 Fri,  3 Apr 2026 10:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1775206412;
 bh=neM1fNbpm3n4vV9N0b07oi8zGmoJ0JJxuL4YbbFR3Zo=;
 h=Received:Received:From:To:Subject;
 b=dzQifYOSX0L1MfEr700Exa6Xq4KzgHkEgI80qKMpX4usFW93keKEJcklfLwkMgE7k
 Gt/xXPmhXkzxry1kCjo5phJJvbtNIY+m1PzUa0s6MKHc83CVOpY93QUNCLJ+5Ahnvl
 Qf19F3Ne5yreDGSqbsi8HRnUB+PWGa6KeUZhkSCW+bF98cG8pAQxISY+oiwbLFahn0
 hhEVpcLGxYlzFbyZM0xjkK0JZKZvmW9VptzIWueOnDsCBaUkAYgGr1HVf0kpdMzoB+
 ZGZsE3suqbjhrs5faXlCmp553Bwscy/hb9KXzXypsb+SHfQkuUJ2N+6Ta3gruFbl84
 xXkesUNGLZx0g==
Received: from livingston (unknown [192.168.42.11])
 by gaggiata.pivistrello.it (Postfix) with ESMTP id 5A7747FA52;
 Fri, 03 Apr 2026 10:53:32 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.98.2)
 (envelope-from <francesco@dolcini.it>) id 1w8aHU-000000004AD-12c9;
 Fri, 03 Apr 2026 10:53:32 +0200
Date: Fri, 3 Apr 2026 10:53:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-ID: <ac-ADDwtwS-xuFTE@livingston.pivistrello.it>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb>
 <20260402233029.GI41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402233029.GI41863@bill-the-cat>
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

On Thu, Apr 02, 2026 at 05:30:29PM -0600, Tom Rini wrote:
> On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
> > On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > > 
> > > With correct POSIX handling, unquoted empty variables can turn the
> > > expression like
> > > 	test -n ${fdtfile}
> > > into
> > > 	test -n
> > > 
> > > The POSIX handling for single argument `test` evaluates it as true,
> > > so the fallback initialization will be skipped unexpectedly.
> > > Quoting variable expansions in `test` expressions will always result in
> > > correct behavior for empty and non-empty values.
> > > This change was triggered by
> > > commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> > > The aim is to have a less fragile codebase that is not dependent on a
> > > quirk of the shell implementation.
> > > 
> > > Use quoted variable expansions in `test` expressions throughout.
> > > 
> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > 
> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> I've decided to go with:
> https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.401876-1-ravi@prevas.dk/
> to make sure that everyone that might hit this problem doesn't end up
> broken, thanks.

I am wondering if you should apply this in any case. This change is generally correct.

In the past when trying to move to some more modern shell as default stuff broke
for us, we reverted the change without investigating. Maybe it was exactly the
same issue.

See https://lore.kernel.org/u-boot/20240111170418.GA7220@francesco-nb/
