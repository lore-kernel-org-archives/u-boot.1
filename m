Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D98C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C9988698;
	Thu, 18 Apr 2024 19:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yXkueJZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36211886A6; Thu, 18 Apr 2024 19:26:30 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCE188692
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso11129531fa.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461187; x=1714065987; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d/wErtk16zYIKMThyrT+EkU6QGyKz9kq913d8psFgRE=;
 b=yXkueJZu4C5rN9KpxKgU0VXk15MFv+N5OkXGkCjHJ0ons/5tS3wayWDWw7bXV+TyQS
 CeKNf1cRnybulILEbI4HnIhD5js4NEqDa8b4HWtHvx79DKP2P0Ki0tnS52cENmiSvRr3
 YtzyIWyr63GUEFKGh3rqEd3q0R3RHfQun/WLYSRU+37ISRzRK3gi+5EqCMeSPyU6gKnJ
 LdJ3jfPiuksnEI01fVaaY33AufYintzCfpvS+V+YLqCybTJ6hE6U/HNXFXIJX/Bm1lP1
 aoNykATD5Fx8VIhdTjOrGpwh6rIrO6FRghN0q5JNilqiY3LpEUNBFuEe/gGWPDVJMkBa
 9TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461187; x=1714065987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/wErtk16zYIKMThyrT+EkU6QGyKz9kq913d8psFgRE=;
 b=Pr+/G1++pdIJpNQeuArF6zjK2dP612W7fsVOs5sKYcbPWqKshz5G+d/38rV2n/Zm4x
 p2rgmzI2aOnjRAF4CQQ805uwXIe0x416sXSa3KX2xfg8w5i+2i+7b8zvtF2hXGHL8XFh
 tiM257g6U0Qquo36QbhsxeXIhCzv9qQGdMwwn2ldK/nhLEIMQ3qv0KvqWu/I9MNEevgQ
 K+2/PFLDqdEH+I41EeDORp1ygoqIpuKLdtI5LLj57azizxA38Oyow9IfjqHqZCcx7boo
 OelNJqQiJv52oiYBmuC2E3OhRpMC0iBeqRlqeftQ/lfv/sHJETZ8SAv4NpA0q4b3hN3A
 F6Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/yqdvvJhMz1JVebTgmyT390EwCR1qhsaLx0Y0AUVDDZy+q+oRqXfw+CfcW+iM94Vr8Rn5nW4WxaXDv3nQwbKGT4EuAA==
X-Gm-Message-State: AOJu0Ywd8QaORxjEQRRuB2jTiqsdBkUJyuyyPM/EnAZB0H/gmssbbrHQ
 ZCbgmAB7X1q/ZO1HNkzhrnyijiqhApMMG8q5LFUESEI8IbdWfZplHs22wPi0T4E=
X-Google-Smtp-Source: AGHT+IG9ewn7e8vAT2vaLo05h0F8Z2h16rlhy0FrQcA4qF14Xqk/Lt5vdFB68Yicsj7E7uGqzLhm4A==
X-Received: by 2002:a05:651c:10c9:b0:2d9:fe84:a485 with SMTP id
 l9-20020a05651c10c900b002d9fe84a485mr2071238ljn.29.1713461187540; 
 Thu, 18 Apr 2024 10:26:27 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:47 +0100
Subject: [PATCH 4/9] phy: qcom: snps-femto-v2: drop clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-4-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ICCz9hpOfFIT7tLy64Sy4o+II72OOqyAu2y9tUZCKcE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H1zp3+Sbb25aFv5PP2Oyft1o+Vvt5cvdlh0WzlRY
 139vu8WHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi+usYGWYKpbZ9DvcpsntZ
 K13z8C6DZWzUi/Dp71MY/306/ex4Ngcjw8LF7zdoKC9ZEHe4XytEo5znytlcoXqPBpvbnd7LPdP
 7zwIA
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

There is a clock associated with this phy, but it's always from the
rpmhcc and isn't actually needed for the hardware to work.

Drop all the clock handling from the driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
index a1675b664e46..04f0f0e7817d 100644
--- a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -5,10 +5,8 @@
  *
  * Based on Linux driver
  */
 
-#include <clk.h>
-#include <clk-uclass.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <generic-phy.h>
@@ -16,9 +14,8 @@
 #include <reset.h>
 
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 
 #define USB2_PHY_USB_PHY_UTMI_CTRL0 (0x3c)
@@ -61,9 +58,8 @@
 #define REFCLK_SEL_DEFAULT (0x2 << 0)
 
 struct qcom_snps_hsphy {
 	void __iomem *base;
-	struct clk_bulk clks;
 	struct reset_ctl_bulk resets;
 };
 
 /*
@@ -142,10 +138,8 @@ static int qcom_snps_hsphy_power_on(struct phy *phy)
 {
 	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
 	int ret;
 
-	clk_enable_bulk(&priv->clks);
-
 	ret = reset_deassert_bulk(&priv->resets);
 	if (ret)
 		return ret;
 
@@ -160,9 +154,8 @@ static int qcom_snps_hsphy_power_off(struct phy *phy)
 {
 	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
 
 	reset_assert_bulk(&priv->resets);
-	clk_disable_bulk(&priv->clks);
 
 	return 0;
 }
 
@@ -174,21 +167,14 @@ static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
 	priv->base = dev_read_addr_ptr(dev);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	ret = clk_get_bulk(dev, &priv->clks);
-	if (ret < 0 && ret != -ENOENT) {
-		printf("%s: Failed to get clocks %d\n", __func__, ret);
-		return ret;
-	}
-
 	ret = reset_get_bulk(dev, &priv->resets);
 	if (ret < 0) {
 		printf("failed to get resets, ret = %d\n", ret);
 		return ret;
 	}
 
-	clk_enable_bulk(&priv->clks);
 	reset_deassert_bulk(&priv->resets);
 
 	return 0;
 }

-- 
2.44.0

