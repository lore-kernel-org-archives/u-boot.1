Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E54C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4703F87F36;
	Wed,  1 May 2024 04:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="huYOnIEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F0D88C08; Wed,  1 May 2024 04:45:11 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B4A88A98
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78edc3ad5fdso41178985a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531507; x=1715136307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnJRse7bYaBHcl7yPlGlqjnKczxGxIAJcARhADVMusU=;
 b=huYOnIEXRTvtHz0ef6IgQA2jIifCtBnPFRY68Jup5Qr84p6m6zgbmiPqDoujxSkbIZ
 LcFa8+f7B5SiZ+v+llihYWtlApMpDOM2GPWBdEouF5N6w2hl3oXaSsJxA+DeGpQCDLsm
 IMuFxh7qLwWy56BHK95Y2wgtDgPDYQp2tl3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531507; x=1715136307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnJRse7bYaBHcl7yPlGlqjnKczxGxIAJcARhADVMusU=;
 b=MGMoa9yqkPDd2DhpqB1oVVtSjBDZpyLoSIdWETCgO30ncHfmd1rieus66lcYbrZeMO
 DZhk673Bp62mzq7NOrZACW6b9qMtL2l5QWleb2PFu9Cr/JwL0YKTte7FCRTnEGQoO3k7
 eJwC9lXkcEMQFzTFP0+DhcA4eVMHW6IVs6O/xCLmMKk1eDgfOK7u3WgLSwGKj8sIEh4I
 2esc8i4xU7Gs7wAcsgO/bxjEwPv4oquA53qugIrNXRRSf0JiRp4u2716o5mgM9qRu4Yo
 /IdkNm0bKuiqdoNUy05MdgLGkT7Lnwfqkp1is4o9LFenBA2Kv8EGa7dvTSQlZthvLtQL
 aVnw==
X-Gm-Message-State: AOJu0YycPUwI/+kf6drhRWiA9fg0HvF25dbSjRB7UhanK9h+Sz3o5/GJ
 OPb+TPdT0GAkK7WutegpGPTHC3MGS3mTuvBJQoohDzPKHk6t0WuFu/tLmmOCAFCdm2iWO0DvnWI
 6anzYo6gW
X-Google-Smtp-Source: AGHT+IESfSR5F3mU1gIdAOaXfy6C7tMe+JRIHFEZeLi2x17+nLXyxi63R4u8xGR9a2gnO0DMTZ9Mvw==
X-Received: by 2002:a05:620a:1a8e:b0:790:eed5:53f with SMTP id
 bl14-20020a05620a1a8e00b00790eed5053fmr7658081qkb.1.1714531507289; 
 Tue, 30 Apr 2024 19:45:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 094/149] board: mscc: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:21 -0600
Message-Id: <20240501024316.1767971-94-trini@konsulko.com>
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
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Simon Glass <sjg@chromium.org>
---
 board/mscc/common/spi.c      | 1 -
 board/mscc/jr2/jr2.c         | 2 +-
 board/mscc/luton/luton.c     | 2 +-
 board/mscc/ocelot/ocelot.c   | 2 +-
 board/mscc/serval/serval.c   | 2 +-
 board/mscc/servalt/servalt.c | 2 +-
 6 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/board/mscc/common/spi.c b/board/mscc/common/spi.c
index 45b9649336db..cb43ad6811e7 100644
--- a/board/mscc/common/spi.c
+++ b/board/mscc/common/spi.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Microsemi Coprporation
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <spi.h>
 #include <linux/bitops.h>
diff --git a/board/mscc/jr2/jr2.c b/board/mscc/jr2/jr2.c
index 84b95be648d7..acaeb4680223 100644
--- a/board/mscc/jr2/jr2.c
+++ b/board/mscc/jr2/jr2.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/board/mscc/luton/luton.c b/board/mscc/luton/luton.c
index 48170b3aa12d..f9ea26ebc5c6 100644
--- a/board/mscc/luton/luton.c
+++ b/board/mscc/luton/luton.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/mscc/ocelot/ocelot.c b/board/mscc/ocelot/ocelot.c
index d69db04de664..4cec25b3976c 100644
--- a/board/mscc/ocelot/ocelot.c
+++ b/board/mscc/ocelot/ocelot.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/mscc/serval/serval.c b/board/mscc/serval/serval.c
index 99d5f5be657e..951c24dd286b 100644
--- a/board/mscc/serval/serval.c
+++ b/board/mscc/serval/serval.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/mscc/servalt/servalt.c b/board/mscc/servalt/servalt.c
index 49993168c237..9055b73ada27 100644
--- a/board/mscc/servalt/servalt.c
+++ b/board/mscc/servalt/servalt.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <asm/global_data.h>
-- 
2.34.1

