Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54358C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C242788DFA;
	Wed, 21 Aug 2024 18:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N+JTG5rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC0288C0C; Wed, 21 Aug 2024 18:19:37 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEE988A27
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093abb12edso4954842a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257174; x=1724861974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JvlM0b8/SYI8BduHQejPYsN6+Ya+USjwyciQ4Dkk2sg=;
 b=N+JTG5rt2FzTaG0xLuVl6Mj/bdZAqwUTvL73fwIOKd2akHuyDoFMy36/dz+yLV8Xcq
 Igyg2t/C8nCQI0kXrRjWGQWz7PZEGzDyuspyC0auUZeCDiIs2sOlUNmBomd1yHhNGNVl
 Zpo2R2fqXvg8aJLJyEWWS/GHz8OhwczPSvRSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257174; x=1724861974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvlM0b8/SYI8BduHQejPYsN6+Ya+USjwyciQ4Dkk2sg=;
 b=XnP1x2Zl156rShq/862/e3mZh24hSYvhvycctwH6mWCOVarR+QH4cfqssyUGgYr67t
 aFA3A4a61TVSFLM+rRA64fkPifThYWb/fIEnZ+j+PtfPMuwAvQwGJrEnu/z0O4dOwv6K
 Gp/UZ5vtgM0XGc+ddGBOszyRDydgYKMDCbItUhoD4NJHba2Q7VdA0sa15aVTWI5TLYmU
 IDSzG16jo3DMhokcrsM29DazjeAkShKdXLXO/IJbkZvYoacThaRVk/HxpqRBUNfXpBAK
 h2pqXGeFugIjdgE0Bbvcz0TbDnv8JYVUS5ZKt+eLCpSfE9Thn7I0ofi3jyvjvVCzsL9v
 3wCA==
X-Gm-Message-State: AOJu0YxLTd7SLOw/2xdX0QmAwP3yHgob20NGvsKu1qKhvEgCSFJetGsF
 Dq70qBy1K4YHCxk56rlnwlqIiTOKKSZ2SKDHcTpUWwWpLEPOvfwmPHXN/2F8wa1EULXm7J0bgE8
 =
X-Google-Smtp-Source: AGHT+IHfCSXeOaIjZtKbRP69+4NmcC1FuhUyAI2kpViK0hAaDv7fK8GNk027v/cbhvf1GLkEX2OSsw==
X-Received: by 2002:a05:6830:2808:b0:709:4230:c6e2 with SMTP id
 46e09a7af769-70df884b9d7mr3179262a34.26.1724257174352; 
 Wed, 21 Aug 2024 09:19:34 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 00/35] global_data: Reduce size of struct global_data
Date: Wed, 21 Aug 2024 10:18:52 -0600
Message-Id: <20240821161927.695717-1-sjg@chromium.org>
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
 common/malloc_simple.c                        |   7 +-
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
 include/asm-generic/global_data.h             | 349 ++++++++----------
 include/board_f.h                             |  35 ++
 include/env_default.h                         |   3 -
 include/env_internal.h                        |   1 +
 include/handoff.h                             |   7 +
 include/video.h                               |  11 +
 lib/asm-offsets.c                             |   2 +
 test/cmd/bdinfo.c                             |   3 -
 test/log/log_test.c                           |   6 +-
 52 files changed, 372 insertions(+), 329 deletions(-)
 rename doc/{README.generic-board => develop/historical/generic_board.rst} (96%)
 create mode 100644 doc/develop/historical/index.rst
 create mode 100644 include/board_f.h

-- 
2.34.1

