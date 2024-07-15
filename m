Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9195C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84783887EE;
	Mon, 15 Jul 2024 12:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AxM9Styu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9B5887FE; Mon, 15 Jul 2024 12:08:23 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2752C8881B
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-58b0beaf703so5082155a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038100; x=1721642900; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5Jhey9+f1ctZXJj4kj8dZl2T5kKcAZR8OhsfmJbg6g=;
 b=AxM9StyuInNgJxlBEvfwsvwqwlIikW2MvLqaHjh4hWU2iRuvJL3fkeQQ5QwO+8ql/k
 8wEPtbRzooZGhQT0UmsdXPjzk0zkJxb7Z4xYdcPek/sREmxEkyNbE35CJG/LKLUbz/EZ
 0zYLBKCswm4vLVGkSVs4IXsOShdbpTubq5Te6aJEYY9mGhIOIsV0YfGgYEopG+Qc8fn+
 KoM3Enu5PBbQGpE3Javf3+1GxcVa4GeOnE9wxV16O7Fjtm6fcqWDbNhyNCyS18hWB8es
 8yHL/tVDjVzt6vb4zVMpjpK5CHus1R7HPT2fNEgy3YlaiBsoNXxhyoWKDiTYdCfdsmCQ
 8ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038100; x=1721642900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5Jhey9+f1ctZXJj4kj8dZl2T5kKcAZR8OhsfmJbg6g=;
 b=B0370XrGTd1WUpPyOKfgxW2q3JqtlSFjJeJcHGkjhS/YaCA2239q6q4nslPbSz/iIV
 VP/+lgoIIGzC0LeoVvcsVmVd7D7429E6IzrRNVof0EDMAhSnta78PjyRal0coMU1llZv
 PssZNh4T5u/KbLfmKFqw4ISoPS2ytG9plVzn2B0mIa1eLl5zPS8XegifkVyJzHRQUE0Y
 SznYn9knuCHeEAmo0McL0ajmzm0R6bUHOXQPKM0UioyRkwqsKR9mgIsJecDA106F64Yl
 6ae78aUgwuvEK+by4zhoJ1n4YGoteE4iGihC0hInLFBuO+GRxYRjCS1JuFjUglWjyuyE
 FR4Q==
X-Gm-Message-State: AOJu0Yz+M90gi0hVLbSi6kQxXCiPbcaWr+x8APos9s4eOxL58p+pkTBR
 7TZAkQ4hcy0jcTVgth+2WISASunl3TvmwpPiEzYsaG0r6hWGrW16ioh4YvSFVWTf2BtG17l2KDy
 7kZQ=
X-Google-Smtp-Source: AGHT+IGtzPaedVH10jcqbJXRMLK8B+/tFzzoZMC9rmUERFMzkCZjVL3lj5O5oOqJ2XPxtbxHae2QXw==
X-Received: by 2002:a17:907:9687:b0:a79:81a4:faff with SMTP id
 a640c23a62f3a-a7981a4fd08mr1224527666b.66.1721038100688; 
 Mon, 15 Jul 2024 03:08:20 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:19 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:08 +0200
Subject: [PATCH v6 09/24] soc: qcom: rpmh-rsc: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-9-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=OluQtwpeX7wRycFAM1tC9sPPwIq/cXlzKqKVg+yAZLo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUGfMKlwDr1WUaAJQmLhdlRzTXl0SLGnRr4z
 OsqIyOYzb2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 tjsUD/9Jjp2q5n85u2//+8uHOvijprzSHW1XFDT0AlJD8vYScjxk/WnbAFRjKy75i9qLenoOn6R
 kjHAskT1TY0M4WJU8W3dXZTiQ4LF7NzVcaNalR5HUzdDB01xyyyVJaGSYZtHThi3punQZ1NLhTS
 OFEG5GeBYJ5tBzrQ8bg0fuYkQ5h/EIbbcCancHSY2kNVcL/GOd+LRqB4HXa+ynVg0YwSKQ0d/as
 wd13gH3CQixkfV+d7rdEUhCwIwdpKN18eVk77wghAr67WoMDSoOZjZUBAhnNI4p/7AH2U6D0HwG
 68VeiS18CnoTGjtsZPdCVCcnWepIvIcGRrBHlmYs7zUW0bt8tGb1uWuMMwnYDEWfzHoz+z/6bQJ
 lZ7jY3f2j/AnrWA/8dio7HFdqkXxZPjkBi+dsDleSIRfpQESGOQGri5cAtFCga/LlBtMfug85Lz
 PmBARtGmGij9TXK8ZldifQ8RDXCNMZpkxRYyj0xHGmlK+LQwD09nerbzpfbboGSzUzyfGEwvt0n
 rP6uk3NugS424PKFBFcgG4yBJ+mGp5uxXiykRYc6t1W/8sFesS9FXWnrpSeBP/hqS3TXYTU8F2D
 rbqvyfGiWs4hs2YyBH++/Vv22wfVFQhIjS9z/Y0wY8KHs3EGSqDwmuUEpY/oWYp33wdIgDT7dKK
 iLowfYfg7n1Lj7A==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Remove unsupported / unused Linux headers and add those needed for
U-Boot.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index fc8321bf208f..6b47c8001cac 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -5,39 +5,27 @@
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
 
-#include <linux/atomic.h>
-#include <linux/cpu_pm.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/kernel.h>
-#include <linux/ktime.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/notifier.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-#include <linux/pm_runtime.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
+#include <linux/err.h>
+#include <linux/types.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+
+#include <log.h>
 
-#include <clocksource/arm_arch_timer.h>
-#include <soc/qcom/cmd-db.h>
 #include <soc/qcom/tcs.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 #include "rpmh-internal.h"
 
-#define CREATE_TRACE_POINTS
-#include "trace-rpmh.h"
-
 
 #define RSC_DRV_ID			0
 
 #define MAJOR_VER_MASK			0xFF

-- 
2.45.2

