Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F36E10BA421
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 08:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27CB83642;
	Sat, 28 Mar 2026 09:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="a7GDuuPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B518394E; Sat, 28 Mar 2026 09:28:49 +0100 (CET)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85FF81E18
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 09:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1774686523; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AXKjUqYgDp8NC9h/ddIwuOs8+2xTK2TlZw6aVWA5Q5At99psHg8Q+Qf0DvxYn4DpaYN7Hs2p4MyqLwzVMhb5G6Zi5NtUtPBu7tSDDchIlRSNJYW+m8l3UnbH/efbhk4QNvxcP0pJwple7IRHJatlaJiXt17ldeUKoS15IXExfkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774686523;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vZwdCGy13Tb2+/pER96TdA/awRVoabC6Q6dUQKgw42w=; 
 b=jgx8/8kY+qjihCysTvgNcFLwcfxJPMjY2qXvKeAQ/SrpGA+nFFdY2+DPiACjHiCbkAhisIjzinisq+TLzqqz8NT3BfnXV/JRNNWMqTrqkFRn4HPAp8ycOLHjCa+hNbFJClrMWrLsKfDHnWRzOQ9vMqfisU0BlDpbbMzdTNHaSIg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774686523; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=vZwdCGy13Tb2+/pER96TdA/awRVoabC6Q6dUQKgw42w=;
 b=a7GDuuPG0y5vxd66iRaU1MfOaExgkk36FBWkjyK1azRttsX3LQcyd/RB9VJgLYg7
 UxJQ12NSh06VkdpOcerIiMFJFzxsPVNFGaUD3X4zaKd9X4yQkP+AYNqVdp337UV1TjC
 El46R54TJrdY2FtOOf5OWv2N2G4c2HQJWfGUggn4=
Received: by mx.zohomail.com with SMTPS id 1774686520268677.9991877626416;
 Sat, 28 Mar 2026 01:28:40 -0700 (PDT)
Date: Sat, 28 Mar 2026 08:28:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v6 1/7] riscv: Add initial support for P8700 SoC
Message-ID: <aceRLGu6ytbHs1Qv@pie>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
 <20260327141029.628483-2-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327141029.628483-2-uros.stajic@htecgroup.com>
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

On Fri, Mar 27, 2026 at 02:11:15PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add initial platform support for the P8700-F, a high-performance
> multi-core RV64GC SoC with optional multi-cluster configuration and
> hardware multithreading.
> 
> This patch introduces the initial platform code necessary to support
> the P8700 CPU in U-Boot.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/Kconfig                        |   8 ++
>  arch/riscv/cpu/p8700/Kconfig              |  14 +++
>  arch/riscv/cpu/p8700/Makefile             |   8 ++
>  arch/riscv/cpu/p8700/cache.c              |  93 +++++++++++++++++++
>  arch/riscv/cpu/p8700/cpu.c                | 105 ++++++++++++++++++++++
>  arch/riscv/cpu/p8700/dram.c               |  37 ++++++++
>  arch/riscv/cpu/p8700/p8700.c              |  12 +++
>  arch/riscv/include/asm/arch-p8700/p8700.h | 101 +++++++++++++++++++++
>  8 files changed, 378 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/Kconfig
>  create mode 100644 arch/riscv/cpu/p8700/Makefile
>  create mode 100644 arch/riscv/cpu/p8700/cache.c
>  create mode 100644 arch/riscv/cpu/p8700/cpu.c
>  create mode 100644 arch/riscv/cpu/p8700/dram.c
>  create mode 100644 arch/riscv/cpu/p8700/p8700.c
>  create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 79867656b15..9e2cbe775d2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -132,6 +132,7 @@ source "arch/riscv/cpu/jh7110/Kconfig"
>  source "arch/riscv/cpu/k1/Kconfig"
>  source "arch/riscv/cpu/k230/Kconfig"
>  source "arch/riscv/cpu/th1520/Kconfig"
> +source "arch/riscv/cpu/p8700/Kconfig"
>  
>  # architecture-specific options below
>  
> @@ -442,6 +443,13 @@ config SBI
>  	bool
>  	default y if RISCV_SMODE || SPL_RISCV_SMODE
>  
> +config RISCV_CM_BASE
> +	hex "RISCV CM Base Address"
> +	default 0x16100000
> +	help
> +	  The physical base address at which to map the Coherence Manager
> +	  Global Configuration Registers (GCRs).
> +

Sorry for not raising this earlier: this sounds like a MIPS-specific
component, would it make sense to move it into a MIPS/P8700-specific
header? For example, arch/riscv/cpu/p8700/Kconfig.

>  choice
>  	prompt "SBI support"
>  	default SBI_V02

Regards,
Yao Zi
