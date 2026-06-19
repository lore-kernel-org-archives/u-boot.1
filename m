Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1784DCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C83184A0F;
	Fri, 19 Jun 2026 18:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KWnuW9qX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03608499C; Fri, 19 Jun 2026 17:59:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0DC45800AE
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 17:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jon.mason@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F11D3297;
 Fri, 19 Jun 2026 08:58:53 -0700 (PDT)
Received: from H24V3P4C17.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05D543F763;
 Fri, 19 Jun 2026 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781884738; bh=Kr/sNfacRS102nkC3mDq0EMStWUs7Ji9Yz6yAfEFz1Y=;
 h=From:To:Cc:Subject:Date:From;
 b=KWnuW9qXrpcEqisQ5fXsoWI3yTK1cZ3CsB/t6rq3rijYkWnJyxELcdZqV7MhMDuoD
 Bf0nzmPYoWqv0c+RFCf4j/UeMD2571I81VDpBz55XFWTTnhgjIjgwFAWCaexgP36X2
 o1fivsDoBKgraK0SbOuv1JSnL+zJy4Y8nHEaV0N8=
From: Jon Mason <jon.mason@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: move efi_var_seed.o to objtree
Date: Fri, 19 Jun 2026 11:58:57 -0400
Message-ID: <20260619155857.9665-1-jon.mason@arm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
(kbuild: Bump the build system to 6.1), there is an issue when trying to
build out of tree, where efi_var_seed.S wants ubootefi.var to be in the
object tree, but lib/efi_loader/efi_var_seed.o wants ubootefi.var to be
in the source tree.

If we change efi_var_seed.o to look in the objtree, then it should work
in both local and out-of-tree.  However, it would require anything
previously working to put ubootefi.vars to the objtree, but it's broken
now anyway.

Signed-off-by: Jon Mason <jon.mason@arm.com>
---
 lib/efi_loader/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index f490081f6542..9c836f6ee237 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
 
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
+$(obj)/efi_var_seed.o: $(objtree)/$(EFI_VAR_SEED_FILE)
 
 ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
 capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
