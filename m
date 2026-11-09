Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4A606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=weMMBlvQ;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=TvQ/TBcU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3162A60810;
	Mon,  9 Nov 2026 15:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWm1vUKA82B6; Mon,  9 Nov 2026 15:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F53607FE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794237290;
	b=BVq0DhiPaogveMqf8tePYCmor8h+H7laBbRNDV2+FCflymXSrWZ+A99eoer1dNBdK7YY
	 KcjzLde0qLvHmbHUgJzzamndgSOKrSJ8iThyw1kVkP3jAqwyFmaWajE1Eyn0lQzClsq0p
	 lfd02hMqDHg1mWHGp6LoHmmxM4E532IG0rZ1oVEJ/Pf1vEy7gBEe/t0+VR+gJyQA0R7xM
	 E4wb6hKyKeERw8g+nWkCWqaqMoA24Ya/I8MnTDD+nBk9zZO/3ksC5TX6CoDzoGfJkwhwi
	 raZKqsaTtEc6x4OGEwCuGhHlZydrsP8Qo2XpxLB95Ae3xf5C2Ead38sDlwj1qv0Yl8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794237290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8SOa2ud0bK42rJK8/i9jPLVsmKSiFv1+GUmq1M8n9qc=;
	b=NKQwszxc+nPXnPM99LmKJ40ExpeJAd9juJtaMljSgxs2r//l7CKyGmh1M+DPk8LkzBDr
	 Ffi4bmtJf8G9AyWUBYKsoknzNZ4rq/6nobJsB9auyQ3JQzpsKQAW43ABaMbqYT05Ycc7c
	 /a7EOSW/MOCzZQAo9K7mFhhSYhlC7ZFSoV3k9sm9/6tBrYWUjprPCIU4sWHYOfU0FGZ8T
	 HlQKqY89NZUo00YEWtTQG9VL6HchX/r2JCLn2ZL9QB62IGUoeR3w2WFo3uP+5/oOsDw4U
	 TbckabixCyQyryHISFaKWDvPdzdyeSCLE5//TiBBqqVL9xDc5WdJPznpa6Dg/xEnWyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794237290;
	bh=8SOa2ud0bK42rJK8/i9jPLVsmKSiFv1+GUmq1M8n9qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=weMMBlvQjHquS6IXwSP1sviVwJMmQ1YfPQNVStN8lHuxhwITWeok7iU6+4qa9mC+p
	 WVMkvK+f6sdokDMEiV+LDy7i+LE7tTp6k9NSdMlD41KUagNW7mi9Z3Uz79HSM/yYq7
	 bPPHX58NLu8ZJukUIrjeG5esMfDEyrl5uIRa/ImhisUOa7HTwz6Wv8Om+uPawLkJ+Y
	 05iOKdvFH7PiVYuHvDjcZRBuCojuxVwj7+KVgs7G4lu4igxjMRjQaYXkQ8t5jyKKm9
	 utyEdmbwuWtb5LCRbLmn7qSnLf9TjMNdVifi85W7TZNnDj4xMIIcZwoH7rWMcONVfF
	 bxDxw3HbbzM6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38F53607FE;
	Mon,  9 Nov 2026 15:14:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC432235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1FB280F8D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNH2yVFWKz5p for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3AB080F5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=TvQ/TBcU
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3AB080F5C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:43 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNYH41xF5zMldw;
 Mon, 09 Nov 2026 16:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1794237280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SOa2ud0bK42rJK8/i9jPLVsmKSiFv1+GUmq1M8n9qc=;
 b=TvQ/TBcUs96LgQNneBIr2eb7V1wiicOztedCK33KMioqHJsBZzLgFRmglJZJvQzVCsa8ul
 d5hWTEEZuN/Kii+LOQqV8nRYAdCTHhMV+guQvI633SWVA/YdGKY6xQQQVNfxRkp+8sQ3YL
 DWo7Ejm+eklV42RadvNCP0py20i/T4AqcOxQz3BaG4uM5VYqIAYkGTaBz6RXw33PkqTwm1
 zko8IoVKYLFq5EmdCJ+/oKtu0zZUMmF8WHlyRtV/W1IUaGN22rF6wvpHdh8/gt+Wws0+t2
 a7wuWyjEHh7/ajvxQVpijsJN6t2bjhkrxXQ4pvwekSf9udJxg6rNq/Hbn/VE2g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 09 Nov 2026 16:13:09 +0100
Subject: [PATCH v2 2/2] arm: mediatek: run board_init_f() with the caches
 on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-std-upstream-mt8188-spl-caches-v2-2-78cfb3e90c55@beckhoff.com>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
In-Reply-To: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
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
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794237275; l=2797;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=6D6/wCCIOg1/45KmQzmTYn85DZnsgLppgF0TPdYqqbA=;
 b=0ZXfWd+h94bkks05Oc8AIbemJGt8Ycmm21x0EYgIqQ8v9b23YKCVggdC8fve84/zAM1NmoERc
 nodMtDm7jTEARLtPHbp6H4Ft/8TupGg6fkMAwVGheN8vNQUMe5pUPlh
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jNYH41xF5zMldw
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
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index dd248d222b97..517fbe7842ff 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -15,5 +15,6 @@
 #define APSW_VER		0x0c
 
 void mtk_early_enable_caches(void);
+void mtk_early_disable_caches(void);
 
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 04ede8823b07..4d7c8bc10ccb 100644
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
+	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		mtk_early_enable_caches();
 
 	return 0;
 }
 
 void enable_caches(void)
 {
+	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		mtk_early_disable_caches();
+
 	/* Enable D-cache. I-cache is already enabled in start.S */
 	dcache_enable();
 }
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
index 1b1e4855d9b5..aa716370d0f2 100644
--- a/arch/arm/mach-mediatek/early_caches.c
+++ b/arch/arm/mach-mediatek/early_caches.c
@@ -21,3 +21,13 @@ void mtk_early_enable_caches(void)
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
2.56.0

