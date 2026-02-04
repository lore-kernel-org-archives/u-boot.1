Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB29EA7943
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7F48341A;
	Wed,  4 Feb 2026 21:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J8OCFm04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D16839A8; Wed,  4 Feb 2026 21:24:35 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B6A83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso190634f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770236672; x=1770841472;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fif/OiTRad0YR8p66Yku7iZKailLnEcd8b3xF2RTj30=;
 b=J8OCFm04QmJYVZW/qPi4jGKTgeQsZviXVgAfVkZO21HIuM4XLaia6mt12wFk6EvNed
 bQN8cCwfQzb+98/+y3aZPGku5hS4rzlCLLOI4u3nmeeBlUiPK3DfyWw6m+QwPQgzRoOc
 v05vbdleXDjrsTm6BMT4TZNuUHQtn8P6b/iKvPnXwvexCBqPfTYarD8xbRMDyLkJp26+
 ffe/emEzNcpl1AXvD0oDdXpI0c7vqgS2bwH3aST+53bmr1I1F7L+ExKkKgg1xuOUttin
 1afSQ3Mdn3Zf93OfQx0vctoLYSWB9of6J04arEIbaKkc+I5HDjE1ftaVf1FMD1BPBBz8
 b9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770236672; x=1770841472;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fif/OiTRad0YR8p66Yku7iZKailLnEcd8b3xF2RTj30=;
 b=ENEv+CHkXO9+gkhyoCUyek7jqguuw6dmfNz7kYP9JQR5OtOpHsGyr5A/90VN/RaShP
 Kzbe+k2NroXT4XKzW0APydhHhPHpJnDIfIveM6ABmNth9nJI4kQOq+yoqUCnriEwM3wC
 6sSf8aVLbxSLt8LEBGjAlrmRM4nupGZrx8ai4IEwaSbWyz1WW/fNaHKKDtBD6s/k8Em/
 cGWBPE6tvGsYzEKsniT2AmsWOSnplb3SrhxqmYxt9OkHAulYXuKYKIe6ddI+u98lu4C3
 PzQkBjtWkOeEXGCmh0Y9Z1TuoRWbrC8EyZ7gfSyKbSMZ0xEnCxdJqtYHieKEVqmTxox2
 Tjmg==
X-Gm-Message-State: AOJu0YxnFJ7K+BFYoq9oZOG/5fMOkFGqe5xsDiTE3PijacSHVTrj48Mo
 L+LmKwTxIm47FpQClvADt1c5vCNImo6JAm+qFLIkg0o4ALIdSNYuHjgwYBWo/a7NrXU=
X-Gm-Gg: AZuq6aL+c2xfO45EhWTk/HxvFJV5ircxsN6O9eUIFnklZ+FWhaPRq6xXCI39HmgKSVI
 9HIX6EwytN5ReIaBgBw53exb3TjX6vL+h31FotWrdl7EoJe77BK0xmxkvLizc75IhfLjqmSGk8I
 hwa8RK6S/Of0qBDS3O6NvyxF8NTq10Fvdby0+wMDEeVnuekZsAiyC+oqlQ6zJ5xM92eOYqCp5bD
 idVUKqPwOoyoGTsHjiVc9e3u+0Gt83sp3H4ow1PNJuaacztmkcFiwcXrZU6WJjlsA3yC3ZxMaCt
 2+TxS/38MJ5VCD9TAfo7d/UpGqSRGuG17FBB3YdGzk/POh9ZsciUEOS/T9O7w4vFfypSsLHA9ts
 yCjR3lUU5oJmTPpnwLF6Rn+TKmeZu3zlp2RiIDxjI5H0lK/E3qnVd63Q59CjaqyIwQ/OO8xT8W9
 lIK1L9AZgjhdv7gqhCP174tASEmtEBQD4UWarUs8n8/AvJoZlHnEgZqgaDfAzgchCCMS8xNfCrb
 ihf47EKXw==
X-Received: by 2002:a05:6000:40d9:b0:435:a370:2d7a with SMTP id
 ffacd0b85a97d-43618053444mr6240318f8f.36.1770236672586; 
 Wed, 04 Feb 2026 12:24:32 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a3a9sm8701651f8f.18.2026.02.04.12.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:24:32 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 04 Feb 2026 21:24:30 +0100
Subject: [PATCH] board: mediatek: add MT8370 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2OywqDMBBFf0WybmCcJJPqrxQXeYw2FLWNVgriv
 1e0dHku3MNZxcQ58STqYhWZlzSlcdihvBQi3N3QsUxxZ4GABAhauhhlP1+VBcnLQ/rR5SgpYlt
 pUuDJiv36zNymz6G9NSdnfr13+3yOwruJZRj7Ps11QZoIfVUFYB8MBbRWBafQITgHxkQ0tqzaQ
 /2vqoujqUQ8mjoe0igtwC/JEJZe4zWA5npB0WzbF9dIuJDtAAAA
X-Change-ID: 20260204-add-mt8370-evk-board-6d2f94630b67
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
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

This adds support for the MT8370 EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8370 is based on MT8188.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/mt8370_evk/MAINTAINERS  |  6 ++++++
 board/mediatek/mt8370_evk/Makefile     |  3 +++
 board/mediatek/mt8370_evk/mt8370_evk.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/board/mediatek/mt8370_evk/MAINTAINERS b/board/mediatek/mt8370_evk/MAINTAINERS
new file mode 100644
index 00000000000..ee2b5cd8291
--- /dev/null
+++ b/board/mediatek/mt8370_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+MT8390 EVK
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+S:	Maintained
+F:	board/mediatek/mt8370_evk/
+F:	configs/mt8370_evk_defconfig
diff --git a/board/mediatek/mt8370_evk/Makefile b/board/mediatek/mt8370_evk/Makefile
new file mode 100644
index 00000000000..39b630f981d
--- /dev/null
+++ b/board/mediatek/mt8370_evk/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += mt8370_evk.o
diff --git a/board/mediatek/mt8370_evk/mt8370_evk.c b/board/mediatek/mt8370_evk/mt8370_evk.c
new file mode 100644
index 00000000000..58874a876ef
--- /dev/null
+++ b/board/mediatek/mt8370_evk/mt8370_evk.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
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
+static struct mm_region mt8370_evk_mem_map[] = {
+	{
+		/* DDR */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x100000000UL,
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
+struct mm_region *mem_map = mt8370_evk_mem_map;

---
base-commit: 64662b99c0ebc56c2773ca32a20aa055d25719f7
change-id: 20260204-add-mt8370-evk-board-6d2f94630b67
prerequisite-change-id: 20260122-add-genio-700-board-5621b428c04e:v2
prerequisite-patch-id: aa6329af5f80e12578b758eab20e3325303837ee

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

