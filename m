Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DFCC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 10:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5D682B31;
	Thu, 15 May 2025 12:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oE4Kp258";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0F982B37; Thu, 15 May 2025 12:03:05 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9984D82B2F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so3829325e9.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747303383; x=1747908183;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/SPXq4bsFUheBeAN54TSGhJH0zAFFGQH0BD+eMTKbQ=;
 b=oE4Kp258sorkRnb1eipDzWFEDzgbywcOklaq1+yFJBLcMC0mj7bHLJs7yJTh62tqQJ
 ewVw3pYwDQs8srUhm3tIj8Sl3isgPVeuk6jLItSwJgh8E2OfkAVM/00nzBtYPqNd922e
 teXVJx5Hl6I0i2jNa+3UIpD/kYQbJcjd4mYK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747303383; x=1747908183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/SPXq4bsFUheBeAN54TSGhJH0zAFFGQH0BD+eMTKbQ=;
 b=LGLv1WgvJK3kFNbciHRtRmjxo96AdtwYsixoZi5xdNUxTI4BppzLR7Cw/mTtSCuM6C
 +Rx5iIVqQEAT0ETaGjp/tDt6Wf4suzQNo0uF9rlL98i0l03q9HBUgmjAnX6417DybcJc
 I3Bcbf9tmUli1EsDfiz4vMUS1jDQ5riV1ORGDgpbDczUpPCmtuHzhvlL/muELyc9+6ru
 s4T3H+mTko/xteBkLUaqkPRiwhzyhx6lC8E83H9HrKmSgFyWlPCMee33uycLIcfMNR/J
 ztlWGsK62Z3cGaOQoe7CQ6fT2epZrUuK4Mbxm3UzLXYeRoM6ooS4uk7lKiPrBg8XvPGu
 UrWg==
X-Gm-Message-State: AOJu0YwC9in3wPK9wu82T8NBwtT6Hy0rlFmnURSWDwpM+ncerL7k6Bjf
 zhNcgkTvzM+cAbtAG3RlPCIz/QcDg1GEM0gJAkL6fh4NWDI/UR99uGqK5ygcG1PwNudKoL60aNl
 h81BqEQ==
X-Gm-Gg: ASbGncvDjBQK5b7hgsL9Q6FRHdGXirSrMp+xE3q6lwchl0vOZaCjlDHSB78aFWnGb+7
 PXFMeP5hBeX+RjER4K9gtNvit15MsjM33bBMduWwk4Tisw91cIbyJgCrfRNwz5rfN7UOY1Czxz0
 puQY5rthccVB20G1Ec4ycr7mcMDU0oRtILLy/B6EtF7w8RTOcCpazBf1SLdImJi0qiPkOakWFRk
 Gz/ojzEbr+XxIPFt62yfZYS3sK6UCIED+TffMNHsVYRK79THq26F2MsjUKnBwJsiQVyYBc9q4FM
 QksDXYs6po4aLkGPVoFOhrNNwrWC4qmhlqkiyLcQfF6XT+IG+3wcwu0xAIcB9+1BDgcNNgqKhr6
 +6xW44r/SVjlUReVw+eFVt08Xdxj6a41d5uvltV+5vWA=
X-Google-Smtp-Source: AGHT+IFEmbOaQ9XSZQmsw3RlsWPfKmjGTcl2vpuBCMhg1k2Z3/GY8d5xoJ4VE28nHMnL1tAy8UI1qQ==
X-Received: by 2002:a05:600c:1c12:b0:442:c98e:79ab with SMTP id
 5b1f17b1804b1-442f20e8159mr65645505e9.9.1747303382719; 
 Thu, 15 May 2025 03:03:02 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b680sm64897765e9.40.2025.05.15.03.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:03:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Vitor Soares <vitor.soares@toradex.com>
Subject: [PATCH] arm: imx: imx8m: soc: fix the macro name
Date: Thu, 15 May 2025 12:02:47 +0200
Message-ID: <20250515100253.730388-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-imx/imx8m/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 567e8e9e81a0..806adcf145fa 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
 #endif
 
 #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
@@ -826,7 +826,7 @@ unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 
 	return raw_sect;
 }
-#endif /* SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
+#endif /* CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
 #endif
 
 bool is_usb_boot(void)
-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: fix-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
