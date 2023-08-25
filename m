Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A6C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C03286A15;
	Fri, 25 Aug 2023 15:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="T2oIFMH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FA486532; Fri, 25 Aug 2023 15:47:41 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377EB869F9
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcde83ce9fso13927161fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692971258; x=1693576058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F7JM0DVgbhZyTdUMXFPB2uGB6cjGT9BwOUYhadKl4uk=;
 b=T2oIFMH2Wv10i0hQ+NIQ2LY5CQ2HVgSiOXkIL69Unfc3FkY2kjv5UdeP5kINV9P4nV
 kekkbZ08ooQC79suHLOauchnlvP9/GSXkAK7N8uXvW7lEUSy8o007DqJOn/dlSLj6aUI
 7yXEEV2bUqkWc5xyKqesoe93sAhbKQ7OB+y1GOj+g5RyBZPOeUi+6/ZG1+FjDZfrcJ7I
 4SknXz4wuBJmZafCCqbTUrx9Lbl+kxm+Ep1+Th+SqEA3SabKjDlFQY38+n05PEtOhNKT
 h3dXO2gSlSt41AKJU7/LiOOviBxZS6TKE3BW5DwOr3xoOsCG5a7O4tBrUHkjg35Nwv4x
 YXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692971258; x=1693576058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7JM0DVgbhZyTdUMXFPB2uGB6cjGT9BwOUYhadKl4uk=;
 b=IDrf6TIdlcwAH0qN5fCBxaZn2E51YRfjTXn0hCEnuAe7zin4JXHHpq22W1pB3COTE3
 TXNLEJ08ud2tGhMOvtqKw1O/yAb6eAUewzb5zeTWQ2UD4sWjoFGAHck6LltXVL7eXExm
 HK1xIBs+hUfFo6gtbYNF913iQOvCppxm8iqUS+8Q02GN7570i8N25Hq7mE7voIm/QjEd
 TzSOIID7lwQJGXoO4l4CbJKGgTOcIsyddZAi/hpKrrAy4fGUZfypA90/rWULK6myFtOd
 0GG53la8lWij+K0PllJ32t+gouEOVziIVjh0FJceXklAEPJu2j+lJXYj+02GciTR+quQ
 pBIw==
X-Gm-Message-State: AOJu0Yz5+z+IIS7Uxh8u3RtuRcZX1YhfPRwEXR5nEWI1GWAZN+gQu6iN
 po+oThXaUQF0fgvoM70rxifShVPwur0NypJk97Q=
X-Google-Smtp-Source: AGHT+IH1K6LO6xn1IwgclaV5L6KiOREQ8nWYi3qVh4CWUT1VGi2LPD8KzTdLceaCPrdFM/Otdgnd0w==
X-Received: by 2002:a2e:8759:0:b0:2bc:baa0:57b8 with SMTP id
 q25-20020a2e8759000000b002bcbaa057b8mr12024226ljj.15.1692971258111; 
 Fri, 25 Aug 2023 06:47:38 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 t8-20020a2e7808000000b002b9e20d0356sm342065ljc.114.2023.08.25.06.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:47:37 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Ricardo Salveti <ricardo@foundries.io>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH] Revert "arm: imx: mx7: Move CONFIG_OPTEE_TZDRAM_SIZE from
 lib/optee"
Date: Fri, 25 Aug 2023 16:47:11 +0300
Message-ID: <20230825134734.21041-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

From: Ricardo Salveti <ricardo@foundries.io>

This reverts commit c5b68ef8af3c2f515c1f5b8d63a69359a85d753b.

CONFIG_OPTEE_TZDRAM_SIZE is used by imx6-based SoCs as well. Move the
option back.

Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 arch/arm/mach-imx/mx7/Kconfig | 8 --------
 lib/optee/Kconfig             | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/mx7/Kconfig b/arch/arm/mach-imx/mx7/Kconfig
index 0bb18f65200..3c0208e13dd 100644
--- a/arch/arm/mach-imx/mx7/Kconfig
+++ b/arch/arm/mach-imx/mx7/Kconfig
@@ -24,14 +24,6 @@ config SPL_TEXT_BASE
 	depends on SPL
 	default 0x00912000
 
-config OPTEE_TZDRAM_SIZE
-	hex "Amount of Trust-Zone RAM for the OPTEE image"
-	default 0x0000000
-	depends on OPTEE_LIB
-	help
-	  The size of pre-allocated Trust Zone DRAM to allocate for the OPTEE
-	  runtime.
-
 choice
 	prompt "MX7 board select"
 	optional
diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
index 517136a4485..e6834d4d3e1 100644
--- a/lib/optee/Kconfig
+++ b/lib/optee/Kconfig
@@ -11,6 +11,14 @@ config OPTEE_IMAGE
 	  This option enable the OPTEE specific checks done before booting
 	  an OPTEE image created with mkimage
 
+config OPTEE_TZDRAM_SIZE
+	hex "Amount of Trust-Zone RAM for the OPTEE image"
+	default 0x0000000
+	depends on OPTEE_LIB
+	help
+	  The size of pre-allocated Trust Zone DRAM to allocate for the OPTEE
+	  runtime.
+
 config BOOTM_OPTEE
 	bool "Support OPTEE bootm command"
 	select BOOTM_LINUX
-- 
2.41.0

