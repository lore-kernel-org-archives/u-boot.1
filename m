Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D4D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2867B895B1;
	Tue, 19 Nov 2024 14:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QlgXaqpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF352895CC; Tue, 19 Nov 2024 14:19:20 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E41F8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a74d9aeb38so3066405ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022357; x=1732627157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH6tibvMa69tCSoUiRRmaURdHXTqyWTs/QfYZ274hXY=;
 b=QlgXaqpzuJSHkI/X+AW59L9/0BXEMwLsVfiXxcZfzriWJJJNECNashrfqfzkjouqcq
 LnxtjUbKDjKX/K455PkuS6/OOlMGdr9eGzeB+zJjrcI5noknIVGinxoiAIaNsXuNCT9g
 g4HYJP3dG57p00ODXWaiPK5/BXMRr3+evwC1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022357; x=1732627157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yH6tibvMa69tCSoUiRRmaURdHXTqyWTs/QfYZ274hXY=;
 b=hfmOHZFyVsZyG6U7Q2daybkvYdeWRxf4xDexaQJVj7kapBtyOUd342pgIrUZGVnieY
 ebLraPQVr127/Zn6oNTQj1CsaJqjT1Ynhsn+aqay1YzO6wjlOf4zpv5UhIYEih+PDEPR
 RF3lWy97Obc9qQpF09SBRYlCBGGwvhoLnAU2jePun0jAdt+A23rlqioGveEDg2PbkOCR
 Ljnp/0pk39uiHhoarAXfes11xPtVwXkvWohgw3JsGc5lqh9V9xwvzoTqxY6Lpy8lbKQK
 p+pGoEbIzbomoA/BQJo/izYR6kD7Oz48GofMAG6ptVF2o+Mrkh2hgnY06/FjETW7Z5J1
 ANqg==
X-Gm-Message-State: AOJu0YyELuN+Gc7InAbGn+/k19pQMibdAM5qoBRe+MzUDFEa64yXlI8+
 Owp7KHlRtGmd0r5Zj0zPt/I+M91dbK7GPmAxb+qb2FJu7FCRgS9hXzM4sFrblTGbs6JnoLwMAXM
 =
X-Google-Smtp-Source: AGHT+IEb7W9LDwMXEpemf+dM3ton5pWg9iuTXyjfeVFeTGAq2SSYgHt8BBHa2+2bGjcUplGTGShQwg==
X-Received: by 2002:a05:6e02:4401:20b0:3a7:4826:b04e with SMTP id
 e9e14a558f8ab-3a74826b96fmr83009705ab.22.1732022356742; 
 Tue, 19 Nov 2024 05:19:16 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 10/39] boot: Split pxe label_run_boot() into two parts
Date: Tue, 19 Nov 2024 06:18:15 -0700
Message-Id: <20241119131844.4078144-11-sjg@chromium.org>
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

This function is quite long. Split out the FDT processing into its own
function.

Add a function comment for the new label_process_fdt() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 100 ++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index edccb29e770..97dd5a36150 100644
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
- * @initrd_addr_str: String containing initaddr address (NULL if none)
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
+ * @initrd_addr_str: String containing initaddr address (NULL if none)
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

