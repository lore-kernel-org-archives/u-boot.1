Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A905CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DAE8788C;
	Mon,  4 Dec 2023 01:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LpN5L2fY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5DA8787F; Mon,  4 Dec 2023 01:28:13 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163158788A
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35d67870032so9774005ab.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649689; x=1702254489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gLWADOrfHXcAzYEtRQwlAeLOyma+RyeNI3tmAGyRmI=;
 b=LpN5L2fY1c5f3d/9pdAFRL+EBLQRyleZFKpQwbb8osNebA3bHFX7SrWdM+KksrW2er
 SuY+GhVTHXPIUMFbh4dHzf4Zjh1mpAP0ScVHL6u5z1oRJyHmcWYKxaIKBc6/pEDZ8a1V
 UJYEfIso2M0rftQNLFsRJTdRa7xFCLmXiuy08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649689; x=1702254489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gLWADOrfHXcAzYEtRQwlAeLOyma+RyeNI3tmAGyRmI=;
 b=pJ3OlwidDoqMG1NYA9JWiTAjDsZWCp/9h5pt+XhgrBKZh1JXhWc4G8y6qDjZXyG3qQ
 GL5O5LGuJ7AAlJgTxTp/WI4i0gINC1dNRA6ubnpif4q0N8BBRaLx3NRuEy1S1+wNknux
 fMUAL75nThZjwid1pLErAoetiz6r7E0ic40H+J1z43b1w+PTa0qb431VuzmGFNWPojUX
 sQqllSOlB19ECW1cosD0g6FaxRaXcwtTrwzvo03jksIB7IeXeSET6R9pc6AFiqNaLGmo
 /Te4NpUimYvIBD5NTNQvDLEbOHPOxnzk/+hXQkOOdGz55dynkpyFAqAMhDto/NBX2UWj
 myhw==
X-Gm-Message-State: AOJu0Yy17ioRHiRTF6yjGWz7YijiW+rXCyfOUzQTIniUaghUmviQA7FI
 apvTOk6shH7se/qnjbm7VUCZ+EIzzhHog7L7TaWgcg==
X-Google-Smtp-Source: AGHT+IGCWdKj5fFSAM964PgqQjU395ovvczHlYeuuT2k4NrA5Mps/FmxeCJQl+wPhBlGgdu7O0X4Qw==
X-Received: by 2002:a92:c103:0:b0:35d:59a2:2da with SMTP id
 p3-20020a92c103000000b0035d59a202damr4154533ile.122.1701649689660; 
 Sun, 03 Dec 2023 16:28:09 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:28:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 17/18] stm32: Use bootm_run() and bootz_run()
Date: Sun,  3 Dec 2023 17:26:33 -0700
Message-ID: <20231204002642.895926-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

Use the new bootm/z_run() functions to avoid having to create an
argument list for the stm32prog code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../cmd_stm32prog/cmd_stm32prog.c             | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 8670535844d3..5e1dc7a03810 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <command.h>
 #include <dfu.h>
 #include <image.h>
@@ -125,12 +126,10 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		char dtb_addr[20];
 		char initrd_addr[40];
 		char *fdt_arg, *initrd_arg;
-		char *bootm_argv[5] = {
-			"bootm", boot_addr_start,
-		};
 		const void *uimage = (void *)data->uimage;
 		const void *dtb = (void *)data->dtb;
 		const void *initrd = (void *)data->initrd;
+		struct bootm_info bmi;
 
 		fdt_arg = dtb_addr;
 		if (!dtb)
@@ -141,7 +140,7 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
 			 "0x%p", uimage);
 
-		initrd_arg = "-";
+		initrd_arg = NULL;
 		if (initrd) {
 			snprintf(initrd_addr, sizeof(initrd_addr) - 1,
 				 "0x%p:0x%zx", initrd, data->initrd_size);
@@ -149,15 +148,20 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 
 		printf("Booting kernel at %s %s %s...\n\n\n", boot_addr_start,
-		       initrd_arg, fdt_arg);
-		bootm_argv[2] = initrd_arg;
-		bootm_argv[3] = fdt_arg;
+		       initrd_arg ?: "-", fdt_arg);
+
+		memset(&bmi, '\0', sizeof(bmi));
+		bmi.addr_fit = boot_addr_start;
+		bmi.conf_ramdisk = initrd_arg;
+		bmi.conf_fdt = fdt_arg;
+		bmi.boot_progress = true;
+		bmi.images = &images;
 
 		/* Try bootm for legacy and FIT format image */
 		if (genimg_get_format(uimage) != IMAGE_FORMAT_INVALID)
-			do_bootm(cmdtp, 0, 4, bootm_argv);
+			bootm_run(&bmi);
 		else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
-			do_bootz(cmdtp, 0, 4, bootm_argv);
+			bootz_run(&bmi);
 	}
 	if (data->script)
 		cmd_source_script(data->script, NULL, NULL);
-- 
2.43.0.rc2.451.g8631bc7472-goog

