Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A96BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 00:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17A28873C;
	Thu, 25 Apr 2024 02:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="LVXp86SB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D3188724; Thu, 25 Apr 2024 02:06:11 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FBF8873C
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 02:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61ac45807cbso4520027b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714003562; x=1714608362;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j69mCDDgHVXm8snCL2hYqzPVHru3bvZoE8g+hRYCY1M=;
 b=LVXp86SBQyN8QqzTz/G9qVR7kYqylUqFvpr70On7QDnVHiSMLDEKsbZvvpEUyWxOET
 nkxO7hb3vz35DXFFjUzmsOtIckvQaT3RHhClETBiMOcN9brBbUzfie+bJccSU3fro53E
 hEdCy92ztzZPiU1se32OVDLPs6Rgksj0Go8xHhTnWQu6MgwKr3XZhFnttM5WYrM92N+v
 HcdNnGuyftYYXxQQ7TOQlQrC3MJS4GrJ0x8Q+SWfv3+i1+0ssM23zB0AhvsjJYCyFOn2
 8FK5txLFhKAP4aucE9cqCTPa0foU+50NOIS+HzP+MLuTIAdIstqcCHtPqatdtD4gHrrE
 rwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003562; x=1714608362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j69mCDDgHVXm8snCL2hYqzPVHru3bvZoE8g+hRYCY1M=;
 b=OIb8NcSg8tQvsMZSVDX7OMn2G1Ozu6yV2YHdgcADymzNNjcAd0MwMw6XJfU7wigkPI
 ui9ujoKCMps+V5wz45mwoC+njSGcbS/NcKLE8zCplkN5VarNXvJekhwHhJB9A3UFB8Gf
 xFDCq6nxhHKjvXhVOd0xKeJx+OlrucDIFonf9FqfKTwPvcvHPcIlprAHIcDMdBDCf6FF
 ZTx2SNqK3LS+0HYv3Us5hWigFC8mH42jRBEyC4emnpuSVCDoDtbzNEePizicLYzDcaOn
 IS/cBKctLyWO2NN8PAd0FJnnOb2gSzN2cqvm6w2wr6SsmmCLpTs1cCka0VnTmdpixVfm
 tC4A==
X-Gm-Message-State: AOJu0Yz+cxMGgO5/WuoHfm/nFTdEItDFoyQ1HxeUJuymEj7qLwTMt5O9
 Qsik61ZOLot9gOhivJmXkuJ/4Ef+vEDHLQbB5nhxVqgh/dTMvH09eNfaCv3vvHD6UK4hfbcZ2F3
 fMw==
X-Google-Smtp-Source: AGHT+IEkkjdGl/t56kMD7nzHwbbDN2xrHbS0205+IB2czps4e3oedSVC21+nanqYfqLo6djRDQSFsw==
X-Received: by 2002:a05:690c:670c:b0:61b:418:139 with SMTP id
 ia12-20020a05690c670c00b0061b04180139mr4620893ywb.27.1714003560536; 
 Wed, 24 Apr 2024 17:06:00 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 t201-20020a8183d2000000b0061870c6e41csm3291753ywf.6.2024.04.24.17.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:06:00 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v2 1/4] arch: arm: Add Analog Devices SC5xx machine type
Date: Wed, 24 Apr 2024 20:04:00 -0400
Message-ID: <20240425000515.21896-2-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Apr 2024 02:06:59 +0200
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Add support for the SC5xx machine type from Analog Devices. This
includes support for the SC57x, SC58x, SC59x, and SC59x-64 SoCs, which
have many common features such as common ADI IP blocks, and SHARC DSP
cores. This commit introduces core functionality required for all boards
using an SC5xx SoC, such as:

- SPL configuration
- Required CPU hooks such as reset
- Boot ROM interaction to load the stage 2 bootloader in the reference
  configuration. Other options are possible but not officially supported
  at this time
- SoC-common configuration expected to be reused by all boards
- Early initialization for system clocks and DDR controller

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---

Changes in v2:
- Removed MACH_TYPE constants and any references to setting the
  MACH_TYPE as it is not used by this platform
- Removed additional compiler flags from config.mk
- Converted to text env. Each board is expected to provide a text env
  and #include env/adi/adi_boot.env if it wants to use the reference ADI
  boot flow
- Some further cleanup on use of Kconfigs--some per board settings
  affecting dmcinit and clkinit have been converted to Kconfigs instead
  of config header constants
- Reviewed #include usage and pruned unnecessary files
- Passes gitlab CI run locally


---
 MAINTAINERS                                  |  13 +
 arch/arm/Kconfig                             |   5 +
 arch/arm/Makefile                            |   1 +
 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  |  39 +
 arch/arm/include/asm/arch-adi/sc5xx/soc.h    |  18 +
 arch/arm/include/asm/arch-adi/sc5xx/spl.h    |  43 +
 arch/arm/mach-sc5xx/Kconfig                  | 475 +++++++++
 arch/arm/mach-sc5xx/Makefile                 |  19 +
 arch/arm/mach-sc5xx/config.mk                |  16 +
 arch/arm/mach-sc5xx/init/Makefile            |  11 +
 arch/arm/mach-sc5xx/init/clkinit.c           | 558 +++++++++++
 arch/arm/mach-sc5xx/init/clkinit.h           |  18 +
 arch/arm/mach-sc5xx/init/dmcinit.c           | 954 +++++++++++++++++++
 arch/arm/mach-sc5xx/init/dmcinit.h           |  31 +
 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h |  62 ++
 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h |  50 +
 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h |  50 +
 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h |  49 +
 arch/arm/mach-sc5xx/rcu.c                    |  22 +
 arch/arm/mach-sc5xx/sc57x.c                  |  32 +
 arch/arm/mach-sc5xx/sc58x.c                  |  32 +
 arch/arm/mach-sc5xx/sc59x.c                  |  43 +
 arch/arm/mach-sc5xx/sc59x_64.c               |  97 ++
 arch/arm/mach-sc5xx/soc.c                    | 179 ++++
 arch/arm/mach-sc5xx/spl.c                    | 102 ++
 include/env/adi/adi_boot.env                 | 122 +++
 26 files changed, 3041 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/soc.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/spl.h
 create mode 100644 arch/arm/mach-sc5xx/Kconfig
 create mode 100644 arch/arm/mach-sc5xx/Makefile
 create mode 100644 arch/arm/mach-sc5xx/config.mk
 create mode 100644 arch/arm/mach-sc5xx/init/Makefile
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
 create mode 100644 arch/arm/mach-sc5xx/rcu.c
 create mode 100644 arch/arm/mach-sc5xx/sc57x.c
 create mode 100644 arch/arm/mach-sc5xx/sc58x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x_64.c
 create mode 100644 arch/arm/mach-sc5xx/soc.c
 create mode 100644 arch/arm/mach-sc5xx/spl.c
 create mode 100644 include/env/adi/adi_boot.env

diff --git a/MAINTAINERS b/MAINTAINERS
index 83fd68e3f3..f743ce9f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -598,6 +598,19 @@ R:	Marc Murphy <marc.murphy@sancloud.com>
 S:	Supported
 F:	arch/arm/dts/am335x-sancloud*
 
+ARM SC5XX
+M:	Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+M:	Greg Malysa <greg.malysa@timesys.com>
+M:	Ian Roberts <ian.roberts@timesys.com>
+M:	Vasileios Bimpikas <vasileios.bimpikas@analog.com>
+M:	Utsav Agarwal <utsav.agarwal@analog.com>
+M:	Arturs Artamonovs <arturs.artamonovs@analog.com>
+S:	Supported
+T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
+F:	arch/arm/include/asm/arch-adi/
+F:	arch/arm/mach-sc5xx/
+F:	include/env/adi/
+
 ARM SNAPDRAGON
 M:	Caleb Connolly <caleb.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a0842e1933..ded35cb65c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1843,6 +1843,9 @@ config TARGET_LS1046AFRWY
 	  development platform that supports the QorIQ LS1046A
 	  Layerscape Architecture processor.
 
+config ARCH_SC5XX
+	bool "Analog Devices SC5XX-processor family"
+
 config TARGET_SL28
 	bool "Support sl28"
 	select ARCH_LS1028A
@@ -2276,6 +2279,8 @@ source "arch/arm/mach-rockchip/Kconfig"
 
 source "arch/arm/mach-s5pc1xx/Kconfig"
 
+source "arch/arm/mach-sc5xx/Kconfig"
+
 source "arch/arm/mach-snapdragon/Kconfig"
 
 source "arch/arm/mach-socfpga/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a4266a3e36..734c6d6992 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -78,6 +78,7 @@ machine-$(CONFIG_ARCH_OWL)		+= owl
 machine-$(CONFIG_ARCH_RENESAS)		+= renesas
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
+machine-$(CONFIG_ARCH_SC5XX)		+= sc5xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STM32)		+= stm32
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h b/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
new file mode 100644
index 0000000000..683e3d412c
--- /dev/null
+++ b/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+#ifndef ARCH_ADI_SC5XX_SC5XX_H
+#define ARCH_ADI_SC5XX_SC5XX_H
+
+#include <linux/types.h>
+
+#define TWI0_CLKDIV                 0x31001400    // TWI0 SCL Clock Divider Register
+#define TWI1_CLKDIV                 0x31001500    // TWI1 SCL Clock Divider Register
+#define TWI2_CLKDIV                 0x31001600    // TWI2 SCL Clock Divider Register
+
+const char *sc5xx_get_boot_mode(u32 *bmode);
+void sc5xx_enable_rgmii(void);
+
+void sc5xx_enable_ns_sharc_access(uintptr_t securec0_base);
+void sc5xx_disable_spu0(uintptr_t spu0_start, uintptr_t spu0_end);
+void sc5xx_enable_pmu(void);
+
+/**
+ * Per-SoC init function to be used to initialize hw-specific things. Examples:
+ * enable PMU on armv7, enable coresight timer on armv8, etc.
+ */
+void sc5xx_soc_init(void);
+
+/*
+ * Reconfigure SPI memory map region for OSPI use. The adi-spi3 driver
+ * does not use the memory map, while the OSPI driver requires it. Only
+ * available on sc59x and sc59x-64
+ */
+void sc59x_remap_ospi(void);
+
+#endif
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/soc.h b/arch/arm/include/asm/arch-adi/sc5xx/soc.h
new file mode 100644
index 0000000000..430dbe2dae
--- /dev/null
+++ b/arch/arm/include/asm/arch-adi/sc5xx/soc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef BOARD_ADI_COMMON_SOC_H
+#define BOARD_ADI_COMMON_SOC_H
+
+#include <phy.h>
+
+void fixup_dp83867_phy(struct phy_device *phydev);
+
+#endif
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/spl.h b/arch/arm/include/asm/arch-adi/sc5xx/spl.h
new file mode 100644
index 0000000000..c215e6b892
--- /dev/null
+++ b/arch/arm/include/asm/arch-adi/sc5xx/spl.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+#ifndef ARCH_ADI_SC5XX_SPL_H
+#define ARCH_ADI_SC5XX_SPL_H
+
+#include <linux/types.h>
+
+struct adi_boot_args {
+	phys_addr_t addr;
+	u32 flags;
+	u32 cmd;
+};
+
+extern u32 bmode;
+
+/**
+ * This table stores the arguments to the rom boot function per bootmode,
+ * and it is populated per SoC in the corresponding SoC support file (sc7x, sc58x,
+ * and so on).
+ */
+extern const struct adi_boot_args adi_rom_boot_args[8];
+
+/**
+ * Struct layout for the boot config is also specific to an SoC, so you should
+ * only access it inside an SoC-specific boot hook function, which will be called
+ * from the boot rom while going from SPL to proper u-boot
+ */
+struct ADI_ROM_BOOT_CONFIG;
+int32_t adi_rom_boot_hook(struct ADI_ROM_BOOT_CONFIG *cfg, int32_t cause);
+
+typedef void (*adi_rom_boot_fn)(void *address, uint32_t flags, int32_t count,
+				void *hook, uint32_t command);
+
+extern adi_rom_boot_fn adi_rom_boot;
+
+#endif
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
new file mode 100644
index 0000000000..3846b4fd5b
--- /dev/null
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -0,0 +1,475 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+# All 32-bit platforms require SYS_ARM_CACHE_WRITETHROUGH
+# But it is ignored if selected here, so it must be in the defconfig
+
+if ARCH_SC5XX
+
+config SC57X
+	bool
+	select SUPPORT_SPL
+	select CPU_V7A
+	select PANIC_HANG
+	select COMMON_CLK_ADI_SC57X
+	select TIMER
+	select ADI_SC5XX_TIMER
+
+config SC58X
+	bool
+	select SUPPORT_SPL
+	select CPU_V7A
+	select PANIC_HANG
+	select COMMON_CLK_ADI_SC58X
+	select TIMER
+	select ADI_SC5XX_TIMER
+
+config SC59X
+	bool
+	select SUPPORT_SPL
+	select CPU_V7A
+	select PANIC_HANG
+	select COMMON_CLK_ADI_SC594
+	select TIMER
+	select ADI_SC5XX_TIMER
+	select NOP_PHY
+
+config SC59X_64
+	bool
+	select SUPPORT_SPL
+	select PANIC_HANG
+	select MMC_SDHCI_ADMA_FORCE_32BIT
+	select ARM64
+	select DM
+	select DM_SERIAL
+	select COMMON_CLK_ADI_SC598
+	select GICV3
+	select GIC_600_CLEAR_RDPD
+	select NOP_PHY
+
+config SC_BOOT_MODE
+	int "SC5XX boot mode select"
+	default 1
+	range 0 7
+	help
+	  Mode 0: do nothing, just idle
+	  Mode 1: boot ldr out of serial flash
+	  Mode 7: boot ldr over uart
+
+config SC_BOOT_SPI_BUS
+	int "sc5xx spi boot bus"
+	default 2
+	range 0 4
+	help
+	  This is the SPI peripheral number to use for booting, X in the
+	  expression `sf probe X:Y`
+
+config SC_BOOT_SPI_SSEL
+	int "sc5xx spi boot chipselect"
+	default 1
+	range 0 6
+	help
+	  This is the SPI chip select number to use for booting, Y in the
+	  expression `sf probe X:Y`
+
+config SC_BOOT_OSPI_BUS
+	int "sc5xx ospi boot bus"
+	default 0
+	help
+	  This is the OSPI peripheral number to use for booting, X in the
+	  expression `sf probe X:Y`
+
+config SC_BOOT_OSPI_SSEL
+	int "sc5xx ospi boot chipselect"
+	default 0
+	help
+	  This is the OSPI chip select number to use for booting, Y in the
+	  expression `sf probe X:Y`
+
+config SYS_FLASH_BASE
+	hex
+	default 0x60000000
+
+config UART_CONSOLE
+	int
+	default 0
+
+config UART4_SERIAL
+	bool
+	depends on DM_SERIAL
+	default y
+
+config WDT_ADI
+	bool
+	default y
+
+config WATCHDOG_TIMEOUT_MSECS
+	int
+	default 30000
+
+config DW_PORTS
+	int
+	default 1
+
+config ADI_BUG_EZKHW21
+	bool "SC584 EZKIT phy bug workaround"
+	depends on SC58X
+	help
+	  This workaround affects the SC584 EZKIT and addresses bug EZKHW21.
+	  It disables gigabit ethernet mode and limits the board to 100 Mbps
+
+config ADI_CARRIER_SOMCRR_EZKIT
+	bool "Support the EV-SOMCRR-EZKIT"
+	depends on (SC59X || SC59X_64)
+	help
+	  Say y to include support for the EV-SOMCRR-EZKIT carrier board,
+	  which is compatible with the SC594 and SC598 SOMs. The EZKIT is
+	  mutually incompatible with the EZLITE.
+
+config ADI_CARRIER_SOMCRR_EZLITE
+	bool "Support the EV-SOMCRR-EZLITE"
+	depends on (SC59X || SC59X_64)
+	help
+	  Say y to include support for the EV-SOMCRR-EZLITE carrier board,
+	  which is compatible with the SC594 and SC598 SOMs. The EZLITE is
+	  mutually incompatible with the EZKIT.
+
+config ADI_SPL_FORCE_BMODE
+	int "Force the SPL to use this BMODE device during next boot stage"
+	default 0
+	range 0 9
+	depends on SPL
+	help
+	  Force the SPL to use this BMODE device during next boot stage.
+	  For example, if booting via QSPI, we can force the second stage
+	  Of the boot process to use other peripherals via:
+	  1 = QSPI -> QSPI
+	  5 = QSPI -> OSPI
+	  6 = QSPI -> eMMC
+
+config ADI_USE_DMC0
+	bool "Configure DMC0"
+	default y
+	help
+	  During hardware initialization, channel 0 of the DMC will be
+	  initialized. Select this if you have DMC0 connected to external
+	  DDR memory. This is expected to be true for every board using
+	  an SC5xx SoC.
+
+config ADI_USE_DMC1
+	bool "Configure DMC1"
+	help
+	  During hardware initialization, channel 1 of the DMC will be
+	  initialized. Not all processors have a DMC1. Select this if your
+	  SoC has DMC1 and you have it connected to external DDR memory.
+
+config ADI_USE_DDR2
+	bool "Configure DMC for DDR2 mode"
+	help
+	  Configure the DMC in DDR2 mode. The default is DDR3 and not all
+	  parts may actually support DDR2. Please consult the manual for
+	  the SoC that you are using to determine if DDR2 mode is supported.
+	  This also requires that DDR2 memory is present on the board or it
+	  will probably cause strange failure.
+
+menu "Clock configuration"
+
+config CGU0_DF_DIV
+	int "CGU0_DF_DIV"
+	range 0 1
+	help
+	  Select 0 to pass CLKIN to PLL
+	  Select 1 to pass CLKIN/2 to PLL
+
+config CGU0_VCO_MULT
+	int "CGU0_VCO_MULT"
+	range 0 127
+	help
+	  VCO_MULT controls the MSEL (multiplier) bits in PLL_CTL
+	  A value of 0 means 128
+
+config CGU0_CCLK_DIV
+	int "CGU0_CCLK_DIV"
+	range 0 31
+	help
+	  CCLK_DIV controls the core clock divider
+	  A value of 0 means 32
+	  CCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / CCLK_DIV
+
+config CGU0_SCLK_DIV
+	int "CGU0_SCLK_DIV"
+	range 0 31
+	help
+	  SCLK_DIV controls the system clock divider
+	  A value of 0 means 32
+	  SCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / SYSCLK_DIV
+
+config CGU0_SCLK0_DIV
+	int "CGU0_SCLK0_DIV"
+	range 0 7
+	help
+	  A value of 0 means 8
+	  SCLK0 = SCLK / SCLK0_DIV
+
+config CGU0_SCLK1_DIV
+	int "CGU0_SCLK1_DIV"
+	depends on (SC57X || SC58X)
+	range 0 7
+	help
+	  A value of 0 means 8
+	  SCLK1 = SCLK / SCLK1_DIV
+
+config CGU0_DCLK_DIV
+	int "CGU0_DCLK_DIV"
+	range 0 31
+	help
+	  DCLK_DIV controls the DDR clock divider
+	  A value of 0 means 32
+	  DCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / DCLK_DIV
+
+config CGU0_OCLK_DIV
+	int "CGU0_OCLK_DIV"
+	range 0 127
+	help
+	  OCLK_DIV controls the output clock divider
+	  A value of 0 means 128
+	  OCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / OCLK_DIV
+
+config CGU0_DIV_S1SELEX
+	int "CGU0_DIV_S1SELEX"
+	depends on !SC57X && !SC58X
+	range 0 255
+	help
+	  CGU0 SCLK1 Extended divisor register.
+	  A value of 0 means 256.
+	  SCLK1 = ((CLKIN / (1 + DF)) * VCO_MULT) / DIV_S1SELEX
+
+config CGU0_CLKOUTSEL
+	int "CGU0_CLKOUTSEL"
+	default 0
+	range 0 31
+	help
+	  Select signal driven through CLKOUT pin multiplexer.
+	  This value varies on each SOC. Refer to
+	  CGU_CLKOUTSEL.CLKOUTSEL in the Hardware Reference Manual
+	  for values applicable to each SOC.
+	  Commonly, values 0 and 1 select CLKIN0 or CLKIN1 respectively.
+
+config CGU1_PLL3_DDRCLK
+	bool "DDRCLK From 3rd PLL"
+	depends on SC59X_64
+	help
+	  3rd PLL output is connected to DMC block when set.
+	  When cleared, DDR clock is CLKO3 output of CDU.
+
+config CGU1_PLL3_VCO_MSEL
+	int "CGU0_PLL3_VCO_MSEL"
+	depends on CGU1_PLL3_DDRCLK
+	range 1 128
+	help
+	  PLL multiplier value for the 3rd PLL.
+	  DCLK = (CLKIN * PLL3_VCO_MSEL) / PLL3_DCLK_DIV
+
+config CGU1_PLL3_DCLK_DIV
+	int "CGU0_PLL3_DCLK_DIV"
+	depends on CGU1_PLL3_DDRCLK
+	range 1 32
+	help
+	  PLL divider value for the 3rd PLL.
+	  DCLK = (CLKIN * PLL3_VCO_MSEL) / PLL3_DCLK_DIV
+
+config CGU1_DF_DIV
+	int "CGU1_DF_DIV"
+	range 0 1
+	help
+	  Select 0 to pass CLKIN to PLL
+	  Select 1 to pass CLKIN/2 to PLL
+
+config CGU1_VCO_MULT
+	int "CGU1_VCO_MULT"
+	range 0 127
+	help
+	  VCO_MULT controls the MSEL (multiplier) bits in PLL_CTL
+	  A value of 0 means 128
+
+config CGU1_CCLK_DIV
+	int "CGU1_CCLK_DIV"
+	range 0 31
+	help
+	  CCLK_DIV controls the core clock divider
+	  A value of 0 means 32
+	  CCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / CCLK_DIV
+
+config CGU1_SCLK_DIV
+	int "CGU1_SCLK_DIV"
+	range 0 31
+	help
+	  SCLK_DIV controls the system clock divider
+	  A value of 0 means 32
+	  SCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / SYSCLK_DIV
+
+config CGU1_SCLK0_DIV
+	int "CGU1_SCLK0_DIV"
+	depends on (SC57X || SC58X || SC59X)
+	range 0 7
+	help
+	  A value of 0 means 8
+	  SCLK0 = SCLK / SCLK0_DIV
+
+config CGU1_SCLK1_DIV
+	int "CGU1_SCLK1_DIV"
+	depends on (SC57X || SC58X)
+	range 0 7
+	help
+	  A value of 0 means 8
+	  SCLK1 = SCLK / SCLK1_DIV
+
+config CGU1_DCLK_DIV
+	int "CGU1_DCLK_DIV"
+	range 0 31
+	help
+	  DCLK_DIV controls the DDR clock divider
+	  A value of 0 means 32
+	  DCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / DCLK_DIV
+
+config CGU1_OCLK_DIV
+	int "CGU1_OCLK_DIV"
+	range 0 127
+	help
+	  OCLK_DIV controls the output clock divider
+	  A value of 0 means 128
+	  OCLK = ((CLKIN / (1 + DF)) * VCO_MULT) / OCLK_DIV
+
+config CGU1_DIV_S0SELEX
+	int "CGU1_DIV_S0SELEX"
+	depends on !SC57X && !SC58X && !SC59X
+	range 0 255
+	help
+	  CGU1 SCLK0 Extended divisor register.
+	  A value of 0 means 256.
+	  SCLK0 = ((CLKIN / (1 + DF)) * VCO_MULT) / DIV_S0SELEX
+
+config CGU1_DIV_S1SELEX
+	int "CGU1_DIV_S1SELEX"
+	depends on !SC57X && !SC58X
+	range 0 255
+	help
+	  CGU1 SCLK1 Extended divisor register.
+	  A value of 0 means 256.
+	  SCLK1 = ((CLKIN / (1 + DF)) * VCO_MULT) / DIV_S1SELEX
+
+config CDU0_CGU1_CLKIN
+	int "CDU0 CGU1 CLKINn Select"
+	default 0
+	range 0 1
+	help
+	  Selects source clock for CGU1.
+	  0 for CLKIN0
+	  1 for CLKIN1
+
+config CDU0_CLKO0
+	int "CDU0_CLKO0"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO1
+	int "CDU0_CLKO1"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO2
+	int "CDU0_CLKO2"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO3
+	int "CDU0_CLKO3"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO4
+	int "CDU0_CLKO4"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO5
+	int "CDU0_CLKO5"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO6
+	int "CDU0_CLKO6"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO7
+	int "CDU0_CLKO7"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO8
+	int "CDU0_CLKO8"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO9
+	int "CDU0_CLKO9"
+	range 1 7
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO10
+	int "CDU0_CLKO10"
+	range 1 7
+	depends on (SC59X || SC59X_64)
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO12
+	int "CDU0_CLKO12"
+	range 1 7
+	depends on (SC59X || SC59X_64)
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO13
+	int "CDU0_CLKO13"
+	range 1 7
+	depends on SC59X_64
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+config CDU0_CLKO14
+	int "CDU0_CLKO14"
+	range 1 7
+	depends on SC59X_64
+	help
+	  Clock source select. Refer to SOC Hardware Reference Manual
+
+endmenu
+
+config ADI_GPIO
+	bool
+	default y
+
+config PINCTRL_ADI
+	bool
+	default y
+
+endif
diff --git a/arch/arm/mach-sc5xx/Makefile b/arch/arm/mach-sc5xx/Makefile
new file mode 100644
index 0000000000..eeb56c078b
--- /dev/null
+++ b/arch/arm/mach-sc5xx/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+obj-y += soc.o init/
+
+obj-$(CONFIG_SC57X) += sc57x.o
+obj-$(CONFIG_SC58X) += sc58x.o
+obj-$(CONFIG_SC59X) += sc59x.o
+obj-$(CONFIG_SC59X_64) += sc59x_64.o
+
+obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_SYSCON) += rcu.o
diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
new file mode 100644
index 0000000000..580964e559
--- /dev/null
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+ifdef CONFIG_SPL_BUILD
+INPUTS-y += $(obj)/u-boot-spl.ldr
+endif
+
+LDR_FLAGS += --bcode=$(CONFIG_SC_BOOT_MODE)
+LDR_FLAGS += --use-vmas
diff --git a/arch/arm/mach-sc5xx/init/Makefile b/arch/arm/mach-sc5xx/init/Makefile
new file mode 100644
index 0000000000..9d4920fe07
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+obj-y += dmcinit.o clkinit.o
diff --git a/arch/arm/mach-sc5xx/init/clkinit.c b/arch/arm/mach-sc5xx/init/clkinit.c
new file mode 100644
index 0000000000..ae53cd61ef
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/clkinit.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/io.h>
+#include <linux/types.h>
+#include "clkinit.h"
+#include "dmcinit.h"
+
+#ifdef CONFIG_CGU0_SCLK0_DIV
+	#define VAL_CGU0_SCLK0_DIV CONFIG_CGU0_SCLK0_DIV
+#else
+	#define VAL_CGU0_SCLK0_DIV 1
+#endif
+#ifdef CONFIG_CGU0_SCLK1_DIV
+	#define VAL_CGU0_SCLK1_DIV CONFIG_CGU0_SCLK1_DIV
+#else
+	#define VAL_CGU0_SCLK1_DIV 1
+#endif
+#ifdef CONFIG_CGU0_DIV_S0SELEX
+	#define VAL_CGU0_DIV_S0SELEX CONFIG_CGU0_DIV_S0SELEX
+#else
+	#define VAL_CGU0_DIV_S0SELEX -1
+#endif
+#ifdef CONFIG_CGU0_DIV_S1SELEX
+	#define VAL_CGU0_DIV_S1SELEX CONFIG_CGU0_DIV_S1SELEX
+#else
+	#define VAL_CGU0_DIV_S1SELEX -1
+#endif
+#ifdef CONFIG_CGU0_CLKOUTSEL
+	#define VAL_CGU0_CLKOUTSEL CONFIG_CGU0_CLKOUTSEL
+#else
+	#define VAL_CGU0_CLKOUTSEL -1
+#endif
+#ifdef CONFIG_CGU1_SCLK0_DIV
+	#define VAL_CGU1_SCLK0_DIV CONFIG_CGU1_SCLK0_DIV
+#else
+	#define VAL_CGU1_SCLK0_DIV 1
+#endif
+#ifdef CONFIG_CGU1_SCLK1_DIV
+	#define VAL_CGU1_SCLK1_DIV CONFIG_CGU1_SCLK1_DIV
+#else
+	#define VAL_CGU1_SCLK1_DIV 1
+#endif
+#ifdef CONFIG_CGU1_DIV_S0SELEX
+	#define VAL_CGU1_DIV_S0SELEX CONFIG_CGU1_DIV_S0SELEX
+#else
+	#define VAL_CGU1_DIV_S0SELEX -1
+#endif
+#ifdef CONFIG_CGU1_DIV_S1SELEX
+	#define VAL_CGU1_DIV_S1SELEX CONFIG_CGU1_DIV_S1SELEX
+#else
+	#define VAL_CGU1_DIV_S1SELEX -1
+#endif
+#ifdef CONFIG_CGU1_CLKOUTSEL
+	#define VAL_CGU1_CLKOUTSEL CONFIG_CGU1_CLKOUTSEL
+#else
+	#define VAL_CGU1_CLKOUTSEL -1
+#endif
+
+#define REG_MISC_REG10_tst_addr     0x310A902C
+
+#define CGU0_REGBASE	0x3108D000
+#define CGU1_REGBASE	0x3108E000
+
+#define CGU_CTL		0x00 // CGU0 Control Register
+#define CGU_PLLCTL	0x04 // CGU0 PLL Control Register
+#define CGU_STAT	0x08 // CGU0 Status Register
+#define CGU_DIV		0x0C // CGU0 Clocks Divisor Register
+#define CGU_CLKOUTSEL	0x10 // CGU0 CLKOUT Select Register
+#define CGU_DIVEX	0x40 // CGU0 DIV Register Extension
+
+#define BITP_CGU_DIV_OSEL                   22    // OUTCLK Divisor
+#define BITP_CGU_DIV_DSEL                   16    // DCLK Divisor
+#define BITP_CGU_DIV_S1SEL                  13    // SCLK 1 Divisor
+#define BITP_CGU_DIV_SYSSEL                  8    // SYSCLK Divisor
+#define BITP_CGU_DIV_S0SEL                   5    // SCLK 0 Divisor
+#define BITP_CGU_DIV_CSEL                    0    // CCLK Divisor
+
+#define BITP_CGU_CTL_MSEL                    8    // Multiplier Select
+#define BITP_CGU_CTL_DF                      0    // Divide Frequency
+
+#define BITM_CGU_STAT_CLKSALGN      0x00000008
+#define BITM_CGU_STAT_PLOCK         0x00000004
+#define BITM_CGU_STAT_PLLBP         0x00000002
+#define BITM_CGU_STAT_PLLEN         0x00000001
+
+/*  PLL Multiplier and Divisor Selections (Required Value, Bit Position) */
+/* PLL Multiplier Select */
+#define MSEL(X)		(((X) << BITP_CGU_CTL_MSEL) & \
+				 BITM_CGU_CTL_MSEL)
+/* Divide frequency[true or false] */
+#define DF(X)		(((X) << BITP_CGU_CTL_DF) & \
+				 BITM_CGU_CTL_DF)
+/* Core Clock Divisor Select */
+#define CSEL(X)		(((X) << BITP_CGU_DIV_CSEL) & \
+				 BITM_CGU_DIV_CSEL)
+/* System Clock Divisor Select */
+#define SYSSEL(X)	(((X) << BITP_CGU_DIV_SYSSEL) & \
+				 BITM_CGU_DIV_SYSSEL)
+/* SCLK0 Divisor Select  */
+#define S0SEL(X)	(((X) << BITP_CGU_DIV_S0SEL) & \
+				 BITM_CGU_DIV_S0SEL)
+/* SCLK1 Divisor Select  */
+#define S1SEL(X)	(((X) << BITP_CGU_DIV_S1SEL) & \
+				 BITM_CGU_DIV_S1SEL)
+/* DDR Clock Divisor Select */
+#define DSEL(X)		(((X) << BITP_CGU_DIV_DSEL) & \
+				 BITM_CGU_DIV_DSEL)
+/* OUTCLK Divisor Select */
+#define OSEL(X)		(((X) << BITP_CGU_DIV_OSEL) & \
+				 BITM_CGU_DIV_OSEL)
+/* CLKOUT select	*/
+#define CLKOUTSEL(X)	(((X) << BITP_CGU_CLKOUTSEL_CLKOUTSEL) & \
+				 BITM_CGU_CLKOUTSEL_CLKOUTSEL)
+#define S0SELEX(X)	(((X) << BITP_CGU_DIVEX_S0SELEX) & \
+				 BITM_CGU_DIVEX_S0SELEX)
+#define S1SELEX(X)	(((X) << BITP_CGU_DIVEX_S1SELEX) & \
+				 BITM_CGU_DIVEX_S1SELEX)
+
+struct CGU_Settings {
+	phys_addr_t rbase;
+	u32 ctl_MSEL:7;
+	u32 ctl_DF:1;
+	u32 div_CSEL:5;
+	u32 div_SYSSEL:5;
+	u32 div_S0SEL:3;
+	u32 div_S1SEL:3;
+	u32 div_DSEL:5;
+	u32 div_OSEL:7;
+	s16 divex_S0SELEX;
+	s16 divex_S1SELEX;
+	s8  clkoutsel;
+};
+
+/* CGU Registers */
+#define BITM_CGU_CTL_LOCK	0x80000000 /* Lock */
+
+#define BITM_CGU_CTL_MSEL	0x00007F00 /* Multiplier Select */
+#define BITM_CGU_CTL_DF		0x00000001 /* Divide Frequency */
+#define BITM_CGU_CTL_S1SELEXEN	0x00020000 /* SCLK1 Extension Divider Enable */
+#define BITM_CGU_CTL_S0SELEXEN	0x00010000 /* SCLK0 Extension Divider Enable */
+
+#define BITM_CGU_DIV_LOCK	0x80000000 /* Lock */
+#define BITM_CGU_DIV_UPDT	0x40000000 /* Update Clock Divisors */
+#define BITM_CGU_DIV_ALGN	0x20000000 /* Align */
+#define BITM_CGU_DIV_OSEL	0x1FC00000 /* OUTCLK Divisor */
+#define BITM_CGU_DIV_DSEL	0x001F0000 /* DCLK Divisor */
+#define BITM_CGU_DIV_S1SEL	0x0000E000 /* SCLK 1 Divisor */
+#define BITM_CGU_DIV_SYSSEL	0x00001F00 /* SYSCLK Divisor */
+#define BITM_CGU_DIV_S0SEL	0x000000E0 /* SCLK 0 Divisor */
+#define BITM_CGU_DIV_CSEL	0x0000001F /* CCLK Divisor */
+
+#define BITP_CGU_DIVEX_S0SELEX	0
+#define BITM_CGU_DIVEX_S0SELEX	0x000000FF /*  SCLK 0 Extension Divisor */
+
+#define BITP_CGU_DIVEX_S1SELEX	16
+#define BITM_CGU_DIVEX_S1SELEX	0x00FF0000 /*  SCLK 1 Extension Divisor */
+
+#define BITM_CGU_PLLCTL_PLLEN		0x00000008	/* PLL Enable */
+#define BITM_CGU_PLLCTL_PLLBPCL		0x00000002	/* PLL Bypass Clear */
+#define BITM_CGU_PLLCTL_PLLBPST		0x00000001	/* PLL Bypass Set */
+
+#define BITP_CGU_CLKOUTSEL_CLKOUTSEL	0		/* CLKOUT Select */
+#define BITM_CGU_CLKOUTSEL_CLKOUTSEL	0x0000001F	/* CLKOUT Select */
+
+#define CGU_STAT_MASK (BITM_CGU_STAT_PLLEN | BITM_CGU_STAT_PLOCK | \
+	    BITM_CGU_STAT_CLKSALGN)
+#define CGU_STAT_ALGN_LOCK (BITM_CGU_STAT_PLLEN | BITM_CGU_STAT_PLOCK)
+
+/* Clock Distribution Unit Registers */
+#define REG_CDU0_CFG0			0x3108F000
+#define REG_CDU0_CFG1			0x3108F004
+#define REG_CDU0_CFG2			0x3108F008
+#define REG_CDU0_CFG3			0x3108F00C
+#define REG_CDU0_CFG4			0x3108F010
+#define REG_CDU0_CFG5			0x3108F014
+#define REG_CDU0_CFG6			0x3108F018
+#define REG_CDU0_CFG7			0x3108F01C
+#define REG_CDU0_CFG8			0x3108F020
+#define REG_CDU0_CFG9			0x3108F024
+#define REG_CDU0_CFG10			0x3108F028
+#define REG_CDU0_CFG11			0x3108F02C
+#define REG_CDU0_CFG12			0x3108F030
+#define REG_CDU0_CFG13			0x3108F034
+#define REG_CDU0_CFG14			0x3108F038
+#define REG_CDU0_STAT			0x3108F040
+#define REG_CDU0_CLKINSEL		0x3108F044
+#define REG_CDU0_REVID			0x3108F048
+
+#define BITM_REG10_MSEL3		0x000007F0
+#define BITP_REG10_MSEL3		4
+
+#define BITM_REG10_DSEL3		0x0001F000
+#define BITP_REG10_DSEL3		12
+
+/* Selected clock macros */
+#define CGUn_MULT(cgu)		((CONFIG_CGU##cgu##_VCO_MULT == 0) ? \
+				 128 : CONFIG_CGU##cgu##_VCO_MULT)
+#define CGUn_DIV(clkname, cgu)	((CONFIG_CGU##cgu##_##clkname##_DIV == 0) ? \
+				 32 : CONFIG_CGU##cgu##_##clkname##_DIV)
+#define CCLK1_n_RATIO(cgu)	(((CGUn_MULT(cgu)) / \
+				  (1 + CONFIG_CGU##cgu##_DF_DIV)) / \
+				   CGUn_DIV(CCLK, cgu))
+#define CCLK2_n_RATIO(cgu)	(((CGUn_MULT(cgu) * 2) / 3) / \
+				  (1 + CONFIG_CGU##cgu##_DF_DIV))
+#define DCLK_n_RATIO(cgu)	(((CGUn_MULT(cgu)) / \
+				 (1 + CONFIG_CGU##cgu##_DF_DIV)) / \
+				  CGUn_DIV(DCLK, cgu))
+#define SYSCLK_n_RATIO(cgu)	(((CGUn_MULT(cgu)) / \
+				 (1 + CONFIG_CGU##cgu##_DF_DIV)) / \
+				  CGUn_DIV(SCLK, cgu))
+#define PLL3_RATIO		((CONFIG_CGU1_PLL3_VCO_MSEL) / \
+				 (CONFIG_CGU1_PLL3_DCLK_DIV))
+
+#if (1 == CONFIG_CDU0_CLKO2)
+	#define ARMCLK_IN	0
+	#define ARMCLK_RATIO	CCLK1_n_RATIO(0)
+#elif (3 == CONFIG_CDU0_CLKO2) && \
+	(defined(CONFIG_SC57X) || defined(CONFIG_SC58X))
+	#define ARMCLK_IN	0
+	#define ARMCLK_RATIO	SYSCLK_n_RATIO(0)
+#elif (5 == CONFIG_CDU0_CLKO2) && defined(CONFIG_SC59X_64)
+	#define ARMCLK_IN	0
+	#define ARMCLK_RATIO	CCLK2_n_RATIO(0)
+#elif (7 == CONFIG_CDU0_CLKO2) && defined(CONFIG_SC59X_64)
+	#define ARMCLK_IN	CDU0_CGU1_CLKIN
+	#define ARMCLK_RATIO	CCLK2_n_RATIO(1)
+#endif
+
+#ifdef CONFIG_CGU1_PLL3_DDRCLK
+	#define DDRCLK_IN	CDU0_CGU1_CLKIN
+	#define DDRCLK_RATIO	PLL3_RATIO
+#elif (1 == CONFIG_CDU0_CLKO3)
+	#define DDRCLK_IN	0
+	#define DDRCLK_RATIO	DCLK_n_RATIO(0)
+#elif (3 == CONFIG_CDU0_CLKO3)
+	#define DDRCLK_IN	CDU0_CGU1_CLKIN
+	#define DDRCLK_RATIO	DCLK_n_RATIO(1)
+#endif
+
+#ifndef ARMCLK_RATIO
+	#error Invalid/unknown ARMCLK selection!
+#endif
+#ifndef DDRCLK_RATIO
+	#error Invalid/unknown DDRCLK selection!
+#endif
+
+#define ARMDDR_CLK_RATIO_FPERCISION 1000
+
+#if ARMCLK_IN != DDRCLK_IN
+	#ifndef CUSTOM_ARMDDR_CLK_RATIO
+		/**
+		 * SYS_CLKINx are defined within the device tree, not configs.
+		 * Thus, we can only determine cross-CGU clock ratios if they
+		 * use the same SYS_CLKINx.
+		 */
+		#error Define CUSTOM_ARMDDR_CLK_RATIO for different SYS_CLKINs
+	#else
+		#define ARMDDR_CLK_RATIO CUSTOM_ARMDDR_CLK_RATIO
+	#endif
+#else
+	#define ARMDDR_CLK_RATIO (ARMDDR_CLK_RATIO_FPERCISION *\
+				   ARMCLK_RATIO / DDRCLK_RATIO)
+#endif
+
+void dmcdelay(uint32_t delay)
+{
+	/* There is no zero-overhead loop on ARM, so assume each iteration
+	 * takes 4 processor cycles (based on examination of -O3 and -Ofast
+	 * output).
+	 */
+	u32 i, remainder;
+
+	/* Convert DDR cycles to core clock cycles */
+	u32 f = delay * ARMDDR_CLK_RATIO;
+
+	delay = f + 500;
+	delay /= ARMDDR_CLK_RATIO_FPERCISION;
+
+	/* Round up to multiple of 4 */
+	remainder = delay % 4;
+	if (remainder != 0u)
+		delay += (4u - remainder);
+
+	for (i = 0; i < delay; i += 4)
+		asm("nop");
+}
+
+static void program_cgu(const struct CGU_Settings *cgu)
+{
+	const uintptr_t b = cgu->rbase;
+	const bool use_extension0 = cgu->divex_S0SELEX >= 0;
+	const bool use_extension1 = cgu->divex_S1SELEX >= 0;
+	u32 temp;
+
+	temp =  OSEL(cgu->div_OSEL);
+	temp |= SYSSEL(cgu->div_SYSSEL);
+	temp |= CSEL(cgu->div_CSEL);
+	temp |= DSEL(cgu->div_DSEL);
+	temp |= (S0SEL(cgu->div_S0SEL));
+	temp |= (S1SEL(cgu->div_S1SEL));
+	temp &= ~BITM_CGU_DIV_LOCK;
+
+	//Put PLL in to Bypass Mode
+	writel(BITM_CGU_PLLCTL_PLLEN | BITM_CGU_PLLCTL_PLLBPST,
+	       b + CGU_PLLCTL);
+	while (!(readl(b + CGU_STAT) & BITM_CGU_STAT_PLLBP))
+		;
+
+	while (!((readl(b + CGU_STAT) & CGU_STAT_MASK) == CGU_STAT_ALGN_LOCK))
+		;
+
+	dmcdelay(1000);
+
+	writel(temp & (~BITM_CGU_DIV_ALGN) & (~BITM_CGU_DIV_UPDT),
+	       b + CGU_DIV);
+
+	dmcdelay(1000);
+
+	temp = MSEL(cgu->ctl_MSEL) | DF(cgu->ctl_DF);
+	if (use_extension0)
+		temp |= BITM_CGU_CTL_S0SELEXEN;
+	if (use_extension1)
+		temp |= BITM_CGU_CTL_S1SELEXEN;
+
+	writel(temp & (~BITM_CGU_CTL_LOCK), b + CGU_CTL);
+
+	if (use_extension0 || use_extension1) {
+		u32 mask = BITM_CGU_CTL_S1SELEXEN | BITM_CGU_CTL_S0SELEXEN;
+
+		while (!(readl(b + CGU_CTL) & mask))
+			;
+
+		temp = readl(b + CGU_DIVEX);
+
+		if (use_extension0) {
+			temp &= ~BITM_CGU_DIVEX_S0SELEX;
+			temp |= S0SELEX(cgu->divex_S0SELEX);
+		}
+
+		if (use_extension1) {
+			temp &= ~BITM_CGU_DIVEX_S1SELEX;
+			temp |= S1SELEX(cgu->divex_S1SELEX);
+		}
+
+		writel(temp, b + CGU_DIVEX);
+	}
+
+	dmcdelay(1000);
+
+	//Take PLL out of Bypass Mode
+	writel(BITM_CGU_PLLCTL_PLLEN | BITM_CGU_PLLCTL_PLLBPCL,
+	       b + CGU_PLLCTL);
+	while ((readl(b + CGU_STAT) &
+	       (BITM_CGU_STAT_PLLBP | BITM_CGU_STAT_CLKSALGN)))
+		;
+
+	dmcdelay(1000);
+
+	if (cgu->clkoutsel >= 0) {
+		temp = readl(b + CGU_CLKOUTSEL);
+		temp &= ~BITM_CGU_CLKOUTSEL_CLKOUTSEL;
+		temp |= CLKOUTSEL(cgu->clkoutsel);
+		writel(temp, b + CGU_CLKOUTSEL);
+	}
+}
+
+void adi_config_third_pll(void)
+{
+#if defined(CONFIG_CGU1_PLL3_VCO_MSEL) && defined(CONFIG_CGU1_PLL3_DCLK_DIV)
+	u32 temp;
+
+	u32 msel = CONFIG_CGU1_PLL3_VCO_MSEL - 1;
+	u32 dsel = CONFIG_CGU1_PLL3_DCLK_DIV - 1;
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp &= 0xFFFE0000;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	dmcdelay(4000u);
+
+	//update MSEL [10:4]
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= ((msel << BITP_REG10_MSEL3) & BITM_REG10_MSEL3);
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x2;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	dmcdelay(100000u);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x1;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x800;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp &= 0xFFFFF7F8;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	dmcdelay(4000u);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= ((dsel << BITP_REG10_DSEL3) & BITM_REG10_DSEL3);
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x4;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	dmcdelay(100000u);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x1;
+	writel(temp, REG_MISC_REG10_tst_addr);
+
+	temp = readl(REG_MISC_REG10_tst_addr);
+	temp |= 0x800;
+	writel(temp, REG_MISC_REG10_tst_addr);
+#endif
+}
+
+static void Active_To_Fullon(const struct CGU_Settings *pCGU)
+{
+	u32 tmp;
+
+	while (1) {
+		tmp = readl(pCGU->rbase + CGU_STAT);
+		if ((tmp & BITM_CGU_STAT_PLLEN) &&
+		    (tmp & BITM_CGU_STAT_PLLBP))
+			break;
+	}
+
+	writel(BITM_CGU_PLLCTL_PLLBPCL, pCGU->rbase + CGU_PLLCTL);
+
+	while (1) {
+		tmp = readl(pCGU->rbase + CGU_STAT);
+		if ((tmp & BITM_CGU_STAT_PLLEN) &&
+		    ~(tmp & BITM_CGU_STAT_PLLBP) &&
+		    ~(tmp & BITM_CGU_STAT_CLKSALGN))
+			break;
+	}
+}
+
+static void CGU_Init(const struct CGU_Settings *pCGU)
+{
+	const uintptr_t b = pCGU->rbase;
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	if (readl(b + CGU_STAT) & BITM_CGU_STAT_PLLEN)
+		writel(BITM_CGU_PLLCTL_PLLEN, b + CGU_PLLCTL);
+
+	dmcdelay(1000);
+#endif
+
+	/* Check if processor is in Active mode */
+	if (readl(b + CGU_STAT) & BITM_CGU_STAT_PLLBP)
+		Active_To_Fullon(pCGU);
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	dmcdelay(1000);
+#endif
+
+	program_cgu(pCGU);
+}
+
+void cgu_init(void)
+{
+	const struct CGU_Settings dividers0 = {
+		.rbase =		CGU0_REGBASE,
+		.ctl_MSEL =		CONFIG_CGU0_VCO_MULT,
+		.ctl_DF =		CONFIG_CGU0_DF_DIV,
+		.div_CSEL =		CONFIG_CGU0_CCLK_DIV,
+		.div_SYSSEL =		CONFIG_CGU0_SCLK_DIV,
+		.div_S0SEL =		VAL_CGU0_SCLK0_DIV,
+		.div_S1SEL =		VAL_CGU0_SCLK1_DIV,
+		.div_DSEL =		CONFIG_CGU0_DCLK_DIV,
+		.div_OSEL =		CONFIG_CGU0_OCLK_DIV,
+		.divex_S0SELEX =	VAL_CGU0_DIV_S0SELEX,
+		.divex_S1SELEX =	VAL_CGU0_DIV_S1SELEX,
+		.clkoutsel =		VAL_CGU0_CLKOUTSEL,
+	};
+	const struct CGU_Settings dividers1 = {
+		.rbase =		CGU1_REGBASE,
+		.ctl_MSEL =		CONFIG_CGU1_VCO_MULT,
+		.ctl_DF =		CONFIG_CGU1_DF_DIV,
+		.div_CSEL =		CONFIG_CGU1_CCLK_DIV,
+		.div_SYSSEL =		CONFIG_CGU1_SCLK_DIV,
+		.div_S0SEL =		VAL_CGU1_SCLK0_DIV,
+		.div_S1SEL =		VAL_CGU1_SCLK1_DIV,
+		.div_DSEL =		CONFIG_CGU1_DCLK_DIV,
+		.div_OSEL =		CONFIG_CGU1_OCLK_DIV,
+		.divex_S0SELEX =	VAL_CGU1_DIV_S0SELEX,
+		.divex_S1SELEX =	VAL_CGU1_DIV_S1SELEX,
+		.clkoutsel =		VAL_CGU1_CLKOUTSEL,
+	};
+
+	CGU_Init(&dividers0);
+	CGU_Init(&dividers1);
+}
+
+#define CONFIGURE_CDU0(a, b, c) \
+	writel(a, b); \
+	while (readl(REG_CDU0_STAT) & (1 << (c)))
+
+void cdu_init(void)
+{
+	while (readl(REG_CDU0_STAT) & 0xffff)
+		;
+	writel((CONFIG_CDU0_CGU1_CLKIN & 0x1), REG_CDU0_CLKINSEL);
+
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO0, REG_CDU0_CFG0, 0);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO1, REG_CDU0_CFG1, 1);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO2, REG_CDU0_CFG2, 2);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO3, REG_CDU0_CFG3, 3);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO4, REG_CDU0_CFG4, 4);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO5, REG_CDU0_CFG5, 5);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO6, REG_CDU0_CFG6, 6);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO7, REG_CDU0_CFG7, 7);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO8, REG_CDU0_CFG8, 8);
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO9, REG_CDU0_CFG9, 9);
+#ifdef CONFIG_CDU0_CLKO10
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO10, REG_CDU0_CFG10, 10);
+#endif
+#ifdef CONFIG_CDU0_CLKO12
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO12, REG_CDU0_CFG12, 12);
+#endif
+#ifdef CONFIG_CDU0_CLKO13
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO13, REG_CDU0_CFG13, 13);
+#endif
+#ifdef CONFIG_CDU0_CLKO14
+	CONFIGURE_CDU0(CONFIG_CDU0_CLKO14, REG_CDU0_CFG14, 14);
+#endif
+}
+
+void clks_init(void)
+{
+	adi_dmc_reset_lanes(true);
+
+	cdu_init();
+	cgu_init();
+
+	adi_config_third_pll();
+
+	adi_dmc_reset_lanes(false);
+}
diff --git a/arch/arm/mach-sc5xx/init/clkinit.h b/arch/arm/mach-sc5xx/init/clkinit.h
new file mode 100644
index 0000000000..b05f4325bf
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/clkinit.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef CLKINIT_H_
+#define CLKINIT_H_
+
+void clks_init(void);
+
+void dmcdelay(uint32_t delay);
+
+#endif
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/dmcinit.c
new file mode 100644
index 0000000000..e375b5c9df
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -0,0 +1,954 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <linux/types.h>
+#include "clkinit.h"
+#include "dmcinit.h"
+
+#define REG_DMC0_BASE		0x31070000
+#define REG_DMC1_BASE		0x31073000
+
+#define REG_DMC_CTL		0x0004 // Control Register
+#define REG_DMC_STAT		0x0008 // Status Register
+#define REG_DMC_CFG		0x0040 // Configuration Register
+#define REG_DMC_TR0		0x0044 // Timing 0 Register
+#define REG_DMC_TR1		0x0048 // Timing 1 Register
+#define REG_DMC_TR2		0x004C // Timing 2 Register
+#define REG_DMC_MR		0x0060 // Shadow MR Register (DDR3)
+#define REG_DMC_EMR1		0x0064 // Shadow EMR1 Register
+#define REG_DMC_EMR2		0x0068 // Shadow EMR2 Register
+#define REG_DMC_EMR3		0x006C
+#define REG_DMC_DLLCTL		0x0080 // DLL Control Register
+#define REG_DMC_DT_CALIB_ADDR	0x0090 // Data Calibration Address Register
+#define REG_DMC_CPHY_CTL	0x01C0 // Controller to PHY Interface Register
+
+/* SC57x && SC58x DMC REGs */
+#define REG_DMC_PHY_CTL0	0x1000 // PHY Control 0 Register
+#define REG_DMC_PHY_CTL1	0x1004 // PHY Control 1 Register
+#define REG_DMC_PHY_CTL2	0x1008 // PHY Control 2 Register
+#define REG_DMC_PHY_CTL3	0x100c // PHY Control 3 Register
+#define REG_DMC_PHY_CTL4	0x1010 // PHY Control 4 Register
+#define REG_DMC_CAL_PADCTL0	0x1034 // CALIBRATION PAD CTL 0 Register
+#define REG_DMC_CAL_PADCTL2	0x103C // CALIBRATION PAD CTL2 Register
+/* END */
+
+/* SC59x DMC REGs */
+#define REG_DMC_DDR_LANE0_CTL0	0x1000 // Data Lane 0 Control Register 0
+#define REG_DMC_DDR_LANE0_CTL1	0x1004 // Data Lane 0 Control Register 1
+#define REG_DMC_DDR_LANE1_CTL0	0x100C // Data Lane 1 Control Register 0
+#define REG_DMC_DDR_LANE1_CTL1	0x1010 // Data Lane 1 Control Register 1
+#define REG_DMC_DDR_ROOT_CTL	0x1018 // DDR ROOT Module Control Register
+#define REG_DMC_DDR_ZQ_CTL0	0x1034 // DDR Calibration Control Register 0
+#define REG_DMC_DDR_ZQ_CTL1	0x1038 // DDR Calibration Control Register 1
+#define REG_DMC_DDR_ZQ_CTL2	0x103C // DDR Calibration Control Register 2
+#define REG_DMC_DDR_CA_CTL	0x1068 // DDR CA Lane Control Register
+/* END */
+
+#define REG_DMC_DDR_SCRATCH_2	0x1074
+#define REG_DMC_DDR_SCRATCH_3	0x1078
+#define REG_DMC_DDR_SCRATCH_6	0x1084
+#define REG_DMC_DDR_SCRATCH_7	0x1088
+
+#define REG_DMC_DDR_SCRATCH_STAT0	0x107C
+#define REG_DMC_DDR_SCRATCH_STAT1	0x1080
+
+#define DMC0_DATA_CALIB_ADD	0x80000000
+#define DMC1_DATA_CALIB_ADD	0xC0000000
+
+#define BITM_DMC_CFG_EXTBANK	0x0000F000  /* External Banks */
+#define ENUM_DMC_CFG_EXTBANK1	0x00000000  /* EXTBANK: 1 External Bank */
+#define BITM_DMC_CFG_SDRSIZE	0x00000F00  /* SDRAM Size */
+#define ENUM_DMC_CFG_SDRSIZE64	0x00000000  /* SDRSIZE: 64M Bit SDRAM (LPDDR Only) */
+#define ENUM_DMC_CFG_SDRSIZE128	0x00000100  /* SDRSIZE: 128M Bit SDRAM (LPDDR Only) */
+#define ENUM_DMC_CFG_SDRSIZE256	0x00000200  /* SDRSIZE: 256M Bit SDRAM */
+#define ENUM_DMC_CFG_SDRSIZE512	0x00000300  /* SDRSIZE: 512M Bit SDRAM */
+#define ENUM_DMC_CFG_SDRSIZE1G	0x00000400  /* SDRSIZE: 1G Bit SDRAM */
+#define ENUM_DMC_CFG_SDRSIZE2G	0x00000500  /* SDRSIZE: 2G Bit SDRAM */
+#define ENUM_DMC_CFG_SDRSIZE4G	0x00000600  /* SDRSIZE: 4G Bit SDRAM */
+#define ENUM_DMC_CFG_SDRSIZE8G	0x00000700  /* SDRSIZE: 8G Bit SDRAM */
+#define BITM_DMC_CFG_SDRWID	0x000000F0  /* SDRAM Width */
+#define ENUM_DMC_CFG_SDRWID16	0x00000020  /* SDRWID: 16-Bit Wide SDRAM */
+#define BITM_DMC_CFG_IFWID	0x0000000F  /* Interface Width */
+#define ENUM_DMC_CFG_IFWID16	0x00000002  /* IFWID: 16-Bit Wide Interface */
+
+#define BITM_DMC_CTL_DDR3EN	0x00000001
+#define BITM_DMC_CTL_INIT	0x00000004
+#define BITP_DMC_STAT_INITDONE	2            /* Initialization Done */
+#define BITM_DMC_STAT_INITDONE	0x00000004
+
+#define BITP_DMC_CTL_AL_EN	27
+#define BITP_DMC_CTL_ZQCL	25           /* ZQ Calibration Long */
+#define BITP_DMC_CTL_ZQCS	24           /* ZQ Calibration Short */
+#define BITP_DMC_CTL_DLLCAL	13           /* DLL Calibration Start */
+#define BITP_DMC_CTL_PPREF	12           /* Postpone Refresh */
+#define BITP_DMC_CTL_RDTOWR	 9           /* Read-to-Write Cycle */
+#define BITP_DMC_CTL_ADDRMODE	 8           /* Addressing (Page/Bank) Mode */
+#define BITP_DMC_CTL_RESET	 7           /* Reset SDRAM */
+#define BITP_DMC_CTL_PREC	 6           /* Precharge */
+#define BITP_DMC_CTL_DPDREQ	 5           /* Deep Power Down Request */
+#define BITP_DMC_CTL_PDREQ	 4           /* Power Down Request */
+#define BITP_DMC_CTL_SRREQ	 3           /* Self Refresh Request */
+#define BITP_DMC_CTL_INIT	 2           /* Initialize DRAM Start */
+#define BITP_DMC_CTL_LPDDR	 1           /* Low Power DDR Mode */
+#define BITP_DMC_CTL_DDR3EN	 0           /* DDR3 Mode */
+
+#ifdef CONFIG_TARGET_SC584_EZKIT
+	#define DMC_PADCTL2_VALUE	0x0078283C
+#elif CONFIG_TARGET_SC573_EZKIT
+	#define DMC_PADCTL2_VALUE	0x00782828
+#elif CONFIG_TARGET_SC589_MINI || CONFIG_TARGET_SC589_EZKIT
+	#define DMC_PADCTL2_VALUE	0x00783C3C
+#elif defined(CONFIG_SC57X) || defined(CONFIG_SC58X)
+	#error "PADCTL2 not specified for custom board!"
+#else
+	//Newer DMC. Legacy calibration obsolete
+	#define DMC_PADCTL2_VALUE	0x0
+#endif
+
+#define DMC_CPHYCTL_VALUE	0x0000001A
+
+#define BITP_DMC_MR1_QOFF	12 /*  Output Buffer Enable */
+#define BITP_DMC_MR1_TDQS	11 /*  Termination Data Strobe */
+#define BITP_DMC_MR1_RTT2	 9 /*  Rtt_nom */
+#define BITP_DMC_MR1_WL		 7 /*  Write Leveling Enable. */
+#define BITP_DMC_MR1_RTT1	 6 /*  Rtt_nom */
+#define BITP_DMC_MR1_DIC1	 5 /*  Output Driver Impedance Control */
+#define BITP_DMC_MR1_AL		 3 /*  Additive Latency */
+#define BITP_DMC_MR1_RTT0	 2 /*  Rtt_nom */
+#define BITP_DMC_MR1_DIC0	 1 /*  Output Driver Impedance control */
+#define BITP_DMC_MR1_DLLEN	 0 /*  DLL Enable */
+
+#define BITP_DMC_MR2_CWL	 3 /* CAS write Latency */
+
+#define BITP_DMC_TR0_TMRD	28 /* Timing Mode Register Delay */
+#define BITP_DMC_TR0_TRC	20 /* Timing Row Cycle */
+#define BITP_DMC_TR0_TRAS	12 /* Timing Row Active Time */
+#define BITP_DMC_TR0_TRP	 8 /* Timing RAS Precharge. */
+#define BITP_DMC_TR0_TWTR	 4 /* Timing Write to Read */
+#define BITP_DMC_TR0_TRCD	 0 /* Timing RAS to CAS Delay */
+
+#define BITP_DMC_TR1_TRRD	28 /* Timing Read-Read Delay */
+#define BITP_DMC_TR1_TRFC	16 /* Timing Refresh-to-Command */
+#define BITP_DMC_TR1_TREF	 0 /* Timing Refresh Interval */
+
+#define BITP_DMC_TR2_TCKE	20 /* Timing Clock Enable */
+#define BITP_DMC_TR2_TXP	16 /* Timing Exit Powerdown */
+#define BITP_DMC_TR2_TWR	12 /* Timing Write Recovery */
+#define BITP_DMC_TR2_TRTP	 8 /* Timing Read-to-Precharge */
+#define BITP_DMC_TR2_TFAW	 0 /* Timing Four-Activated-Window */
+
+#define BITP_DMC_MR_PD		12 /* Active Powerdown Mode */
+#define BITP_DMC_MR_WRRECOV	 9 /* Write Recovery */
+#define BITP_DMC_MR_DLLRST	 8 /* DLL Reset */
+#define BITP_DMC_MR_CL		 4 /* CAS Latency */
+#define BITP_DMC_MR_CL0		 2 /* CAS Latency */
+#define BITP_DMC_MR_BLEN	 0 /* Burst Length */
+
+#define BITP_DMC_DLLCTL_DATACYC		8 /* Data Cycles */
+#define BITP_DMC_DLLCTL_DLLCALRDCNT	0 /* DLL Calibration RD Count */
+
+#define BITM_DMC_DLLCTL_DATACYC		0x00000F00 /* Data Cycles */
+#define BITM_DMC_DLLCTL_DLLCALRDCNT	0x000000FF /* DLL Calib RD Count */
+
+#define BITP_DMC_STAT_PHYRDPHASE	20 /* PHY Read Phase */
+
+#define BITM_DMC_DDR_LANE0_CTL0_CB_RSTDAT	0x08000000 /* Rst Data Pads */
+#define BITM_DMC_DDR_LANE1_CTL0_CB_RSTDAT	0x08000000 /* Rst Data Pads */
+#define BITM_DMC_DDR_LANE0_CTL1_COMP_DCYCLE	0x00000002 /* Compute Dcycle */
+#define BITM_DMC_DDR_LANE1_CTL1_COMP_DCYCLE	0x00000002 /* Compute Dcycle */
+#define BITM_DMC_DDR_LANE1_CTL0_CB_RSTDLL	0x00000100 /* Rst Lane DLL */
+#define BITM_DMC_DDR_LANE0_CTL0_CB_RSTDLL	0x00000100 /* Rst Lane DLL */
+#define BITP_DMC_DDR_ROOT_CTL_PIPE_OFSTDCYCLE	10         /* Pipeline offset for PHYC_DATACYCLE */
+#define BITM_DMC_DDR_ROOT_CTL_SW_REFRESH	0x00002000 /* Refresh Lane DLL Code */
+#define BITM_DMC_DDR_CA_CTL_SW_REFRESH		0x00004000 /* Refresh Lane DLL Code */
+
+#define BITP_DMC_CTL_RL_DQS		26         /* RL_DQS */
+#define BITM_DMC_CTL_RL_DQS		0x04000000 /* RL_DQS */
+#define BITP_DMC_EMR3_MPR		 2         /* Multi Purpose Read Enable (Read Leveling)*/
+#define BITM_DMC_EMR3_MPR		0x00000004 /* Multi Purpose Read Enable (Read Leveling)*/
+#define BITM_DMC_MR1_WL			0x00000080 /* Write Leveling Enable.*/
+#define BITM_DMC_STAT_PHYRDPHASE	0x00F00000 /* PHY Read Phase */
+
+#define BITP_DMC_DDR_LANE0_CTL1_BYPCODE		10
+#define BITM_DMC_DDR_LANE0_CTL1_BYPCODE		0x00007C00
+#define BITP_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN	15
+#define BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN	0x00008000
+
+#define DMC_ZQCTL0_VALUE			0x00785A64
+#define DMC_ZQCTL1_VALUE			0
+#define DMC_ZQCTL2_VALUE			0x70000000
+
+#define DMC_TRIG_CALIB				0
+#define DMC_OFSTDCYCLE				2
+
+#define BITP_DMC_CAL_PADCTL0_RTTCALEN	31         /* RTT Calibration Enable */
+#define BITP_DMC_CAL_PADCTL0_PDCALEN	30         /* PULLDOWN Calib Enable */
+#define BITP_DMC_CAL_PADCTL0_PUCALEN	29         /* PULLUP Calib Enable */
+#define BITP_DMC_CAL_PADCTL0_CALSTRT	28         /* Start New Calib ( Hardware Cleared) */
+#define BITM_DMC_CAL_PADCTL0_RTTCALEN	0x80000000 /* RTT Calibration Enable */
+#define BITM_DMC_CAL_PADCTL0_PDCALEN	0x40000000 /* PULLDOWN Calib Enable */
+#define BITM_DMC_CAL_PADCTL0_PUCALEN	0x20000000 /* PULLUP Calib Enable */
+#define BITM_DMC_CAL_PADCTL0_CALSTRT	0x10000000 /* Start New Calib ( Hardware Cleared) */
+#define ENUM_DMC_PHY_CTL4_DDR3		0x00000000 /* DDRMODE: DDR3 Mode */
+#define ENUM_DMC_PHY_CTL4_DDR2		0x00000001 /* DDRMODE: DDR2 Mode */
+#define ENUM_DMC_PHY_CTL4_LPDDR		0x00000003 /* DDRMODE: LPDDR Mode */
+
+#define BITP_DMC_DDR_ZQ_CTL0_IMPRTT	16         /*  Data/DQS ODT */
+#define BITP_DMC_DDR_ZQ_CTL0_IMPWRDQ	 8         /*  Data/DQS/DM/CLK Drive Strength */
+#define BITP_DMC_DDR_ZQ_CTL0_IMPWRADD	 0         /*  Address/Command Drive Strength */
+#define BITM_DMC_DDR_ZQ_CTL0_IMPRTT	0x00FF0000 /* Data/DQS ODT */
+#define BITM_DMC_DDR_ZQ_CTL0_IMPWRDQ	0x0000FF00 /* Data/DQS/DM/CLK Drive Strength */
+#define BITM_DMC_DDR_ZQ_CTL0_IMPWRADD	0x000000FF /* Address/Command Drive Strength */
+
+#define BITM_DMC_DDR_ROOT_CTL_TRIG_RD_XFER_ALL	0x00200000 /* All Lane Read Status */
+
+#if defined(CONFIG_ADI_USE_DDR2)
+	#define DMC_MR0_VALUE \
+		((DMC_BL / 4 + 1) << BITP_DMC_MR_BLEN) | \
+		(DMC_CL << BITP_DMC_MR_CL) | \
+		(DMC_WRRECOV << BITP_DMC_MR_WRRECOV)
+
+	#define DMC_MR1_VALUE \
+		(DMC_MR1_AL << BITP_DMC_MR1_AL | 0x04) \
+
+	#define DMC_MR2_VALUE 0
+	#define DMC_MR3_VALUE 0
+
+	#define DMC_CTL_VALUE \
+		(DMC_RDTOWR << BITP_DMC_CTL_RDTOWR) | \
+		(1 << BITP_DMC_CTL_DLLCAL) | \
+		(BITM_DMC_CTL_INIT)
+#else
+	#define DMC_MR0_VALUE \
+		(0 << BITP_DMC_MR_BLEN) | \
+		(DMC_CL0 << BITP_DMC_MR_CL0) | \
+		(DMC_CL123 << BITP_DMC_MR_CL) | \
+		(DMC_WRRECOV << BITP_DMC_MR_WRRECOV) | \
+		(1 << BITP_DMC_MR_DLLRST)
+
+	#define DMC_MR1_VALUE \
+		(DMC_MR1_DLLEN << BITP_DMC_MR1_DLLEN) | \
+		(DMC_MR1_DIC0 << BITP_DMC_MR1_DIC0) | \
+		(DMC_MR1_RTT0 << BITP_DMC_MR1_RTT0) | \
+		(DMC_MR1_AL << BITP_DMC_MR1_AL) | \
+		(DMC_MR1_DIC1 << BITP_DMC_MR1_DIC1) | \
+		(DMC_MR1_RTT1 << BITP_DMC_MR1_RTT1) | \
+		(DMC_MR1_RTT2 << BITP_DMC_MR1_RTT2) | \
+		(DMC_MR1_WL << BITP_DMC_MR1_WL) | \
+		(DMC_MR1_TDQS << BITP_DMC_MR1_TDQS) | \
+		(DMC_MR1_QOFF << BITP_DMC_MR1_QOFF)
+
+	#define DMC_MR2_VALUE \
+		((DMC_WL) << BITP_DMC_MR2_CWL)
+
+	#define DMC_MR3_VALUE \
+		((DMC_WL) << BITP_DMC_MR2_CWL)
+
+	#define DMC_CTL_VALUE \
+		(DMC_RDTOWR << BITP_DMC_CTL_RDTOWR) | \
+		(BITM_DMC_CTL_INIT) | \
+		(BITM_DMC_CTL_DDR3EN) | \
+		(DMC_CTL_AL_EN << BITP_DMC_CTL_AL_EN)
+#endif
+
+#define DMC_DLLCTL_VALUE \
+	(DMC_DATACYC << BITP_DMC_DLLCTL_DATACYC) | \
+	(DMC_DLLCALRDCNT << BITP_DMC_DLLCTL_DLLCALRDCNT)
+
+#define DMC_CFG_VALUE \
+	ENUM_DMC_CFG_IFWID16 | \
+	ENUM_DMC_CFG_SDRWID16 | \
+	SDR_CHIP_SIZE | \
+	ENUM_DMC_CFG_EXTBANK1
+
+#define DMC_TR0_VALUE \
+	(DMC_TRCD << BITP_DMC_TR0_TRCD) | \
+	(DMC_TWTR << BITP_DMC_TR0_TWTR) | \
+	(DMC_TRP << BITP_DMC_TR0_TRP) | \
+	(DMC_TRAS << BITP_DMC_TR0_TRAS) | \
+	(DMC_TRC << BITP_DMC_TR0_TRC) | \
+	(DMC_TMRD << BITP_DMC_TR0_TMRD)
+
+#define DMC_TR1_VALUE \
+	(DMC_TREF << BITP_DMC_TR1_TREF) | \
+	(DMC_TRFC << BITP_DMC_TR1_TRFC) | \
+	(DMC_TRRD << BITP_DMC_TR1_TRRD)
+
+#define DMC_TR2_VALUE \
+	(DMC_TFAW << BITP_DMC_TR2_TFAW) | \
+	(DMC_TRTP << BITP_DMC_TR2_TRTP) | \
+	(DMC_TWR << BITP_DMC_TR2_TWR) | \
+	(DMC_TXP << BITP_DMC_TR2_TXP) | \
+	(DMC_TCKE << BITP_DMC_TR2_TCKE)
+
+enum DDR_MODE {
+	DDR3_MODE,
+	DDR2_MODE,
+	LPDDR_MODE,
+};
+
+enum CALIBRATION_MODE {
+	CALIBRATION_LEGACY,
+	CALIBRATION_METHOD1,
+	CALIBRATION_METHOD2,
+};
+
+static struct dmc_param {
+	phys_addr_t reg;
+	u32 ddr_mode;
+	u32 padctl2_value;
+	u32 dmc_cphyctl_value;
+	u32 dmc_cfg_value;
+	u32 dmc_dllctl_value;
+	u32 dmc_ctl_value;
+	u32 dmc_tr0_value;
+	u32 dmc_tr1_value;
+	u32 dmc_tr2_value;
+	u32 dmc_mr0_value;
+	u32 dmc_mr1_value;
+	u32 dmc_mr2_value;
+	u32 dmc_mr3_value;
+	u32 dmc_zqctl0_value;
+	u32 dmc_zqctl1_value;
+	u32 dmc_zqctl2_value;
+	u32 dmc_data_calib_add_value;
+	bool phy_init_required;
+	bool anomaly_20000037_applicable;
+	enum CALIBRATION_MODE calib_mode;
+} dmc;
+
+#ifdef CONFIG_SC59X_64
+#define DQS_DEFAULT_DELAY	3ul
+
+#define DELAYTRIM	1
+#define LANE0_DQS_DELAY	1
+#define LANE1_DQS_DELAY	1
+
+#define CLKDIR		0ul
+
+#define DQSTRIM		0
+#define DQSCODE		0ul
+
+#define CLKTRIM		0
+#define CLKCODE		0ul
+#endif
+
+static inline void calibration_legacy(void)
+{
+	u32 temp;
+
+	/* 1. Set DDR mode to DDR3/DDR2/LPDDR in DMCx_PHY_CTL4 register */
+	if (dmc.ddr_mode == DDR3_MODE)
+		writel(ENUM_DMC_PHY_CTL4_DDR3, dmc.reg + REG_DMC_PHY_CTL4);
+	else if (dmc.ddr_mode == DDR2_MODE)
+		writel(ENUM_DMC_PHY_CTL4_DDR2, dmc.reg + REG_DMC_PHY_CTL4);
+	else if (dmc.ddr_mode == LPDDR_MODE)
+		writel(ENUM_DMC_PHY_CTL4_LPDDR, dmc.reg + REG_DMC_PHY_CTL4);
+
+	/*
+	 * 2. Make sure that the bits 6, 7, 25, and 27 of the DMC_PHY_
+	 * CTL3 register are set
+	 */
+	writel(0x0A0000C0, dmc.reg + REG_DMC_PHY_CTL3);
+
+	/*
+	 * 3. For DDR2/DDR3 mode, make sure that the bits 0, 1, 2, 3 of
+	 * the DMC_PHY_CTL0 register and the bits 26, 27, 28, 29, 30, 31
+	 * of the DMC_PHY_CTL2 are set.
+	 */
+	if (dmc.ddr_mode == DDR3_MODE ||
+	    dmc.ddr_mode == DDR2_MODE) {
+		writel(0XFC000000, dmc.reg + REG_DMC_PHY_CTL2);
+		writel(0x0000000f, dmc.reg + REG_DMC_PHY_CTL0);
+	}
+
+	writel(0x00000000, dmc.reg + REG_DMC_PHY_CTL1);
+
+	/* 4. For DDR3 mode, set bit 1 and configure bits [5:2] of the
+	 * DMC_CPHY_CTL register with WL=CWL+AL in DCLK cycles.
+	 */
+	if (dmc.ddr_mode == DDR3_MODE)
+		writel(dmc.dmc_cphyctl_value, dmc.reg + REG_DMC_CPHY_CTL);
+	/* 5. Perform On Die Termination(ODT) & Driver Impedance Calibration */
+	if (dmc.ddr_mode == LPDDR_MODE) {
+		/* Bypass processor ODT */
+		writel(0x80000, dmc.reg + REG_DMC_PHY_CTL1);
+	} else {
+		/* Set bits RTTCALEN, PDCALEN, PUCALEN of register */
+		temp = BITM_DMC_CAL_PADCTL0_RTTCALEN |
+		       BITM_DMC_CAL_PADCTL0_PDCALEN |
+		       BITM_DMC_CAL_PADCTL0_PUCALEN;
+		writel(temp, dmc.reg + REG_DMC_CAL_PADCTL0);
+		/* Configure ODT and drive impedance values in the
+		 * DMCx_CAL_PADCTL2 register
+		 */
+		writel(dmc.padctl2_value, dmc.reg + REG_DMC_CAL_PADCTL2);
+		/* start calibration */
+		temp |= BITM_DMC_CAL_PADCTL0_CALSTRT;
+		writel(temp, dmc.reg + REG_DMC_CAL_PADCTL0);
+		/* Wait for PAD calibration to complete - 300 DCLK cycle.
+		 * Worst case: CCLK=450 MHz, DCLK=125 MHz
+		 */
+		dmcdelay(300);
+	}
+}
+
+static inline void calibration_method1(void)
+{
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	writel(dmc.dmc_zqctl0_value, dmc.reg + REG_DMC_DDR_ZQ_CTL0);
+	writel(dmc.dmc_zqctl1_value, dmc.reg + REG_DMC_DDR_ZQ_CTL1);
+	writel(dmc.dmc_zqctl2_value, dmc.reg + REG_DMC_DDR_ZQ_CTL2);
+
+	/* Generate the trigger */
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x00010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(8000u);
+
+	/* The [31:26] bits may change if pad ring changes */
+	writel(0x0C000001ul | DMC_TRIG_CALIB,  dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(8000u);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+#endif
+}
+
+static inline void calibration_method2(void)
+{
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	u32 stat_value = 0x0u;
+	u32 drv_pu, drv_pd, odt_pu, odt_pd;
+	u32 ro_dt, clk_dqs_drv_impedance;
+	u32 temp;
+
+	/* Reset trigger */
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+
+	/* Writing internal registers in calib pad to zero. Calib mode set
+	 * to 1 [26], trig M1 S1 write [16], this enables usage of scratch
+	 * registers instead of ZQCTL registers
+	 */
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+
+	/* TRIGGER FOR M2-S2 WRITE     -> slave id 31:26  trig m2,s2 write
+	 * bit 1->1 slave1 address is 4
+	 */
+	writel(0x10000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+
+	/* reset Trigger */
+	writel(0x0u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+
+	/* write to slave 1, make the power down bit high */
+	writel(0x1ul << 12, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	dmcdelay(2500u);
+
+	/* Calib mode set to 1 [26], trig M1 S1 write [16] */
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+
+	writel(0x10000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x0, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+
+	/* for slave 0 */
+	writel(dmc.dmc_zqctl0_value, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+
+	/* Calib mode set to 1 [26], trig M1 S1 write [16] */
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+
+	writel(0x0C000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+
+	/* writing to slave 1
+	 * calstrt is 0, but other programming is done
+	 *
+	 * make power down LOW again, to kickstart BIAS circuit
+	 */
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x30000000ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+
+	/* write to ca_ctl lane, calib mode set to 1 [26],
+	 * trig M1 S1 write [16]
+	 */
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+
+	/*  copies data to lane controller slave
+	 *  TRIGGER FOR M2-S2 WRITE     -> slave id 31:26
+	 *  trig m2,s2 write bit 1->1
+	 *  slave1 address is 4
+	 */
+	writel(0x10000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+
+	/* reset Trigger */
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x10000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(0x0ul, dmc.reg + REG_DMC_DDR_SCRATCH_3);
+	writel(0x50000000ul, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(0x04010000ul, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x10000002ul, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+	writel(0u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x0C000004u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+	writel(BITM_DMC_DDR_ROOT_CTL_TRIG_RD_XFER_ALL,
+	       dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	// calculate ODT PU and PD values
+	stat_value = ((readl(dmc.reg + REG_DMC_DDR_SCRATCH_7) & 0x0000FFFFu) <<
+		16);
+	stat_value |= ((readl(dmc.reg + REG_DMC_DDR_SCRATCH_6) & 0xFFFF0000u) >>
+		16);
+	clk_dqs_drv_impedance = ((dmc.dmc_zqctl0_value) &
+		BITM_DMC_DDR_ZQ_CTL0_IMPWRDQ) >> BITP_DMC_DDR_ZQ_CTL0_IMPWRDQ;
+	ro_dt = ((dmc.dmc_zqctl0_value) & BITM_DMC_DDR_ZQ_CTL0_IMPRTT) >>
+		BITP_DMC_DDR_ZQ_CTL0_IMPRTT;
+	drv_pu = stat_value & 0x0000003Fu;
+	drv_pd = (stat_value >> 12) & 0x0000003Fu;
+	odt_pu = (drv_pu * clk_dqs_drv_impedance) / ro_dt;
+	odt_pd = (drv_pd * clk_dqs_drv_impedance) / ro_dt;
+	temp = ((1uL << 24)                   |
+	       ((drv_pd & 0x0000003Fu))       |
+	       ((odt_pd & 0x0000003Fu) << 6)  |
+	       ((drv_pu & 0x0000003Fu) << 12) |
+	       ((odt_pu & 0x0000003Fu) << 18));
+	temp |= readl(dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(temp, dmc.reg + REG_DMC_DDR_SCRATCH_2);
+	writel(0x0C010000u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x08000002u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+	writel(0u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	writel(0x04010000u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x80000002u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(2500u);
+	writel(0u, dmc.reg + REG_DMC_DDR_CA_CTL);
+	writel(0u, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+#endif
+}
+
+static inline void adi_dmc_lane_reset(bool reset, uint32_t dmc_no)
+{
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	u32 temp;
+	phys_addr_t base = (dmc_no == 0) ? REG_DMC0_BASE : REG_DMC1_BASE;
+	phys_addr_t ln0 = base + REG_DMC_DDR_LANE0_CTL0;
+	phys_addr_t ln1 = base + REG_DMC_DDR_LANE1_CTL0;
+
+	if (reset) {
+		temp = readl(ln0);
+		temp |= BITM_DMC_DDR_LANE0_CTL0_CB_RSTDLL;
+		writel(temp, ln0);
+
+		temp = readl(ln1);
+		temp |= BITM_DMC_DDR_LANE1_CTL0_CB_RSTDLL;
+		writel(temp, ln1);
+	} else {
+		temp = readl(ln0);
+		temp &= ~BITM_DMC_DDR_LANE0_CTL0_CB_RSTDLL;
+		writel(temp, ln0);
+
+		temp = readl(ln1);
+		temp &= ~BITM_DMC_DDR_LANE1_CTL0_CB_RSTDLL;
+		writel(temp, ln1);
+	}
+	dmcdelay(9000u);
+#endif
+}
+
+void adi_dmc_reset_lanes(bool reset)
+{
+	if (!IS_ENABLED(CONFIG_ADI_USE_DDR2)) {
+		if (IS_ENABLED(CONFIG_SC59X) || IS_ENABLED(CONFIG_SC59X_64)) {
+			if (IS_ENABLED(CONFIG_ADI_USE_DMC0))
+				adi_dmc_lane_reset(reset, 0);
+			if (IS_ENABLED(CONFIG_ADI_USE_DMC1))
+				adi_dmc_lane_reset(reset, 1);
+		}
+		else {
+			u32 temp = reset ? 0x800 : 0x0;
+
+			if (IS_ENABLED(CONFIG_ADI_USE_DMC0))
+				writel(temp, REG_DMC0_BASE + REG_DMC_PHY_CTL0);
+			if (IS_ENABLED(CONFIG_ADI_USE_DMC1))
+				writel(temp, REG_DMC1_BASE + REG_DMC_PHY_CTL0);
+		}
+	}
+}
+
+static inline void dmc_controller_init(void)
+{
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	u32 phyphase, rd_cnt, t_EMR1, t_EMR3, t_CTL, data_cyc, temp;
+#endif
+
+	/* 1. Program the DMC controller registers: DMCx_CFG, DMCx_TR0,
+	 * DMCx_TR1, DMCx_TR2, DMCx_MR(DDR2/LPDDR)/DMCx_MR0(DDR3),
+	 * DMCx_EMR1(DDR2)/DMCx_MR1(DDR3),
+	 * DMCx_EMR2(DDR2)/DMCx_EMR(LPDDR)/DMCx_MR2(DDR3)
+	 */
+	writel(dmc.dmc_cfg_value, dmc.reg + REG_DMC_CFG);
+	writel(dmc.dmc_tr0_value, dmc.reg + REG_DMC_TR0);
+	writel(dmc.dmc_tr1_value, dmc.reg + REG_DMC_TR1);
+	writel(dmc.dmc_tr2_value, dmc.reg + REG_DMC_TR2);
+	writel(dmc.dmc_mr0_value, dmc.reg + REG_DMC_MR);
+	writel(dmc.dmc_mr1_value, dmc.reg + REG_DMC_EMR1);
+	writel(dmc.dmc_mr2_value, dmc.reg + REG_DMC_EMR2);
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	writel(dmc.dmc_mr3_value, dmc.reg + REG_DMC_EMR3);
+	writel(dmc.dmc_dllctl_value, dmc.reg + REG_DMC_DLLCTL);
+	dmcdelay(2000u);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_CA_CTL);
+	temp |= BITM_DMC_DDR_CA_CTL_SW_REFRESH;
+	writel(temp, dmc.reg + REG_DMC_DDR_CA_CTL);
+	dmcdelay(5u);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	temp |= BITM_DMC_DDR_ROOT_CTL_SW_REFRESH |
+		(DMC_OFSTDCYCLE << BITP_DMC_DDR_ROOT_CTL_PIPE_OFSTDCYCLE);
+	writel(temp, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+#endif
+
+	/* 2. Make sure that the REG_DMC_DT_CALIB_ADDR register is programmed
+	 * to an unused DMC location corresponding to a burst of 16 bytes
+	 * (by default it is the starting address of the DMC address range).
+	 */
+#ifndef CONFIG_SC59X
+	writel(dmc.dmc_data_calib_add_value, dmc.reg + REG_DMC_DT_CALIB_ADDR);
+#endif
+	/* 3. Program the DMCx_CTL register with INIT bit set to start
+	 * the DMC initialization sequence
+	 */
+	writel(dmc.dmc_ctl_value, dmc.reg + REG_DMC_CTL);
+	/* 4. Wait for the DMC initialization to complete by polling
+	 * DMCx_STAT.INITDONE bit.
+	 */
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	dmcdelay(722000u);
+
+	/* Add necessary delay depending on the configuration */
+	t_EMR1 = (dmc.dmc_mr1_value & BITM_DMC_MR1_WL) >> BITP_DMC_MR1_WL;
+
+	dmcdelay(600u);
+	if (t_EMR1 != 0u)
+		while ((readl(dmc.reg + REG_DMC_EMR1) & BITM_DMC_MR1_WL) != 0)
+			;
+
+	t_EMR3 = (dmc.dmc_mr3_value & BITM_DMC_EMR3_MPR) >>
+		 BITP_DMC_EMR3_MPR;
+	dmcdelay(2000u);
+	if (t_EMR3 != 0u)
+		while ((readl(dmc.reg + REG_DMC_EMR3) & BITM_DMC_EMR3_MPR) != 0)
+			;
+
+	t_CTL = (dmc.dmc_ctl_value & BITM_DMC_CTL_RL_DQS) >> BITP_DMC_CTL_RL_DQS;
+	dmcdelay(600u);
+	if (t_CTL != 0u)
+		while ((readl(dmc.reg + REG_DMC_CTL) & BITM_DMC_CTL_RL_DQS) != 0)
+			;
+#endif
+
+	/* check if DMC initialization finished*/
+	while ((readl(dmc.reg + REG_DMC_STAT) & BITM_DMC_STAT_INITDONE) == 0)
+		;
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	/* toggle DCYCLE */
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	temp |= BITM_DMC_DDR_LANE0_CTL1_COMP_DCYCLE;
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	temp |= BITM_DMC_DDR_LANE1_CTL1_COMP_DCYCLE;
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+
+	dmcdelay(10u);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	temp &= (~BITM_DMC_DDR_LANE0_CTL1_COMP_DCYCLE);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	temp &= (~BITM_DMC_DDR_LANE1_CTL1_COMP_DCYCLE);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+
+	/* toggle RSTDAT */
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+	temp |= BITM_DMC_DDR_LANE0_CTL0_CB_RSTDAT;
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+	temp &= (~BITM_DMC_DDR_LANE0_CTL0_CB_RSTDAT);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+	temp |= BITM_DMC_DDR_LANE1_CTL0_CB_RSTDAT;
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+	temp &= (~BITM_DMC_DDR_LANE1_CTL0_CB_RSTDAT);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+
+	dmcdelay(2500u);
+
+	/* Program phyphase*/
+	phyphase = (readl(dmc.reg + REG_DMC_STAT) &
+		   BITM_DMC_STAT_PHYRDPHASE) >> BITP_DMC_STAT_PHYRDPHASE;
+	data_cyc = (phyphase << BITP_DMC_DLLCTL_DATACYC) &
+		   BITM_DMC_DLLCTL_DATACYC;
+	rd_cnt = dmc.dmc_dllctl_value;
+	rd_cnt <<= BITP_DMC_DLLCTL_DLLCALRDCNT;
+	rd_cnt &= BITM_DMC_DLLCTL_DLLCALRDCNT;
+	writel(rd_cnt | data_cyc, dmc.reg + REG_DMC_DLLCTL);
+	writel((dmc.dmc_ctl_value & (~BITM_DMC_CTL_INIT) &
+	       (~BITM_DMC_CTL_RL_DQS)), dmc.reg + REG_DMC_CTL);
+
+#if DELAYTRIM
+	/* DQS delay trim*/
+	u32 stat_value, WL_code_LDQS, WL_code_UDQS;
+
+	/* For LDQS */
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1) | (0x000000D0);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	dmcdelay(2500u);
+	writel(0x00400000, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x0, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	stat_value = (readl(dmc.reg + REG_DMC_DDR_SCRATCH_STAT0) &
+		     (0xFFFF0000)) >> 16;
+	WL_code_LDQS = (stat_value) & (0x0000001F);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	temp &= ~(BITM_DMC_DDR_LANE0_CTL1_BYPCODE |
+		  BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+
+	/* If write leveling is enabled */
+	if ((dmc.dmc_mr1_value & BITM_DMC_MR1_WL) >> BITP_DMC_MR1_WL) {
+		temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+		temp |= (((WL_code_LDQS + LANE0_DQS_DELAY) <<
+			   BITP_DMC_DDR_LANE0_CTL1_BYPCODE) &
+			    BITM_DMC_DDR_LANE0_CTL1_BYPCODE) |
+			     BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN;
+		writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	} else {
+		temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+		temp |= (((DQS_DEFAULT_DELAY + LANE0_DQS_DELAY) <<
+			   BITP_DMC_DDR_LANE0_CTL1_BYPCODE) &
+			    BITM_DMC_DDR_LANE0_CTL1_BYPCODE) |
+			     BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN;
+		writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL1);
+	}
+	dmcdelay(2500u);
+
+	/* For UDQS */
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1) | (0x000000D0);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	dmcdelay(2500u);
+	writel(0x00800000, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	dmcdelay(2500u);
+	writel(0x0, dmc.reg + REG_DMC_DDR_ROOT_CTL);
+	stat_value = (readl(dmc.reg + REG_DMC_DDR_SCRATCH_STAT1) &
+		     (0xFFFF0000)) >> 16;
+	WL_code_UDQS = (stat_value) & (0x0000001F);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	temp &= ~(BITM_DMC_DDR_LANE0_CTL1_BYPCODE |
+		BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+
+	/* If write leveling is enabled */
+	if ((dmc.dmc_mr1_value & BITM_DMC_MR1_WL) >> BITP_DMC_MR1_WL) {
+		temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+		temp |= (((WL_code_UDQS + LANE1_DQS_DELAY) <<
+			   BITP_DMC_DDR_LANE0_CTL1_BYPCODE) &
+			    BITM_DMC_DDR_LANE0_CTL1_BYPCODE) |
+			     BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN;
+		writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	} else {
+		temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+		temp |= (((DQS_DEFAULT_DELAY + LANE1_DQS_DELAY) <<
+			   BITP_DMC_DDR_LANE0_CTL1_BYPCODE) &
+			    BITM_DMC_DDR_LANE0_CTL1_BYPCODE) |
+			     BITM_DMC_DDR_LANE0_CTL1_BYPDELCHAINEN;
+		writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL1);
+	}
+	dmcdelay(2500u);
+#endif
+
+#else
+	/* 5. Program the DMCx_CTL.DLLCTL register with 0x948 value
+	 * (DATACYC=9,    DLLCALRDCNT=72).
+	 */
+	writel(0x00000948, dmc.reg + REG_DMC_DLLCTL);
+#endif
+
+	/* 6. Workaround for anomaly#20000037 */
+	if (dmc.anomaly_20000037_applicable) {
+		/* Perform dummy read to any DMC location */
+		readl(0x80000000);
+
+		writel(readl(dmc.reg + REG_DMC_PHY_CTL0) | 0x1000,
+		       dmc.reg + REG_DMC_PHY_CTL0);
+		/* Clear DMCx_PHY_CTL0.RESETDAT bit */
+		writel(readl(dmc.reg + REG_DMC_PHY_CTL0) & (~0x1000),
+		       dmc.reg + REG_DMC_PHY_CTL0);
+	}
+}
+
+static inline void dmc_init(void)
+{
+	/* PHY Calibration+Initialization */
+	if (!dmc.phy_init_required)
+		goto out;
+
+	switch (dmc.calib_mode) {
+	case CALIBRATION_LEGACY:
+		calibration_legacy();
+		break;
+	case CALIBRATION_METHOD1:
+		calibration_method1();
+		break;
+	case CALIBRATION_METHOD2:
+		calibration_method2();
+		break;
+	}
+
+#if DQSTRIM
+	/* DQS duty trim */
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+	temp |= ((DQSCODE) << BITP_DMC_DDR_LANE0_CTL0_BYPENB) &
+		 (BITM_DMC_DDR_LANE1_CTL0_BYPENB |
+		  BITM_DMC_DDR_LANE0_CTL0_BYPSELP |
+		  BITM_DMC_DDR_LANE0_CTL0_BYPCODE);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE0_CTL0);
+
+	temp = readl(dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+	temp |= ((DQSCODE) << BITP_DMC_DDR_LANE1_CTL0_BYPENB) &
+		 (BITM_DMC_DDR_LANE1_CTL1_BYPCODE |
+		  BITM_DMC_DDR_LANE1_CTL0_BYPSELP |
+		  BITM_DMC_DDR_LANE1_CTL0_BYPCODE);
+	writel(temp, dmc.reg + REG_DMC_DDR_LANE1_CTL0);
+#endif
+
+#if CLKTRIM
+	/* Clock duty trim */
+	temp = readl(dmc.reg + REG_DMC_DDR_CA_CTL);
+	temp |= (((CLKCODE << BITP_DMC_DDR_CA_CTL_BYPCODE1) &
+		   BITM_DMC_DDR_CA_CTL_BYPCODE1) |
+		 BITM_DMC_DDR_CA_CTL_BYPENB |
+		 ((CLKDIR << BITP_DMC_DDR_CA_CTL_BYPSELP) &
+		  BITM_DMC_DDR_CA_CTL_BYPSELP));
+	writel(temp, dmc.reg + REG_DMC_DDR_CA_CTL);
+#endif
+
+out:
+	/* Controller Initialization */
+	dmc_controller_init();
+}
+
+static inline void __dmc_config(uint32_t dmc_no)
+{
+	if (dmc_no == 0) {
+		dmc.reg = REG_DMC0_BASE;
+		dmc.dmc_data_calib_add_value = DMC0_DATA_CALIB_ADD;
+	} else if (dmc_no == 1) {
+		dmc.reg = REG_DMC1_BASE;
+		dmc.dmc_data_calib_add_value = DMC1_DATA_CALIB_ADD;
+	} else {
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_ADI_USE_DDR2))
+		dmc.ddr_mode = DDR2_MODE;
+	else
+		dmc.ddr_mode = DDR3_MODE;
+
+	dmc.phy_init_required = true;
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	dmc.anomaly_20000037_applicable = false;
+	dmc.dmc_dllctl_value = DMC_DLLCTL_VALUE;
+	dmc.calib_mode = CALIBRATION_METHOD2;
+#else
+	dmc.anomaly_20000037_applicable = true;
+	dmc.calib_mode = CALIBRATION_LEGACY;
+#endif
+
+	dmc.dmc_ctl_value = DMC_CTL_VALUE;
+	dmc.dmc_cfg_value = DMC_CFG_VALUE;
+	dmc.dmc_tr0_value = DMC_TR0_VALUE;
+	dmc.dmc_tr1_value = DMC_TR1_VALUE;
+	dmc.dmc_tr2_value = DMC_TR2_VALUE;
+	dmc.dmc_mr0_value = DMC_MR0_VALUE;
+	dmc.dmc_mr1_value = DMC_MR1_VALUE;
+	dmc.dmc_mr2_value = DMC_MR2_VALUE;
+
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	dmc.dmc_mr3_value = DMC_MR3_VALUE;
+	dmc.dmc_zqctl0_value = DMC_ZQCTL0_VALUE;
+	dmc.dmc_zqctl1_value = DMC_ZQCTL1_VALUE;
+	dmc.dmc_zqctl2_value = DMC_ZQCTL2_VALUE;
+#endif
+
+	dmc.padctl2_value = DMC_PADCTL2_VALUE;
+	dmc.dmc_cphyctl_value = DMC_CPHYCTL_VALUE;
+
+	/* Initialize DMC now */
+	dmc_init();
+}
+
+void DMC_Config(void)
+{
+	if (IS_ENABLED(CONFIG_ADI_USE_DMC0))
+		__dmc_config(0);
+
+	if (IS_ENABLED(CONFIG_ADI_USE_DMC1))
+		__dmc_config(1);
+}
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.h b/arch/arm/mach-sc5xx/init/dmcinit.h
new file mode 100644
index 0000000000..46ff729282
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/dmcinit.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef DMCINIT_H_
+#define DMCINIT_H_
+
+#include <config.h>
+
+#ifdef MEM_MT41K512M16HA
+	#include "mem/mt41k512m16ha.h"
+#elif defined(MEM_MT41K128M16JT)
+	#include "mem/mt41k128m16jt.h"
+#elif defined(MEM_MT47H128M16RT)
+	#include "mem/mt47h128m16rt.h"
+#elif defined(MEM_IS43TR16512BL)
+	#include "mem/is43tr16512bl.h"
+#else
+	#error "No DDR part name is defined for this board."
+#endif
+
+void DMC_Config(void);
+void adi_dmc_reset_lanes(bool reset);
+
+#endif
diff --git a/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h b/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
new file mode 100644
index 0000000000..a583837055
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef IS43TR16512BL_H
+#define IS43TR16512BL_H
+
+/* DMC0 setup for the EV-21593-SOM and EV-SC594-SOM :
+ * - uses a single 8GB IS43TR16512BL-125KBL DDR3 chip configured for
+ *   800 MHz DCLK.
+ * DMC0 setup for the EV-SC594-SOMS :
+ * - uses a single 4GB IS43TR16256BL-093NBL DDR3 chip configured for
+ *   800 MHz DCLK.
+ */
+#define DMC_DLLCALRDCNT                 240
+#define DMC_DATACYC                     12
+#define DMC_TRCD                        11
+#define DMC_TWTR                        6
+#define DMC_TRP                         11
+#define DMC_TRAS                        28
+#define DMC_TRC                         39
+#define DMC_TMRD                        4
+#define DMC_TREF                        6240
+#define DMC_TRRD                        6
+#define DMC_TFAW                        32
+#define DMC_TRTP                        6
+#define DMC_TWR                         12
+#define DMC_TXP                         5
+#define DMC_TCKE                        4
+#define DMC_CL0                         0
+#define DMC_CL123                       7
+#define DMC_WRRECOV                     6
+#define DMC_MR1_DLLEN                   0
+#define DMC_MR1_DIC0                    0
+#define DMC_MR1_RTT0                    0
+#define DMC_MR1_AL                      0
+#define DMC_MR1_DIC1                    0
+#define DMC_MR1_RTT1                    1
+#define DMC_MR1_WL                      0
+#define DMC_MR1_RTT2                    0
+#define DMC_MR1_TDQS                    0
+#define DMC_MR1_QOFF                    0
+#define DMC_WL                          3
+#define DMC_RDTOWR                      5
+#define DMC_CTL_AL_EN                   1
+#if defined(MEM_ISSI_4Gb_DDR3_800MHZ)
+    #define SDR_CHIP_SIZE                    (ENUM_DMC_CFG_SDRSIZE4G)
+    #define DMC_TRFC                        208ul
+#elif defined(MEM_ISSI_8Gb_DDR3_800MHZ)
+    #define SDR_CHIP_SIZE                    (ENUM_DMC_CFG_SDRSIZE8G)
+    #define DMC_TRFC                        280ul
+#else
+    #error "Need to select MEM_ISSI_4Gb_DDR3_800MHZ or MEM_ISSI_8Gb_DDR3_800MHZ"
+#endif
+
+#endif
diff --git a/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h b/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
new file mode 100644
index 0000000000..882777521b
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef MT41K128M16JT_H
+#define MT41K128M16JT_H
+
+/* Default DDR3 part assumed: MT41K128M16JT-125, 2Gb part */
+/* For DCLK= 450 MHz */
+#define DMC_DLLCALRDCNT                 72
+#define DMC_DATACYC                     9
+#define DMC_TRCD                        6
+#define DMC_TWTR                        4
+#define DMC_TRP                         6
+#define DMC_TRAS                        17
+#define DMC_TRC                         23
+#define DMC_TMRD                        4
+#define DMC_TREF                        3510
+#define DMC_TRFC                        72
+#define DMC_TRRD                        4
+#define DMC_TFAW                        17
+#define DMC_TRTP                        4
+#define DMC_TWR                         7
+#define DMC_TXP                         4
+#define DMC_TCKE                        3
+#define DMC_CL0                         0
+#define DMC_CL123                       3
+#define DMC_WRRECOV                     (DMC_TWR - 1)
+#define DMC_MR1_DLLEN                   0
+#define DMC_MR1_DIC0                    1
+#define DMC_MR1_RTT0                    1
+#define DMC_MR1_AL                      0
+#define DMC_MR1_DIC1                    0
+#define DMC_MR1_RTT1                    0
+#define DMC_MR1_WL                      0
+#define DMC_MR1_RTT2                    0
+#define DMC_MR1_TDQS                    0
+#define DMC_MR1_QOFF                    0
+#define DMC_WL                          1
+#define DMC_RDTOWR                      2
+#define DMC_CTL_AL_EN                   0
+#define SDR_CHIP_SIZE                   ENUM_DMC_CFG_SDRSIZE2G
+
+#endif
diff --git a/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h b/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
new file mode 100644
index 0000000000..5735b87871
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef MT41K512M16HA_H
+#define MT41K512M16HA_H
+
+/* Default DDR3 part assumed: MT41K512M16HA-107, 8Gb part */
+/* For DCLK= 450 MHz */
+#define DMC_DLLCALRDCNT                 72
+#define DMC_DATACYC                     9
+#define DMC_TRCD                        7
+#define DMC_TWTR                        4
+#define DMC_TRP                         7
+#define DMC_TRAS                        10
+#define DMC_TRC                         16
+#define DMC_TMRD                        4
+#define DMC_TREF                        3510
+#define DMC_TRFC                        158
+#define DMC_TRRD                        6
+#define DMC_TFAW                        16
+#define DMC_TRTP                        4
+#define DMC_TWR                         7
+#define DMC_TXP                         3
+#define DMC_TCKE                        3
+#define DMC_CL0                         0
+#define DMC_CL123                       3
+#define DMC_WRRECOV                     (DMC_TWR - 1)
+#define DMC_MR1_DLLEN                   0
+#define DMC_MR1_DIC0                    1
+#define DMC_MR1_RTT0                    1
+#define DMC_MR1_AL                      0
+#define DMC_MR1_DIC1                    0
+#define DMC_MR1_RTT1                    0
+#define DMC_MR1_WL                      0
+#define DMC_MR1_RTT2                    0
+#define DMC_MR1_TDQS                    0
+#define DMC_MR1_QOFF                    0
+#define DMC_WL                          1
+#define DMC_RDTOWR                      2
+#define DMC_CTL_AL_EN                   0
+#define SDR_CHIP_SIZE                   ENUM_DMC_CFG_SDRSIZE8G
+
+#endif
diff --git a/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h b/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
new file mode 100644
index 0000000000..5ada7f2985
--- /dev/null
+++ b/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#ifndef MT47H128M16RT_H
+#define MT47H128M16RT_H
+
+/* Default DDR2 part: MT47H128M16RT-25E XIT:C, 2 Gb part */
+/* For DCLK= 400 MHz */
+#define DMC_DLLCALRDCNT                 72
+#define DMC_DATACYC                     9
+#define DMC_TRCD                        5
+#define DMC_TWTR                        3
+#define DMC_TRP                         5
+#define DMC_TRAS                        16
+#define DMC_TRC                         22
+#define DMC_TMRD                        2
+#define DMC_TREF                        3120
+#define DMC_TRFC                        78
+#define DMC_TRRD                        4
+#define DMC_TFAW                        18
+#define DMC_TRTP                        3
+#define DMC_TWR                         6
+#define DMC_TXP                         2
+#define DMC_TCKE                        3
+#define DMC_CL                          5
+#define DMC_WRRECOV                     (DMC_TWR - 1)
+#define DMC_MR1_DLLEN                   0
+#define DMC_MR1_DIC0                    1
+#define DMC_MR1_RTT0                    1
+#define DMC_MR1_AL                      4
+#define DMC_MR1_DIC1                    0
+#define DMC_MR1_RTT1                    0
+#define DMC_MR1_WL                      0
+#define DMC_MR1_RTT2                    0
+#define DMC_MR1_TDQS                    0
+#define DMC_MR1_QOFF                    0
+#define DMC_BL                          4
+#define DMC_RDTOWR                      2
+#define DMC_CTL_AL_EN                   0
+#define SDR_CHIP_SIZE                   ENUM_DMC_CFG_SDRSIZE2G
+
+#endif
diff --git a/arch/arm/mach-sc5xx/rcu.c b/arch/arm/mach-sc5xx/rcu.c
new file mode 100644
index 0000000000..49357501a9
--- /dev/null
+++ b/arch/arm/mach-sc5xx/rcu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Ian Roberts <ian.roberts@timesys.com>
+ */
+
+#include <dm.h>
+#include <syscon.h>
+
+static const struct udevice_id adi_syscon_ids[] = {
+	{ .compatible = "adi,reset-controller" },
+	{ }
+};
+
+U_BOOT_DRIVER(syscon_sc5xx_rcu) = {
+	.name = "sc5xx_rcu",
+	.id = UCLASS_SYSCON,
+	.of_match = adi_syscon_ids,
+};
diff --git a/arch/arm/mach-sc5xx/sc57x.c b/arch/arm/mach-sc5xx/sc57x.c
new file mode 100644
index 0000000000..b0587686d7
--- /dev/null
+++ b/arch/arm/mach-sc5xx/sc57x.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/spl.h>
+
+#define REG_SPU0_SECUREC0 0x3108B980
+#define REG_PADS0_PCFG0 0x31004404
+#define REG_SPU0_SECUREP_START 0x3108BA00
+#define REG_SPU0_SECUREP_END 0x3108BD24
+
+adi_rom_boot_fn adi_rom_boot = (adi_rom_boot_fn)0x000000e1;
+
+void sc5xx_enable_rgmii(void)
+{
+	writel((readl(REG_PADS0_PCFG0) | 0xc), REG_PADS0_PCFG0);
+}
+
+void sc5xx_soc_init(void)
+{
+	sc5xx_enable_ns_sharc_access(REG_SPU0_SECUREC0);
+	sc5xx_disable_spu0(REG_SPU0_SECUREP_START, REG_SPU0_SECUREP_END);
+	sc5xx_enable_pmu();
+}
diff --git a/arch/arm/mach-sc5xx/sc58x.c b/arch/arm/mach-sc5xx/sc58x.c
new file mode 100644
index 0000000000..0f89277430
--- /dev/null
+++ b/arch/arm/mach-sc5xx/sc58x.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/spl.h>
+
+#define REG_SPU0_SECUREC0 0x3108C980
+#define REG_PADS0_PCFG0 0x31004404
+#define REG_SPU0_SECUREP_START 0x3108CA00
+#define REG_SPU0_SECUREP_END 0x3108CCF0
+
+adi_rom_boot_fn adi_rom_boot = (adi_rom_boot_fn)0x000000e1;
+
+void sc5xx_enable_rgmii(void)
+{
+	writel((readl(REG_PADS0_PCFG0) | 0xc), REG_PADS0_PCFG0);
+}
+
+void sc5xx_soc_init(void)
+{
+	sc5xx_enable_ns_sharc_access(REG_SPU0_SECUREC0);
+	sc5xx_disable_spu0(REG_SPU0_SECUREP_START, REG_SPU0_SECUREP_END);
+	sc5xx_enable_pmu();
+}
diff --git a/arch/arm/mach-sc5xx/sc59x.c b/arch/arm/mach-sc5xx/sc59x.c
new file mode 100644
index 0000000000..174c6f5c44
--- /dev/null
+++ b/arch/arm/mach-sc5xx/sc59x.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/spl.h>
+
+#define REG_SPU0_SECUREC0 0x3108B980
+#define REG_PADS0_PCFG0 0x31004604
+#define REG_SPU0_SECUREP_START 0x3108BA00
+#define REG_SPU0_SECUREP_END 0x3108BD24
+
+#define REG_SCB5_SPI2_OSPI_REMAP        0x30400000
+#define BITM_SCB5_SPI2_OSPI_REMAP_REMAP 0x00000003
+#define ENUM_SCB5_SPI2_OSPI_REMAP_OSPI0 0x00000001
+
+adi_rom_boot_fn adi_rom_boot = (adi_rom_boot_fn)0x000000e9;
+
+void sc5xx_enable_rgmii(void)
+{
+	writel((readl(REG_PADS0_PCFG0) | 0xc), REG_PADS0_PCFG0);
+}
+
+void sc59x_remap_ospi(void)
+{
+	clrsetbits_le32(REG_SCB5_SPI2_OSPI_REMAP,
+			BITM_SCB5_SPI2_OSPI_REMAP_REMAP,
+			ENUM_SCB5_SPI2_OSPI_REMAP_OSPI0);
+}
+
+void sc5xx_soc_init(void)
+{
+	sc5xx_enable_ns_sharc_access(REG_SPU0_SECUREC0);
+	sc5xx_disable_spu0(REG_SPU0_SECUREP_START, REG_SPU0_SECUREP_END);
+	sc5xx_enable_pmu();
+}
diff --git a/arch/arm/mach-sc5xx/sc59x_64.c b/arch/arm/mach-sc5xx/sc59x_64.c
new file mode 100644
index 0000000000..82537bf196
--- /dev/null
+++ b/arch/arm/mach-sc5xx/sc59x_64.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/spl.h>
+
+#define REG_TSGENWR0_CNTCR 0x310AE000
+#define REG_PADS0_PCFG0 0x31004604
+#define REG_RCU0_BCODE 0x3108C028
+
+#define REG_SPU0_SECUREP_START 0x3108BA00
+#define REG_SPU0_WP_START 0x3108B400
+#define REG_SPU0_SECUREC0 0x3108B980
+
+#define REG_SCB5_SPI2_OSPI_REMAP 0x30400000
+#define BITM_SCB5_SPI2_OSPI_REMAP_REMAP 0x00000003
+#define ENUM_SCB5_SPI2_OSPI_REMAP_OSPI0 0x00000001
+
+adi_rom_boot_fn adi_rom_boot = (adi_rom_boot_fn)0x000000e4;
+
+void sc5xx_enable_rgmii(void)
+{
+	writel((readl(REG_PADS0_PCFG0) | 0xc), REG_PADS0_PCFG0);
+
+	// Set dw for little endian operation as well
+	writel(readl(REG_PADS0_PCFG0) & ~(1 << 19), REG_PADS0_PCFG0);
+	writel(readl(REG_PADS0_PCFG0) & ~(1 << 20), REG_PADS0_PCFG0);
+}
+
+void sc59x_remap_ospi(void)
+{
+	clrsetbits_le32(REG_SCB5_SPI2_OSPI_REMAP,
+			BITM_SCB5_SPI2_OSPI_REMAP_REMAP,
+			ENUM_SCB5_SPI2_OSPI_REMAP_OSPI0);
+}
+
+/**
+ * SPU/SMPU configuration is the default for permissive access from non-secure
+ * EL1. If TFA and OPTEE are configured, they run *after* this code, as the
+ * current boot flow is SPL -> TFA -> OPTEE -> Proper -> Linux, and will
+ * be expected to configure peripheral security correctly. If they are not
+ * configured, then this permissive setting will allow Linux (which always
+ * runs in NS EL1) to control all access to these peripherals. Without it,
+ * the peripherals would simply be unavailable in a non-security build,
+ * which is not OK.
+ */
+void sc5xx_soc_init(void)
+{
+	phys_addr_t smpus[] = {
+		0x31007800, //SMPU0
+		0x31083800, //SMPU2
+		0x31084800, //SMPU3
+		0x31085800, //SMPU4
+		0x31086800, //SMPU5
+		0x31087800, //SMPU6
+		0x310A0800, //SMPU9
+		0x310A1800, //SMPU11
+		0x31012800, //SMPU12
+	};
+	size_t i;
+
+	// Enable coresight timer
+	writel(1, REG_TSGENWR0_CNTCR);
+
+	//Do not rerun preboot routine --
+	// Without this, hardware resets triggered by RCU0_CTL:SYSRST
+	// lead to a deadlock somewhere in the boot ROM
+	writel(0x200, REG_RCU0_BCODE);
+
+	/* Alter outstanding transactions property of A55*/
+	writel(0x1, 0x30643108); /* SCB6 A55 M0 Ib.fn Mod */
+	isb();
+
+	/* configure DDR prefetch behavior, per ADI */
+	writel(0x1, 0x31076000);
+
+	/* configure smart mode, per ADI */
+	writel(0x1307, 0x31076004);
+
+	// Disable SPU and SPU WP registers
+	sc5xx_disable_spu0(REG_SPU0_SECUREP_START, REG_SPU0_SECUREP_START + 4*213);
+	sc5xx_disable_spu0(REG_SPU0_WP_START, REG_SPU0_WP_START + 4*213);
+
+	/* configure smpus permissively */
+	for (i = 0; i < ARRAY_SIZE(smpus); ++i)
+		writel(0x500, smpus[i]);
+
+	sc5xx_enable_ns_sharc_access(REG_SPU0_SECUREC0);
+}
diff --git a/arch/arm/mach-sc5xx/soc.c b/arch/arm/mach-sc5xx/soc.c
new file mode 100644
index 0000000000..8f13127a66
--- /dev/null
+++ b/arch/arm/mach-sc5xx/soc.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#ifdef CONFIG_SC58X
+	#define RCU0_CTL                0x3108B000
+	#define RCU0_STAT               0x3108B004
+	#define RCU0_CRCTL              0x3108B008
+	#define RCU0_CRSTAT             0x3108B00C
+	#define RCU0_SIDIS              0x3108B010
+	#define RCU0_MSG_SET            0x3108B064
+#elif defined(CONFIG_SC57X) || defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+	#define RCU0_CTL                0x3108C000
+	#define RCU0_STAT               0x3108C004
+	#define RCU0_CRCTL              0x3108C008
+	#define RCU0_CRSTAT             0x3108C00C
+	#define RCU0_SIDIS              0x3108C01C
+	#define RCU0_MSG_SET            0x3108C070
+#else
+	#error "No SC5xx SoC CONFIG_ enabled"
+#endif
+
+#define BITP_RCU_STAT_BMODE                  8
+#define BITM_RCU_STAT_BMODE         0x00000F00
+
+#define REG_ARMPMU0_PMCR            0x31121E04
+#define REG_ARMPMU0_PMUSERENR       0x31121E08
+#define REG_ARMPMU0_PMLAR           0x31121FB0
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void reset_cpu(void)
+{
+	u32 val = readl(RCU0_CTL);
+	writel(val | 1, RCU0_CTL);
+}
+
+void enable_caches(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF))
+		dcache_enable();
+}
+
+void sc5xx_enable_ns_sharc_access(uintptr_t securec0_base)
+{
+	writel(0, securec0_base);
+	writel(0, securec0_base + 0x4);
+	writel(0, securec0_base + 0x8);
+}
+
+void sc5xx_disable_spu0(uintptr_t spu0_start, uintptr_t spu0_end)
+{
+	for (uintptr_t i = spu0_start; i <= spu0_end; i += 4)
+		writel(0, i);
+}
+
+/**
+ * PMU is only available on armv7 platforms and all share the same location
+ */
+void sc5xx_enable_pmu(void)
+{
+	if (!IS_ENABLED(CONFIG_SC59X_64)) {
+		writel(readl(REG_ARMPMU0_PMUSERENR) | 0x01, REG_ARMPMU0_PMUSERENR);
+		writel(0xc5acce55, REG_ARMPMU0_PMLAR);
+		writel(readl(REG_ARMPMU0_PMCR) | (1 << 1), REG_ARMPMU0_PMCR);
+	}
+}
+
+const char *sc5xx_get_boot_mode(u32 *bmode)
+{
+	static const char * const bmodes[] = {
+		"JTAG/BOOTROM",
+		"QSPI Master",
+		"QSPI Slave",
+		"UART",
+		"LP0 Slave",
+		"OSPI",
+#ifdef CONFIG_SC59X_64
+		"eMMC"
+#endif
+	};
+	u32 local_mode;
+
+	local_mode = (readl(RCU0_STAT) & BITM_RCU_STAT_BMODE) >> BITP_RCU_STAT_BMODE;
+
+#if CONFIG_ADI_SPL_FORCE_BMODE != 0
+	/*
+	 * In case we want to force boot sequences such as:
+	 * QSPI -> OSPI
+	 * QSPI -> eMMC
+	 * If this is not set, then we will always try to use the BMODE setting
+	 * for both stages... i.e.
+	 * QSPI -> QSPI
+	 */
+
+	// (Don't allow skipping JTAG/UART BMODE settings)
+	if (local_mode != 0 && local_mode != 3)
+		local_mode = CONFIG_ADI_SPL_FORCE_BMODE;
+#endif
+
+	*bmode = local_mode;
+
+	if (local_mode >= 0 && local_mode <= ARRAY_SIZE(bmodes))
+		return bmodes[local_mode];
+	return "unknown";
+}
+
+void print_cpu_id(void)
+{
+	if (!IS_ENABLED(CONFIG_ARM64)) {
+		u32 cpuid = 0;
+
+		__asm__ __volatile__("mrc p15, 0, %0, c0, c0, 0" : "=r"(cpuid));
+
+		printf("Detected Revision: %d.%d\n", cpuid & 0xf00000 >> 20, cpuid & 0xf);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 bmode;
+
+	printf("CPU:   ADSP %s (%s boot)\n", CONFIG_LDR_CPU, sc5xx_get_boot_mode(&bmode));
+	print_cpu_id();
+
+	return 0;
+}
+
+void fixup_dp83867_phy(struct phy_device *phydev)
+{
+	int phy_data = 0;
+
+	phy_data = phy_read(phydev, MDIO_DEVAD_NONE, 0x32);
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x32, (1 << 7) | phy_data);
+	int cfg3 = 0;
+	#define MII_DP83867_CFG3    (0x1e)
+	/*
+	 * Pin INT/PWDN on DP83867 should be configured as an Interrupt Output
+	 * instead of a Power-Down Input on ADI SC5XX boards in order to
+	 * prevent the signal interference from other peripherals during they
+	 * are running at the same time.
+	 */
+	cfg3 = phy_read(phydev, MDIO_DEVAD_NONE, MII_DP83867_CFG3);
+	cfg3 |= (1 << 7);
+	phy_write(phydev, MDIO_DEVAD_NONE, MII_DP83867_CFG3, cfg3);
+
+	// Mystery second port fixup on ezkits with two PHYs
+	if (CONFIG_DW_PORTS & 2)
+		phy_write(phydev, MDIO_DEVAD_NONE, 0x11, 3);
+
+	if (IS_ENABLED(CONFIG_ADI_BUG_EZKHW21)) {
+		phydev->advertising &= PHY_BASIC_FEATURES;
+		phydev->speed = SPEED_100;
+	}
+
+	if (phydev->drv->config)
+		phydev->drv->config(phydev);
+
+	if (IS_ENABLED(CONFIG_ADI_BUG_EZKHW21))
+		phy_write(phydev, MDIO_DEVAD_NONE, 0, 0x3100);
+}
+
+int dram_init(void)
+{
+	gd->ram_size = CFG_SYS_SDRAM_SIZE;
+	return 0;
+}
diff --git a/arch/arm/mach-sc5xx/spl.c b/arch/arm/mach-sc5xx/spl.c
new file mode 100644
index 0000000000..68e0310f5a
--- /dev/null
+++ b/arch/arm/mach-sc5xx/spl.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <spl.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/spl.h>
+#include "init/clkinit.h"
+#include "init/dmcinit.h"
+
+static bool adi_start_uboot_proper;
+
+static int adi_sf_default_bus = CONFIG_SF_DEFAULT_BUS;
+static int adi_sf_default_cs = CONFIG_SF_DEFAULT_CS;
+static int adi_sf_default_speed = CONFIG_SF_DEFAULT_SPEED;
+
+u32 bmode;
+
+int spl_start_uboot(void)
+{
+	return adi_start_uboot_proper;
+}
+
+unsigned int spl_spi_get_default_speed(void)
+{
+	return adi_sf_default_speed;
+}
+
+unsigned int spl_spi_get_default_bus(void)
+{
+	return adi_sf_default_bus;
+}
+
+unsigned int spl_spi_get_default_cs(void)
+{
+	return adi_sf_default_cs;
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	const char *bmodestring = sc5xx_get_boot_mode(&bmode);
+
+	printf("ADI Boot Mode: 0x%x (%s)\n", bmode, bmodestring);
+
+	/*
+	 * By default everything goes back to the bootrom, where we'll read table
+	 * parameters and ask for another image to be loaded
+	 */
+	spl_boot_list[0] = BOOT_DEVICE_BOOTROM;
+
+	if (bmode == 0) {
+		printf("SPL execution has completed.  Please load U-Boot Proper via JTAG");
+		while (1)
+			;
+	}
+}
+
+int32_t __weak adi_rom_boot_hook(struct ADI_ROM_BOOT_CONFIG *config, int32_t cause)
+{
+	return 0;
+}
+
+int board_return_to_bootrom(struct spl_image_info *spl_image,
+			    struct spl_boot_device *bootdev)
+{
+#if CONFIG_ADI_SPL_FORCE_BMODE != 0
+	// see above
+	if (bmode != 0 && bmode != 3)
+		bmode = CONFIG_ADI_SPL_FORCE_BMODE;
+#endif
+
+	if (bmode >= (ARRAY_SIZE(adi_rom_boot_args)))
+		bmode = 0;
+
+	adi_rom_boot((void *)adi_rom_boot_args[bmode].addr,
+		     adi_rom_boot_args[bmode].flags,
+		     0, &adi_rom_boot_hook,
+		     adi_rom_boot_args[bmode].cmd);
+	return 0;
+};
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	clks_init();
+	DMC_Config();
+	sc5xx_soc_init();
+
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed\n");
+
+	preloader_console_init();
+}
+
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
new file mode 100644
index 0000000000..d56b14f517
--- /dev/null
+++ b/include/env/adi/adi_boot.env
@@ -0,0 +1,122 @@
+/*
+ * A target board needs to set these variables for the commands below to work:
+ *
+ * - adi_stage2_offset, the location of stage2-boot.ldr on the SPI flash
+ * - adi_image_offset, location of the fitImage on the SPI flash
+ * - adi_rfs_offset, location of the RFS on the SPI flash
+ * - loadaddr, where you want to load things
+ * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
+ */
+
+#ifdef CONFIG_SC59X_64
+#define EARLY_PRINTK earlycon=adi_uart,0x31003000
+#else
+#define EARLY_PRINTK earlyprintk=serial,uart0,CONFIG_BAUDRATE
+#endif
+
+/* Config options */
+imagefile=fitImage
+ethaddr=02:80:ad:20:31:e8
+eth1addr=02:80:ad:20:31:e9
+uart_console=CONFIG_UART_CONSOLE
+#ifdef CONFIG_SC59X_64
+fdt_high=0xffffffffffffffff
+initrd_high=0xffffffffffffffff
+#else
+fdt_high=0xffffffff
+initrd_high=0xffffffff
+#endif
+
+/* Helper routines */
+init_ethernet=mii info;
+	dhcp;
+	setenv serverip ${tftpserverip}
+
+/* Args for each boot mode */
+adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
+ramargs=setenv bootargs ${adi_bootargs}
+
+addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off
+
+/* Boot modes are selectable and should be defined in the board env before including */
+#if defined(USE_NFS)
+// rootpath is set by CONFIG_ROOTPATH
+nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}${rootpath},tcp,nfsvers=3 ${adi_bootargs}
+nfsboot=run init_ethernet;
+	tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
+	run nfsargs;
+	run addip;
+	bootm ${loadaddr}
+#endif
+
+#if defined(USE_MMC)
+mmcargs=setenv bootargs root=/dev/mmcblk0p1 rw rootfstype=ext4 rootwait ${adi_bootargs}
+mmcboot=mmc rescan;
+	ext4load mmc 0:1 ${loadaddr} /boot/${imagefile};
+	run mmcargs;
+	bootm ${loadaddr}
+#endif
+
+#if defined(USE_SPI) || defined(USE_OSPI)
+spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}
+spiboot=run spiargs;
+	sf probe ${sfdev};
+	sf read ${loadaddr} ${adi_image_offset} ${imagesize};
+	bootm ${loadaddr}
+#endif
+
+#if defined(USE_OSPI)
+ospiboot=run spiboot
+#endif
+
+#if defined(USE_RAM)
+ramboot=run init_ethernet;
+	tftp ${loadaddr} ${tfpt_dir_prefix}${imagefile};
+	run ramargs;
+	bootm ${loadaddr}
+#endif
+
+/* Update commands */
+stage1file=stage1-boot.ldr
+stage2file=stage2-boot.ldr
+
+#if defined(USE_SPI) || defined(USE_OSPI)
+update_spi_uboot_stage1=tftp ${loadaddr} ${tftp_dir_prefix}${stage1file};
+	sf probe ${sfdev};
+	sf update ${loadaddr} 0x0 ${filesize}
+update_spi_uboot_stage2=tftp ${loadaddr} ${tftp_dir_prefix}${stage2file};
+	sf probe ${sfdev};
+	sf update ${loadaddr} ${adi_stage2_offset} ${filesize}
+update_spi_uboot=run update_spi_uboot_stage1;
+	run update_spi_uboot_stage2;
+update_spi_fit=tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
+	sf probe ${sfdev};
+	sf update ${loadaddr} ${adi_image_offset} ${filesize};
+	setenv imagesize ${filesize}
+update_spi_rfs=tftp ${loadaddr} ${tftp_dir_prefix}${jffs2file};
+	sf probe ${sfdev};
+	sf update ${loadaddr} ${adi_rfs_offset} ${filesize}
+
+start_update_spi=run init_ethernet;
+	run update_spi_uboot;
+	run update_spi_fit;
+	run update_spi_rfs;
+start_update_spi_uboot_only=run init_ethernet;
+	run update_spi_uboot;
+#endif
+
+#if defined(USE_SPI)
+update_spi=setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL;
+	setenv bootcmd run spiboot;
+	setenv argscmd spiargs;
+	run start_update_spi;
+	saveenv
+#endif
+
+#if defined(USE_OSPI)
+update_ospi=setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL;
+	setenv bootcmd run ospiboot;
+	setenv argscmd spiargs;
+	run start_update_spi;
+	saveenv
+#endif
-- 
2.43.2

