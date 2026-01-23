Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54769D72350
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 08:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8900183AC5;
	Fri, 23 Jan 2026 09:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Da8iQmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A8683B85; Fri, 23 Jan 2026 09:37:12 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5271983B87
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 09:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso14773235e9.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769157429; x=1769762229;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hxdQACk/oIsoyLR/ccgYBYnR/cKIt+ULFLBqjthKuaA=;
 b=0Da8iQmJfaV/Ab0GdmRZhmIR0Dt07LucEZIGlVw9kohSKk5XnrFo01HXd76N6VEEsF
 jH41sWux5ivCLSLUK2dIM5IIzIhsZFJCPFNOrMo6rSh0rauO1pNFF74DavKJqQoNkwpG
 74Bevhrj96ywZn6aCt3DQLJ+wJjXaHnax0Hbmtg9ccOBCmYuerOido1Jjha3FxenVTLY
 zQLYr9GcWep9EBirOgNZD/40xIVHT1weVoYa7LhkyaXo0fdiLduk3NBGEGVIOLtYSIRC
 d9jLuO33k5gUXzgWTqh9MWSj1Gw7cFOeyHF0nqDixRMdmySeE7HDggfZyNFdGaHAsBwW
 J1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769157429; x=1769762229;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxdQACk/oIsoyLR/ccgYBYnR/cKIt+ULFLBqjthKuaA=;
 b=JKOI9r922fJaFEmCDVGalhC6187MmT4c/qITVBeN2Lr9bO4yejR/pskXC8jchLwkOZ
 nO83YMOSaEoRscroGfdBtWRMsdWWHLRqz9GHjRgBgRQwvr16k+0oq3JIJbiDshP7kuqu
 OWenG49wSPe3/8hGHaQ3UxwNiak92AEE6S4xABO82rZZwCajsPtcREfgsbUW5nl5BJQv
 aa6SfvnKE9jsEJ/FnptCxZOATdb1DIfMMYenAUevsDoVJvCWSnrErP0s73VsmQXIpV4E
 NX1sgtIrf50YcyQiPbGFPfksujIGmMor6t1hRWbKNA9k6XusT1m5OB8Q/y4smjkWc6F/
 HEhA==
X-Gm-Message-State: AOJu0Yw6KzQJgoYp+g5peiS3KiYVHFAcvPSvey9t526Av1uKEhdfY7jN
 Mn4yqAhpo5/FwXYWdg88ubov/AZcPTpwxdvBjk63KZZ42mq9J+RGBZOUfCc2qMW7vvM=
X-Gm-Gg: AZuq6aLUxYgg/z4rh+itZhZHlkbvGl3gvcWjmGvB7Xbpssn206f70X5jhQmiGqCd3+H
 YRecOK9OjjyohN5oCTK3sHdrtnZhZSzmPpdpS/SbzS7wPEL2rH0jbWWBA3SnyG9SbjPyusHfGAT
 5c3OfzyoyK/OCM2qXULXVEfD4FbX+sivDjEH9cyA6TqMHK8nbp+6decL3tIoHoCO4pZfRoCHD7a
 scp/aGMiSQJFAFT2NREs9E+1aeoXDhshmu68oCTGfOEMo1ZXZRvp2LHB3UhkxGY5Ein8nra3FzK
 nxnhE1TWzr2Nw7KA8F4J9cTm94qfh45GrlvZ/0sbVvYovJMhLjyLtJEDq1x7D1yzeW/Ap3u7K9c
 AP4y8sa/kDGbOGn8n63RNuRL3qFNK1lCrluii24hr2U3PcfhX8T6kzwllUvdg+3Zm48tSNndT00
 d9KVRJ9QINsg6aX71HiKkQuE+8ohXhL0Mor9OTktjgcTHPez6lIi4qTFbTdyRh+54E5ZXdkEHyM
 r9cnOSBxQ==
X-Received: by 2002:a05:600c:1396:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-48051256163mr8179885e9.26.1769157428551; 
 Fri, 23 Jan 2026 00:37:08 -0800 (PST)
Received: from [192.168.1.60]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804703b5b4sm124823875e9.5.2026.01.23.00.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 00:37:07 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 23 Jan 2026 09:37:06 +0100
Subject: [PATCH] board: mediatek: add MT8390 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Oy2rDMBBFf8Vo3YHRWA/Lv1Ky0GOcCmrLlZRQC
 Pn3imTT5blwD+chGtfMTazTQ1S+55bLMUB+TCJ++ePKkNNgQUgGJRH4lODKRy5gESEUXxNoQzI
 oWiIqFuN5Vt7y78v6eXlz5Z/bkPf3KIJvDLHse+7rZJQxFJyLyCFqE8naOfqZPKH3qHUibaXbr
 PgftU4jSUvC+ZW090UuC5z5iL1+Q7udZ6kdtLLJzdY5q7b1TuLyfP4BNFr01fMAAAA=
X-Change-ID: 20260122-add-genio-700-board-5621b428c04e
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

From: Julien Masson <jmasson@baylibre.com>

This adds support for the MT8390 EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8390 is based on MT8188.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/mt8390_evk/MAINTAINERS  |  5 +++++
 board/mediatek/mt8390_evk/Makefile     |  3 +++
 board/mediatek/mt8390_evk/mt8390_evk.c | 34 ++++++++++++++++++++++++++++++++++
 configs/mt8390_evk_defconfig           | 27 +++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt8390_evk/MAINTAINERS
new file mode 100644
index 00000000000..73fc28b096e
--- /dev/null
+++ b/board/mediatek/mt8390_evk/MAINTAINERS
@@ -0,0 +1,5 @@
+MT8390 EVK
+M:	Julien Masson <jmasson@baylibre.com>
+S:	Maintained
+F:	board/mediatek/mt8390_evk/
+F:	configs/mt8390_evk_defconfig
diff --git a/board/mediatek/mt8390_evk/Makefile b/board/mediatek/mt8390_evk/Makefile
new file mode 100644
index 00000000000..a26d46838c4
--- /dev/null
+++ b/board/mediatek/mt8390_evk/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += mt8390_evk.o
diff --git a/board/mediatek/mt8390_evk/mt8390_evk.c b/board/mediatek/mt8390_evk/mt8390_evk.c
new file mode 100644
index 00000000000..1ca40366a55
--- /dev/null
+++ b/board/mediatek/mt8390_evk/mt8390_evk.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 BayLibre SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <linux/types.h>
+#include <asm/armv8/mmu.h>
+
+int board_init(void)
+{
+	return 0;
+}
+
+static struct mm_region mt8390_evk_mem_map[] = {
+	{
+		/* DDR */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x200000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x20000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map = mt8390_evk_mem_map;
diff --git a/configs/mt8390_evk_defconfig b/configs/mt8390_evk_defconfig
new file mode 100644
index 00000000000..9bc1d922587
--- /dev/null
+++ b/configs/mt8390_evk_defconfig
@@ -0,0 +1,27 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="mt8390_evk"
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
+CONFIG_TARGET_MT8188=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_IDENT_STRING="mt8390-evk"
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8188=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
+# CONFIG_RANDOM_UUID is not set

---
base-commit: 64662b99c0ebc56c2773ca32a20aa055d25719f7
change-id: 20260122-add-genio-700-board-5621b428c04e
prerequisite-change-id: 20251203-add-mt8188-pinctrl-support-547d9379974f:v2
prerequisite-patch-id: a8cb24313e56c02b98910f553972a13e8079db30
prerequisite-patch-id: 16094fb012cd9d3ab5e62f81969ba7b4d796af41

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

