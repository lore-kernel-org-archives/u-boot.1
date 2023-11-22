Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3FC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC708760E;
	Wed, 22 Nov 2023 14:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KBkNGSJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4A486F42; Wed, 22 Nov 2023 14:12:10 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA042875F2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-da7ea62e76cso6670349276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658723; x=1701263523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhuia0tBC2GLY2t6pyxGI1aa5S3Y3VJAmqfPQNaJW0E=;
 b=KBkNGSJ6PAQcYc8qCZhJBKpgyUXMairJSPrNJoKTu8jv3ohTn1D2KnSegFykww+yx1
 cfiJSxDDZ5wok2P6Rr4v12bxKKwG3JdWoeBUvBsxCwPnyQBVYyYi8I14RghMWbUsjQtr
 lkaQLOvjFxcEe1xJnKjfHaaEOE2EEG1OZlN9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658723; x=1701263523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhuia0tBC2GLY2t6pyxGI1aa5S3Y3VJAmqfPQNaJW0E=;
 b=X8JrrnFErpad/UPsl+rnxAAXvmkvPqayANvEjxPY2t/VOTQAl0+BeiFCd9yWVQt/6L
 K5xxot0jrlwAVBeY53DTGIeTz9KKWtQoD3PHvtrHIfreRN/EHHKrDIa+pTCGbj7/9b7a
 LNIdLxmdFXwi5fbYYx3WNotGgaZVaSBWGJJDf9p35LFATJqRAb5giKV0lqMuIAl6Z8sE
 jeVOfv5TFuPPvN2TO28lv3RH7TBddRW31LJejkqzEjEm298VE55AkwcBKj/9EFyHhz5i
 IpyWKgrgyLLrx3lz6PQgdmkFismz5+lUWNFxrtRagwGVMRns63rvdh0DSi0zwCeIcwL4
 2pXQ==
X-Gm-Message-State: AOJu0Yx6srd5vG8daR1dvd1PrqV+SX1OlF1v9tubtLH5AmkUFCibO+Wz
 EjEOuEW45k4ovWsgwVEFS7JRy/Z5q3Ws88niULe8eA==
X-Google-Smtp-Source: AGHT+IEJ685sPRB3RIx9k0m0BvOv5t83S6wS4UynxGCK4i2ur/u5ZcLX2CExlc1RfX0WrJVyy/uqpw==
X-Received: by 2002:a25:3d1:0:b0:da0:3684:cad9 with SMTP id
 200-20020a2503d1000000b00da03684cad9mr1742357ybd.59.1700658723257; 
 Wed, 22 Nov 2023 05:12:03 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.12.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:12:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 09/11] display_options: Clean up headers
Date: Wed, 22 Nov 2023 08:11:52 -0500
Message-Id: <20231122131154.2444690-9-trini@konsulko.com>
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

In include/display_options.h we cannot include ourself, but do need
<linux/types.h> directly. Then in lib/display_options.c we further clean
the list to remove common.h.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/display_options.h | 3 ++-
 lib/display_options.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/display_options.h b/include/display_options.h
index 85dacbc75902..66e596077370 100644
--- a/include/display_options.h
+++ b/include/display_options.h
@@ -9,6 +9,8 @@
 #ifndef __DISPLAY_OPTIONS_H
 #define __DISPLAY_OPTIONS_H
 
+#include <linux/types.h>
+
 /**
  * print_size() - Print a size with a suffix
  *
@@ -19,7 +21,6 @@
  * @size:	Size to print
  * @suffix	String to print after the size
  */
-#include <display_options.h>
 void print_size(uint64_t size, const char *suffix);
 
 /**
diff --git a/lib/display_options.c b/lib/display_options.c
index 80def5201f96..d6b93553dcb5 100644
--- a/lib/display_options.c
+++ b/lib/display_options.c
@@ -4,14 +4,15 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <compiler.h>
 #include <console.h>
 #include <display_options.h>
 #include <div64.h>
 #include <version_string.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
+#include <vsprintf.h>
 
 char *display_options_get_banner_priv(bool newlines, const char *build_tag,
 				      char *buf, int size)
-- 
2.34.1

