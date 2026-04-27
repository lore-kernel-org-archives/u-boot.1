Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C11EFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5AA83AA9;
	Mon, 27 Apr 2026 12:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bY/KItBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1210D83C14; Mon, 27 Apr 2026 12:08:50 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852D380433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a2c500750dso11106593e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284525; x=1777889325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eNwUZuUcYNDQ+Hh2uq7Fkj4yiP5impddhm8kXjJLGzc=;
 b=bY/KItBk/4oPYAgv6uG7qDl/UWt0GR4y3hgGMbVVqCVDvoxo081Zi8BKe1K95GOGEC
 ZLFu9YHhimN4mDLk//V5JP4Y+MgQy28PiWZLGAzCjdKp44Kd+BQA+30yHttHH6n8UluG
 T7ud+3x6qmQK1JvdALt7isgfYoIQwLVBlFxS+1CCMB8Rdir7VKdpaPJ7fHTORblAC56k
 uzEGau1zTzypsbXy2+3rP00k1E7AWPSq3yfwY6rBwOfTKdOaBqzT4MAL3DeJoMF1v9A5
 59BqjKnwIAuWw443BWhzwjDYdKtprGDjDzAkDjznLzz7PRNu7G4ihhe3EZM7bsQLqrmJ
 XroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284525; x=1777889325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNwUZuUcYNDQ+Hh2uq7Fkj4yiP5impddhm8kXjJLGzc=;
 b=RbCP9DNUJYCmXDTgEYi6hrzBgyAZcWIqVLUz33a0GTRvYFxaFY5PBf5nWBOm1z0EVk
 1Rm1qAHsYQsafqaOi582R6f+o/WR+JjT1T8eGpMLsndCznboHTK7/cFwIiOuJda9kOi7
 XLvrrbn/bMWyq1lsaVB3Xq6K3KxMO3rgIbQrNy4OSV6aevLyu2KKFgYhr6yA3kMRFAm4
 ZtId3CPfn0PwB31lS40o1SXbig81cZLHLmhG0z7kQPFLDPOgU9QzKjBWzVVL4+1TtKR1
 GbwsHFai4kVp5/1YO4ZzcO/ViFrhlX7OoLaRU7ftod/V+1KGA2ivBmyArqBVd9+dDjv7
 k6xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VI7HqzjqVXxPPnE1dk++zPScKeF+ctMm1KG7RVi8SQN20+XA012mC6JG/lp8xFHteJZ7l8CE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxlidqvz+a5GwkUbMEqCcs34Np7lGmM76MQT8BddRhL0Wn769ri
 RCOCsoggW+kiAy1NARRL56YoowgeSFrmQQohuqBfMC5VHmUG0CJfPYWyKTZpfvkuqAc=
X-Gm-Gg: AeBDiesEQdoLZvCAiqmUEalz1+x+mQSFj1hQVqazy/mAzXXVsZJr04+UwXrqi/nvAZC
 UMaM07NtXlfwAG2vL+X/3cagevgB5olBLS7XaH3WbTGlL7ChV7QBaIt66gPAJibYXolOYXpXrsn
 G9B+XOTLEieIZtG4lyFnUt4s5Tz6XT6wcfhQPbD3H/dMqQQTtSKu5xI9taQZ8ZYW8kC7y3xO2jX
 NQJw1TpAhRx+1w7osM6x7hAJzTe+UKEsNg2Cf/EUfEJrwDbonthUumfPpRUHxuM3e7iPIsoXvDu
 q747VaP8TLfQwPzDeSrtQUfulmWtwM5KFm4hrcfiwK7qtoW76EctOe+Ofa4v15adf/D6Wf11Nu9
 kX7JMHkh80qSefCQC+sh9pa5FFsdGub/H9LhKWtEUxE8b1xRT+XvNbna7snfFUfYRIeJfA7UtHI
 hM/WkY/BYxoZBSBBmiNubl+W8iNSBd94KpiU1c17ycnLHrgMNOAuPqDop88HwSERY9hyS6qi928
 fC32jnBxxXVkJYZjU2dYOAYERQaKWVA5FlSKdYUZNWjfdzCnOdlbZmt5SW9XMA0rI94p/qLVU5D
 xQs60dKyMoXQQ9Mt5RrZjNS1aJOOOKojqynRi96ou7KBda5oXGFGPlhU6PZwWm9TsbbxADFdKCo
 +LVMczeDGBQW4R6rt2ci4vPp7VNMAbfyqyslVdJtyrWl5dq6ch9MGDdJ7Ia2VR2bM+YjyMdzdaC
 Ginvo3UXe7XtJjXC8SWv50qyUvMnptuif75cOarFNQo7sjbwcFGevuQwKH4sVepjvr3K362XtnN
 DICQ25VdUUnQQxAG+zqaO5A8RvFhmSmf9ZN
X-Received: by 2002:a05:6512:124f:b0:5a4:79e:9669 with SMTP id
 2adb3069b0e04-5a4172da134mr12258687e87.21.1777284524990; 
 Mon, 27 Apr 2026 03:08:44 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:44 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 0/6] Relocate U-Boot in the last bank
Date: Mon, 27 Apr 2026 13:08:21 +0300
Message-ID: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
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

Hi This is v3 of [1][2]!

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

Patch #1 - Clean up from Marek
Patch #2 - Introduce fdtdec_setup_mem_ram_top() from Marek
Patch #3 - The boilerplate code that moves bi_dram from bd to gd
Patch #4 - Moves the ram_base calculation in its own initcall
Patch #5 - Cleans up and prepares setup_dest_addr()
Patch #6 - Adds the Kconfig option and code to allow us to relocate in top
           memory banks

[1] https://lore.kernel.org/u-boot/20260403090109.3564638-1-ilias.apalodimas@linaro.org/
[2] https://lore.kernel.org/u-boot/CAC_iWj+JmwW6gDmUf76OX0WiW+RQy-DA2STs+ROHH-i0AbGJ2A@mail.gmail.com/T/#t

Changes since v2:
- Rename bi_dram to dram apart from moving it to gd
- Adjusted a Kconfig description and a commit message on patch #6
- Use get_mem_top() instead of calculating the top address adding the
  dram bank info. That function will account for the reserved memory regions
  and exclude them
- Collected Tested/Reviewed-by tags
- Removed Anshul's r-b from patch #6 since it changed a bit

Changes since v1:
- Rebased and added Marek's cleanup patches
- Remove the ifdefery on patch #6 in favor of 'if (CONFIG_IS_ENABLED)'
- Added a warning on the Kconfig message about breaking devices that
  can't DMA to high memory
- Added depends on EXPERT for relocatiing to the last bank
- Using %llx instead of %llX on debug prints
- Removed 2 remaining comments of bd->bi_dram[]
- Collected Tested/Reviewed-by tags

Ilias Apalodimas (4):
  treewide: move bi_dram[] from bd to gd
  common: move ram_base calculation to independent INITCALL()
  common: Clean up setup_dest_addr()
  common: Add an option to relocate on ram top

Marek Vasut (2):
  fdtdec: Deduplicate iterator function
  fdtdec: Introduce fdtdec_setup_mem_ram_top() to determine end of
    topmost DRAM bank

 Kconfig                                       |  12 ++
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
 cmd/bdinfo.c                                  |  12 +-
 cmd/ti/ddr4.c                                 |   8 +-
 cmd/ufetch.c                                  |   4 +-
 common/board_f.c                              |  72 ++++++++---
 common/init/handoff.c                         |  10 +-
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
 include/fdtdec.h                              |  23 +++-
 include/init.h                                |   2 +-
 lib/fdtdec.c                                  | 102 +++++++--------
 lib/lmb.c                                     |  13 +-
 test/cmd/bdinfo.c                             |   7 +-
 167 files changed, 818 insertions(+), 764 deletions(-)

--
2.53.0

