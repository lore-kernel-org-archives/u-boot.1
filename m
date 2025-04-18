Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D8FC369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 04:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA5F831BF;
	Fri, 18 Apr 2025 06:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TYyDqIk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B44683156; Fri, 18 Apr 2025 06:31:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7EE8312C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5168E3FFD8; 
 Fri, 18 Apr 2025 04:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744950709;
 bh=+BEgbdUEy/GxvCswS4f2Yz3a8Biw6XueU8PtZA6PgQ4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TYyDqIk6ShSF7ByzP7a7VhM6FBEsYrwHpBQx5SMzUu0vufNuc2KACwfEcSVg6OXSV
 pZi6Gja6NGfofFNbXpc8WFpW8Md70TTpPuPQLrS13/ksTVepAWQzEmPXZ+Jy5qV5WB
 sEXb2mZSF7Aoeaz0SQwbCjFW6H/w4yy1cAVrDDqhVMH2f/qMwKDLP++0MwIsnY8f/8
 26R5B58N/eBZskkm9MKd9CK/y2JnftHlKDtn42avwccFhIrm1Vq6bbG3pGr9YuaRZS
 iC5F99VG9gkMtYR4xZU9E10TOjHPJHo1mr8b0zIG9n80zl7gHeME+hRuJdEgW7b5ER
 lh8v7VxeXngfQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 3/3] doc/buildman: describe using fragments
Date: Fri, 18 Apr 2025 06:31:37 +0200
Message-ID: <20250418043137.537340-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	Describe the invocation of merge_config.sh
v3:
	no change
v2:
	new patch
---
 tools/buildman/buildman.rst | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 07ecc5c110c..0729f15f2b5 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1126,27 +1126,23 @@ later comparison.
 defconfig fragments
 -------------------
 
-Buildman provides some initial support for configuration fragments. It can scan
-these when present in defconfig files and handle the resuiting Kconfig
-correctly. Thus it is possible to build a board which has a ``#include`` in the
-defconfig file.
+A comma separated list of configuration fragments can be added via the
+--fragments parameter to all processed defconfig files, e.g.
 
-For now, Buildman simply includes the files to produce a single output file,
-using the C preprocessor. It does not call the ``merge_config.sh`` script. The
-redefined/redundant logic in that script could fairly easily be repeated in
-Buildman, to detect potential problems. For now it is not clear that this is
-useful.
+.. code-block:: bash
 
-To specify the C preprocessor to use, set the ``CPP`` environment variable. The
-default is ``cpp``.
+    buildman -k qemu-riscv64_smode --fragments acpi.config
 
-Note that Buildman does not support adding fragments to existing boards, e.g.
-like::
+Buildman invokes ``make`` passing the defconfig file and the fragment files as
+target arguments. In ``scripts/kconfig/Makefile`` the script ``merge_config.sh``
+is called for each fragment file to add it to the configuration.
 
-    make qemu_riscv64_defconfig acpi.config
+Buildman also supports configuration fragments that are included in defconfig
+files via an ``#include`` statement. It can scan these and handle the resulting
+Kconfig correctly.
 
-This is partly because there is no way for Buildman to know which fragments are
-valid on which boards.
+To specify the C preprocessor to use, set the ``CPP`` environment variable. The
+default is ``cpp``.
 
 Building with clang
 -------------------
-- 
2.48.1

