Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4639C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E198164E;
	Thu,  6 Mar 2025 17:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CnvUroX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E918141E; Thu,  6 Mar 2025 17:05:08 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2D281760
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso2820325ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277103; x=1741881903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=CnvUroX8kYXa6WBpBYWEyv7qMVDzz//Hl+zj57A+B3bMbCkcBCS7SlT6BjwbXLzNdf
 FGnuD/UgGsa3wK4mcih/gcv5fGxYXc4QSW3obiSe+czlFsy01+oXAYPnuNageWuVBrzv
 pnCgmFGxFmZW1bz+IMzwDALENxebB//MGVb44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277103; x=1741881903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgYQ1DBcTz0GQCTNBv2O8yfAQ8mKNJyLlRGuzmVQMpo=;
 b=kE9LlpDyGD7mLeNPH/HQgXBt2mC1UzYxSPeNq6VvtK7emQxKLdv42807T9RcwTVg+T
 uuiE7aN5EqAlKRirCwU7WzFn7/WcKDM9P02Wd5P+nT5MhJ/XpSNmY91zfO1ieB5nUv3X
 iWSh8yYMa35Hh3o6L5sTNRVGpZdgUmaMZOm3nStoE0rHnYvACBUdPpfiamXTjVrff9pv
 qOwY5lNqKg34BeCQtHiiQUuk53vB51/5dMFGXCiuatGwfUKX5ipe6tMjsnBuY706tP47
 k/wQS0GGg4CF0mZjKMEU3rM1/m8dYTyzsffmULWxqBdnIGPdJ3FCIAEIKqIHPMdgqN6H
 XMqQ==
X-Gm-Message-State: AOJu0Yxi2KsECxM75J1eJY7v5f4u9J6aUPR01jsZouPoga4mn5/aGbgG
 Izln53RFW571VMw3U04r4tOARujgnmD/7yMxTRvD/5mywMlDlOiTB08UBAeQqo8vRex7Hfee6KY
 =
X-Gm-Gg: ASbGncust7OrzdKh66XazOj/zZK7FoA0JEwXSAJtcytPsu3VjRKc244os8x5I124pkT
 NU7Bkp/CwSpULp3uTGz8Gj0s26vpbwDdLtvHID8oKVmEuIpLkNBLA3Fwkc2yiYVwSEKmmrgXEfJ
 mwJtSfaJtzm9R0iUym84JXSM8ahZV5/pq/00WzRWO49fjXMArnKVaJLh+wj1AWr1UFDX7pBXqJc
 tGqTE4N5LSz81BrWnijZ6SrZzSoWjNbF7Jf0YpqFsndK8Bvjyl7f42x+7mKDunExclZsveE5xxY
 MY+O8UOd9LRRAiY8NKhLmXjVBDd0FUUmEKcBb/GcXyumJGDG40/SkQ7mdtltfGRQJqDp4xkZlfM
 sdmasxQ==
X-Google-Smtp-Source: AGHT+IGL8tkvDA0H3VVsLjboN3MaB5Gl/9AH2CiF5rYVGM545DIoqTpDJhKemrPw8ZkZlqpzHJEp9g==
X-Received: by 2002:a05:6e02:1906:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d42b9a3ba1mr92465705ab.19.1741277102826; 
 Thu, 06 Mar 2025 08:05:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 08/47] x86: Add some log categories
Date: Thu,  6 Mar 2025 09:03:35 -0700
Message-ID: <20250306160428.3041057-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

Add categories for i8259 and bios files, so that log statements have the
right category.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c            | 3 +++
 arch/x86/lib/bios_interrupts.c | 2 ++
 arch/x86/lib/i8259.c           | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index 03f7360032c..acae635cf19 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2007 Advanced Micro Devices, Inc.
  * Copyright (C) 2009-2010 coresystems GmbH
  */
+
+#define LOG_CATEGRORY	LOGC_ARCH
+
 #include <compiler.h>
 #include <bios_emul.h>
 #include <irq_func.h>
diff --git a/arch/x86/lib/bios_interrupts.c b/arch/x86/lib/bios_interrupts.c
index b2cf1527b1c..3ae6c193ec7 100644
--- a/arch/x86/lib/bios_interrupts.c
+++ b/arch/x86/lib/bios_interrupts.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2007-2009 coresystems GmbH
  */
 
+#define LOG_CATEGRORY	LOGC_ARCH
+
 #include <log.h>
 #include <asm/pci.h>
 #include "bios_emul.h"
diff --git a/arch/x86/lib/i8259.c b/arch/x86/lib/i8259.c
index 465ff70146f..088f78f4661 100644
--- a/arch/x86/lib/i8259.c
+++ b/arch/x86/lib/i8259.c
@@ -13,6 +13,8 @@
  * Programmable Interrupt Controllers.
  */
 
+#define LOG_CATEGORY	UCLASS_IRQ
+
 #include <log.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
-- 
2.43.0

