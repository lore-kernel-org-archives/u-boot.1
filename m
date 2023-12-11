Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB7C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 11:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F358774D;
	Mon, 11 Dec 2023 12:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jc7fnTYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07AE38773E; Mon, 11 Dec 2023 12:46:17 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067258773D
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8EBD1B80CB1;
 Mon, 11 Dec 2023 11:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496A7C433C7;
 Mon, 11 Dec 2023 11:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702295172;
 bh=GkTxo208qY+Gb/+sRcR+oe/CWtFv7pJuVpfn/zsMOAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jc7fnTYOEIikLpogd3C9eXZn2puk5uhyEd3HVDO/au8FE+DO4j1vffyqkep02lo/B
 upwbncIZ6Pe7aXDa+qj3hQ/0Yphkyx2omaFeqtGRtIOFEKv0BMA+XABg2XrMy3L6ZB
 7zY6BwmNJKoJ9g8PG6m1ts7pZZgCL/TDORVCPlVAQSU4YXYKYvUjSXsvykA2Igb6J5
 ivnCH9YwPADoLzyUuLo5RffznBKTPb5/e7ZOnXsR4oZfbou2JRlrvBJ/1GwmEc+4EJ
 9/sd1Bzlo4ZJBmXwERw0xEYAVJw/y535fTKkw0VJokXd5cfSeuqws72+f2QmruzDAD
 nt8u7ngoFWfSw==
From: Roger Quadros <rogerq@kernel.org>
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com
Cc: trini@konsulko.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>,
 Hong Guan <hguan@ti.com>
Subject: [PATCH v2 2/2] mtd: rawnand: omap_elm: Fix elm_init definition
Date: Mon, 11 Dec 2023 13:46:00 +0200
Message-Id: <20231211114600.4414-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211114600.4414-1-rogerq@kernel.org>
References: <20231211114600.4414-1-rogerq@kernel.org>
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
-- 
2.34.1

