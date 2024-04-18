Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906B5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD558869A;
	Thu, 18 Apr 2024 20:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOAshwPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CDA8866A; Thu, 18 Apr 2024 20:40:16 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24634886A7
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-345b857d7adso862769f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713465612; x=1714070412; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
 b=vOAshwPzm+WsN2fqsuKoLCX6eBIMjJWF13wdh/0P09BeddsIHZ6XbXeg5k8rxzhff2
 LJG+p17hfUt8ZuH0KVgBmQDl1LaetaISNDGFdjQYgNLV9nsXwSJFawp6zZkKHQba1UBC
 0NqOjlCaSovS/Ucp6ODZ+7OHE9ZioTAbjzfgy9nOIcfW+9PSj1sw0OBIqUrEx+Cn5q0I
 RrtTqv3jxC7QhupTTNl9INzYCKgx9kneL/xjp7aOxa6L6UAN0r8Ed+xXaCyMq1e8Hcs1
 POjt7cBFfHKNATVBjnjoGSgdpqfbwdNzoOB41qoCo1Qgvg9d8kXvbzqPpWzZR9L5ec29
 KDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713465612; x=1714070412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
 b=BvVHFRRqMSM/scPj64tioq/p563GrjJhLaIh0eNzxu56YbqIwQXcL92JpWosBDksde
 CAsJQrHLJFfl0eGMxUkCq8NbP65ZletmjBy0l27oafAS+ayZXcPKpWcJCS8my4DA8LXz
 1S9GuuM0BFk2Fm1NbTXRaQMofVH/sX6aYlOOwjSLE2snCyO4QuD+9AaK/d6Xm53fbsWs
 E6PZSn2RI2NR+OFbM5MmsOK1UOqHtB7zmpuUkdtDeZvqxDAM7etfK1oJCWWVFJtRRHE6
 J3Ir9sp2QPu3CZalfG5tIh6JxNW1Uqoj7L9kEGo6WFei0DlhgmZ3dmNp8qE0LiPQ0fYf
 jybQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0bWjCcCJLpqs43i3YX6p+YKZVNnfpIeELWNxkREgRLDsjioIpmArWB2vQ9GqQ0hxINrkolrPmI2Na07D/R/OQRdfLag==
X-Gm-Message-State: AOJu0YxSGR/qNK7hyi1mmSnrst/HnXn2e6KEoQSUab+/btzXMQ2g5KBH
 KIKeWVWUjHjJy8dPDVWTQEebBBChIsOeXXDe/oC8DaINK817YAd21mgykggT7n0=
X-Google-Smtp-Source: AGHT+IGKMtvmY64iqzg4mDnnYJA17+J99tXAx0c7OfQn4wNRfnZ5ssIDevkYpTFXp+KtPlpX6ZXAvA==
X-Received: by 2002:adf:e0d1:0:b0:343:688d:2cbf with SMTP id
 m17-20020adfe0d1000000b00343688d2cbfmr2207786wri.60.1713465612456; 
 Thu, 18 Apr 2024 11:40:12 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfe6c5000000b003436cb45f7esm2451408wrm.90.2024.04.18.11.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:40:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 19:39:58 +0100
Subject: [PATCH v4 3/3] dts: support building all dtb files for a specific
 vendor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-of-upstream-build-vendor-v4-3-d404deff386e@linaro.org>
References: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
In-Reply-To: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lFINIkt3mPUDg930k4h55ttVmUyWegfEw9o+thWATTw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFTI5/5yY8c/Utb9K5Gbjw3IE9kVF6S4OWJi2ybFGzX
 VReU/Oto5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyk8wMjw841L9Lq5ZM3+1+f
 e2K1fvB8ycxY0Y+7p0ysMYs46LtRtoLhr6Svbp1O1qVvDVvY7gquzF/+4fB+kQXq/8z2XCs0XBc
 R9AAA
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

This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
all the devicetree files for a given vendor to be compiled. This is
useful for Qualcomm in particular as most boards are supported by a
single U-Boot build just provided with a different DT.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 dts/Kconfig          | 24 ++++++++++++++++++++++++
 scripts/Makefile.dts | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index b9b6367154ef..6883a000a052 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -100,8 +100,32 @@ config OF_UPSTREAM
 	  However, newer boards whose devicetree source files haven't landed in
 	  the dts/upstream subtree, they can override this option to have the
 	  DT build from existing U-Boot tree location instead.
 
+config OF_UPSTREAM_BUILD_VENDOR
+	bool "Build all devicetree files for a particular vendor"
+	depends on OF_UPSTREAM
+	help
+	  Enable building all devicetree files for a particular vendor. This
+	  is useful for generic U-Boot configurations where many boards can
+	  be supported with a single binary.
+
+	  This is only available for platforms using upstream devicetree.
+
+config OF_UPSTREAM_VENDOR
+	string "Vendor to build all upstream devicetree files for"
+	depends on OF_UPSTREAM_BUILD_VENDOR
+	default "qcom" if ARCH_SNAPDRAGON
+	default "rockchip" if ARCH_ROCKCHIP
+	default "amlogic" if ARCH_MESON
+	default "allwinner" if ARCH_SUNXI
+	default "mediatek" if ARCH_MEDIATEK
+	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
+	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
+	default "nvidia" if ARCH_TEGRA
+	help
+	  Select the vendor to build all devicetree files for.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 5e2429c6170c..790f3c508f19 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,3 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+
+ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := $(srctree)/dts/upstream/src/arm64
+else
+dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
+endif
+
+dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
+
+dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
+
+endif

-- 
2.44.0

