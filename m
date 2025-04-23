Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5B5C369D5
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 11:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2CB80BA8;
	Wed, 23 Apr 2025 13:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B34380BA8; Wed, 23 Apr 2025 13:31:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 46710809A5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 13:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF771063;
 Wed, 23 Apr 2025 04:31:41 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351AF3F66E;
 Wed, 23 Apr 2025 04:31:44 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] lmb: use a different bit position for LMB_NOMAP
Date: Wed, 23 Apr 2025 17:01:23 +0530
Message-Id: <20250423113123.888700-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The LMB memory region attributes flags are used to specify the
behaviour of the memory regions with respect to allocations -- for
e.g. it is allowed to re-allocate a memory region already reserved
with the LMB_NONE flag. The flags use values with different bit
positions through the BIT() macro. Move the LMB_NOMAP value to bit
position 1, and also move the other flags accordingly. Using bit
position 0 for LMB_NOMAP results in the logic in
lmb_print_region_flags() to break, which prints an incorrect value for
the regions with LMB_NOMAP atribute.

Fixes: 3d56c06551d ("lmb: Move enum lmb_flags to a u32")
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 0d316c64c0a..606a92cca48 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -27,9 +27,9 @@
  * %LMB_NONOTIFY: Do not notify other modules of changes to this memory region
  */
 #define LMB_NONE 0
-#define LMB_NOMAP BIT(0)
-#define LMB_NOOVERWRITE BIT(1)
-#define LMB_NONOTIFY BIT(2)
+#define LMB_NOMAP BIT(1)
+#define LMB_NOOVERWRITE BIT(2)
+#define LMB_NONOTIFY BIT(3)
 
 /**
  * enum lmb_map_op - memory map operation
-- 
2.34.1

