Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B69FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 04:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C4883FEC;
	Mon,  4 May 2026 06:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="AQGPkzDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EA2845C8; Mon,  4 May 2026 06:56:46 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9686183EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 06:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-38-214-193.ip72.fastwebnet.it [93.38.214.193])
 by mail11.truemail.it (Postfix) with ESMTPA id D706F2558C;
 Mon,  4 May 2026 06:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777870602;
 bh=MqC+HL7prA6Za2odfgu9cKfp8cYS4ikjwegVJHL4izE=; h=From:To:Subject;
 b=AQGPkzDU9U3NsmC5e+Kg8NF4Uq6YlSDNIkvDuUYRFk3FMOM3GjEeO1fQAiSo4gpGr
 JBUsHEvianpq0Lv5+vaoeH7oS9zNOu2+IvysjtmIuO3WPntlL6jiLR0EvbXxCNru/c
 nXOP+5ehgZywdGVzh49MYEwv/ejwuF3Lj8Nt/4aaDLLummC1pT1kzefPG/9CMK7osQ
 rt3nR3d8uviB5uPBf+mNZoFAFm4HkNlZLDp/IH29bGK66wSxgeVrEI0zmnv5uYZr4T
 LRqXtQCMLshM3V+xlujc0yAfhKO4LbkRLV/pWIvUn1BwH+37q+UquK1KBD8qOltL4v
 Jgd9r9WPL8xXA==
Date: Mon, 4 May 2026 06:56:36 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-ID: <20260504045636.GA5660@francesco-nb>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb>
 <20260402233029.GI41863@bill-the-cat>
 <ac-ADDwtwS-xuFTE@livingston.pivistrello.it>
 <87v7e0o624.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7e0o624.fsf@prevas.dk>
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

+Simon

Hello Tom,

On Thu, Apr 09, 2026 at 11:07:31AM +0200, Rasmus Villemoes wrote:
> On Fri, Apr 03 2026, Francesco Dolcini <francesco@dolcini.it> wrote:
> > On Thu, Apr 02, 2026 at 05:30:29PM -0600, Tom Rini wrote:
> >> On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
> >> > On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> >> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> >> > > 
> >> > > With correct POSIX handling, unquoted empty variables can turn the
> >> > > expression like
> >> > > 	test -n ${fdtfile}
> >> > > into
> >> > > 	test -n
> >> > > 
> >> > > The POSIX handling for single argument `test` evaluates it as true,
> >> > > so the fallback initialization will be skipped unexpectedly.
> >> > > Quoting variable expansions in `test` expressions will always result in
> >> > > correct behavior for empty and non-empty values.
> >> > > This change was triggered by
> >> > > commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> >> > > The aim is to have a less fragile codebase that is not dependent on a
> >> > > quirk of the shell implementation.
> >> > > 
> >> > > Use quoted variable expansions in `test` expressions throughout.
> >> > > 
> >> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> >> > 
> >> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >> 
> >> I've decided to go with:
> >> https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.401876-1-ravi@prevas.dk/
> >> to make sure that everyone that might hit this problem doesn't end up
> >> broken, thanks.
> >
> > I am wondering if you should apply this in any case. This change is generally correct.
> 
> I agree. And note that this really isn't anything to do with the 'test'
> command per se, it's simply that using any variable whose value can be
> empty or contain spaces is prone to produce something other than exactly
> 1 word, exactly as in userspace shell, and once the shell has done its
> parsing and word splitting, the called command really has no way of
> knowing that there's an empty argument missing.

Tom? I think this should be applied, see also the related change from
Simon.

Francesco

