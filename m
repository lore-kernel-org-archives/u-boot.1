Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F357C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBD887EFA;
	Thu, 15 Feb 2024 21:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iSM02Ei4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FA887ED1; Thu, 15 Feb 2024 21:52:41 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED12687E6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so571709f8f.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030350; x=1708635150; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cZBNm98s+8jVvBQjHUPRpwr9NT0SIeFPwfCeJ48D4WU=;
 b=iSM02Ei4K8hdZiF+Dfe7CsS31I6AOw8k2VvvOAzZxYtfbAmoal1UaIdMM7wByPI2qu
 VuyC5vVcWOiTZOl0WNA3vzitnuICj5dbLeK2sOJzEsTj+vHP16KRyTdLAUu9pdjoAjYB
 SJD34gdKZn+Fb06QGXuh1T2mCX0wmpkuBePpmamTYco0iNyBAPWlEGk1UW37e/GdLMhu
 AZX2Tm/9qwWG4Xq4xNt22BcmNLhNkVUjXYgAxIJm3jjgwtKDKguhmlPwDFGNWrMuSa66
 chuJCU/3VCTkgns+AKkBF+L7a0tXZAP30VCo5lAlcyfLdZ7hY9hQ9FZgF7H6mFRDGSPA
 YJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030350; x=1708635150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZBNm98s+8jVvBQjHUPRpwr9NT0SIeFPwfCeJ48D4WU=;
 b=aZ856N/hq6wkrPVGWbdXIH9EU+ZVomB+tLVxbKWYp7LCejxFoecpnoKgzceoOz9i2T
 kcAyFQLCp4WNYZIvGAIFLjdoauXl+1Z715nMECZLX18ta5g+OvkhrRlRvBLaYEmSXz0s
 JaCpQQ1YL9feYUGEPnXCvpaiU1HFvRUipSsur6hDr2aB6fqRsY3QplLmPpTYHjZMhtpc
 IHD1Oj2iz0bSzPpjMqLY70pbMP6hqGZaEwh0oAYuhOPnFpnOWqrN+1UqOyPitDOk9hve
 Jqv8YYefOf1lDIQfH606aXliChPtomYOsH3moogCde/qhgxDhr+1Ckh/w79EhCC6vcqw
 uwqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEzZyje7nbf4qJcrUpGZ2DoYn7d88oI3HuQxB2XaScBV/Ep1TngyoC8xyU+vjCvfLQE7GQ7lXb/GzejkHk/MSjbzgYsA==
X-Gm-Message-State: AOJu0YxpaoLa2HQehQLyQywluQb+hIr/PjqUBShu3Ag13tUjRxUe6n5X
 Ckz80M9lk+sBH0wTcNLsa96ONz39hxCSSJyAwXDxqK2eB4bX3P5GRPHVVA9s/kt6+J9BNSWS5mk
 E
X-Google-Smtp-Source: AGHT+IG5Py1S5bOzQnAWj//oMHCKdF+fsf8soR1ktcKvXPtqEPkfzwIEnl5q8hfCabvDW5uSQDnA2w==
X-Received: by 2002:a05:6000:14b:b0:33d:7eb:1a6b with SMTP id
 r11-20020a056000014b00b0033d07eb1a6bmr1719622wrx.67.1708030350084; 
 Thu, 15 Feb 2024 12:52:30 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:29 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:23 +0000
Subject: [PATCH v4 05/39] clk/qcom: use upstream compatible properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-5-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
 bh=R/BDL2N4IRweDQtqcfiPBRAskM2ezH6gCEbox/lwSRA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS0/W59dOShcZvNf63XvJ/vjJVXrFsj/WBDPWZk/I
 62D6ZtyRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIShDD/1C3aeXN0z1SK5bI
 ShVZv711SDpWfp/mxCsPfJ+6MoS+MWVkaElml1fSlmG0Wh3DHpkfK7Uh/buGf2luUofA92yZEwy
 XAA==
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
2.43.1

