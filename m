Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25D0109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CAE840BE;
	Wed, 25 Mar 2026 23:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KV5JldWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE5983CD3; Wed, 25 Mar 2026 23:33:13 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF5B83FD9
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so57381785a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477990; x=1775082790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUFSFfHTdHcO3cTTbrzkqOR/mmMBVaGfkeIV5sjztWo=;
 b=KV5JldWiGF7TkE6kYcvM/nSsQkIR/ow3wBaYzUHWhuoAOXRBLi/htSlpdCG+RpeTLe
 JtP1R/Kkyekb4UVrHASHW5+aw2YkegpwSAswPz9PInUgJFO+w7LKrPHZg2u0jLeI76rz
 jL5VSCEeDOQHzFXAQtdQUn4nJ45i4wR6Rl5HuLLlhkfN1taG3chhOHeXxakVrXTJy3gw
 DVeBLJCJyznrbWLTrIs4NvSF3r3lPD27pHbwumj9UcF9gnYte7hXDaCYLGJGHsWi7Ifm
 hZy3jeKeCZ07G5Zh8FqFMoLH4cba6r6IvNZrsmS1pBYA99dtRuXLcpDdWk0quYZC9Lai
 97cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477990; x=1775082790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUFSFfHTdHcO3cTTbrzkqOR/mmMBVaGfkeIV5sjztWo=;
 b=pfs8NvLVC8l0xbPdXi2RU3UFlzgfcq36xL+kVObI7QZVewrPamASHyxXWC7XsIyxgw
 +NqzQBjig/QrQqyIlZa7X3YeF9G/TLHGlfq/SE8dTFve5bAFAs3SKWvARNARavrwW+oa
 Er9E8a5rT8nmImwNRQA6T0C9yJ0oIY8XWkBADoLSvuH3wwjVVOHwuKs6CxGd9+wXoKb/
 rYQVB4sEaD0tP+bsc5HC5rygt3W6xYesBS3+0RJY4d+5LjB4cdssrH2SrRkP3X0k5/u+
 2ETqOojol6BZs7VpCDrGbgLAVP6JzWH6qUjUJ59yGrZGoJM2yJds3xRCMHK/TX0TGeCK
 Fu8g==
X-Gm-Message-State: AOJu0Yy/wrJSb3RFtMP9FO8NKgvbjPX+EPIKLfz/a0miaZTTm++OCpks
 1gAIbbEp3kZwHfR513oqh/75zlJsRkdm8ftvbynztHPf767ntYXtu+syywlRVEfO
X-Gm-Gg: ATEYQzxu8c4n1P4dF1Rzqq6XUjpWklgSmHcMqaI6G2K/NfDxcyr5uOKQDU8TDcssRbJ
 lMmAj12T2/kNgN1OYPsyDzWuGMu0XqUaPSWz/TSpBJwlv24HIvQ8IAX5Rrt99KgprUqFBUiWW1v
 KA7cMCUftj/3vp0EjgPBkn3ByGhWWv03FjM7B6bDeUNf0fKyl6AKn7Mjlje1dUVSPxVdVloS774
 zpSQysvGWPh3ULBH1AdLsUT6U/yE1s4xe9vJcpX5va/jTVwm+mu83s7Oe6AnYyTvi5uWeoBfVZr
 naCOZn63TTB2w0wDjQMeKseOmhvMbdM7h6H4OfsKi9RtDzEKBXCjDmc+l9Z6wR+HCZoPD21idsJ
 rA1auyv0bNL0yQUA3kR6pVNAapKRSZgZkek5Dne/Fdr08SYzPc/Z1BX07HFWHtdtAy5PXXhS5P0
 gyH1YtNVfRBZRdr850sylbVDFCl2Jn3WeF7RknEaxRFKejORFwRjnbBSL84m6R9UIQ3O528c03c
 t2NCVOoozE=
X-Received: by 2002:a05:620a:4510:b0:8cd:bffa:655 with SMTP id
 af79cd13be357-8d0010986b5mr790943285a.38.1774477989776; 
 Wed, 25 Mar 2026 15:33:09 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:09 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 09/16] board: k1: initialize clock and serial devices in SPL
Date: Wed, 25 Mar 2026 18:32:25 -0400
Message-Id: <20260325223232.1553212-10-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Raymond Mao <raymond.mao@riscstar.com>

Initialize clock and serial devices in SPL. Otherwise, the device
driver won't be loaded in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- None.

 board/spacemit/k1/spl.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index e15cf5f1abf..78f26616347 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,8 +3,45 @@
  * Copyright (c) 2025-2026, RISCstar Ltd.
  */
 
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <log.h>
 #include <spl.h>
 
+static void clk_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@d4090000", &dev);
+	if (ret)
+		panic("Fail to detect clock-controller@d4090000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4050000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4050000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4282800", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4282800\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4015000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4015000\n");
+
+	if (device_active(dev))
+		log_debug("clk: device is active\n");
+	else
+		log_debug("clk: device not active, probing...\n");
+}
+
+void serial_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SERIAL, 0, &dev);
+	if (ret)
+		panic("Serial uclass init failed: %d\n", ret);
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -15,6 +52,8 @@ void board_init_f(ulong dummy)
 
 	riscv_cpu_setup();
 
+	clk_early_init();
+	serial_early_init();
 	preloader_console_init();
 }
 
-- 
2.25.1

