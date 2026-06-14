Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F80FCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 01:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39BC183FEE;
	Sun, 14 Jun 2026 03:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hB0rQ2Ew";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QH3MIX03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A3584105; Sun, 14 Jun 2026 03:52:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249EF801A9
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 03:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gdGTc5CzTz9t8r;
 Sun, 14 Jun 2026 03:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781401940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nq8ytw36k0CA6nmGtpXSB0C4E2PiEPvecuMzgj/bbmc=;
 b=hB0rQ2EwDFyH30F/DpeSI+6e6559FQ3W/g8nk1n3ldM8BEX29BvH6cExtDUlD5U+dO+jvx
 Wvzv8izzr8DNNOxOvypBjTRMl+tbU6Q65epQbUul9VUZvHvwuUMZAgnfT/i95hxZiRk98H
 HtHbpdCFGvKVGLy37fRdp8ghbHxAYQx7NsWxRyI/Mh19/6+1k1VREovxMEfC1siQEf+mVJ
 8KrbXSNbo/kY25bIwFpimJDhktcgadm1ydaak4CRSnAcYZ4Q5/4yGyMKjLAdHlPbhCikP/
 /BHpoWOtTLxcLgbWuGdgoocdA3j5GAlAvPOU7uNFEhWNTG/NDSpXw4sSc00mhQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QH3MIX03;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781401939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nq8ytw36k0CA6nmGtpXSB0C4E2PiEPvecuMzgj/bbmc=;
 b=QH3MIX03nOAJhHkPGjynGjRxXzutzOfgZ3OrjdKqcaH+4BoOLcFVYmAS7ihq2Z0UTXzTf7
 EgwtZWMg6MMvZaOEggBDlVFKZ6oQY+ze3oNbNXpiIg/cI7ZGc83npHCuwTT5VJ1+Z6TLmC
 DLvrk6BOYPbuTKXzIvwUclOSrW9TONppFQLktUXc4QQ8MuCkxRtmVR4P6WU1cGSsLu8c+y
 Vid6SvLF7UeUDKrTiNlsm0RJ3YBnpML2nvDgEF2ejEL6QtN1JBPe+5tNLrcYEZI63NKxmp
 ZBjR/RCnysHwAmcSWSvP2sYDVsSmOLL3+tRqppL259q4N+uBlOklDyjTLg2rvg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Fold mach_cpu_init into board_init_f on R-Car
 S4/V4H/V4M SPL
Date: Sun, 14 Jun 2026 03:52:08 +0200
Message-ID: <20260614015215.341721-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uu5fe46ibegoreiye46c1r6njtyzeco3
X-MBO-RS-ID: 48d1683ba9e567b6212
X-Rspamd-Queue-Id: 4gdGTc5CzTz9t8r
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

The mach_cpu_init() function is not invoked in SPL. Instead of
having two functions, fold mach_cpu_init() into board_init_f(),
which is called very early in the boot process and assures that
the CPG and APMU setup will be invoked before DM is brought up.

Fixes: 37997a214ed1 ("arm: renesas: Use stock lowlevel_init function and remove s_init")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/gen4-spl.c | 41 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/board/renesas/common/gen4-spl.c b/board/renesas/common/gen4-spl.c
index e4c1190eac7..5a0b0ebe115 100644
--- a/board/renesas/common/gen4-spl.c
+++ b/board/renesas/common/gen4-spl.c
@@ -18,6 +18,12 @@
 #include <mapmem.h>
 #include <spl.h>
 
+#define APMU_BASE			0xe6170000U
+#define CL0GRP3_BIT			BIT(3)
+#define CL1GRP3_BIT			BIT(7)
+#define RTGRP3_BIT			BIT(19)
+#define APMU_ACC_ENB_FOR_ARM_CPU	(CL0GRP3_BIT | CL1GRP3_BIT | RTGRP3_BIT)
+
 #define CNTCR_EN	BIT(0)
 
 #ifdef CONFIG_SPL_BUILD
@@ -47,6 +53,18 @@ void board_init_f(ulong dummy)
 	struct udevice *dev;
 	int ret;
 
+	/* Unlock CPG access */
+	writel(0x5A5AFFFF, CPGWPR);
+	writel(0xA5A50000, CPGWPCR);
+	init_generic_timer();
+
+	/* Define for Work Around of APMU */
+	writel(0x00ff00ff, APMU_BASE + 0x10);
+	writel(0x00ff00ff, APMU_BASE + 0x14);
+	writel(0x00ff00ff, APMU_BASE + 0x18);
+	writel(0x00ff00ff, APMU_BASE + 0x1c);
+	clrbits_le32(APMU_BASE + 0x68, BIT(29));
+
 	if (CONFIG_IS_ENABLED(OF_CONTROL)) {
 		ret = spl_early_init();
 		if (ret) {
@@ -76,29 +94,6 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(CONFIG_SYS_LOAD_ADDR + offset, 0);
 }
 
-#define APMU_BASE 0xe6170000U
-#define CL0GRP3_BIT			BIT(3)
-#define CL1GRP3_BIT			BIT(7)
-#define RTGRP3_BIT			BIT(19)
-#define APMU_ACC_ENB_FOR_ARM_CPU	(CL0GRP3_BIT | CL1GRP3_BIT | RTGRP3_BIT)
-
-int mach_cpu_init(void)
-{
-	/* Unlock CPG access */
-	writel(0x5A5AFFFF, CPGWPR);
-	writel(0xA5A50000, CPGWPCR);
-	init_generic_timer();
-
-	/* Define for Work Around of APMU */
-	writel(0x00ff00ff, APMU_BASE + 0x10);
-	writel(0x00ff00ff, APMU_BASE + 0x14);
-	writel(0x00ff00ff, APMU_BASE + 0x18);
-	writel(0x00ff00ff, APMU_BASE + 0x1c);
-	clrbits_le32(APMU_BASE + 0x68, BIT(29));
-
-	return 0;
-}
-
 void reset_cpu(void)
 {
 }
-- 
2.53.0

