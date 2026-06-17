Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84E0CD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3299384704;
	Wed, 17 Jun 2026 09:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CVMrWjR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9BC84895; Wed, 17 Jun 2026 09:49:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4962838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso28741995e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682555; x=1782287355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8iSr+lBlfXUaAu7cJpjQugCOHCdYMfBXTxMP+0KLApM=;
 b=CVMrWjR2BeTMVVujYp3v5Bi0pEmJpfoxGShVoVFywqophuXPoYlofAWRfXQZJhO+Go
 BJmrzw5TFBmgV/AtMVRp48CEc24adUVPpVXpI7I5zrpb28LpiCD6PbZkuXGOaBlKMNZd
 /CbwIeY8NiecYwUEEGWRo2s5WK3euXOJdM3gWPJai9O+Pndzs8b4fqENFxzkirLWafGn
 Kgg7fWnUNw5IX6qpYyPNagR07Si+HdEpH0Dksgje2Ot7BzORTh56sAvK0BgAKjlA0kgp
 Xl8rvfXVQxhlM53GqMEUFmSlhocqLC9p8U73znqvFjPIRDr/X47+/bUCrmwjz5Eo4Sq8
 bTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682555; x=1782287355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iSr+lBlfXUaAu7cJpjQugCOHCdYMfBXTxMP+0KLApM=;
 b=cMJkZ95/+Mw42/FrzJHJbzRr5+aW/r8gwqJ6idq9TQNuo5LM+9+fG7VmDEuIZWTYL+
 xGyum/uIV0mZwXrtb5QMFICHtXJ3O2VxLGgFsL6eV5vGMCzhCJw4xTcOEY1+iA3NHwsk
 8q7XWVfipO2o/l3jHOB0EOAcT4u+8jASPlE6RmW+bUFRxV6P7D2V9Jkp12vfs9lLQ9Vm
 lHtbrpp5Sot0hTokLvA7FuKofrNM8noolRDwTz2919gp3cQPjnTPE8Ln8lzaA4AW3LlP
 4iUzQ3bgAvY7cIOmMPOv81Be9u8zv7Fx6Ke1Bf0lWRvU9p0eDBxsHTCLXIcEMU43iAS0
 K65A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MT/rxhFKoaUzmXg87Q6u1fNc4Q/h87cKCTVOwP6z2GkbHvXgtxtQs7k67P6pOUzWxg05WxQg=@lists.denx.de
X-Gm-Message-State: AOJu0YzdnG/uVLkhSn09/yoy4dlTICHXHMY4CcVCqMt+3wuIcTEYoIkp
 4rjKy+a0s2SDrBZuOMeOkvu5aipaHYuGUIVotnryKi3cVvX4eFHMKFiJFKud+H9yA3o=
X-Gm-Gg: Acq92OEUduLEX+947OaVkbQ4l4Ai59if7wVpCeMezqH8Y8pCUDTUuaGHfLqfdr+JPKF
 +VDSDeLZ6hanN8t85Fzq6cJIpUmF2lrTuACZcPDpi32da9EuCnXAqKrjvIE4cEa0HHaVzqzSoOU
 WO2agtg/l35jsvITvYmyIEH6NKLzdWuuFuDdK2AC0kkOoC48eaq021rsgFrBW5N/8y2+FOIYeUO
 2ZsQ4kCRhdNQh6Oq9opZHChkFSD72UAKR968tZqnw4PphfC50FWPXBLUndY593qDid9CsjR8EIv
 iKfThI38sQX7ozV7OTxHSwG4ZIswKG8tsKsHa4IA+9Tm0By/80doKKtbAavOGGCWv52H5P+Iq3S
 vdrpZ/APiVTmevCfNNvQ+KFb4YtH0dogl42ehznUzsfHJh5x/GAcTd/Jz0fWYoRYIPbEuTPegDI
 r0LJH8vp2v6C0LsMVtdWhWMvlNy7I2T6yqY8rkr1VjCSfbimD0kxdSUc2+e8AZng1MorMbKXo24
 8uo/pvrSy+Y0/nfJeeGyxD2XcTV/w0nXvsbbD9zKMHoM67Td87UHJ/acokPBrTGGeHF+sF0Mdb8
 s8KzSxtnbNylWxBPhWjlU+OYn0W6oF+P8N0lvQn1zQ8xSEg5oRJRPdKMvQ40wQ804P/ddvJoxPA
 bFO95qpwLDYNFXC2WnFw0wHx/CLmAxJibA9GYPhKT8E8wDi65Q3ePaPm/61xSn67owLYj3jbLqZ
 JV5J28BpGVZ+ckdKF7/kNGBczu2ioBPLpyY5o4f8pSYjy2dRDeopMJcCdavu8KJVtOKh3n4EPGq
 fXBa1X4bf0EaDE8OA==
X-Received: by 2002:a05:600c:a142:b0:490:b8d3:5dcc with SMTP id
 5b1f17b1804b1-492333ca3b7mr36426035e9.19.1781682555132; 
 Wed, 17 Jun 2026 00:49:15 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:14 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v7 0/7] Relocate U-Boot in the last bank
Date: Wed, 17 Jun 2026 10:48:18 +0300
Message-ID: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Hi all, this is v7 of [1][2][3][4][5][6]!

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

# RELOC_ADDR_TOP not set
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

# RELOC_ADDR_TOP enabled

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

[1] https://lore.kernel.org/u-boot/20260403090109.3564638-1-ilias.apalodimas@linaro.org/
[2] https://lore.kernel.org/u-boot/CAC_iWj+JmwW6gDmUf76OX0WiW+RQy-DA2STs+ROHH-i0AbGJ2A@mail.gmail.com/T/#t
[3] https://lore.kernel.org/u-boot/20260427100832.581887-1-ilias.apalodimas@linaro.org/
[4] https://lore.kernel.org/u-boot/20260515135245.45067-1-ilias.apalodimas@linaro.org/
[5] https://lore.kernel.org/u-boot/20260604073719.48723-1-ilias.apalodimas@linaro.org/
[6] https://lore.kernel.org/u-boot/20260609131611.46399-1-ilias.apalodimas@linaro.org/

Marek, I've kept your r-b on patch #5 since the changes seem minor and won't
affect anything for now

Changes since v6:
- Mention QEMU on patch #6
- Remove redundant depends on EXPERT
- Rebase on top of -next

Changes since v5:
- Call board_get_usable_ram_top() with mon_len until we decide what's best
  for the common code (mon_len is what we used up to now)
- Address some comments from Simon on the documentation
- Reduce ram_top as well as ram_size when CONFIG_SYS_MEM_TOP_HIDE is defined

Changes since v4:
- Use CONFIG_VAL instead of IS_ENABLED for SYS_MEM_TOP_HIDE
- Fix RPi4 hang

Changes since v3:
- Use (aligned) gd->mon_len for the get_mem_top() size argument instead of 0.
  Using !0 will properly factor in reserved regions before calculating the
  reloc address
- Call board_get_usable_ram_top() regardless of the config option so
  boards can tweak the address eventually
- Don't rely on the fact that banks are populated in ascending order
- Updated the Kconfig description wrt 32-bit boundaries
- Fixed array comment in include/init.h
- Don't carry Marek's patches. We can resend those once we have actual users

Changes since v2:
- Rename bi_dram to dram apart from moving it to gd
- Adjusted a Kconfig description and a commit message on patch #6
- Use get_mem_top() instead of calculating the top address adding the
  dram bank info. That function will account for the reserved memory regions
  and exclude them
- Collected Tested/Reviewed-by tags

Changes since v1:
- Rebased and added Marek's cleanup patches
- Remove the ifdefery on patch #6 in favor of 'if (CONFIG_IS_ENABLED)'
- Added a warning on the Kconfig message about breaking devices that
  can't DMA to high memory
- Added depends on EXPERT for relocatiing to the last bank
- Using %llx instead of %llX on debug prints
- Removed 2 remaining comments of bd->bi_dram[]
- Collected Tested/Reviewed-by tags

Ilias Apalodimas (7):
  treewide: move bi_dram[] from bd to gd
  common: move ram_base calculation to independent INITCALL()
  common: Clean up setup_dest_addr()
  rpi: Add a local get_effective_memsize()
  common: Add an option to relocate on ram top
  configs: Enable RELOC_ADDR_TOP on arm64 QEMU
  doc: Add a warning about using RELOC_ADDR_TOP

 Kconfig                                       |  13 ++
 api/api_platform.c                            |   4 +-
 arch/arm/cpu/armv8/cache_v8.c                 |   6 +-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       | 118 +++++++++---------
 arch/arm/lib/bootm-fdt.c                      |   5 +-
 arch/arm/lib/bootm.c                          |   4 +-
 arch/arm/lib/cache-cp15.c                     |   9 +-
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
 arch/arm/mach-rockchip/rk3588/rk3588.c        |   8 +-
 arch/arm/mach-rockchip/sdram.c                |  42 +++----
 arch/arm/mach-snapdragon/board.c              |  16 +--
 arch/arm/mach-socfpga/board.c                 |   5 +-
 arch/arm/mach-socfpga/misc_arria10.c          |   7 +-
 .../mach-stm32mp/cmd_stm32prog/stm32prog.c    |   4 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c          |   7 +-
 arch/arm/mach-tegra/board2.c                  |  14 +--
 arch/arm/mach-tegra/cboot.c                   |   4 +-
 arch/arm/mach-uniphier/dram_init.c            |   6 +-
 arch/arm/mach-uniphier/fdt-fixup.c            |   8 +-
 arch/arm/mach-versal-net/cpu.c                |   8 +-
 arch/arm/mach-versal/cpu.c                    |  16 +--
 arch/arm/mach-versal2/cpu.c                   |   7 +-
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
 board/axiado/scm3005/scm3005.c                |   4 +-
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
 board/raspberrypi/rpi/rpi.c                   |  12 +-
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
 board/xilinx/zynqmp/zynqmp.c                  |   4 +-
 boot/image-board.c                            |   2 +-
 boot/image-fdt.c                              |   4 +-
 cmd/bdinfo.c                                  |  12 +-
 cmd/ti/ddr4.c                                 |   8 +-
 cmd/ufetch.c                                  |   4 +-
 common/board_f.c                              |  71 ++++++++---
 common/init/handoff.c                         |  10 +-
 configs/qemu_arm64_defconfig                  |   1 +
 doc/develop/memory.rst                        |   9 ++
 drivers/bootcount/bootcount_ram.c             |   4 +-
 drivers/ddr/altera/sdram_agilex.c             |   4 +-
 drivers/ddr/altera/sdram_agilex5.c            |  18 +--
 drivers/ddr/altera/sdram_agilex7m.c           |   4 +-
 drivers/ddr/altera/sdram_arria10.c            |  12 +-
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
 170 files changed, 785 insertions(+), 728 deletions(-)

--
2.43.0

