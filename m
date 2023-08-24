Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF3C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F5983F7D;
	Thu, 24 Aug 2023 20:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dng8gU32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81EAA846EE; Thu, 24 Aug 2023 20:23:59 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9B280778
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso391265ab.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692901435; x=1693506235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dl5ujS9XlpcWpR+9hOmFZesABJUOD9Nhdo8kHjbL2zY=;
 b=dng8gU32NAMyjAipsAlo3pEkKFhUxiK4SL9d7WrTF7kLK4k/IxbuVBJ9jS+VcnewP+
 4LZpuYFlutzOPWDlnW8VXKnXROpoBSyiwOrzyjfnNbfqEhxGOmjVi5veoCfJUZYbYpIm
 860hFAmgmfPhW1NCYu1aMhXw8B3lRUWK2w9dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692901435; x=1693506235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dl5ujS9XlpcWpR+9hOmFZesABJUOD9Nhdo8kHjbL2zY=;
 b=OFdtVQwXTCrPDGuvqpL4ARoIRKJhCelXjSTh8rJo58BKy3vbMSHD2FZW1wY6AyzPNN
 Spp31JY3dje7NncM7v9nL0DjsIWRbKmcHGx1sHJw68pLnxHK1rSrte4vaEBK+1iKju/1
 bczagoB4xvi5bmKKPL96p71AUtvtMvueSxdlRpIQ4zPLX4lpMgvK9CXI45J8Ga/OcbX3
 VQoQdmVwY2FNzCS29OK0qZ8UeX2FDYSb6teWnNCG0M+1c4PkQeo6l4C+YjpIc92O6pIP
 1KrJ04lru6QMIJCb6d8kxhfdVlil+ak2Mkcr8sS9jSGmU2D+4R+R7XeziQ0K0rOdkvFZ
 Xe6A==
X-Gm-Message-State: AOJu0YzqbErXNBYWHZG1tAr9CF2ryets3yCsNitko62o9m5QfRTDPSdv
 IF3w1SdQXHv8TiYwssZdAookAArIhC+0o/aW5kw=
X-Google-Smtp-Source: AGHT+IFJR2LRRCRZYytQ5et5C76e2d5hiooPtQPTplPr4eeWnc2GJ4HP5oRLGm47gItkgICaKEuRlg==
X-Received: by 2002:a05:6e02:12ab:b0:349:8795:15f4 with SMTP id
 f11-20020a056e0212ab00b00349879515f4mr5529234ilr.3.1692901435392; 
 Thu, 24 Aug 2023 11:23:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 a12-20020a029f8c000000b0042b0f3f9367sm4714jam.129.2023.08.24.11.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:23:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] RFC: x86: acpi: Add some debugging
Date: Thu, 24 Aug 2023 12:23:33 -0600
Message-ID: <20230824182337.1666435-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824182337.1666435-1-sjg@chromium.org>
References: <20230824182337.1666435-1-sjg@chromium.org>
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

Enable some debugging to help see what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/tables.c  | 1 +
 lib/acpi/acpi_writer.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 67bc0a72aebc..7c6b32e6e335 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#define LOG_DEBUG
 #define LOG_CATEGORY LOGC_ACPI
 
 #include <common.h>
diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
index 946f90e8e7b1..b1118b602069 100644
--- a/lib/acpi/acpi_writer.c
+++ b/lib/acpi/acpi_writer.c
@@ -5,6 +5,7 @@
  * Copyright 2021 Google LLC
  */
 
+#define LOG_DEBUG
 #define LOG_CATEGORY LOGC_ACPI
 
 #include <common.h>
@@ -21,8 +22,8 @@ int acpi_write_one(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
 	int ret;
 
-	log_debug("%s: writing table '%s'\n", entry->name,
-		  entry->table);
+	log_debug("%s: writing table '%s' at %p\n", entry->name,
+		  entry->table, ctx->current);
 	ctx->tab_start = ctx->current;
 	ret = entry->h_write(ctx, entry);
 	if (ret == -ENOENT) {
@@ -57,11 +58,15 @@ static int acpi_write_all(struct acpi_ctx *ctx)
 	const struct acpi_writer *entry;
 	int ret;
 
+	log_debug("writing acpi tables\n");
+
 	for (entry = writer; entry != writer + n_ents; entry++) {
 		ret = acpi_write_one(ctx, entry);
+		log_debug("- return code %d\n", ret);
 		if (ret && ret != -ENOENT)
 			return log_msg_ret("one", ret);
 	}
+	log_debug("writing acpi tables done ok\n");
 
 	return 0;
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

