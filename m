Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275CAC4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6DB87BA5;
	Thu, 14 Dec 2023 19:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DniSkBEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877C187B8B; Thu, 14 Dec 2023 19:17:15 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5023287B5C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d226f51f71so81973027b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577831; x=1703182631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOKbNvVU3dtmS2xPD3NSufBN0eE0LnHacIu3eak5QqQ=;
 b=DniSkBEuQOs6HZ3WwvaM3WJm3ZnQ2KKLDxflD3LPyvUXY3I5uS2lvQJ27jqvUiQu6M
 CZewCgqtjph+RQm5Mdk8CgVYEdIDcE5YPIR8buAEXav2Ln9w0ihU8b1A1nmcP9rwzfp0
 xj+4ZdaDJGQmUy2vaVBtKmXHf2C0XCPxiKctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577831; x=1703182631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOKbNvVU3dtmS2xPD3NSufBN0eE0LnHacIu3eak5QqQ=;
 b=LLRf4GFYMcQ9Doq19zRqz3j/r4iyw2/vL1ymIxyUBCsDj7rQSiBacBmtDgKrecERPh
 sbXSGKMGhe4qCtJ7GGw2PnxT+pR5k5m6mS8np3YygHgOPrc6+qx2JSgluXiT6NPtQO0B
 fxM3ju/dWMuSwkkLZfUPUN7bk0xdBo0RPuRKH5rm41VH8ei/kAWdkaZL/Ci9ZG1y2jm/
 X9AbU7QpYiWObpFBW+wMu1jH0HMTYksLNRN5C95gBJp4n1yOGhWmLgA/DItOE5rUWLlX
 3C1NzD5gnw9KJ7BbUQtoObCZzOaIKkTtCKUjSle4fw5X1GC7FdaNREnVquoJGp0BeMPL
 SsSg==
X-Gm-Message-State: AOJu0YzqjbGa1F+u+9czPWjrY6qBedxAmFhh8ncV2NMbvMsk9YzPtiXI
 lPi3tBaXq2Buu0gKCBPxnIqI9HmtSjt4HyTK4dA=
X-Google-Smtp-Source: AGHT+IHjW1C7wHDKPqtXWLf5JEYTnKCOQHSEJlT9gGmjvO05ucpoAfe9H9wcigJtq/5mImRaDzekLw==
X-Received: by 2002:a81:6c0e:0:b0:5e1:aa35:2c8b with SMTP id
 h14-20020a816c0e000000b005e1aa352c8bmr5272463ywc.12.1702577831184; 
 Thu, 14 Dec 2023 10:17:11 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 14/16] display_options: Clean up headers
Date: Thu, 14 Dec 2023 13:16:56 -0500
Message-Id: <20231214181658.3359902-14-trini@konsulko.com>
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

In include/display_options.h we cannot include ourself, but do need
<linux/types.h> directly. Then in lib/display_options.c we further clean
the list to remove common.h.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/display_options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

