Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FDCE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538D2896BA;
	Wed,  4 Dec 2024 00:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cAIw0Tiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39BF6896BD; Wed,  4 Dec 2024 00:46:45 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E2A896C8
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-841a565f871so239788539f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269601; x=1733874401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8o5bpZQtB9aD8f2tNHDsQBsbfCNxBC273eNvM2aTC9Q=;
 b=cAIw0TiwCuXUlGn4+Ugk9U4jsuH44Q4xK5JI1VHThxQYybIPGXn7aTPUDee72Yns19
 qvrBk5LSl+gcicCgHtPP5GTZkXk5IYqJ3bjGqy4Q+iSiXPbJePhrADKdWxK0KadBJp7h
 RZ70TvrU1G2D4sT++H7V7vbX31LdxzGMjEvsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269601; x=1733874401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8o5bpZQtB9aD8f2tNHDsQBsbfCNxBC273eNvM2aTC9Q=;
 b=HO2Z4qOEfBy708iN+jMQdVbaSKy85FzMCSC4PEW22srMBlZogf+qK6eGwEO4aeMmnQ
 fynmxEogQIt6rs0kzqMtdIennWw/ZLz/BZH4UsPM4qwX+SGUjnnhYVWoVoBH1BoybJd9
 wrFeQ7j+CmFoU/L7b5DIClPjuGvu101EBOWCnQkfrqdcq6aDaBu39wX5it9Kc68aidPI
 DnAljMpdZfhnG9yR3shJNtNq825cns+HAUO81d4PyRi2yIJj8I61/+TeDq0GUoCcW7RJ
 S33oc3pah8hH7Ut38V3rtTCZSQswkBgJYG3dvkYQGxulv9cb6b1lYwm9nbkY7phnZ/2W
 9Wzg==
X-Gm-Message-State: AOJu0Yxs+MAc0DnxMGe/V5lBhDJokE1jqtWkraXpd0fw12PRmg8op/mB
 a4eLvIvcwUuchTeXvbg2yTKfjYopfURzXcfvuFEU/OYGfRiQvHGgCBdfIDT7P1XnQ4EX9aJ8PxA
 =
X-Gm-Gg: ASbGnctpe183gP52GM+7Q6TWUeZy2RaQx84KX9Xiu1hbtT4ZXicyo19caVw6yxarba9
 mv7FxyAiO76dKOKbCpLaL3EyM1pEeyhawRqYAs61NTdKL05X44nGlK9ebjU/gk/HcUI2hV8njR+
 7r2wJSG6L980xgy7MsedTR/o7f5OVwgheWu9CMkf95EqfievEcs3iQJXwUwgQ8Dd0SYimElDZen
 5tKresHNLPKxbZVzbXEbl6xtTLHrFK9ozIHDNpEOBTKzo3m6imM5aFxNked2jy4WGuj1N5xc2ye
 vq+dxiZBszw=
X-Google-Smtp-Source: AGHT+IHB5n+RnF0RtwdWGicf8ADR1uvdAXEpxCwxaNhG8dvgn//OTA0G26yeiB02Nhz3HT3DcPSU3w==
X-Received: by 2002:a05:6602:2cc8:b0:835:46cb:6747 with SMTP id
 ca18e2360f4ac-8445b556e40mr726983539f.4.1733269601002; 
 Tue, 03 Dec 2024 15:46:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 11/41] boot: Split pxe label_run_boot() into two parts
Date: Tue,  3 Dec 2024 16:45:29 -0700
Message-Id: <20241203234559.2938192-12-sjg@chromium.org>
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

This function is quite long. Split out the FDT processing into its own
function.

Add a function comment for the new label_process_fdt() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

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
2.34.1

