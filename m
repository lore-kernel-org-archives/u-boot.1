Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC1AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F19E885AE;
	Thu, 11 Jul 2024 18:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQPWCyu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BE188582; Thu, 11 Jul 2024 18:46:48 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67B8883C2
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77e6dd7f72so145983466b.3
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716406; x=1721321206; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AKeE+XpA/9gysoPUCfIy5bs+CX6lf188HUaUxs5qDRI=;
 b=nQPWCyu47Gj2Cizn9OuPU2uJpExab1s1+63kDcIteeaAgazbS3DXpLs+yVLqURj10a
 esNc9m+we5qCjftxAdSgraGpZFhrm79Q4eD6QXBCWmbvOq+cL72E99y8Mc2QrBkJ1JYx
 2OIzPNJDYhQgq/zNSqJ/sVu+v8Xya+ZfbphXoU6K+gvftSf7HMpSdsfeq53sqSZoRcSe
 nLvi0TKYa/Y3rYRXAinxYMEuljOzraGUUrOpcFbMAMWxJuAaBwJIlO8y5XY/mtT6mp8M
 v/WsTIvPZL6ReTosLKrEntvuv6Kor/PUEv0n5bsB8KSzghlqLW0DOt0xQcOFgqgCBBa3
 KdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716406; x=1721321206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKeE+XpA/9gysoPUCfIy5bs+CX6lf188HUaUxs5qDRI=;
 b=ha1xt0oN+hblSb9bCJ7gJcTiq+CblLvSFbeDuEMi3AfG4wcwgY87HZiJ6aaBZ9yTIP
 XQtrgqVTth2ciD5qEYIKV8qqBUodckM/SiZ2UBpYua06x61B5eG+GzlklGylET+TJArI
 gKe8P5O/xCXNJsAvhUa8OSQEuklrkPZYfZw1PpfZJDjOPXEajW1hgwMF9//+aU+4AfG/
 QPoxosWLmiqzONKOCmeBbEUtmU5j2jvYZ3W5ePVHShuuBA7LPQEBwreqX27dskapoDzo
 e8Iz5b0UFoKCBEWxo6Psk5RWoyB0oWxQhIW6tTiRseFhQUVWWW2qCGuxQ0icbx2USjsL
 9Bkg==
X-Gm-Message-State: AOJu0Yx3tNF6+rabm/CZQJMYMfSndiY2N1GMKHqdcwrfgGz8SHdQ8o9e
 f8byIKK/yxPwOFeNd45v4pXwjNmEuQ7MAQMohqbgehLpTiIM+m8saq4eCP7OCTY=
X-Google-Smtp-Source: AGHT+IF+KAaKQGHTINrttuaj7yWVXsJscXx7t4fMSZQj5TxNSafGgKNdzNBua6kJN/GdzUrQZN/ovg==
X-Received: by 2002:a17:907:7284:b0:a77:e48d:bb4 with SMTP id
 a640c23a62f3a-a780b6887a1mr819104866b.13.1720716406209; 
 Thu, 11 Jul 2024 09:46:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:35 +0200
Subject: [PATCH v5 03/23] soc: qcom: cmd-db: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-3-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZK+LWpXNf5Jssjrb5gK9eFq0kKWgTy0b3pd+57mKEus=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxu9LUTgUpwG63euVWnJtCxbw2A2GyOPgy1R
 EAgFtk9Pt2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbgAKCRAFgzErGV9k
 trZZD/wNR0EzASVknZIJTFKOxTSa0Qvig1xFtwhWtbi1NGwhgNtpuhKoP55/F/mAKn8p9c/2QIf
 ZFeQLqwpgDPM122VO/o7am8Jt9Iqryg9v3eQ3gYbTAeATMQRgZ24lRteGBJGxHSQYzgxhGpTaTK
 tO839QntrK+7uC5iO5uKDJeNN1j0iMPwZA7MXgr0nCk3qtImVuDO34IvIg3eabSiq5OdBat68nQ
 0kA7L5YM10ey0112KaK36v/4i+3fIO0tIUO4401XL5vg9eRgGmjFpDPJqzLNx7F+ZlPw2bnO1Up
 xmoemWf3vwsO0VebseLX0liFTbfNQowsIiA1aZ0xCh7hCq+Vs2eUOPCY5lTdFPQ2TtFhG8YGgWV
 q9ooJBk64ODe/HRLu0ybD9V3hNSFOqNIbGTNvYWHaTJfqNUUbIJTpiZDLhMtuA3jxFuIMgh+wQq
 zbMHBfpFe3Fu/BQJzutTqBsc9zB+WJZ+chYyp+2DXmTQ7lBaorp11CO3mRpes0ZCoItBqiHFH+F
 58YcTrLB1QkVsiqTWTSaB09ckZNvjFYPcAxhS1QhWxtdhBtvN3PYR6MgYQgISzwSJ4MKEBFpVOi
 nFeCXdVNQrYOBa2g4QshpQWSUWwDQgyEy2Q/hTCvUM1+wSpBwHPWuN7OEmlBu3plzng/7O6J+nV
 mFbFvlnZu/fuIOw==
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
 drivers/soc/qcom/cmd-db.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d84572662017..685b6d530136 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -3,18 +3,16 @@
  * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/bitfield.h>
-#include <linux/debugfs.h>
+#define pr_fmt(fmt) "cmd-db: " fmt
+
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

