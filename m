Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5093AC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC15A88062;
	Tue, 27 Feb 2024 17:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ss47CVuF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OR8NmViE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6338802A; Tue, 27 Feb 2024 17:10:23 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D0D88012
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBM5ybwz9sHC;
 Tue, 27 Feb 2024 17:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGF9RwGoS3gRBI1+VebggeoR8/ifOI+uHoZN+fj5RXg=;
 b=Ss47CVuF2QwXnMTGdttODfNpOaI1/kv8xBtlEq0MpKK0OdbLLFMPEfoR4BitrtQfYtqeau
 3MqLinzckWUq6C3smfx8BJT/cfxgFgvlAr7FCTL9TXgHWHeBxJRaLbvowTah7yNzfjpeCy
 MgFhl/k4Zm9PnM6PzSXEuK5NYeU6Oa2CSkbRBo0hu5tMR03fmDUNNalME8/K/GnP3wA2ZU
 U2J6F90/RRecise/OI5Mlr8HXYBhG7U5EPUJ4Kb77AZUtmbdO1/I5cBi3sWR3xaeamMlgI
 /qIGz661HQUscUOZ2LBLSfjrDE2M+SbX6EW5aRXzpVZyDSlOMDLesJfUxf09tw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGF9RwGoS3gRBI1+VebggeoR8/ifOI+uHoZN+fj5RXg=;
 b=OR8NmViEB2H0vcOyxlA8hUA9JXh5i+qNIVN5BJRtKXoHElcZOAlkxgzP2/ZvIaXbzI9Rwp
 YHiFbMj/uAC718JJgWsv91/BUtkfKSxXt04D1W7oaE0Y1NUGqnLlSRneqy5wPzw9GmKdTy
 1rB7AmcZTW0awXahIlQwkEeWVYIV8cOY5H6kdCmLGo0ezl6+g9wa5eDsKa4bET8Er0d70I
 qZm8hOrI2v0ImJZ7DZwRtNcr6Q9YqdLe3keLVDreapFTnxH7EOEWPg9dO1YXLfHgZ74sMH
 Q4N/rITxbDl81TfcwNIcc7VYYVLF0UqnC+SFnQkRfybIPLcitgFUoJYXJTnYOg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/19] ARM: renesas: Rename CONFIG_ARCH_RMOBILE_EXTRAM_BOOT to
 CONFIG_RENESAS_EXTRAM_BOOT
Date: Tue, 27 Feb 2024 17:05:53 +0100
Message-ID: <20240227160912.412181-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6rnppz3sg5c4hao5knb7ypaj9brbxseg
X-MBO-RS-ID: 0c59748d2defc135d77
X-Rspamd-Queue-Id: 4TkjBM5ybwz9sHC
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

Rename CONFIG_ARCH_RMOBILE_EXTRAM_BOOT to CONFIG_RMOBILE_EXTRAM_BOOT
because the former symbol does not exist and it is only incorrectly
converted CONFIG_RMOBILE_EXTRAM_BOOT which does exist. Replace the
RMOBILE with RENESAS because all the chips are made by Renesas, while
only a subset of them is from the R-Mobile line.

Use the following command to perform the rename with manual Kconfig.32 fix:

"
$ sed -i 's@CONFIG_ARCH_RMOBILE_EXTRAM_BOOT@CONFIG_RMOBILE_EXTRAM_BOOT@g' board/renesas/*/*
$ sed -i 's@CONFIG_RMOBILE_EXTRAM_BOOT@CONFIG_RENESAS_EXTRAM_BOOT@g' board/renesas/*/*
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/Kconfig.32 | 2 +-
 board/renesas/alt/qos.c          | 6 +++---
 board/renesas/blanche/qos.c      | 6 +++---
 board/renesas/gose/qos.c         | 6 +++---
 board/renesas/koelsch/qos.c      | 6 +++---
 board/renesas/lager/qos.c        | 6 +++---
 board/renesas/porter/qos.c       | 6 +++---
 board/renesas/silk/qos.c         | 6 +++---
 board/renesas/stout/qos.c        | 6 +++---
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-rmobile/Kconfig.32 b/arch/arm/mach-rmobile/Kconfig.32
index b546e097c34..693a5abba0d 100644
--- a/arch/arm/mach-rmobile/Kconfig.32
+++ b/arch/arm/mach-rmobile/Kconfig.32
@@ -122,7 +122,7 @@ endchoice
 config TMU_TIMER
 	bool
 
-config RMOBILE_EXTRAM_BOOT
+config RENESAS_EXTRAM_BOOT
 	bool "Enable boot from RAM"
 	depends on TARGET_ALT || TARGET_BLANCHE || TARGET_KOELSCH || TARGET_LAGER || TARGET_PORTER || TARGET_SILK || TARGET_STOUT
 
diff --git a/board/renesas/alt/qos.c b/board/renesas/alt/qos.c
index 38dfa647e81..f0cdad4a80f 100644
--- a/board/renesas/alt/qos.c
+++ b/board/renesas/alt/qos.c
@@ -11,7 +11,7 @@
 #include <asm/io.h>
 #include <asm/arch/rmobile.h>
 
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.311 for ES1 and version 0.321 for ES2 */
 
 enum {
@@ -991,8 +991,8 @@ void qos_init(void)
 	writel(0x00000001, &axi_qos->qosthres2);
 	writel(0x00000001, &axi_qos->qosqon);
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/blanche/qos.c b/board/renesas/blanche/qos.c
index 3134b36a443..d18877ee6db 100644
--- a/board/renesas/blanche/qos.c
+++ b/board/renesas/blanche/qos.c
@@ -10,7 +10,7 @@
 #include <asm/io.h>
 #include <asm/arch/rmobile.h>
 
-#if defined(CONFIG_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
 	DBSC3_05, DBSC3_06, DBSC3_07, DBSC3_08, DBSC3_09,
@@ -1357,8 +1357,8 @@ void qos_init(void)
 	writel(0x0000F700, CCI_AXI_AX2ADDRMASK);
 
 }
-#else /* CONFIG_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/gose/qos.c b/board/renesas/gose/qos.c
index 9944df76759..fca30185231 100644
--- a/board/renesas/gose/qos.c
+++ b/board/renesas/gose/qos.c
@@ -11,7 +11,7 @@
 #include <asm/io.h>
 #include <asm/arch/rmobile.h>
 
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.311 */
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
@@ -1194,8 +1194,8 @@ void qos_init(void)
 	writel(0x00000001, &axi_qos->qosthres2);
 	writel(0x00000001, &axi_qos->qosqon);
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/koelsch/qos.c b/board/renesas/koelsch/qos.c
index 70cd117ba6b..c947fff75c7 100644
--- a/board/renesas/koelsch/qos.c
+++ b/board/renesas/koelsch/qos.c
@@ -12,7 +12,7 @@
 #include <asm/arch/rmobile.h>
 
 /* QoS version 0.240 for ES1 and version 0.411 for ES2 */
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
 	DBSC3_05, DBSC3_06, DBSC3_07, DBSC3_08, DBSC3_09,
@@ -1382,8 +1382,8 @@ void qos_init(void)
 	writel(0x00000001, &axi_qos->qosthres2);
 	writel(0x00000001, &axi_qos->qosqon);
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/lager/qos.c b/board/renesas/lager/qos.c
index f7eade2ed11..d12fdf0f11f 100644
--- a/board/renesas/lager/qos.c
+++ b/board/renesas/lager/qos.c
@@ -11,7 +11,7 @@
 #include <asm/arch/rmobile.h>
 
 /* QoS version 0.955 for ES1 and version 0.973 for ES2 */
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
 	DBSC3_05, DBSC3_06, DBSC3_07, DBSC3_08, DBSC3_09,
@@ -2424,8 +2424,8 @@ void qos_init(void)
 	else
 		qos_init_es1();
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/porter/qos.c b/board/renesas/porter/qos.c
index e4d8f3dfafe..da6ae9ac559 100644
--- a/board/renesas/porter/qos.c
+++ b/board/renesas/porter/qos.c
@@ -13,7 +13,7 @@
 #include <asm/arch/rmobile.h>
 
 /* QoS version 0.240 for ES1 and version 0.334 for ES2 */
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
 	DBSC3_05, DBSC3_06, DBSC3_07, DBSC3_08, DBSC3_09,
@@ -1303,8 +1303,8 @@ void qos_init(void)
 	writel(0x00000001, &axi_qos->qosthres2);
 	writel(0x00000001, &axi_qos->qosqon);
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/silk/qos.c b/board/renesas/silk/qos.c
index bdd76461b6a..c1d4c612df8 100644
--- a/board/renesas/silk/qos.c
+++ b/board/renesas/silk/qos.c
@@ -12,7 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch/rmobile.h>
 
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.11 */
 
 enum {
@@ -942,8 +942,8 @@ void qos_init(void)
 	writel(0x00000001, &axi_qos->qosthres2);
 	writel(0x00000001, &axi_qos->qosqon);
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
diff --git a/board/renesas/stout/qos.c b/board/renesas/stout/qos.c
index 8a878123a5d..10f99f340b8 100644
--- a/board/renesas/stout/qos.c
+++ b/board/renesas/stout/qos.c
@@ -13,7 +13,7 @@
 #include <asm/arch/rmobile.h>
 
 /* QoS version 0.955 for ES1 and version 0.973 for ES2 */
-#if defined(CONFIG_ARCH_RMOBILE_EXTRAM_BOOT)
+#if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
 	DBSC3_00, DBSC3_01, DBSC3_02, DBSC3_03, DBSC3_04,
 	DBSC3_05, DBSC3_06, DBSC3_07, DBSC3_08, DBSC3_09,
@@ -2426,8 +2426,8 @@ void qos_init(void)
 	else
 		qos_init_es1();
 }
-#else /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#else /* CONFIG_RENESAS_EXTRAM_BOOT */
 void qos_init(void)
 {
 }
-#endif /* CONFIG_ARCH_RMOBILE_EXTRAM_BOOT */
+#endif /* CONFIG_RENESAS_EXTRAM_BOOT */
-- 
2.43.0

