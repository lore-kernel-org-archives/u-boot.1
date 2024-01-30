Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337AAC47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8483787D07;
	Tue, 30 Jan 2024 15:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LW/tqz+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C5287DC8; Tue, 30 Jan 2024 15:05:18 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A1687DCA
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40eacb6067dso53523965e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623514; x=1707228314; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZMBVMiF0WqsYlh9tO2eg3irgdHcAcxN37g7zp/Pa4I=;
 b=LW/tqz+3A+jt5aFY6nOzOKX8UeSF13h51V6UmK7mHuthoCPmMBf7xeiuVgghXPA7pb
 v42nsXNRbX4xpihyKbS3YZVkOE5z1GW7Fs+U+T7OwRoSeDlwkJBljq4m8IsCqYvWga40
 MvXkp9yKmZgLQCtJF4//6KWrJ47XnMJ+Oi3whskEKsQyQ9MIdnhCXCg+2ty9M6og2kMU
 sonoVhHwANDz/mPF0i3AykE+veBqc4fNAyCbPJ+tg+ke6scA3Bi5+yF+7fvyseieXrr/
 AGfg8Q0CQb3Q+cYe7mT9C1TkAUmqXauY2SJwdr6W6RZzLyul0IbPqA2mFlWPNCyX3Q7d
 ftCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623514; x=1707228314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZMBVMiF0WqsYlh9tO2eg3irgdHcAcxN37g7zp/Pa4I=;
 b=n4ljn1qBs0tyKRVSfEcVXwn+ov4Xs4/WWSVbN+KOu035n7KS3an31/5m2z3A3temnc
 pGQDi2HwUAIUHYt1A/QNFVTbMGP1Q1QAw9jOICKGm0px5RrwbeGlbIJM/lKjZaDeSqPI
 72wdxGWnB5Kr1uIOoXWXIprCH9U6PUEDWTkcUmAoCDcfTDQ6KVZk7yHMiOecJ3NeNuKY
 tJUkAVjJoZ0cKY8WUsdFBBAc4WjcOsCns/SgaUnel4aHWdG6axAbRkxBTHt4uK8q8GpP
 sqn15h0k8ocSEC4O1RQFU30l/BUFomGhBjgLrZ6QJapkk22CJiMA5ll3wLyJG6UaJQ21
 2/6A==
X-Gm-Message-State: AOJu0YyvKFIRDyxOcDapIIB+3NnNdfIkeYSHYPjIPijJyQv9jj7K5ktP
 cHcVryUEBLfL1qmKvy9bX8MgpHMwiaYNidCU5s0exHfwxKlcAfRl5zho914CH7c=
X-Google-Smtp-Source: AGHT+IHZcE5LC1zQVFVigis5vY8iPMXkIbaI6yz0VflnSd0nMD/LPCQLCAsWKFE/YIg0e/nlK0hsWQ==
X-Received: by 2002:a05:600c:3b04:b0:40f:afc8:bb00 with SMTP id
 m4-20020a05600c3b0400b0040fafc8bb00mr538872wms.13.1706623513972; 
 Tue, 30 Jan 2024 06:05:13 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:13 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:53 +0000
Subject: [PATCH v3 05/36] clk/qcom: use upstream compatible properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-5-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0gGpZPGU/Aj6Y/ozb/GJEjFj/hCB904EqK7yiGK/+VU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAJrlm7U1HRappyV0W1xzqCQpcXjtpCtZF253L3U5
 IebApQ7SlgYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwERmnmf4X3k6Tb+pQstP4sOZ
 Q3rTfs7/8vW60E+59dJWSW2HJqjMvczwPdL/6sN7iz7rXelvNa44396xjkfnzZzUNl/VKSxRab6
 yAA==
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

Adjust the apq8016 and apq8096 drivers to use the upstream compatible
properties, and adjust the associated dts files in U-Boot.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts | 2 +-
 drivers/clk/qcom/clock-apq8016.c | 2 +-
 drivers/clk/qcom/clock-apq8096.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 6a4e3ccf17b1..02c824d0226c 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -75,7 +75,7 @@
 			};
 		};
 		clkc: qcom,gcc@1800000 {
-			compatible = "qcom,gcc-apq8016";
+			compatible = "qcom,gcc-msm8916";
 			reg = <0x1800000 0x80000>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index c0ce570edc79..0af7191cff52 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -145,7 +145,7 @@ static struct msm_clk_data apq8016_clk_data = {
 
 static const struct udevice_id gcc_apq8016_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8016",
+		.compatible = "qcom,gcc-msm8916",
 		.data = (ulong)&apq8016_clk_data,
 	},
 	{ }
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index cf1a347309a5..1e6fdb5cd42d 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -123,7 +123,7 @@ static struct msm_clk_data apq8096_clk_data = {
 
 static const struct udevice_id gcc_apq8096_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8096",
+		.compatible = "qcom,gcc-msm8996",
 		.data = (ulong)&apq8096_clk_data,
 	},
 	{ }

-- 
2.43.0

