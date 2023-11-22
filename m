Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC22FC61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8873187604;
	Wed, 22 Nov 2023 14:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DnizQoVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD72875F7; Wed, 22 Nov 2023 14:12:06 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5C286F67
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da7238b3eb4so6673572276.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658720; x=1701263520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PX6OnGo2Dk61xlqOrXgicr6eu8fcWEI9cwKkfmMt5Mk=;
 b=DnizQoVjpJuRr2WxKX75TuEag33y1RFkFIvyR2NFGEJH032FRiJc3XHljGpK4N3UdW
 BomYpePiatwzAFOl5j5IBZ8pO6ibMXVrWGNCKdS0jIXA5sK/f10UmKnbVpj1+b6OKv9C
 ik4lXXqqKp69HdHtbKb6qhgvXnOMIeFiaQC2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658720; x=1701263520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PX6OnGo2Dk61xlqOrXgicr6eu8fcWEI9cwKkfmMt5Mk=;
 b=qz2EDHOxb/6gx2izFVLH3H5aq5y5H5BIxCPGsA7uzod/6BnKD43H1ZEyAsetRhlT2c
 rnuYwpX3oDVUEEIgcwN8OZLhtd36EO+WiFNwBtDFH7A0efMXe8C+yWvo4yuBpjNwOjZ3
 tvIdHpC5cxz2y9J4wTjUQAvALIm/LMTDnt3JVdxBPQVnSI1vtpj2Vju7TFpm8vHeBJI0
 oQDdC5wTLZugot1oSiMk4+2Fl9mB5nyRvHQRLg3E9P4V1BVRRKLJlzHsvsISxyYKHblV
 nC3B09tC2XRBFM1b2dfdB9fXrSGaAqeULF4PIBHe/BUtbNWF5wu1bsbrHTY1wE1V8bfK
 /8qA==
X-Gm-Message-State: AOJu0YwnTYqBcmASf5hpsfD2XCAxaAW+1uJrRKZ3GZY6BnSi9SkoJKYW
 8CN85aGviddQvUVQmzCQcsupKqbEHt4H+axUU7nZGQ==
X-Google-Smtp-Source: AGHT+IH+00znSW51VpmMx5/CIAnaFZuaTBiOatCO7yRppTgw8UuDwVN1EhcGayXo+Szl2QR9Dlw/Og==
X-Received: by 2002:a5b:94b:0:b0:da0:7936:5265 with SMTP id
 x11-20020a5b094b000000b00da079365265mr1924664ybq.56.1700658720585; 
 Wed, 22 Nov 2023 05:12:00 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 06/11] lib/sha*.c: Update header list
Date: Wed, 22 Nov 2023 08:11:49 -0500
Message-Id: <20231122131154.2444690-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

Cleanup the list of headers we include here. For the tools build we only
need to exclude <cyclic.h> as that's used by the target build for the
prototype for schedule(), and we don't need to get that via
<watchdog.h>. We can also make use of our <string.h> intentionally
existing as a redirection to <linux/string.h> to reduce ifdef'd lines.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/sha1.c   | 7 ++-----
 lib/sha256.c | 7 ++-----
 lib/sha512.c | 6 +-----
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index 8d0740789349..7ef536f4b5db 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -17,12 +17,9 @@
 #endif
 
 #ifndef USE_HOSTCC
-#include <common.h>
-#include <linux/string.h>
-#else
-#include <string.h>
+#include <cyclic.h>
 #endif /* USE_HOSTCC */
-#include <watchdog.h>
+#include <string.h>
 #include <u-boot/sha1.h>
 
 #include <linux/compiler_attributes.h>
diff --git a/lib/sha256.c b/lib/sha256.c
index 4d26aea1c8ce..665ba6f152e5 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -6,12 +6,9 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
-#include <linux/string.h>
-#else
-#include <string.h>
+#include <cyclic.h>
 #endif /* USE_HOSTCC */
-#include <watchdog.h>
+#include <string.h>
 #include <u-boot/sha256.h>
 
 #include <linux/compiler_attributes.h>
diff --git a/lib/sha512.c b/lib/sha512.c
index fbe8d5f5bfe9..ffe2c5cd9642 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -11,13 +11,9 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
-#include <linux/string.h>
-#else
-#include <string.h>
+#include <cyclic.h>
 #endif /* USE_HOSTCC */
 #include <compiler.h>
-#include <watchdog.h>
 #include <u-boot/sha512.h>
 
 const uint8_t sha384_der_prefix[SHA384_DER_LEN] = {
-- 
2.34.1

