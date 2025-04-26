Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81820C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 06:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94B781E0F;
	Sat, 26 Apr 2025 08:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HdIvKTkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364DD81E14; Sat, 26 Apr 2025 08:30:21 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C874810EB
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 08:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2DE1225E01;
 Sat, 26 Apr 2025 08:30:18 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZVhuaEC5Obk; Sat, 26 Apr 2025 08:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745649017; bh=f4/rY0RpQiluUm0PL7wY2X9Ml2g41jbnl2ZsBIXj1xs=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=HdIvKTkcD8oBOZ7ywwjumG+b+DWBJVajNiMiokV/0ICdtRX1s8+M8idfgl6fVU853
 j8jGV/8w6j/7G8WNaFnMFIlbXyeV+2+AmecoLtgttk4jlLjxvFnLNuTHQYWvEvnyCU
 h7dcisKkzOJCJG39fjB4EC+Hz/nofkLMjXKneSqlR0ARIrknb0A3FKqgRHMik338Zq
 I/BUGFeMpbqGFQyc60VWQoMahg6bRX2ScSJLaKQkqeF+C7AESYwfd4EPy6dITR62em
 uMDgIY5k7ppsOni7gx9h4bfH23GhxIFPpKQEQmM36UsDShHfJqQeUCsyC2wMSXPl2Z
 36QhAUFGNTJOw==
Date: Sat, 26 Apr 2025 06:30:06 +0000
From: Yao Zi <ziyao@disroot.org>
To: Nathaniel Hourt <i@nathaniel.land>, UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
Message-ID: <aAx9bjXivAAuth-y@pie>
References: <932979cb47c4fded7ac19216ca172504@nathaniel.land>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932979cb47c4fded7ac19216ca172504@nathaniel.land>
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

On Fri, Apr 25, 2025 at 12:43:08PM -0500, Nathaniel Hourt wrote:
> Hi, all
> 
> I am trying to build u-boot and SPL for my Mars board (riscv, variant of the
> starfive visionfive2) following the board-specific docs [1], using
> LLVM/clang as my toolchain with the HOSTCC and CC make options mentioned in
> [2]. I'm building from a RISC-V native chroot using qemu-binfmt so I am not
> using the cross-compile options; thus my make invocation looks like `make
> HOSTCC=clang CC=clang` (for OpenSBI, I just pass 'LLVM=1'). Note that the
> chroot I'm building from does not contain gcc/binutils at all; LLVM is the
> only toolchain present.
> 
> The build usually succeeds, so I try to pass the SPL to the MaskROM over
> UART (using the u-boot-spl.bin.normal.out image) and it just hangs. No
> output, no response, and I have to reset the board. If I pass a working SPL

Have you tried to apply this patch[1]? U-Boot support for JH7110 is
broken at least in v2025.04 release afaik.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/

> I downloaded, it logs some output then accepts a main u-boot payload over
> UART, so if I send the main u-boot payload I built (u-boot.itb), I get a
> "Load address misaligned" error as in [3].
> 
> I attempted to configure my SPL to log to UART by turning on various logging
> options in `menuconfig`, including the options recently mentioned by
> Heinrich Schuchardt in [4], but I have been unsuccessful in getting any
> output from the SPL I built.
> 
> So I am looking for guidance. Is building with LLVM/clang (for riscv)
> supported? I don't know what to try next.
> 
> Thanks
> —
> Nathaniel
> 
> 
> [1]
> https://docs.u-boot.org/en/latest/board/starfive/milk-v_mars.html#milk-v-mars
> [2] https://docs.u-boot.org/en/latest/build/clang.html
> [3] https://pastebin.com/xwEcqEpz
> [4] https://lists.denx.de/pipermail/u-boot/2025-April/586264.html
