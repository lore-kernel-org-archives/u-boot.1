Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF719CD343B
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 05:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB1E84A19;
	Thu,  7 May 2026 07:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZAxBibqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D2F84A17; Thu,  7 May 2026 07:36:10 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CC284A17
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 07:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EADF6024D;
 Thu,  7 May 2026 05:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5169C2BCB8;
 Thu,  7 May 2026 05:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778132166;
 bh=atpum1xgM25pp2/wKYHwqZ9EhqKpvDYicOBk0OqV6Wo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZAxBibqyxoWZKMZtt0VuT9Upstlj5jxWgbeeD11AXqnfMZPDBsz6AY5cDSdJLdZOp
 F1LHQUjtaam9ZP2j2ikx/TE4WXD+EgWKVmJsBiFYQ6LWt94TVFGsKyB/CS+kdXvtXw
 f4ys1ax1so6JD17P9eGv7Jw/9WApKyCVu5xtZWxOxdBwKDLg9NkShM3u6V1+3k2nw8
 LnenYnAp3cUyVMZepncF4HRKilneGWfMfDPjo7dS5TNJ0l3nP1RqBXoMOReGzv8yWV
 1W6THtJvivGyJL7Z5uyZ/gZt1DQmf32+jaEnk4DK+LJfg42suoVA6bipIJVk/S6qZq
 pket5Fxj9xTCg==
Date: Thu, 7 May 2026 11:06:00 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: mmu: support unmapping regions with
 set_one_region()
Message-ID: <afwkwE1OJehspQa7@sumit-xelite>
References: <20260504183721.646712-1-casey.connolly@linaro.org>
 <CAC_iWjLkz8oMSvGsv-_1UTwNkuLGd3uzEoY90ERWLeeyWCP-_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjLkz8oMSvGsv-_1UTwNkuLGd3uzEoY90ERWLeeyWCP-_g@mail.gmail.com>
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

On Wed, May 06, 2026 at 10:13:24AM +0300, Ilias Apalodimas wrote:
> Hi Casey,
> 
> On Mon, 4 May 2026 at 21:37, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> > Currently set_one_region() implicitly assumes that we want to map a
> > region and aggressively splits blocks into tables to do this, but when
> > called with PTE_TYPE_FAULT to unmap a currently mapped region it may
> > try to unnecessarily split blocks which doesn't make sense if the entire
> > block should actually be unmapped. In the end it then has to walk every
> > single page and create a bunch of empty tables.
> >
> > Introduce a check for this kind of behaviour and optimise with a fast
> > path, if we're unmapping a region >= the size of this entry then we can
> > just unmap the entire PTE and whatever it contains.
> >
> > This fixes some bogus empty tables being left behind when carving out
> > reserved memory regions on Qualcomm, and should improve the performance
> > of the break-before-make in mmu_change_region_attr().
> >
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> > Changes in v2:
> >  - Update pte_type() to correctly check the PTE_TYPE_VALID bit
> >  - Explicitly unset both bits of PTE_TYPE_MASK to be extra safe
> >  - V1: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
> > ---
> 
> [...]
> 
> >
> > +       /*
> > +        * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
> > +        * then the PTE we're looking at right now, in the first case we can do nothing and in the
> > +        * second case we just need to unmap this page/block.
> > +        * Otherwise we will needlessly create new tables until we have traversed every single page
> > +        * in the region.
> > +        */
> > +       if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {
> 
> You need an alignment check (with is_aligned) here instead of just the
> size and levelsize. But then you have to measure if that makes a
> meningful difference on the time it takes to run.
> 
> For example imagine you have two 2mb block mapping and the user
> requests to unmap 2mb starting at 1mb offset. Something like that:
> Mapped memory:
> 0x0-0x200000
> 0x0000000-0x4000000
> 
> and the user reqeusts to unmap 0x100000-0x300000
> The size >= levelsize will succed in this case, but if I am reading
> the code right you'll end up unmapping 0-0x200000

I think this is the reason why we need to ensure that unmap calls from
Qcom platform code should all be block mapping aligned (2MB). That will
ensure we don't run into creating 4K page tables just for the sake of
un-mapping reserved memory regions.

-Sumit
