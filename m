Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD12D3517B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 12:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A0B84056;
	Wed,  1 Apr 2026 14:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B859E83CE3; Wed,  1 Apr 2026 11:00:08 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149B683F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunguang.li_2@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0CEC1A3D11;
 Wed,  1 Apr 2026 11:00:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4D091A3D15;
 Wed,  1 Apr 2026 11:00:05 +0200 (CEST)
Received: from bjse.cn-bjs01.nxp.com (bjse.cn-bjs01.nxp.com [10.193.20.96])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E97881800097;
 Wed,  1 Apr 2026 17:00:03 +0800 (+08)
From: chunguang.li_2@nxp.com
To: trini@konsulko.com,
	meenakshi.aggarwal@nxp.com,
	andy.tang@nxp.com
Cc: chunguang.li_2@nxp.com, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, u-boot@lists.denx.de,
 mingkai.hu@nxp.com, Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com,
 camelia.groza@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: [PATCH 2/4] ls1043ardb: refactor EXTRA_ENV_SETTINGS and add
 board-specific overrides
Date: Wed,  1 Apr 2026 16:59:45 +0800
Message-ID: <20260401085947.1670191-2-chunguang.li_2@nxp.com>
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

u-boot: ls1043a: rename and reorganize EXTRA_ENV_SETTINGS for board overrides

- Rename CFG_EXTRA_ENV_SETTINGS → EXTRA_ENV_SETTINGS in ls1043a_common.h
- Adjust console parameter in the common environment
- Add CFG_EXTRA_ENV_SETTINGS in ls1043ardb.h with additional board/image/fdtfile variables
- Set CFG_EXTRA_ENV_SETTINGS in ls1043aqds.h to EXTRA_ENV_SETTINGS

Enables board‑specific env customization while keeping LS1043A common env shared.
---
 include/configs/ls1043a_common.h |  2 +-
 include/configs/ls1043aqds.h     |  5 +++++
 include/configs/ls1043ardb.h     | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_common.h
index d82502d628e..e2412936b71 100644
--- a/include/configs/ls1043a_common.h
+++ b/include/configs/ls1043a_common.h
@@ -88,7 +88,7 @@
 #include <config_distro_bootcmd.h>
 
 /* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
+#define EXTRA_ENV_SETTINGS              \
 	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
 	"fdt_high=0xffffffffffffffff\0"		\
 	"initrd_high=0xffffffffffffffff\0"	\
diff --git a/include/configs/ls1043aqds.h b/include/configs/ls1043aqds.h
index 7ccbb20bf2e..c06e986e93f 100644
--- a/include/configs/ls1043aqds.h
+++ b/include/configs/ls1043aqds.h
@@ -295,6 +295,11 @@
 /*
  * Environment
  */
+#ifndef SPL_NO_MISC
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS      \
+	EXTRA_ENV_SETTINGS
+#endif
 
 #include <asm/fsl_secure_boot.h>
 
diff --git a/include/configs/ls1043ardb.h b/include/configs/ls1043ardb.h
index ef8fdc1912b..90caf8a1371 100644
--- a/include/configs/ls1043ardb.h
+++ b/include/configs/ls1043ardb.h
@@ -201,4 +201,14 @@
 
 #include <asm/fsl_secure_boot.h>
 
+#ifndef SPL_NO_MISC
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS      \
+	EXTRA_ENV_SETTINGS              \
+	"board=ls1043ardb\0"            \
+	"fdtfile=fsl-ls1043a-rdb-sdk.dtb\0"    \
+	"image=Image\0"					\
+	"console_dbg=earlycon=uart8250,mmio,0x21c0500\0"
+#endif
+
 #endif /* __LS1043ARDB_H__ */
-- 
2.34.1

