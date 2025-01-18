Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47584C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE748073D;
	Sat, 18 Jan 2025 05:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QfrpiZiK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jNUjM7HV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664C58070C; Sat, 18 Jan 2025 05:02:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DF58036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZjbd33Y3z9sX2;
 Sat, 18 Jan 2025 05:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xriR+QuqNQKLYuylhL8XpBglueKjJwxF/dfS8ACm67c=;
 b=QfrpiZiKs3DyaF8rSP51Ju/iF53kUnR2ALFomqsu62x7FheH6Qi7CdCBp8HA+MsIJkeU0Y
 4cSRBn7wVagUdRkUUKfybE2X6FWOQh8GObBbq6PhpV7NRm+QC7iCgcMTE15P28YEW8ff1L
 VMgf3JnRmRz4w7te/xP+3sM31k5eqIcIskLLN34vWagjo4Z0aoY6LV5ilmgaCw/t5NeoC2
 VmVLtk6Vv5fTF7fAaPHT1IKoS7HZRB19vASWeHu5tBBlwlwtrmgv/3UPMWsnjsxZImTaMj
 8Id9AFEx0fBtPC450rTUn80hzpVZIMcAx6eEzfwnpkHezGkOyw9U6UxgYPw7tA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xriR+QuqNQKLYuylhL8XpBglueKjJwxF/dfS8ACm67c=;
 b=jNUjM7HVrENlVC6q/rARYdMpJFJolrX8JPPgpDep2UzJjP/THOBqwSn0XrTTxEhLvPCpRz
 ZlmxnUzgL5rHH9EhDv96W2q1vfSCOqyWk7aOfDg/BNJRZGcPDn5RKdvnsylDHKMUAcwR7z
 hFOJYOEfrQRKZYJo2cAB7dLWJ0xlJs55AyLxuF1SZqkaKy8pq3F+H/yI5nPqueevMXGGxP
 +TaWCkW+H9Jze1FcgHXSL2ePiCtzJkHdV/uK3K2vVce3H+f446wAYQIV2Kg13zg2hk87jq
 t7tOK2n2HkKZfUoDzUioC93SsYr0hkvZRDqQ7JKadUi0jxcAZKwwtjK727NXKg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] cyclic: Prevent corruption of cyclic list on reassignment
Date: Sat, 18 Jan 2025 05:00:55 +0100
Message-ID: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5bc8757db06a70b1997
X-MBO-RS-META: w13becfrdiz1y3ioha6a8djbb948um9c
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

Make cyclic_register() return error code, 0 in case of success,
-EALREADY in case the called attempts to re-register already
registered struct cyclic_info. The re-registration would lead
to corruption of gd->cyclic_list because the re-registration
would memset() one of its nodes, prevent that. Unregister only
initialized struct cyclic_info.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 common/cyclic.c  | 14 +++++++++++---
 include/cyclic.h |  9 ++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index 196797fd61e..53156a704cc 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -27,9 +27,13 @@ struct hlist_head *cyclic_get_list(void)
 	return (struct hlist_head *)&gd->cyclic_list;
 }
 
-void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
-		     uint64_t delay_us, const char *name)
+int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		    uint64_t delay_us, const char *name)
 {
+	/* Reassignment of function would corrupt cyclic list, exit */
+	if (cyclic->func)
+		return -EALREADY;
+
 	memset(cyclic, 0, sizeof(*cyclic));
 
 	/* Store values in struct */
@@ -38,11 +42,15 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
+
+	return 0;
 }
 
 void cyclic_unregister(struct cyclic_info *cyclic)
 {
-	hlist_del(&cyclic->list);
+	/* Unregister only initialized struct cyclic_info */
+	if (cyclic->func)
+		hlist_del(&cyclic->list);
 }
 
 static void cyclic_run(void)
diff --git a/include/cyclic.h b/include/cyclic.h
index c6c463d68e9..c86ac407332 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -60,8 +60,10 @@ typedef void (*cyclic_func_t)(struct cyclic_info *c);
  * The function @func will be called with @cyclic as its
  * argument. @cyclic will usually be embedded in some device-specific
  * structure, which the callback can retrieve using container_of().
+ *
+ * @return 0 on success, -EALREADY on repeated registration, -ve otherwise
  */
-void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 		     uint64_t delay_us, const char *name);
 
 /**
@@ -89,9 +91,10 @@ struct hlist_head *cyclic_get_list(void);
 
 #else
 
-static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
-				   uint64_t delay_us, const char *name)
+static inline int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+				  uint64_t delay_us, const char *name)
 {
+	return 0;
 }
 
 static inline void cyclic_unregister(struct cyclic_info *cyclic)
-- 
2.45.2

