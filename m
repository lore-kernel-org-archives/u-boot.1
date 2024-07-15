Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61987C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABE488823;
	Mon, 15 Jul 2024 12:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bSWfSOUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBCF8881C; Mon, 15 Jul 2024 12:08:16 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565C5887FE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77e85cb9b4so465205366b.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038094; x=1721642894; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ltZEpYWPL6a/RXFmFUmPQKBWq/KTJ3u1HmWmvStedEY=;
 b=bSWfSOUPH6cCQ32+xPPFlmamU3NusOi0aqXmtttFtFAh0yBFOxG7UeE6FCg31Wjnzp
 kxY4lCovA7PI4UgLPHWx3BQ8mIhkK+uM0pmHnGQlWjFEs31suPztY4rH908VKyjAIu+v
 hoM55GPwizbQtCC3Yfj3goDc5MKSXh1NS8gbTpbkoWxMNCmmtlDJhMlR+2dnq6lxxCpC
 RH5b+V71ANR15H5gnumhS9afBh0tp30Qhw7pGA5Z/GMFsEA2h2Lgayh1xMB0h2gPRlFw
 axizAZ+oukeu07micPoLySVoGumNLnNFlaZ3o9xxRaZ/le4e30nKE+Ng5znpd5EEDKV3
 JFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038094; x=1721642894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltZEpYWPL6a/RXFmFUmPQKBWq/KTJ3u1HmWmvStedEY=;
 b=egwWzWKYpN1yS43wVpWF4iqICi4lpaKBPRdSe3oEtpU1N0L76xaNfYT3sjvfWGeOo7
 dIKlWVKwPqJCVSxlwdm1RV5pG+SeijtpD/zZRCRLpi7qGW9SkR8OSsnGyMqjAOKtiS95
 /LBVhkbULKGCito4ZWNiBzXuJOa82kCX3BGKU6Y6k1cpWl18k1em2VluSFuF8VkQ/7f1
 IWW8kTcQLxh/9IfNPp8JBNCsbwsAu1MUUpWErqEW58b0v2H9IoBu+vcRzr8MIb+tTJk1
 3w+T11Q3+Fd50Nlzd0EfowhM+pWjynznJf+isf4Kr0Y3z2sJFnjdW5UGkWWBWArVoMp8
 D12w==
X-Gm-Message-State: AOJu0YzNscYafbIbSBRW5JUio8aX1fN2U51QQw/72RVRNZQZpJeqoVDL
 QXCuwgVcnoiX6EDD+ptxjq73XbZRvs1UYMCSSqDf07nIzEiNzPnB/svlLivWgsQ=
X-Google-Smtp-Source: AGHT+IGpxYgd8AYaTKDn2e3YcXAafOjqEb9Qg4BAdqfUBwUUz8iSLDt6lRBN7YwMAacg9D9AINS6cQ==
X-Received: by 2002:a17:906:e56:b0:a77:e7b9:fda0 with SMTP id
 a640c23a62f3a-a780b68a231mr1188082566b.14.1721038093838; 
 Mon, 15 Jul 2024 03:08:13 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:03 +0200
Subject: [PATCH v6 04/24] soc: qcom: cmd-db: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-4-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KqQWvKqWen77D+Indz1qnmLFZFG0noaBAnSGS2eyqtI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUFwf6qiWJedRZvvYn71V0TamJZ9SZRgA6Pz
 F6UGKt5WfeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 ts+dD/46T3glAfvA/L8zQ7PDW1uW8XObvJ16SMxJh1svSlSykI1v/DvdiMv7mMBt/ex4iZCN7Vu
 Ee9QW+8D89a2D1pE8LFO3dN37QT7jIHth8IUQdOa3hhr+7FbkzV05GyCaOdLDFRdPkxIcNqd+Zw
 P3nPrUYnD78ImPruvIJGnVfXfiRYEyLE+K7/ySU22tuD8PQ2PNcqm2RW8cm/HD8R0kkHg9yzP9a
 bmvqPbc+hIwuWWJQ2U4qTpoeSO4W7c4KpB//IIfvvp+0VCzGepqJkuoCRxpGjlUgoiPaucoeAu+
 S0J9dOeqburIba2NFsIVo25dRYX8ZJBESE2CBqGhZAm4AsUudrp8YmIgz5whQjyu6hh42l+0kHz
 cWFz1oHez+sJp2mwkXTOxQqxG9KRMgBX+5eeTkwHcpoqQ8SRIq6t+SeJi/hEX7LE4XCfJ7wWqRE
 4YvEOkt2S3hal7i7qooy3P6g0+mN6brHIO09E1Xxfu1GXul6KWV7XIDJ5eGElDdmEMzjLmxsc0v
 /bXkUmtPkVl9KKSRiFpUhJL+bKeVgBPkCRFgjLU37YkX4wYPgEyTScNjSd1aE50nFEWYzEQG80A
 IkI0C2pwpgG/tJHEwrWswJhoL83bywazgrsbrbDbSXaLsgFRm2EFPBn1wLaWpJy8hTMo+gnWdsk
 EtVtXJ9Ck4oLang==
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

Replace unused/unsupported Linux headers with appropriate U-Boot
alternatives.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d84572662017..b25f3549c18f 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -3,18 +3,17 @@
  * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/bitfield.h>
-#include <linux/debugfs.h>
+#define pr_fmt(fmt) "cmd-db: " fmt
+
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/device_compat.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_reserved_mem.h>
-#include <linux/platform_device.h>
-#include <linux/seq_file.h>
 #include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/byteorder/generic.h>
 
 #include <soc/qcom/cmd-db.h>
 
 #define NUM_PRIORITY		2

-- 
2.45.2

