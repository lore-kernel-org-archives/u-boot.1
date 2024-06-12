Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFC5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3BF88802;
	Wed, 12 Jun 2024 16:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B0E887DD; Wed, 12 Jun 2024 16:59:01 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA77288805
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vzpb643cxznsv;
 Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vzpb61jSszCBg; Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:58:49 +0200
Subject: [PATCH 4/4] boot: bootflow_menu: fix crash for EFI BOOTMGR global
 bootmeth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-bootflow-efi-crash-v1-4-27b71b0ff08a@cherry.de>
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The global bootmeths don't set the dev in bootflow struct which means
the dev_get_parent(bflow->dev) triggers a NULL-pointer dereference and
crash U-Boot.

So before trying to handle a bootflow, check that the associated
bootmeth isn't global, otherwise skip it.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/bootflow_menu.c | 7 +++++++
 include/bootflow.h   | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 16f9cd8f8ca..70f1f728b72 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -10,6 +10,7 @@
 
 #include <common.h>
 #include <bootflow.h>
+#include <bootmeth.h>
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
@@ -77,6 +78,7 @@ int bootflow_menu_new(struct expo **expp)
 	last_bootdev = NULL;
 	for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
 	     ret = bootflow_next_glob(&bflow), i++) {
+		struct bootmeth_uc_plat *ucp;
 		char str[2], *label, *key;
 		uint preview_id;
 		bool add_gap;
@@ -84,6 +86,11 @@ int bootflow_menu_new(struct expo **expp)
 		if (bflow->state != BOOTFLOWST_READY)
 			continue;
 
+		/* No media to show for BOOTMETHF_GLOBAL bootmeths */
+		ucp = dev_get_uclass_plat(bflow->method);
+		if (ucp->flags & BOOTMETHF_GLOBAL)
+			continue;
+
 		*str = i < 10 ? '0' + i : 'A' + i - 10;
 		str[1] = '\0';
 		key = strdup(str);
diff --git a/include/bootflow.h b/include/bootflow.h
index 080ee850122..6affc5e1a4f 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -63,7 +63,8 @@ enum bootflow_flags_t {
  *
  * @bm_node: Points to siblings in the same bootdev
  * @glob_node: Points to siblings in the global list (all bootdev)
- * @dev: Bootdev device which produced this bootflow
+ * @dev: Bootdev device which produced this bootflow, NULL for flows created by
+ *      BOOTMETHF_GLOBAL bootmeths
  * @blk: Block device which contains this bootflow, NULL if this is a network
  *	device or sandbox 'host' device
  * @part: Partition number (0 for whole device)

-- 
2.45.2

