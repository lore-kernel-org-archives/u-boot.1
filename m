Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B1DC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 04:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 787FF80E06;
	Tue, 21 Jul 2026 04:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFD97s7awKIZ; Tue, 21 Jul 2026 04:27:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D4B580DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784608071;
	bh=4uFHBk/mTKUfPJwMHetGzbINUjeBswcQQBwZ0Ak+Vvg=;
	h=Date:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lhcm5bc45THJRcxkT4rjydl//8gaZ7nXGUA+XBD0By4yzRLBkJWvWB/AY9lj+pDTW
	 9rOLN8DuJ3wEhCMsR7Gdyi594gYXH54YGd7gokfpNnxIhLtw+wcyuUealoJTvH1jgA
	 NRi/O/m0BsfF3bVGF2lj/aUy2z3CwmN1v5w2l6DiU5WvrCNN5zKgJt5ZMjG+npH0kP
	 cLVJ3i+Ysf9vhtHSsvPpIg5UEbtpOoNH7z6ODOUEENYkIQk0aWF7TWEPNWrg6wK1kO
	 jwpYO5meZu/YijVznW6LYD+zUfYYYWhvZBnOH7JsKcSJD5wKf/uWy/AY0foUMJ46nB
	 gfRDQj/M7O5GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D4B580DEF;
	Tue, 21 Jul 2026 04:27:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFEDC42A;
 Tue, 21 Jul 2026 04:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D166C607C6;
 Tue, 21 Jul 2026 04:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHjEFu3tEHZH; Tue, 21 Jul 2026 04:27:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=macro@orcam.me.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 69A58607C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69A58607C5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69A58607C5;
 Tue, 21 Jul 2026 04:27:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EF284659; Tue, 21 Jul 2026 06:27:46 +0200 (CEST)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by phobos.denx.de (Postfix) with ESMTP id 121BA803F6;
 Tue, 21 Jul 2026 06:27:42 +0200 (CEST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 8F9C792009C; Tue, 21 Jul 2026 06:27:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 85FD192009B;
 Tue, 21 Jul 2026 05:27:41 +0100 (BST)
Date: Tue, 21 Jul 2026 05:27:41 +0100 (BST)
To: Tom Rini <trini@konsulko.com>
cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
In-Reply-To: <20260720222158.GL749385@bill-the-cat>
Message-ID: <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
 <20260720222158.GL749385@bill-the-cat>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=orcam.me.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=orcam.me.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=macro@orcam.me.uk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Maciej W. Rozycki via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 20 Jul 2026, Tom Rini via U-Boot wrote:

> > Sadly it seems that the new list is (mis)configured to rewrite the
> > From: header to something like:
> > 
> >   "John Doe via U-Boot <u-boot@lists.u-boot-project.org>"
> > 
> > Does it have to be that way?
> 
> So the answer is kinda. Whereas back on DENX we never "munged" emails
> this is also why we likely often had big piles of unsubscribed due to
> bounces (which was due to rejection from being incorrectly set as spam)
> on the big providers. So now mailman is configured to munge the headers
> *only* from senders which have a enforcing DMARC policy set, which
> xs4all.nl has. And because we're on shared resources our lists not
> following the DMARC rules would mess up all of the other lists.

 That's going to break patch submissions, isn't it?

  Maciej
