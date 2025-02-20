Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC1FC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9587880FED;
	Thu, 20 Feb 2025 22:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/peQ8dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3E880F5C; Thu, 20 Feb 2025 21:59:20 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0486C80F5C
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fbffe0254fso2856266a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085155; x=1740689955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=S/peQ8ddW0Wa1IOJvN/F2Xr6ErmRatCx2f4ylAGAom/ls/sVGpgDA0A/jVE4bEstnt
 ALjGDk1ILp2lmMVc9G97mB9PKuhYBAZtzQJyhG91HIS3yYcWCqJ63t4cbzg5IlIB/Afz
 1XU3rynV+K78RDuK9Z/070L7SxNvZ8jtZ8Ii4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085155; x=1740689955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=QzlWieTJSAX/e1nSqo8U+C93kSe+hKNQ9otnLlh+tIQZV9M/ReB9TU5Gv4BcN3sfR2
 cY6hJ4r/msiQApD5hqHBPn7CsY0OApfKGo2oC8TrqObD5ZeGirjtagmT3WV5rycnL2nS
 7qqTQPruAWKTl6elerqxYJ7PzYQJn4yuZeHMDUjkO8EiHAIIeo8ZLnUVEKACkj5HiTrR
 XSKuVZBddDTCfENy8YjmNJpyO9IlSrCuWNLaaKOJlDFhJKHt1JO/ybAuzQ5kcbVDeHUN
 8TUVewF+Q4YhRaDCpMvSXu6Pjft2brGZbr9kMlv2xY3pnVCpa65Qzj9B+IPzSUIr+uYT
 Mr5g==
X-Gm-Message-State: AOJu0YzHEsq0nqMBjCgVpJv5wzv5siHyZhNwZuiccki16l0RzV+mV3KB
 Qa7q8dEzkpEQ93LoN30DK+dLhTs6QUPFkT52s/1TfmPJV9IaJtUwj9GxW2UvvtFAMVFz1MrrvJc
 =
X-Gm-Gg: ASbGncvjFfSlTLC8zQG7b/KSh3giofBa5xNU4aX4W7dOnk+DG/wIjAsL4Ktjv6Y88oO
 ebVS4WoR1Nnu8bzOrW5+ul5iSxoI5JHS761wuA2loCMNFLc4sKLfCn2uXl0XBvQgrdWjEvyiRlo
 FLwePYLJjGXh08BqIZJF0H4l+/twdzFwk9DwrkEAbDcKaCpM/5us5wTVpfwwyJRhN0zMhwhOs6l
 FpHU1Mji5zRhzne+QIGwET9496s4a+COhGK1TEPelu95bTb5hf2FHss8o7vX79X5xqYqV0vW7xQ
 FNphKC29QRE7elgDEHv4U+Zbk761XdR9BfYEyMF8XciXoVm8yoPbFX4=
X-Google-Smtp-Source: AGHT+IFCLgcbjAQDMFn6HRjIailpfHBEJKr5boGhyRq4riWI2hmVwzyQjqJNt5Om5U4k8QeFU+3bRw==
X-Received: by 2002:a17:90b:2e0d:b0:2fa:2124:8782 with SMTP id
 98e67ed59e1d1-2fce7b1f6afmr1005406a91.25.1740085155269; 
 Thu, 20 Feb 2025 12:59:15 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fc13b913easm13915342a91.39.2025.02.20.12.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:14 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 09/12] pstore: Add pstore address from coreboot tables
Date: Thu, 20 Feb 2025 12:58:51 -0800
Message-ID: <20250220205900.3127680-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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
 cmd/pstore.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 9795eea2dbc3..dccbf455e299 100644
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
@@ -194,19 +209,30 @@ static int pstore_set(struct cmd_tbl *cmdtp, int flag,  int argc,
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

