Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E30DC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C429987745;
	Tue,  5 Dec 2023 14:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GOnBq9gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA97870F4; Tue,  5 Dec 2023 14:47:07 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819DA8779E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9f85eff28so41619331fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784025; x=1702388825; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=alb04N3oaBkRkGdVa9rxQCjSq3ixOo/r+A2MXjNtWWU=;
 b=GOnBq9gwY0m8KUNNi+pC/tmBLnMpMoeb8jgOXSy4v/dijqOOcjEGXIrpT4oyQj9qOU
 nH3JT1r4ymMvholG8u4lICL4tvGkhN81vTmfdTQZAg7rm6zrRJmToKZanX8M7GkzKZ1M
 XNNNARqLiYZUHlJ4WAu4dj3EQz6u/YpaWJVoHcx2OQLqHclJuGq4nz0MrBoxh2rAP6XW
 CukWws2PFm2ejOcl8rYIbXeFusW5ziMRDnVkdERp0IcXrXUw5VNFG5pQ4Yig55Tou1CJ
 enHUZBK17AcZxHt9u4nPfAJTCbaHrIvJEB12ofEFYQDRzymoEHND+QePhX2qoExXq/QV
 DlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784025; x=1702388825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alb04N3oaBkRkGdVa9rxQCjSq3ixOo/r+A2MXjNtWWU=;
 b=S6HIEzh3EshSAK1OZn/dg65LOYTrpCFbkqTpivbXk/2n9MoxaJsRhf6A4Ayuoo5o0Y
 xkUNtE5U7w5yfS6UGV1aqtK2QECDGfjo/mvuWL/W+h1oWzTK7fWRf94TbIDwMUtTEVGN
 eFXYCxMh3tFPI6T0TpxyzUZoyqrDFmGUF/sJ1hOzwhbrVxyRpROQxWoKYDPmL7d2ynuG
 KW33uNT2Uq4R5//K1T5qQq8HLlBYnyvpCgld6bY+ISa9o5sJHfzAZiN2eYUwn+IXxMsM
 IKezA/3xev/YKMlMnnV+2DqLMcmM0vCiNUNT2FRJyKyWKYiwmQfBfi4un4yt8s3zoY+F
 RFtw==
X-Gm-Message-State: AOJu0Yxc524KnSKvu8m6Aa0NaB9RDJh86Z+vMjqs5Ocm7DLkrk9h07FR
 B21UzYuNaIMaRa+YN/SNTVS7vQ==
X-Google-Smtp-Source: AGHT+IHy2eN0GSuAnArFtPBKM5V/QpXWERvu6ex0KXmjDe/bibJS+3W4LsrgV9dKxyZn2Zfn2dR+IA==
X-Received: by 2002:a2e:b0f4:0:b0:2ca:f0:47f6 with SMTP id
 h20-20020a2eb0f4000000b002ca00f047f6mr1660662ljl.10.1701784024959; 
 Tue, 05 Dec 2023 05:47:04 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:47:04 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:51 +0000
Subject: [PATCH v6 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-6-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uPuJrNlKNVfI90nMq6KonKZn0x/ra44MAMSOWoTg69E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zXM9Nyf8mvntvRz/PI+lW33+2157zXaL16dH/Xhvx
 quvxxN/dJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJzJvJ8E+HbZVtxde3L5nN
 n7xdlhy5QjT3xiPxTO7Zr/RKZnSFeEUz/FPN+zvZ7/+KDey/HwXbGb6Q+9fksMj2zx77RXxmhzg
 2OE0GAA==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts | 3 +--
 arch/arm/dts/dragonboard820c.dts | 3 +--
 arch/arm/dts/qcs404-evb.dts      | 3 +--
 arch/arm/dts/sdm845.dtsi         | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

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
index 84224a8a3d39..bd2e303e10f4 100644
--- a/arch/arm/dts/qcs404-evb.dts
+++ b/arch/arm/dts/qcs404-evb.dts
@@ -378,9 +378,8 @@
 					compatible = "qcom,pms405-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <12>;
+					gpio-ranges = <&pms405_gpios 0 0 12>;
 					#gpio-cells = <2>;
-					gpio-bank-name="pmic";
 				};
 			};
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

