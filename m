Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE05D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E86895AE;
	Tue, 19 Nov 2024 14:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xy0l/Gs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3442E895A1; Tue, 19 Nov 2024 14:19:25 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B3D8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a76df43746so7034625ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022361; x=1732627161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1nWbxQl7tv9AxetraWnBf2JPU3WEhPDMoQ2Apin6Z0=;
 b=Xy0l/Gs2+mbrNGPl9bWeyr6baXKr726G68q96kEC7vXlwew64WxXPzQlUpo9W4rago
 IlIpsRkTiV3ldiwJqJ39VJr6y9vlsgj+AxUwRZS5D9hXnvUPRlc+oOR6WlsddBGSnvkR
 nVGcTGSzZXWF/hrXycbY0m4sUdYNjzqsMoNsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022361; x=1732627161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1nWbxQl7tv9AxetraWnBf2JPU3WEhPDMoQ2Apin6Z0=;
 b=K0kTfyftPsW/PDlegCzmc3/Sw42A+kqc4O4tJX4BhIhvz7Bjbh90esz1/dbohOlnTZ
 Q0N8WkeJDup3ZTKNA76GtIF+iKYg2j0N0mVlXD2eO8P2NTTve9Ce3lpjwuU3BEMGcw4k
 tzcHY1SecI1TUh4Ba/EDI9DEI4SL0Ip8SB+NjV4m8vDl3cZwGh7eLYOeDXLW93x37rke
 gvN0YI2IT4fH7lXwvtXxufVNlCaudvkBiSLZyUdPNFxxf9cwjqxPEoqqUuAW5WHbknYC
 5GAYpwzf6XFYhMtHLLIu4yJKzHOcaWor2aKRFMhWg3AgA5H7pIjt6klTpNRyZoyX9qjo
 7hfg==
X-Gm-Message-State: AOJu0YzDxqeKKU2AksWm1zHJmtnTKu5iYFHiXur+r0gkHMDu5gjZ7ihu
 fpL9nER2+rItiOV0M5yFjFwQukrgBuR/+eu7JH9EONfHufjSwkoDpq33iN4e/EnJigdys9sjUDk
 =
X-Google-Smtp-Source: AGHT+IFnMcVXOt5+tPNMN7EWNhKsOkslLt+U7/octoQKVtX3RY8Qz8xq8ibli1ib0jaFPwV5kD0qHQ==
X-Received: by 2002:a05:6e02:1b04:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a76d14e061mr74420435ab.1.1732022359584; 
 Tue, 19 Nov 2024 05:19:19 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 11/39] boot: Pass just the FDT argument to label_process_fdt()
Date: Tue, 19 Nov 2024 06:18:16 -0700
Message-Id: <20241119131844.4078144-12-sjg@chromium.org>
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

Since this function only adjusts one element of the bootm command, pass
just that. This will make it easier to refactor things to remove the
bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 97dd5a36150..66f82d3fbc1 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -438,7 +438,7 @@ skip_overlay:
  * @ctx: PXE context
  * @label: Label to process
  * @kernel_addr: String containing kernel address
- * @bootm_argv: bootm arguments to fill in (this only adjusts @bootm_argv[3])
+ * @fdt_argp: bootm argument to fill in, for FDT
  * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if FDT file could not be
  *	loaded
  *
@@ -461,13 +461,13 @@ skip_overlay:
  * Scenario 4: fdt blob is not available.
  */
 static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
-			     char *kernel_addr, char *bootm_argv[])
+			     char *kernel_addr, char **fdt_argp)
 {
 	/* For FIT, the label can be identical to kernel one */
 	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
-		bootm_argv[3] = kernel_addr;
+		*fdt_argp = kernel_addr;
 	/* if fdt label is defined then get fdt from server */
-	} else if (bootm_argv[3]) {
+	} else if (*fdt_argp) {
 		char *fdtfile = NULL;
 		char *fdtfilefree = NULL;
 
@@ -538,7 +538,7 @@ static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
 
 			free(fdtfilefree);
 			if (err < 0) {
-				bootm_argv[3] = NULL;
+				*fdt_argp = NULL;
 
 				if (label->fdt) {
 					printf("Skipping %s for failure retrieving FDT\n",
@@ -560,7 +560,7 @@ static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
 				label_boot_fdtoverlay(ctx, label);
 #endif
 		} else {
-			bootm_argv[3] = NULL;
+			*fdt_argp = NULL;
 		}
 	}
 
@@ -594,7 +594,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 
 	bootm_argv[3] = env_get("fdt_addr_r");
 
-	ret = label_process_fdt(ctx, label, kernel_addr, bootm_argv);
+	ret = label_process_fdt(ctx, label, kernel_addr, &bootm_argv[3]);
 	if (ret)
 		return ret;
 
-- 
2.34.1

