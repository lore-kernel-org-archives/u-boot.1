Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC2C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7C987D8B;
	Tue, 13 Feb 2024 20:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="MD+bbGlT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wM4R91pA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F45187D66; Tue, 13 Feb 2024 18:13:35 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD95987D1E
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 18:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t-8ch@linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1707844410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YTZifZEFViiCU/epbQU08WszqsCwOZASmInoIAzFOdU=;
 b=MD+bbGlTh/X3pk/ILudhcfWJeoEX6jlbmfcY34bzy8CO4IYvYSUxJldRaFm5N4a/HGr42u
 6Q/y4jdzACJFAuwrIrZ2ZbAV1M/HUbVizRvpWsprrFUeEy5lC2sedRCAMTsVEzw8RLeEQ/
 qmQwBoa/zqiyeLwsk4FqX/msPU5rPVT5q/rgMEhNKfHJPODIEfK3NVP5ixqUDDHquq4XiG
 hMUGRytuH/SGTFWAwg1jSZpfYiW/Ffrm0ATYTNfwca8L/oBL2aq/Hn6JpC1F+TtFFwCFnq
 apT87nXftl4NuXksTMtl+hi6FSyY4vK/lY/huyLKGZgrXojmoW31A4eJ2X6nbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1707844410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YTZifZEFViiCU/epbQU08WszqsCwOZASmInoIAzFOdU=;
 b=wM4R91pABl4GPfVhYvLQfehGCsKOQt06f0kPhuJg/MJwjf4cd6OMGKkRLChJjLE7XH8oJ+
 NliXhwoeii6crnBg==
Date: Tue, 13 Feb 2024 18:13:28 +0100
Subject: [PATCH] log: fixup log_head after relocating global data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-spl-logging-2-v1-1-e3a95b04a7f7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIADejy2UC/x3MTQqAIBBA4avIrBvwD4quEi2kRhsQFYUIwrsnL
 b/Fey80qkwNVvFCpZsb5zSgJgHH5VIg5HMYtNRWamWwlYgxh8ApoEZr3KIcSa/sDKMplTw//2/
 be/8A8irsI18AAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707844409; l=2559;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Sb/aTdjcs9OL5SnF5gsk45ciWcwA6gXkSBf+McDle84=;
 b=q/scG+YKXa8Z2QXI8gBvZSu4avrnaq/aCwOtkttEXmCV5W8udpc7gUsFRxMUnFlrCAjrmF+jw
 7zaSvUQ4aERAS3qwj3NXmmr1PX/Ii7Dj4hT4ci7Sgg/bRuB09FWEPln
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Mailman-Approved-At: Tue, 13 Feb 2024 20:42:35 +0100
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

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
This patch is a simpler alternative to https://lore.kernel.org/u-boot/20240212-spl-logging-v1-1-051cde837559@linutronix.de/

This patch should also remove the special handling introduced in
commit e7595aa350ae ("x86: Allow logging to be used in SPL reliably").
---
 common/log.c     |  4 ++++
 common/spl/spl.c |  3 +++
 include/log.h    | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..0ca2d1b4c8bc 100644
--- a/common/log.c
+++ b/common/log.c
@@ -428,6 +428,10 @@ int log_device_set_enable(struct log_driver *drv, bool enable)
 	return 0;
 }
 
+void log_fixup_for_gd_move(struct global_data *new_gd) {
+	new_gd->log_head.prev->next = &new_gd->log_head;
+}
+
 int log_init(void)
 {
 	struct log_driver *drv = ll_entry_start(struct log_driver, log_driver);
diff --git a/common/spl/spl.c b/common/spl/spl.c
index b65c439e7aa9..e06bc75d36b2 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -909,6 +909,9 @@ ulong spl_relocate_stack_gd(void)
 #if CONFIG_IS_ENABLED(DM)
 	dm_fixup_for_gd_move(new_gd);
 #endif
+#if CONFIG_IS_ENABLED(LOG)
+	log_fixup_for_gd_move(new_gd);
+#endif
 #if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 	gd = new_gd;
 #endif
diff --git a/include/log.h b/include/log.h
index 6e84f080ef3d..fc0d59844728 100644
--- a/include/log.h
+++ b/include/log.h
@@ -688,4 +688,16 @@ static inline int log_get_default_format(void)
 	       (IS_ENABLED(CONFIG_LOGF_FUNC) ? BIT(LOGF_FUNC) : 0);
 }
 
+struct global_data;
+/**
+ * log_fixup_for_gd_move() - Handle global_data moving to a new place
+ *
+ * @new_gd: Pointer to the new global data
+ *
+ * The log_head list is part of global_data. Due to the way lists work, moving
+ * the list will cause it to become invalid. This function fixes that up so
+ * that the log_head list will work correctly.
+ */
+void log_fixup_for_gd_move(struct global_data *new_gd);
+
 #endif

---
base-commit: 73b5b47dd5b546d0b9106bcca54c72815380e6d3
change-id: 20240213-spl-logging-2-43a81ae0f147

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

