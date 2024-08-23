Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D580C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622F8888EB;
	Fri, 23 Aug 2024 22:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ATYFlntk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605BA88580; Fri, 23 Aug 2024 22:27:21 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3954A888EB
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81f86fd9305so119547639f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724444838; x=1725049638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bjdojUz7U61zWZMW09Hb4h6G0+S608KcZejbDIeHFqw=;
 b=ATYFlntkPDhChDIHcgUnu63Ukrrc/6TNZtlid7XA7Bb8Cmm3Ohnjm7pKN8U4VRlLKr
 Ll0U7ssaHv+/tBDSGd42MSWZYVJ0946nvPNCZBqakOexuEsxRQrZO2VTi5Y7xTVq2O8r
 i9Ygym5qySKwMxuZAyhrX6hGt6S1MtcCjz1Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724444838; x=1725049638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjdojUz7U61zWZMW09Hb4h6G0+S608KcZejbDIeHFqw=;
 b=dN5E7tnkIHX/8yTbICM6vUh6JCzCcZzJM8Cq9WdXwZOKX6rqZgtabnc0A0WnCu9PZb
 Z5Icyg2s5O3gG/37NBKx2dFfjCaVPzCK8IB2LbYW3eJHav+8PbdcnTUVhMWhr+4X1lVT
 IQUYfr7SqXNAAmIlQOFCmTLK5o1n0w/6IRnG8IaqBhH6zdNwtpnTzBqFrF9wMB5v9GZq
 nbQMiZiWDMqOzbHAtDfOdZmI83ioCqVRRajh41RR1nd1t685F7A33HMJxs1pZ5Sa26ZV
 IQ7tMYuWfLOLKuFCqTSKLOyIttZochoyoBjJAzkidGZLExVdTV/I5hPPbCSctIy+zFK8
 XaNw==
X-Gm-Message-State: AOJu0YwRu/TMkY/BUOkK9poBwkqfMjjVbdYfbUogupMdORKx7aiSwo9+
 IejgXN/3+Rco4zxnTdYNaLNGKEjWxWwYawKj7CAp9JESuu2WQntw6JOSbspfe0aAI1KNNqnKIQ4
 =
X-Google-Smtp-Source: AGHT+IFd8/Rf0S4T88Em4Y4qHRSnB5VmTkmxYgr1X5AMb4tgsMeoZtpiIm8mqx7adHGnmZ1+IcB23Q==
X-Received: by 2002:a05:6e02:20c6:b0:39d:23e7:9709 with SMTP id
 e9e14a558f8ab-39e3c98998dmr41693955ab.13.1724444837846; 
 Fri, 23 Aug 2024 13:27:17 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7480bsm15401635ab.30.2024.08.23.13.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:27:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 00/35] global_data: Reduce size of struct global_data
Date: Fri, 23 Aug 2024 14:26:38 -0600
Message-Id: <20240823202713.430219-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The global data structure has grown quite a lot over the years, being
the best place to put an important pointer or something that must be
accessed before and after relocation.

This series attempts to reduce the size a little, by moving some things
out and shrinking and aligning some fields.

Some fields are needed during init but not afterwards. To deal with this
a new 'boardf' structure is created, which sits on the stack and is only
present during board_init_f(). It is possible that more fields could
move to this struct, but for now only 4 are moved.

An assumption is made that an int is 32-bits wide on all architectures,
which seems to be true, but maintainers should be able to confirm.

Mostly the code-size impact is neutral, but the patch
'Use less space for environment fields' does increase U-Boot's size by
about 30 bytes on aarch64.

For firefly-rk3399 (64-bit) the size of global reduces from 456 to 368
bytes. For SPL it reduces from 416 to 272 bytes.

There are other things which could be attempted, for example:
- Using hlist instead of list for some lists
- Checking that only necessary fields are present in SPL

Changes in v3:
- Keep new_ptr as a ulong to avoid overflow
- Update the comment for malloc_ptr

Changes in v2:
- Rebase to -next

Simon Glass (35):
  global_data: Move pci_clk to m68k and powerpc
  x86: Drop use of global_data fb_base
  video: Add a function to obtain the framebuffer address
  video: mxc: Avoid setting global_data fb_base
  video: mxs: Avoid setting global_data fb_base
  arm: friendlyarm: Avoid accessing global_data fb_base
  arm: ronetix: Avoid accessing global_data fb_base
  zynqmp: Avoid setting the framebuffer address
  video: Avoid setting global_data fb_base from SPL handoff
  video: Avoid setting global_data fb_base in video setup
  global_data: Drop fb_base
  global_data: Convert have_console into a flag
  global_data: Remove pci_ram_top
  global_data: Drop global_data hose
  global_data: Drop pci_bootdelay
  global_data: Use less space for environment fields
  board_f: Add a new struct to hold pre-relocation info
  board_f: Move fdt_size to board
  board_f: Move new_bootstage to boardf
  board_f: Move new_bloblist to boardf
  global_data: Drop spl_handoff
  global_data: Collect common fields at the top
  global_data: Reduce the size of bus_clk and mem_clk
  global_data: Reduce the size of mon_len
  global_data: log: Reorder and shrink fields
  global_data: Reduce size of early-malloc vars
  global_data: Move baud_rate field lower
  global_data: Move env_addr field higher
  global_data: Put phys_addr fields near the top
  global_data: Move ulong fields together
  global_data: Move pointer members together
  global_data: Remove jump table in SPL
  global_data: Remove environment members if not used
  doc: Move generic-board documentation into rst
  doc: Add some guidelines about global data

 arch/arm/cpu/arm926ejs/mxs/spl_boot.c         |   2 +-
 arch/arm/lib/bdinfo.c                         |   2 +-
 arch/arm/mach-exynos/spl_boot.c               |   2 +-
 arch/arm/mach-k3/common.c                     |   2 +-
 arch/arm/mach-k3/r5/sysfw-loader.c            |   2 +-
 arch/arm/mach-tegra/board2.c                  |   4 -
 arch/arm/mach-tegra/cboot.c                   |   4 -
 arch/m68k/cpu/mcf5445x/cpu.c                  |   2 +-
 arch/m68k/include/asm/global_data.h           |   2 +
 arch/m68k/lib/bdinfo.c                        |   2 +-
 arch/mips/mach-ath79/ar934x/clk.c             |   4 +-
 arch/mips/mach-octeon/cpu.c                   |   2 +-
 arch/powerpc/cpu/mpc83xx/pci.c                |   4 +-
 arch/powerpc/cpu/mpc83xx/speed.c              |   2 +-
 arch/powerpc/include/asm/global_data.h        |   2 +
 arch/x86/cpu/i386/cpu.c                       |   8 -
 arch/x86/cpu/intel_common/cpu_from_spl.c      |   4 +-
 arch/x86/cpu/ivybridge/cpu.c                  |   5 -
 arch/x86/lib/fsp/fsp_graphics.c               |   1 -
 arch/x86/lib/fsp2/fsp_dram.c                  |   4 +-
 board/freescale/ls2080ardb/eth_ls2080rdb.c    |   2 +-
 board/friendlyarm/nanopi2/board.c             |   9 +-
 board/ronetix/pm9263/pm9263.c                 |   6 +-
 board/siemens/common/board_am335x.c           |   2 +-
 cmd/bdinfo.c                                  |   2 -
 cmd/sb.c                                      |   6 +-
 common/board_f.c                              |  56 ++-
 common/board_r.c                              |   2 +-
 common/console.c                              |  17 +-
 common/hwconfig.c                             |   8 +-
 common/init/handoff.c                         |  12 +
 common/malloc_simple.c                        |   4 +-
 common/spl/spl.c                              |   6 +-
 doc/develop/global_data.rst                   |  25 ++
 .../historical/generic_board.rst}             |  17 +-
 doc/develop/historical/index.rst              |  12 +
 doc/develop/index.rst                         |   8 +
 drivers/clk/mpc83xx_clk.c                     |   2 +-
 drivers/clk/rockchip/clk_rk3399.c             |   3 +-
 drivers/video/imx/mxc_ipuv3_fb.c              |   2 -
 drivers/video/mxsfb.c                         |   1 -
 drivers/video/video-uclass.c                  |  16 +-
 drivers/video/zynqmp/zynqmp_dpsub.c           |   3 +-
 include/asm-generic/global_data.h             | 351 ++++++++----------
 include/board_f.h                             |  35 ++
 include/env_default.h                         |   3 -
 include/env_internal.h                        |   1 +
 include/handoff.h                             |   7 +
 include/video.h                               |  11 +
 lib/asm-offsets.c                             |   2 +
 test/cmd/bdinfo.c                             |   3 -
 test/log/log_test.c                           |   6 +-
 52 files changed, 371 insertions(+), 329 deletions(-)
 rename doc/{README.generic-board => develop/historical/generic_board.rst} (96%)
 create mode 100644 doc/develop/historical/index.rst
 create mode 100644 include/board_f.h

-- 
2.34.1

