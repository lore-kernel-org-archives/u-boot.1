Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB4C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD5D87952;
	Wed, 27 Dec 2023 09:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JIX1SeK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B03B8793C; Wed, 27 Dec 2023 09:24:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8E987916
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so1783035e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665460; x=1704270260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DMSGNF+ABS3Pz9kdhhPtI6K1l/jw12WVXTDC8mWMEw=;
 b=JIX1SeK+OaagnqpsW8oMz9uFwCAp8UbD8sKI7n+1u5HcMh+SAsC56fYIjNmhkiRzGq
 zTQnxpDG2wGtnLNdioP47O+hb007LGcfPXpCKwCz6CZFGzQ3Ops0oUs5CoIRGwdESLud
 vNa6CooVx7N5rGGtYKtHFQAxzJExl5XP4JPHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665460; x=1704270260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DMSGNF+ABS3Pz9kdhhPtI6K1l/jw12WVXTDC8mWMEw=;
 b=O58lkO5rqESx/B/Ieu1tmXDD414SA9mOXRrcg3IXUATK4Hkgq6Z+8CMWf7Wv2YXNGF
 2xuFmSqS5Qy3PFjlRHWWWDdy8tTRiUPoN/UcSEbda8ydzCgafRq80BRfYcx9dARPr15/
 r1rgisGU7rHf+OJ8pesoNYjj6ePgrkr5u2n/ct7rmdta5su2jOTEwIX9vvM2k0UxBGz7
 a0u1KG1xWZNaHhqIjcFTs2snLWnGzXDbDmIxswR1mFR4EwkA1YkL4cgP+3QndrGYW+8d
 ksiBTXD5smLPMmzHGd6LI6h85G0lLx3aGk84qtJMG1PKZd7ULs2s106eg6VcC9qrJkik
 PhjA==
X-Gm-Message-State: AOJu0Ywm7CBs9QcS84ncRTYjNyKmqhudwPtHyewv5Vuv3IPso9vFv1dC
 ubC/lGhaOag3OprYFKqzrtkVELvb30OBOoLT8+xtGhcKr3w1
X-Google-Smtp-Source: AGHT+IHP5ikrsTYvh9WCuBQE1t59rg4zgH+bZBGBwnOEQA8w54MQJDd5mRZ+XQbsBxgypuVUG24QXg==
X-Received: by 2002:a7b:c8c2:0:b0:40d:5e72:d31d with SMTP id
 f2-20020a7bc8c2000000b0040d5e72d31dmr231260wml.104.1703665460045; 
 Wed, 27 Dec 2023 00:24:20 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH 9/9] arm: vexpress: dts: Convert to SoC-specific build rules
Date: Wed, 27 Dec 2023 08:24:05 +0000
Message-Id: <20231227082405.2202246-10-sjg@chromium.org>
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

Move the 64-bit vexpress rules over to use SoC-specific Kconfig options.

The other one does not appear to have an SoC or ARCH Kconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8c704169b7e..ef8f2caf38f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1432,12 +1432,13 @@ dtb-$(CONFIG_TARGET_GE_BX50V3) += \
 dtb-$(CONFIG_TARGET_GE_B1X5V2) += imx6dl-b1x5v2.dtb
 dtb-$(CONFIG_TARGET_MX53PPD) += imx53-ppd.dtb
 
-# TODO(Linus Walleij <linus.walleij@linaro.org>): Should us a single vexpress
-# Kconfig option to build all of these. See examples above.
+# TODO(Linus Walleij <linus.walleij@linaro.org>): Should use an SoC-specific
+# Kconfig option to build this. See examples above.
 dtb-$(CONFIG_TARGET_VEXPRESS_CA9X4) += vexpress-v2p-ca9.dtb
-dtb-$(CONFIG_TARGET_VEXPRESS64_BASE_FVP) += fvp-base-revc.dtb
-dtb-$(CONFIG_TARGET_VEXPRESS64_BASER_FVP) += arm_fvp.dtb
-dtb-$(CONFIG_TARGET_VEXPRESS64_JUNO) += juno-r2.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS64) += \
+	arm_fvp.dtb \
+	fvp-base-revc.dtb \
+	juno-r2.dtb
 
 dtb-$(CONFIG_TARGET_TOTAL_COMPUTE) += total_compute.dtb
 
-- 
2.34.1

