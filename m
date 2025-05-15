Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B0C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D4D82B53;
	Fri, 16 May 2025 01:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uVNwIeY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E444B82AE9; Fri, 16 May 2025 01:42:23 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D571982AFC
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72ec926e828so613866a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352540; x=1747957340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdATJYUNvpWn4rQmvzDODSwXXPpRSFyYqUewdx1Y0TU=;
 b=uVNwIeY+SbTcFLgN8BPahtOFmyloumxe1NcB8OP7EaNat+iHiiD4i480EiRKG0/tna
 mV10ZB9uQHFeLLaGtMKzIfav3IFGDxf2ee1JTTuADMMBH61P49wQ5KiIOT4lEuQ6Vmy2
 LdSxUJc9/siAiW5pp5WPsx/TqaXDoWCG5JGUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352540; x=1747957340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdATJYUNvpWn4rQmvzDODSwXXPpRSFyYqUewdx1Y0TU=;
 b=ML+3hzJREksvg0mAkiLRpCyMErjWIs4+MotBvS77TH7bZnZOaT7jmKMdcNcXIEsfAQ
 xTDTt+0ujSNmjSY+X6ywUfFikIQVT7u/VU+GZzFb4ISSGpvESi4tHi+HKn6FtHzgYDNw
 ze4RKJEOhbn6m7iv4IbjRzR/lI+6L9OPpBsUh/fLKWu1Ky4CG24UmBCs8QIdDqdUGTUA
 bncHh7mN1kJBJpC7TZB1MQke9ttmGpQJoaHthPypi+B55Sb78wRSN561D0LLCjLgIK/7
 ugzJQavZBM6DlTxTy6zr6jiaiyC9yrvpJjrmqwlTQ9XC/GYkYYK+mwVVrK5jJWBf6CBS
 XAGA==
X-Gm-Message-State: AOJu0YwJPia/zM5GjYLX7xtQN+QKhlO4pfcCG9Zrvt6NJ76UIb7WZHtN
 UAtgEAPU4hkVq114Htt36sy2eTLu/ahJOQEL4pckzJivTqkacFcaeavjSwEBQBxcXJVmD56Jbss
 wQ1UDtik=
X-Gm-Gg: ASbGncuIznLa5Dp77t9eqKOoj2aMq7K+R/G62F0rv7EGGCj4XUW1rOpmvOyrkzYtvcZ
 KzhfL5cOERf9G8ZB2J3OhCoEQYii/42PBI4YJ1om10vXYw1fxmt+GDlHV7Vhh/v2R02z9bt+ZG/
 guFIY76fuXIRR8JqWgnwdBvMIY7ufcxsm27n4IrPsdqG093prKCp+OF2RE1SQXwRPh5xXIjIrZf
 zaJM1cyu2/J3wXX+iH2A6OiM0X8PWEBcqJeZX7atn6bi9xhc6ZV9Hs0aGzR4+aNmD3a6sFTiOkC
 erNKK9fr/iudVzcIAR85m/08oBaNVSMJa/SOuZGpF6CfNV/Fxy/Hu08OY4yS/CDBIY+vVVdiEZ0
 k357cpazNeu9Stxc=
X-Google-Smtp-Source: AGHT+IEIfyumO2Bu5A904idCUZEseeDgrqb3MidhaawXLBC+SYvD9NC84iE2qDf3dKiVTutR071fhQ==
X-Received: by 2002:a05:6830:6284:b0:72b:8889:8226 with SMTP id
 46e09a7af769-734f987ccefmr387412a34.7.1747352540668; 
 Thu, 15 May 2025 16:42:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/22] net: Include env.h in pcap.c
Date: Thu, 15 May 2025 17:31:48 -0600
Message-ID: <20250515234154.1859366-20-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file uses the environment but does not include the header file.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 net/pcap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/pcap.c b/net/pcap.c
index c959e3e4e511..d1d6f705cda0 100644
--- a/net/pcap.c
+++ b/net/pcap.c
@@ -3,6 +3,7 @@
  * Copyright 2019 Ramon Fried <rfried.dev@gmail.com>
  */
 
+#include <env.h>
 #include <net.h>
 #include <net/pcap.h>
 #include <time.h>
-- 
2.43.0

