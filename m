Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15301E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB3D80328;
	Wed, 18 Dec 2024 16:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A4A80283; Wed, 18 Dec 2024 16:40:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 418E58022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15AD1BB0;
 Wed, 18 Dec 2024 07:40:40 -0800 (PST)
Received: from localhost.localdomain (F4CK67LV29.cambridge.arm.com
 [10.1.27.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16793F7B4;
 Wed, 18 Dec 2024 07:40:11 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Date: Wed, 18 Dec 2024 15:39:30 +0000
Message-ID: <20241218153933.37649-4-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241218153933.37649-1-harrison.mutai@arm.com>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
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

When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
bloblist present in the incoming standard passage is utilised in-place.
There is no need to specify the size of the bloblist as the system
automatically detects it using the header information.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 common/Kconfig    | 7 +++++++
 common/bloblist.c | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 9e89ccd390..11066ec643 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1056,6 +1056,12 @@ config BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.

+config BLOBLIST_PASSAGE
+	bool "Use bloblist in-place"
+	help
+	  Use a bloblist in the incoming standard passage. The size is detected
+	  automatically so CONFIG_BLOBLIST_SIZE can be 0.
+
 endchoice

 config BLOBLIST_ADDR
@@ -1070,6 +1076,7 @@ config BLOBLIST_ADDR

 config BLOBLIST_SIZE
 	hex "Size of bloblist"
+	default 0x0 if BLOBLIST_PASSAGE
 	default 0x400
 	help
 	  Sets the size of the bloblist in bytes. This must include all
diff --git a/common/bloblist.c b/common/bloblist.c
index ec6ff7a5a9..db0091dc0e 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -475,6 +475,9 @@ int bloblist_reloc(void *to, uint to_size)
 {
 	struct bloblist_hdr *hdr;

+	if (to_size == 0)
+		return 0;
+
 	if (to_size < gd->bloblist->total_size)
 		return -ENOSPC;

@@ -510,7 +513,7 @@ int bloblist_init(void)
 	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	bool from_boot_arg = fixed && xpl_is_first_phase();
+	bool from_boot_arg = xpl_is_first_phase();

 	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
 		from_addr = false;
--
2.46.2

