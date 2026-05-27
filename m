Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FCCCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5086784855;
	Wed, 27 May 2026 18:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rrd5F3Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B661C84855; Wed, 27 May 2026 18:11:13 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA9184837
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e55b95ba13so6203323a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898270; x=1780503070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKDyV/hM9xZ/AnlPFPVCSChGt/HxOIkTxXr0P8bkhfY=;
 b=Rrd5F3Qm7JOnyKn32G6M0iwCXsKtAaORT9lu6Ea2PEsTLlyykqckKv9/LfpzeJSnFD
 IGgiUMycI3n62uCwQuqsp7Mph2wQpzfetCAXgTiTlMXQEHHXauuc1kRz9CquoXwYJ0IU
 osKaewX6MFKt080H8mvrLhMx1ZkzAgJ6O8X8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898270; x=1780503070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKDyV/hM9xZ/AnlPFPVCSChGt/HxOIkTxXr0P8bkhfY=;
 b=RMPKLwdCJzGBe3tMcQUCdiLuhQoq5pvSnXRt8DJ8+Vij6HctpsSPktdqJHvyC+sMUW
 t3U432EnM1I3DDoZfufqFubPYifW/2+IZn7bwQpFElXi2LrPUgqdVudLJ4IehFIDXq2i
 b783Y7BVAg6WpbrU2tBWtX8Bk8RRpKg/XXzqtPH3cMOgqP6w5UOPzu6pgZQNxBE2lqTx
 +ZxI6a/ntvRQHMz30b+Iq7rGWQ3/lFMMWEQgxp3F7WwkUhCMciYzCW5hmy+G97VLDX4a
 4b5aluTEBI9c8pfqzZH6bQCjj0Q/rEojpRnqVap8eJR4CnZ0wBP6+HzmZjRKoQTvQ83A
 P9wA==
X-Gm-Message-State: AOJu0YxOrt6UBfRUW0ngT0uhI2FnBOjN2klh9hLej/TQULNjJXJ4Tt7/
 iMe+qGV4mON9uvN4yKmGuEphGwXT4J9vYR3LLI562v6mukYDcB7kNJtM8ESM9J3w8qp8QAbgin9
 cV8UHOi0iXqLV+Q==
X-Gm-Gg: Acq92OGdySl1KfZKGIHzq7W7vuYzzQf4yQUOSv4am/j6IVqOIlGwW9CS/3mjzpWkBRc
 JzSEVPPF594x52K8KGQENwc4jSVq2s4RVOhCncVZfQisOBM208m+HWeFcgoYRNZOnZ4EaKVeyX5
 2bo95b5xBY/rUbqFBDPpGddohDY6V9eWHygHqYNb7aFkqrk+3T2aCdfV/doSz59o5TKWJ5X4Jvk
 PkxEWVIgjfwJpEVepq8ekG8+aqBmclCcUq3ysbS9zlswmhUUX4Giy9wAbfVZS78D1x6vP/75MmD
 cj9hDMU6Uc5h6PUl7+vPLNP37Xb3megjNCO92HnmuDcRLqJegJKBpaoTt/sZqTr8XSP8Tj7z1zD
 4rWs6yDX29Jj5HP5cOnqMJ3s+wW9+jEnjw9h0N4g5/WsAJ+BaWUbBsee+ZsKrAodH5rjqpS2oEM
 8+qyPId1ss1ruHtQjcKg==
X-Received: by 2002:a05:6830:3c8c:b0:7dc:da80:42b4 with SMTP id
 46e09a7af769-7e5fefbe76bmr14275679a34.24.1779898270304; 
 Wed, 27 May 2026 09:11:10 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] alist: Allow inclusion from OS headers
Date: Wed, 27 May 2026 10:10:12 -0600
Message-ID: <20260527161033.3273795-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

Sandbox needs to include system headers in some files, but also wants
to use alist. Adjust the headers to permit this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h | 16 +++++++++++-----
 lib/alist.c     |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/alist.h b/include/alist.h
index b00d9ea97d6..69d7cdb722f 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -10,8 +10,14 @@
 #define __ALIST_H
 
 #include <stdbool.h>
-#include <linux/bitops.h>
+
+#ifdef USE_HOSTCC
+#include <sys/types.h>
+#include <stdint.h>
+#else
 #include <linux/types.h>
+#endif
+#define BIT(nr)			(1UL << (nr))
 
 /**
  * struct alist - object list that can be allocated and freed
@@ -41,10 +47,10 @@
  */
 struct alist {
 	void *data;
-	u16 obj_size;
-	u16 count;
-	u16 alloc;
-	u16 flags;
+	unsigned short obj_size;
+	unsigned short count;
+	unsigned short alloc;
+	unsigned short flags;
 };
 
 /**
diff --git a/lib/alist.c b/lib/alist.c
index 4ce651f5c45..0ae07f0f5c0 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -8,6 +8,7 @@
 
 #include <alist.h>
 #include <display_options.h>
+#include <log.h>
 #include <malloc.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.43.0

