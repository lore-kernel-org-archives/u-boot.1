Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F6C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CCAC8891F;
	Thu,  4 Jul 2024 09:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF51888A9; Thu,  4 Jul 2024 09:37:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BE6DA8891F
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBF8367;
 Thu,  4 Jul 2024 00:37:50 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 284C43F762;
 Thu,  4 Jul 2024 00:37:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 22/48] lmb: init: initialise the lmb data structures
 during board init
Date: Thu,  4 Jul 2024 13:05:18 +0530
Message-Id: <20240704073544.670249-23-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

The memory map maintained by the LMB module is now persistent and
global. This memory map is being maintained through the alloced list
structure which can be extended at runtime -- there is one list for
the available memory, and one for the used memory. Allocate and
initialise these lists during the board init.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Initialise the lmb structures as part of board init.
* Initialise the lmb structure durint SPL init when enabled.

 common/board_r.c |  4 ++++
 common/spl/spl.c |  4 ++++
 include/lmb.h    | 11 +++++++++++
 lib/lmb.c        | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index c823cd262f..1a5bb98218 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -22,6 +22,7 @@
 #include <hang.h>
 #include <image.h>
 #include <irq_func.h>
+#include <lmb.h>
 #include <log.h>
 #include <net.h>
 #include <asm/cache.h>
@@ -611,6 +612,9 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_CLOCKS
 	set_cpu_clk_info, /* Setup clock information */
 #endif
+#if CONFIG_IS_ENABLED(LMB)
+	initr_lmb,
+#endif
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
 #endif
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7794ddccad..633dbd1234 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -686,6 +686,10 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 				SPL_SYS_MALLOC_SIZE);
 		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	}
+
+	if (IS_ENABLED(CONFIG_SPL_LMB))
+		initr_lmb();
+
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
 		if (spl_init())
 			hang();
diff --git a/include/lmb.h b/include/lmb.h
index d0c094107c..02891a14be 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -36,6 +36,17 @@ struct lmb_region {
 	enum lmb_flags flags;
 };
 
+/**
+ * initr_lmb() - Initialise the LMB lists
+ *
+ * Initialise the LMB lists needed for keeping the memory map. There
+ * are two lists, in form of alloced list data structure. One for the
+ * available memory, and one for the used memory.
+ *
+ * Return: 0 on success, -ve on error
+ */
+int initr_lmb(void);
+
 /**
  * lmb_add_memory() - Add memory range for LMB allocations
  *
diff --git a/lib/lmb.c b/lib/lmb.c
index bf6254f4fc..1534380969 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -739,3 +739,23 @@ int lmb_mem_regions_init(void)
 
 	return 0;
 }
+
+/**
+ * initr_lmb() - Initialise the LMB lists
+ *
+ * Initialise the LMB lists needed for keeping the memory map. There
+ * are two lists, in form of alloced list data structure. One for the
+ * available memory, and one for the used memory.
+ *
+ * Return: 0 on success, -ve on error
+ */
+int initr_lmb(void)
+{
+	int ret;
+
+	ret = lmb_mem_regions_init();
+	if (ret)
+		printf("Unable to initialise the LMB data structures\n");
+
+	return ret;
+}
-- 
2.34.1

