Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE1C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFEF8879C8;
	Thu,  4 Jan 2024 16:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eKSfzlkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2874879A5; Thu,  4 Jan 2024 16:11:09 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6DD8798F
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7b7f6caf047so23220539f.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381051; x=1704985851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuMMyoINzgyasVsmgJvWqqRoYWhwNtTQTkUs2Hh1jgE=;
 b=eKSfzlkf/0aKgTSxu+iwNdXyOlZ4KonxOXEjtTfXiI5IwgvA4Jsi1OpF6mGQVHTBbi
 DNykbRViMgBa5AnHCiKVIsDGJSrRS6633vRodeJQhWuj4RjZeNwed3z1Lubjr7co+ibg
 NEq9brlzaVBdDybXuaCQHyFFQxUuIm+/Is6x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381051; x=1704985851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FuMMyoINzgyasVsmgJvWqqRoYWhwNtTQTkUs2Hh1jgE=;
 b=qvn2Bt3AHUdz0OOpNqsVTYtgukxjnq5ZLrZD3q1WayMxbhqKhw8Mm2Nz9jQ+4NVo96
 kcqgMum18iYYLCJ4wpLwTJhTk0TcZKX6ccK5MWHWWft8RTr4PySs+LvCUQaW99HwdMFR
 aMxREVjgrjKPR4Lm6oC/VPmU0vcscDzQ8//GZ5Xj5qXVMuK0vfldnJ/UxTdE8MwTvl34
 CWKzGbyk4HZCP0re6kwt4kmKQFVEVXaan0fNuNrenYJMb1oRMxPtsKhQEeo05CYiwdxZ
 tsnJRfOqVuNzsgwpV5iXFHTUNH4wx6r/K0WYxqWRoXWA0jyOPKV+aMgw70FHnVSnvDVa
 nleg==
X-Gm-Message-State: AOJu0YwhgWUh4HuEw4QvxyM2toWSQ+VhmnamxAdhriuGsKwg4+Qz3ekb
 7bu4bAYebt/qAs8t126wtDZdG/Bi1SP1N0SICJUR7STjTAdW
X-Google-Smtp-Source: AGHT+IFo2r70CszJhQXRkbPSgMxKTc6yfWpbIsalJibBOmJUapJ4euuS1cQY3ScUfCnrwiJ92gtaWQ==
X-Received: by 2002:a5d:8704:0:b0:7ba:9c04:2e03 with SMTP id
 u4-20020a5d8704000000b007ba9c042e03mr739674iom.27.1704381051365; 
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 6/7] x86: qemu: Expand ROM size
Date: Thu,  4 Jan 2024 08:10:41 -0700
Message-Id: <20240104151042.695717-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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
index 01dc1d497ae..34d665a3e4c 100644
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
index 8b4c5aff7f6..79cdb0bddb2 100644
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
2.34.1

