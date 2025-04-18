Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A7BC369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 01:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75FA83171;
	Fri, 18 Apr 2025 03:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Hnw/K0BG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8352F83171; Fri, 18 Apr 2025 03:24:02 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A944281E14
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A58023FFDC; 
 Fri, 18 Apr 2025 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744939437;
 bh=i2EAm6EExuW2Iv7BR5v0unjKujsJpGkBPx5x1RrIdAc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Hnw/K0BGs/9YB6/ZvWPebbMbXuA6xMcVbZaYOYosa12Iu6pQvXmdrxF34V/gzk7yW
 AcCq2QvcuqkVh25U76x/vnX22+zKJk0qe263MxTNFwpdg8wLqR4CnWhD0pe6G1IC/1
 1XPQMgztu8kO7N347nHmG3m2Ph4uQ5Ndq3p7LpDxwifjSvTJ0QFRizF/gWSFC5cwlg
 pnk34XsKuojPrsynqNgWmbAclA3IMTWY1dDhMAmA/zFyefGCrt3EWhorbdSPcQs3P+
 iFTI7AupWVI2o9dKtcsBgkOwzEhfqCzF2y+3MNC4ovFvqHWTyg/NchiOaOHXsC6/NM
 WNLECRfA4fCTA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/3] doc/buildman: describe using fragments
Date: Fri, 18 Apr 2025 03:23:38 +0200
Message-ID: <20250418012339.177968-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418012339.177968-1-heinrich.schuchardt@canonical.com>
References: <20250418012339.177968-1-heinrich.schuchardt@canonical.com>
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

Describe the new --fragments parameter

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2:
	new patch
---
 tools/buildman/buildman.rst | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 07ecc5c110c..ba898cdae5a 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1126,10 +1126,16 @@ later comparison.
 defconfig fragments
 -------------------
 
-Buildman provides some initial support for configuration fragments. It can scan
-these when present in defconfig files and handle the resuiting Kconfig
-correctly. Thus it is possible to build a board which has a ``#include`` in the
-defconfig file.
+A comma separated list of configuration fragments can be added via the
+--fragments parameter to all processed defconfig files, e.g.
+
+.. code-block:: bash
+
+    buildman -k qemu-riscv64_smode --fragments acpi.config
+
+Buildman also supports configuration fragments that are included in defconfig
+files via an ``#include`` statement. It can scan these and handle the resulting
+Kconfig correctly.
 
 For now, Buildman simply includes the files to produce a single output file,
 using the C preprocessor. It does not call the ``merge_config.sh`` script. The
@@ -1140,14 +1146,6 @@ useful.
 To specify the C preprocessor to use, set the ``CPP`` environment variable. The
 default is ``cpp``.
 
-Note that Buildman does not support adding fragments to existing boards, e.g.
-like::
-
-    make qemu_riscv64_defconfig acpi.config
-
-This is partly because there is no way for Buildman to know which fragments are
-valid on which boards.
-
 Building with clang
 -------------------
 
-- 
2.48.1

