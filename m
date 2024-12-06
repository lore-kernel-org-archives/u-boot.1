Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2457CE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2411989619;
	Fri,  6 Dec 2024 03:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHgqYQQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA0789690; Fri,  6 Dec 2024 03:37:05 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8327689633
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-843df3c4390so50367039f.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452620; x=1734057420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSy+fxsRG0mtEIT0uW+SL5I6nQiQ4mlB3+Rx4El2O3M=;
 b=CHgqYQQNTwDNLUYWKe9ClpkVI8xmJVrymtj4PvtzYihsSC8zLUcQ123Z04e42BfSy9
 hxNvkgTr2ccjHWkoYSSxHe+43NrgyrW6Sk8Dv/hkoBhxzWM1vAGUN76yvVmpSAr1RhhK
 /UbevbznLFLZZ2w8zpYQUK8M+LYuRhXBf3QXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452620; x=1734057420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSy+fxsRG0mtEIT0uW+SL5I6nQiQ4mlB3+Rx4El2O3M=;
 b=uXEzfWFRvhkTj8VlxgnVVBR1jkvj1oGDuzWKttNqsORETPw6cLc8cNoPd2svlbiGAX
 DO30YmZf2CaV3RakkYyI1lw5BKaDk0mJ86Ilso/A1OqqGTluVlhS3PbegFS6bWiapFLM
 Xmknx5BEPdMIpWoZzuIclrxV4X/85kC9+jh2NlHj5Bt0Z0LXdqlGO0gS7iOszNSaGWh/
 fGA5oKnrqwq16oAeTinxLybW/EoaWjZNoeebsaNoigrTzWyRA1Xlz07VOU9kzkol8H7x
 KuhCdQtMSugP930EorbL1GjdUws4404jndJoz1mSl08a4HVnnlBDRnHRCXs8xQEii8Ot
 wQ6A==
X-Gm-Message-State: AOJu0YyOV1Tp0FuGdkpcRk5yX30Jl0x1UcHHQ7bTwi12MNxB87uKuFxo
 W3fcRMC2V4M2p/zevFjS8DAKqAxnJheX15gC9iwAtVl3uDD7f3bzLXShzGojJdUrytjgS8cf1Ww
 =
X-Gm-Gg: ASbGnctUAUs+9yFpqnNXKzQKPOo43kb2tnnqO2inFN5N5deEncicqbHXz4Bj4K5R1SB
 Ad/QyjVL6sWOU7NvZhx//wyyyi6+E0j5X8gbGk/mv0IigOZZcf7VHKskqc9u6cWUwJAEsk/2bnc
 Ie4BfmB+cbM7A4Q/eBlvf0I1646a5+ufI4HQhmJ1IhEY/+U9x100l8FL+wiV4+3q+IMh21KyvVA
 mNpHDHzhojepjKWSfUAPBZOGIpVDftSEumxb79GvRDANLkxytEQc7q26x2+sAcCuSDeByfFicWk
 OxxP04ijveE=
X-Google-Smtp-Source: AGHT+IGNLTaTHyGda/iP/7V1Z2vJEcfBk9jGy7s3JlqMyj8u3GINBrWQOysBiVidzcXwhpvFrh5eww==
X-Received: by 2002:a05:6602:1610:b0:83a:d039:a721 with SMTP id
 ca18e2360f4ac-8447e24216emr188461839f.8.1733452620355; 
 Thu, 05 Dec 2024 18:37:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 11/46] boot: Split pxe label_run_boot() into two parts
Date: Thu,  5 Dec 2024 19:35:50 -0700
Message-Id: <20241206023626.2456858-12-sjg@chromium.org>
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
2.34.1

