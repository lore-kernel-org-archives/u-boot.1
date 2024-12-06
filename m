Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34380E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D988979B;
	Fri,  6 Dec 2024 03:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e6+S0un1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677F98978D; Fri,  6 Dec 2024 03:38:37 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1627D89794
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a7a46ca756so5316935ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452713; x=1734057513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+0MII1wQkO+/NRRSb/EhLD0lRD5dPjuS+jMfskJkjA=;
 b=e6+S0un1Ej6zSuY0uGcb6Rv/JA0ZchrR0f9H5QgGA2QEjTbY5vSZpHRUnE47xlrMAX
 B9OZdqQBYOxFMB1AxNqCKdFSszqygjPF025TwFuvTR/6Mp/h7v8rgCmph5lSY34oy8qP
 W5vsIe0qgsBxtFP9jo4eIoOPSd6B5shZL1POo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452713; x=1734057513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+0MII1wQkO+/NRRSb/EhLD0lRD5dPjuS+jMfskJkjA=;
 b=Ymm0f8T5wCWLf6/TZ6dlAuh83FZUVQHsOga5w9VLUS+zCuHvqBcjvhyrMOthaRuxr6
 sEklVu1f5LKEZJ4Brv0xxhih3r4WIt5EJ0xzeFnw+I8SIDCkZP+fuGgPrejblOoRJZ9V
 fAqt5OslmmVmdAiVSl/sTsMn5b/EIG1B5TA+EYutwJg2z7v3qW2Bv5uzAB/nKTfV6qXo
 WgW1/FALRyx9tpqo4yTBvM2Q/lTFuoZetwR5m8bBI2LpynmtwXoBeCwh9xIU4fQJiEWg
 jIOwD1lFN15uulA//Cj3UilT9bREUM4UeQoFOUmINMrR3c2DK3idN7V+frpHHqI7w7Zi
 XLag==
X-Gm-Message-State: AOJu0YzD6KI+4snzfKxFBmjGwJf2iFqeT5G7cQAQUatqoyU6qWmyxo28
 TcLQmDyrp/pX8UidSB7gwomRLfTgzyLVYvuD3+dtyV1kpm8m2IZkf7YePG5wJM+EDFFbAzcfoGM
 =
X-Gm-Gg: ASbGncuH6D3JRp4qyNFDULn1xTYs6YwIF7IFjQZkUV6IraXu9s6BX99a9i944Ej8ox7
 hzQujBd1YtQ6Av9RToAGAImdMmxQl4BWlSgvZQ4a8AhTGPl7nEtrtZ7r9Tf1PK1y0UGZVwkJ/BF
 HIW+Orxod52FMj66N7OGiENb2SEPCuQ225eMEH7miM7Y+6csMHb6Rq9G+OYAnIExIO6JdFqoWaQ
 hIHBwxBvtoY9RxkcVfC10KHx8vOiPPRVZMasdyPHwCJgqwjj3zBghKduP7BwIKC+k+fzY1cyfA+
 fvY0Suk1/LA=
X-Google-Smtp-Source: AGHT+IEf3wkbvZZl7w8UrC4FD528Gnp60C9Itj9W7Hd0P3+KNfD+AuhPJItFkWSV7vY9UE88G3xPXA==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:e528:6edd with SMTP id
 e9e14a558f8ab-3a811db7d25mr20137395ab.12.1733452712677; 
 Thu, 05 Dec 2024 18:38:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 45/46] pxe_utils: Refactor to separate reading from booting
Date: Thu,  5 Dec 2024 19:36:24 -0700
Message-Id: <20241206023626.2456858-46-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

It is useful to be able to select a bootflow and read its images,
without actually doing the boot. This allows adjusting the bootargs, for
example.

Provide support for this in the pxe_utils module, by adding a 'probe'
method which selects a label and saves its settings, so it can be booted
later, if desired.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c    | 72 +++++++++++++++++++++++++++++++++++++++++----
 include/pxe_utils.h | 41 ++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 71347b19119..3a4caa9329a 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -802,8 +802,31 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	if (ctx->bflow)
 		ctx->bflow->fdt_addr = hextoul(conf_fdt, NULL);
 
-	if (ctx->no_boot)
+	if (IS_ENABLED(CONFIG_BOOTSTD_FULL) && ctx->no_boot) {
+		ctx->label = label;
+		ctx->kernel_addr = strdup(kernel_addr);
+		if (initrd_addr_str) {
+			ctx->initrd_addr_str = strdup(initrd_addr_str);
+			ctx->initrd_filesize = strdup(initrd_filesize);
+			ctx->initrd_str = strdup(initrd_str);
+		}
+		ctx->conf_fdt = strdup(conf_fdt);
+		log_debug("Saving label '%s':\n", label->name);
+		log_debug("- kernel_addr '%s' conf_fdt '%s'\n",
+			  ctx->kernel_addr, ctx->conf_fdt);
+		if (initrd_addr_str) {
+			log_debug("- initrd addr '%s' filesize '%s' str '%s'\n",
+				  ctx->initrd_addr_str, ctx->initrd_filesize,
+				  ctx->initrd_str);
+		}
+		if (!ctx->kernel_addr || !ctx->conf_fdt ||
+		    (initrd_addr_str && (!ctx->initrd_addr_str ||
+		     !ctx->initrd_filesize || !ctx->initrd_str))) {
+			printf("malloc fail (saving label)\n");
+			return 1;
+		}
 		return 0;
+	}
 
 	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
 		       initrd_filesize, initrd_str, conf_fdt);
@@ -1695,18 +1718,29 @@ void pxe_destroy_ctx(struct pxe_context *ctx)
 	free(ctx->bootdir);
 }
 
-int pxe_process(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt)
+struct pxe_menu *pxe_prepare(struct pxe_context *ctx, ulong pxefile_addr_r,
+			     bool prompt)
 {
 	struct pxe_menu *cfg;
 
 	cfg = parse_pxefile(ctx, pxefile_addr_r);
 	if (!cfg) {
 		printf("Error parsing config file\n");
-		return 1;
+		return NULL;
 	}
 
-	if (prompt)
-		cfg->prompt = 1;
+	cfg->prompt = prompt;
+
+	return cfg;
+}
+
+int pxe_process(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt)
+{
+	struct pxe_menu *cfg;
+
+	cfg = pxe_prepare(ctx, pxefile_addr_r, prompt);
+	if (!cfg)
+		return 1;
 
 	handle_pxe_menu(ctx, cfg);
 
@@ -1714,3 +1748,31 @@ int pxe_process(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt)
 
 	return 0;
 }
+
+int pxe_probe(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt)
+{
+	ctx->cfg = pxe_prepare(ctx, pxefile_addr_r, prompt);
+	if (!ctx->cfg)
+		return -EINVAL;
+	ctx->no_boot = true;
+
+	handle_pxe_menu(ctx, ctx->cfg);
+
+	return 0;
+}
+
+int pxe_do_boot(struct pxe_context *ctx)
+{
+	int ret;
+
+	if (!ctx->label)
+		return log_msg_ret("pxb", -ENOENT);
+
+	ret = label_run_boot(ctx, ctx->label, ctx->kernel_addr,
+			     ctx->initrd_addr_str, ctx->initrd_filesize,
+			     ctx->initrd_str, ctx->conf_fdt);
+	if (ret)
+		return log_msg_ret("lrb", ret);
+
+	return 0;
+}
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index beadd221475..6425e349d19 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -111,6 +111,16 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  *	"default" option as default
  * @no_boot: Stop show of actually booting and just return
  * @bflow: Bootflow being booted, or NULL if none (must be valid if @no_boot)
+ * @cfg: PXE menu (NULL if not yet probed)
+ *
+ * The following are only used when probing for a label
+ * @label: Label to process
+ * @kernel_addr: String containing kernel address (cannot be NULL)
+ * @initrd_addr_str: String containing initaddr address (NULL if none)
+ * @initrd_filesize: String containing initrd size (only used if
+ *	@initrd_addr_str)
+ * @initrd_str: initrd string to process (only used if @initrd_addr_str)
+ * @conf_fdt: string containing the FDT address
  */
 struct pxe_context {
 	/**
@@ -133,6 +143,15 @@ struct pxe_context {
 	bool use_fallback;
 	bool no_boot;
 	struct bootflow *bflow;
+	struct pxe_menu *cfg;
+
+	/* information on the selected label to boot */
+	struct pxe_label *label;
+	char *kernel_addr;
+	char *initrd_addr_str;
+	char *initrd_filesize;
+	char *initrd_str;
+	char *conf_fdt;
 };
 
 /**
@@ -283,4 +302,26 @@ int pxe_get_file_size(ulong *sizep);
  */
 int pxe_get(ulong pxefile_addr_r, char **bootdirp, ulong *sizep, bool use_ipv6);
 
+/**
+ * pxe_probe() - Process a PXE file to find the label to boot
+ *
+ * This fills in the label, etc. fields in @ctx, assuming it funds something to
+ * boot. Then pxe_do_boot() can be called to boot it.
+ *
+ * @ctx: PXE context created with pxe_setup_ctx()
+ * @pxefile_addr_r: Address to load file
+ * @prompt: Force a prompt for the user
+ * Return: 0 if OK, -ve on error
+ */
+int pxe_probe(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt);
+
+/**
+ * pxe_do_boot() - Boot the selected label
+ *
+ * This boots the label discovered by pxe_probe()
+ *
+ * Return: Does not return, on success, otherwise returns a -ve error code
+ */
+int pxe_do_boot(struct pxe_context *ctx);
+
 #endif /* __PXE_UTILS_H */
-- 
2.34.1

