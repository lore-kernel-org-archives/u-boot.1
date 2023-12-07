Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE3C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 16:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E017286F95;
	Thu,  7 Dec 2023 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pawt62xW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E0086F95; Thu,  7 Dec 2023 17:26:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B60A386EEC
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 17:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 48AB162094;
 Thu,  7 Dec 2023 16:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425EBC433C7;
 Thu,  7 Dec 2023 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701966378;
 bh=xkM57RmQLgHLRbhS7ND9X1xVD4L59m2EMnxV2ZDcKT4=;
 h=From:To:Cc:Subject:Date:From;
 b=Pawt62xWIo0LsNhD8TwjLn/XQwkluSCFPYqSkA8fTZD8GVPbUg9A24DiwYxfUya8N
 yfTJsijaR5AaasWUUjOKFaUkGnVbhR5C0mW229lj7JtomARUgWNBOydnpBDXzOFotz
 SyZXYLBGxl8e+utU3rQb8Gx3hMcedkUwbMd+96MbNW7mjj1FePRZGom91vMSVVX8Tb
 qOL/Cie6gnggYyC6MMOwPdmHzK3WruZAPOUx2NGDzrbombSmSXODQg/lf5WFmoJYG9
 30402mpFeTtxmvE69OsfjcqpdkC8VZb+aiUAxta14S9ZSmCg4rJZOExa5oryNtNpXM
 2HmOvYsBAnK5g==
From: Roger Quadros <rogerq@kernel.org>
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de
Cc: enrico.leto@siemens.com, trini@konsulko.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>,
 Hong Guan <hguan@ti.com>
Subject: [PATCH] mtd: rawnand: omap_elm: Fix elm_init definition
Date: Thu,  7 Dec 2023 18:26:09 +0200
Message-Id: <20231207162609.155555-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The macro ELM_BASE is defined in mach/hardware.h and is
not visible at the omap_elm.h header file. Avoid using it
in omap_elm.h.

Reported-by: Hong Guan <hguan@ti.com>
Fixes: 7363cf0581a3 ("mtd: rawnand: omap_elm: u-boot driver model support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap_elm.c | 4 ++--
 drivers/mtd/nand/raw/omap_elm.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 56a2c39e4f..015ec9bc2d 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -185,7 +185,6 @@ void elm_reset(void)
 		;
 }
 
-#ifdef ELM_BASE
 /**
  * elm_init - Initialize ELM module
  *
@@ -194,10 +193,11 @@ void elm_reset(void)
  */
 void elm_init(void)
 {
+#ifdef ELM_BASE
 	elm_cfg = (struct elm *)ELM_BASE;
 	elm_reset();
-}
 #endif
+}
 
 #if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 
diff --git a/drivers/mtd/nand/raw/omap_elm.h b/drivers/mtd/nand/raw/omap_elm.h
index a7f7bacb15..f3db00d55d 100644
--- a/drivers/mtd/nand/raw/omap_elm.h
+++ b/drivers/mtd/nand/raw/omap_elm.h
@@ -74,12 +74,6 @@ int elm_check_error(u8 *syndrome, enum bch_level bch_type, u32 *error_count,
 		u32 *error_locations);
 int elm_config(enum bch_level level);
 void elm_reset(void);
-#ifdef ELM_BASE
 void elm_init(void);
-#else
-static inline void elm_init(void)
-{
-}
-#endif
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_ELM_H */

base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
-- 
2.34.1

