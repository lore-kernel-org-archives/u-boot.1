Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E74C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75B2871E4;
	Sun, 12 Nov 2023 16:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FXBmfjGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B41E86F1F; Sun, 12 Nov 2023 16:58:27 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123BC870E3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-357cf6725acso14796505ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699804703; x=1700409503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUuSpcrQ3gUlAZofxFiT9iv6YxlJ1mmMNlEAtw8hCbs=;
 b=FXBmfjGZiBpZHI2fyuqQDC5X3qUp2CBZdwO2dbofU/QDlUuVE53t5dWmsCOZ9tnKrH
 2PdOScBmBl64IcrjfhT1v5OtlF73SAOPXQXyHmQH8nnqKx+jNo9NnqSYn0C02vUsiT0w
 ULpWROe0oJxI6mMLqY2A3FfRHE2Of/NNclys0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699804703; x=1700409503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUuSpcrQ3gUlAZofxFiT9iv6YxlJ1mmMNlEAtw8hCbs=;
 b=jE7tBFJNn1clJ2vIAejq/KMhymf0vOeqco7ZFZhyfBhW3knMpE39fE8Kt6QoAGVsjT
 6lrZGUDoHA3pHvBtMKUsMeYnzWmf7jGE6p7G6weHvalLeKOV3ajubo0Zf2pX/DHjJBWy
 sA0d5OJQ8pcAg4uJUZe3+KKN0RdzPhqb/R5l90R5rf1HJlIY3qgDX5ZEm/2e+tDjW+ww
 Z7xpsOYa9KyAg1s3EsLYlj6tvxVt2ENkDRTw7LBB62ovFR4kSNXT7jBaa1CiocNuavMO
 l+KscdBSgHGROKEX5IebyeTj5p/xu6sw+lCU3w9qt3vMh7sf9byoNsX/imLhH0/OuOVN
 AfwQ==
X-Gm-Message-State: AOJu0YywuRx/pWTcjXO6DIHYS/3x13tq73frJXt/veBgOtIxUY+IYe/+
 rrT+hHlccGv+l0PbQhIfShBxdSRho76O35x5ZV3H9w==
X-Google-Smtp-Source: AGHT+IEp0w8XIJH6Cqyau/9u13bgXI2LO/dlbf+5vV1obKupy/1QEJ5GIENDi5vG0hUxUk5+RFRDTg==
X-Received: by 2002:a5d:91d4:0:b0:792:43b4:dc2 with SMTP id
 k20-20020a5d91d4000000b0079243b40dc2mr5374840ior.3.1699804703591; 
 Sun, 12 Nov 2023 07:58:23 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm1065843jal.136.2023.11.12.07.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:58:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 4/4] efi: Avoid using dm_scan_other()
Date: Sun, 12 Nov 2023 08:58:05 -0700
Message-ID: <20231112155808.135585-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112155808.135585-1-sjg@chromium.org>
References: <20231112155808.135585-1-sjg@chromium.org>
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

This function is defined by bootstd so using it precludes using that
feature. Use the board_early_init_r() feature instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/efi-x86_app64_defconfig | 1 +
 lib/efi/efi_app.c               | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index d6b6c3d82995..e6a62b30dd09 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index c5eb816655ea..1bced775a4d0 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -302,15 +302,14 @@ static int setup_block(void)
 }
 
 /**
- * dm_scan_other() - Scan for UEFI devices that should be available to U-Boot
+ * board_early_init_r() - Scan for UEFI devices that should be available
  *
  * This sets up block devices within U-Boot for those found in UEFI. With this,
  * U-Boot can access those devices
  *
- * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
  * Returns: 0 on success, -ve on error
  */
-int dm_scan_other(bool pre_reloc_only)
+int board_early_init_r(void)
 {
 	if (gd->flags & GD_FLG_RELOC) {
 		int ret;
-- 
2.42.0.869.gea05f2083d-goog

