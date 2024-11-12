Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F9DD42B84
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B038945B;
	Tue, 12 Nov 2024 14:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bTYThl5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E943C8942F; Tue, 12 Nov 2024 14:59:47 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF9E8945A
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83aba65556cso226896539f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419984; x=1732024784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoWzMr5PuryPEZl/dXJ4v8W6VN0w5LKOiFyccyNyqhQ=;
 b=bTYThl5gYb/cmvRcTlYC8ld55KMeuxjWeygMKSP2TrWQiCWcPt1bIkRv2VDui58h71
 hXF+52tV934d8hmCLYOGsE0ITlHv5NSq6IX1n5OPwsebKYWzaGQjJZ/X3Sho/n1QbUcZ
 LnuLRNntJftf8evtGeA8XMcAKyWrSESRrGGpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419984; x=1732024784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoWzMr5PuryPEZl/dXJ4v8W6VN0w5LKOiFyccyNyqhQ=;
 b=dyzs1kOAaqxq3ey1ftYogHfRfJhN/u2XM5lEw1XtQkOcRtDyLV6wLIAleORIUNmXHp
 QX2uHFr3bk8f88XDiAEsNsyqndlDieo40Aoi9zAb5HSmjOFBfjMlpDw6maxHMXnXEE0e
 TB94WsftB2dwplsXOF8HIJUYS2TRwnzbMdhIRS1BQMUWBVP3Mvhb7pYLyA2vX6YpNChT
 0PnsYLWVfZZ+lsF+ZAtQPpIKM5UzMx1curPApYRb0tXKpG9CGJsnNiGN9lhX4om34IHR
 jHonNJZQyFb+8CWXSqZZWWtvFg1DUR4onZF6tuJ5Gq8pQaZE9EZsgeq5CR90c2lYa24M
 3jrA==
X-Gm-Message-State: AOJu0YyjRNwaIszSR323jRW0ppRSEvpvufHHXLsng2koea6ua/Xw/OZM
 RTsbHTjLzylBhb5buogzRS0gc5i6twIkETx96Y0I4d9cP/SEOQfnTg0Po8iXO9NZAuebpbhu3PQ
 =
X-Google-Smtp-Source: AGHT+IGS3rpJ1Wwtl+uHFRoWrIwAxnVmDTbGPCW/FbBdeObJ7S/F5/S6tFiqJSNp96r1phlW/ULaZg==
X-Received: by 2002:a05:6602:6d8d:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-83e0337cae1mr1658168239f.13.1731419983971; 
 Tue, 12 Nov 2024 05:59:43 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/18] x86: Add some log categories
Date: Tue, 12 Nov 2024 06:59:00 -0700
Message-Id: <20241112135911.630586-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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
2.34.1

