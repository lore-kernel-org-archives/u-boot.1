Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0005CC61DC4
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31D3E60712;
	Tue, 25 Aug 2026 23:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7g9eBWvsuxz; Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787700754;
	bh=zOiAHuuAe5KIpej+2Xo5TsL8i9oXMuCH3g3fJuntMFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbsfY/8aezI1pm5C10dF5jWbwlqNawaglL4vSkXIWRGE7UFbCzLUalgniMD/CkT+r
	 2qQeavNq7Li9Ksyg8KaBJtzQ2W12NQRllcjMLpuZNJxzdvZ86rimFS+I9aghnFB2Bv
	 pgDw4UU40SP61SEIXsKeI4+e2E4SlDhVpJv64/kQoJNRElLNzbwYvCr8nbKOCuoXJV
	 gW/iwl+jknd+/E3SkysUAxG4AFDA/s++00muftQWaoc/l/FiUWi8AHViEea0N5IMN9
	 wDYvUqi9hj5qAyWLhU1E26TF50gBUUnKPl+/QGre23ykbD0VFMk6tvszbJ0veCzmIn
	 5Zvvm7XFzL8Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F197605F9;
	Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9259B396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 789F1605F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQnqdk9GA_lo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:32:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bCmiX2Vg
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C00A605F8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:30 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b21f09ec76so411120b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787700749; x=1788305549;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zOiAHuuAe5KIpej+2Xo5TsL8i9oXMuCH3g3fJuntMFs=;
 b=bCmiX2VgjnmTUscLPQ89rH7Vo6QYf0nIO2NsxwLxOYbTJQoFstHieI0qCwK9AVL1N5
 AynfnuFwexnrGREegvaA+bcUPPdLxWs2iFTyB2B2S/BPmE8R8K0XAGNQXrNmHghDJ8yX
 d9l3N8IvReW9lNjYcbCjPsi8qICbSVwCs0sQcobuL64fOr2+gKBOdXdoOLtU2jiXaLgE
 RUjgybu9zNIfAzmHBSuGF1EmDUaIMIL4h5wu6IQqQJAENW9uUDFMwWr2XPgOqcGaAeP5
 4kNhFg24LzKRTQQsuVMgSBdU8p/r6IPx8sHwhF1MAnryyry7HW9jGdgR+ladhYkCiBJ9
 tmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787700749; x=1788305549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zOiAHuuAe5KIpej+2Xo5TsL8i9oXMuCH3g3fJuntMFs=;
 b=AY8MQPCNjOJQx2FRqY/3iusSqtK1LO6nkk7ukGNnw/tPhKlkaCPmWfsq7XZN0RPILk
 4cRe/R3Yxa6/NoCnoj6LyXJ09NtJ5V/RW9TGco8YzIeZv2J1qc4BkCxXf/+2bOOFjGZc
 dqu7QQAPVr6sFyiJuTLwy/ItjPe4zpYNy+Guq/wkQOAalYNFy7wjRJBf5P/9lJ/CMg0W
 mS9h/kzy9LqGZU5jrw2Tw6u3Rv2LcJc0lRxInnb3jgFlm3wZza906OnO1ZmTdco5yaDD
 61k02emH8qMewEl6xPcs4mlQnpV51VC3NJfuKqm4FzOHexbCm+7NPegH1Rf+zuphnCAm
 vlqg==
X-Gm-Message-State: AFuF++n9Ej/5pAwPQyeSYyeiWSfQSPsIFXNbuA65GbnEr04WrRtqGCqG
 aXdF+ArSa3DACKR8uAQWkMIK3YlO2nzcFRIKAxvvP/Pe83LhtOvhPuWw1aqGeWq5niSWQsM2kkE
 ShJB4vLU=
X-Gm-Gg: AR+sD13+aJbTaH9Uucf53wtrAopOdHQRa9ZwVm4vqIDwOT2214UvSwkxiXIhRXcuP5a
 or9kF/Ct4SA9rxg3tTWZVXunwN9xlXGjXfHqm231kTaJ2+9xxsghOAu9uGdHWqTcZ1NXYy6qsZ4
 PCTA3Tis3jfeD2s3jr8jmXvqGvZvagBwIUFasBjfpUtYXbpya/SR5Wq8p2Gmy6C81foV4kgLXJn
 EVmvE72BqQipBOxHH2kjOkBCN6/qSfjRqwdMSZPdlG3wINsU1ZebxVH8NkTaCe/q1pu8d71GNTb
 rbwuWdpdpDmJUqEwmMUzG/fNVvU6vMcx+EezxolVtFGjnozWQmWfaLFZyBjGbKgo9cyzmNZp4Sp
 IR+tUmvZGviIorHHZL+3eTSA3FBJgecCY9cygJaFOxWHYF6nyVK5fb1wftBdWV1IlG4Elsx3dU0
 zxPbJeJUDZa6c62cYvfE4dvY+GhckW0Q8njfLQiOstudo25/N8KoXac0axGZByOyms
X-Received: by 2002:a05:6808:c1f4:b0:49a:8f0d:cdd2 with SMTP id
 5614622812f47-4b366885586mr3429133b6e.5.1787700749195; 
 Tue, 25 Aug 2026 16:32:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab734ddsm238211b6e.14.2026.08.25.16.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:32:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 25 Aug 2026 18:31:47 -0500
Subject: [PATCH v3 2/4] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mtk-genio-360-bringup-v3-2-8e79e93882ad@baylibre.com>
References: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
In-Reply-To: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5203; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=J+UOyhLt4kwLFDUY9rOOkNcTOdxpmN4cg7JpwZB9ssc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjiXywpqP4VGIvLITmZfi1KvH41yXzJFgEp/Md
 GWd6kSd8wWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCao4l8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5lEH/1iktI0VV1uZ3gwlgHvhWCmlgxnhJSgDU6of0ql
 fXM/p+bnlkDpj0yD0sPAuw/HclqTDK1L4MFMSPX15QVnhbPNUBhu7b1TYbos3rmNppbPbG4cNNC
 ttC4GqiPExMXotBqqZxfPm8lqYTXE/behEv+gyNDb+p+ZWBlrT4edpCBxANnvra2qYD6oaUqxa7
 /3OUMPIBASq8aLoHG2Svyh2ADOqJDu9FZopuFhEsHuSvUE3fBKKGoFHuTY6KihTrUK9nS6xNsqb
 Npt53gxAEthe4l7hv+i9Z4fo5aVjLh0sVDzZV2fQuNne8qzVNLE0Ld9EOJYGQqEb0DAHSLecUnT
 Wb7I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris Chen <chris-qj.chen@mediatek.com>

Add basic support for the MT8366 application processor including init
Kconfig target.

Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/cpu.c           |  3 +-
 arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index eb8d072e686..3a4a80b8a40 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -119,6 +119,15 @@ config TARGET_MT8365
 	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8366
+	bool "MediaTek MT8366 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8366 is a ARM64-based SoC with a single-core Cortex-A76 and
+	  a five-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  options.
+
 config TARGET_MT8512
 	bool "MediaTek MT8512 SoC"
 	select ARM64
@@ -159,6 +168,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
 	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
+	default 0x100000000 if TARGET_MT8366
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
@@ -207,7 +217,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_GENIO_BOOT_IMAGES
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..51bf5789bb5 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_TARGET_MT8188) += mt8188/
 obj-$(CONFIG_TARGET_MT8189) += mt8189/
 obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
+obj-$(CONFIG_TARGET_MT8366) += mt8366/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
 obj-$(CONFIG_TARGET_MT8518) += mt8518/
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 56a41e42df6..04ede8823b0 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -39,7 +39,8 @@ void enable_caches(void)
 u32 mediatek_sip_part_name(void)
 {
 	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
-	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
+	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365) ||
+	    CONFIG_IS_ENABLED(TARGET_MT8366)) {
 		struct arm_smccc_res res __maybe_unused;
 
 		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &res);
diff --git a/arch/arm/mach-mediatek/mt8366/Makefile b/arch/arm/mach-mediatek/mt8366/Makefile
new file mode 100644
index 00000000000..661744a4398
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8366/init.c b/arch/arm/mach-mediatek/mt8366/init.c
new file mode 100644
index 00000000000..13123be068e
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Baylibre, SAS
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <wdt.h>
+
+#include "../cpu.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
+	 */
+	return min(gd->ram_top, SZ_4G);
+}
+
+void reset_cpu(void)
+{
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
+		psci_system_reset();
+	} else {
+		struct udevice *wdt;
+
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 part = mediatek_sip_part_name();
+
+	if (part)
+		printf("CPU:   MediaTek MT%.4x\n", part);
+	else
+		printf("CPU:   MediaTek MT8366 series\n");
+
+	return 0;
+}

-- 
2.43.0

