Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2510ACCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 10:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97393845E9;
	Fri,  1 May 2026 12:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="JvKj8HlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05E1845E3; Fri,  1 May 2026 12:41:53 +0200 (CEST)
Received: from sender4-op-o17.zoho.com (sender4-op-o17.zoho.com
 [136.143.188.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7E383A91
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 12:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777632107; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kjVwGOoCKZMt9EifSpuusY0zU5FUKDheLmewnjNh43AnmWxPGUD3pO/Nv+a88U//G4YeCJsJMxt9a0Fx4ZSSI5laAAsLMvKFpXeSe1QndvEIr2XyDgSQHd21TYMDYhryunjOO/QyjStRs0UpCf0gfedQGzbYbdjk4lJpjuN+zY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777632107;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bUuk4lguxn5TP+I9gT48ppcJMdxonaBjltv68t1iSiw=; 
 b=FGH9vf3YmBp8u6EKXsp4MIixVSThD2YZoDxbbyb81bPisqQE5D+7j0lEFBGoicplSH5CfmDmIeJXM3+T68473UF6xgJtfN4L+LjRQVvgEiktcWaOfbjzorr7NwvRuHaXJklQEsJ3CMpcRJEJKDFYsJhIFFPiC3TbgUj63N5ksyc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777632107; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=bUuk4lguxn5TP+I9gT48ppcJMdxonaBjltv68t1iSiw=;
 b=JvKj8HlU2O+yzLv8aXn43K4FujsDDLypD0Adabd1rStP42+E2+csFVcEdfbCfkTG
 SfTLuwMwEnDLvs/RonxNC9eR9UrelYuTvcv3vXGuDMYDYxTXt6qte2o77lhtdLFGXAy
 FZVsF1ksOvrbbHKFiAegkd+Wxc4UuSOhkC2/A8O8=
Received: by mx.zohomail.com with SMTPS id 1777632104672277.464001658534;
 Fri, 1 May 2026 03:41:44 -0700 (PDT)
Date: Fri, 1 May 2026 10:41:37 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, <git@amd.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Disable -fpic for SPL builds
Message-ID: <afSDYX7hJWz6U2jN@pie>
References: <6ada697cef076eaed1971c4877c402a91ad5cb48.1777550346.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ada697cef076eaed1971c4877c402a91ad5cb48.1777550346.git.michal.simek@amd.com>
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

On Thu, Apr 30, 2026 at 01:59:07PM +0200, Michal Simek wrote:
> When building U-Boot SPL for RISC-V with position-independent code
> (-fpic), the linker fails with relocation errors like:
> 
>   relocation truncated to fit: R_RISCV_PCREL_HI20 against `symbol'
> 
> This occurs because SPL's linker script places .bss in a separate
> memory region (.bss_mem) from .text/.data (.spl_mem). With -fpic,
> accessing global variables uses PC-relative GOT addressing, which
> fails when the distance between code and data exceeds the 20-bit
> signed offset limit of R_RISCV_PCREL_HI20.
> 
> The main U-Boot binary requires -fpic for runtime relocation support,
> but SPL runs from a fixed address and doesn't need position-independent
> code. Disable -fpic for SPL builds while keeping it enabled for the
> main U-Boot image.
> 
>    spl/u-boot-spl: all -1187 bss +4 data -2631 rodata +2440 text -1000
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

I've sent a similar patch[1] to fix issues caused by GOT addressing when
building RISC-V ports with LLD, and got feedback that without -fpic
CONFIG_SPL_RELOC_LOADER might break, but don't have the time to
investigate it further.

Maybe we should coordinate on this. I'll take a look on
CONFIG_SPL_RELOC_LOADER first.

Thanks,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20251215172236.52710-2-me@ziyao.cc/
