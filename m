Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CCCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D55A848BF;
	Thu,  2 Jul 2026 22:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Hj0LmVGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B394C847C8; Thu,  2 Jul 2026 22:39:28 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312D3847C8
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783024760; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LYaUjKL4hmGYIc1dKIyZtwG/tUcnq+8t7y5LchGoppTpNvyUwn4plMaa8e4nmn5V3ol6RZQnVlio9seXq4TRQZ2s3axBQDFiuzfNXxuXtnyMGMRYAr0/RsPc60ggjdUl5fvMrjZlpW1USMZEGpJAcwEfWLPbxLv3nAfbdFOBs8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783024760;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w6ZhqU+WPFTDDVCazxefJl20thYn7mPG6knmiCl3wPU=; 
 b=hTnMIF1fzApC3GxgKAwWu+Il+yWTDeiwFcrE+9ePiIJfNhKcgmegNwAc0nHOOmiDPhLTK/fPSYkjM1IT2qY6d1RrrzPI4ZytuIr+/yUb1D1F1UhFt4Z0CTHm+sbNTYMkT7WTm9315QGjKg4fXP6EGJ65cqnnjwABCkdwAkRkiUE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783024760; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=w6ZhqU+WPFTDDVCazxefJl20thYn7mPG6knmiCl3wPU=;
 b=Hj0LmVGB0K4QJjc/BUA1zMDOYwl4EG4PpBAjs2w1H1AUYlJ3UoDsQZkPcEtg/Zhz
 ew6E9RSNPYL7lzg219xcToiu7ME96nagb5Dgucts8gLrLCzgnMjTh9WRFV59SI6hJ6F
 CNeUvJ2h5P+t+6KU3cms9H4ysM80h9FBUUjjX43U=
Received: by mx.zohomail.com with SMTPS id 1783024757161537.4642761918177;
 Thu, 2 Jul 2026 13:39:17 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:39:07 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 01/16] lib: fdtdec: Handle multiple memory nodes
Message-ID: <akbGWWq3kQZERfOD@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-2-me@ziyao.cc>
 <CAFLszThfvoqgsTwZcmmR7+feYM80wUhH0n6=RdBPW47+Nv=YAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThfvoqgsTwZcmmR7+feYM80wUhH0n6=RdBPW47+Nv=YAw@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 11:22:14AM +0100, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > lib: fdtdec: Handle multiple memory nodes
> >
> > Current code only tries to fetch the first memory node found in
> > fdt tree and determine memory banks from multiple reg properties.
> >
> > Specification allows multiple memory nodes in devicetree, rework
> > fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
> > to iterate over all memory nodes.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > include/asm-generic/global_data.h |   2 +-
> >  lib/fdtdec.c                      | 129 ++++++++++++++++++++++----------------
> >  2 files changed, 76 insertions(+), 55 deletions(-)
> 
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> > +too_may_memory_banks:
> > +     log_warning("%s: Too many memory banks\n", __func__);
> > +     return -EINVAL;
> > +}
> 
> Typo - too_may_memory_banks should be too_many_memory_banks. While
> you are here, please drop the goto... bank is bounded, so a single
> check after the loops (or bank < CONFIG_NR_DRAM_BANKS in the inner
> while) gives a single return path.

Thanks for the advice. I don't think it's okay to have only a check
after the loops, in which case we might iterate over the boundary of
gd->dram[]; and if we use bank < CONFIG_NR_DRAM_BANKS for the condition
of the inner loop, another additional check is still necessary after
the loops because we want to give out the message and a correct return
value indicating the error, right?

Alternatively, I think we could drop the goto statement and instead
return immediately in the inner loop if CONFIG_NR_DRAM_BANKS is not
sufficient, is it okay for you?

> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> > +                     log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%llx, size = 0x%llx\n",
> > +                               __func__, bank, ofnode_get_name(mem), reg,
> > +                              (unsigned long long)gd->dram[bank].start,
> > +                              (unsigned long long)gd->dram[bank].size);
> 
> The current code uses %pap with &gd->dram[bank].start, which is the
> idiomatic way to print phys_addr_t/phys_size_t iand should avoid
> needing casts. Can you keep %pap here (and in the message below)?

Sure, this makes sense. When rebasing, I noted the change in current
master, but had only remembered to update the log_debug() message in
fdtdec_setup_mem_size_base_lowest() to use %pap.

> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> > +     while (true) {
> > +             struct resource res;
> > +             phys_size_t base, size;
> > +             int reg = 0;
> 
> You should really use phys_addr_t for base

Ok.

> Regards,
> Simon

Best regards,
Yao Zi
