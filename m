Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C7C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E13487498;
	Thu, 16 Nov 2023 05:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZjcNTxPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5F48747E; Thu, 16 Nov 2023 05:11:29 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F62E87463
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b06afbd3cdso13695739f.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107885; x=1700712685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fEiG6ygPn49L0QzdEP+Az3DUJ0GD8lqNixhGFnsDVA=;
 b=ZjcNTxPXcW3P7wWiu4lLQkIYEn24/Rg2FtIRS+35HBP8miwfbdZ1itC9/VM4YQ+t07
 yBuWEdxx+5dWgHvrYaxK9qbDqIdkLWPaq+JN6IRRFrX+YuNOUw//sRS2a5pQJ+dyxgla
 TyKpfMGnjQ/+W2K+8XaX9n0GmPaWGznkkyNiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107885; x=1700712685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fEiG6ygPn49L0QzdEP+Az3DUJ0GD8lqNixhGFnsDVA=;
 b=cM1R9D+xrNBBOjy+B2cMkImS3EtRR5aCjCpQlNDPqebUX2h+XN1vc2dh06S+3G0LFQ
 rZxZ2QMNuttJ+x/3PSKAi4a8pXWVKoD4C+YrR6D6uzjq//b04l58Qe5VASxvDpJVROMs
 5ubR1Mjc6DGOQ2L52TY6TbmMrfKUEKEoLkEk4mpKH1KgnjGzGvKuqM9AA+P6Qrx78+JF
 rhMhWR6FhcDgf1wITYYwGkJ6SL2kdDVX7LAOGmkmXNKrYb0zleSRCT7AbwUBwPUAdrxt
 xe410pbgXHNwYBauKfMhtBqTrSMwvqOVwpgu+iLoaU5gJ1U8KQyymTT2JvmSlfNYjeHc
 Gvqw==
X-Gm-Message-State: AOJu0YwoCCTVkS684Zd6+G7Xo9YzOe1NgvOPVYmdW18aXLctCvJWmniW
 f2EW39vaJl1YV+V3t65jHff344Q3ZFe4gD7RQFHegg==
X-Google-Smtp-Source: AGHT+IHhGB35u9PTeBp6Qc7aFQ6cNYAlUqrB5BezhNw2X7MISVpDgTZs4Cua++vQseyRJe/f+kIM0A==
X-Received: by 2002:a5d:9b04:0:b0:79f:da3d:c47f with SMTP id
 y4-20020a5d9b04000000b0079fda3dc47fmr17281814ion.13.1700107885743; 
 Wed, 15 Nov 2023 20:11:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 08/32] bootm: Simplify arguments for bootm_pre_load()
Date: Wed, 15 Nov 2023 21:10:08 -0700
Message-ID: <20231116041043.362055-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

Move the argument decoding to the caller, to avoid needing to pass the
command-line arguments.

Add a function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index fda97706fc26..1482a2cc783f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -82,22 +82,31 @@ static int bootm_start(void)
 	return 0;
 }
 
-static ulong bootm_data_addr(int argc, char *const argv[])
+static ulong bootm_data_addr(const char *addr_str)
 {
 	ulong addr;
 
-	if (argc > 0)
-		addr = simple_strtoul(argv[0], NULL, 16);
+	if (addr_str)
+		addr = hextoul(addr_str, NULL);
 	else
 		addr = image_load_addr;
 
 	return addr;
 }
 
-static int bootm_pre_load(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
+/**
+ * bootm_pre_load() - Handle the pre-load processing
+ *
+ * This can be used to do a full signature check of the image, for example.
+ * It calls image_pre_load() with the data address of the image to check.
+ *
+ * @addr_str: String containing load address in hex, or NULL to use
+ * image_load_addr
+ * Return: 0 if OK, CMD_RET_FAILURE on failure
+ */
+static int bootm_pre_load(const char *addr_str)
 {
-	ulong data_addr = bootm_data_addr(argc, argv);
+	ulong data_addr = bootm_data_addr(addr_str);
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
@@ -785,7 +794,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(cmdtp, flag, argc, argv);
+		ret = bootm_pre_load(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(cmdtp, flag, argc, argv);
-- 
2.43.0.rc0.421.g78406f8d94-goog

