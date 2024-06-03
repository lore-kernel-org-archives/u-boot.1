Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708B7C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942F788379;
	Mon,  3 Jun 2024 14:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="quJOZDNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA6788348; Mon,  3 Jun 2024 14:49:26 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F2C87FC1
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso379393566b.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418964; x=1718023764; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5CvkkQQjVZUlt+hyfw3395Vr64sY/z9KeE8osvnQc1Y=;
 b=quJOZDNJclgsBEFnPflUbz4wshMJxcJzvVMT9R3IjkSiN0QExnkgGto4vxbbA25eJn
 om+tEYi8b3YBoEk8OzMlqy0qo6JEDvIv4fM/+TAhxpKaxq1gnbeVIk5vxrkTmJ4tL53w
 HaG5NP5C4G17iUHCiqDtx7X2ApMiErFDOScVKc77ma3DhYnQz9uKCZcyMnrTMyOq1H/G
 CmA6F5y65rwuXa3T19RBhKN9EQ6ClwXUehiKg3+1SYMXwnG0xE+oZmBB7tQMoHCz87Hz
 8i8S+8VFR/0YwDrXQSablnnL5hVPn39IGx47jcGlfEYYO7Ov2Tw2TduvKRKw3hvjNLtL
 qwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418964; x=1718023764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CvkkQQjVZUlt+hyfw3395Vr64sY/z9KeE8osvnQc1Y=;
 b=aKTxnXKqsZfVJc0G+wo5veB7IFkpGfOu0K7AnObJ3R01oDx+XyiikEuf/9skiNJGLw
 LGiENbvOoD15WyXV7KcGY5Enk3tLMqgVNi89xGV5iMKSkaQXkLWbRa4Io03dkxJtd7bK
 Op3NcCqQUw/JAwYhRmEGYWbkQ0AZ8KVuzwpAQN52K6OTU21bTBgAe6iyfOMRBI8HiN9Y
 GB41MUrwnVfBiiFXn+/IoTEYG29v7neHnKJfKkuLumw927Hdo6pDcYkDiGhDO8X05CTF
 6TRuabauwwCSDZJ/Gje1om1NyZJt569bXseZu7bhJQ+84iS9K8pB+TAWPg5DcZCLQ6Y5
 gpRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5X1rJo7qKeCL3jF3f1QVh7YUn11h1tVGM43a262IoSwsIl0QdwK17lQWdSNladiNOnxtqdffL4mABqGI0YYln3vLtUg==
X-Gm-Message-State: AOJu0Yw9wuvS2LIy2DcmPB9Eocaqw7ptmwdzNcaYG+LrXR6hYwsN8WRy
 U8sjRkilU3v7eT6B6pJ3XtSeChgTwRwI+xVNZDPR2N/z/iFV5WZzarlBhztJqkc=
X-Google-Smtp-Source: AGHT+IHNnv0EkBxUw+fKN1pjvCW/RfZfJzFMm/ogeV+Ic4BdIyRZcl2AUK8MR3qH4o8SYQh5UppfZw==
X-Received: by 2002:a17:907:9803:b0:a69:2288:41da with SMTP id
 a640c23a62f3a-a6922884340mr102606466b.30.1717418964434; 
 Mon, 03 Jun 2024 05:49:24 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:20 +0200
Subject: [PATCH v3 5/8] qcom_defconfig: savedefconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-5-fe2e083289ec@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xR83LA5bb4K9phi09iNVFjk2Jp7tPnB8GRgBaK5vvro=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvNczOivBzDXs1l9btft2o2g4TdXdBRGL5ef
 krA8W9FjhaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 trPND/9u+/2vRWy6megtuySP+qVqwBrdeFrKr/sCcjvDbZuSGa/ZzmNLlsXNvP+QFSEqrNEGfnM
 TmQYrwVU4iphpp/KFnxD8dL0l7l6mJ3q6auB8sHHqmNiOx2TXx7aLCIt08+SKs3LRqOyQHeiyY+
 G2999m0n8y44TjG7T5gxD2VPiH3p9uHCjx1phoE+VpoXXptJ9y4BSGpJGU/p9TKyItXWbpUzFeN
 pGgbsMCCSVsaJQKbqCESkfLpQbkpnwT2B7jJC3+dJKv75Q7JySeGVWEBrKbqXl5N10sME7+DFw/
 QpEnlxsn9Op0q7RF7riRbgXfBDe5WjQ0cQxfhoYN8J/nK6RpOsNuoyydlXf/wAM0/qzwvi69dwv
 +9UhoaYTzi0Ljp95rl3scfid+pL0hoD7AdH/Bl3S2mk4KmLEZQvcicYhIMaL5tjeJy2IJSKjVXe
 CQ4PGTLSUBSwaWPbSo0NtqzH32+ZAQKJREDcbWJeXHm4GmFOvUzWLLJas9ubuKSDHcDBuKtE6sP
 0tK7ZjBlkuka67QVOisrRobMSLnYo6YeivGeQCK05TR9bSmxVIpUXK9LBblht7BMzDWEMIf6Mp/
 cmM8MUvukHfQcmYCjJaXSiOdNfgxam3gF516PSr5UUEePha50H3RsBxWctlfz9CLRNPxBify4g7
 +fwz9nyp7lq7pfQ==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

