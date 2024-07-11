Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BAAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C76886E5;
	Thu, 11 Jul 2024 18:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lXSHlMxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DECD88606; Thu, 11 Jul 2024 18:46:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7374988452
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso142057166b.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716412; x=1721321212; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I4Ox7Kwu5FMiiaZkV2er0WxkRXREOyU7zsCxPFymEVg=;
 b=lXSHlMxt/nohj3jAHX/su2pY/zI1zPlyLv4lb7mvFkKx2P4/8WeOk2sOwYC905kIyF
 YhKS7b2QLTQ2ugDauhjZa0RNrw+WdlDQ6BQFpFCuQXIBzLdbFmPp12sSI8YKqtYGQ8SK
 P8WhFTFGCRK7BuxvXPUBv98OZ/7jOWvJVuVyeMpWrIRDBJEaVFWkifgFABEfxbctGcof
 v0jXHyZK7EnO4D2BCEYtcaArgnvcT3mLjFXlCiYdB5mZzJHzS1Rs3T3AcCnqYh+/LwWG
 P9hVQXhYCz1EhMEwju1qYYQqBO09hQRhUiD/OTpOAsAAjK1kt0VRd1xjLbuN04/ERbuG
 1ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716412; x=1721321212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4Ox7Kwu5FMiiaZkV2er0WxkRXREOyU7zsCxPFymEVg=;
 b=JCEozgmsSlX9zJsIw+4SmVhzLKF6/WaDvzuS2onmn5fHqc5J9CeuSsVvEGm8rrEGi5
 R8lDXQjyS/pmyiFyuYWe9krGhT3Nzz8ysBoPCDgyPqcw977hymhqa8n2CSkY49v+t2Z6
 clCDTOVUS+JxeH7vmF8ToHVwTFiXG8i/7oUTYTyq4Ji0g/6wOy6Hs0lIvLTHttmbxHvA
 LYidfTBJuTT8Nlry0p8JZ8/m3kgwG0YOoVcI3wn9MOKumz/kZnqMyQqNZN2ago26tJG5
 Lq0TvvYwNRKXYNYP9hW/xxOF6oz11uHJFO6482hdmjdu/xkkc8H+7OJQuTuAxgCAijwx
 2UJw==
X-Gm-Message-State: AOJu0Yzq7Mcw5a63Zaj2U3Cq4pLrcbmaQubimVZsAb0LYeDWyAbrv4ZV
 gAwZ7/60yAC5pXJgIAu2zf+ukKedeoVLq2eWw0sJWNr960+gLkvrrxNwIUYQAh2FPJigfGTHtp/
 Z
X-Google-Smtp-Source: AGHT+IGBrucTWQmPTTYuRc4JndiffCtuxdGlomsbS7Jr69yyEAwI6IQZ/E50MUMbG9npR7aomoI2fw==
X-Received: by 2002:a17:906:2797:b0:a77:c5e4:eebf with SMTP id
 a640c23a62f3a-a780b87ef50mr540924766b.54.1720716412000; 
 Thu, 11 Jul 2024 09:46:52 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:40 +0200
Subject: [PATCH v5 08/23] soc: qcom: rpmh-rsc: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-8-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ksop1teBSbFuBToeOvt9N1MWz1VgMds+DAYe87IGGVw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxu6O/OVxc4CvfQtc2qg9QkjDQsN0jYqRkyn
 5gOcAUvr/GJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbgAKCRAFgzErGV9k
 tuy7EACMPJxvxipUagbuLCsLDyPM6ItAvD1FV54bHsxmj/1Sm+wHwPTIAn+ennA1Nen/s4rzCbe
 B7D7k6iZ4S3eFcN9Bgeo5gaBL15I6Azw5vyGRWnp8hWv8Eb6Y8sfbLFP1hqjh+/saVFY/5xSgzc
 WygGr6o2j8c8YjgC2DKvXgiDQewi/uTGNKS703kWjZcJqrDXBBVnGIutXPgRGB7rA2AspJsQ0g1
 5PVucZB885RVl3YdBqUDRqrNPHlDygYmu/+hcQuuDFgrUlnpcx7ZWAK810ovZx7FGNrZH01ZSSV
 b6Zxrojt0xD6/iDlO3eFeb1MQ76xWONtpllG37kwE/oq5ACBNLys9/uv8QMDNcNlkxklNtSojYs
 gzffh3iiQkj1ceqMB2E3g/4XnAmFai55HjKZb11QKrBT0zZs+Nzs7M2LBYMhtxt5sezOdJSkZTc
 nZRt48K+rRUPc0bo7o9H6dzEJT59Ilk2iTzTvbKXHZrixuy8/N14X3+zRWXoTDg6HXvVnXFKYyp
 YWb8RVXhTGzrlN030cW8pP5uf2bcDHRc3Clnmig1PjN+v4LLJQWPh4epqudMKkWFZIsN/0/YvAW
 hkxnzBxF95EnilYmnURTe8Sp+0Q8UYe6HvYdIsiRpmOvzwTEl9Hb5RqNL20yNsTlK7OlrmIYORI
 HJxAhpCwxy3WHew==
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

