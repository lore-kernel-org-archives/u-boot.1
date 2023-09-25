Return-Path: <u-boot-bounces@lists.denx.de>
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E736DCE7A96
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 03:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD4E86B11;
	Mon, 25 Sep 2023 05:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aZ0z9Jo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1976F866EC; Mon, 25 Sep 2023 04:40:11 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0500886AE1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 04:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3512fae02ecso7269275ab.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695609608; x=1696214408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUzAeKglVBMopXmqgM8R1Lr/2BUOvnB0Y2VMO0CAKBQ=;
 b=aZ0z9Jo9ezDHTDcIn9tFXe5aoILRyFTP0siLP6mkMeujKI/SCd4c9YgxFa/xmh8i/2
 8qqRGIshlY4iLjKy/2WlhqHPAOOuXSb8N8oK9tXXsdseo510rPq/l1jimrlCJw1vfII+
 FFoUuEWEFGD0zMTnBsNMOOztozhmDsbWNaRNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609608; x=1696214408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUzAeKglVBMopXmqgM8R1Lr/2BUOvnB0Y2VMO0CAKBQ=;
 b=VPlQ/U8a4QD//j8i+Mm3aLFs76FIcpTpN2BSQeSQ5gD8SwlSc0a3USD2gz1Lv9AMAW
 X5XR5GQ8aRsLTSm/cZGo03H3wxImpCXNVLFsJrZr7sGta6hAPPSFiOU8FYaYRoKgZa+1
 zOYCpIRd72xXhJpUcu9Bp+28xX3+FDDfwcuawDEbAQro3UPEmi6/Bba5rL3rXanII9WL
 6rmGXRdKiCpyAISh4aEeJ+1T9bk9Ldyzm+rTDxXWl7h/Up06WC89HC1w2VssLy670Tln
 l/wzrL59cQJ4xZ2QdQGMsuZaNO7lemXypMumx0W7BbhzQEUHzYCVqLXLFLlRO/Cyhx1y
 xrug==
X-Gm-Message-State: AOJu0YzFmXTdNOXhVBn/LXNP0HDrZLEN4WwqUU9L7abKJ0fTfeREs6TL
 SforsrXPzvo4ioHsreQZLynOrq5QI7fDtqZNWP4=
X-Google-Smtp-Source: AGHT+IEQG1HkHOQsSd+hVq2GJbNbxoCgJGPFyia8ci1W3RedAiuJIj3WlTool7osBgUJcfiULHIryw==
X-Received: by 2002:a05:6e02:973:b0:34f:2484:64cb with SMTP id
 q19-20020a056e02097300b0034f248464cbmr5719941ilt.20.1695609607425; 
 Sun, 24 Sep 2023 19:40:07 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 q8-20020a0566380ec800b00439e3c9f958sm2477252jas.129.2023.09.24.19.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:40:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] common: Drop linux/string.h from common header
Date: Sun, 24 Sep 2023 20:39:52 -0600
Message-ID: <20230925023958.1913268-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230925023958.1913268-1-sjg@chromium.org>
References: <20230925023958.1913268-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Sep 2023 05:02:35 +0200
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

Move this out of the common header and include it only where needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 api/api.c                                               | 1 +
 api/api_net.c                                           | 1 +
 arch/arc/lib/relocate.c                                 | 1 +
 arch/arm/cpu/arm926ejs/mxs/mxs.c                        | 1 +
 arch/arm/cpu/arm926ejs/mxs/spl_boot.c                   | 1 +
 arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c              | 1 +
 arch/arm/cpu/armv7/bcm235xx/clk-core.c                  | 1 +
 arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c              | 1 +
 arch/arm/cpu/armv7/bcm281xx/clk-core.c                  | 1 +
 arch/arm/cpu/armv7/ls102xa/fdt.c                        | 1 +
 arch/arm/cpu/armv7/vf610/generic.c                      | 1 +
 arch/arm/cpu/armv7/virt-v7.c                            | 1 +
 arch/arm/cpu/armv8/cache_v8.c                           | 1 +
 arch/arm/cpu/armv8/cpu.c                                | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c                 | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/fdt.c                 | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c    | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c    | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c          | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/mp.c                  | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/spl.c                 | 1 +
 arch/arm/cpu/armv8/sec_firmware.c                       | 1 +
 arch/arm/cpu/armv8/spin_table.c                         | 1 +
 arch/arm/cpu/armv8/spl_data.c                           | 1 +
 arch/arm/include/asm/arch-octeontx/soc.h                | 2 ++
 arch/arm/include/asm/arch-octeontx2/soc.h               | 2 ++
 arch/arm/include/asm/io.h                               | 1 +
 arch/arm/include/asm/string.h                           | 2 --
 arch/arm/lib/bootm.c                                    | 1 +
 arch/arm/lib/cache.c                                    | 1 +
 arch/arm/lib/eabi_compat.c                              | 1 +
 arch/arm/lib/gic-v3-its.c                               | 1 +
 arch/arm/lib/psci-dt.c                                  | 1 +
 arch/arm/mach-apple/board.c                             | 1 +
 arch/arm/mach-bcm283x/include/mach/mbox.h               | 1 +
 arch/arm/mach-imx/cmd_bmode.c                           | 1 +
 arch/arm/mach-imx/cmd_dek.c                             | 1 +
 arch/arm/mach-imx/cmd_mfgprot.c                         | 1 +
 arch/arm/mach-imx/cmd_nandbcb.c                         | 1 +
 arch/arm/mach-imx/ele_ahab.c                            | 1 +
 arch/arm/mach-imx/hab.c                                 | 1 +
 arch/arm/mach-imx/image-container.c                     | 1 +
 arch/arm/mach-imx/imx8/ahab.c                           | 1 +
 arch/arm/mach-imx/imx8/cpu.c                            | 1 +
 arch/arm/mach-imx/imx8/fdt.c                            | 1 +
 arch/arm/mach-imx/imx8m/soc.c                           | 1 +
 arch/arm/mach-imx/imx8ulp/soc.c                         | 1 +
 arch/arm/mach-imx/imx8ulp/upower/upower_api.c           | 1 +
 arch/arm/mach-imx/imx9/soc.c                            | 1 +
 arch/arm/mach-imx/imx_bootaux.c                         | 1 +
 arch/arm/mach-imx/mx5/clock.c                           | 1 +
 arch/arm/mach-imx/mx6/module_fuse.c                     | 1 +
 arch/arm/mach-imx/spl_imx_romapi.c                      | 1 +
 arch/arm/mach-imx/video.c                               | 1 +
 arch/arm/mach-k3/am625_init.c                           | 1 +
 arch/arm/mach-k3/am62a7_init.c                          | 1 +
 arch/arm/mach-k3/am642_init.c                           | 1 +
 arch/arm/mach-k3/common.c                               | 1 +
 arch/arm/mach-k3/j721e_init.c                           | 1 +
 arch/arm/mach-k3/j721s2_init.c                          | 1 +
 arch/arm/mach-k3/sysfw-loader.c                         | 1 +
 arch/arm/mach-keystone/cmd_clock.c                      | 1 +
 arch/arm/mach-keystone/cmd_mon.c                        | 1 +
 arch/arm/mach-keystone/ddr3_spd.c                       | 1 +
 arch/arm/mach-keystone/include/mach/hardware.h          | 2 ++
 arch/arm/mach-keystone/mon.c                            | 1 +
 arch/arm/mach-meson/sm.c                                | 1 +
 arch/arm/mach-mvebu/armada3700/cpu.c                    | 1 +
 arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c     | 1 +
 arch/arm/mach-nexell/clock.c                            | 1 +
 arch/arm/mach-omap2/emif-common.c                       | 1 +
 arch/arm/mach-omap2/omap3/board.c                       | 1 +
 arch/arm/mach-omap2/sec-common.c                        | 1 +
 arch/arm/mach-rockchip/board.c                          | 1 +
 arch/arm/mach-rockchip/boot_mode.c                      | 1 +
 arch/arm/mach-rockchip/misc.c                           | 1 +
 arch/arm/mach-rockchip/spl-boot-order.c                 | 1 +
 arch/arm/mach-snapdragon/init_sdm845.c                  | 1 +
 arch/arm/mach-socfpga/clock_manager_arria10.c           | 1 +
 arch/arm/mach-socfpga/misc_arria10.c                    | 1 +
 arch/arm/mach-socfpga/pinmux_arria10.c                  | 1 +
 arch/arm/mach-socfpga/secure_vab.c                      | 1 +
 arch/arm/mach-socfpga/smc_api.c                         | 1 +
 arch/arm/mach-stm32mp/bsec.c                            | 1 +
 arch/arm/mach-stm32mp/cmd_stm32key.c                    | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c     | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c         | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c  | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c     | 1 +
 arch/arm/mach-stm32mp/ecdsa_romapi.c                    | 1 +
 arch/arm/mach-stm32mp/fdt.c                             | 1 +
 arch/arm/mach-sunxi/board.c                             | 1 +
 arch/arm/mach-tegra/cboot.c                             | 1 +
 arch/arm/mach-tegra/dt-setup.c                          | 1 +
 arch/arm/mach-tegra/tegra20/bct.c                       | 1 +
 arch/arm/mach-tegra/tegra20/emc.c                       | 1 +
 arch/arm/mach-tegra/tegra20/warmboot.c                  | 1 +
 arch/arm/mach-tegra/tegra30/bct.c                       | 1 +
 arch/arm/mach-tegra/xusb-padctl-common.c                | 1 +
 arch/arm/mach-uniphier/base-address.c                   | 1 +
 arch/arm/mach-uniphier/board_late_init.c                | 1 +
 arch/arm/mach-uniphier/dram/cmd_ddrmphy.c               | 1 +
 arch/arm/mach-uniphier/dram/cmd_ddrphy.c                | 1 +
 arch/arm/mach-versal/mp.c                               | 1 +
 arch/arm/mach-zynq/ddrc.c                               | 1 +
 arch/arm/mach-zynq/slcr.c                               | 1 +
 arch/arm/mach-zynqmp/cpu.c                              | 1 +
 arch/arm/mach-zynqmp/mp.c                               | 1 +
 arch/microblaze/cpu/cpuinfo.c                           | 1 +
 arch/microblaze/include/asm/io.h                        | 1 +
 arch/mips/include/asm/io.h                              | 1 +
 arch/mips/lib/bootm.c                                   | 1 +
 arch/mips/lib/reloc.c                                   | 1 +
 arch/mips/lib/traps.c                                   | 1 +
 arch/mips/mach-jz47xx/jz4780/jz4780.c                   | 1 +
 arch/mips/mach-mtmips/cpu.c                             | 1 +
 arch/mips/mach-mtmips/mt7621/spl/launch.c               | 1 +
 arch/mips/mach-octeon/bootoctlinux.c                    | 1 +
 arch/mips/mach-octeon/cpu.c                             | 1 +
 arch/mips/mach-octeon/cvmx-bootmem.c                    | 1 +
 arch/mips/mach-octeon/cvmx-cmd-queue.c                  | 1 +
 arch/mips/mach-octeon/cvmx-coremask.c                   | 1 +
 arch/mips/mach-octeon/cvmx-fau-compat.c                 | 1 +
 arch/mips/mach-octeon/cvmx-fpa.c                        | 1 +
 arch/mips/mach-octeon/cvmx-helper-board.c               | 1 +
 arch/mips/mach-octeon/cvmx-helper-cfg.c                 | 1 +
 arch/mips/mach-octeon/cvmx-helper-ilk.c                 | 1 +
 arch/mips/mach-octeon/cvmx-helper-pki.c                 | 1 +
 arch/mips/mach-octeon/cvmx-helper-rgmii.c               | 1 +
 arch/mips/mach-octeon/cvmx-helper-sfp.c                 | 1 +
 arch/mips/mach-octeon/cvmx-helper-util.c                | 1 +
 arch/mips/mach-octeon/cvmx-pcie.c                       | 1 +
 arch/mips/mach-octeon/cvmx-pko3-compat.c                | 1 +
 arch/mips/mach-octeon/cvmx-pko3-queue.c                 | 1 +
 arch/mips/mach-octeon/cvmx-pko3.c                       | 1 +
 arch/mips/mach-octeon/cvmx-qlm.c                        | 1 +
 arch/mips/mach-octeon/include/mach/cvmx-coremask.h      | 1 +
 arch/mips/mach-octeon/include/mach/cvmx-pko3.h          | 1 +
 arch/mips/mach-octeon/include/mach/cvmx-wqe.h           | 1 +
 arch/mips/mach-octeon/octeon_fdt.c                      | 1 +
 arch/mips/mach-octeon/octeon_qlm.c                      | 1 +
 arch/nios2/cpu/cpu.c                                    | 1 +
 arch/nios2/include/asm/io.h                             | 1 +
 arch/powerpc/cpu/mpc83xx/ecc.c                          | 1 +
 arch/powerpc/cpu/mpc85xx/cpu_init.c                     | 1 +
 arch/powerpc/cpu/mpc85xx/fdt.c                          | 1 +
 arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c          | 1 +
 arch/powerpc/cpu/mpc85xx/liodn.c                        | 1 +
 arch/powerpc/cpu/mpc85xx/mp.c                           | 1 +
 arch/powerpc/cpu/mpc85xx/portals.c                      | 1 +
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c                     | 1 +
 arch/powerpc/include/asm/io.h                           | 1 +
 arch/riscv/include/asm/io.h                             | 1 +
 arch/riscv/include/asm/posix_types.h                    | 2 ++
 arch/riscv/lib/andes_plicsw.c                           | 1 +
 arch/riscv/lib/fdt_fixup.c                              | 1 +
 arch/sandbox/cpu/cpu.c                                  | 1 +
 arch/sandbox/cpu/eth-raw-os.c                           | 1 +
 arch/sandbox/cpu/os.c                                   | 1 +
 arch/sandbox/cpu/sdl.c                                  | 1 +
 arch/sandbox/cpu/spl.c                                  | 1 +
 arch/sandbox/cpu/start.c                                | 1 +
 arch/sandbox/cpu/state.c                                | 1 +
 arch/sandbox/lib/bootm.c                                | 1 +
 arch/sh/lib/board.c                                     | 1 +
 arch/sh/lib/bootm.c                                     | 1 +
 arch/sh/lib/zimageboot.c                                | 1 +
 arch/x86/cpu/acpi_gpe.c                                 | 1 +
 arch/x86/cpu/apollolake/acpi.c                          | 1 +
 arch/x86/cpu/apollolake/fsp_bindings.c                  | 1 +
 arch/x86/cpu/apollolake/pmc.c                           | 1 +
 arch/x86/cpu/apollolake/spl.c                           | 1 +
 arch/x86/cpu/apollolake/uart.c                          | 1 +
 arch/x86/cpu/baytrail/acpi.c                            | 1 +
 arch/x86/cpu/broadwell/me.c                             | 1 +
 arch/x86/cpu/broadwell/northbridge.c                    | 1 +
 arch/x86/cpu/broadwell/pinctrl_broadwell.c              | 1 +
 arch/x86/cpu/broadwell/refcode.c                        | 1 +
 arch/x86/cpu/broadwell/sdram.c                          | 1 +
 arch/x86/cpu/cpu_x86.c                                  | 1 +
 arch/x86/cpu/efi/payload.c                              | 1 +
 arch/x86/cpu/i386/cpu.c                                 | 1 +
 arch/x86/cpu/intel_common/intel_opregion.c              | 1 +
 arch/x86/cpu/intel_common/itss.c                        | 1 +
 arch/x86/cpu/intel_common/report_platform.c             | 1 +
 arch/x86/cpu/ivybridge/sata.c                           | 1 +
 arch/x86/cpu/ivybridge/sdram.c                          | 1 +
 arch/x86/cpu/mp_init.c                                  | 1 +
 arch/x86/cpu/mtrr.c                                     | 1 +
 arch/x86/cpu/qfw_cpu.c                                  | 1 +
 arch/x86/cpu/quark/acpi.c                               | 1 +
 arch/x86/cpu/quark/dram.c                               | 1 +
 arch/x86/cpu/quark/smc.c                                | 1 +
 arch/x86/cpu/tangier/acpi.c                             | 1 +
 arch/x86/cpu/tangier/sdram.c                            | 1 +
 arch/x86/include/asm/io.h                               | 1 +
 arch/x86/include/asm/me_common.h                        | 1 +
 arch/x86/lib/acpi.c                                     | 1 +
 arch/x86/lib/acpi_nhlt.c                                | 1 +
 arch/x86/lib/acpi_s3.c                                  | 1 +
 arch/x86/lib/acpi_table.c                               | 1 +
 arch/x86/lib/bios.c                                     | 1 +
 arch/x86/lib/cmd_boot.c                                 | 1 +
 arch/x86/lib/coreboot_table.c                           | 1 +
 arch/x86/lib/fsp1/fsp_support.c                         | 1 +
 arch/x86/lib/fsp2/fsp_meminit.c                         | 1 +
 arch/x86/lib/fsp2/fsp_silicon_init.c                    | 1 +
 arch/x86/lib/fsp2/fsp_support.c                         | 1 +
 arch/x86/lib/mpspec.c                                   | 1 +
 arch/x86/lib/mrccache.c                                 | 1 +
 arch/x86/lib/physmem.c                                  | 1 +
 arch/x86/lib/pirq_routing.c                             | 1 +
 arch/x86/lib/relocate.c                                 | 1 +
 arch/x86/lib/scu.c                                      | 1 +
 arch/x86/lib/sfi.c                                      | 1 +
 arch/x86/lib/spl.c                                      | 1 +
 arch/x86/lib/string.c                                   | 1 +
 arch/x86/lib/tables.c                                   | 1 +
 arch/x86/lib/zimage.c                                   | 1 +
 arch/xtensa/include/asm/io.h                            | 1 +
 arch/xtensa/include/asm/posix_types.h                   | 2 ++
 arch/xtensa/lib/bootm.c                                 | 1 +
 arch/xtensa/lib/relocate.c                              | 1 +
 board/BuR/common/common.c                               | 1 +
 board/BuS/eb_cpu5282/eb_cpu5282.c                       | 1 +
 board/CZ.NIC/turris_atsha_otp.c                         | 1 +
 board/CZ.NIC/turris_omnia/turris_omnia.c                | 1 +
 board/Marvell/mvebu_armada-37xx/board.c                 | 1 +
 board/Marvell/octeon_ebb7304/board.c                    | 1 +
 board/Marvell/octeontx/board-fdt.c                      | 1 +
 board/Marvell/octeontx/board.c                          | 1 +
 board/Marvell/octeontx/soc-utils.c                      | 1 +
 board/Marvell/octeontx2/board-fdt.c                     | 1 +
 board/Marvell/octeontx2/board.c                         | 1 +
 board/Marvell/octeontx2/soc-utils.c                     | 1 +
 board/Synology/common/legacy.c                          | 1 +
 board/Synology/ds414/cmd_syno.c                         | 1 +
 board/advantech/imx8qm_dmsse20_a1/spl.c                 | 1 +
 board/advantech/imx8qm_rom7720_a1/spl.c                 | 1 +
 board/amlogic/vim3/vim3.c                               | 1 +
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c              | 1 +
 board/aristainetos/aristainetos.c                       | 1 +
 board/armltd/vexpress64/vexpress64.c                    | 1 +
 board/atmel/common/mac-spi-nor.c                        | 1 +
 board/atmel/common/video_display.c                      | 1 +
 board/atmel/sama5d3xek/sama5d3xek.c                     | 1 +
 board/beacon/beacon-rzg2m/beacon-rzg2m.c                | 1 +
 board/beacon/imx8mm/spl.c                               | 1 +
 board/beacon/imx8mn/spl.c                               | 1 +
 board/beckhoff/mx53cx9020/mx53cx9020.c                  | 1 +
 board/bluewater/gurnard/gurnard.c                       | 1 +
 board/bosch/acc/acc.c                                   | 1 +
 board/boundary/nitrogen6x/nitrogen6x.c                  | 1 +
 board/bsh/imx8mn_smm_s2/spl.c                           | 1 +
 board/cavium/thunderx/atf.c                             | 1 +
 board/cloos/imx8mm_phg/spl.c                            | 1 +
 board/compulab/cl-som-imx7/spl.c                        | 1 +
 board/compulab/cm_fx6/cm_fx6.c                          | 1 +
 board/compulab/common/eeprom.c                          | 1 +
 board/compulab/imx8mm-cl-iot-gate/spl.c                 | 1 +
 board/congatec/cgtqmx8/cgtqmx8.c                        | 1 +
 board/congatec/cgtqmx8/spl.c                            | 1 +
 board/congatec/common/mmc.c                             | 1 +
 board/cssi/cmpc885/cmpc885.c                            | 1 +
 board/cssi/cmpcpro/cmpcpro.c                            | 1 +
 board/data_modul/common/common.c                        | 1 +
 board/davinci/da8xxevm/da850evm.c                       | 1 +
 board/davinci/da8xxevm/omapl138_lcdk.c                  | 1 +
 board/dhelectronics/dh_imx6/dh_imx6.c                   | 1 +
 board/dhelectronics/dh_imx6/dh_imx6_spl.c               | 1 +
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c       | 1 +
 board/dhelectronics/dh_imx8mp/spl.c                     | 1 +
 board/dhelectronics/dh_stm32mp1/board.c                 | 1 +
 board/ea/mx7ulp_com/mx7ulp_com.c                        | 1 +
 board/egnite/ethernut5/ethernut5_pwrman.c               | 1 +
 board/emulation/common/qemu_dfu.c                       | 1 +
 board/emulation/qemu-ppce500/qemu-ppce500.c             | 1 +
 board/engicam/common/board.c                            | 1 +
 board/engicam/common/spl.c                              | 1 +
 board/engicam/imx8mm/spl.c                              | 1 +
 board/esd/meesc/meesc.c                                 | 1 +
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c             | 1 +
 board/freescale/common/fsl_validate.c                   | 1 +
 board/freescale/common/mmc.c                            | 1 +
 board/freescale/common/ngpixis.c                        | 1 +
 board/freescale/common/qixis.c                          | 1 +
 board/freescale/common/sys_eeprom.c                     | 1 +
 board/freescale/imx8mm_evk/spl.c                        | 1 +
 board/freescale/imx8mn_evk/spl.c                        | 1 +
 board/freescale/imx8mq_evk/spl.c                        | 1 +
 board/freescale/imx8qm_mek/imx8qm_mek.c                 | 1 +
 board/freescale/imx8qm_mek/spl.c                        | 1 +
 board/freescale/imx8qxp_mek/imx8qxp_mek.c               | 1 +
 board/freescale/imx8qxp_mek/spl.c                       | 1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.c               | 1 +
 board/freescale/imx8ulp_evk/spl.c                       | 1 +
 board/freescale/imx93_evk/spl.c                         | 1 +
 board/freescale/ls1012aqds/ls1012aqds.c                 | 1 +
 board/freescale/ls1012ardb/ls1012ardb.c                 | 1 +
 board/freescale/ls1021aiot/ls1021aiot.c                 | 1 +
 board/freescale/ls1021aqds/ddr.c                        | 1 +
 board/freescale/ls1021aqds/ls1021aqds.c                 | 1 +
 board/freescale/ls1021atsn/ls1021atsn.c                 | 1 +
 board/freescale/ls1021atwr/ls1021atwr.c                 | 1 +
 board/freescale/ls1043aqds/eth.c                        | 1 +
 board/freescale/ls1043ardb/cpld.c                       | 1 +
 board/freescale/ls1043ardb/ddr.c                        | 1 +
 board/freescale/ls1046afrwy/eth.c                       | 1 +
 board/freescale/ls1046ardb/cpld.c                       | 1 +
 board/freescale/ls1046ardb/eth.c                        | 1 +
 board/freescale/ls1088a/eth_ls1088aqds.c                | 1 +
 board/freescale/ls1088a/ls1088a.c                       | 1 +
 board/freescale/ls2080aqds/eth.c                        | 1 +
 board/freescale/ls2080aqds/ls2080aqds.c                 | 1 +
 board/freescale/lx2160a/eth_lx2160aqds.c                | 1 +
 board/freescale/lx2160a/eth_lx2162aqds.c                | 1 +
 board/freescale/lx2160a/lx2160a.c                       | 1 +
 board/freescale/mx6memcal/spl.c                         | 1 +
 board/freescale/mx6sabreauto/mx6sabreauto.c             | 1 +
 board/freescale/mx6sabresd/mx6sabresd.c                 | 1 +
 board/freescale/mx6slevk/mx6slevk.c                     | 1 +
 board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c       | 1 +
 board/freescale/p1010rdb/ddr.c                          | 1 +
 board/freescale/p1010rdb/p1010rdb.c                     | 1 +
 board/freescale/p1010rdb/spl.c                          | 1 +
 board/freescale/p1_p2_rdb_pc/ddr.c                      | 1 +
 board/freescale/p1_p2_rdb_pc/spl.c                      | 1 +
 board/freescale/p2041rdb/cpld.c                         | 1 +
 board/freescale/t102xrdb/cpld.c                         | 1 +
 board/freescale/t102xrdb/ddr.c                          | 1 +
 board/freescale/t102xrdb/spl.c                          | 1 +
 board/freescale/t102xrdb/t102xrdb.c                     | 1 +
 board/freescale/t104xrdb/cpld.c                         | 1 +
 board/freescale/t104xrdb/spl.c                          | 1 +
 board/freescale/t208xqds/eth_t208xqds.c                 | 1 +
 board/freescale/t208xqds/spl.c                          | 1 +
 board/freescale/t208xrdb/cpld.c                         | 1 +
 board/freescale/t208xrdb/spl.c                          | 1 +
 board/freescale/t4rdb/cpld.c                            | 1 +
 board/freescale/t4rdb/spl.c                             | 1 +
 board/friendlyarm/nanopi2/board.c                       | 1 +
 board/friendlyarm/nanopi2/lcds.c                        | 1 +
 board/gardena/smart-gateway-mt7688/board.c              | 1 +
 board/gateworks/gw_ventana/eeprom.c                     | 1 +
 board/gateworks/gw_ventana/gw_ventana.c                 | 1 +
 board/gateworks/venice/eeprom.c                         | 1 +
 board/gateworks/venice/spl.c                            | 1 +
 board/gateworks/venice/venice.c                         | 1 +
 board/gdsys/a38x/hre.c                                  | 1 +
 board/gdsys/a38x/ihs_phys.c                             | 1 +
 board/gdsys/a38x/keyprogram.c                           | 1 +
 board/gdsys/common/cmd_ioloop.c                         | 1 +
 board/gdsys/common/ihs_mdio.c                           | 1 +
 board/gdsys/common/ioep-fpga.c                          | 1 +
 board/gdsys/common/osd.c                                | 1 +
 board/gdsys/common/osd_cmd.c                            | 1 +
 board/ge/b1x5v2/b1x5v2.c                                | 1 +
 board/ge/b1x5v2/spl.c                                   | 1 +
 board/ge/bx50v3/bx50v3.c                                | 1 +
 board/ge/mx53ppd/mx53ppd.c                              | 1 +
 board/google/chameleonv3/mercury_aa1.c                  | 1 +
 board/google/imx8mq_phanbell/spl.c                      | 1 +
 board/grinn/liteboard/board.c                           | 1 +
 board/hoperun/hihope-rzg2/hihope-rzg2.c                 | 1 +
 board/imgtec/malta/malta.c                              | 1 +
 board/isee/igep00x0/igep00x0.c                          | 1 +
 board/k+p/kp_imx53/kp_id_rev.c                          | 1 +
 board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c               | 1 +
 board/keymile/common/common.c                           | 1 +
 board/keymile/common/ivm.c                              | 1 +
 board/keymile/kmcent2/kmcent2.c                         | 1 +
 board/kontron/pitx_imx8m/spl.c                          | 1 +
 board/kontron/sl-mx6ul/spl.c                            | 1 +
 board/kontron/sl-mx8mm/spl.c                            | 1 +
 board/kontron/sl28/spl.c                                | 1 +
 board/kosagi/novena/novena.c                            | 1 +
 board/liebherr/display5/display5.c                      | 1 +
 board/liebherr/display5/spl.c                           | 1 +
 board/liebherr/mccmon6/spl.c                            | 1 +
 board/mediatek/mt7623/mt7623_rfb.c                      | 1 +
 board/menlo/m53menlo/m53menlo.c                         | 1 +
 board/mntre/imx8mq_reform2/spl.c                        | 1 +
 board/mscc/jr2/jr2.c                                    | 1 +
 board/mscc/luton/luton.c                                | 1 +
 board/mscc/ocelot/ocelot.c                              | 1 +
 board/mscc/serval/serval.c                              | 1 +
 board/mscc/servalt/servalt.c                            | 1 +
 board/nokia/rx51/rx51.c                                 | 1 +
 board/phytec/pcm058/pcm058.c                            | 1 +
 board/phytec/phycore_imx8mm/spl.c                       | 1 +
 board/phytium/pomelo/pcie.c                             | 1 +
 board/phytium/pomelo/pll.c                              | 1 +
 board/phytium/pomelo/sec.c                              | 1 +
 board/qualcomm/dragonboard410c/dragonboard410c.c        | 1 +
 board/renesas/salvator-x/salvator-x.c                   | 1 +
 board/renesas/stout/cpld.c                              | 1 +
 board/renesas/ulcb/cpld.c                               | 1 +
 board/renesas/ulcb/ulcb.c                               | 1 +
 board/renesas/v3hsk/cpld.c                              | 1 +
 board/renesas/v3msk/cpld.c                              | 1 +
 board/ronetix/imx7-cm/spl.c                             | 1 +
 board/ronetix/imx8mq-cm/spl.c                           | 1 +
 board/samsung/common/gadget.c                           | 1 +
 board/samsung/origen/tools/mkorigenspl.c                | 1 +
 board/samsung/smdkv310/tools/mksmdkv310spl.c            | 1 +
 board/siemens/capricorn/board.c                         | 1 +
 board/siemens/capricorn/spl.c                           | 1 +
 board/siemens/common/board.c                            | 1 +
 board/siemens/common/factoryset.c                       | 1 +
 board/siemens/iot2050/board.c                           | 1 +
 board/siemens/pxm2/board.c                              | 1 +
 board/siemens/rut/board.c                               | 1 +
 board/sifive/unmatched/hifive-platform-i2c-eeprom.c     | 1 +
 board/socionext/developerbox/fwu_plat.c                 | 1 +
 board/softing/vining_2000/vining_2000.c                 | 1 +
 board/softing/vining_fpga/socfpga.c                     | 1 +
 board/solidrun/clearfog/clearfog.c                      | 1 +
 board/solidrun/common/tlv_data.c                        | 1 +
 board/solidrun/mx6cuboxi/mx6cuboxi.c                    | 1 +
 board/st/common/cmd_stboard.c                           | 1 +
 board/st/common/stm32mp_dfu.c                           | 1 +
 board/st/stm32mp1/stm32mp1.c                            | 1 +
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c     | 1 +
 board/ste/stemmy/stemmy.c                               | 1 +
 board/sunxi/board.c                                     | 1 +
 board/sunxi/chip.c                                      | 1 +
 board/synopsys/emsdp/emsdp.c                            | 1 +
 board/synopsys/hsdk/hsdk.c                              | 1 +
 board/technexion/pico-imx6/spl.c                        | 1 +
 board/technexion/pico-imx6ul/spl.c                      | 1 +
 board/technexion/pico-imx7d/spl.c                       | 1 +
 board/technexion/pico-imx8mq/spl.c                      | 1 +
 board/theadorable/fpga.c                                | 1 +
 board/theobroma-systems/puma_rk3399/puma-rk3399.c       | 1 +
 board/theobroma-systems/ringneck_px30/ringneck-px30.c   | 1 +
 board/ti/am335x/board.c                                 | 1 +
 board/ti/am335x/board.h                                 | 1 +
 board/ti/am43xx/board.c                                 | 1 +
 board/ti/am43xx/board.h                                 | 1 +
 board/ti/am57xx/board.c                                 | 1 +
 board/ti/am64x/evm.c                                    | 1 +
 board/ti/am65x/evm.c                                    | 1 +
 board/ti/beagle/beagle.c                                | 1 +
 board/ti/common/board_detect.c                          | 1 +
 board/ti/common/cape_detect.c                           | 1 +
 board/ti/j721e/evm.c                                    | 1 +
 board/ti/j721s2/evm.c                                   | 1 +
 board/ti/ks2_evm/board.c                                | 1 +
 board/ti/ks2_evm/board_k2e.c                            | 1 +
 board/ti/ks2_evm/board_k2g.c                            | 1 +
 board/ti/ks2_evm/board_k2hk.c                           | 1 +
 board/ti/ks2_evm/board_k2l.c                            | 1 +
 board/ti/sdp4430/cmd_bat.c                              | 1 +
 board/toradex/apalis-tk1/apalis-tk1.c                   | 1 +
 board/toradex/apalis_imx6/apalis_imx6.c                 | 1 +
 board/toradex/apalis_imx6/do_fuse.c                     | 1 +
 board/toradex/colibri_imx6/colibri_imx6.c               | 1 +
 board/toradex/colibri_imx6/do_fuse.c                    | 1 +
 board/toradex/common/tdx-cfg-block.c                    | 1 +
 board/toradex/common/tdx-common.c                       | 1 +
 board/toradex/verdin-am62/verdin-am62.c                 | 1 +
 board/toradex/verdin-imx8mm/spl.c                       | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c             | 1 +
 board/toradex/verdin-imx8mp/verdin-imx8mp.c             | 1 +
 board/traverse/common/ten64_controller.c                | 1 +
 board/traverse/ten64/ten64.c                            | 1 +
 board/udoo/neo/neo.c                                    | 1 +
 board/variscite/dart_6ul/spl.c                          | 1 +
 board/variscite/imx8mn_var_som/imx8mn_var_som.c         | 1 +
 board/variscite/imx8mn_var_som/spl.c                    | 1 +
 board/vscom/baltos/board.c                              | 1 +
 board/wandboard/wandboard.c                             | 1 +
 board/work-microwave/work_92105/work_92105_display.c    | 1 +
 board/xilinx/common/board.c                             | 1 +
 board/xilinx/common/fru_ops.c                           | 1 +
 board/xilinx/versal-net/board.c                         | 1 +
 board/xilinx/versal-net/cmds.c                          | 1 +
 board/xilinx/versal/board.c                             | 1 +
 board/xilinx/versal/cmds.c                              | 1 +
 board/xilinx/zynq/board.c                               | 1 +
 board/xilinx/zynq/bootimg.c                             | 1 +
 board/xilinx/zynq/cmds.c                                | 1 +
 board/xilinx/zynqmp/cmds.c                              | 1 +
 board/xilinx/zynqmp/zynqmp.c                            | 1 +
 boot/android_ab.c                                       | 1 +
 boot/bootdev-uclass.c                                   | 1 +
 boot/bootflow.c                                         | 1 +
 boot/bootflow_menu.c                                    | 1 +
 boot/bootm.c                                            | 1 +
 boot/bootm_os.c                                         | 1 +
 boot/bootmeth-uclass.c                                  | 1 +
 boot/bootmeth_cros.c                                    | 1 +
 boot/bootmeth_efi.c                                     | 1 +
 boot/bootmeth_extlinux.c                                | 1 +
 boot/bootmeth_pxe.c                                     | 1 +
 boot/bootmeth_qfw.c                                     | 1 +
 boot/bootmeth_script.c                                  | 1 +
 boot/bootstd-uclass.c                                   | 1 +
 boot/common_fit.c                                       | 1 +
 boot/expo.c                                             | 1 +
 boot/expo_build.c                                       | 1 +
 boot/fdt_region.c                                       | 1 +
 boot/fdt_support.c                                      | 1 +
 boot/image-android.c                                    | 1 +
 boot/image-board.c                                      | 1 +
 boot/image-cipher.c                                     | 1 +
 boot/image-fdt.c                                        | 1 +
 boot/image-fit-sig.c                                    | 1 +
 boot/image-fit.c                                        | 1 +
 boot/image-host.c                                       | 1 +
 boot/image-pre-load.c                                   | 1 +
 boot/image-sig.c                                        | 1 +
 boot/image.c                                            | 1 +
 boot/scene.c                                            | 1 +
 boot/scene_menu.c                                       | 1 +
 boot/vbe.c                                              | 1 +
 boot/vbe_request.c                                      | 1 +
 boot/vbe_simple.c                                       | 1 +
 boot/vbe_simple_fw.c                                    | 1 +
 boot/vbe_simple_os.c                                    | 1 +
 cmd/2048.c                                              | 1 +
 cmd/ab_select.c                                         | 1 +
 cmd/abootimg.c                                          | 1 +
 cmd/acpi.c                                              | 1 +
 cmd/adtimg.c                                            | 1 +
 cmd/aes.c                                               | 1 +
 cmd/armflash.c                                          | 1 +
 cmd/avb.c                                               | 1 +
 cmd/bcb.c                                               | 1 +
 cmd/bdinfo.c                                            | 1 +
 cmd/binop.c                                             | 1 +
 cmd/blk_common.c                                        | 1 +
 cmd/blkmap.c                                            | 1 +
 cmd/blob.c                                              | 1 +
 cmd/bmp.c                                               | 1 +
 cmd/bootdev.c                                           | 1 +
 cmd/bootefi.c                                           | 1 +
 cmd/bootflow.c                                          | 1 +
 cmd/booti.c                                             | 1 +
 cmd/bootmeth.c                                          | 1 +
 cmd/bootstage.c                                         | 1 +
 cmd/button.c                                            | 1 +
 cmd/cache.c                                             | 1 +
 cmd/cedit.c                                             | 1 +
 cmd/cros_ec.c                                           | 1 +
 cmd/date.c                                              | 1 +
 cmd/dfu.c                                               | 1 +
 cmd/dm.c                                                | 1 +
 cmd/echo.c                                              | 1 +
 cmd/eeprom.c                                            | 1 +
 cmd/efi.c                                               | 1 +
 cmd/eficonfig.c                                         | 1 +
 cmd/eficonfig_sbkey.c                                   | 1 +
 cmd/efidebug.c                                          | 1 +
 cmd/elf.c                                               | 1 +
 cmd/ethsw.c                                             | 1 +
 cmd/extension_board.c                                   | 1 +
 cmd/fastboot.c                                          | 1 +
 cmd/fdt.c                                               | 1 +
 cmd/flash.c                                             | 1 +
 cmd/fpga.c                                              | 1 +
 cmd/fuse.c                                              | 1 +
 cmd/gpio.c                                              | 1 +
 cmd/gpt.c                                               | 1 +
 cmd/hash.c                                              | 1 +
 cmd/host.c                                              | 1 +
 cmd/i2c.c                                               | 1 +
 cmd/ide.c                                               | 1 +
 cmd/irq.c                                               | 1 +
 cmd/itest.c                                             | 1 +
 cmd/jffs2.c                                             | 1 +
 cmd/led.c                                               | 1 +
 cmd/legacy_led.c                                        | 1 +
 cmd/load.c                                              | 1 +
 cmd/log.c                                               | 1 +
 cmd/mbr.c                                               | 1 +
 cmd/md5sum.c                                            | 1 +
 cmd/mdio.c                                              | 1 +
 cmd/mem.c                                               | 1 +
 cmd/mii.c                                               | 1 +
 cmd/mmc.c                                               | 1 +
 cmd/mp.c                                                | 1 +
 cmd/mtd.c                                               | 1 +
 cmd/mtdparts.c                                          | 1 +
 cmd/mvebu/bubt.c                                        | 1 +
 cmd/mvebu/comphy_rx_training.c                          | 1 +
 cmd/nand.c                                              | 1 +
 cmd/net.c                                               | 1 +
 cmd/nvedit.c                                            | 1 +
 cmd/nvedit_efi.c                                        | 1 +
 cmd/nvme.c                                              | 1 +
 cmd/onenand.c                                           | 1 +
 cmd/optee_rpmb.c                                        | 1 +
 cmd/osd.c                                               | 1 +
 cmd/part.c                                              | 1 +
 cmd/pci.c                                               | 1 +
 cmd/pinmux.c                                            | 1 +
 cmd/printf.c                                            | 1 +
 cmd/pstore.c                                            | 1 +
 cmd/pxe.c                                               | 1 +
 cmd/read.c                                              | 1 +
 cmd/regulator.c                                         | 1 +
 cmd/remoteproc.c                                        | 1 +
 cmd/rtc.c                                               | 1 +
 cmd/sata.c                                              | 1 +
 cmd/scsi.c                                              | 1 +
 cmd/setexpr.c                                           | 1 +
 cmd/sf.c                                                | 1 +
 cmd/sha1sum.c                                           | 1 +
 cmd/sleep.c                                             | 1 +
 cmd/smccc.c                                             | 1 +
 cmd/spi.c                                               | 1 +
 cmd/stackprot_test.c                                    | 1 +
 cmd/strings.c                                           | 1 +
 cmd/sysboot.c                                           | 1 +
 cmd/test.c                                              | 1 +
 cmd/ti/ddr3.c                                           | 1 +
 cmd/timer.c                                             | 1 +
 cmd/tlv_eeprom.c                                        | 1 +
 cmd/tpm-v1.c                                            | 1 +
 cmd/tpm-v2.c                                            | 1 +
 cmd/tsi148.c                                            | 1 +
 cmd/ubi.c                                               | 1 +
 cmd/ufs.c                                               | 1 +
 cmd/universe.c                                          | 1 +
 cmd/usb.c                                               | 1 +
 cmd/usb_mass_storage.c                                  | 1 +
 cmd/vbe.c                                               | 1 +
 cmd/virtio.c                                            | 1 +
 cmd/w1.c                                                | 1 +
 cmd/x86/cbsysinfo.c                                     | 1 +
 cmd/x86/hob.c                                           | 1 +
 cmd/x86/mtrr.c                                          | 1 +
 cmd/ximg.c                                              | 1 +
 cmd/yaffs2.c                                            | 1 +
 cmd/zfs.c                                               | 1 +
 common/autoboot.c                                       | 1 +
 common/avb_verify.c                                     | 1 +
 common/bloblist.c                                       | 1 +
 common/board_f.c                                        | 1 +
 common/bootstage.c                                      | 1 +
 common/bouncebuf.c                                      | 1 +
 common/cli.c                                            | 1 +
 common/cli_getch.c                                      | 1 +
 common/cli_hush.c                                       | 1 +
 common/cli_readline.c                                   | 1 +
 common/cli_simple.c                                     | 1 +
 common/command.c                                        | 1 +
 common/console.c                                        | 1 +
 common/cyclic.c                                         | 1 +
 common/dlmalloc.c                                       | 1 +
 common/eeprom/eeprom_layout.c                           | 1 +
 common/event.c                                          | 1 +
 common/flash.c                                          | 1 +
 common/hash.c                                           | 1 +
 common/init/board_init.c                                | 1 +
 common/iomux.c                                          | 1 +
 common/kallsyms.c                                       | 1 +
 common/kgdb.c                                           | 1 +
 common/log.c                                            | 1 +
 common/log_syslog.c                                     | 1 +
 common/malloc_simple.c                                  | 1 +
 common/menu.c                                           | 1 +
 common/miiphyutil.c                                     | 1 +
 common/qfw.c                                            | 1 +
 common/scp03.c                                          | 1 +
 common/spl/spl.c                                        | 1 +
 common/spl/spl_atf.c                                    | 1 +
 common/spl/spl_fit.c                                    | 1 +
 common/spl/spl_mmc.c                                    | 1 +
 common/spl/spl_net.c                                    | 1 +
 common/spl/spl_nor.c                                    | 1 +
 common/spl/spl_ram.c                                    | 1 +
 common/spl/spl_sata.c                                   | 1 +
 common/spl/spl_ubi.c                                    | 1 +
 common/spl/spl_ymodem.c                                 | 1 +
 common/splash.c                                         | 1 +
 common/splash_source.c                                  | 1 +
 common/stdio.c                                          | 1 +
 common/update.c                                         | 1 +
 common/usb.c                                            | 1 +
 common/usb_hub.c                                        | 1 +
 common/usb_kbd.c                                        | 1 +
 common/usb_storage.c                                    | 1 +
 disk/part.c                                             | 1 +
 disk/part_amiga.c                                       | 1 +
 disk/part_dos.c                                         | 1 +
 disk/part_efi.c                                         | 1 +
 disk/part_iso.c                                         | 1 +
 drivers/ata/ahci.c                                      | 1 +
 drivers/ata/dwc_ahsata.c                                | 1 +
 drivers/ata/fsl_sata.c                                  | 1 +
 drivers/ata/libata.c                                    | 1 +
 drivers/ata/sata.c                                      | 1 +
 drivers/ata/sata_mv.c                                   | 1 +
 drivers/ata/sata_sil.c                                  | 1 +
 drivers/bios_emulator/atibios.c                         | 1 +
 drivers/bios_emulator/biosemu.c                         | 1 +
 drivers/bios_emulator/x86emu/debug.c                    | 1 +
 drivers/block/blk-uclass.c                              | 1 +
 drivers/block/blk_legacy.c                              | 1 +
 drivers/block/blkcache.c                                | 1 +
 drivers/block/blkmap.c                                  | 1 +
 drivers/block/host-uclass.c                             | 1 +
 drivers/block/host_dev.c                                | 1 +
 drivers/block/ide.c                                     | 1 +
 drivers/bootcount/spi-flash.c                           | 1 +
 drivers/button/button-uclass.c                          | 1 +
 drivers/clk/altera/clk-arria10.c                        | 1 +
 drivers/clk/at91/sam9x60.c                              | 1 +
 drivers/clk/at91/sama7g5.c                              | 1 +
 drivers/clk/at91/sckc.c                                 | 1 +
 drivers/clk/clk-mux.c                                   | 1 +
 drivers/clk/clk_scmi.c                                  | 1 +
 drivers/clk/clk_versal.c                                | 1 +
 drivers/clk/mvebu/armada-37xx-periph.c                  | 1 +
 drivers/clk/renesas/clk-rcar-gen2.c                     | 1 +
 drivers/clk/rockchip/clk_rk322x.c                       | 1 +
 drivers/clk/rockchip/clk_rk3288.c                       | 1 +
 drivers/clk/rockchip/clk_rk3328.c                       | 1 +
 drivers/clk/rockchip/clk_rk3368.c                       | 1 +
 drivers/clk/rockchip/clk_rk3399.c                       | 1 +
 drivers/clk/rockchip/clk_rk3588.c                       | 1 +
 drivers/clk/sifive/sifive-prci.c                        | 1 +
 drivers/clk/stm32/clk-stm32f.c                          | 1 +
 drivers/clk/ti/clk-k3.c                                 | 1 +
 drivers/clk/ti/clk.c                                    | 1 +
 drivers/core/acpi.c                                     | 1 +
 drivers/core/device.c                                   | 1 +
 drivers/core/dump.c                                     | 1 +
 drivers/core/lists.c                                    | 1 +
 drivers/core/of_access.c                                | 1 +
 drivers/core/of_addr.c                                  | 1 +
 drivers/core/of_extra.c                                 | 1 +
 drivers/core/ofnode.c                                   | 1 +
 drivers/core/root.c                                     | 1 +
 drivers/core/uclass.c                                   | 1 +
 drivers/cpu/cpu-uclass.c                                | 1 +
 drivers/cpu/cpu_sandbox.c                               | 1 +
 drivers/cpu/imx8_cpu.c                                  | 1 +
 drivers/cpu/imx9_cpu.c                                  | 1 +
 drivers/cpu/riscv_cpu.c                                 | 1 +
 drivers/crypto/ace_sha.c                                | 1 +
 drivers/crypto/aspeed/aspeed_acry.c                     | 1 +
 drivers/crypto/aspeed/aspeed_hace.c                     | 1 +
 drivers/crypto/fsl/dcp_rng.c                            | 1 +
 drivers/crypto/fsl/desc_constr.h                        | 1 +
 drivers/crypto/fsl/error.c                              | 1 +
 drivers/crypto/fsl/fsl_blob.c                           | 1 +
 drivers/crypto/fsl/fsl_hash.c                           | 1 +
 drivers/crypto/fsl/jobdesc.c                            | 1 +
 drivers/crypto/fsl/jr.c                                 | 1 +
 drivers/crypto/fsl/rng.c                                | 1 +
 drivers/crypto/hash/hash-uclass.c                       | 1 +
 drivers/crypto/nuvoton/npcm_aes.c                       | 1 +
 drivers/crypto/nuvoton/npcm_sha.c                       | 1 +
 drivers/ddr/altera/sdram_arria10.c                      | 1 +
 drivers/ddr/altera/sdram_gen5.c                         | 1 +
 drivers/ddr/altera/sdram_n5x.c                          | 1 +
 drivers/ddr/altera/sdram_soc64.c                        | 1 +
 drivers/ddr/altera/sequencer.c                          | 1 +
 drivers/ddr/fsl/ctrl_regs.c                             | 1 +
 drivers/ddr/fsl/ddr1_dimm_params.c                      | 1 +
 drivers/ddr/fsl/ddr2_dimm_params.c                      | 1 +
 drivers/ddr/fsl/ddr3_dimm_params.c                      | 1 +
 drivers/ddr/fsl/ddr4_dimm_params.c                      | 1 +
 drivers/ddr/fsl/interactive.c                           | 1 +
 drivers/ddr/fsl/main.c                                  | 1 +
 drivers/ddr/imx/imx9/ddr_init.c                         | 1 +
 drivers/ddr/marvell/a38x/mv_ddr4_mpr_pda_if.c           | 2 ++
 drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c | 1 +
 drivers/ddr/marvell/axp/ddr3_hw_training.c              | 1 +
 drivers/ddr/marvell/axp/ddr3_pbs.c                      | 1 +
 drivers/ddr/marvell/axp/ddr3_spd.c                      | 1 +
 drivers/ddr/marvell/axp/ddr3_write_leveling.c           | 1 +
 drivers/dfu/dfu.c                                       | 1 +
 drivers/dfu/dfu_alt.c                                   | 1 +
 drivers/dfu/dfu_mmc.c                                   | 1 +
 drivers/dfu/dfu_mtd.c                                   | 1 +
 drivers/dfu/dfu_nand.c                                  | 1 +
 drivers/dfu/dfu_ram.c                                   | 1 +
 drivers/dfu/dfu_sf.c                                    | 1 +
 drivers/dma/apbh_dma.c                                  | 1 +
 drivers/dma/keystone_nav.c                              | 1 +
 drivers/dma/sandbox-dma-test.c                          | 1 +
 drivers/dma/ti-edma3.c                                  | 1 +
 drivers/dma/ti/k3-udma.c                                | 1 +
 drivers/fastboot/fb_command.c                           | 1 +
 drivers/fastboot/fb_common.c                            | 1 +
 drivers/fastboot/fb_getvar.c                            | 1 +
 drivers/fastboot/fb_mmc.c                               | 1 +
 drivers/fastboot/fb_nand.c                              | 1 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c               | 1 +
 drivers/firmware/arm-ffa/ffa-emul-uclass.c              | 1 +
 drivers/firmware/psci.c                                 | 1 +
 drivers/firmware/scmi/optee_agent.c                     | 1 +
 drivers/firmware/scmi/sandbox-scmi_agent.c              | 1 +
 drivers/firmware/scmi/smt.c                             | 1 +
 drivers/firmware/ti_sci.c                               | 1 +
 drivers/fpga/fpga.c                                     | 1 +
 drivers/fpga/intel_sdm_mb.c                             | 1 +
 drivers/fpga/socfpga_arria10.c                          | 1 +
 drivers/fpga/versalpl.c                                 | 1 +
 drivers/fpga/xilinx.c                                   | 1 +
 drivers/fpga/zynqmppl.c                                 | 1 +
 drivers/fwu-mdata/gpt_blk.c                             | 1 +
 drivers/fwu-mdata/raw_mtd.c                             | 1 +
 drivers/gpio/74x164_gpio.c                              | 1 +
 drivers/gpio/axp_gpio.c                                 | 1 +
 drivers/gpio/da8xx_gpio.c                               | 1 +
 drivers/gpio/dwapb_gpio.c                               | 1 +
 drivers/gpio/gpio-fxl6408.c                             | 1 +
 drivers/gpio/gpio-uclass.c                              | 1 +
 drivers/gpio/gpio_slg7xl45106.c                         | 1 +
 drivers/gpio/hi6220_gpio.c                              | 1 +
 drivers/gpio/imx_rgpio2p.c                              | 1 +
 drivers/gpio/intel_gpio.c                               | 1 +
 drivers/gpio/iproc_gpio.c                               | 1 +
 drivers/gpio/lpc32xx_gpio.c                             | 1 +
 drivers/gpio/mcp230xx_gpio.c                            | 1 +
 drivers/gpio/mpc83xx_spisel_boot.c                      | 1 +
 drivers/gpio/mpc8xx_gpio.c                              | 1 +
 drivers/gpio/mpc8xxx_gpio.c                             | 1 +
 drivers/gpio/mxc_gpio.c                                 | 1 +
 drivers/gpio/mxs_gpio.c                                 | 1 +
 drivers/gpio/nmk_gpio.c                                 | 1 +
 drivers/gpio/nx_gpio.c                                  | 1 +
 drivers/gpio/octeon_gpio.c                              | 1 +
 drivers/gpio/omap_gpio.c                                | 1 +
 drivers/gpio/pca953x_gpio.c                             | 1 +
 drivers/gpio/pic32_gpio.c                               | 1 +
 drivers/gpio/qe_gpio.c                                  | 1 +
 drivers/gpio/rk_gpio.c                                  | 1 +
 drivers/gpio/sifive-gpio.c                              | 1 +
 drivers/gpio/sunxi_gpio.c                               | 1 +
 drivers/gpio/xilinx_gpio.c                              | 1 +
 drivers/gpio/zynq_gpio.c                                | 1 +
 drivers/gpio/zynqmp_gpio_modepin.c                      | 1 +
 drivers/i2c/fsl_i2c.c                                   | 1 +
 drivers/i2c/i2c-uclass.c                                | 1 +
 drivers/i2c/ihs_i2c.c                                   | 1 +
 drivers/i2c/intel_i2c.c                                 | 1 +
 drivers/i2c/lpc32xx_i2c.c                               | 1 +
 drivers/i2c/muxes/i2c-mux-uclass.c                      | 1 +
 drivers/i2c/mv_i2c.c                                    | 1 +
 drivers/i2c/mvtwsi.c                                    | 1 +
 drivers/i2c/stm32f7_i2c.c                               | 1 +
 drivers/i2c/tegra186_bpmp_i2c.c                         | 1 +
 drivers/i2c/tegra_i2c.c                                 | 1 +
 drivers/input/apple_spi_kbd.c                           | 1 +
 drivers/input/button_kbd.c                              | 1 +
 drivers/input/cros_ec_keyb.c                            | 1 +
 drivers/input/i8042.c                                   | 1 +
 drivers/input/input.c                                   | 1 +
 drivers/input/key_matrix.c                              | 1 +
 drivers/input/keyboard-uclass.c                         | 1 +
 drivers/input/tegra-kbc.c                               | 1 +
 drivers/iommu/apple_dart.c                              | 1 +
 drivers/led/led-uclass.c                                | 1 +
 drivers/memory/ti-gpmc.c                                | 1 +
 drivers/misc/atsha204a-i2c.c                            | 1 +
 drivers/misc/cbmem_console.c                            | 1 +
 drivers/misc/cros_ec.c                                  | 1 +
 drivers/misc/cros_ec_i2c.c                              | 1 +
 drivers/misc/cros_ec_sandbox.c                          | 1 +
 drivers/misc/cros_ec_spi.c                              | 1 +
 drivers/misc/ds4510.c                                   | 1 +
 drivers/misc/fsl_portals.c                              | 1 +
 drivers/misc/gdsys_ioep.c                               | 1 +
 drivers/misc/gsc.c                                      | 1 +
 drivers/misc/i2c_eeprom_emul.c                          | 1 +
 drivers/misc/ihs_fpga.c                                 | 1 +
 drivers/misc/misc_sandbox.c                             | 1 +
 drivers/misc/mpc83xx_serdes.c                           | 1 +
 drivers/misc/npcm_host_intf.c                           | 1 +
 drivers/misc/qfw.c                                      | 1 +
 drivers/misc/qfw_sandbox.c                              | 1 +
 drivers/misc/rockchip-efuse.c                           | 1 +
 drivers/misc/rockchip-otp.c                             | 1 +
 drivers/misc/sifive-otp.c                               | 1 +
 drivers/misc/tegra186_bpmp.c                            | 1 +
 drivers/misc/usb251xb.c                                 | 1 +
 drivers/misc/vexpress_config.c                          | 1 +
 drivers/mmc/ca_dw_mmc.c                                 | 1 +
 drivers/mmc/davinci_mmc.c                               | 1 +
 drivers/mmc/f_sdh30.c                                   | 1 +
 drivers/mmc/fsl_esdhc_imx.c                             | 1 +
 drivers/mmc/fsl_esdhc_spl.c                             | 1 +
 drivers/mmc/ftsdc010_mci.c                              | 1 +
 drivers/mmc/iproc_sdhci.c                               | 1 +
 drivers/mmc/meson_gx_mmc.c                              | 1 +
 drivers/mmc/mmc.c                                       | 1 +
 drivers/mmc/mmc_spi.c                                   | 1 +
 drivers/mmc/msm_sdhci.c                                 | 1 +
 drivers/mmc/mxcmmc.c                                    | 1 +
 drivers/mmc/mxsmmc.c                                    | 1 +
 drivers/mmc/octeontx_hsmmc.c                            | 1 +
 drivers/mmc/rpmb.c                                      | 1 +
 drivers/mmc/sandbox_mmc.c                               | 1 +
 drivers/mmc/sdhci.c                                     | 1 +
 drivers/mmc/sh_mmcif.c                                  | 1 +
 drivers/mmc/snps_dw_mmc.c                               | 1 +
 drivers/mmc/sti_sdhci.c                                 | 1 +
 drivers/mmc/sunxi_mmc.c                                 | 1 +
 drivers/mmc/xenon_sdhci.c                               | 1 +
 drivers/mtd/altera_qspi.c                               | 1 +
 drivers/mtd/cfi_flash.c                                 | 1 +
 drivers/mtd/cfi_mtd.c                                   | 1 +
 drivers/mtd/mtd_uboot.c                                 | 1 +
 drivers/mtd/mtdpart.c                                   | 1 +
 drivers/mtd/nand/raw/atmel/nand-controller.c            | 1 +
 drivers/mtd/nand/raw/atmel/pmecc.c                      | 1 +
 drivers/mtd/nand/raw/atmel_nand.c                       | 1 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                | 1 +
 drivers/mtd/nand/raw/cortina_nand.c                     | 1 +
 drivers/mtd/nand/raw/denali.c                           | 1 +
 drivers/mtd/nand/raw/denali_spl.c                       | 1 +
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c                 | 1 +
 drivers/mtd/nand/raw/mt7621_nand.c                      | 1 +
 drivers/mtd/nand/raw/mt7621_nand_spl.c                  | 1 +
 drivers/mtd/nand/raw/mxic_nand.c                        | 1 +
 drivers/mtd/nand/raw/mxs_nand.c                         | 1 +
 drivers/mtd/nand/raw/mxs_nand_spl.c                     | 1 +
 drivers/mtd/nand/raw/nand_base.c                        | 1 +
 drivers/mtd/nand/raw/nand_bch.c                         | 1 +
 drivers/mtd/nand/raw/nand_spl_loaders.c                 | 1 +
 drivers/mtd/nand/raw/nand_util.c                        | 1 +
 drivers/mtd/nand/raw/octeontx_bch.c                     | 1 +
 drivers/mtd/nand/raw/octeontx_nand.c                    | 1 +
 drivers/mtd/nand/raw/omap_gpmc.c                        | 1 +
 drivers/mtd/nand/raw/pxa3xx_nand.c                      | 1 +
 drivers/mtd/nand/raw/rockchip_nfc.c                     | 1 +
 drivers/mtd/nand/raw/sunxi_nand.c                       | 1 +
 drivers/mtd/nand/raw/sunxi_nand_spl.c                   | 1 +
 drivers/mtd/nand/raw/tegra_nand.c                       | 1 +
 drivers/mtd/nand/raw/vf610_nfc.c                        | 1 +
 drivers/mtd/nand/spi/core.c                             | 1 +
 drivers/mtd/onenand/onenand_base.c                      | 1 +
 drivers/mtd/onenand/onenand_bbt.c                       | 1 +
 drivers/mtd/onenand/onenand_spl.c                       | 1 +
 drivers/mtd/onenand/onenand_uboot.c                     | 1 +
 drivers/mtd/onenand/samsung.c                           | 1 +
 drivers/mtd/spi/fsl_espi_spl.c                          | 1 +
 drivers/mtd/spi/sandbox.c                               | 1 +
 drivers/mtd/spi/sf-uclass.c                             | 1 +
 drivers/mtd/spi/sf_dataflash.c                          | 1 +
 drivers/mtd/spi/sf_mtd.c                                | 1 +
 drivers/mtd/spi/sf_probe.c                              | 1 +
 drivers/mtd/spi/spi-nor-core.c                          | 1 +
 drivers/mtd/spi/spi-nor-tiny.c                          | 1 +
 drivers/mtd/ubi/attach.c                                | 1 +
 drivers/mtd/ubi/build.c                                 | 1 +
 drivers/mtd/ubi/debug.c                                 | 1 +
 drivers/mtd/ubi/eba.c                                   | 1 +
 drivers/mtd/ubi/fastmap.c                               | 1 +
 drivers/mtd/ubi/io.c                                    | 1 +
 drivers/mtd/ubi/kapi.c                                  | 1 +
 drivers/mtd/ubi/upd.c                                   | 1 +
 drivers/mtd/ubi/vmt.c                                   | 1 +
 drivers/mtd/ubi/vtbl.c                                  | 1 +
 drivers/mtd/ubispl/ubispl.c                             | 1 +
 drivers/net/ag7xxx.c                                    | 1 +
 drivers/net/altera_tse.c                                | 1 +
 drivers/net/bcm-sf2-eth-gmac.c                          | 1 +
 drivers/net/bcm-sf2-eth.c                               | 1 +
 drivers/net/bcm6368-eth.c                               | 1 +
 drivers/net/bnxt/bnxt.c                                 | 1 +
 drivers/net/calxedaxgmac.c                              | 1 +
 drivers/net/cortina_ni.c                                | 1 +
 drivers/net/dc2114x.c                                   | 1 +
 drivers/net/designware.c                                | 1 +
 drivers/net/dsa_sandbox.c                               | 1 +
 drivers/net/dwc_eth_qos.c                               | 1 +
 drivers/net/e1000.c                                     | 1 +
 drivers/net/e1000_spi.c                                 | 1 +
 drivers/net/eepro100.c                                  | 1 +
 drivers/net/eth-phy-uclass.c                            | 1 +
 drivers/net/ethoc.c                                     | 1 +
 drivers/net/fec_mxc.c                                   | 1 +
 drivers/net/fm/eth.c                                    | 1 +
 drivers/net/fm/fm.c                                     | 1 +
 drivers/net/fm/tgec_phy.c                               | 1 +
 drivers/net/fsl-mc/dpio/qbman_portal.c                  | 1 +
 drivers/net/fsl-mc/dpio/qbman_sys.h                     | 1 +
 drivers/net/fsl-mc/mc.c                                 | 1 +
 drivers/net/fsl_enetc.c                                 | 1 +
 drivers/net/fsl_mcdmafec.c                              | 1 +
 drivers/net/fsl_mdio.c                                  | 1 +
 drivers/net/ftmac100.c                                  | 1 +
 drivers/net/gmac_rockchip.c                             | 1 +
 drivers/net/higmacv300.c                                | 1 +
 drivers/net/ldpaa_eth/ldpaa_eth.c                       | 1 +
 drivers/net/macb.c                                      | 1 +
 drivers/net/mcffec.c                                    | 1 +
 drivers/net/mcfmii.c                                    | 1 +
 drivers/net/mpc8xx_fec.c                                | 1 +
 drivers/net/mscc_eswitch/felix_switch.c                 | 1 +
 drivers/net/mscc_eswitch/jr2_switch.c                   | 1 +
 drivers/net/mscc_eswitch/luton_switch.c                 | 1 +
 drivers/net/mscc_eswitch/ocelot_switch.c                | 1 +
 drivers/net/mscc_eswitch/serval_switch.c                | 1 +
 drivers/net/mscc_eswitch/servalt_switch.c               | 1 +
 drivers/net/mt7620-eth.c                                | 1 +
 drivers/net/mt7628-eth.c                                | 1 +
 drivers/net/mtk_eth.c                                   | 1 +
 drivers/net/mvgbe.c                                     | 1 +
 drivers/net/mvneta.c                                    | 1 +
 drivers/net/mvpp2.c                                     | 1 +
 drivers/net/netconsole.c                                | 1 +
 drivers/net/npcm750_eth.c                               | 1 +
 drivers/net/octeon/octeon_eth.c                         | 1 +
 drivers/net/octeontx/bgx.c                              | 1 +
 drivers/net/octeontx/nic_main.c                         | 1 +
 drivers/net/octeontx/nicvf_main.c                       | 1 +
 drivers/net/octeontx/nicvf_queues.c                     | 1 +
 drivers/net/octeontx2/cgx.c                             | 1 +
 drivers/net/octeontx2/cgx_intf.c                        | 1 +
 drivers/net/octeontx2/nix.c                             | 1 +
 drivers/net/octeontx2/nix_af.c                          | 1 +
 drivers/net/octeontx2/rvu_af.c                          | 1 +
 drivers/net/octeontx2/rvu_common.c                      | 1 +
 drivers/net/octeontx2/rvu_pf.c                          | 1 +
 drivers/net/pch_gbe.c                                   | 1 +
 drivers/net/pcnet.c                                     | 1 +
 drivers/net/pfe_eth/pfe_cmd.c                           | 1 +
 drivers/net/pfe_eth/pfe_driver.c                        | 1 +
 drivers/net/pfe_eth/pfe_firmware.c                      | 1 +
 drivers/net/pfe_eth/pfe_hw.c                            | 1 +
 drivers/net/phy/adin.c                                  | 1 +
 drivers/net/phy/aquantia.c                              | 1 +
 drivers/net/phy/atheros.c                               | 1 +
 drivers/net/phy/b53.c                                   | 1 +
 drivers/net/phy/fixed.c                                 | 1 +
 drivers/net/phy/miiphybb.c                              | 1 +
 drivers/net/phy/mv88e61xx.c                             | 1 +
 drivers/net/phy/mv88e6352.c                             | 1 +
 drivers/net/phy/ncsi.c                                  | 1 +
 drivers/net/phy/phy.c                                   | 1 +
 drivers/net/pic32_mdio.c                                | 1 +
 drivers/net/qe/dm_qe_uec.c                              | 1 +
 drivers/net/qe/uccf.c                                   | 1 +
 drivers/net/ravb.c                                      | 1 +
 drivers/net/rswitch.c                                   | 1 +
 drivers/net/rtl8139.c                                   | 1 +
 drivers/net/rtl8169.c                                   | 1 +
 drivers/net/sandbox-raw-bus.c                           | 1 +
 drivers/net/sandbox-raw.c                               | 1 +
 drivers/net/sandbox.c                                   | 1 +
 drivers/net/sja1105.c                                   | 1 +
 drivers/net/smc911x.c                                   | 1 +
 drivers/net/sni_ave.c                                   | 1 +
 drivers/net/sun8i_emac.c                                | 1 +
 drivers/net/sunxi_emac.c                                | 1 +
 drivers/net/ti/cpsw-common.c                            | 1 +
 drivers/net/ti/cpsw.c                                   | 1 +
 drivers/net/ti/davinci_emac.c                           | 1 +
 drivers/net/tsec.c                                      | 1 +
 drivers/net/xilinx_axi_emac.c                           | 1 +
 drivers/net/xilinx_axi_mrmac.c                          | 1 +
 drivers/net/zynq_gem.c                                  | 1 +
 drivers/nvme/nvme.c                                     | 1 +
 drivers/nvme/nvme_apple.c                               | 1 +
 drivers/pci/pci-uclass.c                                | 1 +
 drivers/pci/pci_rom.c                                   | 1 +
 drivers/pci/pci_tegra.c                                 | 1 +
 drivers/pci/pcie_layerscape_fixup.c                     | 1 +
 drivers/pci/pcie_layerscape_fixup_common.c              | 1 +
 drivers/pci_endpoint/sandbox-pci_ep.c                   | 1 +
 drivers/phy/allwinner/phy-sun4i-usb.c                   | 1 +
 drivers/phy/marvell/comphy_a3700.c                      | 1 +
 drivers/phy/meson-axg-mipi-dphy.c                       | 1 +
 drivers/phy/meson-axg-mipi-pcie-analog.c                | 1 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c        | 1 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c           | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c               | 1 +
 drivers/phy/rockchip/phy-rockchip-usbdp.c               | 1 +
 drivers/phy/ti/phy-j721e-wiz.c                          | 1 +
 drivers/pinctrl/exynos/pinctrl-exynos.c                 | 1 +
 drivers/pinctrl/mtmips/pinctrl-mtmips-common.c          | 1 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c             | 1 +
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c              | 1 +
 drivers/pinctrl/nexell/pinctrl-nexell.c                 | 1 +
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c                | 1 +
 drivers/pinctrl/pinctrl-apple.c                         | 1 +
 drivers/pinctrl/pinctrl-generic.c                       | 1 +
 drivers/pinctrl/pinctrl-k210.c                          | 1 +
 drivers/pinctrl/pinctrl-sandbox.c                       | 1 +
 drivers/pinctrl/pinctrl-stmfx.c                         | 1 +
 drivers/pinctrl/pinctrl-zynqmp.c                        | 1 +
 drivers/pinctrl/pinctrl_stm32.c                         | 1 +
 drivers/pinctrl/renesas/pfc.c                           | 1 +
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c        | 1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                   | 1 +
 drivers/power/domain/imx8-power-domain-legacy.c         | 1 +
 drivers/power/domain/imx8m-power-domain.c               | 1 +
 drivers/power/pmic/i2c_pmic_emul.c                      | 1 +
 drivers/power/pmic/palmas.c                             | 1 +
 drivers/power/pmic/pmic-uclass.c                        | 1 +
 drivers/power/power_core.c                              | 1 +
 drivers/power/power_i2c.c                               | 1 +
 drivers/power/regulator/axp_regulator.c                 | 1 +
 drivers/power/regulator/bd71837.c                       | 1 +
 drivers/power/regulator/da9063.c                        | 1 +
 drivers/power/regulator/npcm8xx_regulator.c             | 1 +
 drivers/power/regulator/palmas_regulator.c              | 1 +
 drivers/power/regulator/pca9450.c                       | 1 +
 drivers/power/regulator/pfuze100.c                      | 1 +
 drivers/power/regulator/regulator-uclass.c              | 1 +
 drivers/pwm/pwm-meson.c                                 | 1 +
 drivers/qe/qe.c                                         | 1 +
 drivers/ram/imxrt_sdram.c                               | 1 +
 drivers/ram/octeon/octeon3_lmc.c                        | 1 +
 drivers/ram/renesas/rzn1/ddr_async.c                    | 1 +
 drivers/ram/rockchip/sdram_rk3066.c                     | 1 +
 drivers/ram/rockchip/sdram_rk3188.c                     | 1 +
 drivers/ram/rockchip/sdram_rk322x.c                     | 1 +
 drivers/ram/rockchip/sdram_rk3288.c                     | 1 +
 drivers/ram/rockchip/sdram_rk3328.c                     | 1 +
 drivers/ram/rockchip/sdram_rv1126.c                     | 1 +
 drivers/ram/stm32_sdram.c                               | 1 +
 drivers/ram/stm32mp1/stm32mp1_ddr.c                     | 1 +
 drivers/ram/stm32mp1/stm32mp1_interactive.c             | 1 +
 drivers/ram/stm32mp1/stm32mp1_tests.c                   | 1 +
 drivers/reboot-mode/reboot-mode-uclass.c                | 1 +
 drivers/remoteproc/ipu_rproc.c                          | 1 +
 drivers/remoteproc/k3_system_controller.c               | 1 +
 drivers/remoteproc/pru_rproc.c                          | 1 +
 drivers/remoteproc/rproc-elf-loader.c                   | 1 +
 drivers/remoteproc/rproc-uclass.c                       | 1 +
 drivers/remoteproc/ti_k3_dsp_rproc.c                    | 1 +
 drivers/remoteproc/ti_k3_r5f_rproc.c                    | 1 +
 drivers/remoteproc/ti_power_proc.c                      | 1 +
 drivers/reset/reset-jh7110.c                            | 1 +
 drivers/rng/iproc_rng200.c                              | 1 +
 drivers/rng/meson-rng.c                                 | 1 +
 drivers/rng/optee_rng.c                                 | 1 +
 drivers/rng/smccc_trng.c                                | 1 +
 drivers/rng/stm32mp1_rng.c                              | 1 +
 drivers/rtc/abx80x.c                                    | 1 +
 drivers/rtc/i2c_rtc_emul.c                              | 1 +
 drivers/scsi/scsi.c                                     | 1 +
 drivers/scsi/scsi_emul.c                                | 1 +
 drivers/serial/sandbox.c                                | 1 +
 drivers/serial/serial-uclass.c                          | 1 +
 drivers/serial/serial.c                                 | 1 +
 drivers/serial/serial_mtk.c                             | 1 +
 drivers/serial/serial_octeon_bootcmd.c                  | 1 +
 drivers/serial/serial_octeon_pcie_console.c             | 1 +
 drivers/serial/serial_semihosting.c                     | 1 +
 drivers/serial/usbtty.c                                 | 1 +
 drivers/smem/msm_smem.c                                 | 1 +
 drivers/soc/soc-uclass.c                                | 1 +
 drivers/soc/ti/k3-navss-ringacc.c                       | 1 +
 drivers/sound/sound.c                                   | 1 +
 drivers/spi/atcspi200_spi.c                             | 1 +
 drivers/spi/bcm63xx_hsspi.c                             | 1 +
 drivers/spi/bcmstb_spi.c                                | 1 +
 drivers/spi/ca_sflash.c                                 | 1 +
 drivers/spi/cadence_ospi_versal.c                       | 1 +
 drivers/spi/cadence_qspi_apb.c                          | 1 +
 drivers/spi/cf_spi.c                                    | 1 +
 drivers/spi/designware_spi.c                            | 1 +
 drivers/spi/fsl_espi.c                                  | 1 +
 drivers/spi/fsl_qspi.c                                  | 1 +
 drivers/spi/gxp_spi.c                                   | 1 +
 drivers/spi/ich.c                                       | 1 +
 drivers/spi/meson_spifc.c                               | 1 +
 drivers/spi/mtk_snfi_spi.c                              | 1 +
 drivers/spi/mtk_snor.c                                  | 1 +
 drivers/spi/mtk_spim.c                                  | 1 +
 drivers/spi/mxc_spi.c                                   | 1 +
 drivers/spi/mxs_spi.c                                   | 1 +
 drivers/spi/npcm_fiu_spi.c                              | 1 +
 drivers/spi/nxp_fspi.c                                  | 1 +
 drivers/spi/octeon_spi.c                                | 1 +
 drivers/spi/rockchip_sfc.c                              | 1 +
 drivers/spi/spi-aspeed-smc.c                            | 1 +
 drivers/spi/spi-mem-nodm.c                              | 1 +
 drivers/spi/spi-mem.c                                   | 1 +
 drivers/spi/spi-mxic.c                                  | 1 +
 drivers/spi/spi-sifive.c                                | 1 +
 drivers/spi/spi.c                                       | 1 +
 drivers/spi/tegra210_qspi.c                             | 1 +
 drivers/spi/zynq_qspi.c                                 | 1 +
 drivers/spi/zynqmp_gqspi.c                              | 1 +
 drivers/sysinfo/gpio.c                                  | 1 +
 drivers/sysinfo/rcar3.c                                 | 1 +
 drivers/sysreset/sysreset_sandbox.c                     | 1 +
 drivers/tee/broadcom/chimp_optee.c                      | 1 +
 drivers/tee/optee/core.c                                | 1 +
 drivers/tee/sandbox.c                                   | 1 +
 drivers/tee/tee-uclass.c                                | 1 +
 drivers/thermal/imx_scu_thermal.c                       | 1 +
 drivers/thermal/imx_tmu.c                               | 1 +
 drivers/tpm/cr50_i2c.c                                  | 1 +
 drivers/tpm/sandbox_common.c                            | 1 +
 drivers/tpm/tpm-uclass.c                                | 1 +
 drivers/tpm/tpm2_ftpm_tee.c                             | 1 +
 drivers/tpm/tpm2_tis_sandbox.c                          | 1 +
 drivers/tpm/tpm2_tis_spi.c                              | 1 +
 drivers/tpm/tpm_atmel_twi.c                             | 1 +
 drivers/tpm/tpm_tis_infineon.c                          | 1 +
 drivers/tpm/tpm_tis_lpc.c                               | 1 +
 drivers/tpm/tpm_tis_sandbox.c                           | 1 +
 drivers/tpm/tpm_tis_st33zp24_i2c.c                      | 1 +
 drivers/tpm/tpm_tis_st33zp24_spi.c                      | 1 +
 drivers/ufs/ufs.c                                       | 1 +
 drivers/usb/cdns3/gadget.c                              | 1 +
 drivers/usb/common/common.c                             | 1 +
 drivers/usb/common/fsl-dt-fixup.c                       | 1 +
 drivers/usb/common/usb_urb.c                            | 1 +
 drivers/usb/dwc3/dwc3-generic.c                         | 1 +
 drivers/usb/dwc3/dwc3-uniphier.c                        | 1 +
 drivers/usb/dwc3/ep0.c                                  | 1 +
 drivers/usb/dwc3/gadget.c                               | 1 +
 drivers/usb/emul/sandbox_flash.c                        | 1 +
 drivers/usb/emul/sandbox_keyb.c                         | 1 +
 drivers/usb/emul/usb-emul-uclass.c                      | 1 +
 drivers/usb/eth/asix.c                                  | 1 +
 drivers/usb/eth/asix88179.c                             | 1 +
 drivers/usb/eth/lan75xx.c                               | 1 +
 drivers/usb/eth/lan78xx.c                               | 1 +
 drivers/usb/eth/lan7x.c                                 | 1 +
 drivers/usb/eth/mcs7830.c                               | 1 +
 drivers/usb/eth/r8152.c                                 | 1 +
 drivers/usb/eth/smsc95xx.c                              | 1 +
 drivers/usb/gadget/at91_udc.c                           | 1 +
 drivers/usb/gadget/atmel_usba_udc.c                     | 1 +
 drivers/usb/gadget/ci_udc.c                             | 1 +
 drivers/usb/gadget/composite.c                          | 1 +
 drivers/usb/gadget/dwc2_udc_otg.c                       | 1 +
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c              | 1 +
 drivers/usb/gadget/epautoconf.c                         | 1 +
 drivers/usb/gadget/ether.c                              | 1 +
 drivers/usb/gadget/f_acm.c                              | 1 +
 drivers/usb/gadget/f_dfu.c                              | 1 +
 drivers/usb/gadget/f_fastboot.c                         | 1 +
 drivers/usb/gadget/f_mass_storage.c                     | 1 +
 drivers/usb/gadget/f_rockusb.c                          | 1 +
 drivers/usb/gadget/f_sdp.c                              | 1 +
 drivers/usb/gadget/f_thor.c                             | 1 +
 drivers/usb/gadget/g_dnl.c                              | 1 +
 drivers/usb/gadget/gadget_chips.h                       | 1 +
 drivers/usb/gadget/rndis.c                              | 1 +
 drivers/usb/gadget/u_os_desc.h                          | 1 +
 drivers/usb/gadget/usbstring.c                          | 1 +
 drivers/usb/host/dwc2.c                                 | 1 +
 drivers/usb/host/dwc3-octeon-glue.c                     | 1 +
 drivers/usb/host/ehci-fsl.c                             | 1 +
 drivers/usb/host/ehci-hcd.c                             | 1 +
 drivers/usb/host/ehci-mx5.c                             | 1 +
 drivers/usb/host/ehci-mxs.c                             | 1 +
 drivers/usb/host/ehci-omap.c                            | 1 +
 drivers/usb/host/ehci-tegra.c                           | 1 +
 drivers/usb/host/ehci-vf.c                              | 1 +
 drivers/usb/host/ohci-hcd.c                             | 1 +
 drivers/usb/host/r8a66597-hcd.c                         | 1 +
 drivers/usb/host/r8a66597.h                             | 1 +
 drivers/usb/host/usb-uclass.c                           | 1 +
 drivers/usb/host/xhci-dwc3.c                            | 1 +
 drivers/usb/host/xhci-mem.c                             | 1 +
 drivers/usb/host/xhci.c                                 | 1 +
 drivers/usb/isp1760/isp1760-hcd.c                       | 1 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c                      | 1 +
 drivers/usb/mtu3/mtu3_qmu.c                             | 1 +
 drivers/usb/musb-new/am35x.c                            | 1 +
 drivers/usb/musb-new/mt85xx.c                           | 1 +
 drivers/usb/musb-new/musb_core.c                        | 1 +
 drivers/usb/musb-new/musb_gadget.c                      | 1 +
 drivers/usb/musb-new/musb_uboot.c                       | 1 +
 drivers/usb/musb-new/pic32.c                            | 1 +
 drivers/usb/musb-new/sunxi.c                            | 1 +
 drivers/usb/musb-new/ti-musb.c                          | 1 +
 drivers/usb/musb-new/ux500.c                            | 1 +
 drivers/usb/musb/am35x.c                                | 1 +
 drivers/usb/musb/musb_hcd.c                             | 1 +
 drivers/video/bridge/anx6345.c                          | 1 +
 drivers/video/bridge/ssd2825.c                          | 1 +
 drivers/video/console_core.c                            | 1 +
 drivers/video/console_truetype.c                        | 1 +
 drivers/video/dw_hdmi.c                                 | 1 +
 drivers/video/dw_mipi_dsi.c                             | 1 +
 drivers/video/endeavoru-panel.c                         | 1 +
 drivers/video/exynos/exynos_dp.c                        | 1 +
 drivers/video/exynos/exynos_mipi_dsi.c                  | 1 +
 drivers/video/himax-hx8394.c                            | 1 +
 drivers/video/ihs_video_out.c                           | 1 +
 drivers/video/imx/ipu_common.c                          | 1 +
 drivers/video/logicore_dp_tx.c                          | 1 +
 drivers/video/mali_dp.c                                 | 1 +
 drivers/video/meson/meson_venc.c                        | 1 +
 drivers/video/mipi_dsi.c                                | 1 +
 drivers/video/mxsfb.c                                   | 1 +
 drivers/video/nexell_display.c                          | 1 +
 drivers/video/orisetech_otm8009a.c                      | 1 +
 drivers/video/raydium-rm68200.c                         | 1 +
 drivers/video/renesas-r61307.c                          | 1 +
 drivers/video/renesas-r69328.c                          | 1 +
 drivers/video/rockchip/rk_edp.c                         | 1 +
 drivers/video/rockchip/rk_vop.c                         | 1 +
 drivers/video/sandbox_osd.c                             | 1 +
 drivers/video/simple_panel.c                            | 1 +
 drivers/video/simplefb.c                                | 1 +
 drivers/video/stb_truetype.h                            | 1 +
 drivers/video/sunxi/sunxi_de2.c                         | 1 +
 drivers/video/sunxi/sunxi_display.c                     | 1 +
 drivers/video/sunxi/sunxi_lcd.c                         | 1 +
 drivers/video/tdo-tl070wsh30.c                          | 1 +
 drivers/video/tegra124/dp.c                             | 1 +
 drivers/video/tegra20/tegra-dc.c                        | 1 +
 drivers/video/tegra20/tegra-dsi.c                       | 1 +
 drivers/video/ti/tilcdc-panel.c                         | 1 +
 drivers/video/ti/tilcdc.c                               | 1 +
 drivers/video/tidss/tidss_drv.c                         | 1 +
 drivers/video/vidconsole-uclass.c                       | 1 +
 drivers/video/video-uclass.c                            | 1 +
 drivers/video/videomodes.c                              | 1 +
 drivers/video/zynqmp/zynqmp_dpsub.c                     | 1 +
 drivers/virtio/virtio-uclass.c                          | 1 +
 drivers/virtio/virtio_mmio.c                            | 1 +
 drivers/virtio/virtio_net.c                             | 1 +
 drivers/virtio/virtio_pci_modern.c                      | 1 +
 drivers/virtio/virtio_ring.c                            | 1 +
 drivers/virtio/virtio_rng.c                             | 1 +
 drivers/w1-eeprom/ds2502.c                              | 1 +
 drivers/w1-eeprom/eep_sandbox.c                         | 1 +
 drivers/watchdog/gpio_wdt.c                             | 1 +
 drivers/watchdog/mpc8xxx_wdt.c                          | 1 +
 drivers/watchdog/sandbox_alarm-wdt.c                    | 1 +
 drivers/watchdog/wdt-uclass.c                           | 1 +
 drivers/xen/pvblock.c                                   | 1 +
 drivers/xen/xenbus.c                                    | 1 +
 env/callback.c                                          | 1 +
 env/common.c                                            | 1 +
 env/env.c                                               | 1 +
 env/ext4.c                                              | 1 +
 env/fat.c                                               | 1 +
 env/flash.c                                             | 1 +
 env/mmc.c                                               | 1 +
 env/nvram.c                                             | 1 +
 env/sf.c                                                | 1 +
 env/ubi.c                                               | 1 +
 examples/api/demo.c                                     | 1 +
 examples/api/glue.c                                     | 1 +
 examples/standalone/atmel_df_pow2.c                     | 1 +
 fs/btrfs/ctree.c                                        | 1 +
 fs/btrfs/ctree.h                                        | 1 +
 fs/btrfs/disk-io.c                                      | 1 +
 fs/btrfs/extent-io.c                                    | 1 +
 fs/btrfs/inode.c                                        | 1 +
 fs/btrfs/subvolume.c                                    | 1 +
 fs/btrfs/volumes.c                                      | 1 +
 fs/cbfs/cbfs.c                                          | 1 +
 fs/cramfs/cramfs.c                                      | 1 +
 fs/ext4/ext4_common.c                                   | 1 +
 fs/ext4/ext4_common.h                                   | 1 +
 fs/ext4/ext4_journal.c                                  | 1 +
 fs/ext4/ext4_write.c                                    | 1 +
 fs/ext4/ext4fs.c                                        | 1 +
 fs/fat/fat.c                                            | 1 +
 fs/fat/fat_write.c                                      | 1 +
 fs/fs.c                                                 | 1 +
 fs/fs_internal.c                                        | 1 +
 fs/jffs2/jffs2_1pass.c                                  | 1 +
 fs/jffs2/mini_inflate.c                                 | 1 +
 fs/reiserfs/reiserfs.c                                  | 1 +
 fs/sandbox/host_bootdev.c                               | 1 +
 fs/squashfs/sqfs.c                                      | 1 +
 fs/ubifs/debug.c                                        | 1 +
 fs/ubifs/io.c                                           | 1 +
 fs/ubifs/key.h                                          | 1 +
 fs/ubifs/log.c                                          | 1 +
 fs/ubifs/lprops.c                                       | 1 +
 fs/ubifs/lpt_commit.c                                   | 1 +
 fs/ubifs/recovery.c                                     | 1 +
 fs/ubifs/replay.c                                       | 1 +
 fs/ubifs/super.c                                        | 1 +
 fs/ubifs/tnc.c                                          | 1 +
 fs/ubifs/ubifs.c                                        | 1 +
 fs/yaffs2/yaffs_mtdif2.c                                | 1 +
 fs/yaffs2/yaffs_uboot_glue.c                            | 1 +
 fs/yaffs2/yaffsfs.c                                     | 1 +
 fs/yaffs2/ydirectenv.h                                  | 1 +
 fs/zfs/zfs.c                                            | 1 +
 include/dm/of.h                                         | 1 +
 include/efi_loader.h                                    | 1 +
 include/exception.h                                     | 1 +
 include/exports.h                                       | 1 +
 include/fdt_support.h                                   | 1 +
 include/imx8image.h                                     | 1 +
 include/linux/string.h                                  | 1 +
 include/net.h                                           | 1 +
 include/net6.h                                          | 1 +
 include/part.h                                          | 1 +
 include/phy_interface.h                                 | 1 +
 include/spi_flash.h                                     | 1 +
 include/test/ut.h                                       | 1 +
 include/tlv_eeprom.h                                    | 1 +
 include/video_console.h                                 | 1 +
 include/xen/interface/io/ring.h                         | 1 +
 lib/abuf.c                                              | 1 +
 lib/acpi/acpi.c                                         | 1 +
 lib/acpi/acpi_device.c                                  | 1 +
 lib/acpi/acpi_dp.c                                      | 1 +
 lib/acpi/acpi_table.c                                   | 1 +
 lib/acpi/acpi_writer.c                                  | 1 +
 lib/acpi/acpigen.c                                      | 1 +
 lib/acpi/base.c                                         | 1 +
 lib/acpi/csrt.c                                         | 1 +
 lib/acpi/dsdt.c                                         | 1 +
 lib/acpi/facs.c                                         | 1 +
 lib/acpi/mcfg.c                                         | 1 +
 lib/acpi/ssdt.c                                         | 1 +
 lib/aes.c                                               | 1 +
 lib/aes/aes-decrypt.c                                   | 1 +
 lib/bch.c                                               | 1 +
 lib/blake2/blake2-impl.h                                | 1 +
 lib/blake2/blake2b.c                                    | 1 +
 lib/bzip2/bzlib.c                                       | 1 +
 lib/charset.c                                           | 1 +
 lib/crc16-ccitt.c                                       | 1 +
 lib/crc32.c                                             | 1 +
 lib/crypt/crypt.c                                       | 1 +
 lib/crypto/pkcs7_verify.c                               | 1 +
 lib/crypto/public_key.c                                 | 1 +
 lib/crypto/x509_public_key.c                            | 1 +
 lib/dhry/dhry.h                                         | 1 +
 lib/ecdsa/ecdsa-libcrypto.c                             | 1 +
 lib/ecdsa/ecdsa-verify.c                                | 1 +
 lib/efi/efi_app.c                                       | 1 +
 lib/efi/efi_stub.c                                      | 1 +
 lib/efi_loader/dtbdump.c                                | 1 +
 lib/efi_loader/efi_bootmgr.c                            | 1 +
 lib/efi_loader/efi_boottime.c                           | 1 +
 lib/efi_loader/efi_capsule.c                            | 1 +
 lib/efi_loader/efi_console.c                            | 1 +
 lib/efi_loader/efi_device_path.c                        | 1 +
 lib/efi_loader/efi_device_path_to_text.c                | 1 +
 lib/efi_loader/efi_disk.c                               | 1 +
 lib/efi_loader/efi_file.c                               | 1 +
 lib/efi_loader/efi_freestanding.c                       | 1 +
 lib/efi_loader/efi_gop.c                                | 1 +
 lib/efi_loader/efi_helper.c                             | 1 +
 lib/efi_loader/efi_hii.c                                | 1 +
 lib/efi_loader/efi_image_loader.c                       | 1 +
 lib/efi_loader/efi_load_options.c                       | 1 +
 lib/efi_loader/efi_memory.c                             | 1 +
 lib/efi_loader/efi_net.c                                | 1 +
 lib/efi_loader/efi_runtime.c                            | 1 +
 lib/efi_loader/efi_setup.c                              | 1 +
 lib/efi_loader/efi_signature.c                          | 1 +
 lib/efi_loader/efi_tcg2.c                               | 1 +
 lib/efi_loader/efi_unicode_collation.c                  | 1 +
 lib/efi_loader/efi_var_file.c                           | 1 +
 lib/efi_loader/efi_var_mem.c                            | 1 +
 lib/efi_loader/efi_variable.c                           | 1 +
 lib/efi_loader/efi_variable_tee.c                       | 1 +
 lib/efi_loader/helloworld.c                             | 1 +
 lib/efi_selftest/efi_selftest_block_device.c            | 1 +
 lib/efi_selftest/efi_selftest_config_table.c            | 1 +
 lib/efi_selftest/efi_selftest_ecpt.c                    | 1 +
 lib/efi_selftest/efi_selftest_load_file.c               | 1 +
 lib/efi_selftest/efi_selftest_loaded_image.c            | 1 +
 lib/efi_selftest/efi_selftest_loadimage.c               | 1 +
 lib/efi_selftest/efi_selftest_manageprotocols.c         | 1 +
 lib/efi_selftest/efi_selftest_mem.c                     | 1 +
 lib/efi_selftest/efi_selftest_memory.c                  | 1 +
 lib/efi_selftest/efi_selftest_rng.c                     | 1 +
 lib/efi_selftest/efi_selftest_set_virtual_address_map.c | 1 +
 lib/efi_selftest/efi_selftest_snp.c                     | 1 +
 lib/efi_selftest/efi_selftest_startimage_exit.c         | 1 +
 lib/efi_selftest/efi_selftest_tcg2.c                    | 1 +
 lib/efi_selftest/efi_selftest_variables.c               | 1 +
 lib/efi_selftest/efi_selftest_variables_runtime.c       | 1 +
 lib/elf.c                                               | 1 +
 lib/fdtdec.c                                            | 1 +
 lib/fdtdec_test.c                                       | 1 +
 lib/fwu_updates/fwu.c                                   | 1 +
 lib/fwu_updates/fwu_mtd.c                               | 1 +
 lib/getopt.c                                            | 1 +
 lib/gunzip.c                                            | 1 +
 lib/hashtable.c                                         | 1 +
 lib/image-sparse.c                                      | 1 +
 lib/libavb/avb_sysdeps_posix.c                          | 1 +
 lib/linux_compat.c                                      | 1 +
 lib/list_sort.c                                         | 1 +
 lib/lz4.c                                               | 1 +
 lib/lz4_wrapper.c                                       | 1 +
 lib/lzo/lzo1x_decompress.c                              | 1 +
 lib/md5.c                                               | 1 +
 lib/membuff.c                                           | 1 +
 lib/net_utils.c                                         | 1 +
 lib/of_live.c                                           | 1 +
 lib/optee/optee.c                                       | 1 +
 lib/physmem.c                                           | 1 +
 lib/qsort.c                                             | 1 +
 lib/rsa/rsa-keyprop.c                                   | 1 +
 lib/rsa/rsa-mod-exp.c                                   | 1 +
 lib/rsa/rsa-verify.c                                    | 1 +
 lib/semihosting.c                                       | 1 +
 lib/slre.c                                              | 1 +
 lib/smbios-parser.c                                     | 1 +
 lib/smbios.c                                            | 1 +
 lib/strto.c                                             | 1 +
 lib/tpm-common.c                                        | 1 +
 lib/tpm-v1.c                                            | 1 +
 lib/tpm-v2.c                                            | 1 +
 lib/trace.c                                             | 1 +
 lib/uuid.c                                              | 1 +
 net/arp.c                                               | 1 +
 net/bootp.c                                             | 1 +
 net/cdp.c                                               | 1 +
 net/dhcpv6.c                                            | 1 +
 net/dns.c                                               | 1 +
 net/dsa-uclass.c                                        | 1 +
 net/eth-uclass.c                                        | 1 +
 net/eth_bootdev.c                                       | 1 +
 net/eth_common.c                                        | 1 +
 net/fastboot_tcp.c                                      | 1 +
 net/fastboot_udp.c                                      | 1 +
 net/link_local.c                                        | 1 +
 net/mdio-uclass.c                                       | 1 +
 net/ndisc.c                                             | 1 +
 net/net.c                                               | 1 +
 net/net6.c                                              | 1 +
 net/net_rand.h                                          | 1 +
 net/nfs.c                                               | 1 +
 net/pcap.c                                              | 1 +
 net/ping6.c                                             | 1 +
 net/rarp.c                                              | 1 +
 net/sntp.c                                              | 1 +
 net/tftp.c                                              | 1 +
 net/wget.c                                              | 1 +
 net/wol.c                                               | 1 +
 post/drivers/flash.c                                    | 1 +
 post/lib_powerpc/multi.c                                | 1 +
 post/lib_powerpc/string.c                               | 1 +
 post/post.c                                             | 1 +
 test/bloblist.c                                         | 1 +
 test/boot/bootdev.c                                     | 1 +
 test/boot/bootflow.c                                    | 1 +
 test/boot/bootstd_common.c                              | 1 +
 test/boot/expo.c                                        | 1 +
 test/bootm.c                                            | 1 +
 test/cmd/bdinfo.c                                       | 1 +
 test/cmd/fdt.c                                          | 1 +
 test/cmd/loadm.c                                        | 1 +
 test/cmd/mem_search.c                                   | 1 +
 test/cmd/rw.c                                           | 1 +
 test/cmd/setexpr.c                                      | 1 +
 test/cmd/wget.c                                         | 1 +
 test/command_ut.c                                       | 1 +
 test/compression.c                                      | 1 +
 test/dm/acpi_dp.c                                       | 1 +
 test/dm/axi.c                                           | 1 +
 test/dm/blkmap.c                                        | 1 +
 test/dm/clk_ccf.c                                       | 1 +
 test/dm/core.c                                          | 1 +
 test/dm/cpu.c                                           | 1 +
 test/dm/devres.c                                        | 1 +
 test/dm/dma.c                                           | 1 +
 test/dm/eth.c                                           | 1 +
 test/dm/fwu_mdata.c                                     | 1 +
 test/dm/gpio.c                                          | 1 +
 test/dm/mmc.c                                           | 1 +
 test/dm/mux-cmd.c                                       | 1 +
 test/dm/nop.c                                           | 1 +
 test/dm/of_platdata.c                                   | 1 +
 test/dm/ofnode.c                                        | 1 +
 test/dm/part.c                                          | 1 +
 test/dm/pci.c                                           | 1 +
 test/dm/regmap.c                                        | 1 +
 test/dm/remoteproc.c                                    | 1 +
 test/dm/rtc.c                                           | 1 +
 test/dm/soc.c                                           | 1 +
 test/dm/sysinfo.c                                       | 1 +
 test/dm/tee.c                                           | 1 +
 test/dm/usb.c                                           | 1 +
 test/dm/video.c                                         | 1 +
 test/env/hashtable.c                                    | 1 +
 test/fuzz/cmd_fuzz.c                                    | 1 +
 test/fuzz/virtio.c                                      | 1 +
 test/image/spl_load.c                                   | 1 +
 test/lib/abuf.c                                         | 1 +
 test/lib/asn1.c                                         | 1 +
 test/lib/rsa.c                                          | 1 +
 test/lib/sscanf.c                                       | 1 +
 test/lib/string.c                                       | 1 +
 test/lib/strlcat.c                                      | 1 +
 test/lib/test_aes.c                                     | 1 +
 test/log/log_test.c                                     | 1 +
 test/log/nolog_ndebug.c                                 | 1 +
 test/log/nolog_test.c                                   | 1 +
 test/log/syslog_test.c                                  | 1 +
 test/optee/cmd_ut_optee.c                               | 1 +
 test/print_ut.c                                         | 1 +
 test/str_ut.c                                           | 1 +
 test/test-main.c                                        | 1 +
 test/unicode_ut.c                                       | 1 +
 test/ut.c                                               | 1 +
 1600 files changed, 1605 insertions(+), 2 deletions(-)

diff --git a/api/api.c b/api/api.c
index 0bd93759f7be..51d68e0c0023 100644
--- a/api/api.c
+++ b/api/api.c
@@ -13,6 +13,7 @@
 #include <env_internal.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <api_public.h>
 #include <u-boot/crc.h>
diff --git a/api/api_net.c b/api/api_net.c
index 7515c26e8b44..63ac3ee09c74 100644
--- a/api/api_net.c
+++ b/api/api_net.c
@@ -8,6 +8,7 @@
 #include <config.h>
 #include <common.h>
 #include <net.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <api_public.h>
 
diff --git a/arch/arc/lib/relocate.c b/arch/arc/lib/relocate.c
index fd6f4fbc9304..f64feea858b4 100644
--- a/arch/arc/lib/relocate.c
+++ b/arch/arc/lib/relocate.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <asm/sections.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/cpu/arm926ejs/mxs/mxs.c b/arch/arm/cpu/arm926ejs/mxs/mxs.c
index 6d6166cb839f..dca9e0d82c01 100644
--- a/arch/arm/cpu/arm926ejs/mxs/mxs.c
+++ b/arch/arm/cpu/arm926ejs/mxs/mxs.c
@@ -27,6 +27,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/sections.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
index 5e7bdb78be1d..e00fd9716182 100644
--- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
+++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
@@ -18,6 +18,7 @@
 #include <asm/gpio.h>
 #include <asm/sections.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 #include "mxs_init.h"
 
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c b/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
index 39217c5b2bf1..abdbcb068ee9 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
 #include <asm/kona-common/clk.h>
+#include <linux/string.h>
 #include "clk-core.h"
 
 #define CLOCK_1K		1000
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-core.c b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
index d7edefee2318..a6bd627e20e4 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
@@ -17,6 +17,7 @@
 #include <bitfield.h>
 #include <asm/arch/sysmap.h>
 #include <asm/kona-common/clk.h>
+#include <linux/string.h>
 #include "clk-core.h"
 
 #define CLK_WR_ACCESS_PASSWORD	0x00a5a501
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
index 8f6260e7857e..ee0e75304807 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
 #include <asm/kona-common/clk.h>
+#include <linux/string.h>
 #include "clk-core.h"
 
 #define CLOCK_1K		1000
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-core.c b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
index 26b673a5405e..a70979d09331 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
@@ -17,6 +17,7 @@
 #include <bitfield.h>
 #include <asm/arch/sysmap.h>
 #include <asm/kona-common/clk.h>
+#include <linux/string.h>
 #include "clk-core.h"
 
 #define CLK_WR_ACCESS_PASSWORD	0x00a5a501
diff --git a/arch/arm/cpu/armv7/ls102xa/fdt.c b/arch/arm/cpu/armv7/ls102xa/fdt.c
index a5c5c780ae8a..a001f8cdb3ff 100644
--- a/arch/arm/cpu/armv7/ls102xa/fdt.c
+++ b/arch/arm/cpu/armv7/ls102xa/fdt.c
@@ -20,6 +20,7 @@
 #include <asm/arch/immap_ls102xa.h>
 #include <fsl_sec.h>
 #include <dm.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/cpu/armv7/vf610/generic.c b/arch/arm/cpu/armv7/vf610/generic.c
index c23ddc12b456..3f266178c98f 100644
--- a/arch/arm/cpu/armv7/vf610/generic.c
+++ b/arch/arm/cpu/armv7/vf610/generic.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_FSL_ESDHC_IMX
 #include <fsl_esdhc_imx.h>
 #endif
+#include <linux/string.h>
 
 #ifdef CONFIG_FSL_ESDHC_IMX
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/cpu/armv7/virt-v7.c b/arch/arm/cpu/armv7/virt-v7.c
index c82b215b6f9c..2905bec9bb83 100644
--- a/arch/arm/cpu/armv7/virt-v7.c
+++ b/arch/arm/cpu/armv7/virt-v7.c
@@ -15,6 +15,7 @@
 #include <asm/gic.h>
 #include <asm/io.h>
 #include <asm/secure.h>
+#include <linux/string.h>
 
 static unsigned int read_id_pfr1(void)
 {
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index cb1131a0480e..f1329ca3d53b 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
index 3c7f36ad8d89..0666cc0503f1 100644
--- a/arch/arm/cpu/armv8/cpu.c
+++ b/arch/arm/cpu/armv8/cpu.c
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/secure.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 /*
  * sdelay() - simple spin loop.
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index 12d31184ad91..b07e6085ebfb 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -42,6 +42,7 @@
 #include <asm/arch/clock.h>
 #include <hwconfig.h>
 #include <fsl_qbman.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_TFABOOT
 #include <env_internal.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
index 22ce6992165b..2eb0f7613750 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
@@ -31,6 +31,7 @@
 #endif
 #include <asm/arch/speed.h>
 #include <fsl_qbman.h>
+#include <linux/string.h>
 
 int fdt_fixup_phy_connection(void *blob, int offset, phy_interface_t phyc)
 {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
index 1541dfb3ec47..785eaaa22c19 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYS_FSL_SRDS_1
 static u8 serdes1_prtcl_map[SERDES_PRCTL_COUNT];
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
index c0efc341afc1..ff49e3cc3345 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
@@ -14,6 +14,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
 #include <fsl-mc/ldpaa_wriop.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYS_FSL_SRDS_1
 static u8 serdes1_prtcl_map[SERDES_PRCTL_COUNT];
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
index 86a49b152e44..e32541d08ac1 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
@@ -9,6 +9,7 @@
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
+#include <linux/string.h>
 
 struct icid_id_table icid_tbl[] = {
 	SET_USB_ICID(1, "snps,dwc3", FSL_USB1_STREAM_ID),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/mp.c b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
index ce0c46ad0d4e..fb33fcd921d5 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/mp.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/psci.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include "cpu.h"
 #include <asm/arch-fsl-layerscape/soc.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index 033f48d04b90..5cbb7bd0b308 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -23,6 +23,7 @@
 #include <asm/arch/fdt.h>
 #include <asm/arch/ppa.h>
 #include <asm/arch/soc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index c0e8726346f5..db4d7bd081d4 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -19,6 +19,7 @@
 #include <asm/types.h>
 #include <asm/macro.h>
 #include <asm/armv8/sec_firmware.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 extern void c_runtime_cpu_setup(void);
diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_table.c
index 42a0962fdcda..6aafb3b6ea3c 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <linux/libfdt.h>
 #include <asm/spin_table.h>
+#include <linux/string.h>
 
 int spin_table_update_dt(void *fdt)
 {
diff --git a/arch/arm/cpu/armv8/spl_data.c b/arch/arm/cpu/armv8/spl_data.c
index 8f1231c86ebb..91dab71de2e1 100644
--- a/arch/arm/cpu/armv8/spl_data.c
+++ b/arch/arm/cpu/armv8/spl_data.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <spl.h>
+#include <linux/string.h>
 
 char __data_save_start[0] __section(".__data_save_start");
 char __data_save_end[0] __section(".__data_save_end");
diff --git a/arch/arm/include/asm/arch-octeontx/soc.h b/arch/arm/include/asm/arch-octeontx/soc.h
index dc081c70b2bc..7bbab94d085a 100644
--- a/arch/arm/include/asm/arch-octeontx/soc.h
+++ b/arch/arm/include/asm/arch-octeontx/soc.h
@@ -8,6 +8,8 @@
 #ifndef __SOC_H__
 #define __SOC_H__
 
+#include <linux/string.h>
+
 /* Product PARTNUM */
 #define CN81XX	0xA2
 #define CN83XX	0xA3
diff --git a/arch/arm/include/asm/arch-octeontx2/soc.h b/arch/arm/include/asm/arch-octeontx2/soc.h
index 9cf6628da4bf..177a4eb235c6 100644
--- a/arch/arm/include/asm/arch-octeontx2/soc.h
+++ b/arch/arm/include/asm/arch-octeontx2/soc.h
@@ -8,6 +8,8 @@
 #ifndef __SOC_H__
 #define __SOC_H__
 
+#include <linux/string.h>
+
 /* Product PARTNUM */
 #define CN81XX	0xA2
 #define CN83XX	0xA3
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 89b1015bc4d3..8175b6dc8efc 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_ARM_IO_H
 #define __ASM_ARM_IO_H
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <asm/byteorder.h>
diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index ead3f2c35643..c9ecdde0d3d8 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARM_STRING_H
 #define __ASM_ARM_STRING_H
 
-#include <config.h>
-
 /*
  * We don't do inline string functions, since the
  * optimised inline asm versions are not small.
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index c56285738a26..1063ccd4dd43 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -21,6 +21,7 @@
 #include <dm/root.h>
 #include <env.h>
 #include <image.h>
+#include <linux/string.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
 #include <linux/libfdt.h>
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 7a1601586711..c13bee54ac33 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index f7029918d4fb..35ce83a6facd 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 
 int raise (int signum)
 {
diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index f4bbd21da915..3cc1619c18ae 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 static u32 lpi_id_bits;
 
diff --git a/arch/arm/lib/psci-dt.c b/arch/arm/lib/psci-dt.c
index 903b3357048a..5b17f131461c 100644
--- a/arch/arm/lib/psci-dt.c
+++ b/arch/arm/lib/psci-dt.c
@@ -13,6 +13,7 @@
 #if CONFIG_IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)
 #include <asm/armv8/sec_firmware.h>
 #endif
+#include <linux/string.h>
 
 int fdt_psci(void *fdt)
 {
diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index d50194811843..5bd7d48fb644 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -8,6 +8,7 @@
 #include <dm/uclass-internal.h>
 #include <efi_loader.h>
 #include <lmb.h>
+#include <linux/string.h>
 
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h b/arch/arm/mach-bcm283x/include/mach/mbox.h
index 490664f878fe..d12e8190b5ce 100644
--- a/arch/arm/mach-bcm283x/include/mach/mbox.h
+++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
@@ -8,6 +8,7 @@
 
 #include <linux/compiler.h>
 #include <asm/arch/base.h>
+#include <linux/string.h>
 
 /*
  * The BCM2835 SoC contains (at least) two CPUs; the VideoCore (a/k/a "GPU")
diff --git a/arch/arm/mach-imx/cmd_bmode.c b/arch/arm/mach-imx/cmd_bmode.c
index cb317499d540..651adaa14d0d 100644
--- a/arch/arm/mach-imx/cmd_bmode.c
+++ b/arch/arm/mach-imx/cmd_bmode.c
@@ -8,6 +8,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <malloc.h>
 #include <command.h>
+#include <linux/string.h>
 
 static const struct boot_mode *modes[2];
 
diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
index 6fa5b41fcd38..f4fcc19c12d4 100644
--- a/arch/arm/mach-imx/cmd_dek.c
+++ b/arch/arm/mach-imx/cmd_dek.c
@@ -25,6 +25,7 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/image.h>
 #endif
+#include <linux/string.h>
 
 #include <cpu_func.h>
 
diff --git a/arch/arm/mach-imx/cmd_mfgprot.c b/arch/arm/mach-imx/cmd_mfgprot.c
index 9576b48dde30..8f1706e9b329 100644
--- a/arch/arm/mach-imx/cmd_mfgprot.c
+++ b/arch/arm/mach-imx/cmd_mfgprot.c
@@ -16,6 +16,7 @@
 #include <fsl_sec.h>
 #include <mapmem.h>
 #include <memalign.h>
+#include <linux/string.h>
 
 /**
  * do_mfgprot() - Handle the "mfgprot" command-line command
diff --git a/arch/arm/mach-imx/cmd_nandbcb.c b/arch/arm/mach-imx/cmd_nandbcb.c
index c54f52b343c7..2fa0319c0cda 100644
--- a/arch/arm/mach-imx/cmd_nandbcb.c
+++ b/arch/arm/mach-imx/cmd_nandbcb.c
@@ -18,6 +18,7 @@
 #include <nand.h>
 #include <dm/devres.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <jffs2/jffs2.h>
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 785b0d6ec3cf..515c46f8839c 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -15,6 +15,7 @@
 #include <console.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index b3ef36c79738..304ad414a009 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -17,6 +17,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/hab.h>
 #include <linux/arm-smccc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 5f188ab32d18..e30185ab7cc0 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -15,6 +15,7 @@
 #include <asm/mach-imx/image.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <linux/string.h>
 
 #define MMC_DEV		0
 #define QSPI_DEV	1
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index b58b14ca9b4d..a48cb5132de1 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -16,6 +16,7 @@
 #include <asm/mach-imx/image.h>
 #include <console.h>
 #include <cpu_func.h>
+#include <linux/string.h>
 #include "u-boot/sha256.h"
 #include <asm/mach-imx/ahab.h>
 
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 39ac0bc4140b..ebd777bfe70d 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -29,6 +29,7 @@
 #include <power-domain.h>
 #include <elf.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index c2bed3e0c1fb..dc9d4f465c3b 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -12,6 +12,7 @@
 #include <fdt_support.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 431ad959f533..61163e8b63f3 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -30,6 +30,7 @@
 #include <fsl_wdog.h>
 #include <imx_sip.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index fd436dd88514..84294a16fec1 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -29,6 +29,7 @@
 #include <linux/iopoll.h>
 #include <env.h>
 #include <env_internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/imx8ulp/upower/upower_api.c b/arch/arm/mach-imx/imx8ulp/upower/upower_api.c
index 5e19b9861f02..3c95fe3233e0 100644
--- a/arch/arm/mach-imx/imx8ulp/upower/upower_api.c
+++ b/arch/arm/mach-imx/imx8ulp/upower/upower_api.c
@@ -3,6 +3,7 @@
  * Copyright 2021 NXP
  */
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <string.h>
 #include <asm/arch/imx-regs.h>
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 5d8687b6f438..648965eae244 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -37,6 +37,7 @@
 #include <asm/mach-imx/ele_api.h>
 #include <fuse.h>
 #include <asm/arch/ddr.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/imx_bootaux.c b/arch/arm/mach-imx/imx_bootaux.c
index f7b14ca38d94..329edad15a9f 100644
--- a/arch/arm/mach-imx/imx_bootaux.c
+++ b/arch/arm/mach-imx/imx_bootaux.c
@@ -13,6 +13,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/compiler.h>
 #include <cpu_func.h>
+#include <linux/string.h>
 
 #ifndef CONFIG_IMX8
 /* Just to avoid build error */
diff --git a/arch/arm/mach-imx/mx5/clock.c b/arch/arm/mach-imx/mx5/clock.c
index bbaddd5a33fa..cc93716c74e4 100644
--- a/arch/arm/mach-imx/mx5/clock.c
+++ b/arch/arm/mach-imx/mx5/clock.c
@@ -16,6 +16,7 @@
 #include <asm/arch/clock.h>
 #include <div64.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 enum pll_clocks {
 	PLL1_CLOCK = 0,
diff --git a/arch/arm/mach-imx/mx6/module_fuse.c b/arch/arm/mach-imx/mx6/module_fuse.c
index b58f11c1e562..381fd718ccb9 100644
--- a/arch/arm/mach-imx/mx6/module_fuse.c
+++ b/arch/arm/mach-imx/mx6/module_fuse.c
@@ -10,6 +10,7 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/mach-imx/module_fuse.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 static struct fuse_entry_desc mx6_fuse_descs[] = {
 #if defined(CONFIG_MX6ULL)
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 4af41699678c..4e082fc43d99 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -12,6 +12,7 @@
 #include <spl.h>
 #include <asm/mach-imx/image.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/video.c b/arch/arm/mach-imx/video.c
index 1bc9b7cc7e15..4d76ecc29694 100644
--- a/arch/arm/mach-imx/video.c
+++ b/arch/arm/mach-imx/video.c
@@ -4,6 +4,7 @@
 #include <env.h>
 #include <linux/errno.h>
 #include <asm/mach-imx/video.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_IMX_HDMI
 #include <asm/arch/mxc_hdmi.h>
diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 8fa36f7b913e..5f20812ae0f0 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "sysfw-loader.h"
 #include "common.h"
 #include <dm.h>
diff --git a/arch/arm/mach-k3/am62a7_init.c b/arch/arm/mach-k3/am62a7_init.c
index d72e19936b9b..620755075ac2 100644
--- a/arch/arm/mach-k3/am62a7_init.c
+++ b/arch/arm/mach-k3/am62a7_init.c
@@ -8,6 +8,7 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "sysfw-loader.h"
 #include "common.h"
 #include <dm.h>
diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index c871e92330bc..720011dc908a 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -12,6 +12,7 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "sysfw-loader.h"
 #include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index cc755dd1bf6e..3eacadb7a899 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -14,6 +14,7 @@
 #include <spl.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "common.h"
 #include <dm.h>
 #include <remoteproc.h>
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b6164575b7ba..49e09f181347 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "sysfw-loader.h"
 #include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index 712a7e253fa8..983ac961e375 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "sysfw-loader.h"
 #include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 9be2d9eaea26..ec31c1e0dc25 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -21,6 +21,7 @@
 #include <dfu.h>
 #include <dm/uclass-internal.h>
 #include <spi_flash.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include "common.h"
diff --git a/arch/arm/mach-keystone/cmd_clock.c b/arch/arm/mach-keystone/cmd_clock.c
index 72dc394df5fb..2217bf97317f 100644
--- a/arch/arm/mach-keystone/cmd_clock.c
+++ b/arch/arm/mach-keystone/cmd_clock.c
@@ -11,6 +11,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/psc_defs.h>
+#include <linux/string.h>
 
 struct pll_init_data cmd_pll_data = {
 	.pll = MAIN_PLL,
diff --git a/arch/arm/mach-keystone/cmd_mon.c b/arch/arm/mach-keystone/cmd_mon.c
index dc97bac85501..4281a6f56293 100644
--- a/arch/arm/mach-keystone/cmd_mon.c
+++ b/arch/arm/mach-keystone/cmd_mon.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <command.h>
 #include <image.h>
+#include <linux/string.h>
 #include <mach/mon.h>
 asm(".arch_extension sec\n\t");
 
diff --git a/arch/arm/mach-keystone/ddr3_spd.c b/arch/arm/mach-keystone/ddr3_spd.c
index 6f7f8ab7b40c..f8c391d53b15 100644
--- a/arch/arm/mach-keystone/ddr3_spd.c
+++ b/arch/arm/mach-keystone/ddr3_spd.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <linux/string.h>
 
 #include <i2c.h>
 #include <ddr_spd.h>
diff --git a/arch/arm/mach-keystone/include/mach/hardware.h b/arch/arm/mach-keystone/include/mach/hardware.h
index 424c32a4bee3..8b0885f80659 100644
--- a/arch/arm/mach-keystone/include/mach/hardware.h
+++ b/arch/arm/mach-keystone/include/mach/hardware.h
@@ -355,6 +355,8 @@ typedef volatile unsigned int   *dv_reg_p;
 
 #ifndef __ASSEMBLY__
 
+#include <asm/io.h>
+
 static inline u16 get_part_number(void)
 {
 	u32 jtag_id = __raw_readl(KS2_JTAG_ID_REG);
diff --git a/arch/arm/mach-keystone/mon.c b/arch/arm/mach-keystone/mon.c
index b863bab19692..ecc5f9d90221 100644
--- a/arch/arm/mach-keystone/mon.c
+++ b/arch/arm/mach-keystone/mon.c
@@ -10,6 +10,7 @@
 #include <asm/unaligned.h>
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 #include <mach/mon.h>
 #include <spl.h>
 asm(".arch_extension sec\n\t");
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index d600c64d0bea..e4ccbd4f901c 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -18,6 +18,7 @@
 #include <linux/bitfield.h>
 #include <regmap.h>
 #include <syscon.h>
+#include <linux/string.h>
 
 #define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
 #define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
diff --git a/arch/arm/mach-mvebu/armada3700/cpu.c b/arch/arm/mach-mvebu/armada3700/cpu.c
index ab72b304e5da..142b5b6177ad 100644
--- a/arch/arm/mach-mvebu/armada3700/cpu.c
+++ b/arch/arm/mach-mvebu/armada3700/cpu.c
@@ -20,6 +20,7 @@
 #include <asm/arch/soc.h>
 #include <asm/armv8/mmu.h>
 #include <sort.h>
+#include <linux/string.h>
 
 /* Armada 3700 */
 #define MVEBU_GPIO_NB_REG_BASE		(MVEBU_REGISTER(0x13800))
diff --git a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
index 68f8eade2722..a8c007810bec 100644
--- a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
+++ b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
@@ -10,6 +10,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "high_speed_env_spec.h"
 #include "board_env_spec.h"
diff --git a/arch/arm/mach-nexell/clock.c b/arch/arm/mach-nexell/clock.c
index 59ffa26255f5..ad47935e0221 100644
--- a/arch/arm/mach-nexell/clock.c
+++ b/arch/arm/mach-nexell/clock.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
 #include <asm/arch/clk.h>
+#include <linux/string.h>
 
 /*
  * clock generator macros
diff --git a/arch/arm/mach-omap2/emif-common.c b/arch/arm/mach-omap2/emif-common.c
index 9daaeef73190..43fc52a76e7e 100644
--- a/arch/arm/mach-omap2/emif-common.c
+++ b/arch/arm/mach-omap2/emif-common.c
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <asm/ti-common/ti-edma3.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static int emif1_enabled = -1, emif2_enabled = -1;
 
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index 8b70251457e2..336e7c59462b 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -28,6 +28,7 @@
 #include <asm/gpio.h>
 #include <asm/omap_common.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 /* Declarations */
 extern omap3_sysinfo sysinfo;
diff --git a/arch/arm/mach-omap2/sec-common.c b/arch/arm/mach-omap2/sec-common.c
index 64560b21e3f5..f42101ee9f19 100644
--- a/arch/arm/mach-omap2/sec-common.c
+++ b/arch/arm/mach-omap2/sec-common.c
@@ -19,6 +19,7 @@
 #include <init.h>
 #include <log.h>
 #include <stdarg.h>
+#include <linux/string.h>
 
 #include <asm/arch/sys_proto.h>
 #include <asm/cache.h>
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0e9..27f86b1fce2d 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -22,6 +22,7 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/misc.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index eb8f65ae4e9d..ff9018ff0128 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #if (CONFIG_ROCKCHIP_BOOT_MODE_REG == 0)
 
diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
index 7d03f0c2b679..ecb7db24352a 100644
--- a/arch/arm/mach-rockchip/misc.c
+++ b/arch/arm/mach-rockchip/misc.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <dm/uclass-internal.h>
 #include <misc.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <u-boot/sha256.h>
 
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 93b8e7de4d0d..a90ee64da622 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -9,6 +9,7 @@
 #include <mmc.h>
 #include <spl.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #if CONFIG_IS_ENABLED(OF_LIBFDT)
 /**
diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
index 1f8850239437..e3ffc49089c8 100644
--- a/arch/arm/mach-snapdragon/init_sdm845.c
+++ b/arch/arm/mach-snapdragon/init_sdm845.c
@@ -11,6 +11,7 @@
 #include <asm/system.h>
 #include <asm/gpio.h>
 #include <dm.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-socfpga/clock_manager_arria10.c b/arch/arm/mach-socfpga/clock_manager_arria10.c
index b48a2b47bcdc..5bb9813e0023 100644
--- a/arch/arm/mach-socfpga/clock_manager_arria10.c
+++ b/arch/arm/mach-socfpga/clock_manager_arria10.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <asm/arch/clock_manager.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SPL_BUILD
 
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 93c9e8b0fb40..c050faec6c90 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/pl310.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #define PINMUX_UART0_TX_SHARED_IO_OFFSET_Q1_3	0x08
 #define PINMUX_UART0_TX_SHARED_IO_OFFSET_Q2_11	0x58
diff --git a/arch/arm/mach-socfpga/pinmux_arria10.c b/arch/arm/mach-socfpga/pinmux_arria10.c
index f378fce7f02d..a38b19c395e2 100644
--- a/arch/arm/mach-socfpga/pinmux_arria10.c
+++ b/arch/arm/mach-socfpga/pinmux_arria10.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <common.h>
 #include <fdtdec.h>
+#include <linux/string.h>
 
 static int do_pinctr_pin(const void *blob, int child, const char *node_name)
 {
diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-socfpga/secure_vab.c
index e2db58850643..b7e164b4b8ab 100644
--- a/arch/arm/mach-socfpga/secure_vab.c
+++ b/arch/arm/mach-socfpga/secure_vab.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/intel-smc.h>
 #include <log.h>
+#include <linux/string.h>
 
 #define CHUNKSZ_PER_WD_RESET		(256 * SZ_1K)
 
diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index 8ffc7a472b5b..eb3dc16fda92 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -8,6 +8,7 @@
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/intel-smc.h>
+#include <linux/string.h>
 
 int invoke_smc(u32 func_id, u64 *args, int arg_len, u64 *ret_arg, int ret_len)
 {
diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
index 599e63a93dd9..e04eccfe0b19 100644
--- a/arch/arm/mach-stm32mp/bsec.c
+++ b/arch/arm/mach-stm32mp/bsec.c
@@ -19,6 +19,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/iopoll.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define BSEC_OTP_MAX_VALUE		95
 #define BSEC_OTP_UPPER_START		32
diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
index e16fcf4424dc..dcf9107db461 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32key.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
@@ -12,6 +12,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /*
  * Closed device: OTP0
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 2411bcf06d8f..ae0ad5741473 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -9,6 +9,7 @@
 #include <image.h>
 #include <asm/arch/stm32prog.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "stm32prog.h"
 
 struct stm32prog_data *stm32prog_data;
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
index 393f9a1b411c..8a733d967f0b 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "stm32prog.h"
 
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
index 31decc413d1e..b5fd29b709be 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "stm32prog.h"
 
 /* - configuration part -----------------------------*/
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
index d18455bf36f1..f49bd56a747e 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
@@ -10,6 +10,7 @@
 #include <asm/arch/stm32prog.h>
 #include <asm/arch/sys_proto.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "stm32prog.h"
 
 static int stm32prog_set_phase(struct stm32prog_data *data, u8 phase,
diff --git a/arch/arm/mach-stm32mp/ecdsa_romapi.c b/arch/arm/mach-stm32mp/ecdsa_romapi.c
index 93c561c69b1d..5476420674bb 100644
--- a/arch/arm/mach-stm32mp/ecdsa_romapi.c
+++ b/arch/arm/mach-stm32mp/ecdsa_romapi.c
@@ -7,6 +7,7 @@
 #include <asm/system.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <u-boot/ecdsa.h>
 #include <crypto/ecdsa-uclass.h>
diff --git a/arch/arm/mach-stm32mp/fdt.c b/arch/arm/mach-stm32mp/fdt.c
index de5c5a55ea0e..2351fdfff23d 100644
--- a/arch/arm/mach-stm32mp/fdt.c
+++ b/arch/arm/mach-stm32mp/fdt.c
@@ -13,6 +13,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 #include <linux/io.h>
+#include <linux/string.h>
 
 #define ETZPC_DECPROT(n)	(STM32_ETZPC_BASE + 0x10 + 4 * (n))
 #define ETZPC_DECPROT_NB	6
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 78597ad932c4..980f47a2b189 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -26,6 +26,7 @@
 #include <asm/arch/timer.h>
 #include <asm/arch/tzpc.h>
 #include <asm/arch/mmc.h>
+#include <linux/string.h>
 
 #include <linux/compiler.h>
 
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index 8f5bb2f261a9..2b29886a3d9c 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/ctype.h>
 #include <linux/sizes.h>
diff --git a/arch/arm/mach-tegra/dt-setup.c b/arch/arm/mach-tegra/dt-setup.c
index c11494722bc7..9917f9999e97 100644
--- a/arch/arm/mach-tegra/dt-setup.c
+++ b/arch/arm/mach-tegra/dt-setup.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <asm/arch-tegra/cboot.h>
 #include <asm/arch-tegra/gpu.h>
+#include <linux/string.h>
 
 /*
  * This function is called right before the kernel is booted. "blob" is the
diff --git a/arch/arm/mach-tegra/tegra20/bct.c b/arch/arm/mach-tegra/tegra20/bct.c
index 5eb48990b6c3..b16ee6667664 100644
--- a/arch/arm/mach-tegra/tegra20/bct.c
+++ b/arch/arm/mach-tegra/tegra20/bct.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <log.h>
 #include <asm/arch-tegra/crypto.h>
+#include <linux/string.h>
 #include "bct.h"
 #include "uboot_aes.h"
 
diff --git a/arch/arm/mach-tegra/tegra20/emc.c b/arch/arm/mach-tegra/tegra20/emc.c
index fb5e699c940d..3adac13c787a 100644
--- a/arch/arm/mach-tegra/tegra20/emc.c
+++ b/arch/arm/mach-tegra/tegra20/emc.c
@@ -12,6 +12,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/emc.h>
 #include <asm/arch/tegra.h>
+#include <linux/string.h>
 
 /*
  * The EMC registers have shadow registers.  When the EMC clock is updated
diff --git a/arch/arm/mach-tegra/tegra20/warmboot.c b/arch/arm/mach-tegra/tegra20/warmboot.c
index 5e3a9ebaceb3..10f320ff7553 100644
--- a/arch/arm/mach-tegra/tegra20/warmboot.c
+++ b/arch/arm/mach-tegra/tegra20/warmboot.c
@@ -20,6 +20,7 @@
 #include <asm/arch-tegra/pmc.h>
 #include <asm/arch-tegra/fuse.h>
 #include <asm/arch-tegra/warmboot.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-tegra/tegra30/bct.c b/arch/arm/mach-tegra/tegra30/bct.c
index c56958da6919..7dc6651725db 100644
--- a/arch/arm/mach-tegra/tegra30/bct.c
+++ b/arch/arm/mach-tegra/tegra30/bct.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <log.h>
 #include <asm/arch-tegra/crypto.h>
+#include <linux/string.h>
 #include "bct.h"
 #include "uboot_aes.h"
 
diff --git a/arch/arm/mach-tegra/xusb-padctl-common.c b/arch/arm/mach-tegra/xusb-padctl-common.c
index 28fdebe50a33..5228fc662722 100644
--- a/arch/arm/mach-tegra/xusb-padctl-common.c
+++ b/arch/arm/mach-tegra/xusb-padctl-common.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <log.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "xusb-padctl-common.h"
 
diff --git a/arch/arm/mach-uniphier/base-address.c b/arch/arm/mach-uniphier/base-address.c
index d7456f8df6f2..1ba55eb7ebba 100644
--- a/arch/arm/mach-uniphier/base-address.c
+++ b/arch/arm/mach-uniphier/base-address.c
@@ -10,6 +10,7 @@
 #include <linux/libfdt.h>
 #include <linux/sizes.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include "base-address.h"
 #include "sc64-regs.h"
diff --git a/arch/arm/mach-uniphier/board_late_init.c b/arch/arm/mach-uniphier/board_late_init.c
index b5356ed87e70..ee138d10d52f 100644
--- a/arch/arm/mach-uniphier/board_late_init.c
+++ b/arch/arm/mach-uniphier/board_late_init.c
@@ -12,6 +12,7 @@
 #include <linux/libfdt.h>
 #include <stdio.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "init.h"
 
diff --git a/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c b/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
index 629f8b90c9d8..be4ce3265bb8 100644
--- a/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
+++ b/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "../soc-info.h"
 #include "ddrmphy-regs.h"
diff --git a/arch/arm/mach-uniphier/dram/cmd_ddrphy.c b/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
index ca519d1c7e0c..3ccafe206382 100644
--- a/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
+++ b/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "../soc-info.h"
 #include "ddrphy-regs.h"
diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
index 7bd39289fac5..0cf210d1e554 100644
--- a/arch/arm/mach-versal/mp.c
+++ b/arch/arm/mach-versal/mp.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 #define HALT		0
 #define RELEASE		1
diff --git a/arch/arm/mach-zynq/ddrc.c b/arch/arm/mach-zynq/ddrc.c
index 28988ef95b5a..65c255da209a 100644
--- a/arch/arm/mach-zynq/ddrc.c
+++ b/arch/arm/mach-zynq/ddrc.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 
 #ifndef CONFIG_ZYNQ_DDRC_INIT
 void zynq_ddrc_init(void) {}
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 5d9f4d23f34b..d7c879dc82dc 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 #define SLCR_LOCK_MAGIC		0x767B
 #define SLCR_UNLOCK_MAGIC	0xDF0D
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 6ae27894ecd9..e0296c2e7310 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -16,6 +16,7 @@
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
 #include <dm/platdata.h>
+#include <linux/string.h>
 
 #define ZYNQ_SILICON_VER_MASK	0xF000
 #define ZYNQ_SILICON_VER_SHIFT	12
diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index aff9054212c5..6153478d5be5 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -12,6 +12,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define LOCK		0
 #define SPLIT		1
diff --git a/arch/microblaze/cpu/cpuinfo.c b/arch/microblaze/cpu/cpuinfo.c
index 6b15d6ca41c0..2f398f045fa5 100644
--- a/arch/microblaze/cpu/cpuinfo.c
+++ b/arch/microblaze/cpu/cpuinfo.c
@@ -5,6 +5,7 @@
 #include <common.h>
 #include <asm/cpuinfo.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index 632bb236fbbe..0f32a18c1cc8 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -18,6 +18,7 @@
 #define __MICROBLAZE_IO_H__
 
 #include <asm/types.h>
+#include <linux/string.h>
 
 #define IO_SPACE_LIMIT 0xFFFFFFFF
 
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index d3ad66930131..836cd436872d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -11,6 +11,7 @@
 
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index ab92bd06b0ee..a493af81b43a 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -14,6 +14,7 @@
 #include <asm/addrspace.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/mips/lib/reloc.c b/arch/mips/lib/reloc.c
index 9cf6809f4068..9c26c7950b59 100644
--- a/arch/mips/lib/reloc.c
+++ b/arch/mips/lib/reloc.c
@@ -32,6 +32,7 @@
 #include <asm/relocs.h>
 #include <asm/sections.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 /**
  * read_uint() - Read an unsigned integer from the buffer
diff --git a/arch/mips/lib/traps.c b/arch/mips/lib/traps.c
index 7a682f256a65..d46fbad160f5 100644
--- a/arch/mips/lib/traps.c
+++ b/arch/mips/lib/traps.c
@@ -20,6 +20,7 @@
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
 #include <asm/system.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/mips/mach-jz47xx/jz4780/jz4780.c b/arch/mips/mach-jz47xx/jz4780/jz4780.c
index 56fdf04bca9d..aa4d30acf3f7 100644
--- a/arch/mips/mach-jz47xx/jz4780/jz4780.c
+++ b/arch/mips/mach-jz47xx/jz4780/jz4780.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 #include <mach/jz4780.h>
 #include <mach/jz4780_dram.h>
 #include <mmc.h>
diff --git a/arch/mips/mach-mtmips/cpu.c b/arch/mips/mach-mtmips/cpu.c
index e88dab10c76e..e91f2f87206c 100644
--- a/arch/mips/mach-mtmips/cpu.c
+++ b/arch/mips/mach-mtmips/cpu.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/mips/mach-mtmips/mt7621/spl/launch.c b/arch/mips/mach-mtmips/mt7621/spl/launch.c
index 95dd65913d4c..e23fdcaefc93 100644
--- a/arch/mips/mach-mtmips/mt7621/spl/launch.c
+++ b/arch/mips/mach-mtmips/mt7621/spl/launch.c
@@ -13,6 +13,7 @@
 #include <linux/sizes.h>
 #include <time.h>
 #include <cpu_func.h>
+#include <linux/string.h>
 #include "launch.h"
 #include "../mt7621.h"
 
diff --git a/arch/mips/mach-octeon/bootoctlinux.c b/arch/mips/mach-octeon/bootoctlinux.c
index 2c583b8b8317..9d9e65ec2aae 100644
--- a/arch/mips/mach-octeon/bootoctlinux.c
+++ b/arch/mips/mach-octeon/bootoctlinux.c
@@ -10,6 +10,7 @@
 #include <elf.h>
 #include <env.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <linux/compat.h>
diff --git a/arch/mips/mach-octeon/cpu.c b/arch/mips/mach-octeon/cpu.c
index c7744e847068..b7f642e58e4f 100644
--- a/arch/mips/mach-octeon/cpu.c
+++ b/arch/mips/mach-octeon/cpu.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include <mach/clock.h>
 #include <mach/cavm-reg.h>
 #include <mach/cvmx-bootmem.h>
diff --git a/arch/mips/mach-octeon/cvmx-bootmem.c b/arch/mips/mach-octeon/cvmx-bootmem.c
index 52e58b4c1761..54cdb783f211 100644
--- a/arch/mips/mach-octeon/cvmx-bootmem.c
+++ b/arch/mips/mach-octeon/cvmx-bootmem.c
@@ -9,6 +9,7 @@
  */
 
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <linux/compat.h>
 #include <linux/io.h>
diff --git a/arch/mips/mach-octeon/cvmx-cmd-queue.c b/arch/mips/mach-octeon/cvmx-cmd-queue.c
index c4b49f940b62..b8f8d244b205 100644
--- a/arch/mips/mach-octeon/cvmx-cmd-queue.c
+++ b/arch/mips/mach-octeon/cvmx-cmd-queue.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-coremask.c b/arch/mips/mach-octeon/cvmx-coremask.c
index c3d6f7e0d143..f5b00ed27fe6 100644
--- a/arch/mips/mach-octeon/cvmx-coremask.c
+++ b/arch/mips/mach-octeon/cvmx-coremask.c
@@ -5,6 +5,7 @@
 
 #include <env.h>
 #include <errno.h>
+#include <linux/string.h>
 
 #include <linux/compat.h>
 #include <linux/ctype.h>
diff --git a/arch/mips/mach-octeon/cvmx-fau-compat.c b/arch/mips/mach-octeon/cvmx-fau-compat.c
index 9c2ff763ad53..e9588d675fc1 100644
--- a/arch/mips/mach-octeon/cvmx-fau-compat.c
+++ b/arch/mips/mach-octeon/cvmx-fau-compat.c
@@ -6,6 +6,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-fpa.c b/arch/mips/mach-octeon/cvmx-fpa.c
index 14fe87c739c9..19f015b46b6d 100644
--- a/arch/mips/mach-octeon/cvmx-fpa.c
+++ b/arch/mips/mach-octeon/cvmx-fpa.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-board.c b/arch/mips/mach-octeon/cvmx-helper-board.c
index 6dcc4e557e12..ae67be786c4d 100644
--- a/arch/mips/mach-octeon/cvmx-helper-board.c
+++ b/arch/mips/mach-octeon/cvmx-helper-board.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <net.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-cfg.c b/arch/mips/mach-octeon/cvmx-helper-cfg.c
index a3f4ff0eeb5f..ec6a2e4cd0e6 100644
--- a/arch/mips/mach-octeon/cvmx-helper-cfg.c
+++ b/arch/mips/mach-octeon/cvmx-helper-cfg.c
@@ -7,6 +7,7 @@
 
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-ilk.c b/arch/mips/mach-octeon/cvmx-helper-ilk.c
index 9e882f133323..2a6b5b54f8fc 100644
--- a/arch/mips/mach-octeon/cvmx-helper-ilk.c
+++ b/arch/mips/mach-octeon/cvmx-helper-ilk.c
@@ -9,6 +9,7 @@
 #include <time.h>
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-pki.c b/arch/mips/mach-octeon/cvmx-helper-pki.c
index 51fa4fb5f054..1e75f1b84dff 100644
--- a/arch/mips/mach-octeon/cvmx-helper-pki.c
+++ b/arch/mips/mach-octeon/cvmx-helper-pki.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-rgmii.c b/arch/mips/mach-octeon/cvmx-helper-rgmii.c
index dc19c3bc1d9b..f16fdc61051b 100644
--- a/arch/mips/mach-octeon/cvmx-helper-rgmii.c
+++ b/arch/mips/mach-octeon/cvmx-helper-rgmii.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-sfp.c b/arch/mips/mach-octeon/cvmx-helper-sfp.c
index a08a6cf22288..93c835a5db12 100644
--- a/arch/mips/mach-octeon/cvmx-helper-sfp.c
+++ b/arch/mips/mach-octeon/cvmx-helper-sfp.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <linux/delay.h>
 #include <display_options.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-helper-util.c b/arch/mips/mach-octeon/cvmx-helper-util.c
index 6d775eee9245..60d573a9d116 100644
--- a/arch/mips/mach-octeon/cvmx-helper-util.c
+++ b/arch/mips/mach-octeon/cvmx-helper-util.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr-enums.h>
diff --git a/arch/mips/mach-octeon/cvmx-pcie.c b/arch/mips/mach-octeon/cvmx-pcie.c
index e46bb609af7c..47a5df778375 100644
--- a/arch/mips/mach-octeon/cvmx-pcie.c
+++ b/arch/mips/mach-octeon/cvmx-pcie.c
@@ -9,6 +9,7 @@
 #include <time.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/octeon-model.h>
diff --git a/arch/mips/mach-octeon/cvmx-pko3-compat.c b/arch/mips/mach-octeon/cvmx-pko3-compat.c
index 3e142322dbfb..14f7803cc11e 100644
--- a/arch/mips/mach-octeon/cvmx-pko3-compat.c
+++ b/arch/mips/mach-octeon/cvmx-pko3-compat.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-pko3-queue.c b/arch/mips/mach-octeon/cvmx-pko3-queue.c
index 53f2e4dd1861..39a203c61ec1 100644
--- a/arch/mips/mach-octeon/cvmx-pko3-queue.c
+++ b/arch/mips/mach-octeon/cvmx-pko3-queue.c
@@ -7,6 +7,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-pko3.c b/arch/mips/mach-octeon/cvmx-pko3.c
index d8ce02a2717a..cdffd151931d 100644
--- a/arch/mips/mach-octeon/cvmx-pko3.c
+++ b/arch/mips/mach-octeon/cvmx-pko3.c
@@ -7,6 +7,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/cvmx-qlm.c b/arch/mips/mach-octeon/cvmx-qlm.c
index 01051788b835..80792c6d5284 100644
--- a/arch/mips/mach-octeon/cvmx-qlm.c
+++ b/arch/mips/mach-octeon/cvmx-qlm.c
@@ -9,6 +9,7 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/octeon-model.h>
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-coremask.h b/arch/mips/mach-octeon/include/mach/cvmx-coremask.h
index 915e87092905..c1645a95ee63 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-coremask.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-coremask.h
@@ -10,6 +10,7 @@
  * executable image.
  *
  * The core numbers used in this file are the same value as what is found in
+#include <linux/string.h>
  * the COP0_EBASE register and the rdhwr 0 instruction.
  *
  * For the CN78XX and other multi-node environments the core numbers are not
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-pko3.h b/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
index 86f89be855fe..d21b72770242 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-pko3.h
@@ -7,6 +7,7 @@
 #ifndef __CVMX_PKO3_H__
 #define __CVMX_PKO3_H__
 
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 
 /* Use full LMTDMA when PARAMETER_CHECKINS is enabled */
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-wqe.h b/arch/mips/mach-octeon/include/mach/cvmx-wqe.h
index 7244d5d29c01..ad8a529a0ca7 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-wqe.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-wqe.h
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2020 Marvell International Ltd.
  *
+#include <linux/string.h>
  * This header file defines the work queue entry (wqe) data structure.
  * Since this is a commonly used structure that depends on structures
  * from several hardware blocks, those definitions have been placed
diff --git a/arch/mips/mach-octeon/octeon_fdt.c b/arch/mips/mach-octeon/octeon_fdt.c
index c74fe9d9fb87..90bf540e1222 100644
--- a/arch/mips/mach-octeon/octeon_fdt.c
+++ b/arch/mips/mach-octeon/octeon_fdt.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <dm/device.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/arch/mips/mach-octeon/octeon_qlm.c b/arch/mips/mach-octeon/octeon_qlm.c
index 1be7434e78cc..42620ba29799 100644
--- a/arch/mips/mach-octeon/octeon_qlm.c
+++ b/arch/mips/mach-octeon/octeon_qlm.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/octeon-model.h>
diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index 79a54d1bc259..7a7016ad7241 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -16,6 +16,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index 817cd72e00bd..b22134cf29c4 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -8,6 +8,7 @@
 #define __ASM_NIOS2_IO_H_
 
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 static inline void sync(void)
 {
diff --git a/arch/powerpc/cpu/mpc83xx/ecc.c b/arch/powerpc/cpu/mpc83xx/ecc.c
index 3e24752e2f6c..90bf2e852878 100644
--- a/arch/powerpc/cpu/mpc83xx/ecc.c
+++ b/arch/powerpc/cpu/mpc83xx/ecc.c
@@ -10,6 +10,7 @@
 #include <irq_func.h>
 #include <mpc83xx.h>
 #include <command.h>
+#include <linux/string.h>
 
 void ecc_print_status(void)
 {
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 96183ac2c84b..ee66aa46b075 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -35,6 +35,7 @@
 #include <hwconfig.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "mp.h"
 #ifdef CONFIG_CHAIN_OF_TRUST
 #include <fsl_validate.h>
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index e26436bf5701..652ee884230c 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -27,6 +27,7 @@
 #ifdef CONFIG_SYS_DPAA_FMAN
 #include <fsl_fman.h>
 #endif
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
index 9b6577e547e5..87f8611ad8b5 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <fsl_errata.h>
+#include <linux/string.h>
 #include "fsl_corenet2_serdes.h"
 
 #ifdef CONFIG_SYS_FSL_SRDS_1
diff --git a/arch/powerpc/cpu/mpc85xx/liodn.c b/arch/powerpc/cpu/mpc85xx/liodn.c
index 4b8844a4d960..3acfbb14c5c3 100644
--- a/arch/powerpc/cpu/mpc85xx/liodn.c
+++ b/arch/powerpc/cpu/mpc85xx/liodn.c
@@ -7,6 +7,7 @@
 #include <log.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 #include <asm/immap_85xx.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index 7c47e415f05d..134dbc45d667 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -17,6 +17,7 @@
 #include <asm/fsl_law.h>
 #include <fsl_ddr_sdram.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "mp.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/powerpc/cpu/mpc85xx/portals.c b/arch/powerpc/cpu/mpc85xx/portals.c
index 6b4cbddcdfe1..9953f6ee2caf 100644
--- a/arch/powerpc/cpu/mpc85xx/portals.c
+++ b/arch/powerpc/cpu/mpc85xx/portals.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 8e1f6c964d3f..7b890e017f1d 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <malloc.h>
 #include <asm/fsl_pamu.h>
+#include <linux/string.h>
 
 struct paace *ppaact;
 struct paace *sec;
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f63cae0bc80f..500d0b640e1c 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -8,6 +8,7 @@
 #define _PPC_IO_H
 
 #include <asm/byteorder.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_ADDR_MAP
 #include <asm/global_data.h>
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index b16e6dfa3760..36552cad921c 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -7,6 +7,7 @@
 #ifndef __ASM_RISCV_IO_H
 #define __ASM_RISCV_IO_H
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <asm/byteorder.h>
diff --git a/arch/riscv/include/asm/posix_types.h b/arch/riscv/include/asm/posix_types.h
index 0fc052082ac3..96581aa39553 100644
--- a/arch/riscv/include/asm/posix_types.h
+++ b/arch/riscv/include/asm/posix_types.h
@@ -83,6 +83,8 @@ typedef struct {
 	typeof(_fd) (fd) = (_fd); \
 	((((fd_set *)fdsetp)->fds_bits[fd >> 5] & (1 << (fd & 31))) != 0)
 
+#include <linux/string.h>
+
 #undef	__FD_ZERO
 #define __FD_ZERO(_fdsetp) \
 	typeof(_fdsetp) (fd) = (_fdsetp); \
diff --git a/arch/riscv/lib/andes_plicsw.c b/arch/riscv/lib/andes_plicsw.c
index 75184080890f..00c7a89ae472 100644
--- a/arch/riscv/lib/andes_plicsw.c
+++ b/arch/riscv/lib/andes_plicsw.c
@@ -20,6 +20,7 @@
 #include <asm/syscon.h>
 #include <cpu.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 /* pending register */
 #define PENDING_REG(base, hart)	((ulong)(base) + 0x1000 + ((hart) / 4) * 4)
diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 36c16e9be2ae..e9550c01d580 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index a1c5c7c4311a..afbb8081c753 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -19,6 +19,7 @@
 #include <dm/ofnode.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index e59b96be5fb8..d362cdbb3363 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -9,6 +9,7 @@
 #include <asm/eth-raw-os.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/string.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 85d0d6a17035..388f1c2a0207 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -21,6 +21,7 @@
 #include <time.h>
 #include <ucontext.h>
 #include <unistd.h>
+#include <linux/string.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/time.h>
diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index 590e406517bf..d644b9632c05 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -10,6 +10,7 @@
 #include <linux/input.h>
 #include <SDL2/SDL.h>
 #include <asm/state.h>
+#include <linux/string.h>
 
 /**
  * struct buf_info - a data buffer holding audio data
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 09e3d10d6a50..ef7988aa1e57 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/spl.h>
 #include <asm/state.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 1026898727f5..40b2d48d8a3b 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -21,6 +21,7 @@
 #include <asm/state.h>
 #include <dm/root.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index d67834988fd4..8971144792fa 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -14,6 +14,7 @@
 #include <asm/malloc.h>
 #include <asm/state.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 /* Main state record for the sandbox */
 static struct sandbox_state main_state;
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index dc8b8e46cb41..08f712bc9ec8 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -8,6 +8,7 @@
 #include <bootstage.h>
 #include <image.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define	LINUX_ARM_ZIMAGE_MAGIC	0x016f2818
 
diff --git a/arch/sh/lib/board.c b/arch/sh/lib/board.c
index b31fa6d70311..96f75dd6405f 100644
--- a/arch/sh/lib/board.c
+++ b/arch/sh/lib/board.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index b205e5e3db1b..e6b45b003dca 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -14,6 +14,7 @@
 #include <asm/byteorder.h>
 #include <asm/global_data.h>
 #include <asm/zimage.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/sh/lib/zimageboot.c b/arch/sh/lib/zimageboot.c
index c2e285ff0f62..76f26fa60549 100644
--- a/arch/sh/lib/zimageboot.c
+++ b/arch/sh/lib/zimageboot.c
@@ -15,6 +15,7 @@
 #include <irq_func.h>
 #include <asm/io.h>
 #include <asm/zimage.h>
+#include <linux/string.h>
 
 int do_sh_zimageboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
diff --git a/arch/x86/cpu/acpi_gpe.c b/arch/x86/cpu/acpi_gpe.c
index f44f0e4c2b24..824013a9e38d 100644
--- a/arch/x86/cpu/acpi_gpe.c
+++ b/arch/x86/cpu/acpi_gpe.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/x86-irq.h>
+#include <linux/string.h>
 
 /**
  * struct acpi_gpe_priv - private driver information
diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index c610a7f44770..36d17f76c194 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -34,6 +34,7 @@
 #include <asm/arch/systemagent.h>
 #include <dm/acpi.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <power/acpi_pmc.h>
 
 int arch_read_sci_irq_select(void)
diff --git a/arch/x86/cpu/apollolake/fsp_bindings.c b/arch/x86/cpu/apollolake/fsp_bindings.c
index fb75e1f70951..27e3b0f7d13b 100644
--- a/arch/x86/cpu/apollolake/fsp_bindings.c
+++ b/arch/x86/cpu/apollolake/fsp_bindings.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/fsp_bindings.h>
+#include <linux/string.h>
 
 /**
  * read_u8_prop() - Read an u8 property from devicetree (scalar or array)
diff --git a/arch/x86/cpu/apollolake/pmc.c b/arch/x86/cpu/apollolake/pmc.c
index 163119e2e9e9..fb31a27282d0 100644
--- a/arch/x86/cpu/apollolake/pmc.c
+++ b/arch/x86/cpu/apollolake/pmc.c
@@ -18,6 +18,7 @@
 #include <asm/pci.h>
 #include <asm/arch/pmc.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <power/acpi_pmc.h>
 
 #define GPIO_GPE_CFG		0x1050
diff --git a/arch/x86/cpu/apollolake/spl.c b/arch/x86/cpu/apollolake/spl.c
index 6078d5a200e8..6ccd17d42804 100644
--- a/arch/x86/cpu/apollolake/spl.c
+++ b/arch/x86/cpu/apollolake/spl.c
@@ -21,6 +21,7 @@
 #include <asm/arch/iomap.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /* This reads the next phase from mapped SPI flash */
 static int rom_load_image(struct spl_image_info *spl_image,
diff --git a/arch/x86/cpu/apollolake/uart.c b/arch/x86/cpu/apollolake/uart.c
index a9362436000c..67ab8968dca4 100644
--- a/arch/x86/cpu/apollolake/uart.c
+++ b/arch/x86/cpu/apollolake/uart.c
@@ -18,6 +18,7 @@
 #include <asm/lpss.h>
 #include <dm/device-internal.h>
 #include <asm/arch/uart.h>
+#include <linux/string.h>
 
 /* Low-power Subsystem (LPSS) clock register */
 enum {
diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 4378846f8b0c..1bb501dc42d4 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -14,6 +14,7 @@
 #include <asm/arch/global_nvs.h>
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static int baytrail_write_fadt(struct acpi_ctx *ctx,
 			       const struct acpi_writer *entry)
diff --git a/arch/x86/cpu/broadwell/me.c b/arch/x86/cpu/broadwell/me.c
index ae16ce264992..4ae084bf4529 100644
--- a/arch/x86/cpu/broadwell/me.c
+++ b/arch/x86/cpu/broadwell/me.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <asm/arch/me.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static inline void me_read_dword_ptr(struct udevice *dev, void *ptr, int offset)
 {
diff --git a/arch/x86/cpu/broadwell/northbridge.c b/arch/x86/cpu/broadwell/northbridge.c
index 141babc51c3a..4f3ccf589e57 100644
--- a/arch/x86/cpu/broadwell/northbridge.c
+++ b/arch/x86/cpu/broadwell/northbridge.c
@@ -11,6 +11,7 @@
 #include <asm/arch/iomap.h>
 #include <asm/arch/pch.h>
 #include <asm/arch/pei_data.h>
+#include <linux/string.h>
 
 __weak asmlinkage void sdram_console_tx_byte(unsigned char byte)
 {
diff --git a/arch/x86/cpu/broadwell/pinctrl_broadwell.c b/arch/x86/cpu/broadwell/pinctrl_broadwell.c
index 85bd37101ba2..2bc3ef97214c 100644
--- a/arch/x86/cpu/broadwell/pinctrl_broadwell.c
+++ b/arch/x86/cpu/broadwell/pinctrl_broadwell.c
@@ -19,6 +19,7 @@
 #include <dt-bindings/gpio/x86-gpio.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/broadwell/refcode.c b/arch/x86/cpu/broadwell/refcode.c
index df2df7972e98..2401bb17b2e3 100644
--- a/arch/x86/cpu/broadwell/refcode.c
+++ b/arch/x86/cpu/broadwell/refcode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Read a coreboot rmodule and execute it.
+#include <linux/string.h>
  * The rmodule_header struct is from coreboot.
  *
  * Copyright (c) 2016 Google, Inc
diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdram.c
index d30ebee021ea..bed313e82b2d 100644
--- a/arch/x86/cpu/broadwell/sdram.c
+++ b/arch/x86/cpu/broadwell/sdram.c
@@ -26,6 +26,7 @@
 #include <asm/arch/pch.h>
 #include <asm/arch/pei_data.h>
 #include <asm/arch/pm.h>
+#include <linux/string.h>
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
diff --git a/arch/x86/cpu/cpu_x86.c b/arch/x86/cpu/cpu_x86.c
index 59da41f38333..4462277b7ca0 100644
--- a/arch/x86/cpu/cpu_x86.c
+++ b/arch/x86/cpu/cpu_x86.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 708bfbe7ee48..72295e11e062 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -17,6 +17,7 @@
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/post.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 8882532ebf3a..6d6fccd8676f 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -32,6 +32,7 @@
 #include <asm/msr.h>
 #include <asm/mtrr.h>
 #include <asm/processor-flags.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/intel_common/intel_opregion.c b/arch/x86/cpu/intel_common/intel_opregion.c
index 1eed21d8cdf8..4de96fa6d552 100644
--- a/arch/x86/cpu/intel_common/intel_opregion.c
+++ b/arch/x86/cpu/intel_common/intel_opregion.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <spi_flash.h>
 #include <asm/intel_opregion.h>
+#include <linux/string.h>
 
 static char vbt_data[8 << 10];
 
diff --git a/arch/x86/cpu/intel_common/itss.c b/arch/x86/cpu/intel_common/itss.c
index ec73b3d89312..590b44b91c25 100644
--- a/arch/x86/cpu/intel_common/itss.c
+++ b/arch/x86/cpu/intel_common/itss.c
@@ -19,6 +19,7 @@
 #include <spl.h>
 #include <asm/global_data.h>
 #include <asm/itss.h>
+#include <linux/string.h>
 
 static int set_polarity(struct udevice *dev, uint irq, bool active_low)
 {
diff --git a/arch/x86/cpu/intel_common/report_platform.c b/arch/x86/cpu/intel_common/report_platform.c
index a3612817c45b..2de29bbbe25e 100644
--- a/arch/x86/cpu/intel_common/report_platform.c
+++ b/arch/x86/cpu/intel_common/report_platform.c
@@ -11,6 +11,7 @@
 #include <asm/pci.h>
 #include <asm/report_platform.h>
 #include <asm/arch/pch.h>
+#include <linux/string.h>
 
 static void report_cpu_info(void)
 {
diff --git a/arch/x86/cpu/ivybridge/sata.c b/arch/x86/cpu/ivybridge/sata.c
index f47ecdffae76..40cb04158681 100644
--- a/arch/x86/cpu/ivybridge/sata.c
+++ b/arch/x86/cpu/ivybridge/sata.c
@@ -14,6 +14,7 @@
 #include <asm/pch_common.h>
 #include <asm/pci.h>
 #include <asm/arch/pch.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/ivybridge/sdram.c b/arch/x86/cpu/ivybridge/sdram.c
index 95a826da7130..7f286572fc19 100644
--- a/arch/x86/cpu/ivybridge/sdram.c
+++ b/arch/x86/cpu/ivybridge/sdram.c
@@ -39,6 +39,7 @@
 #include <asm/arch/pch.h>
 #include <asm/post.h>
 #include <asm/arch/sandybridge.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/mp_init.c b/arch/x86/cpu/mp_init.c
index 9f0f6372dd56..b710b1cd1a33 100644
--- a/arch/x86/cpu/mp_init.c
+++ b/arch/x86/cpu/mp_init.c
@@ -31,6 +31,7 @@
 #include <dm/root.h>
 #include <linux/delay.h>
 #include <linux/linkage.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index 9c24ae984e90..60678cf51732 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -27,6 +27,7 @@
 #include <asm/msr.h>
 #include <asm/mtrr.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/qfw_cpu.c b/arch/x86/cpu/qfw_cpu.c
index ee00b8fe7327..9d0131133f9a 100644
--- a/arch/x86/cpu/qfw_cpu.c
+++ b/arch/x86/cpu/qfw_cpu.c
@@ -11,6 +11,7 @@
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 int qemu_cpu_fixup(void)
 {
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 9a2d682451be..acb59ca38cd4 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -9,6 +9,7 @@
 #include <asm/tables.h>
 #include <asm/arch/global_nvs.h>
 #include <asm/arch/iomap.h>
+#include <linux/string.h>
 
 static int quark_write_fadt(struct acpi_ctx *ctx,
 			    const struct acpi_writer *entry)
diff --git a/arch/x86/cpu/quark/dram.c b/arch/x86/cpu/quark/dram.c
index ad98f3e07bae..bf02f1c5e27e 100644
--- a/arch/x86/cpu/quark/dram.c
+++ b/arch/x86/cpu/quark/dram.c
@@ -18,6 +18,7 @@
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/quark/smc.c b/arch/x86/cpu/quark/smc.c
index b4b3e1204bd5..fa47e587a238 100644
--- a/arch/x86/cpu/quark/smc.c
+++ b/arch/x86/cpu/quark/smc.c
@@ -12,6 +12,7 @@
 #include <asm/arch/device.h>
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
+#include <linux/string.h>
 #include "mrc_util.h"
 #include "hte.h"
 #include "smc.h"
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 1c667c7d5693..3ff3fcc578c2 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -15,6 +15,7 @@
 #include <asm/arch/global_nvs.h>
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static int tangier_write_fadt(struct acpi_ctx *ctx,
 			      const struct acpi_writer *entry)
diff --git a/arch/x86/cpu/tangier/sdram.c b/arch/x86/cpu/tangier/sdram.c
index 374b262b1348..9d98c8b13308 100644
--- a/arch/x86/cpu/tangier/sdram.c
+++ b/arch/x86/cpu/tangier/sdram.c
@@ -10,6 +10,7 @@
 #include <asm/global_data.h>
 #include <asm/sfi.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 83dc09757e0c..f0119c47b856 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -8,6 +8,7 @@
 #define _ASM_IO_H
 
 #include <compiler.h>
+#include <linux/string.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
diff --git a/arch/x86/include/asm/me_common.h b/arch/x86/include/asm/me_common.h
index 857036831492..aa478594ec92 100644
--- a/arch/x86/include/asm/me_common.h
+++ b/arch/x86/include/asm/me_common.h
@@ -13,6 +13,7 @@
 #define __ASM_ME_COMMON_H
 
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <pci.h>
 
diff --git a/arch/x86/lib/acpi.c b/arch/x86/lib/acpi.c
index 155fffabf080..ffdc9e8257e1 100644
--- a/arch/x86/lib/acpi.c
+++ b/arch/x86/lib/acpi.c
@@ -8,6 +8,7 @@
 #include <acpi/acpi_table.h>
 #include <asm/io.h>
 #include <asm/tables.h>
+#include <linux/string.h>
 
 static struct acpi_rsdp *acpi_valid_rsdp(struct acpi_rsdp *rsdp)
 {
diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
index 6c8cd83e12d3..ea269228be80 100644
--- a/arch/x86/lib/acpi_nhlt.c
+++ b/arch/x86/lib/acpi_nhlt.c
@@ -17,6 +17,7 @@
 #include <asm/acpi_nhlt.h>
 #include <asm/unaligned.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 #define NHLT_RID		1
 #define NHLT_SSID		1
diff --git a/arch/x86/lib/acpi_s3.c b/arch/x86/lib/acpi_s3.c
index 2c70acbe7b0b..244764152b23 100644
--- a/arch/x86/lib/acpi_s3.c
+++ b/arch/x86/lib/acpi_s3.c
@@ -10,6 +10,7 @@
 #include <asm/global_data.h>
 #include <asm/post.h>
 #include <linux/linkage.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index c5b33dc65de4..190534e43c47 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -28,6 +28,7 @@
 #include <asm/arch/global_nvs.h>
 #include <dm/acpi.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 static int acpi_create_madt_lapic(struct acpi_madt_lapic *lapic,
 				  u8 cpu, u8 apic)
diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index f146bbd54227..90121a3dd7cc 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -17,6 +17,7 @@
 #include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/post.h>
+#include <linux/string.h>
 #include "bios.h"
 
 /* Interrupt handlers for each interrupt the ROM can call */
diff --git a/arch/x86/lib/cmd_boot.c b/arch/x86/lib/cmd_boot.c
index 4facbe5f32fb..b128b43cebe5 100644
--- a/arch/x86/lib/cmd_boot.c
+++ b/arch/x86/lib/cmd_boot.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <asm/u-boot-x86.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/coreboot_table.c b/arch/x86/lib/coreboot_table.c
index 05519d851a9d..ce267e1c7753 100644
--- a/arch/x86/lib/coreboot_table.c
+++ b/arch/x86/lib/coreboot_table.c
@@ -11,6 +11,7 @@
 #include <asm/coreboot_tables.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/fsp1/fsp_support.c b/arch/x86/lib/fsp1/fsp_support.c
index d84c632f1407..25aa71c6c20a 100644
--- a/arch/x86/lib/fsp1/fsp_support.c
+++ b/arch/x86/lib/fsp1/fsp_support.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <asm/fsp1/fsp_support.h>
 #include <asm/post.h>
+#include <linux/string.h>
 
 struct fsp_header *__attribute__((optimize("O0"))) fsp_find_header(void)
 {
diff --git a/arch/x86/lib/fsp2/fsp_meminit.c b/arch/x86/lib/fsp2/fsp_meminit.c
index 022e2cb64e5a..abbe1a011dda 100644
--- a/arch/x86/lib/fsp2/fsp_meminit.c
+++ b/arch/x86/lib/fsp2/fsp_meminit.c
@@ -18,6 +18,7 @@
 #include <asm/fsp2/fsp_internal.h>
 #include <asm/arch/fsp/fsp_configs.h>
 #include <asm/arch/fsp/fsp_m_upd.h>
+#include <linux/string.h>
 
 static int prepare_mrc_cache_type(enum mrc_type_t type,
 				  struct mrc_data_container **cachep)
diff --git a/arch/x86/lib/fsp2/fsp_silicon_init.c b/arch/x86/lib/fsp2/fsp_silicon_init.c
index a96d2b183f6e..4493ab8d4ad8 100644
--- a/arch/x86/lib/fsp2/fsp_silicon_init.c
+++ b/arch/x86/lib/fsp2/fsp_silicon_init.c
@@ -18,6 +18,7 @@
 #include <asm/fsp/fsp_infoheader.h>
 #include <asm/fsp2/fsp_internal.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 int fsp_silicon_init(bool s3wake, bool use_spi_flash)
 {
diff --git a/arch/x86/lib/fsp2/fsp_support.c b/arch/x86/lib/fsp2/fsp_support.c
index b2c76582453f..a64bacb20645 100644
--- a/arch/x86/lib/fsp2/fsp_support.c
+++ b/arch/x86/lib/fsp2/fsp_support.c
@@ -12,6 +12,7 @@
 #include <asm/fsp/fsp_support.h>
 #include <asm/fsp2/fsp_internal.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 /* The amount of the FSP header to probe to obtain what we need */
 #define PROBE_BUF_SIZE 0x180
diff --git a/arch/x86/lib/mpspec.c b/arch/x86/lib/mpspec.c
index 8e97d9ff36d9..2fc9ae5457f5 100644
--- a/arch/x86/lib/mpspec.c
+++ b/arch/x86/lib/mpspec.c
@@ -19,6 +19,7 @@
 #include <asm/mpspec.h>
 #include <asm/tables.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/mrccache.c b/arch/x86/lib/mrccache.c
index 6494b8d26341..4a6a1777b929 100644
--- a/arch/x86/lib/mrccache.c
+++ b/arch/x86/lib/mrccache.c
@@ -21,6 +21,7 @@
 #include <asm/mrccache.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/physmem.c b/arch/x86/lib/physmem.c
index 382f768149f4..639c6f1663c1 100644
--- a/arch/x86/lib/physmem.c
+++ b/arch/x86/lib/physmem.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/pirq_routing.c b/arch/x86/lib/pirq_routing.c
index caeaec9287fe..8aeba8496a9f 100644
--- a/arch/x86/lib/pirq_routing.c
+++ b/arch/x86/lib/pirq_routing.c
@@ -11,6 +11,7 @@
 #include <asm/global_data.h>
 #include <asm/pci.h>
 #include <asm/pirq_routing.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
index da819b9bdd2c..5db3aeb9a84f 100644
--- a/arch/x86/lib/relocate.c
+++ b/arch/x86/lib/relocate.c
@@ -21,6 +21,7 @@
 #include <asm/u-boot-x86.h>
 #include <asm/sections.h>
 #include <elf.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/scu.c b/arch/x86/lib/scu.c
index 90ef239bcd3d..65af416e931c 100644
--- a/arch/x86/lib/scu.c
+++ b/arch/x86/lib/scu.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 /* SCU register map */
 struct ipc_regs {
diff --git a/arch/x86/lib/sfi.c b/arch/x86/lib/sfi.c
index 85e963b634b5..c6a2a346e104 100644
--- a/arch/x86/lib/sfi.c
+++ b/arch/x86/lib/sfi.c
@@ -20,6 +20,7 @@
 #include <asm/sfi.h>
 #include <asm/tables.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 struct table_info {
 	u32 base;
diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index c15f11f8cdf4..1245d9a5125c 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -30,6 +30,7 @@
 #include <asm/qemu.h>
 #include <asm/spl.h>
 #include <asm-generic/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/string.c b/arch/x86/lib/string.c
index c6263cd2f5a8..d85b77a96240 100644
--- a/arch/x86/lib/string.c
+++ b/arch/x86/lib/string.c
@@ -7,6 +7,7 @@
 
 /* From glibc-2.14, sysdeps/i386/memset.c */
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <asm/string.h>
diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5b5070f7ca57..ae96d930ffbf 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -16,6 +16,7 @@
 #include <asm/mpspec.h>
 #include <asm/tables.h>
 #include <asm/coreboot_tables.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a41e1ccf8a65..bdccb264e113 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -38,6 +38,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 76a646e8825c..14e906193602 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -9,6 +9,7 @@
 #ifndef _XTENSA_IO_H
 #define _XTENSA_IO_H
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
diff --git a/arch/xtensa/include/asm/posix_types.h b/arch/xtensa/include/asm/posix_types.h
index 7fb65ead6713..b996423d39fa 100644
--- a/arch/xtensa/include/asm/posix_types.h
+++ b/arch/xtensa/include/asm/posix_types.h
@@ -64,6 +64,8 @@ typedef struct {
 #define __FD_ISSET(fd, fdsetp) \
 	((((fd_set *)fdsetp)->fds_bits[fd >> 5] & (1<<(fd & 31))) != 0)
 
+#include <linux/string.h>
+
 #undef	__FD_ZERO
 #define __FD_ZERO(fdsetp) \
 	(memset(fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index fee339281502..12ef8927bd33 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -10,6 +10,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
 #include <asm/addrspace.h>
diff --git a/arch/xtensa/lib/relocate.c b/arch/xtensa/lib/relocate.c
index a499590c75bc..7912a3afa7a8 100644
--- a/arch/xtensa/lib/relocate.c
+++ b/arch/xtensa/lib/relocate.c
@@ -6,6 +6,7 @@
 #include <relocate.h>
 #include <asm/sections.h>
 #include <asm/string.h>
+#include <linux/string.h>
 
 int clear_bss(void)
 {
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 3c78020bf93c..8dab60f811bb 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -16,6 +16,7 @@
 #include <i2c.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "bur_common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index ea49c7a99c0b..2a235cae5d44 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "asm/m5282.h"
 #include <bmp_layout.h>
 #include <env.h>
diff --git a/board/CZ.NIC/turris_atsha_otp.c b/board/CZ.NIC/turris_atsha_otp.c
index a29fe3623174..5caffad34fd7 100644
--- a/board/CZ.NIC/turris_atsha_otp.c
+++ b/board/CZ.NIC/turris_atsha_otp.c
@@ -9,6 +9,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <atsha204a-i2c.h>
+#include <linux/string.h>
 
 #include "turris_atsha_otp.h"
 
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 19c5043fcbaa..8a091eb97426 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -25,6 +25,7 @@
 #include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 04124d8014dd..07f64210a4db 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -19,6 +19,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/Marvell/octeon_ebb7304/board.c b/board/Marvell/octeon_ebb7304/board.c
index 5fd84b260b58..4e0da87149ca 100644
--- a/board/Marvell/octeon_ebb7304/board.c
+++ b/board/Marvell/octeon_ebb7304/board.c
@@ -7,6 +7,7 @@
 #include <fdt_support.h>
 #include <ram.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 #include <mach/octeon_ddr.h>
 #include <mach/cvmx-qlm.h>
diff --git a/board/Marvell/octeontx/board-fdt.c b/board/Marvell/octeontx/board-fdt.c
index 6642b167e19f..214670d6a3c7 100644
--- a/board/Marvell/octeontx/board-fdt.c
+++ b/board/Marvell/octeontx/board-fdt.c
@@ -16,6 +16,7 @@
 #include <fdt_support.h>
 #include <asm/arch/board.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/Marvell/octeontx/board.c b/board/Marvell/octeontx/board.c
index 224653519b95..dac419a44339 100644
--- a/board/Marvell/octeontx/board.c
+++ b/board/Marvell/octeontx/board.c
@@ -22,6 +22,7 @@
 #include <asm/arch/soc.h>
 #include <asm/arch/board.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/Marvell/octeontx/soc-utils.c b/board/Marvell/octeontx/soc-utils.c
index 5fd5afd48d57..f4dd8c6d371b 100644
--- a/board/Marvell/octeontx/soc-utils.c
+++ b/board/Marvell/octeontx/soc-utils.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch/soc.h>
 #include <asm/arch/board.h>
+#include <linux/string.h>
 
 int read_platform(void)
 {
diff --git a/board/Marvell/octeontx2/board-fdt.c b/board/Marvell/octeontx2/board-fdt.c
index 04be9fb0a9aa..bc4e302c34c4 100644
--- a/board/Marvell/octeontx2/board-fdt.c
+++ b/board/Marvell/octeontx2/board-fdt.c
@@ -9,6 +9,7 @@
 #include <fdtdec.h>
 #include <fdt_support.h>
 #include <log.h>
+#include <linux/string.h>
 
 #include <linux/compiler.h>
 #include <linux/libfdt.h>
diff --git a/board/Marvell/octeontx2/board.c b/board/Marvell/octeontx2/board.c
index 974e9eb82001..734750f03bdc 100644
--- a/board/Marvell/octeontx2/board.c
+++ b/board/Marvell/octeontx2/board.c
@@ -27,6 +27,7 @@
 #include <asm/arch/soc.h>
 #include <asm/arch/board.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/Marvell/octeontx2/soc-utils.c b/board/Marvell/octeontx2/soc-utils.c
index 43a19a90717c..fcc7efd9677d 100644
--- a/board/Marvell/octeontx2/soc-utils.c
+++ b/board/Marvell/octeontx2/soc-utils.c
@@ -14,6 +14,7 @@
 #include <asm/arch/soc.h>
 #include <asm/arch/board.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 int read_platform(void)
 {
diff --git a/board/Synology/common/legacy.c b/board/Synology/common/legacy.c
index a0bace7b46c2..dbffb34169e0 100644
--- a/board/Synology/common/legacy.c
+++ b/board/Synology/common/legacy.c
@@ -10,6 +10,7 @@
 #include <env.h>
 #include <net.h>
 #include <asm/setup.h>
+#include <linux/string.h>
 
 #include "legacy.h"
 
diff --git a/board/Synology/ds414/cmd_syno.c b/board/Synology/ds414/cmd_syno.c
index a62658a2eb6b..6bf8009f9f35 100644
--- a/board/Synology/ds414/cmd_syno.c
+++ b/board/Synology/ds414/cmd_syno.c
@@ -13,6 +13,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <linux/mtd/mtd.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include "../drivers/ddr/marvell/axp/ddr3_init.h"
diff --git a/board/advantech/imx8qm_dmsse20_a1/spl.c b/board/advantech/imx8qm_dmsse20_a1/spl.c
index e8959ede51d9..1ec9347e16a7 100644
--- a/board/advantech/imx8qm_dmsse20_a1/spl.c
+++ b/board/advantech/imx8qm_dmsse20_a1/spl.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <spl.h>
 #include <init.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/advantech/imx8qm_rom7720_a1/spl.c b/board/advantech/imx8qm_rom7720_a1/spl.c
index d32400101fc9..e35a037bd7d1 100644
--- a/board/advantech/imx8qm_rom7720_a1/spl.c
+++ b/board/advantech/imx8qm_rom7720_a1/spl.c
@@ -10,6 +10,7 @@
 #include <spl.h>
 #include <fsl_esdhc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 8bdfb302f728..c0e6baf40724 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -15,6 +15,7 @@
 #include <asm/arch/sm.h>
 #include <asm/global_data.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include "khadas-mcu.h"
 
 int mmc_get_env_dev(void)
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 3f1a42d18448..50253c6ee175 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -19,6 +19,7 @@
 #include <rng.h>
 #include <stdlib.h>
 #include <video_bridge.h>
+#include <linux/string.h>
 
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 17f37badd746..395e2e88ab04 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -36,6 +36,7 @@
 #include <micrel.h>
 #include <miiphy.h>
 #include <led.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/da9063_pmic.h>
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index ee65a596838a..504b057f8d09 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/sizes.h>
 #include <dm/platform_data/serial_pl01x.h>
+#include <linux/string.h>
 #include "pcie.h"
 #include <asm/armv8/mmu.h>
 #ifdef CONFIG_VIRTIO_NET
diff --git a/board/atmel/common/mac-spi-nor.c b/board/atmel/common/mac-spi-nor.c
index ced27b65e63b..3b150dac7d86 100644
--- a/board/atmel/common/mac-spi-nor.c
+++ b/board/atmel/common/mac-spi-nor.c
@@ -11,6 +11,7 @@
 #include <net.h>
 #include <linux/mtd/spi-nor.h>
 #include <netdev.h>
+#include <linux/string.h>
 
 #define ETH_ADDR_SIZE			6
 
diff --git a/board/atmel/common/video_display.c b/board/atmel/common/video_display.c
index a5049f4aad41..33725a01f505 100644
--- a/board/atmel/common/video_display.c
+++ b/board/atmel/common/video_display.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index 660a6b9d5835..83e7a629b238 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -19,6 +19,7 @@
 #include <spl.h>
 #include <asm/arch/atmel_mpddrc.h>
 #include <asm/arch/at91_wdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/beacon/beacon-rzg2m/beacon-rzg2m.c b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
index 99fe1edfb330..cbab129c464c 100644
--- a/board/beacon/beacon-rzg2m/beacon-rzg2m.c
+++ b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
index 1632238bf5dd..7de355ed5a10 100644
--- a/board/beacon/imx8mm/spl.c
+++ b/board/beacon/imx8mm/spl.c
@@ -15,6 +15,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index b4d46f11f98d..77fc83bfad83 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -24,6 +24,7 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/bd71837.h>
 #include <spl.h>
diff --git a/board/beckhoff/mx53cx9020/mx53cx9020.c b/board/beckhoff/mx53cx9020/mx53cx9020.c
index e7b131836b61..2830eb5f661d 100644
--- a/board/beckhoff/mx53cx9020/mx53cx9020.c
+++ b/board/beckhoff/mx53cx9020/mx53cx9020.c
@@ -18,6 +18,7 @@
 #include <ACEX1K.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 enum LED_GPIOS {
 	GPIO_SD1_CD = IMX_GPIO_NR(1, 1),
diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnard/gurnard.c
index 9b42299b080f..785fabce026e 100644
--- a/board/bluewater/gurnard/gurnard.c
+++ b/board/bluewater/gurnard/gurnard.c
@@ -34,6 +34,7 @@
 #include <asm/arch/gpio.h>
 #include <dm/uclass-internal.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_GURNARD_SPLASH
 #include "splash_logo.h"
diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index 34088adee47b..dd6720f18fdc 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <linux/delay.h>
 #include <mmc.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrogen6x/nitrogen6x.c
index 382c01ddf4e0..b5ebdeb66b73 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -35,6 +35,7 @@
 #include <i2c.h>
 #include <input.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/bsh/imx8mn_smm_s2/spl.c b/board/bsh/imx8mn_smm_s2/spl.c
index 5a77d28cb7e1..d95ed781bc97 100644
--- a/board/bsh/imx8mn_smm_s2/spl.c
+++ b/board/bsh/imx8mn_smm_s2/spl.c
@@ -16,6 +16,7 @@
 #include <asm/sections.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
diff --git a/board/cavium/thunderx/atf.c b/board/cavium/thunderx/atf.c
index 37340fe97003..b7abe60527d9 100644
--- a/board/cavium/thunderx/atf.c
+++ b/board/cavium/thunderx/atf.c
@@ -8,6 +8,7 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
+#include <linux/string.h>
 
 #include <asm/system.h>
 #include <cavium/thunderx_svc.h>
diff --git a/board/cloos/imx8mm_phg/spl.c b/board/cloos/imx8mm_phg/spl.c
index 0c3a0135a860..51b8699bb407 100644
--- a/board/cloos/imx8mm_phg/spl.c
+++ b/board/cloos/imx8mm_phg/spl.c
@@ -20,6 +20,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/compulab/cl-som-imx7/spl.c b/board/compulab/cl-som-imx7/spl.c
index 98c3b831f1e1..90ab7193b37f 100644
--- a/board/compulab/cl-som-imx7/spl.c
+++ b/board/compulab/cl-som-imx7/spl.c
@@ -17,6 +17,7 @@
 #include <asm/arch-mx7/clock.h>
 #include <asm/arch-mx7/mx7-ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 #include "common.h"
 
 #ifdef CONFIG_FSL_ESDHC_IMX
diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 7bce09e432c0..a2fb92356cfa 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -37,6 +37,7 @@
 #include <dm/device-internal.h>
 #include <jffs2/load_kernel.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "common.h"
 #include "../common/eeprom.h"
 #include "../common/common.h"
diff --git a/board/compulab/common/eeprom.c b/board/compulab/common/eeprom.c
index c4b257f851d6..2d4a6295ac5b 100644
--- a/board/compulab/common/eeprom.c
+++ b/board/compulab/common/eeprom.c
@@ -13,6 +13,7 @@
 #include <eeprom_field.h>
 #include <asm/setup.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include "eeprom.h"
 
 #define EEPROM_LAYOUT_VER_OFFSET	44
diff --git a/board/compulab/imx8mm-cl-iot-gate/spl.c b/board/compulab/imx8mm-cl-iot-gate/spl.c
index 19c1acd8a525..1568acf414dc 100644
--- a/board/compulab/imx8mm-cl-iot-gate/spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/spl.c
@@ -22,6 +22,7 @@
 #include <asm/mach-imx/gpio.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 26189ff66f58..430126e18d9e 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -8,6 +8,7 @@
 #include <linux/libfdt.h>
 #include <fsl_esdhc.h>
 #include <init.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/congatec/cgtqmx8/spl.c b/board/congatec/cgtqmx8/spl.c
index b432ce27459f..21dcafbb4f64 100644
--- a/board/congatec/cgtqmx8/spl.c
+++ b/board/congatec/cgtqmx8/spl.c
@@ -16,6 +16,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/congatec/common/mmc.c b/board/congatec/common/mmc.c
index bb7a3d4a9aa0..c45d6cd1b13a 100644
--- a/board/congatec/common/mmc.c
+++ b/board/congatec/common/mmc.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <stdbool.h>
 #include <mmc.h>
+#include <linux/string.h>
 
 static int check_mmc_autodetect(void)
 {
diff --git a/board/cssi/cmpc885/cmpc885.c b/board/cssi/cmpc885/cmpc885.c
index 5e6aa8b8cfa6..96efa210a99c 100644
--- a/board/cssi/cmpc885/cmpc885.c
+++ b/board/cssi/cmpc885/cmpc885.c
@@ -24,6 +24,7 @@
 #include <fdt_support.h>
 #include <linux/delay.h>
 #include <spi.h>
+#include <linux/string.h>
 
 #include "../common/common.h"
 
diff --git a/board/cssi/cmpcpro/cmpcpro.c b/board/cssi/cmpcpro/cmpcpro.c
index 8a30c48e35b6..cc65f9f101d0 100644
--- a/board/cssi/cmpcpro/cmpcpro.c
+++ b/board/cssi/cmpcpro/cmpcpro.c
@@ -17,6 +17,7 @@
 #include <spi.h>
 #include <stdarg.h>
 #include <stdlib.h>
+#include <linux/string.h>
 
 #include <linux/delay.h>
 #include <linux/immap_qe.h>
diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index bf9a11472d11..5ea2509e5cf6 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -20,6 +20,7 @@
 #include <init.h>
 #include <net.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/davinci/da8xxevm/da850evm.c b/board/davinci/da8xxevm/da850evm.c
index 474dca72929f..409d616184c8 100644
--- a/board/davinci/da8xxevm/da850evm.c
+++ b/board/davinci/da8xxevm/da850evm.c
@@ -27,6 +27,7 @@
 #include <hwconfig.h>
 #include <asm/mach-types.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_MMC_DAVINCI
 #include <mmc.h>
diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 5ffd420fff36..971313af50b3 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -26,6 +26,7 @@
 #include <mmc.h>
 #include <asm/arch/sdmmc_defs.h>
 #endif
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 07fc9b1fe6d8..6d83906001de 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -34,6 +34,7 @@
 #include <mmc.h>
 #include <usb.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 
 #include "../common/dh_common.h"
diff --git a/board/dhelectronics/dh_imx6/dh_imx6_spl.c b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
index e6d5657c62d0..d8f8c92b0c8e 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6_spl.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
@@ -30,6 +30,7 @@
 #include <mmc.h>
 #include <spl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define ENET_PAD_CTRL							\
 	(PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm |	\
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 760ea4be35c7..215cb48efe92 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -18,6 +18,7 @@
 #include <malloc.h>
 #include <net.h>
 #include <miiphy.h>
+#include <linux/string.h>
 
 #include "lpddr4_timing.h"
 #include "../common/dh_common.h"
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index a8fda139aa4d..9848327d51bd 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -16,6 +16,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 341d095d689d..b3f271f0acf9 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -35,6 +35,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <remoteproc.h>
 #include <reset.h>
diff --git a/board/ea/mx7ulp_com/mx7ulp_com.c b/board/ea/mx7ulp_com/mx7ulp_com.c
index cd9591a9e324..dc238603eea9 100644
--- a/board/ea/mx7ulp_com/mx7ulp_com.c
+++ b/board/ea/mx7ulp_com/mx7ulp_com.c
@@ -11,6 +11,7 @@
 #include <asm/arch/mx7ulp-pins.h>
 #include <asm/arch/iomux.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/egnite/ethernut5/ethernut5_pwrman.c b/board/egnite/ethernut5/ethernut5_pwrman.c
index 81f1abf2fad9..424ad035b425 100644
--- a/board/egnite/ethernut5/ethernut5_pwrman.c
+++ b/board/egnite/ethernut5/ethernut5_pwrman.c
@@ -20,6 +20,7 @@
  * which allows to manually deal with the PMC.
  *
  * Two distinct registers are provided by the PMC for enabling
+#include <linux/string.h>
  * and disabling specific features. This avoids the often seen
  * read-modify-write cycle or shadow register requirement.
  * Additional registers are available to query the board
diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/qemu_dfu.c
index 7e7d84f6c00f..ab0b9426320d 100644
--- a/board/emulation/common/qemu_dfu.c
+++ b/board/emulation/common/qemu_dfu.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <memalign.h>
 #include <mtd.h>
+#include <linux/string.h>
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
index 221361691c15..060a909b6377 100644
--- a/board/emulation/qemu-ppce500/qemu-ppce500.c
+++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
@@ -30,6 +30,7 @@
 #include <malloc.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/engicam/common/board.c b/board/engicam/common/board.c
index df9149e0d6d8..28080d423b39 100644
--- a/board/engicam/common/board.c
+++ b/board/engicam/common/board.c
@@ -17,6 +17,7 @@
 #include <asm/arch/sys_proto.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include "board.h"
 
diff --git a/board/engicam/common/spl.c b/board/engicam/common/spl.c
index f1ccdc334363..6f782921e3d8 100644
--- a/board/engicam/common/spl.c
+++ b/board/engicam/common/spl.c
@@ -11,6 +11,7 @@
 #include <serial.h>
 #include <spl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/engicam/imx8mm/spl.c b/board/engicam/imx8mm/spl.c
index af9044a3c2b0..4174f2e20ba1 100644
--- a/board/engicam/imx8mm/spl.c
+++ b/board/engicam/imx8mm/spl.c
@@ -17,6 +17,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/esd/meesc/meesc.c b/board/esd/meesc/meesc.c
index 9e3621042241..11d533797668 100644
--- a/board/esd/meesc/meesc.c
+++ b/board/esd/meesc/meesc.c
@@ -28,6 +28,7 @@
 #include <asm/arch/at91_pio.h>
 #include <asm/arch/clk.h>
 #include <netdev.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 93e7d776fb2f..7029bf7bf869 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <spl_gpio.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #include <asm/arch-rockchip/cru.h>
diff --git a/board/freescale/common/fsl_validate.c b/board/freescale/common/fsl_validate.c
index bfe6357b0d60..967898f24c25 100644
--- a/board/freescale/common/fsl_validate.c
+++ b/board/freescale/common/fsl_validate.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <u-boot/rsa-mod-exp.h>
 #include <hash.h>
 #include <fsl_secboot_err.h>
diff --git a/board/freescale/common/mmc.c b/board/freescale/common/mmc.c
index 8cd5079f962d..55aca1c0ecf8 100644
--- a/board/freescale/common/mmc.c
+++ b/board/freescale/common/mmc.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <mmc.h>
 #include <env.h>
+#include <linux/string.h>
 
 static int check_mmc_autodetect(void)
 {
diff --git a/board/freescale/common/ngpixis.c b/board/freescale/common/ngpixis.c
index 37a6f775a057..a89b07986bb0 100644
--- a/board/freescale/common/ngpixis.c
+++ b/board/freescale/common/ngpixis.c
@@ -32,6 +32,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "ngpixis.h"
 
diff --git a/board/freescale/common/qixis.c b/board/freescale/common/qixis.c
index da2c1de078b7..5f1a220f9cb7 100644
--- a/board/freescale/common/qixis.c
+++ b/board/freescale/common/qixis.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <linux/time.h>
 #include <i2c.h>
 #include "qixis.h"
diff --git a/board/freescale/common/sys_eeprom.c b/board/freescale/common/sys_eeprom.c
index 431f8caeb034..794ca4e022f2 100644
--- a/board/freescale/common/sys_eeprom.c
+++ b/board/freescale/common/sys_eeprom.c
@@ -13,6 +13,7 @@
 #include <init.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #ifdef CONFIG_SYS_I2C_EEPROM_CCID
diff --git a/board/freescale/imx8mm_evk/spl.c b/board/freescale/imx8mm_evk/spl.c
index 35437811d9df..f38ed90d61bf 100644
--- a/board/freescale/imx8mm_evk/spl.c
+++ b/board/freescale/imx8mm_evk/spl.c
@@ -20,6 +20,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index dd54fa9b6085..e761032db0ef 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/freescale/imx8mq_evk/spl.c b/board/freescale/imx8mq_evk/spl.c
index 818cdd615eb9..0ca915eed76e 100644
--- a/board/freescale/imx8mq_evk/spl.c
+++ b/board/freescale/imx8mq_evk/spl.c
@@ -25,6 +25,7 @@
 #include <fsl_sec.h>
 #include <mmc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include <spl.h>
diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c b/board/freescale/imx8qm_mek/imx8qm_mek.c
index d96d1d07bb1e..55a5816aecd9 100644
--- a/board/freescale/imx8qm_mek/imx8qm_mek.c
+++ b/board/freescale/imx8qm_mek/imx8qm_mek.c
@@ -18,6 +18,7 @@
 #include <asm/arch/imx8-pins.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx8qm_mek/spl.c b/board/freescale/imx8qm_mek/spl.c
index 17fd437116d3..1e5656a8724c 100644
--- a/board/freescale/imx8qm_mek/spl.c
+++ b/board/freescale/imx8qm_mek/spl.c
@@ -18,6 +18,7 @@
 #include <dm/lists.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
index 516cefd2f246..fe8faa25ce27 100644
--- a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
+++ b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
@@ -21,6 +21,7 @@
 #include <asm/arch/snvs_security_sc.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx8qxp_mek/spl.c b/board/freescale/imx8qxp_mek/spl.c
index 462c43ceebc7..8151e44a9f86 100644
--- a/board/freescale/imx8qxp_mek/spl.c
+++ b/board/freescale/imx8qxp_mek/spl.c
@@ -23,6 +23,7 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index dd04d5925a00..5ed523a3c7b7 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -13,6 +13,7 @@
 #include <miiphy.h>
 #include <netdev.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx8ulp_evk/spl.c b/board/freescale/imx8ulp_evk/spl.c
index c49b5be47620..a777b83adf73 100644
--- a/board/freescale/imx8ulp_evk/spl.c
+++ b/board/freescale/imx8ulp_evk/spl.c
@@ -21,6 +21,7 @@
 #include <asm/arch/upower.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index be9c24fc0d91..99f6221a52c2 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -29,6 +29,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/ccm_regs.h>
 #include <asm/arch/ddr.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
 #include <asm/arch/trdc.h>
diff --git a/board/freescale/ls1012aqds/ls1012aqds.c b/board/freescale/ls1012aqds/ls1012aqds.c
index 194b5d27295b..2d040e2c1a18 100644
--- a/board/freescale/ls1012aqds/ls1012aqds.c
+++ b/board/freescale/ls1012aqds/ls1012aqds.c
@@ -29,6 +29,7 @@
 #include <fsl_mmdc.h>
 #include <spl.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include "../common/qixis.h"
 #include "ls1012aqds_qixis.h"
 #include "ls1012aqds_pfe.h"
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/freescale/ls1012ardb/ls1012ardb.c
index 62c935e4d3ec..8bc803293883 100644
--- a/board/freescale/ls1012ardb/ls1012ardb.c
+++ b/board/freescale/ls1012ardb/ls1012ardb.c
@@ -28,6 +28,7 @@
 #include <env_internal.h>
 #include <fsl_mmdc.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include <net/pfe_eth/pfe/pfe_hw.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index d6f22bd6a2a3..1fda427322f1 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -15,6 +15,7 @@
 #include <asm/arch/ls102xa_stream_id.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/arch/ls102xa_devdis.h>
 #include <asm/arch/ls102xa_soc.h>
diff --git a/board/freescale/ls1021aqds/ddr.c b/board/freescale/ls1021aqds/ddr.c
index 4e70acc5a0cc..ec2ecc04d44b 100644
--- a/board/freescale/ls1021aqds/ddr.c
+++ b/board/freescale/ls1021aqds/ddr.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "ddr.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/freescale/ls1021aqds/ls1021aqds.c b/board/freescale/ls1021aqds/ls1021aqds.c
index a618ce11a584..44b4884053e1 100644
--- a/board/freescale/ls1021aqds/ls1021aqds.c
+++ b/board/freescale/ls1021aqds/ls1021aqds.c
@@ -25,6 +25,7 @@
 #include <fsl_devdis.h>
 #include <fsl_validate.h>
 #include <fsl_ddr.h>
+#include <linux/string.h>
 #include "../common/i2c_mux.h"
 #include "../common/sleep.h"
 #include "../common/qixis.h"
diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index d0e4e796c606..851797fdcde5 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/sections.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "../common/sleep.h"
 #include <fsl_validate.h>
 #include <fsl_immap.h>
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index 27b9d79e5f0b..19fc7b823e5c 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -30,6 +30,7 @@
 #include <fsl_devdis.h>
 #include <spl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "../common/sleep.h"
 #ifdef CONFIG_U_QE
 #include <fsl_qe.h>
diff --git a/board/freescale/ls1043aqds/eth.c b/board/freescale/ls1043aqds/eth.c
index cd1f83e3d068..aaf5ba1f4521 100644
--- a/board/freescale/ls1043aqds/eth.c
+++ b/board/freescale/ls1043aqds/eth.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <asm/arch/fsl_serdes.h>
+#include <linux/string.h>
 
 #include "../common/qixis.h"
 #include "../common/fman.h"
diff --git a/board/freescale/ls1043ardb/cpld.c b/board/freescale/ls1043ardb/cpld.c
index 9db3aa586059..98a29e6286b5 100644
--- a/board/freescale/ls1043ardb/cpld.c
+++ b/board/freescale/ls1043ardb/cpld.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "cpld.h"
 
 u8 cpld_read(unsigned int reg)
diff --git a/board/freescale/ls1043ardb/ddr.c b/board/freescale/ls1043ardb/ddr.c
index 4d2fce384121..209e14942912 100644
--- a/board/freescale/ls1043ardb/ddr.c
+++ b/board/freescale/ls1043ardb/ddr.c
@@ -7,6 +7,7 @@
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr_dimm_params.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "ddr.h"
 #include <log.h>
 #include <vsprintf.h>
diff --git a/board/freescale/ls1046afrwy/eth.c b/board/freescale/ls1046afrwy/eth.c
index d1a2bfe18855..4a69e0e14816 100644
--- a/board/freescale/ls1046afrwy/eth.c
+++ b/board/freescale/ls1046afrwy/eth.c
@@ -11,6 +11,7 @@
 #include <fsl_dtsec.h>
 #include <fsl_mdio.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include "../common/fman.h"
 
diff --git a/board/freescale/ls1046ardb/cpld.c b/board/freescale/ls1046ardb/cpld.c
index ee19d4ff8aab..0210417d04de 100644
--- a/board/freescale/ls1046ardb/cpld.c
+++ b/board/freescale/ls1046ardb/cpld.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "cpld.h"
 
 u8 cpld_read(unsigned int reg)
diff --git a/board/freescale/ls1046ardb/eth.c b/board/freescale/ls1046ardb/eth.c
index bbc22a3cdf4a..76ba4d082f37 100644
--- a/board/freescale/ls1046ardb/eth.c
+++ b/board/freescale/ls1046ardb/eth.c
@@ -11,6 +11,7 @@
 #include <fsl_dtsec.h>
 #include <fsl_mdio.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include "../common/fman.h"
 
diff --git a/board/freescale/ls1088a/eth_ls1088aqds.c b/board/freescale/ls1088a/eth_ls1088aqds.c
index f62f5fd27450..752bb87f5f26 100644
--- a/board/freescale/ls1088a/eth_ls1088aqds.c
+++ b/board/freescale/ls1088a/eth_ls1088aqds.c
@@ -6,6 +6,7 @@
 #include <asm/io.h>
 #include <asm/arch/fsl_serdes.h>
 #include <fsl-mc/fsl_mc.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index f2b8bec03729..380bf5dcc18c 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -27,6 +27,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
+#include <linux/string.h>
 #include "../common/i2c_mux.h"
 
 #include "../common/qixis.h"
diff --git a/board/freescale/ls2080aqds/eth.c b/board/freescale/ls2080aqds/eth.c
index 0d0d5de15623..0e3ba39c3b6c 100644
--- a/board/freescale/ls2080aqds/eth.c
+++ b/board/freescale/ls2080aqds/eth.c
@@ -6,6 +6,7 @@
 #include <asm/io.h>
 #include <asm/arch/fsl_serdes.h>
 #include <fsl-mc/fsl_mc.h>
+#include <linux/string.h>
 
 #define MC_BOOT_ENV_VAR "mcinitcmd"
 
diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index ab5ff6f62ce0..0e4d98bbb4cd 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -25,6 +25,7 @@
 #include <hwconfig.h>
 #include <asm/arch/ppa.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
+#include <linux/string.h>
 #include "../common/i2c_mux.h"
 
 #include "../common/qixis.h"
diff --git a/board/freescale/lx2160a/eth_lx2160aqds.c b/board/freescale/lx2160a/eth_lx2160aqds.c
index 9939bb6f89e4..750aac9acfb0 100644
--- a/board/freescale/lx2160a/eth_lx2160aqds.c
+++ b/board/freescale/lx2160a/eth_lx2160aqds.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <exports.h>
 #include <fsl-mc/fsl_mc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/lx2160a/eth_lx2162aqds.c b/board/freescale/lx2160a/eth_lx2162aqds.c
index 805aa705be91..7c88dd11dbbc 100644
--- a/board/freescale/lx2160a/eth_lx2162aqds.c
+++ b/board/freescale/lx2160a/eth_lx2162aqds.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <exports.h>
 #include <fsl-mc/fsl_mc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/lx2160a.c
index 2883848550af..b2a58db4b668 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -30,6 +30,7 @@
 #include <asm/arch/config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
+#include <linux/string.h>
 #include "../common/i2c_mux.h"
 
 #include "../common/qixis.h"
diff --git a/board/freescale/mx6memcal/spl.c b/board/freescale/mx6memcal/spl.c
index 61d0ca3408f0..4c0ca08b55b8 100644
--- a/board/freescale/mx6memcal/spl.c
+++ b/board/freescale/mx6memcal/spl.c
@@ -16,6 +16,7 @@
 #include <asm/arch/mx6-pins.h>
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/freescale/mx6sabreauto/mx6sabreauto.c
index 77e92006131a..7fb9d920dea0 100644
--- a/board/freescale/mx6sabreauto/mx6sabreauto.c
+++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
@@ -31,6 +31,7 @@
 #include <asm/mach-imx/video.h>
 #include <asm/arch/crm_regs.h>
 #include <pca953x.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include "../common/pfuze.h"
diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx6sabresd/mx6sabresd.c
index b558a596dff8..beb80bd8e018 100644
--- a/board/freescale/mx6sabresd/mx6sabresd.c
+++ b/board/freescale/mx6sabresd/mx6sabresd.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <input.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include "../common/pfuze.h"
diff --git a/board/freescale/mx6slevk/mx6slevk.c b/board/freescale/mx6slevk/mx6slevk.c
index e9ac57118b01..9e071213d8be 100644
--- a/board/freescale/mx6slevk/mx6slevk.c
+++ b/board/freescale/mx6slevk/mx6slevk.c
@@ -25,6 +25,7 @@
 #include <fsl_esdhc_imx.h>
 #include <i2c.h>
 #include <mmc.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include "../common/pfuze.h"
diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
index 534b16cec7ae..f343ccb89890 100644
--- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
+++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
@@ -28,6 +28,7 @@
 #include <linux/sizes.h>
 #include <mmc.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
 #include "../common/pfuze.h"
diff --git a/board/freescale/p1010rdb/ddr.c b/board/freescale/p1010rdb/ddr.c
index b423ec8e218a..2e6598068539 100644
--- a/board/freescale/p1010rdb/ddr.c
+++ b/board/freescale/p1010rdb/ddr.c
@@ -13,6 +13,7 @@
 #include <fsl_ddr_dimm_params.h>
 #include <asm/io.h>
 #include <asm/fsl_law.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/freescale/p1010rdb/p1010rdb.c
index d32274b24812..0b840d45f6bd 100644
--- a/board/freescale/p1010rdb/p1010rdb.c
+++ b/board/freescale/p1010rdb/p1010rdb.c
@@ -29,6 +29,7 @@
 #include <asm/fsl_pci.h>
 #include <hwconfig.h>
 #include <i2c.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/p1010rdb/spl.c b/board/freescale/p1010rdb/spl.c
index e450f626e0ad..4057b7fe4f2f 100644
--- a/board/freescale/p1010rdb/spl.c
+++ b/board/freescale/p1010rdb/spl.c
@@ -16,6 +16,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/spl.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/freescale/p1_p2_rdb_pc/ddr.c b/board/freescale/p1_p2_rdb_pc/ddr.c
index 5f16779abaad..351c4fc82101 100644
--- a/board/freescale/p1_p2_rdb_pc/ddr.c
+++ b/board/freescale/p1_p2_rdb_pc/ddr.c
@@ -12,6 +12,7 @@
 #include <fsl_ddr_dimm_params.h>
 #include <asm/io.h>
 #include <asm/fsl_law.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYS_DDR_RAW_TIMING
 #if	defined(CONFIG_P1020RDB_PROTO)
diff --git a/board/freescale/p1_p2_rdb_pc/spl.c b/board/freescale/p1_p2_rdb_pc/spl.c
index 6c3f82849e3a..f90bf2ce6f2d 100644
--- a/board/freescale/p1_p2_rdb_pc/spl.c
+++ b/board/freescale/p1_p2_rdb_pc/spl.c
@@ -17,6 +17,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/spl.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/freescale/p2041rdb/cpld.c b/board/freescale/p2041rdb/cpld.c
index a1908b8a5712..ab54b3b7b08d 100644
--- a/board/freescale/p2041rdb/cpld.c
+++ b/board/freescale/p2041rdb/cpld.c
@@ -14,6 +14,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "cpld.h"
 
diff --git a/board/freescale/t102xrdb/cpld.c b/board/freescale/t102xrdb/cpld.c
index 17a6226cafc7..95af6b79d54d 100644
--- a/board/freescale/t102xrdb/cpld.c
+++ b/board/freescale/t102xrdb/cpld.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "cpld.h"
 
 u8 cpld_read(unsigned int reg)
diff --git a/board/freescale/t102xrdb/ddr.c b/board/freescale/t102xrdb/ddr.c
index 1b4173989925..0af58d2790dd 100644
--- a/board/freescale/t102xrdb/ddr.c
+++ b/board/freescale/t102xrdb/ddr.c
@@ -15,6 +15,7 @@
 #include <asm/fsl_law.h>
 #include <asm/mpc85xx_gpio.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/t102xrdb/spl.c b/board/freescale/t102xrdb/spl.c
index 9faf259af74d..9de5f5e35b39 100644
--- a/board/freescale/t102xrdb/spl.c
+++ b/board/freescale/t102xrdb/spl.c
@@ -15,6 +15,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/sleep.h"
 #include "../common/spl.h"
 
diff --git a/board/freescale/t102xrdb/t102xrdb.c b/board/freescale/t102xrdb/t102xrdb.c
index 73f9d3ac72e7..441a8a9f8307 100644
--- a/board/freescale/t102xrdb/t102xrdb.c
+++ b/board/freescale/t102xrdb/t102xrdb.c
@@ -22,6 +22,7 @@
 #include <asm/fsl_liodn.h>
 #include <clock_legacy.h>
 #include <fm_eth.h>
+#include <linux/string.h>
 #include "t102xrdb.h"
 #ifdef CONFIG_TARGET_T1024RDB
 #include "cpld.h"
diff --git a/board/freescale/t104xrdb/cpld.c b/board/freescale/t104xrdb/cpld.c
index 9ac57bbd8300..b6292a6c10e0 100644
--- a/board/freescale/t104xrdb/cpld.c
+++ b/board/freescale/t104xrdb/cpld.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "cpld.h"
 
diff --git a/board/freescale/t104xrdb/spl.c b/board/freescale/t104xrdb/spl.c
index dd8283f3c60a..df9a3ad4b8c8 100644
--- a/board/freescale/t104xrdb/spl.c
+++ b/board/freescale/t104xrdb/spl.c
@@ -15,6 +15,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/sleep.h"
 #include "../common/spl.h"
 
diff --git a/board/freescale/t208xqds/eth_t208xqds.c b/board/freescale/t208xqds/eth_t208xqds.c
index 569b193eab78..8cea6d71887e 100644
--- a/board/freescale/t208xqds/eth_t208xqds.c
+++ b/board/freescale/t208xqds/eth_t208xqds.c
@@ -27,6 +27,7 @@
 #include <fsl_dtsec.h>
 #include <asm/fsl_serdes.h>
 #include <hwconfig.h>
+#include <linux/string.h>
 #include "../common/qixis.h"
 #include "../common/fman.h"
 #include "t208xqds_qixis.h"
diff --git a/board/freescale/t208xqds/spl.c b/board/freescale/t208xqds/spl.c
index 8866be54a661..41b94fc56f89 100644
--- a/board/freescale/t208xqds/spl.c
+++ b/board/freescale/t208xqds/spl.c
@@ -15,6 +15,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/qixis.h"
 #include "t208xqds_qixis.h"
 #include "../common/spl.h"
diff --git a/board/freescale/t208xrdb/cpld.c b/board/freescale/t208xrdb/cpld.c
index 933fa0decc31..3d1d9080bd7b 100644
--- a/board/freescale/t208xrdb/cpld.c
+++ b/board/freescale/t208xrdb/cpld.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 #include "cpld.h"
 
 u8 cpld_read(unsigned int reg)
diff --git a/board/freescale/t208xrdb/spl.c b/board/freescale/t208xrdb/spl.c
index 130cb8847c0f..a750f6ff5344 100644
--- a/board/freescale/t208xrdb/spl.c
+++ b/board/freescale/t208xrdb/spl.c
@@ -15,6 +15,7 @@
 #include <fsl_esdhc.h>
 #include <spi_flash.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "../common/spl.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/freescale/t4rdb/cpld.c b/board/freescale/t4rdb/cpld.c
index 8b1012086ec7..75b169714815 100644
--- a/board/freescale/t4rdb/cpld.c
+++ b/board/freescale/t4rdb/cpld.c
@@ -17,6 +17,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "cpld.h"
 
diff --git a/board/freescale/t4rdb/spl.c b/board/freescale/t4rdb/spl.c
index 779457d29640..8cd3e1accadc 100644
--- a/board/freescale/t4rdb/spl.c
+++ b/board/freescale/t4rdb/spl.c
@@ -18,6 +18,7 @@
 #include <mmc.h>
 #include <fsl_esdhc.h>
 #include <i2c.h>
+#include <linux/string.h>
 
 #include "t4rdb.h"
 
diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 393c5a447d6f..3cb33caec328 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -14,6 +14,7 @@
 #endif
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <asm/arch/nexell.h>
 #include <asm/arch/nx_gpio.h>
diff --git a/board/friendlyarm/nanopi2/lcds.c b/board/friendlyarm/nanopi2/lcds.c
index 7303e53af925..2691008dc79b 100644
--- a/board/friendlyarm/nanopi2/lcds.c
+++ b/board/friendlyarm/nanopi2/lcds.c
@@ -9,6 +9,7 @@
 #include <fdtdec.h>
 #include <fdt_support.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <asm/arch/nexell.h>
 #include <asm/arch/display.h>
diff --git a/board/gardena/smart-gateway-mt7688/board.c b/board/gardena/smart-gateway-mt7688/board.c
index 0cfde91c94c6..f616cbd50908 100644
--- a/board/gardena/smart-gateway-mt7688/board.c
+++ b/board/gardena/smart-gateway-mt7688/board.c
@@ -15,6 +15,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <u-boot/crc.h>
 #include <uuid.h>
diff --git a/board/gateworks/gw_ventana/eeprom.c b/board/gateworks/gw_ventana/eeprom.c
index e622a9ba9e4d..b30a19478191 100644
--- a/board/gateworks/gw_ventana/eeprom.c
+++ b/board/gateworks/gw_ventana/eeprom.c
@@ -14,6 +14,7 @@
 #include <dm/uclass.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "eeprom.h"
 
diff --git a/board/gateworks/gw_ventana/gw_ventana.c b/board/gateworks/gw_ventana/gw_ventana.c
index 683def7e9f71..fb4f81595cd5 100644
--- a/board/gateworks/gw_ventana/gw_ventana.c
+++ b/board/gateworks/gw_ventana/gw_ventana.c
@@ -23,6 +23,7 @@
 #include <jffs2/load_kernel.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "common.h"
 
diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 241be4ee630b..5f9009ecf969 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -8,6 +8,7 @@
 #include <hexdump.h>
 #include <i2c.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 #include "eeprom.h"
 
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 774a99041c8a..5bb60ab65b79 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -24,6 +24,7 @@
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/bd71837.h>
 #include <power/mp5416.h>
 #include <power/pca9450.h>
diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index a39ae58c8a09..9dc797be3669 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -12,6 +12,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <linux/string.h>
 
 #include "eeprom.h"
 
diff --git a/board/gdsys/a38x/hre.c b/board/gdsys/a38x/hre.c
index d16233ed78ee..bd5659bc4555 100644
--- a/board/gdsys/a38x/hre.c
+++ b/board/gdsys/a38x/hre.c
@@ -11,6 +11,7 @@
 #include <i2c.h>
 #include <mmc.h>
 #include <tpm-v1.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <u-boot/sha1.h>
 #include <asm/byteorder.h>
diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 60a5c37aeffb..c427b7b7e552 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -4,6 +4,7 @@
 #include <asm-generic/gpio.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ihs_phys.h"
 #include "dt_helpers.h"
diff --git a/board/gdsys/a38x/keyprogram.c b/board/gdsys/a38x/keyprogram.c
index 7020fae18941..e61abdb285fb 100644
--- a/board/gdsys/a38x/keyprogram.c
+++ b/board/gdsys/a38x/keyprogram.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <linux/ctype.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 
 #include "hre.h"
 
diff --git a/board/gdsys/common/cmd_ioloop.c b/board/gdsys/common/cmd_ioloop.c
index 1412421a0218..855161115807 100644
--- a/board/gdsys/common/cmd_ioloop.c
+++ b/board/gdsys/common/cmd_ioloop.c
@@ -9,6 +9,7 @@
 #include <console.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <gdsys_fpga.h>
 
diff --git a/board/gdsys/common/ihs_mdio.c b/board/gdsys/common/ihs_mdio.c
index 5f1215e9e8a6..3a51338d92ab 100644
--- a/board/gdsys/common/ihs_mdio.c
+++ b/board/gdsys/common/ihs_mdio.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <miiphy.h>
 #ifdef CONFIG_GDSYS_LEGACY_DRIVERS
diff --git a/board/gdsys/common/ioep-fpga.c b/board/gdsys/common/ioep-fpga.c
index 7292d7ab5a41..a670425ecb8c 100644
--- a/board/gdsys/common/ioep-fpga.c
+++ b/board/gdsys/common/ioep-fpga.c
@@ -381,6 +381,7 @@ static int get_features(unsigned int fpga, struct fpga_features *features)
 	u16 raw_extended_features;
 #endif
 
+#include <linux/string.h>
 	memset(features, 0, sizeof(struct fpga_features));
 
 	FPGA_GET_REG(fpga, fpga_features, &raw_features);
diff --git a/board/gdsys/common/osd.c b/board/gdsys/common/osd.c
index dc548efbc7a4..b691698c2347 100644
--- a/board/gdsys/common/osd.c
+++ b/board/gdsys/common/osd.c
@@ -261,6 +261,7 @@ static int osd_write_videomem(unsigned screen, unsigned offset,
 	return charcount;
 }
 
+#include <linux/string.h>
 static int osd_print(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
diff --git a/board/gdsys/common/osd_cmd.c b/board/gdsys/common/osd_cmd.c
index 6a9c0b4c24f0..99d217d68ba7 100644
--- a/board/gdsys/common/osd_cmd.c
+++ b/board/gdsys/common/osd_cmd.c
@@ -15,6 +15,7 @@
 #include <hexdump.h>
 #include <video_osd.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 static int do_osd_write(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index a2cbd1512e92..05dccc2cca66 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -31,6 +31,7 @@
 #include <rtc.h>
 #include <spi_flash.h>
 #include <version_string.h>
+#include <linux/string.h>
 
 #include "../common/vpd_reader.h"
 
diff --git a/board/ge/b1x5v2/spl.c b/board/ge/b1x5v2/spl.c
index 460d3be1d834..0098703ab81e 100644
--- a/board/ge/b1x5v2/spl.c
+++ b/board/ge/b1x5v2/spl.c
@@ -19,6 +19,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_SPL_BUILD)
 
diff --git a/board/ge/bx50v3/bx50v3.c b/board/ge/bx50v3/bx50v3.c
index 2d8951964a85..dfd5feb34455 100644
--- a/board/ge/bx50v3/bx50v3.c
+++ b/board/ge/bx50v3/bx50v3.c
@@ -30,6 +30,7 @@
 #include <asm/arch/crm_regs.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <power/da9063_pmic.h>
 #include <power/pmic.h>
diff --git a/board/ge/mx53ppd/mx53ppd.c b/board/ge/mx53ppd/mx53ppd.c
index cc462d53da6a..886b32f0c994 100644
--- a/board/ge/mx53ppd/mx53ppd.c
+++ b/board/ge/mx53ppd/mx53ppd.c
@@ -28,6 +28,7 @@
 #include <mmc.h>
 #include <fsl_esdhc_imx.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <dialog_pmic.h>
 #include <fsl_pmic.h>
diff --git a/board/google/chameleonv3/mercury_aa1.c b/board/google/chameleonv3/mercury_aa1.c
index ed447ec37c45..af43f930f242 100644
--- a/board/google/chameleonv3/mercury_aa1.c
+++ b/board/google/chameleonv3/mercury_aa1.c
@@ -6,6 +6,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <atsha204a-i2c.h>
+#include <linux/string.h>
 #include "mercury_aa1.h"
 
 #define MERCURY_AA1_ATSHA204A_OTP_MAC0 4
diff --git a/board/google/imx8mq_phanbell/spl.c b/board/google/imx8mq_phanbell/spl.c
index 83de5bfd75fa..4b36a41bb157 100644
--- a/board/google/imx8mq_phanbell/spl.c
+++ b/board/google/imx8mq_phanbell/spl.c
@@ -24,6 +24,7 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index 48392c48e5cc..46c7138b303b 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -29,6 +29,7 @@
 #include <mmc.h>
 #include <netdev.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 3372290120b5..a8e17a8a654c 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #define RST_BASE	0xE6160000
 #define RST_CA57RESCNT	(RST_BASE + 0x40)
diff --git a/board/imgtec/malta/malta.c b/board/imgtec/malta/malta.c
index 4a72ab5cecad..93fce2272b54 100644
--- a/board/imgtec/malta/malta.c
+++ b/board/imgtec/malta/malta.c
@@ -16,6 +16,7 @@
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/addrspace.h>
 #include <asm/io.h>
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index 0f0a9c592fcc..9c9b902897ec 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -27,6 +27,7 @@
 #include <jffs2/load_kernel.h>
 #include <mtd_node.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 #include "igep00x0.h"
 
 static const struct ns16550_plat igep_serial = {
diff --git a/board/k+p/kp_imx53/kp_id_rev.c b/board/k+p/kp_imx53/kp_id_rev.c
index 9f93cf008ce8..bd846474bd47 100644
--- a/board/k+p/kp_imx53/kp_id_rev.c
+++ b/board/k+p/kp_imx53/kp_id_rev.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <env.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include "kp_id_rev.h"
 #include <net.h>
 
diff --git a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
index 54902437940b..6e15297cff8d 100644
--- a/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
+++ b/board/k+p/kp_imx6q_tpc/kp_imx6q_tpc_spl.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <spl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/keymile/common/common.c b/board/keymile/common/common.c
index 991022ac833a..ff0a447a89f3 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/bug.h>
 #include <bootcount.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_POST)
 #include "post.h"
diff --git a/board/keymile/common/ivm.c b/board/keymile/common/ivm.c
index 67db0c50f47c..0e3f059436bc 100644
--- a/board/keymile/common/ivm.c
+++ b/board/keymile/common/ivm.c
@@ -8,6 +8,7 @@
 #include <cli_hush.h>
 #include <env.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include "common.h"
 
 #define MAC_STR_SZ	20
diff --git a/board/keymile/kmcent2/kmcent2.c b/board/keymile/kmcent2/kmcent2.c
index 572cc7bbdc67..611a748f5229 100644
--- a/board/keymile/kmcent2/kmcent2.c
+++ b/board/keymile/kmcent2/kmcent2.c
@@ -24,6 +24,7 @@
 #include <net.h>
 #include <netdev.h>
 #include <vsc9953.h>
+#include <linux/string.h>
 
 #include "../common/common.h"
 #include "../common/qrio.h"
diff --git a/board/kontron/pitx_imx8m/spl.c b/board/kontron/pitx_imx8m/spl.c
index a247803a4b46..eabf876e1a7a 100644
--- a/board/kontron/pitx_imx8m/spl.c
+++ b/board/kontron/pitx_imx8m/spl.c
@@ -18,6 +18,7 @@
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/sections.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 
diff --git a/board/kontron/sl-mx6ul/spl.c b/board/kontron/sl-mx6ul/spl.c
index b17588587055..6a49486add78 100644
--- a/board/kontron/sl-mx6ul/spl.c
+++ b/board/kontron/sl-mx6ul/spl.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <mmc.h>
 #include <sl-mx6ul-common.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index 54ee1e66a7a4..b4f178c61f0d 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -22,6 +22,7 @@
 #include <init.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pca9450.h>
 #include <power/pmic.h>
 #include <spl.h>
diff --git a/board/kontron/sl28/spl.c b/board/kontron/sl28/spl.c
index ffaf517a8bbe..93dc9c6ab90f 100644
--- a/board/kontron/sl28/spl.c
+++ b/board/kontron/sl28/spl.c
@@ -6,6 +6,7 @@
 #include <asm/arch-fsl-layerscape/fsl_serdes.h>
 #include <asm/arch-fsl-layerscape/soc.h>
 #include <spi_flash.h>
+#include <linux/string.h>
 
 #include "sl28.h"
 
diff --git a/board/kosagi/novena/novena.c b/board/kosagi/novena/novena.c
index f009a8afd48c..99a21f03a9cb 100644
--- a/board/kosagi/novena/novena.c
+++ b/board/kosagi/novena/novena.c
@@ -39,6 +39,7 @@
 #include <malloc.h>
 #include <mmc.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include <stdio_dev.h>
diff --git a/board/liebherr/display5/display5.c b/board/liebherr/display5/display5.c
index e3a59dbec009..7a061595f25f 100644
--- a/board/liebherr/display5/display5.c
+++ b/board/liebherr/display5/display5.c
@@ -27,6 +27,7 @@
 #include <netdev.h>
 #include <i2c.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <dm/platform_data/serial_mxc.h>
 #include <dm/platdata.h>
diff --git a/board/liebherr/display5/spl.c b/board/liebherr/display5/spl.c
index 97928e92215c..4126ed3d0e07 100644
--- a/board/liebherr/display5/spl.c
+++ b/board/liebherr/display5/spl.c
@@ -19,6 +19,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/mx6-ddr.h>
 #include <asm/arch/mx6-pins.h>
+#include <linux/string.h>
 #include "asm/arch/crm_regs.h"
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/liebherr/mccmon6/spl.c b/board/liebherr/mccmon6/spl.c
index b1f6881275d5..2222bbca6308 100644
--- a/board/liebherr/mccmon6/spl.c
+++ b/board/liebherr/mccmon6/spl.c
@@ -23,6 +23,7 @@
 #include <serial.h>
 #include <spl.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/arch/mx6-ddr.h>
 /*
diff --git a/board/mediatek/mt7623/mt7623_rfb.c b/board/mediatek/mt7623/mt7623_rfb.c
index ec10f77c51e4..84b073e47c5d 100644
--- a/board/mediatek/mt7623/mt7623_rfb.c
+++ b/board/mediatek/mt7623/mt7623_rfb.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <mmc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/menlo/m53menlo/m53menlo.c b/board/menlo/m53menlo/m53menlo.c
index b8dffb0e4858..cf582a9be4bf 100644
--- a/board/menlo/m53menlo/m53menlo.c
+++ b/board/menlo/m53menlo/m53menlo.c
@@ -35,6 +35,7 @@
 #include <netdev.h>
 #include <spl.h>
 #include <splash.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 #include <video_console.h>
 
diff --git a/board/mntre/imx8mq_reform2/spl.c b/board/mntre/imx8mq_reform2/spl.c
index 5120c628b91a..93c3f3dbd331 100644
--- a/board/mntre/imx8mq_reform2/spl.c
+++ b/board/mntre/imx8mq_reform2/spl.c
@@ -25,6 +25,7 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <spl.h>
 
diff --git a/board/mscc/jr2/jr2.c b/board/mscc/jr2/jr2.c
index 84b95be648d7..6ab2d0112589 100644
--- a/board/mscc/jr2/jr2.c
+++ b/board/mscc/jr2/jr2.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 enum {
 	BOARD_TYPE_PCB110 = 0xAABBCE00,
diff --git a/board/mscc/luton/luton.c b/board/mscc/luton/luton.c
index 48170b3aa12d..499c259dcaa7 100644
--- a/board/mscc/luton/luton.c
+++ b/board/mscc/luton/luton.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <led.h>
 #include <miiphy.h>
+#include <linux/string.h>
 
 enum {
 	BOARD_TYPE_PCB090 = 0xAABBCD00,
diff --git a/board/mscc/ocelot/ocelot.c b/board/mscc/ocelot/ocelot.c
index d69db04de664..1f42fe147dcd 100644
--- a/board/mscc/ocelot/ocelot.c
+++ b/board/mscc/ocelot/ocelot.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/mscc/serval/serval.c b/board/mscc/serval/serval.c
index 99d5f5be657e..cce82907d97a 100644
--- a/board/mscc/serval/serval.c
+++ b/board/mscc/serval/serval.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <led.h>
 #include <miiphy.h>
+#include <linux/string.h>
 
 enum {
 	BOARD_TYPE_PCB106 = 0xAABBCD00,
diff --git a/board/mscc/servalt/servalt.c b/board/mscc/servalt/servalt.c
index 49993168c237..2d0fee55e723 100644
--- a/board/mscc/servalt/servalt.c
+++ b/board/mscc/servalt/servalt.c
@@ -9,6 +9,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <led.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/nokia/rx51/rx51.c b/board/nokia/rx51/rx51.c
index ca3bc5133d45..d9a9b1a374ee 100644
--- a/board/nokia/rx51/rx51.c
+++ b/board/nokia/rx51/rx51.c
@@ -43,6 +43,7 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mmc_host_def.h>
+#include <linux/string.h>
 
 #include "tag_omap.h"
 
diff --git a/board/phytec/pcm058/pcm058.c b/board/phytec/pcm058/pcm058.c
index b37c6fe218da..b69f7006ac52 100644
--- a/board/phytec/pcm058/pcm058.c
+++ b/board/phytec/pcm058/pcm058.c
@@ -19,6 +19,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/sections.h>
 #include <dm.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
index 690a51f7a72e..2773323d42da 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -17,6 +17,7 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/phytium/pomelo/pcie.c b/board/phytium/pomelo/pcie.c
index 698d82fd8d56..05c63edda0cd 100644
--- a/board/phytium/pomelo/pcie.c
+++ b/board/phytium/pomelo/pcie.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <linux/arm-smccc.h>
 #include <init.h>
+#include <linux/string.h>
 #include "cpu.h"
 
 struct pcu_ctr {
diff --git a/board/phytium/pomelo/pll.c b/board/phytium/pomelo/pll.c
index a66ffddf094b..439924dd2fc0 100644
--- a/board/phytium/pomelo/pll.c
+++ b/board/phytium/pomelo/pll.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <linux/arm-smccc.h>
 #include <init.h>
+#include <linux/string.h>
 #include "cpu.h"
 
 struct pll_config {
diff --git a/board/phytium/pomelo/sec.c b/board/phytium/pomelo/sec.c
index aeb3983f0130..bb663c6aa577 100644
--- a/board/phytium/pomelo/sec.c
+++ b/board/phytium/pomelo/sec.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <linux/arm-smccc.h>
 #include <init.h>
+#include <linux/string.h>
 #include "cpu.h"
 
 struct common_config {
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 371b3262f8c5..9b1307b8e6d5 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -19,6 +19,7 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/misc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 939b48ee300b..9a7be8aba0c9 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -29,6 +29,7 @@
 #include <asm/arch/sh_sdhi.h>
 #include <i2c.h>
 #include <mmc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/renesas/stout/cpld.c b/board/renesas/stout/cpld.c
index b7c75f5aa65e..4b2466cbf09c 100644
--- a/board/renesas/stout/cpld.c
+++ b/board/renesas/stout/cpld.c
@@ -12,6 +12,7 @@
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 #include "cpld.h"
 
 #define SCLK			(92 + 24)
diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
index 0c060a5323d8..d37f13560c31 100644
--- a/board/renesas/ulcb/cpld.c
+++ b/board/renesas/ulcb/cpld.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <linux/err.h>
 #include <sysreset.h>
+#include <linux/string.h>
 
 #define CPLD_ADDR_MODE		0x00 /* RW */
 #define CPLD_ADDR_MUX		0x02 /* RW */
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 1477750f9217..b7daa3af24d6 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -27,6 +27,7 @@
 #include <asm/arch/sh_sdhi.h>
 #include <i2c.h>
 #include <mmc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/renesas/v3hsk/cpld.c b/board/renesas/v3hsk/cpld.c
index 6016f6daef95..29009152deb7 100644
--- a/board/renesas/v3hsk/cpld.c
+++ b/board/renesas/v3hsk/cpld.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <sysreset.h>
 #include <command.h>
+#include <linux/string.h>
 
 #define CPLD_ADDR_PRODUCT_0		0x0000 /* R */
 #define CPLD_ADDR_PRODUCT_1		0x0001 /* R */
diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
index aed616ac8598..76e6484fc75a 100644
--- a/board/renesas/v3msk/cpld.c
+++ b/board/renesas/v3msk/cpld.c
@@ -16,6 +16,7 @@
 #include <sysreset.h>
 #include <linux/delay.h>
 #include <command.h>
+#include <linux/string.h>
 
 #define CPLD_ADDR_PRODUCT_L		0x000 /* R */
 #define CPLD_ADDR_PRODUCT_H		0x001 /* R */
diff --git a/board/ronetix/imx7-cm/spl.c b/board/ronetix/imx7-cm/spl.c
index b94cfd6ffc67..762134cf4ec6 100644
--- a/board/ronetix/imx7-cm/spl.c
+++ b/board/ronetix/imx7-cm/spl.c
@@ -19,6 +19,7 @@
 #include <asm/sections.h>
 #include <fsl_esdhc_imx.h>
 #include <spl.h>
+#include <linux/string.h>
 
 static struct ddrc ddrc_regs_val = {
 	.mstr		= 0x01040001,
diff --git a/board/ronetix/imx8mq-cm/spl.c b/board/ronetix/imx8mq-cm/spl.c
index 1c675bcab25a..9d0579f58a83 100644
--- a/board/ronetix/imx8mq-cm/spl.c
+++ b/board/ronetix/imx8mq-cm/spl.c
@@ -17,6 +17,7 @@
 #include <fsl_esdhc_imx.h>
 #include <linux/delay.h>
 #include <spl.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/samsung/common/gadget.c b/board/samsung/common/gadget.c
index 9487f9ec4e0c..6633028b5de2 100644
--- a/board/samsung/common/gadget.c
+++ b/board/samsung/common/gadget.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 
 #define EXYNOS_G_DNL_THOR_VENDOR_NUM	0x04E8
diff --git a/board/samsung/origen/tools/mkorigenspl.c b/board/samsung/origen/tools/mkorigenspl.c
index f4be86724503..8f13d26db333 100644
--- a/board/samsung/origen/tools/mkorigenspl.c
+++ b/board/samsung/origen/tools/mkorigenspl.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
+#include <linux/string.h>
 #include <sys/stat.h>
 
 #define BUFSIZE			(16*1024)
diff --git a/board/samsung/smdkv310/tools/mksmdkv310spl.c b/board/samsung/smdkv310/tools/mksmdkv310spl.c
index 378b85d72294..e76c9412f7b5 100644
--- a/board/samsung/smdkv310/tools/mksmdkv310spl.c
+++ b/board/samsung/smdkv310/tools/mksmdkv310spl.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
+#include <linux/string.h>
 #include <sys/stat.h>
 
 #define CHECKSUM_OFFSET		(14*1024-4)
diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 924c88e8fab3..97ac6c52bc39 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -28,6 +28,7 @@
 #include <asm/arch-imx8/clock.h>
 #endif
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "../common/factoryset.h"
 
 #define GPIO_PAD_CTRL \
diff --git a/board/siemens/capricorn/spl.c b/board/siemens/capricorn/spl.c
index e160c611a962..c45c73531ef4 100644
--- a/board/siemens/capricorn/spl.c
+++ b/board/siemens/capricorn/spl.c
@@ -15,6 +15,7 @@
 #include <dm/device.h>
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index 8fa9197a6dfb..c792525c4dbf 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -34,6 +34,7 @@
 #include <cpsw.h>
 #include <watchdog.h>
 #include <asm/mach-types.h>
+#include <linux/string.h>
 #include "../common/factoryset.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 4e36a6f31990..6a228c4a618c 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  *
+#include <linux/string.h>
  * Read FactorySet information from EEPROM into global structure.
  * (C) Copyright 2013 Siemens Schweiz AG
  */
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 15f5310c7bf3..849a7446982c 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -24,6 +24,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define IOT2050_INFO_MAGIC		0x20502050
 
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 47f19bcb8fd9..23a16123326c 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -35,6 +35,7 @@
 #include <miiphy.h>
 #include <cpsw.h>
 #include <watchdog.h>
+#include <linux/string.h>
 #include "board.h"
 #include "../common/factoryset.h"
 #include "pmic.h"
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index a8b196a65c9a..68f6cad31a22 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -35,6 +35,7 @@
 #include <video.h>
 #include <watchdog.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "board.h"
 #include "../common/factoryset.h"
 
diff --git a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
index 2b985b9b228e..96808e5d5b25 100644
--- a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
+++ b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #ifndef CONFIG_SYS_EEPROM_BUS_NUM
diff --git a/board/socionext/developerbox/fwu_plat.c b/board/socionext/developerbox/fwu_plat.c
index e724e702bdc7..ef4c647d7692 100644
--- a/board/socionext/developerbox/fwu_plat.c
+++ b/board/socionext/developerbox/fwu_plat.c
@@ -8,6 +8,7 @@
 #include <fwu_mdata.h>
 #include <memalign.h>
 #include <mtd.h>
+#include <linux/string.h>
 
 #define DFU_ALT_BUF_LEN 256
 
diff --git a/board/softing/vining_2000/vining_2000.c b/board/softing/vining_2000/vining_2000.c
index 4483bd7f7a38..37b5de21d47e 100644
--- a/board/softing/vining_2000/vining_2000.c
+++ b/board/softing/vining_2000/vining_2000.c
@@ -30,6 +30,7 @@
 #include <i2c.h>
 #include <miiphy.h>
 #include <netdev.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 #include <usb.h>
diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index b3f9550742ec..d7b73175b828 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -15,6 +15,7 @@
 #include <asm/gpio.h>
 #include <i2c.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 6edb42215511..b9635def805a 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -17,6 +17,7 @@
 #include <asm/arch/soc.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "../common/tlv_data.h"
 
 #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
diff --git a/board/solidrun/common/tlv_data.c b/board/solidrun/common/tlv_data.c
index 11d6e4a13807..1daf14812ef7 100644
--- a/board/solidrun/common/tlv_data.c
+++ b/board/solidrun/common/tlv_data.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <compiler.h>
 #include <tlv_eeprom.h>
+#include <linux/string.h>
 #include "tlv_data.h"
 
 #define SR_TLV_CODE_RAM_SIZE	0x81
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index e119330bc0c1..ffd64e64dff8 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -41,6 +41,7 @@
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
 #include <usb.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 #include <netdev.h>
 #include <phy.h>
diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index 853ab78bbf16..e6783b152819 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -37,6 +37,7 @@
 #include <asm/arch/bsec.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 static bool check_stboard(u16 board)
 {
diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index faee953cd4bb..f512883d1628 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -15,6 +15,7 @@
 #include <mtd_node.h>
 #include <asm/arch/stm32prog.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define DFU_ALT_BUF_LEN SZ_1K
 
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 8f5719c28b33..d5242e1cb6bf 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -45,6 +45,7 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <usb/dwc2_udc.h>
 
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index befe7888c400..37b43f648086 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -9,6 +9,7 @@
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <linux/delay.h>
 
diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 060d562cbc90..428f2067d498 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -11,6 +11,7 @@
 #include <asm/global_data.h>
 #include <asm/setup.h>
 #include <asm/system.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ebaa94319846..27e1948e0d5f 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -39,6 +39,7 @@
 #endif
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <env_internal.h>
 #include <linux/libfdt.h>
diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
index cde04bebe963..b0ce6ecfb04f 100644
--- a/board/sunxi/chip.c
+++ b/board/sunxi/chip.c
@@ -11,6 +11,7 @@
 #include <w1.h>
 #include <w1-eeprom.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 #include <asm/arch/gpio.h>
 
diff --git a/board/synopsys/emsdp/emsdp.c b/board/synopsys/emsdp/emsdp.c
index a3cee23411d0..380506afe9ad 100644
--- a/board/synopsys/emsdp/emsdp.c
+++ b/board/synopsys/emsdp/emsdp.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #include <asm/arcregs.h>
 
diff --git a/board/synopsys/hsdk/hsdk.c b/board/synopsys/hsdk/hsdk.c
index 6cbc89ae7874..384dc3adc66a 100644
--- a/board/synopsys/hsdk/hsdk.c
+++ b/board/synopsys/hsdk/hsdk.c
@@ -25,6 +25,7 @@
 #include <dwmmc.h>
 #include <malloc.h>
 #include <usb.h>
+#include <linux/string.h>
 
 #include "clk-lib.h"
 #include "env-lib.h"
diff --git a/board/technexion/pico-imx6/spl.c b/board/technexion/pico-imx6/spl.c
index 3b36bb8df131..7b6cdd6c3b16 100644
--- a/board/technexion/pico-imx6/spl.c
+++ b/board/technexion/pico-imx6/spl.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_SPL_BUILD)
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/technexion/pico-imx6ul/spl.c b/board/technexion/pico-imx6ul/spl.c
index ff56fd88d68e..04d6234fdfb1 100644
--- a/board/technexion/pico-imx6ul/spl.c
+++ b/board/technexion/pico-imx6ul/spl.c
@@ -18,6 +18,7 @@
 #include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_SPL_BUILD)
 
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index c6b21aaa42da..f8661b896d7d 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -19,6 +19,7 @@
 #include <asm/sections.h>
 #include <fsl_esdhc_imx.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_SPL_BUILD)
 
diff --git a/board/technexion/pico-imx8mq/spl.c b/board/technexion/pico-imx8mq/spl.c
index 1a9c7996cb2a..f6b5c7026b42 100644
--- a/board/technexion/pico-imx8mq/spl.c
+++ b/board/technexion/pico-imx8mq/spl.c
@@ -22,6 +22,7 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #include "lpddr4_timing.h"
 
diff --git a/board/theadorable/fpga.c b/board/theadorable/fpga.c
index 3a33e15eacc6..4cfc4bbf0acd 100644
--- a/board/theadorable/fpga.c
+++ b/board/theadorable/fpga.c
@@ -13,6 +13,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <asm/arch-mvebu/spi.h>
+#include <linux/string.h>
 #include "theadorable.h"
 
 /*
diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
index 614a60ee8f9f..ef1020078821 100644
--- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
+++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
@@ -12,6 +12,7 @@
 #include <misc.h>
 #include <spl.h>
 #include <syscon.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <usb.h>
 #include <dm/pinctrl.h>
diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
index bb1bb4acf5c4..908bbfcbac0b 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -12,6 +12,7 @@
 #include <misc.h>
 #include <spl.h>
 #include <syscon.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <usb.h>
 #include <dm/pinctrl.h>
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index ecb9fa02de58..33859b9bc8b4 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/tps65217.h>
 #include <power/tps65910.h>
 #include <env_internal.h>
diff --git a/board/ti/am335x/board.h b/board/ti/am335x/board.h
index c2962111c1ad..90b550517110 100644
--- a/board/ti/am335x/board.h
+++ b/board/ti/am335x/board.h
@@ -12,6 +12,7 @@
 
 /**
  * AM335X (EMIF_4D) EMIF REG_COS_COUNT_1, REG_COS_COUNT_2, and
+#include <linux/string.h>
  * REG_PR_OLD_COUNT values to avoid LCDC DMA FIFO underflows and Frame
  * Synchronization Lost errors. The values are the biggest that work
  * reliably with offered video modes and the memory subsystem on the
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 58bfe7cd455f..e65bab10756d 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -26,6 +26,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/emif.h>
 #include <asm/omap_common.h>
+#include <linux/string.h>
 #include "../common/board_detect.h"
 #include "board.h"
 #include <power/pmic.h>
diff --git a/board/ti/am43xx/board.h b/board/ti/am43xx/board.h
index 06b737445d44..e28813f4bb80 100644
--- a/board/ti/am43xx/board.h
+++ b/board/ti/am43xx/board.h
@@ -12,6 +12,7 @@
 #define _BOARD_H_
 
 #include <asm/arch/omap.h>
+#include <linux/string.h>
 
 #define DEV_ATTR_MAX_OFFSET    5
 #define DEV_ATTR_MIN_OFFSET    0
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index 9ea507a8e961..17b08e0a9201 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -32,6 +32,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/omap.h>
 #include <usb.h>
+#include <linux/string.h>
 #include <linux/usb/gadget.h>
 #include <dwc3-uboot.h>
 #include <dwc3-omap-uboot.h>
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index a080b2b0d258..d403dfec3caa 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -15,6 +15,7 @@
 #include <fdt_support.h>
 #include <asm/arch/hardware.h>
 #include <env.h>
+#include <linux/string.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 8bb13ef5b2b3..82785bd871c8 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -21,6 +21,7 @@
 #include <env.h>
 #include <spl.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/ti/beagle/beagle.c b/board/ti/beagle/beagle.c
index 847d596646e3..ed4a2aabd2c7 100644
--- a/board/ti/beagle/beagle.c
+++ b/board/ti/beagle/beagle.c
@@ -35,6 +35,7 @@
 #include <asm/mach-types.h>
 #include <asm/omap_musb.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/musb.h>
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index ac39b25cd426..ea84f16998c0 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "board_detect.h"
 
diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index 2e6105cfbf15..50a1a9f17d75 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <i2c.h>
 #include <extension_board.h>
+#include <linux/string.h>
 
 #include "cape_detect.h"
 
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index d4f7c1d9f938..ff1ee6fa0473 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -23,6 +23,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 7795300abc80..b256c360b48f 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -22,6 +22,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index 5dcda12105b9..cda8a85f56ab 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "board.h"
 #include <env.h>
 #include <hang.h>
diff --git a/board/ti/ks2_evm/board_k2e.c b/board/ti/ks2_evm/board_k2e.c
index 39abb24e1560..b5258b66e102 100644
--- a/board/ti/ks2_evm/board_k2e.c
+++ b/board/ti/ks2_evm/board_k2e.c
@@ -12,6 +12,7 @@
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
+#include <linux/string.h>
 
 unsigned int get_external_clk(u32 clk)
 {
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index 5229afad63b0..cfbb2fded588 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -20,6 +20,7 @@
 #include <remoteproc.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "mux-k2g.h"
 #include "../common/board_detect.h"
 
diff --git a/board/ti/ks2_evm/board_k2hk.c b/board/ti/ks2_evm/board_k2hk.c
index 12c4649c3c4c..6a9935c7ef5c 100644
--- a/board/ti/ks2_evm/board_k2hk.c
+++ b/board/ti/ks2_evm/board_k2hk.c
@@ -12,6 +12,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
+#include <linux/string.h>
 
 unsigned int external_clk[ext_clk_count] = {
 	[sys_clk]	=	122880000,
diff --git a/board/ti/ks2_evm/board_k2l.c b/board/ti/ks2_evm/board_k2l.c
index f759ee364666..459530ecb9de 100644
--- a/board/ti/ks2_evm/board_k2l.c
+++ b/board/ti/ks2_evm/board_k2l.c
@@ -12,6 +12,7 @@
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
+#include <linux/string.h>
 
 unsigned int get_external_clk(u32 clk)
 {
diff --git a/board/ti/sdp4430/cmd_bat.c b/board/ti/sdp4430/cmd_bat.c
index 6c1e6ca393c6..2b8f4bc69de2 100644
--- a/board/ti/sdp4430/cmd_bat.c
+++ b/board/ti/sdp4430/cmd_bat.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_CMD_BAT
 #include <twl6030.h>
diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index 851343159186..173e240843a5 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -18,6 +18,7 @@
 #include <pci_tegra.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/as3722.h>
 #include <power/pmic.h>
 
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index fa6b7226fedf..6ab62ef1a584 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <ahci.h>
 #include <asm/arch/clock.h>
diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index 6991b1bc136e..9ad925999379 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
+#include <linux/string.h>
 
 static int mfgr_fuse(void)
 {
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index e6c9b10570d1..01208f920f21 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index 6991b1bc136e..9ad925999379 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
+#include <linux/string.h>
 
 static int mfgr_fuse(void)
 {
diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 7187e1ba377f..ddeaf712896f 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "tdx-cfg-block.h"
 #include "tdx-eeprom.h"
 
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index d1449143977b..9192faecae92 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -8,6 +8,7 @@
 #include <g_dnl.h>
 #include <init.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_VIDEO
 #include <bmp_logo.h>
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index d09dda5bccc9..fbce8c1743fb 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -14,6 +14,7 @@
 #include <init.h>
 #include <k3-ddrss.h>
 #include <spl.h>
+#include <linux/string.h>
 
 #include "../common/tdx-cfg-block.h"
 
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index afa3686083a4..432b2ab5baf3 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -24,6 +24,7 @@
 #include <dm/uclass-internal.h>
 #include <hang.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include <power/pca9450.h>
 #include <power/pmic.h>
 #include <spl.h>
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 55c02653da68..a77228159a21 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -14,6 +14,7 @@
 #include <micrel.h>
 #include <miiphy.h>
 #include <netdev.h>
+#include <linux/string.h>
 
 #include "../common/tdx-cfg-block.h"
 
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index e16a771e3ec1..bc248e2b7288 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -18,6 +18,7 @@
 #include <micrel.h>
 #include <miiphy.h>
 #include <netdev.h>
+#include <linux/string.h>
 
 #include "../common/tdx-cfg-block.h"
 
diff --git a/board/traverse/common/ten64_controller.c b/board/traverse/common/ten64_controller.c
index d6ef8a8d0df9..f652c3ed0d85 100644
--- a/board/traverse/common/ten64_controller.c
+++ b/board/traverse/common/ten64_controller.c
@@ -13,6 +13,7 @@
 #include <dm/device_compat.h>
 #include <inttypes.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ten64-controller.h"
 
diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index df9f0afe1a4f..de76f6e990a1 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -32,6 +32,7 @@
 #include <asm/arch/soc.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <nvme.h>
+#include <linux/string.h>
 
 #include <fsl_immap.h>
 
diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index 730e266469b2..2e75eb2c65d5 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 #include <common.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
 #include <malloc.h>
diff --git a/board/variscite/dart_6ul/spl.c b/board/variscite/dart_6ul/spl.c
index 1dff69c82771..b8c9c6dfc93c 100644
--- a/board/variscite/dart_6ul/spl.c
+++ b/board/variscite/dart_6ul/spl.c
@@ -14,6 +14,7 @@
 #include <asm/arch/crm_regs.h>
 #include <asm/sections.h>
 #include <fsl_esdhc_imx.h>
+#include <linux/string.h>
 
 #define UART_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |		\
 	PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED |		\
diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 61b9455a8f4e..b020e2748531 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/variscite/imx8mn_var_som/spl.c b/board/variscite/imx8mn_var_som/spl.c
index 01a63c69641f..166dd659102d 100644
--- a/board/variscite/imx8mn_var_som/spl.c
+++ b/board/variscite/imx8mn_var_som/spl.c
@@ -16,6 +16,7 @@
 #include <asm/sections.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index 8f23cda8e4fc..520980b11ca7 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -32,6 +32,7 @@
 #include <i2c.h>
 #include <miiphy.h>
 #include <cpsw.h>
+#include <linux/string.h>
 #include <power/tps65910.h>
 #include <watchdog.h>
 #include "board.h"
diff --git a/board/wandboard/wandboard.c b/board/wandboard/wandboard.c
index 48914450a294..f46d5eedc4a5 100644
--- a/board/wandboard/wandboard.c
+++ b/board/wandboard/wandboard.c
@@ -33,6 +33,7 @@
 #include <netdev.h>
 #include <phy.h>
 #include <i2c.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 
diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
index 5f625e6f52ad..84fa6bab2f81 100644
--- a/board/work-microwave/work_92105/work_92105_display.c
+++ b/board/work-microwave/work_92105/work_92105_display.c
@@ -24,6 +24,7 @@
 #include <version.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /*
  * GPO 15 in port 3 is gpio 3*32+15 = 111
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9309b071269f..94c9bc7d70fd 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -20,6 +20,7 @@
 #include <i2c.h>
 #include <linux/sizes.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include "board.h"
 #include <dm.h>
 #include <i2c_eeprom.h>
diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
index 167252c240cd..b5625313ec0d 100644
--- a/board/xilinx/common/fru_ops.c
+++ b/board/xilinx/common/fru_ops.c
@@ -13,6 +13,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 
 #include "fru.h"
 
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index c18be0c26c99..3d897a3db32c 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -21,6 +21,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 #include "../common/board.h"
 
 #include <linux/bitfield.h>
diff --git a/board/xilinx/versal-net/cmds.c b/board/xilinx/versal-net/cmds.c
index b18a71fe52c0..02546e5ef993 100644
--- a/board/xilinx/versal-net/cmds.c
+++ b/board/xilinx/versal-net/cmds.c
@@ -12,6 +12,7 @@
 #include <memalign.h>
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
+#include <linux/string.h>
 
 /**
  * do_versalnet_load_pdi - Handle the "versalnet load pdi" command-line command
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index e4bdd5d7a38b..ee53a8836aff 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -22,6 +22,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
+#include <linux/string.h>
 #include "../common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
index 148fa51266d2..b9c4b604da05 100644
--- a/board/xilinx/versal/cmds.c
+++ b/board/xilinx/versal/cmds.c
@@ -11,6 +11,7 @@
 #include <memalign.h>
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
+#include <linux/string.h>
 
 static int do_versal_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
 			      char * const argv[])
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 3b6581e30462..9d4d09a6eebf 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -23,6 +23,7 @@
 #include <asm/global_data.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 #include "../common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 2f55078dd768..1a9d3ed3ec5e 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/string.h>
 #include <u-boot/md5.h>
 #include <zynq_bootimg.h>
 
diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 024fac65f304..6075586f76ca 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -12,6 +12,7 @@
 #include <asm/arch/sys_proto.h>
 #include <malloc.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <u-boot/md5.h>
 #include <u-boot/rsa.h>
 #include <u-boot/rsa-mod-exp.h>
diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
index fadb0edb24fb..3bb4e8de8321 100644
--- a/board/xilinx/zynqmp/cmds.c
+++ b/board/xilinx/zynqmp/cmds.c
@@ -14,6 +14,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <mach/zynqmp_aes.h>
 
 static int do_zynqmp_verify_secure(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f16280308483..2957bb219366 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include "../common/board.h"
 
 #include "pm_cfg_obj.h"
diff --git a/boot/android_ab.c b/boot/android_ab.c
index 0f20a34e5110..d245a38f40ab 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -11,6 +11,7 @@
 #include <part.h>
 #include <memalign.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /**
diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 974ddee5d2fa..a31bb2946edf 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -20,6 +20,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 enum {
 	/*
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 6ef62e1d1896..633a94105a97 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -17,6 +17,7 @@
 #include <serial.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /* error codes used to signal running out of things */
 enum {
diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 7c1abe5772cd..ebf01a91d8bf 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -19,6 +19,7 @@
 #include <video_console.h>
 #include <watchdog.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "bootflow_internal.h"
 
 /**
diff --git a/boot/bootm.c b/boot/bootm.c
index b1c3afe0a3ad..b9f7bb723457 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -25,6 +25,7 @@
 #if defined(CONFIG_CMD_USB)
 #include <usb.h>
 #endif
+#include <linux/string.h>
 #else
 #include "mkimage.h"
 #endif
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 9c035b5be886..a30437334f2b 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <vxworks.h>
+#include <linux/string.h>
 #include <tee/optee.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 1d157d54dbdd..4dc407e8f49b 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 20e0b1e89c36..d91bbf70e19e 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -21,6 +21,7 @@
 #include <mapmem.h>
 #include <part.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include "bootmeth_cros.h"
 
 static const efi_guid_t cros_kern_type = PARTITION_CROS_KERNEL;
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa18..a0e3e31d39b3 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -22,6 +22,7 @@
 #include <net.h>
 #include <pxe_utils.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #define EFI_DIRNAME	"efi/boot/"
 
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index aa2a4591ebd7..90201d11f532 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -21,6 +21,7 @@
 #include <mapmem.h>
 #include <mmc.h>
 #include <pxe_utils.h>
+#include <linux/string.h>
 
 static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 8d489a11aa40..107b189e6834 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -22,6 +22,7 @@
 #include <mmc.h>
 #include <net.h>
 #include <pxe_utils.h>
+#include <linux/string.h>
 
 static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
 				char *file_addr, ulong *sizep)
diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
index 8ebbc3ebcd58..4521210baea0 100644
--- a/boot/bootmeth_qfw.c
+++ b/boot/bootmeth_qfw.c
@@ -16,6 +16,7 @@
 #include <env.h>
 #include <qfw.h>
 #include <dm.h>
+#include <linux/string.h>
 
 static int qfw_check(struct udevice *dev, struct bootflow_iter *iter)
 {
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 58c57a2d4b5b..8470f6ac870e 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -20,6 +20,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <net.h>
+#include <linux/string.h>
 
 #define SCRIPT_FNAME1	"boot.scr.uimg"
 #define SCRIPT_FNAME2	"boot.scr"
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 81555d341e32..34a13ba02d58 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -17,6 +17,7 @@
 #include <dm/lists.h>
 #include <dm/read.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/boot/common_fit.c b/boot/common_fit.c
index cde2dc45e907..2e2ecb117e08 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -9,6 +9,7 @@
 #include <image.h>
 #include <log.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 ulong fdt_getprop_u32(const void *fdt, int node, const char *prop)
 {
diff --git a/boot/expo.c b/boot/expo.c
index 139d684f8e6e..00f1d4eaf9a1 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -13,6 +13,7 @@
 #include <expo.h>
 #include <malloc.h>
 #include <video.h>
+#include <linux/string.h>
 #include "scene_internal.h"
 
 int expo_new(const char *name, void *priv, struct expo **expp)
diff --git a/boot/expo_build.c b/boot/expo_build.c
index bb33cc2a33f4..53639922c566 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <dm/ofnode.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 /**
  * struct build_info - Information to use when building
diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91c..863fbcea9b43 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -8,6 +8,7 @@
 #include <fdt_support.h>
 #include <linux/libfdt_env.h>
 #include <fdt_region.h>
+#include <linux/string.h>
 
 #ifndef USE_HOSTCC
 #include <fdt.h>
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 5e49078f8c35..307fd92f9f22 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -15,6 +15,7 @@
 #include <stdio_dev.h>
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
diff --git a/boot/image-android.c b/boot/image-android.c
index 88e40bc7ec6c..447fd445c28e 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -13,6 +13,7 @@
 #include <asm/unaligned.h>
 #include <mapmem.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #define ANDROID_IMAGE_DEFAULT_KERNEL_ADDR	0x10008000
 
diff --git a/boot/image-board.c b/boot/image-board.c
index d500da1b4b91..840672e27b3c 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -22,6 +22,7 @@
 #include <watchdog.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index b9061489396c..70147fb8f0b6 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSdTCC*/
 #include <image.h>
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f10200f64743..89c945f6db39 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -22,6 +22,7 @@
 #include <mapmem.h>
 #include <asm/io.h>
 #include <dm/ofnode.h>
+#include <linux/string.h>
 #include <tee/optee.h>
 
 /* adding a ramdisk needs 0x44 bytes in version 2008.10 */
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 12369896fe3f..5e2cf0619e16 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 #include <fdt_region.h>
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3cc556b727f5..4efe29b8100d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -30,6 +30,7 @@
 #include <dm.h>
 #include <u-boot/hash.h>
 #endif
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 
diff --git a/boot/image-host.c b/boot/image-host.c
index 20a9521948b1..4f3b28604027 100644
--- a/boot/image-host.c
+++ b/boot/image-host.c
@@ -9,6 +9,7 @@
  */
 
 #include <time.h>
+#include <linux/string.h>
 
 void memmove_wd(void *to, void *from, size_t len, ulong chunksz)
 {
diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index b504ab42a544..21eab96f942e 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <mapmem.h>
diff --git a/boot/image-sig.c b/boot/image-sig.c
index b5692d58b24b..d8594de62011 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -7,6 +7,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <relocate.h>
diff --git a/boot/image.c b/boot/image.c
index 88b67bc3a199..4e6caf953f61 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -14,6 +14,7 @@
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #ifdef CONFIG_SHOW_BOOT_PROGRESS
diff --git a/boot/scene.c b/boot/scene.c
index 6c52948eb69c..883dab7cf610 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -17,6 +17,7 @@
 #include <video.h>
 #include <video_console.h>
 #include <linux/input.h>
+#include <linux/string.h>
 #include "scene_internal.h"
 
 int scene_new(struct expo *exp, const char *name, uint id, struct scene **scnp)
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index e0dcd0a4e041..7aa8802f5044 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -17,6 +17,7 @@
 #include <video.h>
 #include <video_console.h>
 #include <linux/input.h>
+#include <linux/string.h>
 #include "scene_internal.h"
 
 static void scene_menuitem_destroy(struct scene_menitem *item)
diff --git a/boot/vbe.c b/boot/vbe.c
index 52b328300374..8dadb399749f 100644
--- a/boot/vbe.c
+++ b/boot/vbe.c
@@ -13,6 +13,7 @@
 #include <image.h>
 #include <vbe.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /**
  * is_vbe() - Check if a device is a VBE method
diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 2f218d4bf97c..c4609e7465da 100644
--- a/boot/vbe_request.c
+++ b/boot/vbe_request.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <rng.h>
 #include <dm/ofnode.h>
+#include <linux/string.h>
 
 #define VBE_PREFIX		"vbe,"
 #define VBE_PREFIX_LEN		(sizeof(VBE_PREFIX) - 1)
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index 12682abd3996..b828c8096896 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -19,6 +19,7 @@
 #include <vbe.h>
 #include <dm/device-internal.h>
 #include <dm/ofnode.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include "vbe_simple.h"
 
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index d59a704ddbad..77181f03f29d 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -23,6 +23,7 @@
 #include <spl.h>
 #include <vbe.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include "vbe_simple.h"
 
 /**
diff --git a/boot/vbe_simple_os.c b/boot/vbe_simple_os.c
index 3285e438a568..30b5e56de7be 100644
--- a/boot/vbe_simple_os.c
+++ b/boot/vbe_simple_os.c
@@ -14,6 +14,7 @@
 #include <vbe.h>
 #include <version_string.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include "vbe_simple.h"
 
 int vbe_simple_fixup_node(ofnode node, struct simple_state *state)
diff --git a/cmd/2048.c b/cmd/2048.c
index fa60aa94aad8..337b80a72ef4 100644
--- a/cmd/2048.c
+++ b/cmd/2048.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <rand.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define SIZE 4
 static uint score;
diff --git a/cmd/ab_select.c b/cmd/ab_select.c
index bfb67b8236b6..c3608914dc6e 100644
--- a/cmd/ab_select.c
+++ b/cmd/ab_select.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <env.h>
 #include <part.h>
+#include <linux/string.h>
 
 static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 2653b555b10a..748718e0b10f 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <image.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 #define abootimg_addr() \
 	(_abootimg_addr == -1 ? image_load_addr : _abootimg_addr)
diff --git a/cmd/acpi.c b/cmd/acpi.c
index ede9c8c7dcb4..0d9cb784655a 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -11,6 +11,7 @@
 #include <asm/acpi_table.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/adtimg.c b/cmd/adtimg.c
index f4b5cbf35b97..aa5be9d9dce3 100644
--- a/cmd/adtimg.c
+++ b/cmd/adtimg.c
@@ -9,6 +9,7 @@
 #include <env.h>
 #include <image-android-dt.h>
 #include <common.h>
+#include <linux/string.h>
 
 #define OPT_INDEX	"--index"
 
diff --git a/cmd/aes.c b/cmd/aes.c
index 1936518824a1..b12f5eaed051 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -12,6 +12,7 @@
 #include <asm/byteorder.h>
 #include <linux/compiler.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 u32 aes_get_key_len(char *command)
 {
diff --git a/cmd/armflash.c b/cmd/armflash.c
index d1466f73aa41..f708c1f6c707 100644
--- a/cmd/armflash.c
+++ b/cmd/armflash.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <flash.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define MAX_REGIONS 4
 #define MAX_IMAGES 32
diff --git a/cmd/avb.c b/cmd/avb.c
index 783f51b81690..8f680b45a146 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -11,6 +11,7 @@
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
+#include <linux/string.h>
 
 #define AVB_BOOTARGS	"avb_bootargs"
 static struct AvbOps *avb_ops;
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 02d0c70d87e2..5866165d6cff 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 enum bcb_cmd {
 	BCB_CMD_LOAD,
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 1fe13ca13a0a..62355ccd952c 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <display_options.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/binop.c b/cmd/binop.c
index 592e9146901b..9e64b0e97db3 100644
--- a/cmd/binop.c
+++ b/cmd/binop.c
@@ -7,6 +7,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 enum {
 	OP_ID_XOR,
diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 9f9d4327a996..8d6f3e0419c8 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -12,6 +12,7 @@
 #include <blk.h>
 #include <command.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 		   int *cur_devnump)
diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index b34c01307284..f40c3bb886e4 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <malloc.h>
 #include <dm/device.h>
+#include <linux/string.h>
 
 static int blkmap_curr_dev;
 
diff --git a/cmd/blob.c b/cmd/blob.c
index 7c77c410d528..b36df41c0fbe 100644
--- a/cmd/blob.c
+++ b/cmd/blob.c
@@ -14,6 +14,7 @@
 #include <fsl_sec.h>
 #include <asm/arch/clock.h>
 #endif
+#include <linux/string.h>
 
 /**
  * blob_decap() - Decapsulate the data as a blob
diff --git a/cmd/bmp.c b/cmd/bmp.c
index 8f43a40dafdd..5d6c01f75044 100644
--- a/cmd/bmp.c
+++ b/cmd/bmp.c
@@ -15,6 +15,7 @@
 #include <splash.h>
 #include <video.h>
 #include <stdlib.h>
+#include <linux/string.h>
 
 static int do_bmp_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index a657de6bd0f6..ea27f16b6628 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static int bootdev_check_state(struct bootstd_priv **stdp)
 {
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index f73d6eb0e2d8..7785c93eb458 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -26,6 +26,7 @@
 #include <memalign.h>
 #include <asm-generic/sections.h>
 #include <linux/linkage.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 300ad3aaa760..94dee25d4c8e 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -15,6 +15,7 @@
 #include <console.h>
 #include <dm.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 /**
  * report_bootflow_err() - Report where a bootflow failed
diff --git a/cmd/booti.c b/cmd/booti.c
index 6ac39193db80..f83a1e7cce93 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 /*
diff --git a/cmd/bootmeth.c b/cmd/bootmeth.c
index 9fbcccdba7ef..4ca10b39c8e5 100644
--- a/cmd/bootmeth.c
+++ b/cmd/bootmeth.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <malloc.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static int do_bootmeth_list(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
diff --git a/cmd/bootstage.c b/cmd/bootstage.c
index 77a4bc66ff43..e1fd70881a61 100644
--- a/cmd/bootstage.c
+++ b/cmd/bootstage.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <bootstage.h>
 #include <command.h>
+#include <linux/string.h>
 
 static int do_bootstage_report(struct cmd_tbl *cmdtp, int flag, int argc,
 			       char *const argv[])
diff --git a/cmd/button.c b/cmd/button.c
index 1b45d0a2a035..4295d0135db5 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <button.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static const char *const state_label[] = {
 	[BUTTON_OFF]	= "off",
diff --git a/cmd/cache.c b/cmd/cache.c
index b68d45b98bf2..0ea2c6c033a8 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 static int parse_argv(const char *);
 
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 2ff284f4cde6..8db514d919c7 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -17,6 +17,7 @@
 #include <mapmem.h>
 #include <dm/ofnode.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 struct expo *cur_exp;
 
diff --git a/cmd/cros_ec.c b/cmd/cros_ec.c
index 90921cecf602..c94b6272e275 100644
--- a/cmd/cros_ec.c
+++ b/cmd/cros_ec.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /* Note: depends on enum ec_current_image */
 static const char * const ec_current_image_name[] = {"unknown", "RO", "RW"};
diff --git a/cmd/date.c b/cmd/date.c
index 4f98b470ca2e..9201ecc5e1f0 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -13,6 +13,7 @@
 #include <rtc.h>
 #include <i2c.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/dfu.c b/cmd/dfu.c
index d7bfb535dc68..9b138990a484 100644
--- a/cmd/dfu.c
+++ b/cmd/dfu.c
@@ -18,6 +18,7 @@
 #include <g_dnl.h>
 #include <usb.h>
 #include <net.h>
+#include <linux/string.h>
 
 static int do_dfu(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/dm.c b/cmd/dm.c
index 1aa86aab9c1c..a42fe1ece334 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <dm/root.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 static int do_dm_dump_driver_compat(struct cmd_tbl *cmdtp, int flag, int argc,
 				    char * const argv[])
diff --git a/cmd/echo.c b/cmd/echo.c
index fda844ee9d35..105e54d89c40 100644
--- a/cmd/echo.c
+++ b/cmd/echo.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 
 static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 0b6ca8c505fb..370048a6451c 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -26,6 +26,7 @@
 #include <i2c.h>
 #include <eeprom_layout.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #ifndef	I2C_RXTX_LEN
 #define I2C_RXTX_LEN	128
diff --git a/cmd/efi.c b/cmd/efi.c
index 6cd5361aca59..fa6c54ec10eb 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -14,6 +14,7 @@
 #include <sort.h>
 #include <uuid.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e6e8a0a488e7..c1c17d8590ea 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -20,6 +20,7 @@
 #include <watchdog.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static struct efi_simple_text_input_protocol *cin;
 const char *eficonfig_menu_desc =
diff --git a/cmd/eficonfig_sbkey.c b/cmd/eficonfig_sbkey.c
index caca27495e02..e962b3098dc5 100644
--- a/cmd/eficonfig_sbkey.c
+++ b/cmd/eficonfig_sbkey.c
@@ -16,6 +16,7 @@
 #include <efi_config.h>
 #include <efi_variable.h>
 #include <crypto/pkcs7_parser.h>
+#include <linux/string.h>
 
 struct eficonfig_sig_data {
 	struct efi_signature_list *esl;
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 0be3af3e7630..49fcf86547b9 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -23,6 +23,7 @@
 #include <search.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #define BS systab.boottime
 
diff --git a/cmd/elf.c b/cmd/elf.c
index b7b9f506a526..cb0ad2e3e655 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -19,6 +19,7 @@
 #include <asm/e820.h>
 #include <linux/linkage.h>
 #endif
+#include <linux/string.h>
 
 /* Allow ports to override the default behavior */
 static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
diff --git a/cmd/ethsw.c b/cmd/ethsw.c
index f8b8a798bf6a..8e2bd3dfa578 100644
--- a/cmd/ethsw.c
+++ b/cmd/ethsw.c
@@ -12,6 +12,7 @@
 #include <env_flags.h>
 #include <ethsw.h>
 #include <net.h>
+#include <linux/string.h>
 
 static const char *ethsw_name;
 
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 2b672d888c68..618f9fe8fa4f 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -13,6 +13,7 @@
 #include <mapmem.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 static LIST_HEAD(extension_list);
 
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index c3c19231c988..30e226974b3f 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -15,6 +15,7 @@
 #include <usb.h>
 #include <watchdog.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 
 static int do_fastboot_udp(int argc, char *const argv[],
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 2401ea8b44cb..2d9186de737a 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <image.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
diff --git a/cmd/flash.c b/cmd/flash.c
index f4f85ecc7a8e..14a70e7f159a 100644
--- a/cmd/flash.c
+++ b/cmd/flash.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <log.h>
 #include <uuid.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_CMD_MTDPARTS)
 #include <jffs2/jffs2.h>
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 8c64e957db0f..754bb42cd3f7 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -16,6 +16,7 @@
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 static long do_fpga_get_device(char *arg)
 {
diff --git a/cmd/fuse.c b/cmd/fuse.c
index 0676bb7a812f..ed77dc0f87d2 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -14,6 +14,7 @@
 #include <fuse.h>
 #include <mapmem.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 static int strtou32(const char *str, unsigned int base, u32 *result)
 {
diff --git a/cmd/gpio.c b/cmd/gpio.c
index f4565982ecd9..90e228fd0812 100644
--- a/cmd/gpio.c
+++ b/cmd/gpio.c
@@ -17,6 +17,7 @@
 #endif
 #include <asm/gpio.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 __weak int name_to_gpio(const char *name)
 {
diff --git a/cmd/gpt.c b/cmd/gpt.c
index d7e96529a693..efb0c424d360 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/sizes.h>
 #include <stdlib.h>
+#include <linux/string.h>
 
 static LIST_HEAD(disk_partitions);
 
diff --git a/cmd/hash.c b/cmd/hash.c
index e163cd677420..5b0d75f8662d 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <hash.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/host.c b/cmd/host.c
index fb1cb1fdd1ad..b619eed40d93 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -13,6 +13,7 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 static int do_host_load(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/cmd/i2c.c b/cmd/i2c.c
index f0a5fa2e741f..72f932fd55f4 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -78,6 +78,7 @@
 #include <asm/byteorder.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /* Display values from last command.
diff --git a/cmd/ide.c b/cmd/ide.c
index ddc87d3a0bb9..296d25c004d7 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 #include <ide.h>
 #include <ata.h>
diff --git a/cmd/irq.c b/cmd/irq.c
index 1d3e28cb3ce0..614fd942bc2a 100644
--- a/cmd/irq.c
+++ b/cmd/irq.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <command.h>
 #include <irq_func.h>
+#include <linux/string.h>
 
 static int do_interrupts(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
diff --git a/cmd/itest.c b/cmd/itest.c
index 74414cbdc4c6..2ff7c7d4fbf6 100644
--- a/cmd/itest.c
+++ b/cmd/itest.c
@@ -16,6 +16,7 @@
 #include <command.h>
 #include <env.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 
diff --git a/cmd/jffs2.c b/cmd/jffs2.c
index e00fcc202266..f40f70575ad0 100644
--- a/cmd/jffs2.c
+++ b/cmd/jffs2.c
@@ -83,6 +83,7 @@
 #include <linux/list.h>
 #include <linux/ctype.h>
 #include <cramfs/cramfs_fs.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_CMD_NAND)
 #include <linux/mtd/rawnand.h>
diff --git a/cmd/led.c b/cmd/led.c
index 48a02baf509d..53c4e32dc2e7 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <led.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 #define LED_TOGGLE LEDST_COUNT
 
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 5256255f052d..638e1a8a2c2b 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -13,6 +13,7 @@
 #include <config.h>
 #include <command.h>
 #include <status_led.h>
+#include <linux/string.h>
 
 struct led_tbl_s {
 	char		*string;	/* String for use in the command */
diff --git a/cmd/load.c b/cmd/load.c
index 2715cf5957ee..61d8792a56f0 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -27,6 +27,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/log.c b/cmd/log.c
index c377aee85c5e..aebcd041d315 100644
--- a/cmd/log.c
+++ b/cmd/log.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 static char log_fmt_chars[LOGF_COUNT] = "clFLfm";
 
diff --git a/cmd/mbr.c b/cmd/mbr.c
index ec99b662834e..d0e57c9c2a21 100644
--- a/cmd/mbr.c
+++ b/cmd/mbr.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <malloc.h>
 #include <part.h>
+#include <linux/string.h>
 
 /**
  * extract_val() - Extract a value from the key=value pair list
diff --git a/cmd/md5sum.c b/cmd/md5sum.c
index 0f0e1d3dd68e..ed345d3b5cf9 100644
--- a/cmd/md5sum.c
+++ b/cmd/md5sum.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <image.h>
 #include <mapmem.h>
+#include <linux/string.h>
 #include <u-boot/md5.h>
 #include <asm/io.h>
 
diff --git a/cmd/mdio.c b/cmd/mdio.c
index 3c74326161ef..4624428d9adc 100644
--- a/cmd/mdio.c
+++ b/cmd/mdio.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <miiphy.h>
 #include <phy.h>
+#include <linux/string.h>
 
 static char last_op[2];
 static uint last_data;
diff --git a/cmd/mem.c b/cmd/mem.c
index d0abf71f2333..f761fb5968da 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -32,6 +32,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/mii.c b/cmd/mii.c
index fab420ee29e2..41cdd0e7c773 100644
--- a/cmd/mii.c
+++ b/cmd/mii.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <dm.h>
 #include <miiphy.h>
+#include <linux/string.h>
 
 typedef struct _MII_field_desc_t {
 	ushort hi;
diff --git a/cmd/mmc.c b/cmd/mmc.c
index c6bd81cebbce..233c49b2ddfe 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -14,6 +14,7 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <image-sparse.h>
+#include <linux/string.h>
 
 static int curr_device = -1;
 
diff --git a/cmd/mp.c b/cmd/mp.c
index 8d14401b4944..dec1fb41c0a7 100644
--- a/cmd/mp.c
+++ b/cmd/mp.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <command.h>
 #include <cpu_func.h>
+#include <linux/string.h>
 
 static int cpu_status_all(void)
 {
diff --git a/cmd/mtd.c b/cmd/mtd.c
index eb6e2d6892ff..fd312778f89c 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -16,6 +16,7 @@
 #include <mtd.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #include <linux/ctype.h>
 
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index 0984158f41ea..c10e3af4748e 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -81,6 +81,7 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/mtd/mtd.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_CMD_NAND)
 #include <linux/mtd/rawnand.h>
diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index ca24a5c1c4ba..ab6265d209eb 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <fuse.h>
+#include <linux/string.h>
 #include <mach/efuse.h>
 
 #include <spi_flash.h>
diff --git a/cmd/mvebu/comphy_rx_training.c b/cmd/mvebu/comphy_rx_training.c
index 4ee8f54ea9c7..42878a8771f0 100644
--- a/cmd/mvebu/comphy_rx_training.c
+++ b/cmd/mvebu/comphy_rx_training.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <fdtdec.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include <mvebu/comphy.h>
 
 int mvebu_comphy_rx_training_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/nand.c b/cmd/nand.c
index b41e54ec4229..6d84029ce704 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -37,6 +37,7 @@
 #include <asm/byteorder.h>
 #include <jffs2/jffs2.h>
 #include <nand.h>
+#include <linux/string.h>
 
 #include "legacy-mtd-utils.h"
 
diff --git a/cmd/net.c b/cmd/net.c
index d407d8320a3d..b0f680e5f65b 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <net.h>
 #include <net6.h>
+#include <linux/string.h>
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index eaa000bd3559..d4eda9ecb386 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -37,6 +37,7 @@
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <linux/stddef.h>
 #include <asm/byteorder.h>
diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 7a30b5cc8f87..81b8f0101aa7 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -18,6 +18,7 @@
 #include <rtc.h>
 #include <uuid.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 /*
  * From efi_variable.c,
diff --git a/cmd/nvme.c b/cmd/nvme.c
index 09d5f438fb1a..01c4cdde6120 100644
--- a/cmd/nvme.c
+++ b/cmd/nvme.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <dm.h>
 #include <nvme.h>
+#include <linux/string.h>
 
 static int nvme_curr_dev;
 
diff --git a/cmd/onenand.c b/cmd/onenand.c
index fad781583a31..38b431087411 100644
--- a/cmd/onenand.c
+++ b/cmd/onenand.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index e0e44bbed042..80de881cc26b 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <mmc.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <tee/optee_ta_avb.h>
 
 static struct udevice *tee;
diff --git a/cmd/osd.c b/cmd/osd.c
index c8c62d4a2ab3..81ea9df24de2 100644
--- a/cmd/osd.c
+++ b/cmd/osd.c
@@ -15,6 +15,7 @@
 #include <hexdump.h>
 #include <video_osd.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 /* Container for selected OSD device */
 static struct udevice *osd_cur;
diff --git a/cmd/part.c b/cmd/part.c
index 0ce190005d32..75453c53d9c0 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -21,6 +21,7 @@
 #include <env.h>
 #include <part.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 enum cmd_part_info {
 	CMD_PART_INFO_START = 0,
diff --git a/cmd/pci.c b/cmd/pci.c
index 78b661d15b1c..1a19c8938e29 100644
--- a/cmd/pci.c
+++ b/cmd/pci.c
@@ -22,6 +22,7 @@
 #include <asm/processor.h>
 #include <asm/io.h>
 #include <pci.h>
+#include <linux/string.h>
 
 struct pci_reg_info {
 	const char *name;
diff --git a/cmd/pinmux.c b/cmd/pinmux.c
index f17cf4110d9f..0ef5b70e1e02 100644
--- a/cmd/pinmux.c
+++ b/cmd/pinmux.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 #define LIMIT_DEVNAME	30
 
diff --git a/cmd/printf.c b/cmd/printf.c
index 0c6887e0d6e9..199194450d3e 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -90,6 +90,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <linux/string.h>
 
 #define WANT_HEX_ESCAPES 0
 #define PRINT_CONVERSION_ERROR 1
diff --git a/cmd/pstore.c b/cmd/pstore.c
index cd6f6feb2fd3..5a9f26df280a 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -12,6 +12,7 @@
 #include <memalign.h>
 #include <part.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 struct persistent_ram_buffer {
 	u32    sig;
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 704589702f23..89fd417b5af4 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -10,6 +10,7 @@
 #include <net.h>
 #include <net6.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include "pxe_utils.h"
 
diff --git a/cmd/read.c b/cmd/read.c
index 1218e7acfd0a..b21ee5eb8452 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <mapmem.h>
 #include <part.h>
+#include <linux/string.h>
 
 static int
 do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/cmd/regulator.c b/cmd/regulator.c
index 635a9add5856..1b8fc5ce23e3 100644
--- a/cmd/regulator.c
+++ b/cmd/regulator.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #define LIMIT_DEVNAME	20
diff --git a/cmd/remoteproc.c b/cmd/remoteproc.c
index ca3b436242ab..d467c7a5b53f 100644
--- a/cmd/remoteproc.c
+++ b/cmd/remoteproc.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include <remoteproc.h>
+#include <linux/string.h>
 
 /**
  * print_remoteproc_list() - print all the remote processor devices
diff --git a/cmd/rtc.c b/cmd/rtc.c
index a344cfa76b1d..d4fb11b26235 100644
--- a/cmd/rtc.c
+++ b/cmd/rtc.c
@@ -8,6 +8,7 @@
 #include <i2c.h>
 #include <mapmem.h>
 #include <rtc.h>
+#include <linux/string.h>
 
 #define MAX_RTC_BYTES 32
 
diff --git a/cmd/sata.c b/cmd/sata.c
index 9c9fe111d12f..3d7533885f64 100644
--- a/cmd/sata.c
+++ b/cmd/sata.c
@@ -18,6 +18,7 @@
 #include <sata.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static int sata_curr_device = -1;
 
diff --git a/cmd/scsi.c b/cmd/scsi.c
index 4549995ba73c..a0a9a3829ec2 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -11,6 +11,7 @@
 #include <blk.h>
 #include <command.h>
 #include <scsi.h>
+#include <linux/string.h>
 
 static int scsi_curr_dev; /* current device */
 
diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 233471f6cb75..0f10d738e250 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include "printf.h"
 
 #define MAX_STR_LEN 128
diff --git a/cmd/sf.c b/cmd/sf.c
index e1a42d21518f..65c0f2a1cd4b 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -19,6 +19,7 @@
 #include <asm/cache.h>
 #include <jffs2/jffs2.h>
 #include <linux/mtd/mtd.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <dm/device-internal.h>
diff --git a/cmd/sha1sum.c b/cmd/sha1sum.c
index bcc665a5a6c6..677f57b62d74 100644
--- a/cmd/sha1sum.c
+++ b/cmd/sha1sum.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <command.h>
 #include <hash.h>
+#include <linux/string.h>
 #include <u-boot/sha1.h>
 
 int do_sha1sum(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/cmd/sleep.c b/cmd/sleep.c
index 0cbbceccc313..5b1fb1f7075a 100644
--- a/cmd/sleep.c
+++ b/cmd/sleep.c
@@ -9,6 +9,7 @@
 #include <console.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static int do_sleep(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/smccc.c b/cmd/smccc.c
index fb80431ad1d9..d241034e9478 100644
--- a/cmd/smccc.c
+++ b/cmd/smccc.c
@@ -9,6 +9,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/compiler.h>
 #include <linux/psci.h>
+#include <linux/string.h>
 
 static int do_call(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/spi.c b/cmd/spi.c
index f30018f33be8..0dca42b191f3 100644
--- a/cmd/spi.c
+++ b/cmd/spi.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <spi.h>
+#include <linux/string.h>
 
 /*-----------------------------------------------------------------------
  * Definitions
diff --git a/cmd/stackprot_test.c b/cmd/stackprot_test.c
index f3470288facc..7bbfeddab220 100644
--- a/cmd/stackprot_test.c
+++ b/cmd/stackprot_test.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 
 static int do_test_stackprot_fail(struct cmd_tbl *cmdtp, int flag, int argc,
 				  char *const argv[])
diff --git a/cmd/strings.c b/cmd/strings.c
index bf348afce814..6c12c7076785 100644
--- a/cmd/strings.c
+++ b/cmd/strings.c
@@ -9,6 +9,7 @@
 #include <config.h>
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 
 static char *start_addr, *last_addr;
 
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 63a7806debe4..541dcda00c0b 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -5,6 +5,7 @@
 #include <env.h>
 #include <fs.h>
 #include <pxe_utils.h>
+#include <linux/string.h>
 
 /**
  * struct sysboot_info - useful information for sysboot helpers
diff --git a/cmd/test.c b/cmd/test.c
index fa7c48fb9f10..ad69e6dd7a6c 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <fs.h>
 #include <log.h>
+#include <linux/string.h>
 
 #define OP_INVALID	0
 #define OP_NOT		1
diff --git a/cmd/ti/ddr3.c b/cmd/ti/ddr3.c
index bbd406fc66ec..13de470a9f3f 100644
--- a/cmd/ti/ddr3.c
+++ b/cmd/ti/ddr3.c
@@ -15,6 +15,7 @@
 #include <common.h>
 #include <command.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/timer.c b/cmd/timer.c
index 507a99562635..6139cde41714 100644
--- a/cmd/timer.c
+++ b/cmd/timer.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <command.h>
 #include <time.h>
+#include <linux/string.h>
 
 static int do_timer(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 79796394c5c8..88f9bc595d17 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -19,6 +19,7 @@
 #include <net.h>
 #include <asm/global_data.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #include "tlv_eeprom.h"
diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
index 3b95c950cc96..a18ef45fd7ed 100644
--- a/cmd/tpm-v1.c
+++ b/cmd/tpm-v1.c
@@ -10,6 +10,7 @@
 #include <asm/unaligned.h>
 #include <tpm-common.h>
 #include <tpm-v1.h>
+#include <linux/string.h>
 #include "tpm-user-utils.h"
 #include <tpm_api.h>
 
diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 7e479b9dfe36..d1b878e7cec8 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -11,6 +11,7 @@
 #include <mapmem.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
+#include <linux/string.h>
 #include "tpm-user-utils.h"
 
 static int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/tsi148.c b/cmd/tsi148.c
index 0d849d9979e4..ce46b01f8029 100644
--- a/cmd/tsi148.c
+++ b/cmd/tsi148.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <asm/io.h>
 #include <pci.h>
+#include <linux/string.h>
 
 #include <tsi148.h>
 
diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd109..7bb84535dfbc 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <jffs2/load_kernel.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 
 #undef ubi_msg
 #define ubi_msg(fmt, ...) printf("UBI: " fmt "\n", ##__VA_ARGS__)
diff --git a/cmd/ufs.c b/cmd/ufs.c
index 143e946370f8..351ed4b3dc84 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <command.h>
 #include <ufs.h>
+#include <linux/string.h>
 
 static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/universe.c b/cmd/universe.c
index fb3a32d4d5a7..a0436ad782a5 100644
--- a/cmd/universe.c
+++ b/cmd/universe.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <asm/io.h>
 #include <pci.h>
+#include <linux/string.h>
 
 #include <universe.h>
 
diff --git a/cmd/usb.c b/cmd/usb.c
index 23253f22231c..60ef56c7c53d 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -22,6 +22,7 @@
 #include <asm/unaligned.h>
 #include <part.h>
 #include <usb.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_USB_STORAGE
 static int usb_stor_curr_dev = -1; /* current device */
diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index a8ddeb494628..22ec3c7d917d 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -19,6 +19,7 @@
 #include <watchdog.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 static int ums_read_sector(struct ums *ums_dev,
 			   ulong start, lbaint_t blkcnt, void *buf)
diff --git a/cmd/vbe.c b/cmd/vbe.c
index 600690394eb8..597df79a42e3 100644
--- a/cmd/vbe.c
+++ b/cmd/vbe.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <spl.h>
 #include <vbe.h>
+#include <linux/string.h>
 
 static int do_vbe_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
diff --git a/cmd/virtio.c b/cmd/virtio.c
index 019e317e7558..ff46f008f655 100644
--- a/cmd/virtio.c
+++ b/cmd/virtio.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <linux/string.h>
 
 static int virtio_curr_dev;
 
diff --git a/cmd/w1.c b/cmd/w1.c
index 3209e65f377f..9e5d7b0d374b 100644
--- a/cmd/w1.c
+++ b/cmd/w1.c
@@ -10,6 +10,7 @@
 #include <w1.h>
 #include <w1-eeprom.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 static int w1_bus(void)
 {
diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index 84822a3e3211..255ae59442b4 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <console.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/x86/hob.c b/cmd/x86/hob.c
index 04d092dbe7ef..171dff7b2372 100644
--- a/cmd/x86/hob.c
+++ b/cmd/x86/hob.c
@@ -10,6 +10,7 @@
 #include <asm/global_data.h>
 #include <asm/hob.h>
 #include <asm/fsp/fsp_hob.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 6ad7a123a447..dfc8786eb9f1 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -9,6 +9,7 @@
 #include <asm/msr.h>
 #include <asm/mp.h>
 #include <asm/mtrr.h>
+#include <linux/string.h>
 
 static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 {
diff --git a/cmd/ximg.c b/cmd/ximg.c
index 60ed2c9f6f9e..10a285f338c0 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -26,6 +26,7 @@
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #ifndef CFG_SYS_XIMG_LEN
 /* use 8MByte as default max gunzip size */
diff --git a/cmd/yaffs2.c b/cmd/yaffs2.c
index 27fbd1be8f75..f130551913c4 100644
--- a/cmd/yaffs2.c
+++ b/cmd/yaffs2.c
@@ -14,6 +14,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 
 #include <config.h>
 #include <command.h>
diff --git a/cmd/zfs.c b/cmd/zfs.c
index 6ef1b56ab10b..2c171532f6b0 100644
--- a/cmd/zfs.c
+++ b/cmd/zfs.c
@@ -19,6 +19,7 @@
 #include <zfs_common.h>
 #include <linux/stat.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_CMD_USB) && defined(CONFIG_USB_STORAGE)
 #include <usb.h>
diff --git a/common/autoboot.c b/common/autoboot.c
index 5d331991c190..297bea5cd062 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -21,6 +21,7 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/sha256.h>
 #include <bootcount.h>
 #include <crypt.h>
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 48ba8db51e59..83eadda69fa6 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <tee/optee_ta_avb.h>
 
 static const unsigned char avb_root_pub[1032] = {
diff --git a/common/bloblist.c b/common/bloblist.c
index 2144b10e1d04..104e19d1b312 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -14,6 +14,7 @@
 #include <mapmem.h>
 #include <spl.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /*
diff --git a/common/board_f.c b/common/board_f.c
index aef395b1354e..9900f0e2b469 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -49,6 +49,7 @@
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/bootstage.c b/common/bootstage.c
index 326c40f1561f..d3aa4e220582 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -21,6 +21,7 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/bouncebuf.c b/common/bouncebuf.c
index 934b83f7ec3f..e4a30e9e6970 100644
--- a/common/bouncebuf.c
+++ b/common/bouncebuf.c
@@ -13,6 +13,7 @@
 #include <bouncebuf.h>
 #include <asm/cache.h>
 #include <linux/dma-mapping.h>
+#include <linux/string.h>
 
 static int addr_aligned(struct bounce_buffer *state)
 {
diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a7d..ad5077c3cf6d 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -23,6 +23,7 @@
 #include <asm/global_data.h>
 #include <dm/ofnode.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_CMDLINE
 /*
diff --git a/common/cli_getch.c b/common/cli_getch.c
index 61d4cb261b81..86f19e33a4cc 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <cli.h>
+#include <linux/string.h>
 
 /**
  * enum cli_esc_state_t - indicates what to do with an escape character
diff --git a/common/cli_hush.c b/common/cli_hush.c
index 9cda97f30e3c..61fb7ac1685e 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -114,6 +114,7 @@
 #define hush_main main
 #define BB_BANNER
 #endif
+#include <linux/string.h>
 #endif
 #define SPECIAL_VAR_SYMBOL 03
 #define SUBSTED_VAR_SYMBOL 04
diff --git a/common/cli_readline.c b/common/cli_readline.c
index e83743e90c92..8444bad23ec3 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/cli_simple.c b/common/cli_simple.c
index e80ba488a5eb..5fa2c4f6fdfc 100644
--- a/common/cli_simple.c
+++ b/common/cli_simple.c
@@ -16,6 +16,7 @@
 #include <env.h>
 #include <log.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 #define DEBUG_PARSER	0	/* set to 1 to debug */
 
diff --git a/common/command.c b/common/command.c
index efe825e82250..2d364ba6bcf0 100644
--- a/common/command.c
+++ b/common/command.c
@@ -19,6 +19,7 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/console.c b/common/console.c
index 98c3ee6ca6b8..6946f103aefb 100644
--- a/common/console.c
+++ b/common/console.c
@@ -22,6 +22,7 @@
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c0..0e0145f7c88a 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+#include <linux/string.h>
  * A general-purpose cyclic execution infrastructure, to allow "small"
  * (run-time wise) functions to be executed at a specified frequency.
  * Things like LED blinking or watchdog triggering are examples for such
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index ebf0f27e1657..523b22f04966 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #if CONFIG_IS_ENABLED(UNIT_TEST)
 #define DEBUG
diff --git a/common/eeprom/eeprom_layout.c b/common/eeprom/eeprom_layout.c
index 5a9be1da061f..338185d58c36 100644
--- a/common/eeprom/eeprom_layout.c
+++ b/common/eeprom/eeprom_layout.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <eeprom_layout.h>
 #include <eeprom_field.h>
+#include <linux/string.h>
 
 #define NO_LAYOUT_FIELDS	"Unknown layout. Dumping raw data\n"
 
diff --git a/common/event.c b/common/event.c
index 3080d9ed754d..b6ca0ff250fe 100644
--- a/common/event.c
+++ b/common/event.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <linux/list.h>
 #include <relocate.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/flash.c b/common/flash.c
index 848f44e59dfd..bc31d0597b51 100644
--- a/common/flash.c
+++ b/common/flash.c
@@ -10,6 +10,7 @@
 #include <flash.h>
 #include <log.h>
 #include <uuid.h>
+#include <linux/string.h>
 
 #include <mtd/cfi_flash.h>
 
diff --git a/common/hash.c b/common/hash.c
index e837c56d4433..66744e506064 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -21,6 +21,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #else
 #include "mkimage.h"
 #include <linux/compiler_attributes.h>
diff --git a/common/init/board_init.c b/common/init/board_init.c
index ab8c508ad83c..06a75979ed9b 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -10,6 +10,7 @@
 #include <bootstage.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/iomux.c b/common/iomux.c
index c428f7110a7a..130913633cc4 100644
--- a/common/iomux.c
+++ b/common/iomux.c
@@ -8,6 +8,7 @@
 #include <console.h>
 #include <serial.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #if CONFIG_IS_ENABLED(CONSOLE_MUX)
 void iomux_printdevs(const int console)
diff --git a/common/kallsyms.c b/common/kallsyms.c
index 13344e634b99..f468733d2b11 100644
--- a/common/kallsyms.c
+++ b/common/kallsyms.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 
 /* We need the weak marking as this symbol is provided specially */
 extern const char system_map[] __attribute__((weak));
diff --git a/common/kgdb.c b/common/kgdb.c
index 29b09fcfe56b..7d19981c23fb 100644
--- a/common/kgdb.c
+++ b/common/kgdb.c
@@ -58,6 +58,7 @@
  *    c             Resume at current address              SNN   ( signal NN)
  *    cAA..AA       Continue at address AA..AA             SNN
  *
+#include <linux/string.h>
  *    s             Step one instruction                   SNN
  *    sAA..AA       Step one instruction from AA..AA       SNN
  *
diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..a9395d9b6cf2 100644
--- a/common/log.c
+++ b/common/log.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/log_syslog.c b/common/log_syslog.c
index 53c4def5d1c0..b9a3c8e45ba5 100644
--- a/common/log_syslog.c
+++ b/common/log_syslog.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <net.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 0a004d40e1ec..ce3f3d5cdbdb 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -13,6 +13,7 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <valgrind/valgrind.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/common/menu.c b/common/menu.c
index b55cf7b99967..9525c6aac4b7 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/list.h>
 #include <watchdog.h>
+#include <linux/string.h>
 
 #include "menu.h"
 
diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 194c84e7e89d..dc51b3568276 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -15,6 +15,7 @@
 #include <miiphy.h>
 #include <phy.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/types.h>
 #include <linux/list.h>
diff --git a/common/qfw.c b/common/qfw.c
index 45e87d3ae28c..6b80859258ec 100644
--- a/common/qfw.c
+++ b/common/qfw.c
@@ -10,6 +10,7 @@
 #include <qfw.h>
 #include <stdlib.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 
 int qfw_get_dev(struct udevice **devp)
 {
diff --git a/common/scp03.c b/common/scp03.c
index 09ef7b5ba3dc..c8724216ecdb 100644
--- a/common/scp03.c
+++ b/common/scp03.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <scp03.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <tee/optee_ta_scp03.h>
 
 static int scp03_enable(bool provision)
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 045a5e89625d..1783bb89fdf3 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -25,6 +25,7 @@
 #include <asm/u-boot.h>
 #include <nand.h>
 #include <fat.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 #include <timestamp.h>
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 2c10252834f6..6716862d538c 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -17,6 +17,7 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/cache.h>
+#include <linux/string.h>
 
 /* Holds all the structures we need for bl31 parameter passing */
 struct bl2_to_bl31_params_mem {
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index cd73b2565658..193bd5140699 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 20f687e13891..cbeaf8860748 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <mmc.h>
 #include <image.h>
+#include <linux/string.h>
 
 static int mmc_load_legacy(struct spl_image_info *spl_image,
 			   struct spl_boot_device *bootdev,
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index b2c901b554b8..de15e3730ba7 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -14,6 +14,7 @@
 #include <spl.h>
 #include <net.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)
 static ulong spl_net_load_read(struct spl_load_info *load, ulong sector,
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 5b65b96a77db..35cd2885a0d4 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -7,6 +7,7 @@
 #include <image.h>
 #include <log.h>
 #include <spl.h>
+#include <linux/string.h>
 
 static ulong spl_nor_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 4158ed1c32d7..1437396e96bf 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,6 +16,7 @@
 #include <mapmem.h>
 #include <spl.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
diff --git a/common/spl/spl_sata.c b/common/spl/spl_sata.c
index 32746ce9f3cf..28a86e9295c3 100644
--- a/common/spl/spl_sata.c
+++ b/common/spl/spl_sata.c
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <fat.h>
 #include <image.h>
+#include <linux/string.h>
 
 static int spl_sata_load_image_raw(struct spl_image_info *spl_image,
 		struct spl_boot_device *bootdev,
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index bcac25cd021c..0ab509cdbc1a 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -11,6 +11,7 @@
 #include <onenand_uboot.h>
 #include <ubispl.h>
 #include <spl.h>
+#include <linux/string.h>
 
 int spl_ubi_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 038b44384571..b103b9a69060 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -16,6 +16,7 @@
 #include <xyzModem.h>
 #include <asm/u-boot.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #define BUF_SIZE 1024
 
diff --git a/common/splash.c b/common/splash.c
index 6820db683bd6..93da74b845e1 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -25,6 +25,7 @@
 #include <env.h>
 #include <splash.h>
 #include <video.h>
+#include <linux/string.h>
 
 static struct splash_location default_splash_locations[] = {
 	{
diff --git a/common/splash_source.c b/common/splash_source.c
index 7223a1aae788..37065cfeebd8 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -22,6 +22,7 @@
 #include <usb.h>
 #include <virtio.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/stdio.c b/common/stdio.c
index 010bf576af0a..499260be96de 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -21,6 +21,7 @@
 #include <i2c.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/update.c b/common/update.c
index ec302ca68fb0..8d3d1d1b4ba2 100644
--- a/common/update.c
+++ b/common/update.c
@@ -10,6 +10,7 @@
 #include <cpu_func.h>
 #include <image.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <command.h>
 #include <env.h>
diff --git a/common/usb.c b/common/usb.c
index 836506dcd9e9..588af4398642 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -39,6 +39,7 @@
 #include <errno.h>
 #include <usb.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define USB_BUFSIZ	512
 
diff --git a/common/usb_hub.c b/common/usb_hub.c
index bcc332693a45..57f697d19c4c 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -40,6 +40,7 @@
 #include <asm/state.h>
 #endif
 #include <asm/unaligned.h>
+#include <linux/string.h>
 
 #include <usb.h>
 
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index e7d2aa9cf090..8bd252be5365 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_SANDBOX
 #include <asm/state.h>
 #endif
+#include <linux/string.h>
 
 #include <usb.h>
 
diff --git a/common/usb_storage.c b/common/usb_storage.c
index 85774220ef2a..cd79eae77b47 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -47,6 +47,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <part.h>
 #include <usb.h>
diff --git a/disk/part.c b/disk/part.c
index 72241b7b232c..5d7061f995b8 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <ubifs_uboot.h>
+#include <linux/string.h>
 
 #undef	PART_DEBUG
 
diff --git a/disk/part_amiga.c b/disk/part_amiga.c
index 65e30fea558d..cb47173ed855 100644
--- a/disk/part_amiga.c
+++ b/disk/part_amiga.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <env.h>
 #include <ide.h>
+#include <linux/string.h>
 #include "part_amiga.h"
 #include <part.h>
 
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 33374384373a..b74e0d63fe94 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -20,6 +20,7 @@
 #include <memalign.h>
 #include <asm/unaligned.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include "part_dos.h"
 #include <part.h>
 
diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ce9243ef25c..4f0f76edfda2 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -30,6 +30,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /* GUID for basic data partitons */
diff --git a/disk/part_iso.c b/disk/part_iso.c
index 6ac6d95be921..a354648972ca 100644
--- a/disk/part_iso.c
+++ b/disk/part_iso.c
@@ -10,6 +10,7 @@
 #include <part.h>
 #include <asm/cache.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include "part_iso.h"
 
 /* #define	ISO_PART_DEBUG */
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 725bd2f16816..9f97847d5771 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <command.h>
 #include <dm.h>
diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index 6a4d861bf1e8..397cb59b3af9 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -26,6 +26,7 @@
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include "dwc_ahsata_priv.h"
 
 struct sata_port_regs {
diff --git a/drivers/ata/fsl_sata.c b/drivers/ata/fsl_sata.c
index 972101b29ce5..c9ac771200ec 100644
--- a/drivers/ata/fsl_sata.c
+++ b/drivers/ata/fsl_sata.c
@@ -22,6 +22,7 @@
 #include <fis.h>
 #include <sata.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "fsl_sata.h"
 
 static inline void sdelay(unsigned long sec)
diff --git a/drivers/ata/libata.c b/drivers/ata/libata.c
index 47e2c5c1cc40..cdc83c75bb69 100644
--- a/drivers/ata/libata.c
+++ b/drivers/ata/libata.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <compiler.h>
 #include <libata.h>
+#include <linux/string.h>
 
 u64 ata_id_n_sectors(u16 *id)
 {
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index ce3e9b5a400c..922aa6f84be0 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -15,6 +15,7 @@
 #include <dm.h>
 #include <part.h>
 #include <sata.h>
+#include <linux/string.h>
 
 #ifndef CONFIG_AHCI
 struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 78395b173c0f..d48328ceb9a9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -51,6 +51,7 @@
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <linux/mbus.h>
+#include <linux/string.h>
 
 #include <asm/arch/soc.h>
 #if defined(CONFIG_ARCH_KIRKWOOD)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index b5e150d568ba..5a4003ac7502 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -21,6 +21,7 @@
 #include <sata.h>
 #include <dm/device-internal.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "sata_sil.h"
 
diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index 7ebead6bfad6..124129ab45c5 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -53,6 +53,7 @@
 #include <malloc.h>
 #include <vesa.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "biosemui.h"
 
 /* Length of the BIOS image */
diff --git a/drivers/bios_emulator/biosemu.c b/drivers/bios_emulator/biosemu.c
index 82befbae66f7..d6065e2f2584 100644
--- a/drivers/bios_emulator/biosemu.c
+++ b/drivers/bios_emulator/biosemu.c
@@ -47,6 +47,7 @@
 
 #include <malloc.h>
 #include <common.h>
+#include <linux/string.h>
 #include "biosemui.h"
 
 BE_sysEnv _BE_env = {{0}};
diff --git a/drivers/bios_emulator/x86emu/debug.c b/drivers/bios_emulator/x86emu/debug.c
index 95f3cc09aad5..1e4b6ba0c6bd 100644
--- a/drivers/bios_emulator/x86emu/debug.c
+++ b/drivers/bios_emulator/x86emu/debug.c
@@ -41,6 +41,7 @@
 #include <common.h>
 #include <linux/ctype.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "x86emu/x86emui.h"
 
 /*----------------------------- Implementation ----------------------------*/
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 885513893f6f..c1debd7440d3 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -16,6 +16,7 @@
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #define blk_get_ops(dev)	((struct blk_ops *)(dev)->driver->ops)
 
diff --git a/drivers/block/blk_legacy.c b/drivers/block/blk_legacy.c
index 5bf1d0471524..bd236af6e962 100644
--- a/drivers/block/blk_legacy.c
+++ b/drivers/block/blk_legacy.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <part.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 struct blk_driver *blk_driver_lookup_type(int uclass_id)
 {
diff --git a/drivers/block/blkcache.c b/drivers/block/blkcache.c
index 26bcbea43533..2b3892adbc84 100644
--- a/drivers/block/blkcache.c
+++ b/drivers/block/blkcache.c
@@ -12,6 +12,7 @@
 #include <asm/global_data.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
+#include <linux/string.h>
 
 struct block_cache_node {
 	struct list_head lh;
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 2bb0acc20f2c..da0351cf8c31 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -14,6 +14,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 struct blkmap;
 
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index 6460d968c23f..b018434a3388 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -17,6 +17,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 64422417b749..00533ceb9bb3 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -18,6 +18,7 @@
 #include <os.h>
 #include <sandbox_host.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 static int host_sb_attach_file(struct udevice *dev, const char *filename)
 {
diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index c698f9cbd558..6bf88f1bf898 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -17,6 +17,7 @@
 #include <watchdog.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #ifdef __PPC__
 # define EIEIO		__asm__ volatile ("eieio")
diff --git a/drivers/bootcount/spi-flash.c b/drivers/bootcount/spi-flash.c
index 03050e666134..f0aebf16a332 100644
--- a/drivers/bootcount/spi-flash.c
+++ b/drivers/bootcount/spi-flash.c
@@ -8,6 +8,7 @@
 #include <bootcount.h>
 #include <dm.h>
 #include <spi_flash.h>
+#include <linux/string.h>
 
 static const u8 bootcount_magic = 0xbc;
 
diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
index 032191d61abc..934b8b1a5dd9 100644
--- a/drivers/button/button-uclass.c
+++ b/drivers/button/button-uclass.c
@@ -11,6 +11,7 @@
 #include <button.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 int button_get_by_label(const char *label, struct udevice **devp)
 {
diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
index 578597a16e81..02d271f94fe6 100644
--- a/drivers/clk/altera/clk-arria10.c
+++ b/drivers/clk/altera/clk-arria10.c
@@ -14,6 +14,7 @@
 #include <dm/util.h>
 #include <linux/bitops.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <asm/arch/clock_manager.h>
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e2f72446d500..9fde41b35e9a 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <dt-bindings/clk/at91.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 #include "pmc.h"
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 3abd22080304..2a9f7ee0554c 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <dt-bindings/clk/at91.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 #include "pmc.h"
 
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 43136ab2e349..94c649edae2c 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <dt-bindings/clk/at91.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 #include "pmc.h"
 
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index f410518461e9..919081a8fd57 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -37,6 +37,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index d172fed24c9d..17f22681b0fd 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,7 @@
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 /**
  * struct scmi_clk_priv - Private data for SCMI clocks
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 2e004beca2f9..ac20527b0941 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -18,6 +18,7 @@
 #include <asm/arch/sys_proto.h>
 #include <zynqmp_firmware.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #define MAX_PARENT			100
 #define MAX_NODES			6
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index e75052f383c6..0b9ac1941001 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -17,6 +17,7 @@
 #include <asm/arch/cpu.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #define TBG_SEL		0x0
 #define DIV_SEL0	0x4
diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 850d64111904..ff0b3bcb585c 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
index 28cdba75758d..00e5bc342e6d 100644
--- a/drivers/clk/rockchip/clk_rk322x.c
+++ b/drivers/clk/rockchip/clk_rk322x.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 
 enum {
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index e24c32c0a2a9..18bfe8ba3244 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index ef97381f0ede..9da01cbbfe2b 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -21,6 +21,7 @@
 #include <dt-bindings/clock/rk3328-cru.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct pll_div {
 	u32 refdiv;
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 3406ff592e17..8103c639f605 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -24,6 +24,7 @@
 #include <dt-bindings/clock/rk3368-cru.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index c37e8a53a268..c857920256e7 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -25,6 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 119b1337bdf2..055dc36db1df 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -18,6 +18,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index c8fb60029070..046b1c263fae 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/math64.h>
 #include <dt-bindings/clock/sifive-fu740-prci.h>
+#include <linux/string.h>
 
 #include "fu540-prci.h"
 #include "fu740-prci.h"
diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index ed7660196ef0..1b4645dcd5c2 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -17,6 +17,7 @@
 #include <dm/device_compat.h>
 #include <dt-bindings/mfd/stm32f7-rcc.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #define RCC_CR_HSION			BIT(0)
 #define RCC_CR_HSEON			BIT(16)
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index ba925fa3c480..db9673a7f1fe 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <soc.h>
 #include <clk-uclass.h>
+#include <linux/string.h>
 #include "k3-clk.h"
 
 #define PLL_MIN_FREQ	800000000
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 6e5cc90f0f8c..d71960914afe 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -11,6 +11,7 @@
 #include <regmap.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 #include "clk.h"
 
 #define CLK_MAX_MEMMAPS           10
diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
index 0ebd288ab420..53b5e0fcf5d3 100644
--- a/drivers/core/acpi.c
+++ b/drivers/core/acpi.c
@@ -18,6 +18,7 @@
 #include <dm/acpi.h>
 #include <dm/device-internal.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 #define MAX_ACPI_ITEMS	100
 
diff --git a/drivers/core/device.c b/drivers/core/device.c
index bf7f261cbce0..de72a0722847 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <power-domain.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 4023b390f542..de3c6794f335 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -11,6 +11,7 @@
 #include <dm/root.h>
 #include <dm/util.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /**
  * struct sort_info - information used for sorting
diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 8034a8f48d99..b1eaadef2094 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -19,6 +19,7 @@
 #include <dm/util.h>
 #include <fdtdec.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 struct driver *lists_driver_lookup_name(const char *name)
 {
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 1bb4d8eab709..1b69f7d6c011 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -29,6 +29,7 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
index b3b3d7ccdd56..f023205ec19e 100644
--- a/drivers/core/of_addr.c
+++ b/drivers/core/of_addr.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
diff --git a/drivers/core/of_extra.c b/drivers/core/of_extra.c
index 59ce9174ad07..f9f6143fad8b 100644
--- a/drivers/core/of_extra.c
+++ b/drivers/core/of_extra.c
@@ -10,6 +10,7 @@
 #include <dm/of_access.h>
 #include <dm/of_extra.h>
 #include <dm/ofnode.h>
+#include <linux/string.h>
 
 int ofnode_read_fmap_entry(ofnode node, struct fmap_entry *entry)
 {
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 2cafa7bca5b3..a22d4669717f 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 126b3140666f..beaec2ec944f 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -30,6 +30,7 @@
 #include <dm/util.h>
 #include <linux/list.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index e46d5717aa62..f57d01054590 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -20,6 +20,7 @@
 #include <dm/uclass.h>
 #include <dm/uclass-internal.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index 9772578968ba..aa357b9dbe60 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -15,6 +15,7 @@
 #include <dm/root.h>
 #include <linux/err.h>
 #include <relocate.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/cpu/cpu_sandbox.c b/drivers/cpu/cpu_sandbox.c
index 2e871fe313c1..1442e4665633 100644
--- a/drivers/cpu/cpu_sandbox.c
+++ b/drivers/cpu/cpu_sandbox.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <cpu.h>
+#include <linux/string.h>
 
 static int cpu_sandbox_get_desc(const struct udevice *dev, char *buf, int size)
 {
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 98ff95f5ff5c..268e88949587 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -16,6 +16,7 @@
 #include <imx_thermal.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/cpu/imx9_cpu.c b/drivers/cpu/imx9_cpu.c
index 66534fe6d17f..30c7726ac0e8 100644
--- a/drivers/cpu/imx9_cpu.c
+++ b/drivers/cpu/imx9_cpu.c
@@ -14,6 +14,7 @@
 #include <asm/arch-imx/cpu.h>
 #include <asm/armv8/cpu.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index d6484d7f4b40..3d001f594231 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -15,6 +15,7 @@
 #include <dm/lists.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/crypto/ace_sha.c b/drivers/crypto/ace_sha.c
index 261d3efe84e5..0b07ae5fd713 100644
--- a/drivers/crypto/ace_sha.c
+++ b/drivers/crypto/ace_sha.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2012  Samsung Electronics
  */
 #include <common.h>
+#include <linux/string.h>
 #include "ace_sha.h"
 #include <log.h>
 #include <rand.h>
diff --git a/drivers/crypto/aspeed/aspeed_acry.c b/drivers/crypto/aspeed/aspeed_acry.c
index 47a007f633a6..638365e7d6fc 100644
--- a/drivers/crypto/aspeed/aspeed_acry.c
+++ b/drivers/crypto/aspeed/aspeed_acry.c
@@ -11,6 +11,7 @@
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/rsa-mod-exp.h>
 
 /* ACRY register offsets */
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 6b6c8fa65889..62a4a7764bdb 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <malloc.h>
 #include <watchdog.h>
+#include <linux/string.h>
 #include <u-boot/hash.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/crypto/fsl/dcp_rng.c b/drivers/crypto/fsl/dcp_rng.c
index 31706960157c..7df29263a3df 100644
--- a/drivers/crypto/fsl/dcp_rng.c
+++ b/drivers/crypto/fsl/dcp_rng.c
@@ -16,6 +16,7 @@
 #include <dm/root.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #define DCP_RNG_MAX_FIFO_STORE_SIZE	4
 #define RNGC_VER_ID			0x0
diff --git a/drivers/crypto/fsl/desc_constr.h b/drivers/crypto/fsl/desc_constr.h
index 209557c4ffa9..a73e21d02d78 100644
--- a/drivers/crypto/fsl/desc_constr.h
+++ b/drivers/crypto/fsl/desc_constr.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
+#include <linux/string.h>
  * caam descriptor construction helper functions
  *
  * Copyright 2008-2014 Freescale Semiconductor, Inc.
diff --git a/drivers/crypto/fsl/error.c b/drivers/crypto/fsl/error.c
index c76574919c74..d19685b0ec4c 100644
--- a/drivers/crypto/fsl/error.c
+++ b/drivers/crypto/fsl/error.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include "desc.h"
 #include "jr.h"
 
diff --git a/drivers/crypto/fsl/fsl_blob.c b/drivers/crypto/fsl/fsl_blob.c
index 9b6e4bca062c..dc224cbf82ee 100644
--- a/drivers/crypto/fsl/fsl_blob.c
+++ b/drivers/crypto/fsl/fsl_blob.c
@@ -12,6 +12,7 @@
 #include <fsl_sec.h>
 #include <asm/cache.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include "jobdesc.h"
 #include "desc.h"
 #include "jr.h"
diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.c
index f22f24b60775..9d0e14098741 100644
--- a/drivers/crypto/fsl/fsl_hash.c
+++ b/drivers/crypto/fsl/fsl_hash.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include "jobdesc.h"
 #include "desc.h"
 #include "jr.h"
diff --git a/drivers/crypto/fsl/jobdesc.c b/drivers/crypto/fsl/jobdesc.c
index d32c1fe5c31a..87546c6b6309 100644
--- a/drivers/crypto/fsl/jobdesc.c
+++ b/drivers/crypto/fsl/jobdesc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+#include <linux/string.h>
  * SEC Descriptor Construction Library
  * Basic job descriptor construction
  *
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index ceb66dd6270d..0e8b89b7feaa 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <power-domain.h>
+#include <linux/string.h>
 #include "jr.h"
 #include "jobdesc.h"
 #include "desc_constr.h"
diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
index 063649480521..754c3d1d4c32 100644
--- a/drivers/crypto/fsl/rng.c
+++ b/drivers/crypto/fsl/rng.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <rng.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include "desc_constr.h"
 #include "jobdesc.h"
 #include "jr.h"
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index 446eb9e56a4f..770ac2974988 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <u-boot/hash.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/crypto/nuvoton/npcm_aes.c b/drivers/crypto/nuvoton/npcm_aes.c
index b01292a19362..b207ab635d3a 100644
--- a/drivers/crypto/nuvoton/npcm_aes.c
+++ b/drivers/crypto/nuvoton/npcm_aes.c
@@ -11,6 +11,7 @@
 #include <asm/arch/aes.h>
 #include <asm/arch/otp.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #define ONE_SECOND 0xC00000
 
diff --git a/drivers/crypto/nuvoton/npcm_sha.c b/drivers/crypto/nuvoton/npcm_sha.c
index 7ebdfa16f4fc..138c8cbfae6a 100644
--- a/drivers/crypto/nuvoton/npcm_sha.c
+++ b/drivers/crypto/nuvoton/npcm_sha.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <uboot_aes.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define HASH_DIG_H_NUM			8
 
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 8ef5fa4c481c..c20dbf5a5b94 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 34d2a2789ccf..69b6a271efde 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -18,6 +18,7 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 
 #include "sequencer.h"
 
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index cb8ab1118295..12c3baf60c86 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -14,6 +14,7 @@
 #include <ram.h>
 #include <reset.h>
 #include <time.h>
+#include <linux/string.h>
 #include "sdram_soc64.h"
 #include <wait_bit.h>
 #include <asm/arch/firewall.h>
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index f2cd16628c4b..404146eb411d 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -16,6 +16,7 @@
 #include <ram.h>
 #include <reset.h>
 #include <time.h>
+#include <linux/string.h>
 #include "sdram_soc64.h"
 #include <wait_bit.h>
 #include <asm/arch/firewall.h>
diff --git a/drivers/ddr/altera/sequencer.c b/drivers/ddr/altera/sequencer.c
index e402f2929ab7..405bd9f39b71 100644
--- a/drivers/ddr/altera/sequencer.c
+++ b/drivers/ddr/altera/sequencer.c
@@ -9,6 +9,7 @@
 #include <asm/arch/sdram.h>
 #include <errno.h>
 #include <hang.h>
+#include <linux/string.h>
 #include "sequencer.h"
 
 static const struct socfpga_sdr_rw_load_manager *sdr_rw_load_mgr_regs =
diff --git a/drivers/ddr/fsl/ctrl_regs.c b/drivers/ddr/fsl/ctrl_regs.c
index 8f8c2c864c3f..7247c5c38ae0 100644
--- a/drivers/ddr/fsl/ctrl_regs.c
+++ b/drivers/ddr/fsl/ctrl_regs.c
@@ -22,6 +22,7 @@
 	defined(CONFIG_ARM)
 #include <asm/arch/clock.h>
 #endif
+#include <linux/string.h>
 
 /*
  * Determine Rtt value.
diff --git a/drivers/ddr/fsl/ddr1_dimm_params.c b/drivers/ddr/fsl/ddr1_dimm_params.c
index e5481eaa0ddd..2ccf1e82f9a6 100644
--- a/drivers/ddr/fsl/ddr1_dimm_params.c
+++ b/drivers/ddr/fsl/ddr1_dimm_params.c
@@ -7,6 +7,7 @@
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <asm/bitops.h>
+#include <linux/string.h>
 
 #include <fsl_ddr.h>
 
diff --git a/drivers/ddr/fsl/ddr2_dimm_params.c b/drivers/ddr/fsl/ddr2_dimm_params.c
index 3b78118a9d82..9ee2dfc24554 100644
--- a/drivers/ddr/fsl/ddr2_dimm_params.c
+++ b/drivers/ddr/fsl/ddr2_dimm_params.c
@@ -7,6 +7,7 @@
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <asm/bitops.h>
+#include <linux/string.h>
 
 #include <fsl_ddr.h>
 /*
diff --git a/drivers/ddr/fsl/ddr3_dimm_params.c b/drivers/ddr/fsl/ddr3_dimm_params.c
index 1f8db90c45bd..4676e7029dba 100644
--- a/drivers/ddr/fsl/ddr3_dimm_params.c
+++ b/drivers/ddr/fsl/ddr3_dimm_params.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
+#include <linux/string.h>
 
 #include <fsl_ddr.h>
 
diff --git a/drivers/ddr/fsl/ddr4_dimm_params.c b/drivers/ddr/fsl/ddr4_dimm_params.c
index ea7916226287..dcc8e14b467b 100644
--- a/drivers/ddr/fsl/ddr4_dimm_params.c
+++ b/drivers/ddr/fsl/ddr4_dimm_params.c
@@ -14,6 +14,7 @@
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 #include <fsl_ddr.h>
 
diff --git a/drivers/ddr/fsl/interactive.c b/drivers/ddr/fsl/interactive.c
index eb2f06e8300a..41189214aa88 100644
--- a/drivers/ddr/fsl/interactive.c
+++ b/drivers/ddr/fsl/interactive.c
@@ -20,6 +20,7 @@
 #include <linux/ctype.h>
 #include <asm/types.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr.h>
diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index cd332718b640..d793ddd8c2ec 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -19,6 +19,7 @@
 #include <init.h>
 #include <log.h>
 #include <asm/bitops.h>
+#include <linux/string.h>
 
 /*
  * CFG_SYS_FSL_DDR_SDRAM_BASE_PHY is the physical address from the view
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 7a333880e6b6..5a80d6f60c23 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -11,6 +11,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static unsigned int g_cdd_rr_max[4];
 static unsigned int g_cdd_rw_max[4];
diff --git a/drivers/ddr/marvell/a38x/mv_ddr4_mpr_pda_if.c b/drivers/ddr/marvell/a38x/mv_ddr4_mpr_pda_if.c
index f742b5a9bcbf..95f54f6787b1 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr4_mpr_pda_if.c
+++ b/drivers/ddr/marvell/a38x/mv_ddr4_mpr_pda_if.c
@@ -5,6 +5,8 @@
 
 #if defined(CONFIG_DDR4)
 
+#include <linux/string.h>
+
 /* DDR4 MPR/PDA Interface */
 #include "ddr3_init.h"
 #include "mv_ddr4_mpr_pda_if.h"
diff --git a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
index 31b6209416bb..58c69c0fd05d 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
+++ b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
@@ -1849,6 +1849,7 @@ int mv_ddr4_receiver_calibration(u8 dev_num)
 			DEBUG_CALIBRATION(DEBUG_LEVEL_INFO, ("final dc %d\n", center_vref[if_id][subphy_num]));
 		}
 
+#include <linux/string.h>
 		/* run centralization again with optimal vref to update global structures */
 		mv_ddr4_centralization(dev_num, lambda_per_dq, c_opt_per_bus, pbs_res_per_bus, valid_win_size,
 				       RX_DIR, 0, center_vref[if_id][0]);
diff --git a/drivers/ddr/marvell/axp/ddr3_hw_training.c b/drivers/ddr/marvell/axp/ddr3_hw_training.c
index 35d98faf58f3..c39f40095fcc 100644
--- a/drivers/ddr/marvell/axp/ddr3_hw_training.c
+++ b/drivers/ddr/marvell/axp/ddr3_hw_training.c
@@ -11,6 +11,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ddr3_init.h"
 #include "ddr3_hw_training.h"
diff --git a/drivers/ddr/marvell/axp/ddr3_pbs.c b/drivers/ddr/marvell/axp/ddr3_pbs.c
index 069a42fbf5ed..a963b3c55be2 100644
--- a/drivers/ddr/marvell/axp/ddr3_pbs.c
+++ b/drivers/ddr/marvell/axp/ddr3_pbs.c
@@ -10,6 +10,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ddr3_hw_training.h"
 
diff --git a/drivers/ddr/marvell/axp/ddr3_spd.c b/drivers/ddr/marvell/axp/ddr3_spd.c
index 4763403c1278..e71fd432da40 100644
--- a/drivers/ddr/marvell/axp/ddr3_spd.c
+++ b/drivers/ddr/marvell/axp/ddr3_spd.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/string.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/axp/ddr3_write_leveling.c b/drivers/ddr/marvell/axp/ddr3_write_leveling.c
index d4add4477745..de8dfc299f7e 100644
--- a/drivers/ddr/marvell/axp/ddr3_write_leveling.c
+++ b/drivers/ddr/marvell/axp/ddr3_write_leveling.c
@@ -11,6 +11,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ddr3_hw_training.h"
 
diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 2adf26e2fe24..ec37ef0fe0e9 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 LIST_HEAD(dfu_list);
 static int dfu_alt_num;
diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
index ece3d2236f3d..1dcec62a956d 100644
--- a/drivers/dfu/dfu_alt.c
+++ b/drivers/dfu/dfu_alt.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <errno.h>
 #include <dfu.h>
+#include <linux/string.h>
 
 /**
  * dfu_write_by_name() - write data to DFU medium
diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index cdb3c18b01db..915abf6a763f 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -18,6 +18,7 @@
 #include <part.h>
 #include <command.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 static unsigned char *dfu_file_buf;
 static u64 dfu_file_buf_len;
diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
index 75e2f6a42151..c7e88b2db95b 100644
--- a/drivers/dfu/dfu_mtd.c
+++ b/drivers/dfu/dfu_mtd.c
@@ -12,6 +12,7 @@
 #include <mtd.h>
 #include <linux/err.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 static bool mtd_is_aligned_with_block_size(struct mtd_info *mtd, u64 size)
 {
diff --git a/drivers/dfu/dfu_nand.c b/drivers/dfu/dfu_nand.c
index 08e8cf5cdb37..acd78a6658d6 100644
--- a/drivers/dfu/dfu_nand.c
+++ b/drivers/dfu/dfu_nand.c
@@ -18,6 +18,7 @@
 #include <linux/mtd/mtd.h>
 #include <jffs2/load_kernel.h>
 #include <nand.h>
+#include <linux/string.h>
 
 static int nand_block_op(enum dfu_op op, struct dfu_entity *dfu,
 			u64 offset, void *buf, long *len)
diff --git a/drivers/dfu/dfu_ram.c b/drivers/dfu/dfu_ram.c
index c4f4bd2e482f..0afed440439f 100644
--- a/drivers/dfu/dfu_ram.c
+++ b/drivers/dfu/dfu_ram.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <dfu.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 static int dfu_transfer_medium_ram(enum dfu_op op, struct dfu_entity *dfu,
 				   u64 offset, void *buf, long *len)
diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
index 2dae15937064..fa20d02dbdea 100644
--- a/drivers/dfu/dfu_sf.c
+++ b/drivers/dfu/dfu_sf.c
@@ -13,6 +13,7 @@
 #include <jffs2/load_kernel.h>
 #include <linux/mtd/mtd.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 static int dfu_get_medium_size_sf(struct dfu_entity *dfu, u64 *size)
 {
diff --git a/drivers/dma/apbh_dma.c b/drivers/dma/apbh_dma.c
index da988f6bb667..a2a76aba84a1 100644
--- a/drivers/dma/apbh_dma.c
+++ b/drivers/dma/apbh_dma.c
@@ -14,6 +14,7 @@
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <linux/list.h>
+#include <linux/string.h>
 
 #include <common.h>
 #include <malloc.h>
diff --git a/drivers/dma/keystone_nav.c b/drivers/dma/keystone_nav.c
index 9a5ba79f3fe5..ec8b343de8e3 100644
--- a/drivers/dma/keystone_nav.c
+++ b/drivers/dma/keystone_nav.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/ti-common/keystone_nav.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct qm_config qm_memmap = {
 	.stat_cfg	= KS2_QM_QUEUE_STATUS_BASE,
diff --git a/drivers/dma/sandbox-dma-test.c b/drivers/dma/sandbox-dma-test.c
index a19e5e37fb9d..b4016aba8f4b 100644
--- a/drivers/dma/sandbox-dma-test.c
+++ b/drivers/dma/sandbox-dma-test.c
@@ -16,6 +16,7 @@
 #include <dt-structs.h>
 #include <errno.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define SANDBOX_DMA_CH_CNT 3
 #define SANDBOX_DMA_BUF_SIZE 1024
diff --git a/drivers/dma/ti-edma3.c b/drivers/dma/ti-edma3.c
index 31ffff07f5b3..c1071f562675 100644
--- a/drivers/dma/ti-edma3.c
+++ b/drivers/dma/ti-edma3.c
@@ -17,6 +17,7 @@
 #include <asm/omap_common.h>
 #include <asm/ti-common/ti-edma3.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define EDMA3_SL_BASE(slot)			(0x4000 + ((slot) << 5))
 #define EDMA3_SL_MAX_NUM			512
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 4f2effd39a80..495f1d3cd326 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -31,6 +31,7 @@
 #include <linux/soc/ti/ti-udma.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/cppi5.h>
+#include <linux/string.h>
 
 #include "k3-udma-hwdef.h"
 #include "k3-psil-priv.h"
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 5fcadcdf503d..f8f5356ac173 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -13,6 +13,7 @@
 #include <part.h>
 #include <stdlib.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /**
  * image_size - final fastboot image size
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 4e9d9b719c6f..881cfe8c2b16 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -16,6 +16,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
+#include <linux/string.h>
 
 /**
  * fastboot_buf_addr - base address of the fastboot download buffer
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 8cb8ffa2c6c8..26ba4a721d99 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -13,6 +13,7 @@
 #include <part.h>
 #include <version.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 static void getvar_version(char *var_parameter, char *response);
 static void getvar_version_bootloader(char *var_parameter, char *response);
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 060918e49109..bbda9a274a8b 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -18,6 +18,7 @@
 #include <div64.h>
 #include <linux/compat.h>
 #include <android_image.h>
+#include <linux/string.h>
 
 #define BOOT_PARTITION_NAME "boot"
 
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index bbe26ddcc9be..81494efc0be0 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <common.h>
 #include <blk.h>
+#include <linux/string.h>
 
 #include <fastboot.h>
 #include <image-sparse.h>
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 8c17b19eaf57..010934679574 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -19,6 +19,7 @@
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 4bf9f6041fec..f0dd14edef6f 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -17,6 +17,7 @@
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c6b9efab41cd..448ba509170f 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -23,6 +23,7 @@
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
+#include <linux/string.h>
 
 #define DRIVER_NAME "psci"
 
diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
index db927fb21405..0b3fefd588f5 100644
--- a/drivers/firmware/scmi/optee_agent.c
+++ b/drivers/firmware/scmi/optee_agent.c
@@ -18,6 +18,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 
 #include "smt.h"
 
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 031882998dfa..d6de80e79c0d 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/scmi_test.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 
 /*
  * The sandbox SCMI agent driver simulates to some extend a SCMI message
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 509ed618a997..79d53ae6eb9a 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/string.h>
 
 #include "smt.h"
 
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 72f572d82484..508d4ddabc37 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/soc/ti/k3-sec-proxy.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/string.h>
 
 #include "ti_sci.h"
 #include "ti_sci_static_data.h"
diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index 81e6d8ffc0bd..0ffa964f2b3e 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -12,6 +12,7 @@
 #include <altera.h>             /* altera specific definitions */
 #include <lattice.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 
 /* Local static data */
 static int next_desc = FPGA_INVALID_DEVICE;
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index fbb4ea70914a..8bc48081724a 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -12,6 +12,7 @@
 #include <asm/arch/smc_api.h>
 #include <linux/delay.h>
 #include <linux/intel-smc.h>
+#include <linux/string.h>
 
 #define RECONFIG_STATUS_POLL_RESP_TIMEOUT_MS		60000
 #define RECONFIG_STATUS_INTERVAL_DELAY_US		1000000
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index 33adbd215293..58c7fb4ace07 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -23,6 +23,7 @@
 #include <watchdog.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define CFGWDTH_32	1
 #define MIN_BITSTREAM_SIZECHECK	230
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index be58db54275c..5ca1aea38b80 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -12,6 +12,7 @@
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
+#include <linux/string.h>
 
 static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 {
diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 8170c3368ef6..648f18654774 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -18,6 +18,7 @@
 #include <spartan2.h>
 #include <spartan3.h>
 #include <zynqpl.h>
+#include <linux/string.h>
 
 /* Local Static Functions */
 static int xilinx_validate(xilinx_desc *desc, char *fn);
diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index b1f201fb18ba..b1c468f81fed 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/sys_proto.h>
 #include <memalign.h>
+#include <linux/string.h>
 
 #define DUMMY_WORD	0xffffffff
 
diff --git a/drivers/fwu-mdata/gpt_blk.c b/drivers/fwu-mdata/gpt_blk.c
index c7284916c4e0..96a00f827b07 100644
--- a/drivers/fwu-mdata/gpt_blk.c
+++ b/drivers/fwu-mdata/gpt_blk.c
@@ -14,6 +14,7 @@
 #include <memalign.h>
 #include <part.h>
 #include <part_efi.h>
+#include <linux/string.h>
 
 #include <dm/device-internal.h>
 #include <linux/errno.h>
diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 17e451797385..e4387390e96c 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -8,6 +8,7 @@
 #include <fwu.h>
 #include <fwu_mdata.h>
 #include <memalign.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 #include <linux/types.h>
diff --git a/drivers/gpio/74x164_gpio.c b/drivers/gpio/74x164_gpio.c
index 7a7cfe86114b..9dbc001bbaf1 100644
--- a/drivers/gpio/74x164_gpio.c
+++ b/drivers/gpio/74x164_gpio.c
@@ -19,6 +19,7 @@
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <spi.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
index 49672193ffcd..3eb8d1745369 100644
--- a/drivers/gpio/axp_gpio.c
+++ b/drivers/gpio/axp_gpio.c
@@ -14,6 +14,7 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <errno.h>
+#include <linux/string.h>
 
 static int axp_gpio_set_value(struct udevice *dev, unsigned pin, int val);
 
diff --git a/drivers/gpio/da8xx_gpio.c b/drivers/gpio/da8xx_gpio.c
index b310f2dbf651..a260c702961c 100644
--- a/drivers/gpio/da8xx_gpio.c
+++ b/drivers/gpio/da8xx_gpio.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/string.h>
 
 #include "da8xx_gpio.h"
 
diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index e6e919444f5f..4024fbaadcf3 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 #include <reset.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #define GPIO_SWPORT_DR(p)	(0x00 + (p) * 0xc)
 #define GPIO_SWPORT_DDR(p)	(0x04 + (p) * 0xc)
diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
index ca7aa14eeb23..e22bae29d303 100644
--- a/drivers/gpio/gpio-fxl6408.c
+++ b/drivers/gpio/gpio-fxl6408.c
@@ -44,6 +44,7 @@
 #include <i2c.h>
 #include <linux/bitops.h>
 #include <log.h>
+#include <linux/string.h>
 
 #define REG_DEVID_CTRL		0x1
 # define SW_RST			BIT(0)
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7aece85a70ae..3b450258f419 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -25,6 +25,7 @@
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/gpio/gpio_slg7xl45106.c b/drivers/gpio/gpio_slg7xl45106.c
index 4ad06c18b4bd..d2a8a3fd833e 100644
--- a/drivers/gpio/gpio_slg7xl45106.c
+++ b/drivers/gpio/gpio_slg7xl45106.c
@@ -13,6 +13,7 @@
 #include <i2c.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 
 #define SLG7XL45106_REG		0xdb
 
diff --git a/drivers/gpio/hi6220_gpio.c b/drivers/gpio/hi6220_gpio.c
index e287c31b93fc..d08f16cbde72 100644
--- a/drivers/gpio/hi6220_gpio.c
+++ b/drivers/gpio/hi6220_gpio.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <errno.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 static int hi6220_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index 175e460aff54..c6d3997017f4 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <dm/device-internal.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 enum imx_rgpio2p_direction {
 	IMX_RGPIO2P_DIRECTION_IN,
diff --git a/drivers/gpio/intel_gpio.c b/drivers/gpio/intel_gpio.c
index 4a3ec6d63502..6287d2c66b94 100644
--- a/drivers/gpio/intel_gpio.c
+++ b/drivers/gpio/intel_gpio.c
@@ -25,6 +25,7 @@
 #include <dm/acpi.h>
 #include <dm/device-internal.h>
 #include <dt-bindings/gpio/x86-gpio.h>
+#include <linux/string.h>
 
 static int intel_gpio_get_value(struct udevice *dev, uint offset)
 {
diff --git a/drivers/gpio/iproc_gpio.c b/drivers/gpio/iproc_gpio.c
index 7187d3257b90..fe48306e5a92 100644
--- a/drivers/gpio/iproc_gpio.c
+++ b/drivers/gpio/iproc_gpio.c
@@ -11,6 +11,7 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <dm/pinctrl.h>
+#include <linux/string.h>
 
 /*
  * There are five GPIO bank register. Each bank can configure max of 32 gpios.
diff --git a/drivers/gpio/lpc32xx_gpio.c b/drivers/gpio/lpc32xx_gpio.c
index de66c765d11e..48bc001cbb74 100644
--- a/drivers/gpio/lpc32xx_gpio.c
+++ b/drivers/gpio/lpc32xx_gpio.c
@@ -12,6 +12,7 @@
 #include <asm/arch-lpc32xx/gpio.h>
 #include <asm-generic/gpio.h>
 #include <dm.h>
+#include <linux/string.h>
 
 /**
  * LPC32xx GPIOs work in banks but are non-homogeneous:
diff --git a/drivers/gpio/mcp230xx_gpio.c b/drivers/gpio/mcp230xx_gpio.c
index 9f02fd42b35f..02615d6f27ad 100644
--- a/drivers/gpio/mcp230xx_gpio.c
+++ b/drivers/gpio/mcp230xx_gpio.c
@@ -14,6 +14,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/string.h>
 
 enum mcp230xx_type {
 	UNKNOWN = 0,
diff --git a/drivers/gpio/mpc83xx_spisel_boot.c b/drivers/gpio/mpc83xx_spisel_boot.c
index fd26a36a0f94..d3e75e83b309 100644
--- a/drivers/gpio/mpc83xx_spisel_boot.c
+++ b/drivers/gpio/mpc83xx_spisel_boot.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <mapmem.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 struct mpc83xx_spisel_boot {
 	u32 __iomem *spi_cs;
diff --git a/drivers/gpio/mpc8xx_gpio.c b/drivers/gpio/mpc8xx_gpio.c
index 2f6534653313..6e942db2860b 100644
--- a/drivers/gpio/mpc8xx_gpio.c
+++ b/drivers/gpio/mpc8xx_gpio.c
@@ -16,6 +16,7 @@
 #include <mapmem.h>
 #include <asm/gpio.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 enum {
 	MPC8XX_CPM1_PORTA,
diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
index f7ffd8926ade..0bbcce81f01c 100644
--- a/drivers/gpio/mpc8xxx_gpio.c
+++ b/drivers/gpio/mpc8xxx_gpio.c
@@ -15,6 +15,7 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm/of_access.h>
+#include <linux/string.h>
 
 struct mpc8xxx_gpio_data {
 	/* The bank's register base in memory */
diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
index 1dec4e35e0a7..af320511ad8b 100644
--- a/drivers/gpio/mxc_gpio.c
+++ b/drivers/gpio/mxc_gpio.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <dt-structs.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 enum mxc_gpio_direction {
 	MXC_GPIO_DIRECTION_IN,
diff --git a/drivers/gpio/mxs_gpio.c b/drivers/gpio/mxs_gpio.c
index 1356f89ac2f0..1573a0018095 100644
--- a/drivers/gpio/mxs_gpio.c
+++ b/drivers/gpio/mxs_gpio.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/imx-regs.h>
+#include <linux/string.h>
 
 #if	defined(CONFIG_MX23)
 #define	PINCTRL_BANKS		3
diff --git a/drivers/gpio/nmk_gpio.c b/drivers/gpio/nmk_gpio.c
index e1bb41b196cc..f479e74db4b8 100644
--- a/drivers/gpio/nmk_gpio.c
+++ b/drivers/gpio/nmk_gpio.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 struct nmk_gpio_regs {
 	u32 dat;	/* data */
diff --git a/drivers/gpio/nx_gpio.c b/drivers/gpio/nx_gpio.c
index e2565d709535..364fd1ab0113 100644
--- a/drivers/gpio/nx_gpio.c
+++ b/drivers/gpio/nx_gpio.c
@@ -11,6 +11,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/gpio/octeon_gpio.c b/drivers/gpio/octeon_gpio.c
index 2b2465b1bcd2..6899356e5796 100644
--- a/drivers/gpio/octeon_gpio.c
+++ b/drivers/gpio/octeon_gpio.c
@@ -18,6 +18,7 @@
 #include <linux/bitfield.h>
 #include <linux/compat.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/string.h>
 
 /* Returns the bit value to write or read based on the offset */
 #define GPIO_BIT(x)		BIT_ULL((x) & 0x3f)
diff --git a/drivers/gpio/omap_gpio.c b/drivers/gpio/omap_gpio.c
index 50c4f75ddf5d..9b415ef7da85 100644
--- a/drivers/gpio/omap_gpio.c
+++ b/drivers/gpio/omap_gpio.c
@@ -26,6 +26,7 @@
 #include <dm/device-internal.h>
 #include <linux/errno.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index b0c66d18317e..acf5e6fd274e 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -29,6 +29,7 @@
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #define PCA953X_INPUT           0
 #define PCA953X_OUTPUT          1
diff --git a/drivers/gpio/pic32_gpio.c b/drivers/gpio/pic32_gpio.c
index 975a2af3ccb8..4b2df8bac0cb 100644
--- a/drivers/gpio/pic32_gpio.c
+++ b/drivers/gpio/pic32_gpio.c
@@ -13,6 +13,7 @@
 #include <asm/gpio.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 #include <mach/pic32.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/gpio/qe_gpio.c b/drivers/gpio/qe_gpio.c
index 16e8d1eae6ed..49cedee381d8 100644
--- a/drivers/gpio/qe_gpio.c
+++ b/drivers/gpio/qe_gpio.c
@@ -11,6 +11,7 @@
 #include <asm/immap_83xx.h>
 #include <asm/io.h>
 #include <dm/of_access.h>
+#include <linux/string.h>
 
 #define QE_DIR_NONE	0
 #define QE_DIR_OUT	1
diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 4a6ae554bf78..3ea4c96d094d 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -18,6 +18,7 @@
 #include <dm/pinctrl.h>
 #include <dm/read.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <linux/string.h>
 
 #define SWPORT_DR		0x0000
 #define SWPORT_DDR		0x0004
diff --git a/drivers/gpio/sifive-gpio.c b/drivers/gpio/sifive-gpio.c
index 151f484e8fd1..459436610f61 100644
--- a/drivers/gpio/sifive-gpio.c
+++ b/drivers/gpio/sifive-gpio.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <asm/gpio.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 static int sifive_gpio_probe(struct udevice *dev)
 {
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index f0b42e4fdb7d..541283c7ada6 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/string.h>
 
 #if !CONFIG_IS_ENABLED(DM_GPIO)
 static int sunxi_gpio_output(u32 pin, u32 val)
diff --git a/drivers/gpio/xilinx_gpio.c b/drivers/gpio/xilinx_gpio.c
index fa8d630b4658..f90cf759633f 100644
--- a/drivers/gpio/xilinx_gpio.c
+++ b/drivers/gpio/xilinx_gpio.c
@@ -12,6 +12,7 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/string.h>
 
 #define XILINX_GPIO_MAX_BANK	2
 
diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
index 71a56127c0aa..cd2d1e269cbb 100644
--- a/drivers/gpio/zynq_gpio.c
+++ b/drivers/gpio/zynq_gpio.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <dm.h>
 #include <fdtdec.h>
+#include <linux/string.h>
 
 /* Maximum banks */
 #define ZYNQ_GPIO_MAX_BANK	4
diff --git a/drivers/gpio/zynqmp_gpio_modepin.c b/drivers/gpio/zynqmp_gpio_modepin.c
index e9565ff5430e..4e4e1b114fc5 100644
--- a/drivers/gpio/zynqmp_gpio_modepin.c
+++ b/drivers/gpio/zynqmp_gpio_modepin.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <asm/arch/hardware.h>
 #include <zynqmp_firmware.h>
+#include <linux/string.h>
 
 #define OUTEN(pin)		(BIT(0) << (pin))
 #define INVAL(pin)		(BIT(4) << (pin))
diff --git a/drivers/i2c/fsl_i2c.c b/drivers/i2c/fsl_i2c.c
index d9d8ee81d2ed..1551aa09d5a8 100644
--- a/drivers/i2c/fsl_i2c.c
+++ b/drivers/i2c/fsl_i2c.c
@@ -18,6 +18,7 @@
 #include <dm.h>
 #include <mapmem.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /* The maximum number of microseconds we will wait until another master has
  * released the bus.  If not defined in the board header file, then use a
diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index 8867a560bd8e..6d8c950e64bb 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -20,6 +20,7 @@
 #include <asm/gpio.h>
 #endif
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "acpi_i2c.h"
 
 #define I2C_MAX_OFFSET_LEN	4
diff --git a/drivers/i2c/ihs_i2c.c b/drivers/i2c/ihs_i2c.c
index d715714638ff..b9e83d518feb 100644
--- a/drivers/i2c/ihs_i2c.c
+++ b/drivers/i2c/ihs_i2c.c
@@ -13,6 +13,7 @@
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct ihs_i2c_priv {
 	uint speed;
diff --git a/drivers/i2c/intel_i2c.c b/drivers/i2c/intel_i2c.c
index bbc527ffddc8..e9ca78510b88 100644
--- a/drivers/i2c/intel_i2c.c
+++ b/drivers/i2c/intel_i2c.c
@@ -14,6 +14,7 @@
 #include <pci.h>
 #include <time.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 /* PCI Configuration Space (D31:F3): SMBus */
 #define SMB_BASE		0x20
diff --git a/drivers/i2c/lpc32xx_i2c.c b/drivers/i2c/lpc32xx_i2c.c
index 496f4feec566..5d75b50d1034 100644
--- a/drivers/i2c/lpc32xx_i2c.c
+++ b/drivers/i2c/lpc32xx_i2c.c
@@ -15,6 +15,7 @@
 #include <asm/arch/i2c.h>
 #include <dm.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 /*
  * Provide default speed and slave if target did not
diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
index a5d1bb0576db..baa47c8c06ae 100644
--- a/drivers/i2c/muxes/i2c-mux-uclass.c
+++ b/drivers/i2c/muxes/i2c-mux-uclass.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <dm/lists.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 /**
  * struct i2c_mux: Information the uclass stores about an I2C mux
diff --git a/drivers/i2c/mv_i2c.c b/drivers/i2c/mv_i2c.c
index 5bc9cd7b295a..6793184e04b4 100644
--- a/drivers/i2c/mv_i2c.c
+++ b/drivers/i2c/mv_i2c.c
@@ -22,6 +22,7 @@
 #include <log.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "mv_i2c.h"
 
 /* All transfers are described by this data structure */
diff --git a/drivers/i2c/mvtwsi.c b/drivers/i2c/mvtwsi.c
index 14cdb0f66351..9a36c3296b9d 100644
--- a/drivers/i2c/mvtwsi.c
+++ b/drivers/i2c/mvtwsi.c
@@ -21,6 +21,7 @@
 #include <dm.h>
 #include <reset.h>
 #endif
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index 914ea2c06487..2e046b7bfc0d 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /* STM32 I2C registers */
 struct stm32_i2c_regs {
diff --git a/drivers/i2c/tegra186_bpmp_i2c.c b/drivers/i2c/tegra186_bpmp_i2c.c
index 588f6bdcc4b4..1aa2c1175ad4 100644
--- a/drivers/i2c/tegra186_bpmp_i2c.c
+++ b/drivers/i2c/tegra186_bpmp_i2c.c
@@ -11,6 +11,7 @@
 #include <asm/arch-tegra/bpmp_abi.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/i2c/tegra_i2c.c b/drivers/i2c/tegra_i2c.c
index 57d77d56ea55..47e5cfaad32f 100644
--- a/drivers/i2c/tegra_i2c.c
+++ b/drivers/i2c/tegra_i2c.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 enum i2c_type {
 	TYPE_114,
diff --git a/drivers/input/apple_spi_kbd.c b/drivers/input/apple_spi_kbd.c
index 7cf12f453a30..d10216de362f 100644
--- a/drivers/input/apple_spi_kbd.c
+++ b/drivers/input/apple_spi_kbd.c
@@ -11,6 +11,7 @@
 #include <asm-generic/gpio.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/string.h>
 
 /*
  * The Apple SPI keyboard controller implements a protocol that
diff --git a/drivers/input/button_kbd.c b/drivers/input/button_kbd.c
index 74fadfca8bb8..191b58ea5185 100644
--- a/drivers/input/button_kbd.c
+++ b/drivers/input/button_kbd.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/string.h>
 
 /**
  * struct button_kbd_priv - driver private data
diff --git a/drivers/input/cros_ec_keyb.c b/drivers/input/cros_ec_keyb.c
index c4853463739b..19514134b44b 100644
--- a/drivers/input/cros_ec_keyb.c
+++ b/drivers/input/cros_ec_keyb.c
@@ -14,6 +14,7 @@
 #include <key_matrix.h>
 #include <log.h>
 #include <stdio_dev.h>
+#include <linux/string.h>
 
 enum {
 	KBC_MAX_KEYS		= 8,	/* Maximum keys held down at once */
diff --git a/drivers/input/i8042.c b/drivers/input/i8042.c
index e6070ca01529..db58a126903d 100644
--- a/drivers/input/i8042.c
+++ b/drivers/input/i8042.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index d5ed5ac65019..d95422f45cda 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -19,6 +19,7 @@
 #endif
 #include <time.h>
 #include <linux/input.h>
+#include <linux/string.h>
 
 enum {
 	/* These correspond to the lights on the keyboard */
diff --git a/drivers/input/key_matrix.c b/drivers/input/key_matrix.c
index e2fb2e170787..a82c0f90bcbd 100644
--- a/drivers/input/key_matrix.c
+++ b/drivers/input/key_matrix.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/input.h>
+#include <linux/string.h>
 
 /**
  * Determine if the current keypress configuration can cause key ghosting
diff --git a/drivers/input/keyboard-uclass.c b/drivers/input/keyboard-uclass.c
index aefc8e825e20..7a014cd33c41 100644
--- a/drivers/input/keyboard-uclass.c
+++ b/drivers/input/keyboard-uclass.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <keyboard.h>
 #include <log.h>
+#include <linux/string.h>
 
 static int keyboard_start(struct stdio_dev *sdev)
 {
diff --git a/drivers/input/tegra-kbc.c b/drivers/input/tegra-kbc.c
index cf11d57fdeff..c1782e56802d 100644
--- a/drivers/input/tegra-kbc.c
+++ b/drivers/input/tegra-kbc.c
@@ -20,6 +20,7 @@
 #include <asm/arch-tegra/timer.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/string.h>
 
 enum {
 	KBC_MAX_GPIO		= 24,
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 6ecd84303bc2..56eaf6c8c7a7 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -10,6 +10,7 @@
 #include <lmb.h>
 #include <memalign.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define DART_PARAMS2		0x0004
 #define  DART_PARAMS2_BYPASS_SUPPORT	BIT(0)
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 68ca3c29702b..836b2315e0f5 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -13,6 +13,7 @@
 #include <dm/device-internal.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 int led_get_by_label(const char *label, struct udevice **devp)
 {
diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index f511a529b1e6..3b0ad7d93f6f 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/omap_gpmc.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include "ti-gpmc.h"
 
 enum gpmc_clk_domain {
diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index d3c515828ffd..7f935e1535c1 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/bitrev.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #define ATSHA204A_TWLO_US		60
diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.c
index ba3a599c4a51..9b55ede90a0c 100644
--- a/drivers/misc/cbmem_console.c
+++ b/drivers/misc/cbmem_console.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <console.h>
 #include <asm/cb_sysinfo.h>
+#include <linux/string.h>
 
 void cbmemc_putc(struct stdio_dev *dev, char data)
 {
diff --git a/drivers/misc/cros_ec.c b/drivers/misc/cros_ec.c
index 060cb5124da9..556afe5e5e3b 100644
--- a/drivers/misc/cros_ec.c
+++ b/drivers/misc/cros_ec.c
@@ -32,6 +32,7 @@
 #include <dm/device-internal.h>
 #include <dm/of_extra.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 #ifdef DEBUG_TRACE
 #define debug_trace(fmt, b...)	debug(fmt, #b)
diff --git a/drivers/misc/cros_ec_i2c.c b/drivers/misc/cros_ec_i2c.c
index a1b78a3045dd..da15cbe649fb 100644
--- a/drivers/misc/cros_ec_i2c.c
+++ b/drivers/misc/cros_ec_i2c.c
@@ -17,6 +17,7 @@
 #include <i2c.h>
 #include <cros_ec.h>
 #include <log.h>
+#include <linux/string.h>
 
 #ifdef DEBUG_TRACE
 #define debug_trace(fmt, b...)	debug(fmt, #b)
diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 0a9ede73c855..38b2ae21065a 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <os.h>
 #include <time.h>
+#include <linux/string.h>
 #include <u-boot/sha256.h>
 #include <spi.h>
 #include <asm/malloc.h>
diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
index d78890162571..ae3a32090a81 100644
--- a/drivers/misc/cros_ec_spi.c
+++ b/drivers/misc/cros_ec_spi.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <spi.h>
 #include <time.h>
+#include <linux/string.h>
 
 int cros_ec_spi_packet(struct udevice *udev, int out_bytes, int in_bytes)
 {
diff --git a/drivers/misc/ds4510.c b/drivers/misc/ds4510.c
index 9340596f2c63..93c5a0217007 100644
--- a/drivers/misc/ds4510.c
+++ b/drivers/misc/ds4510.c
@@ -12,6 +12,7 @@
 #include <i2c.h>
 #include <command.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "ds4510.h"
 
 enum {
diff --git a/drivers/misc/fsl_portals.c b/drivers/misc/fsl_portals.c
index 6b831281e96f..633e3b9be1b9 100644
--- a/drivers/misc/fsl_portals.c
+++ b/drivers/misc/fsl_portals.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/drivers/misc/gdsys_ioep.c b/drivers/misc/gdsys_ioep.c
index 145cfa23c6c5..c2820e811ba4 100644
--- a/drivers/misc/gdsys_ioep.c
+++ b/drivers/misc/gdsys_ioep.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <misc.h>
 #include <regmap.h>
+#include <linux/string.h>
 
 #include "gdsys_ioep.h"
 
diff --git a/drivers/misc/gsc.c b/drivers/misc/gsc.c
index 65c9c2c6ce37..ec1791b59819 100644
--- a/drivers/misc/gsc.c
+++ b/drivers/misc/gsc.c
@@ -13,6 +13,7 @@
 #include <dm/device-internal.h>
 #include <dm/ofnode.h>
 #include <dm/read.h>
+#include <linux/string.h>
 
 #define GSC_BUSNO	0
 #define GSC_SC_ADDR	0x20
diff --git a/drivers/misc/i2c_eeprom_emul.c b/drivers/misc/i2c_eeprom_emul.c
index 6f32087ede56..8c285916847f 100644
--- a/drivers/misc/i2c_eeprom_emul.c
+++ b/drivers/misc/i2c_eeprom_emul.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 #ifdef DEBUG
 #define debug_buffer print_buffer
diff --git a/drivers/misc/ihs_fpga.c b/drivers/misc/ihs_fpga.c
index a0fece985d85..7f684dfa09e8 100644
--- a/drivers/misc/ihs_fpga.c
+++ b/drivers/misc/ihs_fpga.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ihs_fpga.h"
 
diff --git a/drivers/misc/misc_sandbox.c b/drivers/misc/misc_sandbox.c
index 31cde2dbac07..e4ee593063fe 100644
--- a/drivers/misc/misc_sandbox.c
+++ b/drivers/misc/misc_sandbox.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <misc.h>
+#include <linux/string.h>
 
 struct misc_sandbox_priv {
 	u8 mem[128];
diff --git a/drivers/misc/mpc83xx_serdes.c b/drivers/misc/mpc83xx_serdes.c
index 93c87e998c4f..639a329d828b 100644
--- a/drivers/misc/mpc83xx_serdes.c
+++ b/drivers/misc/mpc83xx_serdes.c
@@ -15,6 +15,7 @@
 #include <mapmem.h>
 #include <misc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "mpc83xx_serdes.h"
 
diff --git a/drivers/misc/npcm_host_intf.c b/drivers/misc/npcm_host_intf.c
index 79f57f57d89c..0caedd480283 100644
--- a/drivers/misc/npcm_host_intf.c
+++ b/drivers/misc/npcm_host_intf.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 
 #define SMC_CTL_REG_ADDR	0xc0001001
 #define SMC_CTL_HOSTWAIT	0x80
diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index 7c01bf23d53b..125b9f527b7e 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -19,6 +19,7 @@
 #include <misc.h>
 #include <tables_csum.h>
 #include <asm/acpi_table.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_GENERATE_ACPI_TABLE) && !defined(CONFIG_SANDBOX)
 /*
diff --git a/drivers/misc/qfw_sandbox.c b/drivers/misc/qfw_sandbox.c
index 1002df75339e..5a2fe4212386 100644
--- a/drivers/misc/qfw_sandbox.c
+++ b/drivers/misc/qfw_sandbox.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <dm/device.h>
 #include <qfw.h>
+#include <linux/string.h>
 
 struct qfw_sandbox_plat {
 	u8 file_dir_offset;
diff --git a/drivers/misc/rockchip-efuse.c b/drivers/misc/rockchip-efuse.c
index 2f96b79ea407..a0f0767e7dfd 100644
--- a/drivers/misc/rockchip-efuse.c
+++ b/drivers/misc/rockchip-efuse.c
@@ -16,6 +16,7 @@
 #include <linux/iopoll.h>
 #include <malloc.h>
 #include <misc.h>
+#include <linux/string.h>
 
 #define EFUSE_CTRL		0x0000
 #define RK3036_A_SHIFT		8
diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
index 4814e0e501c9..bded6ac8f6c3 100644
--- a/drivers/misc/rockchip-otp.c
+++ b/drivers/misc/rockchip-otp.c
@@ -13,6 +13,7 @@
 #include <linux/iopoll.h>
 #include <malloc.h>
 #include <misc.h>
+#include <linux/string.h>
 
 /* OTP Register Offsets */
 #define OTPC_SBPI_CTRL			0x0020
diff --git a/drivers/misc/sifive-otp.c b/drivers/misc/sifive-otp.c
index a624a358802c..f59b54807d45 100644
--- a/drivers/misc/sifive-otp.c
+++ b/drivers/misc/sifive-otp.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <misc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define BYTES_PER_FUSE		4
 
diff --git a/drivers/misc/tegra186_bpmp.c b/drivers/misc/tegra186_bpmp.c
index fecac9c4d902..83ad9ab218e8 100644
--- a/drivers/misc/tegra186_bpmp.c
+++ b/drivers/misc/tegra186_bpmp.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define BPMP_IVC_FRAME_COUNT 1
 #define BPMP_IVC_FRAME_SIZE 128
diff --git a/drivers/misc/usb251xb.c b/drivers/misc/usb251xb.c
index 92e92ba5e624..873969b29a46 100644
--- a/drivers/misc/usb251xb.c
+++ b/drivers/misc/usb251xb.c
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <i2c.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/utf.h>
 #include <power/regulator.h>
 
diff --git a/drivers/misc/vexpress_config.c b/drivers/misc/vexpress_config.c
index 2baca48109f9..410f480979a3 100644
--- a/drivers/misc/vexpress_config.c
+++ b/drivers/misc/vexpress_config.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <misc.h>
+#include <linux/string.h>
 
 #define SYS_CFGDATA		0xa0
 
diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
index a17ed8c11cbe..ae7f28ce9f6e 100644
--- a/drivers/mmc/ca_dw_mmc.c
+++ b/drivers/mmc/ca_dw_mmc.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <mapmem.h>
+#include <linux/string.h>
 
 #define SD_CLK_SEL_MASK (0x3)
 #define SD_DLL_DEFAULT  (0x143000)
diff --git a/drivers/mmc/davinci_mmc.c b/drivers/mmc/davinci_mmc.c
index 3a3d23aec00a..c8982f0c1c3a 100644
--- a/drivers/mmc/davinci_mmc.c
+++ b/drivers/mmc/davinci_mmc.c
@@ -17,6 +17,7 @@
 #include <asm/arch/sdmmc_defs.h>
 #include <asm-generic/gpio.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define WATCHDOG_COUNT		(100000)
 
diff --git a/drivers/mmc/f_sdh30.c b/drivers/mmc/f_sdh30.c
index 3d587a464d50..4bee8e34c955 100644
--- a/drivers/mmc/f_sdh30.c
+++ b/drivers/mmc/f_sdh30.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <malloc.h>
 #include <sdhci.h>
+#include <linux/string.h>
 
 #define F_SDH30_ESD_CONTROL		0x124
 #define F_SDH30_CMD_DAT_DELAY		BIT(9)
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 57cfa2b31a99..1f2964ae114f 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <malloc.h>
 #include <fsl_esdhc_imx.h>
diff --git a/drivers/mmc/fsl_esdhc_spl.c b/drivers/mmc/fsl_esdhc_spl.c
index 6d7c0cff22a5..2b88354a733e 100644
--- a/drivers/mmc/fsl_esdhc_spl.c
+++ b/drivers/mmc/fsl_esdhc_spl.c
@@ -8,6 +8,7 @@
 #include <hang.h>
 #include <mmc.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #ifndef CFG_SYS_MMC_U_BOOT_OFFS
 extern uchar mmc_u_boot_offs[];
diff --git a/drivers/mmc/ftsdc010_mci.c b/drivers/mmc/ftsdc010_mci.c
index 8d60687dbd34..9459cbe7e95f 100644
--- a/drivers/mmc/ftsdc010_mci.c
+++ b/drivers/mmc/ftsdc010_mci.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <asm/byteorder.h>
 #include <faraday/ftsdc010.h>
+#include <linux/string.h>
 #include "ftsdc010_mci.h"
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/mmc/iproc_sdhci.c b/drivers/mmc/iproc_sdhci.c
index 11d86ad658f9..70f32bf92857 100644
--- a/drivers/mmc/iproc_sdhci.c
+++ b/drivers/mmc/iproc_sdhci.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <sdhci.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "mmc_private.h"
 #include <linux/delay.h>
 
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index ca6e2bd01b29..7ef3a0aa780d 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include "meson_gx_mmc.h"
 
 bool meson_gx_mmc_is_compatible(struct udevice *dev,
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee9339152c10..766fb11f67f3 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/mmc/mmc_spi.c b/drivers/mmc/mmc_spi.c
index bcea800e5f61..ff7f871edfd1 100644
--- a/drivers/mmc/mmc_spi.c
+++ b/drivers/mmc/mmc_spi.c
@@ -14,6 +14,7 @@
 #include <mmc.h>
 #include <stdlib.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <linux/crc7.h>
 #include <asm/byteorder.h>
diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 604f9c3ff99c..ffa478992494 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
diff --git a/drivers/mmc/mxcmmc.c b/drivers/mmc/mxcmmc.c
index 0057273a2a76..5ca4a5140e1b 100644
--- a/drivers/mmc/mxcmmc.c
+++ b/drivers/mmc/mxcmmc.c
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
+#include <linux/string.h>
 
 #define DRIVER_NAME "mxc-mmc"
 
diff --git a/drivers/mmc/mxsmmc.c b/drivers/mmc/mxsmmc.c
index 35a8e21058ed..5f2337236433 100644
--- a/drivers/mmc/mxsmmc.c
+++ b/drivers/mmc/mxsmmc.c
@@ -33,6 +33,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/dma.h>
 #include <bouncebuf.h>
+#include <linux/string.h>
 
 #define	MXSMMC_MAX_TIMEOUT	10000
 #define MXSMMC_SMALL_TRANSFER	512
diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index 4ee62df9d408..ec1a0f99a75f 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -18,6 +18,7 @@
 #include <part.h>
 #include <pci.h>
 #include <pci_ids.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <time.h>
 #include <watchdog.h>
diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
index b68d98573c9a..b692f80b5201 100644
--- a/drivers/mmc/rpmb.c
+++ b/drivers/mmc/rpmb.c
@@ -13,6 +13,7 @@
 #include <memalign.h>
 #include <mmc.h>
 #include <sdhci.h>
+#include <linux/string.h>
 #include <u-boot/sha256.h>
 #include "mmc_private.h"
 
diff --git a/drivers/mmc/sandbox_mmc.c b/drivers/mmc/sandbox_mmc.c
index 0ba7940a4dbf..e1441439827b 100644
--- a/drivers/mmc/sandbox_mmc.c
+++ b/drivers/mmc/sandbox_mmc.c
@@ -13,6 +13,7 @@
 #include <mmc.h>
 #include <os.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 struct sandbox_mmc_plat {
 	struct mmc_config cfg;
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index b30ea6149939..9a5bf7020b38 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/printk.h>
 #include <phys2bus.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 static void sdhci_reset(struct sdhci_host *host, u8 mask)
diff --git a/drivers/mmc/sh_mmcif.c b/drivers/mmc/sh_mmcif.c
index 76dc1c68b821..5fbf1e44ed52 100644
--- a/drivers/mmc/sh_mmcif.c
+++ b/drivers/mmc/sh_mmcif.c
@@ -21,6 +21,7 @@
 #include <linux/compat.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include "sh_mmcif.h"
 #include <asm/global_data.h>
 
diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 50a8805e736b..542f7ac6a991 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -17,6 +17,7 @@
 #include <linux/libfdt.h>
 #include <linux/err.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #define CLOCK_MIN		400000	/*  400 kHz */
 #define FIFO_MIN		8
diff --git a/drivers/mmc/sti_sdhci.c b/drivers/mmc/sti_sdhci.c
index 23a1dd43c9b2..f4ad9fa0f12e 100644
--- a/drivers/mmc/sti_sdhci.c
+++ b/drivers/mmc/sti_sdhci.c
@@ -13,6 +13,7 @@
 #include <asm/arch/sdhci.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 628727aa7087..e8dc12625d39 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -28,6 +28,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/mmc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #ifndef CCM_MMC_CTRL_MODE_SEL_NEW
 #define CCM_MMC_CTRL_MODE_SEL_NEW	0
diff --git a/drivers/mmc/xenon_sdhci.c b/drivers/mmc/xenon_sdhci.c
index 27dbe0404e04..dae3c238b94f 100644
--- a/drivers/mmc/xenon_sdhci.c
+++ b/drivers/mmc/xenon_sdhci.c
@@ -24,6 +24,7 @@
 #include <malloc.h>
 #include <sdhci.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index d31391f36a47..69a4fcdb1403 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index c14d8cd98c62..5d2525fb6b95 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -34,6 +34,7 @@
 #include <asm/unaligned.h>
 #include <env_internal.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <mtd/cfi_flash.h>
 #include <watchdog.h>
 
diff --git a/drivers/mtd/cfi_mtd.c b/drivers/mtd/cfi_mtd.c
index bf4473ba9e83..9c12d1867afd 100644
--- a/drivers/mtd/cfi_mtd.c
+++ b/drivers/mtd/cfi_mtd.c
@@ -9,6 +9,7 @@
 #include <dma.h>
 #include <flash.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c
index 14ce726b10d8..aef0d3a23426 100644
--- a/drivers/mtd/mtd_uboot.c
+++ b/drivers/mtd/mtd_uboot.c
@@ -15,6 +15,7 @@
 #include <linux/mtd/partitions.h>
 #include <asm/global_data.h>
 #include <mtd.h>
+#include <linux/string.h>
 
 #define MTD_NAME_MAX_LEN 20
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 4886392a1cfa..3dc0ef236af5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/compat.h>
 #include <ubi_uboot.h>
+#include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 2b29c8def6d4..4808432911fb 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -35,6 +35,7 @@
  *	Copyright (C) 2022 Microchip Technology Inc.
  *
  * A few words about the naming convention in this file. This convention
+#include <linux/string.h>
  * applies to structure and function names.
  *
  * Prefixes:
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index e2e3f1ee6b5c..c33fb978792e 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -45,6 +45,7 @@
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "pmecc.h"
 #include <dm/uclass.h>
 #include <dm/device_compat.h>
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 6b17e744a692..73c2d76e2405 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -20,6 +20,7 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <malloc.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 6c4ccc2607b3..59ad1f1ed1b5 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -30,6 +30,7 @@
 #include <linux/mtd/rawnand.h>
 #include <asm/processor.h>
 #include <dm.h>
+#include <linux/string.h>
 
 #include "brcmnand.h"
 #include "brcmnand_compat.h"
diff --git a/drivers/mtd/nand/raw/cortina_nand.c b/drivers/mtd/nand/raw/cortina_nand.c
index b7be6602f7cc..acb2cef8ed6b 100644
--- a/drivers/mtd/nand/raw/cortina_nand.c
+++ b/drivers/mtd/nand/raw/cortina_nand.c
@@ -21,6 +21,7 @@
 #include <fdtdec.h>
 #include <bouncebuf.h>
 #include <dm.h>
+#include <linux/string.h>
 #include "cortina_nand.h"
 
 static unsigned int *pread, *pwrite;
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index c827f80281c1..8be81c69321a 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/string.h>
 
 #include "denali.h"
 
diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denali_spl.c
index 690279c9976b..3e2324f26c50 100644
--- a/drivers/mtd/nand/raw/denali_spl.c
+++ b/drivers/mtd/nand/raw/denali_spl.c
@@ -10,6 +10,7 @@
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/string.h>
 #include "denali.h"
 
 #define DENALI_MAP01		(1 << 26)	/* read/write pages in PIO */
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index ac2e669d46b3..aeb33a9d2d09 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -13,6 +13,7 @@
  *
  * Consequently, pages with meaningful in-band data are written with
  * blank (all-ones) out-of-band data and a valid ECC, and any later
+#include <linux/string.h>
  * out-of-band data write will void the ECC.
  *
  * Therefore, code which reads such late-written out-of-band data
diff --git a/drivers/mtd/nand/raw/mt7621_nand.c b/drivers/mtd/nand/raw/mt7621_nand.c
index f6eddb84a9b8..45fed90ccef6 100644
--- a/drivers/mtd/nand/raw/mt7621_nand.c
+++ b/drivers/mtd/nand/raw/mt7621_nand.c
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 #include "mt7621_nand.h"
 
 /* NFI core registers */
diff --git a/drivers/mtd/nand/raw/mt7621_nand_spl.c b/drivers/mtd/nand/raw/mt7621_nand_spl.c
index 114fc8b7ceac..3adff352db81 100644
--- a/drivers/mtd/nand/raw/mt7621_nand_spl.c
+++ b/drivers/mtd/nand/raw/mt7621_nand_spl.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/string.h>
 #include "mt7621_nand.h"
 
 static struct mt7621_nfc nfc_dev;
diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index 6abdc24bd30c..7d90ebab1ab8 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define HC_CFG			0x0
 #define HC_CFG_IF_CFG(x)	((x) << 27)
diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index 65eab4c8088a..74a3a42e9508 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/math64.h>
 
diff --git a/drivers/mtd/nand/raw/mxs_nand_spl.c b/drivers/mtd/nand/raw/mxs_nand_spl.c
index 65680f740169..d32babc76ecb 100644
--- a/drivers/mtd/nand/raw/mxs_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxs_nand_spl.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/string.h>
 
 static struct mtd_info *mtd;
 static struct nand_chip nand_chip;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 2dbbb40b49c0..6a4240a1fbf8 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -48,6 +48,7 @@
 #endif
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 /* Define default oob placement schemes for large and small page devices */
 #ifndef CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index bb48ebbb96c7..5733bcb9c624 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <dm/devres.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 /*#include <asm/io.h>*/
 #include <linux/types.h>
 
diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nand/raw/nand_spl_loaders.c
index 156b44d83581..4a821ab35c63 100644
--- a/drivers/mtd/nand/raw/nand_spl_loaders.c
+++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
@@ -1,3 +1,4 @@
+#include <linux/string.h>
 int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 {
 	unsigned int block, lastblock;
diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand_util.c
index 72cc24f40376..1069f5a3e918 100644
--- a/drivers/mtd/nand/raw/nand_util.c
+++ b/drivers/mtd/nand/raw/nand_util.c
@@ -27,6 +27,7 @@
 #include <div64.h>
 #include <asm/cache.h>
 #include <dm/devres.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/octeontx_bch.c b/drivers/mtd/nand/raw/octeontx_bch.c
index 056a6857822f..674cc44ef588 100644
--- a/drivers/mtd/nand/raw/octeontx_bch.c
+++ b/drivers/mtd/nand/raw/octeontx_bch.c
@@ -25,6 +25,7 @@
 #include <asm/types.h>
 #include <asm/dma-mapping.h>
 #include <asm/arch/clock.h>
+#include <linux/string.h>
 #include "octeontx_bch.h"
 
 static LIST_HEAD(octeontx_bch_devices);
diff --git a/drivers/mtd/nand/raw/octeontx_nand.c b/drivers/mtd/nand/raw/octeontx_nand.c
index 65a03d22c1db..e6b0056c914c 100644
--- a/drivers/mtd/nand/raw/octeontx_nand.c
+++ b/drivers/mtd/nand/raw/octeontx_nand.c
@@ -29,6 +29,7 @@
 #include <asm/types.h>
 #include <asm/dma-mapping.h>
 #include <asm/arch/clock.h>
+#include <linux/string.h>
 #include "octeontx_bch.h"
 
 /*
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 1a5ed0de31a9..6ff8ff4c975f 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <dm/uclass.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 #include <asm/arch/mem.h>
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 5f92dd8e7415..9e388bc4b260 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <syscon.h>
 #include <regmap.h>
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index 0c8b0e8c6901..aabc42b8a07f 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/rawnand.h>
 #include <memalign.h>
 #include <nand.h>
+#include <linux/string.h>
 
 /*
  * NFC Page Data Layout:
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index bcd03f0a5473..71736eb230a8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/kernel.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 6de0b0a35545..4fc14bb4a024 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/string.h>
 
 /* registers */
 #define NFC_CTL                    0x00000000
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 6086ecdfa3db..bb63d6ec8393 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -25,6 +25,7 @@
 #include <bouncebuf.h>
 #include <dm.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "tegra_nand.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 8736dd289b48..6dba9ab2030d 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -26,6 +26,7 @@
 #include <time.h>
 #include <dm/device_compat.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b8326df0598d..1e3f3b222262 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 8f11472ee23d..f1694c487884 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -28,6 +28,7 @@
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "linux/mtd/flashchip.h"
 #include <linux/mtd/onenand.h>
 
diff --git a/drivers/mtd/onenand/onenand_bbt.c b/drivers/mtd/onenand/onenand_bbt.c
index cc1e449f4a72..026280e5e629 100644
--- a/drivers/mtd/onenand/onenand_bbt.c
+++ b/drivers/mtd/onenand/onenand_bbt.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/onenand.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 
diff --git a/drivers/mtd/onenand/onenand_spl.c b/drivers/mtd/onenand/onenand_spl.c
index 2699958a5de2..056e56e31cff 100644
--- a/drivers/mtd/onenand/onenand_spl.c
+++ b/drivers/mtd/onenand/onenand_spl.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/onenand_regs.h>
 #include <onenand_uboot.h>
+#include <linux/string.h>
 
 /*
  * Device geometry:
diff --git a/drivers/mtd/onenand/onenand_uboot.c b/drivers/mtd/onenand/onenand_uboot.c
index 04791df69bb0..40041fa00eba 100644
--- a/drivers/mtd/onenand/onenand_uboot.c
+++ b/drivers/mtd/onenand/onenand_uboot.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
+#include <linux/string.h>
 
 struct mtd_info onenand_mtd;
 struct onenand_chip onenand_chip;
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index c415e5149a01..27143d4d0a5c 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/samsung_onenand.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <linux/errno.h>
diff --git a/drivers/mtd/spi/fsl_espi_spl.c b/drivers/mtd/spi/fsl_espi_spl.c
index cdbdbd6ea581..75fe842d954e 100644
--- a/drivers/mtd/spi/fsl_espi_spl.c
+++ b/drivers/mtd/spi/fsl_espi_spl.c
@@ -8,6 +8,7 @@
 #include <hang.h>
 #include <spi_flash.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #define ESPI_BOOT_IMAGE_SIZE	0x48
 #define ESPI_BOOT_IMAGE_ADDR	0x50
diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index 4fe547171a5f..8b87183121d7 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -16,6 +16,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <os.h>
+#include <linux/string.h>
 
 #include <spi_flash.h>
 #include "sf_internal.h"
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index 2da0cf0dcf9f..9c4a53748618 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -14,6 +14,7 @@
 #include <spi_flash.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include "sf_internal.h"
 
diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 7960e4247711..c12bf1e5d3b0 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/math64.h>
+#include <linux/string.h>
 
 #include "sf_internal.h"
 
diff --git a/drivers/mtd/spi/sf_mtd.c b/drivers/mtd/spi/sf_mtd.c
index 071b25ac67f2..db624937f945 100644
--- a/drivers/mtd/spi/sf_mtd.c
+++ b/drivers/mtd/spi/sf_mtd.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
 #include <spi_flash.h>
+#include <linux/string.h>
 
 #if CONFIG_IS_ENABLED(DM_SPI_FLASH)
 
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index de6516f1065b..ad760cb87ed6 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -16,6 +16,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <spi-mem.h>
+#include <linux/string.h>
 
 #include "sf_internal.h"
 
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index a8d7cc9c7beb..52a8fdc9cdd1 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -26,6 +26,7 @@
 #include <linux/sizes.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index ffc0074d50cb..26faa55816a3 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -19,6 +19,7 @@
 #include <linux/math64.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 2ef8fde3d324..1b0794d3ba6f 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -11,6 +11,7 @@
  * This sub-system is responsible for attaching MTD devices and it also
  * implements flash media scanning.
  *
+#include <linux/string.h>
  * The attaching information is represented by a &struct ubi_attach_info'
  * object. Information about volumes is represented by &struct ubi_ainf_volume
  * objects which are kept in volume RB-tree with root at the @volumes field.
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a1941b8eb88e..e042e205c7de 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -34,6 +34,7 @@
 #include <linux/bug.h>
 #include <linux/log2.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #endif
 #include <linux/err.h>
 #include <ubi_uboot.h>
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index b119cb6e9c05..393419bd1376 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <ubi_uboot.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "ubi.h"
 #ifndef __UBOOT__
 #include <linux/debugfs.h>
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 9d4337bcfffd..ab7740b2aed4 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -18,6 +18,7 @@
  * accessing a logical eraseblock it is locked for reading or writing. The
  * per-logical eraseblock locking is implemented by means of the lock tree. The
  * lock tree is an RB-tree which refers all the currently locked logical
+#include <linux/string.h>
  * eraseblocks. The lock tree elements are &struct ubi_ltree_entry objects.
  * They are indexed by (@vol_id, @lnum) pairs.
  *
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index b54b56375b44..90ed73b8577f 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <ubi_uboot.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 #endif
 
 #include <linux/compat.h>
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 14be95b74bc4..671873ace14b 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -66,6 +66,7 @@
  * 512-byte chunks, we have to allocate one more buffer and copy our VID header
  * to offset 448 of this buffer.
  *
+#include <linux/string.h>
  * The I/O sub-system does the following trick in order to avoid this extra
  * copy. It always allocates a @ubi->vid_hdr_alsize bytes buffer for the VID
  * header and returns a pointer to offset @ubi->vid_hdr_shift of this buffer.
diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index 41680cdad13f..3fac8b2b3088 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -16,6 +16,7 @@
 #include <asm/div64.h>
 #else
 #include <ubi_uboot.h>
+#include <linux/string.h>
 #endif
 #include <linux/err.h>
 
diff --git a/drivers/mtd/ubi/upd.c b/drivers/mtd/ubi/upd.c
index 28a362aa14a9..c4856b6c11eb 100644
--- a/drivers/mtd/ubi/upd.c
+++ b/drivers/mtd/ubi/upd.c
@@ -32,6 +32,7 @@
 #else
 #include <div64.h>
 #include <ubi_uboot.h>
+#include <linux/string.h>
 #endif
 #include <linux/err.h>
 #include <linux/math64.h>
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 0bfedd0debd6..da68f3519daa 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -19,6 +19,7 @@
 #else
 #include <div64.h>
 #include <ubi_uboot.h>
+#include <linux/string.h>
 #endif
 #include <linux/math64.h>
 
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index a2b5352cb2da..cb4de78fcbba 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -56,6 +56,7 @@
 #else
 #include <ubi_uboot.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 #endif
 
 #include <linux/err.h>
diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index b58d8e8d5656..cfe2235ffa5d 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <errno.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <ubispl.h>
 
diff --git a/drivers/net/ag7xxx.c b/drivers/net/ag7xxx.c
index 92d50591fcfb..ccff74047245 100644
--- a/drivers/net/ag7xxx.c
+++ b/drivers/net/ag7xxx.c
@@ -25,6 +25,7 @@
 #include <linux/mii.h>
 #include <wait_bit.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <mach/ath79.h>
 
diff --git a/drivers/net/altera_tse.c b/drivers/net/altera_tse.c
index c46040156ab9..b21d171eea5b 100644
--- a/drivers/net/altera_tse.c
+++ b/drivers/net/altera_tse.c
@@ -22,6 +22,7 @@
 #include <asm/global_data.h>
 #include <linux/dma-mapping.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "altera_tse.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/net/bcm-sf2-eth-gmac.c b/drivers/net/bcm-sf2-eth-gmac.c
index cbe1e85222fa..3ab5841a7d0f 100644
--- a/drivers/net/bcm-sf2-eth-gmac.c
+++ b/drivers/net/bcm-sf2-eth-gmac.c
@@ -8,6 +8,7 @@
 #define DEBUG
 #include <linux/printk.h>
 #endif
+#include <linux/string.h>
 #endif
 
 #include <config.h>
diff --git a/drivers/net/bcm-sf2-eth.c b/drivers/net/bcm-sf2-eth.c
index 1524f5c99890..b5d75d5d68dd 100644
--- a/drivers/net/bcm-sf2-eth.c
+++ b/drivers/net/bcm-sf2-eth.c
@@ -10,6 +10,7 @@
 #include <config.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <phy.h>
 #include <miiphy.h>
diff --git a/drivers/net/bcm6368-eth.c b/drivers/net/bcm6368-eth.c
index fdd938ce0dd8..d1435a45b744 100644
--- a/drivers/net/bcm6368-eth.c
+++ b/drivers/net/bcm6368-eth.c
@@ -20,6 +20,7 @@
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define ETH_PORT_STR			"brcm,enetsw-port"
 
diff --git a/drivers/net/bnxt/bnxt.c b/drivers/net/bnxt/bnxt.c
index 1c9a9962408a..e4f3e254c27d 100644
--- a/drivers/net/bnxt/bnxt.c
+++ b/drivers/net/bnxt/bnxt.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <dm.h>
diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
index eb1e2a756cd3..d4241debe78b 100644
--- a/drivers/net/calxedaxgmac.c
+++ b/drivers/net/calxedaxgmac.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>	/* for dev_set_priv() */
+#include <linux/string.h>
 
 #define TX_NUM_DESC			1
 #define RX_NUM_DESC			32
diff --git a/drivers/net/cortina_ni.c b/drivers/net/cortina_ni.c
index 8d1a7bf44306..61e118002ddd 100644
--- a/drivers/net/cortina_ni.c
+++ b/drivers/net/cortina_ni.c
@@ -16,6 +16,7 @@
 #include <time.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <led.h>
 
diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 4e7af95b41c4..ac06678e221a 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -9,6 +9,7 @@
 #include <pci.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define SROM_DLEVEL	0
 
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 90ddda5edc6d..60e7ca9af84a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <asm/io.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include "designware.h"
 
diff --git a/drivers/net/dsa_sandbox.c b/drivers/net/dsa_sandbox.c
index 235f2f22d9aa..7e7c7ce54ac6 100644
--- a/drivers/net/dsa_sandbox.c
+++ b/drivers/net/dsa_sandbox.c
@@ -4,6 +4,7 @@
  */
 
 #include <asm/eth.h>
+#include <linux/string.h>
 #include <net/dsa.h>
 #include <net.h>
 
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 9b1a9e69bf88..7f928e2c2810 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -8,6 +8,7 @@
 /*
  * This driver supports the Synopsys Designware Ethernet QOS (Quality Of
  * Service) IP block. The IP supports multiple options for bus type, clocking/
+#include <linux/string.h>
  * reset structure, and feature list.
  *
  * The driver is written such that generic core logic is kept separate from
diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index 41e6ba760e29..71e2d28e5e92 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -40,6 +40,7 @@ tested on both gig copper and gig fiber boards
 #include <net.h>
 #include <pci.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "e1000.h"
 #include <asm/cache.h>
 
diff --git a/drivers/net/e1000_spi.c b/drivers/net/e1000_spi.c
index 69adf282c739..3e7f36708450 100644
--- a/drivers/net/e1000_spi.c
+++ b/drivers/net/e1000_spi.c
@@ -2,6 +2,7 @@
 #include <command.h>
 #include <console.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "e1000.h"
 #include <malloc.h>
 #include <linux/compiler.h>
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index 38d96ab72b6e..5b2340db85c3 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -13,6 +13,7 @@
 #include <netdev.h>
 #include <pci.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /* Ethernet chip registers. */
 #define SCB_STATUS		0	/* Rx/Command Unit Status *Word* */
diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index 9d1e8d38ffa6..c2f21e6e5256 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -15,6 +15,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/lists.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct eth_phy_device_priv {
 	struct mii_dev *mdio_bus;
diff --git a/drivers/net/ethoc.c b/drivers/net/ethoc.c
index 15b9d38a6d1d..fefce91a9b29 100644
--- a/drivers/net/ethoc.c
+++ b/drivers/net/ethoc.c
@@ -21,6 +21,7 @@
 #include <miiphy.h>
 #include <asm/cache.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 
 /* register offsets */
 #define	MODER		0x00
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 471eb2ef4fdf..483290e9b4f8 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -21,6 +21,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #include <asm/io.h>
diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 9fd26de0d721..08a376239d7e 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -23,6 +23,7 @@
 #include <fsl_tgec.h>
 #include <fsl_memac.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "fm.h"
 
diff --git a/drivers/net/fm/fm.c b/drivers/net/fm/fm.c
index 7dfa82190949..946b84746d5c 100644
--- a/drivers/net/fm/fm.c
+++ b/drivers/net/fm/fm.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <dm.h>
 
diff --git a/drivers/net/fm/tgec_phy.c b/drivers/net/fm/tgec_phy.c
index 22225c2f82f9..ad6c08e431c4 100644
--- a/drivers/net/fm/tgec_phy.c
+++ b/drivers/net/fm/tgec_phy.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <fsl_tgec.h>
 #include <fm_eth.h>
+#include <linux/string.h>
 
 /*
  * Write value to the PHY for this device to the register at regnum, waiting
diff --git a/drivers/net/fsl-mc/dpio/qbman_portal.c b/drivers/net/fsl-mc/dpio/qbman_portal.c
index 44ce00041ee0..5a0bef9324fd 100644
--- a/drivers/net/fsl-mc/dpio/qbman_portal.c
+++ b/drivers/net/fsl-mc/dpio/qbman_portal.c
@@ -7,6 +7,7 @@
 #include <malloc.h>
 #include <asm/arch/clock.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 #include "qbman_portal.h"
 
 /* QBMan portal management command codes */
diff --git a/drivers/net/fsl-mc/dpio/qbman_sys.h b/drivers/net/fsl-mc/dpio/qbman_sys.h
index 1c6e48913028..b12d1c5f69c5 100644
--- a/drivers/net/fsl-mc/dpio/qbman_sys.h
+++ b/drivers/net/fsl-mc/dpio/qbman_sys.h
@@ -22,6 +22,7 @@
  * required. */
 #include <linux/bug.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #undef QBMAN_CCSR_TRACE
 #undef QBMAN_CINH_TRACE
 #undef QBMAN_CENA_TRACE
diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 984616fb65c0..9ea245b6cea4 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -29,6 +29,7 @@
 #include <fsl-mc/fsl_dpsparser.h>
 #include <fsl-mc/fsl_qbman_portal.h>
 #include <fsl-mc/ldpaa_wriop.h>
+#include <linux/string.h>
 #include <net/ldpaa_eth.h>
 
 #define MC_RAM_BASE_ADDR_ALIGNMENT  (512UL * 1024 * 1024)
diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 1fd5089cc4be..bd31f62f0731 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "fsl_enetc.h"
 
diff --git a/drivers/net/fsl_mcdmafec.c b/drivers/net/fsl_mcdmafec.c
index cc61a1074038..b0fa249bdf6c 100644
--- a/drivers/net/fsl_mcdmafec.c
+++ b/drivers/net/fsl_mcdmafec.c
@@ -23,6 +23,7 @@
 #include <linux/mii.h>
 #include <asm/immap.h>
 #include <asm/fsl_mcdmafec.h>
+#include <linux/string.h>
 
 #include "MCD_dma.h"
 
diff --git a/drivers/net/fsl_mdio.c b/drivers/net/fsl_mdio.c
index 5fd11db05f5e..21c6f880ba1a 100644
--- a/drivers/net/fsl_mdio.c
+++ b/drivers/net/fsl_mdio.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <tsec.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_DM_MDIO
 struct tsec_mdio_priv {
diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index a66d8041f9c6..91e182d42e37 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 
 #include "ftmac100.h"
 #include <dm.h>
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 04008d2b198e..f8269cf9dd2e 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -28,6 +28,7 @@
 #include <dm/pinctrl.h>
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include "designware.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/net/higmacv300.c b/drivers/net/higmacv300.c
index 1862235d0cd2..24ae4e580416 100644
--- a/drivers/net/higmacv300.c
+++ b/drivers/net/higmacv300.c
@@ -18,6 +18,7 @@
 #include <net.h>
 #include <reset.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 
 #define STATION_ADDR_LOW		0x0000
 #define STATION_ADDR_HIGH		0x0004
diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index 1f60a70aac70..199ec26ae8e0 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -22,6 +22,7 @@
 #include <linux/compat.h>
 #include <linux/delay.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <net/ldpaa_eth.h>
 #include "ldpaa_eth.h"
 
diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bfc48dac079b..78f88a6fab59 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /*
  * The u-boot networking stack is a little weird.  It seems like the
diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
index ec1fae9688bd..3d2bc6723c8b 100644
--- a/drivers/net/mcffec.c
+++ b/drivers/net/mcffec.c
@@ -22,6 +22,7 @@
 #include <asm/immap.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 
 #undef	ET_DEBUG
 #undef	MII_DEBUG
diff --git a/drivers/net/mcfmii.c b/drivers/net/mcfmii.c
index eae20654513e..6738efd78080 100644
--- a/drivers/net/mcfmii.c
+++ b/drivers/net/mcfmii.c
@@ -10,6 +10,7 @@
 #include <netdev.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/fec.h>
 #include <asm/immap.h>
diff --git a/drivers/net/mpc8xx_fec.c b/drivers/net/mpc8xx_fec.c
index 78337731e1fd..c2220c49dbc5 100644
--- a/drivers/net/mpc8xx_fec.c
+++ b/drivers/net/mpc8xx_fec.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <phy.h>
 #include <linux/mii.h>
diff --git a/drivers/net/mscc_eswitch/felix_switch.c b/drivers/net/mscc_eswitch/felix_switch.c
index 2e5f45e5743f..014c950718ee 100644
--- a/drivers/net/mscc_eswitch/felix_switch.c
+++ b/drivers/net/mscc_eswitch/felix_switch.c
@@ -18,6 +18,7 @@
 #include <dm/device_compat.h>
 #include <dm/of_extra.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <net/dsa.h>
 #include <asm/io.h>
 #include <miiphy.h>
diff --git a/drivers/net/mscc_eswitch/jr2_switch.c b/drivers/net/mscc_eswitch/jr2_switch.c
index 7157428a685e..85b8bafe2e3b 100644
--- a/drivers/net/mscc_eswitch/jr2_switch.c
+++ b/drivers/net/mscc_eswitch/jr2_switch.c
@@ -18,6 +18,7 @@
 #include <net.h>
 #include <wait_bit.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <dt-bindings/mscc/jr2_data.h>
 #include "mscc_xfer.h"
diff --git a/drivers/net/mscc_eswitch/luton_switch.c b/drivers/net/mscc_eswitch/luton_switch.c
index 5e4f00c4f4d9..2852b1f35e01 100644
--- a/drivers/net/mscc_eswitch/luton_switch.c
+++ b/drivers/net/mscc_eswitch/luton_switch.c
@@ -16,6 +16,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 
 #include "mscc_xfer.h"
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/ocelot_switch.c b/drivers/net/mscc_eswitch/ocelot_switch.c
index 7ea1f551a11a..4fbc65794a5c 100644
--- a/drivers/net/mscc_eswitch/ocelot_switch.c
+++ b/drivers/net/mscc_eswitch/ocelot_switch.c
@@ -18,6 +18,7 @@
 #include <net.h>
 #include <wait_bit.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "mscc_xfer.h"
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/serval_switch.c b/drivers/net/mscc_eswitch/serval_switch.c
index be06e4833733..ea72bf61aea8 100644
--- a/drivers/net/mscc_eswitch/serval_switch.c
+++ b/drivers/net/mscc_eswitch/serval_switch.c
@@ -18,6 +18,7 @@
 #include <net.h>
 #include <wait_bit.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "mscc_xfer.h"
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/servalt_switch.c b/drivers/net/mscc_eswitch/servalt_switch.c
index 2d2329c204ae..a4eac9b14850 100644
--- a/drivers/net/mscc_eswitch/servalt_switch.c
+++ b/drivers/net/mscc_eswitch/servalt_switch.c
@@ -17,6 +17,7 @@
 #include <net.h>
 #include <wait_bit.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "mscc_xfer.h"
 #include "mscc_miim.h"
diff --git a/drivers/net/mt7620-eth.c b/drivers/net/mt7620-eth.c
index 038cba12407a..2c4dfb591496 100644
--- a/drivers/net/mt7620-eth.c
+++ b/drivers/net/mt7620-eth.c
@@ -26,6 +26,7 @@
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include <mach/mt7620-sysc.h>
 
 /* Frame Engine block */
diff --git a/drivers/net/mt7628-eth.c b/drivers/net/mt7628-eth.c
index b95de474fb02..59d809fd8e9a 100644
--- a/drivers/net/mt7628-eth.c
+++ b/drivers/net/mt7628-eth.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /* Ethernet frame engine register */
 #define PDMA_RELATED		0x0800
diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 52a8fb9c9391..a122f93fdf41 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -28,6 +28,7 @@
 #include <linux/mdio.h>
 #include <linux/mii.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "mtk_eth.h"
 
diff --git a/drivers/net/mvgbe.c b/drivers/net/mvgbe.c
index 3587ca2124e3..ab68d26f6767 100644
--- a/drivers/net/mvgbe.c
+++ b/drivers/net/mvgbe.c
@@ -26,6 +26,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <asm/arch/cpu.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_ARCH_KIRKWOOD)
 #include <asm/arch/soc.h>
diff --git a/drivers/net/mvneta.c b/drivers/net/mvneta.c
index 24933473fa05..950c50288f3b 100644
--- a/drivers/net/mvneta.c
+++ b/drivers/net/mvneta.c
@@ -37,6 +37,7 @@
 #include <linux/compat.h>
 #include <linux/mbus.h>
 #include <asm-generic/gpio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 1cd543076504..14978b657d0c 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -43,6 +43,7 @@
 #include <asm-generic/gpio.h>
 #include <fdt_support.h>
 #include <linux/mdio.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 151bc55e076b..2b2843252486 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <stdio_dev.h>
 #include <net.h>
+#include <linux/string.h>
 
 #ifndef CFG_NETCONSOLE_BUFFER_SIZE
 #define CFG_NETCONSOLE_BUFFER_SIZE 512
diff --git a/drivers/net/npcm750_eth.c b/drivers/net/npcm750_eth.c
index 8354626efae9..abdc8540194c 100644
--- a/drivers/net/npcm750_eth.c
+++ b/drivers/net/npcm750_eth.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 
 #define MAC_ADDR_SIZE		6
 #define CFG_TX_DESCR_NUM	32
diff --git a/drivers/net/octeon/octeon_eth.c b/drivers/net/octeon/octeon_eth.c
index 659ba51ecb4a..2d385d279a79 100644
--- a/drivers/net/octeon/octeon_eth.c
+++ b/drivers/net/octeon/octeon_eth.c
@@ -13,6 +13,7 @@
 #include <misc.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-csr.h>
diff --git a/drivers/net/octeontx/bgx.c b/drivers/net/octeontx/bgx.c
index b6592ff2ce54..f79d567e34b0 100644
--- a/drivers/net/octeontx/bgx.c
+++ b/drivers/net/octeontx/bgx.c
@@ -18,6 +18,7 @@
 #include <asm/arch/board.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #include "nic_reg.h"
 #include "nic.h"
diff --git a/drivers/net/octeontx/nic_main.c b/drivers/net/octeontx/nic_main.c
index 99886e3afc07..00e0d707a227 100644
--- a/drivers/net/octeontx/nic_main.c
+++ b/drivers/net/octeontx/nic_main.c
@@ -14,6 +14,7 @@
 #include <pci_ids.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "nic_reg.h"
 #include "nic.h"
diff --git a/drivers/net/octeontx/nicvf_main.c b/drivers/net/octeontx/nicvf_main.c
index 6e4d0a05121c..4870e542f4e3 100644
--- a/drivers/net/octeontx/nicvf_main.c
+++ b/drivers/net/octeontx/nicvf_main.c
@@ -12,6 +12,7 @@
 #include <phy.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "nic_reg.h"
 #include "nic.h"
diff --git a/drivers/net/octeontx/nicvf_queues.c b/drivers/net/octeontx/nicvf_queues.c
index c7f262f440d2..fa3d05ee6e64 100644
--- a/drivers/net/octeontx/nicvf_queues.c
+++ b/drivers/net/octeontx/nicvf_queues.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <phy.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "nic_reg.h"
 #include "nic.h"
diff --git a/drivers/net/octeontx2/cgx.c b/drivers/net/octeontx2/cgx.c
index c6ec3200c01e..16bb48ae2d86 100644
--- a/drivers/net/octeontx2/cgx.c
+++ b/drivers/net/octeontx2/cgx.c
@@ -13,6 +13,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/csrs/csrs-cgx.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "cgx.h"
 
diff --git a/drivers/net/octeontx2/cgx_intf.c b/drivers/net/octeontx2/cgx_intf.c
index 37d9a2bb730c..246943669e15 100644
--- a/drivers/net/octeontx2/cgx_intf.c
+++ b/drivers/net/octeontx2/cgx_intf.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <misc.h>
 #include <net.h>
+#include <linux/string.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/net/octeontx2/nix.c b/drivers/net/octeontx2/nix.c
index f596b6bca876..56358c917437 100644
--- a/drivers/net/octeontx2/nix.c
+++ b/drivers/net/octeontx2/nix.c
@@ -12,6 +12,7 @@
 #include <net.h>
 #include <pci.h>
 #include <watchdog.h>
+#include <linux/string.h>
 
 #include <asm/arch/board.h>
 #include <asm/arch/csrs/csrs-lmt.h>
diff --git a/drivers/net/octeontx2/nix_af.c b/drivers/net/octeontx2/nix_af.c
index c755dad55b7b..99e4a34e050a 100644
--- a/drivers/net/octeontx2/nix_af.c
+++ b/drivers/net/octeontx2/nix_af.c
@@ -12,6 +12,7 @@
 #include <pci.h>
 #include <time.h>
 #include <watchdog.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/log2.h>
diff --git a/drivers/net/octeontx2/rvu_af.c b/drivers/net/octeontx2/rvu_af.c
index 0d3a9ffe9ee1..db59e769c439 100644
--- a/drivers/net/octeontx2/rvu_af.c
+++ b/drivers/net/octeontx2/rvu_af.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <asm/arch/board.h>
 #include <asm/arch/csrs/csrs-npa.h>
+#include <linux/string.h>
 
 #include "nix.h"
 
diff --git a/drivers/net/octeontx2/rvu_common.c b/drivers/net/octeontx2/rvu_common.c
index 4d8173f5ba7c..f53621d0a4cd 100644
--- a/drivers/net/octeontx2/rvu_common.c
+++ b/drivers/net/octeontx2/rvu_common.c
@@ -9,6 +9,7 @@
 #include <misc.h>
 #include <net.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "rvu.h"
 
diff --git a/drivers/net/octeontx2/rvu_pf.c b/drivers/net/octeontx2/rvu_pf.c
index 5f3ea1f8eab1..b70a308c6a1a 100644
--- a/drivers/net/octeontx2/rvu_pf.c
+++ b/drivers/net/octeontx2/rvu_pf.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch/board.h>
+#include <linux/string.h>
 #include "cgx.h"
 #include "nix.h"
 
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index 1efc40911487..cc807165364f 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -16,6 +16,7 @@
 #include <pci.h>
 #include <miiphy.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "pch_gbe.h"
 
 #if !defined(CONFIG_PHYLIB)
diff --git a/drivers/net/pcnet.c b/drivers/net/pcnet.c
index a1f3c2bd290c..0f0d0f33809c 100644
--- a/drivers/net/pcnet.c
+++ b/drivers/net/pcnet.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <pci.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define	PCNET_DEBUG_LEVEL	0	/* 0=off, 1=init, 2=rx/tx */
 
diff --git a/drivers/net/pfe_eth/pfe_cmd.c b/drivers/net/pfe_eth/pfe_cmd.c
index 2fe0db0fe717..ce3c3b10103d 100644
--- a/drivers/net/pfe_eth/pfe_cmd.c
+++ b/drivers/net/pfe_eth/pfe_cmd.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <net/pfe_eth/pfe_eth.h>
 
 static inline void pfe_command_help(void)
diff --git a/drivers/net/pfe_eth/pfe_driver.c b/drivers/net/pfe_eth/pfe_driver.c
index 5e14f82de5ae..b3fe2c272f70 100644
--- a/drivers/net/pfe_eth/pfe_driver.c
+++ b/drivers/net/pfe_eth/pfe_driver.c
@@ -7,6 +7,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <net/pfe_eth/pfe_firmware.h>
 
diff --git a/drivers/net/pfe_eth/pfe_firmware.c b/drivers/net/pfe_eth/pfe_firmware.c
index da4f2ca42a5b..dbd7272c1b51 100644
--- a/drivers/net/pfe_eth/pfe_firmware.c
+++ b/drivers/net/pfe_eth/pfe_firmware.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <net/pfe_eth/pfe_firmware.h>
 #include <spi_flash.h>
diff --git a/drivers/net/pfe_eth/pfe_hw.c b/drivers/net/pfe_eth/pfe_hw.c
index 9f2f92d116dd..929b4c0e34e3 100644
--- a/drivers/net/pfe_eth/pfe_hw.c
+++ b/drivers/net/pfe_eth/pfe_hw.c
@@ -5,6 +5,7 @@
  */
 #include <log.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <net/pfe_eth/pfe/pfe_hw.h>
 
diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 0970449d0f9f..f986e560d050 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -10,6 +10,7 @@
 #include <phy.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 
 #define PHY_ID_ADIN1300				0x0283bc30
 #define ADIN1300_EXT_REG_PTR			0x10
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index a958e88d44fd..ca554e8dc3ba 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -13,6 +13,7 @@
 #include <phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <malloc.h>
 #include <asm/byteorder.h>
diff --git a/drivers/net/phy/atheros.c b/drivers/net/phy/atheros.c
index abb7bdf537cf..570306f64f87 100644
--- a/drivers/net/phy/atheros.c
+++ b/drivers/net/phy/atheros.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <dt-bindings/net/qca-ar803x.h>
+#include <linux/string.h>
 
 #define AR803x_PHY_DEBUG_ADDR_REG	0x1d
 #define AR803x_PHY_DEBUG_DATA_REG	0x1e
diff --git a/drivers/net/phy/b53.c b/drivers/net/phy/b53.c
index 26e8e2fe64fb..c6579c623109 100644
--- a/drivers/net/phy/b53.c
+++ b/drivers/net/phy/b53.c
@@ -26,6 +26,7 @@
 #include <command.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <errno.h>
 #include <malloc.h>
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 2f0823b83651..fe8f580f5d46 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <fdt_support.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index cf71f7d4e7e5..d57c0273f956 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -17,6 +17,7 @@
 #include <ppc_asm.tmpl>
 #include <miiphy.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #ifndef CONFIG_BITBANGMII_MULTI
 
diff --git a/drivers/net/phy/mv88e61xx.c b/drivers/net/phy/mv88e61xx.c
index 85778106eddc..addaf23a5ceb 100644
--- a/drivers/net/phy/mv88e61xx.c
+++ b/drivers/net/phy/mv88e61xx.c
@@ -33,6 +33,7 @@
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <bitfield.h>
 #include <errno.h>
diff --git a/drivers/net/phy/mv88e6352.c b/drivers/net/phy/mv88e6352.c
index 56060762d85c..dc05f465d4fd 100644
--- a/drivers/net/phy/mv88e6352.c
+++ b/drivers/net/phy/mv88e6352.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <mv88e6352.h>
+#include <linux/string.h>
 
 #define SMI_HDR		((0x8 | 0x1) << 12)
 #define SMI_BUSY_MASK	(0x8000)
diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index eb3fd65bb47f..242b313c17f4 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <phy.h>
 #include <net.h>
+#include <linux/string.h>
 #include <net/ncsi.h>
 #include <net/ncsi-pkt.h>
 #include <asm/unaligned.h>
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 63b3e46f101c..3990c8d189f3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/pic32_mdio.c b/drivers/net/pic32_mdio.c
index d4049cfea525..802563960a16 100644
--- a/drivers/net/pic32_mdio.c
+++ b/drivers/net/pic32_mdio.c
@@ -12,6 +12,7 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "pic32_eth.h"
 
 static int pic32_mdio_write(struct mii_dev *bus,
diff --git a/drivers/net/qe/dm_qe_uec.c b/drivers/net/qe/dm_qe_uec.c
index 6d1509d90cf0..57dce086d9f0 100644
--- a/drivers/net/qe/dm_qe_uec.c
+++ b/drivers/net/qe/dm_qe_uec.c
@@ -14,6 +14,7 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include "dm_qe_uec.h"
 
diff --git a/drivers/net/qe/uccf.c b/drivers/net/qe/uccf.c
index 306f1ea1db68..d511a06ad3ef 100644
--- a/drivers/net/qe/uccf.c
+++ b/drivers/net/qe/uccf.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <linux/immap_qe.h>
+#include <linux/string.h>
 #include "uccf.h"
 #include <fsl_qe.h>
 
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index ca66c7ba699b..a63337d73d90 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -25,6 +25,7 @@
 #include <asm/io.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 /* Registers */
 #define RAVB_REG_CCC		0x000
diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index fd9f9797658b..a2c532c28797 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -25,6 +25,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <miiphy.h>
+#include <linux/string.h>
 
 #define RSWITCH_SLEEP_US	1000
 #define RSWITCH_TIMEOUT_US	1000000
diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 106bc1c7ae79..f67d7a9e3301 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -58,6 +58,7 @@
  *    Drastically simplified error handling. Basically, if any error
  *    in transmission or reception occurs, the card is reset.
  *    Also, pointed all transmit descriptors to the same buffer to
+#include <linux/string.h>
  *    save buffer space. This should decrease driver size and avoid
  *    corruption because of exceeding 32K during runtime.
  *
diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 270fe08be991..873112e570f8 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -53,6 +53,7 @@
 #include <pci.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #undef DEBUG_RTL8169
 #undef DEBUG_RTL8169_TX
diff --git a/drivers/net/sandbox-raw-bus.c b/drivers/net/sandbox-raw-bus.c
index fb1ba5a8c83a..6b111d47eea8 100644
--- a/drivers/net/sandbox-raw-bus.c
+++ b/drivers/net/sandbox-raw-bus.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/string.h>
 
 static int eth_raw_bus_post_bind(struct udevice *dev)
 {
diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
index 99eb7a3bbff6..708c0a0260d8 100644
--- a/drivers/net/sandbox-raw.c
+++ b/drivers/net/sandbox-raw.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <net.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index bf2ee3cc869c..f8a8c7c58293 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -15,6 +15,7 @@
 #include <asm/eth.h>
 #include <asm/global_data.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/sja1105.c b/drivers/net/sja1105.c
index 48f044c64721..5061427dc5c1 100644
--- a/drivers/net/sja1105.c
+++ b/drivers/net/sja1105.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <net/dsa.h>
 #include <stdlib.h>
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 5c5ad8b84a98..9129f5efcf84 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -12,6 +12,7 @@
 #include <miiphy.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "smc911x.h"
diff --git a/drivers/net/sni_ave.c b/drivers/net/sni_ave.c
index 8eeecbc4cf3b..4a80b976f488 100644
--- a/drivers/net/sni_ave.c
+++ b/drivers/net/sni_ave.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define AVE_GRST_DELAY_MSEC	40
 #define AVE_MIN_XMITSIZE	60
diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 04c3274fbe15..3693ff39e7b8 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -29,6 +29,7 @@
 #include <net.h>
 #include <reset.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 
 #define MDIO_CMD_MII_BUSY		BIT(0)
 #define MDIO_CMD_MII_WRITE		BIT(1)
diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
index 4c90d4b4981d..d52b933cb07e 100644
--- a/drivers/net/sunxi_emac.c
+++ b/drivers/net/sunxi_emac.c
@@ -17,6 +17,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
+#include <linux/string.h>
 
 /* EMAC register  */
 struct emac_regs {
diff --git a/drivers/net/ti/cpsw-common.c b/drivers/net/ti/cpsw-common.c
index d5428274d190..9ed0b56cc800 100644
--- a/drivers/net/ti/cpsw-common.c
+++ b/drivers/net/ti/cpsw-common.c
@@ -13,6 +13,7 @@
 #include <cpsw.h>
 #include <dm/device_compat.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 877be7fca52d..49afd22feb29 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -25,6 +25,7 @@
 #include <asm/arch/cpu.h>
 #include <dm.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "cpsw_mdio.h"
 
diff --git a/drivers/net/ti/davinci_emac.c b/drivers/net/ti/davinci_emac.c
index 034877a76907..dd039e8e7d3d 100644
--- a/drivers/net/ti/davinci_emac.c
+++ b/drivers/net/ti/davinci_emac.c
@@ -33,6 +33,7 @@
 #include <asm/arch/emac_defs.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "davinci_emac.h"
 
 unsigned int	emac_dbg = 0;
diff --git a/drivers/net/tsec.c b/drivers/net/tsec.c
index 8833e3098d52..9c761835af8d 100644
--- a/drivers/net/tsec.c
+++ b/drivers/net/tsec.c
@@ -21,6 +21,7 @@
 #include <miiphy.h>
 #include <asm/processor.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define TBIANA_SETTINGS ( \
 		TBIANA_ASYMMETRIC_PAUSE \
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index 54f22327684f..0f3002265bca 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -22,6 +22,7 @@
 #include <wait_bit.h>
 #include <linux/delay.h>
 #include <eth_phy.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 410fb25ddef4..a2a1f013bc72 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
+#include <linux/string.h>
 #include "xilinx_axi_mrmac.h"
 
 static void axi_mrmac_dma_write(struct mcdma_bd *bd, u32 *desc)
diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 3377e669f2f6..404a0bc16f59 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -36,6 +36,7 @@
 #include <linux/errno.h>
 #include <eth_phy.h>
 #include <zynqmp_firmware.h>
+#include <linux/string.h>
 
 /* Bit/mask specification */
 #define ZYNQ_GEM_PHYMNTNC_OP_MASK	0x40020000 /* operation mask bits */
diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 20dc910d8a33..dfc82b8e77e9 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -16,6 +16,7 @@
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 #include "nvme.h"
 
 #define NVME_Q_DEPTH		2
diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 819b748dc02e..cc738eff5d08 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <mailbox.h>
 #include <mapmem.h>
+#include <linux/string.h>
 #include "nvme.h"
 #include <reset.h>
 
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index ae7350aaff98..b036ee296a09 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -25,6 +25,7 @@
 #include <dt-bindings/pci/pci.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "pci_internal.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 15302164aa63..4e9c1247cf0d 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -42,6 +42,7 @@
 #include <acpi/acpi_s3.h>
 #include <asm/global_data.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
index 2fb1fe8dea4d..59a8965a9097 100644
--- a/drivers/pci/pci_tegra.c
+++ b/drivers/pci/pci_tegra.c
@@ -24,6 +24,7 @@
 #include <time.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/drivers/pci/pcie_layerscape_fixup.c b/drivers/pci/pcie_layerscape_fixup.c
index c5198353957b..a8b32d63c688 100644
--- a/drivers/pci/pcie_layerscape_fixup.c
+++ b/drivers/pci/pcie_layerscape_fixup.c
@@ -21,6 +21,7 @@
 #endif
 #include <malloc.h>
 #include <env.h>
+#include <linux/string.h>
 #include "pcie_layerscape.h"
 #include "pcie_layerscape_fixup_common.h"
 
diff --git a/drivers/pci/pcie_layerscape_fixup_common.c b/drivers/pci/pcie_layerscape_fixup_common.c
index 095874a92763..95924a2ab26b 100644
--- a/drivers/pci/pcie_layerscape_fixup_common.c
+++ b/drivers/pci/pcie_layerscape_fixup_common.c
@@ -13,6 +13,7 @@
 #include <asm/arch/soc.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 #include "pcie_layerscape_fixup_common.h"
 
 extern int next_stream_id;
diff --git a/drivers/pci_endpoint/sandbox-pci_ep.c b/drivers/pci_endpoint/sandbox-pci_ep.c
index de148cddb91e..458febb29fb2 100644
--- a/drivers/pci_endpoint/sandbox-pci_ep.c
+++ b/drivers/pci_endpoint/sandbox-pci_ep.c
@@ -9,6 +9,7 @@
 #include <pci.h>
 #include <pci_ep.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 /**
  * struct sandbox_pci_ep_priv - private data for driver
diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 77dffcad8845..b220d24a9cd5 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -24,6 +24,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #define REG_ISCR			0x00
diff --git a/drivers/phy/marvell/comphy_a3700.c b/drivers/phy/marvell/comphy_a3700.c
index c490dc69c695..4db75983dba5 100644
--- a/drivers/phy/marvell/comphy_a3700.c
+++ b/drivers/phy/marvell/comphy_a3700.c
@@ -12,6 +12,7 @@
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
 #include <phy.h>
+#include <linux/string.h>
 
 #include "comphy_a3700.h"
 
diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
index cf2a1cd14c7f..0d92fce9c4bb 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -17,6 +17,7 @@
 #include <generic-phy.h>
 #include <regmap.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <reset.h>
 #include <clk.h>
diff --git a/drivers/phy/meson-axg-mipi-pcie-analog.c b/drivers/phy/meson-axg-mipi-pcie-analog.c
index 236ea1ce5ca7..22e7db780536 100644
--- a/drivers/phy/meson-axg-mipi-pcie-analog.c
+++ b/drivers/phy/meson-axg-mipi-pcie-analog.c
@@ -18,6 +18,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <reset.h>
 #include <clk.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index 9ed7af0d6ef1..db4bf8658fd7 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -17,6 +17,7 @@
 #include <linux/math64.h>
 #include <phy-mipi-dphy.h>
 #include <reset.h>
+#include <linux/string.h>
 
 #define UPDATE(x, h, l)	(((x) << (l)) & GENMASK((h), (l)))
 
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 70e61eccb79a..b35ccc12cc50 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -20,6 +20,7 @@
 #include <asm/io.h>
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 47c69dd6c453..d826408f96c7 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -21,6 +21,7 @@
 #include <asm/io.h>
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index baf92529348c..a683be332d99 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -15,6 +15,7 @@
 #include <dm/of_access.h>
 #include <generic-phy.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/otg.h>
 #include <regmap.h>
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 72613399073e..5a63d1672ee1 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -14,6 +14,7 @@
 #include <regmap.h>
 #include <reset-uclass.h>
 #include <dt-bindings/phy/phy.h>
+#include <linux/string.h>
 
 #include <dt-bindings/phy/phy-ti.h>
 
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 898185479ba3..9d5d784c35b9 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "pinctrl-exynos.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
index 869b78106851..f46f315fc89d 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
+++ b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <dm/pinctrl.h>
 #include <linux/io.h>
+#include <linux/string.h>
 
 #include "pinctrl-mtmips-common.h"
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index e834dddfd137..bf638e9111a5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -36,6 +36,7 @@
 #include <linux/bitops.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 252151f3e5d9..7aa691a771ec 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -10,6 +10,7 @@
 #include <dm/root.h>
 #include <errno.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 struct mvebu_mpp_ctrl_setting {
 	const char *name;
diff --git a/drivers/pinctrl/nexell/pinctrl-nexell.c b/drivers/pinctrl/nexell/pinctrl-nexell.c
index 20497a746d26..d56c88123b8b 100644
--- a/drivers/pinctrl/nexell/pinctrl-nexell.c
+++ b/drivers/pinctrl/nexell/pinctrl-nexell.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
 
diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
index 863eb1455d23..d94d7f5991a3 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
+#include <linux/string.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
 
diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
index 62476358c349..6854f9c31c03 100644
--- a/drivers/pinctrl/pinctrl-apple.c
+++ b/drivers/pinctrl/pinctrl-apple.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 
 struct apple_pinctrl_priv {
 	void *base;
diff --git a/drivers/pinctrl/pinctrl-generic.c b/drivers/pinctrl/pinctrl-generic.c
index 8909b57810af..3ae8f211bd44 100644
--- a/drivers/pinctrl/pinctrl-generic.c
+++ b/drivers/pinctrl/pinctrl-generic.c
@@ -8,6 +8,7 @@
 #include <dm/device_compat.h>
 #include <linux/compat.h>
 #include <dm/pinctrl.h>
+#include <linux/string.h>
 
 /**
  * pinctrl_pin_name_to_selector() - return the pin selector for a pin
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index 13f0a3426860..6bbaad0ce4a0 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 /*
  * The K210 only implements 8 drive levels, even though there is register space
diff --git a/drivers/pinctrl/pinctrl-sandbox.c b/drivers/pinctrl/pinctrl-sandbox.c
index 776597745099..26c3b0048a39 100644
--- a/drivers/pinctrl/pinctrl-sandbox.c
+++ b/drivers/pinctrl/pinctrl-sandbox.c
@@ -10,6 +10,7 @@
 #include <dt-bindings/pinctrl/sandbox-pinmux.h>
 #include <log.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 /*
  * This driver emulates a pin controller with the following rules:
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 509e2a80e9a5..de091bd60389 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 /* STMFX pins = GPIO[15:0] + aGPIO[7:0] */
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 517035961dab..3a782ace41c9 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -19,6 +19,7 @@
 #include <dm/pinctrl.h>
 #include <linux/compat.h>
 #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+#include <linux/string.h>
 
 #define PINCTRL_GET_FUNC_GROUPS_RESP_LEN	12
 #define PINCTRL_GET_PIN_GROUPS_RESP_LEN		12
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 8bb7588714a4..079a4efd2d68 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "../gpio/stm32_gpio_priv.h"
 
diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index f6e8dd93374e..ac03cf69cca9 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -21,6 +21,7 @@
 #include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "sh_pfc.h"
 
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 8ef089994f46..f8dfe64b0a5e 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -12,6 +12,7 @@
 #include <fdtdec.h>
 #include <linux/bitops.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #include "pinctrl-rockchip.h"
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index e51021809027..f0673247d67b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -7,6 +7,7 @@
 #include <dm/pinctrl.h>
 #include <errno.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include <asm/gpio.h>
 
diff --git a/drivers/power/domain/imx8-power-domain-legacy.c b/drivers/power/domain/imx8-power-domain-legacy.c
index c8ca2665752f..29b08164a697 100644
--- a/drivers/power/domain/imx8-power-domain-legacy.c
+++ b/drivers/power/domain/imx8-power-domain-legacy.c
@@ -15,6 +15,7 @@
 #include <dm/device.h>
 #include <dm/uclass-internal.h>
 #include <firmware/imx/sci/sci.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index df5d7d695621..27770ff25804 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -17,6 +17,7 @@
 #include <imx_sip.h>
 #include <linux/bitmap.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
diff --git a/drivers/power/pmic/i2c_pmic_emul.c b/drivers/power/pmic/i2c_pmic_emul.c
index f0a03742f87b..675f286b1761 100644
--- a/drivers/power/pmic/i2c_pmic_emul.c
+++ b/drivers/power/pmic/i2c_pmic_emul.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/sandbox_pmic.h>
 
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index eb83c88d5641..88f88e0014ca 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -11,6 +11,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/palmas.h>
diff --git a/drivers/power/pmic/pmic-uclass.c b/drivers/power/pmic/pmic-uclass.c
index 0e2f5e1f4111..95c93d9b383f 100644
--- a/drivers/power/pmic/pmic-uclass.c
+++ b/drivers/power/pmic/pmic-uclass.c
@@ -15,6 +15,7 @@
 #include <dm/lists.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <linux/ctype.h>
 
diff --git a/drivers/power/power_core.c b/drivers/power/power_core.c
index 4f7ba099cd91..a91bfa3960b2 100644
--- a/drivers/power/power_core.c
+++ b/drivers/power/power_core.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <power/pmic.h>
diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
index b67ac2f027b5..158f57baa233 100644
--- a/drivers/power/power_i2c.c
+++ b/drivers/power/power_i2c.c
@@ -12,6 +12,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <power/pmic.h>
 #include <i2c.h>
diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index 02f320eac1e1..2ab77be4c086 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 
diff --git a/drivers/power/regulator/bd71837.c b/drivers/power/regulator/bd71837.c
index 913ed88d45f7..1230bd3d405a 100644
--- a/drivers/power/regulator/bd71837.c
+++ b/drivers/power/regulator/bd71837.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <power/bd71837.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/da9063.c b/drivers/power/regulator/da9063.c
index 8df1abcf7885..244f3b365786 100644
--- a/drivers/power/regulator/da9063.c
+++ b/drivers/power/regulator/da9063.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <power/da9063_pmic.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/npcm8xx_regulator.c b/drivers/power/regulator/npcm8xx_regulator.c
index fcd1058cdf52..5de31e4c9a05 100644
--- a/drivers/power/regulator/npcm8xx_regulator.c
+++ b/drivers/power/regulator/npcm8xx_regulator.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #define REG_VSRCR	0xf08000e8	/* Voltage Supply Control Register */
diff --git a/drivers/power/regulator/palmas_regulator.c b/drivers/power/regulator/palmas_regulator.c
index 3c4eb83be774..11e7e454a188 100644
--- a/drivers/power/regulator/palmas_regulator.c
+++ b/drivers/power/regulator/palmas_regulator.c
@@ -10,6 +10,7 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/palmas.h>
diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 7ca20d1f7f87..e4cba33723fc 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <log.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <power/pca9450.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index 1d926689b3b0..4f9bfb68617c 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <log.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/pfuze100_pmic.h>
diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 3a6ba69f6d5f..5370f08fece5 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <dm/uclass-internal.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2311910a636e..25fdffe100a7 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -26,6 +26,7 @@
 #include <linux/math64.h>
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
+#include <linux/string.h>
 
 #define NSEC_PER_SEC 1000000000L
 
diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 2825dc6f9aa6..4d901eb7599f 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -15,6 +15,7 @@
 #include <linux/immap_qe.h>
 #include <fsl_qe.h>
 #include <mmc.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #ifdef CONFIG_ARCH_LS1021A
diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
index 6a15242c20cc..a5fa67512c9a 100644
--- a/drivers/ram/imxrt_sdram.c
+++ b/drivers/ram/imxrt_sdram.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /* SDRAM Command Code */
 #define SD_CC_ARD		0x0     /* Master Bus (AXI) command - Read */
diff --git a/drivers/ram/octeon/octeon3_lmc.c b/drivers/ram/octeon/octeon3_lmc.c
index eaef0fa5c12e..16a0fc91c882 100644
--- a/drivers/ram/octeon/octeon3_lmc.c
+++ b/drivers/ram/octeon/octeon3_lmc.c
@@ -9,6 +9,7 @@
 #include <i2c.h>
 #include <ram.h>
 #include <time.h>
+#include <linux/string.h>
 
 #include <linux/bitops.h>
 #include <linux/io.h>
diff --git a/drivers/ram/renesas/rzn1/ddr_async.c b/drivers/ram/renesas/rzn1/ddr_async.c
index 7a81497bc92b..d5a311f17008 100644
--- a/drivers/ram/renesas/rzn1/ddr_async.c
+++ b/drivers/ram/renesas/rzn1/ddr_async.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <wait_bit.h>
+#include <linux/string.h>
 #include <renesas/ddr_ctrl.h>
 
 void clk_rzn1_reset_state(struct clk *clk, int on);
diff --git a/drivers/ram/rockchip/sdram_rk3066.c b/drivers/ram/rockchip/sdram_rk3066.c
index 39c0be56a6e0..2ab4c4341f27 100644
--- a/drivers/ram/rockchip/sdram_rk3066.c
+++ b/drivers/ram/rockchip/sdram_rk3066.c
@@ -28,6 +28,7 @@
 #include <asm/arch-rockchip/sdram.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 struct rk3066_dmc_chan_info {
 	struct rk3288_ddr_pctl *pctl;
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index ad9f936df55a..8147ec6eea59 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -27,6 +27,7 @@
 #include <asm/arch-rockchip/sdram_rk3288.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 struct chan_info {
 	struct rk3288_ddr_pctl *pctl;
diff --git a/drivers/ram/rockchip/sdram_rk322x.c b/drivers/ram/rockchip/sdram_rk322x.c
index 892766a8b435..4c5e6271791b 100644
--- a/drivers/ram/rockchip/sdram_rk322x.c
+++ b/drivers/ram/rockchip/sdram_rk322x.c
@@ -23,6 +23,7 @@
 #include <asm/types.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 struct chan_info {
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index c99118fd6123..f2526b144a2a 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -27,6 +27,7 @@
 #include <asm/arch-rockchip/sdram_rk3288.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include <power/rk8xx_pmic.h>
 
diff --git a/drivers/ram/rockchip/sdram_rk3328.c b/drivers/ram/rockchip/sdram_rk3328.c
index b5ca8ca436f5..8d3ad26d5539 100644
--- a/drivers/ram/rockchip/sdram_rk3328.c
+++ b/drivers/ram/rockchip/sdram_rk3328.c
@@ -20,6 +20,7 @@
 #include <asm/arch-rockchip/sdram_rk3328.h>
 #include <asm/arch-rockchip/uart.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct dram_info {
 #ifdef CONFIG_TPL_BUILD
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 9e1376a940fc..c0d261885241 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -17,6 +17,7 @@
 #include <asm/arch-rockchip/sdram_common.h>
 #include <asm/arch-rockchip/sdram_rv1126.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /* define training flag */
 #define CA_TRAINING			(0x1 << 0)
diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
index 891f4137813e..92148d0a64f7 100644
--- a/drivers/ram/stm32_sdram.c
+++ b/drivers/ram/stm32_sdram.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #define MEM_MODE_MASK	GENMASK(2, 0)
 #define SWP_FMC_OFFSET 10
diff --git a/drivers/ram/stm32mp1/stm32mp1_ddr.c b/drivers/ram/stm32mp1/stm32mp1_ddr.c
index 8ee4e24f39df..c5a8eadcdee6 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ddr.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ddr.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include "stm32mp1_ddr.h"
 #include "stm32mp1_ddr_regs.h"
 
diff --git a/drivers/ram/stm32mp1/stm32mp1_interactive.c b/drivers/ram/stm32mp1/stm32mp1_interactive.c
index a64867178df6..3f4dec2c8b18 100644
--- a/drivers/ram/stm32mp1/stm32mp1_interactive.c
+++ b/drivers/ram/stm32mp1/stm32mp1_interactive.c
@@ -16,6 +16,7 @@
 #include <reset.h>
 #include <time.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "stm32mp1_ddr.h"
 #include "stm32mp1_tests.h"
 
diff --git a/drivers/ram/stm32mp1/stm32mp1_tests.c b/drivers/ram/stm32mp1/stm32mp1_tests.c
index c5f33544144f..3eab64689e3f 100644
--- a/drivers/ram/stm32mp1/stm32mp1_tests.c
+++ b/drivers/ram/stm32mp1/stm32mp1_tests.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include "stm32mp1_tests.h"
 
 #define ADDR_INVALID	0xFFFFFFFF
diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 2b38aa26b859..be7bd961ac04 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -8,6 +8,7 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <exports.h>
+#include <linux/string.h>
 #include <reboot-mode/reboot-mode.h>
 
 int dm_reboot_mode_update(struct udevice *dev)
diff --git a/drivers/remoteproc/ipu_rproc.c b/drivers/remoteproc/ipu_rproc.c
index b4a06bc955a9..a5cceee0ce0b 100644
--- a/drivers/remoteproc/ipu_rproc.c
+++ b/drivers/remoteproc/ipu_rproc.c
@@ -32,6 +32,7 @@
 #include <timer.h>
 #include <reset.h>
 #include <linux/bitmap.h>
+#include <linux/string.h>
 
 #define IPU1_LOAD_ADDR         (0xa17ff000)
 #define MAX_REMOTECORE_BIN_SIZE (8 * 0x100000)
diff --git a/drivers/remoteproc/k3_system_controller.c b/drivers/remoteproc/k3_system_controller.c
index e2affe69c678..58dabf184407 100644
--- a/drivers/remoteproc/k3_system_controller.c
+++ b/drivers/remoteproc/k3_system_controller.c
@@ -14,6 +14,7 @@
 #include <mailbox.h>
 #include <dm/device_compat.h>
 #include <linux/soc/ti/k3-sec-proxy.h>
+#include <linux/string.h>
 
 #define K3_MSG_R5_TO_M3_M3FW			0x8105
 #define K3_MSG_M3_TO_R5_CERT_RESULT		0x8805
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 924070a76b59..8d2b463028da 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -20,6 +20,7 @@
 #include <power-domain.h>
 #include <linux/pruss_driver.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 
 /* PRU_ICSS_PRU_CTRL registers */
 #define PRU_CTRL_CTRL		0x0000
diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
index 5e070e5076e1..4b6704688ed5 100644
--- a/drivers/remoteproc/rproc-elf-loader.c
+++ b/drivers/remoteproc/rproc-elf-loader.c
@@ -12,6 +12,7 @@
 #include <dm/device_compat.h>
 #include <linux/compat.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 /**
  * struct resource_table - firmware resource table header
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index ece534c3c0e3..73db97f13858 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -21,6 +21,7 @@
 #include <dm/uclass-internal.h>
 #include <linux/compat.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 1a2e9dd1f585..a1e193d87834 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/sizes.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/string.h>
 #include "ti_sci_proc.h"
 
 #define KEYSTONE_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 6f3e12d915e6..3ca40f4eac0f 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/string.h>
 #include "ti_sci_proc.h"
 
 /*
diff --git a/drivers/remoteproc/ti_power_proc.c b/drivers/remoteproc/ti_power_proc.c
index 6887a3c8541f..647c126e2ec1 100644
--- a/drivers/remoteproc/ti_power_proc.c
+++ b/drivers/remoteproc/ti_power_proc.c
@@ -12,6 +12,7 @@
 #include <remoteproc.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <mach/psc_defs.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/reset/reset-jh7110.c b/drivers/reset/reset-jh7110.c
index d6bdf6bb00c4..58c43fcac805 100644
--- a/drivers/reset/reset-jh7110.c
+++ b/drivers/reset/reset-jh7110.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <linux/iopoll.h>
 #include <reset-uclass.h>
+#include <linux/string.h>
 
 struct jh7110_reset_priv {
 	void __iomem *reg;
diff --git a/drivers/rng/iproc_rng200.c b/drivers/rng/iproc_rng200.c
index 85ac15bf9ca9..d4f19492f653 100644
--- a/drivers/rng/iproc_rng200.c
+++ b/drivers/rng/iproc_rng200.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <rng.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #define usleep_range(a, b) udelay((b))
 
diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
index e0a1e8c7e046..b51ce343abd6 100644
--- a/drivers/rng/meson-rng.c
+++ b/drivers/rng/meson-rng.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <rng.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 struct meson_rng_plat {
 	fdt_addr_t base;
diff --git a/drivers/rng/optee_rng.c b/drivers/rng/optee_rng.c
index 410dfc053f1e..b79dd071eee4 100644
--- a/drivers/rng/optee_rng.c
+++ b/drivers/rng/optee_rng.c
@@ -5,6 +5,7 @@
 #define LOG_CATEGORY UCLASS_RNG
 
 #include <common.h>
+#include <linux/string.h>
 
 #include <rng.h>
 #include <tee.h>
diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
index 3a4bb3394159..539ffc7147fb 100644
--- a/drivers/rng/smccc_trng.c
+++ b/drivers/rng/smccc_trng.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/psci.h>
+#include <linux/string.h>
 
 #define DRIVER_NAME	"smccc-trng"
 
diff --git a/drivers/rng/stm32mp1_rng.c b/drivers/rng/stm32mp1_rng.c
index 89da78c6c8bd..17ffc951098b 100644
--- a/drivers/rng/stm32mp1_rng.c
+++ b/drivers/rng/stm32mp1_rng.c
@@ -13,6 +13,7 @@
 #include <rng.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <linux/iopoll.h>
diff --git a/drivers/rtc/abx80x.c b/drivers/rtc/abx80x.c
index 823aff03f5f0..6be4a63cb9dd 100644
--- a/drivers/rtc/abx80x.c
+++ b/drivers/rtc/abx80x.c
@@ -18,6 +18,7 @@
 #include <rtc.h>
 #include <log.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 
 #define ABX8XX_REG_HTH		0x00
 #define ABX8XX_REG_SC		0x01
diff --git a/drivers/rtc/i2c_rtc_emul.c b/drivers/rtc/i2c_rtc_emul.c
index c307d6036dd5..53987ff561e7 100644
--- a/drivers/rtc/i2c_rtc_emul.c
+++ b/drivers/rtc/i2c_rtc_emul.c
@@ -21,6 +21,7 @@
 #include <rtc.h>
 #include <asm/rtc.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 #ifdef DEBUG
 #define debug_buffer print_buffer
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 7411660d465e..b2ff36c1ad3e 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -20,6 +20,7 @@
 #include <scsi.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 #if !defined(CONFIG_DM_SCSI)
 # ifdef CFG_SCSI_DEV_LIST
diff --git a/drivers/scsi/scsi_emul.c b/drivers/scsi/scsi_emul.c
index 6b8468f79947..25abc953aece 100644
--- a/drivers/scsi/scsi_emul.c
+++ b/drivers/scsi/scsi_emul.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <scsi.h>
 #include <scsi_emul.h>
+#include <linux/string.h>
 
 int sb_scsi_emul_command(struct scsi_emul_info *info,
 			 const struct scsi_cmd *req, int len)
diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index f4003811ee75..91bba1d40785 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -19,6 +19,7 @@
 #include <linux/compiler.h>
 #include <asm/serial.h>
 #include <asm/state.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 5e2e7dfbcb31..e99449f57309 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -19,6 +19,7 @@
 #include <dm/device-internal.h>
 #include <dm/of_access.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index 787edd536027..20cb575e8110 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <errno.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index f146f2b006e8..f2a39872cabb 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -20,6 +20,7 @@
 #include <asm/types.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 struct mtk_serial_regs {
 	u32 rbr;
diff --git a/drivers/serial/serial_octeon_bootcmd.c b/drivers/serial/serial_octeon_bootcmd.c
index eff5c43e2a55..3fe878167972 100644
--- a/drivers/serial/serial_octeon_bootcmd.c
+++ b/drivers/serial/serial_octeon_bootcmd.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <asm/addrspace.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-bootmem.h>
 
diff --git a/drivers/serial/serial_octeon_pcie_console.c b/drivers/serial/serial_octeon_pcie_console.c
index b0eafe7ad866..3199c086733b 100644
--- a/drivers/serial/serial_octeon_pcie_console.c
+++ b/drivers/serial/serial_octeon_pcie_console.c
@@ -16,6 +16,7 @@
 #include <watchdog.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include <mach/cvmx-regs.h>
 #include <mach/cvmx-bootmem.h>
 
diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
index cfa1ec3148c5..478b04332a97 100644
--- a/drivers/serial/serial_semihosting.c
+++ b/drivers/serial/serial_semihosting.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <serial.h>
 #include <semihosting.h>
+#include <linux/string.h>
 
 /**
  * struct smh_serial_priv - Semihosting serial private data
diff --git a/drivers/serial/usbtty.c b/drivers/serial/usbtty.c
index ecb6ba853df7..672808a8cdd1 100644
--- a/drivers/serial/usbtty.c
+++ b/drivers/serial/usbtty.c
@@ -14,6 +14,7 @@
 #include <serial.h>
 #include <stdio_dev.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include "usbtty.h"
 #include "usb_cdc_acm.h"
 #include "usbdescriptors.h"
diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index 17ee6c837c6a..6c4192963a2f 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/sizes.h>
 #include <smem.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/soc/soc-uclass.c b/drivers/soc/soc-uclass.c
index dfad32d80dbe..09ae8d12daad 100644
--- a/drivers/soc/soc-uclass.c
+++ b/drivers/soc/soc-uclass.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <dm/lists.h>
 #include <dm/root.h>
+#include <linux/string.h>
 
 int soc_get(struct udevice **devp)
 {
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index 9881bffc8e17..3dd4de5e75ce 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -25,6 +25,7 @@
 #include <linux/soc/ti/k3-navss-ringacc.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/cppi5.h>
+#include <linux/string.h>
 
 #define set_bit(bit, bitmap)	__set_bit(bit, bitmap)
 #define clear_bit(bit, bitmap)	__clear_bit(bit, bitmap)
diff --git a/drivers/sound/sound.c b/drivers/sound/sound.c
index c0fc50c99dac..a7db3b7c7476 100644
--- a/drivers/sound/sound.c
+++ b/drivers/sound/sound.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <log.h>
 #include <sound.h>
+#include <linux/string.h>
 
 void sound_create_square_wave(uint sample_rate, unsigned short *data, int size,
 			      uint freq, uint channels)
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index de9c14837cda..014f38fb95fb 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/bcm63xx_hsspi.c b/drivers/spi/bcm63xx_hsspi.c
index a24bb430cbb4..389b1f744b72 100644
--- a/drivers/spi/bcm63xx_hsspi.c
+++ b/drivers/spi/bcm63xx_hsspi.c
@@ -17,6 +17,7 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 #define HSSPI_PP			0
 
diff --git a/drivers/spi/bcmstb_spi.c b/drivers/spi/bcmstb_spi.c
index 503c47a2716f..5c249543ac54 100644
--- a/drivers/spi/bcmstb_spi.c
+++ b/drivers/spi/bcmstb_spi.c
@@ -18,6 +18,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <time.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/ca_sflash.c b/drivers/spi/ca_sflash.c
index 38bddd38619e..4fe319444f5b 100644
--- a/drivers/spi/ca_sflash.c
+++ b/drivers/spi/ca_sflash.c
@@ -22,6 +22,7 @@
 #include <spi-mem.h>
 #include <reset.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index a7685a2f512c..c80f5f19c324 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
+#include <linux/string.h>
 #include "cadence_qspi.h"
 #include <dt-bindings/power/xlnx-versal-power.h>
 
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 895f57981b4d..0d562756f226 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -37,6 +37,7 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include "cadence_qspi.h"
 
 __weak void cadence_qspi_apb_enable_linear_mode(bool enable)
diff --git a/drivers/spi/cf_spi.c b/drivers/spi/cf_spi.c
index 1a841b5dcefc..196391747e27 100644
--- a/drivers/spi/cf_spi.c
+++ b/drivers/spi/cf_spi.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <asm/coldfire/dspi.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 struct coldfire_spi_priv {
 	struct dspi *regs;
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 1c7d0ca310b6..a674d41df87a 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -29,6 +29,7 @@
 #include <linux/compat.h>
 #include <linux/iopoll.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 /* Register offsets */
 #define DW_SPI_CTRLR0			0x00
diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index b1d964d79d0c..a080fa6cde4d 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <malloc.h>
 #include <spi.h>
diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 3f97730bad0b..1f67657558b6 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -39,6 +39,7 @@
 #include <linux/sizes.h>
 #include <linux/err.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/gxp_spi.c b/drivers/spi/gxp_spi.c
index 70d76ac66adf..9ef7a72438f5 100644
--- a/drivers/spi/gxp_spi.c
+++ b/drivers/spi/gxp_spi.c
@@ -10,6 +10,7 @@
 #include <spi.h>
 #include <asm/io.h>
 #include <dm.h>
+#include <linux/string.h>
 
 #define GXP_SPI0_MAX_CHIPSELECT		2
 
diff --git a/drivers/spi/ich.c b/drivers/spi/ich.c
index 705abc9cd9b3..f2952655495e 100644
--- a/drivers/spi/ich.c
+++ b/drivers/spi/ich.c
@@ -30,6 +30,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "ich.h"
 
diff --git a/drivers/spi/meson_spifc.c b/drivers/spi/meson_spifc.c
index d99a151406e6..cbff5b073215 100644
--- a/drivers/spi/meson_spifc.c
+++ b/drivers/spi/meson_spifc.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 
 /* register map */
 #define REG_CMD			0x00
diff --git a/drivers/spi/mtk_snfi_spi.c b/drivers/spi/mtk_snfi_spi.c
index 3decb3744de9..96300d37ea61 100644
--- a/drivers/spi/mtk_snfi_spi.c
+++ b/drivers/spi/mtk_snfi_spi.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 
 #define SNFI_MAC_CTL			0x500
 #define MAC_XIO_SEL			BIT(4)
diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 4b7d4a6e0741..ffae56d005f9 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -23,6 +23,7 @@
 #include <stdbool.h>
 #include <watchdog.h>
 #include <linux/dma-mapping.h>
+#include <linux/string.h>
 
 #define DRIVER_NAME "mtk-spi-nor"
 
diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index 418e586b91d9..e81f5bd9345b 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #define SPI_CFG0_REG				0x0000
 #define SPI_CFG1_REG				0x0004
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 9125acafe836..acb9311c074b 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -21,6 +21,7 @@
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/spi.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/mxs_spi.c b/drivers/spi/mxs_spi.c
index 773e26bbed74..66036cfd698e 100644
--- a/drivers/spi/mxs_spi.c
+++ b/drivers/spi/mxs_spi.c
@@ -29,6 +29,7 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/dma.h>
+#include <linux/string.h>
 
 #define	MXS_SPI_MAX_TIMEOUT	1000000
 #define	MXS_SPI_PORT_OFFSET	0x2000
diff --git a/drivers/spi/npcm_fiu_spi.c b/drivers/spi/npcm_fiu_spi.c
index 73c506442ae2..d13a4718b35b 100644
--- a/drivers/spi/npcm_fiu_spi.c
+++ b/drivers/spi/npcm_fiu_spi.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/log2.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #define DW_SIZE			4
diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 579d6bac9b14..d147bf41b2b9 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -14,6 +14,7 @@
  * data lines).
  *
  * FlexSPI controller is driven by the LUT(Look-up Table) registers
+#include <linux/string.h>
  * LUT registers are a look-up-table for sequences of instructions.
  * A valid sequence consists of four LUT registers.
  * Maximum 32 LUT sequences can be programmed simultaneously.
diff --git a/drivers/spi/octeon_spi.c b/drivers/spi/octeon_spi.c
index 4bc38beaa68b..a3c85780c5c0 100644
--- a/drivers/spi/octeon_spi.c
+++ b/drivers/spi/octeon_spi.c
@@ -14,6 +14,7 @@
 #include <linux/bitfield.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define OCTEON_SPI_MAX_BYTES	9
 #define OCTEON_SPI_MAX_CLOCK_HZ	50000000
diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 914eadad9273..707051e195dc 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <spi.h>
 #include <spi-mem.h>
+#include <linux/string.h>
 
 /* System control */
 #define SFC_CTRL			0x0
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 396203102182..d771d24535d4 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -25,6 +25,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <spi-mem.h>
+#include <linux/string.h>
 
 #define ASPEED_SPI_MAX_CS       5
 
diff --git a/drivers/spi/spi-mem-nodm.c b/drivers/spi/spi-mem-nodm.c
index 77ddb19a9f32..019709d45a6a 100644
--- a/drivers/spi/spi-mem-nodm.c
+++ b/drivers/spi/spi-mem-nodm.c
@@ -7,6 +7,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <spi-mem.h>
+#include <linux/string.h>
 
 int spi_mem_exec_op(struct spi_slave *slave,
 		    const struct spi_mem_op *op)
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b7eca5835956..3d10ff62e0c1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -23,6 +23,7 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 #endif
 
 #ifndef __UBOOT__
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f663b9dcbb16..cb35e13e57fd 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -16,6 +16,7 @@
 #include <spi-mem.h>
 #include <linux/bug.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 
 #define HC_CFG			0x0
 #define HC_CFG_IF_CFG(x)	((x) << 27)
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index ea372a05f836..b0ccd77b6bff 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <clk.h>
+#include <linux/string.h>
 
 #define SIFIVE_SPI_MAX_CS		32
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 22910de0dd93..426d30c6b21e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -7,6 +7,7 @@
 #include <fdtdec.h>
 #include <malloc.h>
 #include <spi.h>
+#include <linux/string.h>
 
 int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
 {
diff --git a/drivers/spi/tegra210_qspi.c b/drivers/spi/tegra210_qspi.c
index 5c8c1859cc96..2c8491634f1d 100644
--- a/drivers/spi/tegra210_qspi.c
+++ b/drivers/spi/tegra210_qspi.c
@@ -18,6 +18,7 @@
 #include <fdtdec.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "tegra_spi.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index a987a4f79560..8081fd2e6112 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <spi-mem.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index ec59ef580447..7ad18b7a0ec7 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/sizes.h>
 #include <zynqmp_firmware.h>
+#include <linux/string.h>
 
 #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
 #define GQSPI_CONFIG_MODE_EN_MASK	(3 << 30)
diff --git a/drivers/sysinfo/gpio.c b/drivers/sysinfo/gpio.c
index 82f90303bb70..10cd76b670c6 100644
--- a/drivers/sysinfo/gpio.c
+++ b/drivers/sysinfo/gpio.c
@@ -9,6 +9,7 @@
 #include <sysinfo.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 
 /**
  * struct sysinfo_gpio_priv - GPIO sysinfo private data
diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
index 7b127986da7e..594b68bd3d9f 100644
--- a/drivers/sysinfo/rcar3.c
+++ b/drivers/sysinfo/rcar3.c
@@ -8,6 +8,7 @@
 #include <i2c_eeprom.h>
 #include <log.h>
 #include <sysinfo.h>
+#include <linux/string.h>
 
 #define BOARD_CODE_MASK		0xF8
 #define BOARD_REV_MASK		0x07
diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
index 3750c60b9b99..9618a0ccfd94 100644
--- a/drivers/sysreset/sysreset_sandbox.c
+++ b/drivers/sysreset/sysreset_sandbox.c
@@ -10,6 +10,7 @@
 #include <sysreset.h>
 #include <asm/state.h>
 #include <asm/test.h>
+#include <linux/string.h>
 
 static int sandbox_warm_sysreset_request(struct udevice *dev,
 					 enum sysreset_t type)
diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
index 37f9b094f767..fc164ff6fa86 100644
--- a/drivers/tee/broadcom/chimp_optee.c
+++ b/drivers/tee/broadcom/chimp_optee.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <tee.h>
 #include <broadcom/chimp.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_CHIMP_OPTEE
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 9a9b697e91f5..976b0a315516 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -14,6 +14,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include <tee/optee_service.h>
 
 #include "optee_smc.h"
diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 86219a9bb1af..646b588b4c31 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <sandboxtee.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <tee/optee_ta_avb.h>
 #include <tee/optee_ta_rpc_test.h>
 #include <tee/optee_ta_scp03.h>
diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
index 52412a4098e4..b3ced4904d6f 100644
--- a/drivers/tee/tee-uclass.c
+++ b/drivers/tee/tee-uclass.c
@@ -14,6 +14,7 @@
 #include <asm/cache.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 /**
  * struct tee_uclass_priv - information of a TEE, stored by the uclass
diff --git a/drivers/thermal/imx_scu_thermal.c b/drivers/thermal/imx_scu_thermal.c
index 3ec131cbc6e1..045b02084705 100644
--- a/drivers/thermal/imx_scu_thermal.c
+++ b/drivers/thermal/imx_scu_thermal.c
@@ -15,6 +15,7 @@
 #include <firmware/imx/sci/sci.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 97efc5504439..2c477febd433 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <malloc.h>
 #include <thermal.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index 35d8067c384c..917a1d29baa0 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -23,6 +23,7 @@
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 enum {
 	TIMEOUT_INIT_MS		= 30000, /* Very long timeout for TPM init */
diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
index 7e0b2502e35d..a1a412c44c80 100644
--- a/drivers/tpm/sandbox_common.c
+++ b/drivers/tpm/sandbox_common.c
@@ -11,6 +11,7 @@
 #include <tpm-v1.h>
 #include <tpm-v2.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include "sandbox_common.h"
 
 #define TPM_ERR_CODE_OFS	(2 + 4)		/* after tag and size */
diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
index fcd5c3668eea..90b1b1619e65 100644
--- a/drivers/tpm/tpm-uclass.c
+++ b/drivers/tpm/tpm-uclass.c
@@ -15,6 +15,7 @@
 #include <tpm-v2.h>
 #include <dm/lists.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/unaligned/be_byteshift.h>
 #include "tpm_internal.h"
 
diff --git a/drivers/tpm/tpm2_ftpm_tee.c b/drivers/tpm/tpm2_ftpm_tee.c
index c61ff2c2af63..c5e212091708 100644
--- a/drivers/tpm/tpm2_ftpm_tee.c
+++ b/drivers/tpm/tpm2_ftpm_tee.c
@@ -18,6 +18,7 @@
 #include <log.h>
 #include <tpm-v2.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <tee/optee_service.h>
 
 #include "tpm_tis.h"
diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index e4004cfcca33..bdac45948892 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -10,6 +10,7 @@
 #include <asm/state.h>
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <u-boot/sha256.h>
 #include "sandbox_common.h"
diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index 06c761d15d40..f7db1d275e1b 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned/be_byteshift.h>
 #include <asm-generic/gpio.h>
diff --git a/drivers/tpm/tpm_atmel_twi.c b/drivers/tpm/tpm_atmel_twi.c
index 106a48fea1cf..5ca16358928c 100644
--- a/drivers/tpm/tpm_atmel_twi.c
+++ b/drivers/tpm/tpm_atmel_twi.c
@@ -13,6 +13,7 @@
 #include <i2c.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "tpm_internal.h"
 
diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index a7d780a8bac5..986f0beb7b1f 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -30,6 +30,7 @@
 #include <linux/errno.h>
 #include <linux/compiler.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned/be_byteshift.h>
 
diff --git a/drivers/tpm/tpm_tis_lpc.c b/drivers/tpm/tpm_tis_lpc.c
index 13a133d58ebd..6ad26005ca53 100644
--- a/drivers/tpm/tpm_tis_lpc.c
+++ b/drivers/tpm/tpm_tis_lpc.c
@@ -19,6 +19,7 @@
 #include <tpm-v1.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define PREFIX "lpc_tpm: "
 
diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
index 7350e1c4d525..f12e8db241b5 100644
--- a/drivers/tpm/tpm_tis_sandbox.c
+++ b/drivers/tpm/tpm_tis_sandbox.c
@@ -9,6 +9,7 @@
 #include <tpm-v1.h>
 #include <asm/state.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include "sandbox_common.h"
 
diff --git a/drivers/tpm/tpm_tis_st33zp24_i2c.c b/drivers/tpm/tpm_tis_st33zp24_i2c.c
index 5deae5f47c4e..08f0b6f194f5 100644
--- a/drivers/tpm/tpm_tis_st33zp24_i2c.c
+++ b/drivers/tpm/tpm_tis_st33zp24_i2c.c
@@ -21,6 +21,7 @@
 #include <tpm-v1.h>
 #include <errno.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/tpm/tpm_tis_st33zp24_spi.c b/drivers/tpm/tpm_tis_st33zp24_spi.c
index 4aec9200cb75..fd4d7d7c7f17 100644
--- a/drivers/tpm/tpm_tis_st33zp24_spi.c
+++ b/drivers/tpm/tpm_tis_st33zp24_spi.c
@@ -21,6 +21,7 @@
 #include <tpm-v1.h>
 #include <errno.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/unaligned.h>
 #include <linux/compat.h>
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index ad5dc1ac7952..f943af0ed4ae 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -26,6 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/string.h>
 
 #include "ufs.h"
 
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 7aa0c6b2beef..76c6bb08dea3 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -63,6 +63,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/gadget.h>
 #include <linux/compat.h>
 #include <linux/iopoll.h>
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 7137a569d97c..4bfc31dfb906 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/phy.h>
diff --git a/drivers/usb/common/fsl-dt-fixup.c b/drivers/usb/common/fsl-dt-fixup.c
index 00b8cd368b1a..a40c4c17ac32 100644
--- a/drivers/usb/common/fsl-dt-fixup.c
+++ b/drivers/usb/common/fsl-dt-fixup.c
@@ -15,6 +15,7 @@
 #include <fsl_errata.h>
 #include <fsl_usb.h>
 #include <fdt_support.h>
+#include <linux/string.h>
 
 /* USB Controllers */
 #define FSL_USB2_MPH	"fsl-usb2-mph"
diff --git a/drivers/usb/common/usb_urb.c b/drivers/usb/common/usb_urb.c
index be3b6b9f32e8..a205bbd4da5e 100644
--- a/drivers/usb/common/usb_urb.c
+++ b/drivers/usb/common/usb_urb.c
@@ -8,6 +8,7 @@
 
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 #include <linux/usb/usb_urb_compat.h>
 
 #include <time.h>
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 744fde806948..09af846f5a52 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
diff --git a/drivers/usb/dwc3/dwc3-uniphier.c b/drivers/usb/dwc3/dwc3-uniphier.c
index ab85428a7003..9e4fd5150afa 100644
--- a/drivers/usb/dwc3/dwc3-uniphier.c
+++ b/drivers/usb/dwc3/dwc3-uniphier.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <dm/lists.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/usb/gadget.h>
 
 #include "core.h"
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 75ac993bc645..aee2f93fdbac 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -19,6 +19,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/string.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 68cf32cd189c..04c34338220a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index 7c5c1ab3de73..de3b83901bd5 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -14,6 +14,7 @@
 #include <scsi.h>
 #include <scsi_emul.h>
 #include <usb.h>
+#include <linux/string.h>
 
 /*
  * This driver emulates a flash stick using the UFI command specification and
diff --git a/drivers/usb/emul/sandbox_keyb.c b/drivers/usb/emul/sandbox_keyb.c
index 5ec1e98e4ed4..0658e112d694 100644
--- a/drivers/usb/emul/sandbox_keyb.c
+++ b/drivers/usb/emul/sandbox_keyb.c
@@ -10,6 +10,7 @@
 #include <os.h>
 #include <scsi.h>
 #include <usb.h>
+#include <linux/string.h>
 
 /*
  * This driver emulates a USB keyboard using the USB HID specification (boot
diff --git a/drivers/usb/emul/usb-emul-uclass.c b/drivers/usb/emul/usb-emul-uclass.c
index b31dc950e3ab..d032ab10c0c6 100644
--- a/drivers/usb/emul/usb-emul-uclass.c
+++ b/drivers/usb/emul/usb-emul-uclass.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <usb.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 
 static int copy_to_unicode(char *buff, int length, const char *str)
 {
diff --git a/drivers/usb/eth/asix.c b/drivers/usb/eth/asix.c
index 26dd312b7d06..5f2157e8f123 100644
--- a/drivers/usb/eth/asix.c
+++ b/drivers/usb/eth/asix.c
@@ -14,6 +14,7 @@
 #include <memalign.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 
 /* ASIX AX8817X based USB 2.0 Ethernet Devices */
diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 2e737e606685..b42c456a5b1c 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -12,6 +12,7 @@
 #include <net.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/usb/eth/lan75xx.c b/drivers/usb/eth/lan75xx.c
index 4effbc5c87fb..9c92b28e4dc5 100644
--- a/drivers/usb/eth/lan75xx.c
+++ b/drivers/usb/eth/lan75xx.c
@@ -8,6 +8,7 @@
 #include <usb.h>
 #include <linux/bitops.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 #include "lan7x.h"
 
diff --git a/drivers/usb/eth/lan78xx.c b/drivers/usb/eth/lan78xx.c
index 1d8267c80bb5..301ea16e9878 100644
--- a/drivers/usb/eth/lan78xx.c
+++ b/drivers/usb/eth/lan78xx.c
@@ -8,6 +8,7 @@
 #include <net.h>
 #include <usb.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 #include "lan7x.h"
 
diff --git a/drivers/usb/eth/lan7x.c b/drivers/usb/eth/lan7x.c
index 0a283619ae53..b14836127835 100644
--- a/drivers/usb/eth/lan7x.c
+++ b/drivers/usb/eth/lan7x.c
@@ -12,6 +12,7 @@
 #include <usb.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 #include "lan7x.h"
 
diff --git a/drivers/usb/eth/mcs7830.c b/drivers/usb/eth/mcs7830.c
index d94204f22d5f..64b75e1c560b 100644
--- a/drivers/usb/eth/mcs7830.c
+++ b/drivers/usb/eth/mcs7830.c
@@ -20,6 +20,7 @@
 #include <memalign.h>
 #include <usb.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include "usb_ether.h"
 
diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index 3c866f4f1e2d..0c38bdcba700 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 #include "r8152.h"
 
diff --git a/drivers/usb/eth/smsc95xx.c b/drivers/usb/eth/smsc95xx.c
index 7a686cc3b72f..0c6967619e52 100644
--- a/drivers/usb/eth/smsc95xx.c
+++ b/drivers/usb/eth/smsc95xx.c
@@ -18,6 +18,7 @@
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
+#include <linux/string.h>
 #include "usb_ether.h"
 
 /* SMSC LAN95xx based USB 2.0 Ethernet Devices */
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index e573a03477b9..fb5d50a077c2 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -22,6 +22,7 @@
 #include <asm/gpio.h>
 #include <asm/hardware.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <mach/at91_matrix.h>
 #include <linux/list.h>
 #include <linux/usb/ch9.h>
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f16731c8ebd2..f65cf401a1e6 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -14,6 +14,7 @@
 #include <asm/hardware.h>
 #include <linux/list.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 2bfacfe59f9d..082d662e8f6f 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..2b37ace7f241 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+#include <linux/string.h>
  * composite.c - infrastructure for Composite USB Gadgets
  *
  * Copyright (C) 2006-2008 David Brownell
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 27082f5152cb..d72e05045f7e 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -29,6 +29,7 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 #include <linux/list.h>
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 1c34b753511d..4850f86d7fe7 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -21,6 +21,7 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 static u8 clear_feature_num;
 int clear_feature_flag;
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index bb0d2971d06b..c5c4b9e6c69e 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/errno.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 6616aef9b7bf..fa5a631bc666 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/cdc.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index de42e0189e8d..9d2e4cbda924 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -19,6 +19,7 @@
 #include <stdio_dev.h>
 #include <version.h>
 #include <watchdog.h>
+#include <linux/string.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
index 44877df4ec6b..8a1166a5c4fd 100644
--- a/drivers/usb/gadget/f_dfu.c
+++ b/drivers/usb/gadget/f_dfu.c
@@ -19,6 +19,7 @@
 #include <common.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 741775a7bcf2..1f521237e4cc 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -18,6 +18,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 1d17331cb036..8a2ca4029571 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -21,6 +21,7 @@
  * function can indicate that LUN is removable and/or CD-ROM.  (The
  * later implies read-only access.)
  *
+#include <linux/string.h>
  * MSF is configured by specifying a fsg_config structure.  It has the
  * following fields:
  *
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index 98a7ffa2a752..1a8773ac4866 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 2b3a9c5fd4cd..9ca6bfec873b 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -23,6 +23,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 0e7529dcdbb6..bce5ca515413 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -26,6 +26,7 @@
 #include <version.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index afb7b74f3057..d7e115faf602 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include <mmc.h>
 #include <part.h>
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 98156c312d25..b83eaf03dfed 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -5,6 +5,7 @@
  *
  * This SHOULD eventually work like the ARM mach_is_*() stuff, driven by
  * some config file that gets updated as new hardware is supported.
+#include <linux/string.h>
  * (And avoiding all runtime comparisons in typical one-choice configs!)
  *
  * NOTE:  some of these controller drivers may not be available yet.
diff --git a/drivers/usb/gadget/rndis.c b/drivers/usb/gadget/rndis.c
index e7276ccd37a3..f6a117c99aac 100644
--- a/drivers/usb/gadget/rndis.c
+++ b/drivers/usb/gadget/rndis.c
@@ -22,6 +22,7 @@
 #include <log.h>
 #include <net.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
diff --git a/drivers/usb/gadget/u_os_desc.h b/drivers/usb/gadget/u_os_desc.h
index 4dab4814a360..485f029abdd3 100644
--- a/drivers/usb/gadget/u_os_desc.h
+++ b/drivers/usb/gadget/u_os_desc.h
@@ -16,6 +16,7 @@
 #ifndef __U_OS_DESC_H__
 #define __U_OS_DESC_H__
 
+#include <linux/string.h>
 #include <linux/utf.h>
 
 #define USB_EXT_PROP_DW_SIZE			0
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index e2464ad923f8..7858353dd50e 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/utf.h>
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 59172e529ac9..6375b26e5603 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -22,6 +22,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/usb/otg.h>
 #include <power/regulator.h>
 #include <reset.h>
diff --git a/drivers/usb/host/dwc3-octeon-glue.c b/drivers/usb/host/dwc3-octeon-glue.c
index 975f375e15ad..9c4a52f1da19 100644
--- a/drivers/usb/host/dwc3-octeon-glue.c
+++ b/drivers/usb/host/dwc3-octeon-glue.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include <linux/usb/dwc3.h>
 #include <linux/usb/otg.h>
 #include <mach/octeon-model.h>
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0569dd54fff9..3d0f84d89a58 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 #include <hwconfig.h>
 #include <fsl_usb.h>
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index d5dcfbbfa7ed..8b19a88fcefc 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -23,6 +23,7 @@
 #include <dm/device_compat.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "ehci.h"
 
diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index c11279867c7c..68a04bf4acab 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
index 147b2fa145d6..a314d04478f4 100644
--- a/drivers/usb/host/ehci-mxs.c
+++ b/drivers/usb/host/ehci-mxs.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <linux/delay.h>
 #include <dm.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #include "ehci.h"
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index d0edabcf39e6..6473459bb601 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <usb.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <usb/ulpi.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 2cf16256703d..67b4166bad5e 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -16,6 +16,7 @@
 #include <asm/arch-tegra/usb.h>
 #include <asm/arch-tegra/clk_rst.h>
 #include <usb.h>
+#include <linux/string.h>
 #include <usb/ulpi.h>
 #include <linux/libfdt.h>
 
diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 648e136447d9..d251131ed741 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <usb/ehci-ci.h>
 #include <linux/libfdt.h>
 #include <fdtdec.h>
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3f4418198ccd..3dbf77885658 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -34,6 +34,7 @@
 #include <errno.h>
 #include <asm/cache.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 3ccbc16da379..8cb4928e6ea7 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -14,6 +14,7 @@
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 #include <linux/usb/usb_urb_compat.h>
 #include <power/regulator.h>
 
diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index 625d4938ccee..b42389b9188a 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -9,6 +9,7 @@
 #define __R8A66597_H__
 
 #include <linux/bitops.h>
+#include <linux/string.h>
 #define SYSCFG0		0x00
 #define SYSCFG1		0x02
 #define SYSSTS0		0x04
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..93601ef72a05 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -18,6 +18,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 
 static bool asynch_allowed;
 
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 1dbd65dfaa34..ee43be410032 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -16,6 +16,7 @@
 #include <usb.h>
 #include <dwc3-uboot.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <usb/xhci.h>
 #include <asm/io.h>
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 72b753062650..dcf25747e0f2 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -23,6 +23,7 @@
 #include <asm/cache.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #include <usb/xhci.h>
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5cacf0769ec7..1b4dbc19c19d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -26,6 +26,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <usb.h>
+#include <linux/string.h>
 #include <usb/xhci.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index efacca8485fa..15a4fe229bf0 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/string.h>
 #include <linux/usb/usb_urb_compat.h>
 #include <usb.h>
 #include <linux/io.h>
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..c298919dcdc2 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/iopoll.h>
+#include <linux/string.h>
 #include <linux/usb/composite.h>
 
 #include "mtu3.h"
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index e8dc0095ab58..18e10a6e8c31 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -21,6 +21,7 @@
 #include <asm/cache.h>
 #include <cpu_func.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "mtu3.h"
diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
index ea0a944a87bb..410cf042f66e 100644
--- a/drivers/usb/musb-new/am35x.c
+++ b/drivers/usb/musb-new/am35x.c
@@ -29,6 +29,7 @@
 #include <asm/omap_musb.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "linux-compat.h"
 #endif
 
diff --git a/drivers/usb/musb-new/mt85xx.c b/drivers/usb/musb-new/mt85xx.c
index 1e632dca0462..d422b9fc8f7a 100644
--- a/drivers/usb/musb-new/mt85xx.c
+++ b/drivers/usb/musb-new/mt85xx.c
@@ -17,6 +17,7 @@
 #include <dm/root.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/musb.h>
 #include <usb.h>
 #include "linux-compat.h"
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index 00da554982fe..7b40d61679bf 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -87,6 +87,7 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/musb.h>
diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index c6083963ede9..bd6dbd55ab39 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -27,6 +27,7 @@
 #include <dm/device_compat.h>
 #include <linux/bug.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include "linux-compat.h"
 #endif
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 303284622707..795ea5f210e2 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/usb_urb_compat.h>
diff --git a/drivers/usb/musb-new/pic32.c b/drivers/usb/musb-new/pic32.c
index 4ed5e6e90c6c..2ffadcd42148 100644
--- a/drivers/usb/musb-new/pic32.c
+++ b/drivers/usb/musb-new/pic32.c
@@ -15,6 +15,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/usb/musb.h>
 #include "linux-compat.h"
 #include "musb_core.h"
diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index 91f082fe05ef..ef4282d74af8 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/musb.h>
 #include "linux-compat.h"
 #include "musb_core.h"
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index ed5e5194d8c9..c21ef808344e 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/usb/otg.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index 57c7d5630d37..cfef2da10519 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <generic-phy.h>
 #include <dm/device_compat.h>
+#include <linux/string.h>
 #include "musb_uboot.h"
 
 static struct musb_hdrc_config ux500_musb_hdrc_config = {
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index f945f1f5e2c5..e749ae97180b 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -11,6 +11,7 @@
 
 #include <common.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "am35x.h"
 
diff --git a/drivers/usb/musb/musb_hcd.c b/drivers/usb/musb/musb_hcd.c
index 4676cabae0aa..30a8f8dc9be2 100644
--- a/drivers/usb/musb/musb_hcd.c
+++ b/drivers/usb/musb/musb_hcd.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <usb.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "musb_hcd.h"
 
 /* MSC control transfers */
diff --git a/drivers/video/bridge/anx6345.c b/drivers/video/bridge/anx6345.c
index 93fa25f16e31..17210917e1d3 100644
--- a/drivers/video/bridge/anx6345.c
+++ b/drivers/video/bridge/anx6345.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <video_bridge.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "../anx98xx-edp.h"
 
 #define DP_MAX_LINK_RATE		0x001
diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index cea20dcffa58..0f524a1dc12a 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 #define SSD2825_DEVICE_ID_REG			0xB0
 #define SSD2825_RGB_INTERFACE_CTRL_REG_1	0xB1
diff --git a/drivers/video/console_core.c b/drivers/video/console_core.c
index b5d0e3dceca3..675ed93f8f6f 100644
--- a/drivers/video/console_core.c
+++ b/drivers/video/console_core.c
@@ -10,6 +10,7 @@
 #include <video_console.h>
 #include <dm.h>
 #include <video_font.h>
+#include <linux/string.h>
 #include "vidconsole_internal.h"
 
 /**
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f7..e4cf2b7cbee0 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <video.h>
 #include <video_console.h>
+#include <linux/string.h>
 
 /* Functions needed by stb_truetype.h */
 static int tt_floor(double val)
diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 16db3d38a2c2..b2868413144a 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -13,6 +13,7 @@
 #include <i2c.h>
 #include <media_bus_format.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "dw_hdmi.h"
 
 struct tmds_n_cts {
diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index 22fef7e8825f..5544b1f2d794 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <video_bridge.h>
+#include <linux/string.h>
 
 #define HWVER_131			0x31333100	/* IP version 1.31 */
 
diff --git a/drivers/video/endeavoru-panel.c b/drivers/video/endeavoru-panel.c
index 79a272128b87..8023a78ae15d 100644
--- a/drivers/video/endeavoru-panel.c
+++ b/drivers/video/endeavoru-panel.c
@@ -14,6 +14,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 struct endeavoru_panel_priv {
diff --git a/drivers/video/exynos/exynos_dp.c b/drivers/video/exynos/exynos_dp.c
index a532d5ae1abb..332ec253d7bb 100644
--- a/drivers/video/exynos/exynos_dp.c
+++ b/drivers/video/exynos/exynos_dp.c
@@ -24,6 +24,7 @@
 #include <asm/arch/dp.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
+#include <linux/string.h>
 
 #include "exynos_dp_lowlevel.h"
 
diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 804fcd0b2484..a7536adf0866 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -20,6 +20,7 @@
 #include <asm/arch/power.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clk.h>
+#include <linux/string.h>
 
 #include "exynos_mipi_dsi_lowlevel.h"
 #include "exynos_mipi_dsi_common.h"
diff --git a/drivers/video/himax-hx8394.c b/drivers/video/himax-hx8394.c
index 63637b4db022..e2a383d59fd7 100644
--- a/drivers/video/himax-hx8394.c
+++ b/drivers/video/himax-hx8394.c
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 struct hx8394_panel_priv {
diff --git a/drivers/video/ihs_video_out.c b/drivers/video/ihs_video_out.c
index 73b8f4bd1c9b..fb694d3a3bb1 100644
--- a/drivers/video/ihs_video_out.c
+++ b/drivers/video/ihs_video_out.c
@@ -16,6 +16,7 @@
 #include <regmap.h>
 #include <video_osd.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 static const uint MAX_X_CHARS = 53;
 static const uint MAX_Y_CHARS = 26;
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index b0a99c9cd5d9..3438933b3785 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -14,6 +14,7 @@
 #include <common.h>
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <asm/io.h>
diff --git a/drivers/video/logicore_dp_tx.c b/drivers/video/logicore_dp_tx.c
index 624084d38bca..5945b232ccb1 100644
--- a/drivers/video/logicore_dp_tx.c
+++ b/drivers/video/logicore_dp_tx.c
@@ -15,6 +15,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "axi.h"
 #include "logicore_dp_dpcd.h"
diff --git a/drivers/video/mali_dp.c b/drivers/video/mali_dp.c
index cbcdb99e1f07..88f337d31f38 100644
--- a/drivers/video/mali_dp.c
+++ b/drivers/video/mali_dp.c
@@ -21,6 +21,7 @@
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #define MALIDP_CORE_ID		0x0018
 #define MALIDP_REG_BG_COLOR	0x0044
diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
index e7366dd2fdea..ce64865d591a 100644
--- a/drivers/video/meson/meson_venc.c
+++ b/drivers/video/meson/meson_venc.c
@@ -12,6 +12,7 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/io.h>
+#include <linux/string.h>
 #include "meson_vpu.h"
 
 enum {
diff --git a/drivers/video/mipi_dsi.c b/drivers/video/mipi_dsi.c
index ecacea1dbebd..5caa6a6fef6c 100644
--- a/drivers/video/mipi_dsi.c
+++ b/drivers/video/mipi_dsi.c
@@ -39,6 +39,7 @@
 #include <mipi_display.h>
 #include <mipi_dsi.h>
 #include <dm/devres.h>
+#include <linux/string.h>
 
 /**
  * DOC: dsi helpers
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 10433949bb80..820ed2f080d9 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <malloc.h>
 #include <video.h>
+#include <linux/string.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
diff --git a/drivers/video/nexell_display.c b/drivers/video/nexell_display.c
index af2698ffca84..65fa7eb5ae54 100644
--- a/drivers/video/nexell_display.c
+++ b/drivers/video/nexell_display.c
@@ -20,6 +20,7 @@
 #include <asm/io.h>
 #include <asm/arch/display.h>
 #include <asm/arch/display_dev.h>
+#include <linux/string.h>
 #include "videomodes.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/video/orisetech_otm8009a.c b/drivers/video/orisetech_otm8009a.c
index 848f174b6e48..af2341da7147 100644
--- a/drivers/video/orisetech_otm8009a.c
+++ b/drivers/video/orisetech_otm8009a.c
@@ -15,6 +15,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #define OTM8009A_BACKLIGHT_DEFAULT	240
diff --git a/drivers/video/raydium-rm68200.c b/drivers/video/raydium-rm68200.c
index f1fce55a2cb2..3e0c3ac58827 100644
--- a/drivers/video/raydium-rm68200.c
+++ b/drivers/video/raydium-rm68200.c
@@ -15,6 +15,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 /*** Manufacturer Command Set ***/
diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index 426fdc6224a0..aba61c95a47b 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 /*
diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index d2f716946814..e73d7bcea632 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 /*
diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 8208f0ead4a9..892e757887b6 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -24,6 +24,7 @@
 #include <asm/arch-rockchip/edp_rk3288.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
+#include <linux/string.h>
 
 #define MAX_CR_LOOP 5
 #define MAX_EQ_LOOP 5
diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index c514e2a0e449..45d1381da411 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -27,6 +27,7 @@
 #include <efi_loader.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 #include "rk_vop.h"
 
diff --git a/drivers/video/sandbox_osd.c b/drivers/video/sandbox_osd.c
index 2a854d3958b7..f009cc372961 100644
--- a/drivers/video/sandbox_osd.c
+++ b/drivers/video/sandbox_osd.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <malloc.h>
 #include <video_osd.h>
+#include <linux/string.h>
 
 #include "sandbox_osd.h"
 
diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 6a6473eb0e54..e47c4600f734 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -11,6 +11,7 @@
 #include <mipi_dsi.h>
 #include <panel.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 struct simple_panel_priv {
diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 235ec761f70b..7eb640f4382d 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <video.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 static int simple_video_probe(struct udevice *dev)
 {
diff --git a/drivers/video/stb_truetype.h b/drivers/video/stb_truetype.h
index c6973bb353c3..d7c21767b5ed 100644
--- a/drivers/video/stb_truetype.h
+++ b/drivers/video/stb_truetype.h
@@ -75,6 +75,7 @@
 //   1.12 (2016-10-25) suppress warnings about casting away const with -Wcast-qual
 //   1.11 (2016-04-02) fix unused-variable warning
 //   1.10 (2016-04-02) user-defined fabs(); rare memory leak; remove duplicate typedef
+#include <linux/string.h>
 //   1.09 (2016-01-16) warning fix; avoid crash on outofmem; use allocation userdata properly
 //   1.08 (2015-09-13) document stbtt_Rasterize(); fixes for vertical & horizontal edges
 //   1.07 (2015-08-01) allow PackFontRanges to accept arrays of sparse codepoints;
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index e02d359cd259..ac8699ad8af9 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -20,6 +20,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/display2.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include "simplefb_common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/video/sunxi/sunxi_display.c b/drivers/video/sunxi/sunxi_display.c
index 9110a4848211..7a717b06270a 100644
--- a/drivers/video/sunxi/sunxi_display.c
+++ b/drivers/video/sunxi/sunxi_display.c
@@ -14,6 +14,7 @@
 #include <init.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/display.h>
diff --git a/drivers/video/sunxi/sunxi_lcd.c b/drivers/video/sunxi/sunxi_lcd.c
index 8b9c3b2bfa95..192e24829b5c 100644
--- a/drivers/video/sunxi/sunxi_lcd.c
+++ b/drivers/video/sunxi/sunxi_lcd.c
@@ -17,6 +17,7 @@
 #include <asm/arch/lcdc.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
+#include <linux/string.h>
 
 struct sunxi_lcd_priv {
 	struct display_timing timing;
diff --git a/drivers/video/tdo-tl070wsh30.c b/drivers/video/tdo-tl070wsh30.c
index 273672db024a..7b601cd04791 100644
--- a/drivers/video/tdo-tl070wsh30.c
+++ b/drivers/video/tdo-tl070wsh30.c
@@ -11,6 +11,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 struct tl070wsh30_panel_priv {
diff --git a/drivers/video/tegra124/dp.c b/drivers/video/tegra124/dp.c
index 5f14d41bb688..ec0240d0c661 100644
--- a/drivers/video/tegra124/dp.c
+++ b/drivers/video/tegra124/dp.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <asm/arch-tegra/dc.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "display.h"
 #include "edid.h"
 #include "sor.h"
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index f53ad4639702..a710dcfa9add 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -17,6 +17,7 @@
 #include <asm/system.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 8c3404e085dc..7f35799f46c3 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -14,6 +14,7 @@
 #include <panel.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <power/regulator.h>
 
 #include <asm/gpio.h>
diff --git a/drivers/video/ti/tilcdc-panel.c b/drivers/video/ti/tilcdc-panel.c
index df95086a5151..f2f9159b2826 100644
--- a/drivers/video/ti/tilcdc-panel.c
+++ b/drivers/video/ti/tilcdc-panel.c
@@ -15,6 +15,7 @@
 #include <panel.h>
 #include <asm/gpio.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include "tilcdc.h"
 
 struct tilcdc_panel_priv {
diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index 2734754ecde7..088c72aecc67 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -13,6 +13,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
+#include <linux/string.h>
 #include "tilcdc.h"
 #include "tilcdc-panel.h"
 
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index e285f255d768..31f0765714d6 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -23,6 +23,7 @@
 #include <regmap.h>
 #include <cpu_func.h>
 #include <media_bus_format.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/cache.h>
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index b5b3b6625902..f1e93cb428c2 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -18,6 +18,7 @@
 #include <video_console.h>
 #include <video_font.h>		/* Bitmap font for code page 437 */
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch)
 {
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index bd1bcd6f66c4..261a076de14f 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -27,6 +27,7 @@
 #ifdef CONFIG_SANDBOX
 #include <asm/sdl.h>
 #endif
+#include <linux/string.h>
 
 /*
  * Theory of operation:
diff --git a/drivers/video/videomodes.c b/drivers/video/videomodes.c
index 35955a5df7dd..b86622334657 100644
--- a/drivers/video/videomodes.c
+++ b/drivers/video/videomodes.c
@@ -61,6 +61,7 @@
 #include <errno.h>
 #include <fdtdec.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 #include "videomodes.h"
 
diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
index def4dcf6261a..38d38b20a1c0 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -21,6 +21,7 @@
 #include <linux/ioport.h>
 #include <dm/device_compat.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include "zynqmp_dpsub.h"
 
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c54201627352..3c4b4af23f2b 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -26,6 +26,7 @@
 #include <virtio.h>
 #include <dm/lists.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 78c15c821b4e..9a105797bcc9 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -17,6 +17,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include "virtio_mmio.h"
 
 static int virtio_mmio_get_config(struct udevice *udev, unsigned int offset,
diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
index 1794f73a8de8..d2e005238f6a 100644
--- a/drivers/virtio/virtio_net.c
+++ b/drivers/virtio/virtio_net.c
@@ -10,6 +10,7 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <linux/string.h>
 #include "virtio_net.h"
 
 /* Amount of buffers to keep in the RX virtqueue */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3cdc2d2d6fd3..a2b04a432c22 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include "virtio_pci.h"
 
 #define VIRTIO_PCI_DRV_NAME	"virtio-pci.m"
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c9adcce5c09b..c3dac0108ae2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 static void *virtio_alloc_pages(struct udevice *vdev, u32 npages)
 {
diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
index b85545c2ee5c..de9d100951fa 100644
--- a/drivers/virtio/virtio_rng.c
+++ b/drivers/virtio/virtio_rng.c
@@ -10,6 +10,7 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <linux/string.h>
 
 #define BUFFER_SIZE	16UL
 
diff --git a/drivers/w1-eeprom/ds2502.c b/drivers/w1-eeprom/ds2502.c
index a67f5edd0feb..af25ee235efd 100644
--- a/drivers/w1-eeprom/ds2502.c
+++ b/drivers/w1-eeprom/ds2502.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <w1-eeprom.h>
 #include <w1.h>
+#include <linux/string.h>
 
 #define DS2502_PAGE_SIZE	32
 #define DS2502_PAGE_COUNT	4
diff --git a/drivers/w1-eeprom/eep_sandbox.c b/drivers/w1-eeprom/eep_sandbox.c
index 27c7f9f1b6b8..86c02b9b915b 100644
--- a/drivers/w1-eeprom/eep_sandbox.c
+++ b/drivers/w1-eeprom/eep_sandbox.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <w1-eeprom.h>
 #include <w1.h>
+#include <linux/string.h>
 
 #define W1_F2D_READ_EEPROM      0xf0
 
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 2920c2c751f6..786e6c63eb11 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -5,6 +5,7 @@
 #include <wdt.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 enum {
 	HW_ALGO_TOGGLE,
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index f28636ca9015..a50eda6056d3 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -9,6 +9,7 @@
 #include <wdt.h>
 #include <clock_legacy.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 struct mpc8xxx_wdt {
 	__be32 res0;
diff --git a/drivers/watchdog/sandbox_alarm-wdt.c b/drivers/watchdog/sandbox_alarm-wdt.c
index 71bb5d924ea5..6208f2a254b0 100644
--- a/drivers/watchdog/sandbox_alarm-wdt.c
+++ b/drivers/watchdog/sandbox_alarm-wdt.c
@@ -2,6 +2,7 @@
 #include <dm.h>
 #include <os.h>
 #include <wdt.h>
+#include <linux/string.h>
 
 struct alarm_wdt_priv {
 	unsigned int timeout_sec;
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index ed329284decb..a39a0618c267 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/xen/pvblock.c b/drivers/xen/pvblock.c
index 4ad548d599d5..546a7cbf3728 100644
--- a/drivers/xen/pvblock.c
+++ b/drivers/xen/pvblock.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <malloc.h>
 #include <part.h>
+#include <linux/string.h>
 
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
diff --git a/drivers/xen/xenbus.c b/drivers/xen/xenbus.c
index 177d144723c1..3221f5f7fe30 100644
--- a/drivers/xen/xenbus.c
+++ b/drivers/xen/xenbus.c
@@ -17,6 +17,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <linux/string.h>
 
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
diff --git a/env/callback.c b/env/callback.c
index 98ddba035ea7..09d0dd9c715b 100644
--- a/env/callback.c
+++ b/env/callback.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <env_internal.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 /*
  * Look up a callback function pointer by name
diff --git a/env/common.c b/env/common.c
index eb1a91379539..da336085dedb 100644
--- a/env/common.c
+++ b/env/common.c
@@ -20,6 +20,7 @@
 #include <search.h>
 #include <errno.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <dm/ofnode.h>
 #include <net.h>
diff --git a/env/env.c b/env/env.c
index bae3f6482aea..d3aca2f84c2f 100644
--- a/env/env.c
+++ b/env/env.c
@@ -11,6 +11,7 @@
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/env/ext4.c b/env/ext4.c
index 47e05a489193..2ebe04fda8e8 100644
--- a/env/ext4.c
+++ b/env/ext4.c
@@ -20,6 +20,7 @@
 
 #include <common.h>
 #include <part.h>
+#include <linux/string.h>
 
 #include <command.h>
 #include <env.h>
diff --git a/env/fat.c b/env/fat.c
index 3172130d75d3..e0f7453327bd 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -21,6 +21,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SPL_BUILD
 /* TODO(sjg@chromium.org): Figure out why this is needed */
diff --git a/env/flash.c b/env/flash.c
index 1e75f8c004ee..6bf92ec951c9 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <search.h>
 #include <errno.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/env/mmc.c b/env/mmc.c
index cb14bbb58f13..d7759f13aadb 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <command.h>
 #include <env.h>
diff --git a/env/nvram.c b/env/nvram.c
index 229c34f5367c..15c9fb2da13f 100644
--- a/env/nvram.c
+++ b/env/nvram.c
@@ -15,6 +15,7 @@
 #include <linux/stddef.h>
 #include <search.h>
 #include <errno.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/env/sf.c b/env/sf.c
index a425ecc11c8e..4f8359253379 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -21,6 +21,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #define	OFFSET_INVALID		(~(u32)0)
diff --git a/env/ubi.c b/env/ubi.c
index 445d34fedb89..87d7df48a1d8 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <command.h>
 #include <env.h>
diff --git a/examples/api/demo.c b/examples/api/demo.c
index d586174ce8c9..789847c401ea 100644
--- a/examples/api/demo.c
+++ b/examples/api/demo.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <env.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <api_public.h>
 
diff --git a/examples/api/glue.c b/examples/api/glue.c
index 075d307ae261..97b7c54c31b0 100644
--- a/examples/api/glue.c
+++ b/examples/api/glue.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <env.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <api_public.h>
 #include <u-boot/crc.h>
diff --git a/examples/standalone/atmel_df_pow2.c b/examples/standalone/atmel_df_pow2.c
index dcb25da94986..bb017fe80ba0 100644
--- a/examples/standalone/atmel_df_pow2.c
+++ b/examples/standalone/atmel_df_pow2.c
@@ -10,6 +10,7 @@
 #include <exports.h>
 #include <spi.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define CMD_ID    0x9f
 #define CMD_STAT  0xd7
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8e932adc425d..0a8f5d3e4989 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include "btrfs.h"
 #include "disk-io.h"
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ffd095ffdd2e..8529d8e5ba03 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <linux/bug.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include "kernel-shared/btrfs_tree.h"
 #include "crypto/hash.h"
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7eaa7e949604..9d7b5e0079d4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4,6 +4,7 @@
 #include <log.h>
 #include <uuid.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include "kernel-shared/btrfs_tree.h"
 #include "common/rbtree-utils.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index f4d56a084b96..03c218b5ece7 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include "btrfs.h"
 #include "ctree.h"
 #include "extent-io.h"
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4691612eda33..024fac95f560 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include "btrfs.h"
 #include "disk-io.h"
 #include "volumes.h"
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 68ca7e48e48e..593a1fe6df5c 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -6,6 +6,7 @@
  */
 
 #include <malloc.h>
+#include <linux/string.h>
 #include "ctree.h"
 #include "btrfs.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7d4095d9ca88..10da3bf8895b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2,6 +2,7 @@
 #include <stdlib.h>
 #include <common.h>
 #include <fs_internal.h>
+#include <linux/string.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "volumes.h"
diff --git a/fs/cbfs/cbfs.c b/fs/cbfs/cbfs.c
index 714f4baafc9e..2481ae72ee0d 100644
--- a/fs/cbfs/cbfs.c
+++ b/fs/cbfs/cbfs.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/byteorder.h>
+#include <linux/string.h>
 
 /* Offset of master header from the start of a coreboot ROM */
 #define MASTER_HDR_OFFSET	0x38
diff --git a/fs/cramfs/cramfs.c b/fs/cramfs/cramfs.c
index abb2de34eb05..12ef683a3888 100644
--- a/fs/cramfs/cramfs.c
+++ b/fs/cramfs/cramfs.c
@@ -31,6 +31,7 @@
 #include <jffs2/jffs2.h>
 #include <jffs2/load_kernel.h>
 #include <cramfs/cramfs_fs.h>
+#include <linux/string.h>
 
 /* These two macros may change in future, to provide better st_ino
    semantics. */
diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 9a9c520e22ca..0cc01f5ada0e 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -28,6 +28,7 @@
 #include <part.h>
 #include <stddef.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #include <linux/time.h>
 #include <asm/byteorder.h>
 #include "ext4_common.h"
diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index 504c708b0647..6ea2dc5caf26 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -29,6 +29,7 @@
 #include "ext4_journal.h"
 #include <linux/crc16.h>
 #endif
+#include <linux/string.h>
 
 #define YES		1
 #define NO		0
diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 1a340b4764c6..580003a03f2c 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -5,6 +5,7 @@
  * Uma Shankar <uma.shankar@samsung.com>
  * Manjunatha C Achar <a.manjunatha@samsung.com>
  *
+#include <linux/string.h>
  * Journal data structures and headers for Journaling feature of ext4
  * have been referred from JBD2 (Journaling Block device 2)
  * implementation in Linux Kernel.
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index ea4c5d4157cc..335563ba6c33 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -29,6 +29,7 @@
 #include <part.h>
 #include <linux/stat.h>
 #include <div64.h>
+#include <linux/string.h>
 #include "ext4_common.h"
 
 static inline void ext4fs_sb_free_inodes_inc(struct ext2_sblock *sb)
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4ad..55335c7e9512 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -24,6 +24,7 @@
 #include <blk.h>
 #include <ext_common.h>
 #include <ext4fs.h>
+#include <linux/string.h>
 #include "ext4_common.h"
 #include <div64.h>
 #include <malloc.h>
diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 8ff1fd0ec835..f658c1784f64 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -24,6 +24,7 @@
 #include <asm/cache.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 8b5d669b0050..8b9b4aead2e4 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -20,6 +20,7 @@
 #include <asm/cache.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
+#include <linux/string.h>
 #include "fat.c"
 
 static dir_entry *find_directory_entry(fat_itr *itr, char *filename);
diff --git a/fs/fs.c b/fs/fs.c
index 5351c560e721..0a8a079d6475 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -32,6 +32,7 @@
 #include <efi_loader.h>
 #include <squashfs.h>
 #include <erofs.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/fs/fs_internal.c b/fs/fs_internal.c
index 111f91b355d1..3a889ebb60f0 100644
--- a/fs/fs_internal.c
+++ b/fs/fs_internal.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <part.h>
 #include <memalign.h>
+#include <linux/string.h>
 
 int fs_devread(struct blk_desc *blk, struct disk_partition *partition,
 	       lbaint_t sector, int byte_offset, int byte_len, char *buf)
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 49ba82ef9596..579d6e40f5bb 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -117,6 +117,7 @@
 #include <div64.h>
 #include <linux/compiler.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #include <linux/time.h>
 #include <u-boot/crc.h>
 #include <watchdog.h>
diff --git a/fs/jffs2/mini_inflate.c b/fs/jffs2/mini_inflate.c
index 3072eedd8c16..117e8f58b304 100644
--- a/fs/jffs2/mini_inflate.c
+++ b/fs/jffs2/mini_inflate.c
@@ -9,6 +9,7 @@
 
 #include <config.h>
 #include <jffs2/mini_inflate.h>
+#include <linux/string.h>
 
 /* The order that the code lengths in section 3.2.7 are in */
 static unsigned char huffman_order[] = {16, 17, 18,  0,  8,  7,  9,  6, 10,  5,
diff --git a/fs/reiserfs/reiserfs.c b/fs/reiserfs/reiserfs.c
index 635aab2eba7c..d5cf5431d4d3 100644
--- a/fs/reiserfs/reiserfs.c
+++ b/fs/reiserfs/reiserfs.c
@@ -11,6 +11,7 @@
  */
 
 /* An implementation for the ReiserFS filesystem ported from GRUB.
+#include <linux/string.h>
  * Some parts of this code (mainly the structures and defines) are
  * from the original reiser fs code, as found in the linux kernel.
  */
diff --git a/fs/sandbox/host_bootdev.c b/fs/sandbox/host_bootdev.c
index 3ef53627608a..63765608c43b 100644
--- a/fs/sandbox/host_bootdev.c
+++ b/fs/sandbox/host_bootdev.c
@@ -12,6 +12,7 @@
 #include <bootmeth.h>
 #include <dm.h>
 #include <fs.h>
+#include <linux/string.h>
 
 static int host_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
 			     struct bootflow *bflow)
diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 1430e671a5a8..b70ab4c250e1 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -11,6 +11,7 @@
 #include <div64.h>
 #include <errno.h>
 #include <fs.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <linux/compat.h>
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index de9c644a952e..5124b8d126bf 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <dm/devres.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #ifndef __UBOOT__
 #include <linux/module.h>
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 9962cbe7eb37..9700d0fde156 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -39,6 +39,7 @@
  * to @c->max_write_size bytes again. We do this by temporarily shrinking
  * write-buffer size (@wbuf->size).
  *
+#include <linux/string.h>
  * Write-buffers are defined by 'struct ubifs_wbuf' objects and protected by
  * mutexes defined inside these objects. Since sometimes upper-level code
  * has to lock the write-buffer (e.g. journal space reservation code), many
diff --git a/fs/ubifs/key.h b/fs/ubifs/key.h
index 70c2faf331b8..f5b19525621e 100644
--- a/fs/ubifs/key.h
+++ b/fs/ubifs/key.h
@@ -33,6 +33,7 @@
  * reserved for "." and "..". %2 is reserved for "end of readdir" marker. This
  * function makes sure the reserved values are not used.
  */
+#include <linux/string.h>
 static inline uint32_t key_mask_hash(uint32_t hash)
 {
 	hash &= UBIFS_S_KEY_HASH_MASK;
diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 77ff52575eaa..0c8671a88478 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #endif
 #include "ubifs.h"
 
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index a9e22abe6b40..83e6b2d5df2c 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -20,6 +20,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #endif
 #include "ubifs.h"
 
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index 2e50c08f4dfa..3de55f72acb5 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/crc16.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #endif
 #include "ubifs.h"
 
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 6b6884fb2098..0852a955dcb7 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -12,6 +12,7 @@
  * This file implements functions needed to recover from unclean un-mounts.
  * When UBIFS is mounted, it checks a flag on the master node to determine if
  * an un-mount was completed successfully. If not, the process of mounting
+#include <linux/string.h>
  * incorporates additional checking and fixing of on-flash data structures.
  * UBIFS always cleans away all remnants of an unclean un-mount, so that
  * errors do not accumulate. However UBIFS defers recovery if it is mounted
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index aa7f281ef6b5..0862fe4ebf3b 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -25,6 +25,7 @@
 #include <dm/devres.h>
 #include <linux/compat.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #endif
 #include "ubifs.h"
 #include <linux/bug.h>
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 3e7160352e6c..901a8549e1a0 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -38,6 +38,7 @@
 #include <linux/printk.h>
 #include <linux/stat.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include "ubifs.h"
 #include <ubi_uboot.h>
 #include <linux/stringify.h>
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 4fb10045ff2f..d80b2b22e932 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -30,6 +30,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #endif
 #include "ubifs.h"
 
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index a509584e5d71..213fd1ba8dbe 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -18,6 +18,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include "ubifs.h"
 #include <part.h>
 #include <dm/devres.h>
diff --git a/fs/yaffs2/yaffs_mtdif2.c b/fs/yaffs2/yaffs_mtdif2.c
index 81a4d964f3e9..9cf4deee99e1 100644
--- a/fs/yaffs2/yaffs_mtdif2.c
+++ b/fs/yaffs2/yaffs_mtdif2.c
@@ -17,6 +17,7 @@
 #include <common.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #include "yportenv.h"
 #include "yaffs_trace.h"
diff --git a/fs/yaffs2/yaffs_uboot_glue.c b/fs/yaffs2/yaffs_uboot_glue.c
index 0a920561149a..92799d2724d5 100644
--- a/fs/yaffs2/yaffs_uboot_glue.c
+++ b/fs/yaffs2/yaffs_uboot_glue.c
@@ -23,6 +23,7 @@
 #include <div64.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 
 #include <config.h>
 #include "nand.h"
diff --git a/fs/yaffs2/yaffsfs.c b/fs/yaffs2/yaffsfs.c
index d615f02d3fcd..fbb1ba9cf05e 100644
--- a/fs/yaffs2/yaffsfs.c
+++ b/fs/yaffs2/yaffsfs.c
@@ -12,6 +12,7 @@
  */
 
 #include <div64.h>
+#include <linux/string.h>
 #include "yaffsfs.h"
 #include "yaffs_guts.h"
 #include "yaffscfg.h"
diff --git a/fs/yaffs2/ydirectenv.h b/fs/yaffs2/ydirectenv.h
index d274f22e84d0..a68c76378673 100644
--- a/fs/yaffs2/ydirectenv.h
+++ b/fs/yaffs2/ydirectenv.h
@@ -23,6 +23,7 @@
 #include <common.h>
 #include <malloc.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 
 #include "yaffs_osglue.h"
 
diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 1fec96cd5ce5..8958a2562277 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 #include <linux/time.h>
 #include <linux/ctype.h>
 #include <asm/byteorder.h>
diff --git a/include/dm/of.h b/include/dm/of.h
index b1c934f610d3..6b7349f18639 100644
--- a/include/dm/of.h
+++ b/include/dm/of.h
@@ -9,6 +9,7 @@
 
 #include <asm/u-boot.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 /* integer value within a device tree property which references another node */
 typedef u32 phandle;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4a29ddaef420..852c38510d92 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -18,6 +18,7 @@
 #include <pe.h>
 #include <linux/list.h>
 #include <linux/oid_registry.h>
+#include <linux/string.h>
 
 struct blk_desc;
 struct jmp_buf_data;
diff --git a/include/exception.h b/include/exception.h
index a7f21e73d753..7f4638e42523 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <linux/string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/include/exports.h b/include/exports.h
index 0452de735b9c..01ee39073e57 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -13,6 +13,7 @@
 
 #include <irq_func.h>
 #include <time.h>
+#include <linux/string.h>
 
 struct cmd_tbl;
 struct spi_slave;
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 2cd836689821..d26bd973fe50 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -120,6 +120,7 @@ static inline int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[],
 }
 #endif
 
+#include <linux/string.h>
 void fdt_fixup_ethernet(void *fdt);
 int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
 			 const void *val, int len, int create);
diff --git a/include/imx8image.h b/include/imx8image.h
index 32064bfeeb8c..293f59b6cecb 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -10,6 +10,7 @@
 
 #include <image.h>
 #include <inttypes.h>
+#include <linux/string.h>
 #include "imagetool.h"
 
 #define __packed   __attribute__((packed))
diff --git a/include/linux/string.h b/include/linux/string.h
index df1c1c5669c4..38eecd2616a4 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
+#include <stddef.h>
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 
diff --git a/include/net.h b/include/net.h
index e254df7d7f43..1a831009234d 100644
--- a/include/net.h
+++ b/include/net.h
@@ -12,6 +12,7 @@
 #ifndef __NET_H__
 #define __NET_H__
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>	/* for nton* / ntoh* stuff */
diff --git a/include/net6.h b/include/net6.h
index 1e766aa72092..315154fed740 100644
--- a/include/net6.h
+++ b/include/net6.h
@@ -12,6 +12,7 @@
 
 #include <net.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 /* struct in6_addr - 128 bits long IPv6 address */
 struct in6_addr {
diff --git a/include/part.h b/include/part.h
index db34bc6bb7d9..860175857387 100644
--- a/include/part.h
+++ b/include/part.h
@@ -12,6 +12,7 @@
 #include <linker_lists.h>
 #include <linux/errno.h>
 #include <linux/list.h>
+#include <linux/string.h>
 
 struct block_drvr {
 	char *name;
diff --git a/include/phy_interface.h b/include/phy_interface.h
index 31be3228c7c4..3bb6ec35c482 100644
--- a/include/phy_interface.h
+++ b/include/phy_interface.h
@@ -11,6 +11,7 @@
 #define _PHY_INTERFACE_H
 
 #include <string.h>
+#include <linux/string.h>
 
 typedef enum {
 	PHY_INTERFACE_MODE_NA, /* don't touch */
diff --git a/include/spi_flash.h b/include/spi_flash.h
index 10d19fd4b117..72511e22dbb7 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -9,6 +9,7 @@
 #ifndef _SPI_FLASH_H_
 #define _SPI_FLASH_H_
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/mtd/spi-nor.h>
 
diff --git a/include/test/ut.h b/include/test/ut.h
index ea6ee95d7344..771103833e69 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <hexdump.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <test/test.h>
 
 struct unit_test_state;
diff --git a/include/tlv_eeprom.h b/include/tlv_eeprom.h
index fd45e5f6ebb6..c84a77552500 100644
--- a/include/tlv_eeprom.h
+++ b/include/tlv_eeprom.h
@@ -17,6 +17,7 @@
  *
  * See the end of this file for details of this eeprom format
  */
+#include <linux/string.h>
 struct __attribute__ ((__packed__)) tlvinfo_header {
 	char    signature[8]; /* 0x00 - 0x07 EEPROM Tag "TlvInfo" */
 	u8      version;      /* 0x08        Structure version    */
diff --git a/include/video_console.h b/include/video_console.h
index 2694e44f6ecf..8d255fc9d8ce 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -7,6 +7,7 @@
 #define __video_console_h
 
 #include <video.h>
+#include <linux/string.h>
 
 struct video_priv;
 
diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 3c5c87deda99..4d8638a62cfc 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -25,6 +25,7 @@
  * and grant_table.h from the Xen public headers.
  */
 
+#include <linux/string.h>
 #include <xen/interface/grant_table.h>
 
 typedef unsigned int RING_IDX;
diff --git a/lib/abuf.c b/lib/abuf.c
index ce2cff53dc93..dd3011675c51 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <string.h>
+#include <linux/string.h>
 #endif
 
 #include <abuf.h>
diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index 14b15754f492..d53d3ec2c4b7 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -9,6 +9,7 @@
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/acpi/acpi_device.c b/lib/acpi/acpi_device.c
index 1b838fdbd6f0..dcd3b60c2e22 100644
--- a/lib/acpi/acpi_device.c
+++ b/lib/acpi/acpi_device.c
@@ -16,6 +16,7 @@
 #include <acpi/acpigen.h>
 #include <asm-generic/gpio.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 /**
  * acpi_device_path_fill() - Find the root device and build a path from there
diff --git a/lib/acpi/acpi_dp.c b/lib/acpi/acpi_dp.c
index 7e3e3259d8d4..7d75c87649e1 100644
--- a/lib/acpi/acpi_dp.c
+++ b/lib/acpi/acpi_dp.c
@@ -14,6 +14,7 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_dp.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 static void acpi_dp_write_array(struct acpi_ctx *ctx,
 				const struct acpi_dp *array);
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index a8d4b470001d..8893bbb17e4c 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -15,6 +15,7 @@
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 /*
  * OEM_REVISION is 32-bit unsigned number. It should be increased only when
diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
index 946f90e8e7b1..ba81252c3d77 100644
--- a/lib/acpi/acpi_writer.c
+++ b/lib/acpi/acpi_writer.c
@@ -14,6 +14,7 @@
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/acpi/acpigen.c b/lib/acpi/acpigen.c
index e395226e3de3..548f4629198f 100644
--- a/lib/acpi/acpigen.c
+++ b/lib/acpi/acpigen.c
@@ -16,6 +16,7 @@
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 /* CPU path format */
 #define ACPI_CPU_STRING "\\_PR.CP%02d"
diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 2057bd2bef88..19c23cd67bf4 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -12,6 +12,7 @@
 #include <dm/acpi.h>
 #include <mapmem.h>
 #include <tables_csum.h>
+#include <linux/string.h>
 
 void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
 		     struct acpi_xsdt *xsdt)
diff --git a/lib/acpi/csrt.c b/lib/acpi/csrt.c
index 2ba86f229529..eea425ff7dff 100644
--- a/lib/acpi/csrt.c
+++ b/lib/acpi/csrt.c
@@ -12,6 +12,7 @@
 #include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 __weak int acpi_fill_csrt(struct acpi_ctx *ctx)
 {
diff --git a/lib/acpi/dsdt.c b/lib/acpi/dsdt.c
index db98cc20e1d0..2f0441162b47 100644
--- a/lib/acpi/dsdt.c
+++ b/lib/acpi/dsdt.c
@@ -11,6 +11,7 @@
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
 #include <tables_csum.h>
+#include <linux/string.h>
 
 /*
  * IASL compiles the dsdt entries and writes the hex values
diff --git a/lib/acpi/facs.c b/lib/acpi/facs.c
index e89f43ca5c91..fbe17607e8ed 100644
--- a/lib/acpi/facs.c
+++ b/lib/acpi/facs.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 int acpi_write_facs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
diff --git a/lib/acpi/mcfg.c b/lib/acpi/mcfg.c
index 7404ae586ab7..e8e463ec3f8a 100644
--- a/lib/acpi/mcfg.c
+++ b/lib/acpi/mcfg.c
@@ -12,6 +12,7 @@
 #include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
 			      u16 seg_nr, u8 start, u8 end)
diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index 659c1aad406b..6212bf7c50c2 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -11,6 +11,7 @@
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
 #include <tables_csum.h>
+#include <linux/string.h>
 
 int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
diff --git a/lib/aes.c b/lib/aes.c
index 4fca85ebee26..dd740ff4b201 100644
--- a/lib/aes.c
+++ b/lib/aes.c
@@ -25,6 +25,7 @@
 #include <common.h>
 #include <display_options.h>
 #include <log.h>
+#include <linux/string.h>
 #else
 #include <string.h>
 #endif
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 345029fa7847..06b5e0274094 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -6,6 +6,7 @@
 #ifndef USE_HOSTCC
 #include <common.h>
 #include <malloc.h>
+#include <linux/string.h>
 #endif
 #include <image.h>
 #include <uboot_aes.h>
diff --git a/lib/bch.c b/lib/bch.c
index 72b4fdcc9c44..1a4ab2029b4e 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -11,6 +11,7 @@
  * This library provides runtime configurable encoding/decoding of binary
  * Bose-Chaudhuri-Hocquenghem (BCH) codes.
  *
+#include <linux/string.h>
  * Call init_bch to get a pointer to a newly allocated bch_control structure for
  * the given m (Galois field order), t (error correction capability) and
  * (optional) primitive polynomial parameters.
diff --git a/lib/blake2/blake2-impl.h b/lib/blake2/blake2-impl.h
index 7ee52fdf5ada..2eda5f2b0518 100644
--- a/lib/blake2/blake2-impl.h
+++ b/lib/blake2/blake2-impl.h
@@ -26,6 +26,7 @@
 
 #include <stdint.h>
 #include <string.h>
+#include <linux/string.h>
 
 #define BLAKE2_INLINE inline
 
diff --git a/lib/blake2/blake2b.c b/lib/blake2/blake2b.c
index 686138ef24b0..5a00049730cc 100644
--- a/lib/blake2/blake2b.c
+++ b/lib/blake2/blake2b.c
@@ -24,6 +24,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdio.h>
+#include <linux/string.h>
 #include <u-boot/blake2.h>
 #include "blake2-impl.h"
 
diff --git a/lib/bzip2/bzlib.c b/lib/bzip2/bzlib.c
index bd589aa810c1..6674115338a7 100644
--- a/lib/bzip2/bzlib.c
+++ b/lib/bzip2/bzlib.c
@@ -2,6 +2,7 @@
 #include <common.h>
 #include <malloc.h>
 #include <watchdog.h>
+#include <linux/string.h>
 
 /*
  * This file is a modified version of bzlib.c from the bzip2-1.0.2
diff --git a/lib/charset.c b/lib/charset.c
index 5e4c4f948a4a..15609a7f01f3 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -12,6 +12,7 @@
 #include <efi_loader.h>
 #include <errno.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 /**
  * codepage_437 - Unicode to codepage 437 translation table
diff --git a/lib/crc16-ccitt.c b/lib/crc16-ccitt.c
index 6cadbc103d3e..942db1387d65 100644
--- a/lib/crc16-ccitt.c
+++ b/lib/crc16-ccitt.c
@@ -26,6 +26,7 @@
 #include <arpa/inet.h>
 #else
 #include <common.h>
+#include <linux/string.h>
 #endif
 #include <u-boot/crc.h>
 
diff --git a/lib/crc32.c b/lib/crc32.c
index f6fad8c15dfc..d643b26c14ab 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -13,6 +13,7 @@
 #else
 #include <common.h>
 #include <efi_loader.h>
+#include <linux/string.h>
 #endif
 #include <compiler.h>
 #include <u-boot/crc.h>
diff --git a/lib/crypt/crypt.c b/lib/crypt/crypt.c
index 247c34b2a9c3..858e4ad9e579 100644
--- a/lib/crypt/crypt.c
+++ b/lib/crypt/crypt.c
@@ -3,6 +3,7 @@
 
 #include <common.h>
 #include <crypt.h>
+#include <linux/string.h>
 #include "crypt-port.h"
 
 typedef int (*crypt_fn)(const char *, size_t, const char *, size_t, uint8_t *,
diff --git a/lib/crypto/pkcs7_verify.c b/lib/crypto/pkcs7_verify.c
index 9d7b9f6bce83..1a63cfedeac1 100644
--- a/lib/crypto/pkcs7_verify.c
+++ b/lib/crypto/pkcs7_verify.c
@@ -16,6 +16,7 @@
 #include <linux/compat.h>
 #include <linux/asn1.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <u-boot/hash-checksum.h>
 #include <crypto/public_key.h>
 #include <crypto/pkcs7_parser.h>
diff --git a/lib/crypto/public_key.c b/lib/crypto/public_key.c
index 6efe951c057c..7f26ef9c7c03 100644
--- a/lib/crypto/public_key.c
+++ b/lib/crypto/public_key.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #else
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index 30071233ee79..78bb48a79031 100644
--- a/lib/crypto/x509_public_key.c
+++ b/lib/crypto/x509_public_key.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #else
 #include <linux/module.h>
 #endif
diff --git a/lib/dhry/dhry.h b/lib/dhry/dhry.h
index 892c9ed73b8d..e05178cb041e 100644
--- a/lib/dhry/dhry.h
+++ b/lib/dhry/dhry.h
@@ -136,6 +136,7 @@
  *              distribution of the executed statements should not be
  *              changed, there are still cases where optimizing compilers
  *              may not generate code for some statements. To a certain
+#include <linux/string.h>
  *              degree, this is unavoidable for small synthetic benchmarks.
  *              Users of the benchmark are advised to check code listings
  *              whether code is generated for all statements of Dhrystone.
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 5fa9be10b4bb..80984b624c25 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -20,6 +20,7 @@
 
 #define OPENSSL_API_COMPAT 0x10101000L
 
+#include <linux/string.h>
 #include <u-boot/ecdsa.h>
 #include <u-boot/fdt-libcrypto.h>
 #include <openssl/ssl.h>
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 0601700c4fc6..305786963cc4 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -3,6 +3,7 @@
  * ECDSA signature verification for u-boot
  *
  * This implements the firmware-side wrapper for ECDSA verification. It bridges
+#include <linux/string.h>
  * the struct crypto_algo API to the ECDSA uclass implementations.
  *
  * Copyright (c) 2020, Alexandru Gagniuc <mr.nuke.me@gmail.com>
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 2209410f35b5..6484282cb8cd 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <efi.h>
 #include <efi_api.h>
diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index c9eb32ec1046..b01e3cbea3d5 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/io.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #ifndef CONFIG_X86
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 3ce2a07f9eb0..b218bb07eaa1 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -11,6 +11,7 @@
 #include <efi_dt_fixup.h>
 #include <part.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 
 #define BUFFER_SIZE 64
 #define ESC 0x17
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c83..f628e2a9164a 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -15,6 +15,7 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..eb32e0ff0881 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -16,6 +16,7 @@
 #include <malloc.h>
 #include <pe.h>
 #include <time.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <usb.h>
 #include <watchdog.h>
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index af8a2ee940ce..279433e6c28a 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -21,6 +21,7 @@
 #include <sort.h>
 #include <sysreset.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #include <crypto/pkcs7.h>
 #include <crypto/pkcs7_parser.h>
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index a2d137d7a9e1..38913ef311e0 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -19,6 +19,7 @@
 #include <stdio_dev.h>
 #include <video_console.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define EFI_COUT_MODE_2 2
 #define EFI_MAX_COUT_MODE 3
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a347..58f1658c1199 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -21,6 +21,7 @@
 #include <uuid.h>
 #include <asm-generic/unaligned.h>
 #include <linux/compat.h> /* U16_MAX */
+#include <linux/string.h>
 
 /* template END node: */
 const struct efi_device_path END = {
diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 8c76d8be605d..e5cadb2aee18 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -9,6 +9,7 @@
 #include <blk.h>
 #include <efi_loader.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #define MAC_OUTPUT_LEN 22
 #define UNKNOWN_OUTPUT_LEN 23
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b001..fc85d214b82f 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <part.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 struct efi_system_partition efi_system_partition = {
 	.uclass_id = UCLASS_INVALID,
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 3c56cebf9653..ad0defcac8fa 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -13,6 +13,7 @@
 #include <mapmem.h>
 #include <fs.h>
 #include <part.h>
+#include <linux/string.h>
 
 /* GUID for file system information */
 const efi_guid_t efi_file_system_info_guid = EFI_FILE_SYSTEM_INFO_GUID;
diff --git a/lib/efi_loader/efi_freestanding.c b/lib/efi_loader/efi_freestanding.c
index 4b65fc64dd04..0ab1b3d418c7 100644
--- a/lib/efi_loader/efi_freestanding.c
+++ b/lib/efi_loader/efi_freestanding.c
@@ -5,6 +5,7 @@
  * Copyright 2019, Heinrich Schuchardt <xypron.glpk@gmx.de>
  *
  * GCC requires that freestanding programs provide memcpy(), memmove(),
+#include <linux/string.h>
  * memset(), and memcmp().
  */
 
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 778b693f983a..9e76515f1335 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <video.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index cdfd16ea7742..d039aa49d493 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -12,6 +12,7 @@
 #include <efi_load_initrd.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/string.h>
 
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INITRD)
 /* GUID used by Linux to identify the LoadFile2 protocol with the initrd */
diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 3b54ecb11ac1..869490ca2d6e 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier:     GPL-2.0+
 /*
+#include <linux/string.h>
  *  EFI Human Interface Infrastructure ... database and packages
  *
  *  Copyright (c) 2017 Leif Lindholm
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 97547571ce33..403c63ad4fef 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -19,6 +19,7 @@
 #include <crypto/mscode.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 const efi_guid_t efi_global_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 const efi_guid_t efi_guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
diff --git a/lib/efi_loader/efi_load_options.c b/lib/efi_loader/efi_load_options.c
index 5f62184da1cd..ad816d40525d 100644
--- a/lib/efi_loader/efi_load_options.c
+++ b/lib/efi_loader/efi_load_options.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <efi_loader.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 
 /**
  * efi_set_load_options() - set the load options of a loaded image
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f752703b438e..dbc0b5cf22c4 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <linux/list_sort.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 96a5bcca2758..4c71880baf04 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -19,6 +19,7 @@
 #include <efi_loader.h>
 #include <malloc.h>
 #include <net.h>
+#include <linux/string.h>
 
 static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index bf54d6ad871d..51731ad90d69 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <rtc.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /* For manual relocation support */
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index e6de685e8795..2ac58a1abdd9 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -12,6 +12,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
+#include <linux/string.h>
 
 #define OBJ_LIST_NOT_INITIALIZED 1
 
diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 742d8919402c..c20ab8865544 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -16,6 +16,7 @@
 #include <crypto/public_key.h>
 #include <linux/compat.h>
 #include <linux/oid_registry.h>
+#include <linux/string.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/rsa.h>
 #include <u-boot/sha256.h>
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 7b7926a0d46b..92cf8e652e62 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -19,6 +19,7 @@
 #include <version_string.h>
 #include <tpm-v2.h>
 #include <tpm_api.h>
+#include <linux/string.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
index c4c75720634a..023c6076cf8b 100644
--- a/lib/efi_loader/efi_unicode_collation.c
+++ b/lib/efi_loader/efi_unicode_collation.c
@@ -10,6 +10,7 @@
 #include <cp1250.h>
 #include <cp437.h>
 #include <efi_loader.h>
+#include <linux/string.h>
 
 /* Characters that may not be used in FAT 8.3 file names */
 static const char illegal[] = "+,<=>:;\"/\\|?*[]\x7f";
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd8341..c967aaf62f32 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -15,6 +15,7 @@
 #include <mapmem.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 #define PART_STR_LEN 10
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 5fa7dcb8d3ed..95bd797feb25 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 /*
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6ef..1a1e6e6f5198 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -20,6 +20,7 @@
 #include <uuid.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <asm/sections.h>
 
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 09d03c0eee78..6ee37e09a201 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -24,6 +24,7 @@
 #include <mapmem.h>
 #include <mm_communication.h>
 #include <tee.h>
+#include <linux/string.h>
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 /* MM return codes */
diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index bd72822c0b72..ddf790c26b36 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -16,6 +16,7 @@
  */
 
 #include <efi_api.h>
+#include <linux/string.h>
 
 static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
 static const efi_guid_t device_path_to_text_protocol_guid =
diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index a367e8b89d17..f2e676163bdb 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -16,6 +16,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 #include "efi_selftest_disk_image.h"
 #include <asm/cache.h>
 
diff --git a/lib/efi_selftest/efi_selftest_config_table.c b/lib/efi_selftest/efi_selftest_config_table.c
index 1961e299348e..f93fee60b1df 100644
--- a/lib/efi_selftest/efi_selftest_config_table.c
+++ b/lib/efi_selftest/efi_selftest_config_table.c
@@ -9,6 +9,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 
 static const struct efi_system_table *sys_table;
diff --git a/lib/efi_selftest/efi_selftest_ecpt.c b/lib/efi_selftest/efi_selftest_ecpt.c
index 09c5e96c5e12..5b63b4ccf9f9 100644
--- a/lib/efi_selftest/efi_selftest_ecpt.c
+++ b/lib/efi_selftest/efi_selftest_ecpt.c
@@ -8,6 +8,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 static const efi_guid_t guid_ecpt = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
 static const efi_guid_t guid_ebbr_2_1 = EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
diff --git a/lib/efi_selftest/efi_selftest_load_file.c b/lib/efi_selftest/efi_selftest_load_file.c
index 14df76117279..003a8ac54681 100644
--- a/lib/efi_selftest/efi_selftest_load_file.c
+++ b/lib/efi_selftest/efi_selftest_load_file.c
@@ -9,6 +9,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 /* Include containing the miniapp.efi application */
 #include "efi_miniapp_file_image_exit.h"
 
diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_selftest/efi_selftest_loaded_image.c
index 5889ab126175..01f6dee2ea6e 100644
--- a/lib/efi_selftest/efi_selftest_loaded_image.c
+++ b/lib/efi_selftest/efi_selftest_loaded_image.c
@@ -8,6 +8,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 static efi_guid_t loaded_image_protocol_guid =
 	EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,
diff --git a/lib/efi_selftest/efi_selftest_loadimage.c b/lib/efi_selftest/efi_selftest_loadimage.c
index 24548f1ae639..5b55d7d0d816 100644
--- a/lib/efi_selftest/efi_selftest_loadimage.c
+++ b/lib/efi_selftest/efi_selftest_loadimage.c
@@ -11,6 +11,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 /* Include containing the efi_selftest_miniapp_exit.efi application */
 #include "efi_miniapp_file_image_exit.h"
 
diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_selftest/efi_selftest_manageprotocols.c
index 097b2ae35456..e9d3734ea62c 100644
--- a/lib/efi_selftest/efi_selftest_manageprotocols.c
+++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
@@ -12,6 +12,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 /*
  * The test currently does not actually call the interface function.
diff --git a/lib/efi_selftest/efi_selftest_mem.c b/lib/efi_selftest/efi_selftest_mem.c
index 51f0fec39b9b..c5f0d7ccfa15 100644
--- a/lib/efi_selftest/efi_selftest_mem.c
+++ b/lib/efi_selftest/efi_selftest_mem.c
@@ -11,6 +11,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 static struct efi_boot_services *boottime;
 
diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/efi_selftest_memory.c
index 4d32a2800613..2efb6e42aa25 100644
--- a/lib/efi_selftest/efi_selftest_memory.c
+++ b/lib/efi_selftest/efi_selftest_memory.c
@@ -11,6 +11,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 #define EFI_ST_NUM_PAGES 8
 
diff --git a/lib/efi_selftest/efi_selftest_rng.c b/lib/efi_selftest/efi_selftest_rng.c
index 007d1c82e9a1..2f174621325a 100644
--- a/lib/efi_selftest/efi_selftest_rng.c
+++ b/lib/efi_selftest/efi_selftest_rng.c
@@ -9,6 +9,7 @@
 
 #include <efi_selftest.h>
 #include <efi_rng.h>
+#include <linux/string.h>
 
 #define RNG_LEN 9
 
diff --git a/lib/efi_selftest/efi_selftest_set_virtual_address_map.c b/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
index d28ed83eb371..99329b7e7425 100644
--- a/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
+++ b/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
@@ -9,6 +9,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 static const struct efi_boot_services *boottime;
 static const struct efi_runtime_services *runtime;
diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
index 15af8d3e18c9..d34bc9f99752 100644
--- a/lib/efi_selftest/efi_selftest_snp.c
+++ b/lib/efi_selftest/efi_selftest_snp.c
@@ -16,6 +16,7 @@
 
 #include <efi_selftest.h>
 #include <net.h>
+#include <linux/string.h>
 
 /*
  * MAC address for broadcasts
diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
index b65a10b7a4bf..2f58c6e0b885 100644
--- a/lib/efi_selftest/efi_selftest_startimage_exit.c
+++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
@@ -10,6 +10,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 /* Include containing the miniapp.efi application */
 #include "efi_miniapp_file_image_exit.h"
 
diff --git a/lib/efi_selftest/efi_selftest_tcg2.c b/lib/efi_selftest/efi_selftest_tcg2.c
index 67a886efaa85..c4a96d3f848b 100644
--- a/lib/efi_selftest/efi_selftest_tcg2.c
+++ b/lib/efi_selftest/efi_selftest_tcg2.c
@@ -9,6 +9,7 @@
 
 #include <efi_selftest.h>
 #include <efi_tcg2.h>
+#include <linux/string.h>
 /*
  * Include containing the miniapp.efi application.
  * Note that tcg2 selftest measures the PE/COFF image,
diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index c7a3fdbaa67d..74e0324b3e43 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -9,6 +9,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 80
diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 4700d9424105..23724badf7c8 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -10,6 +10,7 @@
  */
 
 #include <efi_selftest.h>
+#include <linux/string.h>
 
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 40
diff --git a/lib/elf.c b/lib/elf.c
index 0476b2614c33..5116e53ee19d 100644
--- a/lib/elf.c
+++ b/lib/elf.c
@@ -15,6 +15,7 @@
 #include <asm/e820.h>
 #include <linux/linkage.h>
 #endif
+#include <linux/string.h>
 
 /*
  * A very simple ELF64 loader, assumes the image is valid, returns the
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a6916764835..fa55beb665c6 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -32,6 +32,7 @@
 #include <linux/ctype.h>
 #include <linux/lzo.h>
 #include <linux/ioport.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/fdtdec_test.c b/lib/fdtdec_test.c
index 85351c75ca29..3dec57b58063 100644
--- a/lib/fdtdec_test.c
+++ b/lib/fdtdec_test.c
@@ -12,6 +12,7 @@
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <os.h>
+#include <linux/string.h>
 
 /* The size of our test fdt blob */
 #define FDT_SIZE	(16 * 1024)
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index b58057401539..a815941da4c4 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -11,6 +11,7 @@
 #include <fwu.h>
 #include <fwu_mdata.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include <linux/errno.h>
 #include <linux/types.h>
diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index 69cd3d7001f9..a6ed0a5c8dbb 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -12,6 +12,7 @@
 #include <mtd.h>
 #include <uuid.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 #include <dm/ofnode.h>
 
diff --git a/lib/getopt.c b/lib/getopt.c
index 8b4515dc1967..c4b82b027eff 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <getopt.h>
 #include <log.h>
+#include <linux/string.h>
 
 void getopt_init_state(struct getopt_state *gs)
 {
diff --git a/lib/gunzip.c b/lib/gunzip.c
index 932e3e8036d1..24066bf88482 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -13,6 +13,7 @@
 #include <image.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <linux/string.h>
 #include <u-boot/crc.h>
 #include <watchdog.h>
 #include <u-boot/zlib.h>
diff --git a/lib/hashtable.c b/lib/hashtable.c
index f2d36bd34b4c..804f2e456a4c 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <sort.h>
+#include <linux/string.h>
 
 #ifdef USE_HOSTCC		/* HOST build */
 # include <string.h>
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 8f8a67e15804..9318c15b44c5 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -44,6 +44,7 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <asm/cache.h>
+#include <linux/string.h>
 
 #include <linux/math64.h>
 #include <linux/err.h>
diff --git a/lib/libavb/avb_sysdeps_posix.c b/lib/libavb/avb_sysdeps_posix.c
index 6ffdb0b7eb35..88135b90850c 100644
--- a/lib/libavb/avb_sysdeps_posix.c
+++ b/lib/libavb/avb_sysdeps_posix.c
@@ -7,6 +7,7 @@
 #include <malloc.h>
 #include <stdarg.h>
 #include <stdlib.h>
+#include <linux/string.h>
 
 #include "avb_sysdeps.h"
 
diff --git a/lib/linux_compat.c b/lib/linux_compat.c
index c83426f59dc2..8b9b562f98ea 100644
--- a/lib/linux_compat.c
+++ b/lib/linux_compat.c
@@ -4,6 +4,7 @@
 #include <memalign.h>
 #include <asm/cache.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 
 struct p_current cur = {
 	.pid = 1,
diff --git a/lib/list_sort.c b/lib/list_sort.c
index 1c9e06173270..44d85ff43fee 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #endif
 #include <linux/list.h>
 #include <linux/list_sort.h>
diff --git a/lib/lz4.c b/lib/lz4.c
index 5337842126c8..e09d377e2954 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -30,6 +30,7 @@
 #include <common.h>
 #include <compiler.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <asm/unaligned.h>
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index 67dea2ff3904..f3d0090475da 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -7,6 +7,7 @@
 #include <compiler.h>
 #include <image.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/unaligned.h>
 #include <u-boot/lz4.h>
diff --git a/lib/lzo/lzo1x_decompress.c b/lib/lzo/lzo1x_decompress.c
index 65fef0b0eb90..48800c91ccff 100644
--- a/lib/lzo/lzo1x_decompress.c
+++ b/lib/lzo/lzo1x_decompress.c
@@ -15,6 +15,7 @@
 #include <linux/lzo.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include "lzodefs.h"
 
 #define HAVE_IP(x, ip_end, ip) ((size_t)(ip_end - ip) < (x))
diff --git a/lib/md5.c b/lib/md5.c
index 1636ab936619..7fb9461ab28b 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -15,6 +15,7 @@
  * with every copy.
  *
  * To compute the message digest of a chunk of bytes, declare an
+#include <linux/string.h>
  * MD5Context structure, pass it to MD5Init, call MD5Update as
  * needed on buffers full of bytes, and then call MD5Final, which
  * will fill a supplied 16-byte array with the digest.
diff --git a/lib/membuff.c b/lib/membuff.c
index 36dc43a523fb..b0fc716a04be 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include "membuff.h"
 
 void membuff_purge(struct membuff *mb)
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 4283c13a31d9..c2daa6db437d 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <net.h>
 #include <net6.h>
+#include <linux/string.h>
 
 struct in_addr string_to_ip(const char *s)
 {
diff --git a/lib/of_live.c b/lib/of_live.c
index 25f7af61061e..a284882800be 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <dm/of_access.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 static void *unflatten_dt_alloc(void **mem, unsigned long size,
 				unsigned long align)
diff --git a/lib/optee/optee.c b/lib/optee/optee.c
index b03622404469..4b3a71df67a8 100644
--- a/lib/optee/optee.c
+++ b/lib/optee/optee.c
@@ -12,6 +12,7 @@
 #include <dm/ofnode.h>
 #include <linux/ioport.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 #include <tee/optee.h>
 
 #define optee_hdr_err_msg \
diff --git a/lib/physmem.c b/lib/physmem.c
index fc90ce4d7cfd..43f034766ab8 100644
--- a/lib/physmem.c
+++ b/lib/physmem.c
@@ -13,6 +13,7 @@
 #include <mapmem.h>
 #include <physmem.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 phys_addr_t __weak arch_phys_memset(phys_addr_t s, int c, phys_size_t n)
 {
diff --git a/lib/qsort.c b/lib/qsort.c
index 2f18588dfccd..c2e2ec232ca3 100644
--- a/lib/qsort.c
+++ b/lib/qsort.c
@@ -11,6 +11,7 @@
  * Ray Gardner and found in Bob Stout's snippets collection.  The
  * original code is included below in an #if 0/#endif block.
  *
+#include <linux/string.h>
  * I modified it to avoid the possibility of overflow in the wgap
  * calculation, as well as to reduce the generated code size with
  * bcc and gcc. */
diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 98855f67b890..257bfd2cd6b4 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -13,6 +13,7 @@
 #include <image.h>
 #include <malloc.h>
 #include <crypto/internal/rsa.h>
+#include <linux/string.h>
 #include <u-boot/rsa-mod-exp.h>
 #include <asm/unaligned.h>
 
diff --git a/lib/rsa/rsa-mod-exp.c b/lib/rsa/rsa-mod-exp.c
index d259b2aedf27..3107dd4c9a6b 100644
--- a/lib/rsa/rsa-mod-exp.c
+++ b/lib/rsa/rsa-mod-exp.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <asm/types.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #else
 #include "fdt_host.h"
 #include "mkimage.h"
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 2f3b34403913..e74a3cc2981c 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/unaligned.h>
 #include <dm.h>
+#include <linux/string.h>
 #else
 #include "fdt_host.h"
 #include "mkimage.h"
diff --git a/lib/semihosting.c b/lib/semihosting.c
index 831774e35664..9dfa0a2db065 100644
--- a/lib/semihosting.c
+++ b/lib/semihosting.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <log.h>
 #include <semihosting.h>
+#include <linux/string.h>
 
 #define SYSOPEN		0x01
 #define SYSCLOSE	0x02
diff --git a/lib/slre.c b/lib/slre.c
index e82a9e7635b1..da17c018d839 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -26,6 +26,7 @@
 #endif /* SLRE_TEST */
 
 #include <errno.h>
+#include <linux/string.h>
 
 #include <slre.h>
 
diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index 2b9392936b99..28e04203fa60 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <smbios.h>
+#include <linux/string.h>
 
 static inline int verify_checksum(const struct smbios_entry *e)
 {
diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..1c1c70c57a03 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <dm.h>
 #include <env.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <mapmem.h>
 #include <smbios.h>
diff --git a/lib/strto.c b/lib/strto.c
index 154921165cb2..4b406b42554d 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 /* from lib/kstrtox.c */
 static const char *_parse_integer_fixup_radix(const char *s, uint *basep)
diff --git a/lib/tpm-common.c b/lib/tpm-common.c
index 82ffdc5341bc..e8f06e3c520b 100644
--- a/lib/tpm-common.c
+++ b/lib/tpm-common.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <asm/unaligned.h>
 #include <tpm-common.h>
+#include <linux/string.h>
 #include "tpm-utils.h"
 
 enum tpm_version tpm_get_version(struct udevice *dev)
diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index 60a18ca50400..f6aea6ce9f25 100644
--- a/lib/tpm-v1.c
+++ b/lib/tpm-v1.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <log.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 #include <u-boot/sha1.h>
 #include <tpm-common.h>
 #include <tpm-v1.h>
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 9ab5b46df177..98bcb4906038 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -9,6 +9,7 @@
 #include <tpm-common.h>
 #include <tpm-v2.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include "tpm-utils.h"
 
 u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
diff --git a/lib/trace.c b/lib/trace.c
index 4874bef861bf..1403cb61d245 100644
--- a/lib/trace.c
+++ b/lib/trace.c
@@ -10,6 +10,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/sections.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/uuid.c b/lib/uuid.c
index afb40bff507a..a1c2dfc86091 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -24,6 +24,7 @@
 #include <malloc.h>
 #include <dm/uclass.h>
 #include <rng.h>
+#include <linux/string.h>
 
 int uuid_str_valid(const char *uuid)
 {
diff --git a/net/arp.c b/net/arp.c
index 742e0438130b..7292b6426f7f 100644
--- a/net/arp.c
+++ b/net/arp.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #include "arp.h"
 
diff --git a/net/bootp.c b/net/bootp.c
index 594eeb196dc9..fd8e2a95165b 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -19,6 +19,7 @@
 #include <time.h>
 #include <uuid.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <net/tftp.h>
 #include "bootp.h"
 #ifdef CONFIG_LED_STATUS
diff --git a/net/cdp.c b/net/cdp.c
index a8f890e75226..45d9a1f76994 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -11,6 +11,7 @@
 
 #include <common.h>
 #include <net.h>
+#include <linux/string.h>
 
 #include "cdp.h"
 
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 34ac66b40254..1b93be95d536 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include "net_rand.h"
 #include "dhcpv6.h"
 
diff --git a/net/dns.c b/net/dns.c
index 677e39dd0318..12182c9501ce 100644
--- a/net/dns.c
+++ b/net/dns.c
@@ -29,6 +29,7 @@
 #include <net.h>
 #include <time.h>
 #include <asm/unaligned.h>
+#include <linux/string.h>
 
 #include "dns.h"
 
diff --git a/net/dsa-uclass.c b/net/dsa-uclass.c
index f64c68e340dc..6bb1134e3f71 100644
--- a/net/dsa-uclass.c
+++ b/net/dsa-uclass.c
@@ -3,6 +3,7 @@
  * Copyright 2019-2021 NXP
  */
 
+#include <linux/string.h>
 #include <net/dsa.h>
 #include <dm/lists.h>
 #include <dm/device_compat.h>
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 4311f3fe6e89..f05bc94c6b42 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <net/pcap.h>
 #include "eth_internal.h"
 #include <eth_phy.h>
diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index 869adf8cbbd3..1473ae58fad1 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -18,6 +18,7 @@
 #include <init.h>
 #include <log.h>
 #include <net.h>
+#include <linux/string.h>
 #include <test/test.h>
 
 static int eth_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
diff --git a/net/eth_common.c b/net/eth_common.c
index 14d4c07b695d..27c57effcdda 100644
--- a/net/eth_common.c
+++ b/net/eth_common.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <miiphy.h>
 #include <net.h>
+#include <linux/string.h>
 #include "eth_internal.h"
 
 int eth_env_get_enetaddr_by_index(const char *base_name, int index,
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 2eb52ea25679..3c6b93e89d52 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <fastboot.h>
 #include <net.h>
+#include <linux/string.h>
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
 
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index 58cd3c7ae1c2..b84f8fe5c361 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -8,6 +8,7 @@
 #include <fastboot.h>
 #include <net.h>
 #include <time.h>
+#include <linux/string.h>
 #include <net/fastboot_udp.h>
 #include <linux/printk.h>
 
diff --git a/net/link_local.c b/net/link_local.c
index 16bc5c8b90ad..0ddd1bd061fb 100644
--- a/net/link_local.c
+++ b/net/link_local.c
@@ -17,6 +17,7 @@
 #include <net.h>
 #include <rand.h>
 #include <time.h>
+#include <linux/string.h>
 #include "arp.h"
 #include "net_rand.h"
 
diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
index e758cc66d7e0..8c6f8a07b857 100644
--- a/net/mdio-uclass.c
+++ b/net/mdio-uclass.c
@@ -14,6 +14,7 @@
 #include <dm/of_extra.h>
 #include <dm/uclass-internal.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 
 void dm_mdio_probe_devices(void)
 {
diff --git a/net/ndisc.c b/net/ndisc.c
index 4518f34b2078..827910d7d7eb 100644
--- a/net/ndisc.c
+++ b/net/ndisc.c
@@ -16,6 +16,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 /* IPv6 destination address of packet waiting for ND */
 struct in6_addr net_nd_sol_packet_ip6 = ZERO_IPV6_ADDR;
diff --git a/net/net.c b/net/net.c
index ee10fb61d6f9..1ab455e25717 100644
--- a/net/net.c
+++ b/net/net.c
@@ -94,6 +94,7 @@
 #include <net6.h>
 #include <ndisc.h>
 #include <time.h>
+#include <linux/string.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/tftp.h>
diff --git a/net/net6.c b/net/net6.c
index cb47b79109da..9fcf7ac58609 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -16,6 +16,7 @@
 #include <net6.h>
 #include <ndisc.h>
 #include <time.h>
+#include <linux/string.h>
 
 /* NULL IPv6 address */
 struct in6_addr const net_null_addr_ip6 = ZERO_IPV6_ADDR;
diff --git a/net/net_rand.h b/net/net_rand.h
index 6a52cda85e03..0fe284c0b816 100644
--- a/net/net_rand.h
+++ b/net/net_rand.h
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <dm/uclass.h>
 #include <rng.h>
+#include <linux/string.h>
 
 /*
  * Return a seed for the PRNG derived from the eth0 MAC address.
diff --git a/net/nfs.c b/net/nfs.c
index 7a8887ef2368..f3967881eaa3 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -9,6 +9,7 @@
  * large portions are copied verbatim) as distributed in OSKit 0.97.  A few
  * changes were necessary to adapt the code to Etherboot and to fix several
  * inconsistencies.  Also the RPC message preparation is done "by hand" to
+#include <linux/string.h>
  * avoid adding netsprintf() which I find hard to understand and use.  */
 
 /* NOTE 2: Etherboot does not care about things beyond the kernel image, so
diff --git a/net/pcap.c b/net/pcap.c
index 4036d8a3fa53..981f8f750e23 100644
--- a/net/pcap.c
+++ b/net/pcap.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <net.h>
+#include <linux/string.h>
 #include <net/pcap.h>
 #include <time.h>
 #include <asm/io.h>
diff --git a/net/ping6.c b/net/ping6.c
index 1707da21c3d6..f39e238fa04e 100644
--- a/net/ping6.c
+++ b/net/ping6.c
@@ -13,6 +13,7 @@
 #include <net.h>
 #include <net6.h>
 #include <time.h>
+#include <linux/string.h>
 #include "ndisc.h"
 
 static ushort seq_no;
diff --git a/net/rarp.c b/net/rarp.c
index 231b6233c07a..5f14f30a1e8f 100644
--- a/net/rarp.c
+++ b/net/rarp.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <log.h>
 #include <net.h>
+#include <linux/string.h>
 #include <net/tftp.h>
 #include "nfs.h"
 #include "bootp.h"
diff --git a/net/sntp.c b/net/sntp.c
index 81c85e3c2f93..90aba778adca 100644
--- a/net/sntp.c
+++ b/net/sntp.c
@@ -12,6 +12,7 @@
 #include <net.h>
 #include <rtc.h>
 #include <time.h>
+#include <linux/string.h>
 
 #include <net/sntp.h>
 
diff --git a/net/tftp.c b/net/tftp.c
index e1e5925aabf8..e1c4e191a147 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -18,6 +18,7 @@
 #include <net6.h>
 #include <time.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <net/tftp.h>
 #include "bootp.h"
 
diff --git a/net/wget.c b/net/wget.c
index 07b274bf0f21..28568129b56c 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -12,6 +12,7 @@
 #include <mapmem.h>
 #include <net.h>
 #include <time.h>
+#include <linux/string.h>
 #include <net/tcp.h>
 #include <net/wget.h>
 
diff --git a/net/wol.c b/net/wol.c
index 0a625668a992..e985f4adc59d 100644
--- a/net/wol.c
+++ b/net/wol.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <net.h>
+#include <linux/string.h>
 #include "wol.h"
 
 static ulong wol_timeout = WOL_DEFAULT_TIMEOUT;
diff --git a/post/drivers/flash.c b/post/drivers/flash.c
index a1fcf1f135d9..d71fde87f9a1 100644
--- a/post/drivers/flash.c
+++ b/post/drivers/flash.c
@@ -30,6 +30,7 @@
 # error "invalid flash block start/end"
 #endif
 
+#include <linux/string.h>
 static void *seed_src_data(void *ptr, ulong *old_len, ulong new_len)
 {
 	unsigned char *p;
diff --git a/post/lib_powerpc/multi.c b/post/lib_powerpc/multi.c
index 4df45790ab65..8abfa27a9031 100644
--- a/post/lib_powerpc/multi.c
+++ b/post/lib_powerpc/multi.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <irq_func.h>
 #include <log.h>
+#include <linux/string.h>
 
 /*
  * CPU test
diff --git a/post/lib_powerpc/string.c b/post/lib_powerpc/string.c
index 21e02bcb2664..c1c14cc5f7e6 100644
--- a/post/lib_powerpc/string.c
+++ b/post/lib_powerpc/string.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <irq_func.h>
+#include <linux/string.h>
 
 /*
  * CPU test
diff --git a/post/post.c b/post/post.c
index 946d9094d451..f03ef857efee 100644
--- a/post/post.c
+++ b/post/post.c
@@ -15,6 +15,7 @@
 #include <div64.h>
 #include <post.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 
 #ifdef CFG_SYS_POST_HOTKEYS_GPIO
 #include <asm/gpio.h>
diff --git a/test/bloblist.c b/test/bloblist.c
index 720be7e244ff..f4f43c88401f 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 6b29213416db..08b4c091536b 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -13,6 +13,7 @@
 #include <bootflow.h>
 #include <mapmem.h>
 #include <os.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f5b2059140ac..f972acb97b1f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -19,6 +19,7 @@
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index e71a2975c53c..24eb4d108ead 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -13,6 +13,7 @@
 #include <memalign.h>
 #include <mmc.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include <u-boot/crc.h>
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 90027409c817..5724bd341d0b 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -11,6 +11,7 @@
 #include <menu.h>
 #include <video.h>
 #include <linux/input.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
diff --git a/test/bootm.c b/test/bootm.c
index 4bb3ca0655cf..20d03a01c444 100644
--- a/test/bootm.c
+++ b/test/bootm.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <bootm.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 8c09281cac0d..df1e6035ae89 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -10,6 +10,7 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include <dm.h>
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 1f103a1d7eb4..1ac567aa130b 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -11,6 +11,7 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 41e005ac5923..fd22518ddb2f 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -14,6 +14,7 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index f80c9c406873..8455e5c0b28b 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 #define BUF_SIZE	0x100
diff --git a/test/cmd/rw.c b/test/cmd/rw.c
index 98302bf047b1..a607a8e7d373 100644
--- a/test/cmd/rw.c
+++ b/test/cmd/rw.c
@@ -7,6 +7,7 @@
 #include <dm/test.h>
 #include <mapmem.h>
 #include <part.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e32b..0aacaa1ff5ef 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/ut.h>
 
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index ed83fc94a5e2..4beb33990832 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <linux/string.h>
 #include <net/tcp.h>
 #include <net/wget.h>
 #include <asm/eth.h>
diff --git a/test/command_ut.c b/test/command_ut.c
index a74bd109e153..4dc0a7af3dbd 100644
--- a/test/command_ut.c
+++ b/test/command_ut.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <string.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 static const char test_cmd[] = "setenv list 1\n setenv list ${list}2; "
 		"setenv list ${list}3\0"
diff --git a/test/compression.c b/test/compression.c
index 3df90819a1fb..9b7b1965302b 100644
--- a/test/compression.c
+++ b/test/compression.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/io.h>
+#include <linux/string.h>
 
 #include <u-boot/lz4.h>
 #include <u-boot/zlib.h>
diff --git a/test/dm/acpi_dp.c b/test/dm/acpi_dp.c
index 44bcabda6bc1..6c3694cbb2cb 100644
--- a/test/dm/acpi_dp.c
+++ b/test/dm/acpi_dp.c
@@ -14,6 +14,7 @@
 #include <asm/unaligned.h>
 #include <dm/acpi.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/ut.h>
 #include "acpi.h"
 
diff --git a/test/dm/axi.c b/test/dm/axi.c
index dc029df5e443..a30e25bc549b 100644
--- a/test/dm/axi.c
+++ b/test/dm/axi.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <asm/axi.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/blkmap.c b/test/dm/blkmap.c
index 7a163d6eaef2..a99f21938950 100644
--- a/test/dm/blkmap.c
+++ b/test/dm/blkmap.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <asm/test.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index e4ebb93cdad4..dc2e70ee0ae5 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -11,6 +11,7 @@
 #include <dm/test.h>
 #include <dm/uclass.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <sandbox-clk.h>
diff --git a/test/dm/core.c b/test/dm/core.c
index 7f3f8d183bca..421ad24c22f8 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -17,6 +17,7 @@
 #include <dm/util.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/cpu.c b/test/dm/cpu.c
index 5734cd0a92d3..bfebe631c537 100644
--- a/test/dm/cpu.c
+++ b/test/dm/cpu.c
@@ -10,6 +10,7 @@
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
 #include <cpu.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/devres.c b/test/dm/devres.c
index 3df0f64362dc..3e06aad3ba4f 100644
--- a/test/dm/devres.c
+++ b/test/dm/devres.c
@@ -14,6 +14,7 @@
 #include <dm/devres.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 /* Test that devm_kmalloc() allocates memory, free when device is removed */
diff --git a/test/dm/dma.c b/test/dm/dma.c
index cce47cb21803..3158ec135e98 100644
--- a/test/dm/dma.c
+++ b/test/dm/dma.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <dm/test.h>
 #include <dma.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/eth.c b/test/dm/eth.c
index d05d2a9abe1f..4a55ea967190 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -18,6 +18,7 @@
 #include <dm/test.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <ndisc.h>
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 52018f610fe4..11fbf1e80194 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <linux/string.h>
 
 #include <dm/test.h>
 #include <test/ut.h>
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 0d88ec24bda2..501ad0b8da75 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -14,6 +14,7 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/util.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/mmc.c b/test/dm/mmc.c
index b1eb8bee2f9d..c4cd6dc23e32 100644
--- a/test/dm/mmc.c
+++ b/test/dm/mmc.c
@@ -8,6 +8,7 @@
 #include <mmc.h>
 #include <part.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index a14bfa8e3fbd..5fe00513af83 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -11,6 +11,7 @@
 #include <dt-bindings/mux/mux.h>
 #include <asm/test.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/ut.h>
 #include <console.h>
 #include <rand.h>
diff --git a/test/dm/nop.c b/test/dm/nop.c
index 75b9e7b6cc0b..d9dc82e88c5d 100644
--- a/test/dm/nop.c
+++ b/test/dm/nop.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/test.h>
 #include <misc.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/of_platdata.c b/test/dm/of_platdata.c
index a241c4279367..4def9677c3e3 100644
--- a/test/dm/of_platdata.c
+++ b/test/dm/of_platdata.c
@@ -6,6 +6,7 @@
 #include <dt-structs.h>
 #include <irq.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <asm-generic/gpio.h>
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index d71faac0ee43..37899c000208 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -26,6 +26,7 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/part.c b/test/dm/part.c
index d6e434581274..4be2ad9ae8b0 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -9,6 +9,7 @@
 #include <part.h>
 #include <part_efi.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 static int do_test(struct unit_test_state *uts, int expected,
diff --git a/test/dm/pci.c b/test/dm/pci.c
index 70a736cfdb8a..d4fb2799e28a 100644
--- a/test/dm/pci.c
+++ b/test/dm/pci.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/test.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/regmap.c b/test/dm/regmap.c
index ea71d795ca7e..4158ce657f96 100644
--- a/test/dm/regmap.c
+++ b/test/dm/regmap.c
@@ -15,6 +15,7 @@
 #include <dm/test.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/remoteproc.c b/test/dm/remoteproc.c
index 7a8ff47fa148..e4a79942380e 100644
--- a/test/dm/remoteproc.c
+++ b/test/dm/remoteproc.c
@@ -10,6 +10,7 @@
 #include <remoteproc.h>
 #include <asm/io.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/rtc.c b/test/dm/rtc.c
index bf97dbbd2f9e..648e7d7ca4f7 100644
--- a/test/dm/rtc.c
+++ b/test/dm/rtc.c
@@ -14,6 +14,7 @@
 #include <asm/rtc.h>
 #include <asm/test.h>
 #include <dm/test.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/soc.c b/test/dm/soc.c
index 17e1b5ba0127..474358aa337b 100644
--- a/test/dm/soc.c
+++ b/test/dm/soc.c
@@ -11,6 +11,7 @@
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
 #include <soc.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 struct sb_soc_data {
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index 96b3a8ebabac..48e3fd26efbe 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <dm/test.h>
 #include <sysinfo.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/tee.c b/test/dm/tee.c
index 7a11bf891389..e31b6f4a6a5a 100644
--- a/test/dm/tee.c
+++ b/test/dm/tee.c
@@ -10,6 +10,7 @@
 #include <dm/test.h>
 #include <sandboxtee.h>
 #include <tee.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <tee/optee_ta_avb.h>
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 7671ef156d84..8f4c20feb1bd 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -14,6 +14,7 @@
 #include <dm/device-internal.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/dm/video.c b/test/dm/video.c
index d907f681600b..3b13d98af094 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -18,6 +18,7 @@
 #include <asm/sdl.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/env/hashtable.c b/test/env/hashtable.c
index 70102f9121c2..ebbbe6060b82 100644
--- a/test/env/hashtable.c
+++ b/test/env/hashtable.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <search.h>
 #include <stdio.h>
+#include <linux/string.h>
 #include <test/env.h>
 #include <test/ut.h>
 
diff --git a/test/fuzz/cmd_fuzz.c b/test/fuzz/cmd_fuzz.c
index e2f44f3ecb61..dfe79c9a316d 100644
--- a/test/fuzz/cmd_fuzz.c
+++ b/test/fuzz/cmd_fuzz.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <dm.h>
 #include <fuzzing_engine.h>
+#include <linux/string.h>
 #include <test/fuzz.h>
 
 static struct fuzz_test *find_fuzz_test(const char *name)
diff --git a/test/fuzz/virtio.c b/test/fuzz/virtio.c
index 8a47667e7785..17d0ebb3cc1c 100644
--- a/test/fuzz/virtio.c
+++ b/test/fuzz/virtio.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <linux/string.h>
 #include <test/fuzz.h>
 
 static int fuzz_vring(const uint8_t *data, size_t size)
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 4e27ff460ab4..2854a157d624 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -9,6 +9,7 @@
 #include <mapmem.h>
 #include <os.h>
 #include <spl.h>
+#include <linux/string.h>
 #include <test/ut.h>
 
 /* Declare a new SPL test */
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 42803b20e2a1..c46667c7c6d4 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <abuf.h>
 #include <mapmem.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/asn1.c b/test/lib/asn1.c
index a66cdd77df0a..165a5a37bdac 100644
--- a/test/lib/asn1.c
+++ b/test/lib/asn1.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/rsa.c b/test/lib/rsa.c
index 44f8ade226f4..7034bca13b3f 100644
--- a/test/lib/rsa.c
+++ b/test/lib/rsa.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <command.h>
 #include <image.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/sscanf.c b/test/lib/sscanf.c
index 772e4b920425..a263e1622258 100644
--- a/test/lib/sscanf.c
+++ b/test/lib/sscanf.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <command.h>
 #include <log.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/string.c b/test/lib/string.c
index 5dcf4d6db003..01be6d589acd 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <command.h>
 #include <log.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
index d8453fe78e2c..3da5f35f546d 100644
--- a/test/lib/strlcat.c
+++ b/test/lib/strlcat.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/lib/test_aes.c b/test/lib/test_aes.c
index cbc712f7eda3..a73360b4fd93 100644
--- a/test/lib/test_aes.c
+++ b/test/lib/test_aes.c
@@ -10,6 +10,7 @@
 #include <hexdump.h>
 #include <rand.h>
 #include <uboot_aes.h>
+#include <linux/string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/log/log_test.c b/test/log/log_test.c
index c5abff80d111..e508c08a057f 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/log.h>
 #include <test/ut.h>
 
diff --git a/test/log/nolog_ndebug.c b/test/log/nolog_ndebug.c
index bd9a4f408e7b..61e506bbbe99 100644
--- a/test/log/nolog_ndebug.c
+++ b/test/log/nolog_ndebug.c
@@ -9,6 +9,7 @@
 #include <console.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/log.h>
 #include <test/ut.h>
 
diff --git a/test/log/nolog_test.c b/test/log/nolog_test.c
index 4e52e5bed822..1cbdd0d2bdb5 100644
--- a/test/log/nolog_test.c
+++ b/test/log/nolog_test.c
@@ -12,6 +12,7 @@
 #include <console.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/log.h>
 #include <test/test.h>
 #include <test/suites.h>
diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
index 4db649db8226..88e2a9795ee6 100644
--- a/test/log/syslog_test.c
+++ b/test/log/syslog_test.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <hexdump.h>
+#include <linux/string.h>
 #include <test/log.h>
 #include <test/test.h>
 #include <test/suites.h>
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index c3887ab11d92..906e08a438f0 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -9,6 +9,7 @@
 #include <fdt_support.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <tee/optee.h>
 
 #include <linux/sizes.h>
diff --git a/test/print_ut.c b/test/print_ut.c
index b26f6281b013..28203f5fe2a5 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -11,6 +11,7 @@
 #include <mapmem.h>
 #include <version_string.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/str_ut.c b/test/str_ut.c
index fa9328ede501..7e9500456987 100644
--- a/test/str_ut.c
+++ b/test/str_ut.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/test-main.c b/test/test-main.c
index 778bf0a18a0f..f096576f20dd 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -17,6 +17,7 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <u-boot/crc.h>
diff --git a/test/unicode_ut.c b/test/unicode_ut.c
index 1d0d90c2d734..77f6ac1f33d2 100644
--- a/test/unicode_ut.c
+++ b/test/unicode_ut.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/suites.h>
 #include <test/ut.h>
diff --git a/test/ut.c b/test/ut.c
index 28da417686e4..5dfea56c5b00 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -12,6 +12,7 @@
 #include <asm/state.h>
 #endif
 #include <asm/global_data.h>
+#include <linux/string.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-- 
2.42.0.515.g380fc7ccd1-goog

