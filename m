Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3B3C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0531F8118B;
	Wed, 26 Feb 2025 23:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xh+2yGZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5816080F88; Wed, 26 Feb 2025 23:16:28 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E335180FF2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22128b7d587so4222865ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608184; x=1741212984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=Xh+2yGZ2r75G7/JtIv0WLD1mKdyR4dErQ8F97I97UGs9Q2yn30r27Pxww+bjEyaCFF
 lZq6FFa4Cjk0dJQCBxMrPupP01vH/t5fkLowV7qlufejNfwHHoswNbwgpmKN2F6j8PLy
 YQFuF2qmAl0FWms1Ez6BM7KtAFu3zweGoWTuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608184; x=1741212984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6i1AhQSdVhBIOC5r+5bjgQ33qYMPQR4JFmbkQwP5Og=;
 b=ekNYitNLTjsLaDGulU6y89r/Uhj+OoWIoAROHwRjRWt4I7awyBIb0iephTS3Ss7Osf
 eSghsZK7u5okk5ltFeiy0XYzkd+bBs/b5DuD+WzE/Gq7QPrh6x6ZgRyFpCE7WHXzbVNr
 vsMrIvKHt/Cu29nryEJRhsmvTG+N3mCMBUAGGCyDyc/SbWSSUD8Qt911N968N6Lefk3w
 c2oc3Kt5cuPYnGZSkUwrrveVHJDJJ5tpUS9BDgDh9QqjJrNnBHtUsNrJyu2I+xw9C4Tk
 0vzgDOxTBo4wa/Kvugu8VyuXyG2Hycdv+RkTalkT/AvvZdnolS7Y7WkOoqLCijIfi1tw
 v3HQ==
X-Gm-Message-State: AOJu0YxdnQwIuc6jpLh2pI0cdlFkmS+ZjyfiN+2pboXCMl9ySL9eQfIR
 L/zBmL2xsbl/a8MRUEf9QD/sLJ8kN0kVTcV/ALckkoceYdety32fxuroavc513TYrkN3/w7WEm8
 =
X-Gm-Gg: ASbGncuZSL8VfUuR377aVBAzFM+bWomqvpXdl4c6FGWjiCW56XT1iGNSXm5T+hIvdDY
 pIv4SB1R/sirUmKAOIwdAxCi7qn842D0aL5Np6KJkEIOARluwpAF9WjBuz+YC0+F+lS/e1YGUtA
 MrziWJAYHqTgFUPc66av/fh+vEs/aeTF2uHl5LblWyG9U2uCuEjuMfPA4vGGl/5KIj6igREqvkm
 7OHYmPNSBvfXRO71/o44EWnuAJq2nv6lFWR1J3Lp/rbcm6YoeOwNld2q8SuQ5h71DQNb1WGQcTf
 0/iiKbqaV5fMVwRhuu1ms4wL9s8OJINh5maUBUuL7K4OTc9Ws+WpOJVDC0bgKFD8CA==
X-Google-Smtp-Source: AGHT+IHkZRXk5uOIRN6moPap/J0Uv7wRPOC+qR1uaI5Oo1gAmIf+AZZx+WgeD8gVRCs0Lr7cB8/J9w==
X-Received: by 2002:a17:902:c411:b0:21f:1549:a563 with SMTP id
 d9443c01a7336-22320061fcamr63303945ad.2.1740608184252; 
 Wed, 26 Feb 2025 14:16:24 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-734a003fa44sm45537b3a.139.2025.02.26.14.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:23 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 10/15] pstore: Add pstore address from coreboot tables
Date: Wed, 26 Feb 2025 14:15:56 -0800
Message-ID: <20250226221607.1283592-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

