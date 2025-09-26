Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA4CAC5B9
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F33838BB;
	Fri, 26 Sep 2025 18:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BLJQ7Qu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDED83890; Fri, 26 Sep 2025 18:02:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A44838AA
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-4248b320541so24440755ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758902566; x=1759507366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfI/aEfyUonIZ1Ar6Lt2VWermEzB3jKArx0f+YnOiis=;
 b=BLJQ7Qu69350DBKPgCMjtGaFk/9tfcPMGD3tnSZ11QAfNZI0MU6Uv/FNsvTL1VsiNf
 nXW0kjndgJBp2yV77IqW41cQA8grvZYywb1VTsNuAKZbXusbX102VJ/Q1dm679h04wKE
 q594Km5hpHytMXPTV7V68l1rr2zihZ7S61Jrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902566; x=1759507366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfI/aEfyUonIZ1Ar6Lt2VWermEzB3jKArx0f+YnOiis=;
 b=Hom8I+CcXYUXZPO/xsVlOXsW8dev/hE4qN3ThUODuNXl4Yqep+PyZvOYwgOW8h3EX6
 YcDKr/Nv9gXFeIzwvEUefnDakvAsmqwuf9iaP7NrGRHbUwhssDDssJhlrjGnQtQ/FYqt
 uK2D+AHIzS88rxbCKbZ54EJ2ZOtXC0BxXdaH20zxclodyqRSw/cheKs2R7OeGAJYuzgX
 QIvrPLfrOKx1lPuQbInEyNDdiH+i/MlM4bEXEdRpYOhT8jZXekpr52C6WkQ9fH0lHFRd
 1z731x9HvlWZHiXalFIBfpSDUDYGj+w6Uw9WOYHgFic9HAtZUklpkHynE4gVesZgXNko
 Atvg==
X-Gm-Message-State: AOJu0YzwIj88/8K1d4BvETHJvXzLITn2RlEBkcOru6ijWsmR4A9SiHwX
 lMyl4ORhimEI0dsxhBo274c0Y3nqdCZzLHzV3SjtUpGQY2mBKS47miPHogflhzm4nEifbGwQ2Ud
 r+hC0bw==
X-Gm-Gg: ASbGnctfgbW3SQXLFw1sveww87KrJiHvUoo4078iZ3CI7yU9SNgqDU2i97wg1Ct4Lb0
 CCbsgTrlSY563VAipXfCOYTtNOsrTGnESGptc6SopWbeLt3jDkvhTnGle4e0BjxZ0j9yTjquhPj
 jYtzMKow7K6IwsdcscQWpgwknNE0j83AoVTyln+q1eHNzQyD6UAw/OCJ+phmhXYGLaRnVEzfzmP
 D8s91psidD1lMK9RiGgua2tEVOKMza0yeI3gT95PwVAyreYJTaSN+n7thJJU/EvN9dfpaAo8GW2
 29di6sKVwzVfG83NOATIw/4MDgCYNSRPBtajwgRtqSksqdU3g+dkOqZ79arJ3jvrZyw5loQ3hij
 5suJSsQYg6kbG+LKUHisYxT0rCO0=
X-Google-Smtp-Source: AGHT+IFk/FgNxl6nD99fJiRxmk9ttd/v00bAt4SREbKodhghGOh3TnnglqHeeoGzRIr6YxuweXFtMQ==
X-Received: by 2002:a05:6e02:18c5:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-425955d4f26mr122950235ab.12.1758902555005; 
 Fri, 26 Sep 2025 09:02:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6a5ae382sm1997134173.64.2025.09.26.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:02:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v8 2/4] sunxi: Move to bootstd
Date: Fri, 26 Sep 2025 10:02:10 -0600
Message-ID: <20250926160216.2157348-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926160216.2157348-1-sjg@chromium.org>
References: <20250926160216.2157348-1-sjg@chromium.org>
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

Drop support for distroboot and move to using bootstd instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v8:
- Drop 'select' for USB

Changes in v2:
- Convert the other DISTRO_DEFAULTS in the Kconfig too

 arch/arm/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 625d2e995d2..28ad1341558 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1199,7 +1199,7 @@ config ARCH_SUNXI
 	select BINMAN
 	select CMD_GPIO
 	select CMD_MMC if MMC
-	select CMD_USB if DISTRO_DEFAULTS && USB_HOST
+	select CMD_USB if BOOTSTD_DEFAULTS && USB_HOST
 	select CLK
 	select DM
 	select DM_GPIO
@@ -1222,6 +1222,8 @@ config ARCH_SUNXI
 	select SYS_THUMB_BUILD if !ARM64
 	select USB_KEYBOARD if DISTRO_DEFAULTS && USB_HOST
 	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
+	select USB_KEYBOARD if BOOTSTD_DEFAULTS && USB_HOST
+	select USB_STORAGE if BOOTSTD_DEFAULTS && USB_HOST
 	select SPL_USE_TINY_PRINTF if SPL
 	select USE_PREBOOT
 	select ENV_RELOC_GD_ENV_ADDR
@@ -1229,7 +1231,7 @@ config ARCH_SUNXI
 	imply CMD_DM
 	imply CMD_GPT
 	imply CMD_UBI if MTD_RAW_NAND
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply DM_REGULATOR
 	imply DM_REGULATOR_FIXED
 	imply FAT_WRITE
-- 
2.43.0

