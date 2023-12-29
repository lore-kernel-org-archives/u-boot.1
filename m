Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6A9C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 12:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA7787B49;
	Fri, 29 Dec 2023 13:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="InnRN77i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E27087AFE; Fri, 29 Dec 2023 12:17:19 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8193987B26
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 12:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rJArb-0007h8-I6; Fri, 29 Dec 2023 06:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=7wu+RM97qxDtokFHGxolptcWpipnTGB0/8EczKtPgS0=; b=InnRN77iXijcesI+1x4C
 xrEb30CWt3gdTC0s/elPLnHHTgObfqmJdEugtXMiI630gmVNVjU22W9DHzJS3uTjLDM8ZF2+n6JJ3
 BIGFuDtfIxqO+UGxHNjRJ5yVHqGN4+vAbUEG/V/cWVYQv55HkG7Ay/tOc+oIyYi52FCLmpgMyQtjq
 abGa63z/7O8yAZTwOMYd81AiVJoRNqe3h2AQZrxO9K+Q5HhYNAXEJvC93eTfUdsjgyaT8SLIboUDn
 70QqYdSwFM+CkPV/wKB+8Vb4iP9FCcthQOfndaQM86/JbagMQ3ITLudmwmcpYX6KpV6UnNzmyTHT7
 n0sXYGYDV/8d+w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/3] spl: binman: Disable u_boot_any symbols for i.MX93
 boards
Date: Fri, 29 Dec 2023 12:16:59 +0100
Message-ID: <20231229111701.10696-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229111701.10696-1-othacehe@gnu.org>
References: <20231229111701.10696-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Dec 2023 13:16:20 +0100
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
index c5dd476db58..322e6fe882f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -206,7 +206,7 @@ config SPL_BINMAN_SYMBOLS
 config SPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in SPL"
 	depends on SPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M
+	default n if ARCH_IMX8M || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in SPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 3d6cf1e59f3..9bb57e6fbff 100644
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

