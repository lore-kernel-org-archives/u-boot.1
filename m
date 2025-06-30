Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86690C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF29B82F6F;
	Mon, 30 Jun 2025 20:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uUPDQ87f";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uwUSSNkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41B282EB8; Mon, 30 Jun 2025 20:51:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22AA82E27
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bWFcy4bfsz9t6S;
 Mon, 30 Jun 2025 20:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKeq6sWOZjRX/Peaa4v2QWvaiCack+1k85EfSIyKgiA=;
 b=uUPDQ87fOMBwLIrxti57RKwiY3N8bfl9LBRA0GHJ/UZjaLJHEl2Z+H1HNaSWqdNsC0GH+A
 2ckesG8Usjxi/TEa4k05Xy0fSNhyCOs2kEmIh/kBDQ4Cclf54iDtRzm1VgSR6LCbSugAFg
 8H55kqKstGQ9z+JkcBB2k6zTbGikones/VZp1KnJcEX6i2J+3osGOJEDDQkOwQErXGdmGr
 dSnMfKFl9qk9dCqobixXQqzN9XBp6QpBAPKcSVC9ypztPVhviQa7HhmJUCgiKQJokOgcov
 HKVfheWgz7LQ7EfCU91+pTi60aPrniIEKqmsQQvm/Wy1Tl+wv9+xatxX0i/Chg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKeq6sWOZjRX/Peaa4v2QWvaiCack+1k85EfSIyKgiA=;
 b=uwUSSNkqdtpnuz5o6hxyXKXniMbUz/sv/XZy8TlOl6rBEbXBY2tMZvHdiyEaPysz33YX+R
 E0Xq0U9bJNE5A7k0qwo4vpHM+OUh8Xt8d3Kgz8rmm6kZ7RAbwao2itWRJc27F/dNmbFIii
 UnkgE4glinn+ZmJT/UXceIdF5clsDTgc5o62fULuiQVtAfhQ1XaVbdj5v9NE85cd5F44ke
 PWt6eAOyV5HVMdHexxv1+d6QUxIsN4YbbXvflG/z3bGdZe09qpnaZoePmtBEKA52cdle9D
 dq5hReF/8Iu3gIxZ9kgHukM54nJr1g44h6tMY84bRhYxPP0livlbBz+mtrpHlg==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] net: sh_eth: arm: renesas: README: Drop
 CFG_SH_ETHER_CACHE_*
Date: Mon, 30 Jun 2025 20:51:13 +0200
Message-ID: <20250630185124.1099147-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o67f4sn4k6myaywwpboidh5wc1m6xfgg
X-MBO-RS-ID: 87c3648601199e3b9b8
X-Rspamd-Queue-Id: 4bWFcy4bfsz9t6S
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

Drop CFG_SH_ETHER_CACHE_WRITEBACK and CFG_SH_ETHER_CACHE_INVALIDATE,
which are now always enabled in the sh_eth driver, because those cache
operations are always available. On architectures which do not implement
cache operations yet, cache operations have to be implemented first.

CFG_SH_ETHER_ALIGNE_SIZE now set as SH_ETHER_ALIGN_SIZE in sh_eth.h
based on architecture and no longer configured on board level.

Remove CFG_SH_ETHER_CACHE_WRITEBACK configuration option from README.

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
 include/configs/alt.h     | 3 ---
 include/configs/condor.h  | 3 ---
 include/configs/gose.h    | 3 ---
 include/configs/grpeach.h | 3 ---
 include/configs/koelsch.h | 3 ---
 include/configs/lager.h   | 3 ---
 include/configs/porter.h  | 3 ---
 include/configs/silk.h    | 3 ---
 include/configs/stout.h   | 3 ---
 include/configs/v3hsk.h   | 3 ---
 11 files changed, 33 deletions(-)

diff --git a/README b/README
index 8f8f4b85ef8..7acf39540c2 100644
--- a/README
+++ b/README
@@ -382,9 +382,6 @@ The following options need to be configured:
 			CFG_SH_ETHER_PHY_ADDR
 			Define the ETH PHY's address
 
-			CFG_SH_ETHER_CACHE_WRITEBACK
-			If this option is set, the driver enables cache flush.
-
 - TPM Support:
 		CONFIG_TPM
 		Support TPM devices.
diff --git a/include/configs/alt.h b/include/configs/alt.h
index 52b8c95cd7b..987fd25bb4c 100644
--- a/include/configs/alt.h
+++ b/include/configs/alt.h
@@ -23,9 +23,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/condor.h b/include/configs/condor.h
index ecaf58e4c0f..b2d66c785fc 100644
--- a/include/configs/condor.h
+++ b/include/configs/condor.h
@@ -16,9 +16,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 /* XTAL_CLK : 33.33MHz */
diff --git a/include/configs/gose.h b/include/configs/gose.h
index 323977e9b8a..acef925855a 100644
--- a/include/configs/gose.h
+++ b/include/configs/gose.h
@@ -22,9 +22,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/grpeach.h b/include/configs/grpeach.h
index 67ad8339816..9a7eef57c87 100644
--- a/include/configs/grpeach.h
+++ b/include/configs/grpeach.h
@@ -19,8 +19,5 @@
 /* Network interface */
 #define CFG_SH_ETHER_PHY_ADDR	0
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_MII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 #endif	/* __GRPEACH_H */
diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
index 11f637d3f33..13d2127ac13 100644
--- a/include/configs/koelsch.h
+++ b/include/configs/koelsch.h
@@ -22,9 +22,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/lager.h b/include/configs/lager.h
index aaf4a4a6931..d76f003e391 100644
--- a/include/configs/lager.h
+++ b/include/configs/lager.h
@@ -23,9 +23,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/porter.h b/include/configs/porter.h
index ff99c3fb817..eaf5d31c1d3 100644
--- a/include/configs/porter.h
+++ b/include/configs/porter.h
@@ -24,9 +24,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/silk.h b/include/configs/silk.h
index 20d18aa5aa7..4ef70281dda 100644
--- a/include/configs/silk.h
+++ b/include/configs/silk.h
@@ -24,9 +24,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/stout.h b/include/configs/stout.h
index 454d8ca5716..cb544de243e 100644
--- a/include/configs/stout.h
+++ b/include/configs/stout.h
@@ -28,9 +28,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 
diff --git a/include/configs/v3hsk.h b/include/configs/v3hsk.h
index e16a289ac1a..a8d1641b36e 100644
--- a/include/configs/v3hsk.h
+++ b/include/configs/v3hsk.h
@@ -17,9 +17,6 @@
 /* SH Ether */
 #define CFG_SH_ETHER_PHY_ADDR	0x0
 #define CFG_SH_ETHER_PHY_MODE	PHY_INTERFACE_MODE_RGMII_ID
-#define CFG_SH_ETHER_CACHE_WRITEBACK
-#define CFG_SH_ETHER_CACHE_INVALIDATE
-#define CFG_SH_ETHER_ALIGNE_SIZE	64
 
 /* Board Clock */
 /* XTAL_CLK : 33.33MHz */
-- 
2.47.2

