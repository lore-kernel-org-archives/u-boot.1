Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F65C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E711388B84;
	Fri, 23 Aug 2024 22:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDdj/csD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926B988915; Fri, 23 Aug 2024 22:48:46 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E7E88C72
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39d31d16d39so8666825ab.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446123; x=1725050923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9T8Fnwnw1unBrZVbfatUhdSZjLgpwMkl4MIYJvm/rXc=;
 b=IDdj/csDGUp/eZxn900SEHW5O8ExTGhkZ9QSnS4FLA4IMDtFx9FIQ9I5qvefhXodcx
 jUDWN9M/KObdMxfxhagJPcaUgpJBkrtht9xyqCfy6yDhIQm5ipvUwf7xKxVf6S21KT/w
 zGvsLfnS8KGAY8QJgmwREYVUCIM7yEzjeuQWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446123; x=1725050923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9T8Fnwnw1unBrZVbfatUhdSZjLgpwMkl4MIYJvm/rXc=;
 b=VXD5DpCz58JBczRpa7vvT+ru+TPNNUHiYJYm7rhrwb89pny5AaOxYgzYC7QsoNgcPb
 XzcbRNFOuGE8gf/61wlBI0x06ObNKttvi+GoLpuahuufQWq23ffoFNy7ZW5MQg8KkuCa
 +oKM33wb6B70i3Dlgkmd8Mjc8jJW5uCA28QNlX9TcKajL/sGQnrqux4tY2BMyR+9m1tk
 lPceBKyDITPZn11RJJ/McZD6uf624fr0+52FZIaY9N+v46NfkgWxUu+2kFuDevCqvkDf
 4qyqOHP3zIWcgf1sCIJFRZpCyLqRxE25NNXzhNEbn1UezDjJU5ZVZXPeoR/XEO77Nvqw
 LqGQ==
X-Gm-Message-State: AOJu0YxEmvK1Ubjo6bCWpQGSgAHuLC1toYEPl/rU4ds18DRbHUflLBMN
 2JufoiVS2pug67/booIVLspWEKTmtLqQ5ptQ0HnJw6r4mNEa6Gq0+eSWrMvH71hE1RJIK/2cc5o
 =
X-Google-Smtp-Source: AGHT+IFoHBjerXq6rxQJzHQ9H2RJqjqINBBhkU/cECHsYgQ32O0qj3XoCDfpuN//2hzV1Ggau3r7iQ==
X-Received: by 2002:a92:c569:0:b0:39d:47cf:2c7f with SMTP id
 e9e14a558f8ab-39e3c9e9965mr36722845ab.24.1724446122834; 
 Fri, 23 Aug 2024 13:48:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 5/8] sunxi: Move to bootstd
Date: Fri, 23 Aug 2024 14:48:21 -0600
Message-Id: <20240823204824.443631-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

