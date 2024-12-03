Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B712E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D83D8969D;
	Wed,  4 Dec 2024 00:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMq+hec4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1247888F55; Wed,  4 Dec 2024 00:46:37 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9549896B9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso13734939f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269593; x=1733874393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+z7xhHs6Fff2kbi3oQStxxohtKhNJ050PabMj88Bb4=;
 b=IMq+hec451NfCda+deNhVI7sN+3+uhIxd+tcVI9lDYl65r93z6Dy/eUCaxEvIzT9a4
 MKwouJ529FsDiDtgfrIita5/yuQgW3xgijq9mSsbhNxhM9EWPXIgQKvgIHYEqhPngKTW
 ULtz6XTzPOC9mwehjE8HnlCaniz8T1e6pJN8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269593; x=1733874393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+z7xhHs6Fff2kbi3oQStxxohtKhNJ050PabMj88Bb4=;
 b=P9NAyWqdtXEuzbGhzlz5TMSoILohewHnk6jYbdtXAeoUNCXPYTWjiOxoNlQDEjCN/Z
 lLXIoOArPsr4Kr8R3rFSFmTSPcHbrlAqrBKZxNLJq++zSdvu8xbAg1D1GsLfRySlxOxH
 vLpGGpaf6b4hwxkhEwUAYkhCqxZqGAoFBEA2lFZAWbwSUhmvD0rmrCmgN2cz3I87VV7o
 22IHUkbFEA7qOA0fR7xboNAQKZiWyt+me+N1eHi0rN1R1OhWfkDjP1yWK+dUnnuGcC0A
 qngJy/nR5XVNgtNROwZVps9NVm9FV1rKKPUWDwNTq5U2Rp1ZNok7bG2jHVILjKyjOZ2N
 cd5A==
X-Gm-Message-State: AOJu0YxRDAflkUwz9CwskkgtSLhRqJ05fa9lVqe5UWFZuSO0C+la/QvK
 xY2WpSTcQJg4SfuDRO8M0wh+ygdYHbFiHsfBm1XhAPaKD9Do4/k+LodcrV1v7H5dTptAZICI3qc
 =
X-Gm-Gg: ASbGncsf/XmKCaxAJFdI5qLMJoUhujy1+XhSptkLukBsdqlxFYJ26JeQRetxMh8IfZC
 V5+ojDpj66WcOZxikARrT73mV1KrK3gMc3rlccxUllStKu31G1bHm+LyEo/H+uqU6P/Oyk7IRti
 nxCpGIGQbbTXJoUzTCKF3BlKpDf06XCDj+IZBMj6ypmXXEPm7hzL5lQKYgysTImDYo4Jq0drFF3
 KB2kXOxwPBtwMFSRCb7V4te/eckAyCFld/MWQAKafdohBkGd/b8HtoKAsGNyxPEXWD4k877GQCZ
 teK95H/3HvM=
X-Google-Smtp-Source: AGHT+IHzQTjfUTsT4l5+01j0Btnjn0KW7FZvg3Dv2CPKHlpP3sPYTFK7SEvLnV8+pjzJVXzvew3JvQ==
X-Received: by 2002:a5e:8709:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-844015af3d5mr2132724639f.5.1733269592938; 
 Tue, 03 Dec 2024 15:46:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 08/41] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
Date: Tue,  3 Dec 2024 16:45:26 -0700
Message-Id: <20241203234559.2938192-9-sjg@chromium.org>
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

This value is include the bootm_info, so drop the unnecessary parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 5 +++--
 cmd/bootflow.c        | 3 ++-
 cmd/x86/zboot.c       | 8 +++-----
 include/bootm.h       | 7 ++-----
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index d74c404464c..4dfcde68060 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -555,12 +555,13 @@ static void show_loader(struct setup_header *hdr)
 	printf("\n");
 }
 
-void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
-		 bool show_cmdline)
+void zimage_dump(struct bootm_info *bmi, bool show_cmdline)
 {
+	struct boot_params *base_ptr;
 	struct setup_header *hdr;
 	int i;
 
+	base_ptr = bmi->base_ptr;
 	printf("Setup located at %p:\n\n", base_ptr);
 	print_num64("ACPI RSDP addr", base_ptr->acpi_rsdp_addr);
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index b3b78bebaed..a89c3bfd9c5 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -386,7 +386,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		bootm_init(&bmi);
 		/* we don't know this at present */
 		bootm_x86_set(&bmi, bzimage_addr, 0);
-		zimage_dump(&bmi, bflow->x86_setup, false);
+		bootm_x86_set(&bmi, base_ptr, bflow->x86_setup);
+		zimage_dump(&bmi, false);
 
 		return 0;
 	}
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 029ff4eb9fd..ee099ca041b 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -103,15 +103,13 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	struct boot_params *base_ptr = bmi.base_ptr;
-
 	if (argc > 1)
-		base_ptr = (void *)hextoul(argv[1], NULL);
-	if (!base_ptr) {
+		bmi.base_ptr = (void *)hextoul(argv[1], NULL);
+	if (!bmi.base_ptr) {
 		printf("No zboot setup_base\n");
 		return CMD_RET_FAILURE;
 	}
-	zimage_dump(&bmi, base_ptr, true);
+	zimage_dump(&bmi, true);
 
 	return 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index fe7f80b88a5..c471615b08c 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -342,13 +342,10 @@ const char *zimage_get_kernel_version(struct boot_params *params,
  *
  * This shows all available information in a zimage that has been loaded.
  *
- * @bmi: Bootm information
- * @base_ptr: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
+ * @bmi: Bootm information, with valid base_ptr
  * @show_cmdline: true to show the full command line
  */
-void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
-		 bool show_cmdline);
+void zimage_dump(struct bootm_info *bmi, bool show_cmdline);
 
 /*
  * bootm_boot_start() - Boot an image at the given address
-- 
2.34.1

