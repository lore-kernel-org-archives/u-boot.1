Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42569C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43A588081;
	Mon, 15 Apr 2024 23:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ud3EK89h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770DB875B9; Mon, 15 Apr 2024 23:57:26 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBA387C69
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4edcde7a1so8142555ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713218243; x=1713823043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lsUamYBgzYv0ZpQ2eQQVarM1rktN9R1+HRMOXeVgc04=;
 b=Ud3EK89hd5TxECzyaY0pxgFBaZ5V9VfSlptDXdUCqzN0uTQUQBTw2S9nofUh7ZDkH5
 WoQ88YY0k9BMAdcJuwnekuoeO73w25Dzx3XnzAu9q0gxtzpdJ5S8enB9ggSk9xjhQ0qu
 gUVEXHK3Uz38bF/UxAnPunXj8VSMCvh/f1lEOZaPh7jmOeIhjER0sxAkZPwK29p5hzlz
 b2yG+GVtvwYW2SL6tM/YRsup/nNorwAJKzpXNae8KaQI4kol/OG64p3eWPCvoqnLKUb3
 Uis4DgeQchi9uqWIKGrG8HAL/3TRhnnnb9pex8EkZPFpfth1CWWe/W4mpVlHETB8jc/P
 KCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713218243; x=1713823043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lsUamYBgzYv0ZpQ2eQQVarM1rktN9R1+HRMOXeVgc04=;
 b=viRSV+aeecUPOx18epGT7E3qxN/8756ZL12P5OZ+kKpniztQEridz2BLUoF5XytBjW
 xyFw44Uxx24us4mGaRHEJRuAU9GavhK2NXnYitR9lRdu20CcoRpr2j784zTopzizWPxt
 ai+PSy7/BXym95qndNFhY9Ji6RIH47WZJDBBpLFlPl2ht37Yj7F5AG6NkGAf+ujqHgjq
 sOpXBKNbcPGSvVnpobC7dcvpJ7A0AFdPNjIgVFACQsz9KajooE5+IJ7n7nObBHLt6pzX
 keUzt2e0n0sWuyXqB1NvDxrt3AQN0vSb8KfQmhieItIUvNUGQZh6QSmoIzHOMN4IxM1a
 7bOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV12jOu3Dt2VBXHHm6PSBNVSzx+qWCN+D+flxHJOqnByd4qh3ay5UC4J4929tLExwqxZhkzHJFiQCYE8UbnomOOW69uLw==
X-Gm-Message-State: AOJu0YxHEuNau+wZguaNILM71jBqGc4AnnkBmygZSdLc5KEQ5WoqiuTm
 pkjSqT1dyt4ZPtAb+I1/X5ddxY+xDZVBqYikzXpUZXg2B8FiB63i
X-Google-Smtp-Source: AGHT+IGlOySjungQTD58nZZSJEj5QVa0F3KlmyfRSJidepYmoTmQzUwZJ8puDZ4m/vYYb5I0xzZwaQ==
X-Received: by 2002:a17:903:41cf:b0:1dd:85eb:b11 with SMTP id
 u15-20020a17090341cf00b001dd85eb0b11mr14204568ple.1.1713218242661; 
 Mon, 15 Apr 2024 14:57:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8353:72e9:781e:a68e])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a170902f1d400b001e3e09690c6sm8441128plc.199.2024.04.15.14.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 14:57:21 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: ye.li@nxp.com, m.othacehe@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx93: Move SoC and lifeclycle information to debug level
Date: Mon, 15 Apr 2024 18:57:17 -0300
Message-Id: <20240415215717.3732484-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The following information printed on every boot is not very
helpful for the users:

SOC: 0xa0009300
LC: 0x40040

Move them to debug() level.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/freescale/imx93_evk/spl.c     | 4 ++--
 board/phytec/phycore_imx93/spl.c    | 4 ++--
 board/variscite/imx93_var_som/spl.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 7331a20f94c8..6d5e110b2776 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -120,8 +120,8 @@ void board_init_f(ulong dummy)
 	if (ret) {
 		printf("Fail to init Sentinel API\n");
 	} else {
-		printf("SOC: 0x%x\n", gd->arch.soc_rev);
-		printf("LC: 0x%x\n", gd->arch.lifecycle);
+		debug("SOC: 0x%x\n", gd->arch.soc_rev);
+		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
 	power_init_board();
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index f03bfee9ffa8..5efa38a14427 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -126,8 +126,8 @@ void board_init_f(ulong dummy)
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
-		printf("SOC: 0x%x\n", gd->arch.soc_rev);
-		printf("LC: 0x%x\n", gd->arch.lifecycle);
+		debug("SOC: 0x%x\n", gd->arch.soc_rev);
+		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
 	clock_init();
diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
index 71f346cf77bd..8852aea156b7 100644
--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -125,8 +125,8 @@ void board_init_f(ulong dummy)
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
-		printf("SOC: 0x%x\n", gd->arch.soc_rev);
-		printf("LC: 0x%x\n", gd->arch.lifecycle);
+		debug("SOC: 0x%x\n", gd->arch.soc_rev);
+		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 	power_init_board();
 
-- 
2.34.1

