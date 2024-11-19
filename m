Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC9CD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873AB895A6;
	Tue, 19 Nov 2024 14:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KCGlpHic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65D789715; Tue, 19 Nov 2024 14:20:37 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9F389711
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a778cc0e5cso3028215ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022434; x=1732627234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8QilyQCUKlNUobJ+i/n8LpB05yeXP0mjDoLKL6mV84=;
 b=KCGlpHick9GZWOJITQXsLztphY1w5iIolUY7qYi+gWnD8rxUy+plGkvIulMuYg7jf/
 UrujxMCsxBr0laBCxleOvNddk91nVC8aYOJkjDKOjpHCXDCDCSKpTbt/NtxCt8gv0cgg
 T6VAEAc3Tjb3Rvz0rnn4y2OgWOIqDfv51lNYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022434; x=1732627234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8QilyQCUKlNUobJ+i/n8LpB05yeXP0mjDoLKL6mV84=;
 b=g75+MeSvZiz60PxPi2DCs8VTrEpzAzfmjBM1rs1/ztxZUFQOG+c0EbM3JA3MqZCZzP
 aDq0Q7V9r9uVDQ/BW47e5f+kvWecXEFnBHbNPTul0rS9JJOCzyWmfjxZE6fCfFuI9Zim
 eFj0aPY9HprZoOwp2AgcHeXKHh1uZG64dQN3rSyI5L8IcnahmZl5fqez4P38LslXIL/F
 FC5Sm2wONtCS5MqSEOfz+g1Rr+Osg8CDh8/fPN0cYNhw15PMmarEEKPEEZ23PURxoWuh
 dIDoKmbuBDV/Ea89rj9wJgJM60kl3lRohF27JxSoN2pPXOeV/tIBvfiHISbZR7XUmEhy
 PP4A==
X-Gm-Message-State: AOJu0YyheSesCKYMGBieVOjk9K6NzIoIacBC1lSE7EOnu3xdTBbLaFnj
 kc4GZn3KC3h7DJ4T2VptpcYCAw67IY+PfcamIoyrTyMyXMX+++o2ZMOyOuRFO835EeS0maIbuWQ
 =
X-Google-Smtp-Source: AGHT+IG13gUjgPiRoSqG0pwiwGwGVqCEOkPFjqAXO/wZLcxhr6U4x3ol47SMN4mUhftI7VDF8xPP2w==
X-Received: by 2002:a05:6e02:1568:b0:3a7:464d:36a5 with SMTP id
 e9e14a558f8ab-3a748083ff2mr152034925ab.21.1732022433756; 
 Tue, 19 Nov 2024 05:20:33 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 38/39] pxe_utils: Refactor to separate reading from booting
Date: Tue, 19 Nov 2024 06:18:43 -0700
Message-Id: <20241119131844.4078144-39-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

 boot/pxe_utils.c    | 72 +++++++++++++++++++++++++++++++++++++++++----
 include/pxe_utils.h | 41 ++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 99c968a1202..01fff350f1b 100644
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

