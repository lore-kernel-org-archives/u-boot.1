Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBECCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B9483C64;
	Wed, 12 Nov 2025 14:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sH5KP2N6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D660A83C67; Wed, 12 Nov 2025 14:17:34 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C48F83C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 53B531A1A2C;
 Wed, 12 Nov 2025 13:17:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 21A326070B;
 Wed, 12 Nov 2025 13:17:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 393F1102F17CD; Wed, 12 Nov 2025 14:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762953451; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=mDKZ8tQDJwN6n4/5e8XVPqIaW4M9trCGPrvNmyHxcmQ=;
 b=sH5KP2N6rLDqoSa0b54rGKWzcJdPBoreJGiACZZPPkflr1zMn0Nq+oUUsVKC4i4wpnVhYh
 HPyZ0m+AqRq+9W9SX1DB0BAfBXWm8VQs0rsWn/ISVWmEEfQuPbeDD0VZ9nyUJJKnO64Pzu
 bGXpC7cItt8Vg+UCmu+zn6Q+m/T43edubMEuD5/Vl2E7rhOXeMn1Zu83Dbzemj/jmk/ZlL
 6Tfz2wx2Yw/li2xqHI6ZWTvZDHiJnEul0hspURaRUHcpZy/iFz0E5blC0BcQ4hn5F5Da+H
 84ZCpRWzSr4DaFSrhOUZNn9tgFgRxPkoMYYn/LH619cTCxM51Xh+3PNiVdn8vw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] boot: pxe_utils: Fix memory allocation issues in overlay_dir
 handling
Date: Wed, 12 Nov 2025 14:17:18 +0100
Message-ID: <20251112131719.98950-1-kory.maincent@bootlin.com>
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
   memory allocation. Add the missing calloc() in the else branch.

2. When label->fdtdir is set, the allocation incorrectly used the
   'len' variable instead of 'dir_len'. The 'dir_len' variable is
   calculated to include the fdtdir length plus the trailing slash,
   while 'len' was only for the fdtdir length. This caused incorrect
   memory allocation size.

These issues could lead to memory corruption or undefined behavior when
processing device tree overlays via PXE boot.

Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 boot/pxe_utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..7a64b6b97d4 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -474,7 +474,7 @@ static void label_boot_extension(struct pxe_context *ctx,
 			slash = "";
 
 		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
+		overlay_dir = calloc(1, dir_len);
 		if (!overlay_dir)
 			return;
 
@@ -482,6 +482,10 @@ static void label_boot_extension(struct pxe_context *ctx,
 			 slash);
 	} else {
 		dir_len = 2;
+		overlay_dir = calloc(1, dir_len);
+		if (!overlay_dir)
+			return;
+
 		snprintf(overlay_dir, dir_len, "/");
 	}
 
-- 
2.43.0

