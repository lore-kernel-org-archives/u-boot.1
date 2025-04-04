Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EAAC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 13:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA6E829C3;
	Fri,  4 Apr 2025 15:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SFDDHFlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FDD4829C7; Fri,  4 Apr 2025 15:50:58 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B5B82991
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 15:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso999765f8f.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743774655; x=1744379455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BD1wUKKCrbUmp6rla3NY493cuhq1KXNYy19SiPqkWpg=;
 b=SFDDHFlX+rF7fnjj1ZksSXYHJfFUADimOqkcuHR/sfd1eI1KMMhDO9ugiGGN8V5KAa
 F/HTmuEo7iaYs4qfnmUfiKXr1Zdb9cjkjfwLCuoqnHurfxJaniooBSjTlra2g0jU6I4G
 yJBsO1rWIZzNc8BPUysURSvsGFteHqCx4lVYPKsDD6j+rzNs/+/F3Id2p3qvaYiDdy7v
 /F7Jl8LLqmZjNl5NV8LIjoIFKYnoSmaTVjODQ6oZmcuUqo6Btj6Znja4zqZz1LYxPGIw
 YR+U0KXkuHbZe7sW+rhlRr8chfGfv26n7wjYE+V2PrGQIxXPr8JdA8X3fyducy4Ds8K/
 RA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743774655; x=1744379455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BD1wUKKCrbUmp6rla3NY493cuhq1KXNYy19SiPqkWpg=;
 b=ENmg7o+AIyHiw++oSFnPkVPy1S+F0W4YpjFkmP/s7Y5hO+SGa71EyB+9IENDP7+3oH
 XAuf2np6WVCoFawstCBr7Rem8ygh3+I0i8sIOPAiCwYCETAVc5Uw5Cz3yr49k6YJKXj2
 fNwI5sUGUrbeL/mPMAr9hcSwcWBb49oSoiflEMDMO1sZhfkUcMJF8tqlWMdYPzHp9Vb6
 DFG6ErFnj3FkPBzwGfCyvKyIw14FngjDhhkFlGhJagcuX+CgpHMT+WASlbKvCvze+D6j
 cTgW3FWUOplRHI1+KqXUiAL1gn66Lx7PnAxlYUBq8MA1+PsrKGxE5qPfrqOxVHPtk9Oz
 zzsA==
X-Gm-Message-State: AOJu0YzxiTy5OOWFslUbRaxacTlSzeowWJiJsJ+tUwXu3TC9t8DHxIHN
 SK1bTyoTHcSauNuGUkzT+LVd390wk8SxCyeYPWiji1t4Qvri2o2BnodDdq9VVWKLIpGRZGLQPzW
 uWb1wN+q+
X-Gm-Gg: ASbGncvr7nByHc2XINLRmWJCjv3Bi6wtS3eDkfXTArMeS0WIOrIyEuSGfSf04o5UYY/
 n95p7NEIKrfN8uVf/wE8ipxbAumS/N3WqZrxc7zd2obBfpJkzJ67jGo1bHtmR2pdK1A13/E/dIe
 vzxkh91Wv3ez0XbaPsWlEQN9M05crRFgOAdCw7ZGlqWY0LSzuN+P8tGWu4M4gk7Lc0w1PLvjrgJ
 +mmHFXZRi5+tL+2xOYucIzrosm+LiDNhFcKM8xG9B7yKq3t9Gi/eckn0T6tKJB4v2XsreDB+bgB
 srogI1GQwlQUQPjk/ZOephxb1yDub0NSOdNW01KTkwpO8CpvIzfh3w==
X-Google-Smtp-Source: AGHT+IGySSiPx1ZACd/LkleMijc4gYuPk6FJUAbo5uiIicZzrtiN6VTWph7N1bz5u6/9hU5cWvk5KA==
X-Received: by 2002:a5d:5c84:0:b0:391:3094:d696 with SMTP id
 ffacd0b85a97d-39cba980b93mr2885926f8f.54.1743774655174; 
 Fri, 04 Apr 2025 06:50:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:70d5:66af:ee2d:db3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm4531821f8f.34.2025.04.04.06.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:50:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v6 0/3] Static initcalls
Date: Fri,  4 Apr 2025 15:50:34 +0200
Message-ID: <20250404135038.2134570-1-jerome.forissier@linaro.org>
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

CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514

Changes in v6:
- Rebase on next branch

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
 common/board_r.c                          | 247 +++++++++++-----------
 include/initcall.h                        |  45 ++--
 lib/Makefile                              |   1 -
 lib/initcall.c                            | 102 ---------
 test/py/tests/test_trace.py               |   8 +-
 10 files changed, 295 insertions(+), 376 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

