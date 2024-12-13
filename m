Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09884E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E7A80214;
	Fri, 13 Dec 2024 13:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kG7/zT3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958DC801E7; Fri, 13 Dec 2024 13:46:04 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D0680137
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385df53e559so1358132f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734093962; x=1734698762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boCSn63MQk4H2nOFl/fq2eo2ButnEUWv4XSM+n6NXi0=;
 b=kG7/zT3g0bbKlpEtAlSC/yOJaFnD5Nd70sRpQ5+4smwoVVbnsZ7bX3xZ0jQuaooBoZ
 6VxJ1j9ef8tnrEye7QOD7DiyRG/coPORbplK5XPMXHavjTOsW24/Tzg4+l3K53k2f9tI
 TMqPlGTjuuy/GH6+uogSdm1jivl5SrYIjKXU572NaeXxW8/G9fDQjQarPYzahskgo9bw
 +zMl9j5lNqaNZFpVxoTLgGQSLDRE9QHssn7+UifTYwz3sZDRmci7LUCjjRGaFp8CXmfd
 ht1mQ4xIoQ52h000N9CVvjAHrEpkr0vjW4hgjaYwv1mokn3VSgOuROmJLZPQ/pkT2zHF
 A52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093962; x=1734698762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boCSn63MQk4H2nOFl/fq2eo2ButnEUWv4XSM+n6NXi0=;
 b=Ytlb70sQW9whw2H0IqYToN/KE8yLeiPRHJA7ckWqZVk/T75/5m0wvDihtQdLJ5xNhY
 msbyRX1HzjCW7WYDVRexYnV91JVtfkyKtSf/FjOZ9X+yj2eqPm4FfKkH7GRKuTg5rum7
 6nw/Zi8OpT7qb+HS7D/ULT773re382ecf1+ynRsgHZJ2WjJuq/Wi/CZhsY+TfBLXAGf3
 B6YvzuULjk5pZxx58j0dmpGYSyo1piEPTRN0Z0PBnjvbQ2vVHC4QF/pSd2rRUKLAYJkA
 z/3VLrnK1uYVU6qZPnS/qp0Ca8DRQo9UZdmOCkkOK58SxBeDrzSsSbhwfal6VE11sEu/
 Fkow==
X-Gm-Message-State: AOJu0YzJKbZvqWafnfgkmlVYSIPu5niprh+6GhG3fMeoAEC3PsLC8sF5
 SoN2y57j0s6rM6fM2EwDJmLUEGM0yCd5eateUv9TQub2CQQu5Ls0xxDxOKw1Mm2RrcOXxwVtb8K
 tYvg=
X-Gm-Gg: ASbGnctG5J8Ch2nHMNgsp4OIm9DFMdzv9OrpX1TTtRlUn1PxsPtZsCJv6WDsKGMdgPK
 Epk7nUcs9+qZccE8xlw8HiUmQAux5NsDyRzTYyE6rWPnoiZFHt65cKYJYwRwiDpvd7vPTulu6x8
 0iQQCAIZiSeiA2hj66KCZhhMO9OKYuA13++hYcnXPlqreqo4pBj7EieF+vJa183cdta8VGu20qe
 2Ry93f5CrhY6/jHPLQ/692luRSVkaq09h+O40EeKbyHshr48ijJ+GJuXrNaVroJtQ==
X-Google-Smtp-Source: AGHT+IHweqcJoHINvRPLCXZ4eCZybivrIOV8NOHUoeOhwstZBChxbWdXsBmdJdok5CRDm4nTCGsN5A==
X-Received: by 2002:a05:6000:18ac:b0:386:1cd3:8a08 with SMTP id
 ffacd0b85a97d-38880af13edmr1875798f8f.5.1734093961740; 
 Fri, 13 Dec 2024 04:46:01 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3390:8f2f:2eb7:90a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e54dsm7050988f8f.19.2024.12.13.04.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 04:46:01 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 1/3] trace: add support for 'trace wipe'
Date: Fri, 13 Dec 2024 13:45:36 +0100
Message-ID: <8d7a88c7d11d820527d4909557a2af25be53fbbc.1734093566.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734093566.git.jerome.forissier@linaro.org>
References: <cover.1734093566.git.jerome.forissier@linaro.org>
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

Implement a 'trace wipe' command to delete the currently accumulated
trace data. This comes handy when someone needs to trace a particular
command. For example:

  => trace pause; trace wipe
  => trace resume; dhcp; trace pause
  => trace stats
  => trace calls 0x02100000 0x10000000
  => tftpput $profbase $profoffset 192.168.0.16:trace.bin

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/trace.c     |  5 +++++
 include/trace.h |  2 ++
 lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/cmd/trace.c b/cmd/trace.c
index 937e6a682ad..d36008720db 100644
--- a/cmd/trace.c
+++ b/cmd/trace.c
@@ -100,6 +100,10 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	case 's':
 		trace_print_stats();
 		break;
+	case 'w':
+		if (trace_wipe())
+			return CMD_RET_FAILURE;
+		break;
 	default:
 		return CMD_RET_USAGE;
 	}
@@ -113,6 +117,7 @@ U_BOOT_CMD(
 	"stats                        - display tracing statistics\n"
 	"trace pause                        - pause tracing\n"
 	"trace resume                       - resume tracing\n"
+	"trace wipe                         - wipe traces\n"
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

