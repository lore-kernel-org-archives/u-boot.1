Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19BCC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2E87A7A;
	Mon,  8 Jan 2024 13:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="fJu4Q9xZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E7187A21; Mon,  8 Jan 2024 10:24:33 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53AA87A23
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 10:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rMlrv-0006t8-A1; Mon, 08 Jan 2024 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=c3Oq8Zg4J2S/B/FKBZSkaFnif1+YGUN98p5NqnYJkdE=; b=fJu4Q9xZ2sGF3Q6vxsQe
 1kRDA5S1S7BwH4JHjh8vcaxmLE7tLIC+9lkicw7PNjDS14wlPkWmhk43F0akNgIj4ohCNIKLrqu+D
 2S/XAnC4m4Un04trNCw4dLltApPBu/pwuMG8b2j3mpXgzNMrGCb9/pxRbC5hz8JiKxVE/6Z08n9ll
 G3HS3PPm6MUO+ypJvihetI1HztphGul5cqBTr8mfwU8ekWwLo+esnWq4qrTU/PztpPbYa8mRpFT2K
 ejMkPCu+2ZH3VE8IjNEK+JGMd5YCMLubIGEGMVPrBMeNUMJe+DJoVbcv4wH+nxZsRDj14/g5/+mFc
 iHsFpk/CZYzpFw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 1/4] spl: binman: Disable u_boot_any symbols for i.MX93
 boards
Date: Mon,  8 Jan 2024 10:24:13 +0100
Message-ID: <20240108092416.23591-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108092416.23591-1-othacehe@gnu.org>
References: <20240108092416.23591-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jan 2024 13:10:24 +0100
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
index c521b02f4a3..c4a04fd9ffd 100644
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
2.41.0

