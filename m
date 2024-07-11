Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DD1C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9124A88792;
	Thu, 11 Jul 2024 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JnW3oX38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA2588765; Thu, 11 Jul 2024 18:47:01 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6D0882DC
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77c9d3e593so121629866b.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716418; x=1721321218; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EI1m/5KlruCoT6RpfHcQgeJV034qnLNtuNds708jBqM=;
 b=JnW3oX38qigCYLiPZQRq72AGdhRKBomL/oHX3qoM+T2VoHEsjjeni3xH1g44l3eTPd
 dEaZ2EByChYFotIz/9F/rIGuDEpYAtOu1+4epYmIaJ4dsYutNLVqiqt6ZhBT2tVej/pd
 cy9Y2IAvEZ0KA+ARBj982pdkVJmozmYOrhi9LLqIez6+g+NN4JpB9BK4+f+lhPoDP3Pk
 8g0FwEZ2XFBavbqQOMsIAllyAIHanGflyrtmZ9FaEFYjuOnKxnhRbj7gkBf5ZYEzZmWM
 LMl8LexR2Su5Y7qyyK6I0vW8u6tnYgfRXl0RKIOaakjysDXNi2sy7/TlmETDyBiJDvaQ
 q7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716418; x=1721321218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EI1m/5KlruCoT6RpfHcQgeJV034qnLNtuNds708jBqM=;
 b=f3iI6DZAbqoRkXI1Ko0ZL7co4lk5yU7/wTakuccjppI7uB3/3aF1/tIzQUEjmFSgi5
 KZPkhS3L8gx2086p+Uo1rBHVUXA9KzS4BZVLNWgahHsgNZrX/Fd3QhwbXGTDwTmE+28f
 oHqF+Jatn/u0Qj+Sayl9LUbzBWCmEzsHhR2sx+pUv+Z9StCz68R/UcU37oifsZZ3I2+f
 /WJfKCWQ42u6AXyMC16OKAWl7QtDIR9WvHlIHLPd8zZ+trdk4s1MMsmzlLmzOKWcgLDu
 rtGSnHnFT9mfgHcmoLdfcMcw4WD+EJqbRP3hGGGLH+6g7xFQGOceuquBjN2s9yB19dZ1
 ymCw==
X-Gm-Message-State: AOJu0YxYQetEp/gwpoZMVME4OjoA2/6v1VP3LzSLJ8UWBKkfqswtlzlQ
 MUw0s4/BdxOaI7M0z07ANBpCo1r7INXLbbgHKRASY95eeCJoT4upKE1rSOnJDz8=
X-Google-Smtp-Source: AGHT+IEuBLiB5epMcQ3dyAErS6Wt2Jw9bOHZyxA5gcKqMZTYvg9nY0Bg8nef3sCpvt1bBJc1lvGpxg==
X-Received: by 2002:a17:906:e0d4:b0:a77:c0ef:f195 with SMTP id
 a640c23a62f3a-a780b87f76emr584956966b.52.1720716418610; 
 Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:46 +0200
Subject: [PATCH v5 14/23] soc: qcom: add build infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-14-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XGgpCAr8XHdPFMKI5HuxXuToi062u+tLuE4azL5XNXs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxve685GtVxDOK8yHlSSy914IMgAmpL1LBvW
 vEUEiUQx2CJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 ttPJD/9KVvAXyykCQTsexRMxiMqXw30mY0Tkt9uIyjNqgbR85uwG4Eu2lTS03Nfh20k83sxKF+u
 yyX6A97INA/cOtdiy1VKaqfVO3UZ12znKfPuDwghBWwP9B3IA8EgQwJPGq66CPyWDbkJsbg5l94
 7arJq4evGMy08tXILzmjDllzt4UBzIZsg21794PWkBe35HwoBZaeTeEpet8cZblbfW2cstW/f68
 n/ZN6HZLeCvD1GBj1pPKBj2S/ku2L+1qny1HR6Vl/YBtQgRAoY55qCem4iefJFy6Lr71qXxpfCe
 XuPWy1HmkBP8b8S9fLE6qUFSHaoG8QLfzshbf8dGv2EPnPgplgraM0zcR7Kl95JWJxZ2PhWiiBr
 SSSQBLfV4sHLoRZggaysNm6fceM/g5vWq5gojw49kUEMrM7b7eN/IH5+Wun+7qUcrQ2YqnIvlf2
 dkzQlJn1IdtaRQk/KFPmznLqgDvca7qdB7wjqkG0r7p1d/qFqpDDL3czec1zuF5uFZ7qHFRudzh
 nYeY1cKM7AspaBdZiTjY2FclxzbYa5xykCFeG3muAKW6LjyhDy8cbmD5qJLfSWYex51fK9vjfzO
 Xqq+T6ixRiJSyyO0Afv8cS/1hQIQuYaWiN1x3pfBo3pvZM39blpBLOm9DKZ04bXfI4CtoleO97x
 GJGyIt7sRSa0T1A==
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

Add Kconfig / Makefiles to build rpmh and cmd-db drivers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/Kconfig       |  1 +
 drivers/soc/Makefile      |  1 +
 drivers/soc/qcom/Kconfig  | 27 +++++++++++++++++++++++++++
 drivers/soc/qcom/Makefile |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cee506fe4747..8ef408d9ba1b 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -47,8 +47,9 @@ config SOC_XILINX_VERSAL_NET
 	  Enable this option to select SoC device id driver for Xilinx Versal NET.
 	  This allows other drivers to verify the SoC familiy & revision using
 	  matching SoC attributes.
 
+source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/ti/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ec89a053165..00e6a5ac8e2b 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,8 +2,9 @@
 #
 # Makefile for the U-Boot SOC specific device drivers.
 
 obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
+obj-$(CONFIG_SOC_QCOM) += qcom/
 obj-$(CONFIG_SOC_SAMSUNG) += samsung/
 obj-$(CONFIG_SOC_TI) += ti/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
 obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
new file mode 100644
index 000000000000..4aa7833930c7
--- /dev/null
+++ b/drivers/soc/qcom/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# QCOM Soc drivers
+#
+menuconfig SOC_QCOM
+	bool "Qualcomm SOC drivers support"
+	help
+	  Say Y here if you want to enable Qualcomm SOC drivers support.
+
+if SOC_QCOM
+
+config QCOM_COMMAND_DB
+	bool "Qualcomm Command DB"
+	help
+	  Command DB queries shared memory by key string for shared system
+	  resources. Platform drivers that require to set state of a shared
+	  resource on a RPM-hardened platform must use this database to get
+	  SoC specific identifier and information for the shared resources.
+
+config QCOM_RPMH
+	bool "Qualcomm RPMh support"
+	depends on QCOM_COMMAND_DB
+	help
+	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
+	  if you need to control regulators on Qualcomm platforms, say y here.
+
+endif # SOC_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
new file mode 100644
index 000000000000..78fae8bbfa16
--- /dev/null
+++ b/drivers/soc/qcom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
+obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o

-- 
2.45.2

