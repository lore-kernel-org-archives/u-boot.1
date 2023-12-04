Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4713C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE354878E6;
	Mon,  4 Dec 2023 01:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kCA6Dt8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B40878E5; Mon,  4 Dec 2023 01:33:04 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453C7878E6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce2ff70619so254882b3a.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649980; x=1702254780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUYZWONrCrApEcro+TKJxnxG/sVptnx3NHfaPmuxViU=;
 b=kCA6Dt8ljfFtqLJBkH28+/ZaWyxMaFaqiI/DttpXBPtrww2nzJalQl4YwPTiEzwgd0
 E9q9pMJIzr70EazA+KNnmK4lYhifx9DMWCtdC4t4MF6B6qHX3ySqGkyIue2aQBbSUPSR
 PgfztxsktWTJEqtDdVu31YS0tHzVbM9UXgxcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649980; x=1702254780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUYZWONrCrApEcro+TKJxnxG/sVptnx3NHfaPmuxViU=;
 b=dq64OMEMrIa5kKFngNwodpzSrdxupBlaNTKs68Bsc8rcBsLTM93O71Gww88Zw7vY7c
 D6hycZwKdFUkuEXCppMF/i/QsvfujrYSheh86kYavlJ53ccYRPkWRCEwmAmci1KjX092
 Gb2yw1tnZSEPQnbws/5q/D9wLY/fhHuoRizh0IsUs/MOXO/ujprUuiajSc4HGrUTxzBH
 a5Ic5qJKeJh9pM1yN5Lzcy5UF5wp/OLmFH5lQgt+IIoGYmuQRsPThmYoh7OsIRU07oBC
 P2gc9RcFiz8y8G4mCmdqqxEP5kLMWYcEIzIF1UBDON0VlE1ETSDDPk+AyOAEOeJyTb0H
 xMeg==
X-Gm-Message-State: AOJu0YyVizg3T5WdXEORlVQ8rcGZwKZw6dQpbpBDmYaVckxy8ometV/8
 Bh6jlwSkZLJJovxPWH6IZXMZ2LKLxluPloOsqbV7WA==
X-Google-Smtp-Source: AGHT+IFsKEtE+fF80hey56Egr9WZZxLbqwaCDk26Ub+ikyMDc039oveH2CpRTTXZ7uJBSyg4RTWuQQ==
X-Received: by 2002:a05:6a00:2d0d:b0:6ce:2731:c235 with SMTP id
 fa13-20020a056a002d0d00b006ce2731c235mr840960pfb.36.1701649980454; 
 Sun, 03 Dec 2023 16:33:00 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH 09/14] pxe: Refactor to reduce the size of label_boot()
Date: Sun,  3 Dec 2023 17:31:33 -0700
Message-ID: <20231203173130.9.I66588a1ea770bbeea0a355c2e533e32344302c80@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

This function is far too long and complicated. Split out the part
which actually calls the boot commands into a separate function.

Change a strncpy() to strlcpy() to keep checkpatch happy.

No functional change is intended.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 301 +++++++++++++++++++++++++----------------------
 1 file changed, 163 insertions(+), 138 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a92bb896c63e..6fbccadd99e6 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -470,159 +470,47 @@ skip_overlay:
 #endif
 
 /**
- * label_boot() - Boot according to the contents of a pxe_label
+ * label_run_boot() - Run the correct boot procedure
  *
- * If we can't boot for any reason, we return.  A successful boot never
- * returns.
+ * fdt usage is optional:
+ * It handles the following scenarios.
  *
- * The kernel will be stored in the location given by the 'kernel_addr_r'
- * environment variable.
+ * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
+ * defined in pxe file, retrieve fdt blob from server. Pass fdt_addr_r to
+ * bootm, and adjust argc appropriately.
  *
- * If the label specifies an initrd file, it will be stored in the location
- * given by the 'ramdisk_addr_r' environment variable.
+ * If retrieve fails and no exact fdt blob is specified in pxe file with
+ * "fdt" label, try Scenario 2.
  *
- * If the label specifies an 'append' line, its contents will overwrite that
- * of the 'bootargs' environment variable.
+ * Scenario 2: If there is an fdt_addr specified, pass it along to
+ * bootm, and adjust argc appropriately.
+ *
+ * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
+ * bootm, and adjust argc appropriately, unless the image type is fitImage.
+ *
+ * Scenario 4: fdt blob is not available.
  *
  * @ctx: PXE context
  * @label: Label to process
+ * @kernel_addr: string containing the kernel address / config
+ * @initrd_str: string containing the initrd address / size
+ * @initrd_addr_str: initrd address, or NULL if none
+ * @initrd_filesize: initrd size in bytes; only valid if initrd_addr_str is not
+ *	NULL
  * Returns does not return on success, otherwise returns 0 if a localboot
  *	label was processed, or 1 on error
  */
-static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
+static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
+			  char *kernel_addr, char *initrd_str,
+			  char *initrd_addr_str, char *initrd_filesize)
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
-				NULL) < 0) {
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
-			strncpy(bootargs, label->append, sizeof(bootargs));
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
-	/*
-	 * fdt usage is optional:
-	 * It handles the following scenarios.
-	 *
-	 * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
-	 * defined in pxe file, retrieve fdt blob from server. Pass fdt_addr_r to
-	 * bootm, and adjust argc appropriately.
-	 *
-	 * If retrieve fails and no exact fdt blob is specified in pxe file with
-	 * "fdt" label, try Scenario 2.
-	 *
-	 * Scenario 2: If there is an fdt_addr specified, pass it along to
-	 * bootm, and adjust argc appropriately.
-	 *
-	 * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
-	 * bootm, and adjust argc appropriately, unless the image type is fitImage.
-	 *
-	 * Scenario 4: fdt blob is not available.
-	 */
 	bootm_argv[3] = env_get("fdt_addr_r");
 
 	/* For FIT, the label can be identical to kernel one */
@@ -637,6 +525,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 			fdtfile = label->fdt;
 		} else if (label->fdtdir) {
 			char *f1, *f2, *f3, *f4, *slash;
+			int len;
 
 			f1 = env_get("fdtfile");
 			if (f1) {
@@ -679,7 +568,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 			fdtfilefree = malloc(len);
 			if (!fdtfilefree) {
 				printf("malloc fail (FDT filename)\n");
-				goto cleanup;
+				return -ENOMEM;
 			}
 
 			snprintf(fdtfilefree, len, "%s%s%s%s%s%s",
@@ -698,7 +587,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 				if (label->fdt) {
 					printf("Skipping %s for failure retrieving FDT\n",
 					       label->name);
-					goto cleanup;
+					return -ENOENT;
 				}
 			}
 
@@ -757,6 +646,142 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 
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
+	int ret;
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
+				NULL) < 0) {
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
+		initrd_addr_str = kernel_addr;
+	} else if (label->initrd) {
+		ulong size;
+
+		if (get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
+					&size) < 0) {
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
+	ret = label_run_boot(ctx, label, kernel_addr, initrd_str,
+			     initrd_addr_str, initrd_filesize);
+
 cleanup:
 	free(fit_addr);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

