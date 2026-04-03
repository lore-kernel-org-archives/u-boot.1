Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A7E7E34C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E38840ED;
	Fri,  3 Apr 2026 11:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QJfsvmUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD0A840D8; Fri,  3 Apr 2026 11:01:26 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3324683CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso23049145e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775206881; x=1775811681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2qOw7g0w1OkeBTYcTnMRVGJ+vqoRSbJavpHdkB/7HTQ=;
 b=QJfsvmUV1T3FVbN2aS42syIVtDfMjjNxV0PGWACTX94AGpmLE4LV8IZRHh4qUwTlfY
 7UZ6G53Up5k76JMAq8I/trba2eI4eDy1uGg98xh+SrjOC2nOha4+DnyrXIr8eIU0WgLS
 OLUHJ9Z0R7V8LyGCzPASN1lNZfc6d4/tUBoWZkCl8EJcFlwvwe6BdJfb5znw45IVfyx1
 TwK6/tSgEZdQ4UKvXArRgXzCangRvUNDgaXWMbRZ1DoH72T5yLxrt4qdQu+C/k0jk69U
 7AvMn7C/2UOyi89YywMmUa7o2ParV5kcwmwMcpCdziqsSKjvZJWy46skUlpRPQSCsShg
 eoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775206881; x=1775811681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qOw7g0w1OkeBTYcTnMRVGJ+vqoRSbJavpHdkB/7HTQ=;
 b=rJTfTUq8wuBSJy5ik1Sic5zbkj2ld3M+J1IvGoaaFcXpBlxnZjvfQHABmgrNX5mVZ0
 G3jkOAH2wPAc+v71g7Yuy/4A8SzMAzETfQ1DRtGyKcx5Jf6X8kBr3H+LHSUb3pq2mq7P
 uzm9oXT4xKdzVZ+GTgdyWJYOCblv8fWrRbYjB8rxtdua1H6tleo+fUJOfqwfDxr1x2yX
 t1M/gejHQ4H4A71BJsHpZ+yTfPaDAERgosx25VWoMGjBZp8MGE7Xza5Aj9MKszhd4X3H
 AZQZsdtUJL7NiSx6YIa1G9bMd0m6dBFnPtC94wx+WAiXSJOce1yftkBClSg9usYcQ89T
 12VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwgBF30GDDdXKapFAT/knAVQ559uK0SsagbunVg5AfyrFj7OnCAi6p3Vuy2HY0NBR9fjfcSA0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3xhGCs7rlo8OyqLIwoBZtH2s2IdJtX8ByQVNKFb+lDVyfgu4Y
 kdPSNvaG9JT1cMhjmp6IF52l2uXqASwoWqtGHBa3abka6fxpgP0eEq++hsKazIjvivw=
X-Gm-Gg: ATEYQzxAwi8z9uIt9brHuYPgkK4K+HsFQrtAUuAGDtmUna5kDErdi9fFZ3S6JpySz1T
 tUcrl5OboL8kpv9pjTf4RGYa6TM4hobIe78BafmtqFpMh4ymc/efCMW0weFuvFaQVBssdlsNesr
 H8enzzsUpm+9S/mo1alIRXd6/Mi4Sut0ALDQGKGJq8Dlb3xipQPQvCKyMLJQRWLRhvYus3qhaj5
 OASAaGUfKZk/x7294GYqSIkobIYZ1Y2NKW57Q9sPj3S5DyP/H+zbnwzWKdJ/uDVwY+sXKzPKaSE
 THEppAKBaIKKa5SojatoFOVNk57Y5DlZQE7vW6guTbRLAlySIHL3YDurAfRiWyi78npJlXmoMtI
 d+PQEQjo2UxZLjzQAnjqnDUPKJ8FiDTK9AaO4QlDd2BIpvdNICoKiUnUvBmBuSA1/S4Gt+QLpWQ
 WVcBkQ9Nu7OJTiVqw1TNHDSRWbhwbJxN4RZYiV89xPzSZaMtrMImobBlV1Bjyq3OCyEov3Y2xDj
 u8PYBGiCBLdWfRwYmLZZDMZVIDsXeoArCTWT3O55QOH1qlOFalSdIJy6jTqfOeNKhCP50ALdAIQ
 Kv+xNlH1KEbicytdSxhDHr0tzV1trHmmGZ7oU/6cTRFMMoc2Pq0OWNleUXbWGME3yDkG3SlgdZ4
 cSv+wKxXVGRHifEc1+89ju5fr2HRhTXe5cYMWEgr4BF8qjRz+VOh5Hv1DEstuOEH3jqRhIWUJ2G
 qMgQ0dKhZp6uOHqqETPtWrCaL1aly1JBq9Gj4q+NMAMCmcVuS1ttanxDufITVM
X-Received: by 2002:a05:600c:1d86:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-488997153c7mr29614715e9.4.1775206880920; 
 Fri, 03 Apr 2026 02:01:20 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm332528545e9.14.2026.04.03.02.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:01:20 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Relocate U-Boot in the last bank
Date: Fri,  3 Apr 2026 12:01:02 +0300
Message-ID: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

This is a different and cleaner approach for [1].

The main difference with the previous patches is that instead or retrofitting
the relocation code with the existing codebase, it's much easier to implement
if we just move the bi_dram[] from bd to gd.

Moving them to gd allows us to initialize the bank info really early, before we
setup and reserve memory for board info. This allows platforms to setup the
bank information in an independent way (DT parsing, DRAM scanning etc) before
we have to decide on the relocation address.

There was a discussion recently on the mailing lists regarding our
management of memory above ram_top [0]. The tl;dr is that we have two problems.

The first one is that U-Boot always relocates to the top of the first available
bank unless there's special board code to sidestep that. The second is we don't
successfully deal with devices that can only do 32-bit DMA.

This patch series deals with the first problem by adding a Kconfig option
allowing platforms to relocate to the top of the last discovered bank.

It's worth noting that this is easily testable with QEMU

qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
    -machine virt,secure=off \
    -bios u-boot.bin \
    -device virtio-rng-pci \
    -drive id=os,if=none,file="$image" \
    -device virtio-blk-device,drive=os \
    -object memory-backend-ram,id=ram0,size=4G \
    -object memory-backend-ram,id=ram1,size=4G \
    -numa node,memdev=ram0 \
    -numa node,memdev=ram1

# RELOCATE_LAST_BANK not set
Hit any key to stop autoboot: 0
=> bdinfo
[...]
relocaddr   = 0x000000013f66c000
reloc off   = 0x000000013f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x13d507000-0x13d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x13d50aff0-0x23fffffff], 0x102af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000013ffe0000
irq_sp      = 0x000000013e50aff0
sp start    = 0x000000013e50aff0
Early malloc usage: e88 / 2000
=>

# RELOCATE_LAST_BANK enabled

=> bdinfo
[...]
relocaddr   = 0x000000023f66c000
reloc off   = 0x000000023f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x23d507000-0x23d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x23d50aff0-0x23fffffff], 0x2af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000023ffe0000
irq_sp      = 0x000000023e50aff0
sp start    = 0x000000023e50aff0
Early malloc usage: e88 / 2000
=>

Patch #1 - The boilerplate code that moves bi_dram from bd to gd
Patch #2 - Moves the ram_base calculation in its own initcall
Patch #3 - Cleans up and prepares setup_dest_addr()
Patch #4 - Adds the Kconfig option and code to allow us to relocate in top
           memory banks

[1] https://lore.kernel.org/u-boot/20260331080117.2370092-1-ilias.apalodimas@linaro.org/

Ilias Apalodimas (4):
  treewide: move bi_dram[] from bd to gd
  common: move ram_base calculation to independent INITCALL()
  common: Clean up setup_dest_addr()
  common: Add an optionto relocate on ram top

 Kconfig                                       |   8 ++
 api/api_platform.c                            |   4 +-
 arch/arm/cpu/armv8/cache_v8.c                 |   6 +-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       | 116 +++++++++---------
 arch/arm/lib/bootm-fdt.c                      |   5 +-
 arch/arm/lib/bootm.c                          |   4 +-
 arch/arm/lib/cache-cp15.c                     |   7 +-
 arch/arm/lib/image.c                          |   2 +-
 arch/arm/mach-airoha/an7581/init.c            |   8 +-
 arch/arm/mach-apple/board.c                   |   4 +-
 arch/arm/mach-davinci/misc.c                  |   4 +-
 arch/arm/mach-imx/ele_ahab.c                  |   7 +-
 arch/arm/mach-imx/imx8/ahab.c                 |   7 +-
 arch/arm/mach-imx/imx8/cpu.c                  |  44 +++----
 arch/arm/mach-imx/imx8m/soc.c                 |  24 ++--
 arch/arm/mach-imx/imx8ulp/soc.c               |  20 +--
 arch/arm/mach-imx/imx9/scmi/soc.c             |  24 ++--
 arch/arm/mach-imx/imx9/soc.c                  |  24 ++--
 arch/arm/mach-imx/mx5/mx53_dram.c             |   8 +-
 arch/arm/mach-imx/spl.c                       |   4 +-
 arch/arm/mach-k3/k3-ddr.c                     |   4 +-
 arch/arm/mach-mediatek/mt7987/init.c          |   4 +-
 arch/arm/mach-mediatek/mt7988/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8183/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8188/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8365/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8512/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8516/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8518/init.c          |   4 +-
 arch/arm/mach-mvebu/alleycat5/cpu.c           |   4 +-
 arch/arm/mach-mvebu/armada3700/cpu.c          |  10 +-
 arch/arm/mach-mvebu/armada8k/dram.c           |  10 +-
 arch/arm/mach-mvebu/dram.c                    |   6 +-
 arch/arm/mach-omap2/am33xx/board.c            |   4 +-
 arch/arm/mach-omap2/omap-cache.c              |   5 +-
 arch/arm/mach-omap2/omap3/emif4.c             |   8 +-
 arch/arm/mach-omap2/omap3/sdrc.c              |   8 +-
 arch/arm/mach-owl/soc.c                       |   4 +-
 arch/arm/mach-renesas/memmap-gen3.c           |   8 +-
 arch/arm/mach-renesas/memmap-rzg2l.c          |   4 +-
 arch/arm/mach-rockchip/sdram.c                |  40 +++---
 arch/arm/mach-snapdragon/board.c              |  12 +-
 arch/arm/mach-socfpga/board.c                 |   5 +-
 arch/arm/mach-socfpga/misc_arria10.c          |   7 +-
 .../mach-stm32mp/cmd_stm32prog/stm32prog.c    |   4 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c          |   5 +-
 arch/arm/mach-tegra/board2.c                  |  14 +--
 arch/arm/mach-tegra/cboot.c                   |   4 +-
 arch/arm/mach-uniphier/dram_init.c            |   6 +-
 arch/arm/mach-uniphier/fdt-fixup.c            |   8 +-
 arch/arm/mach-versal-net/cpu.c                |   8 +-
 arch/arm/mach-versal/cpu.c                    |  16 +--
 arch/arm/mach-versal2/cpu.c                   |   8 +-
 arch/arm/mach-zynqmp/cpu.c                    |   8 +-
 arch/mips/mach-octeon/dram.c                  |   4 +-
 arch/riscv/cpu/k1/dram.c                      |  12 +-
 arch/sandbox/cpu/spl.c                        |   4 +-
 arch/x86/cpu/coreboot/sdram.c                 |   4 +-
 arch/x86/cpu/efi/payload.c                    |   4 +-
 arch/x86/cpu/efi/sdram.c                      |   4 +-
 arch/x86/cpu/intel_common/mrc.c               |   4 +-
 arch/x86/cpu/ivybridge/sdram_nop.c            |   4 +-
 arch/x86/cpu/qemu/dram.c                      |   8 +-
 arch/x86/cpu/quark/dram.c                     |   4 +-
 arch/x86/cpu/slimbootloader/sdram.c           |   4 +-
 arch/x86/cpu/tangier/sdram.c                  |   4 +-
 arch/x86/lib/bootm.c                          |   5 +-
 arch/x86/lib/fsp/fsp_dram.c                   |  18 +--
 board/CZ.NIC/turris_1x/turris_1x.c            |  42 +++----
 board/armltd/corstone1000/corstone1000.c      |   4 +-
 board/armltd/integrator/integrator.c          |   4 +-
 board/armltd/total_compute/total_compute.c    |   6 +-
 board/armltd/vexpress/vexpress_common.c       |   8 +-
 board/atmel/common/video_display.c            |   2 +-
 .../sam9x60_curiosity/sam9x60_curiosity.c     |   2 +-
 .../sam9x75_curiosity/sam9x75_curiosity.c     |   2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |   2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |   2 +-
 .../sama5d29_curiosity/sama5d29_curiosity.c   |   2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |   2 +-
 .../sama7d65_curiosity/sama7d65_curiosity.c   |   2 +-
 .../sama7g54_curiosity/sama7g54_curiosity.c   |   2 +-
 board/broadcom/bcmns3/ns3.c                   |   4 +-
 board/compulab/cm_fx6/cm_fx6.c                |  28 ++---
 board/elgin/elgin_rv1108/elgin_rv1108.c       |   4 +-
 board/esd/meesc/meesc.c                       |   4 +-
 board/friendlyarm/nanopi2/board.c             |  10 +-
 board/ge/mx53ppd/mx53ppd.c                    |   8 +-
 board/hisilicon/hikey/hikey.c                 |  24 ++--
 board/hisilicon/hikey960/hikey960.c           |   4 +-
 board/hisilicon/poplar/poplar.c               |   4 +-
 board/k+p/kp_imx53/kp_imx53.c                 |   4 +-
 board/keymile/pg-wcom-ls102xa/ddr.c           |   4 +-
 board/kontron/sl28/sl28.c                     |   4 +-
 board/kontron/sl28/spl_atf.c                  |   6 +-
 board/liebherr/btt/btt.c                      |   2 +-
 board/menlo/m53menlo/m53menlo.c               |   8 +-
 board/nuvoton/arbel_evb/arbel_evb.c           |  26 ++--
 board/nxp/imxrt1020-evk/imxrt1020-evk.c       |   2 +-
 board/nxp/imxrt1050-evk/imxrt1050-evk.c       |   2 +-
 board/nxp/imxrt1170-evk/imxrt1170-evk.c       |   2 +-
 board/nxp/ls1021aqds/ddr.c                    |   4 +-
 board/nxp/ls1028a/ls1028a.c                   |  10 +-
 board/nxp/ls1043aqds/ls1043aqds.c             |   8 +-
 board/nxp/ls1043ardb/ls1043ardb.c             |   8 +-
 board/nxp/ls1046afrwy/ls1046afrwy.c           |   8 +-
 board/nxp/ls1046aqds/ls1046aqds.c             |   8 +-
 board/nxp/ls1046ardb/ls1046ardb.c             |   8 +-
 board/nxp/ls1088a/ls1088a.c                   |   6 +-
 board/nxp/ls2080aqds/ls2080aqds.c             |  14 +--
 board/nxp/ls2080ardb/ls2080ardb.c             |  14 +--
 board/nxp/lx2160a/lx2160a.c                   |   6 +-
 board/phytec/phycore_am62x/phycore-am62x.c    |  26 ++--
 board/phytec/phycore_am64x/phycore-am64x.c    |  18 +--
 board/phytium/durian/durian.c                 |   4 +-
 board/phytium/pe2201/pe2201.c                 |   4 +-
 board/raspberrypi/rpi/rpi.c                   |   4 +-
 board/renesas/common/rcar64-common.c          |   6 +-
 board/renesas/genmai/genmai.c                 |   4 +-
 board/renesas/sparrowhawk/sparrowhawk.c       |   8 +-
 board/ronetix/pm9261/pm9261.c                 |   4 +-
 board/ronetix/pm9263/pm9263.c                 |   4 +-
 board/ronetix/pm9g45/pm9g45.c                 |   4 +-
 board/samsung/arndale/arndale.c               |   4 +-
 board/samsung/common/board.c                  |   6 +-
 board/samsung/exynos-mobile/exynos-mobile.c   |   4 +-
 board/samsung/goni/goni.c                     |  12 +-
 board/samsung/smdkc100/smdkc100.c             |   4 +-
 board/samsung/smdkv310/smdkv310.c             |  16 +--
 board/siemens/iot2050/board.c                 |  16 +--
 board/socionext/developerbox/developerbox.c   |   6 +-
 board/st/stih410-b2260/board.c                |   4 +-
 board/ste/stemmy/stemmy.c                     |   4 +-
 board/ti/dra7xx/evm.c                         |   8 +-
 board/ti/ks2_evm/board.c                      |   4 +-
 board/toradex/colibri_imx7/colibri_imx7.c     |   8 +-
 board/toradex/verdin-am62/verdin-am62.c       |   2 +-
 board/toradex/verdin-am62p/verdin-am62p.c     |   2 +-
 board/traverse/ten64/ten64.c                  |   6 +-
 board/xilinx/zynq/cmds.c                      |   6 +-
 board/xilinx/zynqmp/zynqmp.c                  |   6 +-
 boot/image-board.c                            |   2 +-
 boot/image-fdt.c                              |   4 +-
 cmd/bdinfo.c                                  |   6 +-
 cmd/ti/ddr4.c                                 |   8 +-
 cmd/ufetch.c                                  |   4 +-
 common/board_f.c                              |  57 ++++++---
 common/init/handoff.c                         |  10 +-
 drivers/bootcount/bootcount_ram.c             |   4 +-
 drivers/ddr/altera/sdram_agilex.c             |   4 +-
 drivers/ddr/altera/sdram_agilex5.c            |  18 +--
 drivers/ddr/altera/sdram_agilex7m.c           |   4 +-
 drivers/ddr/altera/sdram_n5x.c                |   4 +-
 drivers/ddr/altera/sdram_s10.c                |   4 +-
 drivers/ddr/altera/sdram_soc64.c              |  28 ++---
 drivers/mmc/mvebu_mmc.c                       |   4 +-
 drivers/net/mvgbe.c                           |   4 +-
 drivers/pci/pci-uclass.c                      |   8 +-
 drivers/usb/host/ehci-marvell.c               |   4 +-
 drivers/video/meson/meson_vpu.c               |   8 +-
 drivers/video/sunxi/sunxi_de2.c               |   2 +-
 drivers/video/sunxi/sunxi_display.c           |   2 +-
 include/asm-generic/global_data.h             |   7 ++
 include/asm-generic/u-boot.h                  |   4 -
 include/configs/m53menlo.h                    |   4 +-
 include/configs/mx53cx9020.h                  |   4 +-
 include/configs/mx53loco.h                    |   4 +-
 include/configs/mx53ppd.h                     |   4 +-
 include/fdtdec.h                              |   7 +-
 include/init.h                                |   2 +-
 lib/fdtdec.c                                  |  23 ++--
 lib/lmb.c                                     |  19 ++-
 test/cmd/bdinfo.c                             |   7 +-
 173 files changed, 749 insertions(+), 720 deletions(-)

--
2.53.0

