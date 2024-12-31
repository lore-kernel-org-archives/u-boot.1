Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F8E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 16:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBF78042A;
	Tue, 31 Dec 2024 17:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010FF8036B; Tue, 31 Dec 2024 17:51:55 +0100 (CET)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42926803E4
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 17:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id DF71C8151A;
 Tue, 31 Dec 2024 17:51:51 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 31 Dec 2024 17:49:14 +0100
Subject: [PATCH v2 3/3] board: samsung: add initial support for
 coreprimevelte board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241231-coreprimevelte-v2-3-6a5445d92d11@skole.hr>
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
In-Reply-To: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
To: Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5212;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=oxznrKCsjLvfOTYZZFAWVW5p/kFQAsTayYamZQAa1xc=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOklCv2Myf/4GD++aJWZf+a7RWZvw0HL+7WtK7cJ7fD4/
 COn/ZpuRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAExEiI+RoX+HxM8UoZzKCVxX
 nj9M3pi8sDGIRWrhB3dRp7prXy5VaDIyXItkuRa1y/6hbpLcQi5f7X/2i01+8Hns3fFX3r3/eys
 /LwA=
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Tue, 31 Dec 2024 17:52:00 +0100
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

Samsung Galaxy Core Prime VE LTE is an entry-level PXA1908-based
smartphone. It has 1GB of DRAM, 8GB eMMC and USB connectivity.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/dts/Makefile                           |  2 +
 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts | 74 +++++++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                       |  6 ++
 board/samsung/coreprimevelte/Kconfig            | 12 ++++
 board/samsung/coreprimevelte/MAINTAINERS        |  6 ++
 configs/coreprimevelte_defconfig                | 18 ++++++
 6 files changed, 118 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6ad59aeed5f684959845833d708bf1b37937f135..ea2c3e80962d08802d364efd25a1b8626225aa4d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1283,6 +1283,8 @@ dtb-$(CONFIG_ARCH_QEMU) += qemu-arm.dtb qemu-arm64.dtb
 dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
 				corstone1000-fvp.dtb
 
+dtb-$(CONFIG_TARGET_COREPRIMEVELTE) += pxa1908-samsung-coreprimevelte.dtb
+
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
new file mode 100644
index 0000000000000000000000000000000000000000..588e39e92650f9217e02bb332dcdcd5f74cc7fce
--- /dev/null
+++ b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "pxa1908.dtsi"
+
+/ {
+	pxa,rev-id = <3928 2>;
+	model = "Samsung Galaxy Core Prime VE LTE";
+	compatible = "samsung,coreprimevelte", "marvell,pxa1908";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:115200n8";
+
+		/* S-Boot places the initramfs here */
+		linux,initrd-start = <0x4d70000>;
+		linux,initrd-end = <0x5000000>;
+
+		fb0: framebuffer@17177000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x17177000 0 (480 * 800 * 4)>;
+			width = <480>;
+			height = <800>;
+			stride = <(480 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x1000000 0 0x3f000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@17000000 {
+			reg = <0 0x17000000 0 0x1800000>;
+			no-map;
+		};
+
+		gpu@9000000 {
+			reg = <0 0x9000000 0 0x1000000>;
+		};
+
+		/* Communications processor, aka modem */
+		cp@5000000 {
+			reg = <0 0x5000000 0 0x3000000>;
+		};
+
+		cm3@a000000 {
+			reg = <0 0xa000000 0 0x80000>;
+		};
+
+		seclog@8000000 {
+			reg = <0 0x8000000 0 0x100000>;
+		};
+
+		ramoops@8100000 {
+			compatible = "ramoops";
+			reg = <0 0x8100000 0 0x40000>;
+			record-size = <0x8000>;
+			console-size = <0x20000>;
+			max-reason = <5>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index b9438c6facb2e7f29f608bc72e97657d97a0d7dc..889f127fe82b8110e16c8fdef2908842e1635ebb 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,6 +1,12 @@
 if ARCH_MMP
 
+config TARGET_COREPRIMEVELTE
+	bool "Support coreprimevelte"
+	select LINUX_KERNEL_IMAGE_HEADER
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
 
+source "board/samsung/coreprimevelte/Kconfig"
+
 endif
diff --git a/board/samsung/coreprimevelte/Kconfig b/board/samsung/coreprimevelte/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..78a803796054ae9c43374eabebc14361d8561211
--- /dev/null
+++ b/board/samsung/coreprimevelte/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_COREPRIMEVELTE
+
+config SYS_BOARD
+	default "coreprimevelte"
+
+config SYS_VENDOR
+	default "samsung"
+
+config SYS_CONFIG_NAME
+	default "pxa1908"
+
+endif
diff --git a/board/samsung/coreprimevelte/MAINTAINERS b/board/samsung/coreprimevelte/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..0902117e8b3dc9da782e61728ad9b10ee077229c
--- /dev/null
+++ b/board/samsung/coreprimevelte/MAINTAINERS
@@ -0,0 +1,6 @@
+Samsung Galaxy Core Prime VE LTE support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+S:	Maintained
+T:	git git://git.dujemihanovic.xyz/u-boot.git
+F:	board/samsung/coreprimevelte/
+F:	configs/coreprimevelte_defconfig
diff --git a/configs/coreprimevelte_defconfig b/configs/coreprimevelte_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..05116669200b3f1393518c8f9d1d0d5b9f90db6f
--- /dev/null
+++ b/configs/coreprimevelte_defconfig
@@ -0,0 +1,18 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=26000000
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MMP=y
+CONFIG_TEXT_BASE=0x1000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_DEFAULT_DEVICE_TREE="pxa1908-samsung-coreprimevelte"
+CONFIG_TARGET_COREPRIMEVELTE=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_ARMV8_PSCI=y
+CONFIG_FIT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_DM=y
+CONFIG_OF_BOARD=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y

-- 
2.47.1


