Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A642CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E26830B5;
	Mon, 25 Aug 2025 15:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="L/dytK+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1E7830C0; Mon, 25 Aug 2025 15:55:42 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450D683093
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B83E0C994A; Mon, 25 Aug 2025 15:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130138; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OB7yFO5XjbjMjeSIKKyunTlypRW7ZNXa9qs7o9tziO0=;
 b=L/dytK+oZ+fIxs+KkthYgYt9ekA6nUb4JzxEPup3f2Rn3dI2hii2QWYX0ds0UlvXTJHhge
 18isn5IhtqDloFmVYxv4PUNHM66wxM3aePMSCEwDLYbYtQEmp+YanX3v+RfWwQjkTqQg6o
 GCWrh/auPia5bUBBvqPYdoUGuTYDmlqokMozzjibTTCIBWbM4mAq4tgArHzYoUolrGSBTU
 xDMqotTSqSeuIg7vH2pi1ZvljLipBr+h710NcDA06WrMqgwKwHBYLYTLrQvQFUlVw+8YQy
 ODV6RXfyMLsWQG0yqGMsWMSd/aqXgEwoaSgzS7OgAmWXxZYGPcGRqXUVapxPYQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, E Shattow <e@freeshell.de>
Subject: [PATCH 01/11] imx: kontron-sl-mx6ul: Fix include statements for local
 header
Date: Mon, 25 Aug 2025 15:54:25 +0200
Message-ID: <20250825135504.193004-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The header from the local directory should use double quotes instead
of brackets. Otherwise the compiler might not search the local
directory.

Fixes: 93935acc6f1d ("imx: imx6ul: kontron-sl-mx6ul: Select correct boot and env device")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx6ul/sl-mx6ul-common.c | 2 +-
 board/kontron/sl-mx6ul/sl-mx6ul.c        | 3 ++-
 board/kontron/sl-mx6ul/spl.c             | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/board/kontron/sl-mx6ul/sl-mx6ul-common.c b/board/kontron/sl-mx6ul/sl-mx6ul-common.c
index 1f24acdfa3d..bda71a330ca 100644
--- a/board/kontron/sl-mx6ul/sl-mx6ul-common.c
+++ b/board/kontron/sl-mx6ul/sl-mx6ul-common.c
@@ -6,7 +6,7 @@
 #include <asm/types.h>
 #include <asm/arch/sys_proto.h>
 
-#include <sl-mx6ul-common.h>
+#include "sl-mx6ul-common.h"
 
 bool sl_mx6ul_is_spi_nor_boot(void)
 {
diff --git a/board/kontron/sl-mx6ul/sl-mx6ul.c b/board/kontron/sl-mx6ul/sl-mx6ul.c
index 0f45ea84fc7..16d89c64d61 100644
--- a/board/kontron/sl-mx6ul/sl-mx6ul.c
+++ b/board/kontron/sl-mx6ul/sl-mx6ul.c
@@ -9,7 +9,8 @@
 #include <env_internal.h>
 #include <fdt_support.h>
 #include <phy.h>
-#include <sl-mx6ul-common.h>
+
+#include "sl-mx6ul-common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/kontron/sl-mx6ul/spl.c b/board/kontron/sl-mx6ul/spl.c
index 33e5337bcbc..8d55273dd9c 100644
--- a/board/kontron/sl-mx6ul/spl.c
+++ b/board/kontron/sl-mx6ul/spl.c
@@ -18,7 +18,8 @@
 #include <linux/sizes.h>
 #include <linux/errno.h>
 #include <mmc.h>
-#include <sl-mx6ul-common.h>
+
+#include "sl-mx6ul-common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.50.1

