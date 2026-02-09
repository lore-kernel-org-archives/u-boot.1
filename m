Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C86E7E0C7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B1D83C30;
	Mon,  9 Feb 2026 12:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EE783C5E; Mon,  9 Feb 2026 12:24:35 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08ED28341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BOJes048936;
 Mon, 9 Feb 2026 19:24:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:24:19 +0800
Date: Mon, 9 Feb 2026 19:24:16 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 1/8] riscv: Add initial support for P8700 SoC
Message-ID: <aYnD4FRyVWrDEflA@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-2-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-2-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BOJes048936
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

On Wed, Dec 24, 2025 at 03:45:22PM +0000, Uros Stajic wrote:
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
>  arch/riscv/Kconfig                        |   1 +
>  arch/riscv/cpu/p8700/Kconfig              |  14 +++
>  arch/riscv/cpu/p8700/Makefile             |   7 ++
>  arch/riscv/cpu/p8700/cache.c              |  93 ++++++++++++++++++
>  arch/riscv/cpu/p8700/cpu.c                | 111 ++++++++++++++++++++++
>  arch/riscv/cpu/p8700/dram.c               |  37 ++++++++
>  arch/riscv/include/asm/arch-p8700/p8700.h | 110 +++++++++++++++++++++
>  7 files changed, 373 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/Kconfig
>  create mode 100644 arch/riscv/cpu/p8700/Makefile
>  create mode 100644 arch/riscv/cpu/p8700/cache.c
>  create mode 100644 arch/riscv/cpu/p8700/cpu.c
>  create mode 100644 arch/riscv/cpu/p8700/dram.c
>  create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
