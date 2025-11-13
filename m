Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6DDCD5BA7
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 09:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E4383D77;
	Thu, 13 Nov 2025 10:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jqOhcSP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7458183D9C; Thu, 13 Nov 2025 10:33:27 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B98883B8A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 10:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 171AEC0F57C;
 Thu, 13 Nov 2025 09:33:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C10466068C;
 Thu, 13 Nov 2025 09:33:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 21F56102F21A8; Thu, 13 Nov 2025 10:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763026403; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=dlRpShcrjLRa29cq8vzwUT5UCwCSQIxDZrE3hNkOLxQ=;
 b=jqOhcSP7RiEf7nrycNtQqnH+fAEUU6ZeX49qvLQNOUXF3ef6Efmb5Nw1Kcuu1qLwp7UXy9
 pvwu/FfU+NjiWvRL7Y0vbkJp0bTaXAKo0k5xHCxdRlr3J2+VecMDT1ZkLc2s9vVn0kc6j5
 meo1l+5slPvKg1EAzjjmWPcB2YUk5v27djZ9LsmMGBIX5ZLYiDUrqyRsAV3ywpPtI0RkTp
 Ue2YC0qLYKhR86TOMXwgxFGfNt/pw9c6oL1ai2ON44FtmQmZsyjb0qOx4n3G+mypDMsVaS
 YO90BNZN/5rn6M9KTDiOs9K5EYOKLclwqJh4CZY+z/oQrQTcv+IWu0MF1/Q2mw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
Date: Thu, 13 Nov 2025 10:33:12 +0100
Message-ID: <20251113093313.362055-1-kory.maincent@bootlin.com>
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
Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- Extract calloc and snprintf of the if condition.
---
 boot/pxe_utils.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..7549a93bdad 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -473,18 +473,18 @@ static void label_boot_extension(struct pxe_context *ctx,
 		else
 			slash = "";
 
-		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
-		if (!overlay_dir)
-			return;
-
-		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
-			 slash);
+		dir_len = len + strlen(slash) + 1;
 	} else {
 		dir_len = 2;
-		snprintf(overlay_dir, dir_len, "/");
+		slash = "/";
 	}
 
+	overlay_dir = calloc(1, dir_len);
+	if (!overlay_dir)
+		return;
+
+	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir ?: "", slash);
+
 	alist_for_each(extension, extension_list) {
 		char *overlay_file;
 		ulong size;
-- 
2.43.0

