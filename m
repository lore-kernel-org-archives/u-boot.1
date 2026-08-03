Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37885C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B4440669;
	Mon,  3 Aug 2026 23:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AViVeJFvPmAt; Mon,  3 Aug 2026 23:21:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 216D64065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799301;
	bh=EpNSLUlturFzAw8snWK8eUFqJ8kqfiHBK24+0esL7hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LjWXRYqLo4sb6mfkya45Pv0xzEo0dbM0trwQrYCNyUx/Zw80/imNp1c+7hk2+JK3Y
	 amuiSPbwY6uWMwPYR0PPlv3nCb6uNdEvAgbzYVsarfZeTDFYy1zW7mQga9euj5jPyM
	 LaDdhXt8tyiJg3JpsYHbeVsZHq4B1pALp5l65hF8kVfJMkBaZh3cExWK9aq8fYIR8E
	 E3/0dl0yXkODn+0B161ddT0Cja/Svg2CxF9MRU4Bayq+K+Ix9PXXmNt7KDDinizQ5D
	 5s1UCn5y7duxe9oJUQ8A56HPY0XH1IXju0dRiQpsgpYcxpvFlPFlMN7vIY9th+Jf7s
	 DEjdFd5aGTfsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 216D64065E;
	Mon,  3 Aug 2026 23:21:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66BA7282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5516380C0C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDFZyyREe2zZ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C4ABA80B92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4ABA80B92
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4ABA80B92
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:37 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-456395f4e7bso2796278fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799296; x=1786404096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpNSLUlturFzAw8snWK8eUFqJ8kqfiHBK24+0esL7hg=;
 b=O558iPC2HYesJZ9Z8geH45DaYjXIzocHyhC4K1rsiZ8isWINdh8SLQKMd4QCCAJVl/
 Djp+R0aOxwGfaee+w1Qo6UiQ7ZbeG52H/6qk0ok4x5xv9efaK2NasbnXauh9EsN2q8zU
 onq1Y3mrcAxQY0LJ3UlGJNhT2iX1QyRZp7LYp1KlFDfo8vF1kQ2y0PnF8+5gELGsRigq
 tTSfaUFH5Pzouap5Hodu3k7OmAkdauDHiwyrcmJRopFbgE0aQQwqprRFJHdy9aCYbny3
 ifHnUarhS9tQFCPXkDDljx3L1BbMFxDhj0cQBNLlF+o3GKnVyVKy8MtUSYLFRxoLfYTX
 VqNw==
X-Gm-Message-State: AOJu0Yxt/CVVxfXR+H2eooXptHDiRRcp9ej5DDJgl8tPtafbHQEgIofu
 9TmygIc/CAmCZPSDPMTB8dPBx3VI7eHJK0AMRzohWxpDkWXVyBDcG7KjN0aCXrZ3A4s=
X-Gm-Gg: AR+sD12ynAaLTkjsli+Ek6E4i1fPofbOyUq/1HvxZAvwaRwsVeFRpFZkTUVZTzaogXV
 jKjJUvjunViG3svrOyyJPGdTi7Urf12EvHzwVeiE/tLb8Pkllmgo4R+WCVjzKFu36WTzU+Xvytz
 t+b6iISCCapW7sTonQZrjAzaDx5FrGp3jqGmkbZpFY2USeAkFooipTTTttwx73G/VMVo0L7Mpw1
 1o3lxTQiSdWLGdd2bmuVK8JQ8kIj5CeaeU1rsWmeZj2zkGoP6ky7lUeYKEzewDBQpynyRDMdfvA
 /zY9dS5nnfyAtSu9ifZYPo+jZ4xc9zpaQUolSr/5P4CtxF5AhiahoEtlT+hC0Vtv66jLwuUZJ2u
 3X8iLu5KQ+lS6YfKUdoZGg0JvDdJBuLdjbR49ugLKL/zWZuhtM4IgjUcfWC8+08PqT0P2ZDTV6P
 zxQjGBcE6fVmfaH1Z7b48wI65GRxVCmVhmDUE10EaaFQ0xmxrI65rC7S7T7WXXSEE=
X-Received: by 2002:a05:6808:50a7:b0:490:af61:8830 with SMTP id
 5614622812f47-4af5dfd4565mr21010910b6e.3.1785799296543; 
 Mon, 03 Aug 2026 16:21:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 18:20:43 -0500
Subject: [PATCH 4/6] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-genio-360-bringup-v1-4-606ee60755b5@baylibre.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5195; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=h1Tr9t/smezbplx4rUw6JH1YDOSeaIljl0YSDZ93z2c=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpxImWgIbb4ZQYkPVEXrHXIjyzFDSQYKq72OnlrOIhkm5h1w
 YkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqcSJlFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8Ak4Qf+N4RrASPxORHfk9/e9A0ccZu5KEHUQmXCPdsDnot8oEZmgkz
 u9Ei3cSm79aRuGAAccH8fOcOmXRsgWL48z4iKgBiFz46qwqoz/RkynroimphdhBtdL1x5pN0j4Q
 qb5K32Q/3AIho768AEyr+Di5YEjmDL8bhqIRCK36hXHpTDmKd1c6OifRJirhb5KeXxdabM/IcCU
 7ioKxIEwSroq7vygiY04DxKF5MR8LEPAaEV3lzQFnPdbbt6DRpSiBhQgxKpswe1E4q6lYHfYZ0E
 WmJS08cY6mmB/4PrIQR9lwJwmf/DvHaF3tjN53HrozWUBr0f9nZaTTAnSMLK+mBOgZMPmw==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799296; x=1786404096;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EpNSLUlturFzAw8snWK8eUFqJ8kqfiHBK24+0esL7hg=;
 b=hAKKaen+xLRmo5UqjxJL6nXIzMUNI2hV9TnpvEEt80+76jVCFmK8kgjCHHXQ8r4xq9
 wN1+fsLzLtpWKWy4wQt6ijv6EyCbGDSumW+w+n+Tvr9LqgeMYaMTSrJkzoDD/+kSUqqo
 kzMYf7DfMX79LlyVapp7n1C6Cg4MA9S0AxewRsRB8VN0rbz+CT1FKgvnuGzN6yst8Mcs
 sAGSwc9iOxWBHq1z7PcMb9v+p3dZyyWXiGIY8gOrWHTselpEsvu823Kvah8TIjjOVmXF
 F+kgYrK/ZVphFN22VcE9X17Bu+9vIadEJno+r+o6sZeqNVLGXDHt73VlPJ10eEW2i4ia
 0UxQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hAKKaen+
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
 arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/cpu.c           |  3 +-
 arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 9ff7e7a7f5e..a9ef1f1e314 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -120,6 +120,15 @@ config TARGET_MT8365
 	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8366
+	bool "MediaTek MT8366 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8366 is a ARM64-based SoC with a single-core Cortex-A76 and
+	  a six-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  options.
+
 config TARGET_MT8512
 	bool "MediaTek MT8512 SoC"
 	select ARM64
@@ -160,6 +169,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
 	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
+	default 0x100000000 if TARGET_MT8366
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
@@ -208,7 +218,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
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

