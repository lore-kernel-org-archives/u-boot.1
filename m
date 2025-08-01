Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD78BC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 07:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8C68380F;
	Fri,  1 Aug 2025 09:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XruEta8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1022D8380F; Fri,  1 Aug 2025 09:54:34 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B0183807
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 09:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8B15025CE4;
 Fri,  1 Aug 2025 09:54:31 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JOcs5TuAsRh; Fri,  1 Aug 2025 09:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754034871; bh=7QoZR+q+YOIhsFI0uyGtszGZuaW5QaNcVwfBrl1NXhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XruEta8E/OcQdFyaJPsH/TF92Q/DUE44UdZQeX31AscF32eZjA+vKxacGf0bz2otw
 V/2oqEeI7c/pPuid6EPiG4ssNoJTQNZRUCCLn3qgbVZufoS9WjY5oc7z9wEjJ64vEf
 RLDgUn3j5JxB/unV+jLLPlnxSOJ8jI5jOmHYYYv5iKahX4VROPNNvy1Kpm+KIMhlZ5
 I9M/Bs49eXJM7bv5gFwX7xdkXLnrlR9fDZrOQWwOihbeBd3un0R6J0+pkQ1bbieDJJ
 dRp3Ht3UN/DGxUj8sHMW0YXLhFqHxl58K3deXUFT/7ww4UhkKsykaxSu5TgtvDKoq5
 0Z5GHeUm83saw==
Date: Fri, 1 Aug 2025 07:54:17 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v3 08/12] riscv: p8700: Add software emulation for AMO*
 instructions
Message-ID: <aIxxeVl7xsQm3QnJ@pie>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-9-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729162035.209849-9-uros.stajic@htecgroup.com>
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

On Tue, Jul 29, 2025 at 04:24:17PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> This patch adds software emulation for atomic memory operations (AMO)
> instructions that may not be supported in hardware.
> 
> The `emu-amo.s` file provides assembly implementations of the
> aforementioned operations. Corresponding handler logic is integrated
> into the illegal instruction trap to catch and emulate unsupported
> AMO* instructions at runtime.

The main body of U-Boot is executed by only one CPU, so I don't think
there're chances for atomic instructions; disassembly of a U-Boot binary
built with qemu-riscv64_smode_defconfig confirms the idea: the only four
amo instructions locate in arch/riscv/cpu/start.S for picking the HART
to run U-Boot.

I suggest implementing a LR/SC-based codepath for HART lottery logic in
start.S, and introducing a new Kconfig entry (maybe CONFIG_ISA_ZAMMO) to
represent the availability of Zammo extension. We could use the
alternative path for RISC-V platforms that don't implement Zammo and
disable CONFIG_ISA_ZAAMO, which saves a lot of lines and make the code
cleaner.

Regards,
Yao Zi

> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/cpu/p8700/Makefile  |   1 +
>  arch/riscv/cpu/p8700/emu-amo.S | 254 ++++++++++++++++++++++++++++
>  arch/riscv/lib/interrupts.c    | 299 +++++++++++++++++++++++++++++++++
>  include/interrupt.h            |  19 +++
>  4 files changed, 573 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/emu-amo.S
