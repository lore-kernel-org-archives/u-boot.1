Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FCDC678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 14:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC22082B20;
	Wed, 11 Jun 2025 16:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WKQJbymk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978BB82B7C; Wed, 11 Jun 2025 16:24:08 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA2082B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 16:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4a3db0666f2so149712081cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749651845; x=1750256645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tz+gXm3HfyEOxhYW9NbZ4ugd+L9plDKVx59FEiBnuKs=;
 b=WKQJbymkJx5FNo8wdfrJGVykvKuWqLlRV28QyntD/I8yCOkG1Fjnz1xk97oTocFFyg
 oGXl+7/WREmDYkDOAl61IZEDFmUBt0t6X0SmlueoW9itmljWRjbFLHprCPhGhMMAZ7TE
 7P6EF59gbIQ72FGLvEIfZ4mtvWra4bnEyFD94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749651845; x=1750256645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tz+gXm3HfyEOxhYW9NbZ4ugd+L9plDKVx59FEiBnuKs=;
 b=QHCFFws+x+lSG90pIaRiyYy+xhkv9P+gM0qkPZVwm4Dwrp2X032UU+8g2dO8YkJ8hR
 2m4EkiqUAijGKBJFeguddb5+8QemOxaRtMV5AnaLc/21Ccnw8YxgOdciaWTaH2uDXaDX
 LKDVcF1iOEziXcIaiK1s1KddfV+OPVpYJAqW8WINhNW60tkoHv8VjcsLTWXWcjztAwG/
 8fm/RbDZUeNNEsSAdN7DWcyZua6Rx9uN0PUesTeSEV5Jm7Hkbwm4T7i0cSopk6xyByFe
 bvAKA4EVkCZULAbWrgYALSuZWv50Doo1Zob9mYxfDkdAJ+KT/ohZuDdoFELnczH+rQti
 hNTw==
X-Gm-Message-State: AOJu0YxXyApUNVqAO3xfXeIzGAlRxEF8Pyp30PjavJtveDLM/Rs6qwXh
 LsOswpTGELfQuP4CZq0Fnbg1IV8qiKZOa15u0yX7cV5XXpbRoydtqi26yJCC8IyJZxiK/CWcdlI
 Vv3OIf9I=
X-Gm-Gg: ASbGncu+6oozyYyCGoyHaV7wovi/ox+Y6Bpf00Zwx5ettIW2BMNBaI1QqHHWF6+67EC
 CRaeWeS7mKmqh5BV0aZo1j+cu+A17MqIssTa0BJmxg8Pe1iqwmXuCmOXevweLc16kgE9b3GxdLv
 157Tg/TAMsw1+g2HNFEc8aHSwWBLy4wRiJXfwwK5zIJkzGpX8IoOQc1u7GTQp1ElJvSg6SO25XB
 e0CSJOoes1sLsbLccpmjY5QyZIr/u1KqEHOZk4VyXIo2yV/ELJv1VJCH+P9KKBDPrBkXCzS+qO2
 /doAXniKaUIOZYmNsisNlbSLpioP8IN/drjBrlURBG3Qb/EiJVZkA1MWShfszefOsL03cOCgkMT
 o6ksP5RJDseWFwqPJt2Ti5vm/nw==
X-Google-Smtp-Source: AGHT+IGOt1Xx4zJ8sHD7PmWMzOGn5uS22V1Cs6STHokFVhsyPbFB97OtzuWSk7+H1oB3EucynhsdHg==
X-Received: by 2002:a05:6808:3096:b0:409:f8e:72a7 with SMTP id
 5614622812f47-40a5e196c3fmr1560990b6e.33.1749651833862; 
 Wed, 11 Jun 2025 07:23:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a5d95e797sm339823b6e.40.2025.06.11.07.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:23:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI ADMA options
Date: Wed, 11 Jun 2025 08:23:52 -0600
Message-ID: <20250611142352.3990076-1-trini@konsulko.com>
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

When doing the investigation for commit 53bb8fdea12a ("mmc: Kconfig:
Correct dependencies SDHCI ADMA options") I missed the implications of
MMC_SDHCI_ADMA_HELPERS. The problem is that FSL_ESDHC via the
FSL_ESDHC_SUPPORT_ADMA2 option will also enable these helper functions.
This in turn means the correct dependency here is
MMC_SDHCI_ADMA_HELPERS and not *MMC_SDHCI_ADMA.

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is a regression vs v2025.04 and so I want to get this in for this
release. Should I apply it directly or will there be an MMC PR for it?
Thanks!

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 38867f30a7eb..1c9b6898bff4 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -528,7 +528,7 @@ config SPL_MMC_SDHCI_ADMA
 
 config MMC_SDHCI_ADMA_FORCE_32BIT
 	bool "Force 32 bit mode for ADMA on 64 bit platforms"
-	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
+	depends on MMC_SDHCI_ADMA_HELPERS
 	help
 	  This forces SDHCI ADMA to be built for 32 bit descriptors, even
 	  on a 64 bit platform where they would otherwise be assumed to
@@ -538,7 +538,7 @@ config MMC_SDHCI_ADMA_FORCE_32BIT
 
 config MMC_SDHCI_ADMA_64BIT
 	bool "Use SHDCI ADMA with 64 bit descriptors"
-	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
+	depends on MMC_SDHCI_ADMA_HELPERS
 	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
 	default y if DMA_ADDR_T_64BIT
 	help
-- 
2.43.0

