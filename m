Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA8CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DA2834D4;
	Thu,  2 Oct 2025 18:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64302835CB; Thu,  2 Oct 2025 18:25:09 +0200 (CEST)
Received: from server.mars-solutions.it (server.mars-solutions.it
 [88.198.47.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DC0828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=apr@cn-eng.de
Received: from nb-apr.fritz.box (ip-078-043-169-169.um18.pools.vodafone-ip.de
 [78.43.169.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by server.mars-solutions.it (Postfix) with ESMTPSA id EF87376A205C;
 Thu,  2 Oct 2025 18:25:06 +0200 (CEST)
From: Andreas Pretzsch <apr@cn-eng.de>
To: u-boot@lists.denx.de
Cc: Martin Schwan <m.schwan@phytec.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] bootstd: rauc: no valid slot fallback: fix info msg to
 reflect real flow
Date: Thu,  2 Oct 2025 18:24:58 +0200
Message-ID: <20251002162506.3908711-2-apr@cn-eng.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002162506.3908711-1-apr@cn-eng.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <20251002162506.3908711-1-apr@cn-eng.de>
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

If there is no more active slot found in find_active_slot(), like when
all slots in BOOT_ORDER have a count of 0, the counters are reset to their
default value CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES. The BOOT_ORDER is _not_
changed, which is logically correct (especially for the case when there is
only one (active) slot set, e.g. BOOT_ORDER only contains 'B', probably due
to RAUC option prevent-late-fallback being set). Resetting the counters of
inactive slots also does not harm here, and is fine as a generic solution.

But the log_info statement in this scenario
  INFO: Resetting boot order and all slot tries
is incorrect. Change this to
  INFO: Resetting all slot tries to 3
with the 3 being inserted by CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES.

Signed-off-by: Andreas Pretzsch <apr@cn-eng.de>
Reviewed-by: Martin Schwan <m.schwan@phytec.de>
---
Changes for v2:
  - add Reviewed-by of Martin Schwan

 boot/bootmeth_rauc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 81a73046e83..f5d5a971e87 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -18,6 +18,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <string.h>
+#include <linux/stringify.h>
 #include <asm/cache.h>
 
 /* Length of env var "BOOT_*_LEFT" */
@@ -304,7 +305,7 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 	if (!slot_found) {
 		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
 			log_warning("WARNING: No valid slot found\n");
-			log_info("INFO: Resetting boot order and all slot tries\n");
+			log_info("INFO: Resetting all slot tries to " __stringify(CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES) "\n");
 			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
 			for (i = 0; boot_order_list[i]; i++) {
 				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
-- 
2.43.0

