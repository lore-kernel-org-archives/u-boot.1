Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683A2ECE58F
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 00:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CB3884CD;
	Tue, 10 Sep 2024 02:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uvqCWAZ9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sa42syYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A75888C69; Tue, 10 Sep 2024 02:16:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3006188113
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X2klM5jJVz9t06;
 Tue, 10 Sep 2024 02:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725927391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qwBnozHbj+1+MPcnn4cmAaty2V+btQZueolpQWtwk9w=;
 b=uvqCWAZ9jGO38e2gBEMURtAOFNxHSQfWo0lD+QOBhOYZSYfNOpTfhnSFHuIThZF2iF4vXD
 04A7/j/mDbu3d20mJnc2idi5rqnq6EWwq+22cR1MBK51JTAWZkwXenau3RGVjoNFQngd4P
 jjVvA4PIQEH0dkep4lfxOA6GKHH+DdEBVkTJJVPDJ8+5ywmfPWoZ2Mmq++W8gdnbbXuK9I
 xBqq3f1Fbo2P33ensfdJWND25W4O/OuOVEHPQG9Gy/qgTrIVv63qRIE+muKLQEftXGuFrT
 oBpM64Sl+iFng+YI1SqfqAGVMt35dHv6yI25Qr5z0YJt/48xERA4C4Uj2LydkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725927389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qwBnozHbj+1+MPcnn4cmAaty2V+btQZueolpQWtwk9w=;
 b=sa42syYWN82avDvCl9aIidzqo9ZM6zwe/W2uPE4N1pzX0CpEJcfSJntoQsgmoqFqjGAXJV
 Vx1d7p32vB2o6Cp+YXKgiVulvSYtop+HcBGmiH67maovoYXlv9FhBUgiwNaDaVQDmYS8kp
 UmFLT6t0P3os2peF3LX4U0AcWpV4jmfVp4zBrn35kjvZcMWwCOgCyl9gZ0oKzmy/LhGDnr
 iV+OlEE3kpDCWJCoh+P/MN0TuDe/LUi54INwLthiJZGPP5EDQdf9z9OvXzpl6BNc0OHCqk
 9AIvDJwXCBX2ga+rT+Psc6vf1N83D8MNSGvECOBI3PCw8VHKYOtr8BlQOErxeA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sh: cache: Fill in invalidate_icache_all()
Date: Tue, 10 Sep 2024 02:15:58 +0200
Message-ID: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 98rows8qkmxm13qhoswezy94661md4ki
X-MBO-RS-ID: 399a87f5b62b1188897
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

Implement invalidate_icache_all() by clearing all V bits in
IC and OC. This is done by setting CCR cache control register
ICI and OCI bits.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sh/cpu/sh4/cache.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index d3c480e79ed..99acc599965 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
 	}
 }
 
-#define CACHE_ENABLE      0
-#define CACHE_DISABLE     1
+#define CACHE_ENABLE		0
+#define CACHE_DISABLE		1
+#define CACHE_INVALIDATE	2
 
 static int cache_control(unsigned int cmd)
 {
@@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
 	if (ccr & CCR_CACHE_ENABLE)
 		cache_wback_all();
 
-	if (cmd == CACHE_DISABLE)
+	if (cmd == CACHE_INVALIDATE)
+		outl(CCR_CACHE_ICI | ccr, CCR);
+	else if (cmd == CACHE_DISABLE)
 		outl(CCR_CACHE_STOP, CCR);
 	else
 		outl(CCR_CACHE_INIT, CCR);
@@ -103,7 +106,7 @@ void icache_disable(void)
 
 void invalidate_icache_all(void)
 {
-	puts("No arch specific invalidate_icache_all available!\n");
+	cache_control(CACHE_INVALIDATE);
 }
 
 int icache_status(void)
-- 
2.45.2

