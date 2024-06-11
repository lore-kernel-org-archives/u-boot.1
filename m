Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B8EC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2947B887B7;
	Tue, 11 Jun 2024 22:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlZJ9uFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB7588758; Tue, 11 Jun 2024 22:02:31 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F2D8871A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3758fbc25f3so14894805ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136148; x=1718740948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvRkEuBZ1SEdecF6ABEjT77RDraKDJonNimggxkHM/s=;
 b=HlZJ9uFsyhla3TcHky59vY79mFN7uDBEYmPU3xPla9UjKUurZzWNWjgWhip+CIGNgb
 NWrS+6/ghEAzUTrsREkoomFr3dvXW8d7qyd84j2YZpOZLuKOxCv4TSj3mMDvmqDN/Snn
 kjauKT6V8x+I1H6aFur7dddxt+vcPtMvtlPiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136148; x=1718740948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvRkEuBZ1SEdecF6ABEjT77RDraKDJonNimggxkHM/s=;
 b=hZSi1D+GHBF+GtcBBfgVNPg11bbR5//CIxOWaanET6p3bkHo/CWPWxnk8L0wmEpIom
 O9BpVDffpJL3E3PhCRfpyCEs1kSNqOn1VHNprusAlQCsIcqWb30zm9iZgdhCii2Gs3Co
 3ec0h+3gocNSmAHVGZPxuCVb/oxsTb3mxQdh+TCON3coz0fTn1sgAIJDYSp/R2Xh5ibl
 AXSryQjFaxxEMwnYKPQMDCj8XbqU/eAskPv6MxxJltTrQhzOb/iytUSuFFL+JeoHhK27
 rSuvsS+MHntpXSDnMhvF5HvWl6TkihphOpERaFnJo95TkS+X7PS+pUcQFrk8vUJZTMAi
 F6QA==
X-Gm-Message-State: AOJu0Yy5NebjD+DxBDU/XnvrmkVUgYHPiu9GGjd4lsaTLlVUJRl9Qe2K
 G4k3yNokztQ/BYNj8RRDTCbgFBbvjzG9cftyuiglexnawDgFCTmollNCsnnzqb3PGqbjNpsRclV
 HYg==
X-Google-Smtp-Source: AGHT+IFQGJv3RvoMbwFJI4YQVpfPrSFOdy1BsgCkJucOE+Ay8A8YIXNU4LpqTGF5+6YhEwlQDudbBg==
X-Received: by 2002:a92:ca4a:0:b0:375:a282:c96b with SMTP id
 e9e14a558f8ab-375a282cc8fmr84130065ab.27.1718136147819; 
 Tue, 11 Jun 2024 13:02:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Allen Martin <amartin@nvidia.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 17/42] google: Disable TPMv2 on most Chromebooks
Date: Tue, 11 Jun 2024 14:01:31 -0600
Message-Id: <20240611200156.2245525-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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
---

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

