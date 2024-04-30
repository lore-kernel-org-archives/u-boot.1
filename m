Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240E5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482E288A76;
	Tue, 30 Apr 2024 15:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k06l3h3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C4B88A41; Tue, 30 Apr 2024 15:36:26 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587F488A4C
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a04bae513cso25023346d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484183; x=1715088983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbX8GeaFiNipVI/fYWdsXyYLEA12+fFJYFLjDYUzlqQ=;
 b=k06l3h3ljpb+AmlU8sPz2mbHGIo1UA6ZahoXxX/jNK4qFsQATv37hRNmv29tJQVq/r
 W3Detg1PUlz+nfURaFF+2QabHJKWmiNJDVLOF/kHbzpce/AtryrqlFT/yus3rDkwhU7V
 bUOkW+EL399+aklLiUv3P1IlMBVPTGaCdmO4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484183; x=1715088983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbX8GeaFiNipVI/fYWdsXyYLEA12+fFJYFLjDYUzlqQ=;
 b=KrZZqmpm0Xg3cPeDK/SkbHnWKs5a7mNU5GYwBK6oDzTVTWDh1yVTITJ7fCGPK7soaA
 hMrim4+7yPhle1Vdv6RdRQbQVkEh5hvSSg5pFFRLU5fUr0X67SzqH+i+EFQETEUY90/f
 TspiYNKFgeuHDizUwEo1IykzsLAA0QcU1kOxKzQWCvHbspJVzU5psQwrK7ydhpXN7Kwn
 +q4CLd0jSSNn40HYqO33xTdTn+pLv8m32V0CaxHWidhek5L9diX3wMlrIrgUtFhmkCUU
 GZ4CEApktsiYq3J0HoDoHWSpKgULxDnnwgLkf9f7HZ2DJXmHv1PHKhEtgKUxupzlstRU
 Oofw==
X-Gm-Message-State: AOJu0YzmM5WzaeDMxKVW1MuROHGRTaAthNH4+najfNl/X45VV+Nhr7Ru
 Ddo3ih5iiDsw+REkUJJHJmZlGJ0Pjdls4ZGBb4jjDoPgBJ9V08zb+6VyTKcC8/ha/j9RDHq8Dpw
 l/JBU+Q==
X-Google-Smtp-Source: AGHT+IEA6oGyhT8GQXLPXKMnvXwRdPNApsCvvUkrzVG0Q9GQVFMXwR8dr9el8bPfGgfjSTi/yTLR4A==
X-Received: by 2002:a05:6214:5093:b0:6a0:d3ef:2a7e with SMTP id
 kk19-20020a056214509300b006a0d3ef2a7emr5949200qvb.61.1714484182982; 
 Tue, 30 Apr 2024 06:36:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH 19/33] arm: meson: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:45 -0600
Message-Id: <20240430133559.1836389-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-meson files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io
---
 arch/arm/mach-meson/board-a1.c     | 2 +-
 arch/arm/mach-meson/board-axg.c    | 1 -
 arch/arm/mach-meson/board-common.c | 1 -
 arch/arm/mach-meson/board-g12a.c   | 1 -
 arch/arm/mach-meson/board-gx.c     | 1 -
 arch/arm/mach-meson/board-info.c   | 1 -
 arch/arm/mach-meson/sm.c           | 1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
index 967bb671822e..f848c0f068ed 100644
--- a/arch/arm/mach-meson/board-a1.c
+++ b/arch/arm/mach-meson/board-a1.c
@@ -3,12 +3,12 @@
  * (C) Copyright 2023 SberDevices, Inc.
  */
 
-#include <common.h>
 #include <asm/arch/a1.h>
 #include <asm/arch/boot.h>
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/sizes.h>
 
 phys_size_t get_effective_memsize(void)
diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
index fdf18752cdd0..6535539184cc 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/boot.h>
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 7ceba7cede85..39774c43049a 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <fastboot.h>
 #include <init.h>
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index d5a830fb1db8..dc4abe1e1074 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index c3fbdfffeae8..0370ed57e205 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/boot.h>
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index d51d9b8f0645..b4058f593234 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2019 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 914fd11c9894..4d9f83d3b38d 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -5,7 +5,6 @@
  * Secure monitor calls.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <regmap.h>
-- 
2.34.1

