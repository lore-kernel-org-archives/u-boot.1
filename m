Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CC2E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4CD087466;
	Tue,  3 Oct 2023 08:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdNOpiyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F248745D; Tue,  3 Oct 2023 08:37:05 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6AD87281
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5046bf37daeso611078e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315023; x=1696919823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=IdNOpiykIFR/07lWKueO/i1rgokcUi35HGsoGcIBF+4C9gk68r2MF9mnoodnk84hCo
 2m3TnU2uL29pUu/O+i0rMKTQvIbRD0iJSrmif0qV3HuwgyWoJwV0GwWgplQMuQ2Cnk1z
 UsnZHufDr/v0FiaMjFQnvUHenPfJUYHKZ5lrRFbW6O/OKiDuBIANRCN2C/w5UV53Ik5s
 5ujpGAh/C5DmvXDODbVaRkw4GUcVeHpycR0nqis5jghD1ibbEOYEnbCUQsKPIhpcWyJe
 pdsnyAa8OTClcM9nWXjl3liajlGm/Ta/k5lC1H8AMMwsbaGPQJY1jkQJJP03JyLA8vyk
 YBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315023; x=1696919823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=RYxiHIztopJ74utB+rpLOoADPgHVw91g3NoxBt/ex80+RDeMTshRfOAx/1pETIURcW
 nJzRHjmF00eqNbCw8+txT16n6ob2fc6cUiaIOl/mNFK0imMTbTaVc5cidPmlZOGgkfzo
 kOFavFQLX2GTqgkuN1DEmvfftx+Wd/az0SLmyfv5LcH+gLWTMsp1TeS9zKpNXxrkN3/A
 UUlPPRKHTpMcpQVMuWOUfKOoVukV/QOZlcrOUo+uy2YUcQFv5a84tZ+hh5sKcmHL5HlZ
 0aS05Z17GDzWUa+I/m4U07+pQqeXue0uY98hUSjgxijw/lnEiAqw56YTyx2uMkXZfRqy
 dFCA==
X-Gm-Message-State: AOJu0YwOfISesPpu2SZyZc7hycAiHA/ReLpMim2Ua2G2yL6NILVGqMMx
 jh1ushQeRhgyUgKIfbSHzdQ=
X-Google-Smtp-Source: AGHT+IH0D7z2C6krHgTTLUTJPCgV+ifzrQQa+8kT+P8OEXrNj4DDm3GEas+IE3nYSDVAgs6l5dmqug==
X-Received: by 2002:a05:6512:29b:b0:503:fee:5849 with SMTP id
 j27-20020a056512029b00b005030fee5849mr9494242lfp.53.1696315022663; 
 Mon, 02 Oct 2023 23:37:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:02 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 09/16] ARM: dts: lg-x3: complete missing bindings
Date: Tue,  3 Oct 2023 09:36:40 +0300
Message-Id: <20231003063647.42770-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Clean up the tree and prepare for DM PMIC migration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-lg-x3.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 922e39915e..6e52fc5a53 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -91,6 +90,14 @@
 					regulator-boot-on;
 				};
 
+				avdd_3v3_periph: ldo2 {
+					regulator-name = "avdd_usb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				vdd_usd: ldo3 {
 					regulator-name = "vdd_sdmmc3";
 					regulator-min-microvolt = <3000000>;
@@ -103,8 +110,6 @@
 					regulator-name = "vdd_ddr_rx";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-					regulator-boot-on;
 				};
 			};
 		};
-- 
2.39.2

