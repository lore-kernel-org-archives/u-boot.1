Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C9DE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7DA8965E;
	Fri,  6 Dec 2024 11:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NHZlFvH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71A6895EC; Fri,  6 Dec 2024 11:29:42 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86682895AE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1869625f8f.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733480980; x=1734085780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ezEE8iaDRygXpYAczBJSbU/+xaXpWW4zLER8KWegIk=;
 b=NHZlFvH0YQjxgDiRcAkeeHmnfPiXIBqHgI8f8GhpaUGbW58Tv0y/oeQwuI9JXCkMYc
 ZqZ3n31UmvNBPWdRTYS2Zrz2TN6MJiIwsl0waE4WdmZt0Y3tmb/ZnF7QSCQBUtTev77A
 Emux/wliOncH8eJiD5Ftm/bFhu1OI0eB2JxdMb1d0QGgRX0CQ+zpQ9OLzUfr7AzyLy9c
 YtV6MXK2FzLQ4pDn40cD7FkKECoV6mxq+KCvetz1GzwjuoJMpt2rg7hCCePCQnnPl3q3
 yP/tpYKPwjCloafshCaU5ASuctJoYatwtYOGYzm67jc5dtWNbOIAgZvh6sc72zjvC9XJ
 lg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480980; x=1734085780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ezEE8iaDRygXpYAczBJSbU/+xaXpWW4zLER8KWegIk=;
 b=n5fmV9mCm0poA3S1x/mHI0+xErxl/LQ+0zqoJwQVFI8I9c8Cv6kgsRCcRfXDPtaa9a
 /i5fvAI9qf85VYPRE/WTjJ27Q5RUuzkvWPkplnTTvvYDcgecIeijLJbQC76kauhCYo+8
 3UBQFeGgKKsF+iqz65Yxexvh4ojBnvvnzV+w0moh0DV8tMI9bUWjMMOqwiJwyCoB42O9
 LdldxkQmKX77XyGz45HadhVtvRsIB2L9LBsiRrvtQ4rWNcSSgrM1BF9GbVLW0z4QF4/D
 KGRhNi4DTpKDp+Ec68l8/o7vYSIcn4kjxqw+x+l+9yzqKpbeg86aR6yFYZuYEct0JuZh
 wKIg==
X-Gm-Message-State: AOJu0Ywiyf96OppNOJA6fG/IyusteExQ+auQ/KxcG1cGcIdjIRRUfFRv
 oa7FJXcKWSEAJQt4nATvx0oJYolUdHXM4H85E3Ouqx/3ySVKo0u4th9hNYZddS2nrxiTXZcZJh+
 7N54=
X-Gm-Gg: ASbGncv1hJ8TcQLE1pO1NqkNQyWV2MHv0r4yRvCyqyFSxrF+DAHBRSS1jfqO+qReoAr
 NixOIR2aAf5XyTCHTeYUHDYeAp4OSEct2oEA/+ItFUMSYkMXpeyDzi+gLhxwuUtXaJA3i/8IHHi
 v/BnCaSo4ks2vXhlw2pzR4uqfHUEbltlr/kwNZMBAUemvl/AP6yIdmCC13VvHoWtg9TTejkC8mm
 PaVwYjTA/du9w772Zo3QHKNb1njYnZCLiMr81MyvDGoGaCon5YRyaiaV/s=
X-Google-Smtp-Source: AGHT+IGh2NCoGeHF6F/6QKtty4qW55AYOZp1chBxDr0A9qvr/5Tq0W1gZQS7loi1t4zIi3tsVz7LnA==
X-Received: by 2002:a5d:6d01:0:b0:385:fb40:e571 with SMTP id
 ffacd0b85a97d-3862a7720bamr2215523f8f.6.1733480979734; 
 Fri, 06 Dec 2024 02:29:39 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7bf2:dbba:fd8f:cf0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59cc47sm4225958f8f.37.2024.12.06.02.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:29:39 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] trace: add support for "trace clear"
Date: Fri,  6 Dec 2024 11:29:16 +0100
Message-ID: <20241206102917.1095207-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

