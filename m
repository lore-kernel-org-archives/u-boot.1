Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3557CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EB683290;
	Tue,  2 Sep 2025 11:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoIH7iCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9DE83A5C; Tue,  2 Sep 2025 07:07:46 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E37B83443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 07:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7723bf02181so1809419b3a.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756789662; x=1757394462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o7B9uBaCrr7SNjgxvU5qZD+bI79Bcq7N6HNEUQ7DaUo=;
 b=JoIH7iCwpxlfSI7k2dC1M/l72rjfxYd8Gp2qHtJVKTsCOlDS0prPhja21xktO/qh/I
 aSVAxAoO8gAt7TcA30cX2+G5iUIWL+9eQZBZJbQJJ5p51RmHzVIOR+XPZFUMPsyHCR75
 AYgpVA2DJzgfAkKWx3sbBuG8HhNqWLx4KXE6r6pGB6SOeu7er2ctgpE/KNSPnyYNY1kf
 +4x1tRuijUFiNziGo8qqguIIohXomBaX7VM0ofb5ulDftdJOWr+YeIpOwJxsiGVMsyQU
 62l1QVBMsSBSUzoR6hFbFsulmKPk7wI2/5Hre0+1AN5X1ffYFQc0EOFbrliR6Df9zRwo
 et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756789662; x=1757394462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7B9uBaCrr7SNjgxvU5qZD+bI79Bcq7N6HNEUQ7DaUo=;
 b=C0xp5vU1vIsMnSbROHuu8x6o0/ZmeqEBAC4ZE01vzSWWNefG8YJcy7RPDi7J6JCy/H
 YK1ugVaciMhDk3jbCm46Yzz8i5Neo/+lkU82FX96zBzvG9VrXsFrTMRfcMVtEfYztqeH
 WzSUnh1GQPv9dgYOmqebEKBjODRMiAL2UdTWhL5LqbqUhsw58CWkQA6cjQM+q1qC++2C
 m5KUPxnVvPBoDDokeKEjDd4ngL6NJ/tLzE9FPGzzP0+buioh9hZP5U0BkiBrlC3LVSbE
 WT6XfYIhk8TfMzKRMBtMkOhGfD8kvF4IlmyRf+xqsSwpCV1s+TtM0e+YQ6krmuV6RNSQ
 OnBQ==
X-Gm-Message-State: AOJu0YwRyqEARLfxeqADTabW081HKwlwzons4qAmqhJVM1V7XjS8TXet
 bVlW+kOGDlAGc8x45Ibjc7lJzXZmqygs9VWbgDKWq3XR6Jr8/PVIKehVfuD+lw==
X-Gm-Gg: ASbGnctoFKVRPvIV+t4aAwKC93XLKofodWbLnVmkRPl2IL2G2P59eU4rg2UM0i47Cwt
 eKznp3czWtA+ap+Pz9GIzNrbwsZva4GxY4FtqSMZyJm3muJFtW3b1mT8f7YLJ5RB8T83Iu3WYbP
 3lXOOASRdAI73GqDks03mb4TvDNlTwdCOBO+Y0AFYfVGIn9WcyeeLKIsTVqYvfUwlazIoy0C/9n
 RvFi7A09iSysPj0E2JhqWb2BDbahytkimc/uHQGG66v2AAb59vSdDi3S/jypYvE0yFXra//mEW+
 2hthHDxzO2IJBT1Y4u3teXtRQb173/fmsXChy6sXI921gPPcXj7g3qohaCjicIvslR3xzbK3LZg
 U0mU4dSCMjX7MaZiCt9T05JDdwoMhKneJpPhuhiOSl8LJoO284Be+bXpynzjKPHu8OF9KfDFrEK
 2YuhECFFR4zw==
X-Google-Smtp-Source: AGHT+IH6y6+BHfgVdCT/b5OlMyOUC3Pu4hZR+gvjfW2mzGmiEBzQZaszWHMWm4k8Wxl/udhRRpgqBQ==
X-Received: by 2002:a05:6a00:1a87:b0:772:114c:bcbb with SMTP id
 d2e1a72fcca58-7723e1f1804mr14769895b3a.4.1756789662195; 
 Mon, 01 Sep 2025 22:07:42 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.220.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a501a94sm12248012b3a.93.2025.09.01.22.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 22:07:41 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] doc: add README.pmic guide for PMIC/regulator framework
Date: Tue,  2 Sep 2025 10:37:18 +0530
Message-ID: <20250902050730.5289-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:12:53 +0200
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

This document introduces a developer guide for PMIC and regulator
support in U-Boot. It covers subsystem architecture, Kconfig options,
Device Tree integration, SPL considerations, and debugging methods,
using TPS65219 + BeaglePlay as an example.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 doc/README.pmic | 345 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 345 insertions(+)
 create mode 100644 doc/README.pmic

diff --git a/doc/README.pmic b/doc/README.pmic
new file mode 100644
index 00000000000..f7c7ef629b9
--- /dev/null
+++ b/doc/README.pmic
@@ -0,0 +1,345 @@
+# U‑Boot PMIC & Regulator Mini‑Guide (README.pmic)
+
+> A concise, practical guide to understanding and extending PMIC + regulator support in U‑Boot. Target audience: BSP/Board bring‑up engineers.
+
+---
+
+## 0) TL;DR
+
+* **Code paths:** `drivers/power/pmic/` (PMIC bus + register access) and `drivers/power/regulator/` (voltage rails).
+* **Device Tree:** Describe PMIC node (I²C/SPI), child regulator nodes with `regulator-` properties.
+* **Kconfig:** Enable the PMIC driver (e.g., `CONFIG_PMIC_TPS65219`) and the regulator framework (`CONFIG_DM_REGULATOR*`).
+* **SPL vs U‑Boot proper:** Decide where rails must be on (e.g., for DDR/IP). Mirror minimal regulator config in SPL (size‑conscious).
+* **Debug:** Use `i2c dev`, `i2c md`, regulator debug prints, and `log level`.
+
+---
+
+## 1) Architecture Overview
+
+### 1.1 Subsystems
+
+* **PMIC layer (`drivers/power/pmic/`)**
+
+  * Abstracts low‑level register operations on a given chip (read/write, init, IRQ masks, sequencing registers, etc.).
+  * Typically binds to an **I²C** or **SPI** bus via a devicetree node.
+* **Regulator layer (`drivers/power/regulator/`)**
+
+  * Presents each rail (BUCK/SMPS, LDO, switch) as a `regulator` device.
+  * Methods: `enable/disable`, `set_value/get_value` (µV), `set_current` (µA), `get_status`.
+* **Consumers**
+
+  * Other drivers (MMC, USB, PHY, PCIe, camera, etc.) request rails via phandles or use fixed supplies.
+
+### 1.2 Typical Call Flow
+
+U‑Boot start → dm_init → ofnode parse PMIC → PMIC probe → create regulator children
+→ Early/SPL: board code sets essential rails (DDR, core) → Later: drivers request rails as needed
+
+---
+
+## 2) Kconfig & Build
+
+Enable core frameworks:
+
+CONFIG_DM=y
+CONFIG_DM_I2C=y               # or DM_SPI for SPI PMICs
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_UCLASS=y
+CONFIG_SPL_DM=y               # if using SPL with DM
+CONFIG_SPL_DM_REGULATOR=y
+
+Enable a specific PMIC (example, TI TPS65219):
+
+CONFIG_PMIC_TPS65219=y
+CONFIG_DM_REGULATOR_TPS65219=y   # if split, or enable generic DM_REGULATOR helpers
+
+Optional helpers:
+
+CONFIG_CMD_I2C=y
+CONFIG_CMD_REGULATOR=y            # if available on your tree
+CONFIG_LOG=y
+CONFIG_LOGLEVEL=6                 # verbose logs
+
+---
+
+## 3) Device Tree Basics
+
+### 3.1 PMIC Node (I²C example)
+
+&i2c0 {
+    status = "okay";
+    pmic: tps65219@24 {
+        compatible = "ti,tps65219";
+        reg = <0x24>;                  // I²C address
+        /* Optional: IRQ, GPIOs, power‑on config */
+        interrupt-parent = <&gpio1>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+
+        /* Child regulators */
+        buck1: buck1 {
+            regulator-name = "vdd_core";
+            regulator-min-microvolt = <700000>;
+            regulator-max-microvolt = <1100000>;
+            regulator-always-on;
+            regulator-boot-on;
+        };
+
+        buck2: buck2 {
+            regulator-name = "vdd_ddr";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-boot-on;
+        };
+
+        ldo1: ldo1 {
+            regulator-name = "vdda_pll";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-allow-bypass;
+        };
+    };
+};
+
+### 3.2 Consumers referencing regulators
+
+&mmc1 {
+    vmmc-supply = <&buck2>;      // card supply
+    vqmmc-supply = <&ldo1>;      // IO voltage
+};
+
+&usbss0 {
+    vbus-supply = <&buck1>;
+};
+
+**Notes**
+
+* Use chip‑specific child node names if the driver expects them (some drivers match by `regulator-name` or by order/index).
+* `regulator-boot-on` ensures the framework enables the rail during init if safe.
+* For **fixed rails** not controlled by PMIC, use `regulator-fixed` nodes under `fixedregulator@…` in DTS.
+
+---
+
+## 4) Adding/Porting a PMIC Driver
+
+### 4.1 Skeleton (PMIC layer)
+
+// drivers/power/pmic/pmic_foo.c
+#include <dm.h>
+#include <power/pmic.h>
+#include <i2c.h>
+
+struct foo_priv { struct udevice *dev; /* cached addr, etc. */ };
+
+static int foo_read(struct udevice *dev, uint reg, u8 *val)
+{ return dm_i2c_read(dev, reg, val, 1); }
+
+static int foo_write(struct udevice *dev, uint reg, const u8 *val)
+{ return dm_i2c_write(dev, reg, *val, 1); }
+
+static int foo_probe(struct udevice *dev)
+{
+    // Optionally: unlock, set default pages, mask IRQs, sanity checks
+    return 0;
+}
+
+static const struct udevice_id foo_ids[] = {
+    { .compatible = "vendor,foo1234" },
+    { }
+};
+
+U_BOOT_DRIVER(pmic_foo) = {
+    .name = "pmic_foo",
+    .id = UCLASS_PMIC,
+    .of_match = foo_ids,
+    .probe = foo_probe,
+};
+```
+
+### 4.2 Per‑regulator ops (Regulator layer)
+
+// drivers/power/regulator/foo_reg.c
+#include <dm.h>
+#include <power/regulator.h>
+
+static int foo_reg_enable(struct udevice *dev, bool enable)
+{ /* read reg; set/clear enable bit; write back */ return 0; }
+
+static int foo_reg_set_value(struct udevice *dev, int uV)
+{ /* map uV → selector → register field */ return 0; }
+
+static const struct dm_regulator_ops foo_reg_ops = {
+    .enable = foo_reg_enable,
+    .set_value = foo_reg_set_value,
+    .get_value = dm_regulator_common_get_value, // or custom
+};
+
+U_BOOT_DRIVER(foo_buck) = {
+    .name = "foo_buck",
+    .id = UCLASS_REGULATOR,
+    .ops = &foo_reg_ops,
+    .of_match = foo_buck_ids,
+};
+
+### 4.3 Kconfig/Makefile
+
+config PMIC_FOO
+    bool "PMIC Foo1234 support"
+    depends on DM_I2C && DM_REGULATOR
+
+obj-$(CONFIG_PMIC_FOO) += pmic_foo.o
+obj-$(CONFIG_PMIC_FOO) += foo_reg.o
+
+---
+
+## 5) SPL Considerations
+
+* **Goal:** Bring up only the rails required for DDR init, boot storage (eMMC/SD), and console.
+* Enable minimal configs: `CONFIG_SPL_DM_REGULATOR`, `CONFIG_SPL_I2C`, `CONFIG_SPL_OF_CONTROL`.
+* **Shrink tips:**
+
+  * Avoid complex features (interrupts/OTPs) in SPL unless mandatory.
+  * Hard‑code essential voltage selectors if DT parsing in SPL is too heavy; keep U‑Boot proper fully DT‑driven.
+* **Mirroring:** Ensure voltages set in SPL match what Linux expects later (handoff harmony).
+
+---
+
+## 6) Runtime Control & Sequencing
+
+* **Power‑on sequence:** Many PMICs have programmable sequences (buck → ldo delays). U‑Boot typically leaves factory OTP; use minimal tweaks only if required by board.
+* **Regulator constraints:** Honour `min/max µV`, `always‑on`, `boot‑on`. Error if request violates limits.
+* **DVFS:** If CPU frequency scaling at early boot is needed, expose a CPU rail regulator and provide OPP‑safe transitions.
+
+---
+
+## 7) Debugging Playbook
+
+1. **Confirm bus & probe**
+
+```sh
+=> i2c bus          # list buses
+=> i2c dev 0        # select bus
+=> i2c probe        # scan addresses; ensure PMIC addr shows up
+```
+
+2. **Peek registers**
+
+```sh
+=> i2c md 0x24 0x00 0x10   # dump first 16 regs (TPS65219 example)
+```
+
+3. **Regulator ops (if command present)**
+
+```sh
+=> regulator list
+=> regulator dev <n>
+=> regulator read
+=> regulator set value 1000000
+=> regulator enable
+```
+
+4. **Logs**
+
+```sh
+=> setenv loglevel 7; saveenv
+```
+
+5. **Scope & DMM**: Verify rails physically (bring up issues often are voltage/seq mismatches).
+
+**Common Pitfalls**
+
+* PMIC **variant mismatch**: OTP differs (missing rail in DTS → peripherals fail; e.g., USB not detected).
+* Wrong **I²C address** or bus number in DTS.
+* Missing `regulator-boot-on` for rails needed before their consumers probe.
+* Using `regulator-always-on` on rails that must be toggled for reset/PM suspend (stuck devices).
+* Not mirroring SPL/U‑Boot‑proper settings → surprise voltage switch later.
+
+---
+
+## 8) Example: TI TPS65219 + BeaglePlay‑like Board
+
+### 8.1 DTS (excerpt)
+
+&i2c2 {
+    status = "okay";
+    pmic: tps65219@24 {
+        compatible = "ti,tps65219";
+        reg = <0x24>;
+
+        buck1: buck1 { /* VDD_CORE */
+            regulator-name = "vdd_core";
+            regulator-min-microvolt = <700000>;
+            regulator-max-microvolt = <1100000>;
+            regulator-boot-on;
+            regulator-always-on;
+        };
+        buck2: buck2 { /* VDD_DDR */
+            regulator-name = "vdd_ddr";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-boot-on;
+        };
+        ldo1: ldo1 { /* VDDA_PLL */
+            regulator-name = "vdda_pll";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+        };
+    };
+};
+
+&dwc3_0 { vbus-supply = <&buck1>; };
+&mmc0   { vmmc-supply = <&buck2>; vqmmc-supply = <&ldo1>; };
+```
+
+### 8.2 Board code (optional guardrails)
+
+int board_init(void)
+{
+    struct udevice *reg;
+    if (!uclass_get_device_by_name(UCLASS_REGULATOR, "vdd_ddr", &reg))
+        regulator_set_value(reg, 950000);
+    return 0;
+}
+
+---
+
+## 9) Checklists
+
+### 9.1 New Board Bring‑up
+
+* [ ] PMIC bus verified (I²C/SPI, pull‑ups, address, reset line)
+* [ ] DTS PMIC node + child regulators authored
+* [ ] Rails mapped to consumers (MMC/USB/PHY/PCIe/CSI/eth)
+* [ ] SPL minimal rails configured
+* [ ] Boot to shell; validate `regulator list`
+* [ ] Measure voltages; confirm within tolerance under load
+* [ ] Exercise suspend/resume (if used) and warm reset
+
+### 9.2 New PMIC Driver
+
+* [ ] Read/write helpers done
+* [ ] ID/OTP/version readout
+* [ ] Regulator enumerate + ops (enable, set/get µV)
+* [ ] DT bindings documented (yaml in Linux style if upstreaming)
+* [ ] Kconfig/Makefile wired
+* [ ] Tested on real hardware; provide scope captures for critical rails
+
+---
+
+## 10) Upstreaming Tips
+
+* Mirror **Linux bindings** (names, properties) to ease review.
+* Keep **per‑rail tables** (selector↔µV) static‑const; avoid magic numbers.
+* Add **`dev_dbg()` breadcrumbs** for probe, set\_value, enable.
+* Provide `MAINTAINERS` entry and `doc/` note pointing here.
+
+---
+
+## 11) References & Useful Pointers
+
+* `drivers/power/pmic/` and `drivers/power/regulator/` examples in U‑Boot tree (TPS, RK8xx, MAX77xxx, PMIC for NXP, etc.)
+* Linux kernel `Documentation/devicetree/bindings/regulator/*` for property patterns.
+* Datasheet/OTP app notes for your PMIC (voltage tables, sequencing, reset behavior).
+
+---
+
+
-- 
2.43.0

