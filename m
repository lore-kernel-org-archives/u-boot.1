Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9B8E9E310
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1CB83A5A;
	Wed, 11 Feb 2026 15:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="TDo/NcnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A67783B64; Wed, 11 Feb 2026 15:16:47 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A26483015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0PQi2/yCsyCskMaCs9L/bilpyOsV3Tnd8JGmEECgEUg=; b=TDo/NcnU9BDhLFKShWDLRGevLv
 hA4cf+tB/be3Z35vRUmdqarTfvK8qi+MYzjf7A5M0GNexs44sEerROCyW71liAAKb/oDWh0OcR7k8
 BqH2uNbDYpAA2ggHQNaS1hDj3Nj6NvgoYfL+ffgDG3KYB6OR6JBGMmMDJsMYv9CtIZwYUZ/WAeVlR
 aYZU2yqQOVaQFDzDi+OZ/CGKVOHOtu83HEZMNGUSZ2wfsZ8HCXZg8TvWKY6jcopMfR+sSOgTI9uuF
 IjlhFigF8PXAfeGBmlnzZjj0NNESewWI2sZApxrFovqZoSZC1wWVsazMw6qeV3xXnPKHfxWaYOv66
 1VX/2j+g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vqB1I-000000002Ti-3SMu;
 Wed, 11 Feb 2026 15:16:44 +0100
Date: Wed, 11 Feb 2026 15:16:44 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] board: Synology: common: Fix typo in Makefile
Message-ID: <aYyPTAJiuDxl4JFx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260204202936.21585-1-phil@nwl.cc>
 <20260207215301.GA259488@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207215301.GA259488@bill-the-cat>
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

On Sat, Feb 07, 2026 at 03:53:01PM -0600, Tom Rini wrote:
> On Wed, Feb 04, 2026 at 09:29:36PM +0100, Phil Sutter wrote:
> 
> > Due to this, legacy.c was neither compiled nor linked into the binary
> > and thus booting legacy DS414 firmware failed. Missing atag setup led to
> > no console output (and probably stalled boot) after:
> > 
> > | Uncompressing Linux... done, booting the kernel.
> > 
> > Fixes: 9774462e34faa ("arm: Disable ATAGs support")
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  board/Synology/common/Makefile | 2 +-
> >  lib/fdtdec.c                   | 5 +++++
> 
> OK, whoops. The lib/fdtec.c change was just a debug thing to drop.
> However, the Makefile portion leads to failure to build on ds109 and
> ds116.

Oh crap, yes. The ftdec.c change was not supposed to end up in this
patch, sorry!

Let me check what's going on when building for the other devices, will
ideally submit a v2 this evening.

Thanks, Phil
