Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45152C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C7C87987;
	Tue, 24 Oct 2023 22:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ut076fVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439D38797C; Tue, 24 Oct 2023 22:24:03 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DC787987
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso840905e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179037; x=1698783837; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SuP/GkU6ITouZfvuKBeu3C011gdwDuEyoEDoMpv3ODY=;
 b=Ut076fVEXTWGG4mIqEwiVgqKd4PVI4J8FfTYP2DBw0l3Ic5frJtMh+qmDJVyMQbdRW
 jvU2UOOqBpbCxYaBq7c426V+uX2WBTk/OTjvotnPZbpMgglKDklO5zzDrheAi5q35OBd
 mRBFdcxrsvICix6r/I9AjaM3YqURmUMXG3dFh9+6s8xTlzd9ZvVxlvjpEnIyFNsp4DP9
 k8tA63eRST7rHhyuLS7BZ4/pkoSGPZTNGmDOQYokIuiDQuv3xZVv5ZFA6L6HXpik8PJ0
 ZdOYsCvysHORtsQDmy0gnQwN5Uw397Lbp0n3r8TwHctVKC8Ff2N5O/sWCHsoUlZlvPc7
 Dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179037; x=1698783837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuP/GkU6ITouZfvuKBeu3C011gdwDuEyoEDoMpv3ODY=;
 b=e2TH17zjtxDVFz2MhM7mymo8r/W65n4M4xD5/GuLXDCYgCFBK/p8w8ypPNYX64gZzH
 IAqgaVrzj3NRKI++RrDx8XtnYDzrDWXS5ve7PdKNeFZHKez45QKOXvVJaot74n460H6E
 kPrurGlFcpIUw96F06rlKUzD+tjKJfG//o/6b6oLkgoSpTv61ZgKPrXT24QlFxu1M7e/
 v20gkmJwpq7RrAzOLSKvdR9uNW/nk5vbKm2kjpbYeoFgs9QpaAYZiu5FJZW75r2THRcJ
 S6bp5q6ec0EpcIiFf0tzyYNo0vYiQDl7cKGhIDSIjgXWBE5Tmxm5XZXTYoZxGT8MfN3/
 9zRw==
X-Gm-Message-State: AOJu0YwWQNEZx0BRkhMNadjfOAcDcZdBFMkTVmoK2CibgLbxzHFIuAH4
 WvYQQNgd4ihWd0yTP2wGcyL95A==
X-Google-Smtp-Source: AGHT+IFSJkDrFeMTYD66tYr8NPC5V6rIl3VUurYKELgGCk5bupkhYyAsnHW9BTutEZYLk5ULoBRAsQ==
X-Received: by 2002:a05:600c:3b28:b0:407:3e94:bcca with SMTP id
 m40-20020a05600c3b2800b004073e94bccamr12707918wms.1.1698179036845; 
 Tue, 24 Oct 2023 13:23:56 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:23:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:52 +0100
Subject: [PATCH 1/8] clk/qcom: move from mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-1-9d96359b9a82@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5898;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0KuOPXf0EAPmzagqSGBbBe71teyBXkli9r2q+QEfIYg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9VsH40TUmYrVjkfrPwg5Iixbf/X0torczQHG/9i6u
 5nfFx7rKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPxtmBkWO4uvsPuyS+PWYVd
 D5ys3hq+5eJR71VbPJ03Y3av9KxvLAx/xSVMuU7sZhFlD1ba9epcZeWaE+t/uC2MyzN17DrUYXp
 PAQA=
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

Clock drivers don't belong here, move them to the right place and
declutter mach-snapdragon a bit.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile                                | 5 -----
 drivers/clk/Makefile                                             | 1 +
 drivers/clk/qcom/Makefile                                        | 9 +++++++++
 {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8016.c   | 2 +-
 {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8096.c   | 3 ++-
 .../clock-snapdragon.c => drivers/clk/qcom/clock-qcom.c          | 2 +-
 .../clock-snapdragon.h => drivers/clk/qcom/clock-qcom.h          | 0
 {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-qcs404.c    | 2 +-
 {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-sdm845.c    | 2 +-
 9 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index cbaaf23f6b56..497ee35cf7d3 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,20 +2,15 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SDM845) += clock-sdm845.o
 obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
-obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
-obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
 obj-y += misc.o
-obj-y += clock-snapdragon.o
 obj-y += dram.o
 obj-y += pinctrl-snapdragon.o
 obj-y += pinctrl-apq8016.o
 obj-y += pinctrl-apq8096.o
 obj-y += pinctrl-qcs404.o
 obj-y += pinctrl-sdm845.o
-obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 26bf429acbc0..dd90c7672e1b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_CLK_MPFS) += microchip/
 obj-$(CONFIG_CLK_MVEBU) += mvebu/
 obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
+obj-$(CONFIG_ARCH_SNAPDRAGON) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
new file mode 100644
index 000000000000..5f0c7a79d2ab
--- /dev/null
+++ b/drivers/clk/qcom/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += clock-qcom.o
+obj-$(CONFIG_SDM845) += clock-sdm845.o
+obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
+obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
+obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
diff --git a/arch/arm/mach-snapdragon/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-apq8016.c
rename to drivers/clk/qcom/clock-apq8016.c
index 23a37a1714dc..90f2a93d9ed5 100644
--- a/arch/arm/mach-snapdragon/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
diff --git a/arch/arm/mach-snapdragon/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-apq8096.c
rename to drivers/clk/qcom/clock-apq8096.c
index 66184596d562..d5388c69aefe 100644
--- a/arch/arm/mach-snapdragon/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -13,7 +13,8 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+
+#include "clock-qcom.h"
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE		BIT(30)
diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.c b/drivers/clk/qcom/clock-qcom.c
similarity index 99%
rename from arch/arm/mach-snapdragon/clock-snapdragon.c
rename to drivers/clk/qcom/clock-qcom.c
index 0ac45dce9a92..5667abeb89a4 100644
--- a/arch/arm/mach-snapdragon/clock-snapdragon.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 /* CBCR register fields */
 #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.h b/drivers/clk/qcom/clock-qcom.h
similarity index 100%
rename from arch/arm/mach-snapdragon/clock-snapdragon.h
rename to drivers/clk/qcom/clock-qcom.h
diff --git a/arch/arm/mach-snapdragon/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
similarity index 99%
rename from arch/arm/mach-snapdragon/clock-qcs404.c
rename to drivers/clk/qcom/clock-qcs404.c
index 3357b54c30c0..80218af73ef6 100644
--- a/arch/arm/mach-snapdragon/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 
diff --git a/arch/arm/mach-snapdragon/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-sdm845.c
rename to drivers/clk/qcom/clock-sdm845.c
index d6df0365afca..95a057b82986 100644
--- a/arch/arm/mach-snapdragon/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
 

-- 
2.42.0

