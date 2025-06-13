Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33DAC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C546582F73;
	Fri, 13 Jun 2025 19:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QVprEtus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AB782F8C; Fri, 13 Jun 2025 19:23:25 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6124C82EA3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d54214adso19586505e9.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835403; x=1750440203; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lbHeCFvnjXCyqU0k59eafUjMnLbKDn2DUrtddM88OX0=;
 b=QVprEtusxf9DHr6h0GpkkXBb1RkzoM9Xgpi9goT03MDoS3+TKswohiUtZcxIH5amZd
 iH518yth9hmXuHvVzKST/RsC2AdEaca9B65RYAOwX2vYFhdNWsS5C9FoksM6ci4tIOxj
 L6TCK/0ZHCPMeTyLMEJ1SmPsOrmJsOcgB4URzAz3Peo4WgV7mos6+uzNwgcKUSF/3CQ5
 joUtwPnxBnL3qlbNr7cDNG+T8egcqkVrc8xX93haAL6NKh+3gJyXveMYpXBE5QHo8Za9
 V1YFRPf+8Lql+JNkThNXlch2j+shxpydgbyN/3v7KH3ohSii/pFXCU88aDe3vuhJYnuo
 9p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835403; x=1750440203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbHeCFvnjXCyqU0k59eafUjMnLbKDn2DUrtddM88OX0=;
 b=RIHVkw/2Ux1PbcP/tSimYTHWHq6gX9cknS8Q9Qv4FxSwZ2KHGVTFIVTpzL3ZLWb2cM
 XqTynOsF2+D0b9bOjMEYY7dO0Hl7grVgVnKd652wwk4EffWf3peqoLMXmpGIY+nWQozp
 wJB+xvtdqa97FOVf6vg0c6A6+zhr+fFsi4fZKxTvyos0Zzv+b8p+UcH0LN05k42u/KE0
 qgHOfaPmc1+GHoyo72ItP8g4hpHAeN4IEzc3/INsOPOi+47gz7DKUZ27AujgxIrUFgmd
 WPZmZavsgmoO9kMHQ5yP5Tb5x7I0AvgXTN17ykLevZlgK+Bh1PDTRdum/fvKGuJH7ZXe
 ySRw==
X-Gm-Message-State: AOJu0Yx5UIG55qqlMckc8C0Doqn6pwlfjQiGneZsOACeSdPjXTFmcnGx
 fqsG/xFpUuvR12TKpRxt3J53R9ZqWNPqBDbmuMnBKbXAR+xa1JL169UlcVuaXmw/IOc=
X-Gm-Gg: ASbGncv/aWLuhs6pmPQnO9yP0w0XrWUAJBSvHGxXbDy+ZxDgAtuOERp+nabJ0DPMX0T
 zi2RitIc68ef5dPQvsANkQ8+Pe48nJGQpPTTtQpQZXtq0ZcUpXOeiZ4B28/SP2vm6t8wEhBonpM
 g+pgBR+7cqMTXkzhDGkDQnxcAXc9LS6+KhHIFmjAGWE5lc0CAnGR3/QVkHWJB8bIOIQRmwKt1ng
 a+PRKwQWqQk9p2PMbxrg8NlKpNATgJmVvchQOf55z7xRj/7RuG5dweQNYbjKr//+hQBy0YwJFP8
 az2ogLPmJFcoHZ5TgQx/PibuAmttD/bavh658gGtEnQ71pWPCxRaQzbbfo/v858m+SKw
X-Google-Smtp-Source: AGHT+IEsYIepFRCheA28u+5sRBcXJDfivsqz+XuPIbXh4rahBtE1bKH+1G6DycRsJdMo7TCkcaUohw==
X-Received: by 2002:a05:600c:5396:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-4533cac8fdbmr4522185e9.29.1749835402647; 
 Fri, 13 Jun 2025 10:23:22 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:11 +0200
Subject: [PATCH v4 7/8] qualcomm: use mkmbn via binman and stop creating
 ELF files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-7-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=tSbKOdrNxp7Wj+8ziwEvN1ykCw/AMOGG47jQp36guIY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF57x6PE+SKZeDmR9g4SL5UPLw5DwVZaNu7lT
 3hJRpHRN4iJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeewAKCRAFgzErGV9k
 tkVeD/9BFcniT+VfT98anf9mghOVmhY8OQbbLJAgHzGqr7sTcxx0krrR5TjSUgB1aWCTu4WXIM3
 k2pBGa6jJmhB8pprAdGjreYwSfdCvGVpUK0/HVwEScx2ZVe+0N9i8CRaet2w2oT/td+j2veDkW0
 DpsqbI905m4ygHlD1q+I0TGrdWPTyvaAf9oky4F6xFLMrtznq+MtAoBqHTeqt3qsBL12tgBYYu/
 Ki9D03f9HjORpCm6pyXCDZuSmY+QDRQbbodqTgiRkS3XsTwVxTBg+8++Gpvc8gZQEumruobbvH/
 NDS+ElkXdpErj26rIIyZmaMh+DAkfWM2DpTDH3uZrw/BpTb7D2Ln6p6UjMEnRGuyYnGL27Ev8Df
 UqdmPII0ulPVTgzuo0lrm1RCJIVNjJwIS8/DVwdcpIOQ/2Hrz5eUmTm30NFOFH2J0NzbsAqboGL
 trL6FfX2itoOh9lKTcjK3gYZMHH8Hf3n5jI6c+6dmOc1q+vuqxjjnmraJSQqiJNt4PrD4AAkRtU
 drG+jKcnhVkxrkoHJgRHtVSDYFs5qrAfJxEoKvi4Ql93qLH4R1PyyyoJseDy8l3VU2LEFuXBf3L
 838+SmLjYVb6/gX9bTN+uF20H3Jv+rO/CweIHpdnszr5rNpkv+F8XXswRVNYOXBvSNlTc7s/MgF
 Wy0DPNwnvupB0mA==
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

Remove the load address and REMAKE_ELF from Qualcomm defconfigs. This
information is now encoded in a table in mkmbn.py.

Add a new qcom-binman.dts file to configure binman to build a u-boot.mbn
file.

mkmbn.py is now run by binman during the build process and will emit an
MBN file for supported boards with the appropriate signatures.

This removes the need for additional processing of the image in most
cases.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/dts/qcom-binman.dts       | 16 ++++++++++++++++
 configs/qcm6490_defconfig          |  4 ----
 configs/qcom_defconfig             |  2 ++
 configs/qcom_ipq9574_mmc_defconfig |  1 -
 configs/qcs9100_defconfig          |  4 ----
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 579c8acfcb466122c4fe66950ec7ca24c355b43a..12f354b86b6c740a8ae4c59a1a48b0be6595acfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1107,8 +1107,9 @@ config ARCH_RENESAS
 
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
 	select ARM64
+	select BINMAN
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_RESET
diff --git a/arch/arm/dts/qcom-binman.dts b/arch/arm/dts/qcom-binman.dts
new file mode 100644
index 0000000000000000000000000000000000000000..da5d4a23d2fa960c5de6e1eec6dd982018fdd804
--- /dev/null
+++ b/arch/arm/dts/qcom-binman.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2025, Linaro Ltd.
+ *
+ * Casey Connolly <casey.connolly@linaro.org>
+ */
+
+/* Configure binman to build a u-boot.mbn */
+/dts-v1/;
+/{
+	binman {
+		u-boot-mbn {
+
+		};
+	};
+};
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaecb7a82c26a4bd7f5d1807ca6d4201c..63daa74a451aec5178cb9c1e58907ab9c9985d90 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,9 +7,5 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 6258d5dd5aad0367cd92f52b6a1f84367b7921ea..2afb930e103cac5801bea05f531f98ed046113a0 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -152,4 +152,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_WDT_QCOM=y
 CONFIG_WDT=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/qcom-binman.dtb"
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 8d7d3d92c73a30b246acc2eae6da1d7b04892691..00abc8430596dadd574d5d2b7353ecfdef01e2b4 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -11,9 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_DEBUG_UART_BASE=0x78b1000
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 4ceeba63ec12cebbc2124eb256a255450500152f..09e2c51d6d216f1f5c92c66b2eb30f38476d5792 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,9 +4,5 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-# Address where U-Boot will be loaded
-CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"

-- 
2.49.0

