Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85196C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A7282E5A;
	Mon, 30 Jun 2025 20:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UJK/nbNo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TUVCKe07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F9482E27; Mon, 30 Jun 2025 20:52:02 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4E581D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bWFd45XZjz9tWl;
 Mon, 30 Jun 2025 20:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1ertLg5PUeXBndO9+7O3inf+1tpkaMHX4VabrJHiRc=;
 b=UJK/nbNo2ZXEx06+/9/UP/zreBM6KYFtxm6LudFY0ZD2rzRmh1KZai/nuzMd1F3SL3dkm3
 jrt/C6awkkmtiFVzijvSNGr056efv8l7U9l1odq/7XGrdfDrz4PfWfnB9uPx9Wi0b9zhMA
 hHHeFw3vHPNLVr+rKU9ya4d3xI1fegysMxuiFVAc67Wnb9m4yUqb3Z5WlY+e6TzogrAYfW
 5gPgmPWk6KJY4XSaIbC0WA15PK3tlsZCvD4GFxsusmwpcFG73nP0KIo5/JWrsd6wqw5ftG
 JwN24vTcvj9M/9lw1wsnOO35fvW0SV7aKt32psoc3kdzOnmq/TCjhsCLO+zkiw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1ertLg5PUeXBndO9+7O3inf+1tpkaMHX4VabrJHiRc=;
 b=TUVCKe07UK1W1xe+EMVxhqcBmHlryjR45yj8hscxzub40OBRpdJgrqO6DmpOYZB1ylpxTX
 PjdL0pgaNgA5au35KYyCRHiEK8hBw58IjoeOxHarFfRnm8E2hSv+bjI6L4KpzEOVaPu4cA
 uPF+8u430ZcRUN/iZp+RfJoNdzIGHp3mIeNAo6wwdovKssiQN1SieS/Uk9mh7K3cCCBf4B
 ugVbgxEKbDY9sje7BQYp5JMtErFpRVUxx7It9rUmYZs5BMNhvebxLXxZ/l3MFbtUtTm88O
 aGL5NPkuvzLwWm8FuFcBkqF3W3csyt79K5WQZsTMe+5k3GpX6eERgp1ghBKoBg==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] net: sh_eth: arm: renesas: README: Drop
 CFG_SH_ETHER_PHY_MODE
Date: Mon, 30 Jun 2025 20:51:16 +0200
Message-ID: <20250630185124.1099147-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 227321b88369a47b771
X-MBO-RS-META: jhpnsd73wgj7qht9og8qrmizujaqsfus
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

Drop CFG_SH_ETHER_PHY_MODE from configuration files, this value
is never used. No functional change intended.

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
 include/configs/alt.h     | 3 ---
 include/configs/condor.h  | 3 ---
 include/configs/gose.h    | 3 ---
 include/configs/grpeach.h | 3 ---
 include/configs/koelsch.h | 3 ---
 include/configs/lager.h   | 3 ---
 include/configs/porter.h  | 3 ---
 include/configs/silk.h    | 3 ---
 include/configs/stout.h   | 3 ---
 include/configs/v3hsk.h   | 3 ---
 10 files changed, 30 deletions(-)

diff --git a/include/configs/alt.h b/include/configs/alt.h
index 7db01cedb8b..dfce0b3f4c8 100644
--- a/include/configs/alt.h
+++ b/include/configs/alt.h
@@ -20,9 +20,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1024u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/condor.h b/include/configs/condor.h
index 3be0f99ec4b..0fb790f2413 100644
--- a/include/configs/condor.h
+++ b/include/configs/condor.h
@@ -13,9 +13,6 @@
 
 /* Environment compatibility */
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 /* XTAL_CLK : 33.33MHz */
 
diff --git a/include/configs/gose.h b/include/configs/gose.h
index a5537ee30b2..abd13df964d 100644
--- a/include/configs/gose.h
+++ b/include/configs/gose.h
@@ -19,9 +19,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512u * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/grpeach.h b/include/configs/grpeach.h
index 9c47fbf1c90..1961b4416dd 100644
--- a/include/configs/grpeach.h
+++ b/include/configs/grpeach.h
@@ -16,7 +16,4 @@
 #define CFG_SYS_SDRAM_BASE		0x20000000
 #define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
 
-/* Network interface */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_MII
-
 #endif	/* __GRPEACH_H */
diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
index cc6266d4d6c..16c9e09a17f 100644
--- a/include/configs/koelsch.h
+++ b/include/configs/koelsch.h
@@ -19,9 +19,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/lager.h b/include/configs/lager.h
index f59f44f1862..fbdc125d67b 100644
--- a/include/configs/lager.h
+++ b/include/configs/lager.h
@@ -20,9 +20,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/porter.h b/include/configs/porter.h
index 265a0d775a3..c74ae3a42d9 100644
--- a/include/configs/porter.h
+++ b/include/configs/porter.h
@@ -21,9 +21,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(2048u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(1024u * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/silk.h b/include/configs/silk.h
index 459b9b86797..bb59e94dc47 100644
--- a/include/configs/silk.h
+++ b/include/configs/silk.h
@@ -21,9 +21,6 @@
 #define RCAR_GEN2_SDRAM_SIZE		(1024u * 1024 * 1024)
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/stout.h b/include/configs/stout.h
index d1accb90d9f..dbb5c63172d 100644
--- a/include/configs/stout.h
+++ b/include/configs/stout.h
@@ -25,9 +25,6 @@
 /* SCIF */
 #define CFG_SCIF_A
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-
 /* Board Clock */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
diff --git a/include/configs/v3hsk.h b/include/configs/v3hsk.h
index c5685b4c6c1..83e5998e7ae 100644
--- a/include/configs/v3hsk.h
+++ b/include/configs/v3hsk.h
@@ -14,9 +14,6 @@
 
 /* Environment compatibility */
 
-/* SH Ether */
-#define CFG_SH_ETHER_PHY_MODE	PHY_INTERFACE_MODE_RGMII_ID
-
 /* Board Clock */
 /* XTAL_CLK : 33.33MHz */
 
-- 
2.47.2

