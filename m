Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A866E73140
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 08:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AAB83D77;
	Mon,  2 Feb 2026 09:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PZQ2D55K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FE583D7A; Mon,  2 Feb 2026 09:23:48 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A3A83CEE
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-480706554beso44984265e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770020625; x=1770625425;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NzP5ijCGNPocNGGZSfaPHIEsRFtLyZVmUwo8L2cSHTs=;
 b=PZQ2D55KxHbNTVDpgoXJHucpdZHCbA3mPugaoU3rdNkValjgX5fm8DZxzN7/nZf24m
 wZNS83oOsksyLd7OKIaUo5GZcG3KKcx5I1/yZMzVa3rvz8wvmz0mfxg5Dvq1NqpXFnD7
 FEeSlo+lDZcE151fv8TqVfeWXYNPb1K/CKYS3mehIS7pek5bVjaBEH8KEL+KGVQWpRjo
 1F6rQ+kCFs3dJ1ie6y25apa3J8S7YN6Sd0DHklmFUsj7rNihkqpGFMwdqttg83Mjj61G
 +wXOclbC4UN7+GfZwfbCcWlDvU3HZ8iUl9li+l9lC65vMQWfbvovFISH1DhstvTUrv4p
 93ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770020625; x=1770625425;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzP5ijCGNPocNGGZSfaPHIEsRFtLyZVmUwo8L2cSHTs=;
 b=Gcb2tQjudSZs06caFhb3KjFliD7BR3fSmuYr215d/gYopi+1n0+T1rw8HWaejRvIpU
 wRneyiANrZUdK9Byu3BCLrE6YvtWDtT6Ta5V7gEQsWXPy+bbTR+8yVIMscghknG4Z0uw
 YSelrrF/lJy54YFRaW9wi4AAuLh/aq9HxjgjhKlAUMmoOfjVKY0nbGIsGxj7nMNSA4tD
 k27Z7gwaGutq7wOnLTKawDq2PZ4DmNHUXTiOLPYQ4URo8ToQKnpbwWpzvPCjEt6+T+H5
 t3ZCdlI8m8Rf7t7iRd+WPcKcyxEUc3TcVXKv8SrUBU5nSjRKyscu5EZdUAO+LtEHEANS
 j0/w==
X-Gm-Message-State: AOJu0Yy8AH9WRiURAnonaWhrV2OcyflQxdH7zqmOXDOOtnMgWxEP5RbU
 NCh37GDfi9aPIGaRG2ZcOqeBvxYkYNhSEhYp5csLA0Hhl1LsJ4sHWb6A1NkGYXR9BuU=
X-Gm-Gg: AZuq6aJVrdfm1up9MMAcHiARF2CN5Z1uGp4Owb7KvZ+iuTIDr5h8Kjk18LjtV2N6tb3
 vLD00qA9rAuJEvxC/b3OOBiGRqFXZOfipgf+jXRQJk2Fj04HzwoZeoTYMfwJa+ZQf929Gpgb7bw
 x2j90mXohwVJwFEKBeQn7OxKGLF5ffl2jPAiCrUmh09cm40xlH/3DDJSdtYYZYMo4/4Y0Z62DoK
 ysbP2rj7jGE4gaUP4jzDp8tRHGRtTBmkJNXPZ6ZL34D4Fz/R3mVaGD2ULN2BVibqgJXmq9N3xUe
 Y3QoDPRb92LlEPrEHRCiuFgfvClRFI/6sZbSMBE64+LCLChwOfrqUYE4RQRireAn7Jdaj3XlqFF
 imkcu49iJEkVD+S+1FLMv33cGgjVewGvMBO0r+AtQVbTh5ighpU0DeRF6tx+bE8uD1DRnnO07AI
 m+QW0vW7UIPobcc81CEL8AaLDJ5aVzi3FCElKSye97I+GuidpzqvZfG4rvta0PQATflJo08oPRx
 YcOzExp5SFhf26xtVrp
X-Received: by 2002:a05:6000:1863:b0:435:a136:b891 with SMTP id
 ffacd0b85a97d-435f3a6a7e0mr14404424f8f.13.1770020624811; 
 Mon, 02 Feb 2026 00:23:44 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfccsm40611708f8f.17.2026.02.02.00.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 00:23:44 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 09:23:42 +0100
Subject: [PATCH v2] board: mediatek: add MT8390 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-add-genio-700-board-v2-1-06d375b877e7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07Zh2REBX/odh0ccIkyjFFomE8
 O9WjHHj8tzknjOLSIEpimM2i0AjR/ZdAtxkwra6awjYJRYosZAKEbRz0FDHHkopwXgdHOwLVCb
 HysqcRHr2gS78XK3n+sOB7o8kH35jy3HwYVrLo3qv38jub2RUoADLXKqDLbBy6mT0dGUTaGv9T
 dTLsrwApx39e84AAAA=
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
Changes in v2:
- Add Macpaul Lin from Mediatek as co-maintainer
- Rebased on master
- Removed series dependency, as the pinctrl series for MT8188 was
  applied on master
- Link to v1: https://lore.kernel.org/r/20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com
---
 board/mediatek/mt8390_evk/MAINTAINERS  |  6 ++++++
 board/mediatek/mt8390_evk/Makefile     |  3 +++
 board/mediatek/mt8390_evk/mt8390_evk.c | 34 ++++++++++++++++++++++++++++++++++
 configs/mt8390_evk_defconfig           | 27 +++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt8390_evk/MAINTAINERS
new file mode 100644
index 00000000000..d46b8b2e156
--- /dev/null
+++ b/board/mediatek/mt8390_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+MT8390 EVK
+M:	Julien Masson <jmasson@baylibre.com>
+M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
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
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260122-add-genio-700-board-5621b428c04e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

