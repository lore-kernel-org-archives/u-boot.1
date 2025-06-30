Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC486C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190AA81FEE;
	Mon, 30 Jun 2025 20:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p8F6AX9A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qkaiXKo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFA482E5A; Mon, 30 Jun 2025 20:51:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9C281D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bWFcv2TDvz9t02;
 Mon, 30 Jun 2025 20:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHbOm0nFsxuSttJnCG+PaakWQTqB1LPUAO6fZg5Bnm4=;
 b=p8F6AX9ADeLIj5p//egAnZsbIvJ0/tSa4wzFhA9YrCVhXoH9iwdGT3QbM+RamjF+QVFhUz
 u7tA0bmy2ObAfOPNVAorIcHXASbcIRBjy4C207q0gJH7xpRWCyU7SW3kH9pkr7v/Lv0Xpv
 UDBljO9ONxHzHTm6OMprCu5BrkOLxwGbMp6HzFS/zznMkfNFghBH75+LuXAlkagLjjyqTP
 fT8T4ZyIHfowm0zqqXST35vwlzh8F7abLl318MAhOU4O9s82twZAnPpk6cruTA7Hq1o4g2
 fUtfjmXWJecR/nJTN7rtyjRI9SN5W4/TOaiJf+5QYKOs+3MUVQW5b7RLG5bnTA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHbOm0nFsxuSttJnCG+PaakWQTqB1LPUAO6fZg5Bnm4=;
 b=qkaiXKo9ms9Ox2k3Xz029oczBrTkQOsvRpHgnMwWBpwVmoSDuULiihsnAMh+mo4jOnqvUh
 RiuyMwaCuVeXlnOhrwOoGGlyrh08AWsA9PxCea/8qNCTPzpOLJSBubaDHSNdEo8K3D1WX0
 WbJ2cXzAFO+QonDNu9bL/2LyLF1EHxkUndB0pYAaL6qGVz/PRLEtdTKroD5XDDguD7NWdY
 aW1+RhU8nuEI6TbvhuJsbNK3uy9jKi/d5pVvJhTvfkKr9d5aMp+8YYRlaQKy6vmqhx3jNH
 EQlG51QbNzhgqZbymsFFuyw12OoYtrBDMpuZozZgE5tZJuSTubcVLuHQ0SW/5Q==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] net: sh_eth: arm: renesas: README: Drop
 CFG_SH_ETHER_USE_PORT
Date: Mon, 30 Jun 2025 20:51:11 +0200
Message-ID: <20250630185124.1099147-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 95b9ht741kagwaso6q3frym9sns71mn9
X-MBO-RS-ID: e11d199da3e35167a12
X-Rspamd-Queue-Id: 4bWFcv2TDvz9t02
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

The CFG_SH_ETHER_USE_PORT configuration option is a remnant from
before U-Boot DM existed and SH Ethernet made full use of it, and
is no longer used, remove it.

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
 README                    | 3 ---
 drivers/net/sh_eth.c      | 3 ---
 include/configs/alt.h     | 1 -
 include/configs/condor.h  | 1 -
 include/configs/gose.h    | 1 -
 include/configs/grpeach.h | 1 -
 include/configs/koelsch.h | 1 -
 include/configs/lager.h   | 1 -
 include/configs/porter.h  | 1 -
 include/configs/silk.h    | 1 -
 include/configs/stout.h   | 1 -
 include/configs/v3hsk.h   | 1 -
 12 files changed, 16 deletions(-)

diff --git a/README b/README
index 40326ef3547..8f8f4b85ef8 100644
--- a/README
+++ b/README
@@ -379,9 +379,6 @@ The following options need to be configured:
 		CONFIG_SH_ETHER
 		Support for Renesas on-chip Ethernet controller
 
-			CFG_SH_ETHER_USE_PORT
-			Define the number of ports to be used
-
 			CFG_SH_ETHER_PHY_ADDR
 			Define the ETH PHY's address
 
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 339a4771586..9ccba153f36 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -29,9 +29,6 @@
 
 #include "sh_eth.h"
 
-#ifndef CFG_SH_ETHER_USE_PORT
-# error "Please define CFG_SH_ETHER_USE_PORT"
-#endif
 #ifndef CFG_SH_ETHER_PHY_ADDR
 # error "Please define CFG_SH_ETHER_PHY_ADDR"
 #endif
diff --git a/include/configs/alt.h b/include/configs/alt.h
index 8f03762583e..52b8c95cd7b 100644
--- a/include/configs/alt.h
+++ b/include/configs/alt.h
@@ -21,7 +21,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/condor.h b/include/configs/condor.h
index 50c8d173383..ecaf58e4c0f 100644
--- a/include/configs/condor.h
+++ b/include/configs/condor.h
@@ -14,7 +14,6 @@
 /* Environment compatibility */
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/gose.h b/include/configs/gose.h
index 7ae0726518d..323977e9b8a 100644
--- a/include/configs/gose.h
+++ b/include/configs/gose.h
@@ -20,7 +20,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512u * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/grpeach.h b/include/configs/grpeach.h
index 8de4a36e931..67ad8339816 100644
--- a/include/configs/grpeach.h
+++ b/include/configs/grpeach.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
 
 /* Network interface */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_MII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
index d47d70178cc..11f637d3f33 100644
--- a/include/configs/koelsch.h
+++ b/include/configs/koelsch.h
@@ -20,7 +20,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/lager.h b/include/configs/lager.h
index 2577c7a7da6..aaf4a4a6931 100644
--- a/include/configs/lager.h
+++ b/include/configs/lager.h
@@ -21,7 +21,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/porter.h b/include/configs/porter.h
index 2cb430be8b0..ff99c3fb817 100644
--- a/include/configs/porter.h
+++ b/include/configs/porter.h
@@ -22,7 +22,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(1024u * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/silk.h b/include/configs/silk.h
index 7bed32d8553..20d18aa5aa7 100644
--- a/include/configs/silk.h
+++ b/include/configs/silk.h
@@ -22,7 +22,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/stout.h b/include/configs/stout.h
index 1278ba63f4f..454d8ca5716 100644
--- a/include/configs/stout.h
+++ b/include/configs/stout.h
@@ -26,7 +26,6 @@
 #define CFG_SCIF_A
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 #define CFG_SH_ETHER_CACHE_WRITEBACK
diff --git a/include/configs/v3hsk.h b/include/configs/v3hsk.h
index 58c2e88c0b7..e16a289ac1a 100644
--- a/include/configs/v3hsk.h
+++ b/include/configs/v3hsk.h
@@ -15,7 +15,6 @@
 /* Environment compatibility */
 
 /* SH Ether */
-#define CFG_SH_ETHER_USE_PORT	0
 #define CFG_SH_ETHER_PHY_ADDR	0x0
 #define CFG_SH_ETHER_PHY_MODE	PHY_INTERFACE_MODE_RGMII_ID
 #define CFG_SH_ETHER_CACHE_WRITEBACK
-- 
2.47.2

