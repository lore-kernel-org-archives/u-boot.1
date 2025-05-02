Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D71AC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D01828BC;
	Fri,  2 May 2025 16:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L0d9/p/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6638982977; Fri,  2 May 2025 16:47:52 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B32E829F6
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-864a071b44bso67747139f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197268; x=1746802068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcBCcvRzIsSB+59lJQn/uQ2gmD2WffFKx8H7Ksbre50=;
 b=L0d9/p/33kajX+Ic1opB4blSB4vG2ttec+wY8GLcZZOTIDAuSbmv6SHuPulgyYbgqx
 F8mxY11qQjrKCKNlnUSeBc1tloNcH0FfSJBYseKGbYSG/Uxws1R3KHOeBkKqwov1FzLs
 VIYNH58X2OdTvjVTnuP08CHh/9vJynVWePMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197268; x=1746802068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcBCcvRzIsSB+59lJQn/uQ2gmD2WffFKx8H7Ksbre50=;
 b=Fv5n7JrteIBJRss73zte8dkGZ9EKyhZ3cnpFYuMAkJ83mprh7+wP9tdsCUcMXE0e1d
 bqmFNInBAzPFDfnQAXvkTKP/MrcFoXyx53iHvksgxNHNSBRdsU3Pg9kAPyOXmq/vt/zu
 CbMJGDGp6C7P8dxf2UpYJiFnJOUKavSnAE1zcA51rUW9n7DaKalU6VRUkKJ4GUvCks5f
 KiX6sawZosl5Y5yj1PXsgtHEKJhFlEDxxPAmzEkUkmOqHhfP3rjZPz59smME96QRrUt4
 5K5V7/cG2qHmeSfoiy0V9x8YUccWVp11lGied+UiQFqR/61MafBXkc8rAqgY9APOAahd
 +vmg==
X-Gm-Message-State: AOJu0YzADZaqPZmtDfcUTMGAfHRYwvHZ0DFLwwkiLbXzfLk4LZ6SY8I6
 gKVic8RkeEEShOPiPe3OX8M053QXoSy0iJAbf1Gw5Ix19fDLyEUc6fO3H7/Ya9FJPYrEwD3s5HQ
 =
X-Gm-Gg: ASbGncsVgzaEu6IYs0/ZLlgAaKhnK3QaoMOnfrQbKLAfCyhaP95UrDKnXwB7Nfo3rVe
 LuNpjRt4ep8rZ3GnyaIzdzijDfxT5JeSioAl1oEBr2jsQTXLoCwMVvECUra2IHI1JEelemeDblx
 H/qWLkJGJjVvAbFWH1OGAnASZ1SyhusO02thy5kOEjUVtZ41gNtJshX7c97UHvbr629/WFS14Aa
 JB2+WqFENj7m2UoZsDXjAMucKzO3ZKcbJXGLVf97BN/wHMW4qTdIt39hWNEfSSHwMxsvl3mGXkd
 cJT6OJNseu7nmWz+oI5mBgXUEx3qBLL7sr18tl0W0ZDiDCUU1Yjprs8LaTPbqFb1Xgoj9PbM/sO
 k4A==
X-Google-Smtp-Source: AGHT+IGVGpnA1Cfz7S0fQOsFyDJDD6n9Fc8SgmKuRaOamJ6W9Kd8Bq0GXDxG9P8riXUdvSqyUsw0UA==
X-Received: by 2002:a05:6602:4c86:b0:85b:6118:db67 with SMTP id
 ca18e2360f4ac-8669f97ef9fmr409554639f.2.1746197268364; 
 Fri, 02 May 2025 07:47:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/60] console: Support a format string for stderr output
Date: Fri,  2 May 2025 08:46:11 -0600
Message-ID: <20250502144718.313633-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Add a console_printf_select_stderr() function so that it is not
necessary for the caller to process the format string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/console.c  | 18 ++++++++++++++++++
 include/console.h | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/common/console.c b/common/console.c
index 3362a32a7a0..c6dfed6e201 100644
--- a/common/console.c
+++ b/common/console.c
@@ -359,6 +359,24 @@ void console_puts_select_stderr(bool serial_only, const char *s)
 		console_puts_select(stderr, serial_only, s);
 }
 
+int console_printf_select_stderr(bool serial_only, const char *fmt, ...)
+{
+	char buf[CONFIG_SYS_PBSIZE];
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+
+	/* For this to work, buf must be larger than anything we ever want to
+	 * print.
+	 */
+	ret = vscnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+	console_puts_select_stderr(serial_only, buf);
+
+	return ret;
+}
+
 static void console_puts(int file, const char *s)
 {
 	int i;
diff --git a/include/console.h b/include/console.h
index 57fdb0834c1..8d0d7bb8a4c 100644
--- a/include/console.h
+++ b/include/console.h
@@ -169,6 +169,21 @@ int console_announce_r(void);
  */
 void console_puts_select_stderr(bool serial_only, const char *s);
 
+/**
+ * console_printf_select_stderr() - Output a formatted string to selected devs
+ *
+ * This writes to stderr only. It is useful for outputting errors. Note that it
+ * uses its own buffer, separate from the print buffer, to allow printing
+ * messages within console/stdio code
+ *
+ * @serial_only: true to output only to serial, false to output to everything
+ *	else
+ * @fmt: Printf format string, followed by format arguments
+ * Return: number of characters written
+ */
+int console_printf_select_stderr(bool serial_only, const char *fmt, ...)
+		__attribute__ ((format (__printf__, 2, 3)));
+
 /**
  * console_clear() - Clear the console
  *
-- 
2.43.0

