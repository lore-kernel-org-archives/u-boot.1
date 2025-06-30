Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B878AC8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F2481D6A;
	Mon, 30 Jun 2025 20:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nSWE2Q5F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="USCR4i3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3A581D6A; Mon, 30 Jun 2025 20:52:03 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C38882EB8
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bWFd63GgVz9t74;
 Mon, 30 Jun 2025 20:51:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvrLz5tteZK7xEFMEU81QMwNrYSsitQKdxhU30tsHSI=;
 b=nSWE2Q5FOzA4+r3Z+eOxjqJ95eRriGIpL3GCv5a8W70DIaUXWaFIEMkADgZic+RjpyxUJk
 1St2KUhlDw454h/6xxemdcidUt4e6bPnlQkgPZk+oOJd1fax0LQ2CRooouofobWpfrJUyc
 Tv51FhH2jkU8chFsvyVbVYZ61nJVv7k8xYYtSBThYRAEs/IjE7V4pNCeZFA3GCWm9Igiwa
 GYc+wNTAv79Bpkjb5MJZIuvjJWli6v8R007saoZUnLIhCTDrMjz0bP95pB45e+QR4uCxe6
 X6tKnC9CsK4gyJCcIicBbsvlBnVJK9iCbLQRu3es7nVBhTnRY2VTYcYkbBIPxg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvrLz5tteZK7xEFMEU81QMwNrYSsitQKdxhU30tsHSI=;
 b=USCR4i3AZW4zWuBPO5H6u/t0EdmFP2/4HBF1j57T3y96t7BVfS0wbR1MGmpQq/4ySR5RSX
 xGq0Oq9epobvGuxn8RL9DmLn1mO86y4Tzg+5xMWNqHCw4xwvtpoR4F1Q7HZnHp6A97WGYC
 j/6zUmnGP86/eFYoVdjG7GQ0P2ZzoiVtkd5B6pgtjlmZAKj7tVly6qjkBqobHjoCSItcUO
 LdHBfz7/UY8vapygHRb0hdAMfceww6OdKmucGftp8EgdAdYLny0Vaf+AaTfKCezkcKYxlb
 lmI98elJaf54uZoF7EvZmfPh9aD4z2v7trZr3V2IDhMD5xlIX1Sovu78RRxokw==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] arm: renesas: configs: Drop deprecated comments
Date: Mon, 30 Jun 2025 20:51:17 +0200
Message-ID: <20250630185124.1099147-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 555420fb30e9c6a9cd8
X-MBO-RS-META: q9gwfuysurku381jacpzp63okwk9y1q4
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

Remove various deprecated code comments, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/configs/alt.h     | 2 --
 include/configs/blanche.h | 4 ----
 include/configs/condor.h  | 5 -----
 include/configs/ebisu.h   | 2 --
 include/configs/falcon.h  | 3 ---
 include/configs/gose.h    | 2 --
 include/configs/grpeach.h | 4 ----
 include/configs/koelsch.h | 4 ----
 include/configs/lager.h   | 4 ----
 include/configs/porter.h  | 4 ----
 include/configs/silk.h    | 4 ----
 include/configs/stout.h   | 4 ----
 include/configs/v3hsk.h   | 5 -----
 13 files changed, 47 deletions(-)

diff --git a/include/configs/alt.h b/include/configs/alt.h
index dfce0b3f4c8..4c5d2de2bdf 100644
--- a/include/configs/alt.h
+++ b/include/configs/alt.h
@@ -20,8 +20,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1024u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"	\
 	"usb_pgood_delay=2000\0"
diff --git a/include/configs/blanche.h b/include/configs/blanche.h
index d4e0f677e67..46521aa16bf 100644
--- a/include/configs/blanche.h
+++ b/include/configs/blanche.h
@@ -29,8 +29,4 @@
 #define CFG_SYS_FLASH_BANKS_SIZES	{ (CFG_SYS_FLASH_SIZE) }
 #endif
 
-/* Board Clock */
-
-/* ENV setting */
-
 #endif	/* __BLANCHE_H */
diff --git a/include/configs/condor.h b/include/configs/condor.h
index 0fb790f2413..b340800cc11 100644
--- a/include/configs/condor.h
+++ b/include/configs/condor.h
@@ -11,9 +11,4 @@
 
 #include "rcar-gen3-common.h"
 
-/* Environment compatibility */
-
-/* Board Clock */
-/* XTAL_CLK : 33.33MHz */
-
 #endif /* __CONDOR_H */
diff --git a/include/configs/ebisu.h b/include/configs/ebisu.h
index ad5944230a6..707e7c28d55 100644
--- a/include/configs/ebisu.h
+++ b/include/configs/ebisu.h
@@ -9,8 +9,6 @@
 #ifndef __EBISU_H
 #define __EBISU_H
 
-#undef DEBUG
-
 #include "rcar-gen3-common.h"
 
 /* Environment in eMMC, at the end of 2nd "boot sector" */
diff --git a/include/configs/falcon.h b/include/configs/falcon.h
index 0b62ff9fbe1..e1cace73550 100644
--- a/include/configs/falcon.h
+++ b/include/configs/falcon.h
@@ -11,7 +11,4 @@
 
 #include "rcar-gen4-common.h"
 
-/* Board Clock */
-/* XTAL_CLK : 16.66MHz */
-
 #endif /* __FALCON_H */
diff --git a/include/configs/gose.h b/include/configs/gose.h
index abd13df964d..4a5954af76f 100644
--- a/include/configs/gose.h
+++ b/include/configs/gose.h
@@ -19,8 +19,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512u * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
diff --git a/include/configs/grpeach.h b/include/configs/grpeach.h
index 1961b4416dd..e4564b67a79 100644
--- a/include/configs/grpeach.h
+++ b/include/configs/grpeach.h
@@ -8,10 +8,6 @@
 #ifndef __GRPEACH_H
 #define __GRPEACH_H
 
-/* Board Clock , P1 clock frequency (XTAL=13.33MHz) */
-
-/* Miscellaneous */
-
 /* Internal RAM Size (RZ/A1=3M, RZ/A1M=5M, RZ/A1H=10M) */
 #define CFG_SYS_SDRAM_BASE		0x20000000
 #define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
index 16c9e09a17f..c2713b77e0a 100644
--- a/include/configs/koelsch.h
+++ b/include/configs/koelsch.h
@@ -19,11 +19,7 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
-/* SPL support */
-
 #endif	/* __KOELSCH_H */
diff --git a/include/configs/lager.h b/include/configs/lager.h
index fbdc125d67b..13f327fabf2 100644
--- a/include/configs/lager.h
+++ b/include/configs/lager.h
@@ -20,11 +20,7 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
-/* SPL support */
-
 #endif	/* __LAGER_H */
diff --git a/include/configs/porter.h b/include/configs/porter.h
index c74ae3a42d9..4612845db19 100644
--- a/include/configs/porter.h
+++ b/include/configs/porter.h
@@ -21,11 +21,7 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(1024u * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
-/* SPL support */
-
 #endif /* __PORTER_H */
diff --git a/include/configs/silk.h b/include/configs/silk.h
index bb59e94dc47..09ef2a848bd 100644
--- a/include/configs/silk.h
+++ b/include/configs/silk.h
@@ -21,11 +21,7 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1024u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
-/* SPL support */
-
 #endif /* __SILK_H */
diff --git a/include/configs/stout.h b/include/configs/stout.h
index dbb5c63172d..f98ebb324f3 100644
--- a/include/configs/stout.h
+++ b/include/configs/stout.h
@@ -25,11 +25,7 @@
 /* SCIF */
 #define CFG_SCIF_A
 
-/* Board Clock */
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"bootm_size=0x10000000\0"
 
-/* SPL support */
-
 #endif	/* __STOUT_H */
diff --git a/include/configs/v3hsk.h b/include/configs/v3hsk.h
index 83e5998e7ae..3298e627e53 100644
--- a/include/configs/v3hsk.h
+++ b/include/configs/v3hsk.h
@@ -12,9 +12,4 @@
 
 #include "rcar-gen3-common.h"
 
-/* Environment compatibility */
-
-/* Board Clock */
-/* XTAL_CLK : 33.33MHz */
-
 #endif /* __V3HSK_H */
-- 
2.47.2

