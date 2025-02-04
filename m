Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B78CC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3728070F;
	Tue,  4 Feb 2025 18:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D89B805E7; Tue,  4 Feb 2025 18:58:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6248D805A1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA59511FB;
 Tue,  4 Feb 2025 09:59:15 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.31.150])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA6E3F77D;
 Tue,  4 Feb 2025 09:58:50 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 1/4] bloblist: fix typo in code comments
Date: Tue,  4 Feb 2025 17:58:39 +0000
Message-ID: <20250204175844.19890-2-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250204175844.19890-1-harrison.mutai@arm.com>
References: <20250204175844.19890-1-harrison.mutai@arm.com>
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

Fix the two typos in the spelling of same and set in common/Kconfig and
include/bloblist.h.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 common/Kconfig     | 6 +++---
 include/bloblist.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 7685914fa6..f9489872fd 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1055,8 +1055,8 @@ choice
 config BLOBLIST_FIXED
 	bool "Place bloblist at a fixed address in memory"
 	help
-	  Select this to used a fixed memory address for the bloblist. If the
-	  bloblist exists at this address from a previous phase, it used as is.
+	  Select this to use a fixed memory address for the bloblist. If the
+	  bloblist exists at this address from a previous phase, it is used as is.
 	  If not it is created at this address in U-Boot.
 
 config BLOBLIST_ALLOC
@@ -1085,7 +1085,7 @@ config BLOBLIST_SIZE
 	  Sets the size of the bloblist in bytes. This must include all
 	  overhead (alignment, bloblist header, record header). The bloblist
 	  is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
-	  proper), and this sane bloblist is used for subsequent phases.
+	  proper), and this same bloblist is used for subsequent phases.
 
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
diff --git a/include/bloblist.h b/include/bloblist.h
index f999391f74..03d9862c0f 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -463,7 +463,7 @@ int bloblist_init(void);
 /**
  * bloblist_maybe_init() - Init the bloblist system if not already done
  *
- * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not et
+ * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not set
  *
  * Return: 0 if OK, -ve on error
  */
-- 
2.46.2

