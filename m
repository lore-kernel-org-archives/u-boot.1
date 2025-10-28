Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41503CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A0381D6A;
	Tue, 28 Oct 2025 15:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B98B82E34; Tue, 28 Oct 2025 15:02:35 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 376B580422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwsWr5R0MzJ9Y;
 Tue, 28 Oct 2025 15:02:32 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwsWr0BbFzkW2; Tue, 28 Oct 2025 15:02:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Oct 2025 15:02:19 +0100
Subject: [PATCH] ext4: include missing blk.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-ext-blk-h-v1-1-bba1828fc73d@cherry.de>
X-B4-Tracking: v=1; b=H4sIAOrMAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3dSKEt2knGzdDF1T8zRjs0QDcwsTE0sloPqCotS0zAqwWdGxtbU
 AMnJHGlsAAAA=
X-Change-ID: 20251028-ext-blk-h-57f36a078449
To: Frederic Leroy <fredo@starox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

If missing, lbaint_t typedef will not be found in some cases.

[The proper fix for the commit above at the time would have been to
 include ide.h as only since 1a73661bc7a7 ("dm: Add a new header for
 block devices") is the typedef in blk.h]

Fixes: 04735e9c5578 ("Fix ext2/ext4 filesystem accesses beyond 2TiB")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 include/ext_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/ext_common.h b/include/ext_common.h
index 6e17fbd2771..09fb2aeb4d9 100644
--- a/include/ext_common.h
+++ b/include/ext_common.h
@@ -20,6 +20,7 @@
 #ifndef __EXT_COMMON__
 #define __EXT_COMMON__
 
+#include <blk.h>
 #include <compiler.h>
 
 struct cmd_tbl;

---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251028-ext-blk-h-57f36a078449

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

