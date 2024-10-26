Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC8BD10BE3
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 04:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C560388FE4;
	Sat, 26 Oct 2024 06:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6voDriE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAC488F68; Sat, 26 Oct 2024 06:07:59 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C771B89043
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 06:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b14554468fso179746985a.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729915670; x=1730520470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YFCzThPgJWlSXsdzAOfcoN/kZMFM0Z073/HQpPJuvVk=;
 b=l6voDriE63s8y0mPnb0ggpAj/dAfNxHV37LFhO7WZKY8COpPPGq9iZxuCf1Jxfv3mM
 daToNyZZmKm8XmZ7/c6Y0GaItcLiZt82hAbfApqDLo3gg0H3+jowfCwDzRBfu2m7QpXZ
 n5xGT8iVXIe+Y6ho98JEv9P9uq1XHU3PVfSo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729915670; x=1730520470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFCzThPgJWlSXsdzAOfcoN/kZMFM0Z073/HQpPJuvVk=;
 b=lOx9pZYlvISKIf5vqxASyah4JHWugfjNebPhofcHP0ICsxMl3siJ72Ic63kt/XhYHJ
 UPoH/Y3bhMYVLH7Mj3MC5CiuNtvaqD3nun+lxiBUbRU9LkliOvETAyZpIpa6y7aKaFCY
 vzyCDCyHgqMdBzXIsmNbQ1HMu/f9/CJnwAaXqG3Nb13xjhS+9RfgyhznRbLo8z03GG5u
 XWSxZ1JYgA4Zn1AJBFsF45K3Kk5lBHpwqEVB4wU7MCq2gZtqLf3xnzMEHJNX4ihvr6Co
 NwX+pQjinXuEpw1KvvlVG0Gay0afHo1MtbbUJKHmPxfA7jwV+Wnrkl/9SiXfH84KwJ1F
 9LzA==
X-Gm-Message-State: AOJu0Yy1t1yM2QWbMo/2lpnl4/4IJor43NhwC5M98kVcHDwlPZxqBz17
 bHsGVI3xcGWJvDLlhxjdjlNQbpe9AXGqKl4nngueaVEqHuFuXlEgL5bjljCM5xVlCdHYURzjy0N
 krV0=
X-Google-Smtp-Source: AGHT+IF5M/gfx6m9R9W349cTghX3Oh+/6x17bHYdiPvG1Yht4UVxRes31p9QBO4/XZE8ecW1Vg0fiA==
X-Received: by 2002:a05:620a:444f:b0:7b1:18d9:1887 with SMTP id
 af79cd13be357-7b193eff029mr209189585a.32.1729915670533; 
 Fri, 25 Oct 2024 21:07:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d32a593sm116512485a.88.2024.10.25.21.07.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 21:07:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Kconfig: Remove TARGET_TRICORDER references
Date: Fri, 25 Oct 2024 22:07:47 -0600
Message-ID: <20241026040747.1657322-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These were missed when removing the rest of the tricorder platform.

Fixes: d137604c20a4 ("arm: Remove tricorder board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig      | 3 ---
 boot/Kconfig | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index a7b2b6db7425..eb55f2511d95 100644
--- a/Kconfig
+++ b/Kconfig
@@ -599,7 +599,6 @@ config SYS_HAS_SRAM
 	bool
 	default y if TARGET_PIC32MZDASK
 	default y if TARGET_DEVKIT8000
-	default y if TARGET_TRICORDER
 	help
 	  Enable this to allow support for the on board SRAM.
 	  SRAM base address is controlled by CONFIG_SYS_SRAM_BASE.
@@ -609,14 +608,12 @@ config SYS_SRAM_BASE
 	hex
 	default 0x80000000 if TARGET_PIC32MZDASK
 	default 0x40200000 if TARGET_DEVKIT8000
-	default 0x40200000 if TARGET_TRICORDER
 	default 0x0
 
 config SYS_SRAM_SIZE
 	hex
 	default 0x00080000 if TARGET_PIC32MZDASK
 	default 0x10000 if TARGET_DEVKIT8000
-	default 0x10000 if TARGET_TRICORDER
 	default 0x0
 
 config SYS_MONITOR_LEN
diff --git a/boot/Kconfig b/boot/Kconfig
index b9287c606856..ba77130449a3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -234,7 +234,7 @@ config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
 	depends on SPL_LOAD_FIT
 	default 0x44000000 if ARCH_IMX8M
-	default 0x0
+	default SYS_LOAD_ADDR
 	help
 	  Specify the load address of the fit image that will be loaded
 	  by SPL.
-- 
2.43.0

