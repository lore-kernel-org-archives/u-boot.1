Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A69C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4F9874F0;
	Sat, 18 Nov 2023 22:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xa3o8u1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E5F874D5; Sat, 18 Nov 2023 22:06:13 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40305870F9
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a94c550cc8so109837239f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341561; x=1700946361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK388huLgge56Hj7hiy5i3x6lUCDWRrEdn3EMHObIwM=;
 b=Xa3o8u1PQLm6S+a+cxU//5sylfjcF6+pw/RRsUQ6E7tQyXW00YNs8dglEhmszmtync
 Ug92/SAGM50IVl58KEbvr8LqXM2JLmRSQ3B/I+Sz/Uv/yJKp7yvJsmKrJ7yAHocVPgUd
 3h+LKr8YlyA5JTs8M+plMgP5y7cmEb9KwxEb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341561; x=1700946361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK388huLgge56Hj7hiy5i3x6lUCDWRrEdn3EMHObIwM=;
 b=Kwl1xXxPjlIoMV+LnMu2hbYWHdCbGi1L1Bl35WVvALkXpdo2ffeWHwLaUJ7jnuHP1v
 KITmJsJZVLXOwJ5PkEv9lhuNaknjeNzBgtXQAFkg7E4rJ9NOKmeYyA8EBYFz7ltizw3m
 KJpXnJUeyCyS+lFVMD55SOyJYJWv4J7+5jGnR9tm5SnoCtN3tMKgU06jx3GiLQNj2ebm
 UaRu74OptJGn/G2WFX00xlJOpo7WmMMyeny0kv9hXbScinoTw7iSdThrSA9nhNaOp2L6
 6zzUxWrW0pgqYnK15Lt/onG76o/mBMFaZ4biuTEDi+eWwhI8IpZX/pfQ+lfc3ZBc/d8R
 b0Sg==
X-Gm-Message-State: AOJu0YyRXsZKEbyrCWE4tnsyQk9W9ELL+982IdlcxNyHwjxf6klHtTK8
 yPEm/YMCSr8WBOd+jb3s7ylfaAT3hF5ujaqTMZmwTw==
X-Google-Smtp-Source: AGHT+IEkhc/95cMpq/rzINWvtHS3iI/ZVWwvhLq80JOEEQo267wFAfgOwewAa3jpcjaA5nuVnsd1Fw==
X-Received: by 2002:a6b:c94d:0:b0:7b0:2664:ba1f with SMTP id
 z74-20020a6bc94d000000b007b02664ba1fmr3337403iof.2.1700341560785; 
 Sat, 18 Nov 2023 13:06:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 06/32] bootm: Drop arguments from bootm_start()
Date: Sat, 18 Nov 2023 14:04:54 -0700
Message-ID: <20231118210547.577026-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

This function does not use its arguments. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 boot/bootm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..fda97706fc26 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -69,8 +69,7 @@ static void boot_start_lmb(struct bootm_headers *images)
 static inline void boot_start_lmb(struct bootm_headers *images) { }
 #endif
 
-static int bootm_start(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
+static int bootm_start(void)
 {
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
@@ -783,7 +782,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * any error.
 	 */
 	if (states & BOOTM_STATE_START)
-		ret = bootm_start(cmdtp, flag, argc, argv);
+		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
 		ret = bootm_pre_load(cmdtp, flag, argc, argv);
-- 
2.43.0.rc0.421.g78406f8d94-goog

