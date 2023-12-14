Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA28C4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6FA87B96;
	Thu, 14 Dec 2023 19:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mS7Gl8PT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3329E87B6B; Thu, 14 Dec 2023 19:17:13 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF3387B77
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so84346507b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577828; x=1703182628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PX6OnGo2Dk61xlqOrXgicr6eu8fcWEI9cwKkfmMt5Mk=;
 b=mS7Gl8PTFQx2W8KvtMqNbQX9RodO9/5WtL5wkhROM4huTsIcjvz2c9ni6WX3VvAl9E
 b7xjDrSL8QQ9Wxxa7WDz29dDc2x8Jk5mChb9fUs2QFQbqGbAZvUyQmqblsaLXni2C7g0
 BF0GChrGEwD2uX/TO1kSQGQQKpA919tQJF8WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577828; x=1703182628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PX6OnGo2Dk61xlqOrXgicr6eu8fcWEI9cwKkfmMt5Mk=;
 b=fe9HdQKlbdXSqhO1pV9rjky0ipxUn/JeFJflhtgn2694XHwEdsIMk1CKkjoPJlSM/e
 yxKfmy95uX7DPfAcz0jAtLS+l4x9cEuUDQ6jplOOh0E0APzTiXQ4spYEJ1OVJmLAAMnL
 aLHSDxn7GWFhzDcV3Sgd3OUXUA/Zh+ZnP9qQ012qo3W+iHjA52e0LA7vAC3VuWi5870W
 U+kiAk+6yl7y9LG+6Ni9oswghK1W2hkehWapHBAwMwZ+AtL39I6JmwVWfx/OPf8VCoaZ
 7Q9MjxPnvwDJlMo5PuRTxysOpj7gmorSL4aehSTqMzE3z1PQ5ePppd9oErt5fIOgayRO
 WGng==
X-Gm-Message-State: AOJu0Yw+/029OERZrJL5x2JztWIyvURyAgGX7bntAwJgorph9GsnNWr/
 JWSdyMT8i4zQsGO0YuFaAlZn87NI14nMJYH0VyM=
X-Google-Smtp-Source: AGHT+IEDkUmzKqs9lj8viGh40xIxAlcL2//tSR+0On42HsHZrNpKKnPEjLIE+1Z2arjuitEBrL4Xow==
X-Received: by 2002:a0d:dc81:0:b0:5d7:1940:f3d6 with SMTP id
 f123-20020a0ddc81000000b005d71940f3d6mr8050677ywe.62.1702577828425; 
 Thu, 14 Dec 2023 10:17:08 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v2 11/16] lib/sha*.c: Update header list
Date: Thu, 14 Dec 2023 13:16:53 -0500
Message-Id: <20231214181658.3359902-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

