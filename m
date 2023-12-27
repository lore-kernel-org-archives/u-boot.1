Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE2FC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24ECE87948;
	Wed, 27 Dec 2023 09:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X2IgEtwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F03287919; Wed, 27 Dec 2023 09:24:20 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6B287906
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d5d898162so3280385e9.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665458; x=1704270258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MX61P7BE2FzUeXXfgEni59cf0lzs+NmkdyoCqkPkOlE=;
 b=X2IgEtwI9PSfuOB/eObr9rWvmLF8qqsQ6ZNOODrQmfBM8Tz++Lr6oNf9tg81ktSYK+
 Z8OsuK5EkwYXU/bWG/MhxEjmUC/tKySpyPyHNi1bY7sadFoBZEk5V+7jWpJJlcab98rw
 UAYRU7lg0GPGc9nzUpjtwVbZaFVrBoLOsIi90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665458; x=1704270258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MX61P7BE2FzUeXXfgEni59cf0lzs+NmkdyoCqkPkOlE=;
 b=B01f5F0VLF0CvriYMKk3Ggk3xXxzJbviEzJTcIQsTiS7h+uCzVVltF8Hb+judkeVB1
 NoH9xGAcK5OsfvrWeL/1JYIJzdADFzbbRutWLW4cwdgHuGbyaI3l+GlaulowOF6R/niZ
 1aeECw1TJGjXuh/226VnRQUAvUEOrKlH8Uo17GTKV6yTEMXqQJFlFl5SWVFMkr0zhGO6
 fgKj8ExJxucEE8L2teUOznXfRcMvg00vYzm6UHQiw48h5yFleK1LKqJ5t7W7Nrx+xuKy
 1zeOMCNzIZBIBRkCGgY5Cyq0djWoMjPqvIbDESxiWObnL3ncWr09sqH2pojMuGUnf5ot
 meMw==
X-Gm-Message-State: AOJu0YxmGxKzx2joxsGiUeie5PDSd5cbCMB9ntcrDWmAoyDoFQP4wdZD
 GNxr2VaqHn0+QuKDhz+wSJVJpkZo6498IY5L/9+SXOKZp5UG
X-Google-Smtp-Source: AGHT+IHGCQqe02kpSANOx7LNeZ7A9H6GSbVNlocN10P0VgVyjLY0us1M7NcSnkRZPa3Ur1f4P2XFsQ==
X-Received: by 2002:a05:600c:1c15:b0:40d:5bbd:a091 with SMTP id
 j21-20020a05600c1c1500b0040d5bbda091mr885672wms.67.1703665458043; 
 Wed, 27 Dec 2023 00:24:18 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Minkyu Kang <mk7.kang@samsung.com>
Subject: [PATCH 6/9] arm: samsung: dts: Convert to SoC-specific build rules
Date: Wed, 27 Dec 2023 08:24:02 +0000
Message-Id: <20231227082405.2202246-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
References: <20231227082405.2202246-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Move all of the Samsung rules over to use SoC-specific Kconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 09465e32c0d..60301dd2b07 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-$(CONFIG_TARGET_SMDKC100) += s5pc1xx-smdkc100.dtb
-dtb-$(CONFIG_TARGET_S5P_GONI) += s5pc1xx-goni.dtb
+dtb-$(CONFIG_ARCH_S5PC1XX) += s5pc1xx-smdkc100.dtb \
+	s5pc1xx-goni.dtb
 dtb-$(CONFIG_ARCH_EXYNOS4) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-universal_c210.dtb \
@@ -22,10 +22,10 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += exynos5250-arndale.dtb \
 	exynos5420-peach-pit.dtb \
 	exynos5800-peach-pi.dtb \
 	exynos5422-odroidxu3.dtb
-dtb-$(CONFIG_EXYNOS7420) += exynos7420-espresso7420.dtb
-dtb-$(CONFIG_TARGET_A5Y17LTE) += exynos78x0-axy17lte.dtb
-dtb-$(CONFIG_TARGET_A3Y17LTE) += exynos78x0-axy17lte.dtb
-dtb-$(CONFIG_TARGET_A7Y17LTE) += exynos78x0-axy17lte.dtb
+dtb-$(ARCH_EXYNOS7) += exynos7420-espresso7420.dtb \
+	exynos78x0-axy17lte.dtb \
+	exynos78x0-axy17lte.dtb \
+	exynos78x0-axy17lte.dtb
 
 dtb-$(CONFIG_ARCH_APPLE) += \
 	t8103-j274.dtb \
-- 
2.34.1

