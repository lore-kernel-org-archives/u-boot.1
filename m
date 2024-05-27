Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CDC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F200883A5;
	Mon, 27 May 2024 19:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zkjv5vD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFE08837C; Mon, 27 May 2024 19:18:03 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA988824B
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e95a1d5ee2so67168051fa.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830280; x=1717435080; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=55O1ljQr/VZ6FjQQPUiTQTuEOls6xKyTMN6AV8avyHQ=;
 b=zkjv5vD6cRwMVndRV+VoKmywKto2izPo1hVlMugfzuUaNw4Q1eBOc5Y8r8uh0ZQEkJ
 8YZDo4PylAhUqgpjuUusaJjBCqdonwNFgprpObR+abfdZvVL9/lmRJPkKPit8zeGTxqt
 cbclcR2wUcLysjSYDneju8TCOFhkX2efpGnzRif+D256tT17KlcMNS+MLuOuv6+dLAVv
 i8UFI5NArFB+hly2KMDy0kBZXz7QA2TAAJfyZKnTjzzuFf/YLf+5dUOO0zCh5yrwPJN4
 GSoUOo1+4mArS+KUL5lmQIrUYr3HD4KyDdtw4nlfb6HywCxqiUx4/Xtc3AY3mTL0Zb1p
 DGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830280; x=1717435080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55O1ljQr/VZ6FjQQPUiTQTuEOls6xKyTMN6AV8avyHQ=;
 b=tD1qf+DJJzXY1arD0LZrtm0tgnDy+CP43UpAxTE3tnl+gBZcdBxPhUCX6dJuGkH10Z
 QO3hyCFNCXL2L8QUPeRaF1v1k0cCg/f9P3ddttJJskY/CwcjAtuRwXTbGO3zbwWwfdxz
 hPzr1EuYaW46RnJ/ou70s40DmFgrLougEgGCmC5KYfW93qiZ7Y2KR7jzmkepHQUO8QuK
 X0+eqbsNSsqOnx6725SNImUpHilSRYKt46GL/c3StJh9iODLHPQ1oWKV8rzt3+h2QlQi
 2Y5bZsLZtKGEbptJ3DjynHQDdedPS/0mO41K/HE31lbAM0AyeB2+VgdS9gWLY/PYyBpW
 EhrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPmfpCLso1z0h9ZoxJtSsrq06Bnc8Ivqrk/3C+iJ9tFZfpj1FhQKCe4iomSSIuIyd6n1KLcFSw85Rqg3oC2v6vg3Ouzw==
X-Gm-Message-State: AOJu0YwNx3rObBmptrtgHUa5BjYevsOcKgb4qGfXoFKBJ1BnxMU8NVvn
 Ieyx6kT00HLDvYH9vysjB2ZhyEuYWd3IWjP4fRVPCgXRGAlolw5zqhoSOzaRtO4=
X-Google-Smtp-Source: AGHT+IH4meV+oVou9g0kyJOkmKI2MpWPHavjz2SmRgN/xQC70TRSu29wRGmOBO3MnXUG0GF4pEwBEA==
X-Received: by 2002:a2e:b784:0:b0:2e0:6313:fe3a with SMTP id
 38308e7fff4ca-2e95b256875mr82607801fa.35.1716830280639; 
 Mon, 27 May 2024 10:18:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:18:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:56 +0200
Subject: [PATCH v2 8/8] qcom_defconfig: enable capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-8-47583d7ad428@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VNSLJAo9B7sSe22NgfOx2tIo486F6kDAs5FBx9s0o8k=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA+HUtpryZi6RJyne3OJ6GmJ7o+FQhSCFoJn
 Knvde6WgZyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPgAKCRAFgzErGV9k
 tgN8D/4uSuGPZ1FvSDU6ubgZXJ90ToBAY+X+PdX3+Lt6O0dd+z3plShoePT6Mxc350Ocv7jNSDx
 MyvK/97phsI5lsZDWaQpfYPOuzwVCIw9vN1qNPKCxgVnkYz3p4hN+PZ0EKI3wqbWd060/Ub7Cfs
 /jXZdeFE4E5wMvtq5ZxBLTKfplXPiPHaOiycSRzOiOzOYEiJKyD6OmUn1UveOXd2AafXzJbFjhh
 f4WNThMiZbrcTcqgGbgyJG1QyV7Ck8LJeWx9XIFewkpCU8jaMSr/+3O+5OtEE9hiJr2/dBnJdCz
 oJLS0OWAMy66BcN3Pq/Y3QvV4j7PrnctqysZREhKVofripsThFCZ3Q9TlER6loLHfAWJbYRBkbd
 3ckaMKwGLNFgfrELHCkxofVGei+IR7X20WbaeW7J8ggsVAIC5oOpk/nSVBKdUBKeFGkRlR/tHZc
 q0W+8mFAEmH/eDVwXCvO4kaZ9WGU/fi3aGMpiKn9ooZshoycFZxVrOvUUTNK5HCQUQJgzF6Y+IW
 fZ4UP9PRcMAn5aM3aLGn1oxFS9Cb+IrD1Iypn8L1fPZqMShV1PPd927W5tBc75mvS31vKIOvUU+
 u7EyEpxTpuP1OpkLeppTIkO3AUpSojlfdYbrdidD4YHsIK8vQ3jLsTB5UWlOMh5OKOLHTzOu+8g
 ZwYCGVJwsxum6JQ==
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
 configs/qcom_defconfig | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index f2dfced4bc1e..3a0ada9fd418 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -19,33 +19,38 @@ CONFIG_LOG_MAX_LEVEL=9
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
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y
@@ -105,6 +110,10 @@ CONFIG_VIDEO=y
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

