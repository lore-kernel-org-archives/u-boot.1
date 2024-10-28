Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6972D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E4889125;
	Mon, 28 Oct 2024 13:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yg/wmvUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B30890CA; Mon, 28 Oct 2024 13:42:00 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5340389099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso4926226a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119317; x=1730724117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1UeZ2QTINTDy9ZPZRiweMfE+yorYgPMHqTtNFRYwpA=;
 b=Yg/wmvUTVnxIubtcwxWBFV6t33Iv8rexuxFFsSJMHQkoTAYrex191uQe56GHLfX4z/
 aiDQ8kv2fiYGJbAZNWnmLg6nCoXu3+DyaWe7thejJFTPxSxpaTfedkBDUf69XdHAjiwx
 zgd3uZegMko8ayQvc1UVfZpEtLh9MHwKFL6G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119317; x=1730724117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1UeZ2QTINTDy9ZPZRiweMfE+yorYgPMHqTtNFRYwpA=;
 b=baKXQXIQv3Wj3YP+WaPGLg4r96rcikjMFSgKqsm5R0anpPPOj3EMqR2xUK4w+Om8y3
 hHpCvhsL4Fv1AQcyPMAX1gXaD0erMri8ehWJ/9iDkmQ0NSBbVHluBYCyycShcbyAnvt7
 q7jmQDBdQQA1K/UX2fXWDbmElNqs+vaI7QyeZIR+0BwgLBADufekOR3pe+yUIlj4pMrk
 fRJ4LzCSqR5covjvFIMYYUVBXbM6nMJuR3VegLlkbRtNgyIDIvr9qDk2l+GjrHRZjDy7
 YckLs9TlNLgLtRq3T3RAoHEP3sUCeDWb4NB8V7Kh6xo2bCvPARHRdflCQRZ7AuqHk2Ez
 Y2hg==
X-Gm-Message-State: AOJu0YyRUPnPQUMX5sEKjPQrcnuYscRe86Ecs3H++BpWgcT8A5V9o6MD
 67Ed/RdwQyiGG60xv922WLz67+9lhD/JkdPFtEO99egRWV85ofEJZwSeN5Ld49Jdf5jdJgRjZf+
 wHQ==
X-Google-Smtp-Source: AGHT+IF/V7RMm8yxpODApL0SCkeMhko+JEJ/y495CwDgZkjzzE9oBNofjpR9bxT7vmtOc4Qb0Rbsjw==
X-Received: by 2002:a17:906:6a1d:b0:a9a:18ee:5106 with SMTP id
 a640c23a62f3a-a9de61e95a5mr707126466b.65.1730119317352; 
 Mon, 28 Oct 2024 05:41:57 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/21] test: Move str_ut test into lib
Date: Mon, 28 Oct 2024 13:41:18 +0100
Message-ID: <20241028124130.32072-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, to match (most of) its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile                | 1 -
 test/lib/Makefile            | 1 +
 test/{str_ut.c => lib/str.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{str_ut.c => lib/str.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 9f19bfa472b..220a249c397 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
diff --git a/test/lib/Makefile b/test/lib/Makefile
index ce22780eed8..be20bbc047f 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -17,6 +17,7 @@ obj-y += lmb.o
 obj-y += longjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += str.o
 obj-y += string.o
 obj-y += strlcat.o
 obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
diff --git a/test/str_ut.c b/test/lib/str.c
similarity index 100%
rename from test/str_ut.c
rename to test/lib/str.c
-- 
2.43.0

