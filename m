Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ED3F483F7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DFA840AB;
	Mon, 23 Mar 2026 21:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DBUAqige";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCCD84073; Mon, 23 Mar 2026 21:18:08 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8335E83FDC
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-467161c4b89so2512084b6e.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297084; x=1774901884;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mtv1ilWODcRkXiON8cGbDFTm/UsWYQcjArGhbarFmNk=;
 b=DBUAqigeyPZPQ3+rk0iseKfypePsQ7Di7KdlUh8EpWXbpl/gl2BkI2UyJ2dZhcLkKt
 dfIF862indqzX1RFWK+RfYlCgIjC010LUAYeAPNH2ocvEWeMqHdxeOJGiJkTbRDrtmQC
 NkKlzErLz8zIN3GPU0UA+OasUGxnWqIOEh4psXwBBIXNqR3EdYYI0OYY+1q079nAulEJ
 6GjOt1baB3XMTt9GVzMOf6gMGR9kVRtD8leeA3+S3qu6+Y7RTQ+gTgEI8Siu1TA0MNdw
 GLaqb79p8EZ/fG5RxJ3bKBEC0jpbYoWfH+d9iIoEDN+X9K9x1FXLaUfEOCSvpy9sSxJD
 41Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297084; x=1774901884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mtv1ilWODcRkXiON8cGbDFTm/UsWYQcjArGhbarFmNk=;
 b=WBqwZLkCGWFI15xDLW/g2+PMAz5JVk9Z90aDB2k3cJ/G7lz01EV4xizrtuUCJKYRhU
 2vXWdpukd0U+yhr7keq8VGixMn7Hz1WGji3YDeC7RtceJC2cgifYcQNMTVyZgj07kshv
 mdVOAFuXiAV/itrRhxbfLPJeL+9ARbOZyFFYPdYtqIKr4GKW0fm4ifimblvM8fNxud5A
 Gbn35EI+oc85ueilFH0Ct9ItEIcSMEtDBvJbiXDt32YNUH+3onHLgV6OPc1pGSz98FKd
 kxWflw3DKa7KtPAVFN4Wktd54V3p8/IbAeUTpAgrPboThK6mFwcqM+2yEXwq31XBRvCL
 X7gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMP69Nd03gnJJX4dE8xfmx1iyFXX+0yhCzU3ZJ9tZOoIoIy2F5LGZsgTWYu368Xsj8D8wM4G4=@lists.denx.de
X-Gm-Message-State: AOJu0YwzfLg0qlWzGy7WXX3FCYvV51k128S8oD0Bn5i3Onh0p/yRCD/O
 iz9iTGW0gm9EX1p1rgCUXqjMnDcagqJJ4g4vxIevPvj+8OHRtTs9arMQ/CTrtPOJ8lM=
X-Gm-Gg: ATEYQzzlxd1UklyVAuOCvnR3ytmVWlrZvQBKTbpEZ1fftXk3kFNfYf1miRLs4Ci1kiz
 CQuHR1cXeSD4db8i5WInYXn6JcukmH1SdFFPxSS/+HETslOHrJ1hVGklTDxVcZ7xudW5/UBQ9yB
 0APGhpVECYsMAHK/Mmzf2DmztX60tWlvnae2GljSOetnfQ9GPElzv9Kxoh+CPBHvZpU5zaf6ZUx
 BcA+4Ksxsxyfl6XxLMX27o+J8vcXO4JaBU78SekpJQ/QN0Njco5U5cpBEFwfVDBP6+96yXAXMes
 CSoXKCK1qaKMNdFAgoSPpljOrTxhpRl6bAbXyE36sh8O+AFL1UiiBAKqzgEDwHunfb4G+EUY+Md
 jN5Y8VB1jIcIdHs3gXxeluwz30ySqn6MBdngKgiHBlmpgljnAow7Gm8ScoFdvRdbrOi9V9QHxdP
 tv3CoKpbhs8z+5TCcOwq5ft93N0l0=
X-Received: by 2002:a05:6808:2214:b0:45f:2788:b006 with SMTP id
 5614622812f47-467e5a72105mr8150711b6e.0.1774297084072; 
 Mon, 23 Mar 2026 13:18:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Mar 2026 15:16:53 -0500
Subject: [PATCH v3 2/6] arm: mediatek: add support of MT8189 SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-mtk-mt8391-initial-support-v3-2-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pUSo3a6nm1S6dnKY8MsAuOly6yxGZyzBZc04vJ6Mi3M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/XTyemEzy90alwuwAebV9PgbWuCLYyF9Akw
 +QiLMsFvz6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGf1xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuK0IAI+xSSdIYcMoFOTD15jCfi1zv0S3JCYNTb4XRSv
 5NSL/jd/o9CL/xRR04IyNYsq+tAgvJ94j0PXShjkwTYUuM95v3/0db2wcZkHrkwu3poFPG+xWXz
 QvmQPRPFu0gX9Lef7phDIShv/IzIDUTwBQbrGD1xMM9uX5DevV0TWvFitMmdMVWhxU7DggkW4C8
 StX1mPcIy4l7VUqk+hzJl+lyRU0puqZWvE3oMFwWcrmQE34abFW/38HNQnbMrmbfD1hOchdNBYD
 s9+GSV+yz5VAwYgrbj9WVf0uoYU/jz08NZ3IYvT6EXL8GpYNVw7W6y6LHerh/YmBh9Zs90u07+n
 eaUk=
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
 arch/arm/mach-mediatek/Kconfig         | 11 ++++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/mt8189/Makefile |  3 +++
 arch/arm/mach-mediatek/mt8189/init.c   | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)

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
index 00000000000..648c17ac305
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -0,0 +1,41 @@
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
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
+	 */
+	return min(SZ_4G - gd->ram_base, gd->ram_size);
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

