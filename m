Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449B7C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FE1B60905;
	Fri,  7 Aug 2026 16:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7kqqrQI0lAQ; Fri,  7 Aug 2026 16:13:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10EB3607E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119217;
	bh=39zy6Yjrov7NZ+4lgNH6WrVrHtNBtAqhmc90cLqBWf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZM/QLIJU5x7HhTyRTQgpj+GzQZVtKs360IT2/0Rhyr/65yDYmMFKoY+ogpMsJrAEL
	 R/1SppjNQ7mHk8McbYxdlFzMBs+lKr/HwMzL6NV4vEKblWY5xUO7LLFLdW7Xr0AjDB
	 DVbgUY8Nv6d4DN+KrwEuBqGIYXDkpHlsoMJI6+ZbNqdnuf6A58SBXGcLWD4lrkR6LQ
	 X/lk5hkt9nfPOqfNkgCAsedyS6c8Qb5+sA/S2vhcYRkNfSc2ZJsAI3PBbSVc+wWwiJ
	 /+fNF6QjkrITWk4vnC72WvoWGsHZUlwMvtaDRU/o6wyC5XVYMQohjtVqu6BFtQiJ7K
	 yC7NdCxd5eFbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10EB3607E6;
	Fri,  7 Aug 2026 16:13:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65536D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62FDC607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbGDuV7lR-yy for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DD6960684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DD6960684
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD6960684
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:32 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso2306519a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119211; x=1786724011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=39zy6Yjrov7NZ+4lgNH6WrVrHtNBtAqhmc90cLqBWf0=;
 b=izAeLwOCuJBOB9aLhbJ5Yna/7aQarZDIYKvK8caBuypXSzj2AkI51Gk+iaFuRUhQRG
 xrb6rUYQXMNqCJ15RW7PqghXeMuGxZCg7RYjvrCLexozLy7EYwBo/hRaM4rI06f1LQqg
 TfEDJvpKCf6kL+WuufeH5LkSZV/thPpMwantFmpvHdlKNpKYqD10J/Y8CaGMhzw/CnfI
 GDTkmX4uvAHpdPf8xz4cysIwplKVT7FVUjh7zbdT1TNxIEzOTxvLuZwhjyxJ464i8rFR
 MOhURfyPD0OuqjUQbfUAk5DlG5HsqiJzg1nvH6RcTXgCLe7/EhOvZJTphMjBBy63Mxzq
 qa0w==
X-Gm-Message-State: AOJu0Ywepjq4/evJo6BVLm9Xc2nZvTjHE4EUCn476cKVvDLjeusEhLCP
 PaA7X8YoQWvoIlnOpRgByscKSLkV5PmoToTpB2tu/xW2P3Uw0KnJ55LsjhS3bON5ZUUBk4SNf/k
 UkgosuNA=
X-Gm-Gg: AR+sD115xsO7LDvQrXsDVSlRcPIj8roO3SX7p7nLvVqJm34Qq8Z3CtmvaV4yfRphEcT
 pAmDqDuxkdLvr5rzUyc7LAvwE/V+8SSEFtSwqD5rLd2Vb+5jNpVbsDb+b/35RlKeHgYQwq/uY0r
 beL0tEDZiHvWbz7AatLh54snQ7xw3Eh/ZXjGEeswdkcSJGCk6YGSbfpVsgYkrlq0JcanEMk7QPn
 eiTDsMet2Qf4I6f5KYlA7P8kdZjZYx4qyP2M1nJfJm4UIGE+db25FhS6rNTOpCgBbM8tAN6pBjG
 euflL1rRG/wiZ6px8YzjLeS/+tUCv5f8Fst83AeAPFKexBhCtVe/23Q1BT0lbaUI0On0UsXv2tS
 YM69OTS1uX1Gvorgl7ZqVlVhir52JpsCBD+L5zItddF0/cczJik9jD7M2b7g6q3uE5nocWq9gkz
 UhWNEGLealvuAz8v74Ewc2BoPhpeidhep4OpSVL7Mk/b42Am77dF1aSSbTWcj11pz/
X-Received: by 2002:a05:6830:6d26:b0:7ee:36e8:d0ba with SMTP id
 46e09a7af769-7f1e5e8afe8mr15254390a34.11.1786119210977; 
 Fri, 07 Aug 2026 09:13:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7b9678sm1537878a34.21.2026.08.07.09.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:13:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:12:52 -0500
Subject: [PATCH v2 2/4] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-genio-360-bringup-v2-2-7c3830297d97@baylibre.com>
References: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
In-Reply-To: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6339; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fzbSu59nsI1wT3BTNW5RJouEPr7SqQem7h5MEh3dYD0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgQUrdnbXBQyEvLcsTFmOQjZKT6wxKT0fIOSw
 TezEuDgvwKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYEFBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHzQH/30oRu774es7spk/0ssuQkroWJ+MD+pwmkTf+m9
 XqzULJrQmZ12U1BvEiI22zCjtuktgMZEfxbIOiT2+EExmCC73iTOdhP4/B+LHvmUqUCD57lnMKK
 3k+xl96TcuD/8JLGPEnpXgQUuURY26RrJTcARTa59FFBapLu1T7PpBdj5fSnUNtspuM0n+3m+ny
 a89ej+L7zcQ3R32c8G+TYMXYWFrgD3hyRAFBZPyYoanxs5esZ3BSdjXaJ8bwj+nFM4MTkZn12Hf
 V4erTUKSBetwiUc8AIkGU49gv1ux9RpgfNcapDrlFjygD15y2TS6NGjLH2PH7qIYT5Ts4GbfPZs
 Enys=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786119211; x=1786724011;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39zy6Yjrov7NZ+4lgNH6WrVrHtNBtAqhmc90cLqBWf0=;
 b=NeNmhC80Q/VaHTbt9EvKAUXJX/gGizCsO67CU8CT0/BM7Dxjt093n6PgHBmcg3Pgu+
 CB06n16ctLNlE06I4ADnY6MvRiIOfmB25ufsi16onxSAzfZ6Kvi9gy54gVqeRnKeRpwR
 eGi/kcEiFo3hZFDCP4M89/m48m/xfusMJrhlzmFiMA/ljOzh4ilkwU8MK5P99nJufBUI
 qt7B/JxsxehKRLMf49+upT9xLlsp8kwZvFWS1Bdr9GAo2uxEH1jwBwujHj+zlSNvi6iZ
 O/xGyFd2Jf7in76/IN5kBLLsE1Tx/i3JLqZdlyLHqv/hc2e/JpPgT9nWKf1QAiqP7emb
 UFjA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NeNmhC80
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Chris Chen <chris-qj.chen@mediatek.com>

Add basic support for the MT8366 application processor including init
Kconfig target.

Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8366.dtsi               | 11 +++++--
 arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/cpu.c           |  3 +-
 arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/mt8366.dtsi b/arch/arm/dts/mt8366.dtsi
index dec3315ee3d..313c6a3707b 100644
--- a/arch/arm/dts/mt8366.dtsi
+++ b/arch/arm/dts/mt8366.dtsi
@@ -483,13 +483,18 @@
 			      <0 0x11e20000 0 0x1000>,
 			      <0 0x11ea0000 0 0x1000>,
 			      <0 0x11f10000 0 0x1000>,
-			      <0 0x11f20000 0 0x1000>;
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
 			reg-names = "gpio", "iocfg_rm", "iocfg_bm",
 				    "iocfg_lb", "iocfg_tr", "iocfg_lt",
-				    "iocfg_tl";
+				    "iocfg_tl", "eint";
 
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 172>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
 		};
 
 		ssusb: usb@11201000 {
@@ -657,7 +662,7 @@
 		};
 
 		snor: spi@11018000 {
-			compatible = "mediatek,mt8366-nor";
+			compatible = "mediatek,mt8366-nor", "mediatek,mt8186-nor";
 			reg = <0 0x11018000 0 0x1000>;
 			clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>,
 				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH>,
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 05ba7c209bc..6897ef66389 100644
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
 
 config MTK_BOOT_IMAGES
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

