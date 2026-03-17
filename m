Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71458FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B5D84253;
	Tue, 17 Mar 2026 02:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DZZImwSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FDD841F2; Tue, 17 Mar 2026 02:24:37 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8184684214
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4487805a34.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710673; x=1774315473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L4RyV1V6f5RQCoR7NOu9CTqsT0bc7zD6f9M5Q2hcris=;
 b=DZZImwSOHhaSHcp72O6gIjPtU+38vQzvCrrqQm12TGMAf847BcvHqWaMtLnmsOSsMi
 zt4012JXQeZXk0tUiFLB7THNreThjFdqlHd08L6HbvCY12wwMLeR+7sOVw9NEP6cyFpZ
 0883tNZ8m5/xRG6xm/gDO6ekczzILzoposflQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710673; x=1774315473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4RyV1V6f5RQCoR7NOu9CTqsT0bc7zD6f9M5Q2hcris=;
 b=oMK3R/9TjPAAdD5gdTGOp1H7DN1mPosv9Sgtr2nFyYTdYXbE2cIEcIPCe9qku08xwZ
 wt5yy9qaBFOAo18SWywpqOIk59xlg1Yv/oamDRtKksAkpG9SBRdhiCENNCWTxuMZx9hg
 lrYxVc2FGnJcB8RXnqwOYVSXp1FF+dSXx3HiATC1xzOpXFsX0sCMnzAnvGMir7WgtJ34
 5L8RRQJowJniZMV/Qt2Gm4xdhUhn2K6a/wTdSFkjsbYUB9NQf1EhsL3TWsNzomDj814g
 XOfRkKXuAlr7qqXBv++c7pk6xMpUJMCpLhzZKh2IS+2GpGLWGy7khqRu0Kyhog4ykaQj
 xStg==
X-Gm-Message-State: AOJu0Yxvhk0KbeJycOHx/rB1ACxPaRp33XKLGYLHkcbQgzYwXmc9Y9aI
 aoVxel0zCiBgf7Asf3jBjHN7sKI8tZssF0HHvwpU7v/B6NwTkIpQt9y2MrefglX2jqUrMsOPG1F
 TgAec71M=
X-Gm-Gg: ATEYQzysbBZA0tDNgXNVQzdcX7uNMHzhv52nGRbEjF64pcn8zm/EveaCuJ/mQ+zWWiy
 hq8SFnwCanzM+/nu+HKT7BBuonaPDZbOeXMRtDymP0Zj4xMwibclDpconP4QdDauVmJs5w5NvRr
 EJ3HUX8G3KsQgNj2IqDHkNtXnJsayUWuFI/KA+hiVu0Q6pmUY9SICgMUcZgBu6IOzAOT0Ga3Y+o
 MebwjB5qOofyWFcC759tHK8cKvBhoDuK4FPT14rcb7nVs6LfYTLm+7oUzJzKbO5exSjx/Tyc7TM
 OoJ+p7WCYw4KOGt4C1hXQCMd8VoXZpvTU4pFIlAPJHIWI3wkDosNvtTJz/pDMaimaMDdxQaO57U
 DwHV/3zvqDUZm4CQwVOlWe3yI4Ll6Q/0lcopCTIHddccEgPgJA3UWUJD2so8gp6wdKmEl1oi6Bp
 8hpTiPuhclehE49wDL5o1HoPZzIbECEglZPgYYVJHRwPkUAx9vn+1XT0D90byl0YrAtov7Z9PBj
 IGT20Hg4T6o/eoppAGmRfBFOfZ9je7oXFyof9Q3/m43/M1BzBR9om57hZ68KQ==
X-Received: by 2002:a05:6830:3111:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7d78251e66cmr10285264a34.23.1773710673214; 
 Mon, 16 Mar 2026 18:24:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae398fcsm12888928a34.16.2026.03.16.18.24.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] SPL: Rework logic around SPL_BLK_FS (and SPL_NVME)
Date: Mon, 16 Mar 2026 19:24:31 -0600
Message-ID: <20260317012431.4162508-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue around SPL_BLK_FS.
This is functionally a library type symbol that should be selected when
required and select what it needs. Have SPL_BLK_FS select SPL_FS_LOADER
and then SPL_NVME will now correctly select SPL_FS_LOADER via
SPL_BLK_FS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig    | 1 -
 drivers/block/Kconfig | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 69b6ad773462..d1a85f50209e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1497,7 +1497,6 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
 config SPL_NVME
 	bool "NVM Express device support"
 	depends on SPL_BLK
-	select FS_LOADER
 	select SPL_BLK_FS
 	help
 	  This option enables support for NVM Express devices.
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 461b5a9fc838..adf338ab00c3 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -106,8 +106,9 @@ config EFI_MEDIA
 	  For sandbox there is a test driver.
 
 config SPL_BLK_FS
-	bool "Load images from filesystems on block devices"
-	depends on SPL_BLK && SPL_FS_LOADER
+	bool
+	depends on SPL_BLK
+	select SPL_FS_LOADER
 	help
 	  Use generic support to load images from fat/ext filesystems on
 	  different types of block devices such as NVMe.
-- 
2.43.0

