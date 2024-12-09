Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00988E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000D4896EA;
	Mon,  9 Dec 2024 16:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ShlfilE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8448D896E4; Mon,  9 Dec 2024 16:32:37 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006B7896DE
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ed7f6605so1993334f8f.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733758353; x=1734363153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ezEE8iaDRygXpYAczBJSbU/+xaXpWW4zLER8KWegIk=;
 b=ShlfilE/LRZ3HycvSE2dUdwP7VAJX6BOPtgZ1j6fEPtpSeOg+Fe8AmT/bfpVmUgIAA
 n6VBAM/Y2ChLGs9qQs5DWc/b+SLccQW+LNeADACdmOy5EHHzqQ9gii4WUXfMh/FquD78
 4HKFq1MMchiC/owGIg6YdunRFYtPBzvFDMS9wdCCuEdxtqGxtfn7hY1ayCC785rotBEa
 x91YbQUG/grwjT7+Helx2bgZl87J66jRrQR26LDBVqq76jlqie6ManXmnc6hb4I+q/4Q
 odMldXZuK7zFJfEbqYUWfAfO+4hkPeNZAkD04fM0/v3fd1YM6lD+Pqteel7X3euvEWyC
 +t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758353; x=1734363153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ezEE8iaDRygXpYAczBJSbU/+xaXpWW4zLER8KWegIk=;
 b=rM0HzX8q+LrmRpWtuiYYRDBPLBk4kMaTAMPg6TAqWxBf+dg2ZPu0jTqpPw2PQ3DjWt
 NcxIxd6+m0/rOWUn032Zes2CK9YNzScmJh6JUlgLB0pG5YsfLmnAEeLuOSiyHohZyl7a
 Zc7cARw9txKlPD002PVwfA6NgFBsu7/9Rr5c2a7e5xbGHpxnCLKHPUZf9BgidVH7Ak3t
 4xGYwULTgWKqq9wCwnM68eZmUtjeT+h3UGK6Ds1Z9rk0efCAnPQa4MwA2RmPBmAnKLf5
 hgVDuAnFlcJ6wrMJkooGoqlNsqOWqIGdlDdsocBgbEkU5EPTkw5nluzkMQhtS90cBJsW
 YpEQ==
X-Gm-Message-State: AOJu0YwqihIchAxc4HuFiKLvVeQRn4alwxsVkc9rGGGDhl2n1Vp7auWJ
 PyeMDlFb+Wyn3YzTJ81/j+3D/OkgOTU6GDMiJ0Ak6/jkFH5ahdHzsJzIkiGnS+dwrbHmdm4EcaX
 6FmQ=
X-Gm-Gg: ASbGncswiooljLRpZHz3uYCOYQ8whEDaEKr5OtekMyyxGxDfTEocBtUtp1fmqxACfp2
 YZ1QdnBp/Y4JGSafy52isOa6p/9qHMndXG7nY8FkYum2FsjgiYM6euHcKaxlw1nIrSUTHuH341X
 wDwuwpmsWht1fTPXnQIR+pr1Alnl9+U8Hm/JC3nX+Kal+dgak8QyveKos0N0cxXhITCZ2T+UhYa
 xToyngPNDsyisibWAxZTXq0g+vKbEKwVuxqDCgBqTOB6IzV58fw0R7eG2E=
X-Google-Smtp-Source: AGHT+IGdcQjSWXcBiKY4/39SYo8GkkJFpnbSWx1yLe40YlltGVKuqJNORNnhEQCBl7JgUsUuFhsYPg==
X-Received: by 2002:a5d:47c9:0:b0:386:2bac:139 with SMTP id
 ffacd0b85a97d-386453fe63cmr663734f8f.54.1733758353260; 
 Mon, 09 Dec 2024 07:32:33 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:144b:1fbf:fd90:f158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f55733d2sm53000415e9.40.2024.12.09.07.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:32:33 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 1/2] trace: add support for "trace clear"
Date: Mon,  9 Dec 2024 16:32:13 +0100
Message-ID: <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733757864.git.jerome.forissier@linaro.org>
References: <cover.1733757864.git.jerome.forissier@linaro.org>
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

Implement a "trace clear" command to delete the currently accumulated
trace data. This comes handy when someone needs to trace a particular
command. For example:

  => trace clear; dhcp; trace pause
  => trace stats
  => trace calls 0x02100000 0x10000000
  => tftpput $profbase $profoffset 192.168.0.16:trace.bin

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/trace.c     | 13 ++++++++++++-
 include/trace.h |  2 ++
 lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/cmd/trace.c b/cmd/trace.c
index 937e6a682ad..e95ac7ca9da 100644
--- a/cmd/trace.c
+++ b/cmd/trace.c
@@ -87,8 +87,18 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		trace_set_enabled(0);
 		break;
 	case 'c':
-		if (create_call_list(argc, argv))
+		switch (*(cmd + 1)) {
+		case 'a':
+			if (create_call_list(argc, argv))
+				return cmd_usage(cmdtp);
+			break;
+		case 'l':
+			if (trace_clear())
+				return CMD_RET_FAILURE;
+			break;
+		default:
 			return cmd_usage(cmdtp);
+		}
 		break;
 	case 'r':
 		trace_set_enabled(1);
@@ -113,6 +123,7 @@ U_BOOT_CMD(
 	"stats                        - display tracing statistics\n"
 	"trace pause                        - pause tracing\n"
 	"trace resume                       - resume tracing\n"
+	"trace clear                        - clear traces\n"
 	"trace funclist [<addr> <size>]     - dump function list into buffer\n"
 	"trace calls  [<addr> <size>]       "
 		"- dump function call trace into buffer"
diff --git a/include/trace.h b/include/trace.h
index 763d6d1255a..782eaae2fc2 100644
--- a/include/trace.h
+++ b/include/trace.h
@@ -100,6 +100,8 @@ void trace_set_enabled(int enabled);
 
 int trace_early_init(void);
 
+int trace_clear(void);
+
 /**
  * Init the trace system
  *
diff --git a/lib/trace.c b/lib/trace.c
index cabbe47b58a..def9f912c92 100644
--- a/lib/trace.c
+++ b/lib/trace.c
@@ -351,14 +351,8 @@ static int get_func_count(void)
 	return gd->mon_len / FUNC_SITE_SIZE;
 }
 
-/**
- * trace_init() - initialize the tracing system and enable it
- *
- * @buff:	Pointer to trace buffer
- * @buff_size:	Size of trace buffer
- * Return:	0 if ok
- */
-int notrace trace_init(void *buff, size_t buff_size)
+static int notrace trace_init_(void *buff, size_t buff_size, bool copy_early,
+			       bool enable)
 {
 	int func_count = get_func_count();
 	size_t needed;
@@ -368,7 +362,7 @@ int notrace trace_init(void *buff, size_t buff_size)
 		return func_count;
 	trace_save_gd();
 
-	if (!was_disabled) {
+	if (copy_early) {
 #ifdef CONFIG_TRACE_EARLY
 		ulong used, count;
 		char *end;
@@ -394,9 +388,6 @@ int notrace trace_init(void *buff, size_t buff_size)
 		}
 		puts("\n");
 		memcpy(buff, hdr, used);
-#else
-		puts("trace: already enabled\n");
-		return -EALREADY;
 #endif
 	}
 	hdr = (struct trace_hdr *)buff;
@@ -419,13 +410,41 @@ int notrace trace_init(void *buff, size_t buff_size)
 	hdr->ftrace_size = (buff_size - needed) / sizeof(*hdr->ftrace);
 	hdr->depth_limit = CONFIG_TRACE_CALL_DEPTH_LIMIT;
 
-	puts("trace: enabled\n");
-	trace_enabled = 1;
+	printf("trace: initialized, %senabled\n", enable ? "" : "not ");
+	trace_enabled = enable;
 	trace_inited = 1;
 
 	return 0;
 }
 
+/**
+ * trace_init() - initialize the tracing system and enable it
+ *
+ * @buff:	Pointer to trace buffer
+ * @buff_size:	Size of trace buffer
+ * Return:	0 if ok
+ */
+int notrace trace_init(void *buff, size_t buff_size)
+{
+	/* If traces are enabled already, we may have early traces to copy */
+	return trace_init_(buff, buff_size, trace_enabled, true);
+}
+
+/**
+ * trace_clear() - clear accumulated traced data
+ *
+ * May be called with tracing enabled or disabled.
+ */
+int notrace trace_clear(void)
+{
+	bool was_enabled = trace_enabled;
+
+	if (trace_enabled)
+		trace_enabled = 0;
+	return trace_init_(gd->trace_buff, CONFIG_TRACE_BUFFER_SIZE,
+			   false, was_enabled);
+}
+
 #ifdef CONFIG_TRACE_EARLY
 /**
  * trace_early_init() - initialize the tracing system for early tracing
-- 
2.43.0

