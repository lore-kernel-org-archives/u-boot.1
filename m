Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6931C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4238D88578;
	Tue,  9 Jul 2024 11:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KU71vCxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118A788599; Tue,  9 Jul 2024 11:34:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5160788664
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77b550128dso613776466b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517695; x=1721122495; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2AVF5Lzv70w8S/EdmcMD32pgoigwpwC5JAqcaXbVoJg=;
 b=KU71vCxSTNmP3Zv8WlFd4IblYR81PefybFqemmWwR7l2YbvJyfbhpnOQd1UvTax+1w
 NbBG5dmRdYcd1V92OL8tT4a7VkTEPVQmr6vxQa0dhQERjBYdd7GNCLijfRvYq0haMgdw
 HVZG10QfTRRHM2hhtNWcIOKbXa343FjevGxSJmCBaHOrwDU6U4rG02IKQbkHKbbngaZ5
 +qXVwdydIZ5jfTS4VqKsmB7YSBrcAWVENGfp/USGyDZIoCoeBbQqRyb5zrlowqrTykJF
 GyPdN8EBwkr8jMbFJgTbrK3u5+jrUNGaHFmibfnmE4P/A8ScuXONCOzy3oV/+eherE9f
 o1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517695; x=1721122495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AVF5Lzv70w8S/EdmcMD32pgoigwpwC5JAqcaXbVoJg=;
 b=FsB2oE1RGjMzjslj7Yw8De0pAbJ9cqqYE1s/zBZQj8KFXdwv6EC/MECF6qFEiDlEjs
 RExz47Tw2ETDbp5mMPByowowXJNx1d4FaytBKohTSBsqNq/jff+BX1M8X2Y1SfpJe10/
 eYgVCR0YDa7MKr8ei7X5YAVVcdVJtoaKsxSqwNToWV1E4kes3CTF33wJRMG1COEfeu5F
 N/a/eOPrX+E/8sHwOZ+xdfYfaiTEP88GuvOF5DOZTBJKT/VAgR8rrfjnR972kvntut1V
 HC61fYlKu4RPrSwA5OUL8pffu65wcPzRnomwArYx7NtDdf6TCxJ83r7orsG2mGjH34Wj
 Hf9A==
X-Gm-Message-State: AOJu0YxDyboHJtdt9qeSOSJszVxdXbY8TB4kKQvvchliaInQ7rRro0es
 28kQ0RxKYb2wEPhc1HZST2JtA9T0XbrtstUPq6y4SWrEx4pOHwryu0DDSifzvCs=
X-Google-Smtp-Source: AGHT+IGi+WLD/9GokZqRwEyBmGNRQV4vIasMRLbCX8lwZE9/XRjNljH6ZctkDmbc6WDZdTduAPvaxA==
X-Received: by 2002:a17:906:32cc:b0:a77:de2a:aeee with SMTP id
 a640c23a62f3a-a780b7053damr185125766b.43.1720517694888; 
 Tue, 09 Jul 2024 02:34:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:36 +0200
Subject: [PATCH v4 08/21] soc: qcom: rpmh-rsc: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-8-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5kthcWvZijZIiOZrv37rl5wqz4iBZ1saBHR0C4JT+Tc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQzXylTzRBR4+/qOuzfCedp1eMRpO5fVzUAd
 6l3wnIAdmSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMwAKCRAFgzErGV9k
 tszTEACb/V7LJ3HJ3KeTpeGqJ0qLxCBewUlKflBaqy198cS5oLmp4oSo3QDJ3KdHbizm9L808mc
 X8VWGWtQQnmup2qqZ4T3cimQTq81yOXlz5kA79yl8j4db4A2a9c3FRq+4fqVU79+PxoTX1II2d6
 0Ji5LIjKqvpeHKB5FG7ceBnbJ1Gr/V9POXvTv2g1Jf/qV+iyInxDHDH9x6oxz/ZOo1bgwId8a8S
 eN6eIJGy/Zr6LbxwOc3k6N0UnVk0YEm05gwakQEF7+XbulD0wvXZB+kufYOUG+63OXWUM6FDmD8
 SWtzDdBd2/oqwSONex6MejLA2OuBumpm1BszMzF2/jy16GfC+DGZEa+XJEvunTR/0RAtdb7rKYS
 HEUOlQbTtiOliBK3tei7v6NfeEBRvNJmB5HQF52XXsYVCxFa45vdWNYKVqlEbkDvw0KmkrJbFzm
 Rc812V1kwZb1dBr0yxAN4LVjtUQtt96Dkm9Bdy8PVA/FnvvLkswAP0Ti5YYsyBjtu8DVXvyN2cI
 lmroOePv7oguu65aM1jdzwZIT63HwgXRHBpIWDviQRbJzhaEF2uCyOX8KEnas4pMOm7hThAhFKx
 J5affOotral0enbjI0FCt7/pZffSLZOheE0vI2DugaHdVAFvGn00DteYlRmoGwmoEZShIs+Ro7B
 l+haLU+eV1PaqSA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index fc8321bf208f..c09214552cfb 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -5,39 +5,28 @@
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
 #include <soc/qcom/cmd-db.h>
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

