Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91FBC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC61848BF;
	Thu,  2 Jul 2026 22:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="aXGKBjX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05AF84A04; Thu,  2 Jul 2026 22:57:11 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEF8843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783025824; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZPSMiO8Jay++6F+sL1q3ZZT8hs3uXNLwXMgG0j4YHwlgrGWhazpxMhZyDGw32ql0DZ3vtUrGKTtnLD4p8Du6cb+2tRN3TQU4ebOtoYyT7p6PDS6pB7D+OXvfPFCZe8Is7JHFQHX3LB33pXtOILyFP+enUx6brkFliD3cdZegxy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783025824;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WIVXnRtv/zx7JK5sFaRn2diOd3nrcZS1NA2Wg0XV9Cw=; 
 b=YhaWYYukPSSsh0ZmycuCptF9RQciJKKD+gbOluAVXeiW7zq3ls7p1MC7WiKVWipmKmU2nDTCrUqvYUz8kdc4F8yDcSGLdyzjACSvwxAvnBhCmOREa9BVR51AJ5B1BNdcJIL+PU0q5YLrceYwQ0I3H2vwRwazyGIc32nsGk9KhMw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783025824; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=WIVXnRtv/zx7JK5sFaRn2diOd3nrcZS1NA2Wg0XV9Cw=;
 b=aXGKBjX4ZpXztu5ipcWWv1rdL8lfOjtfVLoTA/YHXYm+rxd6rwUKfV7X9Ta0+KSi
 CikfujMzSkyXxu7pVvJjvlrwTTSoLHGN0vOF9zMdhX+4I7hKDqu16nSj2IyOyuWBd/Y
 oDTr7m33ld27Rlb9r6SIWhgc1GfAN9IsH2+6qXPA=
Received: by mx.zohomail.com with SMTPS id 1783025821532690.3938542362309;
 Thu, 2 Jul 2026 13:57:01 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:56:46 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Yao Zi <me@ziyao.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Message-ID: <akbQjpFwVPkwTE4p@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
 <20260701174940.GP749385@bill-the-cat>
 <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
 <20260702140708.GX749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702140708.GX749385@bill-the-cat>
X-ZohoMailClient: External
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

On Thu, Jul 02, 2026 at 08:07:08AM -0600, Tom Rini wrote:
> On Thu, Jul 02, 2026 at 10:24:28AM +0100, Jiaxun Yang wrote:
> > 
> > 
> > On Wed, 1 Jul 2026, at 6:49 PM, Tom Rini wrote:
> > > On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:
> > >
> > >> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >> 
> > >> Add some common library routines for the architecture.
> > >> 
> > >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >> Signed-off-by: Yao Zi <me@ziyao.cc>
> > > [snip]
> > >> +#define CACHE_MAX_LEVEL		3
> > >> +#define CACHE_MAX_INDEX		6
> > >> +#define CACHE_OP		GENMASK(4, 3)
> > >> +#define  CACHE_INDEX_INVWB	0x1
> > >> +#define  CACHE_HIT_INVWB	0x2
> > >> +#define CACHE_INDEX		GENMASK(2, 0)
> > >
> > > I was expecting checkpatch.pl to catch the double space here, but it
> > > didn't. It did warn about a few other things in macros, which should be
> > > checked out at least. And that comment applies for the whole series,
> > > along with a manual check for other spacing issues, thanks!
> > 
> > Those style issues are mostly copied over Linux kernel counterparts, should
> > we leave them as is to ease kernel rebasing effort, or fix them for consistency
> > with rest of the U-Boot?
> 
> Ah, OK then yes, we can leave those if it's a match-up with the kernel,
> but should make note of that in the commit message when applicable, not
> just the cover letter. It will make finding that reasoning easier in the
> future.

Yes, most style issues are in files copied from the kernel side, before
sending v2, I do have a brief look and fix some of them (for example,
mixed TAB/space and multiple empty lines).

But the diff quoted here isn't copied from kernel side, it's written by
myself. I consider the double space meaningful since these two macros
are two possible values of CACHE_OP, and found similar styles in
tools/zynqmqimage.h (PART_ATTR_*) and kernel side, do you think it's
acceptable?

> -- 
> Tom

Regards,
Yao Zi
