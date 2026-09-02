Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3C0C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 00:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D372407EC;
	Wed,  2 Sep 2026 00:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjFcDqfRGVPS; Wed,  2 Sep 2026 00:01:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788307307;
	bh=zM5Lkz8k/Aurx45xKh2bDqUr8sYvGecpUiGCX+XZw+8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PA6Pz6MnWCJNKJ9AZPWqleSiQu2dxuhk+/1Dx0emduaRGKZXFOjxAvmwt5CZ61Vd4
	 gQDL+ZGLBrWuJi9WZOrKtSekHj5ssVHMh5gw0NPXlNkrmv8vYAtaGlfdDlcotez+td
	 ORKhSaHx5S/xpn1sp07YuuHbbXd01L25Nz3QYXF8p+u62KfggTiEF4MTD9CtMgC915
	 HHe9fpzxMN02xF8Hk3j0udAot+g9Np/qPx0Ozy3jam0f1s9gXzjUd4oSocHEg4UbDZ
	 VqM9zdf5KW8qkIf8ynSqHzpNwYR+koU7mp7Sw5zhg9uslSu4BOy5tR/lVPpWh0+BqH
	 y95SN961j8FXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C89FF40781;
	Wed,  2 Sep 2026 00:01:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B6C92FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D471606F6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cS0CV4MYwgD for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 00:01:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=E4DuadjR; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=QaboXvgA
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29BC060627
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:01:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hZNF24ywnz8sxV;
 Wed, 02 Sep 2026 02:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zM5Lkz8k/Aurx45xKh2bDqUr8sYvGecpUiGCX+XZw+8=;
 b=E4DuadjR4n5M6/YE84tepFrpdyzwWpgRIOZyKng9DlTnEXNuP5ZKxBK8KIEPTHwcXlJQrK
 XdIsgVwx+GzIipBRnBstPFkv9SiVI/SZLWsVm6OHNyWGcgD2syNKSOgXAPSMHy6SMdnTjA
 I3Ttsf8TX3ma9Oe14J9+lpLJRQVTM00YLAhXUXQCBGDk0NkWLQm6cFLh/q4T3pHmWBIbKi
 HDsYw9x35PIpITbi6GLU9CBgeWeFzxH9U5epdheJMHE3404TxHbRfpuN5YQVY1jQxVFer7
 6jT3CKDoC5AfrBHtr/21VLE6VI0Zbs5GYF3FvoMFf1dWMDaRGA7kGWVTfnl6oQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QaboXvgA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zM5Lkz8k/Aurx45xKh2bDqUr8sYvGecpUiGCX+XZw+8=;
 b=QaboXvgA2wl+dB9PbSXdRZNy426g2zxO5pn93Q9pNpyqc7NDxSu0N+xjLCL4QTl9kOg3vr
 MCQ3ELOfqN6YXd6I3p2HvzkWs+gNXdnCF7iGelNiTDSnehPdjTpObQqhf+W4Zt4EQPFeDq
 VbDKxHRImXdGXSeLdrh0PgE8T9furS/z4WBFJW+8zTbyqPs2d/AOP7hnCLz92x4iNXjdCf
 f0hmA/u3frmEilvbD3NT5DJdHZ+ysXibgA9lgNU1rI5c3wk22oYKJLG7DPwbGX2kih9Ybm
 cmC/ucDBxBOfG7wnejmJsutXqBmIfWo+1J5PTF6Rh8113Nn+2shYkexdtIQHpg==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Drop CNTP from Renesas R-Car Gen5 common code
Date: Wed,  2 Sep 2026 02:01:18 +0200
Message-ID: <20260902000138.350597-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ufj6suguwcgykuwxb6thi7br8w1r8t43
X-MBO-RS-ID: 5ab32ba0d70f9ea9b81
X-Rspamd-Queue-Id: 4hZNF24ywnz8sxV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The CNTP base address points one byte before generic counter region 1
memory address, which is unusual. Since U-Boot on R-Car Gen5 A-core
never runs in EL3, the code which would access this memory address is
never executed. Drop both the CNTP base address macro, and the unused
code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 .../include/mach/rcar-gen5-base.h             |  5 -----
 board/renesas/common/gen5-common.c            | 20 -------------------
 2 files changed, 25 deletions(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
index 35b0d00e45c..748fc028999 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
@@ -17,11 +17,6 @@
 #define TMU_BASE		0x1C030000
 #endif
 
-/* Arm Generic Timer */
-#define CNTCR_BASE		0x1C000FFF /* Region 0 */
-#define CNTFID0			(CNTCR_BASE + 0x020)
-#define CNTCR_EN		BIT(0)
-
 /* Reset */
 #define RST_BASE		0xC1320000 /* Domain0 */
 #define RST_SWSRES1A		(RST_BASE + 0x410)
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index 5160b32e2e3..51bab2aa19e 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -12,18 +12,6 @@
 #include <asm-generic/u-boot.h>
 #include <linux/errno.h>
 
-static void init_generic_timer(void)
-{
-	const u32 freq = CONFIG_SYS_CLK_FREQ;
-
-	/* Update memory mapped and register based freqency */
-	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
-	writel(freq, CNTFID0);
-
-	/* Enable counter */
-	setbits_le32(CNTCR_BASE, CNTCR_EN);
-}
-
 static void init_gic_v3(void)
 {
 	/* GIC v3 power on */
@@ -37,14 +25,6 @@ static void init_gic_v3(void)
 	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
 }
 
-int mach_cpu_init(void)
-{
-	if (current_el() == 3)
-		init_generic_timer();
-
-	return 0;
-}
-
 int board_early_init_f(void)
 {
 	return 0;
-- 
2.53.0

