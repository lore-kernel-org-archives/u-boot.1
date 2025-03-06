Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE8EC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB083814A4;
	Thu,  6 Mar 2025 01:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FXbTadk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2403D81607; Thu,  6 Mar 2025 01:26:58 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEFE8144F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85ada0cf40fso2603939f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220813; x=1741825613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6e+klWtcCoAueS8ui6gvcg6KezvnhkiWU3Zc4e9ODg=;
 b=FXbTadk9i1A32/Ts4k7uSsDad9PNDxarlvvZ9wE3IXw2R7JupzmTZbinPvrKr0BaMt
 609d3kRI40/P7LhFT/hOmjUH19V0KU5Yj4xHLhZVGqS1RGKDj+Pvy8Io9OUVsg+pOpS/
 5xlddHtpV4k4wiaxptYdX7BrYkixMaXfMq/kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220813; x=1741825613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6e+klWtcCoAueS8ui6gvcg6KezvnhkiWU3Zc4e9ODg=;
 b=JY83tpb+X0CFPSCJmjkcC0al1xSs8/7lgF9n6JCd7z64CjFZjb8/R4AbobyauI7K4r
 g77qRmKtspg9lGhkMp+GhGK0FOSmcIr6+El6FasxNodW8NPdj+o/C9ktXFRmIqt0vzhE
 aM4uI4OzB/hJLyOD1XCRvKizWGqs4SXe3os1XNjwdtCUyYe+En6LWDGR8qJrsuhfqScN
 CCAHTH+yu3vU7Ux0ENQL5R8kM2YPUFZdWzlSSHWDM5sFSq0Kh99R6L0mB4DyGfIOC6xZ
 CXjEBB+grKOXFNSKRkB1wROYlDlsYk4D/LiNss8rpKyX80ZjKXX9/P0bqmcAZGfVEPWd
 npCA==
X-Gm-Message-State: AOJu0Yx55fDsAV9NjM+FM+1Ndtdok+DKCHbtcabEygNI70E20LTx7UYJ
 tyDIUzMye5UiO8pjlJgwBMA6c0K2HMtva/QzfhR2Kj+qHuiHdz5I4K92CsoJrojG8CwhfeSbLiw
 =
X-Gm-Gg: ASbGncv3i5/rDn9Xec5Xu+/yGCb5DY1cAyIFMf+nh7Lg2dqEq7ob/QFGEbFGFBZ8bLJ
 Wz6CbAgO3VwdqKeModa+E3WhqBDOum+Q6JdJ5TlE/eUkj0kCU5kwdFXbLId2FlNVgTtwLGMltCV
 klZs2HhWJnaHAHIU/RUQdVwFgAk4uj6rc/rMliMEbDlIiEo/Ga9eLjoj1nRDtLhOLjHTUIvcTJx
 COFMvJZMpq0FJIKr2DEFH5e/v0l709cyEFsf14XGKiob1YsvKoL5Znk1FN2877Veq3Dt9YBVz/m
 vFEaWSCDSAy+bV6K+4P6pvff0PbfV89kvbP5UXTcpGAgf4gKsXakxNTkjvrov9iJ/69pV8UkVSU
 SRHn5Wg==
X-Google-Smtp-Source: AGHT+IGYfr8ttDVMHl1r0xHF72eCo1+lcYk9Jwiyi7GCib5OCMtgrUn5GSshs2jBDRveIAw+5yGe5Q==
X-Received: by 2002:a05:6602:370f:b0:85a:fca9:4633 with SMTP id
 ca18e2360f4ac-85aff898813mr675834739f.2.1741220813526; 
 Wed, 05 Mar 2025 16:26:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v5 11/29] boot: Split pxe label_run_boot() into two parts
Date: Wed,  5 Mar 2025 17:25:05 -0700
Message-ID: <20250306002533.2380866-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This function is quite long. Split out the FDT processing into its own
function.

Add a function comment for the new label_process_fdt() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Rebase on earlier change

 boot/pxe_utils.c | 100 ++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index fd1a09225e1..a14b4eb54c2 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -432,51 +432,37 @@ skip_overlay:
 }
 #endif
 
-/**
- * label_run_boot() - Set up the FDT and call the appropriate bootm/z/i command
+/*
+ * label_process_fdt() - Process FDT for the label
  *
  * @ctx: PXE context
  * @label: Label to process
- * @kernel_addr: String containing kernel address (cannot be NULL)
- * @initrd_addr_str: String containing initrd address (NULL if none)
- * @initrd_filesize: String containing initrd size (only used if
- *	@initrd_addr_str)
- * @initrd_str: initrd string to process (only used if @initrd_addr_str)
- * Return: does not return on success, or returns 0 if the boot command
- * returned, or -ve error value on error
+ * @kernel_addr: String containing kernel address
+ * @bootm_argv: bootm arguments to fill in (this only adjusts @bootm_argv[3])
+ * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if FDT file could not be
+ *	loaded
+ *
+ * fdt usage is optional:
+ * It handles the following scenarios.
+ *
+ * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
+ * defined in pxe file, retrieve fdt blob from server. Pass fdt_addr_r to
+ * bootm, and adjust argc appropriately.
+ *
+ * If retrieve fails and no exact fdt blob is specified in pxe file with
+ * "fdt" label, try Scenario 2.
+ *
+ * Scenario 2: If there is an fdt_addr specified, pass it along to
+ * bootm, and adjust argc appropriately.
+ *
+ * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
+ * bootm, and adjust argc appropriately, unless the image type is fitImage.
+ *
+ * Scenario 4: fdt blob is not available.
  */
-static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
-			  char *kernel_addr, char *initrd_addr_str,
-			  char *initrd_filesize, char *initrd_str)
+static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
+			     char *kernel_addr, char *bootm_argv[])
 {
-	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
-	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
-	ulong kernel_addr_r;
-	int bootm_argc = 2;
-	int zboot_argc = 3;
-	void *buf;
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
-	bootm_argv[3] = env_get("fdt_addr_r");
-
 	/* For FIT, the label can be identical to kernel one */
 	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
 		bootm_argv[3] = kernel_addr;
@@ -578,6 +564,40 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		}
 	}
 
+	return 0;
+}
+
+/**
+ * label_run_boot() - Set up the FDT and call the appropriate bootm/z/i command
+ *
+ * @ctx: PXE context
+ * @label: Label to process
+ * @kernel_addr: String containing kernel address (cannot be NULL)
+ * @initrd_addr_str: String containing initrd address (NULL if none)
+ * @initrd_filesize: String containing initrd size (only used if
+ *	@initrd_addr_str)
+ * @initrd_str: initrd string to process (only used if @initrd_addr_str)
+ * Return: does not return on success, or returns 0 if the boot command
+ * returned, or -ve error value on error
+ */
+static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
+			  char *kernel_addr, char *initrd_addr_str,
+			  char *initrd_filesize, char *initrd_str)
+{
+	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
+	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
+	ulong kernel_addr_r;
+	int bootm_argc = 2;
+	int zboot_argc = 3;
+	void *buf;
+	int ret;
+
+	bootm_argv[3] = env_get("fdt_addr_r");
+
+	ret = label_process_fdt(ctx, label, kernel_addr, bootm_argv);
+	if (ret)
+		return ret;
+
 	bootm_argv[1] = kernel_addr;
 	zboot_argv[1] = kernel_addr;
 
-- 
2.43.0

