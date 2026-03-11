Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B8CFD88D4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D91783FDE;
	Wed, 11 Mar 2026 01:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F2dDGxVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03108401F; Wed, 11 Mar 2026 01:17:48 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AB783FD3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d55b97f358so9655065a34.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188264; x=1773793064;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdycIqbgqPHZ2RE+Nhi7eYwHfQkN6FBSYjkp8z2QVZk=;
 b=F2dDGxVaeFKcMJeW027MHdqcKlgF19bXY1M/iYeZ5d+kBsqd1doxcQ7U1jyjJpmCs1
 8VY+lQh150p2nGebrlL/FkAezpVUD4oHxNfm5p44r4/2TWDUOfM+AHnyxq8rPpUbVvr2
 M46/WUZN6WxSqRiPu2hnCnjgK1TThitrBppoSj7/Po19Cdzjz8TDPa0Y2baGRhlrZSyW
 TKf5jVMzeK8Nns7sd1fTL41VKFVtABd7E4BUeBQNNwzimUS3rpjh1wv1df3lRjmkv7M9
 9sTZrbrUqlElQzLndeJP+R6Yzma8+0CLKOz27BVKTb7f34MVcPK7ZG9jEL5oedt0bKRQ
 8UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188264; x=1773793064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gdycIqbgqPHZ2RE+Nhi7eYwHfQkN6FBSYjkp8z2QVZk=;
 b=abHamGuNtpLpoKcKWTljxlpILVVaiZV2g8qw/L6jSO+aqXTY2EQpDZyOTCVW8hsXq5
 DQFsc685hkswz55VjphbiB6omvBsZeUAM+lQgQM7tP7DMFV7TcFqGR5bhWwZVumnhWWa
 SENN8P8epj6DEmCFJkACbwYg2Qa/wK3cI3+GSCKs7f+Y7fsiXjah7X2ANI1GtZ59VrD3
 U34+SKyf3jZZKQAI4pEfj6vJSNAbFRb1yqyo23XdWAK1THW/aoGp9U341IB/AeHVS3c+
 iHfbtih5G00NaZRlj6t9gX3ezcdcn1BLU0xUI+maKP11AD7/STT/IiY9/7kgStvan/Uk
 mX/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQoPhmqgib6EclyCd82F6qd0qGba8E0pCnNx3d2DNysD89SdftbTvZVHcVotBY5mP+0peHtfI=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ7+h3CsZyP1V9UrBSXf+9IlYyWdCG864Eqn5Wzp27qxGKMcg7
 cC+mdtVcyXKknPeB5os91bjy5KngjpywSbYb5UlFaqI08YE0iMO31x6LtoAThMJ6RME=
X-Gm-Gg: ATEYQzwJTFH7wcx0nlT5lNMqnLVynzimBNDPm+XHiiSJ6dQbk5He8NeQ0sATWrkQe+A
 Ul6IqHrsm0JYJr8SxtWTkWL/cIvfK3nLbYky7X84qwyEp74g3E9y0Xi3cT5ej8UMMsC02qF9Npu
 JkfUfKRtXntQZ8W8X43SXIK6oRTievWwo/pFdmlrWBIF5lDUqVpk6pjYR+nzU8ptqgdvy2zJRuD
 x1sJRnS2gF53njtK9OkPyntGwxNb/bwcfmkdvEvPhWZSA/qnwF5gaImiHkx4LcK3KS+fpX5DyXQ
 faUlGwfQTjTgVSV8Fb1Yvz/Tay3V8N5j3AykOrTp3gWB5Tv3D4q/AuXwGn3KyVvEosWPwVulIsr
 L8QZ73lvF5aYXhGucKVrWVZPC6WP/leAf6an2aK1y/XVkZKZIR2oiHQ7RyYiz2ROpmjpxuuTL2+
 /X89pDBKtLz7CAoNSBSZMRjbJj6XLQ
X-Received: by 2002:a05:6830:91c:b0:7d1:93e7:cd6f with SMTP id
 46e09a7af769-7d76a77354bmr540531a34.13.1773188264454; 
 Tue, 10 Mar 2026 17:17:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 19:16:51 -0500
Subject: [PATCH v2 2/6] arm: mediatek: add support of MT8189 SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-mtk-mt8391-initial-support-v2-2-1dc862d58532@baylibre.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3oAQVsuVgqGVcQJ83e+EdI4lphvIgjF4Fz358JO6u4k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLSFTfIJoo4gJHrcJaBiQXCGdNRImYswti6qu
 VB5MVeqCCiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0hRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsMQH/1/kYB9Lgrz4wUqhjw89W1UBib/14sk3r3K3lOK
 K1fpoCYdprXkrqr9LFbsBWi/ewSYJUseVFgiARLwGizx32GmxT1GNpW78VwkQt9m3NLTXxaABlI
 2O0YaHhg4kt2ioFDjsogf9xe5s7zWrTg6WpYaLjmNq/b41PR+neqjYg1p7XDn/eh9KUmHcuyiMl
 NfXg0hqBNaoU+60j1bclxb1CKXRxDbPE4X3BeRe47NHGSPjRvvuyAXCP7FnPnfeFpkhlsT1DVV6
 gLKubFvsd6qIRJuayBB/FX7HooLJVRjdlgxP9UJW2zhtYI85vbkpXWUn2ghuXZXIQs9l9eMAab7
 TK7E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add TARGET_MT8189 for MT8189 and similar SoCs.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 11 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/mt8189/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8189/init.c   | 58 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 671a6cb1cad..b5b06f4e5b2 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -93,6 +93,15 @@ config TARGET_MT8188
           USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
           several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8189
+	bool "MediaTek MT8189 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8189 is a ARM64-based SoC with a dual-core Cortex-A78 and
+	  a six-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  and LPDDR5x options.
+
 config TARGET_MT8195
 	bool "MediaTek MT8195 SoC"
 	select ARM64
@@ -201,7 +210,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index d1f64d61ab9..35f748a70d6 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
 obj-$(CONFIG_TARGET_MT8188) += mt8188/
+obj-$(CONFIG_TARGET_MT8189) += mt8189/
 obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
diff --git a/arch/arm/mach-mediatek/mt8189/Makefile b/arch/arm/mach-mediatek/mt8189/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8189/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
new file mode 100644
index 00000000000..80910810668
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	fdtdec_setup_mem_size_base();
+
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G.
+	 * Because some periphals like mmc requires DMA buffer
+	 * allocated below SZ_4G.
+	 *
+	 * Note: SZ_1M is for adjusting gd->relocaddr,
+	 *       the reserved memory for u-boot itself.
+	 */
+	if (gd->ram_base + gd->ram_size >= SZ_4G)
+		gd->mon_len = (gd->ram_base + gd->ram_size + SZ_1M) - SZ_4G;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
+}
+
+void reset_cpu(ulong addr)
+{
+	if (!CONFIG_IS_ENABLED(SYSRESET))
+		psci_system_reset();
+}
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   MediaTek MT8189\n");
+
+	return 0;
+}

-- 
2.43.0

