Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90490D149EE
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671B989089;
	Fri, 25 Oct 2024 22:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F43889017; Fri, 25 Oct 2024 19:18:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 064AF8902A
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE8412FC;
 Fri, 25 Oct 2024 10:19:14 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 565713F71E;
 Fri, 25 Oct 2024 10:18:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 4/8] arm: total_compute: move the boot command to an env
 file
Date: Fri, 25 Oct 2024 18:18:17 +0100
Message-Id: <20241025171821.624702-5-leo.yan@arm.com>
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

The boot command for Total Compute has many aspects and changes from time
to time. So move it to an .env file where it can be a proper script.

Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 board/armltd/total_compute/total_compute.env | 28 ++++++++++++++++++++
 configs/total_compute_defconfig              |  2 +-
 include/configs/total_compute.h              | 10 -------
 3 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100644 board/armltd/total_compute/total_compute.env

diff --git a/board/armltd/total_compute/total_compute.env b/board/armltd/total_compute/total_compute.env
new file mode 100644
index 0000000000..8975a86fd2
--- /dev/null
+++ b/board/armltd/total_compute/total_compute.env
@@ -0,0 +1,28 @@
+/* DRAM1 + 0x2000_0000 */
+load_addr=0xa0000000
+/* DRAM1 + 0x0800_0000 */
+initrd_addr_r=0x88000000
+
+bootcmd=
+    if part number mmc 0 vbmeta is_avb; then
+        echo 'MMC with vbmeta partition detected.';
+        echo 'Starting Android Verified boot...';
+        avb init 0;
+        if avb verify; then
+            set bootargs $bootargs $avb_bootargs;
+            part start mmc 0 boot boot_start;
+            part size mmc 0 boot boot_size;
+            mmc read ${load_addr} ${boot_start} ${boot_size};
+            bootm ${load_addr} ${load_addr} ${fdt_addr_r};
+        else;
+            echo 'AVB verification failed.';
+            exit;
+        fi;
+    elif part number mmc 0 system is_non_avb_android; then
+        echo 'Booting Android non-AVB...';
+        booti ${kernel_addr_r} ${initrd_addr_r} ${fdt_addr_r};
+    elif iminfo ${load_addr}; then
+        echo 'Booting FIT image...';
+        bootm ${load_addr} ${load_addr} ${fdt_addr_r};
+    fi;
+    echo 'ERROR: No valid image to boot the system. Aborting boot sequence.';
diff --git a/configs/total_compute_defconfig b/configs/total_compute_defconfig
index 5f21d2e367..291083d8b6 100644
--- a/configs/total_compute_defconfig
+++ b/configs/total_compute_defconfig
@@ -18,7 +18,6 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=5
-CONFIG_BOOTCOMMAND="if part number mmc 0 vbmeta is_avb; then  echo MMC with vbmeta partition detected.;  echo starting Android Verified boot.;  avb init 0;   if avb verify; then     set bootargs $bootargs $avb_bootargs;     part start mmc 0 boot boot_start;     part size mmc 0 boot boot_size;     mmc read ${load_addr} ${boot_start} ${boot_size};     bootm ${load_addr} ${load_addr} ${fdt_addr_r};   else;     echo AVB verification failed.;     exit;   fi; elif part number mmc 0 system is_non_avb_android; then   booti ${kernel_addr_r} ${initrd_addr_r} ${fdt_addr_r};else;  echo Booting FIT image.;  bootm ${load_addr} ${load_addr} ${fdt_addr_r}; fi;"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -60,3 +59,4 @@ CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=256
 # CONFIG_RANDOM_UUID is not set
 CONFIG_LIBAVB=y
+CONFIG_ENV_SOURCE_FILE=total_compute
diff --git a/include/configs/total_compute.h b/include/configs/total_compute.h
index 4c966ce4bf..5cc0166f19 100644
--- a/include/configs/total_compute.h
+++ b/include/configs/total_compute.h
@@ -11,16 +11,6 @@
 
 /* Link Definitions */
 
-#define CFG_EXTRA_ENV_SETTINGS	\
-				"load_addr=0xa0000000\0"	\
-				"initrd_addr_r=0x88000000\0"
-/*
- * If vbmeta partition is present, boot Android with verification using AVB.
- * Else if system partition is present (no vbmeta partition), boot Android
- * without verification (for development purposes).
- * Else boot FIT image.
- */
-
 #define CFG_SYS_FLASH_BASE		0x0C000000
 
 #endif /* __TOTAL_COMPUTE_H */
-- 
2.34.1

