Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6997C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F45488480;
	Sat, 27 Apr 2024 16:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fml+2VFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45D388480; Sat, 27 Apr 2024 16:11:27 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CA688498
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5aa241232faso2346643eaf.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227082; x=1714831882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkIATXv9HROXJ7w/HlOZYNCr9msWo7tAfEVpYrg9Ag8=;
 b=Fml+2VFDG5gKFzPYy7IB/7VV/D9l29UmSCEgVycqp/ZJLcMAsLENacUBCd6UIY3wZD
 lsNyYtoAJMahJfE+TGthBLGwYmcXsT6sLVwvAcvgLqrSCDROKw6SPtJ4b6fOKP+OvNCH
 qklDp7Hd4GcICH8TAmcpRsV+oAZV3frYnlGLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227082; x=1714831882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkIATXv9HROXJ7w/HlOZYNCr9msWo7tAfEVpYrg9Ag8=;
 b=uErCgcGgU6oQofkIxX4ErEyte9iaggM/nHUl3iKxIZfoy5fDfJi9Fj1XkywK4qdIw/
 WhWvoEQWn4ppsI6t8ukyt/sRvxi2e70pG0VHWYKHrpeKRVB0Exh1dI3Y5PhUfqJKRX3u
 odRRmVGUeR3JVO2EThzL1bQZe+SuvdL4nKJ62u1M7xSRPkMXnr/ndE0ccswHs4IECfBb
 RYCxCfRDkkGQAEoUKpUcw/1qxfU702Hz2qPAh+JCirg3M31fTUeEvFTBeS1aq4RN1Y60
 NaIYB2DPO7UssS5b6h2PAVtm6A9GtmWYq9TuShyOSVfwufyEbFiYLr2MH8wla+yPPrPJ
 eU4w==
X-Gm-Message-State: AOJu0Yx5CBgBz/AFYwHyupgtkdjXlyWUYDVhEA7GQbT+e37IaouUfvRj
 dlcdNapOws9Xjw2jpNi5ti9nO9AHrDGOKMk3dbkuiFp5lDM6hxbbeAhp81i6+AvkDlxSHaJNzh4
 7i0CNIQ==
X-Google-Smtp-Source: AGHT+IGYpGMvC/svEzWqhpuvExD4ZymDWQo/K97jORyMvAnw+EjLcMhOxzgv4qSB7iQ72bZx+efn2Q==
X-Received: by 2002:a9d:7985:0:b0:6ee:ca1:ac3a with SMTP id
 h5-20020a9d7985000000b006ee0ca1ac3amr452838otm.3.1714227080643; 
 Sat, 27 Apr 2024 07:11:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 08/18] x86: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:56 -0600
Message-Id: <20240427141106.3406000-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from all x86 architecture files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/acpi_gpe.c                      | 2 +-
 arch/x86/cpu/apollolake/acpi.c               | 1 -
 arch/x86/cpu/apollolake/cpu.c                | 1 -
 arch/x86/cpu/apollolake/cpu_common.c         | 1 -
 arch/x86/cpu/apollolake/cpu_spl.c            | 1 -
 arch/x86/cpu/apollolake/fsp_bindings.c       | 1 -
 arch/x86/cpu/apollolake/fsp_m.c              | 1 -
 arch/x86/cpu/apollolake/fsp_s.c              | 1 -
 arch/x86/cpu/apollolake/hostbridge.c         | 1 -
 arch/x86/cpu/apollolake/lpc.c                | 1 -
 arch/x86/cpu/apollolake/pch.c                | 1 -
 arch/x86/cpu/apollolake/pmc.c                | 1 -
 arch/x86/cpu/apollolake/punit.c              | 2 +-
 arch/x86/cpu/apollolake/spl.c                | 1 -
 arch/x86/cpu/apollolake/systemagent.c        | 1 -
 arch/x86/cpu/apollolake/uart.c               | 1 -
 arch/x86/cpu/baytrail/acpi.c                 | 1 -
 arch/x86/cpu/baytrail/cpu.c                  | 1 -
 arch/x86/cpu/baytrail/early_uart.c           | 1 -
 arch/x86/cpu/baytrail/fsp_configs.c          | 1 -
 arch/x86/cpu/baytrail/valleyview.c           | 2 +-
 arch/x86/cpu/braswell/braswell.c             | 2 +-
 arch/x86/cpu/braswell/early_uart.c           | 1 -
 arch/x86/cpu/braswell/fsp_configs.c          | 1 -
 arch/x86/cpu/broadwell/adsp.c                | 1 -
 arch/x86/cpu/broadwell/cpu.c                 | 1 -
 arch/x86/cpu/broadwell/cpu_from_spl.c        | 2 +-
 arch/x86/cpu/broadwell/cpu_full.c            | 1 -
 arch/x86/cpu/broadwell/iobp.c                | 1 -
 arch/x86/cpu/broadwell/lpc.c                 | 1 -
 arch/x86/cpu/broadwell/me.c                  | 1 -
 arch/x86/cpu/broadwell/northbridge.c         | 1 -
 arch/x86/cpu/broadwell/pch.c                 | 1 -
 arch/x86/cpu/broadwell/pinctrl_broadwell.c   | 1 -
 arch/x86/cpu/broadwell/power_state.c         | 1 -
 arch/x86/cpu/broadwell/refcode.c             | 2 +-
 arch/x86/cpu/broadwell/sata.c                | 1 -
 arch/x86/cpu/broadwell/sdram.c               | 1 -
 arch/x86/cpu/coreboot/coreboot.c             | 1 -
 arch/x86/cpu/coreboot/coreboot_spl.c         | 1 -
 arch/x86/cpu/coreboot/sdram.c                | 2 +-
 arch/x86/cpu/coreboot/timestamp.c            | 2 +-
 arch/x86/cpu/cpu.c                           | 1 -
 arch/x86/cpu/cpu_x86.c                       | 1 -
 arch/x86/cpu/efi/app.c                       | 2 +-
 arch/x86/cpu/efi/payload.c                   | 3 ++-
 arch/x86/cpu/efi/sdram.c                     | 2 +-
 arch/x86/cpu/i386/cpu.c                      | 2 +-
 arch/x86/cpu/i386/interrupt.c                | 1 -
 arch/x86/cpu/intel_common/acpi.c             | 1 -
 arch/x86/cpu/intel_common/car.S              | 1 -
 arch/x86/cpu/intel_common/cpu.c              | 1 -
 arch/x86/cpu/intel_common/cpu_from_spl.c     | 1 -
 arch/x86/cpu/intel_common/fast_spi.c         | 1 -
 arch/x86/cpu/intel_common/generic_wifi.c     | 1 -
 arch/x86/cpu/intel_common/intel_opregion.c   | 1 -
 arch/x86/cpu/intel_common/itss.c             | 1 -
 arch/x86/cpu/intel_common/lpc.c              | 1 -
 arch/x86/cpu/intel_common/lpss.c             | 1 -
 arch/x86/cpu/intel_common/me_status.c        | 1 -
 arch/x86/cpu/intel_common/microcode.c        | 1 -
 arch/x86/cpu/intel_common/mrc.c              | 4 ++--
 arch/x86/cpu/intel_common/p2sb.c             | 1 -
 arch/x86/cpu/intel_common/pch.c              | 1 -
 arch/x86/cpu/intel_common/report_platform.c  | 2 +-
 arch/x86/cpu/ioapic.c                        | 1 -
 arch/x86/cpu/irq.c                           | 1 -
 arch/x86/cpu/ivybridge/bd82x6x.c             | 1 -
 arch/x86/cpu/ivybridge/cpu.c                 | 1 -
 arch/x86/cpu/ivybridge/early_me.c            | 1 -
 arch/x86/cpu/ivybridge/fsp_configs.c         | 1 -
 arch/x86/cpu/ivybridge/ivybridge.c           | 2 +-
 arch/x86/cpu/ivybridge/lpc.c                 | 1 -
 arch/x86/cpu/ivybridge/model_206ax.c         | 1 -
 arch/x86/cpu/ivybridge/northbridge.c         | 1 -
 arch/x86/cpu/ivybridge/sata.c                | 1 -
 arch/x86/cpu/ivybridge/sdram.c               | 1 -
 arch/x86/cpu/ivybridge/sdram_nop.c           | 2 +-
 arch/x86/cpu/lapic.c                         | 1 -
 arch/x86/cpu/mp_init.c                       | 2 +-
 arch/x86/cpu/mtrr.c                          | 1 -
 arch/x86/cpu/pci.c                           | 1 -
 arch/x86/cpu/qemu/cpu.c                      | 1 -
 arch/x86/cpu/qemu/dram.c                     | 2 +-
 arch/x86/cpu/qemu/e820.c                     | 1 -
 arch/x86/cpu/qemu/qemu.c                     | 2 +-
 arch/x86/cpu/qfw_cpu.c                       | 1 -
 arch/x86/cpu/quark/acpi.c                    | 2 +-
 arch/x86/cpu/quark/dram.c                    | 2 +-
 arch/x86/cpu/quark/hte.c                     | 1 -
 arch/x86/cpu/quark/mrc.c                     | 2 +-
 arch/x86/cpu/quark/mrc_util.c                | 2 +-
 arch/x86/cpu/quark/msg_port.c                | 1 -
 arch/x86/cpu/quark/quark.c                   | 2 +-
 arch/x86/cpu/quark/smc.c                     | 3 ++-
 arch/x86/cpu/queensbay/fsp_configs.c         | 1 -
 arch/x86/cpu/queensbay/tnc.c                 | 1 -
 arch/x86/cpu/slimbootloader/sdram.c          | 1 -
 arch/x86/cpu/slimbootloader/serial.c         | 1 -
 arch/x86/cpu/slimbootloader/slimbootloader.c | 1 -
 arch/x86/cpu/tangier/acpi.c                  | 1 -
 arch/x86/cpu/tangier/pinmux.c                | 1 -
 arch/x86/cpu/tangier/sdram.c                 | 2 +-
 arch/x86/cpu/tangier/sysreset.c              | 1 -
 arch/x86/cpu/tangier/tangier.c               | 1 -
 arch/x86/cpu/turbo.c                         | 1 -
 arch/x86/cpu/x86_64/cpu.c                    | 1 -
 arch/x86/cpu/x86_64/interrupts.c             | 1 -
 arch/x86/cpu/x86_64/misc.c                   | 1 -
 arch/x86/include/asm/arch-quark/mrc.h        | 2 ++
 arch/x86/include/asm/arch-quark/msg_port.h   | 2 ++
 arch/x86/include/asm/arch-quark/quark.h      | 2 ++
 arch/x86/include/asm/cb_sysinfo.h            | 1 +
 arch/x86/include/asm/coreboot_tables.h       | 2 ++
 arch/x86/include/asm/early_cmos.h            | 2 ++
 arch/x86/include/asm/handoff.h               | 2 ++
 arch/x86/include/asm/me_common.h             | 1 +
 arch/x86/include/asm/mp.h                    | 1 +
 arch/x86/lib/acpi.c                          | 1 -
 arch/x86/lib/acpi_nhlt.c                     | 1 -
 arch/x86/lib/acpi_s3.c                       | 1 -
 arch/x86/lib/acpi_table.c                    | 1 -
 arch/x86/lib/acpigen.c                       | 1 -
 arch/x86/lib/asm-offsets.c                   | 1 -
 arch/x86/lib/bdinfo.c                        | 1 -
 arch/x86/lib/bios.c                          | 1 -
 arch/x86/lib/bios_interrupts.c               | 1 -
 arch/x86/lib/bootm.c                         | 1 -
 arch/x86/lib/cmd_boot.c                      | 1 -
 arch/x86/lib/coreboot/cb_support.c           | 2 +-
 arch/x86/lib/coreboot/cb_sysinfo.c           | 2 +-
 arch/x86/lib/coreboot_table.c                | 1 -
 arch/x86/lib/div64.c                         | 2 +-
 arch/x86/lib/e820.c                          | 1 -
 arch/x86/lib/early_cmos.c                    | 1 -
 arch/x86/lib/fsp/fsp_common.c                | 1 -
 arch/x86/lib/fsp/fsp_dram.c                  | 1 -
 arch/x86/lib/fsp/fsp_graphics.c              | 1 -
 arch/x86/lib/fsp/fsp_support.c               | 1 -
 arch/x86/lib/fsp1/fsp_common.c               | 1 -
 arch/x86/lib/fsp1/fsp_dram.c                 | 1 -
 arch/x86/lib/fsp1/fsp_support.c              | 1 -
 arch/x86/lib/fsp2/fsp_common.c               | 1 -
 arch/x86/lib/fsp2/fsp_dram.c                 | 1 -
 arch/x86/lib/fsp2/fsp_init.c                 | 1 -
 arch/x86/lib/fsp2/fsp_meminit.c              | 1 -
 arch/x86/lib/fsp2/fsp_silicon_init.c         | 1 -
 arch/x86/lib/fsp2/fsp_support.c              | 1 -
 arch/x86/lib/hob.c                           | 1 -
 arch/x86/lib/i8254.c                         | 2 +-
 arch/x86/lib/i8259.c                         | 1 -
 arch/x86/lib/init_helpers.c                  | 2 +-
 arch/x86/lib/interrupts.c                    | 1 -
 arch/x86/lib/lpc-uclass.c                    | 1 -
 arch/x86/lib/mpspec.c                        | 1 -
 arch/x86/lib/mrccache.c                      | 1 -
 arch/x86/lib/northbridge-uclass.c            | 1 -
 arch/x86/lib/physmem.c                       | 1 -
 arch/x86/lib/pinctrl_ich6.c                  | 1 -
 arch/x86/lib/pirq_routing.c                  | 1 -
 arch/x86/lib/pmu.c                           | 1 -
 arch/x86/lib/ramtest.c                       | 2 +-
 arch/x86/lib/reloc_ia32_efi.c                | 1 -
 arch/x86/lib/reloc_x86_64_efi.c              | 1 -
 arch/x86/lib/relocate.c                      | 1 -
 arch/x86/lib/scu.c                           | 1 -
 arch/x86/lib/sfi.c                           | 1 -
 arch/x86/lib/spl.c                           | 2 +-
 arch/x86/lib/tables.c                        | 1 -
 arch/x86/lib/tpl.c                           | 1 -
 arch/x86/lib/zimage.c                        | 1 -
 include/acpi/acpi_s3.h                       | 3 +++
 172 files changed, 54 insertions(+), 163 deletions(-)

diff --git a/arch/x86/cpu/acpi_gpe.c b/arch/x86/cpu/acpi_gpe.c
index da01e71335f1..13fe695014be 100644
--- a/arch/x86/cpu/acpi_gpe.c
+++ b/arch/x86/cpu/acpi_gpe.c
@@ -6,10 +6,10 @@
 
 #define LOG_CATEGORY	UCLASS_IRQ
 
-#include <common.h>
 #include <dm.h>
 #include <irq.h>
 #include <log.h>
+#include <time.h>
 #include <acpi/acpi_device.h>
 #include <asm/io.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index c610a7f44770..76230aea837d 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <log.h>
diff --git a/arch/x86/cpu/apollolake/cpu.c b/arch/x86/cpu/apollolake/cpu.c
index 647c9df6a72b..f480bb1d8c34 100644
--- a/arch/x86/cpu/apollolake/cpu.c
+++ b/arch/x86/cpu/apollolake/cpu.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <log.h>
diff --git a/arch/x86/cpu/apollolake/cpu_common.c b/arch/x86/cpu/apollolake/cpu_common.c
index 9a5502617bf5..498b306cd618 100644
--- a/arch/x86/cpu/apollolake/cpu_common.c
+++ b/arch/x86/cpu/apollolake/cpu_common.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/cpu_common.h>
diff --git a/arch/x86/cpu/apollolake/cpu_spl.c b/arch/x86/cpu/apollolake/cpu_spl.c
index 8f48457ee220..8798fa79d4c1 100644
--- a/arch/x86/cpu/apollolake/cpu_spl.c
+++ b/arch/x86/cpu/apollolake/cpu_spl.c
@@ -5,7 +5,6 @@
  * Portions taken from coreboot
  */
 
-#include <common.h>
 #include <dm.h>
 #include <ec_commands.h>
 #include <init.h>
diff --git a/arch/x86/cpu/apollolake/fsp_bindings.c b/arch/x86/cpu/apollolake/fsp_bindings.c
index fb75e1f70951..f6fbddce922a 100644
--- a/arch/x86/cpu/apollolake/fsp_bindings.c
+++ b/arch/x86/cpu/apollolake/fsp_bindings.c
@@ -3,7 +3,6 @@
  * Copyright 2020 B&R Industrial Automation GmbH - http://www.br-automation.com
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/fsp_bindings.h>
diff --git a/arch/x86/cpu/apollolake/fsp_m.c b/arch/x86/cpu/apollolake/fsp_m.c
index c6be707e4eaf..19065e17ae04 100644
--- a/arch/x86/cpu/apollolake/fsp_m.c
+++ b/arch/x86/cpu/apollolake/fsp_m.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/iomap.h>
diff --git a/arch/x86/cpu/apollolake/fsp_s.c b/arch/x86/cpu/apollolake/fsp_s.c
index a9b13c0c7047..5fca19f90d38 100644
--- a/arch/x86/cpu/apollolake/fsp_s.c
+++ b/arch/x86/cpu/apollolake/fsp_s.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <binman.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/arch/x86/cpu/apollolake/hostbridge.c b/arch/x86/cpu/apollolake/hostbridge.c
index 2405dec8525b..9ee362239efe 100644
--- a/arch/x86/cpu/apollolake/hostbridge.c
+++ b/arch/x86/cpu/apollolake/hostbridge.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY UCLASS_NORTHBRIDGE
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <log.h>
diff --git a/arch/x86/cpu/apollolake/lpc.c b/arch/x86/cpu/apollolake/lpc.c
index 4be6366f0438..531ff1cd91f4 100644
--- a/arch/x86/cpu/apollolake/lpc.c
+++ b/arch/x86/cpu/apollolake/lpc.c
@@ -5,7 +5,6 @@
  * From coreboot Apollo Lake support lpc.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <spl.h>
diff --git a/arch/x86/cpu/apollolake/pch.c b/arch/x86/cpu/apollolake/pch.c
index a0f9b031dea3..32190312ff8c 100644
--- a/arch/x86/cpu/apollolake/pch.c
+++ b/arch/x86/cpu/apollolake/pch.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pch.h>
 #include <spl.h>
diff --git a/arch/x86/cpu/apollolake/pmc.c b/arch/x86/cpu/apollolake/pmc.c
index 163119e2e9e9..32fd0344861e 100644
--- a/arch/x86/cpu/apollolake/pmc.c
+++ b/arch/x86/cpu/apollolake/pmc.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_ACPI_PMC
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <log.h>
diff --git a/arch/x86/cpu/apollolake/punit.c b/arch/x86/cpu/apollolake/punit.c
index 5ed7963579ea..b1503c25140a 100644
--- a/arch/x86/cpu/apollolake/punit.c
+++ b/arch/x86/cpu/apollolake/punit.c
@@ -3,10 +3,10 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <spl.h>
+#include <time.h>
 #include <asm/cpu.h>
 #include <asm/cpu_common.h>
 #include <asm/intel_regs.h>
diff --git a/arch/x86/cpu/apollolake/spl.c b/arch/x86/cpu/apollolake/spl.c
index 6078d5a200e8..b351d73e7d8b 100644
--- a/arch/x86/cpu/apollolake/spl.c
+++ b/arch/x86/cpu/apollolake/spl.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
-#include <common.h>
 #include <binman_sym.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/arch/x86/cpu/apollolake/systemagent.c b/arch/x86/cpu/apollolake/systemagent.c
index b6bc2ba14f15..f966b9083fc2 100644
--- a/arch/x86/cpu/apollolake/systemagent.c
+++ b/arch/x86/cpu/apollolake/systemagent.c
@@ -4,7 +4,6 @@
  * Take from coreboot project file of the same name
  */
 
-#include <common.h>
 #include <asm/intel_regs.h>
 #include <asm/io.h>
 #include <asm/arch/systemagent.h>
diff --git a/arch/x86/cpu/apollolake/uart.c b/arch/x86/cpu/apollolake/uart.c
index a9362436000c..7e4c816dcef0 100644
--- a/arch/x86/cpu/apollolake/uart.c
+++ b/arch/x86/cpu/apollolake/uart.c
@@ -7,7 +7,6 @@
  * Some code from coreboot lpss.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <malloc.h>
diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index ccc4851b1881..7821964f1fca 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <log.h>
diff --git a/arch/x86/cpu/baytrail/cpu.c b/arch/x86/cpu/baytrail/cpu.c
index c270426d8208..7756a1a4a8e8 100644
--- a/arch/x86/cpu/baytrail/cpu.c
+++ b/arch/x86/cpu/baytrail/cpu.c
@@ -5,7 +5,6 @@
  * Based on code from coreboot
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <event.h>
diff --git a/arch/x86/cpu/baytrail/early_uart.c b/arch/x86/cpu/baytrail/early_uart.c
index 08dbd5538f7a..3736127239e5 100644
--- a/arch/x86/cpu/baytrail/early_uart.c
+++ b/arch/x86/cpu/baytrail/early_uart.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <errno.h>
 #include <asm/io.h>
 
diff --git a/arch/x86/cpu/baytrail/fsp_configs.c b/arch/x86/cpu/baytrail/fsp_configs.c
index fb3f946c45f9..9eb456f90d10 100644
--- a/arch/x86/cpu/baytrail/fsp_configs.c
+++ b/arch/x86/cpu/baytrail/fsp_configs.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015, Kodak Alaris, Inc
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/fsp1/fsp_support.h>
diff --git a/arch/x86/cpu/baytrail/valleyview.c b/arch/x86/cpu/baytrail/valleyview.c
index f73738ce5c01..839ff4d2bf21 100644
--- a/arch/x86/cpu/baytrail/valleyview.c
+++ b/arch/x86/cpu/baytrail/valleyview.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <mmc.h>
 #include <pci_ids.h>
@@ -11,6 +10,7 @@
 #include <asm/mrccache.h>
 #include <asm/post.h>
 #include <asm/arch/iomap.h>
+#include <asm/u-boot-x86.h>
 #include <linux/bitops.h>
 
 /* GPIO SUS */
diff --git a/arch/x86/cpu/braswell/braswell.c b/arch/x86/cpu/braswell/braswell.c
index 3345049993d6..8cf4b628d41a 100644
--- a/arch/x86/cpu/braswell/braswell.c
+++ b/arch/x86/cpu/braswell/braswell.c
@@ -3,10 +3,10 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/mrccache.h>
 #include <asm/post.h>
+#include <asm/u-boot-x86.h>
 
 int arch_cpu_init(void)
 {
diff --git a/arch/x86/cpu/braswell/early_uart.c b/arch/x86/cpu/braswell/early_uart.c
index d78c6b0feb6a..8b28d28d1366 100644
--- a/arch/x86/cpu/braswell/early_uart.c
+++ b/arch/x86/cpu/braswell/early_uart.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 
 #define PCI_DEV_CONFIG(segbus, dev, fn) ( \
diff --git a/arch/x86/cpu/braswell/fsp_configs.c b/arch/x86/cpu/braswell/fsp_configs.c
index 243298fd5718..aaf3e67f81cc 100644
--- a/arch/x86/cpu/braswell/fsp_configs.c
+++ b/arch/x86/cpu/braswell/fsp_configs.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/fsp1/fsp_support.h>
diff --git a/arch/x86/cpu/broadwell/adsp.c b/arch/x86/cpu/broadwell/adsp.c
index 1fa18237809c..90b2449475e5 100644
--- a/arch/x86/cpu/broadwell/adsp.c
+++ b/arch/x86/cpu/broadwell/adsp.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_SYSCON
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index cbd4a3b67973..dc6717eca40e 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -5,7 +5,6 @@
  * Based on code from coreboot src/soc/intel/broadwell/cpu.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <cpu.h>
 #include <event.h>
diff --git a/arch/x86/cpu/broadwell/cpu_from_spl.c b/arch/x86/cpu/broadwell/cpu_from_spl.c
index df5a9675ee4b..a48be2959943 100644
--- a/arch/x86/cpu/broadwell/cpu_from_spl.c
+++ b/arch/x86/cpu/broadwell/cpu_from_spl.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bloblist.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
@@ -13,6 +12,7 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/mtrr.h>
+#include <linux/errno.h>
 
 int misc_init_r(void)
 {
diff --git a/arch/x86/cpu/broadwell/cpu_full.c b/arch/x86/cpu/broadwell/cpu_full.c
index 2049dbfe24a5..c43fb7a608b4 100644
--- a/arch/x86/cpu/broadwell/cpu_full.c
+++ b/arch/x86/cpu/broadwell/cpu_full.c
@@ -5,7 +5,6 @@
  * Based on code from coreboot src/soc/intel/broadwell/cpu.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <cpu.h>
 #include <init.h>
diff --git a/arch/x86/cpu/broadwell/iobp.c b/arch/x86/cpu/broadwell/iobp.c
index cb5595c930e1..f8b2a60d09f1 100644
--- a/arch/x86/cpu/broadwell/iobp.c
+++ b/arch/x86/cpu/broadwell/iobp.c
@@ -5,7 +5,6 @@
  * Modified from coreboot
  */
 
-#include <common.h>
 #include <errno.h>
 #include <asm/intel_regs.h>
 #include <asm/io.h>
diff --git a/arch/x86/cpu/broadwell/lpc.c b/arch/x86/cpu/broadwell/lpc.c
index d2638a4e7a6b..b945693f1cf9 100644
--- a/arch/x86/cpu/broadwell/lpc.c
+++ b/arch/x86/cpu/broadwell/lpc.c
@@ -5,7 +5,6 @@
  * From coreboot broadwell support
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pch.h>
diff --git a/arch/x86/cpu/broadwell/me.c b/arch/x86/cpu/broadwell/me.c
index ae16ce264992..3399d822e5b6 100644
--- a/arch/x86/cpu/broadwell/me.c
+++ b/arch/x86/cpu/broadwell/me.c
@@ -5,7 +5,6 @@
  * Based on code from coreboot src/soc/intel/broadwell/me_status.c
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <asm/arch/me.h>
diff --git a/arch/x86/cpu/broadwell/northbridge.c b/arch/x86/cpu/broadwell/northbridge.c
index 141babc51c3a..d67ab03627d1 100644
--- a/arch/x86/cpu/broadwell/northbridge.c
+++ b/arch/x86/cpu/broadwell/northbridge.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011 The Chromium Authors
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/x86/cpu/broadwell/pch.c b/arch/x86/cpu/broadwell/pch.c
index 37fcddbb9b03..2c8b7380d962 100644
--- a/arch/x86/cpu/broadwell/pch.c
+++ b/arch/x86/cpu/broadwell/pch.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pch.h>
diff --git a/arch/x86/cpu/broadwell/pinctrl_broadwell.c b/arch/x86/cpu/broadwell/pinctrl_broadwell.c
index 85bd37101ba2..b6313c3466a4 100644
--- a/arch/x86/cpu/broadwell/pinctrl_broadwell.c
+++ b/arch/x86/cpu/broadwell/pinctrl_broadwell.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/broadwell/power_state.c b/arch/x86/cpu/broadwell/power_state.c
index 62fd2e8d2c0e..e1d60915f55a 100644
--- a/arch/x86/cpu/broadwell/power_state.c
+++ b/arch/x86/cpu/broadwell/power_state.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Google, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <pci.h>
 #include <asm/io.h>
diff --git a/arch/x86/cpu/broadwell/refcode.c b/arch/x86/cpu/broadwell/refcode.c
index df2df7972e98..653d31dd67c5 100644
--- a/arch/x86/cpu/broadwell/refcode.c
+++ b/arch/x86/cpu/broadwell/refcode.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
+#include <config.h>
 #include <display_options.h>
 #include <errno.h>
 #include <init.h>
diff --git a/arch/x86/cpu/broadwell/sata.c b/arch/x86/cpu/broadwell/sata.c
index be3c9e764ef3..0f67ba9666f6 100644
--- a/arch/x86/cpu/broadwell/sata.c
+++ b/arch/x86/cpu/broadwell/sata.c
@@ -5,7 +5,6 @@
  * From coreboot src/soc/intel/broadwell/sata.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdram.c
index d30ebee021ea..cd534a17cf15 100644
--- a/arch/x86/cpu/broadwell/sdram.c
+++ b/arch/x86/cpu/broadwell/sdram.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index 82fe4c71cd27..d474c79e25ef 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -5,7 +5,6 @@
  * Graeme Russ, graeme.russ@gmail.com.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <event.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/coreboot/coreboot_spl.c b/arch/x86/cpu/coreboot/coreboot_spl.c
index 36661871e923..566c65a96aed 100644
--- a/arch/x86/cpu/coreboot/coreboot_spl.c
+++ b/arch/x86/cpu/coreboot/coreboot_spl.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Google LLC
  */
 
-#include <common.h>
 #include <init.h>
 
 int dram_init(void)
diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
index 26352df421f7..ee0491eab1c8 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/arch/x86/cpu/coreboot/sdram.c
@@ -5,11 +5,11 @@
  * Graeme Russ, <graeme.russ@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/e820.h>
 #include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/coreboot/timestamp.c b/arch/x86/cpu/coreboot/timestamp.c
index 3ad611a530c4..ec4003c4e77e 100644
--- a/arch/x86/cpu/coreboot/timestamp.c
+++ b/arch/x86/cpu/coreboot/timestamp.c
@@ -5,10 +5,10 @@
  * Modified from the coreboot version
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <asm/arch/timestamp.h>
 #include <asm/cb_sysinfo.h>
+#include <asm/u-boot-x86.h>
 #include <linux/compiler.h>
 
 static struct timestamp_table *ts_table  __section(".data");
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index ce55efc454bf..c8433360f28e 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -20,7 +20,6 @@
 
 #define LOG_CATEGORY	UCLASS_CPU
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
diff --git a/arch/x86/cpu/cpu_x86.c b/arch/x86/cpu/cpu_x86.c
index 59da41f38333..6c53f0ea821f 100644
--- a/arch/x86/cpu/cpu_x86.c
+++ b/arch/x86/cpu/cpu_x86.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/cpu/efi/app.c b/arch/x86/cpu/efi/app.c
index f754489784a7..218a68c4642d 100644
--- a/arch/x86/cpu/efi/app.c
+++ b/arch/x86/cpu/efi/app.c
@@ -3,11 +3,11 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <netdev.h>
+#include <asm/u-boot-x86.h>
 
 int arch_cpu_init(void)
 {
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 708bfbe7ee48..cb57f15f710b 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <efi.h>
 #include <efi_api.h>
@@ -17,6 +16,8 @@
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/post.h>
+#include <asm/u-boot.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/efi/sdram.c b/arch/x86/cpu/efi/sdram.c
index 56f3326146ca..1f0e87735b21 100644
--- a/arch/x86/cpu/efi/sdram.c
+++ b/arch/x86/cpu/efi/sdram.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <efi.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 8882532ebf3a..db2727d74851 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -18,7 +18,6 @@
  * src/arch/x86/lib/cpu.c
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
@@ -32,6 +31,7 @@
 #include <asm/msr.h>
 #include <asm/mtrr.h>
 #include <asm/processor-flags.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/i386/interrupt.c b/arch/x86/cpu/i386/interrupt.c
index f3f3527237f2..b3f4214acdb7 100644
--- a/arch/x86/cpu/i386/interrupt.c
+++ b/arch/x86/cpu/i386/interrupt.c
@@ -10,7 +10,6 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <hang.h>
diff --git a/arch/x86/cpu/intel_common/acpi.c b/arch/x86/cpu/intel_common/acpi.c
index d94ec208f65d..29676b4abfae 100644
--- a/arch/x86/cpu/intel_common/acpi.c
+++ b/arch/x86/cpu/intel_common/acpi.c
@@ -8,7 +8,6 @@
  * Modified from coreboot src/soc/intel/common/block/acpi.c
  */
 
-#include <common.h>
 #include <bloblist.h>
 #include <cpu.h>
 #include <dm.h>
diff --git a/arch/x86/cpu/intel_common/car.S b/arch/x86/cpu/intel_common/car.S
index 00308dbdef9b..46d9ede09cb0 100644
--- a/arch/x86/cpu/intel_common/car.S
+++ b/arch/x86/cpu/intel_common/car.S
@@ -10,7 +10,6 @@
  * Copyright (C) 2012 Kyösti Mälkki <kyosti.malkki@gmail.com>
  */
 
-#include <common.h>
 #include <asm/microcode.h>
 #include <asm/msr-index.h>
 #include <asm/mtrr.h>
diff --git a/arch/x86/cpu/intel_common/cpu.c b/arch/x86/cpu/intel_common/cpu.c
index 8f489e6c651c..e7f419130429 100644
--- a/arch/x86/cpu/intel_common/cpu.c
+++ b/arch/x86/cpu/intel_common/cpu.c
@@ -7,7 +7,6 @@
  * Some code taken from coreboot cpulib.c
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/cpu/intel_common/cpu_from_spl.c b/arch/x86/cpu/intel_common/cpu_from_spl.c
index 1c0dcedb5824..48b2ef253cbd 100644
--- a/arch/x86/cpu/intel_common/cpu_from_spl.c
+++ b/arch/x86/cpu/intel_common/cpu_from_spl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <handoff.h>
diff --git a/arch/x86/cpu/intel_common/fast_spi.c b/arch/x86/cpu/intel_common/fast_spi.c
index 5d3944dee2c8..e1d536be2122 100644
--- a/arch/x86/cpu/intel_common/fast_spi.c
+++ b/arch/x86/cpu/intel_common/fast_spi.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/cpu_common.h>
 #include <asm/fast_spi.h>
diff --git a/arch/x86/cpu/intel_common/generic_wifi.c b/arch/x86/cpu/intel_common/generic_wifi.c
index 61ec5391b094..75fa4e01d8ad 100644
--- a/arch/x86/cpu/intel_common/generic_wifi.c
+++ b/arch/x86/cpu/intel_common/generic_wifi.c
@@ -6,7 +6,6 @@
  * Modified from coreboot src/drivers/wifi/generic.c
  */
 
-#include <common.h>
 #include <log.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
diff --git a/arch/x86/cpu/intel_common/intel_opregion.c b/arch/x86/cpu/intel_common/intel_opregion.c
index 1eed21d8cdf8..78caff0dc123 100644
--- a/arch/x86/cpu/intel_common/intel_opregion.c
+++ b/arch/x86/cpu/intel_common/intel_opregion.c
@@ -6,7 +6,6 @@
  * Modified from coreboot src/soc/intel/gma/opregion.c
  */
 
-#include <common.h>
 #include <binman.h>
 #include <bloblist.h>
 #include <dm.h>
diff --git a/arch/x86/cpu/intel_common/itss.c b/arch/x86/cpu/intel_common/itss.c
index ec73b3d89312..6d3184f969f9 100644
--- a/arch/x86/cpu/intel_common/itss.c
+++ b/arch/x86/cpu/intel_common/itss.c
@@ -9,7 +9,6 @@
  * Taken from coreboot itss.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <irq.h>
diff --git a/arch/x86/cpu/intel_common/lpc.c b/arch/x86/cpu/intel_common/lpc.c
index af68c0f079c4..f2bdf8c1e878 100644
--- a/arch/x86/cpu/intel_common/lpc.c
+++ b/arch/x86/cpu/intel_common/lpc.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/intel_common/lpss.c b/arch/x86/cpu/intel_common/lpss.c
index 26a2d2d1e36d..44cd3f0ca5f6 100644
--- a/arch/x86/cpu/intel_common/lpss.c
+++ b/arch/x86/cpu/intel_common/lpss.c
@@ -7,7 +7,6 @@
  * Some code from coreboot lpss.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/io.h>
diff --git a/arch/x86/cpu/intel_common/me_status.c b/arch/x86/cpu/intel_common/me_status.c
index abc5f6fbc77b..a09bd5029ebb 100644
--- a/arch/x86/cpu/intel_common/me_status.c
+++ b/arch/x86/cpu/intel_common/me_status.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011 The Chromium OS Authors. All rights reserved.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/arch/me.h>
 
diff --git a/arch/x86/cpu/intel_common/microcode.c b/arch/x86/cpu/intel_common/microcode.c
index 4d8e1d210838..6cad2727075c 100644
--- a/arch/x86/cpu/intel_common/microcode.c
+++ b/arch/x86/cpu/intel_common/microcode.c
@@ -6,7 +6,6 @@
  * Microcode update for Intel PIII and later CPUs
  */
 
-#include <common.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index ff959d1bd8d8..c834c05d1308 100644
--- a/arch/x86/cpu/intel_common/mrc.c
+++ b/arch/x86/cpu/intel_common/mrc.c
@@ -5,17 +5,17 @@
 
 #define LOG_CATEGORY	UCLASS_RAM
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
 #include <spl.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/intel_regs.h>
-#include <asm/mrc_common.h>
 #include <asm/pch_common.h>
 #include <asm/post.h>
 #include <asm/arch/me.h>
diff --git a/arch/x86/cpu/intel_common/p2sb.c b/arch/x86/cpu/intel_common/p2sb.c
index e4e53f73c08d..7aad8f8ca56a 100644
--- a/arch/x86/cpu/intel_common/p2sb.c
+++ b/arch/x86/cpu/intel_common/p2sb.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_P2SB
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <log.h>
diff --git a/arch/x86/cpu/intel_common/pch.c b/arch/x86/cpu/intel_common/pch.c
index af82b64a13c7..c4cc478b3064 100644
--- a/arch/x86/cpu/intel_common/pch.c
+++ b/arch/x86/cpu/intel_common/pch.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/pch_common.h>
 
diff --git a/arch/x86/cpu/intel_common/report_platform.c b/arch/x86/cpu/intel_common/report_platform.c
index a3612817c45b..a7524435ba03 100644
--- a/arch/x86/cpu/intel_common/report_platform.c
+++ b/arch/x86/cpu/intel_common/report_platform.c
@@ -5,12 +5,12 @@
  * Copyright (C) 2012 Google Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/cpu.h>
 #include <asm/pci.h>
 #include <asm/report_platform.h>
 #include <asm/arch/pch.h>
+#include <linux/string.h>
 
 static void report_cpu_info(void)
 {
diff --git a/arch/x86/cpu/ioapic.c b/arch/x86/cpu/ioapic.c
index 4f99de6ece2b..fa912bac57dd 100644
--- a/arch/x86/cpu/ioapic.c
+++ b/arch/x86/cpu/ioapic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/ioapic.h>
diff --git a/arch/x86/cpu/irq.c b/arch/x86/cpu/irq.c
index 766b2451a2cc..d4dd1816092b 100644
--- a/arch/x86/cpu/irq.c
+++ b/arch/x86/cpu/irq.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/bd82x6x.c b/arch/x86/cpu/ivybridge/bd82x6x.c
index 417290f559e9..8ae4798f125c 100644
--- a/arch/x86/cpu/ivybridge/bd82x6x.c
+++ b/arch/x86/cpu/ivybridge/bd82x6x.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2014 Google, Inc
  */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/cpu.c b/arch/x86/cpu/ivybridge/cpu.c
index e71a10bfd441..d71ab0a6385e 100644
--- a/arch/x86/cpu/ivybridge/cpu.c
+++ b/arch/x86/cpu/ivybridge/cpu.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2011 Google Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/cpu/ivybridge/early_me.c b/arch/x86/cpu/ivybridge/early_me.c
index bee1671baf8b..ac868025f8ed 100644
--- a/arch/x86/cpu/ivybridge/early_me.c
+++ b/arch/x86/cpu/ivybridge/early_me.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011 The Chromium OS Authors. All rights reserved.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/arch/x86/cpu/ivybridge/fsp_configs.c b/arch/x86/cpu/ivybridge/fsp_configs.c
index 3c4ea6c267f8..19b6ef283bc0 100644
--- a/arch/x86/cpu/ivybridge/fsp_configs.c
+++ b/arch/x86/cpu/ivybridge/fsp_configs.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/fsp1/fsp_support.h>
diff --git a/arch/x86/cpu/ivybridge/ivybridge.c b/arch/x86/cpu/ivybridge/ivybridge.c
index eb3f362e4e99..81b54bb8dda5 100644
--- a/arch/x86/cpu/ivybridge/ivybridge.c
+++ b/arch/x86/cpu/ivybridge/ivybridge.c
@@ -3,10 +3,10 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/post.h>
 #include <asm/processor.h>
+#include <asm/u-boot-x86.h>
 
 int arch_cpu_init(void)
 {
diff --git a/arch/x86/cpu/ivybridge/lpc.c b/arch/x86/cpu/ivybridge/lpc.c
index f931d2be1b52..17a47edadbb8 100644
--- a/arch/x86/cpu/ivybridge/lpc.c
+++ b/arch/x86/cpu/ivybridge/lpc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2008-2009 coresystems GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/model_206ax.c b/arch/x86/cpu/ivybridge/model_206ax.c
index 3906a69796f3..b72de96a277e 100644
--- a/arch/x86/cpu/ivybridge/model_206ax.c
+++ b/arch/x86/cpu/ivybridge/model_206ax.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2011 The Chromium Authors
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/northbridge.c b/arch/x86/cpu/ivybridge/northbridge.c
index 994f8a4ff6a5..76e52f38ad83 100644
--- a/arch/x86/cpu/ivybridge/northbridge.c
+++ b/arch/x86/cpu/ivybridge/northbridge.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2011 The Chromium Authors
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/cpu/ivybridge/sata.c b/arch/x86/cpu/ivybridge/sata.c
index f47ecdffae76..4e2484fa956d 100644
--- a/arch/x86/cpu/ivybridge/sata.c
+++ b/arch/x86/cpu/ivybridge/sata.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2008-2009 coresystems GmbH
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/sdram.c b/arch/x86/cpu/ivybridge/sdram.c
index 95a826da7130..bddec6c66b66 100644
--- a/arch/x86/cpu/ivybridge/sdram.c
+++ b/arch/x86/cpu/ivybridge/sdram.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY	UCLASS_RAM
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/cpu/ivybridge/sdram_nop.c b/arch/x86/cpu/ivybridge/sdram_nop.c
index 51dfe23f94d0..e7ec35bbe2a6 100644
--- a/arch/x86/cpu/ivybridge/sdram_nop.c
+++ b/arch/x86/cpu/ivybridge/sdram_nop.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/lapic.c b/arch/x86/cpu/lapic.c
index c0691454f129..55b1b1833eed 100644
--- a/arch/x86/cpu/lapic.c
+++ b/arch/x86/cpu/lapic.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2014 Google, Inc
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/lapic.h>
diff --git a/arch/x86/cpu/mp_init.c b/arch/x86/cpu/mp_init.c
index a133a5d81161..aa1f47d7227e 100644
--- a/arch/x86/cpu/mp_init.c
+++ b/arch/x86/cpu/mp_init.c
@@ -5,13 +5,13 @@
  * Based on code from the coreboot file of the same name
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <qfw.h>
+#include <time.h>
 #include <asm/atomic.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index 9c24ae984e90..50cba5fb88dc 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -16,7 +16,6 @@
  * since the MTRR registers are sometimes in flux.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <sort.h>
diff --git a/arch/x86/cpu/pci.c b/arch/x86/cpu/pci.c
index 8a992ed82339..a7ad57f6de03 100644
--- a/arch/x86/cpu/pci.c
+++ b/arch/x86/cpu/pci.c
@@ -8,7 +8,6 @@
  * Daniel Engström, Omicron Ceti AB, <daniel@omicron.se>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/arch/x86/cpu/qemu/cpu.c b/arch/x86/cpu/qemu/cpu.c
index 735b6560843a..0708a380626f 100644
--- a/arch/x86/cpu/qemu/cpu.c
+++ b/arch/x86/cpu/qemu/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Miao Yan <yanmiaobest@gmail.com>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index d83abf005271..6ac363f3d8c7 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -3,11 +3,11 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/post.h>
 #include <asm/arch/qemu.h>
+#include <asm/u-boot.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/qemu/e820.c b/arch/x86/cpu/qemu/e820.c
index ebfe5956442a..17a04f86479e 100644
--- a/arch/x86/cpu/qemu/e820.c
+++ b/arch/x86/cpu/qemu/e820.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2019 Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <env_internal.h>
 #include <malloc.h>
 #include <asm/e820.h>
diff --git a/arch/x86/cpu/qemu/qemu.c b/arch/x86/cpu/qemu/qemu.c
index 70414556086c..262584d01f0f 100644
--- a/arch/x86/cpu/qemu/qemu.c
+++ b/arch/x86/cpu/qemu/qemu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <pci.h>
@@ -14,6 +13,7 @@
 #include <asm/processor.h>
 #include <asm/arch/device.h>
 #include <asm/arch/qemu.h>
+#include <asm/u-boot-x86.h>
 
 static bool i440fx;
 
diff --git a/arch/x86/cpu/qfw_cpu.c b/arch/x86/cpu/qfw_cpu.c
index ee00b8fe7327..468df5a36e61 100644
--- a/arch/x86/cpu/qfw_cpu.c
+++ b/arch/x86/cpu/qfw_cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 0e18ceab68d4..80e94600fc5a 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -3,13 +3,13 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/processor.h>
 #include <asm/tables.h>
 #include <asm/arch/global_nvs.h>
 #include <asm/arch/iomap.h>
+#include <linux/string.h>
 
 static int quark_write_fadt(struct acpi_ctx *ctx,
 			    const struct acpi_writer *entry)
diff --git a/arch/x86/cpu/quark/dram.c b/arch/x86/cpu/quark/dram.c
index ad98f3e07bae..7d32b98e8daf 100644
--- a/arch/x86/cpu/quark/dram.c
+++ b/arch/x86/cpu/quark/dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <fdtdec.h>
@@ -18,6 +17,7 @@
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/quark/hte.c b/arch/x86/cpu/quark/hte.c
index df14779357d5..3cca6bd4c227 100644
--- a/arch/x86/cpu/quark/hte.c
+++ b/arch/x86/cpu/quark/hte.c
@@ -7,7 +7,6 @@
  * QuarkSocPkg/QuarkNorthCluster/MemoryInit/Pei
  */
 
-#include <common.h>
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
 #include "mrc_util.h"
diff --git a/arch/x86/cpu/quark/mrc.c b/arch/x86/cpu/quark/mrc.c
index ce3c2b8ab426..be9c36b96c4f 100644
--- a/arch/x86/cpu/quark/mrc.c
+++ b/arch/x86/cpu/quark/mrc.c
@@ -32,9 +32,9 @@
  * DRAM unit configuration based on Valleyview MRC.
  */
 
-#include <common.h>
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
+#include <asm/u-boot-x86.h>
 #include "mrc_util.h"
 #include "smc.h"
 
diff --git a/arch/x86/cpu/quark/mrc_util.c b/arch/x86/cpu/quark/mrc_util.c
index b0bc59b71ef5..85408b3e3352 100644
--- a/arch/x86/cpu/quark/mrc_util.c
+++ b/arch/x86/cpu/quark/mrc_util.c
@@ -7,12 +7,12 @@
  * QuarkSocPkg/QuarkNorthCluster/MemoryInit/Pei
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/arch/device.h>
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
+#include <asm/u-boot-x86.h>
 #include "mrc_util.h"
 #include "hte.h"
 #include "smc.h"
diff --git a/arch/x86/cpu/quark/msg_port.c b/arch/x86/cpu/quark/msg_port.c
index d4f8c082ffc2..6261766cdf88 100644
--- a/arch/x86/cpu/quark/msg_port.c
+++ b/arch/x86/cpu/quark/msg_port.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch/device.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
diff --git a/arch/x86/cpu/quark/quark.c b/arch/x86/cpu/quark/quark.c
index 62b83c228cfb..fdf92b2c0c3a 100644
--- a/arch/x86/cpu/quark/quark.c
+++ b/arch/x86/cpu/quark/quark.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <event.h>
 #include <init.h>
@@ -19,6 +18,7 @@
 #include <asm/arch/device.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
+#include <asm/u-boot-x86.h>
 #include <linux/delay.h>
 
 static void quark_setup_mtrr(void)
diff --git a/arch/x86/cpu/quark/smc.c b/arch/x86/cpu/quark/smc.c
index b4b3e1204bd5..a7e92b3f5c16 100644
--- a/arch/x86/cpu/quark/smc.c
+++ b/arch/x86/cpu/quark/smc.c
@@ -7,11 +7,12 @@
  * QuarkSocPkg/QuarkNorthCluster/MemoryInit/Pei
  */
 
-#include <common.h>
 #include <pci.h>
 #include <asm/arch/device.h>
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
+#include <asm/u-boot-x86.h>
+#include <linux/string.h>
 #include "mrc_util.h"
 #include "hte.h"
 #include "smc.h"
diff --git a/arch/x86/cpu/queensbay/fsp_configs.c b/arch/x86/cpu/queensbay/fsp_configs.c
index 381edd076158..3b5cbdb44f1a 100644
--- a/arch/x86/cpu/queensbay/fsp_configs.c
+++ b/arch/x86/cpu/queensbay/fsp_configs.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/fsp1/fsp_support.h>
 
 void fsp_update_configs(struct fsp_config_data *config,
diff --git a/arch/x86/cpu/queensbay/tnc.c b/arch/x86/cpu/queensbay/tnc.c
index 4a008622d19e..7c7eb413f993 100644
--- a/arch/x86/cpu/queensbay/tnc.c
+++ b/arch/x86/cpu/queensbay/tnc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <dm/device-internal.h>
diff --git a/arch/x86/cpu/slimbootloader/sdram.c b/arch/x86/cpu/slimbootloader/sdram.c
index fbb33b246e5b..75ca5273625c 100644
--- a/arch/x86/cpu/slimbootloader/sdram.c
+++ b/arch/x86/cpu/slimbootloader/sdram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
diff --git a/arch/x86/cpu/slimbootloader/serial.c b/arch/x86/cpu/slimbootloader/serial.c
index d28b280890d3..4c889dad6d2d 100644
--- a/arch/x86/cpu/slimbootloader/serial.c
+++ b/arch/x86/cpu/slimbootloader/serial.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <ns16550.h>
diff --git a/arch/x86/cpu/slimbootloader/slimbootloader.c b/arch/x86/cpu/slimbootloader/slimbootloader.c
index ec5b87cfd63f..142c9341cf86 100644
--- a/arch/x86/cpu/slimbootloader/slimbootloader.c
+++ b/arch/x86/cpu/slimbootloader/slimbootloader.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 1d37cc9e2b0d..d4d0ef6f8552 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -5,7 +5,6 @@
  * Partially based on acpi.c for other x86 platforms
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <mapmem.h>
diff --git a/arch/x86/cpu/tangier/pinmux.c b/arch/x86/cpu/tangier/pinmux.c
index 23bfa7c18d2c..6afb8646a987 100644
--- a/arch/x86/cpu/tangier/pinmux.c
+++ b/arch/x86/cpu/tangier/pinmux.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Emlid Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/arch/x86/cpu/tangier/sdram.c b/arch/x86/cpu/tangier/sdram.c
index 374b262b1348..7e1d290fc595 100644
--- a/arch/x86/cpu/tangier/sdram.c
+++ b/arch/x86/cpu/tangier/sdram.c
@@ -3,12 +3,12 @@
  * Copyright (c) 2017 Intel Corporation
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/sfi.h>
+#include <asm/u-boot.h>
 #include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/tangier/sysreset.c b/arch/x86/cpu/tangier/sysreset.c
index b03bc28f9353..f57423a611d2 100644
--- a/arch/x86/cpu/tangier/sysreset.c
+++ b/arch/x86/cpu/tangier/sysreset.c
@@ -5,7 +5,6 @@
  * Reset driver for tangier processor
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sysreset.h>
 #include <asm/scu.h>
diff --git a/arch/x86/cpu/tangier/tangier.c b/arch/x86/cpu/tangier/tangier.c
index 1e2f6cc8b700..8a8f7d27a9d1 100644
--- a/arch/x86/cpu/tangier/tangier.c
+++ b/arch/x86/cpu/tangier/tangier.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2017 Intel Corporation
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/u-boot-x86.h>
diff --git a/arch/x86/cpu/turbo.c b/arch/x86/cpu/turbo.c
index e2c84cddec8e..c9b402c4dc73 100644
--- a/arch/x86/cpu/turbo.c
+++ b/arch/x86/cpu/turbo.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011 The Chromium Authors.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 5ea746ecce4d..80eab7103152 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <init.h>
diff --git a/arch/x86/cpu/x86_64/interrupts.c b/arch/x86/cpu/x86_64/interrupts.c
index 634f7660c03f..b84ff798814e 100644
--- a/arch/x86/cpu/x86_64/interrupts.c
+++ b/arch/x86/cpu/x86_64/interrupts.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <irq_func.h>
 #include <asm/processor-flags.h>
 
diff --git a/arch/x86/cpu/x86_64/misc.c b/arch/x86/cpu/x86_64/misc.c
index 691b67ff68ab..294511e6ebab 100644
--- a/arch/x86/cpu/x86_64/misc.c
+++ b/arch/x86/cpu/x86_64/misc.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <init.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/include/asm/arch-quark/mrc.h b/arch/x86/include/asm/arch-quark/mrc.h
index 2353426cd6d2..40c92a549cdf 100644
--- a/arch/x86/include/asm/arch-quark/mrc.h
+++ b/arch/x86/include/asm/arch-quark/mrc.h
@@ -10,6 +10,8 @@
 #ifndef _MRC_H_
 #define _MRC_H_
 
+#include <linux/types.h>
+
 #define MRC_VERSION	0x0111
 
 /* architectural definitions */
diff --git a/arch/x86/include/asm/arch-quark/msg_port.h b/arch/x86/include/asm/arch-quark/msg_port.h
index 9527fdad3fd4..98a9360d5435 100644
--- a/arch/x86/include/asm/arch-quark/msg_port.h
+++ b/arch/x86/include/asm/arch-quark/msg_port.h
@@ -34,6 +34,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 /**
  * msg_port_setup - set up the message port control register
  *
diff --git a/arch/x86/include/asm/arch-quark/quark.h b/arch/x86/include/asm/arch-quark/quark.h
index feca1983ba89..dec30e2b27f3 100644
--- a/arch/x86/include/asm/arch-quark/quark.h
+++ b/arch/x86/include/asm/arch-quark/quark.h
@@ -71,6 +71,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 /* variable range MTRR usage */
 enum {
 	MTRR_VAR_ROM,
diff --git a/arch/x86/include/asm/cb_sysinfo.h b/arch/x86/include/asm/cb_sysinfo.h
index 12fa395ffd28..5864b2700cec 100644
--- a/arch/x86/include/asm/cb_sysinfo.h
+++ b/arch/x86/include/asm/cb_sysinfo.h
@@ -9,6 +9,7 @@
 #define _COREBOOT_SYSINFO_H
 
 #include <asm/coreboot_tables.h>
+#include <linux/types.h>
 
 /* Maximum number of memory range definitions */
 #define SYSINFO_MAX_MEM_RANGES	32
diff --git a/arch/x86/include/asm/coreboot_tables.h b/arch/x86/include/asm/coreboot_tables.h
index 0dfb64babb96..c967e6ad0ce5 100644
--- a/arch/x86/include/asm/coreboot_tables.h
+++ b/arch/x86/include/asm/coreboot_tables.h
@@ -8,6 +8,8 @@
 #ifndef _COREBOOT_TABLES_H
 #define _COREBOOT_TABLES_H
 
+#include <linux/types.h>
+
 struct timestamp_entry {
 	u32	entry_id;
 	u64	entry_stamp;
diff --git a/arch/x86/include/asm/early_cmos.h b/arch/x86/include/asm/early_cmos.h
index 543a9e69f03a..007aeb7c23eb 100644
--- a/arch/x86/include/asm/early_cmos.h
+++ b/arch/x86/include/asm/early_cmos.h
@@ -6,6 +6,8 @@
 #ifndef __EARLY_CMOS_H
 #define __EARLY_CMOS_H
 
+#include <linux/types.h>
+
 /* CMOS actually resides in the RTC SRAM */
 #define CMOS_IO_PORT	0x70
 
diff --git a/arch/x86/include/asm/handoff.h b/arch/x86/include/asm/handoff.h
index aec49b9b815c..5f6691939eb5 100644
--- a/arch/x86/include/asm/handoff.h
+++ b/arch/x86/include/asm/handoff.h
@@ -9,6 +9,8 @@
 #ifndef __x86_asm_handoff_h
 #define __x86_asm_handoff_h
 
+#include <linux/types.h>
+
 /**
  * struct arch_spl_handoff - architecture-specific handoff info
  *
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
 
diff --git a/arch/x86/include/asm/mp.h b/arch/x86/include/asm/mp.h
index f4c4d6c257c5..7c08f7a1d5c0 100644
--- a/arch/x86/include/asm/mp.h
+++ b/arch/x86/include/asm/mp.h
@@ -11,6 +11,7 @@
 #include <asm/atomic.h>
 #include <asm/cache.h>
 #include <linux/bitops.h>
+#include <linux/errno.h>
 
 struct udevice;
 
diff --git a/arch/x86/lib/acpi.c b/arch/x86/lib/acpi.c
index 155fffabf080..a73a2539ad35 100644
--- a/arch/x86/lib/acpi.c
+++ b/arch/x86/lib/acpi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <acpi/acpi_table.h>
 #include <asm/io.h>
diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
index 08e13fdea67f..880ef31df7d9 100644
--- a/arch/x86/lib/acpi_nhlt.c
+++ b/arch/x86/lib/acpi_nhlt.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY	LOGC_ACPI
 
-#include <common.h>
 #include <binman.h>
 #include <dm.h>
 #include <log.h>
diff --git a/arch/x86/lib/acpi_s3.c b/arch/x86/lib/acpi_s3.c
index 2c70acbe7b0b..3a1e3318a15b 100644
--- a/arch/x86/lib/acpi_s3.c
+++ b/arch/x86/lib/acpi_s3.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <acpi/acpi_s3.h>
 #include <acpi/acpi_table.h>
 #include <asm/acpi.h>
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index a5683132b014..a42a7e6bbd65 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <bloblist.h>
 #include <cpu.h>
 #include <dm.h>
diff --git a/arch/x86/lib/acpigen.c b/arch/x86/lib/acpigen.c
index ea2ec2a90833..b486f8fb37d6 100644
--- a/arch/x86/lib/acpigen.c
+++ b/arch/x86/lib/acpigen.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Google LLC
  */
 
-#include <common.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_table.h>
 #include <asm/acpigen.h>
diff --git a/arch/x86/lib/asm-offsets.c b/arch/x86/lib/asm-offsets.c
index 8df67db65c39..7b2905dda56c 100644
--- a/arch/x86/lib/asm-offsets.c
+++ b/arch/x86/lib/asm-offsets.c
@@ -11,7 +11,6 @@
  * #defines from the assembly-language output.
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <linux/kbuild.h>
 
diff --git a/arch/x86/lib/bdinfo.c b/arch/x86/lib/bdinfo.c
index 124058442c55..165e8ab944f0 100644
--- a/arch/x86/lib/bdinfo.c
+++ b/arch/x86/lib/bdinfo.c
@@ -5,7 +5,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <efi.h>
 #include <init.h>
 #include <asm/cpu.h>
diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index f146bbd54227..03f7360032c6 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2007 Advanced Micro Devices, Inc.
  * Copyright (C) 2009-2010 coresystems GmbH
  */
-#include <common.h>
 #include <compiler.h>
 #include <bios_emul.h>
 #include <irq_func.h>
diff --git a/arch/x86/lib/bios_interrupts.c b/arch/x86/lib/bios_interrupts.c
index d6b4da7e2502..b2cf1527b1cd 100644
--- a/arch/x86/lib/bios_interrupts.c
+++ b/arch/x86/lib/bios_interrupts.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2007-2009 coresystems GmbH
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/pci.h>
 #include "bios_emul.h"
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 050c420e86b6..2c889bcd33c5 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
diff --git a/arch/x86/lib/cmd_boot.c b/arch/x86/lib/cmd_boot.c
index 4facbe5f32fb..0444a5f89d3c 100644
--- a/arch/x86/lib/cmd_boot.c
+++ b/arch/x86/lib/cmd_boot.c
@@ -14,7 +14,6 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/lib/coreboot/cb_support.c b/arch/x86/lib/coreboot/cb_support.c
index ebb45cdfb5b5..b4d5fa4af327 100644
--- a/arch/x86/lib/coreboot/cb_support.c
+++ b/arch/x86/lib/coreboot/cb_support.c
@@ -5,9 +5,9 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <asm/cb_sysinfo.h>
 #include <asm/e820.h>
+#include <linux/kernel.h>
 
 unsigned int cb_install_e820_map(unsigned int max_entries,
 				 struct e820_entry *entries)
diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/arch/x86/lib/coreboot/cb_sysinfo.c
index f7fd9ea5bcbb..ec997fa49cf2 100644
--- a/arch/x86/lib/coreboot/cb_sysinfo.c
+++ b/arch/x86/lib/coreboot/cb_sysinfo.c
@@ -6,12 +6,12 @@
  * Copyright (C) 2009 coresystems GmbH
  */
 
-#include <common.h>
 #include <asm/cb_sysinfo.h>
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/coreboot_table.c b/arch/x86/lib/coreboot_table.c
index 05519d851a9d..33fce5d0a5e5 100644
--- a/arch/x86/lib/coreboot_table.c
+++ b/arch/x86/lib/coreboot_table.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <net.h>
 #include <vesa.h>
diff --git a/arch/x86/lib/div64.c b/arch/x86/lib/div64.c
index 2bea205f60f9..57da889ef49b 100644
--- a/arch/x86/lib/div64.c
+++ b/arch/x86/lib/div64.c
@@ -6,7 +6,7 @@
  * Copyright 2014 Google Inc.
  */
 
-#include <common.h>
+#include <linux/types.h>
 
 union overlay64 {
 	u64 longw;
diff --git a/arch/x86/lib/e820.c b/arch/x86/lib/e820.c
index 12fcff123805..122b4f7ca01b 100644
--- a/arch/x86/lib/e820.c
+++ b/arch/x86/lib/e820.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/lib/early_cmos.c b/arch/x86/lib/early_cmos.c
index f7b3bb2a8e19..5635d08718fa 100644
--- a/arch/x86/lib/early_cmos.c
+++ b/arch/x86/lib/early_cmos.c
@@ -10,7 +10,6 @@
  * uclass write ops, that data is stored in little-endian mode.
  */
 
-#include <common.h>
 #include <asm/early_cmos.h>
 #include <asm/io.h>
 
diff --git a/arch/x86/lib/fsp/fsp_common.c b/arch/x86/lib/fsp/fsp_common.c
index 8f2977a80709..c47e6ca47388 100644
--- a/arch/x86/lib/fsp/fsp_common.c
+++ b/arch/x86/lib/fsp/fsp_common.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/lib/fsp/fsp_dram.c b/arch/x86/lib/fsp/fsp_dram.c
index cc889a688d8a..730721dc1768 100644
--- a/arch/x86/lib/fsp/fsp_dram.c
+++ b/arch/x86/lib/fsp/fsp_dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <handoff.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/lib/fsp/fsp_graphics.c b/arch/x86/lib/fsp/fsp_graphics.c
index 09d5da8c841a..5f7701265a95 100644
--- a/arch/x86/lib/fsp/fsp_graphics.c
+++ b/arch/x86/lib/fsp/fsp_graphics.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_VIDEO
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/lib/fsp/fsp_support.c b/arch/x86/lib/fsp/fsp_support.c
index fd4d98ef6274..19f9f65b2e41 100644
--- a/arch/x86/lib/fsp/fsp_support.c
+++ b/arch/x86/lib/fsp/fsp_support.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/fsp/fsp_support.h>
 #include <asm/post.h>
diff --git a/arch/x86/lib/fsp1/fsp_common.c b/arch/x86/lib/fsp1/fsp_common.c
index df18f4767562..ebf655a11439 100644
--- a/arch/x86/lib/fsp1/fsp_common.c
+++ b/arch/x86/lib/fsp1/fsp_common.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/arch/x86/lib/fsp1/fsp_dram.c b/arch/x86/lib/fsp1/fsp_dram.c
index eee9ce54b1ce..f3a8134a3f2f 100644
--- a/arch/x86/lib/fsp1/fsp_dram.c
+++ b/arch/x86/lib/fsp1/fsp_dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/fsp/fsp_support.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/lib/fsp1/fsp_support.c b/arch/x86/lib/fsp1/fsp_support.c
index d84c632f1407..6e311a12d20b 100644
--- a/arch/x86/lib/fsp1/fsp_support.c
+++ b/arch/x86/lib/fsp1/fsp_support.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/fsp1/fsp_support.h>
 #include <asm/post.h>
diff --git a/arch/x86/lib/fsp2/fsp_common.c b/arch/x86/lib/fsp2/fsp_common.c
index d802a86967d5..45a274c05123 100644
--- a/arch/x86/lib/fsp2/fsp_common.c
+++ b/arch/x86/lib/fsp2/fsp_common.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/fsp/fsp_support.h>
 
diff --git a/arch/x86/lib/fsp2/fsp_dram.c b/arch/x86/lib/fsp2/fsp_dram.c
index a1432239cfc1..83c6d7bcc93f 100644
--- a/arch/x86/lib/fsp2/fsp_dram.c
+++ b/arch/x86/lib/fsp2/fsp_dram.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <handoff.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/lib/fsp2/fsp_init.c b/arch/x86/lib/fsp2/fsp_init.c
index aadc08cf3c44..ecbadaae75cf 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <binman.h>
 #include <binman_sym.h>
 #include <bootstage.h>
diff --git a/arch/x86/lib/fsp2/fsp_meminit.c b/arch/x86/lib/fsp2/fsp_meminit.c
index 022e2cb64e5a..f4817830cc21 100644
--- a/arch/x86/lib/fsp2/fsp_meminit.c
+++ b/arch/x86/lib/fsp2/fsp_meminit.c
@@ -6,7 +6,6 @@
  * Mostly taken from coreboot fsp2_0/memory_init.c
  */
 
-#include <common.h>
 #include <binman.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/arch/x86/lib/fsp2/fsp_silicon_init.c b/arch/x86/lib/fsp2/fsp_silicon_init.c
index a96d2b183f6e..16d30c25a57a 100644
--- a/arch/x86/lib/fsp2/fsp_silicon_init.c
+++ b/arch/x86/lib/fsp2/fsp_silicon_init.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_NORTHBRIDGE
 
-#include <common.h>
 #include <binman.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/arch/x86/lib/fsp2/fsp_support.c b/arch/x86/lib/fsp2/fsp_support.c
index b2c76582453f..808f0eb9d29c 100644
--- a/arch/x86/lib/fsp2/fsp_support.c
+++ b/arch/x86/lib/fsp2/fsp_support.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/x86/lib/hob.c b/arch/x86/lib/hob.c
index b35248e5fde7..46e83aa395ab 100644
--- a/arch/x86/lib/hob.c
+++ b/arch/x86/lib/hob.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/hob.h>
 
 /**
diff --git a/arch/x86/lib/i8254.c b/arch/x86/lib/i8254.c
index a8d1db188ece..8a590c6191fa 100644
--- a/arch/x86/lib/i8254.c
+++ b/arch/x86/lib/i8254.c
@@ -4,10 +4,10 @@
  * Daniel Engström, Omicron Ceti AB, <daniel@omicron.se>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/i8254.h>
 #include <asm/ibmpc.h>
+#include <linux/errno.h>
 
 #define TIMER1_VALUE		18	/* 15.6us */
 #define BEEP_FREQUENCY_HZ	440
diff --git a/arch/x86/lib/i8259.c b/arch/x86/lib/i8259.c
index a0e3c0925738..465ff70146f7 100644
--- a/arch/x86/lib/i8259.c
+++ b/arch/x86/lib/i8259.c
@@ -13,7 +13,6 @@
  * Programmable Interrupt Controllers.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
index bf0c921577d1..bd0efde00c10 100644
--- a/arch/x86/lib/init_helpers.c
+++ b/arch/x86/lib/init_helpers.c
@@ -4,11 +4,11 @@
  * Graeme Russ, <graeme.russ@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/mtrr.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/interrupts.c b/arch/x86/lib/interrupts.c
index ff52959ed285..f96b2bfd70ee 100644
--- a/arch/x86/lib/interrupts.c
+++ b/arch/x86/lib/interrupts.c
@@ -29,7 +29,6 @@
  * Daniel Engström
  */
 
-#include <common.h>
 #include <command.h>
 #include <irq_func.h>
 #include <asm/interrupt.h>
diff --git a/arch/x86/lib/lpc-uclass.c b/arch/x86/lib/lpc-uclass.c
index 67b931d3b289..4f89db4e5389 100644
--- a/arch/x86/lib/lpc-uclass.c
+++ b/arch/x86/lib/lpc-uclass.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 
 UCLASS_DRIVER(lpc) = {
diff --git a/arch/x86/lib/mpspec.c b/arch/x86/lib/mpspec.c
index 8e97d9ff36d9..5abd9288c2a3 100644
--- a/arch/x86/lib/mpspec.c
+++ b/arch/x86/lib/mpspec.c
@@ -5,7 +5,6 @@
  * Adapted from coreboot src/arch/x86/boot/mpspec.c
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/x86/lib/mrccache.c b/arch/x86/lib/mrccache.c
index 6494b8d26341..970704a8dd62 100644
--- a/arch/x86/lib/mrccache.c
+++ b/arch/x86/lib/mrccache.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY	UCLASS_RAM
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/lib/northbridge-uclass.c b/arch/x86/lib/northbridge-uclass.c
index 383888724841..1d1780535a2a 100644
--- a/arch/x86/lib/northbridge-uclass.c
+++ b/arch/x86/lib/northbridge-uclass.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/root.h>
 
diff --git a/arch/x86/lib/physmem.c b/arch/x86/lib/physmem.c
index 382f768149f4..48cd1073c152 100644
--- a/arch/x86/lib/physmem.c
+++ b/arch/x86/lib/physmem.c
@@ -8,7 +8,6 @@
  * Software Foundation.
  */
 
-#include <common.h>
 #include <log.h>
 #include <physmem.h>
 #include <asm/cpu.h>
diff --git a/arch/x86/lib/pinctrl_ich6.c b/arch/x86/lib/pinctrl_ich6.c
index c93f245845de..d4f71c562f85 100644
--- a/arch/x86/lib/pinctrl_ich6.c
+++ b/arch/x86/lib/pinctrl_ich6.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/arch/x86/lib/pirq_routing.c b/arch/x86/lib/pirq_routing.c
index caeaec9287fe..5178940901c2 100644
--- a/arch/x86/lib/pirq_routing.c
+++ b/arch/x86/lib/pirq_routing.c
@@ -5,7 +5,6 @@
  * Part of this file is ported from coreboot src/arch/x86/boot/pirq_routing.c
  */
 
-#include <common.h>
 #include <log.h>
 #include <pci.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/lib/pmu.c b/arch/x86/lib/pmu.c
index 083aec8d8dd7..2127257cd431 100644
--- a/arch/x86/lib/pmu.c
+++ b/arch/x86/lib/pmu.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2017 Intel Corporation
  */
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
diff --git a/arch/x86/lib/ramtest.c b/arch/x86/lib/ramtest.c
index 03385396325d..16cd6e49437c 100644
--- a/arch/x86/lib/ramtest.c
+++ b/arch/x86/lib/ramtest.c
@@ -5,9 +5,9 @@
  * From Coreboot src/lib/ramtest.c
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/post.h>
+#include <vsprintf.h>
 
 static void write_phys(unsigned long addr, u32 value)
 {
diff --git a/arch/x86/lib/reloc_ia32_efi.c b/arch/x86/lib/reloc_ia32_efi.c
index d56cd50bd937..17ab54dc2469 100644
--- a/arch/x86/lib/reloc_ia32_efi.c
+++ b/arch/x86/lib/reloc_ia32_efi.c
@@ -7,7 +7,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <efi.h>
 #include <elf.h>
 
diff --git a/arch/x86/lib/reloc_x86_64_efi.c b/arch/x86/lib/reloc_x86_64_efi.c
index 2694de711041..c7a21d9393d6 100644
--- a/arch/x86/lib/reloc_x86_64_efi.c
+++ b/arch/x86/lib/reloc_x86_64_efi.c
@@ -9,7 +9,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <efi.h>
 #include <elf.h>
 
diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
index da819b9bdd2c..9ce56062d247 100644
--- a/arch/x86/lib/relocate.c
+++ b/arch/x86/lib/relocate.c
@@ -14,7 +14,6 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 
-#include <common.h>
 #include <log.h>
 #include <relocate.h>
 #include <asm/global_data.h>
diff --git a/arch/x86/lib/scu.c b/arch/x86/lib/scu.c
index 90ef239bcd3d..02fed601fb65 100644
--- a/arch/x86/lib/scu.c
+++ b/arch/x86/lib/scu.c
@@ -9,7 +9,6 @@
  *
  * This driver enables IPC channel to SCU.
  */
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
diff --git a/arch/x86/lib/sfi.c b/arch/x86/lib/sfi.c
index 85e963b634b5..04d97327a4df 100644
--- a/arch/x86/lib/sfi.c
+++ b/arch/x86/lib/sfi.c
@@ -12,7 +12,6 @@
  * See https://simplefirmware.org/ for details
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <asm/cpu.h>
diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index c15f11f8cdf4..f761fbc8bc3b 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
@@ -29,6 +28,7 @@
 #include <asm/processor.h>
 #include <asm/qemu.h>
 #include <asm/spl.h>
+#include <asm/u-boot-x86.h>
 #include <asm-generic/sections.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 1095dc92c5aa..45a70e927634 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <bloblist.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 273e9c8e1ca1..7c03dea07111 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <hang.h>
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index d7403876c13d..73a21bc8f03b 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -14,7 +14,6 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <bootm.h>
 #include <command.h>
 #include <env.h>
diff --git a/include/acpi/acpi_s3.h b/include/acpi/acpi_s3.h
index d3f271f948ea..f7bea9418552 100644
--- a/include/acpi/acpi_s3.h
+++ b/include/acpi/acpi_s3.h
@@ -37,6 +37,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/errno.h>
+#include <linux/types.h>
+
 extern char __wakeup[];
 extern int __wakeup_size;
 
-- 
2.34.1

