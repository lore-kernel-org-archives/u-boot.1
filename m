Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8966C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327EC875B5;
	Tue, 21 Nov 2023 18:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pMN6iEjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B899487650; Tue, 21 Nov 2023 18:09:41 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90911875F9
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so8341818e87.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586575; x=1701191375; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QiBmtbjZUgEcqLlXdvcmsZskO1Rn1r1FSdqFrkP2Nt0=;
 b=pMN6iEjRfVH3CtLoKhHxTQLjhc8TbZN9dVPr0uTjNGujBuQvJo2L92CkKhxuJKgURH
 9aQXzvjkEWiZ/lUufHPxMFzNYm+0F4FQ56QDmzj0wqHM/f+6pdNDZRE/eQdbhjV5Ld5R
 g5/PM7LpNPoewov+0AW48eKO+TTDaZfrJnSbHKt7H6VtUORfNtqjitYqilD+ioY0NoXX
 8jksRLf9jU4zA3tnWN+Buemu9YniU/XPHtYUR/e7kxwmjGqQ4DZMSSmcXyWfZdzTeLa1
 uI6NElohm6xG3CliEbGbbgmXwPpnLWuM3WPTVNBweCvogucaYExXyupls5y3jjrPPhOg
 N5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586575; x=1701191375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiBmtbjZUgEcqLlXdvcmsZskO1Rn1r1FSdqFrkP2Nt0=;
 b=n45QoGMMlm4y4DW8oQCybHHytbBVTU3fw7MLWIuad5Zcym/RuKG5ANCo4bVJS3wdKE
 +mQJ69VRNXSS0L9Qgxcws5Rtd1mpLCEoxV3vbE1e+auDWAnOBbre1kRT+tU0MPMrXXpp
 8yxOItGJ8VlhLcpM9dLz02/6BH3tVF/xZBcO1Nx7sbHL99svjtSGG4LSax8ChQfRBrFp
 na7eCjB9XE6tsWmuGFMH/ZTSlx6p9NWgYtD//UemxdP/YY5lh4g+3ZuNUsIkt0iE2hRj
 qgE5y/0xcQC/BmDKGr6yuf9ssT93em/pUQVqUWtNnMxLjYQ8F6BMJE/2OclPyo6wFByQ
 S5fw==
X-Gm-Message-State: AOJu0Ywihu1uJy+Ww3RfFqspgtfa9BDVn7+3GUDuc2tVkjGFHMl6Noa6
 4f/M+At0WXGoNN6N5MVlP99+Tw==
X-Google-Smtp-Source: AGHT+IFNaHLcI3OWfFp9cPkaPSH0W6kQvHU+bCEnv8+i/CKaa9W7a9/qgFEO7gHJbMDlgjMsfB2kMA==
X-Received: by 2002:a05:6512:991:b0:50a:a5ab:e393 with SMTP id
 w17-20020a056512099100b0050aa5abe393mr7358015lft.61.1700586574970; 
 Tue, 21 Nov 2023 09:09:34 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:29 +0000
Subject: [PATCH 06/21] clk/qcom: use upstream compatible properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-6-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gKr87lVRqUOoN68BAsbJs8gqpiVUVEWCMjXxBq6PkmM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ66T5V3PBV2ZY+56U7d5h2Xo5Nn22/k0BH89/HZ61
 hVxxcTNHSUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAik3kZvme8qLG5Ov2y26p1
 dT9tnOYdfe1VpyLZncP87I5f3ZIv1owM7eFy0jtLkvii5HbOYJN4qMJ81zf+w5o1LG++T1T8fXb
 rYgA=
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
2.42.1

