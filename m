Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A96CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF4887D8E;
	Wed, 10 Apr 2024 19:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k7E0Ennv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD22D87D8E; Wed, 10 Apr 2024 19:07:13 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84B887861
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso892714266b.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712768831; x=1713373631; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVioKkTmCH1Nx0KyUgx1w3MclznpU3yEZ5FT6wVgby4=;
 b=k7E0EnnvGtVx+hrI+ubvN10Km6v2r0ZPN3/EofbY8DgwbkYN2GWcWolRjPVfmpV54o
 b2B1x6/a7MO9kOYgkwoPZdVb0qVoxDcHGAEI958egO+o632UVgD0Y/Q6E/w15svIIY9W
 GxWJ0A4HnVDoQNT+0ARvKtosznU+uZ3GxHpF+rExgY2U8qAtJAaN4MgJmMKa7wYsLSn7
 EzFKtynCIBQ9IpESfKjZJ4Gd/AGaxDG2ssxB6DHGhoMvB16b1Y3ifI6lNCp9CILsHPCy
 CUO9XHG9tfaZ9UzbbbTKPTE94fWT/ucGpbAXHADiqnW/0dNlnG6TfMUom4MBmEsn3MD7
 pMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712768831; x=1713373631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVioKkTmCH1Nx0KyUgx1w3MclznpU3yEZ5FT6wVgby4=;
 b=HxPcgVytqJ3nq4McmpFJmtduQxHg0Vb4VT9BbO2GGHZr/HrINgQI0T2YPpf+6VfiEK
 K5fLeueY8zXxZ+tsFmEEmxXVrxFjjSXB3NyRe/DXAIsP5U6gHPdGdwKHLmsBeHLqPw81
 fMOxo1K16XAr/9N/KRGGP3wvlbpHhOV/2387kauqCwbHYC+thnZmDRY3rSbFgj+ZnJ5D
 K9ujpygfYCBxceMHVUgSIuFhm5zRcc0rrgRfwPyZHxmEQ/y/vYBqqX7G5W8nrLxPjFbg
 G2X1fxbeYqpZLKRzFVkK6W77n0htE9kighfpjpvquaLIMGt4NkiJFnifmAdMIV14NM2u
 JR3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/86YZOqs+MLOnr9odxKWLbH8XcAjdSHZhLlaSQdx++ZIdNtvLSu2B05Xsur+YWDJPdSKdjxQXbOBoA6xV1Nb9xdeFQ==
X-Gm-Message-State: AOJu0YyfEU7EryR0m2lcYpKfZSZTmKxGzlvGTWWeKB8KOCJmvFkqiiwH
 Lm1KNQVMk6ZXFr+IUV1hrudmDch5jVb4lo3SxvlIcqiWATwAtROlTwxy2e7m0AA=
X-Google-Smtp-Source: AGHT+IHvv1qXuVUIzrjS+woPEwlONEjpeOytx07Cg6GH3+kN1568bvmmFVricFG0MVTiGyHOJy6glQ==
X-Received: by 2002:a17:906:f44:b0:a47:5182:3b83 with SMTP id
 h4-20020a1709060f4400b00a4751823b83mr1636475ejj.61.1712768831322; 
 Wed, 10 Apr 2024 10:07:11 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 fw14-20020a170906c94e00b00a51def4861bsm3331881ejb.91.2024.04.10.10.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:07:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:06:58 +0200
Subject: [PATCH 2/2] clk: introduce a fallback stub driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-stub-drivers-v1-2-6935bd2c07d1@linaro.org>
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
In-Reply-To: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3815;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=tBzmh2+z4vL+U5q54pC35iQjh4TVM9yOxn7t7BbRAqs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFsc7fk2dJtS0lNtDTm1f5r74RQpDgRCdIx2Uv
 JpQ0DHxDu6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbHOwAKCRAFgzErGV9k
 tpPSD/kBTyY8/lr3PXTIFo6ch91RY1PNBfX5KPQhI4v9VRZLHwPF2BIsVhu9x8e5ztaD4zKXKaT
 qWLjyelCNiaqhxCsDcaFLK6owHRfGZYiiF28t2Ji6nKtO8rhktoVeW4pR5omgVyGIwWHmcd3cZK
 0CJfOiRZA3herCXeh4cZII0liovc5hgYMF6UZCBQ3Npd/9eGOeX+tjASUjf2HLf9z3Zuh4KCPgK
 JNmEZLhsjaJJK/v8c2C0AU+o2N00swtWqfplXnVjV7O5SvieNdPEHOc8Ype5rOizT61Vdw1Sv13
 PLBQVY0PnW2RfWiZoQO7Tehrizmww1UXo0ooDeUu/tIoKE3WwrFdKedw8FqZTaHPJdz4ND/aMg6
 1VqQSp9i1u9IZueWpsjfHN1k3j8TRlVxqflWx1GhtLmO5LZsIWla816hSBXM+DkPOXcD0etmQ55
 MZnz4SOZdIIlJDC0m1OIonS1d6/nVSdv7XKw/Z8XiI95V4DJVl/vrQaznZhCZUiMkM47x6glJL0
 uBiLrpJSkxXl8Oi/aFL+LfFi1EqKYF5aEoMt+5CtET4+z0fNrAOIWSaS32+NTFwPgrFYIXNovP3
 YwtVgWDDlU51R6J87kJj0pWZTpY2wWUNqrLDMO9HWEq7qfFW+3GiTofKd0qzdP3Fwgc7934w/As
 u9MWb25Z1Rbzcsw==
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

Add a stub_clk driver which does absolutely nothing and is configured as
the fallback stub for UCLASS_CLK. If there is a dependency on a clock
device which is not supported by any existing driver, and
CONFIG_CLK_STUB is enabled, then the stub driver will kick in.

This is intended to be useful during early bringup (e.g. if the serial
port is already configured for a default rate) or for clock controllers
that simply aren't vital for a platform to work.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/Makefile       |  1 +
 drivers/clk/clk-fallback.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-uclass.c   |  4 ++++
 drivers/core/Kconfig       | 10 ++++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 638ad04baeb0..dd57f2fd0397 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,8 +4,9 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(SPL_TPL_)CLK) += clk-uclass.o
+obj-$(CONFIG_CLK_FALLBACK) += clk-fallback.o
 obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_rate.o
 obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
diff --git a/drivers/clk/clk-fallback.c b/drivers/clk/clk-fallback.c
new file mode 100644
index 000000000000..f5733821e998
--- /dev/null
+++ b/drivers/clk/clk-fallback.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ *
+ * Stub clock driver for non-vital clocks.
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+
+static ulong fallback_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong fallback_clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+static int fallback_clk_nop(struct clk *clk)
+{
+	return 0;
+};
+
+static struct clk_ops fallback_clk_ops = {
+	.set_rate = fallback_clk_set_rate,
+	.get_rate = fallback_clk_get_rate,
+	.enable = fallback_clk_nop,
+	.disable = fallback_clk_nop,
+};
+
+U_BOOT_DRIVER(clk_fallback) = {
+	.name		= "clk_fallback",
+	.id		= UCLASS_CLK,
+	.ops		= &fallback_clk_ops,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index ed6e60bc4841..c0cdb3cf529c 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -11,8 +11,9 @@
 #include <common.h>
 #include <clk.h>
 #include <clk-uclass.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <dt-structs.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -801,6 +802,9 @@ int clk_uclass_post_probe(struct udevice *dev)
 
 UCLASS_DRIVER(clk) = {
 	.id		= UCLASS_CLK,
 	.name		= "clk",
+#if CONFIG_IS_ENABLED(CLK_FALLBACK)
+	.fallback_drv_name	= "clk_fallback",
+#endif
 	.post_probe	= clk_uclass_post_probe,
 };
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 09075b9b7a15..1cf78b4303ca 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -476,5 +476,15 @@ menuconfig FALLBACK_DRIVERS
 	  driver to "stub" the resource. These stubs usually do nothing and
 	  are therefore only suitable in instances where the resource is not
 	  required.
 
+config CLK_FALLBACK
+	bool "Enable the clock fallback driver"
+	depends on FALLBACK_DRIVERS && CLK
+	help
+	  This provides a no-op clock driver that can be used as a fallback
+	  when no other driver is available. This is useful for systems with
+	  clock controllers that are not actually required for peripherals to
+	  work correctly (for example the RPMh clock controller on Qualcomm
+	  platforms).
+
 endmenu

-- 
2.44.0

