Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1CC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6360088476;
	Wed, 19 Jun 2024 14:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mTeBAmC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B4C87923; Wed, 19 Jun 2024 14:34:59 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70646881C6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eb6b1045f7so227488739f.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718800496; x=1719405296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mFX2W7ShG88fWRML5sLLz2A3FSXY/nbg99ZII5hlqQs=;
 b=mTeBAmC3ihbGie5ZhYbccvBWdtD84MBsJJ/bUj7J2MGaf5MO8vwWiqhetxunYnlRdg
 z/KK9r8KcX7IYkImGZmWxdMIA33fgfrW6C50qkm+6oAAusJcj1JP13Xoi9/dllzqdP71
 CdQQgfgU/qE5R5AdFXzlClXgExok22WM9ThM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718800496; x=1719405296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mFX2W7ShG88fWRML5sLLz2A3FSXY/nbg99ZII5hlqQs=;
 b=HBHzIu+WXFRMo4TvQF9n/EKVyncJ88l7i4I9ArxnvOjBtzjySV8rXOjJZK/Rwm1eV2
 CDGnOS+VVK32paU3GgKrUvH6AW0yKDj0gAe/hfO9eZdmQwFZ3jByXI7IwMsRE67+RMwe
 qgQgee3vP7U5AzbGJ4JEoULngrxZWxZXo3zUCeVu2n7NPy5Nb7qf4nvomexf5gbKW7v4
 zKWuzuRabo3/JN6BDTzbnezCkcdyClcteyGlt0N2tjEHkAw+m3poHIcwtAluQFwUMPK1
 vzadVa38By3bo80kZ74JVJ5LpWNPMgTv+dQyvl57Zpp848H6CGMFr6zxMl/rC1eVHGZp
 S36A==
X-Gm-Message-State: AOJu0YxoRCYtQmABkDUIq2LMbhgOvhf51kS4l8pEPNcPuVv3LVPw6+sL
 dLHTLTpBnsRnERZGN5CW9SnJTaj6KsDJCNVSAPb0I469aE9BTen/hSud26Ypa6enEZNiy6y5ucd
 F4Q==
X-Google-Smtp-Source: AGHT+IHLswwISAWQQlmerEg73fSKKRmnBwbi8gVMoCIXWYMKkei8bFB2TKU7SsX7yPTTH+pBx+xHQQ==
X-Received: by 2002:a05:6602:2cd4:b0:7eb:7e0c:d17f with SMTP id
 ca18e2360f4ac-7f13edb2730mr303597239f.1.1718800494981; 
 Wed, 19 Jun 2024 05:34:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b956a20f18sm3701882173.133.2024.06.19.05.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 05:34:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Menzel <paulepanter@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] pxe: Add debugging for booting
Date: Wed, 19 Jun 2024 06:34:50 -0600
Message-Id: <20240619123453.720600-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Show which boot protocol is being used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 4b22bb6f525..53ddb16be73 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#define LOG_CATEGORY	LOGC_BOOT
+
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -762,17 +764,22 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
-            IS_ENABLED(CONFIG_CMD_BOOTM))
+	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
+		log_debug("using bootm\n");
 		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
 	/* Try booting an AArch64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTI))
+	} else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+		log_debug("using booti\n");
 		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
 	/* Try booting a Image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
+	} else if (IS_ENABLED(CONFIG_CMD_BOOTZ)) {
+		log_debug("using bootz\n");
 		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
 	/* Try booting an x86_64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
+	} else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
+		log_debug("using zboot\n");
 		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
+	}
 
 	unmap_sysmem(buf);
 
-- 
2.34.1

