Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCD5C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C9487666;
	Tue, 21 Nov 2023 18:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u49rLRw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EA9875A9; Tue, 21 Nov 2023 18:10:24 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510BB87682
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so1828365e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586591; x=1701191391; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U8wZyFeQqG0OpTdTamCTfdcnFDhyijFZxn2Z5PtQYKU=;
 b=u49rLRw7pmEuPkmAqZ91J86ZPSNEEGZz91p+kTzOBg0zCFMztDPXhAvt4Z7wyRCUQT
 h4bDXn4mhddK4MPf1SzwCySuy2ZkNPaBs1mQVP8HOwdjzEEtrvyJhLsm4Bavv7mN6JBx
 H833snSKFsawVYN6wp+aq2h4UPlPzjZ1yeeW46EWy4lqpuQZaYnRKB5hPKkKdpdhhx6R
 9wo7prDylH0UckM6YMtDkhICyY16JfE3B64cw7jeqmXPMkuQy9jS/KQDrCCpkKxy6mbJ
 ZsKEOKhNkabFbE8ra6wpW96yKw0hFe8tV9Boz6r9OM09XEjn8T5eKdhU29eEXton0Ebx
 75+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586591; x=1701191391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8wZyFeQqG0OpTdTamCTfdcnFDhyijFZxn2Z5PtQYKU=;
 b=lnw1SzjAgz1KI94sp9LmI1vGPq5tVgAPXcZxq0huvFlark6QHO2QRi7tBvePqUr62J
 9QOqITRYsVw4QYdoWnScWi1dJ3kSzVy7c6emT2SK9Sj/0Vips6M+gvrSTjrW3vRYuCat
 lTNFeyi1jJYlApqxtLJYxJJe9IbX1Fw4DorKHUevbG5Iw4s+rLKMm0Npn348Gysu8uoH
 /QDo/ox4D5sScedOjoKZy9jdXFFFeLb+/GNmS18gnxkgJ5WoyTTZXw9ffMbh09tp7f5Q
 34dIORbtF09u1z+7hcqXapXLovUMLidJUtkeDw6smOdy5OCWJq2BGlQLfBVfIz95q6RH
 M8Vw==
X-Gm-Message-State: AOJu0YwxhGqsimDmz8TdaQnGLoLgG5ifKg/tdSOkno9Zmxz/Mrc21P1B
 rynwwSR5jJB9O9GhEELV2/LCUQ==
X-Google-Smtp-Source: AGHT+IGvptXkUGapBeOyFx8A5Xnqs0zH2vGI41GhEstMFSqhCrxcB3EqNqdspHFdHrx8aXpc+44eGw==
X-Received: by 2002:a05:600c:4f14:b0:406:f833:d853 with SMTP id
 l20-20020a05600c4f1400b00406f833d853mr7443206wmq.15.1700586590859; 
 Tue, 21 Nov 2023 09:09:50 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:44 +0000
Subject: [PATCH 21/21] MAINTAINERS: Qualcomm: add some missing paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-21-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=f07L4rYAmnX6+igOKiHQJoeM9WCNFN7iND7Ww5PjBwA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ+4JZ57f8N17XVwrNYZ7lnfUrBty5YZGImrng8K/B
 01+17Who5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyEYQLD/ypeLzvVQumVa+/X
 mXAzNlZOEL6sckxQylOEb3fxzieL7Rn+O/mbLD/HoFx08MOJ+3kSJRO4+Kta6iJaJ28S3Xppq+U
 nJwA=
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

Add board/qualcomm and the SoC/PMIC DTSI files.
Adjust the driver paths to use globs rather than hardcoding every
specific driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a4bfbf550ca..4f87ebfcabee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -571,15 +571,22 @@ M:	Caleb Connolly <caleb.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
+F:	arch/arm/dts/msm8*.dtsi
+F:	arch/arm/dts/pm8???.dtsi
+F:	arch/arm/dts/pms405.dtsi
+F:	arch/arm/dts/sdm845.dtsi
 F:	arch/arm/mach-snapdragon/
+F:	board/qualcomm
 F:	configs/qcom_defconfig
 F:	doc/board/qualcomm
-F:	drivers/button/button-qcom-pmic.c
-F:	drivers/clk/qcom/
+F:	drivers/*/*/pm8???-*
+F:	drivers/*/*/qcom*
+F:	drivers/*/*/qcom/
+F:	drivers/*/*qcom*
+F:	drivers/*/qcom/
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
-F:	drivers/pinctrl/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c

-- 
2.42.1

