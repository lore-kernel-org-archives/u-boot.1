Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C5D29DC7
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0121683990;
	Tue, 13 Jan 2026 05:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A71A839E2; Tue, 13 Jan 2026 05:03:12 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A458393F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 6FF33340ED3;
 Tue, 13 Jan 2026 04:03:06 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:02:03 +0800
Subject: [PATCH v3 9/9] sunxi: sun60i: initial support for A733 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-9-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5136; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=i9aR16qXn+fHTQC/eS+j+9JkfrsJeU/SfLtZSsOzQA0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPaX34KBdFqH3jNWmFrlQ+nmvQzR9SagFAfJ
 v3+9kGCtguJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXD2hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3N3Q/+PmUnqMTPZMs0ZxInLdghY297yIi7YETer4g1tULawSACc+l0/sqmd
 0Q8deOfewjDOhZGAI39CK6afGkGs/iUY2cLJOyzR9IdLm6XI4WDqQYIPE7kNwymtCmU9EGmElwg
 o1/kQ+gDsCEmvvickYBlpWpwxBEe7tATrH7ys9L5XjTUfpU001U6/NGJa0Ufsnaa0gMEAtBas76
 g7lukQToMBf2hnxwYK27AJQ5ucumg3vM8YxeUm43N3CNLk0Ko6qGXZJb2+mO/pSvzUUi4CVK7li
 Q2nU9YqGsU3BamMPoA1NoMLJNxsvoJQJKYwsZsE8Y1RvCU1PisqldQ6b8iq6I5OFzojufSjbnZr
 Hd7RKNnP3aV+k3wLkpmY95Y5VVhksceA7+f8R+EGbUgZsNUWL7OK2wPWBcBs825KrgdJkgiXVHW
 2xTFRYKyWJpeoWDZfA9OekpHBTB+dItrFIk9s/Q3GllTaQMtyI0RacLd26PcjDStRyYjvO0NQco
 fWjsCRg95BLCtXydEYYaro2p6fxbZYAm+faIpXrg1gYYAC8dyp87hdbdhlhE4IDiCDeRWdxaRTp
 DaeUcE+Hun+wUDdDGW5xkjPhkor0X8biZpH1AtP6ylPkmNaUH1VYebnGQNqnEmKcq+zc2ULU6BT
 uFRsRN41b5QfBkqoF/aFcij1UsQhnk=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add basic support for Allwinner A733 SoC, includes SPL settings.

- Include some basic register definitions
- Introduce a new SUN60I A733 Kconfig option
- Ssetup RVBAR register properly according to docs
- Config max DDR size 16GB
- Config SRAM 0x62000 for TF-A
- Set SPL MAX SIZE to 180KB, 0x47000 - 0x74000
- Set SPL running address to 0x47000, with a header padded before
  the image, so the final SPL text address need to shift 0x60 bytes.
- Set Stack address

Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
Note, Address for TF-A can be altered to other value, for example,
moving it to the DDR address space. The only requirement is that
load and run address should be matched.
---
 arch/arm/mach-sunxi/Kconfig    | 14 ++++++++++++++
 arch/arm/mach-sunxi/cpu_info.c |  2 ++
 common/spl/Kconfig             |  3 +++
 include/configs/sun60i.h       | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..b7ac828e16d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -215,6 +215,7 @@ config SUNXI_SRAM_ADDRESS
 	hex
 	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x47000 if MACH_SUN60I_A733
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
 	---help---
@@ -228,6 +229,7 @@ config SUNXI_RVBAR_ADDRESS
 	depends on ARM64
 	default 0x08100040 if MACH_SUN50I_A133
 	default 0x08000040 if MACH_SUN55I_A523
+	default 0x08001004 if MACH_SUN60I_A733
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
 	---help---
@@ -257,6 +259,7 @@ config SUNXI_BL31_BASE
 	default 0x40000000 if MACH_SUN50I_H616
 	default 0x00104000 if SUN50I_GEN_H6
 	default 0x00054000 if MACH_SUN55I_A523
+	default 0x00062000 if MACH_SUN60I_A733
 	default 0x0
 	help
 	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
@@ -339,6 +342,7 @@ config MACH_SUNXI_H3_H5
 config SUNXI_DRAM_MAX_SIZE
 	hex
 	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x400000000 if MACH_SUN60I_A733
 	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
 	default 0x80000000
 
@@ -553,6 +557,15 @@ config MACH_SUN55I_A523
 	select SPL_LOAD_FIT if SPL
 	imply OF_UPSTREAM
 
+config MACH_SUN60I_A733
+	bool "sun60i (Allwinner A733)"
+	select ARM64
+	select SUNXI_GEN_NCAT2
+	select SUNXI_A733_PINCTRL
+	select FIT
+	select SPL_LOAD_FIT if SPL
+	select SUPPORT_SPL
+
 endchoice
 
 # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
@@ -870,6 +883,7 @@ config SYS_CONFIG_NAME
 	default "sun50i" if MACH_SUN50I_H616
 	default "sun50i" if MACH_SUN50I_A133
 	default "sun55i" if MACH_SUN55I_A523
+	default "sun60i" if MACH_SUN60I_A733
 
 config SYS_BOARD
 	default "sunxi"
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index c3a51d9956e..f0b33bb9097 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -108,6 +108,8 @@ int print_cpuinfo(void)
 	puts("CPU:   Allwinner A133 (SUN50I)\n");
 #elif defined CONFIG_MACH_SUN55I_A523
 	puts("CPU:   Allwinner A523 (SUN55I)\n");
+#elif defined CONFIG_MACH_SUN60I_A733
+	puts("CPU:   Allwinner A733 (SUN60I)\n");
 #else
 #warning Please update cpu_info.c with correct CPU information
 	puts("CPU:   SUNXI Family\n");
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 24d6ce5d739..ba98b76bbc6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -81,6 +81,7 @@ config SPL_MAX_SIZE
 	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x2d000 if MACH_SUN60I_A733
 	default 0x7000 if RCAR_GEN3
 	default 0x5fa0 if SUNXI_SRAM_ADDRESS = 0x0
 	default 0x7fa0 if ARCH_SUNXI
@@ -279,6 +280,7 @@ config SPL_TEXT_BASE
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
 	default 0x44060 if MACH_SUN55I_A523
+	default 0x47060 if MACH_SUN60I_A733
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x00060 if ARCH_SUNXI
 	default 0xfffc0000 if ARCH_ZYNQMP
@@ -434,6 +436,7 @@ config SPL_STACK
 	default 0x52a00 if MACH_SUN50I_H616
 	default 0x40000 if MACH_SUN8I_R528 || MACH_SUN50I_A133
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x5A000 if MACH_SUN60I_A733
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
diff --git a/include/configs/sun60i.h b/include/configs/sun60i.h
new file mode 100644
index 00000000000..70649366c1c
--- /dev/null
+++ b/include/configs/sun60i.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Placeholder wrapper to allow addressing Allwinner devices with Cortex-A55
+ * cores separately. Please do not add anything in here.
+ */
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/sunxi-common.h>
+
+#endif /* __CONFIG_H */

-- 
2.52.0

