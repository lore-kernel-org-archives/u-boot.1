Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EE606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bh/zLnBQ;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Xvqn0wYa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D358A60629;
	Fri, 20 Nov 2026 16:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2R8_QKzyPJY; Fri, 20 Nov 2026 16:30:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 078036074D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192212;
	b=i3P0VfcFApBZQhmTNwM0LngFbJ4EF1vfOv9G7GxoUH3AD92TvOWcbkIYe0ZtC90kpu81
	 22zc3EKSaY6KsE49ORDm2w9jv8JtGt/wqUrmU59C5pL9HXaML1n8wK2cVVOywMx05rPm5
	 9gc6Ggb+jgBWmJlF4dLPbJOeLqFEGj7645AW4OIWLCVxWlZ5TB8aHzv1sZo199vC6KwKN
	 QO4VL6ufXmcO1v/OAEXioCEQCj8u+uohqY0ZfkuNiFEAspa29wzpEv9I67EmcTcT8bdde
	 sFgbEwgbCLn7Ou+IgS0AYwMtBseYZNXWh9RKcm/9NwiXtP2pfFa5Vp67DFqZUK1NQrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O7w3GtN9oSTUbBKSiwnjCkUSazmLghtzyyPKk6HDGRg=;
	b=he6riBLVbEE9HtRZXy9neSWtyzunpPonSPFZ4WCa/nyrtFaizFxF1isZ9duJ4oSHYVib
	 +o08CdlvN8IzGfph5dwZJACA/8WMcDah/KpQezS2bAHk3oT1uLpcvg+nJE+oCc5+UMfPw
	 VX9Gz4NoJqHp1QJ9dNNzLfkAagMksGkcpItDfSHlrSSl68CgUTHaFKcw81nAq0pGErDp8
	 APMTDk78+SqAx+s8oTpMKKUIG10ZInD72sjdv2gKm7Vb+jKzOlSDYkLEtI1zq4BgiKLja
	 +mz3Uq7Beuc7UAdxVxdksfIqdo++2ABBqni6Fc8D+k9tcFj4kSorEYnYsc7RfIYTrOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Xvqn0wYa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795192212;
	bh=O7w3GtN9oSTUbBKSiwnjCkUSazmLghtzyyPKk6HDGRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bh/zLnBQUIAgu/f6YwasB9AoFwdfiZJI4gj/adLCu5SzocGs8b15FflaA7QxhDdno
	 M4X//EWnaIz1u4h//wRA6vOXKhWFTHxcW5V0MHH/9ZYK2HvcnsWBi68470ct3LbW9f
	 xT1edq5WlG62dXka4E0PoGWBMY3y2tW5seH5bGELXJRMpbY0S2p+G1ieqhHOURVSgo
	 4tb6py/fjF8PJTBegwAWuCcg0/9WWxSTsowOMMn9lL/Ta1195o8s0HPhnb+JGXcoKB
	 1pgphgpCpLCQrlz8mmcZiX+6CQ4Eg+qdUEMRfAW/QqB8HtdT3tR+IYyyVQkoJQhDuG
	 y4e3r57ykKxYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 078036074D;
	Fri, 20 Nov 2026 16:30:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 304691E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 227BF6071D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chhv-TGou-fx for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEF286074D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=Xvqn0wYa
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEF286074D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWLR02Rbsz8vSC;
 Fri, 20 Nov 2026 17:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795192204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7w3GtN9oSTUbBKSiwnjCkUSazmLghtzyyPKk6HDGRg=;
 b=Xvqn0wYaoUBuTf6Cs/9lgjdeeqRDpAcw4qigSUMC/GodXs/j/ENY3U+UCqMZRH97P9miFT
 x6UlrCtoZwAG2eR848MgkOOuRGyQbAmch0cr6kbNFSjUpT57RlkGdiPxYZN42n7+4dkxBO
 MgkPrDUAsSdpbpcXGhbXzvRTwpqTIq2M9vfsINYQpPgyVJGMhnjBsXjjPAUEJRWfy/jXaJ
 w0T9cgjLB/cFQXzY3/KyMohlo5DcpbD8cXmtHH+1yTcwBOpU3tAFeDjQY6iFCs4M3b6xaf
 pQhiBrafKGsRpv86PNT3FjBrPTp8KE1QTobZErXhg/YxZlJQiETm05lRy2F5Nw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Fri, 20 Nov 2026 17:29:19 +0100
Subject: [PATCH v3 2/2] arm: mediatek: run board_init_f() with the caches
 on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-std-upstream-mt8188-spl-caches-v3-2-b5ab70d56006@beckhoff.com>
References: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
In-Reply-To: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795192198; l=3892;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=oHjZfqVJ4mpSbU6NsAh8USo9hC+9Ot6BIvJNnxCbFL0=;
 b=107q8MvCk8ZKwt+4bzzBXH7vfwEv79nZFgKH86ZYsb2gv8ICBE7nrKg3CUw+m1p+FxARHYraa
 SmR6jXk3SXPCpAkzru0Q05p8PS0tZ2gRD61PfWaFnXaE8mLCLIqOUcr
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jWLR02Rbsz8vSC
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---
 arch/arm/include/asm/arch-mediatek/misc.h |  1 +
 arch/arm/mach-mediatek/Kconfig            | 10 +++++++++-
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 10 ++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index dd248d222b97..517fbe7842ff 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -15,5 +15,6 @@
 #define APSW_VER		0x0c
 
 void mtk_early_enable_caches(void);
+void mtk_early_disable_caches(void);
 
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 9e36b2a2c82d..a91422de95d2 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,6 +221,14 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config MTK_EARLY_CACHES
+	bool "Enable caches before relocation"
+	depends on ARM64 && !SYS_DCACHE_OFF
+	default y if TARGET_MT8188
+	help
+	  Enable the MMU and caches before relocation, using temporary
+	  page tables.
+
 config SPL_MTK_EARLY_CACHES
 	bool "Enable caches in SPL"
 	depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
@@ -231,7 +239,7 @@ config SPL_MTK_EARLY_CACHES
 
 config MTK_EARLY_TLB_ADDR
 	hex "Address of the early page tables"
-	depends on SPL_MTK_EARLY_CACHES
+	depends on MTK_EARLY_CACHES || SPL_MTK_EARLY_CACHES
 	default 0x401f8000 if TARGET_MT8188
 	help
 	  Address of the 32 KiB of page tables used while the early
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 04ede8823b07..c69a46dd0284 100644
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
+	if (CONFIG_IS_ENABLED(MTK_EARLY_CACHES))
+		mtk_early_enable_caches();
 
 	return 0;
 }
 
 void enable_caches(void)
 {
+	if (CONFIG_IS_ENABLED(MTK_EARLY_CACHES))
+		mtk_early_disable_caches();
+
 	/* Enable D-cache. I-cache is already enabled in start.S */
 	dcache_enable();
 }
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
index 003393d2f681..f4489cb8ba26 100644
--- a/arch/arm/mach-mediatek/early_caches.c
+++ b/arch/arm/mach-mediatek/early_caches.c
@@ -19,3 +19,13 @@ void mtk_early_enable_caches(void)
 	gd->arch.tlb_size = EARLY_TLB_SIZE;
 	dcache_enable();
 }
+
+/*
+ * Turn the data cache off and clear tlb_fillptr, so that the next
+ * dcache_enable() sets up the page tables reserved by arch_reserve_mmu()
+ */
+void mtk_early_disable_caches(void)
+{
+	dcache_disable();
+	gd->arch.tlb_fillptr = 0;
+}

-- 
2.56.1

