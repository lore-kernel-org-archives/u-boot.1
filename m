Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55668EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783C7871C3;
	Tue, 22 Aug 2023 05:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mf/Qt6Z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29727871E0; Tue, 22 Aug 2023 05:17:14 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD0E869C1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso23371339f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674229; x=1693279029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uq9k8Xodx+dOndTc0rbe7WC+ppAeHYCIdMOb341xmzA=;
 b=Mf/Qt6Z20Q0d4i0Cd9tDIPn7ov28N8N8dooKaFZ9Y4UdEV4tXaZJnoISjfbUvcPXPi
 SPte2nB8dlZ6M6MslbjTzKKjoORSB537DKGar+8xmieqJ8XbUO8laCKRtgsj5xXTv05p
 fP7PmcEKOJseo3qWQOT6k4S/FK9pkYMG8dAPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674229; x=1693279029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uq9k8Xodx+dOndTc0rbe7WC+ppAeHYCIdMOb341xmzA=;
 b=U5+WwnzsDViQ+TFFKeBj9Yc3Rwr55IAnk5UztaMTxm1rtqqgCcNfOzIeGKCcEXXbFF
 Rn23uStRMcXl6jRDRpc3MwkoL2mTjlyYS+fNdPVkkCaP7yB2fHa1VWPIX1lFq/SOMFB4
 +kHc3RDTDDmb7CRE0NuhvyJEH5/HDamuh/H+olvcedHQVKyZSc6UUJl4ikBP0SovbuRd
 A0RVKurodMaWts8+gWjcFgiUmbCPIaa/4dOojHgilDYqywoCAYWqbUiRXdH+t8c5Qpvh
 6V5vsjkUIV3XRWoXYaft3mnj53kdI1ZaJ8uni4ksq762ibgCRnLzWG0/KLITz0U9zUmE
 q4AQ==
X-Gm-Message-State: AOJu0YwbyXG1UMne07GtN64pRcTnF7bU3I52ACWRqRfOSjOhEYofkNTa
 t8lIV2XWSYRIif7pnZOggNVug6YXRsJhuhIuNqo=
X-Google-Smtp-Source: AGHT+IEP0WwXN0Qy+jJMdoQ0y4B4ygMKGzclbzsVqh5Hg1ZXoGxw2Hn7imRo5ZyACgkZjoWdPOReFw==
X-Received: by 2002:a05:6602:340f:b0:792:4044:8095 with SMTP id
 n15-20020a056602340f00b0079240448095mr2151391ioz.7.1692674229353; 
 Mon, 21 Aug 2023 20:17:09 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 00/14] event: Replace some more init hooks
Date: Mon, 21 Aug 2023 21:16:47 -0600
Message-ID: <20230822031705.1340941-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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


This series replaces some more of the init hooks in board_f.c and
board_r.c with events. Notably it converts last_state_init() over.

It also provides a 'simple' event spy, which takes no arguments. It turns
out that this is quite a common case, so it is worth optimising for this,
to reduce code size, before events become too commonly used.

Finally, it introduces a way of emitting an event in an initcall, instead
of calling a function. This is likely to be used at least as often as the
functions, as we convert more of these initcalls.

As part of this, the initcall code is brought back into a C file. Somehow
the compiler has changed or something else, so that this does not confer
any benefits now.

For boards with EVENT enabled, this unfortunately results in small growth,
e.g. for firefly:

   aarch64: (for 1/1 boards) all +114.0 data +16.0 rodata +22.0 text +76.0
       arm: (for 1/1 boards) all +82.0 rodata +18.0 text +64.0

For boards without EVENT enabled the growth is smaller, e.g. nokia_rx51:

       arm: (for 1/1 boards) all +32.0 data +8.0 rodata -8.0 text +32.0

I cannot find a good way to avoid the latter, other than macro magic with
an embedded comma (to completely remove an event entry), which seems
nasty.


Simon Glass (14):
  event: Support a simple spy record
  Revert "initcall: Move to inline function"
  initcall: Factor out reloc_off calculation
  initcall: Adjust the loop logic
  initcall: Adjust the failure message and return value
  event: Export event_type_name()
  initcall: Support emitting events
  initcall: Support manual relocation
  event: Convert existing spy records to simple
  event: Rename EVENT_SPY to EVENT_SPY_FULL
  event: Update documentation for simple spy
  x86: Convert arch_fsp_init() to use events
  freescale: Drop call to init_func_vid() in the init sequence
  event: Use an event to replace last_stage_init()

 arch/Kconfig                                  |   1 +
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |   5 +
 arch/arm/mach-imx/imx8/cpu.c                  |   4 +-
 arch/arm/mach-imx/imx8m/soc.c                 |   4 +-
 arch/arm/mach-imx/imx8ulp/soc.c               |   7 +-
 arch/arm/mach-imx/imx9/soc.c                  |   4 +-
 arch/arm/mach-omap2/am33xx/board.c            |   4 +-
 arch/arm/mach-omap2/hwinit-common.c           |  12 +-
 arch/mips/mach-mtmips/cpu.c                   |   6 +-
 arch/mips/mach-pic32/cpu.c                    |  12 +-
 arch/nios2/cpu/cpu.c                          |   4 +-
 arch/riscv/cpu/cpu.c                          |   4 +-
 arch/riscv/include/asm/system.h               |   2 +-
 arch/riscv/lib/spl.c                          |   2 +-
 arch/sandbox/cpu/start.c                      |   7 +-
 arch/x86/cpu/baytrail/cpu.c                   |   4 +-
 arch/x86/cpu/broadwell/cpu.c                  |   4 +-
 arch/x86/cpu/coreboot/coreboot.c              |   7 +-
 arch/x86/cpu/cpu.c                            |  10 +-
 arch/x86/cpu/efi/payload.c                    |   4 +-
 arch/x86/cpu/ivybridge/cpu.c                  |   4 +-
 arch/x86/cpu/quark/quark.c                    |  30 +++--
 arch/x86/lib/fsp1/fsp_common.c                |   1 +
 arch/x86/lib/fsp2/fsp_common.c                |   5 -
 arch/x86/lib/fsp2/fsp_init.c                  |   4 +-
 board/CZ.NIC/turris_mox/turris_mox.c          |   4 +-
 board/Marvell/mvebu_armada-37xx/board.c       |   5 +-
 board/Marvell/octeon_nic23/board.c            |   4 +-
 board/Marvell/octeontx2/board.c               |   4 +-
 board/cortina/presidio-asic/presidio.c        |   4 +-
 board/emulation/qemu-ppce500/qemu-ppce500.c   |   4 +-
 board/freescale/ls1088a/ls1088a.c             |   3 +-
 board/freescale/lx2160a/lx2160a.c             |   2 +
 board/gdsys/a38x/controlcenterdc.c            |  31 +++--
 board/gdsys/mpc8308/gazerbeam.c               |   4 +-
 board/ge/bx50v3/bx50v3.c                      |   4 +-
 board/google/chromebook_coral/coral.c         |   4 +-
 board/keymile/km83xx/km83xx.c                 |   4 +-
 board/keymile/kmcent2/kmcent2.c               |   7 +-
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c |  10 +-
 board/phytium/durian/durian.c                 |   4 +-
 board/phytium/pomelo/pomelo.c                 |   4 +-
 board/starfive/visionfive2/spl.c              |   2 +-
 boot/vbe_request.c                            |   2 +-
 boot/vbe_simple_os.c                          |   2 +-
 common/Kconfig                                |   1 +
 common/board_f.c                              |  21 +---
 common/board_r.c                              |  20 ++--
 common/event.c                                |  13 ++-
 configs/bayleybay_defconfig                   |   1 -
 configs/cherryhill_defconfig                  |   1 -
 configs/chromebook_coral_defconfig            |   1 -
 configs/chromebook_link64_defconfig           |   1 -
 configs/chromebook_link_defconfig             |   1 -
 configs/chromebook_samus_defconfig            |   1 -
 configs/chromebook_samus_tpl_defconfig        |   1 -
 configs/chromebox_panther_defconfig           |   1 -
 ...-qeval20-qa3-e3845-internal-uart_defconfig |   1 -
 configs/conga-qeval20-qa3-e3845_defconfig     |   1 -
 configs/coreboot64_defconfig                  |   1 -
 configs/coreboot_defconfig                    |   1 -
 configs/cougarcanyon2_defconfig               |   1 -
 configs/crownbay_defconfig                    |   1 -
 configs/dfi-bt700-q7x-151_defconfig           |   1 -
 configs/edison_defconfig                      |   1 -
 configs/efi-x86_app32_defconfig               |   1 -
 configs/efi-x86_app64_defconfig               |   1 -
 configs/efi-x86_payload32_defconfig           |   1 -
 configs/efi-x86_payload64_defconfig           |   1 -
 configs/galileo_defconfig                     |   1 -
 configs/minnowmax_defconfig                   |   1 -
 configs/qemu-x86_64_defconfig                 |   3 +-
 configs/qemu-x86_defconfig                    |   1 -
 configs/som-db5800-som-6867_defconfig         |   1 -
 ...able-x86-conga-qa3-e3845-pcie-x4_defconfig |   1 -
 .../theadorable-x86-conga-qa3-e3845_defconfig |   1 -
 configs/theadorable-x86-dfi-bt700_defconfig   |   1 -
 doc/develop/event.rst                         |  23 +++-
 drivers/cpu/microblaze_cpu.c                  |   4 +-
 include/event.h                               |  72 +++++++++++-
 include/init.h                                |  15 ---
 include/initcall.h                            |  72 +++++-------
 lib/Makefile                                  |   1 +
 lib/fwu_updates/fwu.c                         |   4 +-
 lib/initcall.c                                | 109 ++++++++++++++++++
 scripts/event_dump.py                         |  12 +-
 test/common/event.c                           |  22 ++++
 test/py/tests/test_event_dump.py              |   3 +-
 test/py/tests/test_trace.py                   |  11 +-
 89 files changed, 431 insertions(+), 261 deletions(-)
 create mode 100644 lib/initcall.c

-- 
2.42.0.rc1.204.g551eb34607-goog

