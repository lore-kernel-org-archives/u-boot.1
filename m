Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF1DC54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDA088A34;
	Mon,  2 Sep 2024 03:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MW/llu1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF1188B0C; Mon,  2 Sep 2024 03:18:49 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E50E88717
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d3cd4fa49so12025935ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239926; x=1725844726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fHFqiEb/an93PtFX+BLCkE6/YVYMa2Q9B8rwdB3tC4=;
 b=MW/llu1Ss+O+LguK+sg1AETMe4/LAdpLPynX7C4qOzbdK4IVy3fipXNkN075Bhtyj3
 rEBu6tqk7Y50mqQz5m2TF9tYoByJR42HM6qsy6r4FSTVqjRYlGgD3zWj31sT5vPuCEww
 oP0BEKwdtzdJNchztzbhhWoBz20U4DZqfbn8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239926; x=1725844726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fHFqiEb/an93PtFX+BLCkE6/YVYMa2Q9B8rwdB3tC4=;
 b=bzOXIj8asKdBjBd3/2+hS5fdjE91z48hRDZ5jp8xlW4I6G2vs1ZDEiJ8qVRLX3zYfZ
 pZw1+pWa9c9tpuUcwbRl+xgkBi6/NOXValOOoyk89Vj55Dhuiw33tfyNIjELctNQag4S
 JEEsrts+feCBVPWzfDJo4Vy1uieQAdQdn9JFKQONMfliVuw/d0tnvE4kXk+ik4mMNcxB
 ab52VaZ6MzmyF//JYudgwPuZI2FxFClC2EHg2lusYyoBk1oBFjByDFCmBS7UA+FIshrf
 Ph57a9EHVEvO3Z0kqqSMw/pH82PhyZmfWPdZAdyq7FwF9p3GDcfVrSyEOZ5Kz9Hi9H8A
 UM+w==
X-Gm-Message-State: AOJu0YzQXuDpp1k89q7uxZVMQG1piG5oxZRFHPRKpL5E//uM2jyJDZI8
 86arsOwR9U55AK5fNPBWZN/Di74IoEIHYvrXuEXN2oMvw0q3qScPqYaN9beBEEDLu1kbYetdQ40
 =
X-Google-Smtp-Source: AGHT+IGML1j2Xu51cs5N0DOU91P8sJ8getjYqmyU88KkGR1WfpkfDv8NjJiVfB4xxyj5c0NW6xjNqA==
X-Received: by 2002:a92:cd88:0:b0:39d:6377:7c02 with SMTP id
 e9e14a558f8ab-39f38aee5e6mr80347835ab.4.1725239925822; 
 Sun, 01 Sep 2024 18:18:45 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
Date: Sun,  1 Sep 2024 19:18:21 -0600
Message-Id: <20240902011825.746421-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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
2.34.1

