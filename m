Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC9C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A9987724;
	Thu, 30 Nov 2023 21:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fMLI57S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F77587675; Thu, 30 Nov 2023 21:22:57 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C3587675
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b552deba0so14163795e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375773; x=1701980573; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gf3cBmQyShJKbFA3Uv5FmlKa86lloNAaQHHFpz16qfM=;
 b=fMLI57S6ciXYH68c5Atrw1InU2h0daHsqLa5fsij6PbmCMKFcTkdvLDFvLrOjBBt8m
 Y/b9Yuw4efsbFQf2R6++mxD6DuC+df28yb1506kPotveOVNU5eeJLu/lA8oo41Fes3SP
 pKjUuFCCn9IELIMToOIh2uOH6vlBF40lajdghK18Fs/EaCJUDu651Q/i+HADat+PewFl
 M1FjuwwiXepGUZz1IkCM9Xmbj5PEAiHdkJ7I3F9mtwnH3PaFnmvi/YxgoZfrdtSYc5//
 ayIjSgk6UO6ZbWTpobUsbwdu431LCJLcPIAkJxSQUJnyd2Xvo+5z8frNaoIhlIygV4r2
 bChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375773; x=1701980573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gf3cBmQyShJKbFA3Uv5FmlKa86lloNAaQHHFpz16qfM=;
 b=Qx2Wr3cfsB+i6Dau+NAfSoCZLpSLt0L7F2YF/Hq6iiklkMWCIc3q0i3OllZmt8lZ5I
 bbcWBtRVnrYAWRd8TACqQjqrFFYoRO0kz2DGMdC0GDzeXkunFpFgSy8RJ+OvdO6coysm
 uxZzq8mOuGLPvIQC8SeDWCfXS5M1LJY06OiCRMfaBFAu3YaYYRLFv2QJTQuNQnh1QfB9
 U1gI+Dt3GXi4lhhhqYaNGtBFZSDRaR2ympiMkI7zz9lNxceEiQqY3DPmFl7qCEXpGtpY
 DYJ7haeCbhqnopx3avIcFq5ZGUUvEvf4j/5lhNTG25RG0yOS9qDj6Nosj2BXOFpcnzKc
 6O4Q==
X-Gm-Message-State: AOJu0Ywn+KiEn3IjH4dgdeEqOKwcMASXBSwa0mS/2AHdhBDbhmUg36K3
 k7R8VpmmUwJGt7XOnGXYsVx7oA==
X-Google-Smtp-Source: AGHT+IEzVhhx74y1PWJxobjEP8S12earN07/dSSY1R5qXKpIUvAAmH6JDfCQi0OGR3YmBCel7tX8Ng==
X-Received: by 2002:a05:600c:a47:b0:40a:44c0:fd43 with SMTP id
 c7-20020a05600c0a4700b0040a44c0fd43mr43223wmq.17.1701375772924; 
 Thu, 30 Nov 2023 12:22:52 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:30 +0000
Subject: [PATCH v5 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-6-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nlJ/OYxMggVn4W/O03HUdzyvt07GEFCWbK6QOyRtWM4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92J/k5p8mjIbNv5QNZt7Z9eyrWs9NT+efa5i5rq2R
 oDz+IfPHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiK1oYGbYw9sveif7BvunS
 9wzDnZqru18fT7PP9A2ujNjg9J5rfhwjwzb/4/azldfdCZjwUWa2zErNKSqrD007WP1xbr+m9FG
 DoK8A
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

Use the upstream gpio-ranges property instead of gpio-count, and drop
the bank-name property for Qualcomm boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts | 3 +--
 arch/arm/dts/dragonboard820c.dts | 3 +--
 arch/arm/dts/qcs404-evb.dts      | 2 +-
 arch/arm/dts/sdm845.dtsi         | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index c41fee977813..6a4e3ccf17b1 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -170,9 +170,8 @@
 					compatible = "qcom,pm8916-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <4>;
+					gpio-ranges = <&pm8916_gpios 0 0 4>;
 					#gpio-cells = <2>;
-					gpio-bank-name="pmic";
 				};
 			};
 
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 0d9c9f7a4922..146a0af8aafe 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -132,9 +132,8 @@
 					compatible = "qcom,pm8994-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <24>;
+					gpio-ranges = <&pm8994_gpios 0 0 22>;
 					#gpio-cells = <2>;
-					gpio-bank-name="pm8994.";
 				};
 			};
 
diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
index 84224a8a3d39..3bb580ba4e17 100644
--- a/arch/arm/dts/qcs404-evb.dts
+++ b/arch/arm/dts/qcs404-evb.dts
@@ -378,7 +378,7 @@
 					compatible = "qcom,pms405-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <12>;
+					gpio-ranges = <&pms405_gpios 0 0 12>;
 					#gpio-cells = <2>;
 					gpio-bank-name="pmic";
 				};
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index cd5d890e9a45..a26e9f411ee0 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -103,9 +103,8 @@
 					compatible = "qcom,pm8998-gpio";
 					reg = <0xc000 0x1a00>;
 					gpio-controller;
-					gpio-count = <21>;
+					gpio-ranges = <&pm8998_gpios 0 0 26>;
 					#gpio-cells = <2>;
-					gpio-bank-name = "pm8998.";
 				};
 			};
 

-- 
2.42.1

