Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FDAC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C42083937;
	Wed, 28 May 2025 18:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a5RWFtBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05A783903; Wed, 28 May 2025 18:08:44 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B0D83937
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2e8f394bb75so268830fac.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448520; x=1749053320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH6X7tTQ2jZlqgREiWvKUWW28Jm6w9rJkKpZSGTOXZQ=;
 b=a5RWFtBo7x6zlovmr6q8bDHoSdopJe5x0xaXiAJX7hQqiYPfmx++xUROW1eEaF5uYF
 o4GamfOdTyQd96DXWyzVnhuTGPUwL1hSLqj1t3Uwa+uiDLp3f/h3Dd7XdyccAz86gHOA
 SQvQoO0XJkpKa2be98yD00uBjFKIWvFQW8JJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448520; x=1749053320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH6X7tTQ2jZlqgREiWvKUWW28Jm6w9rJkKpZSGTOXZQ=;
 b=t/9Y8DIrARm1NqCZP1Y7OItOpQj4CTDeVGIC0xNYTWm4JMWWkDy2XNC4C+1vVHfBU8
 q04WpmzZgBYYqYH8+Y7Z0eq1y3Ly0M49Tx7uQqxhEuMTgOezI9ft2/1rlC+5mYSrDRZm
 /qvd5bOjPIsRmdvdm70+nYslaZxHncbqiezSDcJmekFhiNUFoq3qm4NelU9s5MaZBC+T
 b+nKFyJNVTnXRT1B34uCEz6hb5qxEOYZryMrkRBeYAmj5NlHaati9QmtdmZXdpyFDeGw
 Rkv/Oix8vKoQuwiNX58RUfNe3CViDk2kcBLyfRDKv4XTOQ+2fUKkWwhtYDixXyJv6PV0
 QHoQ==
X-Gm-Message-State: AOJu0Yx11dd28eeFpNUBPzO+jLXDz0lU6bdDhUTe7QkHQMuUrICGnndA
 ECDk4q4F1uIdYAKJfE/H0ykGfDQQRhMvaINiAa7s/LrOeg4/9g2neylD59HuXDVrbiFbwDFJ9S+
 y+FL/EOuJ
X-Gm-Gg: ASbGnct3NaC1dQPPM46zjB3ig8SSvKOvu3t8+dP+5XTvBskVNOgAEgYGwVhnZzjsjN2
 rfWfU4HUmseXjBqN4RWj1AjCCD34X/Vp/eemgWmwpYb9mQbu2h1ScouN6yySeizBP3zEAqY6VH/
 LCXswbyYKgu1rjTFOua347NgxD+3sZ4pQgPXwVU5lyE0/F4zGdzh7bU1Et91PW9mL9bkyIWbqjx
 F9DOVkHYgbp9P7ALxdGJ6geU6gliKL7KTXkijqLx/8T7AkeK3+6nsWfAQY8hlkC08loEsI+vOD1
 65krulJqf5tbvckFpdsRSR3FeNhPibqGoCW0BPNa9/ww2oNmi1zUMPn9vTN1VsCAnPgN1Z/jZ47
 E9a4hloG/A+Ja
X-Google-Smtp-Source: AGHT+IG2cF0HEwkHXOEWjtKEKCgcG5w4IylNgC16RHmJI/0jFEYlBfBOZxq9WOOWtkMH9CUeyDTk/Q==
X-Received: by 2002:a05:6602:7216:b0:86c:af54:ae56 with SMTP id
 ca18e2360f4ac-86cbb6b509dmr2073446039f.0.1748448510046; 
 Wed, 28 May 2025 09:08:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd586873sm276277173.90.2025.05.28.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:08:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] efi: Create a new CONFIG_EFI
Date: Wed, 28 May 2025 10:03:16 -0600
Message-ID: <20250528160323.1184731-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528160323.1184731-1-sjg@chromium.org>
References: <20250528160323.1184731-1-sjg@chromium.org>
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

Create a Kconfig which indicates that EFI functionality is in use,
either as a client (EFI app / stub) or provider (EFI loader). This will
make it easier to share code between these two parts of U-Boot

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/u-boot_on_efi.rst |  6 +++---
 lib/efi/Kconfig                    | 12 ++++++++++++
 lib/efi_client/Kconfig             |  1 +
 lib/efi_loader/Kconfig             |  3 +++
 4 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 lib/efi/Kconfig

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 9068894e408..177e887ebd9 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -45,9 +45,9 @@ First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
 opt for using QEMU [1] and the OVMF [2], as detailed below.
 
-To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and CONFIG_EFI_APP.
-The efi-x86_app32 and efi-x86_app64 configs are set up for this. Just build
-U-Boot as normal, e.g.::
+To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and
+CONFIG_EFI_APP. The efi-x86_app32 and efi-x86_app64 configs are set up for
+this. Just build U-Boot as normal, e.g.::
 
    make efi-x86_app32_defconfig
    make
diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
new file mode 100644
index 00000000000..fc6d5b6d6c2
--- /dev/null
+++ b/lib/efi/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025 Simon Glass <sjg@chromium.org>
+#
+
+config EFI
+	bool
+	help
+	  Indicates that EFI functionality is enabled, either via EFI_CLIENT or
+	  EFI_LOADER
+
+	  This is used to provide libraries shared by both.
diff --git a/lib/efi_client/Kconfig b/lib/efi_client/Kconfig
index ec413639bfe..723c98d2a75 100644
--- a/lib/efi_client/Kconfig
+++ b/lib/efi_client/Kconfig
@@ -5,6 +5,7 @@ config EFI_CLIENT
 	bool "Support running U-Boot from EFI"
 	depends on X86
 	imply X86_TSC_READ_BASE
+	select EFI
 	help
 	  U-Boot can be started from EFI on certain platforms. This allows
 	  EFI to perform most of the system init and then jump to U-Boot for
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 86b5a3f947f..f04db595200 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -16,6 +16,7 @@ config EFI_LOADER
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
+	select EFI
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
@@ -589,4 +590,6 @@ endif
 
 source "lib/efi_client/Kconfig"
 
+source "lib/efi/Kconfig"
+
 endmenu
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: efit
