Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE59DD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCA6892C8;
	Fri, 18 Oct 2024 01:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SRR88Snq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D55892B8; Fri, 18 Oct 2024 01:25:44 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2D789257
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so5629755ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207541; x=1729812341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ssju8959SXHzP7K3TO0owIJ8KEIUeMfNrH6wT0JUi8=;
 b=SRR88SnqWGh2Jziu+saZe5NJ94hae7CuVBjpX9W5Rae+yOS4CfkdVZEcPcH7DeTaN5
 flSNqcPLnRarCyP8pwqDjqJuniph8/P9xw6DMb6SzU3gtFVxZGB6b+pEsrJlmacc+vGS
 5SX3GDA+YwzHtnEDhw4YF5A60WxcTSE+bdDg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207541; x=1729812341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ssju8959SXHzP7K3TO0owIJ8KEIUeMfNrH6wT0JUi8=;
 b=ulCk7dHSyswuWGbFDEUvFN3zqQfYvXUUunyOv+JKLVvGJTUK4WzbrqCWKnU68+l7FQ
 jy4rbj9SDEv7bGEOH+DjzVFIh4kzufEKmQvfStOWVxKJKMycbhJs1XhhjQu2kHGC/SHd
 MruaDApHwpZVR64sE2lnC6HgiptblOFpzATCwT2EyXVTU1qmWaMj8slVL+6elZIxpRVZ
 Pf5C6Wf4t/9/9dSaGMtn2rQak8j2uWdAcSy1qG5L/xttfZeMcfDp3RkVW/DQrj5ovcYd
 6xJqh535pQ1qwSZzQsqSztcbWSnWH0IPgMkJYly2oPqUtitPvO+T3dAKg1mrtiGKP9b3
 ZItw==
X-Gm-Message-State: AOJu0YxqVkY5RoHsaVTY/c+a+ga7pKZkJ0jI6co8cZvovtfbreK5ja6w
 IIOjbtr4cz16suZavLdy52lDsPIxXIGc8fniJMDjChXelB0U5b/JQ46W83JcozGposMByi/SEOg
 =
X-Google-Smtp-Source: AGHT+IGqzvV7XEOjygY4s3gZP0npK17gDMPsWjJt8lG2JAfyXBC/HcujjKJo0D3HMFcuAG5l54x06Q==
X-Received: by 2002:a05:6e02:2192:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a3f404ff3amr3927295ab.2.1729207540803; 
 Thu, 17 Oct 2024 16:25:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 5/8] sunxi: Move to bootstd
Date: Thu, 17 Oct 2024 17:25:28 -0600
Message-Id: <20241017232531.726559-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Convert the other DISTRO_DEFAULTS in the Kconfig too

 arch/arm/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 060636e9e2d..c6ad706dfff 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,7 +1147,7 @@ config ARCH_SUNXI
 	select BINMAN
 	select CMD_GPIO
 	select CMD_MMC if MMC
-	select CMD_USB if DISTRO_DEFAULTS && USB_HOST
+	select CMD_USB if BOOTSTD_DEFAULTS && USB_HOST
 	select CLK
 	select DM
 	select DM_GPIO
@@ -1169,9 +1169,9 @@ config ARCH_SUNXI
 	select SUNXI_GPIO
 	select SYS_NS16550
 	select SYS_THUMB_BUILD if !ARM64
-	select USB if DISTRO_DEFAULTS
-	select USB_KEYBOARD if DISTRO_DEFAULTS && USB_HOST
-	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
+	select USB if BOOTSTD_DEFAULTS
+	select USB_KEYBOARD if BOOTSTD_DEFAULTS && USB_HOST
+	select USB_STORAGE if BOOTSTD_DEFAULTS && USB_HOST
 	select SPL_USE_TINY_PRINTF if SPL
 	select USE_PREBOOT
 	select SYS_RELOC_GD_ENV_ADDR
@@ -1179,7 +1179,7 @@ config ARCH_SUNXI
 	imply CMD_DM
 	imply CMD_GPT
 	imply CMD_UBI if MTD_RAW_NAND
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply DM_REGULATOR
 	imply DM_REGULATOR_FIXED
 	imply FAT_WRITE
-- 
2.34.1

