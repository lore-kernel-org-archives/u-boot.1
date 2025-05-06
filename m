Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BB1C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922E5820EB;
	Tue,  6 May 2025 14:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D9F82163; Tue,  6 May 2025 14:36:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 80D4980C83
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF62339;
 Tue,  6 May 2025 05:36:17 -0700 (PDT)
Received: from localhost.localdomain (MacBookPro.nice.Arm.com [10.34.111.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 EC8753F58B; Tue,  6 May 2025 05:36:25 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH] cmd: nvedit: fix efi env -e -i command help
Date: Tue,  6 May 2025 14:36:22 +0200
Message-ID: <20250506123622.3216742-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The help string for the `setenv -e' command shows a comma being used as
the separator between address and size for the -i option, which deals
with UEFI Variables contents passed as a buffer in memory.
This is no longer the case since commit 2b3fbcb59f41 ("efi_loader: use
':' as separator for setenv -i") and commit 8f0ac536d493 ("efi: change
'env -e -i' usage syntax"), which changed the separator from a comma to
a colon.
Therefore fix this last bit of the help string accordingly.

While at it, fix the comment of function do_env_set_efi(), which also
mentions a comma as separator.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 cmd/nvedit.c     | 2 +-
 cmd/nvedit_efi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 1f259801293..11c3cea882b 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -1263,7 +1263,7 @@ U_BOOT_CMD_COMPLETE(
 	"      \"-rt\": set runtime attribute\n"
 	"      \"-at\": set time-based authentication attribute\n"
 	"      \"-a\": append-write\n"
-	"      \"-i addr,size\": use <addr,size> as variable's value\n"
+	"      \"-i addr:size\": use <addr,size> as variable's value\n"
 	"      \"-v\": verbose message\n"
 	"    - delete UEFI variable 'name' if 'value' not specified\n"
 #endif
diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 32b7d049074..351ae47e870 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -367,7 +367,7 @@ out:
  *
  * This function is for "env set -e" or "setenv -e" command:
  *   => env set -e [-guid guid][-nv][-bs][-rt][-at][-a][-v]
- *		   [-i address,size] var, or
+ *		   [-i address:size] var, or
  *                 var [value ...]
  * Encode values specified and set given UEFI variable.
  * If no value is specified, delete the variable.
-- 
2.47.2

