Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EF2D6B6D6
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7A189250;
	Wed, 30 Oct 2024 21:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yh0KrVdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0213989255; Wed, 30 Oct 2024 21:46:33 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD60D8924B
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-260e6298635so560506fac.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730321189; x=1730925989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=luBjcYhccKa69jDPFIv+blstp2f391ITBeSd0ucRAkA=;
 b=Yh0KrVdZX9QhM3vt12U0s2F/TNauM2rq5dIVyuSL4PzDJZozMW8z6Y7Q72fjaICL5H
 aHCBJHxvgjHpSZSJ73RLlWIw3tW1Rccj+setLd1d89IzzRgd62x/AMRVBRgZcGR7/9cJ
 b1tOecjq8J3/K3+e2W+uXGMHrsxohE43fqi3PtFX3QDQKuWS7m054mXkbA8xwZviCC78
 k22SUFj8cwQ7B5tWDulYxH/ezKHzFKfnC+PetaFHvMttviytOBKvy47CvDNMGbhHvoyR
 in4l26/nOwHKL1NjadAE3RtOA6lVZEi9RZdxmRyw8gXJnDOtbWKabjF2zlLTH/anywIW
 ASdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730321189; x=1730925989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=luBjcYhccKa69jDPFIv+blstp2f391ITBeSd0ucRAkA=;
 b=wrudJpXxEk8XOf+NndkVNHeMXQKFqG9xQJNd4Gk+LR74jBvUwICT40C+13YonwX5xb
 8oRheaK+xfmB0HBmazea0Rqz1Ydc5P+rAY+Svk6aCkhJsVjQ9Q0n3vSDFMXL3rNWUhxP
 u5ApyryC/IJTf4wWs155aIqjcymMbRxYmkBbhM1mtVy/ROsYLrKo9kgCL3x5saTRKaAZ
 H0jpd3YLwUN5F0lvNbU8yir+RUkMlDt+0JPP97m9j8ZbYHMwNUmkdOisu647arY36MdT
 sXlMdv/PR20imr7QtEaqKVbMO4MzuldYphlAxGoLOQOlMwPlEta1hwCXa8Af4zuLxNoX
 2DOg==
X-Gm-Message-State: AOJu0YwyheBqe7EqWrQRsFaB6dDHe3/I3STft7AwXEkg0TchuEbO9rhD
 twQ721wPsxPi3PHpceJcD0AzxR7HlhGoLeLe7NooB+OrB1kWZadCwYtPQexAXhg=
X-Google-Smtp-Source: AGHT+IGEXDZtnDM9g1IrlMJtt8vEEd3LFsIt8b+qSTVjbeT7w16Jow94/ZsCUYoxskb0/sXjK+1uyQ==
X-Received: by 2002:a05:6871:791e:b0:277:f713:c101 with SMTP id
 586e51a60fabf-294887b8816mr24829fac.15.1730321189274; 
 Wed, 30 Oct 2024 13:46:29 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-294874c8defsm40062fac.25.2024.10.30.13.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 13:46:28 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Minkyu Kang <promsoft@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] arm: dts: e850-96: Remove TRNG node from appended dts
Date: Wed, 30 Oct 2024 15:46:27 -0500
Message-Id: <20241030204627.31757-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Commit 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into
dts/upstream") updates the upstream dts for E850-96 board, bringing
upstream TRNG node. There is no need to keep TRNG node in appended dts
anymore, so remove it.

Tested on E850-96 board by running 'rng' command in U-Boot shell.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
index 3aa5d8bb10d0..6d7148f7264a 100644
--- a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
+++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
@@ -3,17 +3,6 @@
  * Copyright (c) 2023 Linaro Ltd.
  */
 
-&soc {
-	/* TODO: Remove this node once it appears in upstream dts */
-	trng: rng@12081400 {
-		compatible = "samsung,exynos850-trng";
-		reg = <0x12081400 0x100>;
-		clocks = <&cmu_core CLK_GOUT_SSS_ACLK>,
-			 <&cmu_core CLK_GOUT_SSS_PCLK>;
-		clock-names = "secss", "pclk";
-	};
-};
-
 &pmu_system_controller {
 	bootph-all;
 	samsung,uart-debug-1;
-- 
2.39.5

