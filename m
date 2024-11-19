Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D6D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688D4895B0;
	Tue, 19 Nov 2024 14:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eze/WAnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC564895B0; Tue, 19 Nov 2024 14:19:15 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E7E895A1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a758251b7bso10022635ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022352; x=1732627152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkF50Vp4N/q7Qfwn2xDUBTV9Bcu2qi6QbtKIUuA1YsM=;
 b=eze/WAnPk31fpzhlXT5U6bn2/AR0h31q67WxjWcLH3jjKnKDgOhe1OmsAQVga6eyOB
 e1kspOm/KCe4LXdEgnj5/hdVQ3jmBgEZRYNlO+D5tHA6jvtYaab1fwF7wFCee6rW2qt1
 2PMcBSnWcN4WQtTFubtaMlTB/PigoopMdbLh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022352; x=1732627152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkF50Vp4N/q7Qfwn2xDUBTV9Bcu2qi6QbtKIUuA1YsM=;
 b=USMIbJDv0KiaoEedphwxdVtvFVINbiCiDVa2CqMPDSri4Qd5nL9+OrQoQjXUECY84Y
 n1e5UuPFPk0I9JF8mp9bjlR8nQoOzDLVMvUFJ0f6X97GK6fQaVefGYNxSU3jlGZt2Js+
 CBOCDmBdAiRtudLglPmxYs3iayym28/H23l8xOoAh0Q5WYfa/9cqGZHE43sUkaEexpIG
 4LoDV1OqSim9VsywafM33UMLXI6R2aqB+KVQ0vX69FZjaR2YjI3nHxJkeUacRcC6+OyN
 s1Ad9Q3mFSFgBWjS9r/VvlXJuYg5QveifU9juaTcOfy+oWgplaQB1L4ROMLladOTh2tB
 jQqQ==
X-Gm-Message-State: AOJu0YzYWfIUJRnt1yii4gJCcImX//eXda9gySp7T3o3787P4q1ISan9
 +4vDABJURA1WzGhzxupPYiZbR89x27pwK0LTb0H/5NW2ooJ/svcQoBtQ0/JGH7gjFdY2QObHEOQ
 =
X-Google-Smtp-Source: AGHT+IEHbC5ol+OBvEM2VcxxjAKa3CPDyiV3vyzU5l/XujPvPvEVukyXS1cvk5LVvlongaT7fqodQA==
X-Received: by 2002:a05:6e02:1c86:b0:3a7:1bfc:97c6 with SMTP id
 e9e14a558f8ab-3a74807fd99mr155198315ab.16.1732022351922; 
 Tue, 19 Nov 2024 05:19:11 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 08/39] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
Date: Tue, 19 Nov 2024 06:18:13 -0700
Message-Id: <20241119131844.4078144-9-sjg@chromium.org>
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

This value is include the bootm_info, so drop the unnecessary parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

