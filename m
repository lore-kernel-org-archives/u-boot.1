Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253D606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kx7UQZXI;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=kkvtnZQr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED6DB607BC;
	Mon,  9 Nov 2026 15:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBnvdWizw7uV; Mon,  9 Nov 2026 15:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCA69607CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794237287;
	b=MulbX0F7Gn8jnCr/tpZmNniwoO2m3b4ePwX005ISE5uMEcEv/9OjB1kt5wYy5NNWMVYE
	 oGgiBNZ6BXNE35ac7hWfWQ/dR2vZ15gb41Ag70XsfqtK4pc+mBkXjlRL6FVG72ZAkdrkW
	 uUki6fmDvmXSYuCDchRNBSR2wcpXJz7JwgUwhv31sf17cJ3gum/x1hyL6By0CHFX0arHz
	 LhQhl4qwBNrBhQd6yKBpwdU7iIqwel3vCCAStjRsJL6eFAg1+ixySmRnzlgatV6HrsIR+
	 D7Rm+uERTISUKg5yuuCxTFEsOKNLREJq/W3be80HAxaoPBDaN8irP9kmWjnsr2Dbe/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794237287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aQumxZZfy38RFu+o7Svtu/biE2FGcwtA05h1/UuyWaE=;
	b=fCjxlKHMhWofgJYeTOhzfRVjRyG2rMR5UbvR9L8j9ToOGWUZcMdXeiN0O0EBK3uwTxdQ
	 wUDehTq9nr7eXV/Q3LgT4C/cp1A3Ou6Vqf+ZkX7WX+fqFbbSolfmLZVmdeIU+NZa7h3ZW
	 mnF1CT6f1XzSS2il8o15AKcw7KztDF2d5935NRIK9RiWJm9gElOUgmxMFXY1qLAI4mxZ2
	 pH+q2A5Yd4xypeK/VTDtRVRq40+hemVIHTpbE2Km0EwHXuEPDneyoaBapuLtuIRHFpe3W
	 vz4rkprqO+xgrTU9S520D2Xiybh6YsMlgAXCs3JIMfgJg6IwrNl3ojyg2EIG2Ob7NDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=kkvtnZQr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794237287;
	bh=aQumxZZfy38RFu+o7Svtu/biE2FGcwtA05h1/UuyWaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kx7UQZXII6jLXUWbJWlwkKCgj3HOiigU2jln6V1MZjQ+czuptj99NZyLtS6YiRh5D
	 56wgcl3p833f8cxhoaeAVkJAc5A8RUuUEaDj31FeTK/WieZugipJTft8sXRB4E/Nyc
	 e7XAjOYBIOfTNkV+U2/kZnrBsen+urnhIh2i55dQDHAynKx/Yxf+24tLu6STYEtelr
	 3qDIhAk9+5AZNRk2WeCXJEmzQlJa2WxfLtxtBky18c815B1TC3QdQ/fZ0CxZ3fSD+/
	 m4qemtPN0Y7CxC0OHUSrRo+yOTU24BuECfj4IVgaV4s65p8tVOV5T2yZxK/utVjJIn
	 WrnfSW+lMkHDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA69607CA;
	Mon,  9 Nov 2026 15:14:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C8F44B8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 493EA607C9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vIHnEiSLhxw for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:14:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FC1960703
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=kkvtnZQr
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FC1960703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:42 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jNYH26Kn0zKmw6;
 Mon, 09 Nov 2026 16:14:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1794237278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQumxZZfy38RFu+o7Svtu/biE2FGcwtA05h1/UuyWaE=;
 b=kkvtnZQr4ykX5Z8W8bgqPBq3ZNEIrT1ipq9Q+p10MnrWMQv+TX0xPqD9Nj0nfG4haSHpps
 nn2qsyiDI5urDRN4WuF8KGfvsYyh5SHvAsYramtwc1Wvf/q/mmTeXD6P23FXM73Vwsanfl
 scW5mxII8ZCX+tTqSlPQpfSBl3xTI4bkL4egi7lLMeMgRwcpFhoeseceesRDElzWlSSvdW
 UsZusCNZ86LvExoai+oqREHHH6qECxhPibKtN2CdTSLQKvYym70XEcra2CdPjNTv+olgR0
 5UD9vb1+q7bHk1ZFsuKvRN9saadWjezPOf5TGULefbyzSda7CtSb4uinBF57qg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 09 Nov 2026 16:13:08 +0100
Subject: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794237275; l=3492;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=9wq+a/+Ym5p434q8nGhxSehJcupQvjomzwpfBr4H/K8=;
 b=EmB9ouQ8t6t5k81yG7Ermq3VPObwGhBYgRNIl757hf3G1OVaj6UpRhmjushJhclCPE3Dd/VR4
 X3M7DDpdEYCCAxDk5Xdj6PjfY7jp8BdPhJ90Wi+qrLQkdmp+zOXVWd7
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jNYH26Kn0zKmw6
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

Running through spl without the dcache is very slow, especially when
hashing or checking signatures.

Time from the SPL banner to entering BL31 on an MT8370 module loading a
2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:

  FIT                    caches off            caches on
  unsigned               848.3 / 848.6 ms      95.7 / 118.8 ms
  RSA-3072 signature     1903.6 / 1903.0 ms    128.3 / 143.3 ms

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 arch/arm/include/asm/arch-mediatek/misc.h |  2 ++
 arch/arm/mach-mediatek/Makefile           |  3 +++
 arch/arm/mach-mediatek/early_caches.c     | 23 +++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index 2530e78a5f11..dd248d222b97 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -14,4 +14,6 @@
 #define APHW_VER		0x08
 #define APSW_VER		0x0c
 
+void mtk_early_enable_caches(void);
+
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 661fc0b88d90..67b55745a917 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -5,6 +5,9 @@ obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
+ifndef CONFIG_$(PHASE_)SYS_DCACHE_OFF
+obj-$(CONFIG_ARM64) += early_caches.o
+endif
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
new file mode 100644
index 000000000000..1b1e4855d9b5
--- /dev/null
+++ b/arch/arm/mach-mediatek/early_caches.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MMU and caches before U-Boot sets up its final page tables
+ */
+
+#include <cpu_func.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <asm/arch/misc.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define EARLY_TLB_SIZE	SZ_32K
+
+static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_4K);
+
+void mtk_early_enable_caches(void)
+{
+	gd->arch.tlb_addr = (unsigned long)&early_tlb;
+	gd->arch.tlb_size = EARLY_TLB_SIZE;
+	dcache_enable();
+}
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 125ebcd784fe..b3bd92955d92 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -5,9 +5,11 @@
  */
 
 #include <clk.h>
+#include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/arch/misc.h>
 
 __weak int mtk_soc_early_init(void)
 {
@@ -18,6 +20,12 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		/* SPL skips arch_cpu_init(), which enables the I-cache */
+		icache_enable();
+		mtk_early_enable_caches();
+	}
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
@@ -31,6 +39,12 @@ void board_init_f(ulong dummy)
 		hang();
 }
 
+void spl_board_prepare_for_boot(void)
+{
+	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		cleanup_before_linux();
+}
+
 u32 spl_boot_device(void)
 {
 	if (CONFIG_IS_ENABLED(SPI))

-- 
2.56.0

