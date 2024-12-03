Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B251E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF72F8973F;
	Wed,  4 Dec 2024 00:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="km+qA9nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF2E89734; Wed,  4 Dec 2024 00:48:10 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCA18967D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8418a2f596fso199892439f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269686; x=1733874486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJL4HiTJ1SC4AIkNl6lQjH+Cq4cPjeb6520ASidXSys=;
 b=km+qA9nmxxE6XrbFst50WVxQeFZkkW6q8slHXMZ05GySFSEXFdYw8noFXNNSThLsKZ
 gp4iLg+Xmj0YU2K0M5aLXXqoWZuVS3zvIuuGOfkojRF7hm7IMHUhpOKa3BYgXLYZQazw
 UfX48zZC95aDxylnX1AvcmjGS4lFF/HO3oN0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269686; x=1733874486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJL4HiTJ1SC4AIkNl6lQjH+Cq4cPjeb6520ASidXSys=;
 b=EiCjnVGPeROLAMGJdMhdDRbN5+oGPeeJdC0VIYXJKVNMZO4Q19soAxENRFRbXSF2hQ
 d9x39DaQaYhe0hX2TxaXwALoBjun2NhbvbOtzezj1akRqf9j9scy92Oum24PSSmUXyZk
 2PmQI8yOf0a88jQa5C0RWpiCZJmDqrfDb3y9p/ilENtqLsJ8IoB6giHlJsujAjrs/LT7
 ClGiCkDe8YgNV9UnOGW5oy5Kt/5TxcYAUX0jWeW3zw7hbPHSl2Zmncn++bRWxJ+sXHAv
 fyd7Frc3e1XEFqQCkqfiQdSiBJd3rMHJIHKudpEFHKVckWUH5zcWpEWZyn3luW8TWejd
 jHYQ==
X-Gm-Message-State: AOJu0Yy5FruTGxe2h7n9Sb9miYkIpzn6gDyPfnoUb5JVL85OLO8Insul
 c7sg7QY41QaYvnoycHmxpSFDCHmvUyUrBhkwR198LrIKbwtm4XaA9QgX1ie6SYGG5DNVnaOD+PI
 =
X-Gm-Gg: ASbGncthFuIkLL8ZVPUowgOmSDd/oen1f15PFNjCZCKVesjipTSIlJqYszY8W8MyULm
 aLKVpkXDPML3BbeJ6ClQ/KhuOBbAQhiKY/q+gRIOMNWyt4/C3dOA4NKPMvyQMthBcfjBHF+U82L
 sRz9Hb9HZAsJCNDwPtEPIJcc/ElBiSHEKNMIekVAMS+W4aHyuj+8VP3Pl39n8gMLLB+iX3k68k8
 31IYRYCIcR0EwnLvyfZ4C7pb0neHleeW8J6rUeu+RkRaUWt1QjpTfSmdLNJGqmB1vi54tzupzPb
 FQNYngjg1oE=
X-Google-Smtp-Source: AGHT+IEjjqiWgM2tFWvdfDH8Iz5gM7ZVgFu/I2d5dlCIoodAFnY1osytVO6g+BEKqtNXjbCQjplZ1A==
X-Received: by 2002:a05:6602:6013:b0:83a:ab63:20b with SMTP id
 ca18e2360f4ac-8445b556cf6mr547693739f.4.1733269686457; 
 Tue, 03 Dec 2024 15:48:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:48:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 40/41] pxe_utils: Refactor to separate reading from booting
Date: Tue,  3 Dec 2024 16:45:58 -0700
Message-Id: <20241203234559.2938192-41-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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
index 1468a8e8498..a76fa68f832 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -796,8 +796,31 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
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
@@ -1689,18 +1712,29 @@ void pxe_destroy_ctx(struct pxe_context *ctx)
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
 
@@ -1708,3 +1742,31 @@ int pxe_process(struct pxe_context *ctx, ulong pxefile_addr_r, bool prompt)
 
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

