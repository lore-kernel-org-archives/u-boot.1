Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AAAC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B87387BA2;
	Fri, 15 Dec 2023 05:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j0f4SblR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8AB87B96; Fri, 15 Dec 2023 05:19:42 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27AED87B72
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b9e2a5e8faso100639b6e.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613977; x=1703218777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+ouZGr5RMmoq111AYG72szViTuUsFNEETNT60bMDGQ=;
 b=j0f4SblRb+EJT+Q03WWsAZwJZPLM72BzNJMtqWaeHcd7yHQxZCNbGrbd7UAee+yVO4
 +JQctHx7Hy69sxrfam5H4uIimPRnyT+EXZeYXJN2Ut+4W3DEddSn6ULsQbZQVWdAPG8u
 C/m3Yhy7ia42MAzeyjSvRp0/de7RA6eGOE4sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613977; x=1703218777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+ouZGr5RMmoq111AYG72szViTuUsFNEETNT60bMDGQ=;
 b=owYF/lG+hMJJ4YGCL01xdWa0ItXK6hZadMZEvDj7IReUpSVG09WSM4JCUFugEjaTsw
 qza1wqQFvV2fkIyvejMYW0HVjIDhtgPdKjx4a6W8OlzOl5quhFJMAZMnxJzLSRWfkKk4
 C1/3uYglpBP/ghTLwgtojXlplRAaJeeljtiRiWE+KA1wuU3I3bMsnkrEBBrcdVXi4bRX
 WE4MfGFL957pO15Op8jpZEFX+yuy7fAw8DDcYBHVybAzKW61FIYHYr3YdiNWzTCzZUnK
 3YxeYR2hIlSZLRDpK5bFDG+U5NJVfqhqUTIf/C4Et6LE5HCfPz3oXQ6n8BOFoLLDxDPr
 xeXA==
X-Gm-Message-State: AOJu0YxyLBXSBWTAsl7dpaFGDxctGHaboy99YhcJDzicCbkok+d4BnPC
 CYiMbzzm53N1PVb6lerG4NPGPM+CdrRiDt9Ux2K0/Q==
X-Google-Smtp-Source: AGHT+IECSjq18Hpvv3Yapet6TSQHmnTqYJZ+Ds7da/NmNnFiiowHLu/QG+thkGCUHDWxc0KiU3vJGg==
X-Received: by 2002:a05:6808:14d5:b0:3b8:b063:2c07 with SMTP id
 f21-20020a05680814d500b003b8b0632c07mr4957554oiw.45.1702613977648; 
 Thu, 14 Dec 2023 20:19:37 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: [PATCH v2 12/16] pxe: Refactor to avoid over-using bootm_argv
Date: Thu, 14 Dec 2023 21:19:10 -0700
Message-ID: <20231215041919.2197788-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0.472.g3155946c3a-goog

