Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFA1C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CCB84ACF;
	Thu,  9 Jul 2026 00:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cTzNmjNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC60E84AC8; Thu,  9 Jul 2026 00:06:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F97F84AC0
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548361; bh=zwhCif8zYJ8MzbQucZRSXD+MMw4UGGZrd6pFMw7Y/go=;
 b=cTzNmjNettNiJZpKylwx91Kk5yrZVgPj1OwJZdvpW90dMmsYabFRDICHIsBVaRGXbuyxhWyAs
 CGtMQd2c+tO5chWCRbHVdonyOhNYL5IsnswPBGq0gs0+48sbOkRCgT/rVmILxK6oTYioXmT7Zs1
 ArYxlKvsOzLWN7JVvKyX5mIG5eLa4uRw6mOnH2XODQEoJrFWMVWM2WPSr3mc2QkrE6JjACwsQhU
 OA1YL8TuD2kcJ+7CkFy1tXqnii2Cvd39pfMz/O2UmAZt8u+CL49pAr8BMd9eQZ51vgn+PcDDEPb
 vUz7/89WpK5/sODpsIUOmeLFAi4uCAZv+L+Mo1zde0Rw==
X-Forward-Email-ID: 6a4ec9c82402b3ca75f90489
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
Date: Wed,  8 Jul 2026 22:05:32 +0000
Message-ID: <20260708220540.3368825-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

xPL_<name> symbols should typically depend on the associated xPL symbol.

Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<name>
symbols being available when the associated xPL symbol is disabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 common/Kconfig | 2 ++
 lib/Kconfig    | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 345be4b8ca14..ab0557c3666b 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -138,6 +138,7 @@ config SILENT_CONSOLE
 
 config SPL_SILENT_CONSOLE
 	bool "Use a silent console in SPL"
+	depends on SPL
 	default y if SILENT_CONSOLE && !SANDBOX
 	help
 	  This selects a silent console in SPL. When enabled it drops some
@@ -149,6 +150,7 @@ config SPL_SILENT_CONSOLE
 
 config TPL_SILENT_CONSOLE
 	bool "Use a silent console in TPL"
+	depends on TPL
 	default y if SILENT_CONSOLE && !SANDBOX
 	help
 	  This selects a silent console in TPL. When enabled it drops some
diff --git a/lib/Kconfig b/lib/Kconfig
index 9e0f0ad7d068..72b53d7d5490 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -960,6 +960,7 @@ config TPL_LZMA
 
 config VPL_LZMA
 	bool "Enable LZMA decompression support for VPL build"
+	depends on VPL
 	default y if LZMA
 	help
 	  This enables support for LZMA compression algorithm for VPL boot.
@@ -972,23 +973,27 @@ config SPL_LZO
 
 config SPL_GZIP
 	bool "Enable gzip decompression support for SPL build"
+	depends on SPL
 	select SPL_ZLIB
 	help
 	  This enables support for the GZIP compression algorithm for SPL boot.
 
 config TPL_GZIP
-	bool "Enable gzip decompression support for SPL build"
+	bool "Enable gzip decompression support for TPL build"
+	depends on TPL
 	select TPL_ZLIB
 	help
 	  This enables support for the GZIP compression algorithm for TPL
 
 config SPL_ZLIB
 	bool
+	depends on SPL
 	help
 	  This enables compression lib for SPL boot.
 
 config TPL_ZLIB
 	bool
+	depends on TPL
 	help
 	  This enables compression lib for TPL
 
-- 
2.54.0

