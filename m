Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67EE4878EF;
	Mon,  4 Dec 2023 01:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d48nxM5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78B787717; Mon,  4 Dec 2023 01:33:08 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B1B878F0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6cda22140f2so3913446b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649985; x=1702254785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znNrpzTOTJ8pSQEMWFbqPKgFTEou4zWATdY4DuidlwQ=;
 b=d48nxM5X6n+tgrIcO4UUs4nsJLnO9SgBh6JMGaGIjp+v3Cuvbj8vULA2k9yO5XwKf3
 iNou1FR1sX6zvLuDAeW37DEDYXWik/L2kxUl0Da/wXvwLVdD9P8HR4pNJtbMGn7fppes
 ltsYcwQmlfbXp35WSuhVC3EuPy4rUeajM2hXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649985; x=1702254785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znNrpzTOTJ8pSQEMWFbqPKgFTEou4zWATdY4DuidlwQ=;
 b=r4s3uQsrg6PvdfSunBCFRwn7TFOcX/D5UZwVOGDOs8qTtGjlE9qXzj8b80zVJ70CYa
 hHF61NZ0hzvcJbpXbqm7+UOV6a3UK2z7jW+VRqnNVqG3YncyDraaMtgSEw/5UaC6ev1y
 InD5D+1hL307mHGi68wYCZJ2qaLI5oQGA47CszR7n7mkZSy6mBF+yoEyn4QXY8PORh67
 NDIa5ZveJ9WAmw53eIuVrY28sv6S7kZa3ml+7E664lbOEEaGDFWQ6GeXcigHTdMdG2m5
 2c/sJPgEjCvtIqKDRxvQ9ACYlrSfwbhxClf3NsUdCHaBt8o4CwIfCMaizjj1KQ1qs3Cv
 mYDg==
X-Gm-Message-State: AOJu0YyQyH+yh1ZNlnQFXNInQ5CpqTTDIwErwRY55PqIWgsR1x+79dwP
 aVTZDbTH03zvvxXHXdBWFMn1ZBbNh+hMjIxy8pqxOw==
X-Google-Smtp-Source: AGHT+IHFkzy8NrF5BaIpHuFRlbGJlfLoIE94PvIzW6p6TChc28AYSWfHDZqL9MTI6IkyGZ7T14HzSA==
X-Received: by 2002:a05:6a00:4214:b0:6cd:f18e:176 with SMTP id
 cd20-20020a056a00421400b006cdf18e0176mr3400842pfb.27.1701649984770; 
 Sun, 03 Dec 2023 16:33:04 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH 10/14] pxe: Refactor to avoid over-using bootm_argv
Date: Sun,  3 Dec 2023 17:31:34 -0700
Message-ID: <20231204003144.899097-9-sjg@chromium.org>
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

The bootm_argv[3] expression is used in many places. It is the FDT
address, so use that name throughout.

Assign it to bootm_argv[3] only at the end, when all the conditions are
resolved.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 6fbccadd99e6..a6aee68bb797 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -506,18 +506,19 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 {
 	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
+	const char *fdt_addr;
 	ulong kernel_addr_r;
 	int bootm_argc = 2;
 	int zboot_argc = 3;
 	void *buf;
 
-	bootm_argv[3] = env_get("fdt_addr_r");
+	fdt_addr = env_get("fdt_addr_r");
 
 	/* For FIT, the label can be identical to kernel one */
 	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
-		bootm_argv[3] = kernel_addr;
+		fdt_addr = kernel_addr;
 	/* if fdt label is defined then get fdt from server */
-	} else if (bootm_argv[3]) {
+	} else if (fdt_addr) {
 		char *fdtfile = NULL;
 		char *fdtfilefree = NULL;
 
@@ -582,7 +583,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 
 			free(fdtfilefree);
 			if (err < 0) {
-				bootm_argv[3] = NULL;
+				fdt_addr = NULL;
 
 				if (label->fdt) {
 					printf("Skipping %s for failure retrieving FDT\n",
@@ -599,7 +600,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 				label_boot_fdtoverlay(ctx, label);
 #endif
 		} else {
-			bootm_argv[3] = NULL;
+			fdt_addr = NULL;
 		}
 	}
 
@@ -615,20 +616,21 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		zboot_argc = 5;
 	}
 
-	if (!bootm_argv[3])
-		bootm_argv[3] = env_get("fdt_addr");
+	if (!fdt_addr)
+		fdt_addr = env_get("fdt_addr");
 
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
-		bootm_argv[3] = env_get("fdtcontroladdr");
+	if (!fdt_addr && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
+		fdt_addr = env_get("fdtcontroladdr");
 
-	if (bootm_argv[3]) {
+	if (fdt_addr) {
 		if (!bootm_argv[2])
 			bootm_argv[2] = "-";
 		bootm_argc = 4;
 	}
+	bootm_argv[3] = (char *)fdt_addr;
 
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
-- 
2.43.0.rc2.451.g8631bc7472-goog

