Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30DAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E822588A94;
	Tue, 30 Apr 2024 15:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFrdhUgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAE288A69; Tue, 30 Apr 2024 15:36:39 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF8C88A53
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a05f376effso44313446d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484195; x=1715088995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXsa/M8uMhADbT8Th5bVQcwB2ZZAkDzTGf5zLnpwIlY=;
 b=eFrdhUgEKhHtuaCvpPAGWeZiF4N82Cds1znp4FmOmprdEOd+Km25pXcP3IvKGV3NKO
 8bNhFjOWgtthpIVi6OYJy5NeVoPMpL+h7TGL0UjLRvdlxeU4ZMv7u4HzO32M3nDmy6OR
 Qtp80hwazuvbeNLp5RCy2fIiTeW1PSAax/VTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484195; x=1715088995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXsa/M8uMhADbT8Th5bVQcwB2ZZAkDzTGf5zLnpwIlY=;
 b=M280vxjkrr74o0WG2nGgqptNaqpFjpBY0TpSGj5vUoAc50eIQ4jJMuSYFtbRF/vC0j
 xZrGhikA1I9sTqkeIowAfKZAztj0YV1ei0uiz402zyqV3vtS4brT0YnxuWjFOmjRQy1K
 vXQFWRC8eSCcKCjoLQ49qsqPsLVt0diEq3WVfgOOTtdkr9uwIjCVW+ZJFAfPCLsySVmA
 g+U8CQe2ujSEBIBKLGDP0yrBkqr3tNHqXrx/tX/qG2+JtglTw/oUeYaLga28UpA41vZo
 +aexVh8uSGsEXCh6PilhnU5i1v5f9Ns1aVDsLtPOxxP6or4zmUoT7Mx9VXA4sKjQYpJE
 +VRg==
X-Gm-Message-State: AOJu0YzwCHulq3BF+/tEbqBUOASxL28+GPvtq36r9W2x+qgvaiHF0Pkt
 JZvDnl9sY7AK/Uey39iVeNNa29waUjmmNYhn356wtdofV3sNJs4VxuOY5YNV6Ayq7CwrOzNc+y2
 oSW41iQ==
X-Google-Smtp-Source: AGHT+IFmwHmqx1CByrrd4eHi7o3G1bHd6XH8r2UBnFZRwXjakNrHDj/3xoelnlPocBMW33SUOmkXig==
X-Received: by 2002:a05:6214:518f:b0:6a0:b352:f3b0 with SMTP id
 kl15-20020a056214518f00b006a0b352f3b0mr12461428qvb.39.1714484195382; 
 Tue, 30 Apr 2024 06:36:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH 31/33] arm: apple: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:57 -0600
Message-Id: <20240430133559.1836389-31-trini@konsulko.com>
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

Remove <common.h> from all mach-apple files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/mach-apple/board.c | 1 -
 arch/arm/mach-apple/rtkit.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 7a6151a97223..8bace3005eb5 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <efi_loader.h>
diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index a550b553b663..b8f4771e5e71 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -4,13 +4,14 @@
  * (C) Copyright 2021 Copyright The Asahi Linux Contributors
  */
 
-#include <common.h>
 #include <mailbox.h>
 #include <malloc.h>
 
 #include <asm/arch/rtkit.h>
 #include <linux/apple-mailbox.h>
 #include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 
 #define APPLE_RTKIT_EP_MGMT 0
 #define APPLE_RTKIT_EP_CRASHLOG	1
-- 
2.34.1

