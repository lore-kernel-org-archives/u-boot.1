Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D200CCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D515803C6;
	Fri,  1 May 2026 14:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="qHPRuv3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAEB881E18; Fri,  1 May 2026 14:20:53 +0200 (CEST)
Received: from sender4-op-o17.zoho.com (sender4-op-o17.zoho.com
 [136.143.188.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621A780086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777638047; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZDEgSIn30aH//eDdPE3iXD0WXF3+PU72tf0Mas1wEZ9+pGLgiJGJTa9JWvui5gf5GrZ/OqpkK72XEUmko5riUHprX1zUAMj705XIZbUDkABmqx8yF0LKew1Yy878RMGBbeFzLqZg2KoCQHny5KBFgq8FmXQq74knMXAllSHYIqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777638047;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/vJP7rXawwn844+U301DuHJSl1F68+A/ftagc+6vu8g=; 
 b=aVka0fu+9ZpNB8l6pcwlpaJlxJ8xFJabJ7fGAOwZnoQJjkjGCwddY9frWcGRukuLp/GR0vaG4YWjkQVrw5/FpwWIJztxAhtXZX7Dut6pEv8hSy44KVti7AXpXSnLLPvZIwBrRyUjWeCgOAYrk+C7z4jyYgiJ274w2cSUze8oQRs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777638047; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=/vJP7rXawwn844+U301DuHJSl1F68+A/ftagc+6vu8g=;
 b=qHPRuv3u6qOsstcggYHTjuZflSumU4V+NxgXYbPO80PaDG3MCNCo7iNZTHINd4yn
 HQLvvMQ6iteyb/8myF23auMlQ2Ls6EuumtiMjdr1xHaoz/Za06ewDZ2vFgsJWIhTp+n
 K/Sc993d9Sne+J2oJ4JXXcvNpKjL/RuLkntIW7Qg=
Received: by mx.zohomail.com with SMTPS id 1777638043392557.1548888916449;
 Fri, 1 May 2026 05:20:43 -0700 (PDT)
Date: Fri, 1 May 2026 12:20:37 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, <git@amd.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Disable -fpic for SPL builds
Message-ID: <afSalS7aSMP1MHIV@pie>
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

This sounds strange. R_RISCV_GOT_HI20 instead of R_RISCV_PCREL_HI20
should be used when addressing a variable through GOT in code. Thus I
suspect in your case, the compiler decides to address the .bss variable
PC-relatively, bypassing the GOT, possibly because it's static thus
considered non-preemptible.

Might you provide a reproducer for the problem so we could dig it
further and confirm the root cause?

Best regards,
Yao Zi

> The main U-Boot binary requires -fpic for runtime relocation support,
> but SPL runs from a fixed address and doesn't need position-independent
> code. Disable -fpic for SPL builds while keeping it enabled for the
> main U-Boot image.
> 
>    spl/u-boot-spl: all -1187 bss +4 data -2631 rodata +2440 text -1000
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
