Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34889CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 15:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8029F83BA1;
	Mon, 17 Nov 2025 16:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sjZimpiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0999483BB1; Mon, 17 Nov 2025 16:23:17 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6E783959
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D2C5CC1265C;
 Mon, 17 Nov 2025 15:22:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E7F6F606B9;
 Mon, 17 Nov 2025 15:23:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41ECA10371D02; Mon, 17 Nov 2025 16:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763392993; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=byjl5e9wiGbUtuM96TDDrPdr3+/1Gw6t0jxAaV5Vrx0=;
 b=sjZimpiQwg75Wo/8s/BpffDYoUocAacfVQvN29Yv8bIFbWJpKCa8FwiVBGtTfGZ5DlDKXe
 ZOjhg1Lw1IobU2NwpgRrKUndXEswdYsHTmDjIx+/k06SwmldKwszYdQXMsupI5tjzupa28
 VmIyeqnGfWbP+XqYo4M2vQYEeHNzwX0ly6MQeZKh4Fcc60dOksxat6h80727qJJViop/9O
 XPrRz8uNuzZL1Yl9VyK4cxwqJdXy2Y61ig9JlpnXjdo1wXFw/3vdoUuoYzxgOY2JWHIf+x
 63cqX8QqLJVFSP+pXAa4UbhqEwNr8hePY3MQvftinZUW4Yhqum3WQDuwpEbNWg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
Date: Mon, 17 Nov 2025 16:23:07 +0100
Message-ID: <20251117152308.900316-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

Fix two memory allocation bugs in label_boot_extension():

1. When label->fdtdir is not set, overlay_dir was used without any
   memory allocation.

2. When label->fdtdir is set, the allocation size was incorrect,
   using 'len' (just the fdtdir length) instead of 'dir_len' (which
   includes the trailing slash and null terminator).

Resolve both issues by moving the memory allocation and string
formatting outside the conditional block, resulting in clearer code
flow and correct sizing in all cases.

Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
Addresses-Coverity-ID: 638558 Memory - illegal accesses (UNINIT)
Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 boot/pxe_utils.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..836e4eb526c 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -444,7 +444,7 @@ static void label_boot_extension(struct pxe_context *ctx,
 	const struct extension *extension;
 	struct fdt_header *working_fdt;
 	struct alist *extension_list;
-	int ret, dir_len, len;
+	int ret, dir_len, len = 0;
 	char *overlay_dir;
 	const char *slash;
 	ulong fdt_addr;
@@ -472,18 +472,16 @@ static void label_boot_extension(struct pxe_context *ctx,
 			slash = "/";
 		else
 			slash = "";
-
-		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
-		if (!overlay_dir)
-			return;
-
-		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
-			 slash);
 	} else {
-		dir_len = 2;
-		snprintf(overlay_dir, dir_len, "/");
+		slash = "/";
 	}
+	dir_len = len + strlen(slash) + 1;
+
+	overlay_dir = calloc(1, dir_len);
+	if (!overlay_dir)
+		return;
+
+	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir ?: "", slash);
 
 	alist_for_each(extension, extension_list) {
 		char *overlay_file;
-- 
2.43.0

