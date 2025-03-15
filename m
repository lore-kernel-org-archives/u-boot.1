Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E007BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4DF81100;
	Sat, 15 Mar 2025 15:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+slkFDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA62080ECC; Sat, 15 Mar 2025 15:27:21 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972248193A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so3980045e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048838; x=1742653638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=X+slkFDMgT6jpxWK0uQwVyL8ezVCmMYtwnj1LcKd5r0LdEEptN5jShtLLbrr07Fygm
 m3NcD9uEGVgqjK82dD78647slWoiqagqLkYCBUZGaYwj8NFvrbEsOcEhq3ne4mEQqqzG
 7TASQvLVS5GgSOAZDRMd2hW6ToKK/GVgeBDBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048838; x=1742653638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=mxyH2+SpRiVIvsHSvtGMmTUnLjq/qnxPiobv0ptlRpoAyi1gh4S/+vvLWGV+7IpVI2
 vDPLLYnIp/QzdYA6Qfq0R6uhkf+e8pCEynDM65RbCSJuAn4pHXv/39T0iNPApKZToLyG
 xrh+Fwo6H2gB/cNbO7PUCWNGpmYNWmoPRfQrZ5F9UVN/ZvXvzRkXxlI56h2jQ+5EvUBb
 4lRZq7KZ8jqbMd9klIYhvttLht/B2/RQfLHijSiVv2cQRE1/SZbkRCkTPvm11k7XXMuv
 fxa2saz7W2PRJFZzwupzsuAcWbvqBYS9G5ZRWMu/K4ZOWb3k4zN6wDYxdBp32FGJ8JqO
 S2gQ==
X-Gm-Message-State: AOJu0YzldC0tZdqlT90yt575CIRZiImL5zFxpsdz1ZzaQn3QS3diD9J4
 TLHirQG3+bzEqs0iLO6+LOB4ySeZf8hUncO0VmSB1wsU5sUtzBWfqazjU6dp89T2Atw6CcJ/mSb
 ymg==
X-Gm-Gg: ASbGnct4GZIFnLKf1GJLJW9PAQysIOul4v/A6cQgTwRMOUrfMF94ksjDm0cDPYRW5IF
 ZnrwHTXTo4wEaifFkCngLi1c0OUJOQeBXfU32bHtVjd3dWqdlGDTNvJffuLC0RZl0fIydS/sXOq
 Dg4SuJR6okULq5GyoykmrAPzadqAJEiGBylJDA4/oO/YTy4AH0TVssZLudF9a2/ig8nVzX27WDT
 nwR+bXOKa9zrT6r2b/whygvZdSijxPdF7DlwsicgJlpQjT7Hnue1zckJw1xOZPaYgXPh3oIxsDn
 /ug8H0qmViwLbSXI7H0wufTRYjyd/jGlqAJuCMtRKQ==
X-Google-Smtp-Source: AGHT+IEUCaKWAXmD2dNfZFSctlqBx4wImhFblMcdOlpmkUTq5sOMZbTFX+xqYzEO3A7bzTBWlWcLtA==
X-Received: by 2002:a05:600c:3c9e:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43d1ecd2a18mr75871985e9.28.1742048838153; 
 Sat, 15 Mar 2025 07:27:18 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 04/46] x86: qemu: Switch to bochs display
Date: Sat, 15 Mar 2025 14:25:24 +0000
Message-ID: <20250315142643.2600605-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

(no changes since v2)

Changes in v2:
- Redo commit message

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index af275e8ce8f..ff2a192ee7d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,9 +83,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
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
index 0b0e10c795f..ee5b150e062 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,9 +62,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
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
2.43.0

