Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C65E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45CB896A2;
	Wed,  4 Dec 2024 00:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ts83hlSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D70389686; Wed,  4 Dec 2024 00:46:43 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C43C896AF
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so198966239f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269599; x=1733874399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YZrj0aGdQByU50IUsiB/xBSQ+EYu9uFmNxA4aX4IzI=;
 b=Ts83hlSA3VlR1gtdNYg78M/faWWNlpfGRg4duTjoICSvXOc3HuGdVhkg3Ei2VNNj+N
 7nR3hLMQ2cSYh6KQsIUtJdXwe0fdoIQlcaDqn5uE2lz5aej4Hl/jvekDPakMgYOAzMRQ
 MQTx8Nmjj6X9LtQKx4rd1kGtAHLn35Y/7RBbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269599; x=1733874399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YZrj0aGdQByU50IUsiB/xBSQ+EYu9uFmNxA4aX4IzI=;
 b=Ql8cp0TzkGJWUMva9c41DoFuh2QYno7wKy9WE2PK6T3xXzvj2vC/QzWr8fkVATsWyG
 krY6oXqCo1zo3hPpg0YFgZqui5lVlUFgSvNTGrJRvH6mGxRGVQz0gVfU5EeoZAZ01DY3
 mKB1e9JKNO/Bumfnav2ykTNmV8BWnQSzVgudLAfKQ6cLU0gJd2j3sy5ZUzJwEn99VpGz
 BBrqKyGl9YiJEzYJfqvK3Pyfeaz+NgafRVNalc/1DzhdyDPEZXQ+MojWi1S15OgA7TzX
 W4bJtlXwFoHZJQM6CPK678Mx8aJImLzFmHajfemx3pGGXvIlJTaYOcDSH37tzsgEFhg6
 JaiA==
X-Gm-Message-State: AOJu0Ywo+ig7QozSXd1A9dJj9iXdDiH/9VjFNxUE0TcapjYVLRfR56ir
 kg/gfPTLU7AgquSvWeRhfx6VRczf63wSDoEVAQMAD1PksjpyMKIh1mQvQzU2E4dOQrPc6PwkSFc
 =
X-Gm-Gg: ASbGncssfKREVkiL0+oTfbBFH2ITwWtKXHyJdSzI9MZXdjyB4lZC+qRLMqMKiggmj6r
 34tTD3zgvetgHf5BIYR5SAc5Shw/f53aT0AT6evUaQMTEuY6mSYIPxd7n5ukC0upA/CduI1NNgP
 XwRgjbDrcHb2YbDsaTezHZwaFWX5WQ/fX8eq+FoPqkf2s+K5j1NkLmkMt5kehyQL4+oVjDKyXEG
 NEkCfz6kcu1t0RbLoBWkK0G0X/HBTsAcrzos1aP427dyvm6AR+1ijRtHSbJK9J2fBuws2vDPI9F
 X6Zff6fnaqE=
X-Google-Smtp-Source: AGHT+IEIUGEMJAjNz4f7uWkkxqOxrnVMc1WFZOHSVxRfNs5eiov2id/T6cpKP6Xjj7zRFhuqfeUMRA==
X-Received: by 2002:a05:6602:1653:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-8445b546654mr686622239f.3.1733269598797; 
 Tue, 03 Dec 2024 15:46:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 10/41] boot: Split pxe label_boot() into two parts
Date: Tue,  3 Dec 2024 16:45:28 -0700
Message-Id: <20241203234559.2938192-11-sjg@chromium.org>
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

This function is far too long. Split out the part which builds and runs
the bootm/i/z commands into its own function.

Add a function comment for the new label_run_boot() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Move strlcpy() change into an earlier patch
- Fix 'initaddr' typo'

 boot/pxe_utils.c | 284 ++++++++++++++++++++++++++---------------------
 1 file changed, 156 insertions(+), 128 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index e96935896a9..fd1a09225e1 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -433,142 +433,29 @@ skip_overlay:
 #endif
 
 /**
- * label_boot() - Boot according to the contents of a pxe_label
- *
- * If we can't boot for any reason, we return.  A successful boot never
- * returns.
- *
- * The kernel will be stored in the location given by the 'kernel_addr_r'
- * environment variable.
- *
- * If the label specifies an initrd file, it will be stored in the location
- * given by the 'ramdisk_addr_r' environment variable.
- *
- * If the label specifies an 'append' line, its contents will overwrite that
- * of the 'bootargs' environment variable.
+ * label_run_boot() - Set up the FDT and call the appropriate bootm/z/i command
  *
  * @ctx: PXE context
  * @label: Label to process
- * Returns does not return on success, otherwise returns 0 if a localboot
- *	label was processed, or 1 on error
+ * @kernel_addr: String containing kernel address (cannot be NULL)
+ * @initrd_addr_str: String containing initrd address (NULL if none)
+ * @initrd_filesize: String containing initrd size (only used if
+ *	@initrd_addr_str)
+ * @initrd_str: initrd string to process (only used if @initrd_addr_str)
+ * Return: does not return on success, or returns 0 if the boot command
+ * returned, or -ve error value on error
  */
-static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
+static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
+			  char *kernel_addr, char *initrd_addr_str,
+			  char *initrd_filesize, char *initrd_str)
 {
 	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
-	char *kernel_addr = NULL;
-	char *initrd_addr_str = NULL;
-	char initrd_filesize[10];
-	char initrd_str[28];
-	char mac_str[29] = "";
-	char ip_str[68] = "";
-	char *fit_addr = NULL;
+	ulong kernel_addr_r;
 	int bootm_argc = 2;
 	int zboot_argc = 3;
-	int len = 0;
-	ulong kernel_addr_r;
 	void *buf;
 
-	label_print(label);
-
-	label->attempted = 1;
-
-	if (label->localboot) {
-		if (label->localboot_val >= 0)
-			label_localboot(label);
-		return 0;
-	}
-
-	if (!label->kernel) {
-		printf("No kernel given, skipping %s\n",
-		       label->name);
-		return 1;
-	}
-
-	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
-				(enum bootflow_img_t)IH_TYPE_KERNEL, NULL)
-				< 0) {
-		printf("Skipping %s for failure retrieving kernel\n",
-		       label->name);
-		return 1;
-	}
-
-	kernel_addr = env_get("kernel_addr_r");
-	/* for FIT, append the configuration identifier */
-	if (label->config) {
-		int len = strlen(kernel_addr) + strlen(label->config) + 1;
-
-		fit_addr = malloc(len);
-		if (!fit_addr) {
-			printf("malloc fail (FIT address)\n");
-			return 1;
-		}
-		snprintf(fit_addr, len, "%s%s", kernel_addr, label->config);
-		kernel_addr = fit_addr;
-	}
-
-	/* For FIT, the label can be identical to kernel one */
-	if (label->initrd && !strcmp(label->kernel_label, label->initrd)) {
-		initrd_addr_str =  kernel_addr;
-	} else if (label->initrd) {
-		ulong size;
-		if (get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
-					(enum bootflow_img_t)IH_TYPE_RAMDISK,
-					&size) < 0) {
-			printf("Skipping %s for failure retrieving initrd\n",
-			       label->name);
-			goto cleanup;
-		}
-		strcpy(initrd_filesize, simple_xtoa(size));
-		initrd_addr_str = env_get("ramdisk_addr_r");
-		size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
-				initrd_addr_str, size);
-		if (size >= sizeof(initrd_str))
-			goto cleanup;
-	}
-
-	if (label->ipappend & 0x1) {
-		sprintf(ip_str, " ip=%s:%s:%s:%s",
-			env_get("ipaddr"), env_get("serverip"),
-			env_get("gatewayip"), env_get("netmask"));
-	}
-
-	if (IS_ENABLED(CONFIG_CMD_NET))	{
-		if (label->ipappend & 0x2) {
-			int err;
-
-			strcpy(mac_str, " BOOTIF=");
-			err = format_mac_pxe(mac_str + 8, sizeof(mac_str) - 8);
-			if (err < 0)
-				mac_str[0] = '\0';
-		}
-	}
-
-	if ((label->ipappend & 0x3) || label->append) {
-		char bootargs[CONFIG_SYS_CBSIZE] = "";
-		char finalbootargs[CONFIG_SYS_CBSIZE];
-
-		if (strlen(label->append ?: "") +
-		    strlen(ip_str) + strlen(mac_str) + 1 > sizeof(bootargs)) {
-			printf("bootarg overflow %zd+%zd+%zd+1 > %zd\n",
-			       strlen(label->append ?: ""),
-			       strlen(ip_str), strlen(mac_str),
-			       sizeof(bootargs));
-			goto cleanup;
-		}
-
-		if (label->append)
-			strlcpy(bootargs, label->append, sizeof(bootargs));
-
-		strcat(bootargs, ip_str);
-		strcat(bootargs, mac_str);
-
-		cli_simple_process_macros(bootargs, finalbootargs,
-					  sizeof(finalbootargs));
-		env_set("bootargs", finalbootargs);
-		printf("append: %s\n", finalbootargs);
-	}
-
 	/*
 	 * fdt usage is optional:
 	 * It handles the following scenarios.
@@ -607,6 +494,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 			}
 		} else if (label->fdtdir) {
 			char *f1, *f2, *f3, *f4, *slash;
+			int len;
 
 			f1 = env_get("fdtfile");
 			if (f1) {
@@ -649,7 +537,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 			fdtfilefree = malloc(len);
 			if (!fdtfilefree) {
 				printf("malloc fail (FDT filename)\n");
-				goto cleanup;
+				return -ENOMEM;
 			}
 
 			snprintf(fdtfilefree, len, "%s%s%s%s%s%s",
@@ -669,7 +557,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 				if (label->fdt) {
 					printf("Skipping %s for failure retrieving FDT\n",
 					       label->name);
-					goto cleanup;
+					return -ENOENT;
 				}
 
 				if (label->fdtdir) {
@@ -750,10 +638,150 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 
 	unmap_sysmem(buf);
 
+	return 0;
+}
+
+/**
+ * label_boot() - Boot according to the contents of a pxe_label
+ *
+ * If we can't boot for any reason, we return.  A successful boot never
+ * returns.
+ *
+ * The kernel will be stored in the location given by the 'kernel_addr_r'
+ * environment variable.
+ *
+ * If the label specifies an initrd file, it will be stored in the location
+ * given by the 'ramdisk_addr_r' environment variable.
+ *
+ * If the label specifies an 'append' line, its contents will overwrite that
+ * of the 'bootargs' environment variable.
+ *
+ * @ctx: PXE context
+ * @label: Label to process
+ * Returns does not return on success, otherwise returns 0 if a localboot
+ *	label was processed, or 1 on error
+ */
+static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
+{
+	char *kernel_addr = NULL;
+	char *initrd_addr_str = NULL;
+	char initrd_filesize[10];
+	char initrd_str[28];
+	char mac_str[29] = "";
+	char ip_str[68] = "";
+	char *fit_addr = NULL;
+
+	label_print(label);
+
+	label->attempted = 1;
+
+	if (label->localboot) {
+		if (label->localboot_val >= 0)
+			label_localboot(label);
+		return 0;
+	}
+
+	if (!label->kernel) {
+		printf("No kernel given, skipping %s\n",
+		       label->name);
+		return 1;
+	}
+
+	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
+				(enum bootflow_img_t)IH_TYPE_KERNEL, NULL)
+				< 0) {
+		printf("Skipping %s for failure retrieving kernel\n",
+		       label->name);
+		return 1;
+	}
+
+	kernel_addr = env_get("kernel_addr_r");
+	/* for FIT, append the configuration identifier */
+	if (label->config) {
+		int len = strlen(kernel_addr) + strlen(label->config) + 1;
+
+		fit_addr = malloc(len);
+		if (!fit_addr) {
+			printf("malloc fail (FIT address)\n");
+			return 1;
+		}
+		snprintf(fit_addr, len, "%s%s", kernel_addr, label->config);
+		kernel_addr = fit_addr;
+	}
+
+	/* For FIT, the label can be identical to kernel one */
+	if (label->initrd && !strcmp(label->kernel_label, label->initrd)) {
+		initrd_addr_str =  kernel_addr;
+	} else if (label->initrd) {
+		ulong size;
+		int ret;
+
+		ret = get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
+					  (enum bootflow_img_t)IH_TYPE_RAMDISK,
+					  &size);
+		if (ret < 0) {
+			printf("Skipping %s for failure retrieving initrd\n",
+			       label->name);
+			goto cleanup;
+		}
+		strcpy(initrd_filesize, simple_xtoa(size));
+		initrd_addr_str = env_get("ramdisk_addr_r");
+		size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
+				initrd_addr_str, size);
+		if (size >= sizeof(initrd_str))
+			goto cleanup;
+	}
+
+	if (label->ipappend & 0x1) {
+		sprintf(ip_str, " ip=%s:%s:%s:%s",
+			env_get("ipaddr"), env_get("serverip"),
+			env_get("gatewayip"), env_get("netmask"));
+	}
+
+	if (IS_ENABLED(CONFIG_CMD_NET))	{
+		if (label->ipappend & 0x2) {
+			int err;
+
+			strcpy(mac_str, " BOOTIF=");
+			err = format_mac_pxe(mac_str + 8, sizeof(mac_str) - 8);
+			if (err < 0)
+				mac_str[0] = '\0';
+		}
+	}
+
+	if ((label->ipappend & 0x3) || label->append) {
+		char bootargs[CONFIG_SYS_CBSIZE] = "";
+		char finalbootargs[CONFIG_SYS_CBSIZE];
+
+		if (strlen(label->append ?: "") +
+		    strlen(ip_str) + strlen(mac_str) + 1 > sizeof(bootargs)) {
+			printf("bootarg overflow %zd+%zd+%zd+1 > %zd\n",
+			       strlen(label->append ?: ""),
+			       strlen(ip_str), strlen(mac_str),
+			       sizeof(bootargs));
+			goto cleanup;
+		}
+
+		if (label->append)
+			strlcpy(bootargs, label->append, sizeof(bootargs));
+
+		strcat(bootargs, ip_str);
+		strcat(bootargs, mac_str);
+
+		cli_simple_process_macros(bootargs, finalbootargs,
+					  sizeof(finalbootargs));
+		env_set("bootargs", finalbootargs);
+		printf("append: %s\n", finalbootargs);
+	}
+
+	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
+		       initrd_filesize, initrd_str);
+	/* ignore the error value since we are going to fail anyway */
+
 cleanup:
 	free(fit_addr);
 
-	return 1;
+	return 1;	/* returning is always failure */
 }
 
 /** enum token_type - Tokens for the pxe file parser */
-- 
2.34.1

