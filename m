Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F50C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E13780BAD;
	Fri,  7 Feb 2025 19:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AdCLNSGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5048980BA8; Fri,  7 Feb 2025 19:32:07 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5437801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e06e5d11so68301139f.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953123; x=1739557923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebDDHtMFbJdJjjvQFq+1og1/A7rlxFajsmtmG3jG7wU=;
 b=AdCLNSGrOuH74u2CzL6WM1BLaF2oVwam/a1mkw/BGcibSaztKHUQmsN6wIW0b9wo/4
 qmuD2YWvFck9KcbYLL4T0HgDIo3taL8mgZYkZ40h49VZHVrwu0JSoqEU/anU99En3yjx
 cdFJM+8foh73gpEsTs0rTe3nbx2K1fr3PAs1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953123; x=1739557923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebDDHtMFbJdJjjvQFq+1og1/A7rlxFajsmtmG3jG7wU=;
 b=uUBfSvrbFdo2e5DxdJeeFUZR3GrHyAznh1+Rbb3Yj4SBH9LLtDH5sV9Hifw+U3ggCT
 s0RM2nxTGwz/LfnF2Gkg65vpI3TXLP//OtRuMwXAkfmWXvSTzieYQysaoOS3gLb6pzjD
 oMw8WFgQBmssER9A5GBmN9R32fbcV4OZ7VrAHP5ymdKqA3cKt6AVyaNxXcPv1KReR/em
 0S43nficGQmNCjD2TRO/vwno5hW3iR/fMFshj5HkbV+x52heJyw2xgXW/N+SHGMRXgsN
 1bc/9lVLTwrTqdHmTY3t20/YhsQiW5Lard3LRcFxwsx2Tf4WLQoqvifUfkIs2kzJjuhz
 Gp7Q==
X-Gm-Message-State: AOJu0Yy8/kjTHaHQ3D9849aCj3itD3ccOhNig+zGMDlklj3+2ewNljLB
 R09Udwcs6OBlMMCQ6GdmyNKIIU4NvzPatShXoltIgVMS2rTuGZ8f1YGNo4zRPmv+l6eooxmXxAw
 =
X-Gm-Gg: ASbGncs0JppDTCSXX01gIHam8xBxHGbVb4waW9lzpunxPKdP9UiQLpqwIycvNa1CjUe
 esDl4ph6PqUVY4SzwrJiqqaZYLo1XGLm601IbAGa4F6Xx/F1fk9gRrft0HGAM27ggPRx9VGid9I
 dYoR6dPeM4wGdlGsnINZMvZSI446CAicOq2AsiZrzbCXq1DBQTUQWBad927DvXjC+YqUSMTTZcN
 0/pLpzMCcOwbe8FGjosEmA1k6ArELmNHzQUgCTGip7AZHjubkubEUPiyk3vHybxKIdBRH1jTNh7
 3IjKH410o6tO3DACYY7oKWXPqU1jAwI3asC4coS7rpsgot11crSI
X-Google-Smtp-Source: AGHT+IHjN5zRpuGhkD43RCj71UL0MY9FrBOxholjLfei/BTZQT88I81SfzXRw904PvjXqUpZwP3VNw==
X-Received: by 2002:a05:6602:4008:b0:851:f176:9827 with SMTP id
 ca18e2360f4ac-854fd89ba0bmr501010839f.5.1738953122704; 
 Fri, 07 Feb 2025 10:32:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/29] test: Update fdt_overlay to do init from tests
Date: Fri,  7 Feb 2025 11:30:46 -0700
Message-ID: <20250207183121.117663-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Rather than having an init function and then running the tests, create a
test-init function to do it. This will allow us to get rid of the
command function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/fdt_overlay.h            | 4 ++++
 test/fdt_overlay/cmd_ut_fdt_overlay.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/test/fdt_overlay.h b/include/test/fdt_overlay.h
index 34e8020a496..251ad0ec97a 100644
--- a/include/test/fdt_overlay.h
+++ b/include/test/fdt_overlay.h
@@ -12,4 +12,8 @@
 /* Declare a new FDT-overlay test */
 #define FDT_OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fdt_overlay)
 
+/* Declare init for FDT-overlay test */
+#define FDT_OVERLAY_TEST_INIT(_name, _flags)		\
+	UNIT_TEST_INIT(_name, _flags, fdt_overlay)
+
 #endif /* __TEST_OVERLAY_H__ */
diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index ac8a3b2be23..c716c6bd6b0 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -81,6 +81,7 @@ static int fdt_overlay_init(struct unit_test_state *uts)
 
 	return 0;
 }
+FDT_OVERLAY_TEST_INIT(fdt_overlay_init, 0);
 
 static int fdt_getprop_str(void *fdt, const char *path, const char *name,
 			   const char **out)
@@ -243,7 +244,6 @@ int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
 	int ret = -ENOMEM;
 
-	ut_assertok(fdt_overlay_init(uts));
 	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
 			      n_ents, argc, argv);
 
-- 
2.43.0

