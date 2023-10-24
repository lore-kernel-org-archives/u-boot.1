Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F331C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110E1879E5;
	Tue, 24 Oct 2023 22:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="egEN1QW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49176879D6; Tue, 24 Oct 2023 22:24:07 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C51879A6
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so3247889f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179038; x=1698783838; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uSMhm9nyRpqY9DO9hVrSGQzrk9Mj8Glivq/scECJNK4=;
 b=egEN1QW27bZM+BwY+LboqDEJoY7OqYNRv2cT/VAdOPbas3tslBYziYycJhZsWjFW0B
 0XYR2lkHhKjTCf0/C3JTQrjjZ0WO4F1uz1q3CCDKnB0ujOrm0erH2MGCqPMae2gcnq7l
 /iIZ8QQnkn8al3SdsBnc5QAQswFbLHCj6MvC6Z+XF2sozPdzzsDcTaLjzb0VX10j+kj6
 2Gjpfz+yk6Pfq7FYMw6j/ZfQjijUPzNTK5WICA56LkIuG+6KS+yhS5zW0lNoUK5z0B2H
 TGv/sF3kSzEutOo5IURIz0xPUA9PlOyPZjWUeRDbKGz/vaMelhCKHiNQtyW/g7rPSMda
 DRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179038; x=1698783838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSMhm9nyRpqY9DO9hVrSGQzrk9Mj8Glivq/scECJNK4=;
 b=DVli0V+DHJdxCubmIgKDCRBD0bNELBIQe+axNI5445P7I4KJGXh4IiqaEPPDZcF0N/
 8oqPOLh6wdcoMQ5jDidN6d+ZmIORxehf72evl9QXbmGm18NMZ1OPyiY1OJAjuOEcfPA2
 44zaOVQBd+Ky4R6GnW4B7I1f9vhIXhlBBhrXgM4I5Vj6YYxTjLY9xYAxfMFvxdzvRozC
 xp4T1H5Iw0j5Fl8TeRE8uI62BdqvpDqW7uQY/LOMgib/F1iS0BCVcV1oUfT2JgjZwTyl
 dJZ3Y9uQzkJcwHYm7lkcGTW7RXIHiozLllnOaC4X0/vs3tAN8UnHYXvHl3rdrTJ/tpe1
 MWxQ==
X-Gm-Message-State: AOJu0Yz/ueRgVNdS/Y4DofpKBTFnTvTAllx2SSUYhd7NCoHl+PGsTEjR
 4CzzmwIMB9ZyeuVkoP3GCyXTpA==
X-Google-Smtp-Source: AGHT+IHFVZdGwGXF49J62U287qT3tetKZZvaWkz9sFrqiJqZOcvXYTbW6PswXbY5j/qSMZRd4BJwyw==
X-Received: by 2002:a5d:63ce:0:b0:32d:bc6e:7f0e with SMTP id
 c14-20020a5d63ce000000b0032dbc6e7f0emr10524573wrw.3.1698179037958; 
 Tue, 24 Oct 2023 13:23:57 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:23:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:53 +0100
Subject: [PATCH 2/8] clk/qcom: add per-platform configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-2-9d96359b9a82@linaro.org>
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3gbK3p966BObye4H2v4Mk0BiNv3waFV4YfCwhWL5oMo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9VtvHudd+cavdS3qdseEmpOOhuKnl/ebe13fpXKqQ
 kVvGtOUjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARy7OMDHPee82UPMPtH/8m
 bAtf09X3MuvFW8qlLQXjebbN3mBXfJzhn5mlrfuzCp5373ZMsMtkltT4y9JZ9NnW3HFpfvSf1E2
 HlgMA
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

Decouple the clock drivers from the mach-snapdragon TARGET configs by
introducing CONFIG_CLK_QCOM and associated options to build each SoC.

This will make future cleanup easier as we move towards a generic
Qualcomm target.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig |  4 ++++
 drivers/clk/Kconfig              |  1 +
 drivers/clk/Makefile             |  2 +-
 drivers/clk/qcom/Kconfig         | 44 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/Makefile        |  8 ++++----
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 0e073045be54..eaf75abf4bd5 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -16,6 +16,7 @@ config SDM845
 	bool "Qualcomm Snapdragon 845 SoC"
 	default n
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_SDM845
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
@@ -27,6 +28,7 @@ config TARGET_DRAGONBOARD410C
 	bool "96Boards Dragonboard 410C"
 	select BOARD_LATE_INIT
 	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply CLK_QCOM_APQ8016
 	help
 	  Support for 96Boards Dragonboard 410C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -40,6 +42,7 @@ config TARGET_DRAGONBOARD410C
 
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
+	imply CLK_QCOM_APQ8096
 	help
 	  Support for 96Boards Dragonboard 820C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -73,6 +76,7 @@ config TARGET_STARQLTECHN
 config TARGET_QCS404EVB
 	bool "Qualcomm Technologies, Inc. QCS404 EVB"
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_QCS404
 	help
 	  Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
 	  Features:
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index bfd23a990469..017dd260a544 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -254,6 +254,7 @@ source "drivers/clk/meson/Kconfig"
 source "drivers/clk/microchip/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
+source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sifive/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dd90c7672e1b..dd974742b6c8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_CLK_MPFS) += microchip/
 obj-$(CONFIG_CLK_MVEBU) += mvebu/
 obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
-obj-$(CONFIG_ARCH_SNAPDRAGON) += qcom/
+obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
new file mode 100644
index 000000000000..a884f077d9b9
--- /dev/null
+++ b/drivers/clk/qcom/Kconfig
@@ -0,0 +1,44 @@
+if ARCH_SNAPDRAGON || ARCH_IPQ40XX
+
+config CLK_QCOM
+	bool
+	depends on CLK && DM_RESET
+	def_bool n
+
+menu "Qualcomm clock drivers"
+
+config CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon QCS404 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon 845 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+endmenu
+
+endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 5f0c7a79d2ab..44d55583596d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
-obj-$(CONFIG_SDM845) += clock-sdm845.o
-obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
-obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
-obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o

-- 
2.42.0

