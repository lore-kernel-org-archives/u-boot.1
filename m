Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BA7C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 21:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49156848BF;
	Thu,  2 Jul 2026 23:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="dBQCwwoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7F7843B6; Thu,  2 Jul 2026 23:11:07 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A49684A5F
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 23:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783026655; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hils4ltCcDRNHqlcSyn1XZVVSfyq/iAWhAJvgczP6Xt4VMRZhUqbp6REadTgLN+52VF9D820PuaNBYO0VEargePKG3F6HNSvU251mE9dle6rrQ+avcBglLYn+6+gUp65R7DYGsXRC7XMzXQsVHW4pdc+sD+wzxbXdvLJYGfKYso=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783026655;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yq6lx0GA1IBjK9ST1hAnF+NTeP4VZUryf+jVntESbGc=; 
 b=d3CMlL/FdNFkF/M5zuZtTWlTvfiHBg5IkYjr6qngDg+4so3lbJNx/lGWEbzUxNx5xb0xkx7MHeULDHJ/HJ+1gpCAmdEAXc3ypIltHdGg73l61Zf93YBhM+VyC3uryEIHfxMQGEEYUVe+9bvL0hCdAnGasKBXyVYNkq6epEvT9hc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783026655; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=yq6lx0GA1IBjK9ST1hAnF+NTeP4VZUryf+jVntESbGc=;
 b=dBQCwwoY28MoRorFpzlysT7N1MV/RdJacu/31U9tJV292+8T4hg/7XgNJ1TbRXzk
 HTZuBEtTyi55Eet6AGnfzUMnXQF7i8TkbWiWm8JB2xaSiHvrA+Hg8RjEjMgOmLWFTgO
 Njh1YZCKQevHjarXxB9Spyrq3viT29HD1CAg+6v0=
Received: by mx.zohomail.com with SMTPS id 1783026653044238.29621597020025;
 Thu, 2 Jul 2026 14:10:53 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:10:47 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/16] image: Take entry point as an output of
 setup_booti
Message-ID: <akbT18QKNzWz0Fhp@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-4-me@ziyao.cc>
 <20260701173940.GN749385@bill-the-cat> <akbMkCvTJtLlse6C@pie>
 <20260702205522.GE749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702205522.GE749385@bill-the-cat>
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

On Thu, Jul 02, 2026 at 02:55:22PM -0600, Tom Rini wrote:
> On Thu, Jul 02, 2026 at 08:39:44PM +0000, Yao Zi wrote:
> > On Wed, Jul 01, 2026 at 11:39:40AM -0600, Tom Rini wrote:
> > > On Wed, Jul 01, 2026 at 11:17:55AM +0000, Yao Zi wrote:
> > > 
> > > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > 
> > > > For LoongArch the start of the image is not the entry
> > > > point to the image.
> > > > 
> > > > We refactor the code base to allow entry point to be
> > > > supplied by setup_booti.
> > > > 
> > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > > ---
> > > > 
> > > > Changed from v1
> > > > - Correct type of "entry" argument for RISC-V and sandbox
> > > 
> > > Can you please also provide a link to
> > > https://www.kernel.org/doc/html/latest/arch/loongarch/booting.html which
> > > probably should cover this, but I'm not entirely sure does?
> > 
> > It does in a non-obvious way, quoting part of the image header,
> > 
> > 	u32     MZ_MAGIC                /* "MZ", MS-DOS header */
> > 	u32     res0 = 0                /* Reserved */
> > 	u64     kernel_entry            /* Kernel entry point */
> > 
> > comparing it to the RISC-V version[1],
> > 
> > 	u32 code0;                /* Executable code */
> > 	u32 code1;                /* Executable code */
> > 	u64 text_offset;          /* Image load offset, little endian */
> > 	u64 image_size;           /* Effective Image size, little endian */
> >
> > The start of LoongArch image isn't marked as executable.
> 
> Perhaps it's worth clarifying in the kernel documentation then? Thanks.

Sure, Jiaxun and I plan to improve the kernel side documentation, and
additionally improve LoongArch image header to make the image executable
from its start, aligning with aarch64 and riscv64.

However, there isn't a promise when it would land, and even with the
improvement to image header, we still have to parse the text_offset
field to keep compatibility with older images.

> > Additionally, should I include the URL of "latest" kernel documentation,
> > or using a link with explicit kernel version (e.g. [2]) to ensure the
> > content doesn't change or become 404 over time?
> 
> Ah, true, yes, lets point at the v7.1 tag, or whatever you're testing
> this against, to cover future changes if any.
> 
> -- 
> Tom

Best regards,
Yao Zi
