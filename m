Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C15BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7902C87470;
	Thu, 19 Oct 2023 17:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sVALpUyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE15C87469; Thu, 19 Oct 2023 17:01:31 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A5C87441
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso99638607b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727683; x=1698332483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J8iRd02341ZQdgxQo3hwYJbTVXYRRNfrSN3IVwCidv0=;
 b=sVALpUyNC3WoyxiLgwVKb5IYWtqryXhaOzK0iw8oCvcYq83ugseQ0oz/6S2pBa+RR4
 eWcUmxCL3Z7JeKMJ5+G0WfA85eX8j/MliKxNbOQVrS3ooNFQ0VGcpBlkTpwzqGieFWQb
 a/56dhsxVrq4sJItLGvPB9QgK13auXjAxDPQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727683; x=1698332483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8iRd02341ZQdgxQo3hwYJbTVXYRRNfrSN3IVwCidv0=;
 b=bmKT86Ca7K9xrGG23gW5HgmukodkqKfLnk1fqeJWofzrky7IxjuLItOCu49Oc979RF
 AIymfq+jgqG+FKCFoR92Asmu+ojQ/Q6QOamboAA3LfUzl4bAiA+ukwsjJG5PiBm4jZla
 I995FP8nSXEyWBiN5Cv1wcbFi5bzhqsgEcZS6D64fFrBEEuQfHWoeHmLg1r/EXONpKJT
 ykwwyK5nxX+9pD+7hzyFbMKvOMgfAxdo2ESHakCuZkeA4bLZqNvJXkBjHqvx7KsfK+c5
 DY9Qa2HZMMskkvaaBOMyqYjBs+6/lLu/KxjVzByLo1aNo7vNInYnVVmNmah/7AQmXOUR
 vdjw==
X-Gm-Message-State: AOJu0Yy9To1rrfccwOh+jC+0e1Uhiux3RaL/59J64KEahYxlqBHgLL3g
 QbJOxfBvmABvjuXCEBDFTr3p39sf8CnFU7+OcwigYg==
X-Google-Smtp-Source: AGHT+IGmqdPw5fdn894qqyFw/2lN/pF9Lv2dN0HEVLKiPYWLaC7s5wBeAysJLm1kCnSBQL56VzLEVw==
X-Received: by 2002:a81:a214:0:b0:5a8:7edd:b7b0 with SMTP id
 w20-20020a81a214000000b005a87eddb7b0mr2577311ywg.38.1697727683209; 
 Thu, 19 Oct 2023 08:01:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 15/24] boot: Rework BOOT_DEFAULTS to allow for CMDLINE to be
 disabled
Date: Thu, 19 Oct 2023 11:00:56 -0400
Message-Id: <20231019150105.714407-15-trini@konsulko.com>
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

We split BOOT_DEFAULTS to have BOOT_DEFAULTS_FEATURES and
BOOT_DEFAULTS_CMDS that in turn list general features or commands that
we want enabled when BOOT_DEFAULTS is selected.  We only select
BOOT_DEFAULTS_CMDS if CMDLINE is set.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2075ecd34b1f..88b9296ee1bf 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -346,8 +346,16 @@ config PXE_UTILS
 	help
 	  Utilities for parsing PXE file formats.
 
-config BOOT_DEFAULTS
-	bool  # Common defaults for standard boot and distroboot
+config BOOT_DEFAULTS_FEATURES
+	bool
+	select SUPPORT_RAW_INITRD
+	select ENV_VARS_UBOOT_CONFIG
+	imply USB_STORAGE
+	imply EFI_PARTITION
+	imply ISO_PARTITION
+
+config BOOT_DEFAULTS_CMDS
+	bool
 	imply USE_BOOTCOMMAND
 	select CMD_ENV_EXISTS
 	select CMD_EXT2
@@ -358,14 +366,14 @@ config BOOT_DEFAULTS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
 	select CMD_PXE if CMD_NET
-	select SUPPORT_RAW_INITRD
-	select ENV_VARS_UBOOT_CONFIG
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
-	imply USB_STORAGE
-	imply EFI_PARTITION
-	imply ISO_PARTITION
+
+config BOOT_DEFAULTS
+	bool  # Common defaults for standard boot and distroboot
+	select BOOT_DEFAULTS_FEATURES
+	select BOOT_DEFAULTS_CMDS if CMDLINE
 	help
 	  These are not required but are commonly needed to support a good
 	  selection of booting methods. Enable this to improve the capability
@@ -431,7 +439,6 @@ config BOOTSTD_FULL
 config BOOTSTD_DEFAULTS
 	bool "Select some common defaults for standard boot"
 	depends on BOOTSTD
-	imply USE_BOOTCOMMAND
 	select BOOT_DEFAULTS
 	select BOOTMETH_DISTRO
 	help
-- 
2.34.1

