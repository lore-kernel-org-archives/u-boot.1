Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A4D206AB
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC79F88DDE;
	Wed, 16 Oct 2024 09:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ociCVijg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B0A88DDE; Wed, 16 Oct 2024 09:44:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2450488D99
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so60139045e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729064638; x=1729669438; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gpsnpW3hOMoh2OLI5c9UMPVwWk4ktJrVj/MnC8opP1Q=;
 b=ociCVijgAXd/MC6Ex3Yvd/PnEz5BgDyU19ugwGeo5/YDrfd5zNemOXgUwHM3kXOUCF
 piWbOgcW/mJWJvIlTIK2NsGU/I+bv8fcu7OhVuZxr49JzQL07m3G/4glbOypdKE4ysHa
 htQ1JNyuNZHRLLFqeLmCWk8ZvKsT+bpIAHV2pwnQ1O+0sel2JwHhMz1XqHGl54u2HRCN
 HjrqE7O9E6C7IuQ7UCK5K//1JySuSgEzFghdaY2Ymtm2f/Wma7uUgTYP9bSCobWa4k60
 pZWtahDC7fJILBVMcJqPLLVYozInSg8d5GgCxYaHXHy/Zg3gaLa+YjhRak1+npiiR/gx
 cEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729064638; x=1729669438;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpsnpW3hOMoh2OLI5c9UMPVwWk4ktJrVj/MnC8opP1Q=;
 b=JBDweYab2ektLuCLRa9XeSwg+Q7j6fTBtfBCHDkIVqKvj2ikASHwdW8tHbiN7RpvEo
 ySJCNtWB7oRaiWIU08OiJlRQlLo0GqwRXKLViYu2H036s+91M0pnzwhYTckrv/oNpIPX
 f7bMSi6auouc8YYEuWGqRgTs478ESGGAL/vPKMXvohDE/WMBPWA8JDLSoo2XyHLemt1H
 gGlfuet2eny3hKaTA0LgfCCpdEiBer7UB4WbB7SCIMEEFrnC4W3YdWBg6WmX8GukUCBd
 Mo+BDX2d76OcYuGMYUSPoE3+jf/Iu5foM26CyZMGGyL/vfcKsrEP/DWSypvTq4Kcxf2e
 yxSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJrebA8zgV4Elx+gQVXtLvC3ypeDtjWrD877crQ1kA2kOFb/JUoEWtw/awvlRv6ZPKi87LZ5E=@lists.denx.de
X-Gm-Message-State: AOJu0YzayoTLFVhmB7UYJ1g7IROEddh6037CFj23lIOfqHq1cFQVu9XO
 yTJ9EpLJEwDj0E0r5lmU9AE3Fms4q8a/CJkrmNU+BRyCx50es+/saEEnedEeKWM=
X-Google-Smtp-Source: AGHT+IHXTi094dIuPmV+vJzAkO5aJkDqWY047Kbk8z7lmidcE/eL35AMg7eUlETinORO4CC0fRTM8A==
X-Received: by 2002:a05:6000:1869:b0:37d:4ebe:1647 with SMTP id
 ffacd0b85a97d-37d86d6945bmr2517967f8f.49.1729064638556; 
 Wed, 16 Oct 2024 00:43:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa908fdsm3582223f8f.52.2024.10.16.00.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:43:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 09:43:56 +0200
Subject: [PATCH] phy: qcom: ufs: drop unused ufsphy_v2_regs_layout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-topic-ufs-phy-drop-v2-regs-layout-v1-1-af804ce47060@linaro.org>
X-B4-Tracking: v=1; b=H4sIALtuD2cC/x3NQQqEMAxA0atI1gbaIoXxKsMsSptqQGxJVBTx7
 pZZvs3/NygJk8LY3SB0sHJZG2zfQZzDOhFyagZn3GCN9biVyhH3rFjnC5OUiodDoUlxCVfZN8z
 R+U/wySYToXWqUObz//j+nucFAM5dc3MAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vE14gh7J73ks+cxqDSUGYx7PHZEEB1nEsEsMN+k4c8c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD269H+slizJFwshcyUQ7RqO006KZSuZ4yKT0ZhOf
 LwMzE9CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw9uvQAKCRB33NvayMhJ0a7nD/
 wPHPwAO2OZPIvd6HFrMIwOxNYBMsEshXiqyh9FXjCfNZur7vNmf69pK8lRmTtmuKAzfyOVec4DM2kK
 o9oWgTW/wRcAdsizIbEvyluMyxAoSCjOCW5CkFWh97+wV3Nj5+prVfmAwG6AjeiQeOvwRnuOQxhG94
 wBrUakPuRBZcmPAADvt63zeUWRNnzo/z4nsal/KI33zMJSBQeBJ53kcoG23OjhPowXs5mB2r0yR7Dc
 K1pALYSgPaezxdv43iyf5MlTuBsCsKAFs3qAenJcdzm0e81CxftOayxNNgqmEE46cFTvmG++LQhKwD
 56CM4nZsMXrRTLtK97CtMhZFeydrQtWFQUg7vWFSifNSDwky4S+SzBIxyYKXnD/j+HsjU1Z4uqz+Dj
 ct8lCzl8enwRD545JCLxKFBWjS7P8IyFYMUy9qkYLjQEwnhwO0NyIL+lUkg0V23YjKqeS/39o8MwA+
 UVi7EiBT10TI1pNuAIjuOGPdlWN8O19xAM7OwT3QtpFtoP+Z9mMS8m1UUAhb5RDQmWTWKAMWXXbOmw
 GO7Mh3Eh2TDGw+MkQv6XoayollhjlToEvLxgvFdEPhhiFDsImOkF3tqt7Xb4qWvnXiyu+nCR06cW4w
 xmjLOrGhpL1ZCVZ210qu9gjbUT0WEkDsI9D2uqT6JuqlKI4HMBlkALsZogyg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The ufsphy_v2_regs_layout is not used, drop it and fix:
phy-qcom-qmp-ufs.c:87:27: warning: ‘ufsphy_v2_regs_layout’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 8908a34df54..5b17f3aee67 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -84,12 +84,6 @@ enum qphy_reg_layout {
 	QPHY_LAYOUT_SIZE
 };
 
-static const unsigned int ufsphy_v2_regs_layout[QPHY_LAYOUT_SIZE] = {
-	[QPHY_START_CTRL]		= QPHY_V2_PCS_UFS_PHY_START,
-	[QPHY_PCS_READY_STATUS]		= QPHY_V2_PCS_UFS_READY_STATUS,
-	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL,
-};
-
 static const unsigned int ufsphy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V3_PCS_UFS_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V3_PCS_UFS_READY_STATUS,

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-ufs-phy-drop-v2-regs-layout-fc269a6d1d0c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

