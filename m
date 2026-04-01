Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF14D3517C
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 12:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616138408D;
	Wed,  1 Apr 2026 14:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E74C8407E; Wed,  1 Apr 2026 11:00:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CD780212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunguang.li_2@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 642A71A3D10;
 Wed,  1 Apr 2026 11:00:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 330651A3CF7;
 Wed,  1 Apr 2026 11:00:08 +0200 (CEST)
Received: from bjse.cn-bjs01.nxp.com (bjse.cn-bjs01.nxp.com [10.193.20.96])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 757BB1800090;
 Wed,  1 Apr 2026 17:00:06 +0800 (+08)
From: chunguang.li_2@nxp.com
To: trini@konsulko.com,
	meenakshi.aggarwal@nxp.com,
	andy.tang@nxp.com
Cc: chunguang.li_2@nxp.com, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, u-boot@lists.denx.de,
 mingkai.hu@nxp.com, Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com,
 camelia.groza@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: [PATCH 3/4] ls1046ardb: refactor EXTRA_ENV_SETTINGS and add
 board-specific overrides
Date: Wed,  1 Apr 2026 16:59:46 +0800
Message-ID: <20260401085947.1670191-3-chunguang.li_2@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401085947.1670191-1-chunguang.li_2@nxp.com>
References: <20260401085947.1670191-1-chunguang.li_2@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 14:56:02 +0200
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

From: Chunguang Li <chunguang.li_2@nxp.com>

Upstream-Status: Inappropriate
Signed-off-by: Chunguang Li <chunguang.li_2@nxp.com>

- Rename CFG_EXTRA_ENV_SETTINGS → EXTRA_ENV_SETTINGS in ls1046a_common.h
- Adjust console parameter in the common environment
- Add CFG_EXTRA_ENV_SETTINGS in ls1046ardb.h with additional board/image/fdtfile variables
- Set CFG_EXTRA_ENV_SETTINGS in ls1046aqds.h to EXTRA_ENV_SETTINGS

Enables board‑specific env customization while keeping LS1046A common env shared.
---
 include/configs/ls1046a_common.h |  2 +-
 include/configs/ls1046afrwy.h    |  6 ++++++
 include/configs/ls1046aqds.h     |  5 +++++
 include/configs/ls1046ardb.h     | 10 ++++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/configs/ls1046a_common.h b/include/configs/ls1046a_common.h
index 8666aff0f33..e99c677f2d1 100644
--- a/include/configs/ls1046a_common.h
+++ b/include/configs/ls1046a_common.h
@@ -83,7 +83,7 @@
 #endif
 #ifndef SPL_NO_MISC
 /* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
+#define EXTRA_ENV_SETTINGS         \
 	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
 	"ramdisk_addr=0x800000\0"		\
 	"ramdisk_size=0x2000000\0"		\
diff --git a/include/configs/ls1046afrwy.h b/include/configs/ls1046afrwy.h
index 21804fc6654..07846c3bd25 100644
--- a/include/configs/ls1046afrwy.h
+++ b/include/configs/ls1046afrwy.h
@@ -70,6 +70,12 @@
 /*
  * Environment
  */
+#ifndef SPL_NO_MISC
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS      \
+	EXTRA_ENV_SETTINGS
+#endif
+
 #define CFG_SYS_FSL_QSPI_BASE	0x40000000
 
 #undef BOOT_TARGET_DEVICES
diff --git a/include/configs/ls1046aqds.h b/include/configs/ls1046aqds.h
index 4b4bd7cbe48..001118b8504 100644
--- a/include/configs/ls1046aqds.h
+++ b/include/configs/ls1046aqds.h
@@ -312,6 +312,11 @@
 /*
  * Environment
  */
+#ifndef SPL_NO_MISC
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS      \
+	EXTRA_ENV_SETTINGS
+#endif
 
 #ifdef CONFIG_TFABOOT
 #define IFC_NAND_BOOTCOMMAND "run distro_bootcmd; run nand_bootcmd; "	\
diff --git a/include/configs/ls1046ardb.h b/include/configs/ls1046ardb.h
index b2a8bd5cf8a..dfe5270142d 100644
--- a/include/configs/ls1046ardb.h
+++ b/include/configs/ls1046ardb.h
@@ -132,4 +132,14 @@
 
 #include <asm/fsl_secure_boot.h>
 
+#ifndef SPL_NO_MISC
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS      \
+	EXTRA_ENV_SETTINGS				\
+	"board=ls1046ardb\0"            \
+	"fdtfile=fsl-ls1046a-rdb-sdk.dtb\0"     \
+	"image=Image\0"					\
+	"console_dbg=earlycon=uart8250,mmio,0x21c0500\0"
+#endif
+
 #endif /* __LS1046ARDB_H__ */
-- 
2.34.1

