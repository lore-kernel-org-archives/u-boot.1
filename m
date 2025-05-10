Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE45C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFB282A8D;
	Sat, 10 May 2025 15:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0hZMZTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086C6826AA; Sat, 10 May 2025 15:07:02 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080C882A33
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5fbc736f0c7so4417212a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882419; x=1747487219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wyxsopi+X0o3BxQPyWhDqNt5OsNH9d/PfXYV7KygNPg=;
 b=C0hZMZTVquVsqL8+9ZtZq3p12rPWXyExEl4rjqN1ymPHPjqyMwgfan8UFxUdXB2IZk
 RBGJhMWnFQHwVmmMdQNW5nFse37A0lpWRrVGuGLd4VSHyqOMSFtPvq6eyteQh3VYNABE
 SWGyNRnV+Br7zkwvyIjvWtTwRQbCMaTQzSKjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882419; x=1747487219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wyxsopi+X0o3BxQPyWhDqNt5OsNH9d/PfXYV7KygNPg=;
 b=p+uiAHy6MnfF6MAYgie7E9yCS8iwCWin/3nTXjIz+0cGc1FVSzuXeQ+mY/brvNiXOM
 GXNnMyZWo8MZaAfWCuRzo3YP4qDRQ8sx6795lKeFcwIR4vv2k1cLCGhsJYxIyS5E+Y98
 oF3OEmm5aCcyefGd3hksHjB6wORqZSphb21TodtOKgh5sBHdC9W8qlLTvx9aPpB9JxaP
 c9EsyU9wxsXXHoUUeVWJidsmKKx3ZJh1AeYyIge2aFmxAVXeqCEI8GNpUCwLTsNNrokn
 dkMT+mmUS2va5RYyu6FBqkHeLgwQ5VW94PpvaEDeOzzFuEVe5z3VCRdOotIlZGSaOR66
 ddBA==
X-Gm-Message-State: AOJu0YxGzPXEKIWeYl9LmX+nrwwPnX8TiIlfd4zevEfHowGKOwE46mOf
 071+Bz7+8OaC1K2Qu9PGBbmSs+VU9YSa9OUmdC3oN3/xaFC0k5J3zIY0BgZ1aEj08fbMBdkpWBi
 TNmDu+VN9AA==
X-Gm-Gg: ASbGncteidtIkp4q5V4lhPZFHo2JnP/D+XU8SCgOt0C7zb/mrq9uWlx4QQNQcJMLbfW
 E9qyWHAAV3gvWu7wRs+sBY6p5O2cZTQEpkRks/SmhDwEGOKtyd/Otqx7ysoquYCDalUdBia/Ik3
 CWxe99oM5+s6hGb6S3XCm2zOFE56v0M7PdafnNg7j0DI0Huqsft/w9eaa9oIi0NR2iaVU714yk1
 z39yu0WsU/bob9aB3TyoXVYOwPTW/dTN9O4ztdc+WSEvpILjneXZOseTrj9FScY65nie1cY3fg+
 nGAs+ICcq8mzus0Y9VkIU7iafkhnw9KuGa6V3zPqKpFupUI=
X-Google-Smtp-Source: AGHT+IE9bUjqW5pjrFGjoysDSr7N7ZVB4nLgCnVMhwHANcwDVEBon3wnop8CwDtpIzlyTEhG8YeyqQ==
X-Received: by 2002:a17:907:d005:b0:ad2:4374:8493 with SMTP id
 a640c23a62f3a-ad24374863fmr43597166b.34.1746882418929; 
 Sat, 10 May 2025 06:06:58 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:06:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/10] Bring in linux/limits.h
Date: Sat, 10 May 2025 15:06:07 +0200
Message-ID: <20250510130642.1575114-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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
Signed-off-by: Simon Glass <sjg@chromium.org>
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

(no changes since v2)

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

