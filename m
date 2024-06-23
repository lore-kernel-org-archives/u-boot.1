Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ACAC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7748855C;
	Sun, 23 Jun 2024 22:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HW5JIrmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8392188405; Sun, 23 Jun 2024 22:30:45 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0268F882E6
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eb671a835fso208616039f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174641; x=1719779441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hAiRelrVOZnPfOazKAh9FmD+FFz1kkIBB4AvlCjCqs=;
 b=HW5JIrmv2OqZ3qSbNkYaNwF+1379cOKKyNzPXdxz+7xVMzka5bM2HoO6JhMlkEybqJ
 sW2qV5A4sWvWEzFO+Brs0evTsH+NUzF6xWP765Jp+c/X+K6Oyb8nkRhNjHQc1/m4PTbQ
 5Xk47leATOD2PbjcdGqUKoSaO0gaTHv7LzHR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174641; x=1719779441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hAiRelrVOZnPfOazKAh9FmD+FFz1kkIBB4AvlCjCqs=;
 b=j7YQcLicWe077p30Uk9a/vFTo8iZDPJQDa34ppA1pdwV6xCGMc/mXHgSNKg0JAWueW
 ECHVk3HCUlPpXSFW4atO8vAgLAinDD2kTrRzT6/1mj2AcYEvwWFq2cU2M33owt+LVmU8
 VZVKV1u9QuenDbCvSfpeRSyIDbOnw4MRHugJGDF9ySM4EsuG0PDcwfNaIUsqxOvhWUef
 bajZUObtdOYtoMGkdpBXxtrgj6dG1Sd6N1iG64Mjqs6AmgrrJs/Ls1dAejHP9EjcsRcp
 1w1MEX/q9c0xwGMuOSO6iniC3fu55M4ivSUhu7w8xCOf+ka4S061lhxxjhJA9yg6yN3h
 Grlw==
X-Gm-Message-State: AOJu0YzDUNB1YauKz8wIWUcLiHkYWnqudMB0vG+MbkkbZzOGVKlDBt74
 sGL/lE1NyQLrDA1bkOIHcsIyaMaulfcWJXBMbZhhQIMSsh8ZQy1gAK9QOIckQQUQvkV1e0mLj9v
 +Bw==
X-Google-Smtp-Source: AGHT+IEIWNpX7BkNnC03abdRohAlnutJFu8yGRFQgly4AYVyOvHxYFU33MIdhnsikp/t083j26PrEA==
X-Received: by 2002:a05:6602:1541:b0:7eb:4770:6ea2 with SMTP id
 ca18e2360f4ac-7f3a4dccd1dmr328417739f.5.1719174641613; 
 Sun, 23 Jun 2024 13:30:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Allen Martin <amartin@nvidia.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 06/14] google: Disable TPMv2 on most Chromebooks
Date: Sun, 23 Jun 2024 14:30:25 -0600
Message-Id: <20240623203033.1566505-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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
index 1a72fd178a8..e10fabd92d8 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -72,6 +72,7 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
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

