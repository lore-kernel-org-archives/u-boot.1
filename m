Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2433C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF409883A7;
	Mon, 27 May 2024 19:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bwQfKI5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E6B883A5; Mon, 27 May 2024 19:17:59 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAEA88361
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a620a28e95cso687366b.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830277; x=1717435077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X5gz1bj1mNTZaTfELXiIKSfiIlJNnxheelk7WqgER0s=;
 b=bwQfKI5S10dzUPJkwMQnmz44PB1itEToc6MSr9wDvfwCSntqMP3eo3RwrjHvI84U9n
 t83BFGtEAEBuCbKqt8f1WIn7dUjUWou46+TFxP6obM1v7pcAXbwyg6HhBf0DGXiX4qNT
 N6K0iCe0g+th/wHe3RTDhsl0Wphl0h3TJZp1mHmI5aY5WHPnYXr/o5JmXWs6EGBB5Dtk
 z7gBv7A+RTlVhxP3okVC4Jyy4NWZ9QAnbbokYXkURoSW9pNT1CNgY8mRuCbNA40wyH1C
 FnCMNdRlCLX/07QWBM0pCaPuTKWtgr3cfNkqVAiJyxEn07e300DJpq7NIkP0RX/WBewl
 7M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830277; x=1717435077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5gz1bj1mNTZaTfELXiIKSfiIlJNnxheelk7WqgER0s=;
 b=xEuhtGbJ/RXh84kkuPgNh+KbjyXjRH50xVzt/pk80GDXiiJDCziFuq2YFQbAkIOwYt
 2uhOOslIMifMMFG36B214Ci4XYfk5MuXShqm1Wd/shypOal9mtOCQh1NsogR7mXfgOKr
 ZUa37hgWrStSOXt7s8o+XL9k4PdWemK0QptIIyeoszZEjKVa1AQ+zW1DR6O3rg4nu/de
 MGJUevTewlTYcc9staqcrFUG7ZeW3uW/ejLc9tEWR49xyqKqIuiDt/97OgiJ+2bkFN9M
 Y2CPQT/9bkqKb59msjOprgTzECWzffvqa2agNcu+WezXbm4rMVUMMfaXumrqdmaLkcLq
 E5BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjWh53wGKWxr8sWWEMIANQxV4//ViZE0/9z8iBDVhKtCPMZbKETsP0fTW2KRxsKCuLQZZbLmm0Y+5NBvXRc2fxShhEg==
X-Gm-Message-State: AOJu0Ywp5n9DepQuY4DAFcLjbuKaFVtXsxlZssWjd3uI65gg7AJh6gUX
 mWvFRCOAZ7JvptGvgQb12scyRnESrro/PZ3M7YUSgjZT7MECrN54L4ID6optc+I=
X-Google-Smtp-Source: AGHT+IHBt9U3bCZsFpeuUv30OjS/WSG2/tuWsakC4oYvZ+UC3M371Qk11PKDRPkCwdEjnNU7AFea1A==
X-Received: by 2002:a17:907:b09:b0:a59:a356:3f6d with SMTP id
 a640c23a62f3a-a6264f01250mr688486266b.54.1716830277140; 
 Mon, 27 May 2024 10:17:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:53 +0200
Subject: [PATCH v2 5/8] qcom_defconfig: savedefconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-5-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=IpGQLQlKIhluzkgb3D3ktsmIpbCqDfyN8m8eIBSa9sE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA+KcRbtWimlvJ+7T0WKxBRnQ9DAunjqUWvA
 PDksCI1232JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPgAKCRAFgzErGV9k
 tlIPD/9ION3xw0L7fWkg0uIoo6xhEpn1MCPJ3TwPg09+rtfDN7q7a+QasLL1jQ9psuAzKfIrllV
 7+ZAok8IoJXDwGPoWuiiQa3wF+o/AgsRE93ip0DVfyK9GjOmgo/skU5d3pTe2pzuvwyxXWCMI8Y
 K+GmbbYZMW5/mv2eRjig1UlxtIlG6WGAXBTUjNEoYVg1WPkrkknxoD35WAC8vCm1XAD1szflS4P
 Po/q81yExdkwP8rElU0ZLtnnIBGkcJ0tpXptnkt34vHoyl7jfzIvuCvOJOtqVoaDAqxZrkkj14I
 iTTHEhIPAp/Czbmmq3xUvSzeV091vaZl2Mx6gvXJurqxaglKf7O2h59SwLDE1sxh1xFV60Gxky/
 2sX2xBuMbxkkZ38HpoMJt9ZxrFgwDa0dvcBXtpS1zcWvLWqgkfO7llIb+uS8nZU8Ora+tK4o2iR
 p/j5xztvstXS0ALj5AQIXE+pawoBCfufWmCv8WeF2go5XfUBkjO/fsyF7h7/J6DvWfeL7wvQd2v
 XhMqwKA3kezdWC5OxVjJESaLTe8ubZzRxoERkqV1EZmM3a7nJU1H8Tc486HBMaZ5XcH1NiZytMC
 EtUV3PBzkKnxOncr2FbpMYk6H5HIth6JJ32G08qQKs4OmGZ/yqiOWN45ZkCYM2TochSEoozVz4s
 uGZ6Z1qasiyFGww==
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

run savedefconfig

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 65f13ae7a089..f2dfced4bc1e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,17 +1,18 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
 CONFIG_SYS_CBSIZE=512
 CONFIG_LOG_MAX_LEVEL=9
@@ -33,9 +34,8 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
@@ -106,6 +106,5 @@ CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_HEXDUMP=y
-CONFIG_GENERATE_SMBIOS_TABLE=y
 CONFIG_LMB_MAX_REGIONS=64

-- 
2.45.0

