Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B5E7849B
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 22:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DA68644E;
	Mon,  2 Oct 2023 00:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDF28644E; Mon,  2 Oct 2023 00:53:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AD90A86413
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 00:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA931FB;
 Sun,  1 Oct 2023 15:53:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5CD03F5A1;
 Sun,  1 Oct 2023 15:53:18 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: u-boot@lists.denx.de, Sam Edwards <CFSworks@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: psci: move GIC address override to Kconfig
Date: Sun,  1 Oct 2023 23:52:12 +0100
Message-Id: <20231001225212.19081-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

As the code to switch an ARM core from secure to the non-secure state
needs to know the base address of the Generic Interrupt Controller
(GIC), we read an Arm Cortex defined system register that is supposed to
hold that base address. However there are SoCs out there that get this
wrong, and this CBAR register either reads as 0 or points to the wrong
address. To accommodate those systems, so far we use a macro defined in
some platform specific header files, for affected boards.

To simplify future extensions, replace that macro with a Kconfig variable
that holds this override address, and define a default value for SoCs
that need it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this only affects the Arndale board so far, though actually the defconfig
doesn't enable the non-secure and PSCI code. I keep it anyway since
people could manually enable it, and we need the code for the new
Allwinner T113s SoC [1].

Cheers,
Andre

[1] https://lore.kernel.org/u-boot/20230930183424.806520-1-CFSworks@gmail.com/T/#t

 arch/arm/cpu/armv7/Kconfig       | 10 ++++++++++
 arch/arm/cpu/armv7/nonsec_virt.S |  4 ++--
 arch/arm/cpu/armv7/virt-v7.c     |  4 ++--
 include/configs/arndale.h        |  3 ---
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index ccc2f208677..f015d133cb0 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -58,6 +58,16 @@ config ARMV7_SECURE_MAX_SIZE
 	default 0x3c00 if MACH_SUN8I && MACH_SUN8I_H3
 	default 0x10000
 
+config ARM_GIC_BASE_ADDRESS
+	hex
+	depends on ARMV7_NONSEC
+	depends on ARCH_EXYNOS5
+	default 0x10480000 if ARCH_EXYNOS5
+	help
+	  Override the GIC base address if the Arm Cortex defined
+	  CBAR/PERIPHBASE system register holds the wrong value.
+	  Used by the PSCI code to configure the secure side of the GIC.
+
 config ARMV7_VIRT
 	bool "Enable support for hardware virtualization" if EXPERT
 	depends on CPU_V7_HAS_VIRT && ARMV7_NONSEC
diff --git a/arch/arm/cpu/armv7/nonsec_virt.S b/arch/arm/cpu/armv7/nonsec_virt.S
index 9004074da2c..bed40fa3d99 100644
--- a/arch/arm/cpu/armv7/nonsec_virt.S
+++ b/arch/arm/cpu/armv7/nonsec_virt.S
@@ -112,8 +112,8 @@ ENTRY(_do_nonsec_entry)
 ENDPROC(_do_nonsec_entry)
 
 .macro get_cbar_addr	addr
-#ifdef CFG_ARM_GIC_BASE_ADDRESS
-	ldr	\addr, =CFG_ARM_GIC_BASE_ADDRESS
+#ifdef CONFIG_ARM_GIC_BASE_ADDRESS
+	ldr	\addr, =CONFIG_ARM_GIC_BASE_ADDRESS
 #else
 	mrc	p15, 4, \addr, c15, c0, 0	@ read CBAR
 	bfc	\addr, #0, #15			@ clear reserved bits
diff --git a/arch/arm/cpu/armv7/virt-v7.c b/arch/arm/cpu/armv7/virt-v7.c
index c82b215b6f9..5ffeca13d91 100644
--- a/arch/arm/cpu/armv7/virt-v7.c
+++ b/arch/arm/cpu/armv7/virt-v7.c
@@ -26,8 +26,8 @@ static unsigned int read_id_pfr1(void)
 
 static unsigned long get_gicd_base_address(void)
 {
-#ifdef CFG_ARM_GIC_BASE_ADDRESS
-	return CFG_ARM_GIC_BASE_ADDRESS + GIC_DIST_OFFSET;
+#ifdef CONFIG_ARM_GIC_BASE_ADDRESS
+	return CONFIG_ARM_GIC_BASE_ADDRESS + GIC_DIST_OFFSET;
 #else
 	unsigned periphbase;
 
diff --git a/include/configs/arndale.h b/include/configs/arndale.h
index b56effcd411..fa642564f4b 100644
--- a/include/configs/arndale.h
+++ b/include/configs/arndale.h
@@ -18,7 +18,4 @@
 
 #define CFG_SMP_PEN_ADDR	0x02020000
 
-/* The PERIPHBASE in the CBAR register is wrong on the Arndale, so override it */
-#define CFG_ARM_GIC_BASE_ADDRESS	0x10480000
-
 #endif	/* __CONFIG_H */
-- 
2.35.8

