Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94864E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729D98965E;
	Fri,  6 Dec 2024 03:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jz/HMdVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9B0896CC; Fri,  6 Dec 2024 03:37:07 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A98C8965E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a7a46ca756so5313435ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452623; x=1734057423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9Dvt2bKqftKJfhqMb0dV2ed/94BZjckOFVhk80tm4=;
 b=jz/HMdVA3sM14Nttzy/l5GCVQAsI1+w4Lt0D72yYi2cKG3dVK61T8mxE9wYEVc2ImR
 Xh/dFd8tsp3HXMYc8fyozDeDsaKfyyRCP2bKLTtOghqH4oY8wlFyJc/sspQ5abfDudyW
 mUmWApgAqL2puxy15nI9SjK+msMAKr1GpIxz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452623; x=1734057423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ze9Dvt2bKqftKJfhqMb0dV2ed/94BZjckOFVhk80tm4=;
 b=mBx15zUwtuIiehR0TvxOA0Q1vWVOGfpSKyWagoMTKOXi+/799Y5RvxcGBnOCufOhE8
 rUrniMHoYoZXt22JS1WEAaWpU0Zm4MMIGceo7D08Dvwc6WxSMUMMMytJxTAWHoseNCRv
 0/tsfD+fMozaKS4WP5yUWmvryhQKsYbVuCL0IiFWBBbXYa4/nQXifacjzGE6eZYpRe+m
 FLcwso01LfSAmIEWJJlr7Vl1YZtkbmkvnAZZBAdTA2ayoW4GFa3XdmJgymvoU2Dy/sEK
 avyERgrvTFvSqHyg2v7HtMny3Vou74IgK+ZZeIMTTbjjmvECoKPBTHiw41l2RnnLyc76
 A2cA==
X-Gm-Message-State: AOJu0YzwYmVS++JtAnFJxCUwY+dL82gaeAS9Rox2LWqg08d/krGKiUL3
 qO6pz2EFfk7lAishJ/eXrEZvKhPm3LBZaZE75LTcj00TODycF4HYAhYiCL5mlmSydAY4ksjU/Uc
 =
X-Gm-Gg: ASbGncsaUbu+KpdCR2hSd1ikxf3gCRXV1vOuZvIi2MpPeSsGaHJoAbuiK0DylDCsag6
 GKGNXplbA5rDAwDe8I6InbcQjIPL0jrqXlWnWJRMMOKYX+3xSFiqHd4JEsaScnopvEO8iCwxNq4
 H3baXBGAkI8v9Ht3Dh/WeB6VCzYsXSbEpW5ifcjNiXAnAtSDjlt/j1oo9lH67mlIEN4GLPUc6Qg
 nPuPkLiVyrQi7vaDG/HuyTUj6Oz8Z0uir0jU8o2QWXPsTcvk/bmoeYeJ2o53d6zFBurxHYQ4Xj5
 3ZJVHehbPCQ=
X-Google-Smtp-Source: AGHT+IGHSf0x2NRnxjbV5y0UOJ6LoR42S/Q8J3O+ViVYkg9dFFJHRWFmHysMIRyKcBN0wElAidNJRw==
X-Received: by 2002:a05:6e02:1a66:b0:3a7:7ee3:10a2 with SMTP id
 e9e14a558f8ab-3a811e27d9bmr23533645ab.19.1733452623381; 
 Thu, 05 Dec 2024 18:37:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 12/46] boot: Pass just the FDT argument to
 label_process_fdt()
Date: Thu,  5 Dec 2024 19:35:51 -0700
Message-Id: <20241206023626.2456858-13-sjg@chromium.org>
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

Since this function only adjusts one element of the bootm command, pass
just that. This will make it easier to refactor things to remove the
bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/pxe_utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a14b4eb54c2..2ada5c4aaac 100644
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

