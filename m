Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9B5C48260
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 08:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE9587F02;
	Mon, 19 Feb 2024 09:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UNhpA3s9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF21C87F1A; Mon, 19 Feb 2024 09:42:09 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D808C87EBA
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 09:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d731314e67so27703205ad.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708332112; x=1708936912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ3MXRY7ECt5oypwaYTfOq8nRxkhmz0eAU6WSP2NLJc=;
 b=UNhpA3s9ljqD1GmtHIcMkkqjZkZFstRtSZmegwScLgQ3Xh9Rq1bCOLurkKJYkXwAGJ
 DbY2kPBbRYgQ154KcC1hvoPAlcQ5AiXpCPpffmFa2aZiBPkzglkwVx+0xTwlwzJCUjCA
 kNV2nhNeNIv98Dw7VRsOXCzc3TrRNjrfQ0CDzXXLPGRMTh4orFLxlGKv2KJguKl9tTOO
 phJVFNNzSNOUPBXWrQaSZ+BOUfRZe6p0jdYLvdsDCAHIm0TgIBt12Bthb+ZWXf7XF62v
 6evk+lUnNaWlwkxPTy9HvZ2OuOD7OuyC3dlTbuSR/QU01y5JTTflYqX29M3k7/202rzg
 ED6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708332112; x=1708936912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQ3MXRY7ECt5oypwaYTfOq8nRxkhmz0eAU6WSP2NLJc=;
 b=EdJ7vNQ0ZiBQ8Czs1XejSfFMi6iQN76Wmy0XV3vUceHX3nYrCDGaODSetnXKSZPY7i
 6s5Oal5LilRSkRlAEc8Z+3vlLhhWDnn5xv49JOLxD+Xw4GA3rnqY1A6ch8u8L6YlUyIv
 CGb38mbag7haf0HIXwNRXOEacBhzxBWZSTktkzoyIO5JhEyf0ZGVECkBhKNL3j5XWfk/
 v7PpCU/1sZhhNX5Qa2l8Nf9ESetVeQgi++BLj+A3RfV0zFk5RD+IHIPHThPjJ1jGVXeE
 iYj7HN9VBzo4tNAe+r/lGg0n6zj8zjP4S1LNJu1W1Bq4utZsapALhjKXP0fuGPvZNAd9
 HF5A==
X-Gm-Message-State: AOJu0YyNmxPetRfm87Bz8Aw+Ha4c0z7cOUp2+3QwYuK9KmZcNJyFHUjQ
 Z6B3OwxzVK2x+Z4mymmiElcy9CPNsGqsuAjaiTv7lirJtr3YMgAdyGqWnl3zoug=
X-Google-Smtp-Source: AGHT+IEAaC6o2uHqvEvKJIZCLBOtGliVa7fJrQoKwvEgxCU6v1dcIuuGGViAF2IMNh2xY1uiJuouCg==
X-Received: by 2002:a17:902:d486:b0:1dc:687:26d6 with SMTP id
 c6-20020a170902d48600b001dc068726d6mr432488plg.18.1708332112074; 
 Mon, 19 Feb 2024 00:41:52 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 f9-20020a170902e98900b001db45855528sm3797059plb.198.2024.02.19.00.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:41:51 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: caleb.connolly@linaro.org,
	neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] qcom_defconfig: Enable ethernet and I2C support
Date: Mon, 19 Feb 2024 14:11:44 +0530
Message-Id: <20240219084144.2881155-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

QCS404 supports Synopsys Designware Ethernet QOS IP and we already have
the corresponding glue layer present upstream as:
drivers/net/dwc_eth_qos_qcom.c. So enable corresponding support.

Along with that it is possible for Qualcomm platforms to retrieve MAC
address from I2C eeprom present on board. So enable corresponding
support as well.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

This patch based upon Caleb's series [1].

[1] https://lore.kernel.org/all/20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org/

 configs/qcom_defconfig | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 222db6448aba..cbc612b44bd9 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
-# CONFIG_NET is not set
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
@@ -65,3 +64,26 @@ CONFIG_VIDEO_SIMPLE=y
 CONFIG_HEXDUMP=y
 # CONFIG_GENERATE_SMBIOS_TABLE is not set
 CONFIG_LMB_MAX_REGIONS=64
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_PING=y
+CONFIG_DM_ETH=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SUPPORT=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C=y
+CONFIG_SYS_I2C_QUP=y
+CONFIG_SYS_I2C_EEPROM_BUS=2
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
-- 
2.34.1

