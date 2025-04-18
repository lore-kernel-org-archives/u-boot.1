Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB3C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 10:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78C082D5E;
	Fri, 18 Apr 2025 12:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QjcajG+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189A82D5E; Fri, 18 Apr 2025 12:59:35 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C88882C15
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 12:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b5e49615aso159942639f.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744973971; x=1745578771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1vwovDxC/JO05TAfJKRBYXxHESn2bhMJvVFVdF9f3k=;
 b=QjcajG+daguaY3oMuecL1VO6+hDW2RoshcLlB+XPShMvQnU5JTh73sWbNguuVxz7bJ
 ptEuE9JVDejmcunKDmU96NYLNr2UUx4xOVZBozO2uk6vqtLOiXQvffkNN8A5CWgJFpLJ
 up8baTMG+0FoEJxQNyUE2Igx4FiUx9HLte3ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973971; x=1745578771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1vwovDxC/JO05TAfJKRBYXxHESn2bhMJvVFVdF9f3k=;
 b=aG8Bn0eOTilZZl1luBDN12dW8l+E8815VOeztVvM1gFsUwnVaum4JrOYG8EtoSB71S
 0pSplJVqVQmSoo3lQ0ZpLvUsH+ue0+5Ogx5bOmmxTtB/gTD+qACp471xOtt76LCrpCxj
 SRsVXFRDIcbZ89jcnyjkOo4CLUyeEOkHgE0vLm7Jp7j3lNowN1Ne9beqeacQM9/rgQkl
 Ss0/szRHMMuOI6/mqYm+XczlHs0uq+uBIGMuKSTa0Lghiwon1KBwgIfqnS6uf/KlhGM/
 C2WxXMFJpOR5EPKVPmK8UF14bCN9O58QmetPmiV45Nz4bbkmGaq2Xpf90wjfnoTyBGCt
 XN9g==
X-Gm-Message-State: AOJu0Yy6aQyrKWwdp7W0+pC8UADcjrX7WrNPzGIsuiO3ymovUNCChGN0
 o+b6Sk/O54Cw2qoLdmVRJP0aKR0baIHM6AAWPA0O2c1uQhjblkzR5syKThmGGhIOWAYV7iVAisI
 =
X-Gm-Gg: ASbGncuTvDw5pE2R1L7T5x1e0+gGdrVwFqr9Ugz9rRKbcD3d1vhCF5Otzs83GI1qUEw
 VOUXR26W+XK9d52SThPLyPYnLloDlOKC2vdziffrZrbUPC4zkqv4Yr+zUVKAm7arpRmA0HpjCx+
 vywZrYTAMqVGnAg78FTD7Rpmg3L0VTin/TC8Qn9qVgwLvV4Q/mLHf76xWPhj69R2RA+GyFzpWYV
 o5JCCZcnyxU4FISbakqPPsT7VRH658p1UPhZXK+5HNXj02HPVsHgkTNsHzF/QQxCx5u3KOTNCQT
 HTwjAQg+nTXyGHcnl+4vVxXrFPECowrLWhwwdO0qx9DdH+C+vBz6UpswOD3apPafOYrWLU8/kFN
 rXQ==
X-Google-Smtp-Source: AGHT+IFWITWCzJShcRUydfiksEBHYnNOEmMa4T1EGOfPjEzNoI2w7VxeFTWHfFWptWmffeDM9CBNcw==
X-Received: by 2002:a05:6602:3789:b0:85e:2e53:ed27 with SMTP id
 ca18e2360f4ac-861dbdc0f09mr236917039f.3.1744973971715; 
 Fri, 18 Apr 2025 03:59:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a395765esm380588173.107.2025.04.18.03.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 03:59:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] Bring in linux/limits.h
Date: Fri, 18 Apr 2025 04:59:13 -0600
Message-ID: <20250418105919.1645824-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Simon Glass <simon.glass@canonical.com>

Add part of this file from Linux v6.14 so we can include it from the
linux/overflow.h file. Drop the relevant section from kernel.h

The top of the file is omitted since it defines things used in mbedos
and we get an error on SIZE_MAX.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---
Error is:

  In file included from include/limits.h:6,
                 from lib/mbedtls/external/mbedtls/library/constant_time.c:14:
  include/linux/limits.h:7:35: error: missing binary operator before token "0"
    7 | #define SIZE_MAX        (~(size_t)0)
      |                                   ^
  lib/mbedtls/external/mbedtls/library/constant_time_internal.h:65:6: note: in expansion of macro ‘SIZE_MAX’
   65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
      |      ^~~~~~~~
  include/linux/limits.h:7:35: error: missing binary operator before token "0"
    7 | #define SIZE_MAX        (~(size_t)0)
      |                                   ^
  lib/mbedtls/external/mbedtls/library/constant_time_internal.h:71:8: note: in expansion of macro ‘SIZE_MAX’
   71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT64)
      |        ^~~~~~~~
  make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/mbedtls/library/constant_time.o] Error 1
  make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2

Changes in v2:
- Add new patch to bring in linux/limits.h

 include/limits.h       |  2 ++
 include/linux/kernel.h | 12 ------------
 include/linux/limits.h | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/limits.h

diff --git a/include/limits.h b/include/limits.h
index 4700cc7a59f..4927cc7333b 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -3,6 +3,8 @@
 #ifndef _LIMITS_H
 #define _LIMITS_H
 
+#include <linux/limits.h>
+
 #define INT_MAX     0x7fffffff
 #define UINT_MAX    0xffffffffU
 #define CHAR_BIT    8
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9467edd65ab..569804f7264 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -16,18 +16,6 @@
 #define LLONG_MIN	(-LLONG_MAX - 1)
 #define ULLONG_MAX	(~0ULL)
 
-#define U8_MAX		((u8)~0U)
-#define S8_MAX		((s8)(U8_MAX>>1))
-#define S8_MIN		((s8)(-S8_MAX - 1))
-#define U16_MAX		((u16)~0U)
-#define S16_MAX		((s16)(U16_MAX>>1))
-#define S16_MIN		((s16)(-S16_MAX - 1))
-#define U32_MAX		((u32)~0U)
-#define S32_MAX		((s32)(U32_MAX>>1))
-#define S32_MIN		((s32)(-S32_MAX - 1))
-#define U64_MAX		((u64)~0ULL)
-#define S64_MAX		((s64)(U64_MAX>>1))
-#define S64_MIN		((s64)(-S64_MAX - 1))
 
 #define INT32_MAX	S32_MAX
 
diff --git a/include/linux/limits.h b/include/linux/limits.h
new file mode 100644
index 00000000000..0117bf7eea4
--- /dev/null
+++ b/include/linux/limits.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIMITS_H
+#define _LINUX_LIMITS_H
+
+#include <linux/types.h>
+
+#define U8_MAX		((u8)~0U)
+#define S8_MAX		((s8)(U8_MAX >> 1))
+#define S8_MIN		((s8)(-S8_MAX - 1))
+#define U16_MAX		((u16)~0U)
+#define S16_MAX		((s16)(U16_MAX >> 1))
+#define S16_MIN		((s16)(-S16_MAX - 1))
+#define U32_MAX		((u32)~0U)
+#define U32_MIN		((u32)0)
+#define S32_MAX		((s32)(U32_MAX >> 1))
+#define S32_MIN		((s32)(-S32_MAX - 1))
+#define U64_MAX		((u64)~0ULL)
+#define S64_MAX		((s64)(U64_MAX >> 1))
+#define S64_MIN		((s64)(-S64_MAX - 1))
+
+#endif /* _LINUX_LIMITS_H */
-- 
2.43.0

base-commit: 5841e78ed6ebd31b26553003e880be378b232cd9
branch: sec2
