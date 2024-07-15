Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F70C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA898884A;
	Mon, 15 Jul 2024 12:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CpiXug5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7895188853; Mon, 15 Jul 2024 12:08:46 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8347E887EB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso5644134e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038124; x=1721642924; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SKvlBpz8RmPSM+u1cdQpsDXjklLDQjoXQk7ECpqhhF4=;
 b=CpiXug5mhS+Q2eIy2rdDAPhOqxHI86pUEUPKiHUv3HxE49srcAeHu0xe7+geS/qbus
 WqsDUqiNy1s1TpVVBpFM0mZm4E4PulV+KaR+bQIp0/SYAq+qr0DPXSSWz5iO+2tz2Jiz
 isCT/hzDkeIJGtr0HBj6rJT4yYplLaKCB2sXzQg1e9kiCwlyIMEzCYfAHHKk77W8MlxC
 Lm0HLDUqfZO94UIYMo9Ags7gbmyyspyUEihPjkdXhH83/Akviz3rJisBmFw81FtdqCWL
 m4RfPoF2Q2ueQNbozUGAgoKcKhftSsdcBRgpXAOWJfyGt6+esVeJVE5Zh/G7hxprToU3
 EXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038124; x=1721642924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKvlBpz8RmPSM+u1cdQpsDXjklLDQjoXQk7ECpqhhF4=;
 b=l2gGFeLiqrpo+ZupXsvlQSzo0H5kAep/wmF5F4NCyDeQKxRXQzviTCbOwmkqlSMwCD
 VkrLGZGiUpKBP4Z0n2CSWllXC8CtavgOS5KJ99nmpwiPgu93mx8xTWLT6XbfmWxAD1bW
 VExswVEeqy+ZB8JZA6+RwddRQvsj260DhNdhZwTSMWjuSNgEZ30K+MfX2wc2NKTeuE/q
 SFqMsVz8A3XXM66XIT2CsBGwwtdQVf7Knrmq6xQn8N9J2u6qiT1QLlrMAEANbaO/Ee3o
 WqtTyZTwGu3265794PswDjWIfsZafQMgI3mOcnQhKVkKFSblq61yFvTtEV7i8bxzziX5
 y7Ug==
X-Gm-Message-State: AOJu0YzoZ+rqBI9lQEhWxYdPExzRt/dVwR2+oCbvdFE9dPD5svRrLYjJ
 stGO3a3QjlJkLktk5DuQ21pYkFDEOoXKTa+NRj5UNG17AOf0ie6cGP7DwIp0Vh8=
X-Google-Smtp-Source: AGHT+IFSup5wl7MabkZ2ZmDGQYemQ90FnbxLsTaTyYTyQU6WBICWdxpv4D6GNVG8phAn5k7tYxnH3w==
X-Received: by 2002:a05:6512:b18:b0:52c:dd25:9ac6 with SMTP id
 2adb3069b0e04-52eb99a3439mr15718017e87.29.1721038123863; 
 Mon, 15 Jul 2024 03:08:43 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:11 +0200
Subject: [PATCH v6 12/24] soc: qcom: rpmh: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-12-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BrfeN3hYmP1FAjbb3m96AmdP4rR3yrnmrzgBmWKL9Ts=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUGcCuaDOCEaO9Gd6rcsBI4Kjn0IiHw98wN5
 /uMGcgLe5+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 tpooD/0eY2PNJ3mlcQDj5vxdi7rSgQJDmWtRlKX3zKqQsIrYkZVbyVKB36IKgeEEZCE0ISCCgji
 bYi7vrPhY6jSpZSVsYcdeBnWaJl9hNa6Eq5NQCBs3K7f2SVE4IvYYakY+52iVRUvEjjTeizEk/P
 29bLg96E4jvN6nJGTp8qpNXnhCBYYvTT82iIgNeBxn2iuTFTKx+ZsmNld/zCwu6RSzkOcBo00/m
 5yMmqyRkSb05qyuaRvf6p9yPNqY3EMd0pP0vkMQGZ6lrS4DW8ufnmI/mFJtRJwEG1prJ0NxB0EU
 /gFdrYE8LNUKjt2dHH9CWMlqXqRmf5naklcVwZLhuy7i4Hyqwhdai5X/8PaygV/BNkF2qf2P2vM
 50Q/AhwDu4ySztrWinofR2CZhzIQK0kTsvtPwtiFuKPhmaniv4pGz+Ionpu5KEr06O5P65LsghW
 G9wt7O+J4gjWCrGuTcHXrM4hKkgiUNFuQoAhHlvYO+6/++b4SWp8/lRUd5YrDZoI0iv0cytBC3M
 qD+mMrfwbHXEM6A3eDRPFd20ObemBm0L694HGVFLg+cGWIDBqbrTozHgftRbJ36RVg8yrUbv/+Y
 ECEYvVO1x3WU4Sj7/6V65mpkO5qxVRSX6pWrkUeCwqudqBLV5vBWseqNQ5wLp46NW/JPlWOQi64
 QJJ+pte08tKF1yQ==
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

