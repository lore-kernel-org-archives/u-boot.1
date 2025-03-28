Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD87C36016
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6352981E1C;
	Fri, 28 Mar 2025 11:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X7m8+3nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A4981E92; Fri, 28 Mar 2025 11:40:34 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C2781CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso14213685e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743158432; x=1743763232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w4BEsl4FVrt07LGFq9U5rhMZA9nltq/XZfwsuD5HU20=;
 b=X7m8+3nmiiD04vI8JF6qdBWUvTcItrLVPSdwhcGn0GvFSYqHYcv7bWXhumrXOwwp9f
 Ql+FpO4az1PveJe6vyPIgisrZNJOotBiM1vl0XPbxjgNTjgCtbUgMUSHpmbQcrIJteMv
 5FgqTnDn+wKl2CNaVAWm+/BXFohA2fHRQsf7i12qG7QI4aWpjRx0q4y0xG3FI8brA35H
 UPWBEXZZSw7+k2JlOxAwpHJkEuxdv0FLuBaSwJTrkpHbTS3IR7I7MlWwxRRnonxspswB
 yg68EwlikFWrzKMkVtCgVaoFyLAP9J5eROZy0rjTSJAG3MdscYuW1VBagnKSiiJvX3k0
 8BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743158432; x=1743763232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w4BEsl4FVrt07LGFq9U5rhMZA9nltq/XZfwsuD5HU20=;
 b=fXy2V3TOo0AjmKp6oDERCY+u39mZuMzDb4zWrGmCBGoyU/RwAx08usYT0MUCjJ45k4
 5Q7iPI0NTvTENox2emqfoHnWVH4SZUlTVq2dn8izdt3uOCb0U4yqSIqqYE327QDjGisI
 kyJg+AaVVF9OSBIpF+rlnVuHw0x9+hoOdqfbePyusm2pqPQBVDJMW42O92sHnhLGmMbS
 6YwCePDa0KQTfR/uMTcGAPpqhlqSB75V2eAbzQqIjO8coqUAzY0YfeDITL3qB+szQ0Qy
 fZzA77/v65oYaJu3ozbrMbAf6y2GC8A++2kNMpjxEEY/Kl1m3F7kMV3zITPsU2y0cOvj
 VmXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK6NMmlzWc4Zj/+dQkHks9zhv6gYC/PODwH/WNJ9BkqbU2J2yGbGIFWiw95zr3xy3SGH3AUaw=@lists.denx.de
X-Gm-Message-State: AOJu0YxvJrcyiXzV4usnWSTXQrqUDHtR8AJ8vTzx2QrYFN/EzrlIZq8c
 7PBYi7Li1cWL69+HE7AHvoZOdX/Y3jq9Pg77RBa9dQOBmRF269Fz1Kn9R5bZRGU=
X-Gm-Gg: ASbGncvLwp9kJ9rgEN7J84twd7Y16jxa9erNc3foys6GAH2FaIi2o9SvkquZLxUqCoJ
 KXLaLTpAlFVuWjw2zQxm1aEcgpZNJ0FbCXgNgepHaREYznZod+n+LzL3+YM43iYTk/la+WqS7QB
 EA4ogB2vUqLjoajiZd2NYC+ZR658HKF3LmrzmvS3vORWWylVokxauyv/rJ25HJTrtbW0TEKsJ4c
 UUvDg5VV50Popu0oz3FonoLmu6IVSLcrGjTD0VHOWDWctLp/HBM5fZPkkoJPkoPuOL3QL1ZBxCM
 C2VM5V2i90yAEMETlNMLgu340ZBh9edN/EHAUnYXkNPs9CgoZIuLGLxTokC1UAynevMX+hhU+Cc
 MpmVatIAixdzbwSO2xRvu/JE=
X-Google-Smtp-Source: AGHT+IFmLmaqxJjbBAUiWy4N7tvd0DOic+OhVSj2Kim3vRY6CoPBdJXwPXPLl2NG5yUlZXOUt6Jwzw==
X-Received: by 2002:a05:600c:3c8e:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-43d84fbfeb8mr64570095e9.17.1743158431663; 
 Fri, 28 Mar 2025 03:40:31 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314bbf1sm64757915e9.38.2025.03.28.03.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 03:40:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
Date: Fri, 28 Mar 2025 11:40:07 +0100
Message-ID: <20250328104011.1837872-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

A single U-Boot binary can be run on many different Qualcomm boards just
by booting with a different DTB.

Simplify the build process for this by enabling OF_UPSTREAM_BUILD_VENDOR
so that all the DTBs will be available after building U-Boot once.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ba4d38d100e0..a12a5d17b406 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -40,8 +40,9 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_USE_DEFAULT_ENV_FILE=y
 CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
-- 
2.49.0

