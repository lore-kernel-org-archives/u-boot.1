Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF872C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3D980817;
	Fri, 24 Jan 2025 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="whM/Vbg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9818083F; Fri, 24 Jan 2025 10:10:48 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838B780780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso11626935e9.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 01:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737709845; x=1738314645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J3KO4swjELW6T4fiFLqeZQ0/BucYdmvh5JuDKtSnbDc=;
 b=whM/Vbg4IKfm1Mc/JGeDKdOm6OehgZbfzuFn17hGcgUVihwyAmZjc8wMCiWwcr1x1E
 DvYkyznuVsTAgVvuNNQnfPalRxx5hydc8CIwAcdt/QyGrgghDF7ckbhGm7niJ2kHHYFj
 ykP5L5KA6lBfFwACf5QVQ3CRktg0Y02BEbrmrRv1rUFWJCx/Cw9dQK9YV083C4rdHhcs
 eAHR7W4bc6TngtRHtIClwdiyuZBvJfSvbPBpZq2LlgZq9AlBc3gHtnGKjZJ1PkSDEoNI
 xLXHMoofwH79yChFd0uaTZPTt6vGWIPrlv30aAtZkP5aDzwRzi1tF5QOWW9sYkM965dK
 c4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709845; x=1738314645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3KO4swjELW6T4fiFLqeZQ0/BucYdmvh5JuDKtSnbDc=;
 b=bGDrFUjC6feMNLzhlXxQmjYkMj1u4Sut3RHNmRvw2QKRtgzBG63mIO2pqJTrvx82cN
 zZKRM0EhFORkkeG9u+XDnCgw0KZ/QwLQH7Ll9QAkeRBfSdCvRO9pZsKI1+AQOHA9lS+3
 mCpOnlzLohXEpsqqN8ar9/zvxin3OKssBLjPEww1jcUewuZ4+nAoF37+gdxhOm1iQkwN
 PWjkAvkdSDXDVWsDVkU0VeqYUqwyWT6tCeKuwktc6t4bBPqm6sZms85FsgxetlfZxyTt
 CksC1Fy+no6LYJ4SGi5mTgXcqtzPSeWDyJ+/3YuJlPOj/OeCiCUqSc8x5Y0QNYV7madL
 iFCg==
X-Gm-Message-State: AOJu0YziHshau6wF9Uzto7vfWmwj6w8YapBjqZaaJd1yAPb0RvE8DNYq
 JchYTb/LcgbY+XcaLOEG9tAVUAiPNz793sbe1h/2OagXrL1jwx4B902coE4gp34vE/g45LShUAz
 RayQof6hZ
X-Gm-Gg: ASbGncsua/kOXM1WPyXzZoHGBDC2u4wywphKGVFQrimHxPB9wu7cOSb41IQzSXM1on0
 7RnP0mi74VuvIp/XXBUjViNBzsKpfvDgy728jE+ZKpcxrIXZRxvYNIcnZC/KrEocr8kBFDuHIjl
 ETcSHOhcuU3BRAi3F+Mm8AddkxZ5mWJGVOejnybY4XoBEjxs/XjOPodHUWVUl56kkkwdXc9Wp3i
 vIBwS8BxifvuUbD3x1uIKVjQ3WNSnnvzJK1GHBTbW3T4Tb9d42fdeK3L79FFNcIvTwZypmS1W7+
 F4cfL0neMusXdA==
X-Google-Smtp-Source: AGHT+IFgmyZHeJjxdtiQNYupw9jW628q0U2pUk+CN7tJxplxOi3T+jlXyLjqDWYk8uyMMAhKe5hyMw==
X-Received: by 2002:a05:600c:1f0b:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4389142e1a3mr226379325e9.21.1737709844784; 
 Fri, 24 Jan 2025 01:10:44 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e9c0:313f:f99a:cc15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm18943385e9.39.2025.01.24.01.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:10:44 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 0/3] Static initcalls
Date: Fri, 24 Jan 2025 10:10:26 +0100
Message-ID: <cover.1737709089.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series replaces the dynamic initcalls (with function pointers) with
static calls, and gets rid of initcall_run_list(), init_sequence_f,
init_sequence_f_r and init_sequence_r. This makes the code simpler and the
binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

Execution time doesn't seem to change noticeably. There is no impact on
the SPL.

The inline assembly fixes, although they look unrelated, are triggered
on some platforms with LTO enabled. For example: kirkwood_defconfig.

Azure CI passed [1] except:
- World build, imx8ulp_evk (and other imx*): "bl31.bin: Can't open: No
such file or directory"
- World build, xilinx_zynqmp_kria: "file not found: pmu_obj.bin"
...which are clearly unrelated to this series.

[1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10405

Changes in v5:
- Fix mistake in initcall_run_r(): CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
should have been !CONFIG_IS_ENABLED(...). As a result, several CI tests
were failing. (Tom R.)
- Restore fixes in test/py/tests/test_trace.py and arch/sh/lib/board.c
which had unexpectedly disappeared from v4 and caused CI errors.
- Fix CI error caused by wrong conditionals on the fix_fdt() call:
  tools/buildman/buildman -o /tmp -seP powerpc
  [...]
  common/board_f.c:752:12: error: 'fix_fdt' defined but not used [-Werror=unused-function]
- Add "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set"
to fix a build error with LTO detecting mcr/mrc instructions emitted in
Thumb mode on a CPU that doesn't support it:
  make sheevaplug_defconfig
  make -j$(nproc) CROSS_COMPILE="ccache arm-linux-gnueabi-"
  [...]
    LTO     u-boot
  {standard input}: Assembler messages:
  {standard input}:9241: Error: selected processor does not support `mcr p15,1,r0,c15,c11,0' in Thumb mode
  {standard input}:19196: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19223: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19241: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19268: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19286: Error: selected processor does not support `mrc p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19321: Error: selected processor does not support `mcr p15,1,r3,c15,c1,0' in Thumb mode
  {standard input}:19341: Error: selected processor does not support `mrc p15,0,r3,c1,c0,0' in Thumb mode
  {standard input}:19372: Error: selected processor does not support `mcr p15,0,r3,c1,c0,0' in Thumb mode
  make[1]: *** [/tmp/ccu1wZWX.mk:11: /tmp/ccIab81n.ltrans3.ltrans.o] Error 1

Changes in v4:
- Fold all changes to board_init_*() into a single patch
- Use '#if CONFIG_IS_ENABLED(FOO) INITCALL(init_foo) #endif' instead of
'CONFIG_IS_ENABLED(FOO, (INITCALL(init_foo);));' (Caleb C., Simon G.).
As a consequence, drop Michal's patch ("common: board: Simplify array
with function pointers with CONFIG_IS_ENABLED").
- Rebase on next

Changes in v3:
- Use printf() rather than debug() to report initcall failures
(Quentin S.)
- initcall_run_f(): replace one erroneous call to WATCHDOG_INIT() with
WATCHDOG_RESET() (Ilias A.)
- Fix relocate_code() in arch/sh/lib/board.c to address CI failures with
r2dplus (https://lists.denx.de/pipermail/u-boot/2025-January/576213.html)
(Tom R.)
- Add comments to initcall_run_f() and initcall_run_r() (Simon G.)

Changes in v2:
- INTICALL() and INITCALL_EVT() now call hang() immediately on error
- Fixed typo: s/intcall_run_f_r/initcall_run_f_r/

Jerome Forissier (3):
  arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set
  common: board: make initcalls static
  initcall: remove initcall_run_list()

 arch/arm/include/asm/system.h             |  22 +-
 arch/arm/lib/cache.c                      |   5 +-
 arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
 arch/sh/lib/board.c                       |   9 +-
 common/board_f.c                          | 223 +++++++++----------
 common/board_r.c                          | 251 +++++++++++-----------
 include/initcall.h                        |  45 ++--
 lib/Makefile                              |   1 -
 lib/initcall.c                            | 102 ---------
 test/py/tests/test_trace.py               |   8 +-
 10 files changed, 297 insertions(+), 378 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

