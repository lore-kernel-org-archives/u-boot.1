Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFCC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59EC829F6;
	Mon, 28 Apr 2025 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbmnuEJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8D68210D; Mon, 28 Apr 2025 21:24:52 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EF0820F6
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so4134917a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868289; x=1746473089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=NbmnuEJOf+5+/EusUhmOtq3Es6DoNkIgFdOFdRIKbmmK+OtkjEw8Qm+mbiZkZ+/0Gz
 MsiejyNuRc4wUfKEUn6IOVannIgam5CwtVbxUdmpnX08hRiLMc0Xywur2cI6QtrhVtKm
 h0bZTh9dQtI5q0Ar54NgFbGubJbz6Svucqkxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868289; x=1746473089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=VBBsfS6I0/FvNU8bmkWDeTf1d6cr4ztb4j2LUoyKtmVgVc1nKcBqg/kH/qpuadEpYz
 o5dwnB/t6ZwFeFLgvz03EVBXX9giFuX4WwCXXhI+Z8zOQuZJ/RNbPxVxotiqKrXO7Ejh
 92/z0k3QjXfD2hvQdqktvnu+ueXJMZp2k+yHeaokNAFmq2Ga+Pm5/ROBsK6MVAkJp6ld
 1j5RCPvUTe+rELiGjnM0AgdhYGc3Oe82B0li1YrHl6Ojm0IM2WX5YJ0bQ5yDwOrs7+P4
 qBWHlD4tSK8CXy2EEGt1Xu55hhgjpjPgbMnGckY27va4osNee1tg+qtsPI9Ov57xHLAx
 sSJA==
X-Gm-Message-State: AOJu0YxStKKu1bu0b0XOyr5VSnmbx7a7N1K9Hr9FqgHeHtXV3NiVyXGi
 gQ9yuKwc2BiUgNDNS7UE8yebjk/3D+3gQrUxOat42GDWru3f6BQPkcleXJ+Ui6XaF8KUl/yNCu0
 =
X-Gm-Gg: ASbGnct5IEgxMY0Dwa4bGzTg8mC4wdlL5WmU5tgdByxsqbsJfN5ccjPX84YUJMet8V7
 ExKmIqzGAk+59l8Y89iZYo4720dmDS2nBGW/HiK6OiPrXiIMkVCObjH5rT1o9ngRIW4RNOZaaDD
 Gmq2zftFmU30MY0W96H9sFtXe+CTGVVbTdwemtN5DdSt5fWICSlcdr4YVDXPJTSkLj3PlP5zBAN
 hu2yTKqTW05TfVdkZuqYMB3+9qGqlnmMJCJF3gXJDUt8ZANSEZrqDzb8XOYZSIc0DA5BUGnBHZV
 lbMBf3Kg0HaF/2unYjX3PJWqQLebUpgUo+tDG3XdoyEX05BmDo4QR2mgMCJiAz9Kb7f7MOoYizS
 2jg==
X-Google-Smtp-Source: AGHT+IF4QGrPl8tG2E4OqG/5Y8zHxKKVzzRvA1mNhwB4C0umFqesSuf80PRGVz6Cx3L6BV05AsXxag==
X-Received: by 2002:a05:6a20:6f8f:b0:1fd:f48b:f397 with SMTP id
 adf61e73a8af0-2093caf7aadmr834192637.23.1745868288682; 
 Mon, 28 Apr 2025 12:24:48 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b1d59d45835sm1851829a12.67.2025.04.28.12.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:48 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 12/17] pstore: Add pstore address from coreboot tables
Date: Mon, 28 Apr 2025 12:24:19 -0700
Message-ID: <20250428192427.3877612-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

