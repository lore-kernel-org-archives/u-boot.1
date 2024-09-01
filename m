Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF8AC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3C288B93;
	Mon,  2 Sep 2024 00:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Deln1dgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2C788B16; Mon,  2 Sep 2024 00:26:58 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE25D88A12
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82a151ac935so146990739f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229614; x=1725834414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBqltt1LTkU8Dnt4ku4ZAQW81rymDm99eNFCllqQMqs=;
 b=Deln1dgmBxw796HPqITknyQHxKfPk1Tasx/cw7Zz+NRH+gAAFu9ZnSGhIJQpoTvZPT
 eT+waMMb0LwuDg+t01DNrgOlA47MHIcPhK8uTQd0eu2GhdtQZsjHsSJumYRq26yxditS
 oknJSBks9+mEoj8W5S2RStGA2t0okkRqWdsaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229614; x=1725834414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBqltt1LTkU8Dnt4ku4ZAQW81rymDm99eNFCllqQMqs=;
 b=Qo/T+dQiFjledaaUlRVpKrPXWsD82AWLkmP5LO4EjkLteuyAoJ/9bH6EER0+N8140a
 67hUBP1SG+bSInUX5SeQhEyVLPfrh0NiHKKDGdIF3QgxcXpprodlRVa6pUs0TgDLgXv2
 FRiQ621qPRP+tXVGPC+tDgYxFi/5ytaQl2re/oLfCuv3SDKz8BBU2HU6qXp2Go7oqpwM
 Uv16jTQvR+BQ3y6bQJMnLcSUswdzqxB1Bs/w1KnNugc0yuMy/ei6hj5oeIo5nl1BOuHb
 IA6FmyHQMahcuyBR5e2oy0KYjhzO+/yW9m3/LMbq2F1byXzoUP51TenY3gNc5fcNWwi7
 Jssg==
X-Gm-Message-State: AOJu0Ywl3S3hDE6JTw9Jm+p/pqxAgVy8t4FTo3SLtZBOq0NsZep2D2x4
 2XelgxE8qQPbaIsNJo99XMSsKpq1gxlt3HVg7098gw6c0/+C14x+7yb9YRdVFyqjXhTvPYy4Uho
 =
X-Google-Smtp-Source: AGHT+IEelqp2M3u8J9BIJVbJ1GU6uiFZZMaDBiJiQoFGsaBA5jtbNFfQFBFhkZ6k2ORtLnjiRLEufA==
X-Received: by 2002:a05:6602:3cc:b0:81f:8920:e770 with SMTP id
 ca18e2360f4ac-82a37505184mr594287939f.8.1725229614279; 
 Sun, 01 Sep 2024 15:26:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/23] log: Add a new log category for the console
Date: Sun,  1 Sep 2024 16:26:18 -0600
Message-Id: <20240901222634.460873-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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
index 52d6df8150f..0f00f3d8d5b 100644
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
index 69dcb339543..7c25bf0b081 100644
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

