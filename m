Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05221C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBAC688860;
	Mon, 15 Jul 2024 12:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LcXsUO0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C582388875; Mon, 15 Jul 2024 12:08:49 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9088888856
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-59a47d5c22aso3923151a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038127; x=1721642927; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EI1m/5KlruCoT6RpfHcQgeJV034qnLNtuNds708jBqM=;
 b=LcXsUO0aLKZzd+kgBiPpHcxKQpPVqgZnWzpL9OMo0xNFTFRPLxel0oRR/pLCU62IGF
 CfJYgr0ARYFAtOKdlK2Mzz8EvNO0A43cjRG1dvGlfA8rKXTYXNYpx73IRy1IDwnFnyx9
 jjrV3mktRFgfgioKcFnUeosB+gMtremgZAJCfB6Iq3Ys8EREIzwAA3V+QQkg9174ggmv
 NDlLaFxClcalfVKL+Gx36fPbpyK2skD/JaYCuMduI7xxLMnx+8ndTe7RcuxvwgdwkXkE
 SxbQztBVht3XrfMrYBJiHBmJCC2fkNOAtwJhubD84sCZYrA8GwR34GdEfMRRxMyO8hvs
 SCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038127; x=1721642927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EI1m/5KlruCoT6RpfHcQgeJV034qnLNtuNds708jBqM=;
 b=QZKrKUAp5t+CkjB94oXNzgwhXI44vDDcyU6GuzoZcPxzpETGBGfs8KokPdz2pwfJM+
 l9GXE9A/oTpIOhS5FtoTTymWH4d754buJKxcjHVUyAuzhPXC1Rl5xQeVhAfgRt3mnYEC
 Cq32PpDZSRl55kz2R3y1HNGB1vLJtwkeJFloHR6aBh/E1Y1TR95NzP39H23f77+judcW
 xCM93gH3x+o1tD5/93QZzPbBkN4utk58w6xi2VQR7pI2rytDsj5av8zaJswqhDPESaks
 WvakO4YmyoGTUCsT4OFGtSJ1GuNYUrI7CHDS6Qeh45mJ0LdbwxoggzBZhCIpoTXb23MQ
 K9vg==
X-Gm-Message-State: AOJu0YwxnDzmVPa+aSy30thRsQV/Z5PA1KnHjKUm7lXoypRvxhikj/2L
 ueqPyaFtcg13YZaoZKgjQTCmrbnUUxapVJl23qd3frs3PGFDmjqbKmQfBfhzEAE=
X-Google-Smtp-Source: AGHT+IEt66anvoe36tCrMFZk94DJHq7Z8Q1DGx3hVpgoo9OZAnPOShZwzqXjQ96IHEmPg0wPdAKBnQ==
X-Received: by 2002:a17:906:37d6:b0:a77:db36:1ccc with SMTP id
 a640c23a62f3a-a780b6b2f58mr1139255666b.24.1721038127069; 
 Mon, 15 Jul 2024 03:08:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:14 +0200
Subject: [PATCH v6 15/24] soc: qcom: add build infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-15-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XGgpCAr8XHdPFMKI5HuxXuToi062u+tLuE4azL5XNXs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUG26XiR04MWK1RiWSUEYen/dhXKFe+PgQ+3
 iZnnoWwaMGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 thK1EACHpV9p29oJTuQ/NjSWozR5aV2oSdl3ODZTcN1LNOOawBKMnrwGjT36d6DF4GLIjxUBcdM
 efTV3epqr7ExQk1ASnqSUHkxFJfe0utEivRqWfsdS4xNwSA9xHrPKx5sfweJL27GkiQ+ZuwvC66
 cBSD96KfJMvjytqCrH8tfn+HeXfxora/VZV/2HSdLPqq3jKcSLFM3cbDuNmAi2lWpF8+sUyY5wi
 aHBHuBOV4PaTHcN8ByeGohmAzLRq1yghHRRsQSEn4o05SFlAGnCByptEDZCYW4vzf3iggyN7S1s
 EgSoEg6a3p3L2nL1E4ch07ZL/flHmchMFw19Ao0KF86IlYKWTtrCu+mgpNYzqndJZ7/zaJUkaRJ
 0JoJNUkZigSIP0Jnx9/lJi8vKys9faV9uUsNk/OW/nsiicm6ogvceZSsGKUc+8OWgRcFVaXPAO9
 /wse2RxXcRv4o4a4hJxJ9932lXj87LP9EcMEnn6ONk8dfaFRfSE0BToJ4T4vBDm46gwrpVpr/07
 fi9MC6RH8enfX+7QhnsxXkpkhQ3kJTny/f6AhXk6Uxuwtn/ymaCOb6jOmBKwia4xFKNKYs3OJbh
 oH7lxjuXgspDg9CI9ZHECbhqWa0Qgstdl5UWNCn4EVEFsqPntjRnP9DmpfoM420ZKnYkg6H1Sq8
 bPDkDfggPGO0SKA==
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

