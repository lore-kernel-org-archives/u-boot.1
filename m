Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B0C10F16
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAC888C58;
	Wed,  1 May 2024 04:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ESsglrkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640C688C4E; Wed,  1 May 2024 04:45:23 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5352988C45
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78edc3e80e6so498609185a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531520; x=1715136320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQycl2kR9dDpWFrbkH/cJab5P3jiaXtarJdsqahz/pU=;
 b=ESsglrkzHg+Ao3rWoffl+EvEcyC2enkEzqS4KyBr51HZsiBvWeFn2Gp0UPAAUmefuK
 E2CvVa4zMuGLR25d7Mavl5aVjkJDn/Jufh3eAkkt0cvOEm7eOSmOraRk03C8LCV7lBAM
 fAMhBiHqjShc2yvA0X21+vJSVSNtKOAjVNYuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531520; x=1715136320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQycl2kR9dDpWFrbkH/cJab5P3jiaXtarJdsqahz/pU=;
 b=Ol4kP7z2O+0SmugeL4JkfH3cxAD35KcIFnmTvUeHD2390EDGnDkUXDs+Gxu2mZS0Dk
 hnUMMt76V4evNdxvgkpFsHvTExvIMod+24hCVJcQtSThdKSX3lmOzBg3tpLI9xgsiEGX
 tcLNVHimscxsIPXGW/FqsLF8YI3FpGD3i/cpOoj/XOkuWQi3fil6PmULFAseFxxbKN5G
 A72oZv/4Rzs8PlgEuJjNhmCeubQRij3ycHBX8xJvBb+1hGDydQvVpuT7+cXK9AgFZ+4X
 ULO3CxEj10ZqLoi2USsaQqiJpoUZ6/hZdh7TAToApOMkJLPPp//SPUfTpS6g42pzd3As
 VLbw==
X-Gm-Message-State: AOJu0YwSOpuMSiSflAuBixSWSgXh9qMs6ecTv+ZB/hzwL9gTfR3NPzH4
 SdZxgtbW+kVqc2gc2+Z+3O7lvcS4ibhS0x5OItCdOTwm/IQkKEF2OZwrC/fQB5RjwplcefjKX9K
 nv83Mb3Ex
X-Google-Smtp-Source: AGHT+IHx+ooSTK/XzFSW0FKug33S8eXHdrA1iyH7gnnhIXfOT4ILYAATQiqWNQkMpSiwN7B9KQDT9Q==
X-Received: by 2002:ad4:5f4f:0:b0:6a0:b3cc:ee1e with SMTP id
 p15-20020ad45f4f000000b006a0b3ccee1emr1247367qvg.39.1714531520096; 
 Tue, 30 Apr 2024 19:45:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>,
	kernel@puri.sm
Subject: [PATCH 106/149] board: purism: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:33 -0600
Message-Id: <20240501024316.1767971-106-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: kernel@puri.sm
---
 board/purism/librem5/librem5.c          | 1 -
 board/purism/librem5/lpddr4_timing.c    | 1 -
 board/purism/librem5/lpddr4_timing_b0.c | 1 -
 board/purism/librem5/spl.c              | 2 +-
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.c
index d0249e71f09a..a3c421572afb 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -4,7 +4,6 @@
  * Copyright 2021 Purism
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/board/purism/librem5/lpddr4_timing.c b/board/purism/librem5/lpddr4_timing.c
index 46bc7f8591cb..e9559e3d843a 100644
--- a/board/purism/librem5/lpddr4_timing.c
+++ b/board/purism/librem5/lpddr4_timing.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/purism/librem5/lpddr4_timing_b0.c b/board/purism/librem5/lpddr4_timing_b0.c
index ec68edaf6905..5d8f2803be67 100644
--- a/board/purism/librem5/lpddr4_timing_b0.c
+++ b/board/purism/librem5/lpddr4_timing_b0.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index 9aadc553302e..ed57554a2bc3 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -4,7 +4,7 @@
  * Copyright 2021 Purism
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
-- 
2.34.1

