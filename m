Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D283C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 16:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08E782F6D;
	Fri, 11 Jul 2025 18:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ndKguSYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C6805D7; Fri, 11 Jul 2025 18:08:20 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F9C82F49
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 18:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56BG8AjH1845160;
 Fri, 11 Jul 2025 11:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752250090;
 bh=onUw/txcQpoJmlvQOpGxkrgttrMBwJAhw1BqAZ+Q/kY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ndKguSYboeoyuD87Zyj8vZIWsbIqh+PEFCDCdt17QuB6kngvpPDu7RxRgDKBoEUqx
 N3v32mNwresrvvXOPYeazRp9AAh2oMaqaioRK6DICr9EbpA8+xbBOz/d6LiUejkaml
 WBXSV9kXH/otd0mkTpAdCDPZc8tYBl3wny6haNuo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56BG8Aai2441804
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 11 Jul 2025 11:08:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 11:08:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 11:08:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56BG8Ajf3466051;
 Fri, 11 Jul 2025 11:08:10 -0500
Date: Fri, 11 Jul 2025 11:08:10 -0500
From: Bryan Brattlof <bb@ti.com>
To: Yao Zi <ziyao@disroot.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] kbuild: Avoid including architecture-specific
 Makefile twice
Message-ID: <20250711160810.cmtm3jtl2ev2rkzh@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250711085234.23659-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250711085234.23659-1-ziyao@disroot.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On July 11, 2025 thus sayeth Yao Zi:
> Stranges errors are observed when building U-Boot master for almost any
> RISC-V board, the messages are in two types, one is about duplicated
> symbols,
> 
> 	u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
> 	arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
> 
> and the other is fixdep's complaint about missing dependency files,
> 
> 	fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
> 	fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory
> 
> where the latter could only be reproduced when building parallelly.
> 
> Both the two types of errors are about files in arch/riscv/cpu, and
> there's a suspicious slash character in the reported path. Looking
> through RISC-V-specific Makefiles, there's only one place that may
> expand to such a path,
> 
> 	libs-y += arch/riscv/cpu/$(CPU)/
> 
> The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> the time of including. With some debug statement added to
> arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> included twice, once with $(CPU) undefined and once defined correctly
> according to CONFIG_SYS_CPU.
> 
> Futher bisecting shows an extra include statement against
> arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> the statement is evaluated before config.mk is included and definition
> of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> in the error.
> 
> Let's simply remove the extra include to fix these nasty errors. For
> config targets, bumping Kbuild also introduced a new include to
> arch/$(SRCARCH)/Makefile, which is removed as well for consistency.
> 
> Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> 
> Changes from v1
> - Don't describe the problem as RISC-V-specific since it may affect ARM
>   builds as well.
> - Prevent config targets from including for architecture-specific
>   Makefile as well for consistency.
> - Add comments to explain the removal.
> - Link to v1: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao@disroot.org/
> 
>  Makefile | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Works for arch/arm/mach-k3 thanks for fixing this

Tested-by: Bryan Brattlof <bb@ti.com>

~Bryan
