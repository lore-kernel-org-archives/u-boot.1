Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACE4C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E31885F5;
	Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7PS4hea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37EB88599; Fri, 21 Jun 2024 21:52:26 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8FF8859C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso94577439f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999543; x=1719604343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9F8DGtexo5Z5viC+x68GhJfe/EABbTkRGOuNzW7k20=;
 b=V7PS4heavbKSI8q30ZfZ00JCPW6oI034MtnM5lEh3/Art9kK1kXz/rE3ybEsU50X/N
 cmLyuPB7Xu/ySjklHaeu97zO/j/EFHqRXk08/8ZXvfH6/EYx3VC8uwb0mGZo+GC3Ai/O
 hCYKBa8E7bpSMv5QQwRzceQovH/G9TZfuUyHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999543; x=1719604343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9F8DGtexo5Z5viC+x68GhJfe/EABbTkRGOuNzW7k20=;
 b=E3wF/fUQH9zUdlMKxN+vpo5NcxmTrshhsuHbjl1snPcPPX4uLGoqwu1yXkltfiv7Zc
 E6Z/LknXDEur5YYbeWKGn1t61SeFzVWbOeCP2ajQCLvbDrQoWgL9/qccBBUmX+zxflIV
 oBTCO54REL9jUskR5rXnwdcSsa/ELTB4GnHFacBr7DVae+pnYr1nsN/Wd5om59f6Iu3M
 JQyFfQl3o3ymQ0rTHjnh1WD3USHHsVt2yxekeyWgQawJ02xjO3ct4byWrDk+cRmloMRv
 v38++W4ZIr7xycHsDpH91H+TJMaH1gIzo1K59kO0mBofo5qSbVhcax4FjiWDK+jALK+2
 F5HQ==
X-Gm-Message-State: AOJu0Yw62c0JZdfR0TzOtaYjug0IrpQ7I1TvDrggB6O83K3PPGr6fbvi
 thFyiPosur6v8rlxP1T3lcyLJnLL2ZXTx1WutmuYTlM88r1YUK7T1vypPXKDQ9JwPLRabpxIXfG
 jiw==
X-Google-Smtp-Source: AGHT+IHrEDqiNWVt/mGwd9mMqDdpcYW0etdwRlz8d6DJFJ//ExlTtPXlYoY99yJWRr+PcchZvXv+yw==
X-Received: by 2002:a05:6602:6d83:b0:7eb:c59e:b0f with SMTP id
 ca18e2360f4ac-7f13ee8c3femr1118450139f.18.1718999543557; 
 Fri, 21 Jun 2024 12:52:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 17/43] google: Disable TPMv2 on most Chromebooks
Date: Fri, 21 Jun 2024 13:51:38 -0600
Message-Id: <20240621195204.2675252-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

This feature is not present on older Chromebooks, so disable the
setting.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 configs/chromebook_link64_defconfig    | 1 +
 configs/chromebook_link_defconfig      | 1 +
 configs/chromebook_samus_defconfig     | 1 +
 configs/chromebook_samus_tpl_defconfig | 1 +
 configs/nyan-big_defconfig             | 4 +---
 configs/snow_defconfig                 | 1 +
 6 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/configs/chromebook_link64_defconfig b/configs/chromebook_link64_defconfig
index 7cf23b29e46..9583f87bf0f 100644
--- a/configs/chromebook_link64_defconfig
+++ b/configs/chromebook_link64_defconfig
@@ -80,6 +80,7 @@ CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_TPM_TIS_LPC=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB_STORAGE=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index a9f91dd9b26..75a7a488a92 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -70,6 +70,7 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SOUND=y
 CONFIG_SPI=y
 CONFIG_TPM_TIS_LPC=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB_STORAGE=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO_COPY=y
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index 40cc449b9b3..8cdad8d2344 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -74,6 +74,7 @@ CONFIG_SOUND_I8254=y
 CONFIG_SOUND_RT5677=y
 CONFIG_SPI=y
 CONFIG_TPM_TIS_LPC=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB_STORAGE=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO_COPY=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 3e7298f16af..1be57560f89 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -96,6 +96,7 @@ CONFIG_SOUND_RT5677=y
 CONFIG_SPI=y
 CONFIG_TPL_SYSRESET=y
 CONFIG_TPM_TIS_LPC=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB_STORAGE=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 4dec710cf8d..78fb7580da7 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -11,8 +11,6 @@ CONFIG_DEFAULT_DEVICE_TREE="tegra124-nyan-big"
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_BOOTSTAGE_STASH_ADDR=0x83000000
-CONFIG_DEBUG_UART_BASE=0x70006000
-CONFIG_DEBUG_UART_CLOCK=408000000
 CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
@@ -75,7 +73,6 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_PWM_TEGRA=y
-CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
 CONFIG_SOUND=y
 CONFIG_I2S=y
@@ -83,6 +80,7 @@ CONFIG_I2S_TEGRA=y
 CONFIG_SOUND_MAX98090=y
 CONFIG_TEGRA114_SPI=y
 CONFIG_TPM_TIS_INFINEON=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 3a617c6cf40..2c0757194bd 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -88,6 +88,7 @@ CONFIG_SOUND_MAX98095=y
 CONFIG_SOUND_WM8994=y
 CONFIG_EXYNOS_SPI=y
 CONFIG_TPM_TIS_INFINEON=y
+# CONFIG_TPM_V2 is not set
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.34.1

