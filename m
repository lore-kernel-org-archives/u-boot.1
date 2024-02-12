Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF3C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F4F87ED7;
	Mon, 12 Feb 2024 14:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="lCeIDG0o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0UKIOrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901D887073; Mon, 12 Feb 2024 10:33:02 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FFC87CA8
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t-8ch@linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1707730378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u7zdhebH/8yYQnYf+O44xivoghJT/RQ9QfIMD5HC5HY=;
 b=lCeIDG0ofGfGjkzyzWgQT7UU8TU8UToID9lbJS7oplRefn0THmA7THpmWrcZ8ZVTHZ2hzY
 hZlTnRiydL3PKAr11xJktYkjY/mhy71gSbNtUapY1LogJyXanJWCEk0wMWZEEkkpjONEwj
 l7wjSpOknkxesohDIOHmnGMLaZOf6+h6yZHOWnG834QvEZFcropx/JFZTUYAxIZlKnfJ9f
 ksxq1daMVR+pkvfptXm3CoOtHlpRg4+aXp0WbK6kPoDj8WqDC+muA/kAjJDPfa9Bk0w9bz
 FA9gcNrJxK6z6HTPcaRmigM4BHAH3rIlGQ4Nt2kUgvI2oJhWyLW6E4v00Ex6jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1707730378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u7zdhebH/8yYQnYf+O44xivoghJT/RQ9QfIMD5HC5HY=;
 b=D0UKIOrnUaTF6D23vkabWtaV6rqD/42t7IGm2cY82Hr+eGc2RnOJE7N0ti0sEySkRsAca0
 hIB+Zv51XW96nhAw==
Date: Mon, 12 Feb 2024 10:32:56 +0100
Subject: [PATCH] log: make global data relocatable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-spl-logging-v1-1-051cde837559@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAMflyWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwML3eKCHN2c/PT0zLx0XUOTREMjU/NkY0MTcyWgjoKi1LTMCrBp0bG
 1tQDQpBv/XQAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707730377; l=3884;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Qkt+NXi4Y+g6MRNsMkk7TC5e1jK+mMHfTll29WmFNrk=;
 b=9KizOiL1JvkSYlX6p+WX3W0HHycBq3pdTtoU7faR7QusvgovppusETw7woCNKkpZoPG630C3j
 mHE4hrGQo1wAGuagk+yyfVV3WRzBfc9U3FYaqYGwFpawNngo5LkNuqG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Mailman-Approved-At: Mon, 12 Feb 2024 14:19:09 +0100
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

When `gd` is relocated during `spl_relocate_stack_gd()` the
doubly-linked circular list in the `log_head` member is broken.

The last element of the list should point back to the initial
`list_head`, but as the initial `list_head` is moved the pointer becomes
stale. As a result the loop in `log_dispatch` would never finish.

Migrate the list to a singly-linked non-circular one which is
easily relocatable.

This should also remove the special handling introduced in
commit e7595aa350ae ("x86: Allow logging to be used in SPL reliably").

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 common/log.c                      | 15 +++++++++------
 include/asm-generic/global_data.h |  2 +-
 include/log.h                     |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..098d40c86d81 100644
--- a/common/log.c
+++ b/common/log.c
@@ -109,7 +109,7 @@ struct log_device *log_device_find_by_name(const char *drv_name)
 {
 	struct log_device *ldev;
 
-	list_for_each_entry(ldev, &gd->log_head, sibling_node) {
+	for (ldev = gd->log_head; ldev; ldev = ldev->sibling_node) {
 		if (!strcmp(drv_name, ldev->drv->name))
 			return ldev;
 	}
@@ -218,7 +218,7 @@ static int log_dispatch(struct log_rec *rec, const char *fmt, va_list args)
 
 	/* Emit message */
 	gd->processing_msg = true;
-	list_for_each_entry(ldev, &gd->log_head, sibling_node) {
+	for (ldev = gd->log_head; ldev; ldev = ldev->sibling_node) {
 		if ((ldev->flags & LOGDF_ENABLE) &&
 		    log_passes_filters(ldev, rec)) {
 			if (!rec->msg) {
@@ -400,7 +400,7 @@ static struct log_device *log_find_device_by_drv(struct log_driver *drv)
 {
 	struct log_device *ldev;
 
-	list_for_each_entry(ldev, &gd->log_head, sibling_node) {
+	for (ldev = gd->log_head; ldev; ldev = ldev->sibling_node) {
 		if (ldev->drv == drv)
 			return ldev;
 	}
@@ -433,13 +433,16 @@ int log_init(void)
 	struct log_driver *drv = ll_entry_start(struct log_driver, log_driver);
 	const int count = ll_entry_count(struct log_driver, log_driver);
 	struct log_driver *end = drv + count;
+	struct log_device **log_head;
+
+	gd->log_head = NULL;
+	log_head = (struct log_device **)&gd->log_head;
 
 	/*
 	 * We cannot add runtime data to the driver since it is likely stored
 	 * in rodata. Instead, set up a 'device' corresponding to each driver.
 	 * We only support having a single device for each driver.
 	 */
-	INIT_LIST_HEAD((struct list_head *)&gd->log_head);
 	while (drv < end) {
 		struct log_device *ldev;
 
@@ -451,8 +454,8 @@ int log_init(void)
 		INIT_LIST_HEAD(&ldev->filter_head);
 		ldev->drv = drv;
 		ldev->flags = drv->flags;
-		list_add_tail(&ldev->sibling_node,
-			      (struct list_head *)&gd->log_head);
+		*log_head = ldev;
+		log_head = &ldev->sibling_node;
 		drv++;
 	}
 	gd->flags |= GD_FLG_LOG_READY;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index fcc3c6e14ca3..a9a407b801c2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -404,7 +404,7 @@ struct global_data {
 	/**
 	 * @log_head: list of logging devices
 	 */
-	struct list_head log_head;
+	struct log_device *log_head;
 	/**
 	 * @log_fmt: bit mask for logging format
 	 *
diff --git a/include/log.h b/include/log.h
index 6e84f080ef3d..961233684d2a 100644
--- a/include/log.h
+++ b/include/log.h
@@ -455,7 +455,7 @@ struct log_device {
 	unsigned short flags;
 	struct log_driver *drv;
 	struct list_head filter_head;
-	struct list_head sibling_node;
+	struct log_device *sibling_node;
 };
 
 enum {

---
base-commit: e8f2404e093daf6cc3ac2b3233e3c6770d13e371
change-id: 20240208-spl-logging-14a1257c3147

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

