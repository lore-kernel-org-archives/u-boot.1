Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F746CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D026A88D2E;
	Fri,  6 Sep 2024 09:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="VoiQdHGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A6B88D75; Fri,  6 Sep 2024 09:23:07 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA98688D94
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso2795151e87.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607378; x=1726212178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUczQZGXpUfMIOMx62OnfKgr8XFW4oov+Xv2j3PHQUI=;
 b=VoiQdHGmoRGFfDUZO8TlwIWBPSxvv4rl4MnLQ19ReU4eNLVCY1eUrBgeEFfSPNm8nV
 RylCLxWGXpzVJXElklSU1xKzV+4naww9qBld0dBDGeDehajeaiimEgkd2ReZUKey2lWp
 c2TG8oWCIa4zqha7wims6eb/F8Yyj0IuNG07RoWrcZPSq7mzK5ZasYfu6N1G5YbwBHnc
 Vhn8Veu8TGGzbqOLvcFbPf8nAgcYjoo3XZYPTGQJXbzz26qfQ8WUrljjRi4Bne9OC0s6
 9in3o9RyMjC2pXdcZ6G5f4NSQXpHw15EIAVxtyDXGXy5IAQ0S1nEKz/D49CFct+4hXsD
 rXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607378; x=1726212178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUczQZGXpUfMIOMx62OnfKgr8XFW4oov+Xv2j3PHQUI=;
 b=XjMY29diQr4VoPEmUdUrfOIeVu3CWypZHk1F05GODMiKDBVUGKhQCNbArF+doiaTLS
 X8oEiyK+abHkzVNkP2jMmgnmzD/PNniNrp6yFgJjnkkQaqocIMRbW0gu7kHXdBBU2l9K
 cJYfi5fJbCT0qXC0o1HiWT+idGDYtfNGed3tQovTkBHjo19FsQay6zTgKW2yIYfDECey
 8RBpGySZT6d3KIpegZaGOd3GOdG71JyRAereYpK8kVNSCTTknIgRMcnPOl73uzTzDChD
 Zk5ZyTbBmavIMvaPaQgAaKzkjWHjLK439S9bk+9DyBKi4dMTvbaBPXpbcnvXsWoE+vfM
 H65w==
X-Gm-Message-State: AOJu0YxgWveOlBk44u8ckwv7/4JdNMb0fZhL99/OJ2Hgjz62A9obgYuz
 Dc/CO3bi4vzrMA3O+/V3exBY9/0Bry+Qw1lsxs/sZEqQoh7S6+UoN+njTEIdJZsoDmgK+Uc3fQ/
 d
X-Google-Smtp-Source: AGHT+IG8eAhrJNY3rtrxMuX6nkKDrD6TSmByWrYSG8fwljnHJapmHbDKkj2DRTe9evoG/lsTwsvqGw==
X-Received: by 2002:a05:6512:3e02:b0:52e:9921:6dff with SMTP id
 2adb3069b0e04-536587b54efmr1274481e87.26.1725607377667; 
 Fri, 06 Sep 2024 00:22:57 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:57 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 24/28] board: raspberrypi: Add ASL files from tianocore
Date: Fri,  6 Sep 2024 09:22:26 +0200
Message-ID: <20240906072231.2531491-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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

From: Simon Glass <sjg@chromium.org>

Add the necessary DSDT files copied from tianocore to boot the RPi4.
In addition generate a board specific SSDT to dynamically enable/disable
ACPI devices based on FDT. This is required to support the various variants
and boot options. It also allows to test the code on QEMU 9.0 without
modifications, since it doesn't emulate PCIe yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/.gitignore   |   3 +
 board/raspberrypi/rpi/Makefile     |   2 +
 board/raspberrypi/rpi/acpitables.h |  90 +++++++
 board/raspberrypi/rpi/dsdt.asl     | 290 ++++++++++++++++++++++
 board/raspberrypi/rpi/emmc.asl     | 136 +++++++++++
 board/raspberrypi/rpi/gpudevs.asl  | 372 +++++++++++++++++++++++++++++
 board/raspberrypi/rpi/pci.asl      | 177 ++++++++++++++
 board/raspberrypi/rpi/pep.asl      |  90 +++++++
 board/raspberrypi/rpi/rhpx.asl     | 195 +++++++++++++++
 board/raspberrypi/rpi/rpi.c        | 183 ++++++++++++++
 board/raspberrypi/rpi/sdhc.asl     | 111 +++++++++
 board/raspberrypi/rpi/uart.asl     | 208 ++++++++++++++++
 12 files changed, 1857 insertions(+)
 create mode 100644 board/raspberrypi/rpi/.gitignore
 create mode 100644 board/raspberrypi/rpi/acpitables.h
 create mode 100644 board/raspberrypi/rpi/dsdt.asl
 create mode 100644 board/raspberrypi/rpi/emmc.asl
 create mode 100644 board/raspberrypi/rpi/gpudevs.asl
 create mode 100644 board/raspberrypi/rpi/pci.asl
 create mode 100644 board/raspberrypi/rpi/pep.asl
 create mode 100644 board/raspberrypi/rpi/rhpx.asl
 create mode 100644 board/raspberrypi/rpi/sdhc.asl
 create mode 100644 board/raspberrypi/rpi/uart.asl

diff --git a/board/raspberrypi/rpi/.gitignore b/board/raspberrypi/rpi/.gitignore
new file mode 100644
index 0000000000..39e46ba0ae
--- /dev/null
+++ b/board/raspberrypi/rpi/.gitignore
@@ -0,0 +1,3 @@
+dsdt_generated.aml
+dsdt_generated.asl.tmp
+dsdt_generated.c
diff --git a/board/raspberrypi/rpi/Makefile b/board/raspberrypi/rpi/Makefile
index b1186cdf10..bb1b7cc630 100644
--- a/board/raspberrypi/rpi/Makefile
+++ b/board/raspberrypi/rpi/Makefile
@@ -4,3 +4,5 @@
 
 obj-y	:= rpi.o
 obj-y	+= lowlevel_init.o
+
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += dsdt_generated.o
diff --git a/board/raspberrypi/rpi/acpitables.h b/board/raspberrypi/rpi/acpitables.h
new file mode 100644
index 0000000000..3ba8f19808
--- /dev/null
+++ b/board/raspberrypi/rpi/acpitables.h
@@ -0,0 +1,90 @@
+/** @file
+ *
+ *  RPi defines for constructing ACPI tables
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *  Copyright (c) 2019, ARM Ltd. All rights reserved.
+ *  Copyright (c) 2018, Andrei Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+#ifndef __RPI_ACPITABLES_H__
+#define __RPI_ACPITABLES_H__
+
+#include <acpi/acpi_table.h>
+
+// The ASL compiler can't perform arithmetic on MEMORY32FIXED ()
+// parameters so you can't pass a constant like BASE + OFFSET.
+// We therefore define a macro that can perform arithmetic base
+// address update with an offset.
+#define MEMORY32SETBASE(BufName, MemName, VarName, Offset)       \
+    CreateDwordField (^BufName, ^MemName._BAS, VarName)          \
+    Add (BCM2836_SOC_REGISTERS, Offset, VarName)
+
+//------------------------------------------------------------------------
+// Interrupts. These are specific to each platform
+//------------------------------------------------------------------------
+#if defined(CONFIG_TARGET_RPI_3)
+#define BCM2836_V3D_BUS_INTERRUPT               0x2A
+#define BCM2836_DMA_INTERRUPT                   0x3B
+#define BCM2836_SPI1_INTERRUPT                  0x3D
+#define BCM2836_SPI2_INTERRUPT                  0x3D
+#define BCM2836_HVS_INTERRUPT                   0x41
+#define BCM2836_HDMI0_INTERRUPT                 0x48
+#define BCM2836_HDMI1_INTERRUPT                 0x49
+#define BCM2836_PV2_INTERRUPT                   0x4A
+#define BCM2836_PV0_INTERRUPT                   0x4D
+#define BCM2836_PV1_INTERRUPT                   0x4E
+#define BCM2836_MBOX_INTERRUPT                  0x61
+#define BCM2836_VCHIQ_INTERRUPT                 0x62
+#define BCM2386_GPIO_INTERRUPT0                 0x51
+#define BCM2386_GPIO_INTERRUPT1                 0x52
+#define BCM2386_GPIO_INTERRUPT2                 0x53
+#define BCM2386_GPIO_INTERRUPT3                 0x54
+#define BCM2836_I2C1_INTERRUPT                  0x55
+#define BCM2836_I2C2_INTERRUPT                  0x55
+#define BCM2836_SPI0_INTERRUPT                  0x56
+#define BCM2836_USB_INTERRUPT                   0x29
+#define BCM2836_SDHOST_INTERRUPT                0x58
+#define BCM2836_MMCHS1_INTERRUPT                0x5E
+#define BCM2836_MINI_UART_INTERRUPT             0x3D
+#define BCM2836_PL011_UART_INTERRUPT            0x59
+#elif defined(CONFIG_TARGET_RPI_4)
+#define BCM2836_V3D_BUS_INTERRUPT               0x2A
+#define BCM2836_DMA_INTERRUPT                   0x3B
+#define BCM2836_SPI1_INTERRUPT                  0x7D
+#define BCM2836_SPI2_INTERRUPT                  0x7D
+#define BCM2836_HVS_INTERRUPT                   0x41
+#define BCM2836_HDMI0_INTERRUPT                 0x48
+#define BCM2836_HDMI1_INTERRUPT                 0x49
+#define BCM2836_PV2_INTERRUPT                   0x4A
+#define BCM2836_PV0_INTERRUPT                   0x4D
+#define BCM2836_PV1_INTERRUPT                   0x4E
+#define BCM2836_MBOX_INTERRUPT                  0x41
+#define BCM2836_VCHIQ_INTERRUPT                 0x42
+#define BCM2386_GPIO_INTERRUPT0                 0x91
+#define BCM2386_GPIO_INTERRUPT1                 0x92
+#define BCM2386_GPIO_INTERRUPT2                 0x93
+#define BCM2386_GPIO_INTERRUPT3                 0x94
+#define BCM2836_I2C1_INTERRUPT                  0x95
+#define BCM2836_I2C2_INTERRUPT                  0x95
+#define BCM2836_SPI0_INTERRUPT                  0x96
+#define BCM2836_USB_INTERRUPT                   0x69
+#define BCM2836_SDHOST_INTERRUPT                0x98
+#define BCM2836_MMCHS1_INTERRUPT                0x9E
+#define BCM2836_MINI_UART_INTERRUPT             0x7D
+#define BCM2836_PL011_UART_INTERRUPT            0x99
+#define GENET_INTERRUPT0                        0xBD
+#define GENET_INTERRUPT1                        0xBE
+#define GENET_BASE_ADDRESS                      0xFD580000
+#define GENET_LENGTH                            0x10000
+#define THERM_SENSOR_BASE_ADDRESS               0xFD5d2200
+#define THERM_SENSOR_LENGTH                     0x8
+#else
+#error "Unsupported rpi module for ACPI tables"
+#endif
+
+#endif // __ACPITABLES_H__
diff --git a/board/raspberrypi/rpi/dsdt.asl b/board/raspberrypi/rpi/dsdt.asl
new file mode 100644
index 0000000000..b89c81724b
--- /dev/null
+++ b/board/raspberrypi/rpi/dsdt.asl
@@ -0,0 +1,290 @@
+/** @file
+ *
+ *  Differentiated System Definition Table (DSDT)
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *  Copyright (c) 2018-2020, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *  Copyright (c) 2021, ARM Limited. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2711.h>
+#include <asm/arch/acpi/bcm2836.h>
+#include <asm/arch/acpi/bcm2836_gpio.h>
+#include <asm/arch/acpi/bcm2836_gpu.h>
+#include <asm/arch/acpi/bcm2836_pwm.h>
+#include <asm/arch/acpi/bcm2836_sdio.h>
+#include <asm/arch/acpi/bcm2836_sdhost.h>
+
+#include "acpitables.h"
+
+#define BCM_ALT0 0x4
+#define BCM_ALT1 0x5
+#define BCM_ALT2 0x6
+#define BCM_ALT3 0x7
+#define BCM_ALT4 0x3
+#define BCM_ALT5 0x2
+
+//
+// The ASL compiler does not support argument arithmetic in functions
+// like QWordMemory (). So we need to instantiate dummy qword regions
+// that we can then update the Min, Max and Length attributes of.
+// The three macros below help accomplish this.
+//
+// QWORDMEMORYSET specifies a CPU memory range (whose base address is
+// BCM2836_SOC_REGISTERS + Offset), and QWORDBUSMEMORYSET specifies
+// a VPU memory range (whose base address is provided directly).
+//
+#define QWORDMEMORYBUF(Index)                                   \
+  QWordMemory (ResourceProducer,,                               \
+    MinFixed, MaxFixed, NonCacheable, ReadWrite,                \
+    0x0, 0x0, 0x0, 0x0, 0x1,,, RB ## Index)
+
+#define QWORDMEMORYSET(Index, Offset, Length)                   \
+  CreateQwordField (RBUF, RB ## Index._MIN, MI ## Index)        \
+  CreateQwordField (RBUF, RB ## Index._MAX, MA ## Index)        \
+  CreateQwordField (RBUF, RB ## Index._LEN, LE ## Index)        \
+  Store (Length, LE ## Index)                                   \
+  Add (BCM2836_SOC_REGISTERS, Offset, MI ## Index)              \
+  Add (MI ## Index, LE ## Index - 1, MA ## Index)
+
+#define QWORDBUSMEMORYSET(Index, Base, Length)                  \
+  CreateQwordField (RBUF, RB ## Index._MIN, MI ## Index)        \
+  CreateQwordField (RBUF, RB ## Index._MAX, MA ## Index)        \
+  CreateQwordField (RBUF, RB ## Index._LEN, LE ## Index)        \
+  Store (Base, MI ## Index)                                     \
+  Store (Length, LE ## Index)                                   \
+  Add (MI ## Index, LE ## Index - 1, MA ## Index)
+
+DefinitionBlock ("Dsdt.aml", "DSDT", 2, "RPIFDN", "RPI", 2)
+{
+  Scope (\_SB_)
+  {
+    include ("pep.asl")
+
+    Device (CPU0)
+    {
+      Name (_HID, "ACPI0007")
+      Name (_UID, 0x0)
+      Method (_STA)
+      {
+        Return (0xf)
+      }
+    }
+
+    Device (CPU1)
+    {
+      Name (_HID, "ACPI0007")
+      Name (_UID, 0x1)
+      Method (_STA)
+      {
+        Return (0xf)
+      }
+    }
+
+    Device (CPU2)
+    {
+      Name (_HID, "ACPI0007")
+      Name (_UID, 0x2)
+      Method (_STA)
+      {
+        Return (0xf)
+      }
+    }
+
+    Device (CPU3)
+    {
+      Name (_HID, "ACPI0007")
+      Name (_UID, 0x3)
+      Method (_STA)
+      {
+        Return (0xf)
+      }
+    }
+
+    //
+    // GPU device container describes the DMA translation required
+    // when a device behind the GPU wants to access Arm memory.
+    // Only the first GB can be addressed.
+    //
+    Device (GDV0)
+    {
+      Name (_HID, "ACPI0004")
+      Name (_UID, 0x1)
+      Name (_CCA, 0x0)
+
+      Method (_CRS, 0, Serialized) {
+        //
+        // Container devices with _DMA must have _CRS, meaning GDV0
+        // to provide all resources that GpuDevs.asl consume (except
+        // interrupts).
+        //
+        Name (RBUF, ResourceTemplate () {
+          QWORDMEMORYBUF(01)
+          QWORDMEMORYBUF(02)
+          QWORDMEMORYBUF(03)
+          // QWORDMEMORYBUF(04)
+          // QWORDMEMORYBUF(05)
+          QWORDMEMORYBUF(06)
+          QWORDMEMORYBUF(07)
+          QWORDMEMORYBUF(08)
+          QWORDMEMORYBUF(09)
+          QWORDMEMORYBUF(10)
+          QWORDMEMORYBUF(11)
+          QWORDMEMORYBUF(12)
+          QWORDMEMORYBUF(13)
+          QWORDMEMORYBUF(14)
+          QWORDMEMORYBUF(15)
+          // QWORDMEMORYBUF(16)
+          QWORDMEMORYBUF(17)
+          QWORDMEMORYBUF(18)
+          QWORDMEMORYBUF(19)
+          QWORDMEMORYBUF(20)
+          QWORDMEMORYBUF(21)
+          QWORDMEMORYBUF(22)
+          QWORDMEMORYBUF(23)
+          QWORDMEMORYBUF(24)
+          QWORDMEMORYBUF(25)
+        })
+
+        // USB
+        QWORDMEMORYSET(01, BCM2836_USB_OFFSET, BCM2836_USB_LENGTH)
+
+        // GPU
+        QWORDMEMORYSET(02, BCM2836_V3D_BUS_OFFSET, BCM2836_V3D_BUS_LENGTH)
+        QWORDMEMORYSET(03, BCM2836_HVS_OFFSET, BCM2836_HVS_LENGTH)
+        // QWORDMEMORYSET(04, BCM2836_PV0_OFFSET, BCM2836_PV0_LENGTH)
+        // QWORDMEMORYSET(05, BCM2836_PV1_OFFSET, BCM2836_PV1_LENGTH)
+        QWORDMEMORYSET(06, BCM2836_PV2_OFFSET, BCM2836_PV2_LENGTH)
+        QWORDMEMORYSET(07, BCM2836_HDMI0_OFFSET, BCM2836_HDMI0_LENGTH)
+        QWORDMEMORYSET(08, BCM2836_HDMI1_OFFSET, BCM2836_HDMI1_LENGTH)
+
+        // Mailbox
+        QWORDMEMORYSET(09, BCM2836_MBOX_OFFSET, BCM2836_MBOX_LENGTH)
+
+        // VCHIQ
+        QWORDMEMORYSET(10, BCM2836_VCHIQ_OFFSET, BCM2836_VCHIQ_LENGTH)
+
+        // GPIO
+        QWORDMEMORYSET(11, GPIO_OFFSET, GPIO_LENGTH)
+
+        // I2C
+        QWORDMEMORYSET(12, BCM2836_I2C1_OFFSET, BCM2836_I2C1_LENGTH)
+        QWORDMEMORYSET(13, BCM2836_I2C2_OFFSET, BCM2836_I2C2_LENGTH)
+
+        // SPI
+        QWORDMEMORYSET(14, BCM2836_SPI0_OFFSET, BCM2836_SPI0_LENGTH)
+        QWORDMEMORYSET(15, BCM2836_SPI1_OFFSET, BCM2836_SPI1_LENGTH)
+        // QWORDMEMORYSET(16, BCM2836_SPI2_OFFSET, BCM2836_SPI2_LENGTH)
+
+        // PWM
+        QWORDMEMORYSET(17, BCM2836_PWM_DMA_OFFSET, BCM2836_PWM_DMA_LENGTH)
+        QWORDMEMORYSET(18, BCM2836_PWM_CTRL_OFFSET, BCM2836_PWM_CTRL_LENGTH)
+        QWORDBUSMEMORYSET(19, BCM2836_PWM_BUS_BASE_ADDRESS, BCM2836_PWM_BUS_LENGTH)
+        QWORDBUSMEMORYSET(20, BCM2836_PWM_CTRL_UNCACHED_BASE_ADDRESS, BCM2836_PWM_CTRL_UNCACHED_LENGTH)
+        QWORDMEMORYSET(21, BCM2836_PWM_CLK_OFFSET, BCM2836_PWM_CLK_LENGTH)
+
+        // UART
+        QWORDMEMORYSET(22, BCM2836_PL011_UART_OFFSET, BCM2836_PL011_UART_LENGTH)
+        QWORDMEMORYSET(23, BCM2836_MINI_UART_OFFSET, BCM2836_MINI_UART_LENGTH)
+
+        // SDC
+        QWORDMEMORYSET(24, MMCHS1_OFFSET, MMCHS1_LENGTH)
+        QWORDMEMORYSET(25, SDHOST_OFFSET, SDHOST_LENGTH)
+
+        Return (RBUF)
+      }
+
+      Name (_DMA, ResourceTemplate() {
+        //
+        // Only the first GB is available.
+        // Bus 0xC0000000 -> CPU 0x00000000.
+        //
+        QWordMemory (ResourceProducer,
+          ,
+          MinFixed,
+          MaxFixed,
+          NonCacheable,
+          ReadWrite,
+          0x0,
+          0x00000000C0000000, // MIN
+          0x00000000FFFFFFFF, // MAX
+          0xFFFFFFFF40000000, // TRA
+          0x0000000040000000, // LEN
+          ,
+          ,
+          )
+      })
+#include "gpudevs.asl"
+    }
+
+#if defined(CONFIG_TARGET_RPI_4)
+    Device (ETH0)
+    {
+      Name (_HID, "BCM6E4E")
+      Name (_CID, "BCM6E4E")
+      Name (_UID, 0x0)
+      Name (_CCA, 0x0)
+
+      Method (_CRS, 0x0, Serialized)
+      {
+        Return (ResourceTemplate ()
+        {
+          // No need for MEMORY32SETBASE on Genet as we have a straight base address constant
+          MEMORY32FIXED (ReadWrite, GENET_BASE_ADDRESS, GENET_LENGTH, )
+          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { GENET_INTERRUPT0, GENET_INTERRUPT1 }
+        })
+      }
+      Name (_DSD, Package () {
+        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+        Package () {
+          Package () { "brcm,max-dma-burst-size", 0x08 },
+          Package () { "phy-mode", "rgmii-rxid" },
+        }
+      })
+    }
+
+    // Define a simple thermal zone. The idea here is we compute the SOC temp
+    // via a register we can read, and give it to the OS. This enables basic
+    // reports from the "sensors" utility, and the OS can then poll and take
+    // actions if that temp exceeds any of the given thresholds.
+    Device (EC00)
+    {
+      Name (_HID, EISAID ("PNP0C06"))
+      Name (_CCA, 0x0)
+
+      // all temps in are tenths of K (aka 2732 is the min temps in Linux (aka 0C))
+      ThermalZone (TZ00) {
+        OperationRegion (TEMS, SystemMemory, THERM_SENSOR_BASE_ADDRESS, THERM_SENSOR_LENGTH)
+        Field (TEMS, DWordAcc, NoLock, Preserve) {
+          TMPS, 32
+        }
+        Method (_TMP, 0, Serialized) {
+          return (((410040 - ((TMPS & 0x3ff) * 487)) / 100) + 2732);
+        }
+
+        Method (_SCP, 3) { }               // receive cooling policy from OS
+
+        Method (_CRT) { Return (3632) }    // (90C) Critical temp point (immediate power-off)
+        Method (_HOT) { Return (3582) }    // (85C) HOT state where OS should hibernate
+        Method (_PSV) { Return (3532) }    // (80C) Passive cooling (CPU throttling) trip point
+
+        // SSDT inserts _AC0/_AL0 @60C here, if a FAN is configured
+
+        Name (_TZP, 10)                   //The OSPM must poll this device every 1 seconds
+        Name (_PSL, Package () { \_SB_.CPU0, \_SB_.CPU1, \_SB_.CPU2, \_SB_.CPU3 })
+      }
+    }
+#endif
+
+
+#include "uart.asl"
+#include "rhpx.asl"
+#include "sdhc.asl"
+#include "emmc.asl"
+#include "pci.asl"
+  }
+}
diff --git a/board/raspberrypi/rpi/emmc.asl b/board/raspberrypi/rpi/emmc.asl
new file mode 100644
index 0000000000..63f01362c9
--- /dev/null
+++ b/board/raspberrypi/rpi/emmc.asl
@@ -0,0 +1,136 @@
+/** @file
+ *
+ *  Copyright (c) 2021, ARM Limited. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836_sdhost.h>
+#include <asm/arch/acpi/bcm2836_sdio.h>
+#include <asm/arch/acpi/bcm2711.h>
+
+Device (GDV1) {
+  Name (_HID, "ACPI0004")
+  Name (_UID, 0x2)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, MMCHS2_LENGTH, RMEM)
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, MMCHS2_OFFSET)
+    Return (^RBUF)
+  }
+
+  // Translated DMA region for BCM2711 silicon revisions older than C0
+  Name (DMTR, ResourceTemplate() {
+    QWordMemory (ResourceProducer,
+      ,
+      MinFixed,
+      MaxFixed,
+      NonCacheable,
+      ReadWrite,
+      0x0,
+      0x00000000C0000000, // MIN
+      0x00000000FFFFFFFF, // MAX
+      0xFFFFFFFF40000000, // TRA
+      0x0000000040000000, // LEN
+      ,
+      ,
+    )
+  })
+
+  // Non translated DMA region for BCM2711 revisions C0 and newer
+  Name (DMNT, ResourceTemplate() {
+    QWordMemory (ResourceProducer,
+      ,
+      MinFixed,
+      MaxFixed,
+      NonCacheable,
+      ReadWrite,
+      0x0,
+      0x0000000000000000, // MIN
+      0x000000FFFFFFFFFF, // MAX
+      0x0000000000000000, // TRA
+      0x0000010000000000, // LEN
+      ,
+      ,
+    )
+  })
+
+  // emmc2 Host Controller. (brcm,bcm2711-emmc2)
+  Device (SDC3)
+  {
+    Name (_HID, "BRCME88C")
+    Name (_UID, 0x1)
+    Name (_CCA, 0x0)
+    Name (_S1D, 0x1)
+    Name (_S2D, 0x1)
+    Name (_S3D, 0x1)
+    Name (_S4D, 0x1)
+    Name (SDMA, 0x2)
+
+    Name (RBUF, ResourceTemplate ()
+    {
+      MEMORY32FIXED (ReadWrite, 0, MMCHS2_LENGTH, RMEM)
+      Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_MMCHS1_INTERRUPT }
+    })
+    Method (_CRS, 0x0, Serialized)
+    {
+      MEMORY32SETBASE (RBUF, RMEM, RBAS, MMCHS2_OFFSET)
+      Return (^RBUF)
+    }
+
+    // Unfortunately this controller doesn't honor the
+    // standard SDHCI voltage control registers
+    // (or at least Linux's standard code can't
+    // lower the voltage) So, UHS mode is disabled with caps
+    Name (DSD1, Package () {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+        Package () {
+          Package () { "sdhci-caps-mask", 0x0000000500080000 },
+        }
+    })
+    // Along with disabling UHS, here both SDMA and ADMA2
+    // are also disabled until the linux _DMA() mask/translate
+    // works properly.
+    Name (DSD2, Package () {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+        Package () {
+          Package () { "sdhci-caps-mask", 0x0000000504480000 },
+        }
+    })
+    Method (_DSD, 0x0, Serialized)
+    {
+      // Select one of the sdhci-caps-mask definitions
+      // depending on whether we also want to disable DMA
+      if (SDMA == 0)
+      {
+        return (^DSD2)
+      }
+      else
+      {
+        return (^DSD1)
+      }
+    }
+
+    //
+    // A child device that represents the
+    // sd card, which is marked as non-removable.
+    //
+    Device (SDMM)
+    {
+      Method (_ADR)
+      {
+        Return (0)
+      }
+      Method (_RMV) // Is removable
+      {
+        Return (0) // 0 - fixed
+      }
+    }
+  } //SDC3
+} //GDV1
diff --git a/board/raspberrypi/rpi/gpudevs.asl b/board/raspberrypi/rpi/gpudevs.asl
new file mode 100644
index 0000000000..a3077a9c3b
--- /dev/null
+++ b/board/raspberrypi/rpi/gpudevs.asl
@@ -0,0 +1,372 @@
+/** @file
+ *
+ *  [DSDT] Devices behind the GPU.
+ *
+ *  Copyright (c) 2018-2020, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+// DWC OTG Controller
+Device (USB0)
+{
+  Name (_HID, "BCM2848")
+#if defined(CONFIG_TARGET_RPI_3)
+  Name (_CID, "DWC_OTG")
+#elif defined(CONFIG_TARGET_RPI_4)
+  Name (_CID, "BCM2848")
+#endif
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+  Method (_STA)
+  {
+    Return (0xf)
+  }
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_USB_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_USB_INTERRUPT }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_USB_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// Video Core 4 GPU
+Device (GPU0)
+{
+  Name (_HID, "BCM2850")
+  Name (_CID, "BCM2850")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+  Method (_STA)
+  {
+    Return (0xf)
+  }
+  Name (RBUF, ResourceTemplate ()
+  {
+    // Memory and interrupt for the GPU
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_V3D_BUS_LENGTH, RM01)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_V3D_BUS_INTERRUPT }
+
+    // HVS - Hardware Video Scalar
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_HVS_LENGTH, RM02)
+    // The HVS interrupt is reserved by the VPU
+    // Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_HVS_INTERRUPT }
+
+    // PixelValve0 - DSI0 or DPI
+    // MEMORY32FIXED (ReadWrite, BCM2836_PV0_BASE_ADDRESS, BCM2836_PV0_LENGTH, RM03)
+    // Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_PV0_INTERRUPT }
+
+    // PixelValve1 - DS1 or SMI
+    // MEMORY32FIXED (ReadWrite, BCM2836_PV1_BASE_ADDRESS, BCM2836_PV1_LENGTH, RM04)
+    // Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_PV1_INTERRUPT }
+
+    // PixelValve2 - HDMI output - connected to HVS display FIFO 1
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_PV2_LENGTH, RM05)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_PV2_INTERRUPT }
+
+    // HDMI registers
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_HDMI0_LENGTH, RM06)
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_HDMI1_LENGTH, RM07)
+    // hdmi_int[0]
+    // Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_HDMI0_INTERRUPT }
+    // hdmi_int[1]
+    // Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_HDMI1_INTERRUPT }
+
+    // HDMI DDC connection
+    I2CSerialBus (0x50,, 100000,, "\\_SB.GDV0.I2C2",,,,)  // EDID
+    I2CSerialBus (0x30,, 100000,, "\\_SB.GDV0.I2C2",,,,)  // E-DDC Segment Pointer
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RM01, RB01, BCM2836_V3D_BUS_OFFSET)
+    MEMORY32SETBASE (RBUF, RM02, RB02, BCM2836_HVS_OFFSET)
+    MEMORY32SETBASE (RBUF, RM05, RB05, BCM2836_PV2_OFFSET)
+    MEMORY32SETBASE (RBUF, RM06, RB06, BCM2836_HDMI0_OFFSET)
+    MEMORY32SETBASE (RBUF, RM07, RB07, BCM2836_HDMI1_OFFSET)
+    Return (^RBUF)
+  }
+
+  // GPU Power Management Component Data
+  // Reference : https://github.com/Microsoft/graphics-driver-samples/wiki/Install-Driver-in-a-Windows-VM
+  Method (PMCD, 0, Serialized)
+  {
+    Name (RBUF, Package ()
+    {
+      1,                  // Version
+      1,                  // Number of graphics power components
+      Package ()          // Power components package
+      {
+        Package ()        // GPU component package
+        {
+          0,              // Component Index
+          0,              // DXGK_POWER_COMPONENT_MAPPING.ComponentType (0 = DXGK_POWER_COMPONENT_ENGINE)
+          0,              // DXGK_POWER_COMPONENT_MAPPING.NodeIndex
+
+          Buffer ()       // DXGK_POWER_RUNTIME_COMPONENT.ComponentGuid
+          {               // 9B2D1E26-1575-4747-8FC0-B9EB4BAA2D2B
+            0x26, 0x1E, 0x2D, 0x9B, 0x75, 0x15, 0x47, 0x47,
+            0x8f, 0xc0, 0xb9, 0xeb, 0x4b, 0xaa, 0x2d, 0x2b
+          },
+
+          "VC4_Engine_00",// DXGK_POWER_RUNTIME_COMPONENT.ComponentName
+          2,              // DXGK_POWER_RUNTIME_COMPONENT.StateCount
+
+          Package ()      // DXGK_POWER_RUNTIME_COMPONENT.States[] package
+          {
+            Package ()   // F0
+            {
+              0,         // DXGK_POWER_RUNTIME_STATE.TransitionLatency
+              0,         // DXGK_POWER_RUNTIME_STATE.ResidencyRequirement
+              1210000,   // DXGK_POWER_RUNTIME_STATE.NominalPower (microwatt)
+            },
+
+            Package ()   // F1 - Placeholder
+            {
+              10000,     // DXGK_POWER_RUNTIME_STATE.TransitionLatency
+              10000,     // DXGK_POWER_RUNTIME_STATE.ResidencyRequirement
+              4,         // DXGK_POWER_RUNTIME_STATE.NominalPower
+            },
+          }
+        }
+      }
+    })
+    Return (RBUF)
+  }
+}
+
+// PiQ Mailbox Driver
+Device (RPIQ)
+{
+  Name (_HID, "BCM2849")
+  Name (_CID, "BCM2849")
+  Name (_UID, 0)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_MBOX_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_MBOX_INTERRUPT }
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_MBOX_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// VCHIQ Driver
+Device (VCIQ)
+{
+  Name (_HID, "BCM2835")
+  Name (_CID, "BCM2835")
+  Name (_UID, 0)
+  Name (_CCA, 0x0)
+  Name (_DEP, Package() { \_SB.GDV0.RPIQ })
+  Method (_STA)
+  {
+    Return (0xf)
+  }
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_VCHIQ_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_VCHIQ_INTERRUPT }
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_VCHIQ_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// VC Shared Memory Driver
+Device (VCSM)
+{
+  Name (_HID, "BCM2856")
+  Name (_CID, "BCM2856")
+  Name (_UID, 0)
+  Name (_CCA, 0x0)
+  Name (_DEP, Package() { \_SB.GDV0.VCIQ })
+  Method (_STA)
+  {
+    Return (0xf)
+  }
+}
+
+// Description: GPIO
+Device (GPI0)
+{
+  Name (_HID, "BCM2845")
+  Name (_CID, "BCM2845")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, GPIO_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared)
+    {
+      BCM2386_GPIO_INTERRUPT0, BCM2386_GPIO_INTERRUPT1,
+      BCM2386_GPIO_INTERRUPT2, BCM2386_GPIO_INTERRUPT3
+    }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, GPIO_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// Description: I2C
+Device (I2C1)
+{
+  Name (_HID, "BCM2841")
+  Name (_CID, "BCM2841")
+  Name (_UID, 0x1)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_I2C1_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_I2C1_INTERRUPT }
+    PinFunction (Exclusive, PullUp, BCM_ALT0, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 2, 3 }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_I2C1_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// I2C2 is the HDMI DDC connection
+Device (I2C2)
+{
+  Name (_HID, "BCM2841")
+  Name (_CID, "BCM2841")
+  Name (_UID, 0x2)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_I2C2_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_I2C2_INTERRUPT }
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_I2C2_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// SPI
+Device (SPI0)
+{
+  Name (_HID, "BCM2838")
+  Name (_CID, "BCM2838")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_SPI0_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_SPI0_INTERRUPT }
+    PinFunction (Exclusive, PullDown, BCM_ALT0, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 9, 10, 11 } // MISO, MOSI, SCLK
+    PinFunction (Exclusive, PullUp, BCM_ALT0, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 8 } // CE0
+    PinFunction (Exclusive, PullUp, BCM_ALT0, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 7 } // CE1
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_SPI0_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+Device (SPI1)
+{
+  Name (_HID, "BCM2839")
+  Name (_CID, "BCM2839")
+  Name (_UID, 0x1)
+  Name (_CCA, 0x0)
+  Name (_DEP, Package() { \_SB.GDV0.RPIQ })
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_SPI1_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared,) { BCM2836_SPI1_INTERRUPT }
+    PinFunction (Exclusive, PullDown, BCM_ALT4, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 19, 20, 21 } // MISO, MOSI, SCLK
+    PinFunction (Exclusive, PullDown, BCM_ALT4, "\\_SB.GDV0.GPI0", 0, ResourceConsumer, , ) { 16 } // CE2
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_SPI1_OFFSET)
+    Return (^RBUF)
+  }
+}
+
+// SPI2 has no pins on GPIO header
+// Device (SPI2)
+// {
+//   Name (_HID, "BCM2839")
+//   Name (_CID, "BCM2839")
+//   Name (_UID, 0x2)
+//   Name (_CCA, 0x0)
+//   Name (_DEP, Package() { \_SB.GDV0.RPIQ })
+//   Method (_STA)
+//   {
+//     Return (0xf)     // Disabled
+//   }
+//   Method (_CRS, 0x0, Serialized)
+//   {
+//     Name (RBUF, ResourceTemplate ()
+//     {
+//       MEMORY32FIXED (ReadWrite, BCM2836_SPI2_BASE_ADDRESS, BCM2836_SPI2_LENGTH, RMEM)
+//       Interrupt (ResourceConsumer, Level, ActiveHigh, Shared,) { BCM2836_SPI2_INTERRUPT }
+//     })
+//     Return (RBUF)
+//   }
+// }
+
+// PWM Driver
+Device (PWM0)
+{
+  Name (_HID, "BCM2844")
+  Name (_CID, "BCM2844")
+  Name (_UID, 0)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    // DMA channel 11 control
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_PWM_DMA_LENGTH, RM01)
+    // PWM control
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_PWM_CTRL_LENGTH, RM02)
+    // PWM control bus
+    MEMORY32FIXED (ReadWrite, BCM2836_PWM_BUS_BASE_ADDRESS, BCM2836_PWM_BUS_LENGTH, )
+    // PWM control uncached
+    MEMORY32FIXED (ReadWrite, BCM2836_PWM_CTRL_UNCACHED_BASE_ADDRESS, BCM2836_PWM_CTRL_UNCACHED_LENGTH, )
+    // PWM clock control
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_PWM_CLK_LENGTH, RM03)
+    // Interrupt DMA channel 11
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_DMA_INTERRUPT }
+    // DMA channel 11, DREQ 5 for PWM
+    FixedDMA (5, 11, Width32Bit, )
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RM01, RB01, BCM2836_PWM_DMA_OFFSET)
+    MEMORY32SETBASE (RBUF, RM02, RB02, BCM2836_PWM_CTRL_OFFSET)
+    MEMORY32SETBASE (RBUF, RM03, RB03, BCM2836_PWM_CLK_OFFSET)
+    Return (^RBUF)
+  }
+}
\ No newline at end of file
diff --git a/board/raspberrypi/rpi/pci.asl b/board/raspberrypi/rpi/pci.asl
new file mode 100644
index 0000000000..a7a09df5cd
--- /dev/null
+++ b/board/raspberrypi/rpi/pci.asl
@@ -0,0 +1,177 @@
+/** @file
+ *
+ *  Copyright (c) 2019 Linaro, Limited. All rights reserved.
+ *  Copyright (c) 2021 Arm
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+Device(PCI0)
+{
+  Name(_HID, EISAID("PNP0A08")) // PCI Express Root Bridge
+  Name(_CID, EISAID("PNP0A03")) // Compatible PCI Root Bridge
+  Name(_SEG, Zero) // PCI Segment Group number
+  Name(_BBN, Zero) // PCI Base Bus Number
+  Name(_CCA, 0)    // Mark the PCI noncoherent
+
+  // PCIe can only DMA to first 3GB with early SOC's
+  // But we keep the restriction on the later ones
+  // To avoid DMA translation problems.
+  Name (_DMA, ResourceTemplate() {
+    QWordMemory (ResourceProducer,
+      ,
+      MinFixed,
+      MaxFixed,
+      NonCacheable,
+      ReadWrite,
+      0x0,
+      0x0,        // MIN
+      0xbfffffff, // MAX
+      0x0,        // TRA
+      0xc0000000, // LEN
+      ,
+      ,
+      )
+  })
+
+  // PCI Routing Table
+  Name(_PRT, Package() {
+    Package (4) { 0x0000FFFF, 0, zero, 175 },
+    Package (4) { 0x0000FFFF, 1, zero, 176 },
+    Package (4) { 0x0000FFFF, 2, zero, 177 },
+    Package (4) { 0x0000FFFF, 3, zero, 178 }
+  })
+
+  Name (_DSD, Package () {
+    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+      Package () {
+        Package () { "linux-ecam-quirk-id", "bcm2711" },
+      }
+  })
+
+  // Root complex resources
+  Method (_CRS, 0, Serialized) {
+    Name (RBUF, ResourceTemplate () {
+
+      // bus numbers assigned to this root
+      WordBusNumber (
+        ResourceProducer,
+        MinFixed, MaxFixed, PosDecode,
+        0,   // AddressGranularity
+        0,   // AddressMinimum - Minimum Bus Number
+        255, // AddressMaximum - Maximum Bus Number
+        0,   // AddressTranslation - Set to 0
+        256  // RangeLength - Number of Busses
+      )
+
+      // 32-bit mmio window in 64-bit addr
+      QWordMemory (
+        ResourceProducer, PosDecode,
+        MinFixed, MaxFixed,
+        NonCacheable, ReadWrite,        // cacheable
+        0x00000000,                     // Granularity
+        0,                              // PCIE_PCI_MMIO_BEGIN
+        1,                              // PCIE_MMIO_LEN + PCIE_PCI_MMIO_BEGIN
+        PCIE_CPU_MMIO_WINDOW,           // PCIE_PCI_MMIO_BEGIN - PCIE_CPU_MMIO_WINDOW
+        2                               // PCIE_MMIO_LEN + 1
+        ,,,MMI1
+      )
+
+      // root port registers, not to be used if SMCCC is utilized
+      QWordMemory (
+        ResourceConsumer, ,
+        MinFixed, MaxFixed,
+        NonCacheable, ReadWrite,        // cacheable
+        0x00000000,                     // Granularity
+        0xFD500000,                     // Root port begin
+        0xFD509FFF,                     // Root port end
+        0x00000000,                     // no translation
+        0x0000A000,                     // size
+        ,,
+      )
+    }) // end Name(RBUF)
+
+    // Work around ASL's inability to add in a resource definition
+    // or for that matter compute the min,max,len properly
+    CreateQwordField (RBUF, MMI1._MIN, MMIB)
+    CreateQwordField (RBUF, MMI1._MAX, MMIE)
+    CreateQwordField (RBUF, MMI1._TRA, MMIT)
+    CreateQwordField (RBUF, MMI1._LEN, MMIL)
+    Add (MMIB, PCIE_TOP_OF_MEM_WIN, MMIB)
+    Add (PCIE_BRIDGE_MMIO_LEN, PCIE_TOP_OF_MEM_WIN, MMIE)
+    Subtract (MMIT, PCIE_TOP_OF_MEM_WIN, MMIT)
+    Add (PCIE_BRIDGE_MMIO_LEN, 1 , MMIL)
+
+    Return (RBUF)
+  } // end Method(_CRS)
+
+  // OS Control Handoff
+  Name(SUPP, Zero) // PCI _OSC Support Field value
+  Name(CTRL, Zero) // PCI _OSC Control Field value
+
+  // See [1] 6.2.10, [2] 4.5
+  Method(_OSC,4) {
+    // Note, This code is very similar to the code in the PCIe firmware
+    // specification which can be used as a reference
+    // Check for proper UUID
+    If(LEqual(Arg0,ToUUID("33DB4D5B-1FF7-401C-9657-7441C03DD766"))) {
+      // Create DWord-adressable fields from the Capabilities Buffer
+      CreateDWordField(Arg3,0,CDW1)
+      CreateDWordField(Arg3,4,CDW2)
+      CreateDWordField(Arg3,8,CDW3)
+      // Save Capabilities DWord2 & 3
+      Store(CDW2,SUPP)
+      Store(CDW3,CTRL)
+      // Mask out Native HotPlug
+      And(CTRL,0x1E,CTRL)
+      // Always allow native PME, AER (no dependencies)
+      // Never allow SHPC (no SHPC controller in this system)
+      And(CTRL,0x1D,CTRL)
+
+      If(LNotEqual(Arg1,One)) { // Unknown revision
+        Or(CDW1,0x08,CDW1)
+      }
+
+      If(LNotEqual(CDW3,CTRL)) {  // Capabilities bits were masked
+        Or(CDW1,0x10,CDW1)
+      }
+      // Update DWORD3 in the buffer
+      Store(CTRL,CDW3)
+      Return(Arg3)
+    } Else {
+      Or(CDW1,4,CDW1) // Unrecognized UUID
+      Return(Arg3)
+    }
+  } // End _OSC
+
+  Device (XHC0)
+  {
+    Name (_ADR, 0x00010000)
+    Name (_CID, "PNP0D10")
+    Name (_UID, 0x0)            // _UID: Unique ID
+    Name (_CCA, 0x0)            // _CCA: Cache Coherency Attribute
+
+    /*
+     * Microsoft's USB Device-Specific Methods. See:
+     * https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/usb-device-specific-method---dsm-
+     */
+    Name (DSMU, ToUUID ("ce2ee385-00e6-48cb-9f05-2edb927c4899"))
+
+    Method (_DSM, 4, Serialized) {
+        If (LEqual (Arg0, DSMU)) {              // USB capabilities UUID
+            Switch (ToInteger (Arg2)) {
+            Case (0) {                          // Function 0: List of supported functions
+                Return (Buffer () { 0x41 })     // 0x41 - Functions 0 and 6 supported
+            }
+            Case (6) {                          // Function 6: RegisterAccessType
+                Return (Buffer () { 0x01 })     // 0x01 - Must use 32bit register access
+            }
+            Default { }                         // Unsupported
+            }
+        }
+        return (Buffer () { 0x00 })             // Return 0x00 for anything unsupported
+    }
+  } // end XHC0
+
+} // PCI0
\ No newline at end of file
diff --git a/board/raspberrypi/rpi/pep.asl b/board/raspberrypi/rpi/pep.asl
new file mode 100644
index 0000000000..87469e2e5a
--- /dev/null
+++ b/board/raspberrypi/rpi/pep.asl
@@ -0,0 +1,90 @@
+/** @file
+ *
+ *  Platform Extension Plugin (PEP).
+ *
+ *  Copyright (c) 2019, ARM Ltd. All rights reserved.
+ *  Copyright (c) 2018, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+Device(PEPD)
+{
+  //
+  // PEP virtual device.
+  //
+  Name (_HID, "BCM2854") // Note: Since PEP on RPi is a virtual device,
+  Name (_CID, "BCM2854") // its device id needs to be generated by Microsoft
+  Name (_UID, 0x0)
+  Name (_CRS, ResourceTemplate ()
+  {
+    // No hardware resources for PEP driver are needed.
+  })
+
+  //
+  // Processor info. PEP proprietary method to return
+  // PEP_PROCESSOR_TABLE_PLAT structure.
+  //
+  // See Pep.h and Pep.c.
+  //
+  Name (_GPI, Buffer()
+  {
+    0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x5C, 0x00, 0x5F, 0x00, 0x53,
+    0x00, 0x42, 0x00, 0x2E, 0x00, 0x43, 0x00, 0x50, 0x00, 0x55, 0x00, 0x30,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+  })
+
+  //
+  // Coordinated state info. PEP proprietary method to return
+  // PEP_COORDINATED_STATE_TABLE_PLAT structure.
+  //
+  // See Pep.h and Pep.c.
+  //
+  Name (_GCI, Buffer()
+  {
+    0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+  })
+
+  //
+  // Device info. PEP proprietary method to return
+  // PEP_DEVICE_TABLE_PLAT structure.
+  //
+  // See Pep.h and Pep.c.
+  //
+  Name (_GDI, Buffer()
+  {
+    0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x5C, 0x00, 0x5F, 0x00, 0x53,
+    0x00, 0x42, 0x00, 0x2E, 0x00, 0x49, 0x00, 0x32, 0x00, 0x43, 0x00, 0x30,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
+    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+  })
+}
diff --git a/board/raspberrypi/rpi/rhpx.asl b/board/raspberrypi/rpi/rhpx.asl
new file mode 100644
index 0000000000..214b55c656
--- /dev/null
+++ b/board/raspberrypi/rpi/rhpx.asl
@@ -0,0 +1,195 @@
+/** @file
+ *
+ *  [DSDT] RHProxy device to enable WinRT API (RHPX)
+ *
+ *  Copyright (c) 2018, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+Device (RHPX)
+{
+  Name (_HID, "MSFT8000")
+  Name (_CID, "MSFT8000")
+  Name (_UID, 1)
+
+  Name(_CRS, ResourceTemplate ()
+  {
+    // Index 0
+    SPISerialBus (           // SCKL - GPIO 11 - Pin 23
+                             // MOSI - GPIO 10 - Pin 19
+                             // MISO - GPIO 9  - Pin 21
+                             // CE0  - GPIO 8  - Pin 24
+      0,                     // Device selection (CE0)
+      PolarityLow,           // Device selection polarity
+      FourWireMode,          // WireMode
+      8,                     // DataBit len
+      ControllerInitiated,   // Slave mode
+      4000000,               // Connection speed
+      ClockPolarityLow,      // Clock polarity
+      ClockPhaseFirst,       // Clock phase
+      "\\_SB.GDV0.SPI0",     // ResourceSource: SPI bus controller name
+      0,                     // ResourceSourceIndex
+                             // Resource usage
+                             // DescriptorName: creates name for offset of resource descriptor
+    )                        // Vendor Data
+
+    // Index 1
+    SPISerialBus (           // SCKL - GPIO 11 - Pin 23
+                             // MOSI - GPIO 10 - Pin 19
+                             // MISO - GPIO 9  - Pin 21
+                             // CE1  - GPIO 7  - Pin 26
+      1,                     // Device selection (CE1)
+      PolarityLow,           // Device selection polarity
+      FourWireMode,          // WireMode
+      8,                     // DataBit len
+      ControllerInitiated,   // Slave mode
+      4000000,               // Connection speed
+      ClockPolarityLow,      // Clock polarity
+      ClockPhaseFirst,       // Clock phase
+      "\\_SB.GDV0.SPI0",     // ResourceSource: SPI bus controller name
+      0,                     // ResourceSourceIndex
+                             // Resource usage
+                             // DescriptorName: creates name for offset of resource descriptor
+    )                        // Vendor Data
+
+    // Index 2
+    I2CSerialBus (           // Pin 3 (GPIO2, SDA1), 5 (GPIO3, SCL1)
+      0xFFFF,                // SlaveAddress: placeholder
+      ,                      // SlaveMode: default to ControllerInitiated
+      0,                     // ConnectionSpeed: placeholder
+      ,                      // Addressing Mode: default to 7 bit
+      "\\_SB.GDV0.I2C1",     // ResourceSource: I2C bus controller name
+      ,
+      ,
+      ,                      // Descriptor Name: creates name for offset of resource descriptor
+    )                        // Vendor Data
+
+    // Index 3
+    SPISerialBus (           // SPI1_SCLK - GPIO21
+                             // SPI1_MOSI - GPIO20
+                             // SPI1_MISO - GPIO19
+                             // SPI1_CE2_N - GPIO16
+      2,                     // Device selection (CE2)
+      PolarityLow,           // Device selection polarity
+      FourWireMode,          // WireMode
+      8,                     // DataBit len
+      ControllerInitiated,   // Slave mode
+      4000000,               // Connection speed
+      ClockPolarityLow,      // Clock polarity
+      ClockPhaseFirst,       // Clock phase
+      "\\_SB.GDV0.SPI1",          // ResourceSource: SPI bus controller name
+      0,                     // ResourceSourceIndex
+                             // Resource usage
+                             // DescriptorName: creates name for offset of resource descriptor
+    )                        // Vendor Data
+
+    // GPIO 2
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 2 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 2 }
+    // GPIO 3
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 3 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 3 }
+    // GPIO 4
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 4 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 4 }
+    // GPIO 5
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 5 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 5 }
+    // GPIO 6
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 6 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 6 }
+    // GPIO 7
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 7 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 7 }
+    // GPIO 8
+    GpioIO (Shared, PullUp, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 8 }
+    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0, "\\_SB.GDV0.GPI0",)                          { 8 }
+    // GPIO 9
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 9 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 9 }
+    // GPIO 10
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 10 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 10 }
+    // GPIO 11
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 11 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 11 }
+    // GPIO 12
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 12 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 12 }
+    // GPIO 13
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 13 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 13 }
+    // NTRAID#MSFT-7141401-2016/04/7-jordanrh - disable UART muxing
+    // until a proper solution can be created for the dmap conflict
+    // GPIO 14 - UART TX
+    // GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 14 }
+    // GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 14 }
+    // GPIO 15 - UART RX
+    // GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 15 }
+    // GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 15 }
+    // GPIO 16
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 16 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 16 }
+    // GPIO 17
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 17 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 17 }
+    // GPIO 18
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 18 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 18 }
+    // GPIO 19
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 19 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 19 }
+    // GPIO 20
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 20 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 20 }
+    // GPIO 21
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 21 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 21 }
+    // GPIO 22
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 22 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 22 }
+    // GPIO 23
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 23 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 23 }
+    // GPIO 24
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 24 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 24 }
+    // GPIO 25
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 25 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 25 }
+    // GPIO 26
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 26 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 26 }
+    // GPIO 27
+    GpioIO (Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GDV0.GPI0", 0, ResourceConsumer,,) { 27 }
+    GpioInt (Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GDV0.GPI0",)                          { 27 }
+  })
+
+  Name (_DSD, Package()
+  {
+    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+    Package ()
+    {
+      // Reference http://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md
+      // SPI 0
+      Package (2) { "bus-SPI-SPI0", Package() { 0, 1 } },                   // Index 0 & 1
+      Package (2) { "SPI0-MinClockInHz", 7629 },                            // 7629 Hz
+      Package (2) { "SPI0-MaxClockInHz", 125000000 },                       // 125 MHz
+      Package (2) { "SPI0-SupportedDataBitLengths", Package() { 8 } },      // Data Bit Length
+      // I2C1
+      Package (2) { "bus-I2C-I2C1", Package() { 2 } },
+      // GPIO Pin Count and supported drive modes
+      Package (2) { "GPIO-PinCount", 54 },
+      Package (2) { "GPIO-UseDescriptorPinNumbers", 1 },
+      Package (2) { "GPIO-SupportedDriveModes", 0xf },                      // InputHighImpedance, InputPullUp, InputPullDown, OutputCmos
+      // SPI 1
+      Package (2) { "bus-SPI-SPI1", Package() { 3 }},                       // Index 3
+      Package (2) { "SPI1-MinClockInHz", 30511 },                           // 30.5 kHz
+      Package (2) { "SPI1-MaxClockInHz", 20000000 },                        // 20 MHz
+      Package (2) { "SPI1-SupportedDataBitLengths", Package() { 8 } },      // Data Bit Length
+    }
+  })
+}
diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9..9122f33d88 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -23,6 +23,11 @@
 #endif
 #include <watchdog.h>
 #include <dm/pinctrl.h>
+#include <dm/ofnode.h>
+#include <acpi/acpi_table.h>
+#include <acpi/acpigen.h>
+#include <dm/lists.h>
+#include <tables_csum.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -583,3 +588,181 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	return 0;
 }
+
+#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
+static bool is_rpi4(void)
+{
+	return of_machine_is_compatible("brcm,bcm2711") ||
+	       of_machine_is_compatible("brcm,bcm2712");
+}
+
+static bool is_rpi3(void)
+{
+	return of_machine_is_compatible("brcm,bcm2837");
+}
+
+static int acpi_rpi_board_fill_ssdt(struct acpi_ctx *ctx)
+{
+	int node, ret, uart_in_use, mini_clock_rate;
+	bool enabled;
+	struct udevice *dev;
+	struct {
+		const char *fdt_compatible;
+		const char *acpi_scope;
+		bool on_rpi4;
+		bool on_rpi3;
+		u32 mmio_address;
+	} map[] = {
+		{"brcm,bcm2711-pcie", "\\_SB.PCI0", true, false},
+		{"brcm,bcm2711-emmc2", "\\_SB.GDV1.SDC3", true, false},
+		{"brcm,bcm2835-pwm", "\\_SB.GDV0.PWM0", true, true},
+		{"brcm,bcm2711-genet-v5",  "\\_SB.ETH0", true, false},
+		{"brcm,bcm2711-thermal", "\\_SB.EC00", true, true},
+		{"brcm,bcm2835-sdhci", "\\_SB.SDC1", true, true},
+		{"brcm,bcm2835-sdhost", "\\_SB.SDC2", false, true},
+		{"brcm,bcm2835-mbox", "\\_SB.GDV0.RPIQ", true, true},
+		{"brcm,bcm2835-i2c", "\\_SB.GDV0.I2C1", true, true, 0xfe205000},
+		{"brcm,bcm2835-i2c", "\\_SB.GDV0.I2C2", true, true, 0xfe804000},
+		{"brcm,bcm2835-spi", "\\_SB.GDV0.SPI0", true, true},
+		{"brcm,bcm2835-aux-spi", "\\_SB.GDV0.SPI1", true, true, 0xfe215080},
+		{"arm,pl011", "\\_SB.URT0", true, true},
+		{"brcm,bcm2835-aux-uart", "\\_SB.URTM", true, true},
+		{ /* Sentinel */ }
+	};
+
+	/* Device enable */
+	for (int i = 0; map[i].fdt_compatible; i++) {
+		if ((is_rpi4() && !map[i].on_rpi4) ||
+		    (is_rpi3() && !map[i].on_rpi3)) {
+			enabled = false;
+		} else {
+			node = fdt_node_offset_by_compatible(gd->fdt_blob, -1,
+							     map[i].fdt_compatible);
+			while (node != -FDT_ERR_NOTFOUND && map[i].mmio_address) {
+				struct fdt_resource r;
+
+				ret = fdt_get_resource(gd->fdt_blob, node, "reg", 0, &r);
+				if (ret) {
+					node = -FDT_ERR_NOTFOUND;
+					break;
+				}
+
+				if (r.start == map[i].mmio_address)
+					break;
+
+				node = fdt_node_offset_by_compatible(gd->fdt_blob, node,
+								     map[i].fdt_compatible);
+			}
+
+			enabled = (node > 0) ? fdtdec_get_is_enabled(gd->fdt_blob, node) : 0;
+		}
+		acpigen_write_scope(ctx, map[i].acpi_scope);
+		acpigen_write_name_integer(ctx, "_STA", enabled ? 0xf : 0);
+		acpigen_pop_len(ctx);
+	}
+
+	/* GPIO quirks */
+	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "brcm,bcm2835-gpio");
+	if (node <= 0)
+		node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "brcm,bcm2711-gpio");
+
+	acpigen_write_scope(ctx, "\\_SB.GDV0.GPI0");
+	enabled = (node > 0) ? fdtdec_get_is_enabled(gd->fdt_blob, node) : 0;
+	acpigen_write_name_integer(ctx, "_STA", enabled ? 0xf : 0);
+	acpigen_pop_len(ctx);
+
+	if (is_rpi4()) {
+		/* eMMC quirks */
+		node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "brcm,bcm2711-emmc2");
+		if (node) {
+			phys_addr_t cpu;
+			dma_addr_t bus;
+			u64 size;
+
+			ret = fdt_get_dma_range(gd->fdt_blob, node, &cpu, &bus, &size);
+
+			acpigen_write_scope(ctx, "\\_SB.GDV1");
+			acpigen_write_method_serialized(ctx, "_DMA", 0);
+			acpigen_emit_byte(ctx, RETURN_OP);
+
+			if (!ret && bus != cpu)		/* Translated DMA range */
+				acpigen_emit_namestring(ctx, "\\_SB.GDV1.DMTR");
+			else if (!ret && bus == cpu)	/* Non translated DMA */
+				acpigen_emit_namestring(ctx, "\\_SB.GDV1.DMNT");
+			else	/* Silicon revisions older than C0: Translated DMA range */
+				acpigen_emit_namestring(ctx, "\\_SB.GDV1.DMTR");
+			acpigen_pop_len(ctx);
+		}
+	}
+
+	/* Serial */
+	uart_in_use = ~0;
+	mini_clock_rate = 0x1000000;
+
+	ret = uclass_get_device_by_driver(UCLASS_SERIAL,
+					  DM_DRIVER_GET(bcm283x_pl011_uart),
+					  &dev);
+	if (!ret)
+		uart_in_use = 0;
+
+	ret = uclass_get_device_by_driver(UCLASS_SERIAL,
+					  DM_DRIVER_GET(serial_bcm283x_mu),
+					  &dev);
+	if (!ret) {
+		if (uart_in_use == 0)
+			log_err("Invalid config: PL011 and MiniUART are both enabled.");
+		else
+			uart_in_use = 1;
+
+		mini_clock_rate = dev_read_u32_default(dev, "clock", 0x1000000);
+	}
+	if (uart_in_use > 1)
+		log_err("No working serial: PL011 and MiniUART are both disabled.");
+
+	acpigen_write_scope(ctx, "\\_SB.BTH0");
+	acpigen_write_name_integer(ctx, "URIU", uart_in_use);
+	acpigen_pop_len(ctx);
+
+	acpigen_write_scope(ctx, "\\_SB.URTM");
+	acpigen_write_name_integer(ctx, "MUCR", mini_clock_rate);
+	acpigen_pop_len(ctx);
+
+	return 0;
+}
+
+static int rpi_acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *ssdt;
+	int ret;
+
+	ssdt = ctx->current;
+	memset(ssdt, '\0', sizeof(struct acpi_table_header));
+
+	acpi_fill_header(ssdt, "SSDT");
+	ssdt->revision = acpi_get_table_revision(ACPITAB_SSDT);
+	ssdt->creator_revision = 1;
+	ssdt->length = sizeof(struct acpi_table_header);
+
+	acpi_inc(ctx, sizeof(struct acpi_table_header));
+
+	ret = acpi_rpi_board_fill_ssdt(ctx);
+	if (ret) {
+		ctx->current = ssdt;
+		return log_msg_ret("fill", ret);
+	}
+
+	/* (Re)calculate length and checksum */
+	ssdt->length = ctx->current - (void *)ssdt;
+	ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
+	log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
+
+	/* Drop the table if it is empty */
+	if (ssdt->length == sizeof(struct acpi_table_header))
+		return log_msg_ret("fill", -ENOENT);
+	acpi_add_table(ctx, ssdt);
+
+	return 0;
+}
+
+ACPI_WRITER(5ssdt, "SSDT", rpi_acpi_write_ssdt, 0);
+#endif
diff --git a/board/raspberrypi/rpi/sdhc.asl b/board/raspberrypi/rpi/sdhc.asl
new file mode 100644
index 0000000000..3feac14acf
--- /dev/null
+++ b/board/raspberrypi/rpi/sdhc.asl
@@ -0,0 +1,111 @@
+/** @file
+ *
+ *  [DSDT] SD controller/card definition (SDHC)
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *  Copyright (c) 2018, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836_sdhost.h>
+#include <asm/arch/acpi/bcm2836_sdio.h>
+
+#include "acpitables.h"
+
+//
+// Note: UEFI can use either SDHost or Arasan. We expose both to the OS.
+//
+
+// ArasanSD 3.0 SD Host Controller. (brcm,bcm2835-sdhci)
+Device (SDC1)
+{
+  Name (_HID, "BCM2847")
+  Name (_CID, "BCM2847")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+  Name (_S1D, 0x1)
+  Name (_S2D, 0x1)
+  Name (_S3D, 0x1)
+  Name (_S4D, 0x1)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, MMCHS1_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_MMCHS1_INTERRUPT }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, MMCHS1_OFFSET)
+    Return (^RBUF)
+  }
+
+  // The standard CAPs registers on this controller
+  // appear to be 0, lets set some minimal defaults
+  // Since this cap doesn't indicate DMA capability
+  // we don't need a _DMA()
+  Name (_DSD, Package () {
+    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+    Package () {
+      Package () { "sdhci-caps", 0x0120fa81 },
+    }
+  })
+
+  //
+  // A child device that represents the
+  // sd card, which is marked as non-removable.
+  //
+  Device (SDMM)
+  {
+    Method (_ADR)
+    {
+      Return (0)
+    }
+    Method (_RMV) // Is removable
+    {
+      Return (0) // 0 - fixed
+    }
+  }
+}
+
+// Broadcom SDHost 2.0 SD Host Controller
+Device (SDC2)
+{
+  Name (_HID, "BCM2855")
+  Name (_CID, "BCM2855")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+  Name (_S1D, 0x1)
+  Name (_S2D, 0x1)
+  Name (_S3D, 0x1)
+  Name (_S4D, 0x1)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, SDHOST_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_SDHOST_INTERRUPT }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, SDHOST_OFFSET)
+    Return (^RBUF)
+  }
+
+  //
+  // A child device that represents the
+  // sd card, which is marked as non-removable.
+  //
+  Device (SDMM)
+  {
+    Method (_ADR)
+    {
+      Return (0)
+    }
+    Method (_RMV) // Is removable
+    {
+      Return (0) // 0 - fixed
+    }
+  }
+}
\ No newline at end of file
diff --git a/board/raspberrypi/rpi/uart.asl b/board/raspberrypi/rpi/uart.asl
new file mode 100644
index 0000000000..78dc9a74df
--- /dev/null
+++ b/board/raspberrypi/rpi/uart.asl
@@ -0,0 +1,208 @@
+/** @file
+ *
+ *  [DSDT] Serial devices (UART).
+ *
+ *  Copyright (c) 2021, ARM Limited. All rights reserved.
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *  Copyright (c) 2018, Andrey Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ *  SPDX-License-Identifier: BSD-2-Clause-Patent
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#include "acpitables.h"
+
+// PL011 based UART.
+Device (URT0)
+{
+  Name (_HID, "BCM2837")
+  Name (_CID, "ARMH0011")
+  Name (_UID, 0x4)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_PL011_UART_LENGTH, RMEM)
+    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BCM2836_PL011_UART_INTERRUPT }
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_PL011_UART_OFFSET)
+    Return (^RBUF)
+  }
+
+  Name (CLCK, 48000000)
+
+  Name (_DSD, Package ()
+  {
+    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), Package ()
+    {
+      Package (2) { "clock-frequency", CLCK },
+    }
+  })
+}
+
+//
+// UART Mini.
+//
+// This device is referenced in the DBG2 table, which will cause the system to
+// not start the driver when the debugger is enabled and to mark the device
+// with problem code 53 (CM_PROB_USED_BY_DEBUGGER).
+//
+
+Device (URTM)
+{
+  Name (_HID, "BCM2836")
+  Name (_CID, "BCM2836")
+  Name (_UID, 0x0)
+  Name (_CCA, 0x0)
+
+  Name (RBUF, ResourceTemplate ()
+  {
+    MEMORY32FIXED (ReadWrite, 0, BCM2836_MINI_UART_LENGTH, RMEM)
+    Interrupt(ResourceConsumer, Level, ActiveHigh, Shared) { BCM2836_MINI_UART_INTERRUPT }
+
+  })
+  Method (_CRS, 0x0, Serialized)
+  {
+    MEMORY32SETBASE (RBUF, RMEM, RBAS, BCM2836_MINI_UART_OFFSET)
+    Return (^RBUF)
+  }
+
+  //
+  // Mini Uart Clock Rate will be dynamically updated during boot
+  //
+  External (\_SB.URTM.MUCR, IntObj)
+
+  Name (_DSD, Package ()
+  {
+    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), Package ()
+    {
+      Package (2) { "clock-frequency", MUCR },
+    }
+  })
+}
+
+//
+// Multifunction serial bus device to support Bluetooth function.
+//
+Device(BTH0)
+{
+  Name (_HID, "BCM2EA6")
+  Name (_CID, "BCM2EA6")
+
+  //
+  // UART In Use will be dynamically updated during boot
+  //
+  External (\_SB.BTH0.URIU, IntObj)
+
+  Method (_STA)
+  {
+    Return (0xf)
+  }
+
+  //
+  // Resource for URT0 (PL011)
+  //
+  Name (BTPL, ResourceTemplate ()
+  {
+    UARTSerialBus(
+      115200,        // InitialBaudRate: in BPS
+      ,              // BitsPerByte: default to 8 bits
+      ,              // StopBits: Defaults to one bit
+      0x00,          // LinesInUse: 8 1-bit flags to
+                    //   declare enabled control lines.
+                    //   Raspberry Pi does not exposed
+                    //   HW control signals -> not supported.
+                    //   Optional bits:
+                    //   - Bit 7 (0x80) Request To Send (RTS)
+                    //   - Bit 6 (0x40) Clear To Send (CTS)
+                    //   - Bit 5 (0x20) Data Terminal Ready (DTR)
+                    //   - Bit 4 (0x10) Data Set Ready (DSR)
+                    //   - Bit 3 (0x08) Ring Indicator (RI)
+                    //   - Bit 2 (0x04) Data Carrier Detect (DTD)
+                    //   - Bit 1 (0x02) Reserved. Must be 0.
+                    //   - Bit 0 (0x01) Reserved. Must be 0.
+      ,              // IsBigEndian:
+                    //   default to LittleEndian.
+      ,              // Parity: Defaults to no parity
+      ,              // FlowControl: Defaults to
+                    //   no flow control.
+      16,            // ReceiveBufferSize
+      16,            // TransmitBufferSize
+      "\\_SB.GDV0.URT0",  // ResourceSource:
+                    //   UART bus controller name
+      ,              // ResourceSourceIndex: assumed to be 0
+      ,              // ResourceUsage: assumed to be
+                    //   ResourceConsumer
+      UAR0,          // DescriptorName: creates name
+                    //   for offset of resource descriptor
+    )                // Vendor data
+  })
+
+  //
+  // Resource for URTM (miniUART)
+  //
+  Name (BTMN, ResourceTemplate ()
+  {
+    //
+    // BT UART: ResourceSource will be dynamically updated to
+    // either URT0 (PL011) or URTM (miniUART) during boot
+    //
+    UARTSerialBus(
+      115200,        // InitialBaudRate: in BPS
+      ,              // BitsPerByte: default to 8 bits
+      ,              // StopBits: Defaults to one bit
+      0x00,          // LinesInUse: 8 1-bit flags to
+                    //   declare enabled control lines.
+                    //   Raspberry Pi does not exposed
+                    //   HW control signals -> not supported.
+                    //   Optional bits:
+                    //   - Bit 7 (0x80) Request To Send (RTS)
+                    //   - Bit 6 (0x40) Clear To Send (CTS)
+                    //   - Bit 5 (0x20) Data Terminal Ready (DTR)
+                    //   - Bit 4 (0x10) Data Set Ready (DSR)
+                    //   - Bit 3 (0x08) Ring Indicator (RI)
+                    //   - Bit 2 (0x04) Data Carrier Detect (DTD)
+                    //   - Bit 1 (0x02) Reserved. Must be 0.
+                    //   - Bit 0 (0x01) Reserved. Must be 0.
+      ,              // IsBigEndian:
+                    //   default to LittleEndian.
+      ,              // Parity: Defaults to no parity
+      ,              // FlowControl: Defaults to
+                    //   no flow control.
+      16,            // ReceiveBufferSize
+      16,            // TransmitBufferSize
+      "\\_SB.GDV0.URTM",  // ResourceSource:
+                    //   UART bus controller name
+      ,              // ResourceSourceIndex: assumed to be 0
+      ,              // ResourceUsage: assumed to be
+                    //   ResourceConsumer
+      UARM,          // DescriptorName: creates name
+                    //   for offset of resource descriptor
+    )                // Vendor data
+  })
+
+  Method (_CRS, 0x0, Serialized)
+  {
+    if (URIU == 0)
+    {
+      //
+      // PL011 UART is configured for console output
+      // Return Mini UART for Bluetooth
+      //
+      return (^BTMN)
+    }
+    else
+    {
+      //
+      // Mini UART is configured for console output
+      // Return PL011 UART for Bluetooth
+      //
+      return (^BTPL)
+    }
+  }
+}
-- 
2.45.2

