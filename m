Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB24CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E3886E06;
	Wed, 11 Oct 2023 15:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1809986D28; Wed, 11 Oct 2023 15:06:27 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D48831BE
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp78t1697029540tg9ecea5
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:05:39 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: znfcQSa1hKb1RbYdDlYF9/LvJIC+2Q8ZmRJbi6TGIQt4g8X01HTeTu115jfO+
 SN4u4sVQYKSON4xJlJLLQ16AZqJucc9kX//VabDWBOpdiXqhm367fcwwaZLQlGI9yt9xHjc
 pT8qvvk4TrbNm166HTdnL8qP/XhkxgOpKXFqlEBOaB4HwYh9CmYIt0maFiUybnVaGzkm0VO
 Us4Pw8Xdj7eUeed6kn+IlpeQK7yyP2UhJWCX4AoErZFAnVa7ZxEdF3e1oygiYMVyMMGu+Ed
 tilEws9E6jWhIWV0dYgsbpmawVai+kq/egyQuBXQ0EGMHZxkkobithfeKg3J3DJTfyY6+wK
 ST+KPPNxIqnHahvmzCBwpRBl9jhPv5x/mw8B0zw
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7696133082460464981
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH 1/9] ufs: Correct the UFS terminlogy
Date: Wed, 11 Oct 2023 21:05:27 +0800
Message-Id: <20231011130535.3964-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011130535.3964-1-bmeng@tinylab.org>
References: <20231011130535.3964-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

UFS stands for Universal Flash Storage, not Subsytem.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/Kconfig              | 2 +-
 drivers/ufs/ufs-uclass.c | 2 +-
 drivers/ufs/ufs.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6470b138d2..a59c67e333 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1536,7 +1536,7 @@ config CMD_TSI148
 	  Turndra tsi148 device. See the command help for full details.
 
 config CMD_UFS
-	bool "Enable UFS - Universal Flash Subsystem commands"
+	bool "Enable UFS - Universal Flash Storage commands"
 	depends on UFS
 	help
 	  "This provides commands to initialise and configure universal flash
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index ceea30c4a9..ffae811d46 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /**
- * ufs-uclass.c - Universal Flash Subsystem (UFS) Uclass driver
+ * ufs-uclass.c - Universal Flash Storage (UFS) Uclass driver
  *
  * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  */
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 7c48d57f99..f534d6e29f 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /**
- * ufs.c - Universal Flash Subsystem (UFS) driver
+ * ufs.c - Universal Flash Storage (UFS) driver
  *
  * Taken from Linux Kernel v5.2 (drivers/scsi/ufs/ufshcd.c) and ported
  * to u-boot.
-- 
2.34.1

