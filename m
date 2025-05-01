Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1E0C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B58A8070C;
	Thu,  1 May 2025 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QtHg3PzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F3982169; Thu,  1 May 2025 03:05:48 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1CA8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so2089575ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061543; x=1746666343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8Jmn70vCHqky9GNDXO3fq/AyqdaOWtD1J+LgfsQGQ8=;
 b=QtHg3PzKjhXoP6B9zNDEJzUrYqsmDamYWBSjUnqH74SwAiXN0OygyQamiZsFtadkxH
 JrHOFUw3ahtzY3+Hvi7SX00fY+ut7iN3BX7L01A/zTVSuhWd+8bC16cHpJU0sUMU+k1R
 zOq81kfXBNigcpVQEzWslov2CU2iBieAgdb70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061543; x=1746666343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Jmn70vCHqky9GNDXO3fq/AyqdaOWtD1J+LgfsQGQ8=;
 b=RK2Ce04ssIrpFx1c6CkB9pIurJm4UDjZmCSCBV8r5Wvr/hpNZHn5/OhEfNKwpVu4dW
 Z52IO4ntwEXUoJvzauFxWPhw/WOsDjirN3e9EgpdN3R72CReSDrwFWT/hittDsggFrDO
 a+q4caNZDrGnOwv7ENL+tmnrNTPsPx/oIezlejYpMIcQYCZJ9j7g6tebf9UidjqPhkNA
 L5Xif09amiwjEutSAOBxALgDpfYnvgyPzyz8n0UcK21ZziFN4rdOwSw2hY2SMwn1XKiS
 6BY8RQj3hTNXBWvKyP+Ck44jG1uOv0G07+x+S256SrN1e4h65NhqUvmX1vfvOWZ+9obE
 Uk5Q==
X-Gm-Message-State: AOJu0Yxgg2EbQ1IPz78fGrwXbuEqw12GzNeVa0bQTFRsGFQzhyMk8VDh
 VybFiGEcbo0ok39hLsdwK6xsjKd6zqOCqKd1ICOFZAnjpkqgXt3xH1nVPUT2xpBafvP3su4kHMM
 =
X-Gm-Gg: ASbGncvM/0xRGLHEHigGGQCjdcWulVTPXr3scc6r/q5JfbD2DC3TYzUVIkNHfn6dNQ4
 g9Db11MK+ry6Dfew34L1IS72tTOTA63aJTGvm7XvkEDCXFBIj5Rxabx2fCv8zgEIaiVC97CrUIf
 J4rg+ydljNSBSWn0J7CxU+Xt349qs11lrN5j9QJdNFNsYZM9TMqNyk5ch45il2hn2C4a1M3LM6I
 9VL5W/ilaguOznFK6AWHjDT3MsdcYchX5HRVnqmF84IfN3tX0IeyGGOsdLmJXAWVhzCMP79w4+d
 rXJt5E6OREP4iEBrTOPnnv24jS2nx1Sn296jICl6N+JG/NpKMKylXYzFqUZtFWJ6xr9vKLaNcHU
 47w==
X-Google-Smtp-Source: AGHT+IFDihQdpiD9ecC2ml4MdYlzAxjplgf8SD3mQf02hCaiCNryMP5V9skc1LEZlh+/GotDtWCkUQ==
X-Received: by 2002:a05:6e02:1fe9:b0:3d9:66c7:d1e8 with SMTP id
 e9e14a558f8ab-3d96f0b7871mr16161095ab.0.1746061543450; 
 Wed, 30 Apr 2025 18:05:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 10/22] tegra: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:35 -0600
Message-ID: <20250501010456.3930701-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-tegra/dt-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/dt-setup.c b/arch/arm/mach-tegra/dt-setup.c
index f4ae602d523..96044ac78ce 100644
--- a/arch/arm/mach-tegra/dt-setup.c
+++ b/arch/arm/mach-tegra/dt-setup.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2010-2016, NVIDIA CORPORATION.
  */
 
+#include <env.h>
 #include <fdtdec.h>
 #include <stdlib.h>
 #include <asm/arch-tegra/cboot.h>
-- 
2.43.0

