Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D8AC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B834B88294;
	Mon,  3 Jun 2024 14:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w1KM9yyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6450881B8; Mon,  3 Jun 2024 14:49:30 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35772882AC
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a68f1017170so165587866b.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418968; x=1718023768; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lsIZY0KzQXAG1zxH2t2OLiFyKGHkLCxaeTV1oOAZzl4=;
 b=w1KM9yyFpB71+7eorTWUAC8UHev6qWsOAlUxjB0gP3ScWqdOlB4GPFrCCv5HDiaT4P
 ORrLJY7D2JsWAw6TipUOYIp1kSSlP4z0Z7Pn5nuh9V/h80OpZId4YKVQEbG69iXX5Mb8
 VXgdsUEG/K/yF8VEKGMiSYl6f/DMV1dxI3QJey5NSWx/P7Iv1YPxqGaOZ0E6L2erDKyV
 Mb/sofHU3vCTas77sSsq9JdeigDF5fVwM75rujXDrKgebXArcNvfrJhS/iWHSH4WYzu+
 iXCM0hoaoA8Jn/NLegAPraEoGn2T8PFXAPdJisPtnw11ypU/TOljRr/3pRMBzxQxyyKJ
 67iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418968; x=1718023768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsIZY0KzQXAG1zxH2t2OLiFyKGHkLCxaeTV1oOAZzl4=;
 b=wjYm1ap7efTjtq5+GIytIimdCCAe2L8hasGv8D2VuKcvXXcYQVPON2f5b3beGiKXZN
 h8+STNNdtkVZDWxP9LGdzvQVZW3MnP96eYr2tbmtpsqeXvaqgmlUx4BSO/WKteruS0JN
 VoSiKDRqFGgy6f8u6fG0wWzclPuGAwmH1gnJoBgkKLketLhKOFQSUZ5x1TlXmy9WewLL
 IeOfRkGH+GFOMSExFO3CKFyKvwwFS8zaXTz10/N5nRXqyLr+dy7HliJwI81eNFhKHz8A
 VJGDsRZhit619/lGY4bQSXXxnhxeVjJtZOL4wTvMJ5uNdDDs3Yw4QK7bDzFqsdyiEkJf
 qmgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDSjchHM25Jt641XHnQYi3N1t3AhpTsBrB+71mKw3b+FAXAcuu0E1MgklUKQJLs3j/ZLE8XzJfInzg2tKZPyudJ1cHHQ==
X-Gm-Message-State: AOJu0YyYYeKpald/v0VswH28yrv/LH5szX7Y4fOfhi2baMdk+2hCgz5d
 dp4C4VN9dYn3b78WXBItgmxpMtPR6Xs4fcmQbPXgcLXYhZ7GL7e5kecfiH72rNs=
X-Google-Smtp-Source: AGHT+IHiNlnfLJaHJkR139J0cJ6PB956/A1IHkbPRoZ4McmDwL4zO4LccphQm1cW7DLQLnrdTld8hg==
X-Received: by 2002:a17:907:944c:b0:a69:d3c:bda2 with SMTP id
 a640c23a62f3a-a690d3cbe91mr224023366b.26.1717418967566; 
 Mon, 03 Jun 2024 05:49:27 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:23 +0200
Subject: [PATCH v3 8/8] qcom_defconfig: enable capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-8-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Bf88sm23VkxDn3TjsmUmB8CcS2N5ovQyDSQifX5rp3o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvNBFdXZ8h2awVkL8Q0kqru+aBB3odWHQBfY
 D3SStYyK1+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 tn1UD/401Nl/mbAF/aBtS484s3QxfTbc72jNz7rNigZWVJniYA7tF8XxzwGpJqKW63pL5oTeSuc
 AFBWQtskiesX1ZsIKORFb53rvGyupoWhBqIUz0sYVq9A6TLstqnIys9vxZPNki5ByTbc/cszzuY
 Sp6/GgmCmAdfbYT+SyplvWSHQGiyAbWI8cZSbnlw0jaMVMg/LOwgMhRWLQ9a4Nf4dWbzuGw3//o
 x3FJSib7N26EkNkogH1XNc93eXctXzPCAhW/IvDLWqqiF+Pzjbr8lc/MU0xI86AahQQu/g6Ct81
 FtGJUmx8QiA3GNM/aOWuXf+PFyEZwhtDdYzvcXSMFtgF8VzfB0FPpK+h0pGWcD+HuMDcva4F42M
 xX57uhWsIw5uomwUtd81rYRvT1Ze2bJViDAJTOT7AxIVClbEWvcTwYadJ08SHZ8UsLPFqULUpbz
 cZ3P9Y0eOEO60Em0nGX7fkpSncfTrra+HvHe+PEVkgS0J0GSv8gGiugeQQkyp+qhsIQjGVZVaBe
 GhSBlMs8msUueFKCokDj3nF4SJNM0T8RdDhFcA+MK14st5sy3Q+3IagbcyIDYaj09QB7geGYo8Z
 DxAoLn+YSeqU/F9FEHJaUevJnB/rkJyMRNUcVv9sJS2YYdt7SyIrrbXWmlJ/GIY1NJAVX+CKfkM
 rTn+mYhLc0U3QiQ==
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

Enable all the necessary options for capsule updates to work, as well as
a few additional EFI features.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index f2dfced4bc1e..d1de7158e3f5 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -19,33 +19,39 @@ CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 # CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
+CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
-CONFIG_CLK_STUB=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y
@@ -105,6 +111,10 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
-CONFIG_HEXDUMP=y
+CONFIG_SYMBOL_LOOKUP=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_IGNORE_OSINDICATIONS=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_LMB_MAX_REGIONS=64

-- 
2.45.0

