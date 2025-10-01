Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4EECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 23:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B8E835B3;
	Thu,  2 Oct 2025 01:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9437C828A2; Thu,  2 Oct 2025 01:23:04 +0200 (CEST)
Received: from server.mars-solutions.it (server.mars-solutions.it
 [88.198.47.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382998352B
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 01:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=apr@cn-eng.de
Received: from nb-apr.fritz.box (ip-078-043-169-169.um18.pools.vodafone-ip.de
 [78.43.169.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by server.mars-solutions.it (Postfix) with ESMTPSA id DCB7876A2090;
 Thu,  2 Oct 2025 01:22:59 +0200 (CEST)
From: Andreas Pretzsch <apr@cn-eng.de>
To: u-boot@lists.denx.de
Cc: Martin Schwan <m.schwan@phytec.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] bootstd: rauc: extend and fix doc to reflect real flow
Date: Thu,  2 Oct 2025 01:22:56 +0200
Message-ID: <20251001232259.3599563-3-apr@cn-eng.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001232259.3599563-1-apr@cn-eng.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
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

The documentation of bootmeth rauc in some aspects does not reflect the
real program flow. Specifically the reset of boot tries in case of "no
more slots found" is incorrect (it won't change BOOT_ORDER).
Also the search sequence for boot scripts was mixed and incomplete.
Fix these points in the documentation.

Explain the initial setup of any missing BOOT_ORDER and BOOT_x_LEFT
environment variables, and inform about BOOT_x_LEFT decrementing.

Signed-off-by: Andreas Pretzsch <apr@cn-eng.de>
---
 doc/develop/bootstd/rauc.rst | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
index b2661d18da4..668d2a138a3 100644
--- a/doc/develop/bootstd/rauc.rst
+++ b/doc/develop/bootstd/rauc.rst
@@ -21,14 +21,21 @@ with the left one tried first.
 The default number of boot tries of each slot is set by
 ``CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES``.
 
-In case no valid slot can be found and/or all slots have zero tries left, the
-boot order and slot tries are reset to their default values, if
-``CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES`` is enabled. This prevents a system
-from locking up in the bootloader and tries booting again after a specified
-number of tries.
+If ``BOOT_ORDER`` does not exist in environment, it will be created and set to
+``CONFIG_BOOTMETH_RAUC_BOOT_ORDER``.  If any ``BOOT_x_LEFT`` (``BOOT_A_LEFT``,
+``BOOT_B_LEFT``) does not exist in environment, it will be created and set to
+``CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES``.
+
+If ``CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES`` is enabled, and no valid slot
+is found (all slots in BOOT_ORDER have BOOT_x_LEFT set to 0), *all* slot tries
+are reset to their default values.  This prevents a system from locking up in
+the bootloader and tries booting again after a specified number of tries.
+
+If a valid slot is found, its LEFT value in environment is decremented by 1.
 
 The boot script must be located in each boot partition. The bootmeth searches
-for "boot.scr.uimg" first, then "boot.scr" if not found.
+for ``boot.scr`` first, then ``boot.scr.uimg`` if not found. It will search in
+all directories of the bootstd list of prefixes (``"/", "/boot"`` by default).
 
 When the bootflow is booted, the bootmeth sets these environment variables:
 
-- 
2.43.0

