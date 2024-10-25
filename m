Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE8AD149EB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659F689030;
	Fri, 25 Oct 2024 22:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760928902A; Fri, 25 Oct 2024 19:18:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4C83288F68
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF1D339;
 Fri, 25 Oct 2024 10:19:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B448A3F71E;
 Fri, 25 Oct 2024 10:18:40 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 2/8] arm: total_compute: Initialize environment variables
Date: Fri, 25 Oct 2024 18:18:15 +0100
Message-Id: <20241025171821.624702-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

From: Boyan Karatotev <boyan.karatotev@arm.com>

Initialize the environment variables 'fdt_addr_r' and 'kernel_addr_r'
during the misc init phase. The static configurations are not needed,
remove them.

Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 arch/arm/Kconfig                           |  1 +
 board/armltd/total_compute/total_compute.c | 23 ++++++++++++++++++++++
 include/configs/total_compute.h            |  4 +---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d0127418ee..f4ce884e37 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1391,6 +1391,7 @@ config TARGET_TOTAL_COMPUTE
 	select DM_MMC
 	select DM_GPIO
 	imply OF_HAS_PRIOR_STAGE
+	imply MISC_INIT_R
 
 config TARGET_LS2080A_EMU
 	bool "Support ls2080a_emu"
diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index 571a075145..02bb648ce7 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -8,6 +8,8 @@
 #include <dm.h>
 #include <dm/platform_data/serial_pl01x.h>
 #include <env.h>
+#include <linux/sizes.h>
+
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
@@ -51,6 +53,27 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)fw_dtb_pointer;
 }
 
+int misc_init_r(void)
+{
+	size_t base;
+
+	if (!env_get("fdt_addr_r"))
+		env_set_hex("fdt_addr_r", fw_dtb_pointer);
+
+	if (!env_get("kernel_addr_r")) {
+		/*
+		 * The kernel has to be 2M aligned and the first 64K at the
+		 * start of SDRAM is reserved for DTB.
+		 */
+		base = gd->ram_base + SZ_2M;
+		assert(IS_ALIGNED(base, SZ_2M));
+
+		env_set_hex("kernel_addr_r", base);
+	}
+
+	return 0;
+}
+
 int board_init(void)
 {
 	return 0;
diff --git a/include/configs/total_compute.h b/include/configs/total_compute.h
index 205e6a6278..8053dca315 100644
--- a/include/configs/total_compute.h
+++ b/include/configs/total_compute.h
@@ -14,9 +14,7 @@
 #define CFG_EXTRA_ENV_SETTINGS	\
 				"bootm_size=0x20000000\0"	\
 				"load_addr=0xa0000000\0"	\
-				"kernel_addr_r=0x80080000\0"	\
-				"initrd_addr_r=0x88000000\0"	\
-				"fdt_addr_r=0x83000000\0"
+				"initrd_addr_r=0x88000000\0"
 /*
  * If vbmeta partition is present, boot Android with verification using AVB.
  * Else if system partition is present (no vbmeta partition), boot Android
-- 
2.34.1

