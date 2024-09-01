Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64C3C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802AE88D09;
	Mon,  2 Sep 2024 00:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KvBSRZnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15DF888C8; Mon,  2 Sep 2024 00:27:50 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8259F889FC
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39d3cd4fa49so11721365ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229667; x=1725834467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeIhUQOUCo2gOBgUOb7qQ9POf+iisu3dLWb2mlD55no=;
 b=KvBSRZnktAy/lcQZxv/YiUNvV1u7uZD5b7brL1wydipet7OWi12wVrKS5z7GuNpzLT
 Lkg1A6hmHRR4O4d9siI6oMy8Xc2fwiWD2StrNJgk32/gPRqevvLE7fy+Rqq8kp5A9Nu9
 kwl7i0Q+CyJC5nfbfg/SFDXmB2GZ7roHAjvmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229667; x=1725834467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeIhUQOUCo2gOBgUOb7qQ9POf+iisu3dLWb2mlD55no=;
 b=V1Y7k6UBl/X/6xuB1e5Wf29JSBX0mtQqAWT3ZprNMWRrLoGhkFgrMUoaoYThP4pF8n
 0BRCpqXERl44VMgOh2wWiMxzUs+iZW5yOhHWEZI2eTBDYR1fvJRUxwtOlm1b+U0WYyqh
 L3S6M9MV670ygdJX+OVuP4mHe0Ox22l5Kkfyn02eG7j9Ih1mCzXMYmoHZkVqxIerQGM7
 aujPzw0VNMV+ZgyDBaJpOK8MTtpZEquyg3ifcKhOb7Ob49ZXorBFVM8MPjF7xiP4q81X
 pyG6MIMVgC7/R9iONF9MPP/ojVz8IaNSIJbk35QMS76pfjkHymEJkOISu6bJLOLg9e6D
 Sd+g==
X-Gm-Message-State: AOJu0YybPLCYuWETVKx+wGaFMEw9RrX0vPTaMSDlTUjZn/lzvZJT/I6+
 yL7ezF3Pf3NhjPX0Lt9go83hMeiv/oxRpX0uRCePaY66ZpXUn11WYdWJ8h2Oq+44RsjbCRK1M14
 =
X-Google-Smtp-Source: AGHT+IEVfY3Q29oeAwZecK1Cwxhslm+fMdVylW5Z0zns/A5+Gzslb5iRacscbHuR7SMxr9CZ4GB8/g==
X-Received: by 2002:a05:6e02:1ca4:b0:39d:2aee:e4e4 with SMTP id
 e9e14a558f8ab-39f38ad7253mr84707005ab.2.1725229666874; 
 Sun, 01 Sep 2024 15:27:46 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/8] sunxi: Move to bootstd
Date: Sun,  1 Sep 2024 16:27:31 -0600
Message-Id: <20240901222734.462334-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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
index 656f588a97c..4e36a4814b8 100644
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

