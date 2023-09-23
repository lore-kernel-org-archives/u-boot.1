Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E84CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0B086AE6;
	Sat, 23 Sep 2023 21:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z6pJoaGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14D88684C; Sat, 23 Sep 2023 21:44:35 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047FE868D8
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3512740906dso4434795ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498271; x=1696103071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdEtMWHL6ImEIXlcWBghJiJSKhqdfFeRRW6MjOyWTSo=;
 b=Z6pJoaGDqt5V2/ImF/1BvVU6GHg9LcLAUPaR9I3+6+sC3SCwViG4DrTWCyVmuStnV5
 qa4Wogq39krErkPtfIvmH7m7AAA77vCUihZqZoLrPVFs4GBS5THiqdF3Jxd1bMXfJ+yn
 WesY/KEQIomnyyJBbXDVO9WAxjTxuEXHNEc9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498271; x=1696103071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdEtMWHL6ImEIXlcWBghJiJSKhqdfFeRRW6MjOyWTSo=;
 b=l3kOjPFzT333yFZg2o9mAybXxJmcmhLJNvp2L5vOZdMLM2kr+twRopNRoVOFCP5GwE
 8quNmkFuqZjAjYckKQ2tpUba5ayb+1XhWMuJf6jHHqRZV5rRQdyCfPJcwqLzGvNVsl/Q
 EYU5/EKXYNvWtHINSbL0O2CTzv+ebi2K9x6CGTGTEdxC88RPs6xJ8pVw+UMtOHA6KvyR
 8/m/LaMymBwqM32AkeEM4a0YlqnqNmM0fps03GjrSQMjoQP0WOli6/PYLLqmt/RnLPQD
 S4hG0cwR2eNzQiASWRyKTk86dqEM4l9GLCOghuol00qBbt+aVxjM0nQAEyC0DRDlUjrE
 8tQg==
X-Gm-Message-State: AOJu0Yxnkoq01UgY+qmAMthwg5QMW/zRANvZx2Q3HBPvqJ2L7+OHe+VY
 LREU2yGuHlt4Sh53XKu8cNyEJ6zGvV47KmLLP3s=
X-Google-Smtp-Source: AGHT+IFryPsBncK0xmIY4itGZT2IwdwM3qeQAHEPxbkNe0coXUj8JQntfRSwoVMO2ol6sCHlWxTkXQ==
X-Received: by 2002:a05:6e02:1b89:b0:345:3378:4251 with SMTP id
 h9-20020a056e021b8900b0034533784251mr4199687ili.23.1695498271649; 
 Sat, 23 Sep 2023 12:44:31 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/27] moveconfig: Avoid deprecation warning for setDaemon
Date: Sat, 23 Sep 2023 13:43:51 -0600
Message-ID: <20230923194424.1739224-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Use the recommended new way of setting a thread to be a daemon.

This avoids a warning:

   DeprecationWarning: setDaemon() is deprecated, set the daemon attribute
      instead

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 880a5594be05..2f7dee88c7ee 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -2029,7 +2029,7 @@ doc/develop/moveconfig.rst for documentation.'''
     config_db = {}
     db_queue = queue.Queue()
     t = DatabaseThread(config_db, db_queue)
-    t.setDaemon(True)
+    t.daemon = True
     t.start()
 
     check_clean_directory()
-- 
2.42.0.515.g380fc7ccd1-goog

