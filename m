Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBC5C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B2B80107;
	Mon, 17 Mar 2025 14:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lso/2oGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787898081A; Mon, 17 Mar 2025 14:25:27 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF75800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2510579f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742217925; x=1742822725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9CFYjmuBAfhFjes+322EOgHjoMj4Z9LoKbsOkPqiWk=;
 b=Lso/2oGzyT52GaAyIm2+RnyQasTNPIryUK5a6KnQyXIZbTUUH+kIeVJEcniqH7H7w1
 oQFA/osnDcyCUqpwhUhq4pSSTrZb164IquKpM4kn0IfG5XkdqKjqBFrewVT9NCZuW8XN
 AJ8+vyrwuJtOeYwLCuO3U2jT4EYGwXJAxVUVt++EI9aORaQNceQ9K2FrhKuXiMsKi7B7
 p8NM46rU/BA2nU84kk7mcbHVSvuaDTAFbttOUIIYzswIlUcuZ+66sPqIE0H6SrlWzk3V
 w32Pb78N+PrghyPFQ9bxfz7oudZGD7aiSX13n4llWLGYT3Oth7OhouNrtnLFnkLPb/ax
 SUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742217925; x=1742822725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9CFYjmuBAfhFjes+322EOgHjoMj4Z9LoKbsOkPqiWk=;
 b=H97oZ4YijY13ffqF9w+neMAHoa/VAkOPbGxRmQ4MA1dCDbOgRPKhsp510Ut03FY3YL
 eGOafsvvaTwdQ9g8OWya9QX9jzN6l1eEQAWrF+730k3HhuLiN07qoofsEOi2BcuYZYkW
 iLGnn5fAMtYoWniSDnZwWIvx9Eybow3BxeYCYYUmNawFLGZdv3DAzlOs8y6mbbGHlp5q
 cdKlV3kdyEbNF+DzQODh9Pm4PKBhSpBEXp2Y5HU0Xz9rKJil7olCVmN94HKB/Bwjx5K7
 3oCybilmPmqRob1kkdMPUJJkyPhQPpeiHgkinK6jTJqr2+5HXrfsTwUhiZLDVS3VkTJR
 9UDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVftuUfiX549qc0qzaUgG/TG143YHhF5xo/cbogn7L0dhh7oP4R5XCd4lnFYUmswWAmOjHDaJw=@lists.denx.de
X-Gm-Message-State: AOJu0YwfsllqsEP3mplQae/8lsMIq9hq2YxZ6r2hl6LZZ8N9KmORX9OT
 HQ6govyBWqtDu5Ks4Yqn5kIUF6HK4A3yo0dq8wN2t8cIQ9X8Q1tCsJkb0rPXOGc=
X-Gm-Gg: ASbGncumW9mepcyqseN2hVVNVPf7jyTRk0Au7sDfZdyVuU0Vu1SBLyW5JP1pWEPj8Ea
 ymHqc+qG3ouwD5dbIeA1peI4MplcAM/ir4JDEDdNhzx5Fof1vTAv3fow6TPOMGot6Neiwr1HUzg
 pQRoEb6feffMeVdpwRkbD+FCLCNrziyodzIr4I1OZkoXRGBJGRgA87+eYBANiAmbFacfAfqLwOL
 v1ggJgay4/uQrYFIWFt4HcJM4FK5yjdBSyxmIK5a5/BDDdwtco3U9LCdyxYLgSoG8XpXPbixI68
 /cg7v3MAcemplNA7eamy6LdLbv9WqmXEpzCuIbG4msI89Lo0sgl7bgqmRKVM
X-Google-Smtp-Source: AGHT+IEHBW6+7MY8BKYnStAhFfp61DyW18CWZbcETyZ4pE5cEVLO5tFYU5pBDh9kcc6NoXIyM7YWaQ==
X-Received: by 2002:a05:6000:1aca:b0:391:40b8:e890 with SMTP id
 ffacd0b85a97d-3971d9f2097mr11920863f8f.22.1742217924663; 
 Mon, 17 Mar 2025 06:25:24 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888117csm14773562f8f.44.2025.03.17.06.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:25:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] pinctrl/qcom: fix kconfig option names
Date: Mon, 17 Mar 2025 13:25:14 +0000
Message-ID: <20250317132519.46080-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A copy-paste error is starting to get out of hand... Fix all these so
they don't look like clock drivers in menuconfig.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 103ab05ed26e..f4a3942ee2f6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -6,23 +6,23 @@ config PINCTRL_QCOM
 
 menu "Qualcomm pinctrl drivers"
 
 config PINCTRL_QCOM_APQ8016
-	bool "Qualcomm APQ8016 GCC"
+	bool "Qualcomm APQ8016 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
 	  Snapdragon 410 SoC, as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_APQ8096
-	bool "Qualcomm APQ8096 GCC"
+	bool "Qualcomm APQ8096 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
 	  Snapdragon 820 SoC, as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_IPQ4019
-	bool "Qualcomm IPQ4019 GCC"
+	bool "Qualcomm IPQ4019 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
@@ -34,16 +34,16 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_QCM2290
-	bool "Qualcomm QCM2290 GCC"
+	bool "Qualcomm QCM2290 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_QCS404
-	bool "Qualcomm QCS404 GCC"
+	bool "Qualcomm QCS404 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
 	  as well as the associated GPIO driver.
@@ -55,51 +55,51 @@ config PINCTRL_QCOM_SC7280
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SDM845
-	bool "Qualcomm SDM845 GCC"
+	bool "Qualcomm SDM845 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SM6115
-	bool "Qualcomm SM6115 GCC"
+	bool "Qualcomm SM6115 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SM8150
-	bool "Qualcomm SM8150 GCC"
+	bool "Qualcomm SM8150 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SM8250
-	bool "Qualcomm SM8250 GCC"
+	bool "Qualcomm SM8250 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SM8550
-	bool "Qualcomm SM8550 GCC"
+	bool "Qualcomm SM8550 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SM8650
-	bool "Qualcomm SM8650 GCC"
+	bool "Qualcomm SM8650 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
 	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_X1E80100
-	bool "Qualcomm X1E80100 GCC"
+	bool "Qualcomm X1E80100 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
 	  as well as the associated GPIO driver.
-- 
2.48.1

