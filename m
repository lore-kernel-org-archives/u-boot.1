Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD413C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B508D60850;
	Tue, 21 Jul 2026 14:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MJx-3666Vfe; Tue, 21 Jul 2026 14:29:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FD916083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784644171;
	bh=wbX4m7xx2q/JgajeFX6oP8+UZ/0odmjwcQe+xh9bHC8=;
	h=Date:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Kwe/PWdc4GimNaUgFYUatM3BH6hAjey9aLmhbrLiU3LJ4Ru67hbQ4Gvm9NB+K2mOe
	 ETNQfEwtuKmMEYdE88JzmQN+W/kbOCPTXQzZxR6Thh47PjXyWf1iLkd/gYJvtkFuws
	 GrPmAVjY66OpL5idFEhLDZMjrro7Ke6Z++K9VWxZqTT3U6uyMLyT+SPTExAK5yRK+G
	 pUAsvT3Adzuj8b14vSYsUx3XAfyVYW6WpHa0hQzazAgfGtEeUSR1XjT4yeIXtdBjKU
	 T7jW3ioqD7hdOFEYzyfbnPpzORw91Eeyd5Yqo/RcK0nyKvz5LsmZgge5XjWjTHDNQ6
	 Ff0ySYgG66f7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FD916083B;
	Tue, 21 Jul 2026 14:29:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BC38109B;
 Tue, 21 Jul 2026 14:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D097809F6;
 Tue, 21 Jul 2026 14:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpLwy0WNFbjz; Tue, 21 Jul 2026 14:29:28 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=macro@orcam.me.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 06787809B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06787809B0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06787809B0;
 Tue, 21 Jul 2026 14:29:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531F584659; Tue, 21 Jul 2026 16:29:26 +0200 (CEST)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by phobos.denx.de (Postfix) with ESMTP id 1BB69803F6;
 Tue, 21 Jul 2026 16:29:24 +0200 (CEST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id AFB1292009C; Tue, 21 Jul 2026 16:29:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id AC60A92009B;
 Tue, 21 Jul 2026 15:29:23 +0100 (BST)
Date: Tue, 21 Jul 2026 15:29:23 +0100 (BST)
To: Tom Rini <trini@konsulko.com>
cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
In-Reply-To: <20260721135414.GR749385@bill-the-cat>
Message-ID: <alpine.DEB.2.21.2607211504130.14485@angie.orcam.me.uk>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
 <20260720222158.GL749385@bill-the-cat>
 <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
 <20260721135414.GR749385@bill-the-cat>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
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

On Tue, 21 Jul 2026, Tom Rini wrote:

> >  That's going to break patch submissions, isn't it?
> 
> Looks like it's working:
> https://patchwork.ozlabs.org/project/uboot/patch/20260721063050.18756-1-dinesh.maniyam@altera.com/

 It breaks for `git am' though, such as for picking up patches directly 
from the mailing list via the MUA (hmm, why hasn't this particular patch 
arrive here?).  There are other issues with the rewrite, such as the 
inability to sort messages by authors in the mailbox, but the former is 
possibly the most painful.

> Not my favorite that it's going to have "... via U-Boot" in patchwork
> only. And we already have "... via B4 Relay" in others. We aren't the
> only project OSU OSL is hosting mailman for, so I'd assume this is a
> solved problem.

 Yep, GNU toolchain lists I'm on that are used for patch distribution 
(such as <binutils@sourceware,org>, <gcc-patches@gcc.gnu.org>, but not 
<gcc-help@gcc.gnu.org>) simply disabled such rewriting, after numerous 
discussions (not sure what OSU OSL is though).

 Up to you to decide, I just wanted to share my concern.

  Maciej
