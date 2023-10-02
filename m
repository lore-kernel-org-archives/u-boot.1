Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B6E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C62A871E6;
	Mon,  2 Oct 2023 03:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N43A38To";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD07D87120; Mon,  2 Oct 2023 03:16:05 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C746087122
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so476446439f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209305; x=1696814105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4k8w3jmwzg3Lig42juPNVhV1vGd3c6UJij8pnOShr0=;
 b=N43A38To8tp08iL2wpKvxdk5KWtD9i3y5scCDtI0tU5bRXS3IZWNK0PKUY6hOsxjXT
 MutdQUNCFwqwkJ3O96asyBDtL/y6AGm8Iv4lzSsvu9Jy3y3VmLsujjDJlkPUWJUhNPq0
 LEJtwoKEtz5KnqzWj/+pVl3c6O4d0kLxe+6aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209305; x=1696814105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4k8w3jmwzg3Lig42juPNVhV1vGd3c6UJij8pnOShr0=;
 b=NSRUUXs++w71wlXvFd7keTecTlIe6mrClebALFoFq9H8b4EzncF+4aCypTXmLH7csz
 kLSzXkAFmhR65iThBQiJFPjwWO07y44slZKVRLPelybRlSZxw1BH0DyjvEjnDoDIyw3D
 5/KsdJ5fXQPPek/P/ei2hVWkzwbKa7mlIP7Ra1Dw3chNgkV29b5NkcXiDstJthIiTGiJ
 5OP0/DLbHHn9yjpIbbM25WrjrIm5l4jA47CcaWIAV+5u0CI4Uj/5MiRQmkrMdraNpCGJ
 17s1co9uTGc6BrOBK5oMomWp4zHijoHEx33rINBzQBCfG8TJfnbD6Zxc8eGJrn0p/f1L
 Qssw==
X-Gm-Message-State: AOJu0YyNd9yFYp9lAiygw8kkvRAdMh5Hy4j2I0r/u9KNy8lr14bP30zP
 +HWNLAx4RosSKSeVzL2yPBYc6NNr7evQNfOTNHs=
X-Google-Smtp-Source: AGHT+IEEqV7gamDFfZe2LGfyKxaHz8IqFyI3yvQUdU0z00ESUKoosoy+Ed8f/GdRB0dcG+qDUOcMtg==
X-Received: by 2002:a6b:ea15:0:b0:79e:4abd:7be3 with SMTP id
 m21-20020a6bea15000000b0079e4abd7be3mr10960839ioc.15.1696209305345; 
 Sun, 01 Oct 2023 18:15:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 11/12] x86: qemu: Expand ROM size
Date: Sun,  1 Oct 2023 19:14:46 -0600
Message-ID: <20231002011450.462468-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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
 configs/qemu-x86_64_defconfig    | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 787751abba4f..04b7a8aff89e 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -21,7 +21,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select X86_RESET_VECTOR
 	select QEMU
 	select QFW_PIO
-	select BOARD_ROMSIZE_KB_1024
+	select BOARD_ROMSIZE_KB_1024 if TARGET_QEMU_X86
+	select BOARD_ROMSIZE_KB_2048 if TARGET_QEMU_X86_64
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 165f0b512c8b..6de3da2d8269 100644
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
@@ -17,12 +17,12 @@ CONFIG_DEBUG_UART=y
 CONFIG_SMP=y
 CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
-CONFIG_X86_OFFSET_U_BOOT=0xfff00000
+CONFIG_X86_OFFSET_U_BOOT=0xffe00000
+CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_SHOW_BOOT_PROGRESS=y
-- 
2.42.0.582.g8ccd20d70d-goog

