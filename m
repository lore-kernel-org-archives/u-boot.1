Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B42CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A49B88E96;
	Fri, 27 Sep 2024 00:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bFnEm/EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BCC88E5F; Fri, 27 Sep 2024 00:01:43 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FA588E9F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb2e136da3so9463166d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388099; x=1727992899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6rJQMOhsSwQGbiM5xIK5Rhad8fP1T84y2nnqZJna0o=;
 b=bFnEm/EIt+8c+g5KqggHSDNa8A3Q3av6fYOvYgklX/uCrR5CjQ1P4iJG+pBYmf+Td0
 0anE9dQyrZyQP2ix9x6Ozd41qv+1x5iVWF4dHXLotyy+A7EYwuNHDPcsYpL+cQqvuMCN
 EEHd7IJaEZbaXrIOBSbN9bRhGTzWtCnrwN9Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388099; x=1727992899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6rJQMOhsSwQGbiM5xIK5Rhad8fP1T84y2nnqZJna0o=;
 b=tqmwiBFAZNE7Gj1CXsaJkRgBYkKcT3KOVUpaUbawEQIW0+/iUl2beOF61HgxUdrrUC
 ieRZF5lTM7bCY19Dl3Lho5JKT2J3xu3RdcI1yEHhXa2xfZG7TZ+NBm0rwMQvbv3cLo/h
 dYrYP7Z4r5Qlipt/shlEAQitL15vwkLWy53cd92W426gopnfGjiOhREMBp+0baaF52XT
 pvwEFerqWuBwYDC/XYMdMWOdgP4RkIhzfEWxsnMOZbwer6N7WbkOrOC4Wx0QeFBnNQXH
 NOm5rEoSSkvaHQgdy2RCf/K7lXOMpxd+d2HyXpnnjxOPmHYgGu0rozWH0w2T0U1XH/3t
 hx/w==
X-Gm-Message-State: AOJu0YxGjF0hHr7/GYMod69xZnvkZk6bEIO9dR5NWKvlGFt5n7D/u+2H
 +N3Zp3xmaFbZGu1hgnZ9kp+zxY7IWMRXIJnkS7n4pa4eYqbUuvAAxVtbEOZaKLqA+J63aybv5NT
 czzZ/MyE=
X-Google-Smtp-Source: AGHT+IFrU6skhJCY0Uv4oJqf2BzcA9F+0nEVaOSPd0DzfiCosEPmHjbPPjZbkV9BSVjo9RBRLcpcsQ==
X-Received: by 2002:a05:6214:590b:b0:6cb:2a26:af89 with SMTP id
 6a1803df08f44-6cb3b644060mr22625036d6.34.1727388099374; 
 Thu, 26 Sep 2024 15:01:39 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:01:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Date: Thu, 26 Sep 2024 23:59:38 +0200
Message-ID: <20240926215950.1265143-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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

We don't want ANSI characters written in tests since it is a pain to
check the output with ut_assert_nextline() et al.

Provide a way to tests to request that ANSI characters not be sent.

Add a proper function comment while we are here, to encourage others.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi_loader.h         | 21 ++++++++++++++++++++-
 lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f84852e384f..82b90ee0f1d 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
 efi_status_t efi_bootmgr_run(void *fdt);
 /* search the boot option index in BootOrder */
 bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
-/* Set up console modes */
+
+/**
+ * efi_setup_console_size() - update the mode table.
+ *
+ * By default the only mode available is 80x25. If the console has at least 50
+ * lines, enable mode 80x50. If we can query the console size and it is neither
+ * 80x25 nor 80x50, set it as an additional mode.
+ */
 void efi_setup_console_size(void);
+
+/**
+ * efi_console_set_ansi() - Set whether ANSI characters should be emitted
+ *
+ * These characters mess up tests which use ut_assert_nextline(). Call this
+ * function to tell efi_loader not to emit these characters when starting up the
+ * terminal
+ *
+ * @allow_ansi: Allow emitting ANSI characters
+ */
+void efi_console_set_ansi(bool allow_ansi);
+
 /* Set up load options from environment variable */
 efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 				      u16 **load_options);
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index cea50c748aa..569fc9199bc 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -30,6 +30,17 @@ struct cout_mode {
 
 __maybe_unused static struct efi_object uart_obj;
 
+/*
+ * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
+ * default behaviour
+ */
+static bool no_ansi;
+
+void efi_console_set_ansi(bool allow_ansi)
+{
+	no_ansi = !allow_ansi;
+}
+
 static struct cout_mode efi_cout_modes[] = {
 	/* EFI Mode 0 is 80x25 and always present */
 	{
@@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
 	return 0;
 }
 
-/**
- * efi_setup_console_size() - update the mode table.
- *
- * By default the only mode available is 80x25. If the console has at least 50
- * lines, enable mode 80x50. If we can query the console size and it is neither
- * 80x25 nor 80x50, set it as an additional mode.
- */
 void efi_setup_console_size(void)
 {
 	int rows = 25, cols = 80;
@@ -362,8 +366,12 @@ void efi_setup_console_size(void)
 
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ret = query_vidconsole(&rows, &cols);
-	if (ret)
-		ret = query_console_serial(&rows, &cols);
+	if (ret) {
+		if (no_ansi)
+			ret = 0;
+		else
+			ret = query_console_serial(&rows, &cols);
+	}
 	if (ret)
 		return;
 
-- 
2.43.0

