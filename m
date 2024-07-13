Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2846C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF8688804;
	Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h+wk7ayS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Btlhhea5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CC9887FA; Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D98887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpxx4zRqz9sZv;
 Sat, 13 Jul 2024 15:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3sEYUMYBYXtTZIMHX0+RXVrcw/LSS0T4r86uMrVfkQ=;
 b=h+wk7ayS2QrCXzZIr+KhdRk9LtQ2fFWdKMchdNB96fciUBvWRJv6qpY5IFwiIr4N4/Yypq
 R3bF8a8wuo7d69DBM2dNYZJD02yCXoJMJcxqp+pIhWg6sLUf82s9I17s0J5WTTfcSkL3NC
 fGpjbsyU5a9oILN6gX7jDWwud3rmdp5kWd77zkZDZ+cG4U3yv78odAo7MTelvwQHkZ2TPA
 zSaTSYkiY88CbbkRry5tuQjlbRl+3FornFdrKDgj2USAkDnv3dY1bhPHN6/Sk0msdqgD5T
 GSay/4rJSzanBumR67OTVdjRQLxOjOGldvBOEtrfLJyMLE0/fQD1S5vnFAqFlg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3sEYUMYBYXtTZIMHX0+RXVrcw/LSS0T4r86uMrVfkQ=;
 b=Btlhhea5bEuWqJ6cs1prvDXvrNxpLT52vh2YjQ0Q1xc2TcDgfRrXlPBJBVKpuQGw+kRTPH
 eXIqAjofkv0AiBy1bRTss3fhN3F8khlQTrQdvbYxQWdYRMrDAW3rCZbh7FuLxuh7YnLKgV
 IBrB2FykNusDuyRZKXy62gJq6ak8tMlP3gTWbqTOeEZlZD8Dk2vYY/l/zka6faE4NZQLZw
 1og6RaFSX6Irk10Wi+/HaXcZ6DM6X9rrOjrtXYcq06tBYSVNKQeUQJ1rT5YlARVFua5Wzh
 XlWtGskrdKla19qKvb7SRPCLcC6alPm+dFIpBIdzo+I164o3VsuJH40HuDHTxg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/45] arm: cpu: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:54 +0200
Message-ID: <20240713132021.57650-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 640dcafe0991c1d9ab9
X-MBO-RS-META: fkpr4zy7zb39e89ao84ns5bkebp1h17t
X-Rspamd-Queue-Id: 4WLpxx4zRqz9sZv
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/cpu/arm926ejs/cpu.c           | 1 -
 arch/arm/cpu/armv7/arch_timer.c        | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-core.c | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-core.c | 1 -
 arch/arm/cpu/armv7/ls102xa/cpu.c       | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/cpu/arm926ejs/cpu.c b/arch/arm/cpu/arm926ejs/cpu.c
index 07ab04b7b08..0e100e6f13d 100644
--- a/arch/arm/cpu/arm926ejs/cpu.c
+++ b/arch/arm/cpu/arm926ejs/cpu.c
@@ -44,7 +44,6 @@ int cleanup_before_linux (void)
 
 	disable_interrupts();
 
-
 	/* turn off I/D-cache */
 	icache_disable();
 	dcache_disable();
diff --git a/arch/arm/cpu/armv7/arch_timer.c b/arch/arm/cpu/armv7/arch_timer.c
index f25a8674dea..36c557d4a8f 100644
--- a/arch/arm/cpu/armv7/arch_timer.c
+++ b/arch/arm/cpu/armv7/arch_timer.c
@@ -49,7 +49,6 @@ unsigned long long get_ticks(void)
 	return (((unsigned long long)gd->arch.tbu) << 32) | gd->arch.tbl;
 }
 
-
 ulong timer_get_boot_us(void)
 {
 	if (!gd->arch.timer_rate_hz)
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-core.c b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
index b769c451105..fa8af1b6941 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
@@ -84,7 +84,6 @@ static int peri_clk_enable(struct clk *c, int enable)
 	struct bcm_clk_gate *gate = &cd->gate;
 	void *base = (void *)c->ccu_clk_mgr_base;
 
-
 	debug("%s: %s\n", __func__, c->name);
 
 	clk_get_rate(c);	/* Make sure rate and sel are filled in */
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-core.c b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
index 3f2e021a307..71b3a9277b1 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
@@ -84,7 +84,6 @@ static int peri_clk_enable(struct clk *c, int enable)
 	struct bcm_clk_gate *gate = &cd->gate;
 	void *base = (void *)c->ccu_clk_mgr_base;
 
-
 	debug("%s: %s\n", __func__, c->name);
 
 	clk_get_rate(c);	/* Make sure rate and sel are filled in */
diff --git a/arch/arm/cpu/armv7/ls102xa/cpu.c b/arch/arm/cpu/armv7/ls102xa/cpu.c
index 74a2dcbc116..dccf2fb3eb1 100644
--- a/arch/arm/cpu/armv7/ls102xa/cpu.c
+++ b/arch/arm/cpu/armv7/ls102xa/cpu.c
@@ -224,7 +224,6 @@ void enable_caches(void)
 }
 #endif /* #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
-
 uint get_svr(void)
 {
 	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-- 
2.43.0

