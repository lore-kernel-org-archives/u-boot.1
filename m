Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8A6F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28621842DB;
	Mon, 23 Mar 2026 20:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HxhmpceW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4D084088; Mon, 23 Mar 2026 20:53:17 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20A584246
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4670bcc40d7so1474567b6e.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295593; x=1774900393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iasQUtqpORLp5bhhnKTX2FHUnLZbIT9Je5peBjZpi88=;
 b=HxhmpceWGJd+OhjVaKWUtu8LuIeMictrtTpwTBRXk5ceGdcLYPtRKEiGOqyUoifPiT
 KT4QBX/wuCiGxXwhV7vArS7jPsSZBypkFPFXK82BLpjrczDocB6vLqQqALYeVKJq5Alg
 Z+EdRIUQf4abVO4juTT2TnQJZfH0f23vdoZpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295593; x=1774900393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iasQUtqpORLp5bhhnKTX2FHUnLZbIT9Je5peBjZpi88=;
 b=nFId6fKn1dGJ0sVAtu6UbZFwI4Lftsv65Y5mAlGiagQgoCs6CLBE0Jz3UCA40dbc7H
 cW2z0MxfsU5NIrTx5TZjU7NW1qMksRj1sPcgkKA4IF+hbzacT6j1osqc2HIr9W4Dn3mm
 6qO4v/TILcJ2uCgf3vzwPC7lleVkrfdrRC7lulzY9OykZJcxdpwMVnnNgS+qCebLES/A
 sPjRsLg26x9F0S0qz+W/Kbt2lWQZwJYJZ2lrbk+979JzA9Dtg9IC+G3iFOkkUgh04P9m
 FtqusKHd6ltOfODuJTtm6Th4gG4kIZ3D7v6XsKTA4UZkYGr+qnSwh1dZBgYiSvWJ7fgJ
 OvCw==
X-Gm-Message-State: AOJu0Yx/2jL7Vk1zsbylBPutOy5JmPdCde5iV7eu0gtQdYEBiNYsr4QF
 VWt27PCxKfLpr0V3dIqXOdunsautPdmWIHRta/0CDJLEfxfdIW0Vpr/w9OmU5d5o7TPzUKy2QPc
 fapqoUw0=
X-Gm-Gg: ATEYQzyvvEbZMj7OaZxZh7mWJDg2g3Si4OfAaT81bcYp1cNzs64g1BYkZi8Bnw42xLI
 ofksfwOyMeNTEDqBNdD53oGSAgppBMVM7Q81SvWeCN4D3x499y9wJAy8BSj9LI0EX+1hAUjikDP
 UN7hb4CaMiOspSkpQfPDUA0/inx5rNoPULkJoGES8/BpkM6XDzZDSL23yH78x2FjS1CHOyaxqal
 QjK85hXN5MG90sYR/hYaOxjf1aMVq20CK0U9u5W+gfJZVhQwTg0SR6+jI0Rd1qlysI+5z07xMNH
 aAJ8i7HdY6nbRVbPhiul0CS3F1Qe1b8HC1Bap2B0C+h/BSdTE96OQqCmllPDB4NmT2IpIveNVau
 svxVvCTnyUtLlJIYriJTYO/3BL+IxFHMStJhIG8vYlS00yc4tTsID4I/3FQ+k4IBroBBX9uCRkv
 10jW9z6j2qcIpQ5JH85Ae8U3YMJg42rjC9Px4rjgaPwlr2N7tv6Ub0Vg8CQ944OdF4DxFp35OS9
 ARTD0NuLzF7ARUvR/UHrD/3f3tUZ3XOQoRVD28ZIUwbXxs4Nek=
X-Received: by 2002:a05:6808:4fcd:b0:46a:cc:24f4 with SMTP id
 5614622812f47-46a00cc3013mr2169941b6e.5.1774295593159; 
 Mon, 23 Mar 2026 12:53:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7f131b2sm7178499b6e.15.2026.03.23.12.53.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] video: Correct dependencies for VIDEO_TIDSS
Date: Mon, 23 Mar 2026 13:53:11 -0600
Message-ID: <20260323195311.2363654-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The VIDEO_TIDSS functionality can only work with PANEL enabled, so
express this dependency in Kconfig for all phases.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/tidss/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tidss/Kconfig b/drivers/video/tidss/Kconfig
index 3291b3ceb8d5..c98491100597 100644
--- a/drivers/video/tidss/Kconfig
+++ b/drivers/video/tidss/Kconfig
@@ -10,7 +10,7 @@
 
 menuconfig VIDEO_TIDSS
 	bool "Enable TIDSS video support"
-	depends on VIDEO
+	depends on VIDEO && PANEL
 	imply VIDEO_DAMAGE
 	help
 	  TIDSS supports  video output options LVDS and
@@ -19,7 +19,7 @@ menuconfig VIDEO_TIDSS
 
 config SPL_VIDEO_TIDSS
 	bool "Enable TIDSS video support in SPL Stage"
-	depends on SPL_VIDEO
+	depends on SPL_VIDEO && SPL_PANEL
 	help
 	  This options enables tidss driver in SPL stage. If
 	  you need to use tidss at SPL stage use this config.
-- 
2.43.0

