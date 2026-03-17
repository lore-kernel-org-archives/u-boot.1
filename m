Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3FFD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D01384390;
	Tue, 17 Mar 2026 15:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lx8RAZ2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D1684378; Tue, 17 Mar 2026 15:24:21 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55AC84355
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso17035725e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757459; x=1774362259;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDEIn4jDOtSE0h56UoXZt3Mbos2jhFBy6ZX9qXYYhEI=;
 b=lx8RAZ2wx0YckSkfWE9XAy53HZ9PHW0rJy7c1nNQadfR4fM+Z8ZNq6zWo/ka34elCL
 /Cv57B+xVaaVI4c+Jch4xPAg8I8DEF0HCx+FL5KncBgTimIxH22uKUAGuYgZzMZjney4
 Yf5IkYk/2Wmfbm1s/LjCH0ClvaNifvCWvX3Zdv5HYg7GeJ6w1VYhQvUbmnVD1g0K3aq2
 VJX++PNo9mJadIBvDk9ch6BEXmAJ/taWYVMZ6jWp/MzFKdueBsviOwsgBFjgW1nHHUxq
 SB+kVSvdJH+ZESv2uMTtY4N4g51wrFFQK8yqUe3KyIPbee3FqjBYuqhbG7FKfsej7YKS
 PXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757459; x=1774362259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oDEIn4jDOtSE0h56UoXZt3Mbos2jhFBy6ZX9qXYYhEI=;
 b=LDCL7jTRC4wMfGuJDeSZz4727Sk1Bqv28xW3DIbTpH4xqavi8ZMHLBHkFd+6W/rgJv
 yqgyS7kShj+/KEmZ2AcRasJJm+Z+JdBaidApaSoQJ5K8DSOpj2cqumrTE5lNDwtS8zJ9
 5KmgMA9kCep4jLq6T7pHAHaTo7HcFNrfLDQJxYI9zmYnR6zXAYypEnqG56P4On9+azBi
 HqiQfPSRWsxNWMmI95MzocwlMs+bkWWslGnDz/hEb8FCAtBjZhY2vo4tdkLSZTeTZv37
 JsaDiy6LLwDssze4VJYKf4NhLtKr/8Fo/LcBO7tHzcjGTM3n1A5EsxoFQPXw00A/TtOV
 Al8g==
X-Gm-Message-State: AOJu0YyxskKJg47h0TBycU7mlP6LC0l5zb7u3JeVGcHgtazg5Bg6smuX
 tB2COGIb6bTGRaudyHlpRjP6PKhdo2RbonrC9tIgbZvXjJFVukqIquxJi4w6PjQpiLs=
X-Gm-Gg: ATEYQzzxCSXzOP1I+83yUHgI1TpkjWlgGtWEe6WQL5sFqrmlTbm1IU8i68PfeMdIR11
 03K1g4boK4V6WZdH085ekpZN2crNITE8RbztMxHqYQInG2gtWgvbh6OzXuRXEYnZw9o4VKfgWJL
 g9/gDO5G6krNIMQ2xWhMPPC8Im8gLRXLrkeiLgpEZDL1MWUNP61hLw7wdYkun49L5vO8EiG4X9g
 aOOfueAW5bnAX0O8eJP0B7N1NrE9enKyrhHQzQFAz6cJFnYzJc8SbOyiKwhtSE47iJYPvLMSHJh
 04a6sEK6PRGfX3U86LlOnuiDrCaWqzhcuMi9QzjD+gDacUugMMt2heuMxh7LHRblR2gZTh5w55m
 oosJry/ok2EnrsZi/OLy6ElL5Bnk0jrgQGxEXcv6lY4pDHcerQ6UR8tfObi3rNG40LAi4KcAY72
 Qq0gofgYLGxCUtuP+vtBoNVvv0Qsbr/WfPnpnBr0aMMi6pvXfhQZ7iwWvQ1ELVaIHAOteu+puOh
 y5M2z0L5AWvKM/o7Da/C+2F32wPZjs5Zej7IqE7auskNfhhvuNv3eADN1ByHubQmZ8tfyJsewaX
 Zr6JPUE=
X-Received: by 2002:a05:600d:8495:10b0:485:3e00:9451 with SMTP id
 5b1f17b1804b1-485566fac49mr217293485e9.17.1773757459134; 
 Tue, 17 Mar 2026 07:24:19 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:21 +0100
Subject: [PATCH 03/11] drivers: phy: phy-mtk-ufs: cleanup headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-3-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
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

Remove unneeded headers and sort them alphabetically

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 1eda3df858d..14a90cf2064 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -6,23 +6,15 @@
  * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
  */
 
-#include "dm/ofnode.h"
-#include "dm/read.h"
-#include <clk.h>
-#include <dm.h>
-#include <generic-phy.h>
-#include <malloc.h>
-#include <mapmem.h>
-#include <regmap.h>
-#include <syscon.h>
 #include <asm/io.h>
+#include <clk.h>
+#include <dm/device.h>
 #include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bitfield.h>
+#include <dm/read.h>
+#include <generic-phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-
-#include <dt-bindings/phy/phy.h>
+#include <mapmem.h>
 
 /* mphy register and offsets */
 #define MP_GLB_DIG_8C               0x008C

-- 
2.52.0

