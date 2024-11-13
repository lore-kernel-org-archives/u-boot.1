Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA1CD41C00
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631B08952B;
	Wed, 13 Nov 2024 06:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vPwWK+oR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5083884D2; Wed, 13 Nov 2024 06:04:38 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34B88862E
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso9359210e87.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731474276; x=1732079076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sqNZMVeHJ5Kgup1Ckj/aR3vSdS7qrSWvGZ7apZLs7eE=;
 b=vPwWK+oR2mpNJkzQC+grT/4hkqTMeuIlYc4F9S/cP9MRStn8xC3d78OTe4T7oSwoA8
 y5Xicu9Sp/Bf9ZL1jP+SFHZFV5jrqcgbaQpVgLmf/MZFZs/STL4iBf2p4sjutM1ZBQwJ
 h3WayWQJi8HakDRG4UZTy63olGy+sAhoSw5vgT5bk2N4X1wgvuynYvwKSO68ejt73nd8
 uahzDxrTh0Y9wELWNLdh8IsHIK8QTxbdQ6cepi8jJ310FR1DX3qbEo26nXxd2j8mxB3E
 2p77uHo+bH27YPKy1sgSmaC52GZp8oBSvy/m3MpqiHgPjqogueclAPkCg/ZDCc4ZIg3T
 G2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731474276; x=1732079076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqNZMVeHJ5Kgup1Ckj/aR3vSdS7qrSWvGZ7apZLs7eE=;
 b=dLAnbz19/ZxX9VOX0RwQZjSwEJIaEZ/F4Svm6u4DBh+oBAEM5W2dKaaPGUrVUUgERY
 0q8/6FMTK7lumNBX3xvsxCj5d8hZbel5Unr93JoRjdhZYBiE3m4lm6VxHP+GurfrgJ3c
 s2R53rLhKeVjcmWzDf0qQHiWp6pbimrCP3z4kqVFtCAAxcFp+oB18HfaEspRMFeopY57
 bf4Nj+7L8jco8RKW2X4si8p5J+otEZs5K9DUvem4vd8ePdEiCAMDHH04ZyNYIwLDmqun
 CXTVO20sKB6GQoE3pcUi3z7b1c4L8vfod4IWY/9+2+my2C7/jAaQRXpTS3ttIuQfe0Ia
 CRGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSvw8hyCH5xUGplT+cpmierpA7y6hWaGxi9Q7U9ZWfVH8FaEI4SKY7YBCxwNAdFH4G7WP8u5E=@lists.denx.de
X-Gm-Message-State: AOJu0YwkVbkITh+nSlGE67dnqIkderec1ZVqy8s5tyBRwK7an6G4t0li
 3i8LPVDoroCqslvA6dRFmEJDR8L2GCgUfC3xbijfIoMXhN8faJD/qE4a7GfuOJA=
X-Google-Smtp-Source: AGHT+IFpxHJli8yU7kNIImfypOhLQYO7sahItmNlZ/7sHZUMtZOE7o3gDRiWbP9Sa3vjq+UxwbTqCw==
X-Received: by 2002:a05:6512:3a88:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-53d862ee7b7mr13461433e87.42.1731474276170; 
 Tue, 12 Nov 2024 21:04:36 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17662sm828002466b.28.2024.11.12.21.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:04:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: u-boot-qcom@groups.io, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: configure logging
Date: Wed, 13 Nov 2024 06:04:17 +0100
Message-ID: <20241113050431.1848951-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Set LOG_CATEGORY and pr_fmt. Also fix the time.h include.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ab2ceb51389..bbe9d3de7636 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -5,9 +5,11 @@
  * Copyright (c) 2024 Linaro Ltd.
  * Author: Caleb Connolly <caleb.connolly@linaro.org>
  */
 
-#include "time.h"
+#define LOG_CATEGORY LOGC_BOARD
+#define pr_fmt(fmt) "QCOM: " fmt
+
 #include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/psci.h>
@@ -28,8 +30,9 @@
 #include <malloc.h>
 #include <fdt_support.h>
 #include <usb.h>
 #include <sort.h>
+#include <time.h>
 
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.47.0

