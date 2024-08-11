Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5798DC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8897988A02;
	Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hVmv/cnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34820889F8; Sun, 11 Aug 2024 16:52:41 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF95884C3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-396cc82f6d7so12024535ab.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387958; x=1723992758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=hVmv/cnGee5sER6GThOR5g8ObYvFcxAvDSVm8f3yzJENZdkJ30KOzUPp+O9IWhF9lF
 xTLpKojh2klGVebWb5iU7WcUOhpI079aO7woNla206g6hezfPSMeh6OwyDmT/202gHGP
 +BJX8sb3fd5EmoxlgIbikoflYH7FWVmB3mhIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387958; x=1723992758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHucv9SvIxlH9ZUiFfnyDS+E5Bs/v1DYrZK8hA8K99E=;
 b=ahf4mSeMsTfwkIAXiDulJLutatKhvhOsd7Qu/oROFZexfEj6MzIkpkEiPBdUv4DpJi
 vNtx5cA4U4l1HBHNur+RniqTJSO6Ixt5/G9B/vK/7sbzML2JplhuwplIpvl4Z0gOVzPA
 8wE9tigcShaYmU8AxZHqhO0b2Ko3RgtltyeqzF8vPL//3e/xQS4wjDyuBpCSapDIjkxL
 90I/rvM+waxN2gldXQKVESrSMcyMGQfNAt2Y8IsWtV5RjIWab2O/mrTE3nhTgiUVmvK8
 umCRF6VMpKY1Dr5gkr5QFa8efvzCKb4f4OqZzgz/4buctO2cc/D46uyiAb6OwpsZoqDz
 l/AQ==
X-Gm-Message-State: AOJu0YzxfP9HqtY1plw75GIdTRlY/+51OSks1LckdOBzUviNplgconFX
 CGyha5d6h47SCV9PctRb/QaKGBJLuIdeNj36zlIQFKffVcqbx5C87zTr1fjz3M+lX4gKVuCt0vM
 =
X-Google-Smtp-Source: AGHT+IEPewvsNDguI1w/o3LJFLgsQqCPeI07CYLxugcnuTV5DCZmR9p+2LK7wnmL7MtYmjCMq01/Og==
X-Received: by 2002:a05:6e02:17c8:b0:399:df91:bf57 with SMTP id
 e9e14a558f8ab-39bc7050af6mr75595945ab.0.1723387957687; 
 Sun, 11 Aug 2024 07:52:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/40] log: Add a new log category for the console
Date: Sun, 11 Aug 2024 08:51:37 -0600
Message-Id: <20240811145209.4191404-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

