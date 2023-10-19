Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A08CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B0687495;
	Thu, 19 Oct 2023 17:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YhOh/GZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54DF8743C; Thu, 19 Oct 2023 17:01:36 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15DD87454
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7dafb659cso99013607b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727691; x=1698332491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AirJw0cDDMZ+s+9xPvxHuqKBNLqNBaZF0XDHiCvDU1w=;
 b=YhOh/GZAXxVGJJ/JhOiT2Zlfq16Ow6uUCQ5rw+/Ij2As7wWQXCJT0VBwzUG8Fe36lY
 +6AQI1PNh9BYrL9ULfebGC+kq7E0FNVxieTYAfLTWSUIRIrVpznx4O4WCcFTrANsHNzH
 jMnMaHuCWtT31uhx2Fk1usoCm9QJdd+0EjKyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727691; x=1698332491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AirJw0cDDMZ+s+9xPvxHuqKBNLqNBaZF0XDHiCvDU1w=;
 b=rghZBtdz3Ia6J2UnOQ1jMeQxX7yIXasWnPn/HZnZ7xfZiQlM82jjmmadwgEGdDS4lL
 MDSSXbyhmy6wd8ThBE000+QbQsr7ulcwc+8oCMBlE8Hz5w6Z/71RCvyyhAd5HS4DSfXq
 GSlRcqjruH7rfkc7Ws+6IN9O6wDLWnMshpQ5JT8IvYFzENGj+Blirq5aMHjmtjp/WMUI
 l/nfWM/UlrjdLkfPOZDMEJXjUvI06gAxMtTqijQH2LY7/lrTuxLG3VExFK06Acd8b5zz
 bkzHu4PKp3C+gWNNCvHDBZCikgxgU336vJ7l1AzrufhAN7GHFbGa0h59nIclc7Zse3FM
 XqJw==
X-Gm-Message-State: AOJu0Yw9Nl4eYNafJxYN5LqfUUHTRnAYd65P5d/d6RtwI3YiwULrq497
 5lLABpWfnJbelAiCItOIOsBQlcoG2aKV4ZyK7qFj9Q==
X-Google-Smtp-Source: AGHT+IEG8ikGtHzm9JH3aZTb+d0pMr14IDTfQqIS8YLl9S16zNvC7wIRNLTKNR7NAvEpGEDxYdKR2w==
X-Received: by 2002:a05:690c:ece:b0:5a7:bfbf:691d with SMTP id
 cs14-20020a05690c0ece00b005a7bfbf691dmr3195190ywb.42.1697727691088; 
 Thu, 19 Oct 2023 08:01:31 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 21/24] sandbox: Disable CONFIG_DISTRO_DEFAULTS
Date: Thu, 19 Oct 2023 11:01:02 -0400
Message-Id: <20231019150105.714407-21-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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
index 19f2891ba1c5..edfa3f7f83aa 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -208,6 +208,9 @@ config SANDBOX
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
+	imply BOOTSTD_DEFAULTS if BOOTSTD_FULL && CMDLINE
+	imply BOOTMETH_DISTRO if BOOTSTD_FULL && CMDLINE
+	imply CMD_SYSBOOT if BOOTSTD_FULL
 
 config SH
 	bool "SuperH architecture"
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018b..ff895b930170 100644
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
index 47417cb0391d..5230b81be2c4 100644
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
index 29ae4532c508..8df2a82c521c 100644
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

