Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D4E7E34F
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36ACE84101;
	Fri,  3 Apr 2026 11:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qt7Hoh4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C12840B0; Fri,  3 Apr 2026 11:01:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A7584099
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486ff201041so16452255e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775206885; x=1775811685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3prXxKafKY2Mh8Z9LXE8neePiaArtj1uXYWpuI7wZL8=;
 b=qt7Hoh4jXygdBqhfbLbpP3eAKVE3BdCQ40mdVkBv1fWS1olTyJ43npzJ7X0BAzOdZs
 DekkXmP4Tt9fxRa1c9Ojq7lrz7nlX3MS9yk3psX/ewhqhFArvtGYPo8Uop4XnUynXOHS
 Pgqpy3jvwWA1I/w1e269d9+mk9YYFkCR2prRXX77ltsRTWlrCSl4LC4Shk642X89D292
 FcI8Gwm0CwgG38COm7B6yrDiTwOPiH7GsrVYu+ITn5vva8xzv0YBSX4BdSaKfXXRFv5N
 eOrdizhiafExbvKOhhmG5pLuKQTVzFn/nit+0ossxS5XO4GRvpozFZCbhRC2xbDY23SN
 585g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775206885; x=1775811685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3prXxKafKY2Mh8Z9LXE8neePiaArtj1uXYWpuI7wZL8=;
 b=FIHFwLCzRdudoVPpKIpW8lv9qZzGKgSf3/Z/g6WpASo78eZ2UYb9JCx1966fjYzLTG
 1/vt+Llk3USJVMEw/KTNkxy2AZy6i04nw/m1+eQsC7jzyn2O04f0tV6gJVCgGXNu2lgr
 L6/I1mCah1BLrTLoKCIofi2TfkOInBVAGiE/JaTziZQ7ivku9xP4C6QO+H30WXmuqhsk
 ufBfgOWSmDZiezxTuCoeXixT8idtp7tHKJ4WesD0N4dlc8j8Dr+ur1jUsHEwMhT4u3Mc
 b+Q3fbju/Vg4MoLWJE8s0mSUp6nW8zd14F/iMGVryMfQpG7zMGKw+UnU/nexGXp9C5zr
 OMNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCAY3evOhf+tEhA9s/9HMSLNZT5CGzuddu3+sFn8rEHCb3yFVz11WLBuoYpzc54JWDrr6br5k=@lists.denx.de
X-Gm-Message-State: AOJu0YyENbKX8i1ZtDBlBURxv7DruM0N2TSvMc4m0SUk9UC8bhHCLWSV
 nGM7nGrF3GaNAXVQPCBx/BDm9tRgEF16780i7t4jbIgCANWMzCMduOxXtrsQx727npo=
X-Gm-Gg: ATEYQzxnNpyuuqP+nUkw9qyFwCvE9J2QzYaRMqUhM5b4oiCXnbZpHNwWNElc2pY5X0O
 W1HVeRTytF7A3okCymZ21kFCwLFVM5demG5uzSC1H20QVmrv1PHdoi2ggor1JFUwtgnswkp5w2o
 fmXOj0NfyjgPDC+uKqjNMYUyOuQ3+WO6Y50PpUhMEkTOkTM9ztqRQTcObygCu77ukt1bNXp8pT4
 kUqyaURz5/K3Qr8jdHQJBhi15s0gB9Wwdd8Yge2CbSs+kB18DeZWzdNqmH7DDlrHFL2uLkHTdEZ
 cxt6B1tIQYuVtJSMwP9OV3Wl870RFARNjlMtALfTzG3bflnk/MSaZcAJkIYk+4onncF2fCyFOxA
 /B20Jupqx8aYVQ3f9kUMQTomF70wj0PIJoQgxx6lZkrkNmkXTnMpDwysqoZQcpAnattfoMI5vFB
 qnxqm2Hhdp0iaolQA4obmuZmNSfBshRtWLnfkePT++q6RjV3HTt35tjWg2o8G+gMituVa6Fm+kw
 ISqP1YDNEZ7wABIgE5LXJvTDWZQ/PyJId81gIAFr309THqG+0W3hzR0j2aGxFsr9OgGFDpDzddo
 nVrWH0gMArry97q8kXd1A2HM5vtD/ikFFYKU0t5CmyHQWQQLXwhRj1oFFNAlvCU/vNPD9gppqq+
 YWySJ49avoWgm7EQe6P4eJ7Al07ZlXhG2pHyPTYKP6GGaL9gW/VueMmbZmrxTtidKbpVULJXt+U
 GvNvNreA4yj9nuMht2AruoAzx1zX838m5QiAyPu2H/7j7gr/TmCdjQfp3vr9HY
X-Received: by 2002:a05:600c:3b23:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488996ecd50mr32190835e9.10.1775206883290; 
 Fri, 03 Apr 2026 02:01:23 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm332528545e9.14.2026.04.03.02.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:01:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/4] treewide: move bi_dram[] from bd to gd
Date: Fri,  3 Apr 2026 12:01:03 +0300
Message-ID: <20260403090109.3564638-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
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

Currently, the bi_dram[] information is stored in the board info
structure (bd). Because bd is only valid after reserve_board(),
dram_init_banksize() must be called late in the initialization process.
This limitation is problematic, as it forces us to rely on a variety of
bespoke functions to determine board RAM, bank memory sizes, and other
early setup requirements.

By moving bi_dram[] into the global data (gd), we can run it earlier.
This is particularly convenient since boards define their own
dram_init_banksize() routines, which do not always rely on parsing
Device Tree (DT) memory nodes.

Additionally, U-Boot defaults to relocating to the top of the first memory
bank. While boards currently use custom functions to override this
behavior, having the DRAM bank information available earlier in gd makes
relocating to a different bank trivial and standardizes the process.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
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
 common/board_f.c                              |  10 +-
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
 172 files changed, 704 insertions(+), 710 deletions(-)

diff --git a/api/api_platform.c b/api/api_platform.c
index d5cbcd6e2010..32f89e98d9da 100644
--- a/api/api_platform.c
+++ b/api/api_platform.c
@@ -21,8 +21,8 @@ int platform_sys_info(struct sys_info *si)
 	si->clk_cpu = gd->cpu_clk;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		platform_set_mr(si, gd->bd->bi_dram[i].start,
-				gd->bd->bi_dram[i].size, MR_ATTR_DRAM);
+		platform_set_mr(si, gd->bi_dram[i].start,
+				gd->bi_dram[i].size, MR_ATTR_DRAM);
 
 	platform_set_mr(si, gd->ram_base, gd->ram_size, MR_ATTR_DRAM);
 	platform_set_mr(si, gd->bd->bi_flashstart, gd->bd->bi_flashsize, MR_ATTR_FLASH);
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21f..63e95408212b 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -69,9 +69,9 @@ int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
 	}
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		mem_map[index].virt = gd->bd->bi_dram[i].start;
-		mem_map[index].phys = gd->bd->bi_dram[i].start;
-		mem_map[index].size = gd->bd->bi_dram[i].size;
+		mem_map[index].virt = gd->bi_dram[i].start;
+		mem_map[index].phys = gd->bi_dram[i].start;
+		mem_map[index].size = gd->bi_dram[i].size;
 		mem_map[index].attrs = attrs;
 		index++;
 	}
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index cfbaa475701a..d598d05db7cf 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -538,16 +538,16 @@ static inline void final_mmu_setup(void)
 		 */
 		switch (final_map[index].virt) {
 		case CFG_SYS_FSL_DRAM_BASE1:
-			final_map[index].virt = gd->bd->bi_dram[0].start;
-			final_map[index].phys = gd->bd->bi_dram[0].start;
-			final_map[index].size = gd->bd->bi_dram[0].size;
+			final_map[index].virt = gd->bi_dram[0].start;
+			final_map[index].phys = gd->bi_dram[0].start;
+			final_map[index].size = gd->bi_dram[0].size;
 			break;
 #ifdef CFG_SYS_FSL_DRAM_BASE2
 		case CFG_SYS_FSL_DRAM_BASE2:
 #if (CONFIG_NR_DRAM_BANKS >= 2)
-			final_map[index].virt = gd->bd->bi_dram[1].start;
-			final_map[index].phys = gd->bd->bi_dram[1].start;
-			final_map[index].size = gd->bd->bi_dram[1].size;
+			final_map[index].virt = gd->bi_dram[1].start;
+			final_map[index].phys = gd->bi_dram[1].start;
+			final_map[index].size = gd->bi_dram[1].size;
 #else
 			final_map[index].size = 0;
 #endif
@@ -556,9 +556,9 @@ static inline void final_mmu_setup(void)
 #ifdef CFG_SYS_FSL_DRAM_BASE3
 		case CFG_SYS_FSL_DRAM_BASE3:
 #if (CONFIG_NR_DRAM_BANKS >= 3)
-			final_map[index].virt = gd->bd->bi_dram[2].start;
-			final_map[index].phys = gd->bd->bi_dram[2].start;
-			final_map[index].size = gd->bd->bi_dram[2].size;
+			final_map[index].virt = gd->bi_dram[2].start;
+			final_map[index].phys = gd->bi_dram[2].start;
+			final_map[index].size = gd->bi_dram[2].size;
 #else
 			final_map[index].size = 0;
 #endif
@@ -1371,10 +1371,10 @@ static int tfa_dram_init_banksize(void)
 		}
 
 		debug("bank[%d]: start %lx, size %lx\n", i, res.a1, res.a2);
-		gd->bd->bi_dram[i].start = res.a1;
-		gd->bd->bi_dram[i].size = res.a2;
+		gd->bi_dram[i].start = res.a1;
+		gd->bi_dram[i].size = res.a2;
 
-		dram_size -= gd->bd->bi_dram[i].size;
+		dram_size -= gd->bi_dram[i].size;
 
 		i++;
 	} while (dram_size);
@@ -1385,24 +1385,24 @@ static int tfa_dram_init_banksize(void)
 #if defined(CONFIG_RESV_RAM) && !defined(CONFIG_XPL_BUILD)
 	/* Assign memory for MC */
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
-	if (gd->bd->bi_dram[2].size >=
-	    board_reserve_ram_top(gd->bd->bi_dram[2].size)) {
-		gd->arch.resv_ram = gd->bd->bi_dram[2].start +
-			    gd->bd->bi_dram[2].size -
-			    board_reserve_ram_top(gd->bd->bi_dram[2].size);
+	if (gd->bi_dram[2].size >=
+	    board_reserve_ram_top(gd->bi_dram[2].size)) {
+		gd->arch.resv_ram = gd->bi_dram[2].start +
+			    gd->bi_dram[2].size -
+			    board_reserve_ram_top(gd->bi_dram[2].size);
 	} else
 #endif
 	{
-		if (gd->bd->bi_dram[1].size >=
-		    board_reserve_ram_top(gd->bd->bi_dram[1].size)) {
-			gd->arch.resv_ram = gd->bd->bi_dram[1].start +
-				gd->bd->bi_dram[1].size -
-				board_reserve_ram_top(gd->bd->bi_dram[1].size);
-		} else if (gd->bd->bi_dram[0].size >
-			   board_reserve_ram_top(gd->bd->bi_dram[0].size)) {
-			gd->arch.resv_ram = gd->bd->bi_dram[0].start +
-				gd->bd->bi_dram[0].size -
-				board_reserve_ram_top(gd->bd->bi_dram[0].size);
+		if (gd->bi_dram[1].size >=
+		    board_reserve_ram_top(gd->bi_dram[1].size)) {
+			gd->arch.resv_ram = gd->bi_dram[1].start +
+				gd->bi_dram[1].size -
+				board_reserve_ram_top(gd->bi_dram[1].size);
+		} else if (gd->bi_dram[0].size >
+			   board_reserve_ram_top(gd->bi_dram[0].size)) {
+			gd->arch.resv_ram = gd->bi_dram[0].start +
+				gd->bi_dram[0].size -
+				board_reserve_ram_top(gd->bi_dram[0].size);
 		}
 	}
 #endif	/* CONFIG_RESV_RAM */
@@ -1439,30 +1439,30 @@ int dram_init_banksize(void)
 	}
 #endif
 
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 	if (gd->ram_size > CFG_SYS_DDR_BLOCK1_SIZE) {
-		gd->bd->bi_dram[0].size = CFG_SYS_DDR_BLOCK1_SIZE;
-		gd->bd->bi_dram[1].start = CFG_SYS_DDR_BLOCK2_BASE;
-		gd->bd->bi_dram[1].size = gd->ram_size -
+		gd->bi_dram[0].size = CFG_SYS_DDR_BLOCK1_SIZE;
+		gd->bi_dram[1].start = CFG_SYS_DDR_BLOCK2_BASE;
+		gd->bi_dram[1].size = gd->ram_size -
 					  CFG_SYS_DDR_BLOCK1_SIZE;
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
 		if (gd->bi_dram[1].size > CONFIG_SYS_DDR_BLOCK2_SIZE) {
-			gd->bd->bi_dram[2].start = CONFIG_SYS_DDR_BLOCK3_BASE;
-			gd->bd->bi_dram[2].size = gd->bd->bi_dram[1].size -
+			gd->bi_dram[2].start = CONFIG_SYS_DDR_BLOCK3_BASE;
+			gd->bi_dram[2].size = gd->bi_dram[1].size -
 						  CONFIG_SYS_DDR_BLOCK2_SIZE;
-			gd->bd->bi_dram[1].size = CONFIG_SYS_DDR_BLOCK2_SIZE;
+			gd->bi_dram[1].size = CONFIG_SYS_DDR_BLOCK2_SIZE;
 		}
 #endif
 	} else {
-		gd->bd->bi_dram[0].size = gd->ram_size;
+		gd->bi_dram[0].size = gd->ram_size;
 	}
 #ifdef CFG_SYS_MEM_RESERVE_SECURE
-	if (gd->bd->bi_dram[0].size >
+	if (gd->bi_dram[0].size >
 				CFG_SYS_MEM_RESERVE_SECURE) {
-		gd->bd->bi_dram[0].size -=
+		gd->bi_dram[0].size -=
 				CFG_SYS_MEM_RESERVE_SECURE;
-		gd->arch.secure_ram = gd->bd->bi_dram[0].start +
-				      gd->bd->bi_dram[0].size;
+		gd->arch.secure_ram = gd->bi_dram[0].start +
+				      gd->bi_dram[0].size;
 		gd->arch.secure_ram |= MEM_RESERVE_SECURE_MAINTAINED;
 		gd->ram_size -= CFG_SYS_MEM_RESERVE_SECURE;
 	}
@@ -1471,24 +1471,24 @@ int dram_init_banksize(void)
 #if defined(CONFIG_RESV_RAM) && !defined(CONFIG_XPL_BUILD)
 	/* Assign memory for MC */
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
-	if (gd->bd->bi_dram[2].size >=
-	    board_reserve_ram_top(gd->bd->bi_dram[2].size)) {
-		gd->arch.resv_ram = gd->bd->bi_dram[2].start +
-			    gd->bd->bi_dram[2].size -
-			    board_reserve_ram_top(gd->bd->bi_dram[2].size);
+	if (gd->bi_dram[2].size >=
+	    board_reserve_ram_top(gd->bi_dram[2].size)) {
+		gd->arch.resv_ram = gd->bi_dram[2].start +
+			    gd->bi_dram[2].size -
+			    board_reserve_ram_top(gd->bi_dram[2].size);
 	} else
 #endif
 	{
-		if (gd->bd->bi_dram[1].size >=
-		    board_reserve_ram_top(gd->bd->bi_dram[1].size)) {
-			gd->arch.resv_ram = gd->bd->bi_dram[1].start +
-				gd->bd->bi_dram[1].size -
-				board_reserve_ram_top(gd->bd->bi_dram[1].size);
-		} else if (gd->bd->bi_dram[0].size >
-			   board_reserve_ram_top(gd->bd->bi_dram[0].size)) {
-			gd->arch.resv_ram = gd->bd->bi_dram[0].start +
-				gd->bd->bi_dram[0].size -
-				board_reserve_ram_top(gd->bd->bi_dram[0].size);
+		if (gd->bi_dram[1].size >=
+		    board_reserve_ram_top(gd->bi_dram[1].size)) {
+			gd->arch.resv_ram = gd->bi_dram[1].start +
+				gd->bi_dram[1].size -
+				board_reserve_ram_top(gd->bi_dram[1].size);
+		} else if (gd->bi_dram[0].size >
+			   board_reserve_ram_top(gd->bi_dram[0].size)) {
+			gd->arch.resv_ram = gd->bi_dram[0].start +
+				gd->bi_dram[0].size -
+				board_reserve_ram_top(gd->bi_dram[0].size);
 		}
 	}
 #endif	/* CONFIG_RESV_RAM */
@@ -1510,8 +1510,8 @@ int dram_init_banksize(void)
 					  CONFIG_DP_DDR_DIMM_SLOTS_PER_CTLR,
 					  NULL, NULL, NULL);
 		if (dp_ddr_size) {
-			gd->bd->bi_dram[2].start = CONFIG_SYS_DP_DDR_BASE;
-			gd->bd->bi_dram[2].size = dp_ddr_size;
+			gd->bi_dram[2].start = CONFIG_SYS_DP_DDR_BASE;
+			gd->bi_dram[2].size = dp_ddr_size;
 		} else {
 			puts("Not detected");
 		}
@@ -1542,8 +1542,8 @@ void lmb_arch_add_memory(void)
 		if (i == 2)
 			continue;	/* skip DP-DDR */
 #endif
-		ram_start = gd->bd->bi_dram[i].start;
-		ram_size = gd->bd->bi_dram[i].size;
+		ram_start = gd->bi_dram[i].start;
+		ram_size = gd->bi_dram[i].size;
 #ifdef CONFIG_RESV_RAM
 		if (gd->arch.resv_ram >= ram_start &&
 		    gd->arch.resv_ram < ram_start + ram_size)
diff --git a/arch/arm/lib/bootm-fdt.c b/arch/arm/lib/bootm-fdt.c
index 2671f9a0ebf5..8b58e30ff732 100644
--- a/arch/arm/lib/bootm-fdt.c
+++ b/arch/arm/lib/bootm-fdt.c
@@ -35,14 +35,13 @@ int arch_fixup_fdt(void *blob)
 {
 	__maybe_unused int ret = 0;
 #if defined(CONFIG_ARMV7_NONSEC) || defined(CONFIG_OF_LIBFDT)
-	struct bd_info *bd = gd->bd;
 	int bank;
 	u64 start[CONFIG_NR_DRAM_BANKS];
 	u64 size[CONFIG_NR_DRAM_BANKS];
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] = bd->bi_dram[bank].start;
-		size[bank] = bd->bi_dram[bank].size;
+		start[bank] = gd->bi_dram[bank].start;
+		size[bank] = gd->bi_dram[bank].size;
 #ifdef CONFIG_ARMV7_NONSEC
 		ret = armv7_apply_memory_carveout(&start[bank], &size[bank]);
 		if (ret)
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 019eca957809..024ba5fb5634 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -100,8 +100,8 @@ static void setup_memory_tags(struct bd_info *bd)
 		params->hdr.tag = ATAG_MEM;
 		params->hdr.size = tag_size (tag_mem32);
 
-		params->u.mem.start = bd->bi_dram[i].start;
-		params->u.mem.size = bd->bi_dram[i].size;
+		params->u.mem.start = gd->bi_dram[i].start;
+		params->u.mem.size = gd->bi_dram[i].size;
 
 		params = tag_next (params);
 	}
diff --git a/arch/arm/lib/cache-cp15.c b/arch/arm/lib/cache-cp15.c
index 947012f29963..0a15407e5c78 100644
--- a/arch/arm/lib/cache-cp15.c
+++ b/arch/arm/lib/cache-cp15.c
@@ -94,7 +94,6 @@ void mmu_set_region_dcache_behaviour_phys(phys_addr_t start, phys_addr_t phys,
 
 __weak void dram_bank_mmu_setup(int bank)
 {
-	struct bd_info *bd = gd->bd;
 	int	i;
 
 	/* bd->bi_dram is available only after relocation */
@@ -102,9 +101,9 @@ __weak void dram_bank_mmu_setup(int bank)
 		return;
 
 	debug("%s: bank: %d\n", __func__, bank);
-	for (i = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	     i < (bd->bi_dram[bank].start >> MMU_SECTION_SHIFT) +
-		 (bd->bi_dram[bank].size >> MMU_SECTION_SHIFT);
+	for (i = gd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+	     i < (gd->bi_dram[bank].start >> MMU_SECTION_SHIFT) +
+		 (gd->bi_dram[bank].size >> MMU_SECTION_SHIFT);
 	     i++)
 		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
 }
diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index 1f672eee2c86..ac5fd79e7c4a 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -69,7 +69,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 	if (!force_reloc && (le64_to_cpu(ih->flags) & BIT(3)))
 		dst = image - text_offset;
 	else
-		dst = gd->bd->bi_dram[0].start;
+		dst = gd->bi_dram[0].start;
 
 	*relocated_addr = ALIGN(dst, SZ_2M) + text_offset;
 
diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index ab32706a79d0..d985ff533367 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -23,12 +23,12 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = get_effective_memsize();
 
 	if (gd->ram_size > SZ_2G) {
-		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
-		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+		gd->bi_dram[1].start = gd->ram_base + SZ_2G;
+		gd->bi_dram[1].size = gd->ram_size - SZ_2G;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 4cd8979bdc20..f85cbcfbe134 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -728,8 +728,8 @@ void build_mem_map(void)
 		;
 
 	/* Align RAM mapping to page boundaries */
-	base = gd->bd->bi_dram[0].start;
-	size = gd->bd->bi_dram[0].size;
+	base = gd->bi_dram[0].start;
+	size = gd->bi_dram[0].size;
 	size += (base - ALIGN_DOWN(base, SZ_4K));
 	base = ALIGN_DOWN(base, SZ_4K);
 	size = ALIGN(size, SZ_4K);
diff --git a/arch/arm/mach-davinci/misc.c b/arch/arm/mach-davinci/misc.c
index 07125eac7cd3..bdabe08b51f3 100644
--- a/arch/arm/mach-davinci/misc.c
+++ b/arch/arm/mach-davinci/misc.c
@@ -33,8 +33,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 4d4620dcafd5..7cfde7903ced 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -310,12 +310,11 @@ int ahab_verify_cntr_image(struct boot_img_t *img, int image_index)
 static inline bool check_in_dram(ulong addr)
 {
 	int i;
-	struct bd_info *bd = gd->bd;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
-		if (bd->bi_dram[i].size) {
-			if (addr >= bd->bi_dram[i].start &&
-			    addr < (bd->bi_dram[i].start + bd->bi_dram[i].size))
+		if (gd->bi_dram[i].size) {
+			if (addr >= gd->bi_dram[i].start &&
+			    addr < (gd->bi_dram[i].start + gd->bi_dram[i].size))
 				return true;
 		}
 	}
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index f13baa871cc2..e127e725853a 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -109,12 +109,11 @@ int ahab_verify_cntr_image(struct boot_img_t *img, int image_index)
 static inline bool check_in_dram(ulong addr)
 {
 	int i;
-	struct bd_info *bd = gd->bd;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
-		if (bd->bi_dram[i].size) {
-			if (addr >= bd->bi_dram[i].start &&
-			    addr < (bd->bi_dram[i].start + bd->bi_dram[i].size))
+		if (gd->bi_dram[i].size) {
+			if (addr >= gd->bi_dram[i].start &&
+			    addr < (gd->bi_dram[i].start + gd->bi_dram[i].size))
 				return true;
 		}
 	}
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 0e112af661c1..0871f6babfc9 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -604,18 +604,18 @@ static void dram_bank_sort(int current_bank)
 	phys_size_t size;
 
 	while (current_bank > 0) {
-		if (gd->bd->bi_dram[current_bank - 1].start >
-		    gd->bd->bi_dram[current_bank].start) {
-			start = gd->bd->bi_dram[current_bank - 1].start;
-			size = gd->bd->bi_dram[current_bank - 1].size;
-
-			gd->bd->bi_dram[current_bank - 1].start =
-				gd->bd->bi_dram[current_bank].start;
-			gd->bd->bi_dram[current_bank - 1].size =
-				gd->bd->bi_dram[current_bank].size;
-
-			gd->bd->bi_dram[current_bank].start = start;
-			gd->bd->bi_dram[current_bank].size = size;
+		if (gd->bi_dram[current_bank - 1].start >
+		    gd->bi_dram[current_bank].start) {
+			start = gd->bi_dram[current_bank - 1].start;
+			size = gd->bi_dram[current_bank - 1].size;
+
+			gd->bi_dram[current_bank - 1].start =
+				gd->bi_dram[current_bank].start;
+			gd->bi_dram[current_bank - 1].size =
+				gd->bi_dram[current_bank].size;
+
+			gd->bi_dram[current_bank].start = start;
+			gd->bi_dram[current_bank].size = size;
 		}
 		current_bank--;
 	}
@@ -643,24 +643,24 @@ int dram_init_banksize(void)
 				continue;
 
 			if (start >= phys_sdram_1_start && start <= end1) {
-				gd->bd->bi_dram[i].start = start;
+				gd->bi_dram[i].start = start;
 
 				if ((end + 1) <= end1)
-					gd->bd->bi_dram[i].size =
+					gd->bi_dram[i].size =
 						end - start + 1;
 				else
-					gd->bd->bi_dram[i].size = end1 - start;
+					gd->bi_dram[i].size = end1 - start;
 
 				dram_bank_sort(i);
 				i++;
 			} else if (start >= phys_sdram_2_start && start <= end2) {
-				gd->bd->bi_dram[i].start = start;
+				gd->bi_dram[i].start = start;
 
 				if ((end + 1) <= end2)
-					gd->bd->bi_dram[i].size =
+					gd->bi_dram[i].size =
 						end - start + 1;
 				else
-					gd->bd->bi_dram[i].size = end2 - start;
+					gd->bi_dram[i].size = end2 - start;
 
 				dram_bank_sort(i);
 				i++;
@@ -670,10 +670,10 @@ int dram_init_banksize(void)
 
 	/* If error, set to the default value */
 	if (!i) {
-		gd->bd->bi_dram[0].start = phys_sdram_1_start;
-		gd->bd->bi_dram[0].size = phys_sdram_1_size;
-		gd->bd->bi_dram[1].start = phys_sdram_2_start;
-		gd->bd->bi_dram[1].size = phys_sdram_2_size;
+		gd->bi_dram[0].start = phys_sdram_1_start;
+		gd->bi_dram[0].size = phys_sdram_1_size;
+		gd->bi_dram[1].start = phys_sdram_2_start;
+		gd->bi_dram[1].size = phys_sdram_2_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 1fe083ae94ff..f853809d80d4 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -224,11 +224,11 @@ void enable_caches(void)
 
 	while (i < CONFIG_NR_DRAM_BANKS &&
 	       entry < ARRAY_SIZE(imx8m_mem_map)) {
-		if (gd->bd->bi_dram[i].start == 0)
+		if (gd->bi_dram[i].start == 0)
 			break;
-		imx8m_mem_map[entry].phys = gd->bd->bi_dram[i].start;
-		imx8m_mem_map[entry].virt = gd->bd->bi_dram[i].start;
-		imx8m_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx8m_mem_map[entry].phys = gd->bi_dram[i].start;
+		imx8m_mem_map[entry].virt = gd->bi_dram[i].start;
+		imx8m_mem_map[entry].size = gd->bi_dram[i].size;
 		imx8m_mem_map[entry].attrs = attrs;
 		debug("Added memory mapping (%d): %llx %llx\n", entry,
 		      imx8m_mem_map[entry].phys, imx8m_mem_map[entry].size);
@@ -290,24 +290,24 @@ int dram_init_banksize(void)
 		sdram_b2_size = 0;
 	}
 
-	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	gd->bi_dram[bank].start = PHYS_SDRAM;
 	if (!IS_ENABLED(CONFIG_ARMV8_PSCI) && !IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
-		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		gd->bi_dram[bank].size = optee_start - gd->bi_dram[bank].start;
 		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
 			if (++bank >= CONFIG_NR_DRAM_BANKS) {
 				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
 				return -1;
 			}
 
-			gd->bd->bi_dram[bank].start = optee_start + optee_size;
-			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
-				sdram_b1_size - gd->bd->bi_dram[bank].start;
+			gd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bi_dram[bank].start;
 		}
 	} else {
-		gd->bd->bi_dram[bank].size = sdram_b1_size;
+		gd->bi_dram[bank].size = sdram_b1_size;
 	}
 
 	if (sdram_b2_size) {
@@ -315,8 +315,8 @@ int dram_init_banksize(void)
 			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
 			return -1;
 		}
-		gd->bd->bi_dram[bank].start = 0x100000000UL;
-		gd->bd->bi_dram[bank].size = sdram_b2_size;
+		gd->bi_dram[bank].start = 0x100000000UL;
+		gd->bi_dram[bank].size = sdram_b2_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 1ee483065e85..b560bc340462 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -502,11 +502,11 @@ void enable_caches(void)
 
 		while (i < CONFIG_NR_DRAM_BANKS &&
 		       entry < ARRAY_SIZE(imx8ulp_arm64_mem_map)) {
-			if (gd->bd->bi_dram[i].start == 0)
+			if (gd->bi_dram[i].start == 0)
 				break;
-			imx8ulp_arm64_mem_map[entry].phys = gd->bd->bi_dram[i].start;
-			imx8ulp_arm64_mem_map[entry].virt = gd->bd->bi_dram[i].start;
-			imx8ulp_arm64_mem_map[entry].size = gd->bd->bi_dram[i].size;
+			imx8ulp_arm64_mem_map[entry].phys = gd->bi_dram[i].start;
+			imx8ulp_arm64_mem_map[entry].virt = gd->bi_dram[i].start;
+			imx8ulp_arm64_mem_map[entry].size = gd->bi_dram[i].size;
 			imx8ulp_arm64_mem_map[entry].attrs = attrs;
 			debug("Added memory mapping (%d): %llx %llx\n", entry,
 			      imx8ulp_arm64_mem_map[entry].phys, imx8ulp_arm64_mem_map[entry].size);
@@ -558,24 +558,24 @@ int dram_init_banksize(void)
 	if (ret)
 		return ret;
 
-	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	gd->bi_dram[bank].start = PHYS_SDRAM;
 	if (rom_pointer[1]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
-		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		gd->bi_dram[bank].size = optee_start - gd->bi_dram[bank].start;
 		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_size)) {
 			if (++bank >= CONFIG_NR_DRAM_BANKS) {
 				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
 				return -1;
 			}
 
-			gd->bd->bi_dram[bank].start = optee_start + optee_size;
-			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
-				sdram_size - gd->bd->bi_dram[bank].start;
+			gd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_size - gd->bi_dram[bank].start;
 		}
 	} else {
-		gd->bd->bi_dram[bank].size = sdram_size;
+		gd->bi_dram[bank].size = sdram_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c3..55b26af9e049 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -318,11 +318,11 @@ void enable_caches(void)
 
 	while (i < CONFIG_NR_DRAM_BANKS &&
 	       entry < ARRAY_SIZE(imx9_mem_map)) {
-		if (gd->bd->bi_dram[i].start == 0)
+		if (gd->bi_dram[i].start == 0)
 			break;
-		imx9_mem_map[entry].phys = gd->bd->bi_dram[i].start;
-		imx9_mem_map[entry].virt = gd->bd->bi_dram[i].start;
-		imx9_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx9_mem_map[entry].phys = gd->bi_dram[i].start;
+		imx9_mem_map[entry].virt = gd->bi_dram[i].start;
+		imx9_mem_map[entry].size = gd->bi_dram[i].size;
 		imx9_mem_map[entry].attrs = attrs;
 		debug("Added memory mapping (%d): %llx %llx\n", entry,
 		      imx9_mem_map[entry].phys, imx9_mem_map[entry].size);
@@ -396,24 +396,24 @@ int dram_init_banksize(void)
 		sdram_b2_size = 0;
 	}
 
-	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	gd->bi_dram[bank].start = PHYS_SDRAM;
 	if (rom_pointer[1] && PHYS_SDRAM < (phys_addr_t)rom_pointer[0]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
-		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		gd->bi_dram[bank].size = optee_start - gd->bi_dram[bank].start;
 		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
 			if (++bank >= CONFIG_NR_DRAM_BANKS) {
 				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
 				return -1;
 			}
 
-			gd->bd->bi_dram[bank].start = optee_start + optee_size;
-			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
-				sdram_b1_size - gd->bd->bi_dram[bank].start;
+			gd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bi_dram[bank].start;
 		}
 	} else {
-		gd->bd->bi_dram[bank].size = sdram_b1_size;
+		gd->bi_dram[bank].size = sdram_b1_size;
 	}
 
 	if (sdram_b2_size) {
@@ -421,8 +421,8 @@ int dram_init_banksize(void)
 			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
 			return -1;
 		}
-		gd->bd->bi_dram[bank].start = 0x100000000UL;
-		gd->bd->bi_dram[bank].size = sdram_b2_size;
+		gd->bi_dram[bank].start = 0x100000000UL;
+		gd->bi_dram[bank].size = sdram_b2_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 583c3a5a464b..d8beb86c6932 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -370,11 +370,11 @@ void enable_caches(void)
 
 	while (i < CONFIG_NR_DRAM_BANKS &&
 	       entry < ARRAY_SIZE(imx93_mem_map)) {
-		if (gd->bd->bi_dram[i].start == 0)
+		if (gd->bi_dram[i].start == 0)
 			break;
-		imx93_mem_map[entry].phys = gd->bd->bi_dram[i].start;
-		imx93_mem_map[entry].virt = gd->bd->bi_dram[i].start;
-		imx93_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx93_mem_map[entry].phys = gd->bi_dram[i].start;
+		imx93_mem_map[entry].virt = gd->bi_dram[i].start;
+		imx93_mem_map[entry].size = gd->bi_dram[i].size;
 		imx93_mem_map[entry].attrs = attrs;
 		debug("Added memory mapping (%d): %llx %llx\n", entry,
 		      imx93_mem_map[entry].phys, imx93_mem_map[entry].size);
@@ -448,24 +448,24 @@ int dram_init_banksize(void)
 		sdram_b2_size = 0;
 	}
 
-	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	gd->bi_dram[bank].start = PHYS_SDRAM;
 	if (!IS_ENABLED(CONFIG_XPL_BUILD) && rom_pointer[1]) {
 		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
 		phys_size_t optee_size = (size_t)rom_pointer[1];
 
-		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		gd->bi_dram[bank].size = optee_start - gd->bi_dram[bank].start;
 		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
 			if (++bank >= CONFIG_NR_DRAM_BANKS) {
 				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
 				return -1;
 			}
 
-			gd->bd->bi_dram[bank].start = optee_start + optee_size;
-			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
-				sdram_b1_size - gd->bd->bi_dram[bank].start;
+			gd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bi_dram[bank].start;
 		}
 	} else {
-		gd->bd->bi_dram[bank].size = sdram_b1_size;
+		gd->bi_dram[bank].size = sdram_b1_size;
 	}
 
 	if (sdram_b2_size) {
@@ -473,8 +473,8 @@ int dram_init_banksize(void)
 			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
 			return -1;
 		}
-		gd->bd->bi_dram[bank].start = 0x100000000UL;
-		gd->bd->bi_dram[bank].size = sdram_b2_size;
+		gd->bi_dram[bank].start = 0x100000000UL;
+		gd->bi_dram[bank].size = sdram_b2_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/mx5/mx53_dram.c b/arch/arm/mach-imx/mx5/mx53_dram.c
index 180a745d4351..b6e4e325b42e 100644
--- a/arch/arm/mach-imx/mx5/mx53_dram.c
+++ b/arch/arm/mach-imx/mx5/mx53_dram.c
@@ -35,11 +35,11 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = get_ram_size((void *)PHYS_SDRAM_1, 1 << 30);
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = get_ram_size((void *)PHYS_SDRAM_1, 1 << 30);
 
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = get_ram_size((void *)PHYS_SDRAM_2, 1 << 30);
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size = get_ram_size((void *)PHYS_SDRAM_2, 1 << 30);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 57ae81c7834e..2dbf7d4216e5 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -375,8 +375,8 @@ void *spl_load_simple_fit_fix_load(const void *fit)
 #if defined(CONFIG_MX6) && defined(CONFIG_SPL_OS_BOOT)
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = imx_ddr_size();
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = imx_ddr_size();
 
 	return 0;
 }
diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
index 6e3e60cdc865..a413944009fa 100644
--- a/arch/arm/mach-k3/k3-ddr.c
+++ b/arch/arm/mach-k3/k3-ddr.c
@@ -59,8 +59,8 @@ void fixup_memory_node(struct spl_image_info *spl_image)
 	dram_init_banksize();
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] = gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
+		start[bank] = gd->bi_dram[bank].start;
+		size[bank] = gd->bi_dram[bank].size;
 	}
 
 	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
diff --git a/arch/arm/mach-mediatek/mt7987/init.c b/arch/arm/mach-mediatek/mt7987/init.c
index 8b2682978097..59a2029d142e 100644
--- a/arch/arm/mach-mediatek/mt7987/init.c
+++ b/arch/arm/mach-mediatek/mt7987/init.c
@@ -29,8 +29,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 8bdd3848d261..d5931cc7ea8e 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -28,8 +28,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 37243547da81..45e631f39b7b 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -31,8 +31,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index ed67150e6119..4a75290ab75e 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -39,8 +39,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/mt8365/init.c
index 8f03ed28763d..d0467d5cad82 100644
--- a/arch/arm/mach-mediatek/mt8365/init.c
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -20,8 +20,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediatek/mt8512/init.c
index 3b48caf5196c..db7e89142722 100644
--- a/arch/arm/mach-mediatek/mt8512/init.c
+++ b/arch/arm/mach-mediatek/mt8512/init.c
@@ -37,8 +37,8 @@ phys_size_t  get_effective_memsize(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = get_effective_memsize();
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 892bd441a33b..a83f096aa364 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -34,8 +34,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index c04bcb635178..efa61a5360fc 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -35,8 +35,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
index be2d9a25bf90..7578947e75bc 100644
--- a/arch/arm/mach-mvebu/alleycat5/cpu.c
+++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
@@ -138,8 +138,8 @@ int alleycat5_dram_init_banksize(void)
 	/*
 	 * Config single DRAM bank
 	 */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-mvebu/armada3700/cpu.c b/arch/arm/mach-mvebu/armada3700/cpu.c
index 17525691e682..709c43e43590 100644
--- a/arch/arm/mach-mvebu/armada3700/cpu.c
+++ b/arch/arm/mach-mvebu/armada3700/cpu.c
@@ -256,7 +256,7 @@ int a3700_dram_init_banksize(void)
 		 * build_mem_map.
 		 */
 		if (last_end == dram_wins[win].base) {
-			gd->bd->bi_dram[bank - 1].size += size;
+			gd->bi_dram[bank - 1].size += size;
 			last_end += size;
 		} else {
 			if (bank == CONFIG_NR_DRAM_BANKS) {
@@ -264,8 +264,8 @@ int a3700_dram_init_banksize(void)
 				return -ENOBUFS;
 			}
 
-			gd->bd->bi_dram[bank].start = dram_wins[win].base;
-			gd->bd->bi_dram[bank].size = size;
+			gd->bi_dram[bank].start = dram_wins[win].base;
+			gd->bi_dram[bank].size = size;
 			last_end = dram_wins[win].base + size;
 			++bank;
 		}
@@ -276,8 +276,8 @@ int a3700_dram_init_banksize(void)
 	 * the rest with zeros.
 	 */
 	for (; bank < CONFIG_NR_DRAM_BANKS; ++bank) {
-		gd->bd->bi_dram[bank].start = 0;
-		gd->bd->bi_dram[bank].size = 0;
+		gd->bi_dram[bank].start = 0;
+		gd->bi_dram[bank].size = 0;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mvebu/armada8k/dram.c b/arch/arm/mach-mvebu/armada8k/dram.c
index fd58551d0e32..48fdda6c8940 100644
--- a/arch/arm/mach-mvebu/armada8k/dram.c
+++ b/arch/arm/mach-mvebu/armada8k/dram.c
@@ -38,16 +38,16 @@ int a8k_dram_init_banksize(void)
 	 */
 	phys_size_t max_bank0_size = SZ_4G - SZ_1G;
 
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 	if (gd->ram_size <= max_bank0_size) {
-		gd->bd->bi_dram[0].size = gd->ram_size;
+		gd->bi_dram[0].size = gd->ram_size;
 		return 0;
 	}
 
-	gd->bd->bi_dram[0].size = max_bank0_size;
+	gd->bi_dram[0].size = max_bank0_size;
 	if (CONFIG_NR_DRAM_BANKS > 1) {
-		gd->bd->bi_dram[1].start = SZ_4G;
-		gd->bd->bi_dram[1].size = gd->ram_size - max_bank0_size;
+		gd->bi_dram[1].start = SZ_4G;
+		gd->bi_dram[1].size = gd->ram_size - max_bank0_size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mvebu/dram.c b/arch/arm/mach-mvebu/dram.c
index c00c6b9b3fc2..88aa5ac7d344 100644
--- a/arch/arm/mach-mvebu/dram.c
+++ b/arch/arm/mach-mvebu/dram.c
@@ -294,11 +294,11 @@ int dram_init_banksize(void)
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		gd->bd->bi_dram[i].start = mvebu_sdram_bar(i);
-		gd->bd->bi_dram[i].size = mvebu_sdram_bs(i);
+		gd->bi_dram[i].start = mvebu_sdram_bar(i);
+		gd->bi_dram[i].size = mvebu_sdram_bs(i);
 
 		/* Clip the banksize to 1GiB if it exceeds the max size */
-		size += gd->bd->bi_dram[i].size;
+		size += gd->bi_dram[i].size;
 		if (size > MVEBU_SDRAM_SIZE_MAX)
 			mvebu_sdram_bs_set(i, 0x40000000);
 	}
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b..15dbeda9b661 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -80,8 +80,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap-cache.c b/arch/arm/mach-omap2/omap-cache.c
index 200a08fa5c83..5a9841b71010 100644
--- a/arch/arm/mach-omap2/omap-cache.c
+++ b/arch/arm/mach-omap2/omap-cache.c
@@ -53,11 +53,10 @@ void enable_caches(void)
 
 void dram_bank_mmu_setup(int bank)
 {
-	struct bd_info *bd = gd->bd;
 	int	i;
 
-	u32 start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	u32 size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+	u32 start = gd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+	u32 size = gd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
 	u32 end = start + size;
 
 	debug("%s: bank: %d\n", __func__, bank);
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 049eedfeb65b..5cba20160750 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -150,10 +150,10 @@ int dram_init_banksize(void)
 	size0 = get_sdr_cs_size(CS0);
 	size1 = get_sdr_cs_size(CS1);
 
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = size0;
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_1 + get_sdr_cs_offset(CS1);
-	gd->bd->bi_dram[1].size = size1;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = size0;
+	gd->bi_dram[1].start = PHYS_SDRAM_1 + get_sdr_cs_offset(CS1);
+	gd->bi_dram[1].size = size1;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 24fae4843698..581614459039 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -222,10 +222,10 @@ int dram_init_banksize(void)
 	size0 = get_sdr_cs_size(CS0);
 	size1 = get_sdr_cs_size(CS1);
 
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = size0;
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_1 + get_sdr_cs_offset(CS1);
-	gd->bd->bi_dram[1].size = size1;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = size0;
+	gd->bi_dram[1].start = PHYS_SDRAM_1 + get_sdr_cs_offset(CS1);
+	gd->bi_dram[1].size = size1;
 
 	return 0;
 }
diff --git a/arch/arm/mach-owl/soc.c b/arch/arm/mach-owl/soc.c
index 0130cad76782..926efb41b296 100644
--- a/arch/arm/mach-owl/soc.c
+++ b/arch/arm/mach-owl/soc.c
@@ -50,8 +50,8 @@ int dram_init(void)
 /* This is called after dram_init() so use get_ram_size result */
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/arm/mach-renesas/memmap-gen3.c b/arch/arm/mach-renesas/memmap-gen3.c
index d24419f5daa5..23487012004d 100644
--- a/arch/arm/mach-renesas/memmap-gen3.c
+++ b/arch/arm/mach-renesas/memmap-gen3.c
@@ -70,8 +70,8 @@ void enable_caches(void)
 
 	/* Generate entires for DRAM in 32bit address space */
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start = gd->bd->bi_dram[bank].start;
-		size = gd->bd->bi_dram[bank].size;
+		start = gd->bi_dram[bank].start;
+		size = gd->bi_dram[bank].size;
 
 		/* Skip empty DRAM banks */
 		if (!size)
@@ -114,8 +114,8 @@ void enable_caches(void)
 
 	/* Generate entires for DRAM in 64bit address space */
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start = gd->bd->bi_dram[bank].start;
-		size = gd->bd->bi_dram[bank].size;
+		start = gd->bi_dram[bank].start;
+		size = gd->bi_dram[bank].size;
 
 		/* Skip empty DRAM banks */
 		if (!size)
diff --git a/arch/arm/mach-renesas/memmap-rzg2l.c b/arch/arm/mach-renesas/memmap-rzg2l.c
index 3b3c6f7cde9a..fda4b7f2d396 100644
--- a/arch/arm/mach-renesas/memmap-rzg2l.c
+++ b/arch/arm/mach-renesas/memmap-rzg2l.c
@@ -67,8 +67,8 @@ void enable_caches(void)
 
 	/* Generate entries for DRAM in 32bit address space */
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start = gd->bd->bi_dram[bank].start;
-		size = gd->bd->bi_dram[bank].size;
+		start = gd->bi_dram[bank].start;
+		size = gd->bi_dram[bank].size;
 
 		/* Skip empty DRAM banks */
 		if (!size)
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index d560f90e873d..008c3879b890 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -261,8 +261,8 @@ static int rockchip_dram_init_banksize(void)
 				 * split the region in two, one for before the
 				 * reserved memory area and one for after.
 				 */
-				gd->bd->bi_dram[j].start = start_addr;
-				gd->bd->bi_dram[j].size = rsrv_start - start_addr;
+				gd->bi_dram[j].start = start_addr;
+				gd->bi_dram[j].size = rsrv_start - start_addr;
 
 				j++;
 
@@ -281,8 +281,8 @@ static int rockchip_dram_init_banksize(void)
 			return -ENOMEM;
 		}
 
-		gd->bd->bi_dram[j].start = start_addr;
-		gd->bd->bi_dram[j].size = size;
+		gd->bi_dram[j].start = start_addr;
+		gd->bi_dram[j].size = size;
 	}
 
 	return 0;
@@ -304,15 +304,15 @@ int dram_init_banksize(void)
 	      ret);
 
 	/* Reserve 2M for ATF bl31 */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
-	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
+	gd->bi_dram[0].size = top - gd->bi_dram[0].start;
 
 	/* Add usable memory beyond the blob of space for peripheral near 4GB */
 	if (ram_top > SZ_4G && top < SZ_4G) {
-		gd->bd->bi_dram[1].start = SZ_4G;
-		gd->bd->bi_dram[1].size = ram_top - gd->bd->bi_dram[1].start;
+		gd->bi_dram[1].start = SZ_4G;
+		gd->bi_dram[1].size = ram_top - gd->bi_dram[1].start;
 	} else if (ram_top > SZ_4G && top == SZ_4G) {
-		gd->bd->bi_dram[0].size = ram_top - gd->bd->bi_dram[0].start;
+		gd->bi_dram[0].size = ram_top - gd->bi_dram[0].start;
 	}
 #else
 #ifdef CONFIG_SPL_OPTEE_IMAGE
@@ -322,23 +322,23 @@ int dram_init_banksize(void)
 			TRUST_PARAMETER_OFFSET);
 
 	if (tos_parameter->tee_mem.flags == 1) {
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = tos_parameter->tee_mem.phy_addr
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = tos_parameter->tee_mem.phy_addr
 					- CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[1].start = tos_parameter->tee_mem.phy_addr +
+		gd->bi_dram[1].start = tos_parameter->tee_mem.phy_addr +
 					tos_parameter->tee_mem.size;
-		gd->bd->bi_dram[1].size = top - gd->bd->bi_dram[1].start;
+		gd->bi_dram[1].size = top - gd->bi_dram[1].start;
 	} else {
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x8400000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x8400000;
 		/* Reserve 32M for OPTEE with TA */
-		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE
-					+ gd->bd->bi_dram[0].size + 0x2000000;
-		gd->bd->bi_dram[1].size = top - gd->bd->bi_dram[1].start;
+		gd->bi_dram[1].start = CFG_SYS_SDRAM_BASE
+					+ gd->bi_dram[0].size + 0x2000000;
+		gd->bi_dram[1].size = top - gd->bi_dram[1].start;
 	}
 #else
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = top - gd->bi_dram[0].start;
 #endif
 #endif
 
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5a..56f12de141ac 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -78,8 +78,8 @@ static void qcom_configure_bi_dram(void)
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
-		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+		gd->bi_dram[i].start = prevbl_ddr_banks[i].start;
+		gd->bi_dram[i].size = prevbl_ddr_banks[i].size;
 	}
 }
 
@@ -589,15 +589,15 @@ static void build_mem_map(void)
 	 */
 	mem_map[0].phys = 0x1000;
 	mem_map[0].virt = mem_map[0].phys;
-	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
+	mem_map[0].size = gd->bi_dram[0].start - mem_map[0].phys;
 	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
 
-	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
-		mem_map[i].phys = gd->bd->bi_dram[j].start;
+	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bi_dram[j].size; i++, j++) {
+		mem_map[i].phys = gd->bi_dram[j].start;
 		mem_map[i].virt = mem_map[i].phys;
-		mem_map[i].size = gd->bd->bi_dram[j].size;
+		mem_map[i].size = gd->bi_dram[j].size;
 		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
 				   PTE_BLOCK_INNER_SHARE;
 	}
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 7f65aed4540e..cfb3d8d54263 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -202,11 +202,10 @@ void board_prep_linux(struct bootm_headers *images)
 void lmb_arch_add_memory(void)
 {
 	int i;
-	struct bd_info *bd = gd->bd;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (bd->bi_dram[i].size)
-			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
+		if (gd->bi_dram[i].size)
+			lmb_add(gd->bi_dram[i].start, gd->bi_dram[i].size);
 	}
 }
 #endif
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7cb..e75f45ef4462 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -246,7 +246,6 @@ int qspi_flash_software_reset(void)
 
 void dram_bank_mmu_setup(int bank)
 {
-	struct bd_info *bd = gd->bd;
 	u32 start, size;
 	int i;
 
@@ -261,11 +260,11 @@ void dram_bank_mmu_setup(int bank)
 	 * The default implementation of this function allows the DRAM dcache
 	 * to be enabled only after relocation. However, to speed up ECC
 	 * initialization, we want to be able to enable DRAM dcache before
-	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
+	 * relocation, so we don't check GD_FLG_RELOC (this assumes gd->bi_dram
 	 * is set first).
 	 */
-	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+	start = gd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+	size = gd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
 	for (i = start; i < start + size; i++)
 		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
 }
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
index 835eaf48dfa5..edc6bd6c8bba 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
@@ -825,8 +825,8 @@ static int init_device(struct stm32prog_data *data,
 		dev->mtd = mtd;
 		break;
 	case STM32PROG_RAM:
-		first_addr = gd->bd->bi_dram[0].start;
-		last_addr = first_addr + gd->bd->bi_dram[0].size;
+		first_addr = gd->bi_dram[0].start;
+		last_addr = first_addr + gd->bi_dram[0].size;
 		dev->erase_size = 1;
 		break;
 	default:
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 252aef1852ea..1b5810c38d70 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -52,7 +52,6 @@ u32 get_bootauth(void)
  */
 void dram_bank_mmu_setup(int bank)
 {
-	struct bd_info *bd = gd->bd;
 	int	i;
 	phys_addr_t start;
 	phys_addr_t addr;
@@ -68,8 +67,8 @@ void dram_bank_mmu_setup(int bank)
 #endif
 	} else if (gd->flags & GD_FLG_RELOC) {
 		/* bd->bi_dram is available only after relocation */
-		start = bd->bi_dram[bank].start;
-		size =  bd->bi_dram[bank].size;
+		start = gd->bi_dram[bank].start;
+		size =  gd->bi_dram[bank].size;
 		use_lmb = true;
 	} else {
 		/* mark cacheable and executable the beggining of the DDR */
diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 396851c5bd84..63cd43d4dd7b 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -393,18 +393,18 @@ int dram_init_banksize(void)
 
 	/* fall back to default DRAM bank size computation */
 
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = usable_ram_size_below_4g();
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = usable_ram_size_below_4g();
 
 #ifdef CONFIG_PHYS_64BIT
 	if (gd->ram_size > SZ_2G) {
-		gd->bd->bi_dram[1].start = 0x100000000;
-		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+		gd->bi_dram[1].start = 0x100000000;
+		gd->bi_dram[1].size = gd->ram_size - SZ_2G;
 	} else
 #endif
 	{
-		gd->bd->bi_dram[1].start = 0;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[1].start = 0;
+		gd->bi_dram[1].size = 0;
 	}
 
 	return 0;
@@ -418,7 +418,7 @@ int dram_init_banksize(void)
  * carve-out, as mentioned above.
  *
  * This function is called before dram_init_banksize(), so we can't simply
- * return gd->bd->bi_dram[1].start + gd->bd->bi_dram[1].size.
+ * return gd->bi_dram[1].start + gd->bi_dram[1].size.
  */
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index e2342b2aece7..53ad4b11e292 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -185,8 +185,8 @@ int cboot_dram_init_banksize(void)
 	}
 
 	for (i = 0; i < ram_bank_count; i++) {
-		gd->bd->bi_dram[i].start = tegra_mem_map[1 + i].virt;
-		gd->bd->bi_dram[i].size = tegra_mem_map[1 + i].size;
+		gd->bi_dram[i].start = tegra_mem_map[1 + i].virt;
+		gd->bi_dram[i].size = tegra_mem_map[1 + i].size;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-uniphier/dram_init.c b/arch/arm/mach-uniphier/dram_init.c
index 0e1164a2680f..0a25a2839182 100644
--- a/arch/arm/mach-uniphier/dram_init.c
+++ b/arch/arm/mach-uniphier/dram_init.c
@@ -280,9 +280,9 @@ int dram_init_banksize(void)
 		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(dram_map); i++) {
-		if (i < ARRAY_SIZE(gd->bd->bi_dram)) {
-			gd->bd->bi_dram[i].start = dram_map[i].base;
-			gd->bd->bi_dram[i].size = dram_map[i].size;
+		if (i < ARRAY_SIZE(gd->bi_dram)) {
+			gd->bi_dram[i].start = dram_map[i].base;
+			gd->bi_dram[i].size = dram_map[i].size;
 		}
 
 		if (!dram_map[i].size)
diff --git a/arch/arm/mach-uniphier/fdt-fixup.c b/arch/arm/mach-uniphier/fdt-fixup.c
index dfa32fdd48b3..82cd90b4d346 100644
--- a/arch/arm/mach-uniphier/fdt-fixup.c
+++ b/arch/arm/mach-uniphier/fdt-fixup.c
@@ -4,6 +4,7 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
+#include <asm/global_data.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
 #include <jffs2/load_kernel.h>
@@ -20,6 +21,7 @@
  */
 static int uniphier_ld20_fdt_mem_rsv(void *fdt, struct bd_info *bd)
 {
+	DECLARE_GLOBAL_DATA_PTR;
 	unsigned long rsv_addr;
 	const unsigned long rsv_size = 64;
 	int i, ret;
@@ -28,11 +30,11 @@ static int uniphier_ld20_fdt_mem_rsv(void *fdt, struct bd_info *bd)
 	    uniphier_get_soc_id() != UNIPHIER_LD20_ID)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(bd->bi_dram); i++) {
-		if (!bd->bi_dram[i].size)
+	for (i = 0; i < ARRAY_SIZE(gd->bi_dram); i++) {
+		if (!gd->bi_dram[i].size)
 			continue;
 
-		rsv_addr = bd->bi_dram[i].start + bd->bi_dram[i].size;
+		rsv_addr = gd->bi_dram[i].start + gd->bi_dram[i].size;
 		rsv_addr -= rsv_size;
 
 		ret = fdt_add_mem_rsv(fdt, rsv_addr, rsv_size);
diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index d088e440f638..e966b002fdec 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -69,12 +69,12 @@ void mem_map_fill(void)
 
 	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		/* Zero size means no more DDR that's this is end */
-		if (!gd->bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			break;
 
-		versal_mem_map[banks].virt = gd->bd->bi_dram[i].start;
-		versal_mem_map[banks].phys = gd->bd->bi_dram[i].start;
-		versal_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		versal_mem_map[banks].virt = gd->bi_dram[i].start;
+		versal_mem_map[banks].phys = gd->bi_dram[i].start;
+		versal_mem_map[banks].size = gd->bi_dram[i].size;
 		versal_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					      PTE_BLOCK_INNER_SHARE;
 		banks = banks + 1;
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 363ce3007fd1..8f1e6f68692b 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -82,21 +82,21 @@ void mem_map_fill(void)
 
 	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		/* Zero size means no more DDR that's this is end */
-		if (!gd->bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			break;
 
 #if defined(CONFIG_VERSAL_NO_DDR)
-		if (gd->bd->bi_dram[i].start < 0x80000000UL ||
-		    gd->bd->bi_dram[i].start > 0x100000000UL) {
+		if (gd->bi_dram[i].start < 0x80000000UL ||
+		    gd->bi_dram[i].start > 0x100000000UL) {
 			printf("Ignore caches over %llx/%llx\n",
-			       gd->bd->bi_dram[i].start,
-			       gd->bd->bi_dram[i].size);
+			       gd->bi_dram[i].start,
+			       gd->bi_dram[i].size);
 			continue;
 		}
 #endif
-		versal_mem_map[banks].virt = gd->bd->bi_dram[i].start;
-		versal_mem_map[banks].phys = gd->bd->bi_dram[i].start;
-		versal_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		versal_mem_map[banks].virt = gd->bi_dram[i].start;
+		versal_mem_map[banks].phys = gd->bi_dram[i].start;
+		versal_mem_map[banks].size = gd->bi_dram[i].size;
 		versal_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					      PTE_BLOCK_INNER_SHARE;
 		banks = banks + 1;
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 2dfcadb369eb..f8c4246082fd 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -69,12 +69,12 @@ void mem_map_fill(void)
 
 	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		/* Zero size means no more DDR that's this is end */
-		if (!gd->bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			break;
 
-		versal2_mem_map[banks].virt = gd->bd->bi_dram[i].start;
-		versal2_mem_map[banks].phys = gd->bd->bi_dram[i].start;
-		versal2_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		versal2_mem_map[banks].virt = gd->bi_dram[i].start;
+		versal2_mem_map[banks].phys = gd->bi_dram[i].start;
+		versal2_mem_map[banks].size = gd->bi_dram[i].size;
 		versal2_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					      PTE_BLOCK_INNER_SHARE;
 		banks = banks + 1;
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 5f194aaff9a4..065624e408ee 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -92,12 +92,12 @@ void mem_map_fill(void)
 #if !defined(CONFIG_ZYNQMP_NO_DDR)
 	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		/* Zero size means no more DDR that's this is end */
-		if (!gd->bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			break;
 
-		zynqmp_mem_map[banks].virt = gd->bd->bi_dram[i].start;
-		zynqmp_mem_map[banks].phys = gd->bd->bi_dram[i].start;
-		zynqmp_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		zynqmp_mem_map[banks].virt = gd->bi_dram[i].start;
+		zynqmp_mem_map[banks].phys = gd->bi_dram[i].start;
+		zynqmp_mem_map[banks].size = gd->bi_dram[i].size;
 		zynqmp_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					      PTE_BLOCK_INNER_SHARE;
 		banks = banks + 1;
diff --git a/arch/mips/mach-octeon/dram.c b/arch/mips/mach-octeon/dram.c
index 5b1311d8b5b9..f9ea364f95ab 100644
--- a/arch/mips/mach-octeon/dram.c
+++ b/arch/mips/mach-octeon/dram.c
@@ -41,8 +41,8 @@ int dram_init(void)
 		 * No DDR init yet -> run in L2 cache
 		 */
 		gd->ram_size = (4 << 20);
-		gd->bd->bi_dram[0].size = gd->ram_size;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[0].size = gd->ram_size;
+		gd->bi_dram[1].size = 0;
 	}
 
 	return 0;
diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
index cc1e903c9dd6..972c2bfb8ab7 100644
--- a/arch/riscv/cpu/k1/dram.c
+++ b/arch/riscv/cpu/k1/dram.c
@@ -56,12 +56,12 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = min_t(phys_size_t, gd->ram_size, SZ_2G);
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = min_t(phys_size_t, gd->ram_size, SZ_2G);
 
 	if (gd->ram_size > SZ_2G && CONFIG_NR_DRAM_BANKS > 1) {
-		gd->bd->bi_dram[1].start = 0x100000000;
-		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+		gd->bi_dram[1].start = 0x100000000;
+		gd->bi_dram[1].size = gd->ram_size - SZ_2G;
 	}
 
 	return 0;
@@ -82,8 +82,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		start[i] = gd->bd->bi_dram[i].start;
-		size[i] = gd->bd->bi_dram[i].size;
+		start[i] = gd->bi_dram[i].start;
+		size[i] = gd->bi_dram[i].size;
 	}
 
 	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 7ee4975523e3..c5544acbad7b 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -131,8 +131,8 @@ SPL_LOAD_IMAGE_METHOD("sandbox_image", 7, BOOT_DEVICE_BOARD, load_from_image);
 int dram_init_banksize(void)
 {
 	/* These are necessary so TFTP can use LMBs to check its load address */
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = get_effective_memsize();
 
 	return 0;
 }
diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
index cc1edd7badd8..6c42a1bee68b 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/arch/x86/cpu/coreboot/sdram.c
@@ -91,8 +91,8 @@ int dram_init_banksize(void)
 			struct memrange *memrange = &lib_sysinfo.memrange[i];
 
 			if (memrange->type == CB_MEM_RAM) {
-				gd->bd->bi_dram[j].start = memrange->base;
-				gd->bd->bi_dram[j].size = memrange->size;
+				gd->bi_dram[j].start = memrange->base;
+				gd->bi_dram[j].size = memrange->size;
 				j++;
 				if (j >= CONFIG_NR_DRAM_BANKS)
 					break;
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 6845ce72ff94..28f71ac3b08f 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -123,8 +123,8 @@ int dram_init_banksize(void)
 		if (desc->type != EFI_CONVENTIONAL_MEMORY ||
 		    (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
 			continue;
-		gd->bd->bi_dram[num_banks].start = desc->physical_start;
-		gd->bd->bi_dram[num_banks].size = desc->num_pages <<
+		gd->bi_dram[num_banks].start = desc->physical_start;
+		gd->bi_dram[num_banks].size = desc->num_pages <<
 			EFI_PAGE_SHIFT;
 		num_banks++;
 	}
diff --git a/arch/x86/cpu/efi/sdram.c b/arch/x86/cpu/efi/sdram.c
index 6fe400711402..b02157c3b680 100644
--- a/arch/x86/cpu/efi/sdram.c
+++ b/arch/x86/cpu/efi/sdram.c
@@ -24,8 +24,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = efi_get_ram_base();
-	gd->bd->bi_dram[0].size = CONFIG_EFI_RAM_SIZE;
+	gd->bi_dram[0].start = efi_get_ram_base();
+	gd->bi_dram[0].size = CONFIG_EFI_RAM_SIZE;
 
 	return 0;
 }
diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index baa1f0e32d6b..deed96c01d7b 100644
--- a/arch/x86/cpu/intel_common/mrc.c
+++ b/arch/x86/cpu/intel_common/mrc.c
@@ -67,8 +67,8 @@ void mrc_common_dram_init_banksize(void)
 
 		if (area->start >= 1ULL << 32)
 			continue;
-		gd->bd->bi_dram[num_banks].start = area->start;
-		gd->bd->bi_dram[num_banks].size = area->size;
+		gd->bi_dram[num_banks].start = area->start;
+		gd->bi_dram[num_banks].size = area->size;
 		num_banks++;
 	}
 }
diff --git a/arch/x86/cpu/ivybridge/sdram_nop.c b/arch/x86/cpu/ivybridge/sdram_nop.c
index d20c9a2a379f..2cfc75d49bfe 100644
--- a/arch/x86/cpu/ivybridge/sdram_nop.c
+++ b/arch/x86/cpu/ivybridge/sdram_nop.c
@@ -11,8 +11,8 @@ DECLARE_GLOBAL_DATA_PTR;
 int dram_init(void)
 {
 	gd->ram_size = 1ULL << 31;
-	gd->bd->bi_dram[0].start = 0;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = 0;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index ba3638e6acc6..453cd1d4ec13 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -69,13 +69,13 @@ int dram_init_banksize(void)
 {
 	u64 high_mem_size;
 
-	gd->bd->bi_dram[0].start = 0;
-	gd->bd->bi_dram[0].size = qemu_get_low_memory_size();
+	gd->bi_dram[0].start = 0;
+	gd->bi_dram[0].size = qemu_get_low_memory_size();
 
 	high_mem_size = qemu_get_high_memory_size();
 	if (high_mem_size) {
-		gd->bd->bi_dram[1].start = SZ_4G;
-		gd->bd->bi_dram[1].size = high_mem_size;
+		gd->bi_dram[1].start = SZ_4G;
+		gd->bi_dram[1].size = high_mem_size;
 	}
 
 	return 0;
diff --git a/arch/x86/cpu/quark/dram.c b/arch/x86/cpu/quark/dram.c
index 34e576940d4f..18151fefca39 100644
--- a/arch/x86/cpu/quark/dram.c
+++ b/arch/x86/cpu/quark/dram.c
@@ -169,8 +169,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = 0;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = 0;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/arch/x86/cpu/slimbootloader/sdram.c b/arch/x86/cpu/slimbootloader/sdram.c
index 75ca5273625c..b490d7c15d1f 100644
--- a/arch/x86/cpu/slimbootloader/sdram.c
+++ b/arch/x86/cpu/slimbootloader/sdram.c
@@ -129,8 +129,8 @@ int dram_init_banksize(void)
 		return 0;
 
 	/* simply use a single bank to have whole size for now */
-	gd->bd->bi_dram[0].start = 0;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = 0;
+	gd->bi_dram[0].size = gd->ram_size;
 	return 0;
 }
 
diff --git a/arch/x86/cpu/tangier/sdram.c b/arch/x86/cpu/tangier/sdram.c
index 6192f2296b80..114563c2a905 100644
--- a/arch/x86/cpu/tangier/sdram.c
+++ b/arch/x86/cpu/tangier/sdram.c
@@ -160,8 +160,8 @@ static int sfi_get_bank_size(void)
 		if (mentry->type != SFI_MEM_CONV)
 			continue;
 
-		gd->bd->bi_dram[bank].start = mentry->phys_start;
-		gd->bd->bi_dram[bank].size = mentry->pages << 12;
+		gd->bi_dram[bank].start = mentry->phys_start;
+		gd->bi_dram[bank].size = mentry->pages << 12;
 		bank++;
 	}
 
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 7a94dc877e31..7bdf42f5e7cf 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -55,14 +55,13 @@ void bootm_announce_and_cleanup(void)
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
 int arch_fixup_memory_node(void *blob)
 {
-	struct bd_info	*bd = gd->bd;
 	int bank;
 	u64 start[CONFIG_NR_DRAM_BANKS];
 	u64 size[CONFIG_NR_DRAM_BANKS];
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] = bd->bi_dram[bank].start;
-		size[bank] = bd->bi_dram[bank].size;
+		start[bank] = gd->bi_dram[bank].start;
+		size[bank] = gd->bi_dram[bank].size;
 	}
 
 	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
diff --git a/arch/x86/lib/fsp/fsp_dram.c b/arch/x86/lib/fsp/fsp_dram.c
index 730721dc1768..dfcd4c345ad7 100644
--- a/arch/x86/lib/fsp/fsp_dram.c
+++ b/arch/x86/lib/fsp/fsp_dram.c
@@ -64,8 +64,8 @@ int dram_init_banksize(void)
 	update_mtrr = CONFIG_IS_ENABLED(FSP_VERSION2);
 
 	if (!ll_boot_init()) {
-		gd->bd->bi_dram[0].start = 0;
-		gd->bd->bi_dram[0].size = gd->ram_size;
+		gd->bi_dram[0].start = 0;
+		gd->bi_dram[0].size = gd->ram_size;
 
 		if (update_mtrr)
 			mtrr_add_request(MTRR_TYPE_WRBACK, 0, gd->ram_size);
@@ -89,21 +89,21 @@ int dram_init_banksize(void)
 			mtrr_top = max(mtrr_top,
 				       res_desc->phys_start + res_desc->len);
 		} else {
-			gd->bd->bi_dram[bank].start = res_desc->phys_start;
-			gd->bd->bi_dram[bank].size = res_desc->len;
+			gd->bi_dram[bank].start = res_desc->phys_start;
+			gd->bi_dram[bank].size = res_desc->len;
 			if (update_mtrr)
 				mtrr_add_request(MTRR_TYPE_WRBACK,
 						 res_desc->phys_start,
 						 res_desc->len);
 			log_debug("ram %llx %llx\n",
-				  gd->bd->bi_dram[bank].start,
-				  gd->bd->bi_dram[bank].size);
+				  gd->bi_dram[bank].start,
+				  gd->bi_dram[bank].size);
 		}
 	}
 
 	/* Add the memory below 4GB */
-	gd->bd->bi_dram[0].start = 0;
-	gd->bd->bi_dram[0].size = low_end;
+	gd->bi_dram[0].start = 0;
+	gd->bi_dram[0].size = low_end;
 
 	/*
 	 * Set up an MTRR to the top of low, reserved memory. This is necessary
@@ -184,7 +184,7 @@ unsigned int install_e820_map(unsigned int max_entries,
 #if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_USE_HOB)
 int handoff_arch_save(struct spl_handoff *ho)
 {
-	ho->arch.usable_ram_top = gd->bd->bi_dram[0].size;
+	ho->arch.usable_ram_top = gd->bi_dram[0].size;
 	ho->arch.hob_list = gd->arch.hob_list;
 
 	return 0;
diff --git a/board/CZ.NIC/turris_1x/turris_1x.c b/board/CZ.NIC/turris_1x/turris_1x.c
index 2f9557a4170f..22fba5ba31fd 100644
--- a/board/CZ.NIC/turris_1x/turris_1x.c
+++ b/board/CZ.NIC/turris_1x/turris_1x.c
@@ -42,9 +42,9 @@ int dram_init_banksize(void)
 
 	static_assert(CONFIG_NR_DRAM_BANKS >= 3);
 
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
-	size -= gd->bd->bi_dram[0].size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = get_effective_memsize();
+	size -= gd->bi_dram[0].size;
 
 	/* Note: This address space is not mapped via TLB entries in U-Boot */
 
@@ -68,16 +68,16 @@ int dram_init_banksize(void)
 
 	if (size > 0) {
 		/* Free space between PCIe bus 3 MEM and NOR */
-		gd->bd->bi_dram[1].start = 0xc0200000;
-		gd->bd->bi_dram[1].size = min(size, 0xef000000 - gd->bd->bi_dram[1].start);
-		size -= gd->bd->bi_dram[1].size;
+		gd->bi_dram[1].start = 0xc0200000;
+		gd->bi_dram[1].size = min(size, 0xef000000 - gd->bi_dram[1].start);
+		size -= gd->bi_dram[1].size;
 	}
 
 	if (size > 0) {
 		/* Free space between NOR and NAND */
-		gd->bd->bi_dram[2].start = 0xf0000000;
-		gd->bd->bi_dram[2].size = min(size, 0xff800000 - gd->bd->bi_dram[2].start);
-		size -= gd->bd->bi_dram[2].size;
+		gd->bi_dram[2].start = 0xf0000000;
+		gd->bi_dram[2].size = min(size, 0xff800000 - gd->bi_dram[2].start);
+		size -= gd->bi_dram[2].size;
 	}
 #else
 	puts("\n\n!!! TODO: fix sdcard >2GB RAM\n\n\n");
@@ -231,8 +231,8 @@ void ft_memory_setup(void *blob, struct bd_info *bd)
 
 	if (!env_get("bootm_low") && !env_get("bootm_size")) {
 		for (count = 0; count < CONFIG_NR_DRAM_BANKS; count++) {
-			start[count] = gd->bd->bi_dram[count].start;
-			size[count] = gd->bd->bi_dram[count].size;
+			start[count] = gd->bi_dram[count].start;
+			size[count] = gd->bi_dram[count].size;
 			if (!size[count])
 				break;
 		}
@@ -452,13 +452,13 @@ static void recalculate_used_pcie_mem(void)
 	size = gd->ram_size;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		size -= gd->bd->bi_dram[i].size;
+		size -= gd->bi_dram[i].size;
 
 	if (size == 0)
 		return;
 
 	e = find_law_by_addr_id(CFG_SYS_PCIE3_MEM_PHYS, LAW_TRGT_IF_PCIE_3);
-	if (e.index < 0 && gd->bd->bi_dram[1].size > 0) {
+	if (e.index < 0 && gd->bi_dram[1].size > 0) {
 		/*
 		 * If there is no LAW for PCIe 3 MEM then 3rd PCIe controller
 		 * is inactive, which is the case for Turris 1.0 boards. So
@@ -471,8 +471,8 @@ static void recalculate_used_pcie_mem(void)
 		printf("Reserving unused ");
 		print_size(bank_size, "");
 		printf(" of PCIe 3 MEM for DDR RAM\n");
-		gd->bd->bi_dram[1].start -= bank_size;
-		gd->bd->bi_dram[1].size += bank_size;
+		gd->bi_dram[1].start -= bank_size;
+		gd->bi_dram[1].size += bank_size;
 		size -= bank_size;
 		if (size == 0)
 			return;
@@ -534,9 +534,9 @@ static void recalculate_used_pcie_mem(void)
 		printf("Reserving unused ");
 		print_size(free_size2, "");
 		printf(" of PCIe 2 MEM for DDR RAM\n");
-		gd->bd->bi_dram[i].start = free_start2;
-		gd->bd->bi_dram[i].size = min(size, free_size2);
-		size -= gd->bd->bi_dram[i].start;
+		gd->bi_dram[i].start = free_start2;
+		gd->bi_dram[i].size = min(size, free_size2);
+		size -= gd->bi_dram[i].start;
 		i++;
 		if (size == 0)
 			return;
@@ -548,9 +548,9 @@ static void recalculate_used_pcie_mem(void)
 		printf("Reserving unused ");
 		print_size(free_size1, "");
 		printf(" of PCIe 1 MEM for DDR RAM\n");
-		gd->bd->bi_dram[i].start = free_start1;
-		gd->bd->bi_dram[i].size = min(size, free_size1);
-		size -= gd->bd->bi_dram[i].size;
+		gd->bi_dram[i].start = free_start1;
+		gd->bi_dram[i].size = min(size, free_size1);
+		size -= gd->bi_dram[i].size;
 		i++;
 		if (size == 0)
 			return;
diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 16d0e679c3e2..3e8c0426f310 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -86,8 +86,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/armltd/integrator/integrator.c b/board/armltd/integrator/integrator.c
index eaf87e3bfe30..1dc7169e4eda 100644
--- a/board/armltd/integrator/integrator.c
+++ b/board/armltd/integrator/integrator.c
@@ -137,7 +137,7 @@ int misc_init_r (void)
 
 int dram_init (void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 #ifdef CONFIG_CM_SPD_DETECT
 	{
 extern void dram_query(void);
@@ -170,7 +170,7 @@ extern void dram_query(void);
 				    PHYS_SDRAM_1_SIZE);
 #endif /* CM_SPD_DETECT */
 	/* We only have one bank of RAM, set it to whatever was detected */
-	gd->bd->bi_dram[0].size	 = gd->ram_size;
+	gd->bi_dram[0].size	 = gd->ram_size;
 
 	return 0;
 }
diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index 12bb6defab25..73378a4bcdd4 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -89,9 +89,9 @@ void build_mem_map(void)
 		 * The first node is for I/O device, start from node 1 for
 		 * updating DRAM info.
 		 */
-		mem_map[i + 1].virt = gd->bd->bi_dram[i].start;
-		mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
-		mem_map[i + 1].size = gd->bd->bi_dram[i].size;
+		mem_map[i + 1].virt = gd->bi_dram[i].start;
+		mem_map[i + 1].phys = gd->bi_dram[i].start;
+		mem_map[i + 1].size = gd->bi_dram[i].size;
 		mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 				       PTE_BLOCK_INNER_SHARE;
 	}
diff --git a/board/armltd/vexpress/vexpress_common.c b/board/armltd/vexpress/vexpress_common.c
index 3833af59b09a..4b1e569b0707 100644
--- a/board/armltd/vexpress/vexpress_common.c
+++ b/board/armltd/vexpress/vexpress_common.c
@@ -79,11 +79,11 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size =
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size =
 			get_ram_size((long *)PHYS_SDRAM_1, PHYS_SDRAM_1_SIZE);
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size =
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size =
 			get_ram_size((long *)PHYS_SDRAM_2, PHYS_SDRAM_2_SIZE);
 
 	return 0;
diff --git a/board/atmel/common/video_display.c b/board/atmel/common/video_display.c
index 771888205814..553f5cbf9fcd 100644
--- a/board/atmel/common/video_display.c
+++ b/board/atmel/common/video_display.c
@@ -40,7 +40,7 @@ int at91_video_show_board_info(void)
 
 	dram_size = 0;
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		dram_size += gd->bd->bi_dram[i].size;
+		dram_size += gd->bi_dram[i].size;
 
 	nand_size = 0;
 #ifdef CONFIG_NAND_ATMEL
diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
index 3393478e4c8c..82d1152f969c 100644
--- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
+++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
@@ -71,7 +71,7 @@ int misc_init_r(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	board_leds_init();
 
diff --git a/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
index 4e7c5667e214..5596dd9469bf 100644
--- a/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
+++ b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
@@ -50,7 +50,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	return 0;
 }
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index bf54fc33df4b..0b21065c6060 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -71,7 +71,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	rgb_leds_init();
 
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 897fab58ebae..82516a6d1ba1 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -65,7 +65,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	rgb_leds_init();
 
diff --git a/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c b/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
index 8759ff6f01ac..83d443fea5d2 100644
--- a/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
+++ b/board/atmel/sama5d29_curiosity/sama5d29_curiosity.c
@@ -65,7 +65,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	rgb_leds_init();
 
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index eca5b2bf1076..8bb3d7b0efa4 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -70,7 +70,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	rgb_leds_init();
 
diff --git a/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
index 713b1b9d9591..fe29b27f2c31 100644
--- a/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
+++ b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
@@ -57,7 +57,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	board_leds_init();
 
diff --git a/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
index b05c9754c964..08765e08f520 100644
--- a/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
+++ b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
@@ -19,7 +19,7 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_init(void)
 {
 	// Address of boot parameters
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	return 0;
 }
diff --git a/board/broadcom/bcmns3/ns3.c b/board/broadcom/bcmns3/ns3.c
index bb2f1e4f62ad..f7c38fc048c6 100644
--- a/board/broadcom/bcmns3/ns3.c
+++ b/board/broadcom/bcmns3/ns3.c
@@ -176,8 +176,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = (BCM_NS3_MEM_END - SZ_16M);
-	gd->bd->bi_dram[0].size = SZ_16M;
+	gd->bi_dram[0].start = (BCM_NS3_MEM_END - SZ_16M);
+	gd->bi_dram[0].size = SZ_16M;
 
 	return 0;
 }
diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 40047cf67830..cc0beb4d8fcc 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -666,34 +666,34 @@ int misc_init_r(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
 
 	switch (gd->ram_size) {
 	case 0x10000000: /* DDR_16BIT_256MB */
-		gd->bd->bi_dram[0].size = 0x10000000;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[0].size = 0x10000000;
+		gd->bi_dram[1].size = 0;
 		break;
 	case 0x20000000: /* DDR_32BIT_512MB */
-		gd->bd->bi_dram[0].size = 0x20000000;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[0].size = 0x20000000;
+		gd->bi_dram[1].size = 0;
 		break;
 	case 0x40000000:
 		if (is_cpu_type(MXC_CPU_MX6SOLO)) { /* DDR_32BIT_1GB */
-			gd->bd->bi_dram[0].size = 0x20000000;
-			gd->bd->bi_dram[1].size = 0x20000000;
+			gd->bi_dram[0].size = 0x20000000;
+			gd->bi_dram[1].size = 0x20000000;
 		} else { /* DDR_64BIT_1GB */
-			gd->bd->bi_dram[0].size = 0x40000000;
-			gd->bd->bi_dram[1].size = 0;
+			gd->bi_dram[0].size = 0x40000000;
+			gd->bi_dram[1].size = 0;
 		}
 		break;
 	case 0x80000000: /* DDR_64BIT_2GB */
-		gd->bd->bi_dram[0].size = 0x40000000;
-		gd->bd->bi_dram[1].size = 0x40000000;
+		gd->bi_dram[0].size = 0x40000000;
+		gd->bi_dram[1].size = 0x40000000;
 		break;
 	case 0xEFF00000: /* DDR_64BIT_4GB */
-		gd->bd->bi_dram[0].size = 0x70000000;
-		gd->bd->bi_dram[1].size = 0x7FF00000;
+		gd->bi_dram[0].size = 0x70000000;
+		gd->bi_dram[1].size = 0x7FF00000;
 		break;
 	}
 
diff --git a/board/elgin/elgin_rv1108/elgin_rv1108.c b/board/elgin/elgin_rv1108/elgin_rv1108.c
index 9fea4f86d5aa..1de3d52fd8ff 100644
--- a/board/elgin/elgin_rv1108/elgin_rv1108.c
+++ b/board/elgin/elgin_rv1108/elgin_rv1108.c
@@ -66,8 +66,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = 0x60000000;
-	gd->bd->bi_dram[0].size = 0x8000000;
+	gd->bi_dram[0].start = 0x60000000;
+	gd->bi_dram[0].size = 0x8000000;
 
 	return 0;
 }
diff --git a/board/esd/meesc/meesc.c b/board/esd/meesc/meesc.c
index dce69abdfd1d..845350751a91 100644
--- a/board/esd/meesc/meesc.c
+++ b/board/esd/meesc/meesc.c
@@ -141,8 +141,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM;
+	gd->bi_dram[0].size = PHYS_SDRAM_SIZE;
 
 	return 0;
 }
diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 4dff32e10d6b..5264efe008be 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -517,17 +517,17 @@ int dram_init_banksize(void)
 	/* set global data memory */
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x00000100;
 
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size  = CFG_SYS_SDRAM_SIZE;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size  = CFG_SYS_SDRAM_SIZE;
 
 	/* Number of Row: 14 bits */
 	if ((reg_val >> 28) == 14)
-		gd->bd->bi_dram[0].size -= 0x20000000;
+		gd->bi_dram[0].size -= 0x20000000;
 
 	/* Number of Memory Chips */
 	if ((reg_val & 0x3) > 1) {
-		gd->bd->bi_dram[1].start = 0x80000000;
-		gd->bd->bi_dram[1].size  = 0x40000000;
+		gd->bi_dram[1].start = 0x80000000;
+		gd->bi_dram[1].size  = 0x40000000;
 	}
 	return 0;
 }
diff --git a/board/ge/mx53ppd/mx53ppd.c b/board/ge/mx53ppd/mx53ppd.c
index cb9b88a1a58e..bffe30a6b8d5 100644
--- a/board/ge/mx53ppd/mx53ppd.c
+++ b/board/ge/mx53ppd/mx53ppd.c
@@ -71,11 +71,11 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = mx53_dram_size[0];
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = mx53_dram_size[0];
 
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = mx53_dram_size[1];
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size = mx53_dram_size[1];
 
 	return 0;
 }
diff --git a/board/hisilicon/hikey/hikey.c b/board/hisilicon/hikey/hikey.c
index 5e60ab9d7b71..b6214e22644b 100644
--- a/board/hisilicon/hikey/hikey.c
+++ b/board/hisilicon/hikey/hikey.c
@@ -456,23 +456,23 @@ int dram_init_banksize(void)
 	 *  0x3e00,0000 - 0x3fff,ffff: OP-TEE
 	*/
 
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = 0x05e00000;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = 0x05e00000;
 
-	gd->bd->bi_dram[1].start = 0x05f00000;
-	gd->bd->bi_dram[1].size = 0x00001000;
+	gd->bi_dram[1].start = 0x05f00000;
+	gd->bi_dram[1].size = 0x00001000;
 
-	gd->bd->bi_dram[2].start = 0x05f02000;
-	gd->bd->bi_dram[2].size = 0x00efd000;
+	gd->bi_dram[2].start = 0x05f02000;
+	gd->bi_dram[2].size = 0x00efd000;
 
-	gd->bd->bi_dram[3].start = 0x06e00000;
-	gd->bd->bi_dram[3].size = 0x0060f000;
+	gd->bi_dram[3].start = 0x06e00000;
+	gd->bi_dram[3].size = 0x0060f000;
 
-	gd->bd->bi_dram[4].start = 0x07410000;
-	gd->bd->bi_dram[4].size = 0x1aaf0000;
+	gd->bi_dram[4].start = 0x07410000;
+	gd->bi_dram[4].size = 0x1aaf0000;
 
-	gd->bd->bi_dram[5].start = 0x22000000;
-	gd->bd->bi_dram[5].size = 0x1c000000;
+	gd->bi_dram[5].start = 0x22000000;
+	gd->bi_dram[5].size = 0x1c000000;
 
 	return 0;
 }
diff --git a/board/hisilicon/hikey960/hikey960.c b/board/hisilicon/hikey960/hikey960.c
index 5029f4edb2af..ac10bc263cd3 100644
--- a/board/hisilicon/hikey960/hikey960.c
+++ b/board/hisilicon/hikey960/hikey960.c
@@ -79,8 +79,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/board/hisilicon/poplar/poplar.c b/board/hisilicon/poplar/poplar.c
index c3ea080ff75a..98eda6b9d848 100644
--- a/board/hisilicon/poplar/poplar.c
+++ b/board/hisilicon/poplar/poplar.c
@@ -87,8 +87,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = KERNEL_TEXT_OFFSET;
-	gd->bd->bi_dram[0].size = gd->ram_size - gd->bd->bi_dram[0].start;
+	gd->bi_dram[0].start = KERNEL_TEXT_OFFSET;
+	gd->bi_dram[0].size = gd->ram_size - gd->bi_dram[0].start;
 
 	return 0;
 }
diff --git a/board/k+p/kp_imx53/kp_imx53.c b/board/k+p/kp_imx53/kp_imx53.c
index efb7b49cbe08..f5f8310adeb0 100644
--- a/board/k+p/kp_imx53/kp_imx53.c
+++ b/board/k+p/kp_imx53/kp_imx53.c
@@ -39,8 +39,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/keymile/pg-wcom-ls102xa/ddr.c b/board/keymile/pg-wcom-ls102xa/ddr.c
index 51938a1b4d88..1a480abd720d 100644
--- a/board/keymile/pg-wcom-ls102xa/ddr.c
+++ b/board/keymile/pg-wcom-ls102xa/ddr.c
@@ -84,8 +84,8 @@ int fsl_initdram(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/board/kontron/sl28/sl28.c b/board/kontron/sl28/sl28.c
index 8a9502037fb6..fb4a57e1486c 100644
--- a/board/kontron/sl28/sl28.c
+++ b/board/kontron/sl28/sl28.c
@@ -175,8 +175,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	/* fixup DT for the two GPP DDR banks */
 	for (i = 0; i < nbanks; i++) {
-		base[i] = gd->bd->bi_dram[i].start;
-		size[i] = gd->bd->bi_dram[i].size;
+		base[i] = gd->bi_dram[i].start;
+		size[i] = gd->bi_dram[i].size;
 	}
 
 	fdt_fixup_memory_banks(blob, base, size, nbanks);
diff --git a/board/kontron/sl28/spl_atf.c b/board/kontron/sl28/spl_atf.c
index 0710316a48bc..a5e4f072d28c 100644
--- a/board/kontron/sl28/spl_atf.c
+++ b/board/kontron/sl28/spl_atf.c
@@ -36,9 +36,9 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
 
 	dram_regions_info.num_dram_regions = CONFIG_NR_DRAM_BANKS;
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		dram_regions_info.region[i].addr = gd->bd->bi_dram[i].start;
-		dram_regions_info.region[i].size = gd->bd->bi_dram[i].size;
-		dram_regions_info.total_dram_size += gd->bd->bi_dram[i].size;
+		dram_regions_info.region[i].addr = gd->bi_dram[i].start;
+		dram_regions_info.region[i].size = gd->bi_dram[i].size;
+		dram_regions_info.total_dram_size += gd->bi_dram[i].size;
 	}
 
 	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
index c4b6c37e4959..242cb5ca3734 100644
--- a/board/liebherr/btt/btt.c
+++ b/board/liebherr/btt/btt.c
@@ -239,7 +239,7 @@ int spl_start_uboot(void)
 
 static const char *get_board_name(void)
 {
-	if (gd->bd->bi_dram[0].size == SZ_128M)
+	if (gd->bi_dram[0].size == SZ_128M)
 		return STR_BTTC;
 
 	return STR_BTT3;
diff --git a/board/menlo/m53menlo/m53menlo.c b/board/menlo/m53menlo/m53menlo.c
index fc76d5765fa7..9b2e4faa770a 100644
--- a/board/menlo/m53menlo/m53menlo.c
+++ b/board/menlo/m53menlo/m53menlo.c
@@ -69,11 +69,11 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = mx53_dram_size[0];
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = mx53_dram_size[0];
 
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = mx53_dram_size[1];
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size = mx53_dram_size[1];
 
 	return 0;
 }
diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 05c4dd187fe3..292318fd884c 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -57,7 +57,7 @@ int dram_init_banksize(void)
 {
 	phys_size_t ram_size = gd->ram_size;
 
-	gd->bd->bi_dram[0].start = 0;
+	gd->bi_dram[0].start = 0;
 
 	#if defined(CONFIG_SYS_MEM_TOP_HIDE)
 		ram_size += CONFIG_SYS_MEM_TOP_HIDE;
@@ -69,25 +69,25 @@ int dram_init_banksize(void)
 	case DRAM_1GB_SIZE:
 	case DRAM_2GB_ECC_SIZE:
 	case DRAM_2GB_SIZE:
-		gd->bd->bi_dram[0].size = ram_size;
-		gd->bd->bi_dram[1].start = 0;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[0].size = ram_size;
+		gd->bi_dram[1].start = 0;
+		gd->bi_dram[1].size = 0;
 		break;
 	case DRAM_4GB_ECC_SIZE:
-		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
-		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
-		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE -
+		gd->bi_dram[0].size = DRAM_2GB_SIZE;
+		gd->bi_dram[1].start = DRAM_4GB_SIZE;
+		gd->bi_dram[1].size = DRAM_2GB_SIZE -
 			(DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
 		break;
 	case DRAM_4GB_SIZE:
-		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
-		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
-		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
+		gd->bi_dram[0].size = DRAM_2GB_SIZE;
+		gd->bi_dram[1].start = DRAM_4GB_SIZE;
+		gd->bi_dram[1].size = DRAM_2GB_SIZE;
 		break;
 	default:
-		gd->bd->bi_dram[0].size = DRAM_1GB_SIZE;
-		gd->bd->bi_dram[1].start = 0;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[0].size = DRAM_1GB_SIZE;
+		gd->bi_dram[1].start = 0;
+		gd->bi_dram[1].size = 0;
 		break;
 	}
 
diff --git a/board/nxp/imxrt1020-evk/imxrt1020-evk.c b/board/nxp/imxrt1020-evk/imxrt1020-evk.c
index 11dbef846881..bc8cd8e674d6 100644
--- a/board/nxp/imxrt1020-evk/imxrt1020-evk.c
+++ b/board/nxp/imxrt1020-evk/imxrt1020-evk.c
@@ -73,7 +73,7 @@ u32 spl_boot_device(void)
 
 int board_init(void)
 {
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	return 0;
 }
diff --git a/board/nxp/imxrt1050-evk/imxrt1050-evk.c b/board/nxp/imxrt1050-evk/imxrt1050-evk.c
index 056489932ac7..8990be392b80 100644
--- a/board/nxp/imxrt1050-evk/imxrt1050-evk.c
+++ b/board/nxp/imxrt1050-evk/imxrt1050-evk.c
@@ -78,7 +78,7 @@ u32 spl_boot_device(void)
 
 int board_init(void)
 {
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	return 0;
 }
diff --git a/board/nxp/imxrt1170-evk/imxrt1170-evk.c b/board/nxp/imxrt1170-evk/imxrt1170-evk.c
index 047aea8181ae..b7aeb0f4c738 100644
--- a/board/nxp/imxrt1170-evk/imxrt1170-evk.c
+++ b/board/nxp/imxrt1170-evk/imxrt1170-evk.c
@@ -73,7 +73,7 @@ u32 spl_boot_device(void)
 
 int board_init(void)
 {
-	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+	gd->bd->bi_boot_params = gd->bi_dram[0].start + 0x100;
 
 	return 0;
 }
diff --git a/board/nxp/ls1021aqds/ddr.c b/board/nxp/ls1021aqds/ddr.c
index fd897e832c82..4f860697684e 100644
--- a/board/nxp/ls1021aqds/ddr.c
+++ b/board/nxp/ls1021aqds/ddr.c
@@ -192,8 +192,8 @@ int fsl_initdram(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return 0;
 }
diff --git a/board/nxp/ls1028a/ls1028a.c b/board/nxp/ls1028a/ls1028a.c
index db94d9c1fa80..33c01ef5253f 100644
--- a/board/nxp/ls1028a/ls1028a.c
+++ b/board/nxp/ls1028a/ls1028a.c
@@ -152,7 +152,7 @@ int board_early_init_f(void)
 void detail_board_ddr_info(void)
 {
 	puts("\nDDR    ");
-	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
+	print_size(gd->bi_dram[0].size + gd->bi_dram[1].size, "");
 	print_ddr_info(0);
 }
 
@@ -205,10 +205,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	ft_cpu_setup(blob, bd);
 
 	/* fixup DT for the two GPP DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 #ifdef CONFIG_RESV_RAM
 	/* reduce size if reserved memory is within this bank */
diff --git a/board/nxp/ls1043aqds/ls1043aqds.c b/board/nxp/ls1043aqds/ls1043aqds.c
index f043599fbb88..f746120d09b8 100644
--- a/board/nxp/ls1043aqds/ls1043aqds.c
+++ b/board/nxp/ls1043aqds/ls1043aqds.c
@@ -542,10 +542,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u8 reg;
 
 	/* fixup DT for the two DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
diff --git a/board/nxp/ls1043ardb/ls1043ardb.c b/board/nxp/ls1043ardb/ls1043ardb.c
index bba041065b5c..513d548f9672 100644
--- a/board/nxp/ls1043ardb/ls1043ardb.c
+++ b/board/nxp/ls1043ardb/ls1043ardb.c
@@ -305,10 +305,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u64 size[CONFIG_NR_DRAM_BANKS];
 
 	/* fixup DT for the two DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
diff --git a/board/nxp/ls1046afrwy/ls1046afrwy.c b/board/nxp/ls1046afrwy/ls1046afrwy.c
index 8889c24f1f0c..4f2b95ea56cc 100644
--- a/board/nxp/ls1046afrwy/ls1046afrwy.c
+++ b/board/nxp/ls1046afrwy/ls1046afrwy.c
@@ -198,10 +198,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u64 size[CONFIG_NR_DRAM_BANKS];
 
 	/* fixup DT for the two DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
diff --git a/board/nxp/ls1046aqds/ls1046aqds.c b/board/nxp/ls1046aqds/ls1046aqds.c
index 7df125508686..526925178c7e 100644
--- a/board/nxp/ls1046aqds/ls1046aqds.c
+++ b/board/nxp/ls1046aqds/ls1046aqds.c
@@ -426,10 +426,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u8 reg;
 
 	/* fixup DT for the two DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
diff --git a/board/nxp/ls1046ardb/ls1046ardb.c b/board/nxp/ls1046ardb/ls1046ardb.c
index 83b280f7646a..e845144820ee 100644
--- a/board/nxp/ls1046ardb/ls1046ardb.c
+++ b/board/nxp/ls1046ardb/ls1046ardb.c
@@ -171,10 +171,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u64 size[CONFIG_NR_DRAM_BANKS];
 
 	/* fixup DT for the two DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
diff --git a/board/nxp/ls1088a/ls1088a.c b/board/nxp/ls1088a/ls1088a.c
index 51ec055be63a..eaa65e0dba1e 100644
--- a/board/nxp/ls1088a/ls1088a.c
+++ b/board/nxp/ls1088a/ls1088a.c
@@ -830,7 +830,7 @@ int board_init(void)
 void detail_board_ddr_info(void)
 {
 	puts("\nDDR    ");
-	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
+	print_size(gd->bi_dram[0].size + gd->bi_dram[1].size, "");
 	print_ddr_info(0);
 }
 
@@ -959,8 +959,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	/* fixup DT for the two GPP DDR banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		base[i] = gd->bd->bi_dram[i].start;
-		size[i] = gd->bd->bi_dram[i].size;
+		base[i] = gd->bi_dram[i].start;
+		size[i] = gd->bi_dram[i].size;
 	}
 
 #ifdef CONFIG_RESV_RAM
diff --git a/board/nxp/ls2080aqds/ls2080aqds.c b/board/nxp/ls2080aqds/ls2080aqds.c
index aba0560181af..1f9b64712fc1 100644
--- a/board/nxp/ls2080aqds/ls2080aqds.c
+++ b/board/nxp/ls2080aqds/ls2080aqds.c
@@ -253,12 +253,12 @@ int misc_init_r(void)
 void detail_board_ddr_info(void)
 {
 	puts("\nDDR    ");
-	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
+	print_size(gd->bi_dram[0].size + gd->bi_dram[1].size, "");
 	print_ddr_info(0);
 #ifdef CONFIG_SYS_FSL_HAS_DP_DDR
-	if (soc_has_dp_ddr() && gd->bd->bi_dram[2].size) {
+	if (soc_has_dp_ddr() && gd->bi_dram[2].size) {
 		puts("\nDP-DDR ");
-		print_size(gd->bd->bi_dram[2].size, "");
+		print_size(gd->bi_dram[2].size, "");
 		print_ddr_info(CONFIG_DP_DDR_CTRL);
 	}
 #endif
@@ -302,10 +302,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	ft_cpu_setup(blob, bd);
 
 	/* fixup DT for the two GPP DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 #ifdef CONFIG_RESV_RAM
 	/* reduce size if reserved memory is within this bank */
diff --git a/board/nxp/ls2080ardb/ls2080ardb.c b/board/nxp/ls2080ardb/ls2080ardb.c
index 6f824f57c478..4801cad2d461 100644
--- a/board/nxp/ls2080ardb/ls2080ardb.c
+++ b/board/nxp/ls2080ardb/ls2080ardb.c
@@ -359,12 +359,12 @@ int misc_init_r(void)
 void detail_board_ddr_info(void)
 {
 	puts("\nDDR    ");
-	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
+	print_size(gd->bi_dram[0].size + gd->bi_dram[1].size, "");
 	print_ddr_info(0);
 #ifdef CONFIG_SYS_FSL_HAS_DP_DDR
-	if (soc_has_dp_ddr() && gd->bd->bi_dram[2].size) {
+	if (soc_has_dp_ddr() && gd->bi_dram[2].size) {
 		puts("\nDP-DDR ");
-		print_size(gd->bd->bi_dram[2].size, "");
+		print_size(gd->bi_dram[2].size, "");
 		print_ddr_info(CONFIG_DP_DDR_CTRL);
 	}
 #endif
@@ -487,10 +487,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	size = calloc(total_memory_banks, sizeof(u64));
 
 	/* fixup DT for the two GPP DDR banks */
-	base[0] = gd->bd->bi_dram[0].start;
-	size[0] = gd->bd->bi_dram[0].size;
-	base[1] = gd->bd->bi_dram[1].start;
-	size[1] = gd->bd->bi_dram[1].size;
+	base[0] = gd->bi_dram[0].start;
+	size[0] = gd->bi_dram[0].size;
+	base[1] = gd->bi_dram[1].start;
+	size[1] = gd->bi_dram[1].size;
 
 #ifdef CONFIG_RESV_RAM
 	/* reduce size if reserved memory is within this bank */
diff --git a/board/nxp/lx2160a/lx2160a.c b/board/nxp/lx2160a/lx2160a.c
index 341f82ce7245..8c2722702bec 100644
--- a/board/nxp/lx2160a/lx2160a.c
+++ b/board/nxp/lx2160a/lx2160a.c
@@ -567,7 +567,7 @@ void detail_board_ddr_info(void)
 
 	puts("\nDDR    ");
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		ddr_size += gd->bd->bi_dram[i].size;
+		ddr_size += gd->bi_dram[i].size;
 	print_size(ddr_size, "");
 	print_ddr_info(0);
 }
@@ -800,8 +800,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	/* fixup DT for the three GPP DDR banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		base[i] = gd->bd->bi_dram[i].start;
-		size[i] = gd->bd->bi_dram[i].size;
+		base[i] = gd->bi_dram[i].start;
+		size[i] = gd->bi_dram[i].size;
 	}
 
 #ifdef CONFIG_RESV_RAM
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 3cdcbf2ecc97..6f29c411d53d 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -93,7 +93,7 @@ int dram_init_banksize(void)
 {
 	u8 ram_size;
 
-	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
+	memset(gd->bi_dram, 0, sizeof(gd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
 
 	if (!IS_ENABLED(CONFIG_CPU_V7R))
 		return fdtdec_setup_memory_banksize();
@@ -101,34 +101,34 @@ int dram_init_banksize(void)
 	ram_size = phytec_get_am62_ddr_size_default();
 	switch (ram_size) {
 	case EEPROM_RAM_SIZE_1GB:
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x40000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x40000000;
 		gd->ram_size = 0x40000000;
 		break;
 
 	case EEPROM_RAM_SIZE_2GB:
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x80000000;
 		gd->ram_size = 0x80000000;
 		break;
 
 	case EEPROM_RAM_SIZE_4GB:
 		/* Bank 0 declares the memory available in the DDR low region */
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x80000000;
 		gd->ram_size = 0x80000000;
 
 #ifdef CONFIG_PHYS_64BIT
 		/* Bank 1 declares the memory available in the DDR upper region */
-		gd->bd->bi_dram[1].start = 0x880000000;
-		gd->bd->bi_dram[1].size = 0x80000000;
+		gd->bi_dram[1].start = 0x880000000;
+		gd->bi_dram[1].size = 0x80000000;
 		gd->ram_size = 0x100000000;
 #endif
 		break;
 	default:
 		/* Continue with default 2GB setup */
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x80000000;
 		gd->ram_size = 0x80000000;
 		printf("DDR size %d is not supported\n", ram_size);
 	}
@@ -186,8 +186,8 @@ int do_board_detect(void)
 	dram_init_banksize();
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] = gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
+		start[bank] = gd->bi_dram[bank].start;
+		size[bank] = gd->bi_dram[bank].size;
 	}
 
 	ret = fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
index 114aa2170235..82baabb95265 100644
--- a/board/phytec/phycore_am64x/phycore-am64x.c
+++ b/board/phytec/phycore_am64x/phycore-am64x.c
@@ -66,7 +66,7 @@ int dram_init_banksize(void)
 {
 	u8 ram_size;
 
-	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
+	memset(gd->bi_dram, 0, sizeof(gd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
 
 	if (!IS_ENABLED(CONFIG_CPU_V7R))
 		return fdtdec_setup_memory_banksize();
@@ -74,21 +74,21 @@ int dram_init_banksize(void)
 	ram_size = phytec_get_am64_ddr_size_default();
 	switch (ram_size) {
 	case EEPROM_RAM_SIZE_1GB:
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x40000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x40000000;
 		gd->ram_size = 0x40000000;
 		break;
 
 	case EEPROM_RAM_SIZE_2GB:
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x80000000;
 		gd->ram_size = 0x80000000;
 		break;
 
 	default:
 		/* Continue with default 2GB setup */
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = 0x80000000;
 		gd->ram_size = 0x80000000;
 		printf("DDR size %d is not supported\n", ram_size);
 	}
@@ -109,8 +109,8 @@ int do_board_detect(void)
 	dram_init_banksize();
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] = gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
+		start[bank] = gd->bi_dram[bank].start;
+		size[bank] = gd->bi_dram[bank].size;
 	}
 
 	return fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
diff --git a/board/phytium/durian/durian.c b/board/phytium/durian/durian.c
index 9fc63febdac9..53d16767e9a6 100644
--- a/board/phytium/durian/durian.c
+++ b/board/phytium/durian/durian.c
@@ -31,8 +31,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size =  PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size =  PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/phytium/pe2201/pe2201.c b/board/phytium/pe2201/pe2201.c
index 6824454cdf4f..ab0a611865cf 100644
--- a/board/phytium/pe2201/pe2201.c
+++ b/board/phytium/pe2201/pe2201.c
@@ -44,8 +44,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 7f69e5b61639..431e5f702be9 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -356,9 +356,9 @@ int dram_init_banksize(void)
 
 	/* Update gd->ram_size to reflect total RAM across all banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (gd->bd->bi_dram[i].size == 0)
+		if (gd->bi_dram[i].size == 0)
 			break;
-		total_size += gd->bd->bi_dram[i].size;
+		total_size += gd->bi_dram[i].size;
 	}
 	gd->ram_size = total_size;
 
diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/rcar64-common.c
index bcb037924948..cad2fcaeca6f 100644
--- a/board/renesas/common/rcar64-common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -48,15 +48,15 @@ int dram_init_banksize(void)
 		return 0;
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (gd->bd->bi_dram[bank].start != 0x48000000)
+		if (gd->bi_dram[bank].start != 0x48000000)
 			continue;
 
 		/*
 		 * If this U-Boot runs in EL3, make the bottom 128 MiB
 		 * available for loading of follow up firmware blobs.
 		 */
-		gd->bd->bi_dram[bank].start -= 0x8000000;
-		gd->bd->bi_dram[bank].size += 0x8000000;
+		gd->bi_dram[bank].start -= 0x8000000;
+		gd->bi_dram[bank].size += 0x8000000;
 		break;
 	}
 
diff --git a/board/renesas/genmai/genmai.c b/board/renesas/genmai/genmai.c
index 8153aed15e3d..5470ed38ad94 100644
--- a/board/renesas/genmai/genmai.c
+++ b/board/renesas/genmai/genmai.c
@@ -43,7 +43,7 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = gd->ram_size;
 	return 0;
 }
diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index f5b1a5614b10..9a651d9835a0 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -261,10 +261,10 @@ void renesas_dram_init_banksize(void)
 
 	/* 16 GiB device, adjust memory map. */
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (gd->bd->bi_dram[bank].start == 0x480000000ULL)
-			gd->bd->bi_dram[bank].size = 0x180000000ULL;
-		else if (gd->bd->bi_dram[bank].start == 0x600000000ULL)
-			gd->bd->bi_dram[bank].size = 0x200000000ULL;
+		if (gd->bi_dram[bank].start == 0x480000000ULL)
+			gd->bi_dram[bank].size = 0x180000000ULL;
+		else if (gd->bi_dram[bank].start == 0x600000000ULL)
+			gd->bi_dram[bank].size = 0x200000000ULL;
 	}
 }
 
diff --git a/board/ronetix/pm9261/pm9261.c b/board/ronetix/pm9261/pm9261.c
index ee578749bce7..84b667d20dc0 100644
--- a/board/ronetix/pm9261/pm9261.c
+++ b/board/ronetix/pm9261/pm9261.c
@@ -108,8 +108,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM;
+	gd->bi_dram[0].size = PHYS_SDRAM_SIZE;
 
 	return 0;
 }
diff --git a/board/ronetix/pm9263/pm9263.c b/board/ronetix/pm9263/pm9263.c
index 8125f064cf11..29288ea3c912 100644
--- a/board/ronetix/pm9263/pm9263.c
+++ b/board/ronetix/pm9263/pm9263.c
@@ -102,8 +102,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM;
+	gd->bi_dram[0].size = PHYS_SDRAM_SIZE;
 
 	return 0;
 }
diff --git a/board/ronetix/pm9g45/pm9g45.c b/board/ronetix/pm9g45/pm9g45.c
index 5d5edd9f2530..93bdcd294a55 100644
--- a/board/ronetix/pm9g45/pm9g45.c
+++ b/board/ronetix/pm9g45/pm9g45.c
@@ -150,8 +150,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = CFG_SYS_SDRAM_SIZE;
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = CFG_SYS_SDRAM_SIZE;
 
 	return 0;
 }
diff --git a/board/samsung/arndale/arndale.c b/board/samsung/arndale/arndale.c
index e70b4a82687c..83d9c530f96f 100644
--- a/board/samsung/arndale/arndale.c
+++ b/board/samsung/arndale/arndale.c
@@ -67,8 +67,8 @@ int dram_init_banksize(void)
 		addr = CFG_SYS_SDRAM_BASE + (i * SDRAM_BANK_SIZE);
 		size = get_ram_size((long *)addr, SDRAM_BANK_SIZE);
 
-		gd->bd->bi_dram[i].start = addr;
-		gd->bd->bi_dram[i].size = size;
+		gd->bi_dram[i].start = addr;
+		gd->bi_dram[i].size = size;
 	}
 
 	return 0;
diff --git a/board/samsung/common/board.c b/board/samsung/common/board.c
index eed1c2450fa6..d42a49513698 100644
--- a/board/samsung/common/board.c
+++ b/board/samsung/common/board.c
@@ -115,7 +115,7 @@ int board_init(void)
 	ulong size = CONFIG_SYS_MEM_TOP_HIDE;
 
 	gd->ram_size -= size;
-	gd->bd->bi_dram[CONFIG_NR_DRAM_BANKS - 1].size -= size;
+	gd->bi_dram[CONFIG_NR_DRAM_BANKS - 1].size -= size;
 #endif
 	exynos_init();
 
@@ -143,8 +143,8 @@ int dram_init_banksize(void)
 		addr = CFG_SYS_SDRAM_BASE + (i * SDRAM_BANK_SIZE);
 		size = get_ram_size((long *)addr, SDRAM_BANK_SIZE);
 
-		gd->bd->bi_dram[i].start = addr;
-		gd->bd->bi_dram[i].size = size;
+		gd->bi_dram[i].start = addr;
+		gd->bi_dram[i].size = size;
 	}
 
 	return 0;
diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 6b2b15236636..e15fcef88457 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -346,8 +346,8 @@ int dram_init_banksize(void)
 	unsigned int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		gd->bd->bi_dram[i].start = mem_map[i + 1].phys;
-		gd->bd->bi_dram[i].size = mem_map[i + 1].size;
+		gd->bi_dram[i].start = mem_map[i + 1].phys;
+		gd->bi_dram[i].size = mem_map[i + 1].size;
 	}
 
 	return 0;
diff --git a/board/samsung/goni/goni.c b/board/samsung/goni/goni.c
index a1047f3fd2a2..e7115d368d9d 100644
--- a/board/samsung/goni/goni.c
+++ b/board/samsung/goni/goni.c
@@ -43,12 +43,12 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = PHYS_SDRAM_2_SIZE;
-	gd->bd->bi_dram[2].start = PHYS_SDRAM_3;
-	gd->bd->bi_dram[2].size = PHYS_SDRAM_3_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size = PHYS_SDRAM_2_SIZE;
+	gd->bi_dram[2].start = PHYS_SDRAM_3;
+	gd->bi_dram[2].size = PHYS_SDRAM_3_SIZE;
 
 	return 0;
 }
diff --git a/board/samsung/smdkc100/smdkc100.c b/board/samsung/smdkc100/smdkc100.c
index 7d0b0fcb0ae1..99f82c3f32fa 100644
--- a/board/samsung/smdkc100/smdkc100.c
+++ b/board/samsung/smdkc100/smdkc100.c
@@ -56,8 +56,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/samsung/smdkv310/smdkv310.c b/board/samsung/smdkv310/smdkv310.c
index 5a4874b29cdf..4a65cb94f5f1 100644
--- a/board/samsung/smdkv310/smdkv310.c
+++ b/board/samsung/smdkv310/smdkv310.c
@@ -57,17 +57,17 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = get_ram_size((long *)PHYS_SDRAM_1,
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = get_ram_size((long *)PHYS_SDRAM_1,
 							PHYS_SDRAM_1_SIZE);
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = get_ram_size((long *)PHYS_SDRAM_2,
+	gd->bi_dram[1].start = PHYS_SDRAM_2;
+	gd->bi_dram[1].size = get_ram_size((long *)PHYS_SDRAM_2,
 							PHYS_SDRAM_2_SIZE);
-	gd->bd->bi_dram[2].start = PHYS_SDRAM_3;
-	gd->bd->bi_dram[2].size = get_ram_size((long *)PHYS_SDRAM_3,
+	gd->bi_dram[2].start = PHYS_SDRAM_3;
+	gd->bi_dram[2].size = get_ram_size((long *)PHYS_SDRAM_3,
 							PHYS_SDRAM_3_SIZE);
-	gd->bd->bi_dram[3].start = PHYS_SDRAM_4;
-	gd->bd->bi_dram[3].size = get_ram_size((long *)PHYS_SDRAM_4,
+	gd->bi_dram[3].start = PHYS_SDRAM_4;
+	gd->bi_dram[3].size = get_ram_size((long *)PHYS_SDRAM_4,
 							PHYS_SDRAM_4_SIZE);
 
 	return 0;
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index c75f4a0d084d..afc19af6f24b 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -397,20 +397,20 @@ int dram_init_banksize(void)
 
 	if (gd->ram_size > SZ_2G) {
 		/* Bank 0 declares the memory available in the DDR low region */
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = SZ_2G;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = SZ_2G;
 
 		/* Bank 1 declares the memory available in the DDR high region */
-		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
-		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+		gd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+		gd->bi_dram[1].size = gd->ram_size - SZ_2G;
 	} else {
 		/* Bank 0 declares the memory available in the DDR low region */
-		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-		gd->bd->bi_dram[0].size = gd->ram_size;
+		gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bi_dram[0].size = gd->ram_size;
 
 		/* Bank 1 declares the memory available in the DDR high region */
-		gd->bd->bi_dram[1].start = 0;
-		gd->bd->bi_dram[1].size = 0;
+		gd->bi_dram[1].start = 0;
+		gd->bi_dram[1].size = 0;
 	}
 
 	return 0;
diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
index 556a9ed527e7..66f9a344331d 100644
--- a/board/socionext/developerbox/developerbox.c
+++ b/board/socionext/developerbox/developerbox.c
@@ -170,11 +170,11 @@ int dram_init_banksize(void)
 	struct draminfo_entry *ent = synquacer_draminfo->entry;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(gd->bd->bi_dram); i++) {
+	for (i = 0; i < ARRAY_SIZE(gd->bi_dram); i++) {
 		if (i < synquacer_draminfo->nr_regions) {
 			debug("%s: dram[%d] = %llx@%llx\n", __func__, i, ent[i].size, ent[i].base);
-			gd->bd->bi_dram[i].start = ent[i].base;
-			gd->bd->bi_dram[i].size = ent[i].size;
+			gd->bi_dram[i].start = ent[i].base;
+			gd->bi_dram[i].size = ent[i].size;
 		}
 	}
 
diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
index f5174720434a..1dcca5b369e6 100644
--- a/board/st/stih410-b2260/board.c
+++ b/board/st/stih410-b2260/board.c
@@ -18,8 +18,8 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+	gd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
 
 	return 0;
 }
diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 826c002907d6..5e1dcb8e7fa8 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -70,8 +70,8 @@ int dram_init_banksize(void)
 		if (t->hdr.tag != ATAG_MEM)
 			continue;
 
-		gd->bd->bi_dram[bank].start = t->u.mem.start;
-		gd->bd->bi_dram[bank].size = t->u.mem.size;
+		gd->bi_dram[bank].start = t->u.mem.start;
+		gd->bi_dram[bank].size = t->u.mem.size;
 		if (++bank == CONFIG_NR_DRAM_BANKS)
 			break;
 	}
diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index 0966db2bb620..da6f7c9a6134 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -643,11 +643,11 @@ int dram_init_banksize(void)
 
 	ram_size = board_ti_get_emif_size();
 
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = get_effective_memsize();
 	if (ram_size > CFG_MAX_MEM_MAPPED) {
-		gd->bd->bi_dram[1].start = 0x200000000;
-		gd->bd->bi_dram[1].size = ram_size - CFG_MAX_MEM_MAPPED;
+		gd->bi_dram[1].start = 0x200000000;
+		gd->bi_dram[1].size = ram_size - CFG_MAX_MEM_MAPPED;
 	}
 
 	return 0;
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index a92aa5cfc671..7913265ea8b9 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -117,8 +117,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	}
 
 	nbanks = 1;
-	start[0] = bd->bi_dram[0].start;
-	size[0]  = bd->bi_dram[0].size;
+	start[0] = gd->bi_dram[0].start;
+	size[0]  = gd->bi_dram[0].size;
 
 	/* adjust memory start address for LPAE */
 	if (lpae) {
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 69a8a18d3a75..8a020bfe3130 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -288,13 +288,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		 * Reserve 1MB of memory for M4 (1MiB is also the minimum
 		 * alignment for Linux due to MMU section size restrictions).
 		 */
-		start[0] = gd->bd->bi_dram[0].start;
+		start[0] = gd->bi_dram[0].start;
 		size[0] = SZ_256M - SZ_1M;
 
 		/* If needed, create a second entry for memory beyond 256M */
-		if (gd->bd->bi_dram[0].size > SZ_256M) {
-			start[1] = gd->bd->bi_dram[0].start + SZ_256M;
-			size[1] = gd->bd->bi_dram[0].size - SZ_256M;
+		if (gd->bi_dram[0].size > SZ_256M) {
+			start[1] = gd->bi_dram[0].start + SZ_256M;
+			size[1] = gd->bi_dram[0].size - SZ_256M;
 			areas = 2;
 		}
 
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 19ac2ae93136..213abd4b34d9 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -44,7 +44,7 @@ int dram_init_banksize(void)
 		printf("Error setting up memory banksize. %d\n", ret);
 
 	/* Use the detected RAM size, we only support 1 bank right now. */
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return ret;
 }
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 1234b3887c6a..249d2ea8b1a2 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -78,7 +78,7 @@ int dram_init_banksize(void)
 		printf("Error setting up memory banksize. %d\n", ret);
 
 	/* Use the detected RAM size, we only support 1 bank right now. */
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	gd->bi_dram[0].size = gd->ram_size;
 
 	return ret;
 }
diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index d41bd2e9deeb..c0ba69d274be 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -148,7 +148,7 @@ int fsl_initdram(void)
 void detail_board_ddr_info(void)
 {
 	puts("\nDDR    ");
-	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
+	print_size(gd->bi_dram[0].size + gd->bi_dram[1].size, "");
 	print_ddr_info(0);
 }
 
@@ -225,8 +225,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	/* fixup DT for the two GPP DDR banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		base[i] = gd->bd->bi_dram[i].start;
-		size[i] = gd->bd->bi_dram[i].size;
+		base[i] = gd->bi_dram[i].start;
+		size[i] = gd->bi_dram[i].size;
 		/* reduce size if reserved memory is within this bank */
 		if (IS_ENABLED(CONFIG_RESV_RAM) && RESV_MEM_IN_BANK(i))
 			size[i] = gd->arch.resv_ram - base[i];
diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 05ecb75406b4..688146af01e4 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -347,10 +347,10 @@ static int zynq_verify_image(u32 src_ptr)
 		 * This validation is just for PS DDR.
 		 * TODO: Update this for PL DDR check as well.
 		 */
-		if (part_load_addr < gd->bd->bi_dram[0].start &&
+		if (part_load_addr < gd->bi_dram[0].start &&
 		    ((part_load_addr + part_data_len) >
-		    (gd->bd->bi_dram[0].start +
-		     gd->bd->bi_dram[0].size))) {
+		    (gd->bi_dram[0].start +
+		     gd->bi_dram[0].size))) {
 			printf("INVALID_LOAD_ADDRESS_FAIL\n");
 			return -1;
 		}
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 769e52bcfb5f..7387c471292d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -84,7 +84,7 @@ int __maybe_unused psu_uboot_init(void)
 
 	/* Delay is required for clocks to be propagated */
 	udelay(1000000);
-	
+
 	return 0;
 }
 
@@ -262,8 +262,8 @@ int dram_init(void)
 #else
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bi_dram[0].size = get_effective_memsize();
 
 	mem_map_fill();
 
diff --git a/boot/image-board.c b/boot/image-board.c
index 005d60caf5c9..75df291cb402 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -118,7 +118,7 @@ phys_addr_t env_get_bootm_low(void)
 #if defined(CFG_SYS_SDRAM_BASE)
 	return CFG_SYS_SDRAM_BASE;
 #elif defined(CONFIG_ARM) || defined(CONFIG_MICROBLAZE) || defined(CONFIG_RISCV)
-	return gd->bd->bi_dram[0].start;
+	return gd->bi_dram[0].start;
 #else
 	return 0;
 #endif
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558f..def1ee729ca6 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -223,8 +223,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 		of_start = NULL;
 
 		for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-			start = gd->bd->bi_dram[bank].start;
-			size = gd->bd->bi_dram[bank].size;
+			start = gd->bi_dram[bank].start;
+			size = gd->bi_dram[bank].size;
 
 			/* DRAM bank addresses are too low, skip it. */
 			if (start + size < low)
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index dc7c2c3c853c..182079bb1fc6 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -82,10 +82,10 @@ static void print_bi_dram(const struct bd_info *bd)
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
-		if (bd->bi_dram[i].size) {
+		if (gd->bi_dram[i].size) {
 			bdinfo_print_num_l("DRAM bank",	i);
-			bdinfo_print_num_ll("-> start",	bd->bi_dram[i].start);
-			bdinfo_print_num_ll("-> size",	bd->bi_dram[i].size);
+			bdinfo_print_num_ll("-> start",	gd->bi_dram[i].start);
+			bdinfo_print_num_ll("-> size",	gd->bi_dram[i].size);
 		}
 	}
 }
diff --git a/cmd/ti/ddr4.c b/cmd/ti/ddr4.c
index a8d71d11a919..fcf4bee03de6 100644
--- a/cmd/ti/ddr4.c
+++ b/cmd/ti/ddr4.c
@@ -227,10 +227,10 @@ static int do_ddr4_ecc_inject(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	if (!((start_addr >= gd->bd->bi_dram[0].start &&
-	       (start_addr <= (gd->bd->bi_dram[0].start + gd->bd->bi_dram[0].size - 1))) ||
-	      (start_addr >= gd->bd->bi_dram[1].start &&
-	       (start_addr <= (gd->bd->bi_dram[1].start + gd->bd->bi_dram[1].size - 1))))) {
+	if (!((start_addr >= gd->bi_dram[0].start &&
+	       (start_addr <= (gd->bi_dram[0].start + gd->bi_dram[0].size - 1))) ||
+	      (start_addr >= gd->bi_dram[1].start &&
+	       (start_addr <= (gd->bi_dram[1].start + gd->bi_dram[1].size - 1))))) {
 		puts("Address is not in the DDR range\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index bc5db08eee1b..51778c06e6ce 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -191,8 +191,8 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			printf("CPU: " RESET CONFIG_SYS_ARCH " (%d cores, 1 in use)\n", n_cpus);
 			break;
 		case MEMORY:
-			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
-				size += gd->bd->bi_dram[j].size;
+			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bi_dram[j].size; j++)
+				size += gd->bi_dram[j].size;
 			printf("Memory:" RESET " ");
 			print_size(size, "\n");
 			break;
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899bf..91c569da9682 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -223,11 +223,11 @@ static int show_dram_config(void)
 
 	debug("\nRAM Configuration:\n");
 	for (i = size = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		size += gd->bd->bi_dram[i].size;
+		size += gd->bi_dram[i].size;
 		debug("Bank #%d: %llx ", i,
-		      (unsigned long long)(gd->bd->bi_dram[i].start));
+		      (unsigned long long)(gd->bi_dram[i].start));
 #ifdef DEBUG
-		print_size(gd->bd->bi_dram[i].size, "\n");
+		print_size(gd->bi_dram[i].size, "\n");
 #endif
 	}
 	debug("\nDRAM:  ");
@@ -245,8 +245,8 @@ static int show_dram_config(void)
 
 __weak int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
+	gd->bi_dram[0].start = gd->ram_base;
+	gd->bi_dram[0].size = get_effective_memsize();
 
 	return 0;
 }
diff --git a/common/init/handoff.c b/common/init/handoff.c
index a7cd065fb385..668d8999f90a 100644
--- a/common/init/handoff.c
+++ b/common/init/handoff.c
@@ -12,14 +12,13 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void handoff_save_dram(struct spl_handoff *ho)
 {
-	struct bd_info *bd = gd->bd;
 	int i;
 
 	ho->ram_size = gd->ram_size;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		ho->ram_bank[i].start = bd->bi_dram[i].start;
-		ho->ram_bank[i].size = bd->bi_dram[i].size;
+		ho->ram_bank[i].start = gd->bi_dram[i].start;
+		ho->ram_bank[i].size = gd->bi_dram[i].size;
 	}
 }
 
@@ -30,11 +29,10 @@ void handoff_load_dram_size(struct spl_handoff *ho)
 
 void handoff_load_dram_banks(struct spl_handoff *ho)
 {
-	struct bd_info *bd = gd->bd;
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		bd->bi_dram[i].start = ho->ram_bank[i].start;
-		bd->bi_dram[i].size = ho->ram_bank[i].size;
+		gd->bi_dram[i].start = ho->ram_bank[i].start;
+		gd->bi_dram[i].size = ho->ram_bank[i].size;
 	}
 }
diff --git a/drivers/bootcount/bootcount_ram.c b/drivers/bootcount/bootcount_ram.c
index 33e157b865a1..8182c60dfb94 100644
--- a/drivers/bootcount/bootcount_ram.c
+++ b/drivers/bootcount/bootcount_ram.c
@@ -27,7 +27,7 @@ void bootcount_store(ulong a)
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		size += gd->bd->bi_dram[i].size;
+		size += gd->bi_dram[i].size;
 	save_addr = (ulong *)(size - BOOTCOUNT_ADDR);
 	writel(a, save_addr);
 	writel(CONFIG_SYS_BOOTCOUNT_MAGIC, &save_addr[1]);
@@ -50,7 +50,7 @@ ulong bootcount_load(void)
 	int i, tmp;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		size += gd->bd->bi_dram[i].size;
+		size += gd->bi_dram[i].size;
 	save_addr = (ulong *)(size - BOOTCOUNT_ADDR);
 
 	counter = readl(&save_addr[0]);
diff --git a/drivers/ddr/altera/sdram_agilex.c b/drivers/ddr/altera/sdram_agilex.c
index b36a765a5de7..ee50880a6685 100644
--- a/drivers/ddr/altera/sdram_agilex.c
+++ b/drivers/ddr/altera/sdram_agilex.c
@@ -104,7 +104,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
-				     (phys_size_t *)&gd->ram_size, &bd);
+				     (phys_size_t *)&gd->ram_size, gd);
 	if (ret) {
 		puts("DDR: Failed to decode memory node\n");
 		return -ENXIO;
@@ -158,7 +158,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_set_firewall(&bd);
 
-	priv->info.base = bd.bi_dram[0].start;
+	priv->info.base = gd->bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
 	debug("DDR: HMC init success\n");
diff --git a/drivers/ddr/altera/sdram_agilex5.c b/drivers/ddr/altera/sdram_agilex5.c
index ee66c72157a6..f411fd2dfddd 100644
--- a/drivers/ddr/altera/sdram_agilex5.c
+++ b/drivers/ddr/altera/sdram_agilex5.c
@@ -302,7 +302,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
-				     (phys_size_t *)&gd->ram_size, gd->bd);
+				     (phys_size_t *)&gd->ram_size, gd);
 	if (ret) {
 		puts("DDR: Failed to decode memory node\n");
 		ret = -ENXIO;
@@ -345,19 +345,19 @@ int sdram_mmr_init_full(struct udevice *dev)
 		for (i = 0; i < config_dram_banks; i++) {
 			remaining_size = hw_size - size_counter;
 			if (remaining_size <= dram_bank_info[i].max_size) {
-				gd->bd->bi_dram[i].start = dram_bank_info[i].start;
-				gd->bd->bi_dram[i].size = remaining_size;
+				gd->bi_dram[i].start = dram_bank_info[i].start;
+				gd->bi_dram[i].size = remaining_size;
 				debug("Memory bank[%d]  Starting address: 0x%llx  size: 0x%llx\n",
-				      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
+				      i, gd->bi_dram[i].start, gd->bi_dram[i].size);
 				break;
 			}
 
-			gd->bd->bi_dram[i].start = dram_bank_info[i].start;
-			gd->bd->bi_dram[i].size = dram_bank_info[i].max_size;
+			gd->bi_dram[i].start = dram_bank_info[i].start;
+			gd->bi_dram[i].size = dram_bank_info[i].max_size;
 
 			debug("Memory bank[%d]  Starting address: 0x%llx  size: 0x%llx\n",
-			      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
-			size_counter += gd->bd->bi_dram[i].size;
+			      i, gd->bi_dram[i].start, gd->bi_dram[i].size);
+			size_counter += gd->bi_dram[i].size;
 		}
 
 		gd->ram_size = hw_size;
@@ -408,7 +408,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	printf("DDR: firewall init success\n");
 
-	priv->info.base = gd->bd->bi_dram[0].start;
+	priv->info.base = gd->bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
 	/* Ending DDR driver initialization success tracking */
diff --git a/drivers/ddr/altera/sdram_agilex7m.c b/drivers/ddr/altera/sdram_agilex7m.c
index 9b3cc5c7b869..cfcbfdd2f258 100644
--- a/drivers/ddr/altera/sdram_agilex7m.c
+++ b/drivers/ddr/altera/sdram_agilex7m.c
@@ -375,7 +375,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
-				     (phys_size_t *)&gd->ram_size, &bd);
+				     (phys_size_t *)&gd->ram_size, gd);
 	if (ret) {
 		printf("%s: Failed to decode memory node\n", memory_type_in_use(dev));
 
@@ -484,7 +484,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	printf("%s: firewall init success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
 
-	priv->info.base = bd.bi_dram[0].start;
+	priv->info.base = gd->bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
 	/* Ending DDR driver initialization success tracking */
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 17ec6afa82b0..b36b7a27a3a9 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -2279,7 +2279,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
-				     (phys_size_t *)&gd->ram_size, &bd);
+				     (phys_size_t *)&gd->ram_size, gd);
 	if (ret) {
 		debug("%s: Failed to decode memory node\n",  __func__);
 		return -1;
@@ -2287,7 +2287,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	printf("DDR: %lld MiB\n", gd->ram_size >> 20);
 
-	priv->info.base = bd.bi_dram[0].start;
+	priv->info.base = gd->bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
 	sdram_size_check(&bd);
diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 4ac4c79e0ac3..634b21ba1b5b 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -285,7 +285,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
-				     (phys_size_t *)&gd->ram_size, &bd);
+				     (phys_size_t *)&gd->ram_size, gd);
 	if (ret) {
 		puts("DDR: Failed to decode memory node\n");
 		return -1;
@@ -328,7 +328,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
-	priv->info.base = bd.bi_dram[0].start;
+	priv->info.base = gd->bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
 	debug("DDR: HMC init success\n");
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 2d0093c591c2..6d6630dc1b21 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -150,8 +150,8 @@ void sdram_init_ecc_bits(struct bd_info *bd)
 
 	icache_enable();
 
-	start_addr = bd->bi_dram[0].start;
-	size = bd->bi_dram[0].size;
+	start_addr = gd->bi_dram[0].start;
+	size = gd->bi_dram[0].size;
 
 	/* Initialize small block for page table */
 	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
@@ -174,8 +174,8 @@ void sdram_init_ecc_bits(struct bd_info *bd)
 		if (bank >= CONFIG_NR_DRAM_BANKS)
 			break;
 
-		start_addr = bd->bi_dram[bank].start;
-		size = bd->bi_dram[bank].size;
+		start_addr = gd->bi_dram[bank].start;
+		size = gd->bi_dram[bank].size;
 	}
 
 	dcache_disable();
@@ -198,12 +198,12 @@ void sdram_size_check(struct bd_info *bd)
 		phys_addr_t start = 0;
 		phys_size_t remaining_size;
 
-		start = bd->bi_dram[bank].start;
-		remaining_size = bd->bi_dram[bank].size;
+		start = gd->bi_dram[bank].start;
+		remaining_size = gd->bi_dram[bank].size;
 		debug("Checking bank %d: start=0x%llx, size=0x%llx\n",
 		      bank, start, remaining_size);
 
-		while (ram_check < bd->bi_dram[bank].size) {
+		while (ram_check < gd->bi_dram[bank].size) {
 			phys_size_t size, test_size, detected_size;
 
 			size = min((phys_addr_t)SZ_1G, (phys_addr_t)remaining_size);
@@ -232,7 +232,7 @@ void sdram_size_check(struct bd_info *bd)
 			}
 
 			ram_check += detected_size;
-			remaining_size = bd->bi_dram[bank].size - ram_check;
+			remaining_size = gd->bi_dram[bank].size - ram_check;
 		}
 
 		total_ram_check += ram_check;
@@ -292,10 +292,10 @@ static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
 	u32 lower, upper;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (!bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			continue;
 
-		value = bd->bi_dram[i].start;
+		value = gd->bi_dram[i].start;
 
 		/* Keep first 1MB of SDRAM memory region as secure region when
 		 * using ATF flow, where the ATF code is located.
@@ -322,7 +322,7 @@ static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
 				      (i * 4 * sizeof(u32)));
 
 		/* Setting non-secure MPU limit and limit extended */
-		value = bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
+		value = gd->bi_dram[i].start + gd->bi_dram[i].size - 1;
 
 		lower = lower_32_bits(value);
 		upper = upper_32_bits(value);
@@ -354,10 +354,10 @@ static void sdram_set_firewall_f2sdram(struct bd_info *bd)
 	phys_size_t value;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (!bd->bi_dram[i].size)
+		if (!gd->bi_dram[i].size)
 			continue;
 
-		value = bd->bi_dram[i].start;
+		value = gd->bi_dram[i].start;
 
 		/* Keep first 1MB of SDRAM memory region as secure region when
 		 * using ATF flow, where the ATF code is located.
@@ -376,7 +376,7 @@ static void sdram_set_firewall_f2sdram(struct bd_info *bd)
 					  (i * 4 * sizeof(u32)));
 
 		/* Setting limit and limit extended */
-		value = bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
+		value = gd->bi_dram[i].start + gd->bi_dram[i].size - 1;
 
 		lower = lower_32_bits(value);
 		upper = upper_32_bits(value);
diff --git a/drivers/mmc/mvebu_mmc.c b/drivers/mmc/mvebu_mmc.c
index 5af1953cd148..11425249c71d 100644
--- a/drivers/mmc/mvebu_mmc.c
+++ b/drivers/mmc/mvebu_mmc.c
@@ -375,8 +375,8 @@ static void mvebu_window_setup(const struct mmc *mmc)
 			break;
 		}
 
-		size = gd->bd->bi_dram[i].size;
-		base = gd->bd->bi_dram[i].start;
+		size = gd->bi_dram[i].size;
+		base = gd->bi_dram[i].start;
 		if (size && attrib) {
 			mvebu_mmc_write(mmc, WINDOW_CTRL(i),
 					MVCPU_WIN_CTRL_DATA(size,
diff --git a/drivers/net/mvgbe.c b/drivers/net/mvgbe.c
index 107a33aa9f54..bf1964c9248c 100644
--- a/drivers/net/mvgbe.c
+++ b/drivers/net/mvgbe.c
@@ -256,8 +256,8 @@ static void set_dram_access(struct mvgbe_registers *regs)
 		win_param.access_ctrl = EWIN_ACCESS_FULL;
 		win_param.high_addr = 0;
 		/* Get bank base and size */
-		win_param.base_addr = gd->bd->bi_dram[i].start;
-		win_param.size = gd->bd->bi_dram[i].size;
+		win_param.base_addr = gd->bi_dram[i].start;
+		win_param.size = gd->bi_dram[i].size;
 		if (win_param.size == 0)
 			win_param.enable = 0;
 		else
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 83b76d01f24a..3e8f93da7be5 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1126,14 +1126,14 @@ static int decode_regions(struct pci_controller *hose, ofnode parent_node,
 		return 0;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
-		if (bd->bi_dram[i].size) {
-			phys_addr_t start = bd->bi_dram[i].start;
+		if (gd->bi_dram[i].size) {
+			phys_addr_t start = gd->bi_dram[i].start;
 
 			if (IS_ENABLED(CONFIG_PCI_MAP_SYSTEM_MEMORY))
-				start = virt_to_phys((void *)(uintptr_t)bd->bi_dram[i].start);
+				start = virt_to_phys((void *)(uintptr_t)gd->bi_dram[i].start);
 
 			pci_set_region(hose->regions + hose->region_count++,
-				       start, start, bd->bi_dram[i].size,
+				       start, start, gd->bi_dram[i].size,
 				       PCI_REGION_MEM | PCI_REGION_SYS_MEMORY);
 		}
 	}
diff --git a/drivers/usb/host/ehci-marvell.c b/drivers/usb/host/ehci-marvell.c
index 794a41689138..d8b7cccd122d 100644
--- a/drivers/usb/host/ehci-marvell.c
+++ b/drivers/usb/host/ehci-marvell.c
@@ -222,8 +222,8 @@ static void usb_brg_adrdec_setup(int index)
 			break;
 		}
 
-		size = gd->bd->bi_dram[i].size;
-		base = gd->bd->bi_dram[i].start;
+		size = gd->bi_dram[i].size;
+		base = gd->bi_dram[i].start;
 		if ((size) && (attrib))
 			writel(MVCPU_WIN_CTRL_DATA(size, USB_TARGET_DRAM,
 						   attrib, MVCPU_WIN_ENABLE),
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index ca627728743b..8be3c7b8bec6 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -81,8 +81,8 @@ cvbs:
 	meson_fb.fb_size = ALIGN(meson_fb.xsize * meson_fb.ysize *
 				 ((1 << VPU_MAX_LOG2_BPP) / 8) +
 				 MESON_VPU_OVERSCAN, EFI_PAGE_SIZE);
-	meson_fb.base = gd->bd->bi_dram[0].start +
-			gd->bd->bi_dram[0].size - meson_fb.fb_size;
+	meson_fb.base = gd->bi_dram[0].start +
+			gd->bi_dram[0].size - meson_fb.fb_size;
 
 	/* Override the framebuffer address */
 	uc_plat->base = meson_fb.base;
@@ -175,8 +175,8 @@ static void meson_vpu_setup_simplefb(void *fdt)
 	 * at the end of the RAM and we strip this portion from the kernel
 	 * allowed region
 	 */
-	mem_start = gd->bd->bi_dram[0].start;
-	mem_size = gd->bd->bi_dram[0].size - meson_fb.fb_size;
+	mem_start = gd->bi_dram[0].start;
+	mem_size = gd->bi_dram[0].size - meson_fb.fb_size;
 	ret = fdt_fixup_memory_banks(fdt, &mem_start, &mem_size, 1);
 	if (ret) {
 		eprintf("Cannot setup simplefb: Error reserving memory\n");
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index 154641b9a699..f9a3d0b7724c 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -368,7 +368,7 @@ int sunxi_simplefb_setup(void *blob)
 		return 0; /* Keep older kernels working */
 	}
 
-	start = gd->bd->bi_dram[0].start;
+	start = gd->bi_dram[0].start;
 	size = de2_plat->base - start;
 	ret = fdt_fixup_memory_banks(blob, &start, &size, 1);
 	if (ret) {
diff --git a/drivers/video/sunxi/sunxi_display.c b/drivers/video/sunxi/sunxi_display.c
index 4a6a89ef9d26..7d84509c3187 100644
--- a/drivers/video/sunxi/sunxi_display.c
+++ b/drivers/video/sunxi/sunxi_display.c
@@ -1336,7 +1336,7 @@ int sunxi_simplefb_setup(void *blob)
 	 * and e.g. Linux refuses to iomap RAM on ARM, see:
 	 * linux/arch/arm/mm/ioremap.c around line 301.
 	 */
-	start = gd->bd->bi_dram[0].start;
+	start = gd->bi_dram[0].start;
 	size = sunxi_display->fb_addr - start;
 	ret = fdt_fixup_memory_banks(blob, &start, &size, 1);
 	if (ret) {
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a9663..dfe421f03b25 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -448,6 +448,13 @@ struct global_data {
 	 */
 	struct upl *upl;
 #endif
+	/**
+	 * @bi_dram: array describing DRAM banks (start address and size for each bank)
+	 */
+	struct {			/* RAM configuration */
+		phys_addr_t start;
+		phys_size_t size;
+	} bi_dram[CONFIG_NR_DRAM_BANKS];
 };
 #ifndef DO_DEPS_ONLY
 static_assert(sizeof(struct global_data) == GD_SIZE);
diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
index 8c619c1b74a1..931fe2f32741 100644
--- a/include/asm-generic/u-boot.h
+++ b/include/asm-generic/u-boot.h
@@ -59,10 +59,6 @@ struct bd_info {
 #endif
 	ulong	        bi_arch_number;	/* unique id for this board */
 	ulong	        bi_boot_params;	/* where this board expects params */
-	struct {			/* RAM configuration */
-		phys_addr_t start;
-		phys_size_t size;
-	} bi_dram[CONFIG_NR_DRAM_BANKS];
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index a6aafb518542..023ccc54b5d7 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -15,9 +15,9 @@
  * Memory configurations
  */
 #define PHYS_SDRAM_1			CSD0_BASE_ADDR
-#define PHYS_SDRAM_1_SIZE		(gd->bd->bi_dram[0].size)
+#define PHYS_SDRAM_1_SIZE		(gd->bi_dram[0].size)
 #define PHYS_SDRAM_2			CSD1_BASE_ADDR
-#define PHYS_SDRAM_2_SIZE		(gd->bd->bi_dram[1].size)
+#define PHYS_SDRAM_2_SIZE		(gd->bi_dram[1].size)
 #define PHYS_SDRAM_SIZE			(gd->ram_size)
 
 #define CFG_SYS_SDRAM_BASE		(PHYS_SDRAM_1)
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index 2bd1426c7d9d..9d4c92843b05 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -51,9 +51,9 @@
 
 /* Physical Memory Map */
 #define PHYS_SDRAM_1			CSD0_BASE_ADDR
-#define PHYS_SDRAM_1_SIZE		(gd->bd->bi_dram[0].size)
+#define PHYS_SDRAM_1_SIZE		(gd->bi_dram[0].size)
 #define PHYS_SDRAM_2			CSD1_BASE_ADDR
-#define PHYS_SDRAM_2_SIZE		(gd->bd->bi_dram[1].size)
+#define PHYS_SDRAM_2_SIZE		(gd->bi_dram[1].size)
 #define PHYS_SDRAM_SIZE			(gd->ram_size)
 
 #define CFG_SYS_SDRAM_BASE		(PHYS_SDRAM_1)
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 14095b99f034..5a6c587ca626 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -86,9 +86,9 @@
 
 /* Physical Memory Map */
 #define PHYS_SDRAM_1			CSD0_BASE_ADDR
-#define PHYS_SDRAM_1_SIZE		(gd->bd->bi_dram[0].size)
+#define PHYS_SDRAM_1_SIZE		(gd->bi_dram[0].size)
 #define PHYS_SDRAM_2			CSD1_BASE_ADDR
-#define PHYS_SDRAM_2_SIZE		(gd->bd->bi_dram[1].size)
+#define PHYS_SDRAM_2_SIZE		(gd->bi_dram[1].size)
 #define PHYS_SDRAM_SIZE			(gd->ram_size)
 
 #define CFG_SYS_SDRAM_BASE		(PHYS_SDRAM_1)
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index 3707de254e14..0167cd7915fb 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -81,9 +81,9 @@
 
 /* Physical Memory Map */
 #define PHYS_SDRAM_1			CSD0_BASE_ADDR
-#define PHYS_SDRAM_1_SIZE		(gd->bd->bi_dram[0].size)
+#define PHYS_SDRAM_1_SIZE		(gd->bi_dram[0].size)
 #define PHYS_SDRAM_2			CSD1_BASE_ADDR
-#define PHYS_SDRAM_2_SIZE		(gd->bd->bi_dram[1].size)
+#define PHYS_SDRAM_2_SIZE		(gd->bi_dram[1].size)
 #define PHYS_SDRAM_SIZE			(gd->ram_size)
 
 #define CFG_SYS_SDRAM_BASE		(PHYS_SDRAM_1)
diff --git a/include/fdtdec.h b/include/fdtdec.h
index 26e40c3cdb46..850e30e769f9 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -56,6 +56,7 @@ struct fdt_memory {
 };
 
 struct bd_info;
+struct global_data;
 
 /**
  * enum fdt_source_t - indicates where the devicetree came from
@@ -950,7 +951,7 @@ int fdtdec_setup_mem_size_base_lowest(void);
 int fdtdec_setup_mem_ram_top(void);
 
 /**
- * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
+ * fdtdec_setup_memory_banksize() - decode and populate gd->bi_dram
  *
  * Decode the /memory 'reg' property to determine the address and size of the
  * memory banks. Use this data to populate the global data board info with the
@@ -1232,12 +1233,12 @@ int board_fdt_blob_setup(void **fdtp);
  * @param basep		Returns base address of first memory bank (NULL to
  *			ignore)
  * @param sizep		Returns total memory size (NULL to ignore)
- * @param bd		Updated with the memory bank information (NULL to skip)
+ * @param gd_ptr	Updated with the memory bank information (NULL to skip)
  * Return: 0 if OK, -ve on error
  */
 int fdtdec_decode_ram_size(const void *blob, const char *area, int board_id,
 			   phys_addr_t *basep, phys_size_t *sizep,
-			   struct bd_info *bd);
+			   struct global_data *gd_ptr);
 
 /**
  * fdtdec_get_srcname() - Get the name of where the devicetree comes from
diff --git a/include/init.h b/include/init.h
index 1e375da48936..651752c7a288 100644
--- a/include/init.h
+++ b/include/init.h
@@ -74,7 +74,7 @@ int dram_init(void);
  * dram_init_banksize() - Set up DRAM bank sizes
  *
  * This can be implemented by boards to set up the DRAM bank information in
- * gd->bd->bi_dram(). It is called just before relocation, after dram_init()
+ * gd->bi_dram(). It is called just before relocation, after dram_init()
  * is called.
  *
  * If this is not provided, a default implementation will try to set up a
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index bdb26d8fb75b..1b8329de645e 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -35,6 +35,7 @@
 #include <linux/ctype.h>
 #include <linux/lzo.h>
 #include <linux/ioport.h>
+#include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -1128,13 +1129,13 @@ static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, i
 
 static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
 {
-	gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
-	gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
+	gd->bi_dram[bank].start = (phys_addr_t)res->start;
+	gd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
 
 	debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
 	      __func__, bank,
-	      (unsigned long long)gd->bd->bi_dram[bank].start,
-	      (unsigned long long)gd->bd->bi_dram[bank].size);
+	      (unsigned long long)gd->bi_dram[bank].start,
+	      (unsigned long long)gd->bi_dram[bank].size);
 }
 
 int fdtdec_setup_memory_banksize(void)
@@ -1803,7 +1804,7 @@ int fdtdec_resetup(int *rescan)
 
 int fdtdec_decode_ram_size(const void *blob, const char *area, int board_id,
 			   phys_addr_t *basep, phys_size_t *sizep,
-			   struct bd_info *bd)
+			   gd_t *gd_ptr)
 {
 	int addr_cells, size_cells;
 	const u32 *cell, *end;
@@ -1855,8 +1856,8 @@ int fdtdec_decode_ram_size(const void *blob, const char *area, int board_id,
 	}
 	/* Note: if no matching subnode was found we use the parent node */
 
-	if (bd) {
-		memset(bd->bi_dram, '\0', sizeof(bd->bi_dram[0]) *
+	if (gd_ptr) {
+		memset(gd_ptr->bi_dram, '\0', sizeof(gd_ptr->bi_dram[0]) *
 						CONFIG_NR_DRAM_BANKS);
 	}
 
@@ -1872,8 +1873,8 @@ int fdtdec_decode_ram_size(const void *blob, const char *area, int board_id,
 		if (addr_cells == 2)
 			addr += (u64)fdt32_to_cpu(*cell++) << 32UL;
 		addr += fdt32_to_cpu(*cell++);
-		if (bd)
-			bd->bi_dram[bank].start = addr;
+		if (gd_ptr)
+			gd_ptr->bi_dram[bank].start = addr;
 		if (basep && !bank)
 			*basep = (phys_addr_t)addr;
 
@@ -1895,8 +1896,8 @@ int fdtdec_decode_ram_size(const void *blob, const char *area, int board_id,
 			}
 		}
 
-		if (bd)
-			bd->bi_dram[bank].size = size;
+		if (gd_ptr)
+			gd_ptr->bi_dram[bank].size = size;
 		total_size += size;
 	}
 
diff --git a/lib/lmb.c b/lib/lmb.c
index e2d9fe86c14e..560a2dff211e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -554,12 +554,12 @@ static void lmb_reserve_uboot_region(void)
 #endif
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    rsv_start < gd->bd->bi_dram[bank].start)
+		if (!gd->bi_dram[bank].size ||
+		    rsv_start < gd->bi_dram[bank].start)
 			continue;
 		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
+		bank_end = gd->bi_dram[bank].start +
+			gd->bi_dram[bank].size - 1;
 		if (rsv_start > bank_end)
 			continue;
 		if (bank_end > end)
@@ -614,7 +614,6 @@ static void lmb_add_memory(void)
 	phys_addr_t bank_end;
 	phys_size_t size;
 	u64 ram_top = gd->ram_top;
-	struct bd_info *bd = gd->bd;
 
 	if (CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP))
 		return lmb_arch_add_memory();
@@ -624,19 +623,19 @@ static void lmb_add_memory(void)
 		ram_top = 0x100000000ULL;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		size = bd->bi_dram[i].size;
-		bank_end = bd->bi_dram[i].start + size;
+		size = gd->bi_dram[i].size;
+		bank_end = gd->bi_dram[i].start + size;
 
 		if (size) {
-			lmb_add(bd->bi_dram[i].start, size);
+			lmb_add(gd->bi_dram[i].start, size);
 
 			/*
 			 * Reserve memory above ram_top as
 			 * no-overwrite so that it cannot be
 			 * allocated
 			 */
-			if (bd->bi_dram[i].start >= ram_top)
-				lmb_reserve(bd->bi_dram[i].start, size,
+			if (gd->bi_dram[i].start >= ram_top)
+				lmb_reserve(gd->bi_dram[i].start, size,
 					    LMB_NOOVERWRITE);
 			else if (bank_end > ram_top)
 				lmb_reserve(ram_top, bank_end - ram_top,
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index c3a3519d16d4..b6a75c4812d0 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -138,16 +138,15 @@ static int lmb_test_dump_all(struct unit_test_state *uts)
 
 static int bdinfo_check_mem(struct unit_test_state *uts)
 {
-	struct bd_info *bd = gd->bd;
 	int i;
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
-		if (bd->bi_dram[i].size) {
+		if (gd->bi_dram[i].size) {
 			ut_assertok(test_num_l(uts, "DRAM bank", i));
 			ut_assertok(test_num_ll(uts, "-> start",
-						bd->bi_dram[i].start));
+						gd->bi_dram[i].start));
 			ut_assertok(test_num_ll(uts, "-> size",
-						bd->bi_dram[i].size));
+						gd->bi_dram[i].size));
 		}
 	}
 
-- 
2.53.0

