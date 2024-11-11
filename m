Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2973CD2E9E9
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE6988EBB;
	Mon, 11 Nov 2024 14:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1021188EC9; Mon, 11 Nov 2024 14:21:07 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D7088A0A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xn9D048R9zc4V;
 Mon, 11 Nov 2024 14:21:04 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Xn9Cz69hYz6X3; Mon, 11 Nov 2024 14:21:03 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Nov 2024 14:20:49 +0100
Subject: [PATCH] Makefile: fix empty MK_ARCH when using ccache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
X-B4-Tracking: v=1; b=H4sIALAEMmcC/x2MQQqAIBAAvxJ7TlAxkr4SEbJtuUQWChGEf29pb
 nOYeaFQZiowNC9kurnwmURM2wDGkDZSvIiD1dYZQR37HDJGhRgwkupNp523uC7kQaIr08rPPxy
 nWj9EUeQRYAAAAA==
X-Change-ID: 20241111-mk_arch-ccache-7150482cfde8
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjd@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

One can use ccache by prefixing the typical CROSS_COMPILE value with
"ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
makes the MK_ARCH empty because sed won't find a match anymore since it
expects the CROSS_COMPILE value to start with the actual toolchain (with
an unlimited number of white spaces before).

This is failing builds since commit 7506c1566998 ("sandbox: Report host
default-filename in native mode").

Add "ccache" prefix to ignore but participate in the matching regex used
by sed to identify the target architecture.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
One can use ccache by prefixing the typical CROSS_COMPILE value with
"ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
makes the MK_ARCH empty because sed won't find a match anymore since it
expects the CROSS_COMPILE value to start with the actual toolchain (with
an unlimited number of white spaces before).

This is failing builds since commit 7506c1566998 ("sandbox: Report host
default-filename in native mode").

Add "ccache" prefix to ignore but participate in the matching regex used
by sed to identify the target architecture.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7275a02f24ca64ebd46c5dc6e769dcdee9917dca..71743db16fca930567edd67eb77f1c94e9b7b4e9 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))

---
base-commit: 9c25cd563179cf32cf3b119d5ae78ef8348d0335
change-id: 20241111-mk_arch-ccache-7150482cfde8

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

