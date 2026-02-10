Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF5EEA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B26483D3D;
	Tue, 10 Feb 2026 16:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l0ywZ8iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E47B83DC9; Tue, 10 Feb 2026 16:15:40 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9DB83D3D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50145d27b4cso65848031cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736537; x=1771341337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxel+wBoujwO3BG8buPT181W65nJpHxTI/y+o7/seYA=;
 b=l0ywZ8iGol7v7PtnFrWqLqTZWWHo6B+4XRAMDGycFNhaC21zeWOGOwtbR5uhGcrXrP
 CmtS1v2fEzsKA/Lj6WTkDGGQngUfuP+iLtCGFDF05HAwnYuUSyIBCRwNs0DyUSFA1Iwy
 nWcjzCFh8H/zah85+IBAXZOGR0UAcx3+UQzl1dJ5u35K+QGRgzRlhgw71jSViekuxrM9
 NTOtvYkrGu8LDjBUS12ANw7FJSVJal/10K22KdcP7BGwV3buopN18nBykh4EcJdBk9oT
 gPe9/VKmeVso5JazAGrzyGXOI/ax4c70E6UqeiVGhD5PQXWEoOGVsJLs9ZCM5ch4aCWi
 QH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736537; x=1771341337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxel+wBoujwO3BG8buPT181W65nJpHxTI/y+o7/seYA=;
 b=XE/FOrPlcvBTu1D7FBScUfr4o2jtE6kz+JBZtGT+Yls9vHrbcsOl02JCjeNJnrxwCU
 zOJtWf6yPOEYHyq3T7bH9wxBgKngQ7/uUjEtCQtfhc2UhCQ48Azj5/1BEMDNZhCfmGFJ
 YWTIQCJaWno3/j12NLi7iH69o+hQv2PS8Nn44xHEc3kaWV2ntAbLtOXsAYOTjw3JfrN8
 yrEo88wSt3bdJUgHg+XTJLjKgoboywTuMBPYL4tPedD6wQHg7BHLrO1J+2LfWUll7hQm
 09/TxPp3vuog13Bg8fTb78G+sz0Z1nprJDcXh2U+60ZkwZ/4EhOk58tftGupo1LQsWX0
 w2+g==
X-Gm-Message-State: AOJu0YzaXPW3/t39OyjgtfeyCcVuoZtPo1AZKslmRe327ihYrj++Rv9d
 BRa6gRED94r0QuonXfAjALaWI9EK5VDssYDxYsrxUmVtPzcKCZej4s2ZPVUwGg==
X-Gm-Gg: AZuq6aL7Xu8A1bzPdMEloE6hLA0CCmEozxDQj9WK1vbfLZsRdymQVr1VD7Z7cvp4k2o
 hRZv0cQY4uBRsd/WThwjQVU+hlEve8GdRQTSmRuH9dYP/FnXeD4Oxdkz9Ok5wfsdYfWxnj9VirH
 JlKNsXF6HDEQJu3E8xvClGgvILhBAkWhAfiraiJ/5F7U3dKhqozST7D/7VjEAPVBLruaTn7VMAw
 rRJfeJd/egrFmX7eiY8HKfH07zkL3BgxJlLjo95Ae3bqlYhsfDUNXtst6St/0melnQiENba3duS
 uKavMLmCgXorGK10Quf1pTfAPd44fzI746bXqgeroQCywvTp0CHzioL+OPSJyM29SrMlmACQpC4
 7hVdXKUu0hGjTHVaCt3CSHR+ygDOzQMzXFZqak6cAXQ7sFZaxZ0f2nBDH+OyyB0H70UeF4jy4EL
 9bdXJF/f3xrNGcR2NjKevXjT+U90PqO3SzwybLNIVwj7YdMNJEst/oF3UHWERriVycSWruYkS/e
 WgXcaSUAqg=
X-Received: by 2002:a05:622a:65c3:b0:506:542d:2b3a with SMTP id
 d75a77b69052e-506542d2f4emr106642611cf.11.1770736536594; 
 Tue, 10 Feb 2026 07:15:36 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:36 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 09/16] board: k1: initialize clock and serial devices in SPL
Date: Tue, 10 Feb 2026 10:14:52 -0500
Message-Id: <20260210151459.2348758-10-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

