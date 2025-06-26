Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69049C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8510782E08;
	Thu, 26 Jun 2025 14:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R66TKRxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E526282D83; Thu, 26 Jun 2025 11:35:36 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD6A82D88
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so119544066b.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750930532; x=1751535332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=R66TKRxKTTlQuoa8nvpAKxmbvHQTWqZCmZAhS0RF5uKZ35rQrW0slQ1mpt6w6EgUwb
 Mf1aeoRUiJPyFkoKEfoh1Fp9UIBwx5exhrzCP57F3mXgtCVvGSAIgJYq0tw6IxOqeoIQ
 vYcCjrgQbIA+vjL9+V67HKkAeYQC1R9DDynclVyIb27aBoQyoarz14lis2BqWTb+0Z6z
 g+rNbU6h5J6nWkKLcpTK8+E2eTBKUIddcdWYFGcUPhZuPEW+yFgrWf3k1tjQP5lZaVSw
 xr4q7r/1AV1naYpa+vakGox20vtYRNgQBL9yRm3U5B/u3Cvje3E35uw6CBMbXV2RU20P
 3P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750930532; x=1751535332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=EHpEN4P3pEmZ7FQYg41wNXCJ9ooksTXrtpCAdGA2I7Dr6L/OgpQ0VHNqp3g77kMH3o
 a2iyvr4ETYviPne7GIl26fVIFhMfItR0PnGt166dePV9j9LJYTKUoUU2f8lwm1HV39yR
 qgbZ+2VOmj5QUaHpTqQKP6PBHWZMlLJGD05nRb4kpbvwFSaXoDCI+D2cvR+W4ssCqXaY
 VPmPr4EQxfOgTVcijUp2d9WdSY0bEhVDkp25QuEOhtBDqIIzqQgmucblnz/R+BXWJRXT
 /1IjfGJpDtfEYHao/oTl16WQg/57041r4k/rmmWvl9BVg6uq5HXwaqbB5ttCgqYjfnuK
 w5tw==
X-Gm-Message-State: AOJu0YxE/vZORXtW7b37HyLqttS46kTjREW88lWXWhkChuPX4zw4kdsF
 KWVx1yJLIyvHxvMAw5XznjucUyvE0tw12k05AN5AAer/EQour4VVIMA0uPk+ag==
X-Gm-Gg: ASbGncsEbRMKgZLYlqKB314NHtAJYUOiWHNMuGvvfhgLPAlpaWx3COyrPN1ZASXe78Y
 Kdwk3vIcK/bWbiHJ5JmnwErVI4KEBwW+/Ts/Z/6GKCsjqqKm0u7l09s98BKXv4yR9z6oznPDWJe
 r1yYbIjIcB/Hl1kStcca9RHGllSjXWCQBHsDAEofuG1b3R7M+qYC3e6qqqzaYmBst6pXCYKCrTI
 SBXCMLu6nchXZIMJvbj3Be6QFDrVxSTrbdjiQ95xC/I7+lNElahwKZxB1eaRgvMhDH5QCimtB1X
 NgOjciSmDj6Rc8X3VAsE1dDJRvmj6HS7oE++HbWmsSw8tZw8tVuwpgAMQ7Ru6Dzz
X-Google-Smtp-Source: AGHT+IFqXrobfq5fnw/Y6cRRkbZu+GbCKaJqNeHAr01tn9vlPwVZ1MsG38te0+J9QupK2KctoeBAVA==
X-Received: by 2002:a17:907:c88b:b0:ae0:a116:b9d3 with SMTP id
 a640c23a62f3a-ae0befc12efmr613219366b.60.1750930531535; 
 Thu, 26 Jun 2025 02:35:31 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0d950eae0sm76670766b.149.2025.06.26.02.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 02:35:31 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v3 3/4] Enable FPGA commands and drivers at sandbox_defconfig
Date: Thu, 26 Jun 2025 11:35:15 +0200
Message-ID: <20250626093519.115655-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626093519.115655-1-vtpieter@gmail.com>
References: <20250626093519.115655-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Jun 2025 14:57:08 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Enable to facilitate compiler checks on most FPGA-related sources.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 configs/sandbox_defconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 4f6943d1a4b..a64e208ad89 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -78,6 +78,11 @@ CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
+CONFIG_CMD_FPGA_LOADP=y
+CONFIG_CMD_FPGA_LOADBP=y
+CONFIG_CMD_FPGA_LOADFS=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_FPGA_LOAD_SECURE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_PWM=y
@@ -196,6 +201,21 @@ CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_FPGA_ALTERA=y
+CONFIG_FPGA_STRATIX_II=y
+CONFIG_FPGA_STRATIX_V=y
+CONFIG_FPGA_ACEX1K=y
+CONFIG_FPGA_CYCLON2=y
+CONFIG_FPGA_LATTICE=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_VERSALPL=y
+CONFIG_FPGA_SPARTAN2=y
+CONFIG_FPGA_SPARTAN3=y
+CONFIG_FPGA_VIRTEX2=y
+CONFIG_SYS_FPGA_CHECK_BUSY=y
+CONFIG_SYS_FPGA_CHECK_CTRLC=y
+CONFIG_DM_FPGA=y
+CONFIG_SANDBOX_FPGA=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
-- 
2.48.1

