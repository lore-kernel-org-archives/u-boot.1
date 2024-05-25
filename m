Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA35C25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 21:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB8A881CE;
	Sat, 25 May 2024 23:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cc0oHcHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A14BA8820B; Sat, 25 May 2024 23:51:42 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C44E881AD
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 23:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-24fe13f1e28so121177fac.0
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716673899; x=1717278699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qpv8UKZg00hL/bIrLkVKS/JNUkbfx8NNqxowNzIR15U=;
 b=cc0oHcHR793gtzuO3K3zhOudJikO5VE0reNbBImKv8+eqeYP94m0iqPRYYOHy3Ss4n
 wfSHjiMHYCw3tI553JiOQzaOGgxMTnfy+gtHRtOCzEYmgZmnye2IL+Y/mpQeZOtEBaoH
 eKAvR3D/iUCNY0ih6zKNiPR83Lo/w6lUWQKVU+5r5S7QLC2l+nNwXEH9ASRb8YgVPedn
 q97s4q1ZewlGhyyo4vfFBFvxhM0bddXvf99rTNMXOF2Xt/C4xMBg9Ai0yc/ZsR93xuJm
 GufMkNiADHnhFjL0bcPwr5vjf5fh+ssjEVS5ODwWyYigP4ObKc0mOxKK/8Wt2zlVRaf9
 CTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716673899; x=1717278699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpv8UKZg00hL/bIrLkVKS/JNUkbfx8NNqxowNzIR15U=;
 b=CnV3e6g+BZ6DyX/DnVjCTiDWmsR4DQQnqHI99AbWru/yxJQseQkXtMlGwLTNY9SP+y
 lZA9zen4xiIhG++043aAWwdUFuLepW3vJXp9Arp6Tpzloan4NrwftZPkRwc9dxJsKCOg
 bEczear0K/qjxTKOyuFv9XUa0lyO1u7aHkjdFFKiEEZETXhbz6FrFrpz4+5QHByZ9jmF
 jpzt60aZANhwJNIsbeJarNngvRDZxYQuM2YhL66uXdUahN/7l8FKpoIb1CYWgOFAaK0y
 iExGK4V1AUzzE7tT1+F4n5I0N+ryVrHjjMFbzB5tEZgx2OXsexXREUSh2ntWT0330yoV
 kfLw==
X-Gm-Message-State: AOJu0YwngLhhp/iFm0dI9NsXxfYIBsqRsWr4BFVlNz7tOlYE/U/UjTmf
 ODgrroCBbOy8Mp3DnasgcreDeKka7dCQ2n5hC5hnA5CgPiMNtyOcfKsUHrVyKkc=
X-Google-Smtp-Source: AGHT+IGXkUjaEj6MaZX4abJIOuVBayTGcH9PwiGTrNksic2V98rT5brMgc7eH+2a1J5REFczZkjtbQ==
X-Received: by 2002:a05:6870:ac21:b0:24f:a0b3:369e with SMTP id
 586e51a60fabf-24fa0b3377amr1615712fac.4.1716673899044; 
 Sat, 25 May 2024 14:51:39 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24ca1ff7c8esm1080400fac.22.2024.05.25.14.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 14:51:38 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] arm: dts: e850-96: Remove not needed bootph-all flags
Date: Sat, 25 May 2024 16:51:38 -0500
Message-Id: <20240525215138.11936-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Most of the nodes in e850-96 appended device tree that add bootph-all
flags are not necessary. All those nodes are instantiated as
dependencies of other nodes anyway. Remove those nodes to avoid
cluttering the appended dts. 'bdinfo' reports 768 bytes reduction for
"Early malloc usage", and 'dm tree' output doesn't change. Keep only
pmu_system_controller changes, which are actually needed for serial to
work properly.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
index 7ad11e9faab2..6d7148f7264a 100644
--- a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
+++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
@@ -3,35 +3,7 @@
  * Copyright (c) 2023 Linaro Ltd.
  */
 
-&cmu_top {
-	bootph-all;
-};
-
-&cmu_peri {
-	bootph-all;
-};
-
-&oscclk {
-	bootph-all;
-};
-
-&pinctrl_alive {
-	bootph-all;
-};
-
 &pmu_system_controller {
 	bootph-all;
 	samsung,uart-debug-1;
 };
-
-&serial_0 {
-	bootph-all;
-};
-
-&uart1_pins {
-	bootph-all;
-};
-
-&usi_uart {
-	bootph-all;
-};
-- 
2.39.2

