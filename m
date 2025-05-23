Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E7C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979D4835B3;
	Sat, 24 May 2025 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c17P122n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0CEC8334D; Sat, 24 May 2025 00:59:14 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADB883409
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-231e98e46c0so3156655ad.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041151; x=1748645951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/yOBH+e+9FDQdh7TZ6MraihHp2NF8jjzjfkZBIhC8k=;
 b=c17P122nOcP9PPqVM/zKrNxb6tY4kRS1OfzIGXNoY5M/irEjLDCXFqtUvhZlBbkOfv
 R17Omq53dChNBEeCMa82z9ox+WXgYED8FyPvo368rKGHt8S99heVEHiZEHpK5/3ZiZWh
 7OqnO1Spk7DIBBkktVmwzsqgz1q+aXyFpzY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041151; x=1748645951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/yOBH+e+9FDQdh7TZ6MraihHp2NF8jjzjfkZBIhC8k=;
 b=feHYr90GcUjc3zt/hoTIIu4LXS/Tp38a7f7DVZy+/WO9ZvF0YTlLkaUZgC/RtWz2B+
 sSnJRv81IFAPb0oNN4xG0Fn+QDReRRCiKdrMLE9AgPfosOzmGr/FSzIa/NpZ8kImdxVV
 Y7p8oAY/4hzoGgn3CuUbVuSUjFo/SygrBABr7m9JXY7isSi7a4n3N4EvSgqSUpJQLOXr
 3V2iZvVdMh/3XjB48Keo3pC4Wz9MhNDVbcRgyJF+oaavfK2/teU5Zu/DRd5UtOHJ++U0
 SFHhAwmzlz6azZkPkT2QXfRmYO1C1E64ot2mqTScwlnS+R1wZUnFojqYBWerEb3vZlrW
 9qLw==
X-Gm-Message-State: AOJu0YxXGRH6uKt544aLW+2dkq38JVZgK0FBvnZJY7v5hDUSmrremWJY
 Zx5hn1MgWT4n9GEgqX1rgJSKECpfqXafDBGQ3IGVjkq6lpdwTX9IZY43UvinC9Bec8ZedUroqmn
 mtYs=
X-Gm-Gg: ASbGncucMQFsKKeTZSs6oA7MVqEX1BRujoBa7Vep9hwBg7rnK2fjTrSvwtTu0q440CG
 PR1KSP2taz+8v3COtiUZ/TOVm6Fm+aS77EpCe7Lv7JGV8oEFrvHd3TFZdkiz8JiUif/L/u6N0fq
 mBE7Ske4qeCXJsRixVTGhKNlXGkduQK5fW/5Xa+IzUFfqtET1eG59i/q2SHL2mv+upPw2Yx2LZ/
 5q09tQNpcb0OYndpt+3Qmp7YjMoXnKoYpMXI6HkWsbu7KhiQOlqahX8/cnCLfalfycg+gdN1ty1
 KX0FRXU/QvFaLFqMkfFtL7rU9aJ7w8sFV209HXk/umjZGm4SH290Nf1pdzp7hrC/2tmRqth7/+3
 9L5iXquMxmaiIgMg=
X-Google-Smtp-Source: AGHT+IFbQQuwpcc8XASC9EatoxJ6ZvvgL6WtkiX9izui09ZAfWXwrGD/5GlSv7IYz3UKHvJm8JkMbA==
X-Received: by 2002:a17:903:230d:b0:231:e331:b7c9 with SMTP id
 d9443c01a7336-23414f33299mr19588725ad.10.1748041150636; 
 Fri, 23 May 2025 15:59:10 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2340c505efbsm6426895ad.129.2025.05.23.15.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:10 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 15/28] pstore: Add pstore address from coreboot tables
Date: Fri, 23 May 2025 15:58:30 -0700
Message-ID: <20250523225845.2311989-16-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Set the pstore address and size based on the coreboot tables if the
coreboot tables are populated.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/pstore.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 9795eea2dbc3..f8858b382215 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -3,8 +3,10 @@
  * Copyright © 2019 Collabora Ltd
  */
 
+#include <cb_sysinfo.h>
 #include <config.h>
 #include <command.h>
+#include <event.h>
 #include <fdtdec.h>
 #include <fs.h>
 #include <log.h>
@@ -141,6 +143,19 @@ static void pstore_init_buffer_size(void)
 		buffer_size = pstore_pmsg_size;
 }
 
+static void pstore_set_end(void)
+{
+	if (pstore_length < (pstore_record_size + pstore_console_size
+			     + pstore_ftrace_size + pstore_pmsg_size)) {
+		printf("pstore <len> should be larger than the sum of all records sizes\n");
+		pstore_length = 0;
+	}
+
+	log_debug("pstore set done: start 0x%08llx - length 0x%llx\n",
+		  (unsigned long long)pstore_addr,
+		  (unsigned long long)pstore_length);
+}
+
 /**
  * pstore_set() - Initialize PStore settings from command line arguments
  * @cmdtp: Command data struct pointer
@@ -194,19 +209,37 @@ static int pstore_set(struct cmd_tbl *cmdtp, int flag,  int argc,
 	if (argc > 7)
 		pstore_ecc_size = hextoul(argv[7], NULL);
 
-	if (pstore_length < (pstore_record_size + pstore_console_size
-			     + pstore_ftrace_size + pstore_pmsg_size)) {
-		printf("pstore <len> should be larger than the sum of all records sizes\n");
-		pstore_length = 0;
-	}
-
-	log_debug("pstore set done: start 0x%08llx - length 0x%llx\n",
-	          (unsigned long long)pstore_addr,
-	          (unsigned long long)pstore_length);
+	pstore_set_end();
 
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(SYS_COREBOOT)
+static int pstore_coreboot_init(void)
+{
+	const struct sysinfo_t *sysinfo;
+
+	sysinfo = cb_get_sysinfo();
+	if (!sysinfo)
+		return 0;
+
+	/*
+	 * The sysinfo pointer always exists, while the pstore buffer will be
+	 * zero size if this isn't a coreboot payload.
+	 */
+	if (!sysinfo->ramoops_buffer_size)
+		return 0;
+
+	pstore_addr = sysinfo->ramoops_buffer;
+	pstore_length = sysinfo->ramoops_buffer_size;
+
+	pstore_set_end();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, pstore_coreboot_init);
+#endif
+
 /**
  * pstore_print_buffer() - Print buffer
  * @type: buffer type
-- 
Sent by a computer, using git, on the internet

