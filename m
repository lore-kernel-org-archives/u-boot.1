Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5DC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B27C8309E;
	Mon, 14 Jul 2025 15:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bxx8bPHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D0B82E52; Mon, 14 Jul 2025 15:13:30 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A16E383055
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so10360775e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498807; x=1753103607; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vRO6TsjtuO4FoYZFYI3LLk482AHm4xrnMfQpRXls1HY=;
 b=Bxx8bPHgI5xuC256gcICDKCZasU3cI3cR/2lh4Uh4b3ayNZyN4ye2ozV+GHa3vFZm+
 5DIe/pXLz28wI6S3dK2+skVvZ1x7GU76nR4ZJgk/9jjNg8rihE0Vlf6j0TFRJKsXEc/b
 ZPK1v+xx3dyrce1Ne3UuG7O8q2D83qFxdDrjGxHo+lhpCBLqdWh8u7Sjq4jBQ91iC/Oe
 Sm/1KPCNGWinVVOUgOo07HprZIOBhh+s7D9bepm6HbpQb8lAVXlPlBSQ2tuo3h5JJFzM
 +u2OX4NU7AlM/U8vS4QwEVvcfwhmOGmY3jq8h+GBGD0d+jdU1Thg9YM4bsajt5E0AQEA
 oM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498807; x=1753103607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRO6TsjtuO4FoYZFYI3LLk482AHm4xrnMfQpRXls1HY=;
 b=ggplVEmotSQryhZt/Yo+7jUFyoA/60oUiPEvKld8GmrYQzU3PwwHtpLHlZWfX0bL8Q
 DDabYNaUzk4ehN+i9gX9Rhxj1N5I1LFSUc+IwvoN0wtsmr/0ixDrpbbo1TYSidD1s7YZ
 Yn/iN6o3z61ZaeSvEMmrLQNfSrhI4HmYOJsdYT6/oSODEfVRr2bQ7R2WgNlhJhb/EEED
 Mje4jA2y8Mo/gqWPuB8PPtDDz8ZN5mfBQgCJbWqf2jnsOTtwMQke2dqu5ND3YFEes7pr
 NZSyvS5AydqB8YeklH1MUUime9L9ShvrMhqHjugW0IZnHggXY607iXDogdG3UKccCzjN
 UjQQ==
X-Gm-Message-State: AOJu0Yyz9EWTMAaky3C0gMjt7eYTwf9Igt3SdLsr8VO1FBRoQ6ZWwZQs
 VUOODq2wczQL0hSmBKjftEhked5tOO7dTVFKEJrdQopHVow6oRO+b+eeNqFk4EEzRQ0=
X-Gm-Gg: ASbGncsNotLkYC5jsFdtBxHrBNsWoJjotpKQp6XLakhFIUkkE440DNUVyWoDKbs7PMn
 KQPqtv+sO/C81WwZJ/E14/qDJKE8oMoMWVkNBFdbQjpq44KbOBStUdRNmUlz0C9DHp5U1V01+nI
 Z+K1hos1lNT9hqlcmVA3uZ9h9Khk/wx7ZEzKg71funHMEC6V1WrMwga+fLvzosdtIQlEv2d76ow
 Hsf0Yzl/5+lRiO5Estu2vmN7fzvI8he3htDT9lt7JwJ/4ZgxbzZTexjOMVAjAGbV8DERr7ZxTpQ
 Lk2EK7yHGIMqUBkQUc7bpWA2Q54hFIE8tb3khHFTwPrcHXq+qBx60D15FPk/2VuIIJtz3Wwrxck
 cHySfanTzy4tu7EQShqGdijBBxvEuxiZ8vrEKys/41vz0ukcRxK3AG2K/q0LmQLnOZd4IkB7l4N
 iZH8DE
X-Google-Smtp-Source: AGHT+IEPZxUz7pG47VHN4m9W07VdKd8qs7yJDGukKZi5bZaItJmZSCU5nAn6ayECCk/HXfaF6V2HfA==
X-Received: by 2002:a5d:64ec:0:b0:3b4:6577:eed5 with SMTP id
 ffacd0b85a97d-3b5f2db1739mr10058400f8f.12.1752498806994; 
 Mon, 14 Jul 2025 06:13:26 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:19 +0200
Subject: [PATCH v5 8/8] configs: qcom_*: enable QCOM_GENI where needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-8-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=+c8Izve2/yFtqFnP8AcucsceNjRjGif/OzA+OaaACBY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJrjP5yHB3CNGjbnQsB2Fa8VVIk8y+/X7oZa
 cjubFFmzhCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCawAKCRAFgzErGV9k
 ttVoD/9Sne8WiuPMXZO1zLSRp6eyjVJTeXUqFVl7q590oED3Q1ErWgLPpHM6aljf2cJyDfod0XS
 6lHXbgaSKs9V5n1kxbO1OsV8mkYFyBem/oGBlmAS+1ErsalFhBxv4ThBPcOh9m8xk/j6BOsfCFg
 dsRpgQ3Wflc0m0iWGdkRlpwzciZJAhiidmJW/kPjqXPQC6Cn1ceGm1r8lVbgtKEh7VGmsmk91Jp
 1259C66Qb8Ag5TPCbUB+GRryvHouwlECp5oyZb/kryA4vJUrxa0enbGVrrEsFds1V07j4a8hhu0
 LbRj5p4qQmP5o1C0xVULRIXy8jWLX1t09i2drkw1TeTlkeuIZo0iVsC+AhQyDDFKJOIG++o+D/g
 9USZw517CWezrL9DBBIAX+yd62D/QN6nfH3tzXYvwW7vjHFJAnh20NkwMCTUGOTJyD+aXCo1AD9
 z1Ql9/Knind4MK6zLEQRFs8DuNPWVYaDDLGjujRzAyaETuGbvRKwzPmLTV6BACTJYxssgknFXMf
 eVQ8fdT+PVd2vcbfMEgH0Ji0wObeLbgqiKOc3JxsxPhmekgcgMqkEFUvSal4MoQDX4wEetepyPV
 PuDo4UCvEVLlGpVVe5VNNb8ZkS0rIkXMCqBRbCYYElYck2CBt9qkwc85WukCJlKc7iTFtiU/5wq
 u/aQN3tQPhwiGqw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Enable the GENI MISC driver which is required for many Qualcomm
platforms.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_defconfig             | 1 +
 configs/qcom_ipq5424_mmc_defconfig | 2 ++
 configs/qcom_ipq9574_mmc_defconfig | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 4ce1bae54145e892d3389fa0ef49bc5c4df8fa03..0c40dc6198c62748979fe6a63be41a083d02a40f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -84,8 +84,9 @@ CONFIG_BUTTON_KEYBOARD=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
+CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 81c3865193d73e3f1fc85bd342e3f1d25534c81d..cbd154f81c396b0b10c3c208efe52ff4077e0b54 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -34,8 +34,10 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
 CONFIG_MSM_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 6c5706f4c08e35ddec40be8c1e44bfc5cba04fff..97c4abd41c495b47ca9cd322ec2b50c64f64530f 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -33,8 +33,10 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ9574=y
 CONFIG_MSM_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MTD=y

-- 
2.50.0

