Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F986C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F7187B57;
	Thu, 26 Oct 2023 20:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tb5eaNZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D82787638; Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A561D87646
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-773ac11de71so90334285a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345105; x=1698949905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcdTj9HKcG4dZ8B/zo46mbw6gQkqzlPY19Qc5+lgrUA=;
 b=Tb5eaNZBsyk896WCPWSjWhDAEiWDFtSEh01tnQuMG8qHItZSTkgOgCTX1YNhcrAtNd
 cVhbdfVWKfMSojhRUkuqVGL8uzXMwFqcJtQomWWzVtLlkzIEsf6fIA2VtaMdFPA5scLW
 pGL0BB87G69cOqSL8lmnEdkqgYv2cWFTes6dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345105; x=1698949905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcdTj9HKcG4dZ8B/zo46mbw6gQkqzlPY19Qc5+lgrUA=;
 b=DjYEVtoptlmtVgWAXgLK3O7zkuukSZfER+es6VGe0I/sluoil5IAjhvb319P6UMFda
 PZvrlGCD7/rXrv1h9Msk5EJbPiHvI4hzFEefMJ0TDFB8Q139ireQsZvxXQ9UK03hmsci
 p5bt9RSE2S/R1tTy+t9QUvBr7yCA0V0E23MAIFGUxnTLd2hVvk3oKvQzNhL4rfO734xJ
 2a1a7T/yl3EOIjpurT+rAy4pVWiOWaA3GRQcG6b7IvMiYLUT/t6B/BZyq8awWb+wiqlF
 4H8pyu6vEWla7TJLq8nvIrLdbmdgPsmvGhrgb3W92CqsVNCldR2YRTVRnOzX0SB4f9No
 2uqg==
X-Gm-Message-State: AOJu0YyQY8xfCC7+sKroKjXSWQro04N8fsq92aura19jf92gFOEeaV5U
 m6n2NnQhV8NWiJRugP4Rfy6YkpfwG8lv8ViXWTAVQA==
X-Google-Smtp-Source: AGHT+IFZ/87O1DqRgVDd05+dOc6WVStlEwHN1R5QWzKspGxcMHH/7T0+vROR7S96N6zm5wDTU1rpKg==
X-Received: by 2002:a05:620a:c45:b0:778:b0f5:d4e7 with SMTP id
 u5-20020a05620a0c4500b00778b0f5d4e7mr133273qki.46.1698345104862; 
 Thu, 26 Oct 2023 11:31:44 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [v5 06/30] qemu: Correct CMD_QFW dependencies in Kconfig
Date: Thu, 26 Oct 2023 14:31:14 -0400
Message-Id: <20231026183138.636948-6-trini@konsulko.com>
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

Rather than selecting CMD_QFW, we should make the option itself by
enabled by default on these platforms.  Then in the board-specific
Kconfig we should select the appropriate back-end as needed if the
command is enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/emulation/qemu-arm/Kconfig | 3 +--
 board/emulation/qemu-x86/Kconfig | 2 +-
 cmd/Kconfig                      | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 09c95413a541..ac2d078f42a1 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -5,8 +5,7 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
-	select CMD_QFW
-	select QFW_MMIO
+	select QFW_MMIO if CMD_QFW
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 787751abba4f..01dc1d497aec 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -20,7 +20,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select X86_RESET_VECTOR
 	select QEMU
-	select QFW_PIO
+	select QFW_PIO if CMD_QFW
 	select BOARD_ROMSIZE_KB_1024
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 205df2f1fb65..cd2793b6876b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2247,6 +2247,8 @@ config CMD_SYSBOOT
 config CMD_QFW
 	bool "qfw"
 	select QFW
+	default y if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
+		TARGET_QEMU_X86 || TARGET_QEMU_X86_64
 	help
 	  This provides access to the QEMU firmware interface.  The main
 	  feature is to allow easy loading of files passed to qemu-system
-- 
2.34.1

