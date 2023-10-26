Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EDAC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83C887BCA;
	Thu, 26 Oct 2023 20:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pkmuG+9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDA387B96; Thu, 26 Oct 2023 20:32:04 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE06875C6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-584042e7f73so675953eaf.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345120; x=1698949920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkGIY5QkVbfG6wfG6YSoG3bJaDz+siFu6YMMT/GsdCk=;
 b=pkmuG+9AYzzy6PDkR4I17/6zBOcaciD3zqDw9awqre6IBnSn3P/rVNHdO1fvqardd2
 WZWJJy/IQLgDNjtQtBmmXLbRdQwRjL5MPQkgmqxSn3Arxv+k4bZfUaGbXvBfzaXJPToR
 RFLWEGsgzpmPAIPSYrRENLHkvopYSk2uFjFtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345120; x=1698949920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkGIY5QkVbfG6wfG6YSoG3bJaDz+siFu6YMMT/GsdCk=;
 b=ahTB7FqPND4RmwKVhv55b3jsWWWnb4KMcU3Qeu+cKDrlTleIBAGxv8CD3jWx2FWiiH
 x6f5jkiHJIwu7ZMYR3Knqeu8nJXRZG4zgokRWGObTypU/sdUthrQsySKqmCenC35+zO4
 sk61SmR3/5oPr5yw0PP+p54ah8RUA/xdS3ia/6pR3l3R1Lsh4BjYLnpt0YA2qm4wAbig
 hTWC7RVAo8uCze9F4QEvrYtpRrIpLYwp28xg0SqUKa/jPQg7ux/guF3pxMHtYFCeHUfo
 ImHgIpHvhNA82eTLKoiTohTjk8RJQ8TF7pd9sddWJ0GJcWwtcIMkwjSiIrZQSv6X32BK
 QCBg==
X-Gm-Message-State: AOJu0Yw+0HhHHzpoVx/lZVfV/CYjLJu/LxbogheYg8bqGIP/rHIEbHDm
 Cja9LZ8zXKEoO5iNVXVBqf/staWSOIOz8XdafYSvjw==
X-Google-Smtp-Source: AGHT+IFTdlKHKqlg8GMkR/xEqWIJhSeK0Kq+L+wxGl7t3t6CVW+G7pTp/nTGWZpI58Rfcao2YVug3g==
X-Received: by 2002:a05:6358:9f93:b0:168:ff1b:8f69 with SMTP id
 fy19-20020a0563589f9300b00168ff1b8f69mr419418rwb.17.1698345120631; 
 Thu, 26 Oct 2023 11:32:00 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 25/30] sandbox: Disable CONFIG_DISTRO_DEFAULTS
Date: Thu, 26 Oct 2023 14:31:33 -0400
Message-Id: <20231026183138.636948-25-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This is not used for sandbox, so drop it. Enable the things that it
controls to avoid dstrastic changes in the config settings for
sandbox builds.

The end result is that these are enabled:

   BOOTMETH_DISTRO
   BOOTSTD_DEFAULTS

and these are disabled:

   USE_BOOTCOMMAND
   BOOTCOMMAND (was "run distro_bootcmd")
   DISTRO_DEFAULTS

Note that the tools-only build has already disabled DISTRO_DEFAULTS
and BOOTSTD_FULL

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Only modify sandbox and restrict the changes to only DISTRO_DEFAULTS
---
 arch/Kconfig                       | 3 +++
 configs/sandbox64_defconfig        | 1 -
 configs/sandbox_defconfig          | 1 -
 configs/sandbox_flattree_defconfig | 1 -
 configs/sandbox_noinst_defconfig   | 1 -
 configs/sandbox_spl_defconfig      | 1 -
 configs/sandbox_vpl_defconfig      | 1 -
 7 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4f5b75129f34..6fa17b21b8fa 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -210,6 +210,9 @@ config SANDBOX
 	imply BINMAN
 	imply CMD_MBR
 	imply CMD_MMC
+	imply BOOTSTD_DEFAULTS if BOOTSTD_FULL && CMDLINE
+	imply BOOTMETH_DISTRO if BOOTSTD_FULL && CMDLINE
+	imply CMD_SYSBOOT if BOOTSTD_FULL
 
 config SH
 	bool "SuperH architecture"
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a01f51a0b75..301758a2891b 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -14,7 +14,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index e3a2f9eb1708..ff3f63b5b3dc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -14,7 +14,6 @@ CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 44ab80725fc7..282b8ff31a4a 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -12,7 +12,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index db05e6308329..44e55f4452f3 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -25,7 +25,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 56072b15ad2d..015e0a59d085 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -20,7 +20,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 5bd0281796d4..9935575352b2 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,7 +27,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
-- 
2.34.1

