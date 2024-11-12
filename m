Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D72D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C031E89447;
	Tue, 12 Nov 2024 14:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RhwW3DXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F93E8942F; Tue, 12 Nov 2024 14:59:39 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27FCB893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83aad4a05eeso230888739f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419975; x=1732024775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ0or+92eQIwyIqeAnu22dTpZHJuaX9S3qy+ardMUUs=;
 b=RhwW3DXsD3f9eSyWreAC/KsO2qhrxV7/enyaKlTv7EaASNrAbtJIA++lTuQI80tGP5
 VaOXkrCcmYM0HN0H9N2JVn9l5ls4v99S2YFqz8SniWlPVqKiAK/wvJb2nDvYkJziaBRN
 F3LmMDQUK5QcPJ8aUt0PWaLV1BoNtCAwYDtHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419975; x=1732024775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ0or+92eQIwyIqeAnu22dTpZHJuaX9S3qy+ardMUUs=;
 b=kye5RQwtUtHWivhaJAzmaLof0Lz/+MhWUrwm4P/yqVloNU9NvmW/zFmAHmxacyrkIC
 lNECjhAg+PpGMvfGGpVc8fQsV/9wniNcu3e82xaY5fsQWwOJ0fx7g6GVSsDdWmfJHmv+
 wQQ8LllV0CM1Sl7+JNvd8RAU7/0+tmRjfi9HHlhXpXh7m/6psXA0r/sMfiSj71jhFmn5
 0hm2TXkt0+yg62vTO3KLEmx0ec7R68Iw3s7+xg1FMkZ72gAFS7HS8bC/JV8yPgP57qY+
 y3vOYll8au9eoH95sBDTh3gPj1UHYScC6iQtsUc/Oj/CWztpPW7jVKTdOJKDj6RLezvp
 5YkQ==
X-Gm-Message-State: AOJu0YxSYemj1PVtVcnUHRAsaL9ukI0dae2/kDbSkSDu+NfJRjMvD0th
 zh6pd8ViRN4ryjm9oZQrBS0S+5yJnSFaIUSBtfTzfT1cf87tO0kHSny6QgvNUwMOxG72L1/WA7U
 =
X-Google-Smtp-Source: AGHT+IFRbhsH3AjC0WgNlkAxNkftaUSmp70QM44N6E+zcwo2sbWOYoqBNr0YBpkJee5o8ETWAtybWQ==
X-Received: by 2002:a05:6602:3c5:b0:83b:2da6:239a with SMTP id
 ca18e2360f4ac-83e432ae355mr281331239f.15.1731419974877; 
 Tue, 12 Nov 2024 05:59:34 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH 03/18] RFC: x86: qemu: Switch to bochs display
Date: Tue, 12 Nov 2024 06:58:56 -0700
Message-Id: <20241112135911.630586-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

The vesa display is widely used on hardware, but it is a bit of a pain
with QEMU. It requires executing option ROMs, which either doesn't work
with kvm, or is difficult to do in a kvm/QEMU-friendly way.

THe bochs display is probably better anyway, so switch to that. It works
fine with kvm as it doesn't need an option ROM.

Unfortunately this causes the Ubuntu 22.04 installer to stop booting,
which needs further investigation

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 218c3535d15..1670c122002 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -81,9 +81,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 947d15cd727..40c2f1cd362 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -58,9 +58,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
-- 
2.34.1

