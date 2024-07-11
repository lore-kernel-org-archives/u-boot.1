Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D0EC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2784688763;
	Thu, 11 Jul 2024 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aYT4fnba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5B688761; Thu, 11 Jul 2024 18:46:57 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46778831F
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so172854566b.3
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716415; x=1721321215; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SKvlBpz8RmPSM+u1cdQpsDXjklLDQjoXQk7ECpqhhF4=;
 b=aYT4fnba62/qlNYZ22nggy2nPXkYt6Xz6isla/Mvor7NaLeroCdRlVRGFTcFPF+t27
 FGnoJhqgyFqNv9iEFbtkfqY2HdEqsawjzawNO0JunEapPFUAGeHTHyKSD2WConXNA6Rx
 c2SasIa/F9BAaz/J1wKSbXrVlL57u83++Vel1Ui717fSnlVQHYtpDfg8OVXQV865GyZ5
 JDclEUcP+vFIeoJGS8aiXNeK22ai/97hEkgq4Vqsm+2QO6rbZPBaV+YTLeGzBhfh9HGb
 5d8jhy3+AQ7tEVuIXHWjKhF8uJZcf3KxlzzbftT+TO9uYP3rT9+oy0nUIbAZQxWtVxt1
 5nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716415; x=1721321215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKvlBpz8RmPSM+u1cdQpsDXjklLDQjoXQk7ECpqhhF4=;
 b=CRWuIMEtThoviWUCI0C1Nc1UXQDgjHI59EYFoJ6IA10V+tFb+VlE3xqw8MrcqdvFY5
 L3Z4tQo9eRfoXedamwVXtoCyPuMIlb2WZxSrsPwes1bWQogOOFH+8LbgfD3zFxaG+7pm
 hCXwxHBEiWvLnEz1jsS6H1W/2Wri2Ayv6T/RfiaZUc2of7FhVFuffXgvi6i9iBRfC8Dz
 LLzb2ue2jPj2je3/gttatLLDkFHrLiFak6p6Kxi89IUjEPweVw6xYX9Cc5NhPh/oTFhz
 nBe9yXmK6974XLegbGGEva+2Jc2TcjstvSUt/5H2X6PzhNuB90P4MyacHFGS4uU5EiS4
 dTuQ==
X-Gm-Message-State: AOJu0YyONuONd847Qsc/nknwEzuj5qEgoUGJclea0J5FAK8R0gz6UdbH
 zWYGQYJD+frrDFbnbnEYbmfQy5BJoJt/xmHARaroEL5Qo7R577F2gZRQR4rlSx/jL5M/rQ1Va0p
 +
X-Google-Smtp-Source: AGHT+IGCiSZSs8V/3x472hRWnCt2FrQw0+olGOlrUiywl+s5R3ACmsBkGWRTydH/qMseaInvOizwAw==
X-Received: by 2002:a17:906:3090:b0:a77:b410:b1ed with SMTP id
 a640c23a62f3a-a780b7016aemr543295466b.36.1720716415292; 
 Thu, 11 Jul 2024 09:46:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:43 +0200
Subject: [PATCH v5 11/23] soc: qcom: rpmh: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-11-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BrfeN3hYmP1FAjbb3m96AmdP4rR3yrnmrzgBmWKL9Ts=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxv/arjd/AQf0roC4RAdsdhkaIeDzcVtQkil
 SxPh+X0e9CJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 tkXiD/0cmd6ZiSKqmKduvcA+YI4YucydTnbOTRXzDJ5xwYaXd67nAVJpklwz21RtwS9RO+vIogM
 3BtThV0Y66QST5QBKw9kWvjauBam499FwO8a3eBw+cKWNPOsG4kpZiNfjbLR7IXgzqXluYC6p6O
 W7g77qiCMvJAiDe8V3UwW8ERK3idI71TOw2umLrPKz8nG2LmRMwEyGCGR7l3HhGeV6bFEcg5sEh
 5AXwOQNFa6xGPV8DdGNZUzQJELI3KOzMAPnO/vJiZyTwD8WE4P2kh4udZ+c/qSKA5+d8XnBZ2GL
 Jy3WOomFj1rpqRQA0hYPLFmqhQeBu23d7z++QAK5rGSa7aQ4O7bY3uQVf6/HsgUfCHg8ydlkIE4
 PqitmBA3HPd6zB9CX0HmRo63GZ4JRDx71wtTHsa/QsyuMeFy/1wGBrihHNFWu3hpAmGF6djFmmg
 ZKMqDXhsweKkHS4ycHEFYZvfApvO+95KeQu2etGO1UprCpb9vQAoB27lT4paUCVt00nshdZamKo
 pUc6hivACIIZQrjM/XuobjHPjx4i3RkJQH7LZdiDhQasUTAW0/5EfBCwdjSs/m4nDIyHfLgwnKC
 BqWhmDdYhOgVaJ7s7FnE29mYikBrEVnO3x6RQvau1UuGHjuBtA5L5WsnkI7fw/i4UP6pkhx5RxO
 d9dYbIDaoX0dxkw==
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

Drop unused/unsupported Linux headers and add dm/device.h for U-Boot.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8903ed956312..03ef4106c9a6 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -2,22 +2,14 @@
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/atomic.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
 #include <linux/bug.h>
-#include <linux/interrupt.h>
-#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 
 #include <soc/qcom/rpmh.h>
 
 #include "rpmh-internal.h"

-- 
2.45.2

