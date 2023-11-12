Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1865C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EABB8744D;
	Sun, 12 Nov 2023 21:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mY8bfT0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE5787469; Sun, 12 Nov 2023 21:03:17 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DF5871FC
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3580b94ac2eso16266115ab.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819389; x=1700424189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5MhNq1q9rvMHlabEA2QBtIvjrU48aCrsscJvftE+G0=;
 b=mY8bfT0duhNdV88P+JTOuVAe0Uxxee9CSoki9+4E1fb/YT71jLUI3eKX11KWBgCn6Q
 gOmHnf4K7VZ1C8qu+9F23FbamvVESzIDgC52AuNirHrB7yShWGbUNoVfWehxtomSwNmu
 xHbVsDqCEz060B8r8rLjCkmCCQgLZjc2e/bsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819389; x=1700424189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5MhNq1q9rvMHlabEA2QBtIvjrU48aCrsscJvftE+G0=;
 b=R3qKSy70liKSM4sXvWnN82WwdGCCkIOaIttBosCF0lFoOAw2h1AXSlOOkxCR9M7D7Q
 uVKGSVPX3pWti+DWvggx2s4ueeO1A6ScDd9t4YaNtG6vX7pkZ0vd7Pwa7FwAHCY3x5jT
 ZCTAr57tFnqBc6nBjjpfuq3NxNenGXa9oxxTivGlGWYknBIXj8fZ77PsEZq+DDeI6Tbu
 D2tW+yW7V43OdffhVa58W87ByO0t5NiE5SQUhwytckO4UJHV69VYnbFfwOFdg3TWh/5M
 YO2u61aYr4Ecvd/R8ZmDwg0gAV8Elhvmfuq0pSGtwvvC9TjCdB7v75cgFdRUQ8uvFe+i
 /MjQ==
X-Gm-Message-State: AOJu0YxIFu+/N7i5uO2t8YP+YTr8HfZWKdu83uCQrzSXto6ALYFm+EJs
 ds5DRcfHg14xakjqZUVlIENuKBZZ9LwfvX68Vnda7w==
X-Google-Smtp-Source: AGHT+IFeGQ+OJqi5D0KnicGwKQCAwHCMFl/Kg9spvUkdYg9gn9npONmV3AvEkB87n9HxGSOhTNVhgQ==
X-Received: by 2002:a05:6e02:2186:b0:352:6251:2364 with SMTP id
 j6-20020a056e02218600b0035262512364mr7460601ila.11.1699819388857; 
 Sun, 12 Nov 2023 12:03:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 11/12] x86: qemu: Expand ROM size
Date: Sun, 12 Nov 2023 13:02:48 -0700
Message-ID: <20231112200255.172351-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

