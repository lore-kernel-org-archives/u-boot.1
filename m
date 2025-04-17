Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208CAC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5A9830E9;
	Thu, 17 Apr 2025 20:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SUo7ovok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA8183102; Thu, 17 Apr 2025 20:17:00 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4A1830EA
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d589ed2b47so3441535ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913817; x=1745518617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfjJY6xZ/5N/uHWZhgCN3CyWchK0E/3fjjBV47a/97c=;
 b=SUo7ovokCoENGszysEC0vd9aoMzO+ZWynLnmot3FssyrQHrBKZdu/pfda48mBfe4ye
 +ZkIUHxlLW4471VxKOWDmHOGK6pvgkrknbN206NGyLjn48WtOqoQYDEVUefPMiGRg3DO
 utZCw6awYuotALy2YpMmvApy8atlJtXrTlJ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913817; x=1745518617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfjJY6xZ/5N/uHWZhgCN3CyWchK0E/3fjjBV47a/97c=;
 b=qHv5flddVz83AGkxcX0tUSYxBFr6/ge5OlaU7jxMIZbGcWhFAYAJSxmpXBNRbx+33P
 MezvaVQdi2wS3HB16DG2AbJM/7GozgQMtL/hafLmXTEyx3/LbbbMrscK01UCEUpgNJkH
 EhDIr6mZlDqy6hZWtEfOkx6tfE6/FfLTJINTM96QWOVRRx5AN7XVs99CGYagxgbcxVU8
 gpML+SyAwGOoz+9LeQHqWa8n7D7/CPP6SWJAmK0C4rw1E/tuefpcRpp89S5CX9JI1NPL
 Z7naPqBRGmfIajKCuCTZ/9ciEqyOkQI9eP+tGPSFYo1aqVKwIJgtCOvwTOt6j3aXSk7D
 gDFA==
X-Gm-Message-State: AOJu0Yz7rMN9VWiqzLEIlonz6OTg7hTgytV811GHaqPRLntNpNVk43zo
 Eu84sjKQpyhMtzfHHMSQg/kMRqGp0fHsfZ1R7fyRL0ri6E0uZNrEkiZcB212KxT/Z2CyAE4HVxg
 =
X-Gm-Gg: ASbGnctb/tTOwp3cSUatHDnCoKnMRAj4KRGAW4P2AQsIuxQq9rM2oBJDjb4ZsFO701W
 FMXtdVpniRsESmxZgepg6Cv8ZNz3GdFdR8cGlOhSU8Qtg2ZqFQbQsnE3xjD4HrEJTgj9DrFIzJE
 qrpfsg135n3cWQ6xaM6xHDFQLMIeUkYAtzbzNP5KnlNBdss0JvzTKD9TErj8eBq9y9UR+oVw0TQ
 wILri+gntNlJqTcDqkoCkuAL1JOl3c3inspOXc8YSF67bOQ4x2tgAu7ZTpm6OH0qSXARKFnP9AY
 EnOf5OW29CA5A3eHGh/m+zFZgmjh0Ihib4vhtGGbzwCJuIHfHNaIy3L1oEZG03OZqXQXYY6N/3v
 uPA==
X-Google-Smtp-Source: AGHT+IGXjyjnMDsPAplBULKl+Mkc/93x6RKBFwAoVGOd45kSKD8UqQDn43Gdr6Y9B3k5YZ4EMb+ygw==
X-Received: by 2002:a05:6e02:214f:b0:3d8:1b0b:c92b with SMTP id
 e9e14a558f8ab-3d88ed7c360mr1335315ab.2.1744913816600; 
 Thu, 17 Apr 2025 11:16:56 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 09/22] bloblist: Adjust how the bloblist is received from
 passage
Date: Thu, 17 Apr 2025 12:15:51 -0600
Message-ID: <20250417181613.1355024-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

With standard passage we can read the bloblist from global_data. Update
the implementation to handle this, thus simplifying the code somewhat.

Shrink the log_msg_ret() string back down to a more normal size.

Note that if OF_BLOBLIST is enabled, this code should never be reached
unless there is a valid bloblist, since the devicetree is processed
first.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to adjust how the bloblist is received from stdpass

 common/bloblist.c | 70 ++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..c7322b96bcb 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <passage.h>
 #include <spl.h>
 #include <tables_csum.h>
 #include <asm/global_data.h>
@@ -513,47 +514,37 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
-	ulong addr = 0, size;
-
-	/* Check if a valid transfer list passed in */
-	if (!xferlist_from_boot_arg(&addr)) {
-		size = bloblist_get_total_size();
-	} else {
-		/*
-		 * If U-Boot is not in the first phase, an existing bloblist must
-		 * be at a fixed address.
-		 */
-		bool from_addr = fixed && !xpl_is_first_phase();
-
-		/*
-		 * If Firmware Handoff is mandatory but no transfer list is
-		 * observed, report it as an error.
-		 */
-		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
-			return -ENOENT;
-
-		ret = -ENOENT;
-
-		if (xpl_prev_phase() == PHASE_TPL &&
-		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-			from_addr = false;
-		if (fixed)
-			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-					      CONFIG_BLOBLIST_ADDR);
-		size = CONFIG_BLOBLIST_SIZE;
-
-		if (from_addr)
-			ret = bloblist_check(addr, size);
-
-		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
+	int ret = -ENOENT;
+	ulong addr, size;
+	bool expected;
+
+	/**
+	 * We don't expect to find an existing bloblist in the first phase of
+	 * U-Boot that runs. The only way to receive the address of an allocated
+	 * bloblist from a previous stage is with standard passage, so without
+	 * that, the bloblist must be at a fixed address.
+	 */
+	expected = (fixed && !xpl_is_first_phase()) || passage_valid();
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+		expected = false;
+	if (fixed)
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+	size = CONFIG_BLOBLIST_SIZE;
+	if (expected) {
+		if (passage_valid()) {
+			addr = gd_passage_bloblist();
+			size = 0;
+		}
+		ret = bloblist_check(addr, size);
+		if (ret) {
+			log_warning("Expected bloblist at %lx not found (err=%d)\n",
 				    addr, ret);
-		else
-			/* Get the real size */
+		} else {
+			/* Get the real size, if it is not what we expected */
 			size = gd->bloblist->total_size;
+		}
 	}
-
 	if (ret) {
 		/*
 		 * If we don't have a bloblist from a fixed address, or the one
@@ -567,8 +558,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-- 
2.43.0

