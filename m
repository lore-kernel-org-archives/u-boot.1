Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB56C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9D680F32;
	Sun, 16 Feb 2025 12:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HVJfi587";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BDC8056A; Sun, 16 Feb 2025 12:12:58 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0EB80C7E
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 544893FF73; 
 Sun, 16 Feb 2025 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739704375;
 bh=YOwtxfC50fmGVQNi+4+9T7/L44C3W4uOaVGvPn6hujM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HVJfi587n736v3vgwIfFXEgDfT/E8jwtR/UMcZKiJq9MRrUMltndySgHNcDoJpVMo
 prq0b7b3jjLUgZbnrzW56SVBFq8mx/eeOkZeXuZ/Ku2ZM0rYACbQlelyLdSEwErsMy
 7EYrpvLV6pbneHOeWBSn6Ex3XrjP5QQXBECPCRPaC85I4ziPGYweEZfSDmNmnDvlK7
 nerCKiaEjujCEw98RLk7/JB1v6MosfrGMtF4Sq53icZ+lCe3Js4UiJaErt2/qhU2qv
 +PLEhE8eVp9LNddW8JMYmExEbLSVLZl6+xy1/7M5OfDAmhTdGa+aCUXVXYesrJW3qT
 4XOnbBLLwTyWg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] lmb: avoid superfluous value check in
 lmb_map_update_notify()
Date: Sun, 16 Feb 2025 12:12:39 +0100
Message-ID: <20250216111241.6846-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
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

Instead of testing the value of parameter op at runtime use an enum to
ensure that only valid values are used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/lmb.h | 12 ++++++++++++
 lib/lmb.c     | 23 +++++++----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index d9d7435a431..09297a4f530 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -31,6 +31,18 @@
 #define LMB_NOOVERWRITE BIT(1)
 #define LMB_NONOTIFY BIT(2)
 
+/**
+ * enum lmb_map_op - memory map operation
+ */
+enum lmb_map_op {
+	/** @LMB_MAP_OP_RESERVE:	reserve memory */
+	LMB_MAP_OP_RESERVE = 1,
+	/** @LMB_MAP_OP_FREE:		free memory */
+	LMB_MAP_OP_FREE,
+	/** @LMB_MAP_OP_ADD:		add memory */
+	LMB_MAP_OP_ADD,
+};
+
 /**
  * struct lmb_region - Description of one region
  * @base: Base address of the region
diff --git a/lib/lmb.c b/lib/lmb.c
index 7ca44591e1d..7534a231c99 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -23,10 +23,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define MAP_OP_RESERVE		(u8)0x1
-#define MAP_OP_FREE		(u8)0x2
-#define MAP_OP_ADD		(u8)0x3
-
 /*
  * The following low level LMB functions must not access the global LMB memory
  * map since they are also used to manage IOVA memory maps in iommu drivers like
@@ -436,18 +432,13 @@ static bool lmb_should_notify(u32 flags)
 		CONFIG_IS_ENABLED(EFI_LOADER);
 }
 
-static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
-				 u32 flags)
+static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
+				 enum lmb_map_op op, u32 flags)
 {
 	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
 
-	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
-		log_err("Invalid map update op received (%d)\n", op);
-		return -1;
-	}
-
 	if (!lmb_should_notify(flags))
 		return 0;
 
@@ -456,7 +447,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	efi_addr &= ~EFI_PAGE_MASK;
 
 	status = efi_add_memory_map_pg(efi_addr, pages,
-				       op == MAP_OP_RESERVE ?
+				       op == LMB_MAP_OP_RESERVE ?
 				       EFI_BOOT_SERVICES_DATA :
 				       EFI_CONVENTIONAL_MEMORY,
 				       false);
@@ -642,7 +633,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	if (ret)
 		return ret;
 
-	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
+	return lmb_map_update_notify(base, size, LMB_MAP_OP_ADD, LMB_NONE);
 }
 
 long lmb_free_flags(phys_addr_t base, phys_size_t size,
@@ -654,7 +645,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 	if (ret < 0)
 		return ret;
 
-	return lmb_map_update_notify(base, size, MAP_OP_FREE, flags);
+	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
 }
 
 long lmb_free(phys_addr_t base, phys_size_t size)
@@ -671,7 +662,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 	if (ret)
 		return ret;
 
-	return lmb_map_update_notify(base, size, MAP_OP_RESERVE, flags);
+	return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
 }
 
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
@@ -712,7 +703,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 					return 0;
 
 				ret = lmb_map_update_notify(base, size,
-							    MAP_OP_RESERVE,
+							    LMB_MAP_OP_RESERVE,
 							    flags);
 				if (ret)
 					return ret;
-- 
2.47.1

