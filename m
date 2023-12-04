Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE2CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E495878E5;
	Mon,  4 Dec 2023 01:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJ3Hr4/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D319F87717; Mon,  4 Dec 2023 01:33:16 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59AD878F1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1f5da5df68eso2225112fac.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649993; x=1702254793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwBXt6k+gK9lQ3tJmwNIeeOXqzWcNPCPZLMTg9KjYkM=;
 b=CJ3Hr4/aMJBYUQHAmbbHCGmdR5p+DstaHK1hNxmj6HuaKwFLxmY8sXsz39tbww+kJG
 YQKyZbQi1a7hfA6amnXx3gN+F9/HAEUoongwsRyVXlnIqDpPx1OSOzqje4ON/SKuTjMh
 GL/5trNWbcX7NuGCgwNx9tYzTXgDt3DDRUpiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649993; x=1702254793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwBXt6k+gK9lQ3tJmwNIeeOXqzWcNPCPZLMTg9KjYkM=;
 b=IFB10NN9jpO735+mG38qMlVojqxWTyJopbNocqwxRODb/H0j3X6oHKKtSfUAQikH5m
 P+Sx8MV46f6YRjoGaHeV4BrM7efuxCIT3czlac/MRIinH7qNlJX9JuFa40c2+qM1Mb6g
 NemF4qLfW2bipJXN0IKbRYqXd/xFz5+lGOmBx8SRCKA736L0IPw9GqAVtVWP9n7moAD9
 vf/YtYlrpG04xwcYV/BQuB2aj5mWFJq882XBlUvRB7ufpUKVLfUeCiG93PNxrkWaETPQ
 RYcSj0xmImh7bbbc4CoTUwufjB8WXAzn51CCQo77sm1l+IT786OSSPB6e0JjXzQC3OUo
 WK1A==
X-Gm-Message-State: AOJu0Yzm+nKvnyyUe/k4hGJKzg2oRQ9dux4EDISKtrjuLSjKmfjmiaQx
 iSwfWK0PDLWZ+rSh736r/3PQF2GA9Hyk6BHlSucxKQ==
X-Google-Smtp-Source: AGHT+IGpE6Aabfskr68LMxS7ZgyILYWiF5wGMTYKItepEZcyvPzRTefbOXiIcdPSAiVShDLH9X24sw==
X-Received: by 2002:a05:6870:6c0d:b0:1fb:75b:1318 with SMTP id
 na13-20020a0568706c0d00b001fb075b1318mr4337334oab.106.1701649993323; 
 Sun, 03 Dec 2023 16:33:13 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH 12/14] pxe: Allow booting without CMDLINE for bootm methods
Date: Sun,  3 Dec 2023 17:31:36 -0700
Message-ID: <20231203173130.12.I71a8d9d2665494a0cf11dd309216c7badce34388@changeid>
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

Use bootm_run() to boot rather than the command line. This allows
extlinux to be used without CMDLINE being enabled.

Collect any error but do not return it, to match the existing code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a34f4410e07e..322ee93a2804 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -566,13 +567,15 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_str,
 			  char *initrd_addr_str, char *initrd_filesize)
 {
-	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
+	struct bootm_info bmi;
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	const char *fdt_addr;
 	ulong kernel_addr_r;
-	int bootm_argc = 2;
 	int zboot_argc = 3;
 	void *buf;
+	int ret;
+
+	memset(&bmi, '\0', sizeof(struct bootm_info));
 
 	fdt_addr = env_get("fdt_addr_r");
 
@@ -620,12 +623,11 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		}
 	}
 
-	bootm_argv[1] = kernel_addr;
+	bmi.addr_fit = kernel_addr;
 	zboot_argv[1] = kernel_addr;
 
 	if (initrd_addr_str) {
-		bootm_argv[2] = initrd_str;
-		bootm_argc = 3;
+		bmi.conf_ramdisk = initrd_str;
 
 		zboot_argv[3] = initrd_addr_str;
 		zboot_argv[4] = initrd_filesize;
@@ -641,23 +643,20 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	if (!fdt_addr && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
 		fdt_addr = env_get("fdtcontroladdr");
 
-	if (fdt_addr) {
-		if (!bootm_argv[2])
-			bootm_argv[2] = "-";
-		bootm_argc = 4;
-	}
-	bootm_argv[3] = (char *)fdt_addr;
+	bmi.conf_fdt = fdt_addr;
+	if (IS_ENABLED(CONFIG_BOOTM))
+		bmi.images = &images;
 
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
-            IS_ENABLED(CONFIG_CMD_BOOTM))
-		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	    IS_ENABLED(CONFIG_BOOTM))
+		ret = bootm_run(&bmi);
 	/* Try booting an AArch64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTI))
-		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret = booti_run(&bmi);
 	/* Try booting a Image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
-		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret = bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
 	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
 		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
-- 
2.43.0.rc2.451.g8631bc7472-goog

