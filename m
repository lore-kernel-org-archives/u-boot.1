Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B506E668A2
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 22:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5FD803F5;
	Fri, 19 Dec 2025 23:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="irekw/RT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD8F808AF; Fri, 19 Dec 2025 23:43:32 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C910D80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 23:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EDC94409C2; 
 Fri, 19 Dec 2025 22:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766184210;
 bh=s8b8Uic9d7RncRiAWtRnTvTD7/4VQYt20ShYKokAikg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=irekw/RTWy8LY27CcRSrRtlrQoBgCHwGZ8u15liXzAhYTBX76Wj3dkvg+aXa8LRLP
 NjNLADc+5LJu1oKuEOamUuLjgt/E7TV0TUTUbacLVshDpx+n5BD74uPrpHl9pUxOv4
 Pw1mPbbhL1gMz8x5gGA1NNeioepjZsYMOt2PDBmTs0X5jS+gIkZ8E157SYptthHcrE
 3dwnilHYarubFRbBZbGdn9TViDcBQU8Q4YoMQ0l2Ah1rHYYSJ+YYKOIyYDwk4pFAmo
 9eS3z9WRS+cpUyI9mKr4oRWpqFW8pcbi0Lv4zvwbrD4KwPZW+KJfXHkzMZ7oTgPENS
 2U2jFr5reuEZzs8RWkhI5BjyjzvHazzcgIy84QVq1Zm1+V32Q91w8lC5Q13Zgw7KhC
 xrT1MG4Xo3lVIy2c1F8l35Wpw5d4CUZp8DcuhA3Fe8KpDK+gLZiL+XF7oDulomGGFm
 tu1/R7VuJiKzaoXntRe+3qQzam+1PM6R+jYDOsKA834qyaVfDrFIWp65ydRwgdePy0
 T/r5Viy6vsSZr3M2qH2p3ixrPC4jKeN+z1tuzFwN4aR7TjI2l4KcrcmDtnt+w/Pbbh
 CoITDGYtisB0rfQTy35kzCtObW/derPdXmw0WKHhTGJPUWQ+z+RxbIDpjrPvA75ZqC
 B77B6xobtY7iNevafn0tbC+s=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: The LMB test depends on CONFIG_LMB
Date: Fri, 19 Dec 2025 23:43:26 +0100
Message-ID: <20251219224326.195190-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

We cannot build the LMB test without the LMB library.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 7c9dc180c8d..f25383a40e5 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
 endif
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
-obj-y += lmb.o
+obj-$(CONFIG_LMB) += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_SANDBOX) += membuf.o
 obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
-- 
2.51.0

