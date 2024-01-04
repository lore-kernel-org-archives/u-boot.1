Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C28C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271FD879E7;
	Thu,  4 Jan 2024 17:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="MeCfmp1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B5A879D2; Thu,  4 Jan 2024 16:54:14 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED41987949
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rLQ2q-0002zf-UH; Thu, 04 Jan 2024 10:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=z5+CANPZaj6ZU7PhxqH291ffz4j2e7HG0yWHi2EhP4s=; b=MeCfmp1XsS+tCP/Y0X9l
 EJTkI9kLfyk6VRc7Gveag0lQvciOx1ZbJ+XDx65e1257d/OjA0+fZdyuREE+LYI1bKvLbMuuzZVvG
 LiNxQjjs0jWTHNXUII1/Ma+UjZhCvFTDeHkK6vl1QpSBwzMdZzGZs63YaHXS2+qv3JorBOTaXcFOy
 LaEuu23Pl8+XlrSyYdLvVjqW24+zVBJc1JerM3uFyd0z3AE4EQ3RzoB5Z4I20WURfEngfb7ZnVjZn
 k495QcUTfd1G20zf43xSH4r0f/JPd5GWNnklGxjWC0LCNlp+cOUZnQOYp4zu+NUEMc23kpJc9n2yi
 V0Kci78CN6Q82g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 1/4] spl: binman: Disable u_boot_any symbols for i.MX93
 boards
Date: Thu,  4 Jan 2024 16:53:54 +0100
Message-ID: <20240104155357.21865-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104155357.21865-1-othacehe@gnu.org>
References: <20240104155357.21865-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 17:10:51 +0100
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

From: Mathieu Othacehe <m.othacehe@gmail.com>

This is extending commit 6516c9b349b3 ("spl: binman: Disable u_boot_any
symbols for i.MX8M boards") to i.MX93 boards.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 common/spl/Kconfig     | 2 +-
 common/spl/Kconfig.tpl | 2 +-
 common/spl/Kconfig.vpl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index cf7ffc9b112..e7b84fc1fa6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -207,7 +207,7 @@ config SPL_BINMAN_SYMBOLS
 config SPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in SPL"
 	depends on SPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M
+	default n if ARCH_IMX8M || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in SPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index cc71578f646..4ee3b9b826d 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -23,7 +23,7 @@ config TPL_BINMAN_SYMBOLS
 config TPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in TPL"
 	depends on TPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M
+	default n if ARCH_IMX8M || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in TPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index ae1a3c724f3..f1993026bba 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -243,7 +243,7 @@ config VPL_BINMAN_SYMBOLS
 config VPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in VPL"
 	depends on VPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M
+	default n if ARCH_IMX8M || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in VPL which refer to U-Boot phases,
-- 
2.25.1

