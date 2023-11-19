Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E90C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED3A874BD;
	Sun, 19 Nov 2023 20:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9n30uGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDA5874C7; Sun, 19 Nov 2023 20:12:28 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5678272A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3594cb642beso13708645ab.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421139; x=1701025939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHoSjR2LUDkkV8giIYCS1vdKdMFZFQ4C2RZdEtDgt8g=;
 b=T9n30uGI7pmNjrYaNtRP3Tg63CXwoAOkpbs7GN4sBAQfSrH9qjJWmwVATFPP9OFeGI
 MTASU6kIqCQuu53288PWPVsuPI9jdvic5arha9lnTFO56FIz0LfA+buHGw9lnbBkNLUR
 RyCnYR+Pv0ZDMTPDDVYCEy/s69JGCuLfxMAXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421139; x=1701025939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHoSjR2LUDkkV8giIYCS1vdKdMFZFQ4C2RZdEtDgt8g=;
 b=Qx+xG0jOITYZBiCc59V3dDqA8WbnTAw6RsrU6df6EIS82PaV4g8q2q/XJ4dh2qY2dF
 4YI2jXnW8B+ROF40Hrk6Mmc7Y0/mcozOpppGppfStA4/WaxXgyoC4fI21mXLYTtUlvwq
 ga9mHFMgj9Om5WYXu2mofGx0cIxY5t5a9SycSAwFF9WkXOnAcJbwWkoxjD1kMj2MnSWz
 /qEAlgY2+kAUDAFXl7hY7hYc0rLXqDQaXjw1mzZRRwlzyIWDElHGYlSTUaJpRXZn8dii
 IXLVY39YMmLKGN8S7lh48mTVkHA9aeYcYpZKR+iUQNT/AYU21HUBU1K3IECjjnuirbKm
 7nMA==
X-Gm-Message-State: AOJu0YzJGAwKfyXr0CvJsTrHxQIEjMPyQ9ZqQ1NtThw1FLqxIGaZotmr
 6fzLmQEiSkweB9ez8PK+h9NKiSE4SgcG6okoB+jW+Q==
X-Google-Smtp-Source: AGHT+IE/uLVSTDa7CBQ7IS4zCCtZaepcOf9+YApfx5RpTD7zzTzbLiq4FXpjtvzuNYM0wAzbUDElog==
X-Received: by 2002:a92:740c:0:b0:35b:dc:b1c7 with SMTP id
 p12-20020a92740c000000b0035b00dcb1c7mr1759377ilc.13.1700421139703; 
 Sun, 19 Nov 2023 11:12:19 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 11/12] x86: qemu: Expand ROM size
Date: Sun, 19 Nov 2023 12:11:46 -0700
Message-ID: <20231119191202.667180-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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

Expand the ROM for x86_64 to 2MB to make space for the font, as it is
already on the edge.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/emulation/qemu-x86/Kconfig | 3 ++-
 configs/qemu-x86_64_defconfig    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 01dc1d497aec..34d665a3e4c0 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -21,7 +21,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select X86_RESET_VECTOR
 	select QEMU
 	select QFW_PIO if CMD_QFW
-	select BOARD_ROMSIZE_KB_1024
+	select BOARD_ROMSIZE_KB_1024 if TARGET_QEMU_X86
+	select BOARD_ROMSIZE_KB_2048 if TARGET_QEMU_X86_64
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2ff49fbd6acc..a71111697e38 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_TEXT_BASE=0xfffd8000
+CONFIG_SPL_TEXT_BASE=0xfffd4000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_SMP=y
 CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
-CONFIG_X86_OFFSET_U_BOOT=0xfff00000
+CONFIG_X86_OFFSET_U_BOOT=0xffe00000
 CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.43.0.rc0.421.g78406f8d94-goog

