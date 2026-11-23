Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l9yj89xX;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Mj2OO5w+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA232406AB;
	Mon, 23 Nov 2026 11:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZ1qsmdvF5zb; Mon, 23 Nov 2026 11:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5D0A40698
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795433203;
	b=B4Ru3mk3R/wMcfUOUCBosLkES5lpg4HExatUMyzjPlqZ9hB1CJ0okGxX4K74VEPNvX2I
	 9dL/QUScsNd859j8Pa7hy60CD4jsdqmvIEsU6Puy20F0udMfE02em6hAoVTNBM30G4cJH
	 z1k2Xx5OiKPMy2uARwtaeo7zj/vsaj5a7bmkrYp4DXyKfcDnqCnYK0M8j3EMUIL7b7mZl
	 GApVQh0hf66hYivNfCLxBr7ulNgkXvUI8i+bSorQWchtMeaCXcRW143S+UN4RCp47G1NY
	 SDdC+HdwLfYt9YT7sWq+fH4OsPwZ5HobI7Jf1m9AWkIrMgKoaqS5b+lAtwuNfSnVGRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795433203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VDtioNXO1QMAC3EDoTLI3QW8KwvIpiP/m/Yw31u4WcQ=;
	b=B4t38iqtMGkDUxZNVRHHwGQGViCUjfBdBqMFPsvV17X9AfXzNF0vRIQXlrrNi88lF2Tp
	 nOQJVWSVUeEO02L9Zr7Q7JIVMVbqfuhn22iffLNg2C1+OEfUp4M0qFKrKT9byu6SuFC4w
	 tvWmMvoz8C6IDvzrYsajHL0ZmChbCTS6qQngjUXTZccT17enUqqdCwwSQE4PQtP2KNUW7
	 Cc5vPDI9U1wOPVHQ8D7b64BW2zaAhUdzLqYHqU9cW0POeMUCvM99iqerRnesIrq6gdZLf
	 IBjqIWDP/Skm73DAGEZfI3irQTpsBSffkviGQd0HUT14gZBz8BkgErRPoYJMk0KQW1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795433203;
	bh=VDtioNXO1QMAC3EDoTLI3QW8KwvIpiP/m/Yw31u4WcQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l9yj89xXpUeTwjtO+rgHtY7OF9KcuVE6tnL+DjxSoDINjMii1JSRZGOtxV/gIxcv+
	 cwT+Zz2WKgD/oKCaHGJm6B+uzwPsx28lLDEZNA5ejSdKuXEwLspK0sCEr47cna6ORO
	 cDb/1W9e6LQ/n2bFiCXEEx9eFJeKc0MSvGtIM55wxWszHWXbVAGT53tT8S5syRiPPZ
	 6IK3AaXQydxFjybzNQb4iGdnGvbw8/WXjnrwcV4UYe+cT1KatNa/HgTxrjWiPY/OVX
	 o+uKy+Jr/BBgB+W/KDCOoFD35sFfC58zNOkAWEkYpnjpF6vSHG7SgWTRVTDFyz47Kl
	 F8rmxmFOfUiKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5D0A40698;
	Mon, 23 Nov 2026 11:26:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B84E1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D9A66073D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybVD_Ut3GWQB for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B8E5F6071F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=Mj2OO5w+
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8E5F6071F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:34 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jY3YM3hkqzKqVl;
 Mon, 23 Nov 2026 12:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795433191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDtioNXO1QMAC3EDoTLI3QW8KwvIpiP/m/Yw31u4WcQ=;
 b=Mj2OO5w+6RFKA1iSgEnjWwhOfSEn/dEyTah7NL17BJo9XKxEuc8VuXUq1Ni2N9XYPQnamm
 agytaA0aQfgsBUnjC3SHkRXgXLzGQnXV8ZeXlozD6uNEpo2OOVwjgGMTcQr7pMZVrdcglz
 4fh5ZlAcGuEgSHcjahQ0MuzFKmGbcKaSlKrF3tnWYvCkMjR4x80ihg2Su66k6XHUPYMo9f
 di56Py2KGYaOIQRQmnBqPcAB3KQFYd4FSiXMz7vfZ1Y36fIaBug9Rh1LYdRjohBaSOM2FK
 B1b9eBcgfdR1/JfVq/Fjql4oGREA1/8k3bjKyT14MStohcMtxtRw9BR1BadT8g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 12:26:23 +0100
Subject: [PATCH v4 2/2] arm: mediatek: run board_init_f() with the caches
 on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-std-upstream-mt8188-spl-caches-v4-2-521e424fd1ad@beckhoff.com>
References: <20261123-std-upstream-mt8188-spl-caches-v4-0-521e424fd1ad@beckhoff.com>
In-Reply-To: <20261123-std-upstream-mt8188-spl-caches-v4-0-521e424fd1ad@beckhoff.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795433188; l=3994;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=DIz3yiJEp8VrRG4GpGXfQ5typeQu7MsWTa+LyM89C2U=;
 b=YywFwsR2WJHzMi14VmFvHLwLdZzbKDIspMd4b3h8gASwWU8NpI7io6zAU+xcx6kqRgwq+wF9k
 2JwnTCcfPSaAv5B81xum1SlziwBOTSQU/AeF1dCGxFNjTiXVPKqbDqX
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY3YM3hkqzKqVl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Device tree walks and other setup is very slow without caches, so turn
them on before relocation.

On an MT8370 module, from bootstage marks before each initcall, two
boots each:

  step                            caches off        caches on
  initf_dm                        349.8 / 349.7     4.6 / 4.6 ms
  serial_init                     204.7 / 204.7     3.0 / 3.0 ms
  dram_init                       162.2 / 162.1     2.3 / 2.3 ms
  relocate_code                   22.0 / 22.0       0.4 / 0.4 ms
  board_init_f() to main_loop()   819 / 819         87 / 87 ms

and from the serial console, after power-on (includes 5s debug usb wait):

  U-Boot banner                   7336 / 7335 ms    6772 / 6775 ms

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Tested-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/include/asm/arch-mediatek/misc.h |  1 +
 arch/arm/mach-mediatek/Kconfig            | 10 +++++++++-
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 10 ++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index d21e09358f59..1ddfa61f3af7 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -15,5 +15,6 @@
 #define APSW_VER		0x0c
 
 void mtk_early_enable_dcache(void);
+void mtk_early_disable_dcache(void);
 
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 471622d22318..035b761a7e21 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,6 +221,14 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config MTK_EARLY_DCACHE
+	bool "Enable caches before relocation"
+	depends on ARM64 && !SYS_DCACHE_OFF
+	default y if TARGET_MT8188
+	help
+	  Enable the MMU and caches before relocation, using temporary
+	  page tables.
+
 config SPL_MTK_EARLY_DCACHE
 	bool "Enable caches in SPL"
 	depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
@@ -231,7 +239,7 @@ config SPL_MTK_EARLY_DCACHE
 
 config MTK_EARLY_TLB_ADDR
 	hex "Address of the early page tables"
-	depends on SPL_MTK_EARLY_DCACHE
+	depends on MTK_EARLY_DCACHE || SPL_MTK_EARLY_DCACHE
 	default 0x401f8000 if TARGET_MT8188
 	help
 	  Address of the 32 KiB of page tables used while the early
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 04ede8823b07..57d48fb35d24 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -8,6 +8,7 @@
 #include <init.h>
 #include <wdt.h>
 #include <dm/uclass-internal.h>
+#include <asm/arch/misc.h>
 #include <linux/arm-smccc.h>
 #include <linux/types.h>
 
@@ -17,12 +18,17 @@
 int arch_cpu_init(void)
 {
 	icache_enable();
+	if (CONFIG_IS_ENABLED(MTK_EARLY_DCACHE))
+		mtk_early_enable_dcache();
 
 	return 0;
 }
 
 void enable_caches(void)
 {
+	if (CONFIG_IS_ENABLED(MTK_EARLY_DCACHE))
+		mtk_early_disable_dcache();
+
 	/* Enable D-cache. I-cache is already enabled in start.S */
 	dcache_enable();
 }
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
index 62705529c162..0eff263c266d 100644
--- a/arch/arm/mach-mediatek/early_caches.c
+++ b/arch/arm/mach-mediatek/early_caches.c
@@ -19,3 +19,13 @@ void mtk_early_enable_dcache(void)
 	gd->arch.tlb_size = MTK_EARLY_TLB_SIZE;
 	dcache_enable();
 }
+
+/*
+ * Turn the data cache off and clear tlb_fillptr, so that the next
+ * dcache_enable() sets up the page tables reserved by arch_reserve_mmu()
+ */
+void mtk_early_disable_dcache(void)
+{
+	dcache_disable();
+	gd->arch.tlb_fillptr = 0;
+}

-- 
2.56.1

