Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E40CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F3484879;
	Tue, 26 May 2026 15:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MskTnIM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2A0848B3; Tue, 26 May 2026 15:10:22 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF0984873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6967fd0416bso5244181eaf.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801019; x=1780405819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVhVNl1DfsdU9wHBFNpp9m0407Om/N/24cTf9muW9Jg=;
 b=MskTnIM9Nv0lWt8EPvGNHo6JYO7MOqtMjIgMWL3NFa/IND8nEKYBF4E20Fkojiuxmd
 0oEo55hc/1XeJy0tMh2OlQXo0J7ywslsZUVIgmAr8H/FEQjVA/Sw2anaJlXdXwEiWLSX
 PB9PWdwqpTVsinnCXsREc+64kSOeDm4ncy2nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801019; x=1780405819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tVhVNl1DfsdU9wHBFNpp9m0407Om/N/24cTf9muW9Jg=;
 b=fPrXb/Au+kAuYamGKCnUQ9AwWkOesatdSNV7eHHzo8jig16Ejqj4Ru6ZZsPf8gFC8x
 rEfXxGKdzZ6avQ2TLf/q6xqpyNcJNSy3kI44rJHj9zQ/T6DPzlVnoLf9BA5NVxg2vJ3v
 KBPrwkzZvlkZ0Xf6f/4cI3iw1PsVLpw27ZnjJcEFFW84JJe6kBB6fobVIxInKaRt9YQe
 l6T5nesbT/Oe0dK3N3qd3IfblU6jjaKrZa/yyZC9N8uX+0s7LoVX300x6sJSdc6zNLV4
 n+Y0Ff/11YWscmOgWWjW9EgbqdKjIhG1ZXqee8f67DsathFt2oolZVrLxvVMykDUMj2f
 IrKA==
X-Gm-Message-State: AOJu0Yy/sn4XihBTSggyO8KSx7+t/3FRxJEvUTXYoVovnXZZ112RHgKu
 WrVa5QhA4YAARJlAM8oGUG/3qggOvsFEpO7MDiUyPCoH7MZ5Cy7h4ovGuAMwNJ/9zvasB1xw3zF
 SGawhbLgy5N0=
X-Gm-Gg: Acq92OH8gQo/LwGd62u+EbS5RDaG2oqs+JtT0GYkGt59XXXp5aEc+qEGtjLJf9Ff+FE
 HpNTYPRYHbMFaxPKQ8kgAczTaH/nrbRAvNXpu+wRHwif2LUvqY37TLcBwiEFUs8VmRS0E4J/jwG
 VUvFtMwyCN6vP/rlKAL044Y29xxhzbrucMat6WtRRWQBsjGeMd6brfYRvuDSWY9+LqeN/hbjaQo
 2XL9X28qUN/uMfJNQLzYvPvuZCzDOV3V+jvLXplM2eqtY1Zo4uV5OLQH0QAIUGetlj4ZPNHtdDK
 Gb4xd0dTCUI0D+stOjayAoRRFuVztcOWrKJZWBpvra10X/mluLThBi9nb2+ISt/obY7VlQJ4VmA
 OlBeH5YqT3FMGk6BNCtEhXquFVfqRwl7uBN5Y0j6HuUPuDKi6veauo06OsFGuzIGJMlz/eH+ELl
 sVwE4w3UbhrWX+5v0Xwgl8RXn3LZ8s
X-Received: by 2002:a4a:ec4c:0:b0:69d:6bbf:3fd0 with SMTP id
 006d021491bc7-69d7ec7f7d3mr9242168eaf.49.1779801018817; 
 Tue, 26 May 2026 06:10:18 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 8/9] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
Date: Tue, 26 May 2026 07:09:14 -0600
Message-ID: <20260526130931.2103552-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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
index 3e1d6f44239..e66744fde86 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -545,11 +545,12 @@ static void show_loader(struct setup_header *hdr)
 	printf("\n");
 }
 
-void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
-		 bool show_cmdline)
+void zimage_dump(struct bootm_info *bmi, bool show_cmdline)
 {
+	struct boot_params *base_ptr;
 	struct setup_header *hdr;
 
+	base_ptr = bmi->base_ptr;
 	printf("Setup located at %p:\n\n", base_ptr);
 	print_num64("ACPI RSDP addr", base_ptr->acpi_rsdp_addr);
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index b76daf9cc0d..f920966a67c 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -403,7 +403,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		bootm_init(&bmi);
 		/* we don't know this at present */
 		bootm_x86_set(&bmi, bzimage_addr, 0);
-		zimage_dump(&bmi, bflow->x86_setup, false);
+		bootm_x86_set(&bmi, base_ptr, bflow->x86_setup);
+		zimage_dump(&bmi, false);
 
 		return 0;
 	}
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 7ae4a80c223..aa2892f5206 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -104,15 +104,13 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
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
index 8df591f70e0..dc5416f305c 100644
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
2.43.0

