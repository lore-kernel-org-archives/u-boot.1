Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB7BC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E967888B59;
	Thu, 15 Aug 2024 22:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DxhUrGJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD9E88B5D; Thu, 15 Aug 2024 22:25:57 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C6388B5A
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39c2f653efcso4567695ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753548; x=1724358348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=DxhUrGJUbCpZdNxaqMGqm7B6I3uyeKn5GhkBIK5GHsMzGNKh8KI44YmvgN9DliU5RC
 LlGMhXA0jfA0+kxtwR9Wo/0J9VuPxks68BXhoVqjrEjg7p3k08l2xhRrFUwqOQ0fPYv+
 EDUmgtUep0MllGluxRpnY594FRiEqk10r70zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753548; x=1724358348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=kLdX8kj3FmwrnWdslrPnZvVBQLJjFp6T9EfqiM28IAm7sqMBo+dbGmphmXTKvlwrxW
 n2oFTxd4AubMEAhLGJQobwUz1aYxrdE7ZCgasNDz1ty6CyFuG+lXrKV/0SDhk5bB69Tg
 08OiO/8IyJOCcJX4rCtk+oRnu6oww9jS60zedJvJUkq3sgXARxiB7JvxaRjDbb9LkYuI
 YOixkVCTGKZggVRU7RK/YkGK1rCG6C2qljrKKim1LdRc0bvacJfNhoXxgQz/rx46nu2M
 xzcTGjLJ8/LM2OhIwEsPo64IKq5sKqhdljh8HdBfAwRSKeiASlyY2sH8+td3Y5+TbQWy
 h+Ow==
X-Gm-Message-State: AOJu0YyWCVPJEbxtY+fOVWn5gVBgUv8fkMR1vtx4sO2+Sabmu+30Wi1q
 5HQ7TgVn0WnEQqxN2jrtZj+pD3SpqMcs9m6c2l45OWzuDF/77Bad0DKvB92PULvZRpRI+swri9+
 6EA==
X-Google-Smtp-Source: AGHT+IGy4SlnQTr3d85DC1pM5GYB0Mix7ho8ZQ1pGg371P5COlSDMQr/xI7jg6k7wmK+C6og/cbWtw==
X-Received: by 2002:a05:6e02:16cf:b0:39a:eb26:45f8 with SMTP id
 e9e14a558f8ab-39d26d5fbe5mr9357365ab.20.1723753548459; 
 Thu, 15 Aug 2024 13:25:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/24] log: Add a new log category for the console
Date: Thu, 15 Aug 2024 14:25:19 -0600
Message-Id: <20240815202535.767869-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

Add a new category which covers the console, including the stdio
drivers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/console.c | 2 ++
 common/log.c     | 1 +
 include/log.h    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/common/console.c b/common/console.c
index 63f78004fdb..034942ec4a9 100644
--- a/common/console.c
+++ b/common/console.c
@@ -4,6 +4,8 @@
  * Paolo Scaffardi, AIRVENT SAM s.p.a - RIMINI(ITALY), arsenio@tin.it
  */
 
+#define LOG_CATEGORY	LOGC_CONSOLE
+
 #include <console.h>
 #include <debug_uart.h>
 #include <display_options.h>
diff --git a/common/log.c b/common/log.c
index dfee250b158..b83a6618900 100644
--- a/common/log.c
+++ b/common/log.c
@@ -31,6 +31,7 @@ static const char *const log_cat_name[] = {
 	"event",
 	"fs",
 	"expo",
+	"console",
 };
 
 _Static_assert(ARRAY_SIZE(log_cat_name) == LOGC_COUNT - LOGC_NONE,
diff --git a/include/log.h b/include/log.h
index fc0d5984472..2b86c7da3d4 100644
--- a/include/log.h
+++ b/include/log.h
@@ -104,6 +104,8 @@ enum log_category_t {
 	LOGC_FS,
 	/** @LOGC_EXPO: Related to expo handling */
 	LOGC_EXPO,
+	/** @LOGC_CONSOLE: Related to the console and stdio */
+	LOGC_CONSOLE,
 	/** @LOGC_COUNT: Number of log categories */
 	LOGC_COUNT,
 	/** @LOGC_END: Sentinel value for lists of log categories */
-- 
2.34.1

