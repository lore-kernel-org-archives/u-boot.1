Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C0CC44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8C184D38;
	Tue, 14 Jul 2026 19:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="kodZtFox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3160884D3A; Tue, 14 Jul 2026 19:08:22 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75EC84D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784048893; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LJF2OQDEZ9M4k3hVD/yPRwZDgrBQ2d3ZQ5cRuB5cMnzKc9wjxShEeQeed1cjmOc0R+8kRkE8wi731A5olweWPCzMj8DywM3REVxD4wnUi/tQ2fB+B+XcgpOm1DjwSo6IdiSiR/QTdNkBa+hvLuPsiuT1CRQnjs4MlF8RPlrg71g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784048893;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Jo5+rez/Jq5bC79kfcGIOK7vNW26lc99Mc4s3Nh76mY=; 
 b=Q1uhtsrhhpU+7q8Zoh699pZqH+I4bY8OwQlB5c8b5pvgWj4TJeuFDSavZhmxSyC+E3GNwXA/8aCC5CWkLfbqSl70kJqfChY/4fwfG7M+9Zpa9ricw6+Lv5DAm/enWMQvje9/GSyvSP7iQXdGNMVq3xDtGe8MvTQJp5sS2CH8w0Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784048893; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Jo5+rez/Jq5bC79kfcGIOK7vNW26lc99Mc4s3Nh76mY=;
 b=kodZtFoxfmEJllJwh65OYKHTmrQJ7vbvVhVDztib0Sx/fhVBm9PfpZros3FD4qeF
 hNg7MZw3fdp34qCiCpIT6d6axbXNdJ65DGegULNgxbBY/DOkgVkXHreG5UC3pmgcVil
 /s9YJMTPOQq4r1AHynW3WWNPCqnh9ZxWcghedYHs=
Received: by mx.zohomail.com with SMTPS id 1784048890195808.9186321744206;
 Tue, 14 Jul 2026 10:08:10 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:08:04 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 11/16] LoongArch: Generic CPU type
Message-ID: <alZs9GZgBGI91_EB@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-12-me@ziyao.cc>
 <20260701175503.GR749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701175503.GR749385@bill-the-cat>
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

On Wed, Jul 01, 2026 at 11:55:03AM -0600, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:18:03AM +0000, Yao Zi wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > Provide a generic CPU type with some common routines
> > that expected to be implemented at CPU level.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> > 
> > (No changes from v1)
> > 
> >  arch/loongarch/Kconfig              |  1 +
> >  arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
> >  arch/loongarch/cpu/generic/Makefile |  7 +++++++
> >  arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
> >  arch/loongarch/cpu/generic/dram.c   | 21 +++++++++++++++++++++
> >  5 files changed, 64 insertions(+)
> >  create mode 100644 arch/loongarch/cpu/generic/Kconfig
> >  create mode 100644 arch/loongarch/cpu/generic/Makefile
> >  create mode 100644 arch/loongarch/cpu/generic/cpu.c
> >  create mode 100644 arch/loongarch/cpu/generic/dram.c
> > 
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 109d37d8e2c7..5254afb2cd05 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -12,6 +12,7 @@ endchoice
> >  # board-specific options below
> >  
> >  # platform-specific options below
> > +source "arch/loongarch/cpu/generic/Kconfig"
> >  
> >  # architecture-specific options below
> >  choice
> > diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/generic/Kconfig
> > new file mode 100644
> > index 000000000000..ac7556d6d4d0
> > --- /dev/null
> > +++ b/arch/loongarch/cpu/generic/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
> > +#
> > +
> > +config GENERIC_LOONGARCH
> > +	bool
> > +	select SYS_CACHE_SHIFT_6
> > +	imply CPU
> > +	imply CPU_LOONGARCH
> > +	imply LOONGARCH_TIMER
> > +	imply CMD_CPU
> 
> Which of these "imply" values can ever really be turned off? CMD_CPU?
> Yes, others, I don't know.

CPU* are all optional, but to turn them off, we must also turn off
DISPLAY_CPUINFO, which is broken without CONFIG_CPU since the
implementation of print_cpuinfo() is guarded by CONFIG_IS_ENABLED(CPU).
I think we should reflect the dependency in Kconfig?

For LOONGARCH_TIMER, it's necessary for delay functions to operate, but
if a platform makes use of a non-standard in-core timer implementation
in the future, being able to turn LOONGARCH_TIMER off in the board
configuration might help in code size. But I don't have a strong opinion
for this.

> -- 
> Tom

Regards,
Yao Zi
