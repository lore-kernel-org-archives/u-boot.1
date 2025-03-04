Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD39C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 10:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E218142D;
	Tue,  4 Mar 2025 11:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aEGqUYlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE6228144A; Tue,  4 Mar 2025 11:51:52 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476FF81335
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 11:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so58348095e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741085510; x=1741690310; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TyvuaGnLvQhEv051XvEZCES4aanJ3SW9InUYaDZZQCg=;
 b=aEGqUYlXzSqhye/+llxQQvcFdJ8ZnCWfDvUpEp0QpIkLjV3lWG5R0N1AMeWlVIr/xg
 smIbXcH8ogTctMhR3hEw/nZTboL+QLZbwEYkvc82ARy9lYE75l9vAIqMV51Kgg+/sWWL
 2+OGGqf75OTZ2fqJq5D296VXyGQ3ApWJVCkjmhPcG2mOy2LBMcsWYkdqJVx6TAI5j35m
 WFyWNTzUuUNz5NhOV9Q12HdVTDMBCc6Vy5ZvBbJlYsNQ7es71348g6LbWTYeQ9rHgILu
 HOoHCLnGYf8wXWC5VQdM6Ps71/LQKcN7njHbji/PTCwjXXEahx7kXUURCEM8cvcHZEHN
 v0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741085510; x=1741690310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TyvuaGnLvQhEv051XvEZCES4aanJ3SW9InUYaDZZQCg=;
 b=BL47aZpFHhJfn0jvr4UwOSwBCy+qa7MjiwTtGMAIWWLUeH9gEFH7w9lhxC55cgStkS
 N+Rz+ZOMKJxUmwpnGXfyBpLmu3AwcL1UPuI1QIz3YbbbQwJT9S4yRNc6+eGMYm5kwpLi
 qr/et0CRQDsbDYcvqJt+41yBv8sbGJ1CQbWF7zpf7uH144dbvP0VdRuQbeH0VcjpkxfH
 EXMahRAYsiR+T32TFYU6Eyc3o0dJRLrgnbab1SaPzG4Uc3cANGtY37i+BHSyojCvpSJK
 T0jjKCeEvn1zgia9z5fxyCxZT3su8XeUax6W240DCTAVXmkyrg+sEzEWD3y3+u3/ar6p
 5fWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAeRmiNNRivgFdxN0WypXts2uGfSUrXRiNND4XYdLT+qMqedjUNJp2rMtd4uvC7HavEW8sAeA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywab/bRuRLcE2gBWLrUeRVIf3LijNBw5LxLcY4Yb/BsOYEhntL7
 QsD7S35WO/5DKCwibAR/r0LQGRdfqxCgaKSPGoTXe+WkHCJgBdunsjewdVJCKf8=
X-Gm-Gg: ASbGnctYQyVhCE+NCrO83YLG8fx/VEUyXrY2TswpnqlBd+/XSpASZbe8mupxaKEAdz9
 f7jAK8mj688FeW5GteD1bRulp8WUUQkF6hnJE8olT9WKyvFbPClOCGALNwRdJ5ABMiFO6D7tdqD
 Y+Ez/faqVyLd1Ab1yEbnu/WYcXTDyq4ldplzUBNPhRzxqcxigrGufUkBYz8KNbFyNWwyBwQY7vB
 GPJlrP9XfC2NkjsA5uNTv/tgEw9PYABgN+py3I/fUInsMLNuzg+fv5lZOGy0Goghbqh/d1cfODl
 aUAmNSLRJiHCW3xJR9aSgPXoGqubPg6rFbrjWDV2tCs118T1ula3P+I=
X-Google-Smtp-Source: AGHT+IHrT9/lFU+zQiUesDFlRVAAnDBhAp+bG3EudPkC/QZ2xP5qW/rf9R7gHFW8Yl34P5XZzodWEQ==
X-Received: by 2002:a05:600c:5246:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43bb64f1ce8mr78475445e9.25.1741085509602; 
 Tue, 04 Mar 2025 02:51:49 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5710ebsm230089175e9.26.2025.03.04.02.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 02:51:49 -0800 (PST)
Message-ID: <d2701608-76ea-483a-b437-31098f90dbf1@linaro.org>
Date: Tue, 4 Mar 2025 11:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Static initcalls
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <cover.1737709089.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <cover.1737709089.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Marek,

On 1/24/25 10:10, Jerome Forissier wrote:
> This series replaces the dynamic initcalls (with function pointers) with
> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> 
> Execution time doesn't seem to change noticeably. There is no impact on
> the SPL.
> 
> The inline assembly fixes, although they look unrelated, are triggered
> on some platforms with LTO enabled. For example: kirkwood_defconfig.
> 
> Azure CI passed [1] except:
> - World build, imx8ulp_evk (and other imx*): "bl31.bin: Can't open: No
> such file or directory"
> - World build, xilinx_zynqmp_kria: "file not found: pmu_obj.bin"
> ...which are clearly unrelated to this series.
> 
> [1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10405
> 
> Changes in v5:
> - Fix mistake in initcall_run_r(): CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
> should have been !CONFIG_IS_ENABLED(...). As a result, several CI tests
> were failing. (Tom R.)
> - Restore fixes in test/py/tests/test_trace.py and arch/sh/lib/board.c
> which had unexpectedly disappeared from v4 and caused CI errors.
> - Fix CI error caused by wrong conditionals on the fix_fdt() call:
>   tools/buildman/buildman -o /tmp -seP powerpc
>   [...]
>   common/board_f.c:752:12: error: 'fix_fdt' defined but not used [-Werror=unused-function]
> - Add "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set"
> to fix a build error with LTO detecting mcr/mrc instructions emitted in
> Thumb mode on a CPU that doesn't support it:
>   make sheevaplug_defconfig
>   make -j$(nproc) CROSS_COMPILE="ccache arm-linux-gnueabi-"
>   [...]
>     LTO     u-boot
>   {standard input}: Assembler messages:
>   {standard input}:9241: Error: selected processor does not support `mcr p15,1,r0,c15,c11,0' in Thumb mode
>   {standard input}:19196: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19223: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19241: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19268: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19286: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19321: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
>   {standard input}:19341: Error: selected processor does not support `mrc p15,0,r3,c1,c0,0' in Thumb mode
>   {standard input}:19372: Error: selected processor does not support `mcr p15,0,r3,c1,c0,0' in Thumb mode
>   make[1]: *** [/tmp/ccu1wZWX.mk:11: /tmp/ccIab81n.ltrans3.ltrans.o] Error 1
> 
> Changes in v4:
> - Fold all changes to board_init_*() into a single patch
> - Use '#if CONFIG_IS_ENABLED(FOO) INITCALL(init_foo) #endif' instead of
> 'CONFIG_IS_ENABLED(FOO, (INITCALL(init_foo);));' (Caleb C., Simon G.).
> As a consequence, drop Michal's patch ("common: board: Simplify array
> with function pointers with CONFIG_IS_ENABLED").
> - Rebase on next
> 
> Changes in v3:
> - Use printf() rather than debug() to report initcall failures
> (Quentin S.)
> - initcall_run_f(): replace one erroneous call to WATCHDOG_INIT() with
> WATCHDOG_RESET() (Ilias A.)
> - Fix relocate_code() in arch/sh/lib/board.c to address CI failures with
> r2dplus (https://lists.denx.de/pipermail/u-boot/2025-January/576213.html)
> (Tom R.)
> - Add comments to initcall_run_f() and initcall_run_r() (Simon G.)
> 
> Changes in v2:
> - INTICALL() and INITCALL_EVT() now call hang() immediately on error
> - Fixed typo: s/intcall_run_f_r/initcall_run_f_r/
> 
> Jerome Forissier (3):
>   arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set
>   common: board: make initcalls static
>   initcall: remove initcall_run_list()
> 
>  arch/arm/include/asm/system.h             |  22 +-
>  arch/arm/lib/cache.c                      |   5 +-
>  arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
>  arch/sh/lib/board.c                       |   9 +-
>  common/board_f.c                          | 223 +++++++++----------
>  common/board_r.c                          | 251 +++++++++++-----------
>  include/initcall.h                        |  45 ++--
>  lib/Makefile                              |   1 -
>  lib/initcall.c                            | 102 ---------
>  test/py/tests/test_trace.py               |   8 +-
>  10 files changed, 297 insertions(+), 378 deletions(-)
>  delete mode 100644 lib/initcall.c


Do you need something more from me on this series? Thanks!

-- 
Jerome
