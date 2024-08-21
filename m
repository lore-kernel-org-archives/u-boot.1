Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A57C5320E
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 11:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CA588BB5;
	Wed, 21 Aug 2024 12:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A96188DB5; Wed, 21 Aug 2024 12:59:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8686E88DB8
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 12:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19005DA7;
 Wed, 21 Aug 2024 04:00:22 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0323F73B;
 Wed, 21 Aug 2024 03:59:52 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 15/27] lmb: init: initialise the lmb data structures during
 board init
Date: Wed, 21 Aug 2024 16:28:27 +0530
Message-Id: <20240821105839.2870293-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V2:
* Use if(CONFIG_IS_ENABLED(...)) in initr_lmb() instead of an #ifdef.

 common/board_r.c | 10 ++++++++++
 common/spl/spl.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index f445803d7a..a60da39a29 100644
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
@@ -510,6 +511,14 @@ int initr_mem(void)
 }
 #endif
 
+static int initr_lmb(void)
+{
+	if (CONFIG_IS_ENABLED(LMB))
+		return lmb_init();
+	else
+		return 0;
+}
+
 static int dm_announce(void)
 {
 	int device_count;
@@ -612,6 +621,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_CLOCKS
 	set_cpu_clk_info, /* Setup clock information */
 #endif
+	initr_lmb,
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
 #endif
diff --git a/common/spl/spl.c b/common/spl/spl.c
index d6a364de6e..4102e25115 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -723,6 +723,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	    IS_ENABLED(CONFIG_SPL_ATF))
 		dram_init_banksize();
 
+	if (IS_ENABLED(CONFIG_SPL_LMB))
+		lmb_init();
+
 	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
 		ret = pci_init();
 		if (ret)
-- 
2.34.1

