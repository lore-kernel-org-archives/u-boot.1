Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEEE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FB080241;
	Wed, 18 Dec 2024 16:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07D880295; Wed, 18 Dec 2024 16:40:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9DAD08022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18ED5497;
 Wed, 18 Dec 2024 07:40:37 -0800 (PST)
Received: from localhost.localdomain (F4CK67LV29.cambridge.arm.com
 [10.1.27.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 192EC3F7B4;
 Wed, 18 Dec 2024 07:40:07 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 1/4] bloblist: fix typo in code comments
Date: Wed, 18 Dec 2024 15:39:28 +0000
Message-ID: <20241218153933.37649-2-harrison.mutai@arm.com>
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

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 common/Kconfig     | 2 +-
 include/bloblist.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e8d89bf6eb..9e89ccd390 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1075,7 +1075,7 @@ config BLOBLIST_SIZE
 	  Sets the size of the bloblist in bytes. This must include all
 	  overhead (alignment, bloblist header, record header). The bloblist
 	  is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
-	  proper), and this sane bloblist is used for subsequent phases.
+	  proper), and this same bloblist is used for subsequent phases.

 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
diff --git a/include/bloblist.h b/include/bloblist.h
index ff32d3fecf..9d3ec3a8fa 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -456,7 +456,7 @@ int bloblist_init(void);
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

