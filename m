Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C957C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 20:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF07820E1;
	Fri,  2 May 2025 22:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="GoFc89kK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7965820E2; Fri,  2 May 2025 20:38:47 +0200 (CEST)
Received: from gw2.cammew.com (gw2.cammew.com [64.182.209.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7B781F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 20:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gw2.cammew.com (Postfix) with ESMTPSA id 5197FEDCC5;
 Fri,  2 May 2025 14:38:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw2.cammew.com 5197FEDCC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=novatechautomation.com; s=relay; t=1746211123;
 bh=a2mlZ9uW7g0040S1V3NtN/N22KAjDRbfVoZHB24QL/E=;
 h=From:To:Cc:Subject:Date:From;
 b=GoFc89kKHneC8YEgqtTl//8BeEs5Ji+2lzI+rzS4F2bv1OI1D89yXedbC1mT51kOe
 F6IKSvRekJBQ1okMdXIs2Py19saYlp1r3gQeeyq0yYw/FbNusO4dl4sDQQ9L3IAYqJ
 4R+AYdbpEVz9ugIoLWUX5KCTcgXolDn0aRsJ6zwk=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: u-boot@lists.denx.de
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Date: Fri,  2 May 2025 13:38:26 -0500
Message-Id: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 May 2025 22:06:13 +0200
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

This will allow arch(s) that use device tree blobs to pad the end of the
device tree so they can be modified by board files at run time. This will
help prevent errors such as FDT_ERR_NOSPACE from occuring.

Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/Kconfig                 | 11 +++++++++++
 arch/arc/dts/Makefile        |  6 +++++-
 arch/arm/dts/Makefile        |  4 ++++
 arch/m68k/dts/Makefile       |  6 +++++-
 arch/microblaze/dts/Makefile |  6 +++++-
 arch/nios2/dts/Makefile      |  6 +++++-
 arch/powerpc/dts/Makefile    |  4 ++++
 arch/riscv/dts/Makefile      |  6 +++++-
 arch/sandbox/dts/Makefile    |  6 +++++-
 arch/x86/dts/Makefile        |  8 +++++++-
 10 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea33d07c086..a85f751d1e6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -63,6 +63,17 @@ config SYS_CACHELINE_SIZE
 	default 64 if RISCV
 	default 32 if MIPS
 
+config SYS_DTC_PAD
+	bool "Enable DTC padding"
+	help
+	  This will allow the final device tree of your specified arch to
+	  have pad space at the end. This enables the ability for the device
+	  tree to be modified in place by board files.
+
+config SYS_DTC_PAD_BYTES
+	int "Size in bytes to pad device tree blob"
+	default 4096 if SYS_DTC_PAD
+
 config LINKER_LIST_ALIGN
 	int
 	default 32 if SANDBOX
diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
index fe6ad7b849a..fee5d7baae6 100644
--- a/arch/arc/dts/Makefile
+++ b/arch/arc/dts/Makefile
@@ -11,4 +11,8 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=  iot_devkit.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82f5c374f10..8c6bd53172f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1213,5 +1213,9 @@ include $(srctree)/scripts/Makefile.dts
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
+
 DTC_FLAGS_imx8mp-dhcom-som-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
 DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
index 8b354b9c570..2fda1f5081e 100644
--- a/arch/m68k/dts/Makefile
+++ b/arch/m68k/dts/Makefile
@@ -21,4 +21,8 @@ dtb-$(CONFIG_TARGET_STMARK2) += stmark2.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
index 9be902d3bb1..d0b6c185e7e 100644
--- a/arch/microblaze/dts/Makefile
+++ b/arch/microblaze/dts/Makefile
@@ -5,4 +5,8 @@ dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
index d77db9762a1..aefbb7815ec 100644
--- a/arch/nios2/dts/Makefile
+++ b/arch/nios2/dts/Makefile
@@ -5,4 +5,8 @@ dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 766b0c05951..c39e04c9544 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -37,3 +37,7 @@ include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
 DTC_FLAGS +=
+
+ifdef CONFIG_SYS_DTC_PAD
+    DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index cf1872f3fdc..fd4ed512aaa 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -19,4 +19,8 @@ dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/sandbox/dts/Makefile b/arch/sandbox/dts/Makefile
index 1c9fb4a4566..1911b25700f 100644
--- a/arch/sandbox/dts/Makefile
+++ b/arch/sandbox/dts/Makefile
@@ -11,4 +11,8 @@ dtb-$(CONFIG_CMD_EXTENSION) += overlay0.dtbo overlay1.dtbo
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+       DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
diff --git a/arch/x86/dts/Makefile b/arch/x86/dts/Makefile
index 9a46726e026..6da4364116e 100644
--- a/arch/x86/dts/Makefile
+++ b/arch/x86/dts/Makefile
@@ -24,4 +24,10 @@ dtb-y += bayleybay.dtb \
 
 include $(srctree)/scripts/Makefile.dts
 
-DTC_FLAGS += -R 4 -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
+DTC_FLAGS += -R 4
+
+ifdef CONFIG_SYS_DTC_PAD
+	DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+else
+	DTC_FLAGS += -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
+endif
-- 
2.34.1

